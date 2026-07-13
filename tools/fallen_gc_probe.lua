--[[
	Fallen Survival GC offset probe.
	Run in-game AFTER spawning to dump current ban-table signatures.

	Usage:
		getgenv().FallenBypassDebug = true
		loadstring(readfile("tools/fallen_gc_probe.lua"), "fallen_gc_probe")()
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local client = Players.LocalPlayer
local output = {
	placeId = game.PlaceId,
	timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
	remotesFolder = nil,
	remotesContexts = {},
	characterContexts = {},
	recursiveContexts = {},
	assetContainerClosures = 0,
}

local function tableLength(tbl)
	if rawlen then return rawlen(tbl) end
	local n = 0
	for k in tbl do
		if type(k) == "number" and k > n then n = k end
	end
	return n
end

local function describeValue(value)
	local t = typeof(value)
	if t == "Instance" then
		return string.format("Instance(%s %s)", value.ClassName, value:GetFullName())
	end
	if t == "table" then
		return string.format("table(len=%s)", tostring(tableLength(value)))
	end
	return string.format("%s(%s)", t, tostring(value))
end

local function snapshotTable(tbl, maxIndex)
	local snap = {}
	for i = 1, maxIndex or 16 do
		local v = rawget(tbl, i)
		if v ~= nil then
			snap[tostring(i)] = describeValue(v)
		end
	end
	return snap
end

repeat task.wait() until game:IsLoaded()
repeat task.wait() until client.Character and client.Character:FindFirstChild("Humanoid")

local remotes = ReplicatedStorage:WaitForChild("Remotes", 30)
output.remotesFolder = remotes and remotes:GetFullName() or nil

local character = client.Character
local humanoid = character:FindFirstChildOfClass("Humanoid")

for _, tbl in getgc(true) do
	if type(tbl) ~= "table" then continue end

	for i = 1, 24 do
		if rawget(tbl, i) == remotes then
			table.insert(output.remotesContexts, {
				remotesIndex = i,
				length = tableLength(tbl),
				snapshot = snapshotTable(tbl, 16),
			})
			break
		end
	end

	if character and humanoid and rawget(tbl, 1) == character and rawget(tbl, 2) == humanoid then
		table.insert(output.characterContexts, {
			length = tableLength(tbl),
			snapshot = snapshotTable(tbl, 16),
		})
	end

	if getrawmetatable and not getrawmetatable(tbl) then
		local foundIndex, foundRecursive = false, false
		for _, value in tbl do
			if type(value) == "number" and rawequal(value, 1) then foundIndex = value end
			if rawequal(value, tbl) then foundRecursive = value end
		end
		if foundIndex and foundRecursive and rawequal(rawget(tbl, foundIndex), nil) then
			table.insert(output.recursiveContexts, {
				length = tableLength(tbl),
				snapshot = snapshotTable(tbl, 8),
			})
		end
	end
end

for _, func in getgc(false) do
	if type(func) ~= "function" then continue end
	local info = (getinfo or debug.getinfo)(func)
	if info and info.source and info.source:find("AssetContainer") then
		output.assetContainerClosures += 1
	end
end

local encoded = HttpService:JSONEncode(output)
print("[FallenGCProbe]\n" .. encoded)

if writefile then
	local path = "fallen_gc_probe_" .. tostring(game.PlaceId) .. ".json"
	writefile(path, encoded)
	print("[FallenGCProbe] wrote " .. path)
end

return output
