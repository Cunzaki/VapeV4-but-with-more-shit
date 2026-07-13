--[[
	Fallen Survival anticheat bypass — combined stack from reference/bypas.txt + fishy_bypass.txt.

	1. Ban table #1 — Remotes GC table index 4
	2. Ban table #2 — character/humanoid 9-entry GC table indices 5 + 8
	3. Recursive self-referencing table hook (fishy / V3)
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

local status = {
	Active = false,
	IsFallen = false,
	LastRun = 0,
	LastError = nil,
	RunCount = 0,
	HookCount = 0,
	Bypass1 = false,
	Bypass2 = false,
	Bypass3 = false,
}

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
	local character = player.Character
	if character and character:FindFirstChild('HumanoidRootPart') and character:FindFirstChild('Humanoid') then
		return character
	end
	while tick() < deadline do
		character = player.Character
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

local deadMeta = {
	__index = function() end,
	__newindex = function() end,
}

-- Bypass #1: Remotes ban table (reference/bypas.txt, source.lua)
local function neutralizeRemotesBanTable()
	for _, tbl in getgc(true) do
		if type(tbl) == 'table' then
			local first = rawget(tbl, 1)
			if typeof(first) == 'Instance' and first.Name == 'Remotes' then
				local banTable = rawget(tbl, 4)
				if type(banTable) == 'table' then
					setmetatable(banTable, deadMeta)
					return true
				end
			end
		end
	end
	return false
end

-- Bypass #2: per-character 9-entry ban tables
local function neutralizeCharacterBanTables(character, humanoid)
	if not (character and humanoid) then
		return false
	end
	for _, tbl in getgc(true) do
		if type(tbl) == 'table' and rawget(tbl, 1) == character and rawget(tbl, 2) == humanoid then
			local len = rawlen and rawlen(tbl) or #tbl
			if len == 9 then
				local ban1 = rawget(tbl, 8)
				local ban2 = rawget(tbl, 5)
				if type(ban1) == 'table' then
					setmetatable(ban1, deadMeta)
				end
				if type(ban2) == 'table' then
					setmetatable(ban2, deadMeta)
					rawset(tbl, 5, nil)
				end
				return true
			end
		end
	end
	return false
end

-- Bypass #3: recursive self-referencing table hook (fishy)
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
						local insideVal = rawget(id1, 1)
						local outsideVal = rawget(value, 2)
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

				if not whitelisted then
					return
				end
			end
			return rawset(self, index, value)
		end,
	})
	return true
end

local function scanRecursiveBypass()
	local hooked = 0
	LPH_JIT_MAX(function()
		for _, tbl in getgc(true) do
			if type(tbl) ~= 'table' then
				-- skip
			elseif getrawmetatable and getrawmetatable(tbl) then
				-- skip
			else
				local foundIndex, foundRecursive = false, false
				for _, value in tbl do
					if type(value) == 'number' and rawequal(value, 1) then
						foundIndex = value
					end
					if rawequal(value, tbl) then
						foundRecursive = value
					end
				end
				if foundIndex and foundRecursive and rawequal(rawget(tbl, foundIndex), nil) then
					if protectRecursiveTable(foundRecursive, foundIndex) then
						hooked = hooked + 1
					end
				end
			end
		end
	end)()
	return hooked > 0, hooked
end

local function runBypassPass(character)
	status.RunCount = status.RunCount + 1
	status.LastRun = tick()
	status.IsFallen = isFallenGame()

	local humanoid = character and character:FindFirstChildOfClass('Humanoid')

	local ok, err = pcall(function()
		status.Bypass1 = neutralizeRemotesBanTable() or status.Bypass1
		if character and humanoid then
			status.Bypass2 = neutralizeCharacterBanTables(character, humanoid) or status.Bypass2
		end
		local success, count = scanRecursiveBypass()
		if success then
			status.Bypass3 = true
			status.HookCount = math.max(status.HookCount, count or 0)
		end
	end)

	if not ok then
		status.LastError = tostring(err)
		status.Active = false
		publishStatus()
		return false
	end

	-- ponytail: Fallen needs all three; #2 re-runs on respawn
	if status.IsFallen then
		status.Active = status.Bypass1 and status.Bypass2 and status.Bypass3
	else
		status.Active = status.Bypass3
	end
	if status.Active then
		status.LastError = nil
	end

	publishStatus()
	return status.Active
end

local function runBypassWithRetry(character, maxWait)
	local deadline = tick() + (maxWait or 30)
	repeat
		if runBypassPass(character) then
			return true
		end
		task.wait(0.25)
	until tick() >= deadline
	return status.Active
end

status.Run = function(maxWait)
	local player = Players.LocalPlayer
	local char = player and player.Character
	return runBypassWithRetry(char, maxWait)
end

status.WaitForCharacter = waitForCharacter
status.IsFallenGame = isFallenGame
publishStatus()

local function bootstrap()
	local player = waitForLocalPlayer(120)
	if not player then
		status.LastError = 'LocalPlayer timeout'
		publishStatus()
		return nil
	end

	status.IsFallen = isFallenGame()

	local character = waitForCharacter(player, 120)
	if not character then
		status.LastError = 'Character timeout'
		if status.IsFallen then
			player:Kick('[Vape] Anticheat bypass — spawn in fully before loading.')
		end
		publishStatus()
		return player
	end

	local bypassed = runBypassWithRetry(character, status.IsFallen and 45 or 15)
	if not bypassed and status.IsFallen then
		player:Kick('[Vape] Anticheat bypass failed — rejoin when fully loaded.')
	end

	return player
end

task.spawn(function()
	local player = bootstrap()
	if player then
		player.CharacterAdded:Connect(function(char)
			task.wait(0.5)
			local hum = char:WaitForChild('Humanoid', 10)
			if hum then
				runBypassWithRetry(char, 20)
			end
		end)
	end
end)

return status.Active
