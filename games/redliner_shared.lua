local run = function(func)
	local ok, err = pcall(func)
	if not ok then
		warn('[REDLINER]', err)
	end
end

local cloneref = cloneref or function(obj)
	return obj
end

local playersService = cloneref(game:GetService('Players'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local collectionService = cloneref(game:GetService('CollectionService'))
local runService = cloneref(game:GetService('RunService'))
local inputService = cloneref(game:GetService('UserInputService'))
local workspaceService = cloneref(workspace)

local gameCamera = workspaceService.CurrentCamera
local lplr = playersService.LocalPlayer
local vape = shared.vape
local entitylib = vape.Libraries.entity
local targetinfo = vape.Libraries.targetinfo

local REDLINER_GAME_IDS = {
	[7265339759] = true,
	[115875349872417] = true,
}
local REDLINER_PLACES = {
	[115875349872417] = true,
	[126691165749976] = true,
	[94987506187454] = true,
}

if not REDLINER_GAME_IDS[game.GameId] and not REDLINER_PLACES[game.PlaceId] then
	return
end

vape:Remove('Killaura')

if not vape.Categories.Minigames then
	vape.Categories.Minigames = vape:CreateCategory({
		Name = 'Minigames',
		Icon = 'vape/assets/new/minigames.png'
	})
end

local minigames = vape.Categories.Minigames

local function notif(...)
	return vape:CreateNotification(...)
end

local Packets
local Util
local PlaceContext
local mapMain

local packetTemplates = {
	melee = nil,
	gun = nil,
	grapple = nil,
	parry = nil,
	dash = nil,
	heat = nil,
}

local packetLog = {}
local PACKET_LOG_MAX = 80

local NO_ARG_PACKETS = {
	'_x01d1e6369b1ddabb',
	'_x2b80b9b0eee78387',
	'_x609f99d3a8520d69',
	'_x65d117c21ab35208',
	'_x54d2d509e605e4a2',
	'_x5962b203e0f968e5',
	'_xd280acb67659621a',
	'_xfc69375ed1634248',
	'_xbbc4a0659c684667',
	'_xd62c578b7c77d170',
	'_xfa0d0cdb5e28525c',
}

local function getRoot(plr)
	local char = plr and plr.Character
	return char and char:FindFirstChild('HumanoidRootPart')
end

local function getCharFromHurtbox(part)
	return part and part:FindFirstAncestorWhichIsA('Model')
end

local function isEnemyModel(model)
	if not model or model == lplr.Character then
		return false
	end
	local plr = playersService:GetPlayerFromCharacter(model)
	if not plr or plr == lplr then
		return false
	end
	return true
end

local function getMapMain()
	if mapMain and mapMain.Parent then
		return mapMain
	end
	local map = workspaceService:FindFirstChild('Map')
	mapMain = map and map:FindFirstChild('Main')
	return mapMain
end

local function getMapRayParams()
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	params.IgnoreWater = true
	local main = getMapMain()
	params.FilterDescendantsInstances = main and {main} or {}
	return params
end

local function initGameModules()
	if Packets then
		return true
	end

	local assets = replicatedStorage:WaitForChild('Assets', 20)
	if not assets then
		return false
	end

	local modules = assets:WaitForChild('ModuleScripts', 20)
	if not modules then
		return false
	end

	local okPackets, loadedPackets = pcall(require, modules:WaitForChild('Packets', 10))
	if not okPackets then
		warn('[REDLINER] Failed to load Packets:', loadedPackets)
		return false
	end

	Packets = loadedPackets

	pcall(function()
		Util = require(assets.SharedClasses:WaitForChild('Util'))
	end)
	pcall(function()
		PlaceContext = require(modules:WaitForChild('PlaceContext'))
	end)

	getMapMain()
	return true
end

local function pushPacketLog(name, args)
	table.insert(packetLog, 1, {
		t = tick(),
		name = name,
		n = args and args.n or 0,
		args = args,
	})
	while #packetLog > PACKET_LOG_MAX do
		table.remove(packetLog)
	end
end

local function hookPacket(name, packet, templateKey)
	if not packet or packet._redlinerHooked then
		return
	end
	local oldFire = packet.Fire
	packet.Fire = function(self, ...)
		local packed = table.pack(...)
		pushPacketLog(name, packed)
		if templateKey then
			packetTemplates[templateKey] = packed
		end
		return oldFire(self, ...)
	end
	packet._redlinerHooked = true
end

local function installPacketHooks()
	if not initGameModules() then
		return false
	end

	hookPacket('_x2e2c62e0acfc88ae', Packets._x2e2c62e0acfc88ae, 'melee')
	hookPacket('_x77a8b8d28b943359', Packets._x77a8b8d28b943359, 'gun')
	hookPacket('_xefd6d8e74acc7f88', Packets._xefd6d8e74acc7f88, 'grapple')
	hookPacket('_xdb2548bded1dd8e3', Packets._xdb2548bded1dd8e3, 'heat')

	for _, id in NO_ARG_PACKETS do
		hookPacket(id, Packets[id])
	end

	return true
end

local function bindActionDiscovery()
	if not Packets then
		return
	end

	local lastKey
	local keyTime = 0

	vape:Clean(inputService.InputBegan:Connect(function(input, processed)
		if processed then
			return
		end
		local key = input.KeyCode
		if key == Enum.KeyCode.F or key == Enum.KeyCode.LeftShift or key == Enum.KeyCode.E or key == Enum.KeyCode.Q or key == Enum.KeyCode.ButtonR2 then
			lastKey = key
			keyTime = tick()
		end
	end))

	for _, id in NO_ARG_PACKETS do
		local packet = Packets and Packets[id]
		if packet and not packet._redlinerActionHooked then
			local oldFire = packet.Fire
			packet.Fire = function(self, ...)
				if lastKey and tick() - keyTime < 0.35 then
					if lastKey == Enum.KeyCode.F then
						packetTemplates.parry = id
					elseif lastKey == Enum.KeyCode.LeftShift then
						packetTemplates.dash = id
					end
					lastKey = nil
				end
				return oldFire(self, ...)
			end
			packet._redlinerActionHooked = true
		end
	end
end

local function getHurtboxes()
	return collectionService:GetTagged('Hurtbox')
end

local function getEnemyHurtboxes(range, origin)
	origin = origin or (entitylib.isAlive and entitylib.character.RootPart.Position)
	if not origin then
		return {}
	end

	local results = {}
	for _, part in getHurtboxes() do
		if part.Parent and (part.Position - origin).Magnitude <= range then
			local owner = getCharFromHurtbox(part)
			if owner and isEnemyModel(owner) then
				table.insert(results, {
					Part = part,
					Model = owner,
					Player = playersService:GetPlayerFromCharacter(owner),
					Distance = (part.Position - origin).Magnitude,
				})
			end
		end
	end

	table.sort(results, function(a, b)
		return a.Distance < b.Distance
	end)

	return results
end

local function getNearestEnemyEntity(range)
	if not entitylib.isAlive then
		return
	end
	return entitylib.EntityPosition({
		Range = range,
		Part = 'RootPart',
		Players = true,
		NPCs = false,
	})
end

local function fireParry()
	if not Packets then
		return false
	end

	local id = packetTemplates.parry or '_x01d1e6369b1ddabb'
	local packet = Packets[id]
	if not packet then
		return false
	end

	pcall(function()
		packet:Fire()
	end)
	return true
end

local function fireDash()
	if not Packets then
		return false
	end

	local id = packetTemplates.dash or '_x2b80b9b0eee78387'
	local packet = Packets[id]
	if not packet then
		return false
	end

	pcall(function()
		packet:Fire()
	end)
	return true
end

local function fireMelee(targetHurtbox, aimPos)
	if not Packets or not Packets._x2e2c62e0acfc88ae or not entitylib.isAlive then
		return false
	end

	local root = entitylib.character.RootPart
	local dir = aimPos and (aimPos - root.Position).Unit or root.CFrame.LookVector
	local template = packetTemplates.melee

	local args = {
		template and template[1] or 'Nothing',
		template and template[2] or 'SWING',
		template and template[3] or '',
		dir,
		targetHurtbox and {targetHurtbox} or {},
		template and template[6] or nil,
	}

	pcall(function()
		Packets._x2e2c62e0acfc88ae:Fire(table.unpack(args))
	end)
	return true
end

local function fireGrapple(targetPos)
	if not Packets or not Packets._xefd6d8e74acc7f88 or not entitylib.isAlive then
		return false
	end

	local root = entitylib.character.RootPart
	local template = packetTemplates.grapple
	local startPos = root.Position
	local itemId = template and template[1] or 'Grappler'
	local tag = template and template[4] or ''

	pcall(function()
		Packets._xefd6d8e74acc7f88:Fire(itemId, startPos, targetPos, tag)
	end)
	return true
end

local function fireGunAt(targetPos)
	if not Packets or not Packets._x77a8b8d28b943359 or not entitylib.isAlive then
		return false
	end

	local root = entitylib.character.RootPart
	local origin = gameCamera.CFrame.Position
	local dir = (targetPos - origin).Unit
	local template = packetTemplates.gun

	if template then
		local args = {}
		for i = 1, template.n do
			args[i] = template[i]
		end
		if typeof(args[7]) == 'Vector3' then
			args[7] = dir
		end
		pcall(function()
			Packets._x77a8b8d28b943359:Fire(table.unpack(args))
		end)
		return true
	end

	local pitch = math.asin(math.clamp(dir.Y, -1, 1))
	local yaw = math.atan2(-dir.X, -dir.Z)
	pcall(function()
		Packets._x77a8b8d28b943359:Fire('Castigate', pitch, yaw, false, 1, dir, '', 0, 0)
	end)
	return true
end

local function setHeat(value)
	if not Packets or not Packets._xdb2548bded1dd8e3 then
		return false
	end
	pcall(function()
		Packets._xdb2548bded1dd8e3:Fire(value)
	end)
	return true
end

local function hasGlint(model)
	if not model then
		return false
	end
	for _, inst in model:GetDescendants() do
		local name = string.lower(inst.Name)
		if string.find(name, 'glint', 1, true) then
			if inst:IsA('BasePart') and inst.Transparency < 1 then
				return true
			end
			if inst:IsA('ParticleEmitter') and inst.Enabled then
				return true
			end
			if inst:IsA('BillboardGui') and inst.Enabled then
				return true
			end
		end
	end
	return false
end

local function isMeleeThreat(model, range)
	local enemyRoot = model:FindFirstChild('HumanoidRootPart')
	local myRoot = entitylib.isAlive and entitylib.character.RootPart
	if not enemyRoot or not myRoot then
		return false
	end

	local delta = myRoot.Position - enemyRoot.Position
	local dist = delta.Magnitude
	if dist > range then
		return false
	end

	local toMe = dist > 0.05 and delta.Unit or Vector3.zero
	local facing = enemyRoot.CFrame.LookVector
	if toMe ~= Vector3.zero and facing:Dot(toMe) < 0.35 then
		return false
	end

	local approach = enemyRoot.AssemblyLinearVelocity:Dot(toMe)
	return dist <= range * 0.55 or approach > 8
end

local function configureSilentAim()
	local silentAim = vape.Modules.SilentAim
	if not silentAim then
		return
	end

	for _, opt in silentAim.Options do
		if opt.Name == 'Method' and opt.SetValue then
			opt:SetValue('Raycast')
		elseif opt.Name == 'Raycast Type' and opt.SetValue then
			opt:SetValue('Include')
		elseif opt.Name == 'Range' and opt.SetValue then
			opt:SetValue(math.max(opt.Value or 150, 250))
		end
	end

	notif('REDLINER', 'Silent Aim: Method=Raycast, Raycast Type=Include. Enable Wallbang for Monarch.', 8)
end

task.defer(function()
	local start = tick()
	repeat
		task.wait(0.1)
	until vape.Modules.SilentAim or tick() - start > 12
	configureSilentAim()
end)

run(function()
	installPacketHooks()
	task.defer(bindActionDiscovery)
end)

run(function()
	minigames:CreateModule({
		Name = 'Silent Aim Setup',
		Function = function(callback)
			if callback then
				configureSilentAim()
			end
		end,
		Tooltip = 'REDLINER guns use workspace:Raycast with FilterType.Include on Map.Main. Set Method to Raycast + Include. Slash attacks ignore raycasts — use Melee Aura. Enable Wallbang for Monarch wallbangs.',
	})
end)

run(function()
	local MeleeAura
	local Range
	local CPS
	local FaceTarget
	local attackDelay = 0

	MeleeAura = minigames:CreateModule({
		Name = 'Melee Aura',
		Function = function(callback)
			if callback then
				if not installPacketHooks() then
					notif('Melee Aura', 'Packet system not ready.', 5, 'alert')
					MeleeAura:Toggle(true)
					return
				end

				repeat
					if entitylib.isAlive then
						local root = entitylib.character.RootPart
						local hurtboxes = getEnemyHurtboxes(Range.Value, root.Position)

						if #hurtboxes > 0 and attackDelay < tick() then
							attackDelay = tick() + (1 / CPS.GetRandomValue())
							local target = hurtboxes[1]

							if FaceTarget.Enabled then
								local flat = Vector3.new(target.Part.Position.X, root.Position.Y, target.Part.Position.Z)
								root.CFrame = CFrame.lookAt(root.Position, flat)
							end

							fireMelee(target.Part, target.Part.Position)
							if target.Player then
								targetinfo.Targets[target.Player] = tick() + 1
							end
						end
					end
					task.wait()
				until not MeleeAura.Enabled
			end
		end,
		Tooltip = 'Packet-based sword aura for REDLINER. Slash once manually first so the script learns melee packet args.',
	})

	Range = MeleeAura:CreateSlider({
		Name = 'Range',
		Min = 4,
		Max = 18,
		Default = 10,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end,
	})
	CPS = MeleeAura:CreateTwoSlider({
		Name = 'CPS',
		Min = 1,
		Max = 15,
		DefaultMin = 6,
		DefaultMax = 10,
	})
	FaceTarget = MeleeAura:CreateToggle({Name = 'Face target'})
end)

run(function()
	local AutoParry
	local Range
	local GunGlint
	local MeleeThreat
	local Cooldown
	local lastParry = 0

	AutoParry = minigames:CreateModule({
		Name = 'Auto Parry',
		Function = function(callback)
			if callback then
				if not installPacketHooks() then
					notif('Auto Parry', 'Packet system not ready.', 5, 'alert')
					AutoParry:Toggle(true)
					return
				end

				repeat
					if entitylib.isAlive and lastParry + Cooldown.Value < tick() then
						local root = entitylib.character.RootPart
						local threatened = false

						if GunGlint.Enabled then
							for _, plr in playersService:GetPlayers() do
								if plr ~= lplr and plr.Character and hasGlint(plr.Character) then
									local enemyRoot = getRoot(plr)
									if enemyRoot and (enemyRoot.Position - root.Position).Magnitude <= Range.Value then
										threatened = true
										break
									end
								end
							end
						end

						if not threatened and MeleeThreat.Enabled then
							for _, plr in playersService:GetPlayers() do
								if plr ~= lplr and plr.Character and isMeleeThreat(plr.Character, Range.Value) then
									threatened = true
									break
								end
							end
						end

						if threatened and fireParry() then
							lastParry = tick()
						end
					end
					task.wait(0.03)
				until not AutoParry.Enabled
			end
		end,
		Tooltip = 'Parries gun glints and nearby melee threats. Press F once manually to learn the parry packet ID.',
	})

	Range = AutoParry:CreateSlider({
		Name = 'Range',
		Min = 4,
		Max = 30,
		Default = 14,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end,
	})
	GunGlint = AutoParry:CreateToggle({Name = 'Gun glint', Default = true})
	MeleeThreat = AutoParry:CreateToggle({Name = 'Melee threat', Default = true})
	Cooldown = AutoParry:CreateSlider({
		Name = 'Cooldown',
		Min = 0.05,
		Max = 1,
		Decimal = 100,
		Default = 0.2,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
	})
end)

run(function()
	local InfiniteHeat
	local HeatValue

	InfiniteHeat = minigames:CreateModule({
		Name = 'Infinite Heat',
		Function = function(callback)
			if callback then
				if not installPacketHooks() then
					notif('Infinite Heat', 'Packet system not ready.', 5, 'alert')
					InfiniteHeat:Toggle(true)
					return
				end

				repeat
					setHeat(HeatValue.Value)
					task.wait(0.25)
				until not InfiniteHeat.Enabled
			end
		end,
		Tooltip = 'Spam heat packet (_xdb2548bded1dd8e3). Bullets cost heat (H) in REDLINER.',
	})

	HeatValue = InfiniteHeat:CreateSlider({
		Name = 'Heat',
		Min = 50,
		Max = 500,
		Default = 200,
		Suffix = 'H',
	})
end)

run(function()
	local NoDashCooldown
	local DashRate

	NoDashCooldown = minigames:CreateModule({
		Name = 'No Dash CD',
		Function = function(callback)
			if callback then
				if not installPacketHooks() then
					notif('No Dash CD', 'Packet system not ready.', 5, 'alert')
					NoDashCooldown:Toggle(true)
					return
				end

				repeat
					if entitylib.isAlive then
						fireDash()
					end
					task.wait(DashRate.Value)
				until not NoDashCooldown.Enabled
			end
		end,
		Tooltip = 'Spams dash packet. Dash once manually (Shift) to learn the correct packet ID.',
	})

	DashRate = NoDashCooldown:CreateSlider({
		Name = 'Rate',
		Min = 0.05,
		Max = 1,
		Decimal = 100,
		Default = 0.15,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
	})
end)

run(function()
	local InfiniteGrapple
	local Range
	local Rate

	InfiniteGrapple = minigames:CreateModule({
		Name = 'Infinite Grapple',
		Function = function(callback)
			if callback then
				if not installPacketHooks() then
					notif('Infinite Grapple', 'Packet system not ready.', 5, 'alert')
					InfiniteGrapple:Toggle(true)
					return
				end

				repeat
					if entitylib.isAlive then
						local root = entitylib.character.RootPart
						local look = gameCamera.CFrame.LookVector
						local params = getMapRayParams()
						local hit = workspaceService:Raycast(root.Position, look * Range.Value, params)
						if hit then
							fireGrapple(hit.Position)
						else
							fireGrapple(root.Position + look * Range.Value)
						end
					end
					task.wait(Rate.Value)
				until not InfiniteGrapple.Enabled
			end
		end,
		Tooltip = 'Spams grapple packet toward camera look. Grapple once manually (E) to learn packet args.',
	})

	Range = InfiniteGrapple:CreateSlider({
		Name = 'Range',
		Min = 30,
		Max = 250,
		Default = 120,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end,
	})
	Rate = InfiniteGrapple:CreateSlider({
		Name = 'Rate',
		Min = 0.05,
		Max = 1,
		Decimal = 100,
		Default = 0.2,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
	})
end)

run(function()
	local InstantGun
	local Range
	local Rate

	InstantGun = minigames:CreateModule({
		Name = 'Instant Gun',
		Function = function(callback)
			if callback then
				if not installPacketHooks() then
					notif('Instant Gun', 'Packet system not ready.', 5, 'alert')
					InstantGun:Toggle(true)
					return
				end

				repeat
					if entitylib.isAlive then
						local ent = getNearestEnemyEntity(Range.Value)
						if ent and ent.RootPart then
							fireGunAt(ent.Head and ent.Head.Position or ent.RootPart.Position)
						end
					end
					task.wait(Rate.Value)
				until not InstantGun.Enabled
			end
		end,
		Tooltip = 'Fires gun packet at nearest enemy. Draw/shoot once manually (Q) to capture gun packet args. Pair with universal Silent Aim for best results.',
	})

	Range = InstantGun:CreateSlider({
		Name = 'Range',
		Min = 20,
		Max = 500,
		Default = 200,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end,
	})
	Rate = InstantGun:CreateSlider({
		Name = 'Rate',
		Min = 0.1,
		Max = 2,
		Decimal = 100,
		Default = 0.35,
		Suffix = function(val)
			return val == 1 and 'second' or 'seconds'
		end,
	})
end)

run(function()
	local SpeedBoost
	local Speed

	SpeedBoost = minigames:CreateModule({
		Name = 'Speed Boost',
		Function = function(callback)
			if callback then
				repeat
					if entitylib.isAlive then
						local hum = entitylib.character.Humanoid
						if hum then
							hum.WalkSpeed = Speed.Value
						end
					end
					task.wait(0.2)
				until not SpeedBoost.Enabled
			end
		end,
		Tooltip = 'Local walkspeed boost between dashes.',
	})

	Speed = SpeedBoost:CreateSlider({
		Name = 'WalkSpeed',
		Min = 16,
		Max = 80,
		Default = 28,
	})
end)

run(function()
	local HurtboxESP
	local highlights = {}

	local function clearHighlights()
		for model, highlight in highlights do
			pcall(function()
				highlight:Destroy()
			end)
			highlights[model] = nil
		end
	end

	HurtboxESP = minigames:CreateModule({
		Name = 'Hurtbox ESP',
		Function = function(callback)
			if callback then
				repeat
					local seen = {}
					for _, part in getHurtboxes() do
						local owner = getCharFromHurtbox(part)
						if owner and isEnemyModel(owner) then
							seen[owner] = true
							if not highlights[owner] then
								local highlight = Instance.new('Highlight')
								highlight.FillTransparency = 0.7
								highlight.OutlineTransparency = 0
								highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
								highlight.Parent = owner
								highlights[owner] = highlight
							end
						end
					end

					for model in highlights do
						if not seen[model] or not model.Parent then
							pcall(function()
								highlights[model]:Destroy()
							end)
							highlights[model] = nil
						end
					end

					task.wait(0.5)
				until not HurtboxESP.Enabled
			else
				clearHighlights()
			end
		end,
		Tooltip = 'Highlights enemy Hurtbox owners (CollectionService tag "Hurtbox").',
	})

	vape:Clean(clearHighlights)
end)

run(function()
	local PacketLogger
	local lastNotify = 0

	PacketLogger = minigames:CreateModule({
		Name = 'Packet Logger',
		Function = function(callback)
			if callback then
				notif('Packet Logger', 'Use melee/parry/dash/grapple/gun once manually. Check output.', 6)
				repeat
					if #packetLog > 0 and tick() - lastNotify > 3 then
						local entry = packetLog[1]
						print('[REDLINER Packet]', entry.name, 'args:', entry.n)
						for i = 1, math.min(entry.n, 8) do
							print('  ', i, typeof(entry.args[i]), entry.args[i])
						end
						lastNotify = tick()
					end
					task.wait(0.2)
				until not PacketLogger.Enabled
			end
		end,
		Tooltip = 'Logs outgoing packet fires to console. Use to confirm parry/dash/melee packet IDs.',
	})

	minigames:CreateModule({
		Name = 'Packet Templates',
		Function = function(callback)
			if callback then
				local lines = {}
				for key, template in packetTemplates do
					if template then
						table.insert(lines, key .. ': ' .. (typeof(template) == 'string' and template or template.n .. ' args'))
					end
				end
				if #lines == 0 then
					notif('Packet Templates', 'No templates captured yet. Use actions manually first.', 6, 'alert')
				else
					notif('Packet Templates', table.concat(lines, ' | '), 10)
					print('[REDLINER Templates]', packetTemplates)
				end
			end
		end,
		Tooltip = 'Shows captured packet templates from manual actions (melee, parry, dash, grapple, gun).',
	})
end)

run(function()
	local ctx
	pcall(function()
		if PlaceContext or initGameModules() and PlaceContext then
			ctx = PlaceContext.get(true)
		end
	end)

	local mode = ctx and ctx.effective_mode or 'unknown'
	local placeType = ctx and ctx.effective_place_type or tostring(game.PlaceId)
	notif('REDLINER', 'Loaded ' .. placeType .. ' (' .. mode .. '). Minigames modules ready.', 5)
end)
