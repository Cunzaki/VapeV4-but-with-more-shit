--[[
	UGC 5315066937 — Full Engine Dumper (standalone)

	This place destroys ReplicatedStorage.Client / Shared after Load.ModuleScript runs.
	The universal dumper only captures ~50 wiring scripts; the physics engine lives in
	destroyed Shared modules (Simulation, GameMechanics, Physics, RealtimeContext, …).

	This dumper:
	  1. Waits for the custom engine to finish bootstrapping
	  2. Decompiles all live Instance scripts (wiring/UI)
	  3. Recovers destroyed Client/Shared ModuleScripts from getgc()
	  4. Names modules via getscriptclosure, obtain() hook, debug.info paths, and signatures
	  5. Reconciles canonical paths and writes manifest/debug/ (full debug.info index + capabilities)

	AUTOEXECUTE (recommended — put this file in your executor autoexec folder):
		Runs automatically on join to place 5315066937. Writes to executor workspace immediately.

	Manual:
		loadstring(readfile('tools/ugc5315066937_full_dumper.lua'), 'ugc531_full')()

	Output (executor workspace):
		decompiled games/Ugc_5315066937_<timestamp>/
			scripts/           wiring modules still parented in game
			scripts_client/    recovered ReplicatedStorage.Client.*
			scripts_shared/    recovered ReplicatedStorage.Shared.*  (Simulation, GameMechanics, …)
			scripts_deobf/     deobfuscated copies when obfuscation detected
			bytecode/          hex fallback when decompile fails
			manifest/          indexes, remotes, runtime engine snapshots
			runtime/           detailed singleton / simulation introspection

	Requires: writefile, makefolder, isfolder, getgc, decompile or getscriptbytecode
	Optional: getscriptclosure, getloadedmodules, getscripts, getnilinstances, getrunningscripts, gethui
]]

local TARGET_PLACE_ID = 5315066937

local CONFIG = {
	AUTOEXECUTE = true, -- set false to require manual loadstring
	ONLY_THIS_PLACE = true, -- skip autoexec on other places
	OUTPUT_ROOT = 'decompiled games',
	BACKUP_ROOT = 'game_dumps', -- secondary copy of manifest + stats
	INITIAL_LOAD_WAIT = 15, -- wait after join so RS Client/Shared replicate before Load destroys them
	WAIT_FOR_ENGINE = true,
	ENGINE_TIMEOUT = 60,
	RS_WAIT_TIMEOUT = 60,
	POST_LOAD_DELAY = 2,
	POLL_INTERVAL = 0.5,
	PROGRESS_EVERY_N = 3,
	GC_SCAN_YIELD_EVERY = 150,
	MAX_RECOVERED_MODULES = 0, -- 0 = no cap; dump every matching module
	GC_RESCAN_PASSES = 2, -- rescan getgc after bootstrap; modules can appear late
	HOOK_OBTAIN = true, -- capture Client/Shared modules as Load.require runs
	MAP_SOURCE_PATHS = true, -- name files via getscriptclosure + debug.info
	MAP_BY_MODULE_NAME = true, -- match RS modules when script.Name matches a live source path
	RECONCILE_CANONICAL = true, -- second pass writes canonical paths for mapped but unnamed dumps
	DUMP_DEBUG_INDEX = true, -- manifest/debug/ — full debug.info source path inventory
	DUMP_EXECUTOR_CAPS = true, -- manifest/debug/capabilities.txt
	MIRROR_WIRING_PATHS = true, -- also write scripts/PlayerScripts/Main/Load/<Name>.lua
	LINK_COVERAGE_BY_NAME = true, -- coverage OK if scripts_recovered/<Name> exists
	FINAL_GC_RESCAN = true, -- rescan debug.info + reconcile after main decompile pass
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
		if src:find('CreateStyleInfo', 1, true) then s += 4 end
		if src:find('StyleInfo', 1, true) then s += 2 end
		if src:find('fly_speed', 1, true) then s += 2 end
		if src:find('TICKINFO_BIT', 1, true) then s += 2 end
		if src:find('SetNextControls', 1, true) then s += 3 end
		if src:find('MaxSpeed', 1, true) then s += 3 end
		if src:find('SetStyle', 1, true) then s += 1 end
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
		if src:find('LoadModeStyleList', 1, true) then s += 5 end
		if src:find('tickrate', 1, true) then s += 2 end
		if src:find('StyleInfo', 1, true) then s += 2 end
		if src:find('mv = 2.7', 1, true) then s += 3 end
		return s
	end },
	{ folder = 'shared', name = 'SimulationDirector', score = function(src)
		local s = 0
		if src:find('HandleControl', 1, true) then s += 2 end
		if src:find('InputHandlers', 1, true) then s += 2 end
		if src:find('FlagInProgressRuns', 1, true) then s += 3 end
		return s
	end },
	{ folder = 'shared', name = 'World', score = function(src)
		local s = 0
		if src:find('LoadWorld', 1, true) then s += 2 end
		if src:find('WorldCache', 1, true) then s += 2 end
		if src:find('ObjectRecognition', 1, true) then s += 2 end
		return s
	end },
	{ folder = 'client', name = 'View', score = function(src)
		local s = 0
		if src:find('PlaybackContext', 1, true) then s += 3 end
		if src:find('VisibilityManager', 1, true) then s += 2 end
		if src:find('RenderManager', 1, true) then s += 2 end
		return s
	end },
	{ folder = 'client', name = 'SimulationControl', score = function(src)
		local s = 0
		if src:find('SimulationDirector', 1, true) then s += 2 end
		if src:find('Hotkey', 1, true) then s += 2 end
		if src:find('LoadState', 1, true) then s += 2 end
		return s
	end },
	{ folder = 'client', name = 'Remote', score = function(src)
		local s = 0
		if src:find(':Call%(', 1, false) then s += 1 end
		if src:find('NetworkChannel', 1, true) then s += 2 end
		if src:find('Remote%.Call', 1, true) then s += 3 end
		return s
	end },
	{ folder = 'client', name = 'QBox', score = function(src)
		local s = 0
		if src:find('FreeMouse', 1, true) then s += 3 end
		if src:find('roblox_messing_with_guis_factor', 1, true) then s += 5 end
		return s
	end },
	{ folder = 'shared', name = 'Timers', score = function(src)
		local s = 0
		if src:find('GetGlobalScale', 1, true) then s += 4 end
		if src:find('function v3.SetScale', 1, true) then s += 3 end
		if src:find('SavedScale', 1, true) then s += 2 end
		return s
	end },
	{ folder = 'client', name = 'PlaybackContext', score = function(src)
		local s = 0
		if src:find('StyleInfo', 1, true) and src:find('MapOffset', 1, true) then s += 4 end
		if src:find('HandleControl', 1, true) and src:find('Runs', 1, true) then s += 3 end
		return s
	end },
	{ folder = 'shared', name = 'World', score = function(src)
		local s = 0
		if src:find('UpdateDynamicVisible', 1, true) then s += 3 end
		if src:find('ReferenceWorld', 1, true) then s += 3 end
		if src:find('LoadWorld', 1, true) then s += 1 end
		return s
	end },
	{ folder = 'client', name = 'Remote', score = function(src)
		local s = 0
		if src:find('NetworkChannel', 1, true) then s += 2 end
		if src:find('Add%(', 1, false) and src:find('SimulationFailed', 1, true) then s += 3 end
		return s
	end },
}

