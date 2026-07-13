--[[
	Fallen Survival — Anticheat GC Offset Dumper

	Run in-game AFTER you have fully spawned (character + HUD loaded).
	DO NOT run alongside Vape bypass — it will kick on 0x01/0x02 if bypass loads first.

	Usage (executor):
		loadstring(readfile("tools/fallen_anticheat_offset_dumper.lua"), "fallen_ac_dumper")()

	Optional:
		getgenv().FallenDumperPollSeconds = 30   -- how long to poll gc (default 30)
		getgenv().FallenDumperPollInterval = 0.25

	Output folder (executor workspace):
		fallen_ac_dumps/<PlaceId>_<timestamp>/
			offsets.json
			offsets.txt
			bypass_offsets.lua
]]

if not getgc then
	error("[FallenACDumper] getgc is required")
end

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local POLL_SECONDS = tonumber(getgenv().FallenDumperPollSeconds) or 30
local POLL_INTERVAL = tonumber(getgenv().FallenDumperPollInterval) or 0.25
local OUTPUT_ROOT = "fallen_ac_dumps"

local client = Players.LocalPlayer

local function tableLength(tbl)
	if rawlen then
		return rawlen(tbl)
	end
	local maxIndex = 0
	for key in tbl do
		if type(key) == "number" and key > maxIndex then
			maxIndex = key
		end
	end
	return maxIndex
end

local function tableKeys(tbl, maxScan)
	local keys = {}
	for key in tbl do
		if type(key) == "number" then
			table.insert(keys, key)
		end
	end
	table.sort(keys)
	if maxScan and #keys > maxScan then
		local trimmed = {}
		for i = 1, maxScan do
			trimmed[i] = keys[i]
		end
		return trimmed
	end
	return keys
end

local function pointerId(value)
	if typeof(value) == "Instance" then
		return string.format("Instance:%s:%s", value.ClassName, value:GetDebugId and value:GetDebugId() or tostring(value))
	end
	if type(value) == "table" then
		return string.format("table:%s", tostring(value))
	end
	if type(value) == "function" then
		return string.format("function:%s", tostring(value))
	end
	return string.format("%s:%s", typeof(value), tostring(value))
end

local function describeValue(value, depth)
	depth = depth or 0
	local t = typeof(value)
	if t == "Instance" then
		local fullName = "[destroyed]"
		pcall(function()
			fullName = value:GetFullName()
		end)
		return {
			type = "Instance",
			class = value.ClassName,
			name = value.Name,
			fullName = fullName,
			debugId = value:GetDebugId and value:GetDebugId() or nil,
		}
	end
	if type(value) == "table" then
		local child = {}
		if depth < 1 then
			for i = 1, math.min(8, tableLength(value)) do
				local entry = rawget(value, i)
				if entry ~= nil then
					child[tostring(i)] = describeValue(entry, depth + 1)
				end
			end
		end
		return {
			type = "table",
			length = tableLength(value),
			pointer = tostring(value),
			preview = child,
		}
	end
	if type(value) == "function" then
		return { type = "function", pointer = tostring(value) }
	end
	return { type = t, value = tostring(value) }
end

local function snapshotTable(tbl, maxIndex)
	local snap = {}
	for i = 1, maxIndex do
		local value = rawget(tbl, i)
		if value ~= nil then
			snap[tostring(i)] = describeValue(value, 0)
		end
	end
	return snap
end

local function listTableOffsets(tbl, predicate, maxIndex)
	local hits = {}
	for i = 1, maxIndex do
		local value = rawget(tbl, i)
		if predicate(value, i) then
			table.insert(hits, i)
		end
	end
	return hits
end

local function ensureFolder(path)
	if not isfolder then return end
	local built = ""
	for part in path:gsub("\\", "/"):gmatch("[^/]+") do
		built = built == "" and part or (built .. "/" .. part)
		if not isfolder(built) then
			pcall(makefolder, built)
		end
	end
end

