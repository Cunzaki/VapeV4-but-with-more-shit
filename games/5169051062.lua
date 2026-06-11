local run = function(func)
	local ok, err = pcall(func)
	if not ok then
		warn('[5169051062]', err)
	end
end
local cloneref = cloneref or function(obj)
	return obj
end

local playersService = cloneref(game:GetService('Players'))
local runService = cloneref(game:GetService('RunService'))
local lplr = playersService.LocalPlayer
local vape = shared.vape

if not vape.Categories.Minigames then
	vape.Categories.Minigames = vape:CreateCategory({
		Name = 'Minigames',
		Icon = 'vape/assets/new/minigames.png'
	})
end

local minigames = vape.Categories.Minigames
local ft = {
	hooks = {},
	connections = {},
	remoteHooks = {},
	reloadHooks = {},
	hooksStarted = false
}
vape.Libraries.frontlines = ft

local function isGunFireTable(v)
	return type(v) == 'table'
		and type(rawget(v, 'Fire')) == 'function'
		and type(rawget(v, 'Reload')) == 'function'
		and type(rawget(v, 'Raycast')) == 'function'
end

local function isGunInputTable(v)
	return type(v) == 'table'
		and type(rawget(v, 'MouseClick')) == 'function'
		and type(rawget(v, 'MouseRelease')) == 'function'
end

local function isGunRemoteTable(v)
	return type(v) == 'table'
		and type(rawget(v, 'FireServer')) == 'function'
		and type(rawget(v, 'GetIgnore')) == 'function'
		and type(rawget(v, 'Raycast')) == 'function'
end

local function forEachUpvalue(fn, callback)
	for i = 1, 80 do
		local ok, name, val = pcall(debug.getupvalue, fn, i)
		if not ok then
			break
		end
		callback(i, name, val)
	end
end

local function setAmmoUpvalues(fn, amount)
	forEachUpvalue(fn, function(i, _, val)
		if type(val) == 'number' and val >= 0 and val <= 35 then
			pcall(debug.setupvalue, fn, i, amount)
		end
	end)
end

local function setInfiniteFlag(fn)
	local ammoIdx
	forEachUpvalue(fn, function(i, _, val)
		if type(val) == 'number' and val >= 0 and val <= 35 then
			ammoIdx = i
		end
	end)
	if not ammoIdx then
		return
	end
	for idx = ammoIdx - 4, ammoIdx + 4 do
		if idx > 0 then
			local ok, _, val = pcall(debug.getupvalue, fn, idx)
			if ok and type(val) == 'boolean' and val == false then
				pcall(debug.setupvalue, fn, idx, true)
				return
			end
		end
	end
end

local function traceLooksLikeGunFire(trace)
	return trace:find('Gun', 1, true)
		or trace:find('MouseClick', 1, true)
		or trace:find('ServerConnectionFolder', 1, true)
end

local function traceLooksLikeGunSpread(trace)
	return trace:find('Fire', 1, true) and trace:find('Gun', 1, true)
end

local function traceLooksLikeGunReload(trace)
	return trace:find('Reload', 1, true) and trace:find('Gun', 1, true)
end

local function restoreHooks()
	for _, entry in ipairs(ft.remoteHooks or {}) do
		entry[1][entry[2]] = entry[3]
	end
	ft.remoteHooks = {}
	if ft.hooks['task.wait'] and task.wait ~= ft.hooks['task.wait'] then
		task.wait = ft.hooks['task.wait']
	end
	if ft.hooks['math.random'] and math.random ~= ft.hooks['math.random'] then
		math.random = ft.hooks['math.random']
	end
	if ft.hooks.requirement then
		local req = lplr:FindFirstChild('Requirement')
		if req then
			req.Invoke = ft.hooks.requirement
		end
	end
	for _, entry in ipairs(ft.reloadHooks or {}) do
		entry[1].Reload = entry[2]
	end
	ft.reloadHooks = {}
	table.clear(ft.hooks)
	for _, conn in ipairs(ft.connections) do
		pcall(function()
			conn:Disconnect()
		end)
	end
	table.clear(ft.connections)
	ft.hooksStarted = false
end

