--[[
	Fallen Survival anticheat bypass for Vape.
	Must run before universal / GUI modules load.

	Stage 0x01 failed when this ran too early — AssetContainer must be required
	(StateAssetController line ~58) before Remotes ban tables exist in getgc.
]]

if getgenv().FallenBypassLoaded then
	return true
end

if not (cloneref and type(cloneref) == 'function') then
	warn('[FallenBypass] cloneref is required')
	return false
end

if not getgc then
	warn('[FallenBypass] getgc is required')
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

local getinfo_fn = getinfo or (debug and debug.getinfo)
local getprotos_fn = (debug and debug.getprotos) or getprotos
local getproto_fn = (debug and debug.getproto) or getproto
local getconstants_fn = (debug and debug.getconstants) or getconstants
local getupvalues_fn = (debug and debug.getupvalues) or getupvalues
local islclosure_fn = islclosure or (debug and debug.islclosure)
local isexecutorclosure_fn = isexecutorclosure or function() return false end
local hookfunction_fn = hookfunction or replaceclosure
local setrawmetatable_fn = setrawmetatable or setmetatable
local DEBUG = getgenv().FallenBypassDebug == true

local function debugLog(...)
	if DEBUG then
		warn('[FallenBypass]', ...)
	end
end

if not (getinfo_fn and getprotos_fn and getproto_fn and getconstants_fn and hookfunction_fn) then
	warn('[FallenBypass] Missing hook/debug APIs')
	return false
end

LPH_NO_VIRTUALIZE(function()
	repeat task.wait() until Players.LocalPlayer ~= nil and game:IsLoaded()
end)()

local Client = Players.LocalPlayer

local function validateFallenGame()
	local modules = ReplicatedStorage:FindFirstChild('Modules')
	return modules and modules:FindFirstChild('AssetContainer')
end

if not validateFallenGame() then
	warn('[FallenBypass] AssetContainer missing — not Fallen Survival?')
	return false
end

local function tableLength(tbl)
	if rawlen then
		return rawlen(tbl)
	end
	local n = 0
	for k in tbl do
		if type(k) == 'number' and k > n then
			n = k
		end
	end
	return n
end

local function neutralizeBanTable(tbl)
	if type(tbl) ~= 'table' then
		return false
	end
	setmetatable(tbl, {
		__index = function() end,
		__newindex = function() end
	})
	return true
end

local function assetContainerInGc()
	for _, func in getgc(false) do
		if type(func) ~= 'function' then continue end
		local info = getinfo_fn(func)
		if info and info.source and info.source:find('AssetContainer') then
			return true
		end
	end
	return false
end

local function waitForAnticheatInit(maxWait)
	local deadline = tick() + maxWait
	local modules = ReplicatedStorage:WaitForChild('Modules', maxWait)
	modules:WaitForChild('AssetContainer', maxWait)
	local remotes = ReplicatedStorage:WaitForChild('Remotes', maxWait)
	if not remotes then
		return nil
	end

	local character = Client.Character or Client.CharacterAdded:Wait()
	character:WaitForChild('Humanoid', maxWait)
	character:WaitForChild('HumanoidRootPart', maxWait)

	while tick() < deadline do
		if character:FindFirstChild('InventoryController') or character:FindFirstChild('StateController') then
			debugLog('character controllers ready')
			return remotes
		end
		if assetContainerInGc() then
			debugLog('AssetContainer closures in gc')
			return remotes
		end
		task.wait(0.2)
	end

	return remotes
end

local REMOTES_BAN_OFFSETS = {4, 3, 5, 6, 2, 7, 8}
local CHARACTER_BAN_OFFSETS = {5, 8, 3, 4, 6, 7, 9, 10}
local CHARACTER_TABLE_LENGTHS = {9, 8, 10, 11, 12, 7}

