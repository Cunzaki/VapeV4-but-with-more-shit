--[[
	UGC 5315066937 — Full Engine Dumper (standalone)

	This place destroys ReplicatedStorage.Client / Shared after Load.ModuleScript runs.
	The universal dumper only captures ~50 wiring scripts; the physics engine lives in
	destroyed Shared modules (Simulation, GameMechanics, Physics, RealtimeContext, …).

	This dumper:
	  1. Waits for the custom engine to finish bootstrapping
	  2. Decompiles all live Instance scripts (wiring/UI)
	  3. Recovers destroyed Client/Shared ModuleScripts from getgc()
	  4. Names recovered modules via debug.info source paths + content signatures
	  5. Dumps live runtime singletons (ContextManager, View, RootTimer, Simulations, GameMechanics)

	Usage (executor — join place 5315066937, load a map, wait ~5s, then run):
		loadstring(readfile('tools/ugc5315066937_full_dumper.lua'), 'ugc531_full')()

	Output (primary, repo-ready):
		decompiled games/Ugc_5315066937_<timestamp>/
			scripts/           wiring modules still parented in game
			scripts_client/    recovered ReplicatedStorage.Client.*
			scripts_shared/    recovered ReplicatedStorage.Shared.*  (Simulation, GameMechanics, …)
			scripts_deobf/     deobfuscated copies when obfuscation detected
			bytecode/          hex fallback when decompile fails
			manifest/          indexes, remotes, runtime engine snapshots
			runtime/           detailed singleton / simulation introspection

	Requires: writefile, makefolder, isfolder, getgc, decompile or getscriptbytecode
	Optional: getloadedmodules, getscripts, getnilinstances, getrunningscripts, gethui
]]

local TARGET_PLACE_ID = 5315066937

local CONFIG = {
	OUTPUT_ROOT = 'decompiled games',
	BACKUP_ROOT = 'game_dumps', -- secondary copy of manifest + stats
	WAIT_FOR_ENGINE = true,
	ENGINE_TIMEOUT = 120,
	POST_LOAD_DELAY = 3,
	DECOMPILE_CONCURRENCY = 1,
	PROGRESS_EVERY_N = 10,
	DUMP_ALL_SCRIPTS = false,
	INCLUDE_PLAYER_MODULE = false,
	INCLUDE_CHARACTER_SCRIPTS = false,
	RECOVER_DESTROYED_MODULES = true,
	DUMP_RUNTIME_ENGINE = true,
	DUMP_REMOTES = true,
	DUMP_TAGS = true,
	DUMP_SOURCE_PATH_INDEX = true,
	AUTO_DETECT_OBFUSCATION = true,
	DEOBFUSCATE_WHEN_DETECTED = true,
	LOG_PREFIX = '[UGC531 FullDumper]',
}

local SCRIPT_CLASSES = {
	LocalScript = true,
	ModuleScript = true,
	Script = true,
}

local INVALID_PATH_CHARS = { '\\', '/', ':', '*', '?', '"', '<', '>', '|' }
local WINDOWS_RESERVED = {
	CON = true, PRN = true, AUX = true, NUL = true,
	COM1 = true, COM2 = true, COM3 = true, COM4 = true, COM5 = true,
	COM6 = true, COM7 = true, COM8 = true, COM9 = true,
	LPT1 = true, LPT2 = true, LPT3 = true, LPT4 = true, LPT5 = true,
	LPT6 = true, LPT7 = true, LPT8 = true, LPT9 = true,
}

