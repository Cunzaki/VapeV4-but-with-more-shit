--[[
	REDLINER shared game script (FFA + MATCH place IDs).
	Combat is packet-based. Parry packet: Packets._x01d1e6369b1ddabb (no args).
]]

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

local lplr = playersService.LocalPlayer
local vape = shared.vape
if not vape then
	return
end

local entitylib = vape.Libraries.entity

local PARRY_PACKET_NAME = '_x01d1e6369b1ddabb'
local MELEE_PACKET_NAME = '_x2e2c62e0acfc88ae'
local GUN_PACKET_NAME = '_x77a8b8d28b943359'

local Packets
local packetsReady = false
local autoParryActive = false
local myHurtboxes = {}
local lastParryAt = 0
local enemyGlintState = {}
local packetListenersBound = false

local function notif(...)
	return vape:CreateNotification(...)
end

local function initPackets()
	if Packets then
		return true
	end

	local assets = replicatedStorage:WaitForChild('Assets', 30)
	if not assets then
		return false
	end

	local modules = assets:WaitForChild('ModuleScripts', 30)
	if not modules then
		return false
	end

	local packetsModule = modules:WaitForChild('Packets', 30)
	if not packetsModule then
		return false
	end

	local ok, loaded = pcall(require, packetsModule)
	if not ok then
		warn('[REDLINER] require(Packets) failed:', loaded)
		return false
	end

	Packets = loaded
	return true
end

local function waitForPacketIds(timeout)
	timeout = timeout or 45
	local deadline = tick() + timeout

	while tick() < deadline do
		if initPackets() then
			local parryPacket = Packets[PARRY_PACKET_NAME]
			local meleePacket = Packets[MELEE_PACKET_NAME]
			local gunPacket = Packets[GUN_PACKET_NAME]
			if parryPacket and parryPacket.Id and meleePacket and gunPacket then
				packetsReady = true
				return true
			end
		end
		task.wait(0.1)
	end

	return false
end

local function refreshMyHurtboxes()
	table.clear(myHurtboxes)
	if not entitylib.isAlive then
		return
	end
	local char = entitylib.character.Character
	if not char then
		return
	end
	for _, part in collectionService:GetTagged('Hurtbox') do
		if part.Parent and part:IsDescendantOf(char) then
			table.insert(myHurtboxes, part)
		end
	end
end

local function listIncludesMyHurtbox(list)
	if typeof(list) ~= 'table' then
		return false
	end
	refreshMyHurtboxes()
	for _, mine in myHurtboxes do
		if table.find(list, mine) then
			return true
		end
	end
	return false
end

local function getLocalRoot()
	return entitylib.isAlive and entitylib.character.RootPart
end

local function isEnemyCharacter(model)
	if not model or model == lplr.Character then
		return false
	end
	local plr = playersService:GetPlayerFromCharacter(model)
	return plr and plr ~= lplr
end

local function flatDot(fromPos, toPos, direction)
	local offset = toPos - fromPos
	local dist = offset.Magnitude
	if dist < 0.05 or direction.Magnitude < 0.05 then
		return 0, dist
	end
	return direction.Unit:Dot(offset.Unit), dist
end

local function directionThreatensMe(direction, maxRange, origin)
	local root = getLocalRoot()
	if not root or typeof(direction) ~= 'Vector3' then
		return false
	end

	if origin then
		local dot, dist = flatDot(origin, root.Position, direction)
		return dist <= maxRange and dot > 0.35
	end

	for _, plr in playersService:GetPlayers() do
		if plr ~= lplr and plr.Character then
			local enemyRoot = plr.Character:FindFirstChild('HumanoidRootPart')
			if enemyRoot then
				local dot, dist = flatDot(enemyRoot.Position, root.Position, direction)
				if dist <= maxRange and dot > 0.35 then
					return true
				end
			end
		end
	end

	return false
end

local function fireParry()
	if not packetsReady or not Packets then
		return false
	end

	local packet = Packets[PARRY_PACKET_NAME]
	if not packet or not packet.Id then
		return false
	end

	task.spawn(function()
		pcall(function()
			packet:Fire()
		end)
	end)
	return true
end

local function tryParry()
	if not autoParryActive then
		return false
	end
	if tick() - lastParryAt < 0.06 then
		return false
	end
	if not entitylib.isAlive then
		return false
	end
	if fireParry() then
		lastParryAt = tick()
		return true
	end
	return false
end

local function isSwingAction(action)
	if typeof(action) ~= 'string' then
		return false
	end
	local lower = string.lower(action)
	return string.find(lower, 'swing', 1, true)
		or string.find(lower, 'slash', 1, true)
		or string.find(lower, 'hit', 1, true)
