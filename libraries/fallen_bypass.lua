--[[
	Fallen Survival anticheat bypass — single getgc pass, minimal post-load work.

	#1 Remotes ban @ [4] only  #2 Character bans (strict/fuzzy)  #3 Fishy recursive (required)
]]

if getgenv().fishy_loaded or getgenv().FallenBypassLoaded then
	return true
end

if not (cloneref and type(cloneref) == 'function') then
	warn('[FallenBypass] cloneref is required')
	return false
end

if not getgc or not setrawmetatable then
	warn('[FallenBypass] getgc / setrawmetatable required')
	return false
end

if not LPH_OBFUSCATED then
	LPH_JIT = function(f) return f end
	LPH_JIT_MAX = LPH_JIT
	LPH_NO_VIRTUALIZE = LPH_JIT
	LPH_NO_UPVALUES = function(f) return f end
end

local Players = cloneref(game:GetService('Players'))
local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))

local Diag
pcall(function()
	local src = readfile and readfile('newvape/libraries/fallen_ac_diag.lua')
	if src then
		Diag = loadstring(src, 'fallen_ac_diag')()
	end
end)

local status = {
	Active = false,
	Strict = false,
	IsFallen = false,
	LastRun = 0,
	LastError = nil,
	RunCount = 0,
	HookCount = 0,
	Bypass1 = false,
	Bypass2 = false,
	Bypass3 = false,
	Bypass2Absent = false,
	LastDiagPath = nil,
}

local deadMeta = {
	__index = function() end,
	__newindex = function() end,
}

local hookedBans = setmetatable({}, { __mode = 'k' })

local function log(msg)
	print('[FallenBypass] ' .. msg)
end

local function publishStatus()
	getgenv().FallenBypassLoaded = status.Active
	getgenv().fishy_loaded = status.Active
	shared.FallenBypassLoaded = status.Active
	local vape = shared.vape
	if vape and vape.Libraries then
		vape.Libraries.fallenBypass = status
	end
	return status
end

local function isFallenGame()
	local modules = ReplicatedStorage:FindFirstChild('Modules')
	return modules and modules:FindFirstChild('AssetContainer') ~= nil
end

local function tblLen(tbl)
	if rawlen then return rawlen(tbl) end
	local n = 0
	for k in tbl do if type(k) == 'number' and k > n then n = k end end
	return n
end

local function instEq(a, b)
	if a == b then return true end
	if typeof(a) ~= 'Instance' or typeof(b) ~= 'Instance' then return false end
	local ok, ida, idb = pcall(function()
		return a:GetDebugId(), b:GetDebugId()
	end)
	return ok and ida and idb and ida == idb
end

local function hookBanTable(ban)
	if type(ban) ~= 'table' or hookedBans[ban] then return false end
	if pcall(setmetatable, ban, deadMeta) then
		hookedBans[ban] = true
		return true
	end
	return false
end

local function waitForLocalPlayer(timeout)
	local deadline = tick() + (timeout or 120)
	repeat
		if Players.LocalPlayer and game:IsLoaded() then
			return Players.LocalPlayer
		end
		task.wait()
	until tick() >= deadline
	return Players.LocalPlayer
end

local function waitForCharacter(player, timeout)
	timeout = timeout or 120
	local deadline = tick() + timeout
	while tick() < deadline do
		local character = player.Character
		if character then
			local root = character:FindFirstChild('HumanoidRootPart') or character:WaitForChild('HumanoidRootPart', 2)
			local humanoid = character:FindFirstChild('Humanoid') or character:WaitForChild('Humanoid', 2)
			local head = character:FindFirstChild('Head') or character:FindFirstChild('UpperTorso')
			if root and humanoid and head then
				return character
			end
		end
		task.wait(0.2)
	end
	return nil
end

local function assetContainerReady()
	for _, fn in getgc(false) do
		if type(fn) == 'function' then
			local ok, info = pcall(debug.getinfo, fn)
			if ok and info and type(info.source) == 'string' and info.source:find('AssetContainer') then
				return true
			end
		end
	end
	return false
end

local function hasCharBanTargets(character, humanoid)
	if not (character and humanoid) then return false end
	for _, tbl in getgc(true) do
		if type(tbl) ~= 'table' then continue end
		local charIdx, humIdx
		for i = 1, 32 do
			local v = rawget(tbl, i)
			if instEq(v, character) then charIdx = charIdx or i end
			if instEq(v, humanoid) then humIdx = humIdx or i end
		end
		if charIdx and humIdx then
			for i = 1, 32 do
				if i ~= charIdx and i ~= humIdx and type(rawget(tbl, i)) == 'table' then
					return true
				end
			end
		end
	end
	return false
