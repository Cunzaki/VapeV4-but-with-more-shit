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

local function tblLen(tbl)
	if rawlen then return rawlen(tbl) end
	local n = 0
	for k in tbl do if type(k) == 'number' and k > n then n = k end end
	return n
end

local function writeQuickDump(character, reason)
	if not writefile then return end
	local hum = character and character:FindFirstChildOfClass('Humanoid')
	local lines = {
		'=== Fallen Bypass Quick Dump ===',
		os.date('!%Y-%m-%dT%H:%M:%SZ'),
		'reason=' .. tostring(reason),
		string.format('B1=%s B2=%s B3=%s hooks=%d runs=%d', tostring(status.Bypass1), tostring(status.Bypass2),
			tostring(status.Bypass3), status.HookCount, status.RunCount),
		'',
	}
	local n = 0
	for _, tbl in getgc(true) do
		if type(tbl) == 'table' and character and hum then
			if rawget(tbl, 1) == character and rawget(tbl, 2) == hum then
				n = n + 1
				lines[#lines + 1] = string.format('charTable#%d len=%d idx5=%s idx8=%s',
					n, tblLen(tbl), type(rawget(tbl, 5)), type(rawget(tbl, 8)))
			end
			if typeof(rawget(tbl, 1)) == 'Instance' and rawget(tbl, 1).Name == 'Remotes' then
				lines[#lines + 1] = string.format('remotesTable len=%d idx4=%s', tblLen(tbl), type(rawget(tbl, 4)))
			end
		end
	end
	if n == 0 then lines[#lines + 1] = 'no character GC table found' end
	pcall(function()
		if isfolder and not isfolder('fallen_ac_dumps') then makefolder('fallen_ac_dumps') end
		writefile('fallen_ac_dumps/latest.txt', table.concat(lines, '\n'))
	end)
	status.LastDiagPath = 'fallen_ac_dumps/latest.txt'
end
local function runBypassPass(character)
	status.RunCount = status.RunCount + 1
	status.LastRun = tick()
	status.IsFallen = isFallenGame()

	local humanoid = character and character:FindFirstChildOfClass('Humanoid')
	local b1, b2, b3 = false, false, 0
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
					local first = rawget(tbl, 1)

					-- B1: source/bypas.txt — Remotes at [1], ban table at [4] only
					if typeof(first) == 'Instance' and first.Name == 'Remotes' then
						local ban = rawget(tbl, 4)
						if type(ban) == 'table' then
							pcall(setmetatable, ban, deadMeta)
							b1 = true
						end
					end

					-- B2: source — char[1] hum[2] len==9, ban at [8] and [5], nil [5]
					if character and humanoid and first == character and rawget(tbl, 2) == humanoid then
						if tblLen(tbl) == 9 then
							local ban1 = rawget(tbl, 8)
							local ban2 = rawget(tbl, 5)
							if type(ban1) == 'table' then
								pcall(setmetatable, ban1, deadMeta)
								b2 = true
							end
							if type(ban2) == 'table' then
								pcall(setmetatable, ban2, deadMeta)
								pcall(rawset, tbl, 5, nil)
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

	status.Bypass1 = b1 or status.Bypass1
	status.Bypass2 = b2 or status.Bypass2
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

-- Brief yield + wait for game controllers (B2 ban table appears after AC init)
if status.IsFallen then
	pcall(function()
		ReplicatedStorage:WaitForChild('Remotes', 15)
	end)
	pcall(function()
		character:WaitForChild('InventoryController', 30)
	end)
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
	writeQuickDump(character, 'B3_failed')
	player:Kick('[Vape] Fishy bypass (#3) failed — rejoin when loaded')
	return false
end

-- B2 required before Vape loads — Iridescent 0x02 (instant ban if skipped)
if status.IsFallen and not status.Bypass2 then
	log('waiting for B2 (character ban table len=9)...')
	local deadline = tick() + 60
	while tick() < deadline and not status.Bypass2 do
		task.wait(0.5)
		runBypassPass(character)
	end
end

if status.IsFallen and not status.Bypass2 then
	writeQuickDump(character, 'B2_failed_0x02')
	player:Kick('[Vape] B2 bypass failed (0x02) — fully spawn in before inject. See fallen_ac_dumps/latest.txt')
	return false
end

log(string.format('bypass ready strict=%s', tostring(status.Strict)))
writeQuickDump(character, 'ok')
runDiagnosticsAsync(character)

player.CharacterAdded:Connect(function(char)
	task.wait(1)
	char:WaitForChild('Humanoid', 10)
	pcall(function() char:WaitForChild('InventoryController', 30) end)
	for _ = 1, 20 do
		runBypassPass(char)
		if status.Bypass2 and status.Bypass3 then break end
		task.wait(0.5)
	end
end)

return status.Active