end

local function onMeleePacket(itemId, action, tag, direction, hurtboxes)
	if not entitylib.isAlive then
		return
	end
	if not isSwingAction(action) then
		return
	end
	if listIncludesMyHurtbox(hurtboxes) then
		tryParry()
		return
	end
	if directionThreatensMe(direction, 16) then
		tryParry()
	end
end

local function onGunPacket(itemId, pitch, yaw, charged, heatCost, direction)
	if not entitylib.isAlive then
		return
	end
	if typeof(direction) ~= 'Vector3' then
		return
	end

	local root = getLocalRoot()
	if not root then
		return
	end

	for _, plr in playersService:GetPlayers() do
		if plr ~= lplr and plr.Character then
			local enemyRoot = plr.Character:FindFirstChild('HumanoidRootPart')
			local enemyHead = plr.Character:FindFirstChild('Head') or enemyRoot
			if enemyRoot and enemyHead then
				local dist = (enemyRoot.Position - root.Position).Magnitude
				if dist <= 120 then
					local aimFrom = enemyHead.Position
					local dot, shotDist = flatDot(aimFrom, root.Position, direction)
					if shotDist <= 120 and dot > 0.82 then
						tryParry()
						return
					end
				end
			end
		end
	end

	if directionThreatensMe(direction, 120) then
		tryParry()
	end
end

local function bindPacketListeners()
	if packetListenersBound or not packetsReady then
		return
	end
	packetListenersBound = true

	local meleePacket = Packets[MELEE_PACKET_NAME]
	local gunPacket = Packets[GUN_PACKET_NAME]

	if meleePacket and meleePacket.OnClientEvent then
		meleePacket.OnClientEvent:Connect(function(...)
			onMeleePacket(...)
		end)
	end

	if gunPacket and gunPacket.OnClientEvent then
		gunPacket.OnClientEvent:Connect(function(...)
			onGunPacket(...)
		end)
	end
end

local function instanceShowsGlint(inst)
	if inst:IsA('ParticleEmitter') and inst.Enabled and inst.Rate > 0 then
		return true
	end
	if inst:IsA('BillboardGui') and inst.Enabled then
		return true
	end
	if inst:IsA('Highlight') and inst.Enabled then
		return true
	end
	if inst:IsA('Beam') and inst.Enabled then
		return true
	end
	if inst:IsA('PointLight') and inst.Enabled and inst.Brightness > 0 then
		return true
	end
	return false
end

local function modelHasGlint(model)
	if not model then
		return false
	end

	for _, attr in {'Glint', 'GunDrawn', 'Drawing', 'Drawn', 'Aiming'} do
		local val = model:GetAttribute(attr)
		if val == true or val == 1 then
			return true
		end
	end

	for _, inst in model:GetDescendants() do
		local name = string.lower(inst.Name)
		if string.find(name, 'glint', 1, true)
			or string.find(name, 'drawflash', 1, true)
			or string.find(name, 'gunflash', 1, true)
			or string.find(name, 'aimflash', 1, true) then
			if instanceShowsGlint(inst) then
				return true
			end
		end
	end

	return false
end

local function trackEnemyGlint(model)
	if not isEnemyCharacter(model) or enemyGlintState[model] then
		return
	end
	enemyGlintState[model] = {active = false}

	local function scan()
		local has = modelHasGlint(model)
		local state = enemyGlintState[model]
		if not state then
			return
		end
		if has and not state.active then
			state.active = true
			local root = getLocalRoot()
			local enemyRoot = model:FindFirstChild('HumanoidRootPart')
			if root and enemyRoot and (enemyRoot.Position - root.Position).Magnitude <= 100 then
				local toMe = root.Position - enemyRoot.Position
				if toMe.Magnitude < 0.05 or enemyRoot.CFrame.LookVector:Dot(toMe.Unit) > 0.2 then
					tryParry()
				end
			end
		elseif not has then
			state.active = false
		end
	end

	model.DescendantAdded:Connect(scan)
	model.DescendantRemoving:Connect(function()
		task.defer(scan)
	end)
	scan()
end

local function isSwingingAnimation(model)
	local hum = model:FindFirstChildWhichIsA('Humanoid')
	if not hum then
		return false
	end
	for _, track in hum:GetPlayingAnimationTracks() do
		if track.IsPlaying and track.WeightCurrent > 0.2 then
			local animName = track.Animation and string.lower(track.Animation.Name) or ''
			local isAttackAnim = string.find(animName, 'swing', 1, true)
				or string.find(animName, 'slash', 1, true)
				or string.find(animName, 'attack', 1, true)
			if isAttackAnim and not string.find(animName, 'parry', 1, true) then
				if track.Priority.Value >= Enum.AnimationPriority.Action.Value then
					return true
				end
			end
		end
	end
	return false