local function hookRequirementInfAmmo()
	local req = lplr:FindFirstChild('Requirement')
	if not req or ft.hooks.requirement then
		return
	end
	local oldInvoke = req.Invoke
	ft.hooks.requirement = oldInvoke
	req.Invoke = function(self, method, ...)
		if method == 'getsvar' and select(1, ...) == 'infammo' and ft.infAmmoEnabled then
			return true
		end
		return oldInvoke(self, method, ...)
	end
end

local function alreadyHooked(list, target)
	for _, entry in ipairs(list) do
		if entry[1] == target then
			return true
		end
	end
	return false
end

local function hookGunRemotes()
	ft.remoteHooks = ft.remoteHooks or {}
	for _, v in getgc(true) do
		if isGunRemoteTable(v) and not alreadyHooked(ft.remoteHooks, v) then
			local oldFireServer = v.FireServer
			table.insert(ft.remoteHooks, {v, 'FireServer', oldFireServer})
			v.FireServer = function(self, tool, packetId, ...)
				local args = {...}
				if packetId == 2 and ft.damageBoostEnabled and type(args[1]) == 'table' then
					local packet = args[1]
					if type(packet[4]) == 'number' then
						packet[4] = math.floor(packet[4] * (ft.damageMultiplier or 2))
					end
				end
				return oldFireServer(self, tool, packetId, table.unpack(args))
			end
		end
	end
end

local function hookGunReload()
	ft.reloadHooks = ft.reloadHooks or {}
	for _, v in getgc(true) do
		if isGunFireTable(v) and not alreadyHooked(ft.reloadHooks, v) then
			local oldReload = v.Reload
			table.insert(ft.reloadHooks, {v, oldReload})
			v.Reload = function(...)
				if ft.instantReloadEnabled then
					setAmmoUpvalues(oldReload, 35)
					forEachUpvalue(oldReload, function(i, _, val)
						if type(val) == 'boolean' and val == true then
							pcall(debug.setupvalue, oldReload, i, false)
						end
					end)
					return
				end
				return oldReload(...)
			end
		end
	end
end

local function hookGunFireRate()
	if ft.hooks['task.wait'] then
		return
	end
	local oldWait = task.wait
	ft.hooks['task.wait'] = oldWait
	task.wait = function(duration, ...)
		if ft.fireRateEnabled and type(duration) == 'number' then
			local trace = debug.traceback('', 2)
			if traceLooksLikeGunFire(trace) then
				if duration >= 0.08 and duration <= 0.1 then
					duration = 1 / math.max(1, ft.fireRateValue or 20)
				elseif duration >= 0.35 and duration <= 0.45 and ft.instantReloadEnabled then
					duration = 0
				elseif duration >= 0.08 and duration <= 0.2 and traceLooksLikeGunReload(trace) and ft.instantReloadEnabled then
					duration = 0
				end
			end
		end
		return oldWait(duration, ...)
	end
end

local function hookGunSpread()
	if ft.hooks['math.random'] then
		return
	end
	local oldRandom = math.random
	ft.hooks['math.random'] = oldRandom
	math.random = function(a, b, ...)
		if ft.noSpreadEnabled and type(a) == 'number' and type(b) == 'number' then
			local trace = debug.traceback('', 2)
			if traceLooksLikeGunSpread(trace) and a < 0 and b > 0 and math.abs(a) <= 1 and math.abs(b) <= 1 then
				return 0
			end
		end
		if b then
			return oldRandom(a, b, ...)
		elseif a then
			return oldRandom(a, ...)
		end
		return oldRandom(...)
	end
end

local function maintainGunState()
	if not (ft.infAmmoEnabled or ft.autoReloadEnabled) then
		return
	end
	for _, v in getgc(true) do
		if isGunInputTable(v) then
			if ft.infAmmoEnabled then
				setInfiniteFlag(v.MouseClick)
				setAmmoUpvalues(v.MouseClick, 35)
			elseif ft.autoReloadEnabled then
				setAmmoUpvalues(v.MouseClick, 35)
			end
		end
		if isGunFireTable(v) and ft.autoReloadEnabled then
			setAmmoUpvalues(v.Reload, 35)
		end
	end
