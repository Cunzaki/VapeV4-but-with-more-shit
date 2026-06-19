--[[
	Universal Full Game Dumper (standalone)

	Dumps decompiled scripts, bytecode fallbacks, remotes, tags, animations,
	instance trees, and optional game-specific extras into one folder.

	Works on any Roblox place — not tied to REDLINER. Obfuscation is detected
	per script; deobfuscation runs only when markers are found.

	Usage (executor):
		loadstring(readfile('tools/redliner_full_dumper.lua'), 'game_dumper')()

	Or paste this entire file into your executor and run.

	Output (executor workspace):
		game_dumps/Ugc_<PlaceId>_<timestamp>/
			scripts/         — raw decompiler output (always)
			scripts_deobf/   — deobfuscated copy (only when obfuscation detected)
			bytecode/        — hex bytecode when decompile fails
			manifest/        — remotes, tags, animations, trees, index
		decompiled games/Ugc_<PlaceId>_<timestamp>/  — mirror of scripts/ (SYNC_TO_DECOMPILED)

	Join the target game before dumping. Copy the mirror folder into this repo's decompiled games/.

	Requires: writefile, makefolder, isfolder
	Optional: decompile, getscriptbytecode, getnilinstances, getscripts,
	          getrunningscripts, getloadedmodules, gethui, gethiddenproperty,
	          HttpService:JSONEncode
]]

local CONFIG = {
	OUTPUT_ROOT = 'game_dumps',
	SYNC_TO_DECOMPILED = true, -- mirror scripts/ into decompiled games/Ugc_<placeId>_<timestamp>/
	INCLUDE_CORE_PACKAGES = false,
	INCLUDE_CORE_GUI = false,
	INCLUDE_PLAYER_MODULE = false, -- Roblox default PlayerModule (large duplicate noise)
	INCLUDE_CHARACTER_SCRIPTS = false,
	INCLUDE_BACKPACK = false,
	DECOMPILE_CONCURRENCY = 2, -- keep low; 40 parallel decompiles often OOM/crash executors
	WRITE_EVERY_N = 1, -- write each script immediately after decompile
	PROGRESS_EVERY_N = 5,
	AUTO_DETECT_OBFUSCATION = true,
	DEOBFUSCATE_WHEN_DETECTED = true, -- only deobfuscate scripts that look obfuscated
	DEOBFUSCATE_WRITE_COPY = true, -- write scripts_deobf/ for obfuscated scripts
	OBFUSCATION_SCORE_THRESHOLD = 5, -- min score from detectObfuscation() to treat as obfuscated
	DUMP_ALL_SCRIPTS = false, -- true = skip Roblox noise filter (very large dump)
	REQUIRE_PROBE = true, -- shallow require ModuleScripts under game roots (pcall)
	REQUIRE_PROBE_MAX = 250,
	GAME_EXTRAS = 'auto', -- false | true | 'auto' — packets/item defs when REDLINER-like layout found
	TREE_MAX_DEPTH = 12,
	WAIT_FOR_GAME_LOAD = true,
	GAME_LOAD_TIMEOUT = 90,
	PRIORITY_PATH_HINTS = {
		'ReplicatedStorage',
		'ServerStorage',
		'ServerScriptService',
		'StarterPlayer',
		'StarterGui',
		'Workspace',
	},
	GC_KEYWORDS = {
		'remote', 'packet', 'replicate', 'hitbox', 'parry', 'damage', 'weapon',
		'anticheat', 'kick', 'ban', 'exploit', 'fireserver', 'invoke',
	},
	LOG_PREFIX = '[Game Dumper]',
}

local SCRIPT_CLASSES = {
	LocalScript = true,
	ModuleScript = true,
	Script = true,
}

local INVALID_PATH_CHARS = {'\\', '/', ':', '*', '?', '"', '<', '>', '|'}
local WINDOWS_RESERVED = {
	CON = true, PRN = true, AUX = true, NUL = true,
	COM1 = true, COM2 = true, COM3 = true, COM4 = true, COM5 = true,
	COM6 = true, COM7 = true, COM8 = true, COM9 = true,
	LPT1 = true, LPT2 = true, LPT3 = true, LPT4 = true, LPT5 = true,
	LPT6 = true, LPT7 = true, LPT8 = true, LPT9 = true,
}

local httpService = game:GetService('HttpService')
local collectionService = game:GetService('CollectionService')
local playersService = game:GetService('Players')

local dumpRoot = ''
local manifest = {
	placeId = game.PlaceId,
	placeName = game.Name,
	jobId = game.JobId,
	startedAt = os.date('!%Y-%m-%dT%H:%M:%SZ'),
	scripts = {},
	errors = {},
	stats = {},
}

local function log(...)
	print(CONFIG.LOG_PREFIX, ...)
end

local function warnLog(...)
	warn(CONFIG.LOG_PREFIX, ...)
end

local function hasFileApi()
	return type(writefile) == 'function'
		and type(makefolder) == 'function'
		and type(isfolder) == 'function'
end

local function sanitizeName(name)
	if type(name) ~= 'string' or name == '' then
		return 'Unnamed'
	end
	for _, c in INVALID_PATH_CHARS do
		name = name:gsub(c, '_')
	end
	name = name:gsub('[%z]', '_')
	name = name:gsub('[%s%.]+$', '')
	if name == '' then
		return 'Unnamed'
	end
	if WINDOWS_RESERVED[name:upper()] then
		name = name .. '_'
	end
	return name:sub(1, 200)
end

local function ensureFolder(folderPath)
	local built = ''
	for part in folderPath:gsub('\\', '/'):gmatch('[^/]+') do
		built = built == '' and part or (built .. '/' .. part)
		if not isfolder(built) then
			pcall(makefolder, built)
		end
	end