end

local function isMeleeProximityThreat(model, range)
	local root = getLocalRoot()
	local enemyRoot = model:FindFirstChild('HumanoidRootPart')
	if not root or not enemyRoot then
		return false
	end

	local offset = root.Position - enemyRoot.Position
	local dist = offset.Magnitude
	if dist > range then
		return false
	end

	local facingDot = enemyRoot.CFrame.LookVector:Dot(offset.Unit)
	if facingDot < 0.25 then
		return false
	end

	return isSwingingAnimation(model) or enemyRoot.AssemblyLinearVelocity:Dot(offset.Unit) > 6
end

local function scanVisualThreats(meleeRange, gunRange)
	if not entitylib.isAlive then
		return
	end

	for _, plr in playersService:GetPlayers() do
		if plr == lplr then
			continue
		end
		local char = plr.Character
		if not char then
			continue
		end

		trackEnemyGlint(char)

		if modelHasGlint(char) then
			local root = getLocalRoot()
			local enemyRoot = char:FindFirstChild('HumanoidRootPart')
			if root and enemyRoot and (enemyRoot.Position - root.Position).Magnitude <= gunRange then
				tryParry()
			end
		end

		if isMeleeProximityThreat(char, meleeRange) then
			tryParry()
		end
	end
end

local function cleanupEnemyState(model)
	enemyGlintState[model] = nil
end

run(function()
	if not vape.Categories.Minigames then
		vape.Categories.Minigames = vape:CreateCategory({
			Name = 'Minigames',
			Icon = 'vape/assets/new/minigames.png'
		})
	end

	local minigames = vape.Categories.Minigames
	local AutoParry
	local MeleeRange
	local GunRange
	local Debug

	AutoParry = minigames:CreateModule({
		Name = 'Auto Parry',
		Function = function(callback)
			autoParryActive = callback
			if not callback then
				return
			end

			task.spawn(function()
				local ready = waitForPacketIds(60)
				if not ready then
					notif('Auto Parry', 'Combat packets not ready yet. Wait in-game or rejoin.', 8, 'alert')
					if AutoParry.Enabled then
						AutoParry:Toggle(true)
					end
					return
				end

				bindPacketListeners()
				notif('Auto Parry', 'Combat packets loaded. Auto parry active.', 5)

				for _, plr in playersService:GetPlayers() do
					if plr ~= lplr and plr.Character then
						trackEnemyGlint(plr.Character)
					end
				end
			end)

			AutoParry:Clean(playersService.PlayerAdded:Connect(function(plr)
				if plr == lplr then
					return
				end
				AutoParry:Clean(plr.CharacterAdded:Connect(function(char)
					trackEnemyGlint(char)
				end))
				if plr.Character then
					trackEnemyGlint(plr.Character)
				end
			end))

			AutoParry:Clean(playersService.PlayerRemoving:Connect(function(plr)
				if plr.Character then
					cleanupEnemyState(plr.Character)
				end
			end))

			AutoParry:Clean(runService.RenderStepped:Connect(function()
				scanVisualThreats(MeleeRange.Value, GunRange.Value)
			end))
		end,
		Tooltip = 'Instantly parries incoming melee swings and gun shots. Uses REDLINER parry packet _x01d1e6369b1ddabb.',
	})

	MeleeRange = AutoParry:CreateSlider({
		Name = 'Melee Range',
		Min = 4,
		Max = 20,
		Default = 14,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end,
	})

	GunRange = AutoParry:CreateSlider({
		Name = 'Gun Range',
		Min = 20,
		Max = 200,
		Default = 100,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end,
	})

	Debug = AutoParry:CreateToggle({
		Name = 'Debug',
		Function = function(callback)
			if callback then
				print('[REDLINER AutoParry] packetsReady=', packetsReady, 'parryId=', Packets and Packets[PARRY_PACKET_NAME] and Packets[PARRY_PACKET_NAME].Id)
			end
		end,
	})
end)

run(function()
	task.defer(function()
		local start = tick()
		repeat
			task.wait(0.25)
		until vape.Loaded or tick() - start > 20

		task.spawn(function()
			if waitForPacketIds(30) then
				notif('REDLINER', 'Auto Parry ready. Enable it in Minigames.', 5)
			end
		end)
	end)
end)
