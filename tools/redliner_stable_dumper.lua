--[[
	REDLINER Stable Dumper (standalone)

	Goal:
	- Dump as much useful RE data as possible without freezing/crashing game client.
	- Prioritize stability over speed.
	- Produce decompiled scripts and bytecode fallback in a resumable-style flow.

	Usage:
		loadstring(readfile("tools/redliner_stable_dumper.lua"), "redliner_stable_dumper")()
]]

local CONFIG = {
	OUTPUT_ROOT = "redliner_dumps",
	DECOMPILE_PER_TICK = 1,
	YIELD_SECONDS = 0.03,
	MAX_SCRIPTS = 12000,
	INCLUDE_NIL_INSTANCES = false, -- heavy; set true only if your executor handles it safely
	INCLUDE_GETSCRIPTS = true,
	INCLUDE_GETRUNNINGSCRIPTS = true,
	INCLUDE_GETLOADEDMODULES = true,
	INCLUDE_CORE_GUI = false,
	INCLUDE_CORE_PACKAGES = false,
	INCLUDE_PLAYER_MODULE = true,
	DUMP_GC_KEYWORDS = true,
	GC_MAX_STRINGS = 6000, -- cap to reduce memory churn
	LOG_PREFIX = "[REDLINER StableDumper]",
}

local SCRIPT_CLASSES = {
	LocalScript = true,
	ModuleScript = true,
	Script = true,
}

local INVALID_PATH_CHARS = { "\\", "/", ":", "*", "?", "\"", "<", ">", "|" }
local WINDOWS_RESERVED = {
	CON = true, PRN = true, AUX = true, NUL = true,
	COM1 = true, COM2 = true, COM3 = true, COM4 = true, COM5 = true,
	COM6 = true, COM7 = true, COM8 = true, COM9 = true,
	LPT1 = true, LPT2 = true, LPT3 = true, LPT4 = true, LPT5 = true,
	LPT6 = true, LPT7 = true, LPT8 = true, LPT9 = true,
}

local playersService = game:GetService("Players")
local collectionService = game:GetService("CollectionService")
local httpService = game:GetService("HttpService")

local rootPath = ""
local stats = {
	scripts_found = 0,
	decompiled = 0,
	bytecode = 0,
	failed = 0,
}

local function log(...)
	print(CONFIG.LOG_PREFIX, ...)
end

local function warnLog(...)
	warn(CONFIG.LOG_PREFIX, ...)
end

local function hasFileApi()
	return type(writefile) == "function" and type(makefolder) == "function" and type(isfolder) == "function"
end

local function sanitizeName(name)
	if type(name) ~= "string" or name == "" then
		return "Unnamed"
	end
	for _, c in INVALID_PATH_CHARS do
		name = name:gsub(c, "_")
	end
	name = name:gsub("[%z]", "_")
	name = name:gsub("[%s%.]+$", "")
	if name == "" then
		return "Unnamed"
	end
	if WINDOWS_RESERVED[name:upper()] then
		name = name .. "_"
	end
	return name:sub(1, 180)
end

local function ensureFolder(folderPath)
	local built = ""
	for part in folderPath:gsub("\\", "/"):gmatch("[^/]+") do
		built = built == "" and part or (built .. "/" .. part)
		if not isfolder(built) then
			pcall(makefolder, built)
		end
	end
end

local function writeText(relPath, text)
	local full = rootPath .. "/" .. relPath:gsub("\\", "/")
	local dir = full:match("^(.*)/[^/]+$")
	if dir then
		ensureFolder(dir)
	end
	local ok, err = pcall(writefile, full, text)
	if not ok then
		warnLog("write failed:", relPath, err)
		return false
	end
	return true
end

local function jsonEncode(value)
	local ok, out = pcall(httpService.JSONEncode, httpService, value)
	if ok then
		return out
	end
	return nil
end

local function nowStamp()
	return os.date("%Y%m%d_%H%M%S")
