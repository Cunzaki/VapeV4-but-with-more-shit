--[[
	Fallen Survival anticheat bypass (Fallen Ultimate V3 / fishy style).

	Only hooks recursive self-referencing GC ban tables — NOT legacy 0x01/0x02 tables.
	Source: reference/fishy_bypass.txt, Fallen Ultimate V3.lua
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

local function runBypassPass()
	status.RunCount = status.RunCount + 1
	status.LastRun = tick()
	status.IsFallen = isFallenGame()

	local ok, bypassed, hookCount = pcall(function()
		local success, count = scanRecursiveBypass()
		return success, count
	end)

	if not ok then
		status.LastError = tostring(bypassed)
		status.Active = false
		publishStatus()
		return false
	end

	if bypassed then
		status.Active = true
		status.HookCount = math.max(status.HookCount, hookCount or 0)
		status.LastError = nil
	else
		status.Active = status.HookCount > 0
	end

	publishStatus()
	return status.Active
end

local function runBypassWithRetry(maxWait)
	local deadline = tick() + (maxWait or 30)
	repeat
		if runBypassPass() then
			return true
		end
		task.wait(0.25)
	until tick() >= deadline
	return status.Active
end

status.Run = function(maxWait)
	return runBypassWithRetry(maxWait)
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

	local bypassed = runBypassWithRetry(status.IsFallen and 45 or 15)
	if not bypassed and status.IsFallen then
		player:Kick('[Vape] Anticheat bypass failed — rejoin when fully loaded.')
	end

	return player
end

task.spawn(function()
	local player = bootstrap()
	if player then
		player.CharacterAdded:Connect(function()
			task.wait(0.5)
			runBypassWithRetry(20)
		end)
	end
end)

return status.Active