local function findRemotesContextTable(remotesFolder)
	for _, tbl in getgc(true) do
		if type(tbl) ~= 'table' then continue end

		local remotesIndex
		for i = 1, 24 do
			if rawget(tbl, i) == remotesFolder then
				remotesIndex = i
				break
			end
		end

		if remotesIndex then
			return tbl, remotesIndex
		end

		local first = rawget(tbl, 1)
		if typeof(first) == 'Instance' and first == remotesFolder then
			return tbl, 1
		end
		if typeof(first) == 'Instance' and first.Name == 'Remotes' and first:IsA('Folder') then
			return tbl, 1
		end
	end
	return nil
end

local function bypassRemotesBanTable(remotesFolder)
	local context, remotesIndex = findRemotesContextTable(remotesFolder)
	if not context then
		return false
	end

	debugLog('remotes context at index', remotesIndex)

	for _, offset in REMOTES_BAN_OFFSETS do
		local banTable = rawget(context, offset)
		if type(banTable) == 'table' and banTable ~= context and neutralizeBanTable(banTable) then
			debugLog('neutralized remotes ban table at offset', offset)
			return true
		end
	end

	for i = 1, 24 do
		if i == remotesIndex then continue end
		local banTable = rawget(context, i)
		if type(banTable) == 'table' and banTable ~= context and neutralizeBanTable(banTable) then
			debugLog('neutralized remotes ban table at scanned offset', i)
			return true
		end
	end

	return false
end

local function bypassCharacterBanTables(character, humanoid)
	local matched = false

	for _, tbl in getgc(true) do
		if type(tbl) ~= 'table' then continue end

		local charIdx, humIdx
		for i = 1, 32 do
			local value = rawget(tbl, i)
			if value == character then
				charIdx = charIdx or i
			end
			if value == humanoid then
				humIdx = humIdx or i
			end
		end

		if not (charIdx and humIdx) then
			continue
		end

		local len = tableLength(tbl)
		if len < 3 or len > 20 then
			continue
		end

		debugLog('character context charIdx', charIdx, 'humIdx', humIdx, 'len', len)

		for i = 1, 32 do
			if i == charIdx or i == humIdx then
				continue
			end
			local banTable = rawget(tbl, i)
			if type(banTable) == 'table' and banTable ~= tbl then
				neutralizeBanTable(banTable)
				matched = true
				debugLog('neutralized character ban table at offset', i)
			end
		end

		for _, clearIdx in {5, 8} do
			if rawget(tbl, clearIdx) ~= nil then
				rawset(tbl, clearIdx, nil)
			end
		end

		matched = true
	end

	return matched
end