end

local function protectRecursiveTable(recursiveTbl, banIndexValue)
	setrawmetatable(recursiveTbl, {
		__newindex = function(self, index, value)
			if type(value) == 'table' and index == banIndexValue then
				local whitelisted = false
				local id1 = rawget(value, 1)
				local id2 = rawget(value, 2)
				local id4 = rawget(value, 4)
				local len = rawlen and rawlen(value) or #value
				if id1 then
					if type(id1) == 'table' and len == 2 and rawlen and rawlen(id1) == 1 and not rawget(id1, 'n') then
						local insideVal, outsideVal = rawget(id1, 1), rawget(value, 2)
						if insideVal and outsideVal and tonumber(insideVal) and tonumber(outsideVal) then
							whitelisted = true
						end
					elseif type(id1) == 'number' and rawequal(id1, 2) then
						if len == 1 or (len == 4 and rawequal(id4, false)) then
							whitelisted = true
						end
					elseif type(id1) == 'string' and type(id2) == 'number' and rawequal(id2, 7) then
						whitelisted = true
					end
				end
				if not whitelisted then return end
			end
			return rawset(self, index, value)
		end,
	})
	return true
end

local function tryB1(tbl, remotesInst)
	local first = rawget(tbl, 1)
	local isRemotes = typeof(first) == 'Instance' and first.Name == 'Remotes'
	local remotesAt1 = remotesInst and instEq(first, remotesInst)
	if not (isRemotes or remotesAt1) then return false end
	-- source/bypas.txt: ban table at [4] ONLY — never hook sibling slots
	return hookBanTable(rawget(tbl, 4))
end

local function tryB2(tbl, character, humanoid)
	local charIdx, humIdx
	for i = 1, 32 do
		local v = rawget(tbl, i)
		if instEq(v, character) then charIdx = charIdx or i end
		if instEq(v, humanoid) then humIdx = humIdx or i end
	end
	if not (charIdx and humIdx) then return false end

	local hooked = false
	local len, seqLen = tblLen(tbl), #tbl

	if charIdx == 1 and humIdx == 2 and (len == 9 or seqLen == 9) then
		if hookBanTable(rawget(tbl, 8)) then hooked = true end
		if hookBanTable(rawget(tbl, 5)) then
			pcall(rawset, tbl, 5, nil)
			hooked = true
		end
	end

	for i = 1, 32 do
		if i ~= charIdx and i ~= humIdx then
			local ban = rawget(tbl, i)
			if type(ban) == 'table' and ban ~= tbl and not instEq(ban, character) and not instEq(ban, humanoid) then
				if hookBanTable(ban) then
					if i == 5 then pcall(rawset, tbl, 5, nil) end
					hooked = true
				end
			end
		end
	end
	return hooked
end

local function writeDumpAsync(character, reason)
	if not writefile or getgenv().FallenBypassNoDiag then return end
	task.spawn(function()
		task.wait(3)
		if not Diag then return end
		pcall(function()
			local hum = character and character:FindFirstChildOfClass('Humanoid')
			local report = Diag.scan(character, hum, status)
			report.dumpReason = reason
			local path = Diag.write(report)
			if path then status.LastDiagPath = path end
		end)
	end)
end

local function runBypassPass(character)
	status.RunCount = status.RunCount + 1
	status.LastRun = tick()
	status.IsFallen = isFallenGame()

	local humanoid = character and character:FindFirstChildOfClass('Humanoid')
	local remotesInst = ReplicatedStorage:FindFirstChild('Remotes')
	local b1, b2, b3 = false, false, 0
	local scanned = 0

	local ok, err = pcall(function()
		LPH_JIT_MAX(function()
			for _, tbl in getgc(true) do
				scanned = scanned + 1
				if scanned % 8000 == 0 then task.wait() end
				if type(tbl) ~= 'table' then continue end

				if tryB1(tbl, remotesInst) then b1 = true end
				if character and humanoid and tryB2(tbl, character, humanoid) then b2 = true end

				if not (getrawmetatable and getrawmetatable(tbl)) then
					local foundIndex, foundRecursive = false, false
					for _, value in tbl do
						if type(value) == 'number' and rawequal(value, 1) then foundIndex = value end
						if rawequal(value, tbl) then foundRecursive = value end
					end
					if foundIndex and foundRecursive and rawequal(rawget(tbl, foundIndex), nil) then
						if protectRecursiveTable(foundRecursive, foundIndex) then
							b3 = b3 + 1
						end
					end
				end
			end
		end)()
	end)

	if not ok then status.LastError = tostring(err) end

	status.Bypass1 = b1 or status.Bypass1
	status.Bypass2 = b2 or status.Bypass2
	if b3 > 0 then
		status.Bypass3 = true
		status.HookCount = math.max(status.HookCount, b3)
	end
	status.Active = status.Bypass3
	status.Strict = status.Bypass1 and status.Bypass2 and status.Bypass3
	if status.Active then status.LastError = nil end

	publishStatus()
	log(string.format('pass #%d (%dk tbl) B1=%s B2=%s B3=%s hooks=%d',
		status.RunCount, math.floor(scanned / 1000), tostring(status.Bypass1), tostring(status.Bypass2),
		tostring(status.Bypass3), status.HookCount))
	return status.Active