end

local function makeRoot()
	local base = string.format(
		"%s/%s_%s_%s",
		CONFIG.OUTPUT_ROOT,
		sanitizeName(game.Name),
		tostring(game.PlaceId),
		nowStamp()
	)
	ensureFolder(base)
	return base
end

local function pathNoise(fullName)
	if not CONFIG.INCLUDE_PLAYER_MODULE and fullName:find("PlayerScripts%.PlayerModule%.") then
		return true
	end
	if not CONFIG.INCLUDE_CORE_GUI and fullName:find("^CoreGui%.") then
		return true
	end
	if not CONFIG.INCLUDE_CORE_PACKAGES and fullName:find("^CorePackages%.") then
		return true
	end
	return false
end

local function collectScripts()
	local seen = {}
	local list = {}
	local rootGame = game

	local function pushScript(inst)
		if typeof(inst) ~= "Instance" then
			return
		end
		if not SCRIPT_CLASSES[inst.ClassName] then
			return
		end
		local okName, fullName = pcall(inst.GetFullName, inst)
		if not okName then
			return
		end
		if pathNoise(fullName) then
			return
		end
		if seen[fullName] then
			return
		end
		seen[fullName] = true
		list[#list + 1] = inst
	end

	for _, inst in rootGame:GetDescendants() do
		pushScript(inst)
	end

	if CONFIG.INCLUDE_GETSCRIPTS and type(getscripts) == "function" then
		local ok, got = pcall(getscripts)
		if ok and type(got) == "table" then
			for _, inst in got do
				pushScript(inst)
			end
		end
	end

	if CONFIG.INCLUDE_GETRUNNINGSCRIPTS and type(getrunningscripts) == "function" then
		local ok, got = pcall(getrunningscripts)
		if ok and type(got) == "table" then
			for _, inst in got do
				pushScript(inst)
			end
		end
	end

	if CONFIG.INCLUDE_GETLOADEDMODULES and type(getloadedmodules) == "function" then
		local ok, got = pcall(getloadedmodules)
		if ok and type(got) == "table" then
			for _, inst in got do
				pushScript(inst)
			end
		end
	end

	if CONFIG.INCLUDE_NIL_INSTANCES and type(getnilinstances) == "function" then
		local ok, nils = pcall(getnilinstances)
		if ok and type(nils) == "table" then
			for _, inst in nils do
				pushScript(inst)
			end
		end
	end

	table.sort(list, function(a, b)
		return a:GetFullName() < b:GetFullName()
	end)

	if #list > CONFIG.MAX_SCRIPTS then
		local trimmed = {}
		for i = 1, CONFIG.MAX_SCRIPTS do
			trimmed[i] = list[i]
		end
		list = trimmed
	end

	return list
end

local function relScriptPath(script, used)
	local parts = {}
	local cur = script.Parent
	while cur and cur ~= game do
		parts[#parts + 1] = sanitizeName(cur.Name)
		cur = cur.Parent
	end
	local ordered = {}
	for i = #parts, 1, -1 do
		ordered[#ordered + 1] = parts[i]
	end
	local base = sanitizeName(script.Name) .. "." .. script.ClassName .. ".lua"
	local dir = table.concat(ordered, "/")
	local rel = dir == "" and ("scripts/" .. base) or ("scripts/" .. dir .. "/" .. base)
	local n = 1
	while used[rel] do
		n += 1
		local withIdx = sanitizeName(script.Name) .. "." .. script.ClassName .. "_" .. n .. ".lua"
		rel = dir == "" and ("scripts/" .. withIdx) or ("scripts/" .. dir .. "/" .. withIdx)
	end
	used[rel] = true
	return rel
end

local function tryDecompile(script)
	if type(decompile) ~= "function" then
		return false, "decompile unavailable"
	end
	local ok, src = pcall(decompile, script)
	if not ok then
		return false, tostring(src)
	end
	if type(src) ~= "string" or src == "" then
		return false, "empty decompile"
	end
	local lower = src:lower()
	if lower:find("failed to decompile", 1, true) or lower:find("decompile failed", 1, true) then
		return false, src
	end
	return true, src
end

local function tryBytecode(script)
	if type(getscriptbytecode) ~= "function" then
		return false, nil
	end
	local ok, bc = pcall(getscriptbytecode, script)
	if not ok or type(bc) ~= "string" or bc == "" then
		return false, nil
	end
	return true, bc
end

local function hexEncode(s)
	return (s:gsub(".", function(c)
		return string.format("%02x", string.byte(c))
	end))
end

local function dumpScriptSet(scripts)
	local indexLines = { "# script_paths", "" }
	local used = {}
	local entries = {}
	local processed = 0

	for _, script in scripts do
		indexLines[#indexLines + 1] = script:GetFullName() .. " [" .. script.ClassName .. "]"
	end
	writeText("manifest/script_paths.txt", table.concat(indexLines, "\n") .. "\n")

	for _, script in scripts do
		processed += 1
		if processed % 25 == 0 then
			log("decompile", processed .. "/" .. #scripts, "ok=" .. stats.decompiled, "bc=" .. stats.bytecode, "fail=" .. stats.failed)
		end

		local rel = relScriptPath(script, used)
		local entry = {
			path = script:GetFullName(),
			className = script.ClassName,
			output = rel,
			status = "failed",
		}

		local okDec, srcOrErr = tryDecompile(script)
		if okDec then
			local text = "-- Decompiled from: " .. script:GetFullName() .. "\n"
				.. "-- Class: " .. script.ClassName .. "\n"
				.. "-- Place: " .. game.Name .. " (" .. tostring(game.PlaceId) .. ")\n\n"
				.. srcOrErr:gsub("\r\n", "\n"):gsub("\r", "\n")
			if not text:match("\n$") then
				text ..= "\n"
			end
			writeText(rel, text)
			entry.status = "decompiled"
			stats.decompiled += 1
		else
			entry.decompileError = srcOrErr
			local okBc, bc = tryBytecode(script)
			if okBc then
				local bcRel = rel:gsub("^scripts/", "bytecode/"):gsub("%.lua$", ".hex.txt")
				local header = "-- Bytecode fallback\n-- Script: " .. script:GetFullName() .. "\n-- Size: " .. tostring(#bc) .. " bytes\n\n"
				writeText(bcRel, header .. hexEncode(bc))
				entry.status = "bytecode"
				entry.bytecode = bcRel
				stats.bytecode += 1
			else
				stats.failed += 1
			end
		end
		entries[#entries + 1] = entry

		if (processed % CONFIG.DECOMPILE_PER_TICK) == 0 then
			task.wait(CONFIG.YIELD_SECONDS)
		end
	end

	return entries
end

local function dumpSimpleManifests()
	local remotes = { "# remotes", "" }
	local remoteClasses = { RemoteEvent = true, RemoteFunction = true, UnreliableRemoteEvent = true }
	for _, inst in game:GetDescendants() do
		if remoteClasses[inst.ClassName] then
			remotes[#remotes + 1] = inst.ClassName .. "\t" .. inst:GetFullName()
		end
	end
	writeText("manifest/remotes.txt", table.concat(remotes, "\n") .. "\n")

	local tags = { "# collection_tags", "" }
	for _, tag in collectionService:GetAllTags() do
		local tagged = collectionService:GetTagged(tag)
		tags[#tags + 1] = tag .. "\tcount=" .. tostring(#tagged)
	end
	writeText("manifest/collection_tags.txt", table.concat(tags, "\n") .. "\n")

	local roLines = { "# read_only", "" }
	local rs = game:GetService("ReplicatedStorage")
	local roRoot = rs:FindFirstChild("ReadOnly")
	if roRoot then
		roLines[#roLines + 1] = "ReplicatedStorage.ReadOnly children=" .. tostring(#roRoot:GetChildren())
	end
	for _, plr in playersService:GetPlayers() do
		roLines[#roLines + 1] = "## " .. plr.Name .. " (" .. plr.UserId .. ")"
		local ro = plr:FindFirstChild("ReadOnly")
		if ro then
			for _, child in ro:GetChildren() do
				local val = child:IsA("ValueBase") and child.Value or "<non-value>"
				roLines[#roLines + 1] = "  " .. child.Name .. " (" .. child.ClassName .. ") = " .. tostring(val)
			end
		else
			roLines[#roLines + 1] = "  (missing)"
		end
	end
	writeText("manifest/read_only.txt", table.concat(roLines, "\n") .. "\n")
end

local function dumpGcKeywords()
	if not CONFIG.DUMP_GC_KEYWORDS or type(getgc) ~= "function" then
		return
	end
	local keywords = { "impact", "instabil", "destabil", "stun", "clash", "parry", "packetpredicate", "hurtbox" }
	local lines = { "# gc_keyword_hits", "" }
	local seen = {}
	local captured = 0

	local ok, gc = pcall(getgc, true)
	if not ok or type(gc) ~= "table" then
		return
	end

	for _, obj in gc do
		if captured >= CONFIG.GC_MAX_STRINGS then
			break
		end
		if type(obj) == "string" then
			local s = obj:lower()
			for _, kw in keywords do
				if s:find(kw, 1, true) and not seen[obj] then
					seen[obj] = true
					lines[#lines + 1] = obj
					captured += 1
					break
				end
			end
		end
	end
	writeText("manifest/gc_keyword_hits.txt", table.concat(lines, "\n") .. "\n")
end

local function run()
	if not hasFileApi() then
		error("writefile/makefolder/isfolder required")
	end
	if type(decompile) ~= "function" and type(getscriptbytecode) ~= "function" then
		error("need decompile or getscriptbytecode")
	end

	rootPath = makeRoot()
	log("output root:", rootPath)
	ensureFolder(rootPath .. "/manifest")
	ensureFolder(rootPath .. "/scripts")
	ensureFolder(rootPath .. "/bytecode")

	local meta = {
		placeId = game.PlaceId,
		placeName = game.Name,
		jobId = game.JobId,
		startedAt = os.date("!%Y-%m-%dT%H:%M:%SZ"),
	}
	writeText("manifest/meta.json", jsonEncode(meta) or "{}")

	dumpSimpleManifests()
	dumpGcKeywords()

	log("collecting scripts...")
	local scripts = collectScripts()
	stats.scripts_found = #scripts
	log("scripts found:", #scripts)

	local entries = dumpScriptSet(scripts)

	local out = {
		meta = meta,
		stats = stats,
		entries = entries,
		finishedAt = os.date("!%Y-%m-%dT%H:%M:%SZ"),
	}
	local json = jsonEncode(out)
	if json then
		writeText("manifest/index.json", json)
	end

	local summary = {
		"REDLINER Stable Dumper Summary",
		"root=" .. rootPath,
		"place=" .. tostring(game.PlaceId) .. " (" .. game.Name .. ")",
		"job=" .. game.JobId,
		"",
		"scripts_found=" .. tostring(stats.scripts_found),
		"decompiled=" .. tostring(stats.decompiled),
		"bytecode=" .. tostring(stats.bytecode),
		"failed=" .. tostring(stats.failed),
	}
	writeText("manifest/SUMMARY.txt", table.concat(summary, "\n") .. "\n")

	log("done.")
	log("found=" .. stats.scripts_found, "decompiled=" .. stats.decompiled, "bytecode=" .. stats.bytecode, "failed=" .. stats.failed)
	log("saved to workspace/" .. rootPath)
end

local function main()
	log("starting for", game.Name, game.PlaceId)
	local ok, err = pcall(run)
	if not ok then
		warnLog("fatal:", err)
		error(err)
	end
end

main()