-- Heuristic rename for recovered modules (source path preferred when available)
local MODULE_SIGNATURES = {
	{ folder = 'shared', name = 'GameMechanics', score = function(src)
		local s = 0
		if src:find('MaxSpeed', 1, true) then s += 3 end
		if src:find('AirAccelerate', 1, true) then s += 3 end
		if src:find('SetStyle', 1, true) then s += 2 end
		if src:find('SetMapInfo', 1, true) then s += 2 end
		return s
	end },
	{ folder = 'shared', name = 'Simulation', score = function(src)
		local s = 0
		if src:find('GameMechanics', 1, true) then s += 2 end
		if src:find('HandleInput', 1, true) then s += 2 end
		if src:find('LoadWorld', 1, true) then s += 3 end
		if src:find('CopyState', 1, true) then s += 2 end
		if src:find('ShouldRun', 1, true) then s += 1 end
		return s
	end },
	{ folder = 'shared', name = 'Physics', score = function(src)
		local s = 0
		if src:find('SetVelocity', 1, true) then s += 3 end
		if src:find('SetPosition', 1, true) then s += 2 end
		if src:find('Handlers', 1, true) then s += 1 end
		return s
	end },
	{ folder = 'shared', name = 'RealtimeTimerSystem', score = function(src)
		local s = 0
		if src:find('RootTimer', 1, true) then s += 4 end
		if src:find('GetScale', 1, true) then s += 2 end
		if src:find('SetTimescale', 1, true) then s += 2 end
		return s
	end },
	{ folder = 'shared', name = 'ContextManager', score = function(src)
		local s = 0
		if src:find('GetContext', 1, true) then s += 3 end
		if src:find('RegisterContext', 1, true) then s += 3 end
		if src:find('Contexts', 1, true) then s += 2 end
		return s
	end },
	{ folder = 'client', name = 'RealtimeContext', score = function(src)
		local s = 0
		if src:find('GetPV', 1, true) then s += 4 end
		if src:find('SmoothingSimulation', 1, true) then s += 3 end
		if src:find('GetOutput', 1, true) then s += 2 end
		return s
	end },
	{ folder = 'client', name = 'PlaybackContext', score = function(src)
		local s = 0
		if src:find('PlaybackControl', 1, true) then s += 3 end
		if src:find('MapOffset', 1, true) then s += 2 end
		if src:find('Runs', 1, true) then s += 1 end
		return s
	end },
	{ folder = 'client', name = 'SimulationSynchronization', score = function(src)
		local s = 0
		if src:find('Desynced', 1, true) then s += 3 end
		if src:find('BindSimulation', 1, true) then s += 3 end
		if src:find('ServerStateTimelines', 1, true) then s += 2 end
		return s
	end },
	{ folder = 'client', name = 'SmoothingSimulation', score = function(src)
		local s = 0
		if src:find('SetReferenceSimulation', 1, true) then s += 5 end
		if src:find('ReferenceSimulation', 1, true) then s += 3 end
		return s
	end },
	{ folder = 'shared', name = 'Styles', score = function(src)
		local s = 0
		if src:find('GetStyleName', 1, true) then s += 3 end
		if src:find('tickrate', 1, true) then s += 2 end
		if src:find('StyleInfo', 1, true) then s += 2 end
		return s
	end },
	{ folder = 'shared', name = 'SimulationDirector', score = function(src)
		local s = 0
		if src:find('HandleControl', 1, true) then s += 2 end
		if src:find('InputHandlers', 1, true) then s += 2 end
		if src:find('FlagInProgressRuns', 1, true) then s += 3 end
		return s
	end },
}

local httpService = game:GetService('HttpService')
local collectionService = game:GetService('CollectionService')
local playersService = game:GetService('Players')

