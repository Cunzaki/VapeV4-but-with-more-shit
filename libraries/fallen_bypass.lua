--[[
	Fallen Survival anticheat bypass for Vape.
	Must run before universal / GUI modules load.
	Combines GC ban-table neutralization (bypas.txt) with AssetContainer proto hooks.
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

local function runBanTableBypass(character, humanoid)
	local bypassCheck1 = false
	local bypassCheck2 = false

	LPH_JIT_MAX(function()
		for _, tbl in getgc(true) do
			if type(tbl) ~= 'table' then continue end
			if typeof(rawget(tbl, 1)) == 'Instance' and rawget(tbl, 1).Name == 'Remotes' then
				local banTable = rawget(tbl, 4)
				if type(banTable) == 'table' then
					setmetatable(banTable, {
						__index = function() end,
						__newindex = function() end
					})
					bypassCheck1 = true
				end
			end
		end
	end)()

	if not bypassCheck1 then
		Client:Kick('Failed to load. 0x01')
		return false
	end

	LPH_JIT_MAX(function()
		for _, tbl in getgc(true) do
			if type(tbl) ~= 'table' then continue end
			if rawget(tbl, 1) == character and rawget(tbl, 2) == humanoid and #tbl == 9 then
				local banTable1 = rawget(tbl, 8)
				local banTable2 = rawget(tbl, 5)
				if type(banTable1) == 'table' then
					setmetatable(banTable1, {
						__index = function() end,
						__newindex = function() end
					})
				end
				if type(banTable2) == 'table' then
					setmetatable(banTable2, {
						__index = function() end,
						__newindex = function() end
					})
				end
				rawset(tbl, 5, nil)
				bypassCheck2 = true
			end
		end
	end)()

	if not bypassCheck2 then
		Client:Kick('Failed to load. 0x02')
		return false
	end

	return true
end

local function runRecursiveTableBypass()
	local success, err = pcall(function()
		local function protectRecursiveTable(recursiveTbl, banIndexValue)
			setrawmetatable_fn(recursiveTbl, {
				__newindex = function(self, index, value)
					if type(value) == 'table' and index == banIndexValue then
						local whitelisted = false
						local id1 = rawget(value, 1)
						local id2 = rawget(value, 2)
						local id4 = rawget(value, 4)
						local len = rawlen and rawlen(value) or #value

						if id1 then
							if type(id1) == 'table' and len == 2 and rawlen(id1) == 1 and not rawget(id1, 'n') then
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

		if not bypassed then
			Client:Kick('Failed to load. 0x03')
			return false
		end
		return true
	end)

	if not success then
		Client:Kick(tostring(err))
		return false
	end
	return true
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

local function runBypassForCharacter(character)
	local humanoid = character:FindFirstChildOfClass('Humanoid') or character:WaitForChild('Humanoid', 15)
	local root = character:FindFirstChild('HumanoidRootPart') or character:WaitForChild('HumanoidRootPart', 15)
	if not humanoid or not root then
		warn('[FallenBypass] Character not ready')
		return false
	end

	if not runBanTableBypass(character, humanoid) then
		return false
	end
	if not runRecursiveTableBypass() then
		return false
	end

	task.defer(function()
		for _ = 1, 8 do
			if hookAssetContainerProtos() then break end
			task.wait(0.35)
		end
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
	task.wait(0.25)
	runBypassForCharacter(newCharacter)
	task.defer(function()
		for _ = 1, 6 do
			if hookAssetContainerProtos() then break end
			task.wait(0.35)
		end
	end)
end)

return true