local function writeOutput(folder, name, content)
	if not writefile then
		return false
	end
	ensureFolder(folder)
	local ok, err = pcall(writefile, folder .. "/" .. name, content)
	if not ok then
		warn("[FallenACDumper] write failed:", name, err)
	end
	return ok
end

local function waitForReady(maxWait)
	local deadline = tick() + maxWait
	ReplicatedStorage:WaitForChild("Modules", maxWait):WaitForChild("AssetContainer", maxWait)
	local remotes = ReplicatedStorage:WaitForChild("Remotes", maxWait)
	local character = client.Character or client.CharacterAdded:Wait()
	character:WaitForChild("Humanoid", maxWait)
	character:WaitForChild("HumanoidRootPart", maxWait)

	while tick() < deadline do
		if character:FindFirstChild("InventoryController") or character:FindFirstChild("StateController") then
			break
		end
		for _, fn in getgc(false) do
			if type(fn) == "function" then
				local info = (getinfo or debug.getinfo)(fn)
				if info and info.source and info.source:find("AssetContainer") then
					return remotes, character, character:FindFirstChildOfClass("Humanoid")
				end
			end
		end
		task.wait(0.2)
	end

	return remotes, character, character:FindFirstChildOfClass("Humanoid")
end

local function scanGc(remotes, character, humanoid)
	local result = {
		remotesExact = {},
		remotesByName = {},
		characterExact = {},
		characterFuzzy = {},
		recursive = {},
		assetContainer = {
			closureCount = 0,
			samples = {},
		},
	}

	local seenRemotes, seenCharacter, seenFuzzy, seenRecursive = {}, {}, {}, {}

	for _, tbl in getgc(true) do
		if type(tbl) ~= "table" then continue end

		-- Stage 0x01: Remotes context
		local remotesIndex
		for i = 1, 32 do
			if rawget(tbl, i) == remotes then
				remotesIndex = i
				break
			end
		end
		local first = rawget(tbl, 1)
		if not remotesIndex and typeof(first) == "Instance" and first.Name == "Remotes" then
			remotesIndex = 1
		end

		if remotesIndex then
			local id = tostring(tbl)
			if not seenRemotes[id] then
				seenRemotes[id] = true
				local banOffsets = listTableOffsets(tbl, function(value, index)
					return index ~= remotesIndex and type(value) == "table" and value ~= tbl
				end, 32)
				table.insert(result.remotesExact, {
					remotesIndex = remotesIndex,
					length = tableLength(tbl),
					banTableOffsets = banOffsets,
					legacyBanOffset = rawget(tbl, 4) and 4 or nil,
					snapshot = snapshotTable(tbl, 16),
					tablePointer = id,
				})
			end
		end

		if typeof(first) == "Instance" and first.Name == "Remotes" then
			local id = "name:" .. tostring(tbl)
			if not seenRemotes[id] then
				seenRemotes[id] = true
				table.insert(result.remotesByName, {
					remotesIndex = 1,
					length = tableLength(tbl),
					banTableOffsets = listTableOffsets(tbl, function(value, index)
						return index ~= 1 and type(value) == "table" and value ~= tbl
					end, 32),
					snapshot = snapshotTable(tbl, 16),
					tablePointer = tostring(tbl),
				})
			end
		end

		-- Stage 0x02: Character context (strict)
		if character and humanoid and rawget(tbl, 1) == character and rawget(tbl, 2) == humanoid then
			local id = tostring(tbl)
			if not seenCharacter[id] then
				seenCharacter[id] = true
				local banOffsets = listTableOffsets(tbl, function(value, index)
					return index > 2 and type(value) == "table"
				end, 32)
				table.insert(result.characterExact, {
					characterIndex = 1,
					humanoidIndex = 2,
					length = tableLength(tbl),
					lengthHash = tableLength(tbl),
					banTableOffsets = banOffsets,
					legacyBanOffsets = {
						five = rawget(tbl, 5) ~= nil and 5 or nil,
						eight = rawget(tbl, 8) ~= nil and 8 or nil,
					},
					snapshot = snapshotTable(tbl, 16),
					tablePointer = id,
				})
			end
		end

		-- Stage 0x02 fuzzy: character and/or humanoid anywhere
		if character and humanoid then
			local charIndexes = listTableOffsets(tbl, function(value)
				return value == character
			end, 32)
			local humIndexes = listTableOffsets(tbl, function(value)
				return value == humanoid
			end, 32)
			if #charIndexes > 0 or #humIndexes > 0 then
				local id = string.format("fuzzy:%s:%s:%s", tostring(tbl), table.concat(charIndexes, ","), table.concat(humIndexes, ","))
				if not seenFuzzy[id] then
					seenFuzzy[id] = true
					table.insert(result.characterFuzzy, {
						characterIndexes = charIndexes,
						humanoidIndexes = humIndexes,
						length = tableLength(tbl),
						banTableOffsets = listTableOffsets(tbl, function(value, index)
							return type(value) == "table" and value ~= tbl and value ~= character and value ~= humanoid
						end, 32),
						snapshot = snapshotTable(tbl, 16),
						tablePointer = tostring(tbl),
					})
				end
			end
		end

		-- Stage 0x03: recursive self-table
		if getrawmetatable and not getrawmetatable(tbl) then
			local foundIndex, foundRecursive = false, false
			for _, value in tbl do
				if type(value) == "number" and rawequal(value, 1) then
					foundIndex = value
				end
				if rawequal(value, tbl) then
					foundRecursive = value
				end
			end
			if foundIndex and foundRecursive and rawequal(rawget(tbl, foundIndex), nil) then
				local id = tostring(tbl)
				if not seenRecursive[id] then
					seenRecursive[id] = true
					table.insert(result.recursive, {
						banIndex = foundIndex,
						length = tableLength(tbl),
						snapshot = snapshotTable(tbl, 8),
						tablePointer = id,
					})
				end
			end
		end
	end

	for _, fn in getgc(false) do
		if type(fn) ~= "function" then continue end
		local info = (getinfo or debug.getinfo)(fn)
		if info and info.source and info.source:find("AssetContainer") then
			result.assetContainer.closureCount += 1
			if #result.assetContainer.samples < 5 then
				table.insert(result.assetContainer.samples, {
					name = info.name,
					source = info.source,
					numparams = info.numparams,
				})
			end
		end
	end

	return result