local dumpRoot = ''
local backupRoot = ''
local manifest = {
	placeId = game.PlaceId,
	placeName = game.Name,
	jobId = game.JobId,
	startedAt = os.date('!%Y-%m-%dT%H:%M:%SZ'),
	scripts = {},
	recovered = {},
	runtime = {},
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
	if backupRoot ~= '' and relPath:sub(1, 9) == 'manifest/' then
		pcall(function()
			local backupPath = backupRoot .. '/' .. relPath
			local backupDir = backupPath:match('^(.*)/[^/]+$')
			if backupDir then
				ensureFolder(backupDir)
			end
			writefile(backupPath, text)
		end)
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
	if depth > 3 then
		return '...'
	end
	local t = typeof(value)
	if t == 'string' then
		if #value > 160 then
			return '"' .. value:sub(1, 157) .. '..."'
		end
		return '"' .. value:gsub('"', '\\"') .. '"'
	end
	if t == 'number' or t == 'boolean' then
		return tostring(value)
	end
	if t == 'Instance' then
		local ok, full = pcall(function()
			return value:GetFullName()
		end)
		return ok and full or tostring(value)
	end
	if t == 'Vector3' then
		return string.format('Vector3(%.4f, %.4f, %.4f)', value.X, value.Y, value.Z)
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
		for i = 1, math.min(#keys, 20) do
			local k = keys[i]
			parts[#parts + 1] = tostring(k) .. '=' .. valuePreview(value[k], depth + 1)
		end
		if #keys > 20 then
			parts[#parts + 1] = '...+' .. (#keys - 20)
		end
		return '{' .. table.concat(parts, ', ') .. '}'
	end
	return t
end

local function buildDumpRoot()
	local stamp = os.date('%Y%m%d_%H%M%S')
	local root = string.format('%s/Ugc_%s_%s', CONFIG.OUTPUT_ROOT, tostring(game.PlaceId), stamp)
	ensureFolder(root)
	backupRoot = string.format('%s/Ugc_%s_%s', CONFIG.BACKUP_ROOT, tostring(game.PlaceId), stamp)
	ensureFolder(backupRoot)
	return root
end

local function isRobloxNoise(script)
	if CONFIG.DUMP_ALL_SCRIPTS then
		return false
	end
	local path = script:GetFullName():gsub('/', '.')
	if path:find('CorePackages%.', 1, true) then
		return true
	end
	if path:find('CoreGui%.', 1, true) then
		return true
	end
	if not CONFIG.INCLUDE_PLAYER_MODULE and path:find('PlayerModule', 1, true) then
		return true
	end
	if not CONFIG.INCLUDE_CHARACTER_SCRIPTS and path:find('Players%.[^%.]+%.Character%.', 1, true) then
		return true
	end
	return false
end

local function gatherLiveScripts()
	local seen = {}
	local scripts = {}
	local coreGui = game.CoreGui
	local corePackages = game.CorePackages

	local function addScript(script)
		if not SCRIPT_CLASSES[script.ClassName] then
			return
		end
		if script:IsDescendantOf(coreGui) or script:IsDescendantOf(corePackages) then
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

	for _, fnName in { 'getnilinstances', 'getscripts', 'getrunningscripts', 'getloadedmodules' } do
		local fn = _G[fnName]
		if type(fn) ~= 'function' then
			continue
		end
		local ok, list = pcall(fn)
		if not ok or type(list) ~= 'table' then
			continue
		end
		for _, item in list do
			if typeof(item) == 'Instance' then
				if item.ClassName == 'ModuleScript' or SCRIPT_CLASSES[item.ClassName] then
					addScript(item)
				else
					walk(item)
				end
			end
		end
	end

	if type(gethui) == 'function' then
		local ok, hui = pcall(gethui)
		if ok and typeof(hui) == 'Instance' then
			walk(hui)
		end
	end

	table.sort(scripts, function(a, b)
		return a:GetFullName() < b:GetFullName()
	end)
	return scripts
end

local function gatherGcModuleScripts()
	local list = {}
	local seenBc = {}
	if type(getgc) ~= 'function' then
		return list
	end
	local ok, gc = pcall(getgc, true)
	if not ok or type(gc) ~= 'table' then
		return list
	end
	for _, obj in gc do
		if typeof(obj) ~= 'Instance' or obj.ClassName ~= 'ModuleScript' then
			continue
		end
		if type(getscriptbytecode) ~= 'function' then
			table.insert(list, obj)
			continue
		end
		local bcOk, bc = pcall(getscriptbytecode, obj)
		if bcOk and type(bc) == 'string' and #bc > 0 then
			local key = tostring(#bc) .. ':' .. bc:sub(1, 24)
			if not seenBc[key] then
				seenBc[key] = true
				table.insert(list, obj)
			end
		else
			table.insert(list, obj)
		end
	end
	return list
end

local function buildSourcePathIndex()
	local paths = {}
	if type(getgc) ~= 'function' then
		return paths
	end
	local ok, gc = pcall(getgc, true)
	if not ok then
		return paths
	end
	for _, obj in gc do
		if type(obj) ~= 'function' then
			continue
		end
		local srcOk, src = pcall(debug.info, obj, 's')
		if srcOk and type(src) == 'string' then
			local subfolder = src:match('^ReplicatedStorage%.(%w+)%.')
			if subfolder == 'Shared' or subfolder == 'Client' then
				paths[src] = (paths[src] or 0) + 1
			end
		end
	end
	return paths
end

local function snapshotRsModulesEarly()
	local rs = game:GetService('ReplicatedStorage')
	local jobs = {}
	local usedPaths = {}
	for _, folderName in { 'Client', 'Shared' } do
		local folder = rs:FindFirstChild(folderName)
		if not folder then
			continue
		end
		for _, desc in folder:GetDescendants() do
			if desc.ClassName ~= 'ModuleScript' then
				continue
			end
			local sub = folderName == 'Shared' and 'scripts_shared' or 'scripts_client'
			local rel = sub .. '/' .. sanitizeName(desc.Name) .. '.ModuleScript.lua'
			if usedPaths[rel] then
				continue
			end
			usedPaths[rel] = true
			table.insert(jobs, {
				script = desc,
				rel = rel,
				fullName = desc:GetFullName(),
				recovered = true,
				recoveredPath = desc:GetFullName(),
			})
		end
	end
	return jobs
end

local function bytecodeToHex(data)
	return (data:gsub('.', function(c)
		return string.format('%02x', string.byte(c))
	end))
end

local function formatHeader(script, recoveredPath)
	local fullName = 'unknown'
	pcall(function()
		fullName = script:GetFullName()
	end)
	if recoveredPath then
		fullName = recoveredPath
	end
	return string.format(
		'-- Decompiled from: %s\n-- Class: %s\n-- Place: %s (%s)\n-- JobId: %s\n-- Recovered: %s\n\n',
		fullName,
		script.ClassName,
		game.Name,
		tostring(game.PlaceId),
		game.JobId,
		tostring(recoveredPath ~= nil)
	)
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
	if lower:find('failed to decompile', 1, true) then
		return false, src
	end
	return true, src
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

local function guessRecoveredModuleName(source)
	local bestName, bestFolder, bestScore = nil, 'scripts_recovered', 0
	for _, sig in MODULE_SIGNATURES do
		local score = sig.score(source)
		if score > bestScore then
			bestScore = score
			bestName = sig.name
			bestFolder = 'scripts_' .. sig.folder
		end
	end
	if bestName and bestScore >= 4 then
		return bestFolder, bestName
	end
	return nil, nil
end

local function buildScriptRelPath(script, subfolder, usedPaths, forcedName)
	local dirParts = {}
	local current = script.Parent
	while current and current ~= game do
		local partName = current.Name
		if partName ~= '' then
			table.insert(dirParts, 1, sanitizeName(partName))
		end
		current = current.Parent
	end
	local baseName = forcedName or sanitizeName(script.Name)
	if baseName == 'Unnamed' or baseName == '' then
		baseName = 'Module'
	end
	local fileName = baseName .. '.ModuleScript.lua'
	local dirPath = table.concat(dirParts, '/')
	local rel = subfolder .. '/' .. (dirPath == '' and fileName or (dirPath .. '/' .. fileName))
	local suffix = 1
	while usedPaths[rel] do
		suffix += 1
		fileName = baseName .. '_' .. suffix .. '.ModuleScript.lua'
		rel = subfolder .. '/' .. (dirPath == '' and fileName or (dirPath .. '/' .. fileName))
	end
	usedPaths[rel] = true
	return rel
end

local function processScriptJob(job, stats, usedPaths)
	local script = job.script
	local entry = {
		fullName = job.fullName or 'unknown',
		output = job.rel,
		status = 'failed',
		recovered = job.recovered or false,
		recoveredPath = job.recoveredPath,
	}

	local decompOk, decompSrc = tryDecompile(script)
	if decompOk then
		local normalized = decompSrc:gsub('\r\n', '\n'):gsub('\r', '\n')
		local text = formatHeader(script, job.recoveredPath) .. normalized
		if not text:match('\n$') then
			text ..= '\n'
		end
		writeText(job.rel, text)
		entry.status = 'decompiled'
		stats.decompiled += 1

		if job.recovered and not job.recoveredPath then
			local folder, guessed = guessRecoveredModuleName(normalized)
			if folder and guessed then
				local guessRel = folder .. '/' .. sanitizeName(guessed) .. '.ModuleScript.lua'
				if not usedPaths[guessRel] then
					usedPaths[guessRel] = true
					writeText(guessRel, text)
					entry.guessedName = guessed
					entry.guessOutput = guessRel
				end
			end
		end
	else
		entry.decompileError = decompSrc
		local bcOk, bc, bcErr = tryBytecode(script)
		if bcOk then
			local hexPath = job.rel:gsub('^scripts', 'bytecode'):gsub('^scripts_', 'bytecode/'):gsub('.lua$', '.hex.txt')
			local header = string.format(
				'-- Bytecode dump\n-- Script: %s\n-- Size: %d\n-- Error: %s\n\n',
				entry.fullName,
				#bc,
				tostring(decompSrc):gsub('\n', ' ')
			)
			writeText(hexPath, header .. bytecodeToHex(bc))
			entry.status = 'bytecode'
			entry.bytecode = hexPath
			stats.bytecode += 1
		else
			entry.bytecodeError = bcErr
			stats.failed += 1
		end
	end

	if job.recovered then
		table.insert(manifest.recovered, entry)
	else
		table.insert(manifest.scripts, entry)
	end
end

local function dumpAllScriptJobs(jobs)
	local stats = {
		found = #jobs,
		decompiled = 0,
		bytecode = 0,
		failed = 0,
	}
	local usedPaths = {}
	for i, job in jobs do
		processScriptJob(job, stats, usedPaths)
		if i % CONFIG.PROGRESS_EVERY_N == 0 or i == #jobs then
			log(string.format('Decompiled %d/%d (ok=%d bytecode=%d failed=%d)', i, #jobs, stats.decompiled, stats.bytecode, stats.failed))
			task.wait()
		end
	end
	return stats
end

local function waitForEngine()
	if not CONFIG.WAIT_FOR_ENGINE then
		return
	end
	log('Waiting for custom engine bootstrap (_G.obtain cleared + ContextManager in gc)...')
	local deadline = tick() + CONFIG.ENGINE_TIMEOUT
	while tick() < deadline do
		local obtainGone = _G.obtain == nil
		local hasContext = false
		if type(getgc) == 'function' then
			local ok, gc = pcall(getgc, true)
			if ok then
				for _, obj in gc do
					if type(obj) == 'table' and type(obj.GetContext) == 'function' and type(obj.Contexts) == 'table' then
						hasContext = true
						break
					end
				end
			end
		end
		if obtainGone and hasContext then
			log('Engine ready')
			task.wait(CONFIG.POST_LOAD_DELAY)
			return true
		end
		task.wait(0.5)
	end
	warnLog('Engine wait timed out — dumping anyway')
	return false
end

local function dumpSourcePathIndex(paths)
	local lines = { '# debug.info source paths (ReplicatedStorage Client/Shared modules)', '' }
	local sorted = {}
	for path, count in paths do
		sorted[#sorted + 1] = { path = path, count = count }
	end
	table.sort(sorted, function(a, b)
		return a.path < b.path
	end)
	for _, item in sorted do
		lines[#lines + 1] = string.format('%s\tfunctions=%d', item.path, item.count)
	end
	writeText('manifest/source_paths.txt', table.concat(lines, '\n') .. '\n')
	manifest.stats.sourcePaths = #sorted
end

local function dumpRemotes()
	local lines = { '# Remote inventory', '# place=' .. tostring(game.PlaceId), '' }
	for _, inst in game:GetDescendants() do
		if inst.ClassName == 'RemoteEvent' or inst.ClassName == 'RemoteFunction' or inst.ClassName == 'UnreliableRemoteEvent' then
			lines[#lines + 1] = inst.ClassName .. '\t' .. inst:GetFullName()
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
		lines[#lines + 1] = string.format('%s\tcount=%d', tag, #collectionService:GetTagged(tag))
	end
	writeText('manifest/collection_tags.txt', table.concat(lines, '\n') .. '\n')
	manifest.stats.tags = #tags
end

local function collectRuntimeEngine()
	local data = {
		contextManager = nil,
		view = nil,
		rootTimer = nil,
		playbackContexts = {},
		realtimeContexts = {},
		simulations = {},
		gameMechanics = {},
		styles = nil,
	}
	if type(getgc) ~= 'function' then
		return data
	end
	local ok, gc = pcall(getgc, true)
	if not ok then
		return data
	end

	local lplr = playersService.LocalPlayer

	for _, obj in gc do
		if type(obj) ~= 'table' then
			continue
		end

		if not data.contextManager and type(obj.GetContext) == 'function' and type(obj.Contexts) == 'table' then
			data.contextManager = obj
		end

		if not data.view and type(obj.PlaybackContext) == 'table' then
			local player = obj.Player
			if player == 'Local' or player == lplr or player == (lplr and lplr.Name) then
				data.view = obj
			end
		end

		if type(obj.Time) == 'function' and type(obj.Scale) == 'number' and type(obj.GetScale) == 'function' then
			data.rootTimer = obj
		end

		if type(obj.GetPV) == 'function' and type(obj.GetOutput) == 'function' and obj.Timer then
			table.insert(data.realtimeContexts, obj)
		end

		if type(obj.GameMechanics) == 'table' and obj.Phys and obj.Timer then
			table.insert(data.simulations, obj)
		end

		if type(obj.MaxSpeed) == 'number' and (type(obj.Accelerate) == 'number' or type(obj.SetStyle) == 'function') then
			table.insert(data.gameMechanics, obj)
		end

		if type(obj.GetStyleName) == 'function' and type(obj.GetStyleInfo) == 'function' then
			data.styles = obj
		end
	end

	if data.contextManager then
		for key, ctx in data.contextManager.Contexts do
			table.insert(data.playbackContexts, {
				key = tostring(key),
				hasContext = ctx and ctx.Context ~= nil,
				contextType = ctx and ctx.Context and typeof(ctx.Context) or 'nil',
			})
		end
	end

	return data
end

local function dumpTableFields(title, obj, keys)
	local lines = { '# ' .. title, '' }
	if type(obj) ~= 'table' then
		lines[#lines + 1] = '(not found)'
		return table.concat(lines, '\n') .. '\n'
	end
	for _, key in keys do
		local ok, val = pcall(function()
			return obj[key]
		end)
		if ok then
			lines[#lines + 1] = key .. '\t' .. valuePreview(val)
		end
	end
	return table.concat(lines, '\n') .. '\n'
end

local function dumpRuntimeEngine()
	if not CONFIG.DUMP_RUNTIME_ENGINE then
		return
	end
	log('Dumping live runtime engine state from getgc...')
	local rt = collectRuntimeEngine()
	manifest.runtime = {
		hasContextManager = rt.contextManager ~= nil,
		hasView = rt.view ~= nil,
		hasRootTimer = rt.rootTimer ~= nil,
		simulationCount = #rt.simulations,
		gameMechanicsCount = #rt.gameMechanics,
		realtimeContextCount = #rt.realtimeContexts,
		playbackContextCount = #rt.playbackContexts,
		hasStyles = rt.styles ~= nil,
	}

	writeText('runtime/context_manager.txt', dumpTableFields('ContextManager', rt.contextManager, {
		'Contexts',
	}))

	if rt.view then
		writeText('runtime/view.txt', dumpTableFields('View', rt.view, {
			'Player', 'PlaybackContext',
		}))
	end

	writeText('runtime/root_timer.txt', dumpTableFields('RootTimer', rt.rootTimer, {
		'Scale', 'SavedScale',
	}))

	local simLines = { '# Simulation tables found in gc', '' }
	for i, sim in rt.simulations do
		simLines[#simLines + 1] = string.format('## Simulation %d', i)
		simLines[#simLines + 1] = 'Timer\t' .. valuePreview(sim.Timer)
		simLines[#simLines + 1] = 'ShouldRun\t' .. valuePreview(sim.ShouldRun)
		if sim.GameMechanics then
			simLines[#simLines + 1] = 'GameMechanics.MaxSpeed\t' .. valuePreview(sim.GameMechanics.MaxSpeed)
			simLines[#simLines + 1] = 'GameMechanics.Accelerate\t' .. valuePreview(sim.GameMechanics.Accelerate)
			simLines[#simLines + 1] = 'GameMechanics.AirAccelerate\t' .. valuePreview(sim.GameMechanics.AirAccelerate)
			simLines[#simLines + 1] = 'GameMechanics.Gravity\t' .. valuePreview(sim.GameMechanics.Gravity)
			simLines[#simLines + 1] = 'GameMechanics.Style\t' .. valuePreview(sim.GameMechanics.Style)
		end
		if sim.Phys then
			simLines[#simLines + 1] = 'Phys.Time\t' .. valuePreview(sim.Phys.Time)
			simLines[#simLines + 1] = 'Phys.Position\t' .. valuePreview(sim.Phys.Position)
			pcall(function()
				local pos, vel = sim.Phys.Position, sim.Phys.Velocity
				simLines[#simLines + 1] = 'Phys.Velocity\t' .. valuePreview(vel)
			end)
		end
		simLines[#simLines + 1] = ''
	end
	writeText('runtime/simulations.txt', table.concat(simLines, '\n') .. '\n')

	local mechLines = { '# GameMechanics tables (all gc hits)', '' }
	for i, mech in rt.gameMechanics do
		mechLines[#mechLines + 1] = string.format('## GameMechanics %d', i)
		for _, key in {
			'MaxSpeed', 'Accelerate', 'AirAccelerate', 'Gravity', 'Friction',
			'StopSpeed', 'Style', 'sv_airaccelerate', 'sv_accelerate', 'sv_maxspeed',
		} do
			local ok, val = pcall(function()
				return mech[key]
			end)
			if ok and val ~= nil then
				mechLines[#mechLines + 1] = key .. '\t' .. valuePreview(val)
			end
		end
		mechLines[#mechLines + 1] = ''
	end
	writeText('runtime/game_mechanics.txt', table.concat(mechLines, '\n') .. '\n')

	local ctxLines = { '# RealtimeContext tables', '' }
	for i, ctx in rt.realtimeContexts do
		ctxLines[#ctxLines + 1] = string.format('## RealtimeContext %d', i)
		ctxLines[#ctxLines + 1] = 'Timer\t' .. valuePreview(ctx.Timer)
		ctxLines[#ctxLines + 1] = 'SmoothingSimulation\t' .. valuePreview(ctx.SmoothingSimulation)
		pcall(function()
			local pos, vel = ctx:GetPV()
			ctxLines[#ctxLines + 1] = 'GetPV.pos\t' .. valuePreview(pos)
			ctxLines[#ctxLines + 1] = 'GetPV.vel\t' .. valuePreview(vel)
		end)
		ctxLines[#ctxLines + 1] = ''
	end
	writeText('runtime/realtime_contexts.txt', table.concat(ctxLines, '\n') .. '\n')

	local pcLines = { '# ContextManager.Contexts keys', '' }
	for _, item in rt.playbackContexts do
		pcLines[#pcLines + 1] = item.key .. '\thasContext=' .. tostring(item.hasContext) .. '\ttype=' .. item.contextType
	end
	writeText('runtime/playback_contexts.txt', table.concat(pcLines, '\n') .. '\n')

	if rt.rootTimer and rt.view and rt.view.PlaybackContext and rt.view.PlaybackContext.Context then
		local liveCtx = rt.view.PlaybackContext.Context
		local matchLines = { '# Timer identity check (which Simulation uses live RootTimer)', '' }
		matchLines[#matchLines + 1] = 'liveCtx.Timer\t' .. valuePreview(liveCtx.Timer)
		matchLines[#matchLines + 1] = 'rootTimer\t' .. valuePreview(rt.rootTimer)
		matchLines[#matchLines + 1] = 'sameReference\t' .. tostring(liveCtx.Timer == rt.rootTimer)
		for i, sim in rt.simulations do
			matchLines[#matchLines + 1] = string.format('simulation[%d].Timer matches live\t%s', i, tostring(sim.Timer == rt.rootTimer))
		end
		writeText('runtime/timer_identity.txt', table.concat(matchLines, '\n') .. '\n')
	end

	if rt.styles then
		writeText('runtime/styles.txt', dumpTableFields('Styles module export', rt.styles, {
			'GetStyleName', 'GetStyleInfo',
		}))
	end

	writeText('manifest/runtime_engine.txt', jsonEncode(manifest.runtime) or table.concat({
		'hasContextManager=' .. tostring(manifest.runtime.hasContextManager),
		'hasRootTimer=' .. tostring(manifest.runtime.hasRootTimer),
		'simulations=' .. tostring(manifest.runtime.simulationCount),
		'gameMechanics=' .. tostring(manifest.runtime.gameMechanicsCount),
	}, '\n') .. '\n')
end

local function resolveRecoveredRel(script, usedPaths, sourcePaths)
	local recoveredPath = nil
	local folder = 'scripts_recovered'
	local baseName = nil

	pcall(function()
		local full = script:GetFullName()
		local sub, name = full:match('^ReplicatedStorage%.(%w+)%.(.+)$')
		if sub == 'Shared' then
			folder = 'scripts_shared'
			recoveredPath = full
			baseName = name
		elseif sub == 'Client' then
			folder = 'scripts_client'
			recoveredPath = full
			baseName = name
		end
	end)

	if not baseName and sourcePaths and type(getscriptbytecode) == 'function' then
		local bcOk, bc = pcall(getscriptbytecode, script)
		if bcOk and type(bc) == 'string' then
			baseName = 'bc_' .. tostring(#bc)
		end
	end

	return buildScriptRelPath(script, folder, usedPaths, baseName and sanitizeName(baseName) or nil), recoveredPath
end

local function buildRecoveredJobs(sourcePaths)
	local jobs = {}
	local usedPaths = {}
	local gcModules = gatherGcModuleScripts()
	local liveScripts = gatherLiveScripts()
	local liveSet = {}
	for _, script in liveScripts do
		liveSet[script] = true
	end

	for _, script in gcModules do
		if liveSet[script] then
			continue
		end
		local rel, recoveredPath = resolveRecoveredRel(script, usedPaths, sourcePaths)
		table.insert(jobs, {
			script = script,
			rel = rel,
			fullName = recoveredPath or ('gc:ModuleScript:' .. tostring(script)),
			recovered = true,
			recoveredPath = recoveredPath,
		})
	end

	local pathCount = 0
	for _ in sourcePaths do
		pathCount += 1
	end
	writeText('manifest/recovered_modules.txt', table.concat({
		'# Recovered ModuleScript instances from getgc()',
		'# total=' .. #jobs,
		'# source_paths_in_memory=' .. pathCount,
		'',
		'Priority files for Speed Boost RE:',
		'  scripts_shared/Simulation.ModuleScript.lua',
		'  scripts_shared/GameMechanics.ModuleScript.lua',
		'  scripts_shared/Physics.ModuleScript.lua',
		'  scripts_shared/RealtimeTimerSystem.ModuleScript.lua',
		'  scripts_client/RealtimeContext.ModuleScript.lua',
		'  scripts_client/SimulationSynchronization.ModuleScript.lua',
		'',
		'See manifest/source_paths.txt for all debug.info module paths still in memory.',
		'See runtime/ for live singleton snapshots (run on a map before dumping).',
		'',
	}, '\n'))

	return jobs
end

local function writeSummary(liveStats, recoveredStats)
	manifest.finishedAt = os.date('!%Y-%m-%dT%H:%M:%SZ')
	local json = jsonEncode(manifest)
	if json then
		writeText('manifest/index.json', json)
	end
	local summary = {
		'UGC 5315066937 Full Engine Dump',
		'place=' .. tostring(manifest.placeId) .. ' (' .. manifest.placeName .. ')',
		'job=' .. game.JobId,
		'root=' .. dumpRoot,
		'backup=' .. backupRoot,
		'started=' .. manifest.startedAt,
		'finished=' .. manifest.finishedAt,
		'',
		'IMPORTANT: Load a map and start moving before dumping for runtime/ snapshots.',
		'Engine modules live in scripts_shared/ (Simulation, GameMechanics, Physics, …).',
		'Wiring/UI modules live in scripts/.',
		'',
		'live_scripts:',
		'  found=' .. liveStats.found,
		'  decompiled=' .. liveStats.decompiled,
		'  bytecode=' .. liveStats.bytecode,
		'  failed=' .. liveStats.failed,
		'recovered_modules:',
		'  found=' .. recoveredStats.found,
		'  decompiled=' .. recoveredStats.decompiled,
		'  bytecode=' .. recoveredStats.bytecode,
		'  failed=' .. recoveredStats.failed,
	}
	for k, v in manifest.stats do
		summary[#summary + 1] = k .. '=' .. tostring(v)
	end
	if manifest.runtime then
		summary[#summary + 1] = ''
		summary[#summary + 1] = 'runtime:'
		for k, v in manifest.runtime do
			summary[#summary + 1] = '  ' .. k .. '=' .. tostring(v)
		end
	end
	writeText('manifest/SUMMARY.txt', table.concat(summary, '\n') .. '\n')
end

local function runDump()
	if not hasFileApi() then
		error('writefile/makefolder/isfolder required')
	end
	if game.PlaceId ~= TARGET_PLACE_ID then
		warnLog('PlaceId is', game.PlaceId, '— dumper tuned for', TARGET_PLACE_ID, 'but continuing anyway')
	end
	if type(getgc) ~= 'function' then
		error('getgc(true) required to recover destroyed Client/Shared modules')
	end
	if type(decompile) ~= 'function' and type(getscriptbytecode) ~= 'function' then
		error('Need decompile or getscriptbytecode')
	end

	dumpRoot = buildDumpRoot()
	log('Output:', dumpRoot)
	log('Backup manifest:', backupRoot)

	-- If Client/Shared still exist (run before Load finishes), snapshot them immediately
	local earlyJobs = snapshotRsModulesEarly()
	if #earlyJobs > 0 then
		log('Early snapshot: ReplicatedStorage Client/Shared still present — dumping', #earlyJobs, 'modules first')
		dumpAllScriptJobs(earlyJobs)
	end

	waitForEngine()

	local sourcePaths = buildSourcePathIndex()
	if CONFIG.DUMP_SOURCE_PATH_INDEX then
		dumpSourcePathIndex(sourcePaths)
	end

	log('Gathering live scripts...')
	local liveScripts = gatherLiveScripts()
	local liveJobs = {}
	local usedLive = {}
	for _, script in liveScripts do
		table.insert(liveJobs, {
			script = script,
			rel = buildScriptRelPath(script, 'scripts', usedLive),
			fullName = script:GetFullName(),
			recovered = false,
		})
	end
	log('Live scripts:', #liveJobs)

	local recoveredJobs = {}
	if CONFIG.RECOVER_DESTROYED_MODULES then
		log('Recovering destroyed Client/Shared ModuleScripts from getgc...')
		recoveredJobs = buildRecoveredJobs(sourcePaths)
		log('Recovered ModuleScripts:', #recoveredJobs)
	end

	if CONFIG.DUMP_REMOTES then
		dumpRemotes()
	end
	if CONFIG.DUMP_TAGS then
		dumpTags()
	end

	dumpRuntimeEngine()

	log('Decompiling live scripts...')
	local liveStats = dumpAllScriptJobs(liveJobs)

	log('Decompiling recovered modules (this may take several minutes)...')
	local recoveredStats = { found = #recoveredJobs, decompiled = 0, bytecode = 0, failed = 0 }
	if #recoveredJobs > 0 then
		recoveredStats = dumpAllScriptJobs(recoveredJobs)
	end

	manifest.stats.live = liveStats
	manifest.stats.recovered = recoveredStats
	writeSummary(liveStats, recoveredStats)

	log('Done.')
	log('Primary output:', dumpRoot)
	log('Copy this folder into the repo decompiled games/ directory if needed.')
	log('Check scripts_shared/Simulation.ModuleScript.lua and scripts_shared/GameMechanics.ModuleScript.lua')
end

pcall(runDump)