end

local function writeText(relPath, text)
	local full = dumpRoot .. '/' .. relPath:gsub('\\', '/')
	local dir = full:match('^(.*)/[^/]+$')
	if dir then
		ensureFolder(dir)
	end
	local ok, err = pcall(writefile, full, text)
	if not ok then
		table.insert(manifest.errors, 'write failed: ' .. relPath .. ' -> ' .. tostring(err))
		return false
	end
	return true
end

local function jsonEncode(value)
	local ok, res = pcall(httpService.JSONEncode, httpService, value)
	if ok then
		return res
	end
	return nil
end

local function valuePreview(value, depth)
	depth = depth or 0
	if depth > 2 then
		return '...'
	end
	local t = typeof(value)
	if t == 'string' then
		if #value > 120 then
			return '"' .. value:sub(1, 117) .. '..."'
		end
		return '"' .. value:gsub('"', '\\"') .. '"'
	end
	if t == 'number' or t == 'boolean' then
		return tostring(value)
	end
	if t == 'Instance' then
		return value:GetFullName()
	end
	if t == 'Vector3' then
		return string.format('Vector3(%.3f, %.3f, %.3f)', value.X, value.Y, value.Z)
	end
	if t == 'CFrame' then
		return 'CFrame(...)'
	end
	if t == 'table' then
		local keys = {}
		for k in value do
			table.insert(keys, tostring(k))
		end
		table.sort(keys)
		if #keys == 0 then
			return '{}'
		end
		local parts = {}
		for i = 1, math.min(#keys, 12) do
			local k = keys[i]
			parts[#parts + 1] = tostring(k) .. '=' .. valuePreview(value[k], depth + 1)
		end
		if #keys > 12 then
			parts[#parts + 1] = '...+' .. (#keys - 12)
		end
		return '{' .. table.concat(parts, ', ') .. '}'
	end
	return t
end

local mirrorRoot = ''

local function buildDumpRoot()
	local stamp = os.date('%Y%m%d_%H%M%S')
	local placeName = sanitizeName(game.Name)
	local root = string.format('%s/Ugc_%s_%s', CONFIG.OUTPUT_ROOT, tostring(game.PlaceId), stamp)
	if CONFIG.SYNC_TO_DECOMPILED then
		mirrorRoot = string.format('decompiled games/Ugc_%s_%s', tostring(game.PlaceId), stamp)
	else
		mirrorRoot = ''
	end
	ensureFolder(root)
	if mirrorRoot ~= '' then
		ensureFolder(mirrorRoot)
	end
	return root
end

local function isPriorityScript(script)
	local full = script:GetFullName()
	if full:find('CorePackages', 1, true) or full:find('CoreGui', 1, true) then
		return false
	end
	for _, hint in CONFIG.PRIORITY_PATH_HINTS do
		if full:find(hint, 1, true) then
			return true
		end
	end
	return false
end

local function waitForGameLoad()
	if not CONFIG.WAIT_FOR_GAME_LOAD then
		return true
	end
	local rs = game:GetService('ReplicatedStorage')
	local lplr = playersService.LocalPlayer
	local deadline = tick() + CONFIG.GAME_LOAD_TIMEOUT
	while tick() < deadline do
		local ready = false
		if game:IsLoaded() then
			ready = true
		end
		if #rs:GetChildren() > 0 then
			ready = true
		end
		if lplr and lplr.Character and lplr.Character:FindFirstChild('HumanoidRootPart') then
			ready = true
		end
		if ready then
			log('Game load ready')
			return true
		end
		task.wait(0.5)
	end
	warnLog('Timed out waiting for game load - dumping anyway')
	return false
end

local function hasRedlinerLikeLayout()
	local rs = game:GetService('ReplicatedStorage')
	local assets = rs:FindFirstChild('Assets')
	local modules = assets and assets:FindFirstChild('ModuleScripts')
	return modules and modules:FindFirstChild('Packets') ~= nil
end

local function shouldDumpGameExtras()
	if CONFIG.GAME_EXTRAS == true then
		return true
	end
	if CONFIG.GAME_EXTRAS == false then
		return false
	end
	return hasRedlinerLikeLayout()
end

local function isRobloxNoise(script)
	if CONFIG.DUMP_ALL_SCRIPTS then
		return false
	end
	local path = script:GetFullName():gsub('/', '.')
	if path:find('CorePackages%.', 1, true) and not CONFIG.INCLUDE_CORE_PACKAGES then
		return true
	end
	if path:find('CoreGui%.', 1, true) and not CONFIG.INCLUDE_CORE_GUI then
		return true
	end
	if path:find('ReplicatedStorage%.Default', 1, true) then
		return true
	end
	if path:find('ReplicatedStorage%.Shared%.Modules', 1, true) then
		return true
	end
	if path:find('ReplicatedStorage%.Studio%.', 1, true) then
		return true
	end
	if path:find('ServerScriptService%.Default', 1, true) then
		return true
	end
	if path:find('StarterPlayer%.Default', 1, true) then
		return true
	end
	if path:find('StarterGui%.Default', 1, true) then
		return true
	end
	if path:find('StarterPlayerScripts%.Default', 1, true) then
		return true
	end
	if path:find('StarterCharacterScripts%.Default', 1, true) then
		return true
	end
	if path:find('Lighting%.Default', 1, true) then
		return true
	end
	if path:find('GameInsight%.', 1, true) then
		return true
	end
	if path:find('CoreGui%.Roboto%.', 1, true) then
		return true
	end
	if path:find('GameSettings%.', 1, true) then
		return true
	end
	if path:find('SessionService%.', 1, true) then
		return true
	end
	if path:find('Chat%.', 1, true) and not path:find('Chat%.CustomChat', 1, true) then
		return true
	end
	if not CONFIG.INCLUDE_PLAYER_MODULE and path:find('PlayerModule', 1, true) then
		return true
	end
	if not CONFIG.INCLUDE_CHARACTER_SCRIPTS and path:find('Players%.[^%.]+%.Character%.', 1, true) then
		return true
	end
	if not CONFIG.INCLUDE_BACKPACK and path:find('Players%.[^%.]+%.Backpack%.', 1, true) then
		return true
	end
	return false
end

local function gatherScripts()
	local seen = {}
	local scripts = {}
	local coreGui = game.CoreGui
	local corePackages = game.CorePackages

	local function addScript(script)
		if not SCRIPT_CLASSES[script.ClassName] then
			return
		end
		if script:IsDescendantOf(coreGui) and not CONFIG.INCLUDE_CORE_GUI then
			return
		end
		if script:IsDescendantOf(corePackages) and not CONFIG.INCLUDE_CORE_PACKAGES then
			return
		end
		if isRobloxNoise(script) then
			return
		end
		local fullName = script:GetFullName()
		if seen[fullName] then
			return
		end
		seen[fullName] = true
		table.insert(scripts, script)
	end

	local function walk(inst)
		if SCRIPT_CLASSES[inst.ClassName] then
			addScript(inst)
		end
		for _, child in inst:GetChildren() do
			walk(child)
		end
	end

	walk(game)

	if type(getnilinstances) == 'function' then
		for _, inst in getnilinstances() do
			walk(inst)
		end
	end

	if type(gethui) == 'function' then
		local ok, hui = pcall(gethui)
		if ok and typeof(hui) == 'Instance' then
			walk(hui)
		end
	end

	if type(getscripts) == 'function' then
		local ok, list = pcall(getscripts)
		if ok and type(list) == 'table' then
			for _, script in list do
				if typeof(script) == 'Instance' then
					addScript(script)
				end
			end
		end
	end

	if type(getrunningscripts) == 'function' then
		local ok, list = pcall(getrunningscripts)
		if ok and type(list) == 'table' then
			for _, script in list do
				if typeof(script) == 'Instance' then
					addScript(script)
				end
			end
		end
	end

	if type(getloadedmodules) == 'function' then
		local ok, list = pcall(getloadedmodules)
		if ok and type(list) == 'table' then
			for _, module in list do
				if typeof(module) == 'Instance' and module.ClassName == 'ModuleScript' then
					addScript(module)
				end
			end
		end
	end

	local settingsObj = settings and settings()
	if typeof(settingsObj) == 'Instance' then
		walk(settingsObj)
	end

	table.sort(scripts, function(a, b)
		local pa, pb = isPriorityScript(a), isPriorityScript(b)
		if pa ~= pb then
			return pa
		end
		return a:GetFullName() < b:GetFullName()
	end)

	return scripts
end

local function buildScriptRelPath(script, subfolder, usedPaths)
	local dirParts = {}
	local current = script.Parent
	while current and current ~= game do
		table.insert(dirParts, 1, sanitizeName(current.Name))
		current = current.Parent
	end
	local baseName = sanitizeName(script.Name) .. '.' .. script.ClassName
	local fileName = baseName .. '.lua'
	local dirPath = table.concat(dirParts, '/')
	local rel = subfolder .. '/' .. (dirPath == '' and fileName or (dirPath .. '/' .. fileName))
	local suffix = 1
	while usedPaths[rel] do
		suffix += 1
		fileName = baseName .. '_' .. suffix .. '.lua'
		rel = subfolder .. '/' .. (dirPath == '' and fileName or (dirPath .. '/' .. fileName))
	end
	usedPaths[rel] = true
	return rel
end

local function getScriptEnabled(script)
	if script.ClassName == 'ModuleScript' then
		return nil
	end
	local ok, enabled = pcall(function()
		return script.Enabled
	end)
	if ok then
		return enabled
	end
	return nil
end

local function formatDecompiledHeader(script)
	return string.format(
		'-- Decompiled from: %s\n-- Class: %s\n-- Place: %s (%s)\n-- JobId: %s\n\n',
		script:GetFullName(),
		script.ClassName,
		game.Name,
		tostring(game.PlaceId),
		game.JobId
	)
end

local function bytecodeToHex(data)
	return (data:gsub('.', function(c)
		return string.format('%02x', string.byte(c))
	end))
end

local function tryDecompile(script)
	if type(decompile) ~= 'function' then
		return false, 'decompile unavailable'
	end
	local ok, src = pcall(decompile, script)
	if not ok then
		return false, tostring(src)
	end
	if type(src) ~= 'string' or #src == 0 then
		return false, 'empty decompile result'
	end
	local lower = src:lower()
	if lower:find('failed to decompile', 1, true) or lower:find('decompile failed', 1, true) then
		return false, src
	end
	return true, src
end

-- Obfuscation detection + best-effort cleanup (not full devirtualization)
local OBFUSCATION_MARKERS = {
	{ id = 'lph', pattern = 'LPH_OBFUSCATED', score = 10 },
	{ id = 'lph', pattern = 'LPH_JIT_MAX', score = 8 },
	{ id = 'lph', pattern = 'LPH_JIT', score = 8 },
	{ id = 'lph', pattern = 'LPH_NO_VIRTUALIZE', score = 8 },
	{ id = 'lph', pattern = 'LPH_NO_UPVALUES', score = 8 },
	{ id = 'luraph', pattern = 'luraph', score = 5, ignoreCase = true },
	{ id = 'ironbrew', pattern = 'IB_DEBUG', score = 8 },
	{ id = 'moonsec', pattern = 'MoonSec', score = 8, ignoreCase = true },
	{ id = 'psu', pattern = 'PSU_', score = 6 },
	{ id = 'flux', pattern = 'FLUX_', score = 6 },
	{ id = 'hash_keys', pattern = '_x[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]+', score = 2, minCount = 4 },
	{ id = 'l__alias', pattern = 'l__[%w_]+', score = 1, minCount = 6 },
	{ id = 'goto_spam', pattern = 'goto ', score = 1, minCount = 12 },
	{ id = 'string_char', pattern = 'string%.char%(', score = 1, minCount = 8 },
}

local function countPattern(source, pattern)
	local count = 0
	for _ in source:gmatch(pattern) do
		count += 1
	end
	return count
end

local function detectObfuscation(source)
	if type(source) ~= 'string' or source == '' then
		return false, 0, {}
	end
	local hits = {}
	local score = 0
	for _, marker in OBFUSCATION_MARKERS do
		if marker.minCount then
			local count = countPattern(source, marker.pattern)
			if count >= marker.minCount then
				hits[marker.id] = (hits[marker.id] or 0) + count
				score += marker.score
			end
		else
			local found = false
			if marker.ignoreCase then
				found = source:lower():find(marker.pattern:lower(), 1, true) ~= nil
			else
				found = source:find(marker.pattern, 1, true) ~= nil
			end
			if found then
				hits[marker.id] = 1
				score += marker.score
			end
		end
	end
	local vmCount = countPattern(source, 'local v%d+')
	if vmCount >= 35 then
		hits.virtualized_locals = vmCount
		score += 6
	end
	local threshold = CONFIG.OBFUSCATION_SCORE_THRESHOLD or 5
	return score >= threshold, score, hits
end

local function unwrapLphWrappers(text)
	local guard = 0
	while guard < 500 do
		guard += 1
		local before = text
		text = text:gsub('LPH_JIT_MAX%(function', 'function')
		text = text:gsub('LPH_NO_VIRTUALIZE%(function', 'function')
		text = text:gsub('LPH_JIT%(function', 'function')
		text = text:gsub('LPH_NO_UPVALUES%(function', 'function')
		text = text:gsub('end%)%s*;', 'end;')
		text = text:gsub('end%)', 'end')
		if text == before then
			break
		end
	end
	return text
end

local function deobfuscateLuau(source, hits)
	if type(source) ~= 'string' or source == '' then
		return source
	end
	hits = hits or {}
	local out = source:gsub('\r\n', '\n'):gsub('\r', '\n')

	if hits.lph or out:find('LPH_', 1, true) then
		out = out:gsub('if not LPH_OBFUSCATED then.-end;\n', '')
		out = unwrapLphWrappers(out)
	end

	if hits.l__alias or out:find('l__', 1, true) then
		out = out:gsub(
			'local (l__[%w_]+) = require%(game:GetService%("ReplicatedStorage"%)%.Assets%.ModuleScripts%.(%w+)%)',
			function(alias, mod)
				return string.format(
					'local %s = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.%s) -- %s',
					alias, mod, mod
				)
			end
		)
		out = out:gsub(
			'local (l__[%w_]+) = require%((.-)%)',
			function(alias, pathExpr)
				return string.format('local %s = require(%s) -- deobf alias', alias, pathExpr)
			end
		)
	end

	out = out:gsub('\n\n\n+', '\n\n')
	if not out:match('\n$') then
		out ..= '\n'
	end
	return out
end

local function tryBytecode(script)
	if type(getscriptbytecode) ~= 'function' then
		return false, nil, 'getscriptbytecode unavailable'
	end
	local ok, bc = pcall(getscriptbytecode, script)
	if not ok or type(bc) ~= 'string' or #bc == 0 then
		return false, nil, tostring(bc)
	end
	return true, bc, nil
end

local function dumpAllScripts(scripts)
	local usedPaths = {}
	local jobs = {}
	for _, script in scripts do
		table.insert(jobs, {
			script = script,
			rel = buildScriptRelPath(script, 'scripts', usedPaths),
		})
	end

	local stats = {
		found = #jobs,
		decompiled = 0,
		deobfuscated = 0,
		plain = 0,
		bytecode = 0,
		failed = 0,
	}
	local pendingWrites = {}
	local active = 0
	local idx = 0

	local function queueWrite(rel, text)
		table.insert(pendingWrites, { rel, text })
		if mirrorRoot ~= '' and rel:sub(1, 8) == 'scripts/' then
			table.insert(pendingWrites, { mirrorRoot .. '/' .. rel:sub(9), text })
		elseif mirrorRoot ~= '' and rel:sub(1, 15) == 'scripts_deobf/' then
			table.insert(pendingWrites, { mirrorRoot .. '/deobf/' .. rel:sub(16), text })
		end
	end

	local function flushWrites(forceAll)
		local limit = forceAll and #pendingWrites or CONFIG.WRITE_EVERY_N
		while #pendingWrites > 0 and (forceAll or #pendingWrites >= limit) do
			local pair = table.remove(pendingWrites, 1)
			writeText(pair[1], pair[2])
		end
	end

	local function writeProgress()
		writeText('manifest/decompile_progress.txt', string.format(
			'processed=%d/%d decompiled=%d plain=%d deobfuscated=%d bytecode=%d failed=%d pendingWrites=%d\n',
			idx, #jobs, stats.decompiled, stats.plain, stats.deobfuscated, stats.bytecode, stats.failed, #pendingWrites
		))
	end

	local function processJob(job)
		local ok, err = pcall(function()
			local script = job.script
			local entry = {
				fullName = script:GetFullName(),
				className = script.ClassName,
				output = job.rel,
				status = 'failed',
				enabled = getScriptEnabled(script),
			}

			if type(gethiddenproperty) == 'function' and script.ClassName ~= 'ModuleScript' then
				local hiddenOk, hiddenEnabled = pcall(gethiddenproperty, script, 'Enabled')
				if hiddenOk then
					entry.hiddenEnabled = hiddenEnabled
				end
			end

			local decompOk, decompSrc = tryDecompile(script)
			if decompOk then
				local normalized = decompSrc:gsub('\r\n', '\n'):gsub('\r', '\n')
				local rawText = formatDecompiledHeader(script) .. normalized
				if not rawText:match('\n$') then
					rawText ..= '\n'
				end
				queueWrite(job.rel, rawText)

				local obfuscated, obfScore, obfHits = false, 0, {}
				if CONFIG.AUTO_DETECT_OBFUSCATION then
					obfuscated, obfScore, obfHits = detectObfuscation(normalized)
				end
				entry.obfuscated = obfuscated
				entry.obfuscationScore = obfScore
				if next(obfHits) then
					entry.obfuscationHits = obfHits
				end

				if obfuscated and CONFIG.DEOBFUSCATE_WHEN_DETECTED then
					local deobfText = formatDecompiledHeader(script)
						.. deobfuscateLuau(normalized, obfHits)
					if CONFIG.DEOBFUSCATE_WRITE_COPY then
						local deobfRel = job.rel:gsub('^scripts/', 'scripts_deobf/')
						queueWrite(deobfRel, deobfText)
					end
					stats.deobfuscated += 1
					entry.status = 'decompiled+deobf'
				else
					stats.plain += 1
					entry.status = 'decompiled'
				end
				stats.decompiled += 1
			else
				entry.decompileError = decompSrc
				local bcOk, bc, bcErr = tryBytecode(script)
				if bcOk then
					local hexPath = job.rel:gsub('^scripts/', 'bytecode/'):gsub('.lua$', '.hex.txt')
					local header = string.format(
						'-- Bytecode dump (decompile failed)\n-- Script: %s\n-- Size: %d bytes\n-- Error: %s\n\n',
						script:GetFullName(),
						#bc,
						tostring(decompSrc):gsub('\n', ' ')
					)
					queueWrite(hexPath, header .. bytecodeToHex(bc))
					entry.bytecode = hexPath
					entry.status = 'bytecode'
					stats.bytecode += 1
				else
					entry.bytecodeError = bcErr
					entry.status = 'failed'
					stats.failed += 1
				end
			end

			table.insert(manifest.scripts, entry)
			flushWrites(false)
		end)
		if not ok then
			stats.failed += 1
			table.insert(manifest.scripts, {
				fullName = job.script:GetFullName(),
				className = job.script.ClassName,
				output = job.rel,
				status = 'failed',
				processError = tostring(err),
			})
			table.insert(manifest.errors, 'processJob: ' .. job.script:GetFullName() .. ' -> ' .. tostring(err))
			flushWrites(false)
		end
	end

	local concurrency = math.max(1, CONFIG.DECOMPILE_CONCURRENCY or 1)
	if concurrency <= 1 then
		for _, job in jobs do
			idx += 1
			processJob(job)
			if idx % CONFIG.PROGRESS_EVERY_N == 0 or idx == #jobs then
				writeProgress()
				log(string.format('Processing scripts %d/%d (decompiled=%d plain=%d deobf=%d bytecode=%d failed=%d)',
					idx, #jobs, stats.decompiled, stats.plain, stats.deobfuscated, stats.bytecode, stats.failed))
				task.wait()
			end
		end
	else
		local jobIndex = 0
		local function worker()
			while true do
				jobIndex += 1
				local job = jobs[jobIndex]
				if not job then
					break
				end
				idx += 1
				processJob(job)
				if idx % CONFIG.PROGRESS_EVERY_N == 0 or idx == #jobs then
					writeProgress()
				end
			end
		end
		for _ = 1, concurrency do
			active += 1
			task.spawn(function()
				worker()
				active -= 1
			end)
		end
		while active > 0 do
			if idx % CONFIG.PROGRESS_EVERY_N == 0 or idx == #jobs then
				log(string.format('Processing scripts %d/%d (decompiled=%d plain=%d deobf=%d bytecode=%d failed=%d)',
					idx, #jobs, stats.decompiled, stats.plain, stats.deobfuscated, stats.bytecode, stats.failed))
			end
			task.wait()
		end
	end

	flushWrites(true)
	manifest.stats.scripts = stats
	if mirrorRoot ~= '' then
		manifest.stats.mirrorRoot = mirrorRoot
	end
	writeText('manifest/obfuscation_summary.txt', string.format(
		'# Obfuscation detection summary\n'
			.. 'threshold=%s\n'
			.. 'decompiled=%d\n'
			.. 'plain=%d\n'
			.. 'deobfuscated=%d\n'
			.. 'autoDetect=%s\n'
			.. 'deobfuscateWhenDetected=%s\n',
		tostring(CONFIG.OBFUSCATION_SCORE_THRESHOLD),
		stats.decompiled,
		stats.plain,
		stats.deobfuscated,
		tostring(CONFIG.AUTO_DETECT_OBFUSCATION),
		tostring(CONFIG.DEOBFUSCATE_WHEN_DETECTED)
	))
	return stats
end

local function dumpRemotes()
	local lines = {
		'# Remote / bindable inventory',
		'# place=' .. tostring(game.PlaceId) .. ' job=' .. game.JobId,
		'',
	}
	local classes = {
		RemoteEvent = true,
		RemoteFunction = true,
		UnreliableRemoteEvent = true,
		BindableEvent = true,
		BindableFunction = true,
	}
	for _, inst in game:GetDescendants() do
		if classes[inst.ClassName] then
			lines[#lines + 1] = string.format('%s\t%s', inst.ClassName, inst:GetFullName())
		end
	end
	writeText('manifest/remotes.txt', table.concat(lines, '\n') .. '\n')
	manifest.stats.remotes = #lines - 3
end

local function dumpTags()
	local tags = collectionService:GetAllTags()
	table.sort(tags)
	local lines = { '# CollectionService tags', '' }
	for _, tag in tags do
		local tagged = collectionService:GetTagged(tag)
		lines[#lines + 1] = string.format('%s\tcount=%d', tag, #tagged)
		for i = 1, math.min(8, #tagged) do
			lines[#lines + 1] = '  ' .. tagged[i]:GetFullName()
		end
		if #tagged > 8 then
			lines[#lines + 1] = '  ... +' .. (#tagged - 8) .. ' more'
		end
	end
	writeText('manifest/collection_tags.txt', table.concat(lines, '\n') .. '\n')
	manifest.stats.tags = #tags
end

local function dumpInstanceTree(root, relName, maxDepth)
	if not root then
		return
	end
	local lines = {
		'# Instance tree: ' .. root:GetFullName(),
		'',
	}
	local function walk(inst, depth, prefix)
		if depth > maxDepth then
			lines[#lines + 1] = prefix .. '... (depth limit)'
			return
		end
		local extra = ''
		if inst:IsA('Animation') and inst.AnimationId ~= '' then
			extra = ' AnimationId=' .. inst.AnimationId
		elseif inst:IsA('Sound') and inst.SoundId ~= '' then
			extra = ' SoundId=' .. inst.SoundId
		elseif inst:IsA('ValueBase') then
			extra = ' Value=' .. valuePreview(inst.Value)
		end
		local attrCount = 0
		for _ in inst:GetAttributes() do
			attrCount += 1
		end
		if attrCount > 0 then
			extra = extra .. ' attrs=' .. attrCount
		end
		lines[#lines + 1] = prefix .. inst.ClassName .. ' ' .. inst.Name .. extra
		for _, child in inst:GetChildren() do
			walk(child, depth + 1, prefix .. '  ')
		end
	end
	walk(root, 0, '')
	writeText('manifest/trees/' .. relName .. '.txt', table.concat(lines, '\n') .. '\n')
end

local function dumpAnimations()
	local lines = {
		'# Animation catalog',
		'# Format: path | AnimationId | name',
		'',
	}
	local roots = {
		game:GetService('ReplicatedStorage'),
		game:GetService('StarterPlayer'),
		game:GetService('ServerStorage'),
	}
	local seen = {}
	for _, root in roots do
		if root then
			for _, desc in root:GetDescendants() do
				if desc:IsA('Animation') then
					local key = desc:GetFullName()
					if not seen[key] then
						seen[key] = true
						lines[#lines + 1] = string.format('%s\t%s\t%s', desc:GetFullName(), desc.AnimationId, desc.Name)
					end
				elseif desc:IsA('KeyframeSequence') then
					local key = desc:GetFullName()
					if not seen[key] then
						seen[key] = true
						lines[#lines + 1] = string.format('%s\tKeyframeSequence\t%s', desc:GetFullName(), desc.Name)
					end
				end
			end
		end
	end
	writeText('manifest/animations.txt', table.concat(lines, '\n') .. '\n')
	manifest.stats.animations = #lines - 3
end

local function dumpReadOnly()
	local lines = {
		'# ReadOnly snapshots',
		'',
	}
	local rs = game:GetService('ReplicatedStorage')
	local globalRo = rs:FindFirstChild('ReadOnly')
	if globalRo then
		lines[#lines + 1] = '## ReplicatedStorage.ReadOnly'
		for _, child in globalRo:GetChildren() do
			lines[#lines + 1] = string.format('  %s (%s) = %s', child.Name, child.ClassName, valuePreview(child:IsA('ValueBase') and child.Value or child))
		end
		lines[#lines + 1] = ''
	end
	for _, plr in playersService:GetPlayers() do
		local ro = plr:FindFirstChild('ReadOnly')
		lines[#lines + 1] = '## Player ' .. plr.Name .. ' (' .. plr.UserId .. ')'
		if not ro then
			lines[#lines + 1] = '  (missing ReadOnly folder)'
		else
			for _, child in ro:GetChildren() do
				local val = child:IsA('ValueBase') and child.Value
				lines[#lines + 1] = string.format('  %s (%s) = %s', child.Name, child.ClassName, valuePreview(val))
			end
		end
		lines[#lines + 1] = ''
	end
	writeText('manifest/read_only.txt', table.concat(lines, '\n') .. '\n')
end

local function dumpPackets()
	local lines = {
		'# Packet registry (client-visible)',
		'',
	}
	local rs = game:GetService('ReplicatedStorage')
	local assets = rs:FindFirstChild('Assets')
	local modules = assets and assets:FindFirstChild('ModuleScripts')
	local packetsModule = modules and modules:FindFirstChild('Packets')
	if not packetsModule then
		lines[#lines + 1] = 'Packets module not found under ReplicatedStorage.Assets.ModuleScripts'
	else
		local ok, packets = pcall(require, packetsModule)
		if not ok then
			lines[#lines + 1] = 'require(Packets) failed: ' .. tostring(packets)
		else
			for key, packet in packets do
				if type(key) == 'string' and key:sub(1, 1) == '_' then
					local name = (type(packet) == 'table' and packet.Name) or '?'
					local id = (type(packet) == 'table' and packet.Id) or '?'
					lines[#lines + 1] = string.format('%s -> remote=%s id=%s type=%s', key, name, tostring(id), typeof(packet))
				end
			end
			if type(packets.unreliablePackets) == 'table' then
				lines[#lines + 1] = ''
				lines[#lines + 1] = '# unreliablePackets'
				for key, packet in packets.unreliablePackets do
					if type(key) == 'string' then
						local name = (type(packet) == 'table' and packet.Name) or '?'
						lines[#lines + 1] = string.format('%s -> remote=%s', key, name)
					end
				end
			end
		end
		for _, child in packetsModule:GetChildren() do
			if child:IsA('RemoteEvent') or child:IsA('UnreliableRemoteEvent') or child:IsA('RemoteFunction') then
				lines[#lines + 1] = string.format('child_remote %s %s', child.ClassName, child.Name)
			end
		end
	end
	writeText('manifest/packets.txt', table.concat(lines, '\n') .. '\n')
end

local function dumpItemDefs()
	local lines = { '# ItemDef / registry', '' }
	local rs = game:GetService('ReplicatedStorage')
	local assets = rs:FindFirstChild('Assets')
	if not assets then
		writeText('manifest/item_defs.txt', 'Assets folder missing\n')
		return
	end
	local modules = assets:FindFirstChild('ModuleScripts')
	local itemDef = modules and modules:FindFirstChild('ItemDef')
	if itemDef then
		local ok, mod = pcall(require, itemDef)
		if ok and type(mod) == 'table' and type(mod.getDefs) == 'function' then
			local ok2, defs = pcall(mod.getDefs)
			if ok2 and type(defs) == 'table' then
				for id, def in defs do
					lines[#lines + 1] = '## ' .. tostring(id)
					if type(def) == 'table' then
						for k, v in def do
							if k ~= 'stat_entries' then
								lines[#lines + 1] = '  ' .. tostring(k) .. ' = ' .. valuePreview(v)
							end
						end
						if type(def.stat_entries) == 'table' then
							for _, entry in def.stat_entries do
								lines[#lines + 1] = string.format(
									'  stat %s = %s (alpha=%s)',
									tostring(entry.stat_name),
									valuePreview(entry.stat_value),
									tostring(entry.fill_alpha)
								)
							end
						end
					end
					lines[#lines + 1] = ''
				end
			end
		else
			lines[#lines + 1] = 'ItemDef require failed: ' .. tostring(mod)
		end
	end
	local sharedClasses = assets:FindFirstChild('SharedClasses')
	local registry = sharedClasses and sharedClasses:FindFirstChild('ItemRegistry')
	if registry then
		local ok, reg = pcall(require, registry)
		if ok and type(reg) == 'table' then
			lines[#lines + 1] = '# ItemRegistry keys'
			for k, v in reg do
				lines[#lines + 1] = string.format('%s = %s', tostring(k), valuePreview(v))
			end
		end
	end
	writeText('manifest/item_defs.txt', table.concat(lines, '\n') .. '\n')
end

local function shallowTableKeys(tbl, depth)
	depth = depth or 0
	if type(tbl) ~= 'table' or depth > 1 then
		return valuePreview(tbl)
	end
	local keys = {}
	for k, v in tbl do
		if type(k) == 'string' then
			if type(v) == 'table' then
				local sub = {}
				for sk in v do
					sub[#sub + 1] = tostring(sk)
				end
				table.sort(sub)
				keys[#keys + 1] = k .. '{' .. table.concat(sub, ',') .. '}'
			else
				keys[#keys + 1] = k .. '=' .. typeof(v)
			end
		end
	end
	table.sort(keys)
	return table.concat(keys, '; ')
end

local function dumpModuleProbes()
	if not CONFIG.REQUIRE_PROBE then
		return
	end
	local lines = {
		'# Module require probe (shallow, pcall)',
		'# WARNING: side effects possible; skipped on failure',
		'',
	}
	local rs = game:GetService('ReplicatedStorage')
	local roots = {
		rs,
		game:GetService('ServerStorage'),
		game:GetService('ServerScriptService'),
		game:GetService('StarterPlayer'),
		game:GetService('StarterGui'),
	}
	local assets = rs:FindFirstChild('Assets')
	if assets then
		table.insert(roots, 1, assets)
	end
	local count = 0
	for _, root in roots do
		for _, desc in root:GetDescendants() do
			if desc.ClassName ~= 'ModuleScript' then
				continue
			end
			if count >= CONFIG.REQUIRE_PROBE_MAX then
				lines[#lines + 1] = '... probe limit reached'
				break
			end
			count += 1
			local ok, result = pcall(require, desc)
			if ok then
				lines[#lines + 1] = string.format(
					'OK %s -> %s %s',
					desc:GetFullName(),
					typeof(result),
					shallowTableKeys(result)
				)
			else
				lines[#lines + 1] = string.format('FAIL %s -> %s', desc:GetFullName(), tostring(result))
			end
		end
	end
	manifest.stats.moduleProbes = count
	writeText('manifest/module_probe.txt', table.concat(lines, '\n') .. '\n')
end

local function dumpGcStrings()
	if type(getgc) ~= 'function' then
		return
	end
	local keywords = CONFIG.GC_KEYWORDS or {}
	local hits = {}
	local ok, gc = pcall(getgc, true)
	if not ok or type(gc) ~= 'table' then
		return
	end
	for _, obj in gc do
		if type(obj) == 'string' then
			local lower = obj:lower()
			for _, kw in keywords do
				if lower:find(kw, 1, true) then
					hits[obj] = (hits[obj] or 0) + 1
				end
			end
		elseif type(obj) == 'function' then
			local info = debug.info(obj, 's')
			if type(info) == 'string' then
				local lower = info:lower()
				for _, kw in keywords do
					if lower:find(kw, 1, true) then
						hits[info] = (hits[info] or 0) + 1
					end
				end
			end
		end
	end
	local lines = { '# getgc keyword hits', '' }
	local sorted = {}
	for str in hits do
		sorted[#sorted + 1] = str
	end
	table.sort(sorted)
	for _, str in sorted do
		lines[#lines + 1] = str
	end
	writeText('manifest/gc_keyword_hits.txt', table.concat(lines, '\n') .. '\n')
	manifest.stats.gcHits = #lines - 2
end

local function dumpLoadedModulesList()
	if type(getloadedmodules) ~= 'function' then
		return
	end
	local ok, mods = pcall(getloadedmodules)
	if not ok or type(mods) ~= 'table' then
		return
	end
	local lines = { '# getloadedmodules', '' }
	for _, mod in mods do
		if typeof(mod) == 'Instance' then
			lines[#lines + 1] = mod:GetFullName()
		end
	end
	table.sort(lines)
	writeText('manifest/loaded_modules.txt', table.concat(lines, '\n') .. '\n')
	manifest.stats.loadedModules = #lines - 2
end

local function writeManifest()
	manifest.finishedAt = os.date('!%Y-%m-%dT%H:%M:%SZ')
	local json = jsonEncode(manifest)
	if json then
		writeText('manifest/index.json', json)
	end
	local summary = {
		'Universal Full Game Dump Summary',
		'place=' .. tostring(manifest.placeId) .. ' (' .. manifest.placeName .. ')',
		'job=' .. game.JobId,
		'root=' .. dumpRoot,
		'started=' .. manifest.startedAt,
		'finished=' .. manifest.finishedAt,
		'',
		'scripts/ = raw decompiler output for every script.',
		'scripts_deobf/ = deobfuscated copy only when obfuscation was detected.',
		'Use bytecode/*.hex.txt + Potassium decompiler for failed scripts.',
		'',
		'Copy mirror to repo:',
		'  decompiled games/Ugc_<placeId>_<timestamp>/scripts/...',
		'Join the live game (not just menu) before dumping for best coverage.',
		'',
	}
	if mirrorRoot ~= '' then
		summary[#summary + 1] = 'mirrorRoot=' .. mirrorRoot
	end
	for k, v in manifest.stats do
		if type(v) == 'table' then
			summary[#summary + 1] = k .. ':'
			for k2, v2 in v do
				summary[#summary + 1] = '  ' .. k2 .. '=' .. tostring(v2)
			end
		else
			summary[#summary + 1] = k .. '=' .. tostring(v)
		end
	end
	writeText('manifest/SUMMARY.txt', table.concat(summary, '\n') .. '\n')
end

local function runDump()
	if not hasFileApi() then
		error('writefile/makefolder/isfolder required')
	end
	if type(decompile) ~= 'function' and type(getscriptbytecode) ~= 'function' then
		error('Need decompile or getscriptbytecode')
	end

	dumpRoot = buildDumpRoot()
	log('Output:', dumpRoot)
	if mirrorRoot ~= '' then
		log('Mirror:', mirrorRoot)
	end
	waitForGameLoad()
	log('Gathering scripts...')
	local scripts = gatherScripts()
	log('Found', #scripts, 'scripts (priority scripts sorted first)')

	local pathLines = { '# All discovered script paths', '' }
	for _, script in scripts do
		pathLines[#pathLines + 1] = script:GetFullName() .. ' [' .. script.ClassName .. ']'
	end
	writeText('manifest/script_paths.txt', table.concat(pathLines, '\n') .. '\n')

	dumpRemotes()
	dumpTags()
	dumpAnimations()
	dumpReadOnly()
	if shouldDumpGameExtras() then
		log('Game-specific extras enabled (packets/item defs)')
		dumpPackets()
		dumpItemDefs()
	else
		writeText('manifest/packets.txt', '# Packet registry\n\n(not enabled — set CONFIG.GAME_EXTRAS or join a REDLINER-like place)\n')
		writeText('manifest/item_defs.txt', '# Item defs\n\n(not enabled)\n')
	end
	dumpLoadedModulesList()

	local rs = game:GetService('ReplicatedStorage')
	local assets = rs:FindFirstChild('Assets')
	if assets then
		dumpInstanceTree(assets, 'ReplicatedStorage_Assets', CONFIG.TREE_MAX_DEPTH)
	end
	dumpInstanceTree(rs, 'ReplicatedStorage', math.min(6, CONFIG.TREE_MAX_DEPTH))
	dumpInstanceTree(game:GetService('ServerScriptService'), 'ServerScriptService', CONFIG.TREE_MAX_DEPTH)
	dumpInstanceTree(game:GetService('StarterPlayer'), 'StarterPlayer', CONFIG.TREE_MAX_DEPTH)
	dumpInstanceTree(game:GetService('ServerStorage'), 'ServerStorage', CONFIG.TREE_MAX_DEPTH)
	dumpInstanceTree(workspace, 'Workspace', math.min(8, CONFIG.TREE_MAX_DEPTH))

	local scriptStats = dumpAllScripts(scripts)

	dumpModuleProbes()
	dumpGcStrings()
	writeManifest()

	log('Done.')
	log('Scripts: found=' .. scriptStats.found
		.. ' decompiled=' .. scriptStats.decompiled
		.. ' plain=' .. tostring(scriptStats.plain or 0)
		.. ' deobfuscated=' .. tostring(scriptStats.deobfuscated or 0)
		.. ' bytecode=' .. scriptStats.bytecode
		.. ' failed=' .. scriptStats.failed)
	log('Saved to workspace/' .. dumpRoot)
	log('See manifest/SUMMARY.txt and manifest/index.json')
end

local function main()
	log('Starting universal dump for', game.Name, game.PlaceId)
	local ok, err = pcall(runDump)
	if not ok then
		warnLog('Dump failed:', err)
		error(err)
	end
end

main()
