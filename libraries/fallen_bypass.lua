--[[
	Fallen Survival anticheat bypass — combined stack + diagnostics.

	#1 Remotes ban tables (all table offsets, not only index 4)
	#2 Character/humanoid ban tables (any length with tables at 5/8)
	#3 Fishy recursive self-table hook (required for Active)
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

local deadMeta = {
	__index = function() end,
	__newindex = function() end,
}

local function neutralizeRemotesBanTable()
	local hooked = false
	for _, tbl in getgc(true) do
		if type(tbl) == 'table' then
			local first = rawget(tbl, 1)
			if typeof(first) == 'Instance' and first.Name == 'Remotes' then
				for i = 1, 32 do
					if i ~= 1 then
						local banTable = rawget(tbl, i)
						if type(banTable) == 'table' and banTable ~= tbl then
							pcall(setmetatable, banTable, deadMeta)
							hooked = true
						end
					end
				end
			end
		end
	end
	return hooked
end

local function neutralizeCharacterBanTables(character, humanoid)
	if not (character and humanoid) then
		return false
	end
	local hooked = false
	for _, tbl in getgc(true) do
		if type(tbl) == 'table' and rawget(tbl, 1) == character and rawget(tbl, 2) == humanoid then
			for _, idx in { 5, 8 } do
				local ban = rawget(tbl, idx)
				if type(ban) == 'table' then
					pcall(setmetatable, ban, deadMeta)
					if idx == 5 then
						pcall(rawset, tbl, 5, nil)
					end
					hooked = true
				end
			end
			-- ponytail: also hook any other table slots past humanoid
			for i = 3, 16 do
				local v = rawget(tbl, i)
				if type(v) == 'table' and i ~= 5 and i ~= 8 then
					pcall(setmetatable, v, deadMeta)
					hooked = true
				end
			end
		end
	end
	return hooked
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
			if type(tbl) == 'table' and not (getrawmetatable and getrawmetatable(tbl)) then
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

local function runDiagnostics(character)
	if not Diag then return end
	local ok, path = pcall(Diag.run, character, status)
	if ok and path then
		status.LastDiagPath = path
	end
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
	end

	-- Fishy (#3) is required — V3 reference only used this for Active
	status.Active = status.Bypass3
	status.Strict = status.Bypass1 and status.Bypass2 and status.Bypass3
	if status.Active then
		status.LastError = nil
	end

	publishStatus()
	log(string.format('pass #%d B1=%s B2=%s B3=%s hooks=%d active=%s strict=%s',
		status.RunCount, tostring(status.Bypass1), tostring(status.Bypass2), tostring(status.Bypass3),
		status.HookCount, tostring(status.Active), tostring(status.Strict)))
	return status.Active
end

local function runBypassWithRetry(character, maxWait)
	local deadline = tick() + (maxWait or 60)
	repeat
		if runBypassPass(character) then
			runDiagnostics(character)
			return true
		end
		task.wait(0.25)
	until tick() >= deadline
	runDiagnostics(character)
	return status.Active
end

status.Run = function(maxWait)
	local player = Players.LocalPlayer
	local char = player and player.Character
	return runBypassWithRetry(char, maxWait)
end

status.Diagnose = function(character)
	runDiagnostics(character or (Players.LocalPlayer and Players.LocalPlayer.Character))
	return status.LastDiagPath
end

status.WaitForCharacter = waitForCharacter
status.IsFallenGame = isFallenGame
publishStatus()

-- Block main.lua until bypass finishes (sync bootstrap on Fallen)
local player = waitForLocalPlayer(120)
if not player then
	status.LastError = 'LocalPlayer timeout'
	publishStatus()
	return false
end

status.IsFallen = isFallenGame()
log('game detected fallen=' .. tostring(status.IsFallen))

local character = waitForCharacter(player, status.IsFallen and 120 or 30)
if not character then
	status.LastError = 'Character timeout'
	runDiagnostics(nil)
	if status.IsFallen then
		player:Kick('[Vape] Spawn in fully before loading. See fallen_ac_dumps/latest.txt')
	end
	publishStatus()
	return false
end

local maxWait = status.IsFallen and 90 or 20
log('scanning gc (up to ' .. maxWait .. 's)...')
local bypassed = runBypassWithRetry(character, maxWait)

if not bypassed and status.IsFallen then
	local path = status.LastDiagPath or 'fallen_ac_dumps/latest.txt'
	player:Kick('[Vape] Fishy bypass (#3) failed — see ' .. path)
elseif status.IsFallen and not status.Strict then
	log('WARN: partial bypass — B1=' .. tostring(status.Bypass1) .. ' B2=' .. tostring(status.Bypass2) .. ' (continuing)')
	local vape = shared.vape
	if vape and vape.CreateNotification then
		vape:CreateNotification('Fallen Bypass', 'Partial: B1=' .. tostring(status.Bypass1) .. ' B2=' .. tostring(status.Bypass2) .. ' B3=ok', 10, 'warning')
	end
end

player.CharacterAdded:Connect(function(char)
	task.wait(0.5)
	local hum = char:WaitForChild('Humanoid', 10)
	if hum then
		runBypassWithRetry(char, 25)
	end
end)

return status.Active