end

local function startGunHooks()
	if ft.hooksStarted then
		return
	end
	ft.hooksStarted = true
	hookRequirementInfAmmo()
	hookGunRemotes()
	hookGunReload()
	hookGunFireRate()
	hookGunSpread()
	table.insert(ft.connections, runService.RenderStepped:Connect(maintainGunState))
	table.insert(ft.connections, runService.Heartbeat:Connect(function()
		hookGunRemotes()
		hookGunReload()
	end))
end

run(function()
	local InfiniteAmmo
	local FireRate
	local FireRateValue
	local NoSpread
	local DamageBoost
	local DamageMultiplier
	local InstantReload
	local AutoReload

	InfiniteAmmo = minigames:CreateModule({
		Name = 'Infinite Ammo',
		Function = function(callback)
			ft.infAmmoEnabled = callback
			if callback then
				startGunHooks()
			elseif not (FireRate.Enabled or NoSpread.Enabled or DamageBoost.Enabled or InstantReload.Enabled or AutoReload.Enabled) then
				restoreHooks()
			end
		end,
		Tooltip = 'Never run out of SMG ammo (Frontlines Training)'
	})

	FireRate = minigames:CreateModule({
		Name = 'Fire Rate',
		Function = function(callback)
			ft.fireRateEnabled = callback
			if callback then
				startGunHooks()
			elseif not (InfiniteAmmo.Enabled or NoSpread.Enabled or DamageBoost.Enabled or InstantReload.Enabled or AutoReload.Enabled) then
				restoreHooks()
			end
		end,
		Tooltip = 'Increase SMG fire rate above the default ~11 shots/sec'
	})
	FireRateValue = FireRate:CreateSlider({
		Name = 'Shots Per Second',
		Min = 5,
		Max = 30,
		Default = 20,
		Suffix = '/s',
		Function = function(val)
			ft.fireRateValue = val
		end
	})
	ft.fireRateValue = FireRateValue.Value

	NoSpread = minigames:CreateModule({
		Name = 'No Spread',
		Function = function(callback)
			ft.noSpreadEnabled = callback
			if callback then
				startGunHooks()
			elseif not (InfiniteAmmo.Enabled or FireRate.Enabled or DamageBoost.Enabled or InstantReload.Enabled or AutoReload.Enabled) then
				restoreHooks()
			end
		end,
		Tooltip = 'Remove random bullet spread from SMG shots'
	})

	DamageBoost = minigames:CreateModule({
		Name = 'Damage Boost',
		Function = function(callback)
			ft.damageBoostEnabled = callback
			if callback then
				startGunHooks()
			elseif not (InfiniteAmmo.Enabled or FireRate.Enabled or NoSpread.Enabled or InstantReload.Enabled or AutoReload.Enabled) then
				restoreHooks()
			end
		end,
		Tooltip = 'Multiply damage sent to the server on hit'
	})
	DamageMultiplier = DamageBoost:CreateSlider({
		Name = 'Multiplier',
		Min = 1,
		Max = 10,
		Default = 2,
		Decimal = 10,
		Suffix = 'x',
		Function = function(val)
			ft.damageMultiplier = val
		end
	})
	ft.damageMultiplier = DamageMultiplier.Value

	InstantReload = minigames:CreateModule({
		Name = 'Instant Reload',
		Function = function(callback)
			ft.instantReloadEnabled = callback
			if callback then
				startGunHooks()
			elseif not (InfiniteAmmo.Enabled or FireRate.Enabled or NoSpread.Enabled or DamageBoost.Enabled or AutoReload.Enabled) then
				restoreHooks()
			end
		end,
		Tooltip = 'Skip reload animation and refill instantly'
	})

	AutoReload = minigames:CreateModule({
		Name = 'Auto Reload',
		Function = function(callback)
			ft.autoReloadEnabled = callback
			if callback then
				startGunHooks()
			elseif not (InfiniteAmmo.Enabled or FireRate.Enabled or NoSpread.Enabled or DamageBoost.Enabled or InstantReload.Enabled) then
				restoreHooks()
			end
		end,
		Tooltip = 'Keep magazine topped off while the gun is equipped'
	})
end)
