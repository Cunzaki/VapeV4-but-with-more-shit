--[[
	Fallen Survival anticheat bypass (Fallen Ultimate V3 / fishy only).
	Runs synchronously from main.lua before universal and game scripts.
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

local function runBypassPass()
	status.RunCount = status.RunCount + 1
	status.LastRun = tick()
	local hooked = 0
	local scanned = 0

	local ok, err = pcall(function()
		LPH_JIT_MAX(function()
			for _, tbl in getgc(true) do
				scanned = scanned + 1
				if scanned % 8000 == 0 then task.wait() end
				if type(tbl) ~= 'table' then continue end
				if getrawmetatable and getrawmetatable(tbl) then continue end

				local foundIndex, foundRecursive = false, false
				for _, value in tbl do
					if type(value) == 'number' and rawequal(value, 1) then foundIndex = value end
					if rawequal(value, tbl) then foundRecursive = value end
				end
				if foundIndex and foundRecursive and rawequal(rawget(tbl, foundIndex), nil) then
					if protectRecursiveTable(foundRecursive, foundIndex) then
						hooked = hooked + 1
					end
				end
			end
		end)()
	end)

	if not ok then
		status.LastError = tostring(err)
	elseif hooked > 0 then
		status.LastError = nil
	end

	if hooked > 0 then
		status.HookCount = math.max(status.HookCount, hooked)
		status.Active = true
	end

	publishStatus()
	log(string.format('pass #%d (%dk tbl) hooks=%d active=%s',
		status.RunCount, math.floor(scanned / 1000), status.HookCount, tostring(status.Active)))
	return status.Active
end

status.Run = function()
	if not status.IsFallen then return false end
	runBypassPass()
	return status.Active
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
if not status.IsFallen then
	log('not Fallen — skipped')
	publishStatus()
	return true
end

log('game detected fallen=true')

local character = waitForCharacter(player, 60)
if not character then
	status.LastError = 'Character timeout'
	player:Kick('[Vape] Spawn in fully before loading.')
	publishStatus()
	return false
end

log('running fishy bypass...')
runBypassPass()

if not status.Active then
	for _ = 1, 8 do
		task.wait(0.5)
		runBypassPass()
		if status.Active then break end
	end
end

if not status.Active then
	player:Kick('[Vape] Anticheat bypass failed — rejoin when fully loaded')
	return false
end

log('bypass ready hooks=' .. tostring(status.HookCount))

player.CharacterAdded:Connect(function(char)
	task.wait(1)
	char:WaitForChild('Humanoid', 10)
	runBypassPass()
end)

return status.Active