local httpService = game:GetService('HttpService')
local collectionService = game:GetService('CollectionService')
local playersService = game:GetService('Players')

local dumpRoot = ''
local backupRoot = ''
local dumpState = {
	rsCaptured = {},
	rsCapturedCount = 0,
	bootstrapLog = {},
	startedAt = tick(),
	gcCache = nil,
	gcCacheAt = 0,
	scriptSourceCache = {},
	sourceByScript = {},
	moduleBySource = {},
	obtainCaptured = {},
	obtainHooked = false,
	obtainLog = {},
	pendingCaptures = {},
	knownSourcePaths = {},
	sourcePathByModuleName = {},
	writtenRelPaths = {},
}
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
	if dumpRoot == '' then
		return false
	end
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

local function appendBootstrapLog(line)
	table.insert(dumpState.bootstrapLog, os.date('%H:%M:%S') .. ' ' .. line)
	writeText('manifest/bootstrap_log.txt', table.concat(dumpState.bootstrapLog, '\n') .. '\n')
end

local function writeStatus(phase, detail)
	local text = string.format(
		'phase=%s\nplace=%s\njob=%s\nroot=%s\nelapsed=%.1fs\nrsCaptured=%d\nobtain=%s\ndetail=%s\n',
		phase,
		tostring(game.PlaceId),
		game.JobId,
		dumpRoot,
		tick() - dumpState.startedAt,
		dumpState.rsCapturedCount,
		tostring(_G.obtain),
		tostring(detail or '')
	)
	writeText('manifest/status.txt', text)
	appendBootstrapLog(phase .. (detail and (': ' .. detail) or ''))
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

	local lplr = playersService.LocalPlayer
	if lplr then
		for _, rootName in { 'PlayerGui', 'PlayerScripts', 'Backpack' } do
			local root = lplr:FindFirstChild(rootName)
			if root then
				walk(root)
			end
		end
	end
	for _, svcName in { 'StarterGui', 'ReplicatedFirst' } do
		local svc = game:GetService(svcName)
		if svc then
			walk(svc)
		end
	end

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