end

local function waitForAcInit(character, timeout)
	local deadline = tick() + (timeout or 45)
	local hum = character:FindFirstChildOfClass('Humanoid')
	repeat
		pcall(function() ReplicatedStorage:WaitForChild('Remotes', 2) end)
		pcall(function() character:WaitForChild('InventoryController', 2) end)
		if assetContainerReady() then return true end
		if status.Bypass1 or status.Bypass3 then return true end
		task.wait(0.5)
	until tick() >= deadline
	return assetContainerReady()
end

status.Run = function()
	local char = Players.LocalPlayer and Players.LocalPlayer.Character
	if char then runBypassPass(char) end
	return status.Active
end

status.Diagnose = function(character)
	task.spawn(function()
		if Diag then
			local ok, path = pcall(Diag.run, character or Players.LocalPlayer.Character, status)
			if ok and path then status.LastDiagPath = path end
		end
	end)
	return status.LastDiagPath
end

status.WaitForCharacter = waitForCharacter
status.IsFallenGame = isFallenGame
publishStatus()

local player = waitForLocalPlayer(120)
if not player then
	status.LastError = 'LocalPlayer timeout'
	publishStatus()
	return false
end

status.IsFallen = isFallenGame()
log('game detected fallen=' .. tostring(status.IsFallen))

local character = waitForCharacter(player, status.IsFallen and 60 or 20)
if not character then
	status.LastError = 'Character timeout'
	if status.IsFallen then
		player:Kick('[Vape] Spawn in fully before loading.')
	end
	publishStatus()
	return false
end

if status.IsFallen then
	log('waiting for AC init...')
	waitForAcInit(character, 45)
	task.wait(0.5)
end

log('running bypass (single gc pass)...')
runBypassPass(character)

if not status.Bypass3 and status.IsFallen then
	for _ = 1, 8 do
		task.wait(0.5)
		runBypassPass(character)
		if status.Bypass3 then break end
	end
end

if not status.Bypass3 and status.IsFallen then
	writeDumpAsync(character, 'B3_failed')
	player:Kick('[Vape] Fishy bypass (#3) failed — rejoin when loaded')
	return false
end

local humanoid = character:FindFirstChildOfClass('Humanoid')
if status.IsFallen and not status.Bypass2 then
	if hasCharBanTargets(character, humanoid) then
		log('B2 ban tables present — polling...')
		local deadline = tick() + 15
		while tick() < deadline and not status.Bypass2 do
			task.wait(0.5)
			runBypassPass(character)
		end
	else
		status.Bypass2Absent = true
		log('B2 legacy absent (char GC len=2 only) — fishy-only like V3')
	end
end

if status.IsFallen and not status.Bypass2 and hasCharBanTargets(character, humanoid) then
	writeDumpAsync(character, 'B2_failed_targets_present')
	player:Kick('[Vape] B2 bypass failed — ban tables found but not hooked. See fallen_ac_dumps/latest.txt')
	return false
end

log(string.format('bypass ready strict=%s absent=%s', tostring(status.Strict), tostring(status.Bypass2Absent)))

-- ponytail: no sync getgc dump / no 2s background rescans — those froze/crashed after bootstrap
if getgenv().FallenBypassDiag then
	writeDumpAsync(character, 'ok')
end

player.CharacterAdded:Connect(function(char)
	task.wait(2)
	char:WaitForChild('Humanoid', 10)
	pcall(function() char:WaitForChild('InventoryController', 20) end)
	runBypassPass(char)
end)

return status.Active