end

local function mergeScan(target, incoming)
	for key, list in incoming do
		target[key] = target[key] or {}
		local seen = {}
		for _, entry in target[key] do
			seen[entry.tablePointer or HttpService:GenerateGUID(false)] = true
		end
		for _, entry in list do
			local id = entry.tablePointer or HttpService:GenerateGUID(false)
			if not seen[id] then
				seen[id] = true
				table.insert(target[key], entry)
			end
		end
	end
end

local function pickBestRemotes(matches)
	return matches[1]
end

local function pickBestCharacter(exact, fuzzy)
	if #exact > 0 then
		return exact[1]
	end
	for _, entry in fuzzy do
		if #entry.characterIndexes == 1 and #entry.humanoidIndexes == 1 then
			return {
				characterIndex = entry.characterIndexes[1],
				humanoidIndex = entry.humanoidIndexes[1],
				length = entry.length,
				banTableOffsets = entry.banTableOffsets,
				source = "fuzzy",
				snapshot = entry.snapshot,
			}
		end
	end
	return fuzzy[1]
end

local function buildRecommendations(scan)
	local remotes = pickBestRemotes(scan.remotesExact) or pickBestRemotes(scan.remotesByName)
	local character = pickBestCharacter(scan.characterExact, scan.characterFuzzy)
	local recursive = scan.recursive[1]

	return {
		stage0x01 = remotes and {
			remotesIndex = remotes.remotesIndex,
			banTableOffsets = remotes.banTableOffsets,
			tableLength = remotes.length,
		} or nil,
		stage0x02 = character and {
			characterIndex = character.characterIndex or (character.characterIndexes and character.characterIndexes[1]),
			humanoidIndex = character.humanoidIndex or (character.humanoidIndexes and character.humanoidIndexes[1]),
			tableLength = character.length,
			banTableOffsets = character.banTableOffsets,
			clearOffsets = {5},
			source = character.source or "exact",
		} or nil,
		stage0x03 = recursive and {
			banIndex = recursive.banIndex,
			tableLength = recursive.length,
		} or nil,
	}