local function getGcCache()
	local now = tick()
	if dumpState.gcCache and now - dumpState.gcCacheAt < 30 then
		return dumpState.gcCache
	end
	if type(getgc) ~= 'function' then
		return {}
	end
	log('Scanning getgc(true)...')
	local ok, gc = pcall(getgc, true)
	if not ok or type(gc) ~= 'table' then
		return {}
	end
	dumpState.gcCache = gc
	dumpState.gcCacheAt = now
	appendBootstrapLog('getgc count=' .. tostring(#gc))
	return gc
end

local function invalidateGcCache()
	dumpState.gcCache = nil
	dumpState.gcCacheAt = 0
end

local function indexKnownSourcePaths(sourcePaths)
	dumpState.knownSourcePaths = {}
	dumpState.sourcePathByModuleName = {}
	for src in sourcePaths do
		dumpState.knownSourcePaths[src] = true
		local sub, name = src:match('^ReplicatedStorage%.(Client|Shared)%.(.+)$')
		if sub and name then
			local short = name:match('([^%.]+)$') or name
			local bucket = dumpState.sourcePathByModuleName[short]
			if not bucket then
				bucket = {}
				dumpState.sourcePathByModuleName[short] = bucket
			end
			bucket[#bucket + 1] = src
		end
	end
end

local function getModuleSourcePath(script)
	if dumpState.scriptSourceCache[script] ~= nil then
		return dumpState.scriptSourceCache[script]
	end
	local src = nil
	if typeof(script) == 'Instance' and type(getscriptclosure) == 'function' then
		local ok, fn = pcall(getscriptclosure, script)
		if ok and type(fn) == 'function' then
			local sOk, s = pcall(debug.info, fn, 's')
			if sOk and type(s) == 'string' and #s > 0 then
				src = s
			end
		end
	end
	dumpState.scriptSourceCache[script] = src or false
	return src
end

local function isIgnoredSourcePath(sourcePath)
	if not sourcePath or sourcePath == '' then
		return true
	end
	if sourcePath:find('CorePackages', 1, true) then
		return true
	end
	if sourcePath:find('CoreGui', 1, true) then
		return true
	end
	if not CONFIG.INCLUDE_PLAYER_MODULE and sourcePath:find('PlayerModule', 1, true) then
		return true
	end
	if sourcePath:find('RbxCharacterSounds', 1, true) then
		return true
	end
	if sourcePath:find('AtomicBinding', 1, true) then
		return true
	end
	return false
end

local function sourcePathToRel(sourcePath, usedPaths)
	if not sourcePath or isIgnoredSourcePath(sourcePath) then
		return nil, nil
	end
	local sub, name = sourcePath:match('^ReplicatedStorage%.(Client|Shared)%.(.+)$')
	if sub and name then
		local folder = sub == 'Shared' and 'scripts_shared' or 'scripts_client'
		local rel = folder .. '/' .. sanitizeName(name) .. '.ModuleScript.lua'
		if usedPaths[rel] then
			return nil, sourcePath
		end
		usedPaths[rel] = true
		return rel, sourcePath
	end
	if sourcePath:find('^Players%.', 1, false) or sourcePath:find('StarterPlayer', 1, true) or sourcePath:find('PlayerGui', 1, true) then
		local relParts = {}
		for part in sourcePath:gmatch('[^%.]+') do
			if part ~= 'Players' and not part:match('^%d+$') and part ~= 'LocalPlayer' then
				relParts[#relParts + 1] = sanitizeName(part)
			end
		end
		local rel = 'scripts/' .. table.concat(relParts, '/') .. '.ModuleScript.lua'
		local suffix = 1
		while usedPaths[rel] do
			suffix += 1
			rel = 'scripts/' .. table.concat(relParts, '/') .. '_' .. suffix .. '.ModuleScript.lua'
		end
		usedPaths[rel] = true
		return rel, sourcePath
	end
	if sourcePath:find('StarterGui', 1, true) or sourcePath:find('ReplicatedFirst', 1, true) then
		local shortName = sourcePath:match('%.([^%.]+)$') or 'Module'
		local rel = 'scripts/' .. sanitizeName(shortName) .. '.ModuleScript.lua'
		local suffix = 1
		while usedPaths[rel] do
			suffix += 1
			rel = 'scripts/' .. sanitizeName(shortName) .. '_' .. suffix .. '.ModuleScript.lua'
		end
		usedPaths[rel] = true
		return rel, sourcePath
	end
	return nil, sourcePath
end

local function registerModuleSource(script, sourcePath)
	if not script or not sourcePath or isIgnoredSourcePath(sourcePath) then
		return
	end
	dumpState.sourceByScript[script] = sourcePath
	if not dumpState.moduleBySource[sourcePath] then
		dumpState.moduleBySource[sourcePath] = script
	end
end

local function resolveSourcePathForScript(script)
	local src = getModuleSourcePath(script) or dumpState.sourceByScript[script]
	if src then
		return src
	end
	if not CONFIG.MAP_BY_MODULE_NAME then
		return nil
	end
	local nameOk, name = pcall(function()
		return script.Name
	end)
	if not nameOk or type(name) ~= 'string' or name == '' then
		return nil
	end
	local bucket = dumpState.sourcePathByModuleName[name]
	if bucket and #bucket == 1 then
		return bucket[1]
	end
	for _, folder in { 'Client', 'Shared' } do
		local candidate = 'ReplicatedStorage.' .. folder .. '.' .. name
		if dumpState.knownSourcePaths[candidate] then
			return candidate
		end
	end
	return nil
end

local function canonicalRelForSourcePath(sourcePath, usedPaths)
	if not sourcePath or not CONFIG.MAP_SOURCE_PATHS then
		return nil
	end
	local rel = sourcePathToRel(sourcePath, usedPaths or {})
	return rel
end

local function findRsModuleInstance(moduleName)
	local rs = game:GetService('ReplicatedStorage')
	for _, folderName in { 'Client', 'Shared' } do
		local folder = rs:FindFirstChild(folderName)
		if not folder then
			continue
		end
		local direct = folder:FindFirstChild(moduleName)
		if direct and direct.ClassName == 'ModuleScript' then
			return direct, folderName
		end
		local nested = folder:FindFirstChild(moduleName, true)
		if nested and nested.ClassName == 'ModuleScript' then
			return nested, folderName
		end
	end
	return nil, nil
end

local function isRobloxEngineModule(script)
	local ok, full = pcall(function()
		return script:GetFullName()
	end)
	if ok and type(full) == 'string' then
		if full:find('CorePackages', 1, true) then
			return true
		end
		if full:find('CoreGui', 1, true) then
			return true
		end
		if not CONFIG.INCLUDE_PLAYER_MODULE and full:find('PlayerModule', 1, true) then
			return true
		end
		if full:find('Packages%.', 1, true) then
			return true
		end
	end
	return false
end

local function isGameModuleScript(script)
	if typeof(script) ~= 'Instance' or script.ClassName ~= 'ModuleScript' then
		return false
	end
	if isRobloxEngineModule(script) then
		return false
	end
	local src = getModuleSourcePath(script)
	if src and not isIgnoredSourcePath(src) then
		if src:match('^ReplicatedStorage%.(Client|Shared)%.') then
			return true
		end
		if src:find('^Players%.', 1, false) or src:find('StarterPlayer', 1, true) then
			return true
		end
	end
	local ok, full = pcall(function()
		return script:GetFullName()
	end)
	if ok and type(full) == 'string' then
		if full:find('ReplicatedStorage%.Shared%.', 1, true) then
			return true
		end
		if full:find('ReplicatedStorage%.Client%.', 1, true) then
			return true
		end
		if full:find('PlayerGui%.', 1, true) or full:find('PlayerScripts%.', 1, true) then
			return true
		end
	end
	local nameOk, name = pcall(function()
		return script.Name
	end)
	local parentOk, parent = pcall(function()
		return script.Parent
	end)
	if nameOk and name == '' and parentOk and parent == nil then
		return true
	end
	if nameOk and name ~= '' and parentOk and parent == nil and not isRobloxEngineModule(script) then
		return true
	end
	return false
end

local function isUgcEngineModule(script)
	return isGameModuleScript(script)
end

local function gatherGcModuleScripts()
	local list = {}
	local seen = {}
	local scanned = 0

	local function add(script)
		if seen[script] then
			return
		end
		if not isGameModuleScript(script) then
			return
		end
		local src = resolveSourcePathForScript(script)
		if src then
			registerModuleSource(script, src)
		end
		seen[script] = true
		table.insert(list, script)
	end

	if type(getloadedmodules) == 'function' then
		local ok, mods = pcall(getloadedmodules)
		if ok and type(mods) == 'table' then
			for _, mod in mods do
				if typeof(mod) == 'Instance' and mod.ClassName == 'ModuleScript' then
					add(mod)
				end
			end
		end
	end

	local gc = getGcCache()
	for i, obj in gc do
		scanned += 1
		if typeof(obj) == 'Instance' and obj.ClassName == 'ModuleScript' then
			add(obj)
		end
		if scanned % CONFIG.GC_SCAN_YIELD_EVERY == 0 then
			task.wait()
		end
		if CONFIG.MAX_RECOVERED_MODULES > 0 and #list >= CONFIG.MAX_RECOVERED_MODULES then
			break
		end
	end

	log('GC module scan:', scanned, 'gc entries,', #list, 'UGC modules')
	appendBootstrapLog('gcModules=' .. tostring(#list))
	return list
end

local function gatherGcModuleScriptsMultiPass()
	local merged = {}
	local seen = {}
	local passes = math.max(1, CONFIG.GC_RESCAN_PASSES or 1)
	for pass = 1, passes do
		if pass > 1 then
			log('GC rescan pass', pass, 'of', passes)
			invalidateGcCache()
			task.wait(0.5)
		end
		for _, script in gatherGcModuleScripts() do
			if not seen[script] then
				seen[script] = true
				table.insert(merged, script)
			end
		end
	end
	return merged
end

local function writeObtainLog()
	if #dumpState.obtainLog == 0 then
		return
	end
	local lines = { '# obtain() calls observed during Load', '' }
	for _, item in dumpState.obtainLog do
		lines[#lines + 1] = string.format(
			'%s\tfound=%s\tsource=%s',
			tostring(item.name),
			tostring(item.found),
			tostring(item.sourcePath or '')
		)
	end
	writeText('manifest/obtain_log.txt', table.concat(lines, '\n') .. '\n')
end

local function findWrittenRelForSourcePath(src)
	if not src then
		return nil
	end
	local check = {}
	local canonicalRel = sourcePathToRel(src, check)
	if canonicalRel and dumpState.writtenRelPaths[canonicalRel] then
		return canonicalRel
	end
	if not CONFIG.LINK_COVERAGE_BY_NAME then
		return nil
	end
	local short = src:match('%.([^%.]+)$')
	if not short then
		return nil
	end
	local safe = sanitizeName(short)
	local candidates = {
		'scripts/PlayerScripts/Main/Load/' .. safe .. '.ModuleScript.lua',
		'scripts_recovered/' .. safe .. '.ModuleScript.lua',
		'scripts_shared/' .. safe .. '.ModuleScript.lua',
		'scripts_client/' .. safe .. '.ModuleScript.lua',
		'scripts/' .. safe .. '.ModuleScript.lua',
	}
	for _, rel in candidates do
		if dumpState.writtenRelPaths[rel] then
			return rel
		end
	end
	return nil
end

local function mirrorWiringModule(shortName, text, job)
	if not CONFIG.MIRROR_WIRING_PATHS or not shortName or shortName == '' then
		return nil
	end
	if shortName:match('^Module_%d+$') or shortName == 'Unnamed' then
		return nil
	end
	if job then
		if job.rel and (job.rel:match('^scripts_shared/') or job.rel:match('^scripts_client/')) then
			return nil
		end
		if job.canonicalRel and (job.canonicalRel:match('^scripts_shared/') or job.canonicalRel:match('^scripts_client/')) then
			return nil
		end
	end
	local isWiring = false
	if job and job.sourcePath and job.sourcePath:find('Main%.Load%.', 1, false) then
		isWiring = true
	elseif job and job.rel and job.rel:match('^scripts_recovered/') then
		isWiring = true
	elseif job and job.fullName and job.fullName:find('Load%.', 1, false) then
		isWiring = true
	end
	if not isWiring then
		return nil
	end
	local rel = 'scripts/PlayerScripts/Main/Load/' .. sanitizeName(shortName) .. '.ModuleScript.lua'
	if dumpState.writtenRelPaths[rel] then
		return rel
	end
	writeText(rel, text)
	dumpState.writtenRelPaths[rel] = true
	return rel
end

local function dumpExecutorCapabilities()
	if not CONFIG.DUMP_EXECUTOR_CAPS then
		return
	end
	local caps = {
		'place=' .. tostring(game.PlaceId),
		'job=' .. game.JobId,
		'obtain=' .. tostring(_G.obtain),
		'',
	}
	local apis = {
		'writefile', 'readfile', 'isfile', 'isfolder', 'makefolder', 'listfiles',
		'getgc', 'getreg', 'getrenv', 'getgenv', 'gethui', 'getscripts', 'getrunningscripts',
		'getloadedmodules', 'getnilinstances', 'getscriptclosure', 'getscriptbytecode',
		'decompile', 'debug.info', 'hookfunction', 'restorefunction', 'clonefunction',
	}
	for _, name in apis do
		local val = _G[name]
		local status = type(val)
		if status == 'function' then
			status = 'yes'
		elseif val == nil then
			status = 'no'
		else
			status = type(val)
		end
		caps[#caps + 1] = name .. '=' .. status
	end
	if type(debug) == 'table' and type(debug.info) == 'function' then
		caps[#caps + 1] = ''
		caps[#caps + 1] = 'debug.info=available'
	end
	writeText('manifest/debug/capabilities.txt', table.concat(caps, '\n') .. '\n')
end

local function dumpFullDebugIndex()
	if not CONFIG.DUMP_DEBUG_INDEX or type(getgc) ~= 'function' then
		return
	end
	log('Building full debug.info source path index...')
	local paths = {}
	local scanned = 0
	local gc = getGcCache()
	for _, obj in gc do
		scanned += 1
		if type(obj) ~= 'function' then
			continue
		end
		local srcOk, src = pcall(debug.info, obj, 's')
		if srcOk and type(src) == 'string' and #src > 0 and not isIgnoredSourcePath(src) then
			paths[src] = (paths[src] or 0) + 1
		end
		if scanned % CONFIG.GC_SCAN_YIELD_EVERY == 0 then
			task.wait()
		end
	end
	local sorted = {}
	for path, count in paths do
		sorted[#sorted + 1] = { path = path, count = count }
	end
	table.sort(sorted, function(a, b)
		return a.path < b.path
	end)
	local lines = {
		'# full debug.info source paths from getgc(true) functions',
		'# scanned_functions=' .. scanned,
		'# unique_paths=' .. #sorted,
		'',
	}
	for _, item in sorted do
		lines[#lines + 1] = string.format('%s\tfunctions=%d', item.path, item.count)
	end
	writeText('manifest/debug/all_source_paths.txt', table.concat(lines, '\n') .. '\n')
	manifest.stats.debugSourcePaths = #sorted
end

local function dumpGcModuleInventory()
	local lines = {
		'# GC ModuleScript inventory (name + resolved source + output path)',
		'',
	}
	for _, entry in manifest.recovered do
		lines[#lines + 1] = string.format(
			'%s\tstatus=%s\toutput=%s\tcanonical=%s\tguess=%s',
			tostring(entry.fullName),
			tostring(entry.status),
			tostring(entry.output),
			tostring(entry.canonicalOutput or entry.knownOutput or ''),
			tostring(entry.guessOutput or '')
		)
	end
	for _, entry in manifest.scripts do
		lines[#lines + 1] = string.format(
			'%s\tstatus=%s\toutput=%s\tlive=1',
			tostring(entry.fullName),
			tostring(entry.status),
			tostring(entry.output)
		)
	end
	writeText('manifest/debug/gc_module_inventory.txt', table.concat(lines, '\n') .. '\n')
end

local function buildSourcePathIndex()
	local paths = {}
	local gc = getGcCache()
	local scanned = 0
	for _, obj in gc do
		scanned += 1
		if type(obj) ~= 'function' then
			continue
		end
		local srcOk, src = pcall(debug.info, obj, 's')
		if srcOk and type(src) == 'string' then
			if src:match('^ReplicatedStorage%.(Client|Shared)%.') then
				paths[src] = (paths[src] or 0) + 1
			elseif src:find('^Players%.', 1, false) and not isIgnoredSourcePath(src) then
				paths[src] = (paths[src] or 0) + 1
			elseif not isIgnoredSourcePath(src) and (
				src:find('PlayerGui', 1, true)
				or src:find('StarterGui', 1, true)
				or src:find('StarterPlayer', 1, true)
				or src:find('ReplicatedFirst', 1, true)
			) then
				paths[src] = (paths[src] or 0) + 1
			end
		end
		if scanned % CONFIG.GC_SCAN_YIELD_EVERY == 0 then
			task.wait()
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
			if dumpState.rsCaptured[desc] then
				continue
			end
			dumpState.rsCaptured[desc] = true
			local sub = folderName == 'Shared' and 'scripts_shared' or 'scripts_client'
			local relKey = sub .. '/' .. sanitizeName(desc.Name) .. '.ModuleScript.lua'
			if usedPaths[relKey] then
				continue
			end
			usedPaths[relKey] = true
			table.insert(jobs, buildJobForScript(desc, usedPaths, {
				sourcePath = 'ReplicatedStorage.' .. folderName .. '.' .. desc.Name,
				folderName = folderName,
				recovered = true,
			}))
		end
	end
	dumpState.rsCapturedCount = 0
	for _ in dumpState.rsCaptured do
		dumpState.rsCapturedCount += 1
	end
	return jobs
end

local function startRsModuleWatcher()
	local rs = game:GetService('ReplicatedStorage')
	local function watchFolder(folderName)
		task.spawn(function()
			local folder = rs:WaitForChild(folderName, CONFIG.RS_WAIT_TIMEOUT)
			if not folder then
				appendBootstrapLog('RS.' .. folderName .. ' not found within timeout')
				return
			end
			appendBootstrapLog('Watching ReplicatedStorage.' .. folderName)
			for _, child in folder:GetDescendants() do
				if child.ClassName == 'ModuleScript' then
					dumpSingleModuleImmediate(child, folderName)
				end
			end
			folder.DescendantAdded:Connect(function(desc)
				if desc.ClassName == 'ModuleScript' then
					task.defer(function()
						dumpSingleModuleImmediate(desc, folderName)
					end)
				end
			end)
		end)
	end
	watchFolder('Client')
	watchFolder('Shared')
end

local function hasEngineInGc()
	if type(getgc) ~= 'function' then
		return false
	end
	local ok, gc = pcall(getgc, true)
	if not ok then
		return false
	end
	for _, obj in gc do
		if type(obj) ~= 'table' then
			continue
		end
		if type(obj.GetContext) == 'function' then
			local ctxOk, ctx = pcall(function()
				return obj.Contexts
			end)
			if ctxOk and ctx ~= nil then
				return true
			end
		end
		if type(obj.Time) == 'function' and type(obj.Scale) == 'number' then
			return true
		end
		if type(obj.GetPV) == 'function' and type(obj.GetOutput) == 'function' then
			return true
		end
	end
	return false
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
	if bestName and bestScore >= 3 then
		return bestFolder, bestName, bestScore
	end
	return nil, nil, bestScore
end

local function knownSourcePathForGuess(guessedName)
	if not guessedName then
		return nil
	end
	local clientPath = 'ReplicatedStorage.Client.' .. guessedName
	if dumpState.knownSourcePaths[clientPath] then
		return clientPath
	end
	local sharedPath = 'ReplicatedStorage.Shared.' .. guessedName
	if dumpState.knownSourcePaths[sharedPath] then
		return sharedPath
	end
	return nil
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
		dumpState.writtenRelPaths[job.rel] = true
		entry.status = 'decompiled'
		stats.decompiled += 1
		entry.sourcePath = job.sourcePath

		if job.canonicalRel and job.canonicalRel ~= job.rel then
			writeText(job.canonicalRel, text)
			dumpState.writtenRelPaths[job.canonicalRel] = true
			entry.canonicalOutput = job.canonicalRel
		end

		local folder, guessed, guessScore = guessRecoveredModuleName(normalized)
		if folder and guessed then
			local knownPath = knownSourcePathForGuess(guessed)
			if knownPath then
				local knownRel = canonicalRelForSourcePath(knownPath, usedPaths)
				if knownRel and not dumpState.writtenRelPaths[knownRel] then
					writeText(knownRel, text)
					dumpState.writtenRelPaths[knownRel] = true
					entry.knownOutput = knownRel
					entry.sourcePath = entry.sourcePath or knownPath
				end
			end
			local guessRel = folder .. '/' .. sanitizeName(guessed) .. '.ModuleScript.lua'
			if guessScore >= 4 and not usedPaths[guessRel] and guessRel ~= job.rel and guessRel ~= job.canonicalRel then
				usedPaths[guessRel] = true
				if not dumpState.writtenRelPaths[guessRel] then
					writeText(guessRel, text)
					dumpState.writtenRelPaths[guessRel] = true
				end
				entry.guessedName = guessed
				entry.guessOutput = guessRel
			end
		end

		if CONFIG.MIRROR_WIRING_PATHS then
			local shortName = job.sourcePath and job.sourcePath:match('%.([^%.]+)$')
				or job.fullName and job.fullName:match('%.([^%.]+)$')
				or (guessed or nil)
			if not shortName and job.rel then
				shortName = job.rel:match('/([^/]+)%.ModuleScript%.lua$')
			end
			if shortName then
				local mirrorRel = mirrorWiringModule(shortName, text, job)
				if mirrorRel then
					entry.wiringMirror = mirrorRel
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
			writeStatus('decompiling', string.format('%d/%d ok=%d', i, #jobs, stats.decompiled))
			task.wait()
		end
	end
	return stats
end

local function buildJobForScript(script, usedPaths, opts)
	opts = opts or {}
	local sourcePath = opts.sourcePath or resolveSourcePathForScript(script)
	if sourcePath then
		registerModuleSource(script, sourcePath)
	end
	local canonicalRel = nil
	if sourcePath and CONFIG.MAP_SOURCE_PATHS then
		canonicalRel = sourcePathToRel(sourcePath, usedPaths or {})
	end
	local folder = 'scripts_recovered'
	local baseName = nil
	local recoveredPath = sourcePath
	if sourcePath then
		local sub, name = sourcePath:match('^ReplicatedStorage%.(Client|Shared)%.(.+)$')
		if sub and name then
			folder = sub == 'Shared' and 'scripts_shared' or 'scripts_client'
			baseName = name
		elseif sourcePath:find('^Players%.', 1, false) then
			folder = 'scripts'
			baseName = sourcePath:match('%.([^%.]+)$')
		end
	elseif opts.folderName then
		folder = opts.folderName == 'Shared' and 'scripts_shared' or 'scripts_client'
		baseName = script.Name
		recoveredPath = script:GetFullName()
	end
	local rel = canonicalRel
	if not rel then
		if not usedPaths then
			usedPaths = {}
		end
		rel = buildScriptRelPath(script, folder, usedPaths, baseName and sanitizeName(baseName) or nil)
	end
	local fullName = recoveredPath
	pcall(function()
		if not fullName then
			fullName = script:GetFullName()
		end
	end)
	return {
		script = script,
		rel = rel,
		canonicalRel = canonicalRel,
		sourcePath = sourcePath,
		fullName = fullName or ('gc:' .. tostring(script)),
		recovered = opts.recovered ~= false,
		recoveredPath = recoveredPath,
	}
end

local function captureModule(script, opts)
	if dumpState.rsCaptured[script] then
		return false
	end
	dumpState.rsCaptured[script] = true
	dumpState.rsCapturedCount += 1
	local job = buildJobForScript(script, {}, opts)
	if dumpRoot == '' then
		table.insert(dumpState.pendingCaptures, job)
		return true
	end
	local stats = { found = 1, decompiled = 0, bytecode = 0, failed = 0 }
	processScriptJob(job, stats, {})
	if job.sourcePath then
		writeStatus('captured', (job.sourcePath or job.fullName) .. ' -> ' .. job.rel)
	end
	return true
end

local function flushPendingCaptures()
	if #dumpState.pendingCaptures == 0 then
		return
	end
	log('Flushing', #dumpState.pendingCaptures, 'modules captured during obtain/RS hook...')
	local stats = { found = #dumpState.pendingCaptures, decompiled = 0, bytecode = 0, failed = 0 }
	local usedPaths = {}
	for _, job in dumpState.pendingCaptures do
		processScriptJob(job, stats, usedPaths)
	end
	dumpState.pendingCaptures = {}
	appendBootstrapLog('flushedObtain=' .. tostring(stats.decompiled))
end

local function installObtainHook()
	if not CONFIG.HOOK_OBTAIN or dumpState.obtainHooked then
		return
	end
	task.spawn(function()
		local deadline = tick() + CONFIG.RS_WAIT_TIMEOUT + CONFIG.INITIAL_LOAD_WAIT + 10
		while tick() < deadline do
			if type(_G.obtain) == 'function' and not dumpState.obtainHooked then
				local original = _G.obtain
				dumpState.obtainHooked = true
				_G.obtain = function(moduleName)
					local modInst, folderName = findRsModuleInstance(moduleName)
					local sourcePath = nil
					if modInst and folderName then
						sourcePath = 'ReplicatedStorage.' .. folderName .. '.' .. moduleName
					elseif dumpState.knownSourcePaths['ReplicatedStorage.Client.' .. moduleName] then
						sourcePath = 'ReplicatedStorage.Client.' .. moduleName
						folderName = 'Client'
					elseif dumpState.knownSourcePaths['ReplicatedStorage.Shared.' .. moduleName] then
						sourcePath = 'ReplicatedStorage.Shared.' .. moduleName
						folderName = 'Shared'
					end
					table.insert(dumpState.obtainLog, {
						name = moduleName,
						found = modInst ~= nil,
						sourcePath = sourcePath,
						at = tick(),
					})
					local result = original(moduleName)
					if modInst then
						dumpState.obtainCaptured[moduleName] = {
							script = modInst,
							sourcePath = sourcePath,
						}
						captureModule(modInst, {
							sourcePath = sourcePath,
							folderName = folderName,
							recovered = true,
						})
					end
					return result
				end
				appendBootstrapLog('obtain hook installed')
				log('obtain() hook active — capturing Client/Shared modules on load')
				return
			end
			task.wait(0.03)
		end
		appendBootstrapLog('obtain hook timeout (Load may have finished before hook)')
	end)
end

local function dumpSingleModuleImmediate(script, folderName)
	return captureModule(script, {
		folderName = folderName,
		sourcePath = 'ReplicatedStorage.' .. folderName .. '.' .. script.Name,
		recovered = true,
	})
end

local function buildModuleSourceMap(gcModules)
	if not CONFIG.MAP_SOURCE_PATHS then
		return
	end
	for _, script in gcModules do
		local src = resolveSourcePathForScript(script)
		if src then
			registerModuleSource(script, src)
		end
	end
	local lines = { '# module source path map (getscriptclosure + debug.info)', '' }
	local sorted = {}
	for src, inst in dumpState.moduleBySource do
		sorted[#sorted + 1] = { src = src, inst = inst }
	end
	table.sort(sorted, function(a, b)
		return a.src < b.src
	end)
	for _, item in sorted do
		lines[#lines + 1] = item.src .. '\t' .. tostring(item.inst)
	end
	writeText('manifest/module_source_map.txt', table.concat(lines, '\n') .. '\n')
	manifest.stats.mappedSources = #sorted
end

local function buildCoverageReport(sourcePaths, recoveredJobs)
	local covered = {}
	for _, job in recoveredJobs do
		if job.sourcePath then
			covered[job.sourcePath] = job.rel
		end
	end
	for src in dumpState.moduleBySource do
		if not covered[src] then
			local rel = sourcePathToRel(src, {})
			if rel then
				covered[src] = rel .. ' (mapped)'
			end
		end
	end
	local missing = {}
	local lines = { '# module coverage vs debug.info source paths', '' }
	for src in sourcePaths do
		local coveredRel = covered[src] or findWrittenRelForSourcePath(src)
		if coveredRel then
			lines[#lines + 1] = 'OK\t' .. src .. '\t' .. coveredRel
		else
			lines[#lines + 1] = 'MISSING\t' .. src
			missing[#missing + 1] = src
		end
	end
	lines[#lines + 1] = ''
	lines[#lines + 1] = '# summary'
	lines[#lines + 1] = 'source_paths=' .. tostring(manifest.stats.sourcePaths or 0)
	lines[#lines + 1] = 'mapped=' .. tostring(manifest.stats.mappedSources or 0)
	lines[#lines + 1] = 'recovered_jobs=' .. tostring(#recoveredJobs)
	lines[#lines + 1] = 'missing=' .. tostring(#missing)
	lines[#lines + 1] = 'obtain_captured=' .. tostring(dumpState.rsCapturedCount)
	writeText('manifest/module_coverage.txt', table.concat(lines, '\n') .. '\n')
	manifest.stats.missingSourcePaths = #missing
end

local function buildReconcileJobs(sourcePaths)
	if not CONFIG.RECONCILE_CANONICAL then
		return {}
	end
	local jobs = {}
	local usedPaths = {}
	for src in sourcePaths do
		local script = dumpState.moduleBySource[src]
		if not script then
			continue
		end
		local relCheck = {}
		local rel = sourcePathToRel(src, relCheck)
		if not rel or dumpState.writtenRelPaths[rel] then
			continue
		end
		table.insert(jobs, buildJobForScript(script, usedPaths, {
			recovered = true,
			sourcePath = src,
		}))
	end
	if #jobs > 0 then
		log('Reconcile pass:', #jobs, 'modules still missing canonical paths')
	end
	return jobs
end

local function waitInitialLoad()
	local total = CONFIG.INITIAL_LOAD_WAIT or 10
	log('Waiting', total, 'seconds for game / RS modules to load...')
	writeStatus('loading', 'waiting ' .. total .. 's for scripts to replicate')
	startRsModuleWatcher()
	for sec = 1, total do
		task.wait(1)
		local jobs = snapshotRsModulesEarly()
		if #jobs > 0 then
			log('RS capture second', sec, ':', #jobs, 'new modules')
			dumpAllScriptJobs(jobs)
		end
		writeStatus('loading', string.format('%d/%ds rsCaptured=%d', sec, total, dumpState.rsCapturedCount))
	end
end

local function waitForBootstrap()
	if not CONFIG.WAIT_FOR_ENGINE then
		return true
	end
	log('Bootstrap: waiting for Load to finish...')
	local deadline = tick() + CONFIG.ENGINE_TIMEOUT
	local obtainGoneSince = nil
	local lastStatusAt = 0

	while tick() < deadline do
		local now = tick()
		local jobs = snapshotRsModulesEarly()
		if #jobs > 0 then
			log('RS snapshot:', #jobs, 'new modules — writing now')
			dumpAllScriptJobs(jobs)
		end

		local obtainGone = _G.obtain == nil
		if obtainGone then
			obtainGoneSince = obtainGoneSince or now
		else
			obtainGoneSince = nil
		end

		local engineReady = hasEngineInGc()
		local rsReady = dumpState.rsCapturedCount > 0
		local obtainGoneLongEnough = obtainGoneSince and (now - obtainGoneSince) >= 3

		if now - lastStatusAt >= 2 then
			lastStatusAt = now
			writeStatus('waiting', string.format(
				'obtain=%s rsCaptured=%d engineGc=%s obtainGoneFor=%.1fs',
				tostring(_G.obtain),
				dumpState.rsCapturedCount,
				tostring(engineReady),
				obtainGoneSince and (now - obtainGoneSince) or 0
			))
		end

		if obtainGone and (engineReady or rsReady or obtainGoneLongEnough) then
			log('Bootstrap complete (rs=' .. dumpState.rsCapturedCount .. ', engineGc=' .. tostring(engineReady) .. ')')
			task.wait(CONFIG.POST_LOAD_DELAY)
			return true
		end

		if rsReady and not game:GetService('ReplicatedStorage'):FindFirstChild('Shared') and not game:GetService('ReplicatedStorage'):FindFirstChild('Client') then
			log('Bootstrap: RS folders destroyed, proceeding with captured modules')
			task.wait(CONFIG.POST_LOAD_DELAY)
			return true
		end

		task.wait(CONFIG.POLL_INTERVAL)
	end

	warnLog('Bootstrap timed out after', CONFIG.ENGINE_TIMEOUT, 's — running main dump anyway')
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
	local gc = getGcCache()

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

local function resolveRecoveredRel(script, usedPaths)
	local job = buildJobForScript(script, usedPaths, { recovered = true })
	return job.rel, job.recoveredPath, job
end

local function buildRecoveredJobs(sourcePaths, liveSet)
	local jobs = {}
	local usedPaths = {}
	log('Scanning getgc for all game ModuleScripts...')
	writeStatus('gc_scan', 'scanning getgc for modules')
	local gcModules = gatherGcModuleScriptsMultiPass()
	buildModuleSourceMap(gcModules)

	for i, script in gcModules do
		if liveSet and liveSet[script] then
			continue
		end
		local rel, recoveredPath, job = resolveRecoveredRel(script, usedPaths)
		table.insert(jobs, job)
		if i % 25 == 0 then
			task.wait()
		end
	end

	log('Recovered job list built:', #jobs, 'modules to decompile')

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
		'See manifest/module_coverage.txt — goal is missing=0 for indexed source paths.',
		'See manifest/debug/all_source_paths.txt for full debug.info inventory.',
		'See manifest/debug/capabilities.txt for executor API availability.',
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
	if CONFIG.ONLY_THIS_PLACE and game.PlaceId ~= TARGET_PLACE_ID then
		return
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
	dumpState.startedAt = tick()
	log('Output:', dumpRoot)
	log('Backup manifest:', backupRoot)
	writeStatus('init', 'dump folder created')
	appendBootstrapLog('Dumper started place=' .. tostring(game.PlaceId))
	installObtainHook()
	flushPendingCaptures()

	waitInitialLoad()

	local immediateJobs = snapshotRsModulesEarly()
	if #immediateJobs > 0 then
		log('Post-wait RS snapshot:', #immediateJobs, 'modules')
		dumpAllScriptJobs(immediateJobs)
	end

	waitForBootstrap()
	writeStatus('main_dump', 'starting full pass')

	invalidateGcCache()
	local sourcePaths = buildSourcePathIndex()
	indexKnownSourcePaths(sourcePaths)
	dumpExecutorCapabilities()
	if CONFIG.DUMP_SOURCE_PATH_INDEX then
		dumpSourcePathIndex(sourcePaths)
	end

	log('Gathering live scripts...')
	local liveScripts = gatherLiveScripts()
	local liveJobs = {}
	local liveSet = {}
	local usedLive = {}
	for _, script in liveScripts do
		liveSet[script] = true
		if dumpState.rsCaptured[script] then
			continue
		end
		table.insert(liveJobs, buildJobForScript(script, usedLive, { recovered = false }))
	end
	log('Live scripts:', #liveJobs)

	local recoveredJobs = {}
	if CONFIG.RECOVER_DESTROYED_MODULES then
		log('Recovering destroyed Client/Shared ModuleScripts from getgc...')
		recoveredJobs = buildRecoveredJobs(sourcePaths, liveSet)
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

	writeObtainLog()

	local reconcileJobs = buildReconcileJobs(sourcePaths)
	local reconcileStats = { found = 0, decompiled = 0, bytecode = 0, failed = 0 }
	if #reconcileJobs > 0 then
		log('Decompiling reconcile pass...')
		reconcileStats = dumpAllScriptJobs(reconcileJobs)
	end

	if CONFIG.FINAL_GC_RESCAN then
		log('Final GC rescan for late-appearing modules...')
		invalidateGcCache()
		local latePaths = buildSourcePathIndex()
		for src, count in latePaths do
			if not sourcePaths[src] then
				sourcePaths[src] = count
			end
		end
		indexKnownSourcePaths(sourcePaths)
		if CONFIG.DUMP_SOURCE_PATH_INDEX then
			dumpSourcePathIndex(sourcePaths)
		end
		local lateJobs = buildReconcileJobs(sourcePaths)
		if #lateJobs > 0 then
			log('Final reconcile:', #lateJobs, 'modules')
			local lateStats = dumpAllScriptJobs(lateJobs)
			reconcileStats.decompiled += lateStats.decompiled
			reconcileStats.found += lateStats.found
		end
	end

	buildCoverageReport(sourcePaths, recoveredJobs)

	dumpExecutorCapabilities()
	dumpFullDebugIndex()
	dumpGcModuleInventory()

	manifest.stats.live = liveStats
	manifest.stats.recovered = recoveredStats
	manifest.stats.reconcile = reconcileStats
	manifest.stats.rsCapturedEarly = dumpState.rsCapturedCount
	manifest.stats.obtainHooked = dumpState.obtainHooked
	manifest.stats.obtainCalls = #dumpState.obtainLog
	manifest.stats.mappedSources = manifest.stats.mappedSources or 0
	writeSummary(liveStats, recoveredStats)
	writeStatus('done', string.format(
		'live=%d recovered=%d reconcile=%d missing=%s rsEarly=%d',
		liveStats.decompiled,
		recoveredStats.decompiled,
		reconcileStats.decompiled,
		tostring(manifest.stats.missingSourcePaths or '?'),
		dumpState.rsCapturedCount
	))

	log('Done.')
	log('Primary output:', dumpRoot)
	log('Check manifest/status.txt in your executor workspace')
	_G.__UGC531_DUMP_DONE = dumpRoot
	_G.__UGC531_DUMP_RUNNING = nil
end

local function startAutoDump()
	if _G.__UGC531_DUMP_RUNNING or _G.__UGC531_DUMP_DONE then
		return
	end
	_G.__UGC531_DUMP_RUNNING = true
	task.spawn(function()
		installObtainHook()
		if not game:IsLoaded() then
			game.Loaded:Wait()
		end
		if CONFIG.ONLY_THIS_PLACE and game.PlaceId ~= TARGET_PLACE_ID then
			_G.__UGC531_DUMP_RUNNING = nil
			return
		end
		local ok, err = pcall(runDump)
		if not ok then
			warnLog('Dump failed:', err)
			if dumpRoot ~= '' then
				writeStatus('error', tostring(err))
			end
			_G.__UGC531_DUMP_RUNNING = nil
		end
	end)
end

if CONFIG.AUTOEXECUTE then
	installObtainHook()
end

if CONFIG.AUTOEXECUTE then
	startAutoDump()
else
	pcall(runDump)
end
