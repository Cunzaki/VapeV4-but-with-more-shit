--[[
	Fallen Survival anticheat bypass — one GC pass per attempt, non-blocking bootstrap.

	#1 Remotes ban tables  #2 Character ban tables  #3 Fishy recursive (required)
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
	LastDiagPath = nil,
}

local deadMeta = {
	__index = function() end,
	__newindex = function() end,
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

-- Single getgc pass for B1 + B2 + B3 (ponytail: one scan, yield every 8k tables)
local function runBypassPass(character)
	status.RunCount = status.RunCount + 1
	status.LastRun = tick()
	status.IsFallen = isFallenGame()

	local humanoid = character and character:FindFirstChildOfClass('Humanoid')
	local remotesInst = ReplicatedStorage:FindFirstChild('Remotes')
	local b1, b2, b3 = status.Bypass1, status.Bypass2, 0
	local scanned = 0

	local ok, err = pcall(function()
		LPH_JIT_MAX(function()
			for _, tbl in getgc(true) do
				scanned = scanned + 1
				if scanned % 8000 == 0 then
					task.wait()
				end
				if type(tbl) ~= 'table' then
					-- skip
				else
					-- B1: Remotes context
					local remotesIndex
					if remotesInst then
						for i = 1, 32 do
							if rawget(tbl, i) == remotesInst then
								remotesIndex = i
								break
							end
						end
					end
					local first = rawget(tbl, 1)
					if not remotesIndex and typeof(first) == 'Instance' and first.Name == 'Remotes' then
						remotesIndex = 1
					end
					if remotesIndex then
						for i = 1, 32 do
							if i ~= remotesIndex then
								local ban = rawget(tbl, i)
								if type(ban) == 'table' and ban ~= tbl then
									pcall(setmetatable, ban, deadMeta)
									b1 = true
								end
							end
						end
					end

					-- B2: Character context
					if character and humanoid and rawget(tbl, 1) == character and rawget(tbl, 2) == humanoid then
						for _, idx in { 5, 8 } do
							local ban = rawget(tbl, idx)
							if type(ban) == 'table' then
								pcall(setmetatable, ban, deadMeta)
								if idx == 5 then pcall(rawset, tbl, 5, nil) end
								b2 = true
							end
						end
						for i = 3, 16 do
							local v = rawget(tbl, i)
							if type(v) == 'table' and i ~= 5 and i ~= 8 then
								pcall(setmetatable, v, deadMeta)
								b2 = true
							end
						end
					end

					-- B3: Fishy recursive
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
			end
		end)()
	end)

	if not ok then
		status.LastError = tostring(err)
	end

	status.Bypass1 = b1
	status.Bypass2 = b2
	if b3 > 0 then
		status.Bypass3 = true
		status.HookCount = math.max(status.HookCount, b3)
	end
	status.Active = status.Bypass3
	status.Strict = status.Bypass1 and status.Bypass2 and status.Bypass3
	if status.Active then
		status.LastError = nil
	end

	publishStatus()
	log(string.format('pass #%d (%dk tbl) B1=%s B2=%s B3=%s hooks=%d',
		status.RunCount, math.floor(scanned / 1000), tostring(status.Bypass1), tostring(status.Bypass2),
		tostring(status.Bypass3), status.HookCount))
	return status.Active
end

local function runDiagnosticsAsync(character)
	if not Diag then return end
	task.spawn(function()
		task.wait(1)
		local ok, path = pcall(Diag.run, character, status)
		if ok and path then
			status.LastDiagPath = path
		end
	end)
end

local function startBackgroundStrictPass(player)
	task.spawn(function()
		local deadline = tick() + 90
		local lastB1, lastB2 = status.Bypass1, status.Bypass2
		while tick() < deadline and not status.Strict do
			task.wait(5)
			local char = player.Character
			if char then
				runBypassPass(char)
				if (status.Bypass1 and not lastB1) or (status.Bypass2 and not lastB2) then
					runDiagnosticsAsync(char)
					lastB1, lastB2 = status.Bypass1, status.Bypass2
				end
				if status.Strict then
					log('strict bypass complete')
					local vape = shared.vape
					if vape and vape.CreateNotification then
						vape:CreateNotification('Fallen Bypass', 'Full bypass (B1+B2+B3)', 8, 'info')
					end
					break
				end
			end
		end
	end)
end

status.Run = function()
	local player = Players.LocalPlayer
	local char = player and player.Character
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

-- Brief yield for AC init — no GC polling loop
if status.IsFallen then
	task.wait(1)
end

log('running bypass (single gc pass)...')
runBypassPass(character)

-- Retry B3 only if needed (light, max 5 attempts)
if not status.Bypass3 and status.IsFallen then
	for _ = 1, 5 do
		task.wait(0.5)
		runBypassPass(character)
		if status.Bypass3 then break end
	end
end

if not status.Bypass3 and status.IsFallen then
	player:Kick('[Vape] Fishy bypass (#3) failed — rejoin when loaded')
	return false
end

if status.IsFallen and not status.Strict then
	log('partial bypass ok — B1/B2 retry in background')
	local vape = shared.vape
	if vape and vape.CreateNotification then
		vape:CreateNotification('Fallen Bypass', 'B3 ok — hardening B1/B2 in background', 8, 'info')
	end
	startBackgroundStrictPass(player)
end

runDiagnosticsAsync(character)

player.CharacterAdded:Connect(function(char)
	task.wait(1)
	local hum = char:WaitForChild('Humanoid', 10)
	if hum then
		runBypassPass(char)
	end
end)

return status.Active