end

local function formatTxt(report)
	local lines = {
		"=" .. string.rep("=", 78),
		"FALLEN SURVIVAL — ANTICHEAT GC OFFSET DUMP",
		"=" .. string.rep("=", 78),
		"",
		"PlaceId:      " .. tostring(report.placeId),
		"Game:         " .. tostring(report.gameName),
		"Timestamp:    " .. tostring(report.timestamp),
		"PollSeconds:  " .. tostring(report.pollSeconds),
		"Character:    " .. tostring(report.characterPath),
		"Remotes:      " .. tostring(report.remotesPath),
		"AssetContainer closures: " .. tostring(report.scan.assetContainer.closureCount),
		"",
		"-" .. string.rep("-", 78),
		"RECOMMENDED BYPASS OFFSETS",
		"-" .. string.rep("-", 78),
	}

	local rec = report.recommendations
	if rec.stage0x01 then
		table.insert(lines, "[0x01 Remotes]")
		table.insert(lines, "  remotesIndex      = " .. tostring(rec.stage0x01.remotesIndex))
		table.insert(lines, "  banTableOffsets   = {" .. table.concat(rec.stage0x01.banTableOffsets, ", ") .. "}")
		table.insert(lines, "  tableLength       = " .. tostring(rec.stage0x01.tableLength))
	else
		table.insert(lines, "[0x01 Remotes] NOT FOUND")
	end
	table.insert(lines, "")

	if rec.stage0x02 then
		table.insert(lines, "[0x02 Character]")
		table.insert(lines, "  characterIndex    = " .. tostring(rec.stage0x02.characterIndex))
		table.insert(lines, "  humanoidIndex     = " .. tostring(rec.stage0x02.humanoidIndex))
		table.insert(lines, "  banTableOffsets   = {" .. table.concat(rec.stage0x02.banTableOffsets, ", ") .. "}")
		table.insert(lines, "  clearOffsets      = {" .. table.concat(rec.stage0x02.clearOffsets, ", ") .. "}")
		table.insert(lines, "  tableLength       = " .. tostring(rec.stage0x02.tableLength))
		table.insert(lines, "  matchSource       = " .. tostring(rec.stage0x02.source))
	else
		table.insert(lines, "[0x02 Character] NOT FOUND")
	end
	table.insert(lines, "")

	if rec.stage0x03 then
		table.insert(lines, "[0x03 Recursive]")
		table.insert(lines, "  banIndex          = " .. tostring(rec.stage0x03.banIndex))
		table.insert(lines, "  tableLength       = " .. tostring(rec.stage0x03.tableLength))
	else
		table.insert(lines, "[0x03 Recursive] NOT FOUND")
	end

	local function appendSection(title, entries)
		table.insert(lines, "")
		table.insert(lines, "-" .. string.rep("-", 78))
		table.insert(lines, title .. " (" .. tostring(#entries) .. " matches)")
		table.insert(lines, "-" .. string.rep("-", 78))
		if #entries == 0 then
			table.insert(lines, "  (none)")
			return
		end
		for i, entry in entries do
			table.insert(lines, string.format("  [%d] %s", i, HttpService:JSONEncode(entry)))
		end
	end

	appendSection("REMOTES EXACT MATCHES", report.scan.remotesExact)
	appendSection("REMOTES NAME MATCHES", report.scan.remotesByName)
	appendSection("CHARACTER EXACT MATCHES (idx1=char, idx2=hum)", report.scan.characterExact)
	appendSection("CHARACTER FUZZY MATCHES", report.scan.characterFuzzy)
	appendSection("RECURSIVE SELF-TABLE MATCHES", report.scan.recursive)

	return table.concat(lines, "\n")
end

local function buildBypassSnippet(recommendations)
	local r1 = recommendations.stage0x01
	local r2 = recommendations.stage0x02
	local r3 = recommendations.stage0x03

	return table.concat({
		"-- Auto-generated by tools/fallen_anticheat_offset_dumper.lua",
		"-- Paste into libraries/fallen_bypass.lua OFFSETS section",
		"",
		"local FALLEN_AC_OFFSETS = {",
		"\tremotesIndex = " .. (r1 and tostring(r1.remotesIndex) or "1") .. ",",
		"\tremotesBanOffsets = {" .. (r1 and table.concat(r1.banTableOffsets, ", ") or "4") .. "},",
		"\tcharacterIndex = " .. (r2 and tostring(r2.characterIndex) or "1") .. ",",
		"\thumanoidIndex = " .. (r2 and tostring(r2.humanoidIndex) or "2") .. ",",
		"\tcharacterBanOffsets = {" .. (r2 and table.concat(r2.banTableOffsets, ", ") or "5, 8") .. "},",
		"\tcharacterClearOffsets = {" .. (r2 and table.concat(r2.clearOffsets, ", ") or "5") .. "},",
		"\tcharacterTableLengths = {" .. (r2 and tostring(r2.tableLength) or "9") .. "},",
		"\trecursiveBanIndex = " .. (r3 and tostring(r3.banIndex) or "1") .. ",",
		"}",
		"return FALLEN_AC_OFFSETS",
	}, "\n")
end

-- main
print("[FallenACDumper] waiting for Fallen Survival to finish loading...")
repeat task.wait() until game:IsLoaded()

local remotes, character, humanoid = waitForReady(60)
if not remotes or not character or not humanoid then
	error("[FallenACDumper] timed out waiting for character / remotes / assetcontainer")
end

print("[FallenACDumper] polling getgc for", POLL_SECONDS, "seconds...")
local merged = {
	remotesExact = {},
	remotesByName = {},
	characterExact = {},
	characterFuzzy = {},
	recursive = {},
	assetContainer = { closureCount = 0, samples = {} },
}

local pollDeadline = tick() + POLL_SECONDS
local pollCount = 0
while tick() < pollDeadline do
	local scan = scanGc(remotes, character, humanoid)
	mergeScan(merged, scan)
	merged.assetContainer.closureCount = math.max(merged.assetContainer.closureCount, scan.assetContainer.closureCount)
	pollCount += 1
	task.wait(POLL_INTERVAL)
end

local timestamp = os.date("%Y%m%d_%H%M%S")
local folder = string.format("%s/%s_%s", OUTPUT_ROOT, tostring(game.PlaceId), timestamp)
local report = {
	placeId = game.PlaceId,
	gameName = game.Name,
	timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
	pollSeconds = POLL_SECONDS,
	pollCount = pollCount,
	characterPath = character:GetFullName(),
	remotesPath = remotes:GetFullName(),
	scan = merged,
	recommendations = buildRecommendations({ scan = merged }),
}

local json = HttpService:JSONEncode(report)
local txt = formatTxt(report)
local snippet = buildBypassSnippet(report.recommendations)

print("[FallenACDumper] complete")
print(txt)

if writefile then
	writeOutput(folder, "offsets.json", json)
	writeOutput(folder, "offsets.txt", txt)
	writeOutput(folder, "bypass_offsets.lua", snippet)
	print("[FallenACDumper] wrote:")
	print("  " .. folder .. "/offsets.json")
	print("  " .. folder .. "/offsets.txt")
	print("  " .. folder .. "/bypass_offsets.lua")
else
	warn("[FallenACDumper] writefile unavailable — copy console output manually")
end

return report