local function runRecursiveTableBypass()
	local ok, bypassed = pcall(function()
		local function protectRecursiveTable(recursiveTbl, banIndexValue)
			setrawmetatable_fn(recursiveTbl, {
				__newindex = function(self, index, value)
					if type(value) == 'table' and index == banIndexValue then
						local whitelisted = false
						local id1 = rawget(value, 1)
						local id2 = rawget(value, 2)
						local id4 = rawget(value, 4)
						local len = rawlen and rawlen(value) or tableLength(value)

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

		local bypassed = false
		LPH_JIT_MAX(function()
			for _, tbl in getgc(true) do
				if type(tbl) ~= 'table' then continue end
				if getrawmetatable and getrawmetatable(tbl) then continue end

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
						bypassed = true
					end
				end
			end
		end)()

		return bypassed
	end)

	if not ok then
		debugLog('recursive bypass error', bypassed)
		return false
	end
	return bypassed == true
end

local function hookAssetContainerProtos()
	local hooked = 0
	LPH_JIT_MAX(function()
		for _, func in getgc(false) do
			if type(func) ~= 'function' then continue end
			if islclosure_fn and not islclosure_fn(func) then continue end
			if isexecutorclosure_fn(func) then continue end

			local info = getinfo_fn(func)
			if not info or not info.source or not info.source:find('AssetContainer') then continue end

			local protos = getprotos_fn(func)
			if not protos or not protos[1] then continue end

			local proto = getproto_fn(func, 1, true)
			if type(proto) ~= 'table' then
				proto = {getproto_fn(func, 1)}
			end

			for _, protoFunc in proto do
				if type(protoFunc) ~= 'function' then continue end
				local constants = getconstants_fn(protoFunc)
				local upvalues = getupvalues_fn and getupvalues_fn(protoFunc) or {}

				if constants[2] == 'SurfaceGui' then
					hookfunction_fn(protoFunc, LPH_NO_UPVALUES(function() end))
					hooked += 1
				elseif table.find(constants, 'Foundation') then
					hookfunction_fn(protoFunc, LPH_NO_UPVALUES(function() end))
					hooked += 1
				elseif table.find(constants, 'LocalAmmo') and table.find(constants, 'Equipped') then
					hookfunction_fn(protoFunc, LPH_NO_UPVALUES(function() end))
					hooked += 1
				elseif table.find(constants, 'WalkSpeed') then
					hookfunction_fn(protoFunc, LPH_NO_UPVALUES(function() end))
					hooked += 1
				elseif #constants == 23 then
					local old
					old = hookfunction_fn(protoFunc, LPH_NO_UPVALUES(function(...)
						local args = {...}
						if #args == 1 and typeof(args[1]) == 'table' then
							for ind, val in args[1] do
								if typeof(val) == 'table' then
									for i = #args[1], ind, -1 do
										args[1][i] = nil
									end
									break
								end
							end
						end
						return old(...)
					end))
					hooked += 1
				elseif #constants == 9 and #upvalues == 3 then
					hookfunction_fn(protoFunc, LPH_NO_UPVALUES(function() end))
					hooked += 1
				else
					local old
					old = hookfunction_fn(protoFunc, LPH_NO_UPVALUES(function(...)
						local args = {...}
						local a1 = args[1]
						if typeof(a1) ~= 'Instance' then
							if a1 == '' then return end
							if #args == 0 then return end
							for _, arg in args do
								if typeof(arg) == 'function' then
									return
								end
							end
						end
						return old(...)
					end))
					hooked += 1
				end
			end
		end
	end)()

	return hooked > 0
end

local function retryUntil(timeout, interval, fn)
	local deadline = tick() + timeout
	repeat
		if fn() then
			return true
		end
		task.wait(interval)
	until tick() >= deadline
	return false
end

local function runBypassForCharacter(character)
	local humanoid = character:FindFirstChildOfClass('Humanoid') or character:WaitForChild('Humanoid', 20)
	local root = character:FindFirstChild('HumanoidRootPart') or character:WaitForChild('HumanoidRootPart', 20)
	if not humanoid or not root then
		warn('[FallenBypass] Character not ready')
		return false
	end

	local remotesFolder = waitForAnticheatInit(45)
	if not remotesFolder then
		Client:Kick('Failed to load. 0x00')
		return false
	end

	local stage1 = retryUntil(25, 0.25, function()
		return bypassRemotesBanTable(remotesFolder)
	end)
	if not stage1 then
		Client:Kick('Failed to load. 0x01')
		return false
	end

	local stage2 = retryUntil(20, 0.25, function()
		return bypassCharacterBanTables(character, humanoid)
	end)
	if not stage2 then
		Client:Kick('Failed to load. 0x02')
		return false
	end

	local stage3 = retryUntil(15, 0.25, runRecursiveTableBypass)
	if not stage3 then
		Client:Kick('Failed to load. 0x03')
		return false
	end

	task.spawn(function()
		retryUntil(20, 0.35, hookAssetContainerProtos)
	end)

	return true
end

local character = Client.Character or Client.CharacterAdded:Wait()
if not runBypassForCharacter(character) then
	return false
end

getgenv().FallenBypassLoaded = true
shared.FallenBypassLoaded = true

Client.CharacterAdded:Connect(function(newCharacter)
	task.wait(0.5)
	runBypassForCharacter(newCharacter)
	task.spawn(function()
		retryUntil(15, 0.35, hookAssetContainerProtos)
	end)
end)

return true
