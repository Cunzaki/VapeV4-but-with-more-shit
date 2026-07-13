--[[
	Fallen Survival shared place hooks.
	Loaded by 16849012343 (Medium) and 13800717766 (Large).
	Pass 1: targeting, silent aim, gun mods, ESP, world ESP, visuals.
]]

repeat task.wait() until shared.vape
local vape = shared.vape

local run = function(func)
	local ok, err = pcall(func)
	if not ok then
		warn('[Fallen]', err)
	end
end

local cloneref = cloneref or function(obj)
	return obj
end

local playersService = cloneref(game:GetService('Players'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local runService = cloneref(game:GetService('RunService'))
local lighting = cloneref(game:GetService('Lighting'))
local tweenService = cloneref(game:GetService('TweenService'))
local userInputService = cloneref(game:GetService('UserInputService'))
local soundService = cloneref(game:GetService('SoundService'))
local httpService = cloneref(game:GetService('HttpService'))
local debris = cloneref(game:GetService('Debris'))
local coreGui = cloneref(game:GetService('CoreGui'))

local lplr = playersService.LocalPlayer
local camera = workspace.CurrentCamera
local entitylib = vape.Libraries.entity
local DrawingLib = rawget(getfenv(), 'Drawing') or Drawing

local FALLEN_PLACE_IDS = {
	[16849012343] = 'Medium',
	[13800717766] = 'Large',
}

local Modules = replicatedStorage:WaitForChild('Modules')

local function safeRequire(childName)
	local ok, res = pcall(function()
		return require(Modules:WaitForChild(childName, 10))
	end)
	return ok and res or nil
end

local ToolInfo = safeRequire('ToolInfo')
local RaycastUtil = safeRequire('RaycastUtil')
local VFXModule = safeRequire('VFXModule')
local Items = safeRequire('Items')
local ItemClass = safeRequire('ItemClass')
local SettingsModule = safeRequire('SettingsModule')
local TableUtil = safeRequire('TableUtil')

local function deepCopy(tbl)
	local copy = {}
	for k, v in next, tbl do
		if type(v) == 'table' then
			copy[k] = deepCopy(v)
		else
			copy[k] = v
		end
	end
	return copy
end

local ToolInfoCopy = ToolInfo and deepCopy(ToolInfo) or nil

local function colorFromSlider(opt)
	if not opt then
		return Color3.new(1, 1, 1)
	end
	if opt.Hue ~= nil then
		return Color3.fromHSV(opt.Hue or 0, opt.Sat or 1, opt.Value or 1)
	end
	return Color3.new(1, 1, 1)
end

local function guiParent()
	if gethui then
		return gethui()
	end
	return coreGui
end

local isvalidlevel = isvalidlevel or function(level)
	local ok = pcall(function()
		debug.getstack(level + 3)
	end)
	return ok
end

-- Obfuscated remote hashes (from insulin / live ViewmodelController)
local RELOAD_REMOTE = 'd\147e\001R\169#o\249,9\133\153`B4q^W\006'
local RELOAD_HASH = '\197s5m:\246\237\135\220Hr\235\001\239\214\\\209\212\219\219'
local FIRE_HASH = '#\250)\215\028\001U\143\237}\154\218\231Cl-\015H\001\147'

local SOLDIER_CLASS = {
	Brutus = 'Boss',
	Bruno = 'Boss',
	BTR = 'Boss',
	Boris = 'Boss',
	Soldier = 'AI',
}

local Targeting = {
	TargetPart = nil,
	TargetCharacter = nil,
	TargetObject = nil,
	ManipulatedPosition = nil,
	ManipulatedPart = nil,
	ScannedPosition = nil,
	ScannedPart = nil,
	HitScanActive = false,
	ManipulationActive = false,
	Targets = {},
}

local FallenState = {
	PlaceId = game.PlaceId,
	ServerType = FALLEN_PLACE_IDS[game.PlaceId] or 'Unknown',
	Modules = Modules,
	Values = replicatedStorage:FindFirstChild('Values'),
	CharacterScripts = replicatedStorage:FindFirstChild('CharacterScripts'),
	VFX = replicatedStorage:FindFirstChild('VFX'),
	VMs = replicatedStorage:FindFirstChild('VMs'),
	ToolInfo = ToolInfo,
	ToolInfoCopy = ToolInfoCopy,
	RaycastUtil = RaycastUtil,
	VFXModule = VFXModule,
	Items = Items,
	ItemClass = ItemClass,
	SettingsModule = SettingsModule,
	TableUtil = TableUtil,
	Targeting = Targeting,
	ClientCharacter = nil,
	ClientHumanoid = nil,
	ClientRoot = nil,
	VMNetworkPointer = nil,
	LastAutoReload = 0,
	LastBulletSpeed = nil,
	LastBulletGravity = nil,
	ShouldHit = true,
	LastPredictionPos = nil,
	AssetContainerHooked = false,
	ProjectileHooked = false,
	RaycastHooked = false,
	BloodHooked = false,
	HoleHooked = false,
	AttachmentHooked = false,
	TableRandomHooked = false,
	NetworkHooked = false,
	Flags = {},
}

vape.Libraries.fallen = FallenState
local fallen = FallenState
local flags = FallenState.Flags

local RayParams = RaycastParams.new()
RayParams.FilterType = Enum.RaycastFilterType.Exclude
RayParams.IgnoreWater = true
FallenState.RaycastParams = RayParams

local clanTeamCache = {}
do
	local ok, env = pcall(function()
		local ps = lplr:FindFirstChild('PlayerScripts')
		local cc = ps and ps:FindFirstChild('ClanController')
		if cc and getsenv then
			return getsenv(cc)
		end
	end)
	if ok and env and env.shared and env.shared.cachedTeamModels then
		clanTeamCache = env.shared.cachedTeamModels
	end
end

local function isTeam(player)
	if typeof(player) ~= 'Instance' or not player:IsA('Player') then
		return false
	end
	return clanTeamCache[player.UserId] and true or false
end

local function resolveCharacter(entity, object)
	if object and object.Class == 'Player' then
		local player = object.Player
		if not player and typeof(entity) == 'Instance' and entity:IsA('Player') then
			player = entity
		end
		return player and player.Character
	end
	if typeof(entity) == 'Instance' then
		if entity:IsA('Player') then
			return entity.Character
		end
		if entity:IsA('Model') then
			return entity
		end
	end
	return object and object.Character
end

local function getRoot(model)
	if not model then
		return nil
	end
	if model:IsA('Player') then
		model = model.Character
	end
	if not model then
		return nil
	end
	local hrp = model:FindFirstChild('HumanoidRootPart')
	if hrp then
		return hrp
	end
	if model:IsA('Model') and model.PrimaryPart then
		return model.PrimaryPart
	end
	return model:FindFirstChild('RootPart') or model:FindFirstChild('Torso')
end

local function getTargetPart(model, desired)
	if not model then
		return nil
	end
	if model:IsA('Player') then
		model = model.Character
	end
	if not model then
		return nil
	end
	return model:FindFirstChild(desired)
		or model:FindFirstChild('Head')
		or model:FindFirstChild('UpperTorso')
		or model:FindFirstChild('HumanoidRootPart')
		or (model:IsA('Model') and model.PrimaryPart)
end

local function getDistanceFromCenter(part)
	local position = part
	if typeof(part) == 'Instance' then
		position = part.CFrame.Position
	end
	local sp, on = camera:WorldToViewportPoint(position)
	if not on then
		return math.huge
	end
	local c = Vector2.new(camera.ViewportSize.X * 0.5, camera.ViewportSize.Y * 0.5)
	return (c - Vector2.new(sp.X, sp.Y)).Magnitude
end

local function refreshClientCharacter(char)
	char = char or lplr.Character
	FallenState.ClientCharacter = char
	if char then
		FallenState.ClientHumanoid = char:FindFirstChildOfClass('Humanoid')
		FallenState.ClientRoot = getRoot(char)
	else
		FallenState.ClientHumanoid = nil
		FallenState.ClientRoot = nil
	end
end

refreshClientCharacter(lplr.Character)
vape:Clean(lplr.CharacterAdded:Connect(function(char)
	task.wait(0.1)
	refreshClientCharacter(char)
end))

---------------------------------------------------------------------------
-- Strip universal modules that conflict with Fallen-specific ones
---------------------------------------------------------------------------
run(function()
	local removeList = {
		'SilentAim', 'AimAssist', 'TriggerBot', 'Reach', 'HitBoxes', 'Killaura',
		'HitSounds', 'AutoClicker', 'TargetStrafe',
		'Fly', 'Speed', 'HighJump', 'LongJump', 'Phase', 'Invisible', 'Spider',
		'SpinBot', 'Swim', 'Jesus', 'NoJumpCooldown', 'Blink', 'Desync', 'Void',
		'Arrows', 'Chams', 'ESP', 'GamingChair', 'Health', 'NameTags', 'PlayerModel',
		'Tracers', 'Fullbright', 'ThirdPerson',
		'AntiFall', 'MouseTP', 'Search', 'Waypoints',
		'Freecam', 'Gravity', 'Parkour', 'Part Manipulation', 'Xray',
		'Atmosphere',
	}
	for _, name in removeList do
		pcall(function()
			vape:Remove(name)
		end)
	end
end)

---------------------------------------------------------------------------
-- AssetContainer proto hooks (minimal — after bypass Active)
---------------------------------------------------------------------------
local function installAssetContainerHooks()
	if FallenState.AssetContainerHooked then
		return
	end
	if not (getgc and hookfunction and debug and debug.getinfo and debug.getprotos and debug.getproto and debug.getconstants) then
		return
	end
	local hooked = 0
	pcall(function()
		for _, fn in getgc(false) do
			if type(fn) == 'function' and (not isexecutorclosure or not isexecutorclosure(fn)) then
				local infoOk, info = pcall(debug.getinfo, fn)
				if infoOk and info and type(info.source) == 'string' and info.source:find('AssetContainer') then
					local protosOk, protos = pcall(debug.getprotos, fn)
					if protosOk and protos and protos[1] then
						local protoOk, proto = pcall(debug.getproto, fn, 1)
						if protoOk and proto then
							local constOk, constants = pcall(debug.getconstants, proto)
							if constOk and constants then
								local match = constants[2] == 'SurfaceGui'
									or table.find(constants, 'Foundation')
									or (table.find(constants, 'LocalAmmo') and table.find(constants, 'Equipped'))
									or table.find(constants, 'WalkSpeed')
								if match then
									pcall(hookfunction, proto, function()
										return
									end)
									hooked = hooked + 1
								end
							end
						end
					end
				end
			end
		end
	end)
	if hooked > 0 then
		FallenState.AssetContainerHooked = true
	end
end

run(function()
	task.spawn(function()
		for _ = 1, 60 do
			local st = vape.Libraries and vape.Libraries.fallenBypass
			if (st and st.Active) or getgenv().FallenBypassLoaded or getgenv().fishy_loaded then
				installAssetContainerHooks()
				if FallenState.AssetContainerHooked then
					break
				end
			end
			task.wait(1)
			installAssetContainerHooks()
			if FallenState.AssetContainerHooked then
				break
			end
		end
	end)
end)

---------------------------------------------------------------------------
-- Targeting math (ported from insulin)
---------------------------------------------------------------------------
local UnitDirections = {
	Vector3.new(1, 0, 0), Vector3.new(-1, 0, 0),
	Vector3.new(0, 0, 1), Vector3.new(0, 0, -1),
	Vector3.new(0, 1, 0), Vector3.new(0, -1, 0),
	Vector3.new(1, 1, 0).Unit, Vector3.new(1, -1, 0).Unit,
	Vector3.new(-1, 1, 0).Unit, Vector3.new(-1, -1, 0).Unit,
	Vector3.new(0, 1, 1).Unit, Vector3.new(0, -1, 1).Unit,
	Vector3.new(0, 1, -1).Unit, Vector3.new(0, -1, -1).Unit,
}

local manipOffsets = {
	Vector3.new(0.5, 0, 0), Vector3.new(-0.5, 0, 0),
	Vector3.new(0.5, 0.5, 0), Vector3.new(-0.5, 0.5, 0),
	Vector3.new(1, 0, 0), Vector3.new(-1, 0, 0),
	Vector3.new(1, 0.5, 0), Vector3.new(-1, 0.5, 0),
	Vector3.new(1, 1, 0), Vector3.new(-1, 1, 0),
	Vector3.new(0, 0.5, 0),
	Vector3.new(0, 1, 0),
	Vector3.new(0, 1.5, 0),
	Vector3.new(0, 0, -0.5),
	Vector3.new(0, 0, -1),
	Vector3.new(0, 1, -1), Vector3.new(0, 1, 1),
	Vector3.new(0.5, 0, -1), Vector3.new(-0.5, 0, -1),
	Vector3.new(1, 0, -1), Vector3.new(-1, 0, -1),
	Vector3.new(1, 1, -1), Vector3.new(-1, 1, -1),
	Vector3.new(1.5, 0, 0), Vector3.new(-1.5, 0, 0),
	Vector3.new(1.5, 1, 0), Vector3.new(-1.5, 1, 0),
	Vector3.new(1.5, 0, -1), Vector3.new(-1.5, 0, -1),
	Vector3.new(0, 2, 0),
	Vector3.new(0, 2, -1),
	Vector3.new(0, 2, -2),
	Vector3.new(1, 2, 0), Vector3.new(-1, 2, 0),
	Vector3.new(2, 0, 0), Vector3.new(-2, 0, 0),
	Vector3.new(2, 0.5, 0), Vector3.new(-2, 0.5, 0),
	Vector3.new(2, 1, 0), Vector3.new(-2, 1, 0),
	Vector3.new(2, 1.5, 0), Vector3.new(-2, 1.5, 0),
	Vector3.new(2, 2, 0), Vector3.new(-2, 2, 0),
	Vector3.new(2, 0, -1), Vector3.new(-2, 0, -1),
	Vector3.new(2, 0, -2), Vector3.new(-2, 0, -2),
	Vector3.new(2, 1, -2), Vector3.new(-2, 1, -2),
	Vector3.new(0, 3, 0),
	Vector3.new(0, 3, -1),
	Vector3.new(0, 3, -2),
	Vector3.new(1, 3, 0), Vector3.new(-1, 3, 0),
	Vector3.new(2.5, 0, 0), Vector3.new(-2.5, 0, 0),
	Vector3.new(2.5, 1, 0), Vector3.new(-2.5, 1, 0),
	Vector3.new(2.5, 2, 0), Vector3.new(-2.5, 2, 0),
	Vector3.new(3, 0, 0), Vector3.new(-3, 0, 0),
	Vector3.new(3, 1, 0), Vector3.new(-3, 1, 0),
	Vector3.new(3, 2, 0), Vector3.new(-3, 2, 0),
	Vector3.new(3, 3, 0), Vector3.new(-3, 3, 0),
	Vector3.new(0, 4, 0),
	Vector3.new(0, 4, -1),
	Vector3.new(0, 4, -2),
	Vector3.new(0.2, 3.9, 0),
	Vector3.new(3.5, 0, 0), Vector3.new(-3.5, 0, 0),
	Vector3.new(3.5, 1, 0), Vector3.new(-3.5, 1, 0),
	Vector3.new(3.5, 2, 0), Vector3.new(-3.5, 2, 0),
	Vector3.new(4, 0, 0), Vector3.new(-4, 0, 0),
	Vector3.new(4, 1, 0), Vector3.new(-4, 1, 0),
	Vector3.new(4, 2, 0), Vector3.new(-4, 2, 0),
	Vector3.new(2, 0, -3), Vector3.new(-2, 0, -3),
	Vector3.new(3, 1.5, -3), Vector3.new(-3, 1.5, -3),
	Vector3.new(0, 5, 0),
	Vector3.new(1.8, 4.1, 1),
	Vector3.new(2.1, 4.4, 1.1),
	Vector3.new(5, 0, 0), Vector3.new(-5, 0, 0),
	Vector3.new(0, 0, -5),
	Vector3.new(3, 0, -5), Vector3.new(-3, 0, -5),
	Vector3.new(4, 2, -5), Vector3.new(-4, 2, -5),
	Vector3.new(5, 2, 0), Vector3.new(-5, 2, 0),
	Vector3.new(5, 3, 0), Vector3.new(-5, 3, 0),
	Vector3.new(0, 6, 0),
	Vector3.new(0.15, 5.2, 0.1),
	Vector3.new(-1.8, 5.4, -0.2),
	Vector3.new(-2.3, 6.0, -0.4),
	Vector3.new(0.1, 6.0, 0.0),
	Vector3.new(6, 0, 0), Vector3.new(-6, 0, 0),
	Vector3.new(6, 2, 0), Vector3.new(-6, 2, 0),
	Vector3.new(7, 0, 0), Vector3.new(-7, 0, 0),
	Vector3.new(7, 2, 0), Vector3.new(-7, 2, 0),
	Vector3.new(3, 5, 0), Vector3.new(-3, 5, 0),
	Vector3.new(5, 4, 0), Vector3.new(-5, 4, 0),
	Vector3.new(0.1, 7.5, 0.0),
	Vector3.new(0.1, 8.0, 0.0),
	Vector3.new(0, 9, 0),
	Vector3.new(8, 0, 0), Vector3.new(-8, 0, 0),
	Vector3.new(8, 3, 0), Vector3.new(-8, 3, 0),
	Vector3.new(10, 0, 0), Vector3.new(-10, 0, 0),
	Vector3.new(10, 3, 0), Vector3.new(-10, 3, 0),
	Vector3.new(4, 0, -8), Vector3.new(-4, 0, -8),
	Vector3.new(6, 2, -8), Vector3.new(-6, 2, -8),
	Vector3.new(0, 4, -8),
	Vector3.new(0, 5, -10),
	Vector3.new(4, 4, -10), Vector3.new(-4, 4, -10),
	Vector3.new(0, 6, -12),
	Vector3.new(2, 0, 4), Vector3.new(-2, 0, 4),
	Vector3.new(0, 3, 5),
}

local function IsCFrameVisible(fromCF, toCF, rayParams)
	if not (fromCF and toCF) then
		return false
	end
	local hit = workspace:Raycast(fromCF.Position, toCF.Position - fromCF.Position, rayParams)
	return hit == nil
end

local function IsPartVisibleFromCF(fromCF, targetPart, rayParams)
	if not (fromCF and targetPart) then
		return false
	end
	local origin = fromCF.Position
	local dir = targetPart.Position - origin
	local hit = workspace:Raycast(origin, dir, rayParams)
	if not hit then
		return true
	end
	return hit.Instance and hit.Instance:IsDescendantOf(targetPart.Parent)
end

local IsPartVisible = IsPartVisibleFromCF

local function GetHitScanPos(originCF, targetPart, rayParams)
	rayParams = rayParams or RayParams
	local maxDist = flags.HitScanDistance or 5
	local stepSize = 0.5
	local steps = math.max(1, math.ceil(maxDist / stepSize))
	for s = 1, steps do
		local dist = math.min(s * stepSize, maxDist)
		for i = 1, #UnitDirections do
			local surfaceCF = targetPart.CFrame * CFrame.new(UnitDirections[i] * dist)
			if IsPartVisibleFromCF(surfaceCF, targetPart, rayParams) and IsCFrameVisible(originCF, surfaceCF, rayParams) then
				return surfaceCF.Position
			end
		end
	end
	return nil
end

local function IsManipPathClear(origin, targetPart)
	if not (origin and targetPart) then
		return false
	end
	local to = targetPart.CFrame.Position
	local dir = to - origin
	local result = workspace:Raycast(origin, dir, RayParams)
	if not result then
		return true
	end
	local inst = result.Instance
	return inst and inst:IsDescendantOf(targetPart.Parent) or false
end

local function IsAimPointReachable(origin, aimPoint, targetPart)
	if not (origin and aimPoint) then
		return false
	end
	local dir = aimPoint - origin
	local result = workspace:Raycast(origin, dir, RayParams)
	if not result then
		return true
	end
	if targetPart then
		local inst = result.Instance
		if inst and inst:IsDescendantOf(targetPart.Parent) then
			return true
		end
	end
	return false
end

local function IsCandidateReachable(originPos, candidatePos)
	if not (originPos and candidatePos) then
		return false
	end
	local dir = candidatePos - originPos
	if dir.Magnitude < 0.05 then
		return true
	end
	local result = workspace:Raycast(originPos, dir, RayParams)
	if not result then
		return true
	end
	return false
end

local function FindVisiblePosition(Origin, Destination, AimPoint)
	local o = (typeof(Origin) == 'CFrame') and Origin or CFrame.new(Origin)
	local oPos = o.Position
	local maxDist = flags.ManipulationDistance or 5
	if AimPoint then
		for i = 1, #manipOffsets do
			local off = manipOffsets[i]
			if off.Magnitude <= maxDist then
				local pos = o * off
				if IsCandidateReachable(oPos, pos) and IsManipPathClear(pos, Destination) and IsAimPointReachable(pos, AimPoint, Destination) then
					return pos
				end
			end
		end
	end
	for i = 1, #manipOffsets do
		local off = manipOffsets[i]
		if off.Magnitude <= maxDist then
			local pos = o * off
			if IsCandidateReachable(oPos, pos) and IsManipPathClear(pos, Destination) then
				return pos
			end
		end
	end
	return nil
end

FallenState.GetRoot = getRoot
FallenState.GetTargetPart = getTargetPart
FallenState.IsPartVisible = IsPartVisible
FallenState.IsPartVisibleFromCF = IsPartVisibleFromCF
FallenState.FindVisiblePosition = FindVisiblePosition
FallenState.GetHitScanPos = GetHitScanPos
FallenState.colorFromSlider = colorFromSlider

local function cacheSoldier(soldier)
	local classType = SOLDIER_CLASS[soldier.Name]
	if not classType then
		return
	end
	Targeting.Targets[soldier] = {
		Class = classType,
		Player = soldier,
		Character = soldier,
		LastUpdate = 0,
		Root = nil,
		Humanoid = nil,
		CoreInformation = { Visible = false, OnScreen = false, Root = nil },
	}
end

local function registerPlayerTarget(player)
	if player == lplr then
		return
	end
	Targeting.Targets[player] = {
		Class = 'Player',
		Player = player,
		Character = player.Character,
		LastUpdate = 0,
		Root = nil,
		Humanoid = nil,
		CoreInformation = { Visible = false, OnScreen = false, Root = nil },
	}
	vape:Clean(player.CharacterAdded:Connect(function(char)
		local entry = Targeting.Targets[player]
		if entry then
			entry.Character = char
			entry.LastUpdate = 0
			entry.Root = nil
			entry.Humanoid = nil
			entry.CoreInformation = { Visible = false, OnScreen = false, Root = nil }
		end
	end))
end

for _, player in playersService:GetPlayers() do
	registerPlayerTarget(player)
end
vape:Clean(playersService.PlayerAdded:Connect(registerPlayerTarget))
vape:Clean(playersService.PlayerRemoving:Connect(function(player)
	Targeting.Targets[player] = nil
end))

run(function()
	local military = workspace:FindFirstChild('Military')
	local events = workspace:FindFirstChild('Events')
	if events then
		for _, child in events:GetChildren() do
			if child.Name == 'BTR' then
				cacheSoldier(child)
			end
		end
		vape:Clean(events.ChildAdded:Connect(function(child)
			task.wait(1)
			if child.Name == 'BTR' then
				cacheSoldier(child)
			end
		end))
		vape:Clean(events.ChildRemoved:Connect(function(child)
			if child.Name == 'BTR' then
				Targeting.Targets[child] = nil
			end
		end))
	end
	if military then
		for _, folder in military:GetChildren() do
			for _, soldier in folder:GetChildren() do
				if soldier:IsA('Model') then
					cacheSoldier(soldier)
				end
			end
			vape:Clean(folder.ChildAdded:Connect(function(soldier)
				task.wait(1)
				if soldier:IsA('Model') then
					cacheSoldier(soldier)
				end
			end))
			vape:Clean(folder.ChildRemoved:Connect(function(soldier)
				Targeting.Targets[soldier] = nil
			end))
		end
	end
end)

local ignoreList = { nil, nil, nil, nil }
local MyShotQueue = {}
local LastPredictionPos = nil

local function tptbHeld()
	if not flags.TeleportToBullet then
		return false
	end
	local keyName = flags.TeleportToBulletKey or 'F'
	local ok, key = pcall(function()
		return Enum.KeyCode[keyName]
	end)
	if not ok or not key then
		return false
	end
	return userInputService:IsKeyDown(key)
end

local function aimbotActive()
	if not flags.AimbotEnabled then
		return false
	end
	if flags.DisableSilentWhileTPTB and flags.TeleportToBullet and tptbHeld() then
		return false
	end
	return true
end

local function getEnabledTargetParts()
	local parts = flags.TargetParts
	if type(parts) == 'table' and #parts > 0 then
		return parts
	end
	return { 'Head', 'UpperTorso', 'LowerTorso', 'HumanoidRootPart' }
end

---------------------------------------------------------------------------
-- Heartbeat targeting loop
---------------------------------------------------------------------------
vape:Clean(runService.Heartbeat:Connect(function()
	camera = workspace.CurrentCamera
	ignoreList[1] = camera
	ignoreList[2] = FallenState.ClientCharacter
	ignoreList[3] = workspace:FindFirstChild('VFX')
	ignoreList[4] = workspace:FindFirstChild('RocketFactoryPinkCardInvisWalls')
	RayParams.FilterDescendantsInstances = ignoreList

	local needTarget = aimbotActive() or flags.TargetRing or flags.FatBullet
	if not needTarget then
		Targeting.TargetPart = nil
		Targeting.TargetCharacter = nil
		Targeting.ScannedPosition = nil
		Targeting.ManipulatedPosition = nil
		Targeting.HitScanActive = false
		Targeting.ManipulationActive = false
		return
	end

	local TargetParts = getEnabledTargetParts()
	local Silent = aimbotActive() and flags.Mode == 'Silent'
	local DesiredPartName = TargetParts[math.random(#TargetParts)]
	local UseVisibleCheck = flags.VisibleCheck
	local DownCheck = flags.DownCheck
	local ClosestDistance = (flags.FovSize or 300) * 0.5
	local ClosestTarget, EntityCharacter, EntityData, EntityInstance, Visible

	local now = tick()

	for Entity, Object in pairs(Targeting.Targets) do
		if not Object then
			continue
		end

		local character = resolveCharacter(Entity, Object)
		Object.Character = character
		if not character or not character.Parent then
			Object.CoreInformation = Object.CoreInformation or {}
			Object.CoreInformation.Visible = false
			Object.CoreInformation.OnScreen = false
			Object.CoreInformation.Root = nil
			continue
		end

		if (now - (Object.LastUpdate or 0)) > (1 / 10) then
			Object.LastUpdate = now
			local humanoid = character:FindFirstChildOfClass('Humanoid')
			local root = getRoot(character)
			Object.Humanoid = humanoid
			Object.Root = root
			local Core = Object.CoreInformation or {}
			Object.CoreInformation = Core

			if not root or (camera.CFrame.Position - root.Position).Magnitude > 2000 then
				Core.Visible = false
				Core.OnScreen = false
				Core.Root = root
				Core.VisibleSince = nil
			else
				local _, onScreen = camera:WorldToViewportPoint(root.Position)
				local localHead = FallenState.ClientCharacter and FallenState.ClientCharacter:FindFirstChild('Head')
				local rootVisible = false
				if localHead then
					local origin = localHead.CFrame.Position
					local rr = workspace:Raycast(origin, root.Position - origin, RayParams)
					if rr and rr.Instance and rr.Instance:IsDescendantOf(character) then
						rootVisible = true
					end
				end
				if rootVisible then
					Core.VisibleSince = Core.VisibleSince or now
				else
					Core.VisibleSince = nil
				end
				local stableVisible = Core.VisibleSince and (now - Core.VisibleSince) >= 0.3 or false
				Core.Root = root
				Core.RootPosition = root.Position
				Core.OnScreen = onScreen
				Core.Visible = stableVisible
				Core.VisiblePart = stableVisible and root or nil
			end
		end

		local Core = Object.CoreInformation
		if not Core or not Core.Root or Entity == lplr then
			continue
		end
		if Entity:IsA('Player') and flags.TeamCheck and isTeam(Entity) then
			continue
		end
		if not Core.OnScreen then
			continue
		end

		local humanoid = Object.Humanoid
		if not humanoid or humanoid.Health <= 0 then
			continue
		end
		if DownCheck and humanoid:GetAttribute('Downed') then
			continue
		end

		local Distance = getDistanceFromCenter(Core.Root)
		if Distance >= ClosestDistance then
			continue
		end

		local tpart
		if UseVisibleCheck and Core.Visible then
			tpart = Core.VisiblePart
		else
			tpart = getTargetPart(character, DesiredPartName)
		end

		if tpart then
			ClosestDistance = Distance
			ClosestTarget = tpart
			EntityCharacter = character
			EntityData = Object
			EntityInstance = Entity
			Visible = Core.Visible
		end
	end

	local Manipulated, HitScanned
	local ManipulatedPosition, ManipulatedPart
	local ScannedPosition, ScannedPart

	if Silent and not Visible and ClosestTarget and EntityData and FallenState.ClientCharacter then
		local head = FallenState.ClientCharacter:FindFirstChild('Head')
		local StartCF = head and head.CFrame
		if head and StartCF then
			local bothOn = flags.HitScan and flags.Manipulation
			local hsThrottle = bothOn and (1 / 30) or (1 / 15)
			if (now - (EntityData.LastHitScanTime or 0)) > hsThrottle then
				EntityData.LastHitScanTime = now
				if flags.HitScan then
					local hs = GetHitScanPos(StartCF, ClosestTarget)
					if hs then
						HitScanned = true
						ScannedPart = ClosestTarget
						ScannedPosition = hs
					end
				end
				if HitScanned then
					EntityData.HitScanCache = { ScannedPart = ScannedPart, ScannedPosition = ScannedPosition }
					EntityData.HitScanCacheTime = now
				elseif EntityData.HitScanCache and (now - (EntityData.HitScanCacheTime or 0)) <= 3 then
					local cfg = EntityData.HitScanCache
					if cfg.ScannedPart and cfg.ScannedPart.Parent then
						local d = (cfg.ScannedPosition - cfg.ScannedPart.Position).Magnitude
						if d <= (flags.HitScanDistance or 5) + 0.05 then
							HitScanned = true
							ScannedPart = cfg.ScannedPart
							ScannedPosition = cfg.ScannedPosition
						else
							EntityData.HitScanCache = nil
						end
					else
						EntityData.HitScanCache = nil
					end
				else
					EntityData.HitScanCache = nil
				end
			else
				local cfg = EntityData.HitScanCache
				if cfg and cfg.ScannedPart and cfg.ScannedPart.Parent then
					local d = (cfg.ScannedPosition - cfg.ScannedPart.Position).Magnitude
					if d <= (flags.HitScanDistance or 5) + 0.05 then
						HitScanned = true
						ScannedPart = cfg.ScannedPart
						ScannedPosition = cfg.ScannedPosition
					end
				end
			end

			if flags.Manipulation then
				local manipThrottle = bothOn and (1 / 30) or 0.05
				if (now - (EntityData.LastManip or 0)) > manipThrottle then
					EntityData.LastManip = now
					local aimPoint = HitScanned and ScannedPosition or nil
					local vp = FindVisiblePosition(StartCF, ClosestTarget, aimPoint)
					if vp then
						Manipulated = true
						ManipulatedPart = ClosestTarget
						ManipulatedPosition = vp
						EntityData.LastManipCFG = {
							ManipulatedPosition = vp,
							ManipulatedPart = ClosestTarget,
						}
						EntityData.LastManipCFGTime = now
					elseif EntityData.LastManipCFG and (now - (EntityData.LastManipCFGTime or 0)) <= 1.5 then
						local cfg = EntityData.LastManipCFG
						if cfg.ManipulatedPart and cfg.ManipulatedPart.Parent then
							Manipulated = true
							ManipulatedPart = cfg.ManipulatedPart
							ManipulatedPosition = cfg.ManipulatedPosition
						else
							EntityData.LastManipCFG = nil
						end
					else
						EntityData.LastManipCFG = nil
					end
				elseif EntityData.LastManipCFG then
					local cfg = EntityData.LastManipCFG
					if cfg.ManipulatedPart and cfg.ManipulatedPart.Parent then
						Manipulated = true
						ManipulatedPart = cfg.ManipulatedPart
						ManipulatedPosition = cfg.ManipulatedPosition
					end
				end
			else
				EntityData.LastManipCFG = nil
			end
		end
	end

	Targeting.TargetPart = ClosestTarget
	Targeting.TargetCharacter = EntityCharacter
	Targeting.TargetObject = EntityData
	Targeting.ManipulatedPosition = Manipulated and ManipulatedPosition or nil
	Targeting.ManipulatedPart = Manipulated and ManipulatedPart or nil
	Targeting.ScannedPosition = HitScanned and ScannedPosition or nil
	Targeting.ScannedPart = HitScanned and ScannedPart or nil
	Targeting.HitScanActive = (Silent and not Visible and ClosestTarget and flags.HitScan) and true or false
	Targeting.ManipulationActive = (Silent and not Visible and ClosestTarget and flags.Manipulation) and true or false

	-- Memory mode: aim camera at target
	if aimbotActive() and flags.Mode == 'Memory' and ClosestTarget then
		camera.CFrame = CFrame.lookAt(camera.CFrame.Position, ClosestTarget.Position)
	end
end))

---------------------------------------------------------------------------
-- Combat Silent Aim module
---------------------------------------------------------------------------
run(function()
	local SilentAim
	local ModeDrop, HitChanceSlider
	local ManipToggle, ManipDist, ManipColor
	local HitScanToggle, HitScanDist, HitScanColor
	local VisCheck, VisCheckColor, DownCheckToggle, TeamCheckToggle
	local PartHead, PartUpper, PartLower, PartHRP
	local DrawFov, FovSize, FovColor, FovThickness
	local Indicators, TargetRing, PredictionDot
	local TPTB, TPTBKey, DisableSilentTPTB

	local fovGui, fovRing, fovStroke
	local indicatorGui, manipText, hitscanText, visibleText
	local ringParts = {}
	local predDot

	local function syncTargetParts()
		local list = {}
		if PartHead and PartHead.Enabled then table.insert(list, 'Head') end
		if PartUpper and PartUpper.Enabled then table.insert(list, 'UpperTorso') end
		if PartLower and PartLower.Enabled then table.insert(list, 'LowerTorso') end
		if PartHRP and PartHRP.Enabled then table.insert(list, 'HumanoidRootPart') end
		if #list == 0 then
			list = { 'Head' }
		end
		flags.TargetParts = list
	end

	local combatHooksInstalled = false
	local installCombatHooks

	SilentAim = vape.Categories.Combat:CreateModule({
		Name = 'Fallen Silent Aim',
		Function = function(callback)
			flags.AimbotEnabled = callback
			if fovGui then
				fovGui.Enabled = callback and flags.DrawFov
			end
			if callback and installCombatHooks and not combatHooksInstalled then
				installCombatHooks()
				combatHooksInstalled = true
			end
			if not callback then
				Targeting.TargetPart = nil
				Targeting.ManipulatedPosition = nil
				Targeting.ScannedPosition = nil
			end
		end,
		Tooltip = 'Fallen viewmodel silent aim with manipulation / hitscan',
	})

	ModeDrop = SilentAim:CreateDropdown({
		Name = 'Mode',
		List = { 'Silent', 'Memory' },
		Function = function(val)
			flags.Mode = val
		end,
	})
	flags.Mode = ModeDrop.Value

	HitChanceSlider = SilentAim:CreateSlider({
		Name = 'Hit Chance',
		Min = 0,
		Max = 100,
		Default = 100,
		Suffix = '%',
		Function = function(val)
			flags.HitChance = val
		end,
	})
	flags.HitChance = HitChanceSlider.Value

	ManipToggle = SilentAim:CreateToggle({
		Name = 'Manipulation',
		Function = function(val)
			flags.Manipulation = val
			if ManipDist then ManipDist.Object.Visible = val end
			if ManipColor then ManipColor.Object.Visible = val end
		end,
	})
	ManipDist = SilentAim:CreateSlider({
		Name = 'Manipulation Distance',
		Min = 1,
		Max = 10,
		Default = 10,
		Decimal = 10,
		Darker = true,
		Visible = false,
		Function = function(val)
			flags.ManipulationDistance = val
		end,
	})
	ManipColor = SilentAim:CreateColorSlider({
		Name = 'Manipulation Color',
		Darker = true,
		Visible = false,
		DefaultHue = 0,
	})

	HitScanToggle = SilentAim:CreateToggle({
		Name = 'Hit Scan',
		Function = function(val)
			flags.HitScan = val
			if HitScanDist then HitScanDist.Object.Visible = val end
			if HitScanColor then HitScanColor.Object.Visible = val end
		end,
	})
	HitScanDist = SilentAim:CreateSlider({
		Name = 'Hit Scan Distance',
		Min = 1,
		Max = 9.5,
		Default = 9.5,
		Decimal = 10,
		Darker = true,
		Visible = false,
		Function = function(val)
			flags.HitScanDistance = val
		end,
	})
	HitScanColor = SilentAim:CreateColorSlider({
		Name = 'Hit Scan Color',
		Darker = true,
		Visible = false,
		DefaultHue = 0.15,
	})

	VisCheck = SilentAim:CreateToggle({
		Name = 'Visible Check',
		Function = function(val)
			flags.VisibleCheck = val
			if VisCheckColor then
				VisCheckColor.Object.Visible = val
			end
		end,
	})
	VisCheckColor = SilentAim:CreateColorSlider({
		Name = 'Visible Check Color',
		Darker = true,
		Visible = false,
		DefaultHue = 0.33,
	})
	DownCheckToggle = SilentAim:CreateToggle({
		Name = 'Down Check',
		Default = true,
		Function = function(val)
			flags.DownCheck = val
		end,
	})
	flags.DownCheck = true
	TeamCheckToggle = SilentAim:CreateToggle({
		Name = 'Team Check',
		Function = function(val)
			flags.TeamCheck = val
		end,
	})

	PartHead = SilentAim:CreateToggle({
		Name = 'Target Head',
		Default = true,
		Function = syncTargetParts,
	})
	PartUpper = SilentAim:CreateToggle({
		Name = 'Target UpperTorso',
		Default = true,
		Function = syncTargetParts,
	})
	PartLower = SilentAim:CreateToggle({
		Name = 'Target LowerTorso',
		Function = syncTargetParts,
	})
	PartHRP = SilentAim:CreateToggle({
		Name = 'Target HRP',
		Default = true,
		Function = syncTargetParts,
	})
	syncTargetParts()

	DrawFov = SilentAim:CreateToggle({
		Name = 'Draw FOV',
		Function = function(val)
			flags.DrawFov = val
			if fovGui then
				fovGui.Enabled = SilentAim.Enabled and val
			end
		end,
	})
	FovSize = SilentAim:CreateSlider({
		Name = 'Fov Size',
		Min = 10,
		Max = 800,
		Default = 300,
		Function = function(val)
			flags.FovSize = val
		end,
	})
	flags.FovSize = FovSize.Value
	FovColor = SilentAim:CreateColorSlider({ Name = 'Fov Color' })
	FovThickness = SilentAim:CreateSlider({
		Name = 'Fov Thickness',
		Min = 1,
		Max = 4,
		Default = 1,
		Function = function(val)
			flags.FovThickness = val
		end,
	})

	Indicators = SilentAim:CreateToggle({
		Name = 'Combat Indicators',
		Function = function(val)
			flags.CombatIndicators = val
			if indicatorGui then
				indicatorGui.Enabled = val
			end
		end,
	})
	TargetRing = SilentAim:CreateToggle({
		Name = 'Target Ring',
		Function = function(val)
			flags.TargetRing = val
		end,
	})
	PredictionDot = SilentAim:CreateToggle({
		Name = 'Prediction Dot',
		Function = function(val)
			flags.PredictionDot = val
		end,
	})

	TPTB = SilentAim:CreateToggle({
		Name = 'Teleport To Bullet',
		Function = function(val)
			flags.TeleportToBullet = val
		end,
	})
	TPTBKey = SilentAim:CreateDropdown({
		Name = 'TPTB Key',
		List = { 'F', 'E', 'Q', 'C', 'V', 'X', 'Z', 'LeftAlt', 'LeftControl' },
		Function = function(val)
			flags.TeleportToBulletKey = val
		end,
	})
	flags.TeleportToBulletKey = TPTBKey.Value
	DisableSilentTPTB = SilentAim:CreateToggle({
		Name = 'Disable Silent While TPTB',
		Default = true,
		Function = function(val)
			flags.DisableSilentWhileTPTB = val
		end,
	})
	flags.DisableSilentWhileTPTB = true

	-- FOV / indicator UI
	do
		fovGui = Instance.new('ScreenGui')
		fovGui.Name = 'FallenFovGui'
		fovGui.IgnoreGuiInset = true
		fovGui.ResetOnSpawn = false
		fovGui.Enabled = false
		fovGui.Parent = guiParent()
		fovRing = Instance.new('Frame')
		fovRing.AnchorPoint = Vector2.new(0.5, 0.5)
		fovRing.BackgroundTransparency = 1
		fovRing.Parent = fovGui
		local corner = Instance.new('UICorner')
		corner.CornerRadius = UDim.new(1, 0)
		corner.Parent = fovRing
		fovStroke = Instance.new('UIStroke')
		fovStroke.Thickness = 1
		fovStroke.Parent = fovRing
		vape:Clean(fovGui)

		indicatorGui = Instance.new('ScreenGui')
		indicatorGui.Name = 'FallenCombatIndicators'
		indicatorGui.IgnoreGuiInset = true
		indicatorGui.ResetOnSpawn = false
		indicatorGui.Enabled = false
		indicatorGui.Parent = guiParent()
		local function makeLabel(y)
			local t = Instance.new('TextLabel')
			t.Size = UDim2.fromOffset(220, 18)
			t.Position = UDim2.new(0.5, -110, 0, y)
			t.BackgroundTransparency = 1
			t.Font = Enum.Font.GothamBold
			t.TextSize = 14
			t.TextStrokeTransparency = 0.5
			t.Visible = false
			t.Parent = indicatorGui
			return t
		end
		manipText = makeLabel(80)
		hitscanText = makeLabel(100)
		visibleText = makeLabel(120)
		vape:Clean(indicatorGui)
	end

	vape:Clean(runService.RenderStepped:Connect(function()
		if not SilentAim.Enabled then
			return
		end
		local m = userInputService:GetMouseLocation()
		if flags.DrawFov and fovRing then
			local size = flags.FovSize or 300
			fovRing.Size = UDim2.fromOffset(size, size)
			fovRing.Position = UDim2.fromOffset(m.X, m.Y)
			fovStroke.Thickness = flags.FovThickness or 1
			fovStroke.Color = colorFromSlider(FovColor)
			fovGui.Enabled = true
		elseif fovGui then
			fovGui.Enabled = false
		end

		if flags.CombatIndicators then
			indicatorGui.Enabled = true
			if Targeting.ManipulatedPosition then
				local distance = (Targeting.ManipulatedPosition - camera.CFrame.Position).Magnitude
				manipText.Text = string.format('Manipulated %.0fs', distance)
				manipText.TextColor3 = colorFromSlider(ManipColor)
				manipText.Visible = true
			else
				manipText.Visible = false
			end
			local scanPart = Targeting.ScannedPart or Targeting.TargetPart
			if Targeting.ScannedPosition and scanPart then
				local distance = (Targeting.ScannedPosition - scanPart.Position).Magnitude
				hitscanText.Text = string.format('Hitscan %.1fs', distance)
				hitscanText.TextColor3 = colorFromSlider(HitScanColor)
				hitscanText.Visible = true
			else
				hitscanText.Visible = false
			end
			if Targeting.TargetObject and Targeting.TargetObject.CoreInformation and Targeting.TargetObject.CoreInformation.Visible then
				visibleText.Text = 'Visible'
				visibleText.TextColor3 = colorFromSlider(VisCheckColor)
				visibleText.Visible = true
			else
				visibleText.Visible = false
			end
		elseif indicatorGui then
			indicatorGui.Enabled = false
		end

		-- Target ring (simple BillboardAdornment)
		if flags.TargetRing and Targeting.TargetCharacter then
			local root = getRoot(Targeting.TargetCharacter)
			if root then
				if not ringParts.highlight then
					local h = Instance.new('Highlight')
					h.Name = 'FallenTargetRing'
					h.FillTransparency = 1
					h.OutlineColor = Color3.fromRGB(255, 0, 0)
					h.OutlineTransparency = 0
					h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
					h.Parent = guiParent()
					ringParts.highlight = h
					vape:Clean(h)
				end
				ringParts.highlight.Adornee = Targeting.TargetCharacter
				ringParts.highlight.Enabled = true
			end
		elseif ringParts.highlight then
			ringParts.highlight.Enabled = false
		end

		-- Prediction dot
		if flags.PredictionDot and Targeting.TargetPart and LastPredictionPos then
			local world = Targeting.TargetPart.Position + LastPredictionPos
			local sp, on = camera:WorldToViewportPoint(world)
			if not predDot then
				predDot = Instance.new('Frame')
				predDot.Size = UDim2.fromOffset(6, 6)
				predDot.AnchorPoint = Vector2.new(0.5, 0.5)
				predDot.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
				predDot.BorderSizePixel = 0
				predDot.Parent = fovGui
				local c = Instance.new('UICorner')
				c.CornerRadius = UDim.new(1, 0)
				c.Parent = predDot
			end
			predDot.Visible = on
			predDot.Position = UDim2.fromOffset(sp.X, sp.Y)
		elseif predDot then
			predDot.Visible = false
		end
	end))

	-- CreateProjectile / blood / hole / network hooks (installed on first module enable)
	installCombatHooks = function()
		if not VFXModule then
			return
		end

		if not FallenState.ProjectileHooked and VFXModule.CreateProjectile then
			FallenState.ProjectileHooked = true
			local CreateProjectile = VFXModule.CreateProjectile
			VFXModule.CreateProjectile = function(self, ...)
				local Args = { ... }
				local Traceback = ''
				pcall(function()
					Traceback = debug.traceback()
				end)

				if
					flags.AimbotEnabled
					and Traceback:find('ViewmodelController')
					and Args[1]
					and type(Args[1]) == 'table'
					and Args[1].StepFunction ~= 'FakeStepFunc'
					and Args[1].HitFunction ~= 'FakeHitFunc'
					and not tostring(Args[1].HitFunction):find('Ignore')
				then
					if Targeting.TargetPart or Targeting.ScannedPosition or Targeting.ManipulatedPosition then
						Args[1].Filters = Args[1].Filters or {}
						for _, v in workspace:GetChildren() do
							if v:IsA('Folder') and v.Name ~= 'Military' and v.Name ~= 'Events' then
								local skip = false
								for _, c in v:GetChildren() do
									if c:IsA('Model') and SOLDIER_CLASS[c.Name] then
										skip = true
										break
									end
								end
								if not skip then
									table.insert(Args[1].Filters, v)
								end
							end
						end
						table.insert(Args[1].Filters, workspace.Terrain)
					end

					local ManipPos = Targeting.ManipulatedPosition
					FallenState.ShouldHit = (math.floor(Random.new():NextNumber(0, 1) * 100) / 100) <= ((flags.HitChance or 100) / 100)

					local stacklevel = isvalidlevel(3) and 3 or (isvalidlevel(2) and 2)
					if stacklevel and Targeting.TargetPart and debug.getstack and debug.setstack then
						LastPredictionPos = nil
						local startPos = Args[1].Position or Args[1].PositionFirst or camera.CFrame.Position
						local targetPos = Targeting.ScannedPosition or (Targeting.TargetPart and Targeting.TargetPart.Position)
						local oldspeed = Args[1].Speed
						local Gravity = Args[1].Gravity or 0
						local G = Gravity * -196.2

						local targetVel = Vector3.zero
						do
							local part = Targeting.TargetPart
							local char = part and part.Parent
							local root = char and (char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso'))
							local vel
							if root then
								local ok, v = pcall(function()
									return root.AssemblyLinearVelocity
								end)
								if ok then
									vel = v
								end
							end
							if (not vel or vel.Magnitude < 0.05) and part then
								local ok, v = pcall(function()
									return part.AssemblyLinearVelocity
								end)
								if ok then
									vel = v
								end
							end
							if vel and vel.Magnitude < 500 and vel.Magnitude == vel.Magnitude then
								targetVel = vel
							end
						end

						local pingComp = 0
						do
							local ok, ping = pcall(lplr.GetNetworkPing, lplr)
							if ok and type(ping) == 'number' and ping == ping and ping < 1 then
								pingComp = ping
							end
						end

						local Drop = 0
						local Lead = Vector3.zero
						if oldspeed and oldspeed > 0 and targetPos then
							local TimeToHit = (targetPos - startPos).Magnitude / oldspeed
							for _ = 1, 6 do
								Lead = targetVel * (TimeToHit + pingComp)
								Drop = -0.5 * G * TimeToHit * TimeToHit
								if tostring(Drop):find('nan') then
									Drop = 0
								end
								local aimPoint = targetPos + Lead + Vector3.new(0, Drop, 0)
								TimeToHit = (aimPoint - startPos).Magnitude / oldspeed
							end
						end
						if tostring(Lead.X):find('nan') then
							Lead = Vector3.zero
						end
						LastPredictionPos = Lead + Vector3.new(0, Drop, 0)
						FallenState.LastPredictionPos = LastPredictionPos
						FallenState.LastBulletSpeed = oldspeed
						FallenState.LastBulletGravity = Gravity

						pcall(function()
							local Stack = debug.getstack(stacklevel)
							local CameraIndex, HRPIndex, FlashIndex, MouseIndex
							local CameraValue, HRPValue, FlashValue, MouseValue
							for i = 1, 100 do
								local v = rawget(Stack, i)
								if v then
									local t = typeof(v)
									if t == 'CFrame' and not CameraValue then
										CameraValue = v
										CameraIndex = i
									elseif t == 'CFrame' and CameraValue and not HRPValue and v ~= CameraValue then
										HRPValue = v
										HRPIndex = i
									elseif t == 'Vector3' and not FlashValue then
										FlashValue = v
										FlashIndex = i
									elseif t == 'Vector3' and FlashValue and v ~= FlashValue and not MouseValue then
										MouseValue = v
										MouseIndex = i
									end
								end
							end
							if CameraValue and HRPValue and FlashValue and MouseValue and Targeting.TargetPart then
								local finalTarget = Targeting.ScannedPosition or Targeting.TargetPart.Position
								if LastPredictionPos then
									finalTarget = finalTarget + LastPredictionPos
								end
								local camPos = CameraValue.Position
								local hrpPos = HRPValue.Position
								local newFlash = CFrame.new(FlashValue, finalTarget).Position
								if ManipPos then
									local offC = camPos - FlashValue
									local offH = hrpPos - FlashValue
									CameraValue = CFrame.new(ManipPos + offC, finalTarget)
									HRPValue = CFrame.new(ManipPos + offH, finalTarget)
									newFlash = ManipPos
								else
									CameraValue = CFrame.new(camPos, finalTarget)
									HRPValue = CFrame.new(hrpPos, finalTarget)
								end
								debug.setstack(stacklevel, CameraIndex, CameraValue)
								debug.setstack(stacklevel, HRPIndex, HRPValue)
								debug.setstack(stacklevel, FlashIndex, newFlash)
								debug.setstack(stacklevel, MouseIndex, finalTarget)
							end
						end)
					end

					if Args[1].Terminate then
						Args[1].Terminate = nil
					end

					if flags.AimbotEnabled and Targeting.TargetPart and flags.Mode == 'Silent' and FallenState.ShouldHit then
						local p = Targeting.ScannedPart or Targeting.TargetPart
						local hit = Targeting.ScannedPosition or (p and p.Position)
						if p and hit then
							if LastPredictionPos and not Targeting.ScannedPosition then
								hit = hit + LastPredictionPos
							end
							local origin = Args[1].Position
							local dir = (hit - origin).Unit
							local cp = CFrame.lookAt(origin, hit).Position
							if Targeting.ManipulatedPosition then
								local mp = Targeting.ManipulatedPosition
								dir = (hit - mp).Unit
								cp = CFrame.lookAt(mp, hit).Position
							end
							Args[1].Position = cp
							if Args[1].PositionFirst then
								Args[1].PositionFirst = cp
							end
							Args[1].DirectionFirst = dir
							Args[1].Direction = dir
						end
					end
				end

				if
					Traceback:find('ViewmodelController')
					and Args[1]
					and type(Args[1]) == 'table'
					and Args[1].StepFunction ~= 'FakeStepFunc'
					and Args[1].HitFunction ~= 'FakeHitFunc'
					and type(Args[1].HitFunction) == 'function'
					and not tostring(Args[1].HitFunction):find('Ignore')
				then
					local origHit = Args[1].HitFunction
					local shotOrigin = Targeting.ManipulatedPosition or Args[1].Position or Args[1].PositionFirst
					Args[1].HitFunction = function(...)
						table.insert(MyShotQueue, { origin = shotOrigin, time = tick() })
						return origHit(...)
					end
				end

				return CreateProjectile(self, unpack(Args))
			end
		end

		local function popMyShot()
			local now = tick()
			while #MyShotQueue > 0 and (now - MyShotQueue[1].time) > 5 do
				table.remove(MyShotQueue, 1)
			end
			if #MyShotQueue > 0 then
				return table.remove(MyShotQueue, 1)
			end
			return nil
		end

		local function onMyHit(position)
			local mine = popMyShot()
			if not mine then
				return
			end
			if flags.BulletTracers and FallenState.SpawnTracer then
				FallenState.SpawnTracer(position, mine.origin)
			end
			if flags.Hitmarkers and FallenState.SpawnHitmarker then
				FallenState.SpawnHitmarker(position)
			end
			if flags.TeleportToBullet and tptbHeld() then
				local char = lplr.Character
				local hrp = char and char:FindFirstChild('HumanoidRootPart')
				if hrp then
					hrp.CFrame = CFrame.new(position) + Vector3.new(0, 2, 0)
					task.wait()
					hrp.CFrame = CFrame.new(position) + Vector3.new(0, 2, 0)
				end
			end
		end

		if not FallenState.BloodHooked and VFXModule.CreateBlood then
			FallenState.BloodHooked = true
			local CreateBlood = VFXModule.CreateBlood
			VFXModule.CreateBlood = function(self, hit, position, ...)
				onMyHit(position)
				return CreateBlood(self, hit, position, ...)
			end
		end

		if not FallenState.HoleHooked and VFXModule.CreateHole then
			FallenState.HoleHooked = true
			local CreateHole = VFXModule.CreateHole
			VFXModule.CreateHole = function(self, hit, position, ...)
				onMyHit(position)
				return CreateHole(self, hit, position, ...)
			end
		end

		if RaycastUtil and not FallenState.RaycastHooked and RaycastUtil.Raycast then
			FallenState.RaycastHooked = true
			local OldRaycast = RaycastUtil.Raycast
			RaycastUtil.Raycast = function(self, ...)
				local Arguments = { ... }
				local Traceback = ''
				pcall(function()
					Traceback = debug.traceback()
				end)

				if Traceback:find('ViewmodelController') and flags.Reach then
					if typeof(Arguments[2]) == 'Vector3' then
						Arguments[2] = Arguments[2] * 10
					end
				end

				if
					flags.InstantBullet
					and flags.AimbotEnabled
					and Targeting.TargetPart
					and Traceback:find('VFXModule')
				then
					local TargetPart = Targeting.TargetPart
					if typeof(TargetPart) == 'Instance' and TargetPart:IsA('BasePart') and TargetPart.Parent then
						local Output = { OldRaycast(self, unpack(Arguments)) }
						if typeof(Output[2]) == 'Vector3' then
							local Offset = Vector3.new(-0.26287078857421875, 0.144287109375, 0.584716796875)
							return TargetPart, TargetPart.Position + Offset, Vector3.new(0, 0, 1), TargetPart.Material, Output[5], Output[6]
						end
					end
				end

				return OldRaycast(self, unpack(Arguments))
			end
		end
	end

	-- VMNetworkPointer discovery + fire rewrite
	vape:Clean(runService.Heartbeat:Connect(function()
		if FallenState.NetworkHooked or not (getgc and getconstants and getinfo and getupvalue and hookfunction) then
			return
		end
		local hookedSet = FallenState._hookedClosures
		if not hookedSet then
			hookedSet = setmetatable({}, { __mode = 'k' })
			FallenState._hookedClosures = hookedSet
		end
		for _, v in getgc(true) do
			if type(v) == 'function' and (not islclosure or islclosure(v)) and not hookedSet[v] then
				local ok, constants = pcall(getconstants, v)
				if not ok or not constants then
					continue
				end
				local infoOk, info = pcall(getinfo, v)
				if infoOk and info and type(info.source) == 'string' and info.source:find('ViewmodelController') then
					if constants[1] == 'Parent' and constants[2] == 'CFrame' then
						hookedSet[v] = true
						local network = getupvalue(v, 1)
						if type(network) == 'function' then
							FallenState.VMNetworkPointer = network
							FallenState.NetworkHooked = true
							local old
							old = hookfunction(network, function(rt, remote, hash, ...)
								local args = { ... }
								if hash == FIRE_HASH then
									if rawlen(args) ~= 8 or not Targeting.TargetPart then
										return old(rt, remote, hash, unpack(args))
									end
									local ServerTime, WeaponName, CameraCFrame, MuzzlePos, CharacterCFrame, Spread, OtherSpread, MouseRaycast =
										unpack(args)
									local targetPos = Targeting.ScannedPosition or Targeting.TargetPart.Position
									if LastPredictionPos then
										targetPos = targetPos + LastPredictionPos
									end
									local CharacterPos = CharacterCFrame.Position
									local ManipPos = Targeting.ManipulatedPosition
									if ManipPos then
										CharacterPos = ManipPos
									end
									MouseRaycast = targetPos
									local FlashWorld = CharacterCFrame:PointToWorldSpace(MuzzlePos)
									local offset = CameraCFrame:PointToObjectSpace(FlashWorld)
									CameraCFrame = CFrame.lookAt(CharacterPos, targetPos)
									MuzzlePos = offset
									local hawk = CFrame.lookAt(CharacterPos, targetPos)
									local pitch, yaw = hawk:ToEulerAnglesYXZ()
									CharacterCFrame = CFrame.new(CharacterPos) * CFrame.fromEulerAnglesYXZ(pitch, yaw, 0)
									args = { ServerTime, WeaponName, CameraCFrame, MuzzlePos, CharacterCFrame, Spread, OtherSpread, MouseRaycast }
								end
								return old(rt, remote, hash, unpack(args))
							end)
						end
					end
				end
			end
			if FallenState.NetworkHooked then
				break
			end
		end
	end))
end)

---------------------------------------------------------------------------
-- Gun Mods
---------------------------------------------------------------------------
run(function()
	local GunMods
	local NoRecoil, NoSpread, NoSway, InstantBullet, RapidFire, RapidRate
	local InstantEquip, AlwaysAuto, InstaAim, ReachToggle, AutoReload, ReloadDelay
	local CustomHit, HitVol

	local function mutateToolInfo(applyFn, restoreFn)
		if not ToolInfo or not ToolInfoCopy then
			return
		end
		for name, data in pairs(ToolInfo) do
			local copy = ToolInfoCopy[name]
			if data and data.Weapon then
				if applyFn then
					applyFn(data, copy)
				elseif restoreFn and copy then
					restoreFn(data, copy)
				end
			end
		end
	end

	GunMods = vape.Categories.Combat:CreateModule({
		Name = 'Fallen Gun Mods',
		Function = function(callback)
			if not callback then
				flags.NoRecoil = false
				flags.NoSpread = false
				flags.NoSway = false
				flags.InstantBullet = false
				flags.RapidFire = false
				flags.Reach = false
				flags.AutoReload = false
				flags.CustomHitSound = false
				-- restore ToolInfo
				if ToolInfo and ToolInfoCopy then
					for name, data in pairs(ToolInfo) do
						local copy = ToolInfoCopy[name]
						if data and data.Weapon and copy and copy.Weapon then
							data.Weapon.Auto = copy.Weapon.Auto
							if copy.Weapon.EquipAnimSpeed ~= nil then
								data.Weapon.EquipAnimSpeed = type(copy.Weapon.EquipAnimSpeed) == 'table'
									and deepCopy(copy.Weapon.EquipAnimSpeed)
									or copy.Weapon.EquipAnimSpeed
							end
							if copy.Weapon.AimDownSpeed then
								data.Weapon.AimDownSpeed.In = copy.Weapon.AimDownSpeed.In
								data.Weapon.AimDownSpeed.Out = copy.Weapon.AimDownSpeed.Out
							end
						end
					end
				end
			end
		end,
		Tooltip = 'Recoil / spread / fire-rate / equip mods for Fallen weapons',
	})

	NoRecoil = GunMods:CreateToggle({
		Name = 'No Recoil',
		Function = function(val)
			flags.NoRecoil = val
		end,
	})
	NoSpread = GunMods:CreateToggle({
		Name = 'No Spread',
		Function = function(val)
			flags.NoSpread = val
		end,
	})
	NoSway = GunMods:CreateToggle({
		Name = 'No Sway',
		Function = function(val)
			flags.NoSway = val
		end,
	})
	InstantBullet = GunMods:CreateToggle({
		Name = 'Instant Bullet',
		Function = function(val)
			flags.InstantBullet = val
		end,
	})
	RapidFire = GunMods:CreateToggle({
		Name = 'Rapid Fire',
		Function = function(val)
			flags.RapidFire = val
			if RapidRate then RapidRate.Object.Visible = val end
		end,
	})
	RapidRate = GunMods:CreateSlider({
		Name = 'Rapid Fire Rate',
		Min = 1,
		Max = 1.6,
		Default = 1.3,
		Decimal = 100,
		Darker = true,
		Visible = false,
		Function = function(val)
			flags.RapidFireRate = val
		end,
	})
	flags.RapidFireRate = RapidRate.Value

	InstantEquip = GunMods:CreateToggle({
		Name = 'Instant Equip',
		Function = function(v)
			if not ToolInfo or not ToolInfoCopy then
				return
			end
			for name, data in pairs(ToolInfo) do
				if data.Weapon and data.Weapon.EquipAnimSpeed ~= nil then
					if v then
						if type(data.Weapon.EquipAnimSpeed) == 'table' then
							for key in pairs(data.Weapon.EquipAnimSpeed) do
								data.Weapon.EquipAnimSpeed[key] = 10000
							end
						else
							data.Weapon.EquipAnimSpeed = 10000
						end
					else
						local copy = ToolInfoCopy[name]
						if copy and copy.Weapon then
							if type(copy.Weapon.EquipAnimSpeed) == 'table' then
								for key, val in pairs(copy.Weapon.EquipAnimSpeed) do
									data.Weapon.EquipAnimSpeed[key] = val
								end
							else
								data.Weapon.EquipAnimSpeed = copy.Weapon.EquipAnimSpeed
							end
						end
					end
				end
			end
		end,
	})

	AlwaysAuto = GunMods:CreateToggle({
		Name = 'Always Auto',
		Function = function(v)
			if not ToolInfo or not ToolInfoCopy then
				return
			end
			for name, data in pairs(ToolInfo) do
				if data.Weapon and data.Weapon.Auto ~= nil then
					if v then
						data.Weapon.Auto = true
					else
						local copy = ToolInfoCopy[name]
						if copy and copy.Weapon then
							data.Weapon.Auto = copy.Weapon.Auto
						end
					end
				end
			end
		end,
	})

	InstaAim = GunMods:CreateToggle({
		Name = 'Insta Aim',
		Function = function(v)
			if not ToolInfo or not ToolInfoCopy then
				return
			end
			for Index, Value in pairs(ToolInfo) do
				if type(Value) == 'table' and rawget(Value, 'Weapon') then
					local Old = ToolInfoCopy[Index] and ToolInfoCopy[Index].Weapon
					if Old and rawget(Value.Weapon, 'AimDownSpeed') then
						if v then
							Value.Weapon.AimDownSpeed.In = 0
							Value.Weapon.AimDownSpeed.Out = 0
						else
							Value.Weapon.AimDownSpeed.In = Old.AimDownSpeed.In
							Value.Weapon.AimDownSpeed.Out = Old.AimDownSpeed.Out
						end
					end
				end
			end
		end,
	})

	ReachToggle = GunMods:CreateToggle({
		Name = 'Reach',
		Function = function(val)
			flags.Reach = val
		end,
	})

	AutoReload = GunMods:CreateToggle({
		Name = 'Auto Reload',
		Function = function(val)
			flags.AutoReload = val
			if ReloadDelay then ReloadDelay.Object.Visible = val end
		end,
	})
	ReloadDelay = GunMods:CreateSlider({
		Name = 'Reload Delay',
		Min = 0.5,
		Max = 5,
		Default = 3,
		Decimal = 10,
		Darker = true,
		Visible = false,
		Suffix = 's',
		Function = function(val)
			flags.AutoReloadDelay = val
		end,
	})
	flags.AutoReloadDelay = ReloadDelay.Value

	CustomHit = GunMods:CreateToggle({
		Name = 'Custom Hit Sound',
		Function = function(val)
			flags.CustomHitSound = val
		end,
	})
	HitVol = GunMods:CreateSlider({
		Name = 'Hit Sound Volume',
		Min = 0,
		Max = 2,
		Default = 0.8,
		Decimal = 10,
		Function = function(val)
			flags.HitsoundsVolume = val
		end,
	})

	if ItemClass and ItemClass.AttachmentStats and not FallenState.AttachmentHooked then
		FallenState.AttachmentHooked = true
		local oldAttachmentStats = ItemClass.AttachmentStats
		ItemClass.AttachmentStats = function(v50, v51)
			local tb = ''
			pcall(function()
				tb = debug.traceback()
			end)
			local r = oldAttachmentStats(v50, v51)
			if tb:find('ViewmodelController') and r then
				if flags.RapidFire then
					r.FireRateMult = (flags.RapidFireRate or 1.3) - 1
				end
				if flags.NoRecoil then
					r.RecoilMult = -1
				end
				if flags.NoSpread then
					r.AimSpreadMult = -1
					r.HipSpreadMult = -1
				end
				if flags.NoSway then
					r.SwayMult = -1
				end
				r.RangeMult = 10
				r.HideTracer = false
			end
			return r
		end
	end

	if TableUtil and TableUtil.TableRandom and not FallenState.TableRandomHooked then
		FallenState.TableRandomHooked = true
		local oldTableRandom = TableUtil.TableRandom
		TableUtil.TableRandom = function(_, v1, v2, v3)
			if flags.NoRecoil then
				return type(v1) == 'table' and v1[1] or v1
			end
			return oldTableRandom(_, v1, v2, v3)
		end
	end

	local function reloadGun()
		if not FallenState.VMNetworkPointer then
			return
		end
		local char = FallenState.ClientCharacter
		if not char or not char:FindFirstChild('ViewmodelController') then
			return
		end
		local ViewmodelController = char.ViewmodelController
		if not char:FindFirstChild('InventoryController') or not Items then
			return
		end
		local ok, inv = pcall(function()
			return char.InventoryController.Fetch:Invoke()
		end)
		if not ok or not inv or not inv.Toolbar then
			return
		end
		local equipped = inv.Toolbar[ViewmodelController:GetAttribute('Equipped')]
		if not equipped or equipped == 0 then
			return
		end
		local gun = Items[equipped.ID]
		local ammoType = gun and gun.AmmoType
		if not ammoType then
			return
		end
		local ammoId = 'None'
		for _, containerName in { 'Inventory', 'Toolbar' } do
			for _, item in inv[containerName] do
				if item ~= 0 and item.Amount > 0 then
					local def = Items[item.ID]
					if def and def.Type and def.Type:find('Ammo') and def.AmmoType == ammoType then
						ammoId = item.ID
						break
					end
				end
			end
			if ammoId ~= 'None' then
				break
			end
		end
		if ammoId == 'None' then
			return
		end
		pcall(FallenState.VMNetworkPointer, 'Fire', RELOAD_REMOTE, RELOAD_HASH, workspace:GetServerTimeNow())
	end

	vape:Clean(runService.Heartbeat:Connect(function()
		if not (GunMods.Enabled and flags.AutoReload) then
			return
		end
		local now = tick()
		if now - FallenState.LastAutoReload > (flags.AutoReloadDelay or 3) then
			FallenState.LastAutoReload = now
			reloadGun()
		end
	end))

	-- Custom hit sound
	local normal_hit = soundService:FindFirstChild('Hit')
	local hit_head = soundService:FindFirstChild('HitHead')
	local defaultHitId = normal_hit and normal_hit.SoundId
	local defaultHeadId = hit_head and hit_head.SoundId
	local defaultHitVol = normal_hit and normal_hit.Volume
	local defaultHeadVol = hit_head and hit_head.Volume
	vape:Clean(runService.Heartbeat:Connect(function()
		if not (normal_hit and hit_head) then
			return
		end
		if flags.CustomHitSound and GunMods.Enabled then
			normal_hit.SoundId = 'rbxassetid://3748776946'
			hit_head.SoundId = 'rbxassetid://3748776946'
			normal_hit.Volume = flags.HitsoundsVolume or 0.8
			hit_head.Volume = flags.HitsoundsVolume or 0.8
		elseif defaultHitId then
			normal_hit.SoundId = defaultHitId
			hit_head.SoundId = defaultHeadId
			normal_hit.Volume = defaultHitVol
			hit_head.Volume = defaultHeadVol
		end
	end))
end)

---------------------------------------------------------------------------
-- Shared ESP helpers
---------------------------------------------------------------------------
local EspStore = {
	objects = {}, -- [model] = {billboard, highlight, ...}
}

local SKEL_PAIRS = {
	{ 'Head', 'UpperTorso' },
	{ 'UpperTorso', 'LowerTorso' },
	{ 'UpperTorso', 'LeftUpperArm' },
	{ 'LeftUpperArm', 'LeftLowerArm' },
	{ 'LeftLowerArm', 'LeftHand' },
	{ 'UpperTorso', 'RightUpperArm' },
	{ 'RightUpperArm', 'RightLowerArm' },
	{ 'RightLowerArm', 'RightHand' },
	{ 'LowerTorso', 'LeftUpperLeg' },
	{ 'LeftUpperLeg', 'LeftLowerLeg' },
	{ 'LeftLowerLeg', 'LeftFoot' },
	{ 'LowerTorso', 'RightUpperLeg' },
	{ 'RightUpperLeg', 'RightLowerLeg' },
	{ 'RightLowerLeg', 'RightFoot' },
}

local function destroyDrawingList(list)
	if not list then
		return
	end
	for _, obj in list do
		pcall(function()
			obj:Remove()
		end)
	end
end

local function getEntityFlags(extra)
	local bits = {}
	if extra and extra.downed then
		table.insert(bits, 'DOWN')
	end
	if extra and extra.visible then
		table.insert(bits, 'VIS')
	end
	if extra and extra.boss then
		table.insert(bits, 'BOSS')
	end
	return table.concat(bits, ' ')
end

local function clearEspEntry(model)
	local entry = EspStore.objects[model]
	if not entry then
		return
	end
	for _, obj in pairs(entry) do
		if typeof(obj) == 'Instance' then
			pcall(function()
				obj:Destroy()
			end)
		elseif type(obj) == 'table' and obj.lines then
			destroyDrawingList(obj.lines)
		elseif type(obj) == 'userdata' or (type(obj) == 'table' and obj.Remove) then
			pcall(function()
				obj:Remove()
			end)
		end
	end
	EspStore.objects[model] = nil
end

local function ensureEspEntry(model, settings, label)
	if not model or not model.Parent then
		return
	end
	local root = getRoot(model)
	if not root then
		return
	end
	local entry = EspStore.objects[model]
	if not entry then
		entry = {}
		EspStore.objects[model] = entry
	end

	if settings.Name or settings.Distance or settings.Health or settings.Weapon then
		if not entry.bb then
			local bb = Instance.new('BillboardGui')
			bb.Name = 'FallenESP'
			bb.AlwaysOnTop = true
			bb.Size = UDim2.fromOffset(200, 50)
			bb.StudsOffset = Vector3.new(0, 3, 0)
			bb.Adornee = root
			bb.Parent = guiParent()
			local text = Instance.new('TextLabel')
			text.Size = UDim2.fromScale(1, 1)
			text.BackgroundTransparency = 1
			text.TextStrokeTransparency = 0.4
			text.Font = Enum.Font.GothamBold
			text.TextSize = 13
			text.TextColor3 = Color3.new(1, 1, 1)
			text.Parent = bb
			entry.bb = bb
			entry.label = text
		else
			entry.bb.Adornee = root
		end
	elseif entry.bb then
		entry.bb:Destroy()
		entry.bb = nil
		entry.label = nil
	end

	if settings.Chams then
		if not entry.hl then
			local hl = Instance.new('Highlight')
			hl.Name = 'FallenChams'
			hl.Adornee = model
			hl.FillTransparency = settings.ChamsStyle == 'Glow' and 0.5 or 0.35
			hl.OutlineTransparency = 0
			hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			hl.Parent = guiParent()
			entry.hl = hl
		else
			entry.hl.Adornee = model
		end
	elseif entry.hl then
		entry.hl:Destroy()
		entry.hl = nil
	end

	if settings.BoundingBox then
		if settings.BoxStyle == 'Corner' and DrawingLib then
			if entry.box then
				entry.box:Destroy()
				entry.box = nil
			end
			if not entry.cornerDraw then
				entry.cornerDraw = { lines = {} }
				for i = 1, 8 do
					local line = DrawingLib.new('Line')
					line.Thickness = 1
					line.Visible = false
					entry.cornerDraw.lines[i] = line
				end
			end
		else
			if entry.cornerDraw then
				destroyDrawingList(entry.cornerDraw.lines)
				entry.cornerDraw = nil
			end
			if not entry.box and root then
			local box = Instance.new('BoxHandleAdornment')
			box.Name = 'FallenBox'
			box.Adornee = root
			box.AlwaysOnTop = true
			box.ZIndex = 5
			box.Transparency = 0.7
			box.Size = root.Size + Vector3.new(1, 2, 1)
			box.Parent = guiParent()
			entry.box = box
		elseif entry.box then
			entry.box.Adornee = root
		end
		end
	elseif entry.box then
		entry.box:Destroy()
		entry.box = nil
	end

	if settings.Healthbar and root then
		if not entry.healthFrame then
			local bb = Instance.new('BillboardGui')
			bb.Name = 'FallenHealth'
			bb.AlwaysOnTop = true
			bb.Size = UDim2.fromOffset(54, 6)
			bb.StudsOffset = Vector3.new(0, 2.2, 0)
			bb.Adornee = root
			bb.Parent = guiParent()
			local back = Instance.new('Frame')
			back.Size = UDim2.fromScale(1, 1)
			back.BackgroundColor3 = Color3.new(0, 0, 0)
			back.BorderSizePixel = 0
			back.Parent = bb
			local fill = Instance.new('Frame')
			fill.Name = 'Fill'
			fill.Size = UDim2.fromScale(1, 1)
			fill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
			fill.BorderSizePixel = 0
			fill.Parent = back
			entry.healthFrame = bb
			entry.healthFill = fill
		else
			entry.healthFrame.Adornee = root
		end
	elseif entry.healthFrame then
		entry.healthFrame:Destroy()
		entry.healthFrame = nil
		entry.healthFill = nil
	end

	return entry
end

local function updateCornerBox(entry, model, col)
	if not (entry and entry.cornerDraw and DrawingLib) then
		return
	end
	local cf, size = model:GetBoundingBox()
	local hx, hy, hz = size.X * 0.5, size.Y * 0.5, size.Z * 0.5
	local corners = {}
	for _, off in {
		Vector3.new(-hx, hy, -hz), Vector3.new(hx, hy, -hz), Vector3.new(hx, hy, hz), Vector3.new(-hx, hy, hz),
		Vector3.new(-hx, -hy, -hz), Vector3.new(hx, -hy, -hz), Vector3.new(hx, -hy, hz), Vector3.new(-hx, -hy, hz),
	} do
		local sp, on = camera:WorldToViewportPoint((cf * CFrame.new(off)).Position)
		table.insert(corners, on and Vector2.new(sp.X, sp.Y) or nil)
	end
	local function line(i, a, b)
		local ln = entry.cornerDraw.lines[i]
		if not ln then
			return
		end
		if corners[a] and corners[b] then
			ln.From = corners[a]
			ln.To = corners[b]
			ln.Color = col
			ln.Visible = true
		else
			ln.Visible = false
		end
	end
	line(1, 1, 2); line(2, 2, 3); line(3, 3, 4); line(4, 4, 1)
	line(5, 5, 6); line(6, 6, 7); line(7, 7, 8); line(8, 8, 5)
end

local function updateSkeleton(entry, character, col)
	if not (entry and DrawingLib) then
		return
	end
	if not entry.skeleton then
		entry.skeleton = { lines = {} }
	end
	local idx = 0
	for _, pair in SKEL_PAIRS do
		local a = character:FindFirstChild(pair[1])
		local b = character:FindFirstChild(pair[2])
		idx = idx + 1
		local ln = entry.skeleton.lines[idx]
		if not ln then
			ln = DrawingLib.new('Line')
			ln.Thickness = 1
			entry.skeleton.lines[idx] = ln
		end
		if a and b then
			local pa, oa = camera:WorldToViewportPoint(a.Position)
			local pb, ob = camera:WorldToViewportPoint(b.Position)
			if oa and ob then
				ln.From = Vector2.new(pa.X, pa.Y)
				ln.To = Vector2.new(pb.X, pb.Y)
				ln.Color = col
				ln.Visible = true
			else
				ln.Visible = false
			end
		else
			ln.Visible = false
		end
	end
	for i = idx + 1, #entry.skeleton.lines do
		entry.skeleton.lines[i].Visible = false
	end
end

local function drawOffscreenArrow(entry, rootPos, col)
	if not (entry and DrawingLib) then
		return
	end
	if not entry.offscreen then
		entry.offscreen = DrawingLib.new('Triangle')
		entry.offscreen.Filled = true
	end
	local tri = entry.offscreen
	local vp = camera.ViewportSize
	local sp, on = camera:WorldToViewportPoint(rootPos)
	if on then
		tri.Visible = false
		return
	end
	local center = Vector2.new(vp.X * 0.5, vp.Y * 0.5)
	local dir = (Vector2.new(sp.X, sp.Y) - center).Unit
	local edge = math.min(vp.X, vp.Y) * 0.45
	local tip = center + dir * edge
	local perp = Vector2.new(-dir.Y, dir.X)
	tri.PointA = tip
	tri.PointB = tip - dir * 14 + perp * 8
	tri.PointC = tip - dir * 14 - perp * 8
	tri.Color = col
	tri.Visible = true
end

local function updateEspVisuals(model, entry, settings, colorVis, colorOcc, isVisible, dist, extra)
	if not entry then
		return
	end
	local col = isVisible and colorVis or colorOcc
	if entry.label then
		local bits = {}
		if settings.Name then
			table.insert(bits, extra and extra.name or model.Name)
		end
		if settings.Distance and dist then
			table.insert(bits, string.format('[%.0f]', dist))
		end
		if settings.Health and extra and extra.health then
			table.insert(bits, string.format('%.0fHP', extra.health))
		end
		if settings.Weapon and extra and extra.weapon then
			table.insert(bits, extra.weapon)
		end
		if settings.Flags and extra and extra.flagText and extra.flagText ~= '' then
			table.insert(bits, extra.flagText)
		end
		entry.label.Text = table.concat(bits, ' ')
		entry.label.TextColor3 = col
		entry.bb.Enabled = true
	end
	if entry.hl then
		entry.hl.FillColor = isVisible and (settings.ChamsVisColor or col) or (settings.ChamsOccColor or col)
		entry.hl.OutlineColor = entry.hl.FillColor
		entry.hl.Enabled = true
	end
	if entry.box then
		entry.box.Color3 = col
		entry.box.Visible = settings.BoxStyle ~= 'Corner'
	end
	if entry.cornerDraw and settings.BoxStyle == 'Corner' then
		updateCornerBox(entry, model, col)
	elseif entry.cornerDraw then
		for _, ln in entry.cornerDraw.lines do
			ln.Visible = false
		end
	end
	if entry.healthFill and extra and extra.health and extra.maxHealth then
		local pct = math.clamp(extra.health / math.max(extra.maxHealth, 1), 0, 1)
		entry.healthFill.Size = UDim2.fromScale(pct, 1)
		entry.healthFill.BackgroundColor3 = Color3.fromRGB(255 * (1 - pct), 255 * pct, 0)
		if entry.healthFrame then
			entry.healthFrame.Enabled = true
		end
	end
	if settings.Skeleton then
		updateSkeleton(entry, model, col)
	elseif entry.skeleton then
		destroyDrawingList(entry.skeleton.lines)
		entry.skeleton = nil
	end
	if settings.Offscreen and extra and extra.offscreen then
		drawOffscreenArrow(entry, extra.rootPos or model:GetPivot().Position, col)
	elseif entry.offscreen then
		entry.offscreen.Visible = false
	end
end

local function getGunName(char)
	if not char then
		return nil
	end
	for _, model in char:GetChildren() do
		if model:IsA('Model') and model.Name ~= 'Hair' and model.Name ~= 'HolsterModel' and model.PrimaryPart then
			if
				model:FindFirstChild('Detail')
				or model:FindFirstChild('Main')
				or model:FindFirstChild('Handle')
				or model:FindFirstChild('Attachments')
			then
				return model.Name
			end
		end
	end
	return nil
end

local function makeEspModule(category, name, classFilter)
	local mod
	local Enabled, Bounding, BoxStyle, Skeleton, ViewAngle, Healthbar
	local ShowName, ShowDist, ShowWeapon, ShowHealth, ShowFlags, Offscreen, Chams, ChamsStyle, MaxDist
	local ColVis, ColOcc, ChamsVis, ChamsOcc

	local settings = {
		Enabled = false,
		BoundingBox = false,
		BoxStyle = 'Solid',
		Skeleton = false,
		ViewAngle = false,
		Healthbar = false,
		Name = true,
		Distance = true,
		Weapon = false,
		Health = false,
		Flags = false,
		Offscreen = false,
		Chams = false,
		ChamsStyle = 'Solid',
		MaxDistance = 2000,
	}

	mod = category:CreateModule({
		Name = name,
		Function = function(callback)
			settings.Enabled = callback
			if not callback then
				for model, entry in pairs(EspStore.objects) do
					local obj = Targeting.Targets[model] or (model:IsA('Player') and Targeting.Targets[model])
					-- leave cleanup to update loop via class filter
				end
			end
		end,
		Tooltip = name .. ' ESP for Fallen',
	})

	Enabled = mod -- module itself is enable
	Bounding = mod:CreateToggle({
		Name = 'Bounding Box',
		Function = function(v)
			settings.BoundingBox = v
		end,
	})
	BoxStyle = mod:CreateDropdown({
		Name = 'Box Style',
		List = { 'Solid', 'Corner' },
		Function = function(v)
			settings.BoxStyle = v
		end,
	})
	Skeleton = mod:CreateToggle({
		Name = 'Skeleton',
		Function = function(v)
			settings.Skeleton = v
		end,
	})
	ViewAngle = mod:CreateToggle({
		Name = 'View Angle',
		Function = function(v)
			settings.ViewAngle = v
		end,
	})
	Healthbar = mod:CreateToggle({
		Name = 'Healthbar',
		Function = function(v)
			settings.Healthbar = v
		end,
	})
	ShowName = mod:CreateToggle({
		Name = 'Name',
		Default = true,
		Function = function(v)
			settings.Name = v
		end,
	})
	ShowDist = mod:CreateToggle({
		Name = 'Distance',
		Default = true,
		Function = function(v)
			settings.Distance = v
		end,
	})
	ShowWeapon = mod:CreateToggle({
		Name = 'Weapon',
		Function = function(v)
			settings.Weapon = v
		end,
	})
	ShowHealth = mod:CreateToggle({
		Name = 'Health',
		Function = function(v)
			settings.Health = v
		end,
	})
	ShowFlags = mod:CreateToggle({
		Name = 'Flags',
		Function = function(v)
			settings.Flags = v
		end,
	})
	Offscreen = mod:CreateToggle({
		Name = 'Offscreen',
		Function = function(v)
			settings.Offscreen = v
		end,
	})
	Chams = mod:CreateToggle({
		Name = 'Chams',
		Function = function(v)
			settings.Chams = v
		end,
	})
	ChamsStyle = mod:CreateDropdown({
		Name = 'Chams Style',
		List = { 'Solid', 'Glow' },
		Function = function(v)
			settings.ChamsStyle = v
		end,
	})
	MaxDist = mod:CreateSlider({
		Name = 'Max Distance',
		Min = 100,
		Max = 4000,
		Default = 2000,
		Function = function(v)
			settings.MaxDistance = v
		end,
	})
	ColVis = mod:CreateColorSlider({ Name = 'Visible Color', DefaultHue = 0.33 })
	ColOcc = mod:CreateColorSlider({ Name = 'Occluded Color', DefaultHue = 0 })
	ChamsVis = mod:CreateColorSlider({ Name = 'Chams Visible', DefaultHue = 0.55 })
	ChamsOcc = mod:CreateColorSlider({ Name = 'Chams Occluded', DefaultHue = 0.05 })

	vape:Clean(runService.RenderStepped:Connect(function()
		if not mod.Enabled then
			return
		end
		local camPos = camera.CFrame.Position
		local localChar = FallenState.ClientCharacter
		local seen = {}

		for entity, object in pairs(Targeting.Targets) do
			local class = object.Class
			if classFilter == 'Player' and class ~= 'Player' then
				continue
			end
			if classFilter == 'AI' and class ~= 'AI' then
				continue
			end
			if classFilter == 'Boss' and class ~= 'Boss' then
				continue
			end

			local character = resolveCharacter(entity, object)
			if not character or not character.Parent then
				continue
			end
			local root = getRoot(character)
			local hum = character:FindFirstChildOfClass('Humanoid')
			if not root or not hum or hum.Health <= 0 then
				continue
			end
			local dist = (camPos - root.Position).Magnitude
			if dist > settings.MaxDistance then
				continue
			end
			local _, onScreen = camera:WorldToViewportPoint(root.Position)
			if not onScreen and not settings.Offscreen then
				continue
			end

			local isVisible = false
			if localChar then
				local head = localChar:FindFirstChild('Head')
				if head then
					local hit = workspace:Raycast(head.Position, root.Position - head.Position, RayParams)
					isVisible = not hit or (hit.Instance and hit.Instance:IsDescendantOf(character))
				end
			end

			settings.ChamsVisColor = colorFromSlider(ChamsVis)
			settings.ChamsOccColor = colorFromSlider(ChamsOcc)
			local entry = ensureEspEntry(character, settings, character.Name)
			updateEspVisuals(
				character,
				entry,
				settings,
				colorFromSlider(ColVis),
				colorFromSlider(ColOcc),
				isVisible,
				dist,
				{
					name = class == 'Player' and object.Player.Name or character.Name,
					health = hum.Health,
					maxHealth = hum.MaxHealth,
					weapon = getGunName(character),
					downed = hum:GetAttribute('Downed'),
					visible = isVisible,
					boss = class == 'Boss',
					flagText = getEntityFlags({
						downed = hum:GetAttribute('Downed'),
						visible = isVisible,
						boss = class == 'Boss',
					}),
					offscreen = not onScreen,
					rootPos = root.Position,
				}
			)
			seen[character] = true
		end

		-- cleanup unseen for this filter
		for model, entry in pairs(EspStore.objects) do
			if not seen[model] then
				local obj = nil
				for ent, data in pairs(Targeting.Targets) do
					local c = data.Class == 'Player' and (data.Player and data.Player.Character) or data.Character
					if c == model then
						obj = data
						break
					end
				end
				if obj and ((classFilter == 'Player' and obj.Class == 'Player') or (classFilter == 'AI' and obj.Class == 'AI') or (classFilter == 'Boss' and obj.Class == 'Boss')) then
					if not mod.Enabled or not seen[model] then
						clearEspEntry(model)
					end
				end
			end
		end
	end))

	return mod
end

run(function()
	makeEspModule(vape.Categories.Render, 'Fallen Player ESP', 'Player')
end)
run(function()
	makeEspModule(vape.Categories.Render, 'Fallen AI ESP', 'AI')
end)
run(function()
	makeEspModule(vape.Categories.Render, 'Fallen Boss ESP', 'Boss')
end)

---------------------------------------------------------------------------
-- World ESP
---------------------------------------------------------------------------
run(function()
	local WorldESP
	local toggles = {}
	local colors = {}
	local maxDist
	local worldObjects = {} -- [inst] = billboard

	local CATEGORIES = {
		Nodes = { 'Node', 'ResourceNode', 'Harvest' },
		['Body Bags'] = { 'BodyBag', 'Body Bag', 'Corpse' },
		Items = { 'Drop', 'Pickup', 'Loot' },
		Raids = { 'Raid', 'RaidZone' },
		['Timed Crates'] = { 'TimedCrate', 'Timed Crate' },
		['Care Packages'] = { 'CarePackage', 'Care Package', 'Airdrop' },
		Sleepers = { 'Sleeper', 'Sleeping' },
		['Cloth Plants'] = { 'Cloth', 'Hemp', 'Plant' },
	}

	local function nameMatches(instName, keys)
		local lower = string.lower(instName)
		for _, key in keys do
			if lower:find(string.lower(key), 1, true) then
				return true
			end
		end
		return false
	end

	WorldESP = vape.Categories.Render:CreateModule({
		Name = 'Fallen World ESP',
		Function = function(callback)
			if not callback then
				for _, bb in pairs(worldObjects) do
					pcall(function()
						bb:Destroy()
					end)
				end
				table.clear(worldObjects)
			end
		end,
		Tooltip = 'Nodes, bags, crates, raids, sleepers, plants',
	})

	for catName in pairs(CATEGORIES) do
		toggles[catName] = WorldESP:CreateToggle({
			Name = catName,
			Default = true,
			Function = function() end,
		})
		colors[catName] = WorldESP:CreateColorSlider({
			Name = catName .. ' Color',
			Darker = true,
		})
	end
	maxDist = WorldESP:CreateSlider({
		Name = 'Max Distance',
		Min = 50,
		Max = 3000,
		Default = 800,
	})

	local scanFolders = { 'Bases', 'Events', 'Animals', 'Drops', 'Plants' }

	vape:Clean(runService.Heartbeat:Connect(function()
		if not WorldESP.Enabled then
			return
		end
		-- throttle
		if (tick() * 2) % 1 > 0.05 then
			return
		end
		local camPos = camera.CFrame.Position
		local seen = {}
		local limit = maxDist.Value

		for _, folderName in scanFolders do
			local folder = workspace:FindFirstChild(folderName)
			if not folder then
				continue
			end
			for _, desc in folder:GetDescendants() do
				if not (desc:IsA('Model') or desc:IsA('BasePart')) then
					continue
				end
				local matchedCat
				for catName, keys in pairs(CATEGORIES) do
					if toggles[catName] and toggles[catName].Enabled and nameMatches(desc.Name, keys) then
						matchedCat = catName
						break
					end
				end
				if not matchedCat then
					continue
				end
				local pos
				if desc:IsA('BasePart') then
					pos = desc.Position
				else
					local r = getRoot(desc) or (desc:IsA('Model') and desc.PrimaryPart) or desc:FindFirstChildWhichIsA('BasePart')
					pos = r and r.Position
				end
				if not pos then
					continue
				end
				local dist = (camPos - pos).Magnitude
				if dist > limit then
					continue
				end
				seen[desc] = true
				local bb = worldObjects[desc]
				if not bb then
					bb = Instance.new('BillboardGui')
					bb.Name = 'FallenWorldESP'
					bb.AlwaysOnTop = true
					bb.Size = UDim2.fromOffset(160, 28)
					bb.StudsOffset = Vector3.new(0, 2, 0)
					bb.Adornee = desc:IsA('BasePart') and desc or (getRoot(desc) or (desc:IsA('Model') and desc.PrimaryPart))
					bb.Parent = guiParent()
					local text = Instance.new('TextLabel')
					text.Name = 'Label'
					text.Size = UDim2.fromScale(1, 1)
					text.BackgroundTransparency = 1
					text.Font = Enum.Font.Gotham
					text.TextSize = 12
					text.TextStrokeTransparency = 0.5
					text.Parent = bb
					worldObjects[desc] = bb
				end
				local label = bb:FindFirstChild('Label')
				if label then
					label.Text = string.format('%s [%.0f]', desc.Name, dist)
					label.TextColor3 = colorFromSlider(colors[matchedCat])
				end
			end
		end

		for inst, bb in pairs(worldObjects) do
			if not seen[inst] or not inst.Parent then
				bb:Destroy()
				worldObjects[inst] = nil
			end
		end
	end))
end)

---------------------------------------------------------------------------
-- Crosshair
---------------------------------------------------------------------------
run(function()
	local Crosshair
	local Length, Width, Gap, Color, StickTarget
	local gui, lines = nil, {}

	local function rebuild()
		if gui then
			gui:Destroy()
		end
		gui = Instance.new('ScreenGui')
		gui.Name = 'FallenCrosshair'
		gui.IgnoreGuiInset = true
		gui.ResetOnSpawn = false
		gui.Parent = guiParent()
		vape:Clean(gui)
		lines = {}
		for i = 1, 4 do
			local f = Instance.new('Frame')
			f.BorderSizePixel = 0
			f.AnchorPoint = Vector2.new(0.5, 0.5)
			f.Parent = gui
			lines[i] = f
		end
	end

	Crosshair = vape.Categories.Render:CreateModule({
		Name = 'Fallen Crosshair',
		Function = function(callback)
			if callback then
				rebuild()
			elseif gui then
				gui.Enabled = false
			end
		end,
	})
	Length = Crosshair:CreateSlider({ Name = 'Length', Min = 2, Max = 30, Default = 8 })
	Width = Crosshair:CreateSlider({ Name = 'Width', Min = 1, Max = 6, Default = 2 })
	Gap = Crosshair:CreateSlider({ Name = 'Gap', Min = 0, Max = 20, Default = 4 })
	Color = Crosshair:CreateColorSlider({ Name = 'Color' })
	StickTarget = Crosshair:CreateToggle({ Name = 'Stick To Target' })

	vape:Clean(runService.RenderStepped:Connect(function()
		if not Crosshair.Enabled or not gui then
			return
		end
		gui.Enabled = true
		local pos = userInputService:GetMouseLocation()
		if StickTarget.Enabled and Targeting.TargetPart then
			local sp, on = camera:WorldToViewportPoint(Targeting.TargetPart.Position)
			if on then
				pos = Vector2.new(sp.X, sp.Y)
			end
		end
		local col = colorFromSlider(Color)
		local L, W, G = Length.Value, Width.Value, Gap.Value
		-- top, bottom, left, right
		lines[1].Size = UDim2.fromOffset(W, L)
		lines[1].Position = UDim2.fromOffset(pos.X, pos.Y - G - L / 2)
		lines[2].Size = UDim2.fromOffset(W, L)
		lines[2].Position = UDim2.fromOffset(pos.X, pos.Y + G + L / 2)
		lines[3].Size = UDim2.fromOffset(L, W)
		lines[3].Position = UDim2.fromOffset(pos.X - G - L / 2, pos.Y)
		lines[4].Size = UDim2.fromOffset(L, W)
		lines[4].Position = UDim2.fromOffset(pos.X + G + L / 2, pos.Y)
		for _, f in lines do
			f.BackgroundColor3 = col
		end
	end))
end)

---------------------------------------------------------------------------
-- Bullet Tracers + Hitmarkers
---------------------------------------------------------------------------
run(function()
	local Tracers
	local TexDrop, Col1, Col2, Bright, Life
	local HitMod, HitSize, HitLife, HitColor

	local TRACER_STYLES = {
		Default = { Asset = 'rbxassetid://128372145766358', Width = 0.4 },
		Lightning = { Asset = 'rbxassetid://16892528550', Width = 2 },
		Dark = { Asset = 'rbxassetid://119588180395545', Width = 1 },
	}

	FallenState.SpawnTracer = function(position, originPos)
		if not flags.BulletTracers then
			return
		end
		local origin = originPos
		if not origin then
			local head = FallenState.ClientCharacter and FallenState.ClientCharacter:FindFirstChild('Head')
			origin = head and head.Position
		end
		if not origin then
			return
		end
		local vms = workspace:FindFirstChild('VFX') and workspace.VFX:FindFirstChild('VMs')
		if not vms then
			vms = workspace.Terrain
		end
		local info = TRACER_STYLES[flags.BulletTracersStyle or 'Default'] or TRACER_STYLES.Default
		local att0 = Instance.new('Attachment')
		att0.WorldPosition = origin
		att0.Parent = vms
		local att1 = Instance.new('Attachment')
		att1.WorldPosition = origin
		att1.Parent = vms
		local beam = Instance.new('Beam')
		beam.Attachment0 = att0
		beam.Attachment1 = att1
		beam.Texture = info.Asset
		beam.Width0 = info.Width
		beam.Width1 = info.Width
		beam.FaceCamera = true
		beam.LightEmission = 1
		beam.Brightness = flags.BulletTracersBrightness or 8
		beam.TextureMode = Enum.TextureMode.Stretch
		beam.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, flags.BulletTracerColor1 or Color3.new(1, 1, 1)),
			ColorSequenceKeypoint.new(1, flags.BulletTracerColor2 or Color3.new(1, 0.5, 0)),
		})
		beam.Parent = vms
		task.spawn(function()
			tweenService:Create(att1, TweenInfo.new(0.35), { WorldPosition = position }):Play()
			task.wait(flags.BulletTracersLifetime or 1)
			local tw = tweenService:Create(beam, TweenInfo.new(0.4), { Width0 = 0, Width1 = 0 })
			tw:Play()
			tw.Completed:Wait()
			beam:Destroy()
			att0:Destroy()
			att1:Destroy()
		end)
	end

	FallenState.SpawnHitmarker = function(position)
		if not flags.Hitmarkers then
			return
		end
		local part = Instance.new('Part')
		part.Anchored = true
		part.CanCollide = false
		part.Size = Vector3.new(0.2, 0.2, 0.2)
		part.Transparency = 1
		part.Position = position
		part.Parent = workspace
		local bb = Instance.new('BillboardGui')
		bb.Size = UDim2.fromOffset(flags.HitmarkerSize or 24, flags.HitmarkerSize or 24)
		bb.AlwaysOnTop = true
		bb.Parent = part
		local label = Instance.new('TextLabel')
		label.Size = UDim2.fromScale(1, 1)
		label.BackgroundTransparency = 1
		label.Text = 'x'
		label.Font = Enum.Font.GothamBold
		label.TextSize = flags.HitmarkerSize or 24
		label.TextColor3 = flags.HitmarkerColor or Color3.new(1, 1, 1)
		label.Parent = bb
		debris:AddItem(part, flags.HitmarkerLifetime or 0.4)
	end

	Tracers = vape.Categories.Render:CreateModule({
		Name = 'Fallen Bullet Tracers',
		Function = function(callback)
			flags.BulletTracers = callback
		end,
	})
	TexDrop = Tracers:CreateDropdown({
		Name = 'Texture',
		List = { 'Default', 'Lightning', 'Dark' },
		Function = function(v)
			flags.BulletTracersStyle = v
		end,
	})
	Col1 = Tracers:CreateColorSlider({ Name = 'Color 1' })
	Col2 = Tracers:CreateColorSlider({ Name = 'Color 2', DefaultHue = 0.08 })
	Bright = Tracers:CreateSlider({
		Name = 'Brightness',
		Min = 1,
		Max = 16,
		Default = 8,
		Function = function(v)
			flags.BulletTracersBrightness = v
		end,
	})
	Life = Tracers:CreateSlider({
		Name = 'Lifetime',
		Min = 0.2,
		Max = 3,
		Default = 1,
		Decimal = 10,
		Function = function(v)
			flags.BulletTracersLifetime = v
		end,
	})
	vape:Clean(runService.Heartbeat:Connect(function()
		if Tracers.Enabled then
			flags.BulletTracerColor1 = colorFromSlider(Col1)
			flags.BulletTracerColor2 = colorFromSlider(Col2)
		end
	end))

	HitMod = vape.Categories.Render:CreateModule({
		Name = 'Fallen Hitmarkers',
		Function = function(callback)
			flags.Hitmarkers = callback
		end,
	})
	HitSize = HitMod:CreateSlider({
		Name = 'Size',
		Min = 8,
		Max = 48,
		Default = 24,
		Function = function(v)
			flags.HitmarkerSize = v
		end,
	})
	HitLife = HitMod:CreateSlider({
		Name = 'Lifetime',
		Min = 0.1,
		Max = 2,
		Default = 0.4,
		Decimal = 10,
		Function = function(v)
			flags.HitmarkerLifetime = v
		end,
	})
	HitColor = HitMod:CreateColorSlider({ Name = 'Color' })
	vape:Clean(runService.Heartbeat:Connect(function()
		if HitMod.Enabled then
			flags.HitmarkerColor = colorFromSlider(HitColor)
		end
	end))
end)

---------------------------------------------------------------------------
-- Lighting
---------------------------------------------------------------------------
run(function()
	local LightingMod
	local Fullbright, Ambient, TimeOfDay, FogDensity, Bloom, RemoveGrass
	local saved = {}

	local function capture()
		saved.Ambient = lighting.Ambient
		saved.Brightness = lighting.Brightness
		saved.ClockTime = lighting.ClockTime
		saved.FogEnd = lighting.FogEnd
		saved.FogStart = lighting.FogStart
		saved.OutdoorAmbient = lighting.OutdoorAmbient
	end
	capture()

	LightingMod = vape.Categories.Render:CreateModule({
		Name = 'Fallen Lighting',
		Function = function(callback)
			if not callback then
				lighting.Ambient = saved.Ambient
				lighting.Brightness = saved.Brightness
				lighting.ClockTime = saved.ClockTime
				lighting.FogEnd = saved.FogEnd
				lighting.FogStart = saved.FogStart
				lighting.OutdoorAmbient = saved.OutdoorAmbient
				local bloom = lighting:FindFirstChildOfClass('BloomEffect')
				if bloom then
					bloom.Enabled = false
				end
			end
		end,
	})
	Fullbright = LightingMod:CreateToggle({ Name = 'Fullbright', Default = true })
	Ambient = LightingMod:CreateColorSlider({ Name = 'Ambient' })
	TimeOfDay = LightingMod:CreateSlider({ Name = 'Time', Min = 0, Max = 24, Default = 12, Decimal = 10 })
	FogDensity = LightingMod:CreateSlider({ Name = 'Fog Density', Min = 0, Max = 1, Default = 0, Decimal = 100 })
	Bloom = LightingMod:CreateToggle({ Name = 'Bloom' })
	RemoveGrass = LightingMod:CreateToggle({ Name = 'Remove Grass' })

	vape:Clean(runService.Heartbeat:Connect(function()
		if not LightingMod.Enabled then
			return
		end
		if Fullbright.Enabled then
			lighting.Brightness = 2
			lighting.Ambient = Color3.new(1, 1, 1)
			lighting.OutdoorAmbient = Color3.new(1, 1, 1)
			lighting.FogEnd = 1e6
		else
			lighting.Ambient = colorFromSlider(Ambient)
		end
		lighting.ClockTime = TimeOfDay.Value
		if FogDensity.Value > 0 then
			lighting.FogStart = 0
			lighting.FogEnd = math.max(50, 500 * (1 - FogDensity.Value))
		end
		local bloomFx = lighting:FindFirstChildOfClass('BloomEffect')
		if Bloom.Enabled then
			if not bloomFx then
				bloomFx = Instance.new('BloomEffect')
				bloomFx.Parent = lighting
			end
			bloomFx.Enabled = true
			bloomFx.Intensity = 0.4
			bloomFx.Size = 24
			bloomFx.Threshold = 0.9
		elseif bloomFx then
			bloomFx.Enabled = false
		end
		if RemoveGrass.Enabled then
			pcall(function()
				workspace.Terrain.Decoration = false
			end)
		end
	end))
end)

---------------------------------------------------------------------------
-- XRay Bases
---------------------------------------------------------------------------
run(function()
	local XRay
	local Transparency
	local modified = {}

	local BASE_PART_NAMES = {
		Wall = true, ['Half Wall'] = true, ['Low Wall'] = true, Doorway = true, Window = true,
		Foundation = true, Floor = true, ['Triangle Floor'] = true, ['Floor Frame'] = true,
		['L-Shaped Stairs'] = true, ['U-Shaped Stairs'] = true, ['Foundation Steps'] = true,
		['Triangle Foundation'] = true, Ceiling = true,
	}

	XRay = vape.Categories.Render:CreateModule({
		Name = 'Fallen XRay Bases',
		Function = function(callback)
			if not callback then
				for part, props in pairs(modified) do
					if part.Parent then
						part.LocalTransparencyModifier = props.ltm or 0
						part.Transparency = props.trans
					end
				end
				table.clear(modified)
			end
		end,
	})
	Transparency = XRay:CreateSlider({
		Name = 'Transparency',
		Min = 0,
		Max = 1,
		Default = 0.7,
		Decimal = 100,
	})

	vape:Clean(runService.Heartbeat:Connect(function()
		if not XRay.Enabled then
			return
		end
		local bases = workspace:FindFirstChild('Bases')
		if not bases then
			return
		end
		local t = Transparency.Value
		for _, desc in bases:GetDescendants() do
			if desc:IsA('BasePart') and (BASE_PART_NAMES[desc.Name] or desc.Name:find('Wall') or desc.Name:find('Floor') or desc.Name:find('Foundation')) then
				if not modified[desc] then
					modified[desc] = { trans = desc.Transparency, ltm = desc.LocalTransparencyModifier }
				end
				desc.LocalTransparencyModifier = t
			end
		end
	end))
end)

---------------------------------------------------------------------------
-- Viewmodel Sandbox
---------------------------------------------------------------------------
run(function()
	local VMSandbox
	local ItemChams, ArmChams, ItemColor, ArmColor, ItemMat, ArmMat

	VMSandbox = vape.Categories.Render:CreateModule({
		Name = 'Fallen Viewmodel Sandbox',
		Function = function() end,
		Tooltip = 'Recolor / material on workspace.VFX.VMs',
	})
	ItemChams = VMSandbox:CreateToggle({ Name = 'Item Chams', Default = true })
	ArmChams = VMSandbox:CreateToggle({ Name = 'Arm Chams', Default = true })
	ItemColor = VMSandbox:CreateColorSlider({ Name = 'Item Color', DefaultHue = 0.7 })
	ArmColor = VMSandbox:CreateColorSlider({ Name = 'Arm Color', DefaultHue = 0.1 })
	ItemMat = VMSandbox:CreateDropdown({
		Name = 'Item Material',
		List = { 'ForceField', 'Neon', 'SmoothPlastic', 'Glass' },
	})
	ArmMat = VMSandbox:CreateDropdown({
		Name = 'Arm Material',
		List = { 'ForceField', 'Neon', 'SmoothPlastic', 'Glass' },
	})

	vape:Clean(runService.RenderStepped:Connect(function()
		if not VMSandbox.Enabled then
			return
		end
		local vfx = workspace:FindFirstChild('VFX')
		local vms = vfx and vfx:FindFirstChild('VMs')
		if not vms then
			return
		end
		for _, model in vms:GetChildren() do
			if not model:IsA('Model') then
				continue
			end
			for _, part in model:GetDescendants() do
				if not part:IsA('BasePart') then
					continue
				end
				local isArm = part.Name:lower():find('arm') or part.Name:lower():find('hand') or part.Name:lower():find('glove')
				if isArm and ArmChams.Enabled then
					part.Color = colorFromSlider(ArmColor)
					pcall(function()
						part.Material = Enum.Material[ArmMat.Value]
					end)
				elseif not isArm and ItemChams.Enabled then
					part.Color = colorFromSlider(ItemColor)
					pcall(function()
						part.Material = Enum.Material[ItemMat.Value]
					end)
				end
			end
		end
	end))
end)

---------------------------------------------------------------------------
-- Entity refresh
---------------------------------------------------------------------------
run(function()
	local function refreshEntityState()
		if entitylib and entitylib.refresh then
			pcall(entitylib.refresh)
		end
	end

	vape:Clean(lplr.CharacterAdded:Connect(function()
		task.delay(0.5, refreshEntityState)
		task.delay(2, refreshEntityState)
	end))

	for _, folderName in { 'Animals', 'Events', 'Bases' } do
		local folder = workspace:FindFirstChild(folderName)
		if folder then
			vape:Clean(folder.DescendantAdded:Connect(function(obj)
				if obj:IsA('Model') then
					if SOLDIER_CLASS[obj.Name] then
						cacheSoldier(obj)
					end
					if entitylib and entitylib.tryAddFakePlayer then
						task.defer(entitylib.tryAddFakePlayer, obj)
					end
				end
			end))
		end
	end

	-- Keep visualizer ignore list in sync with VMs
	vape:Clean(runService.Heartbeat:Connect(function()
		local vfx = workspace:FindFirstChild('VFX')
		if not vfx then
			return
		end
		local vms = vfx:FindFirstChild('VMs')
		if vms and vape.Libraries.visualizerModels then
			for _, model in vms:GetChildren() do
				if model:IsA('Model') and not table.find(vape.Libraries.visualizerModels, model) then
					table.insert(vape.Libraries.visualizerModels, model)
				end
			end
		end
	end))
end)

if vape.CreateNotification then
	local serverLabel = fallen.ServerType ~= 'Unknown' and (' (' .. fallen.ServerType .. ')') or ''
	vape:CreateNotification('Fallen Survival', 'Pass 1 loaded' .. serverLabel, 5)
end
