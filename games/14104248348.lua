local run = function(func)
	func()
end
local cloneref = cloneref or function(obj)
	return obj
end

local playersService = cloneref(game:GetService('Players'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local runService = cloneref(game:GetService('RunService'))

local lplr = playersService.LocalPlayer
local vape = shared.vape
local entitylib = vape.Libraries.entity

local ONTAP_GAME_ID = 14104248348
local ONTAP_PLACES = {
	[124888106410202] = true,
	[138408235315132] = true,
	[118277828653151] = true,
	[14104248348] = true,
}

if game.GameId ~= ONTAP_GAME_ID and not ONTAP_PLACES[game.PlaceId] then
	return
end

if not vape.Categories.Minigames then
	vape.Categories.Minigames = vape:CreateCategory({
		Name = 'Minigames',
		Icon = 'vape/assets/new/minigames.png'
	})
end

local function notif(...)
	return vape:CreateNotification(...)
end

local Mince
local remotes = {}
local placeRayParams = RaycastParams.new()
placeRayParams.FilterType = Enum.RaycastFilterType.Exclude

local function initMince()
	if Mince then
		return true
	end
	local modules = replicatedStorage:WaitForChild('Modules', 20)
	local minceMod = modules:WaitForChild('Mince', 20)
	local ok, loaded = pcall(require, minceMod)
	if not ok or not loaded then
		return false
	end
	Mince = loaded
	local ready = pcall(function()
		Mince:WaitUntilSetup('Server')
	end)
	if not ready then
		return false
	end
	remotes.snowballThrow = Mince:GetEvent('Snowballs'):Extend('ThrowBall')
	remotes.bottleThrow = Mince:GetEvent('FightBottle'):Extend('ThrowBall')
	remotes.cakeThrow = Mince:GetEvent('ThrowCakes'):Extend('ThrowBall')
	remotes.dartThrow = Mince:GetEvent('Darts'):Extend('Throw')
	remotes.vomitCreate = Mince:GetEvent('Vomit'):Extend('Create')
	remotes.confetti = Mince:GetEvent('ConfettiPopper')
	remotes.intoxReport = Mince:GetEvent('IntoxicationReport')
	remotes.pickup = Mince:GetEvent('RequestPickupCharacter')
	remotes.swing = Mince:GetEvent('Swing')
	remotes.placeDrink = Mince:GetEvent('PlaceDrink')
	remotes.interactDrink = Mince:GetEvent('InteractDrink')
	remotes.emoteSync = Mince:GetEvent('EmoteCollabSync')
	remotes.lockUpCollab = Mince:GetEvent('LockUpEmoteCollab')
	remotes.ragdoll = Mince:GetEvent('RequestRagdoll')
	remotes.ragdollDrop = Mince:GetEvent('RequestRagdollDrop')
	return true
end

local function getRoot(plr)
	local char = plr and plr.Character
	return char and char:FindFirstChild('HumanoidRootPart')
end

local function getThrowOrigin()
	local char = lplr.Character
	if not char then
		return
	end
	local hand = char:FindFirstChild('RightHand') or char:FindFirstChild('Right Arm')
	local hrp = char:FindFirstChild('HumanoidRootPart')
	return (hand and hand.Position) or (hrp and hrp.Position)
end

local function getPlayersInRange(range)
	local myRoot = getRoot(lplr)
	if not myRoot then
		return {}
	end
	local list = {}
	for _, plr in playersService:GetPlayers() do
		if plr ~= lplr then
			local root = getRoot(plr)
			if root and (root.Position - myRoot.Position).Magnitude <= range then
				table.insert(list, plr)
			end
		end
	end
	return list
end

local function getNearestPlayer(range)
	local myRoot = getRoot(lplr)
	if not myRoot then
		return
	end
	local nearest, nearestDist
	for _, plr in playersService:GetPlayers() do
		if plr ~= lplr then
			local root = getRoot(plr)
			if root then
				local dist = (root.Position - myRoot.Position).Magnitude
				if dist <= range and (not nearestDist or dist < nearestDist) then
					nearest = plr
					nearestDist = dist
				end
			end
		end
	end
	return nearest
end

local function getTargetPlayer(range, allTargets)
	if allTargets then
		return getPlayersInRange(range)
	end
	return getNearestPlayer(range)
end

local function throwBall(remote, target, power)
	local origin = getThrowOrigin()
	local targetRoot = getRoot(target)
	if not (remote and origin and targetRoot) then
		return
	end
	remote:Fire(power, origin, targetRoot.Position - origin)
end

local function throwDart(target)
	local char = lplr.Character
	local hand = char and (char:FindFirstChild('RightHand') or char:FindFirstChild('Right Arm'))
	local targetRoot = getRoot(target)
	if not (remotes.dartThrow and hand and targetRoot) then
		return
	end
	remotes.dartThrow:Fire(hand.Position, targetRoot.Position, false)
end

local function vomitAt(target)
	local targetRoot = getRoot(target)
	if remotes.vomitCreate and targetRoot then
		remotes.vomitCreate:Fire(targetRoot.Position)
	end
end

local function placeDrinkAt(target)
	local targetRoot = getRoot(target)
	local char = lplr.Character
	if not (remotes.placeDrink and targetRoot and char) then
		return
	end
	placeRayParams.FilterDescendantsInstances = {char}
	local origin = targetRoot.Position + Vector3.new(0, 3, 0)
	local result = workspace:Raycast(origin, Vector3.new(0, -8, 0), placeRayParams)
	if result then
		remotes.placeDrink:Fire(result.Position, result.Instance)
	end
end

local function isRagdolled(plr)
	local char = plr and plr.Character
	local hum = char and char:FindFirstChildOfClass('Humanoid')
	return hum and hum.PlatformStand
end

local function canPickupPlayer(plr)
	local char = plr and plr.Character
	if not char then
		return false
	end
	local mode = char:GetAttribute('CharacterPickupMode') or 'Nobody'
	if mode == 'Nobody' then
		return false
	end
	if mode == 'Friends' and not plr:IsFriendsWith(lplr.UserId) then
		return false
	end
	return isRagdolled(plr)
end

run(function()
	local ThrowSpammer, Projectile, Power, Delay, Range, AllTargets
	local throwMap = {}

	ThrowSpammer = vape.Categories.Minigames:CreateModule({
		Name = 'Throw Spammer',
		Function = function(callback)
			if not callback then
				return
			end
			if not initMince() then
				notif('On Tap', 'Mince remotes failed to load.', 8, 'warning')
				return
			end
			throwMap.Snowball = remotes.snowballThrow
			throwMap.Bottle = remotes.bottleThrow
			throwMap.Cake = remotes.cakeThrow
			throwMap.Dart = 'dart'

			repeat
				local remote = throwMap[Projectile.Value]
				if remote then
					local targets = getTargetPlayer(Range.Value, AllTargets.Enabled)
					if AllTargets.Enabled then
						for _, plr in targets do
							if remote == 'dart' then
								throwDart(plr)
							else
								throwBall(remote, plr, Power.Value)
							end
						end
					elseif targets then
						if remote == 'dart' then
							throwDart(targets)
						else
							throwBall(remote, targets, Power.Value)
						end
					end
				end
				task.wait(Delay.Value)
			until not ThrowSpammer.Enabled
		end,
		Tooltip = 'Spams snowballs, bottles, cakes, or darts at players via Mince throw remotes.'
	})
	Projectile = ThrowSpammer:CreateDropdown({
		Name = 'Projectile',
		List = {'Snowball', 'Bottle', 'Cake', 'Dart'},
		Function = function() end
	})
	Power = ThrowSpammer:CreateSlider({
		Name = 'Power',
		Min = 0.1,
		Max = 1,
		Default = 1,
		Decimal = 10
	})
	Delay = ThrowSpammer:CreateSlider({
		Name = 'Delay',
		Min = 0.05,
		Max = 2,
		Default = 0.35,
		Decimal = 100,
		Suffix = 's'
	})
	Range = ThrowSpammer:CreateSlider({
		Name = 'Range',
		Min = 20,
		Max = 300,
		Default = 200,
		Suffix = ' studs'
	})
	AllTargets = ThrowSpammer:CreateToggle({
		Name = 'All In Range',
		Default = false,
		Function = function() end
	})
end)

run(function()
	local BottleBomber, Delay, Range, AllTargets

	BottleBomber = vape.Categories.Minigames:CreateModule({
		Name = 'Bottle Bomber',
		Function = function(callback)
			if not callback then
				return
			end
			if not initMince() then
				notif('On Tap', 'Mince remotes failed to load.', 8, 'warning')
				return
			end
			repeat
				local targets = getTargetPlayer(Range.Value, AllTargets.Enabled)
				if AllTargets.Enabled then
					for _, plr in targets do
						throwBall(remotes.bottleThrow, plr, 1)
					end
				elseif targets then
					throwBall(remotes.bottleThrow, targets, 1)
				end
				task.wait(Delay.Value)
			until not BottleBomber.Enabled
		end,
		Tooltip = 'Glass bottle throws — blur + explosion VFX on hit.'
	})
	Delay = BottleBomber:CreateSlider({
		Name = 'Delay',
		Min = 0.05,
		Max = 2,
		Default = 0.4,
		Decimal = 100,
		Suffix = 's'
	})
	Range = BottleBomber:CreateSlider({
		Name = 'Range',
		Min = 20,
		Max = 300,
		Default = 200,
		Suffix = ' studs'
	})
	AllTargets = BottleBomber:CreateToggle({
		Name = 'All In Range',
		Default = false,
		Function = function() end
	})
end)

run(function()
	local DartSniper, Delay, Range, AllTargets

	DartSniper = vape.Categories.Minigames:CreateModule({
		Name = 'Dart Sniper',
		Function = function(callback)
			if not callback then
				return
			end
			if not initMince() then
				notif('On Tap', 'Mince remotes failed to load.', 8, 'warning')
				return
			end
			repeat
				local targets = getTargetPlayer(Range.Value, AllTargets.Enabled)
				if AllTargets.Enabled then
					for _, plr in targets do
						throwDart(plr)
					end
				elseif targets then
					throwDart(targets)
				end
				task.wait(Delay.Value)
			until not DartSniper.Enabled
		end,
		Tooltip = 'Fires Darts/Throw remote at player positions (not dartboard).'
	})
	Delay = DartSniper:CreateSlider({
		Name = 'Delay',
		Min = 0.05,
		Max = 2,
		Default = 0.35,
		Decimal = 100,
		Suffix = 's'
	})
	Range = DartSniper:CreateSlider({
		Name = 'Range',
		Min = 20,
		Max = 300,
		Default = 200,
		Suffix = ' studs'
	})
	AllTargets = DartSniper:CreateToggle({
		Name = 'All In Range',
		Default = false,
		Function = function() end
	})
end)

run(function()
	local VomitRain, Delay, Range, AllTargets

	VomitRain = vape.Categories.Minigames:CreateModule({
		Name = 'Vomit Rain',
		Function = function(callback)
			if not callback then
				return
			end
			if not initMince() then
				notif('On Tap', 'Mince remotes failed to load.', 8, 'warning')
				return
			end
			repeat
				local targets = getTargetPlayer(Range.Value, AllTargets.Enabled)
				if AllTargets.Enabled then
					for _, plr in targets do
						vomitAt(plr)
					end
				elseif targets then
					vomitAt(targets)
				end
				task.wait(Delay.Value)
			until not VomitRain.Enabled
		end,
		Tooltip = 'Spawns vomit puddles at players via Vomit/Create remote.'
	})
	Delay = VomitRain:CreateSlider({
		Name = 'Delay',
		Min = 0.1,
		Max = 3,
		Default = 0.5,
		Decimal = 100,
		Suffix = 's'
	})
	Range = VomitRain:CreateSlider({
		Name = 'Range',
		Min = 20,
		Max = 200,
		Default = 120,
		Suffix = ' studs'
	})
	AllTargets = VomitRain:CreateToggle({
		Name = 'All In Range',
		Default = true,
		Function = function() end
	})
end)

run(function()
	local ConfettiSpam, Delay

	ConfettiSpam = vape.Categories.Minigames:CreateModule({
		Name = 'Confetti Spam',
		Function = function(callback)
			if not callback then
				return
			end
			if not initMince() then
				notif('On Tap', 'Mince remotes failed to load.', 8, 'warning')
				return
			end
			repeat
				remotes.confetti:Fire()
				task.wait(Delay.Value)
			until not ConfettiSpam.Enabled
		end,
		Tooltip = 'Spams ConfettiPopper remote. Server may require the gear equipped.'
	})
	Delay = ConfettiSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.05,
		Max = 2,
		Default = 0.25,
		Decimal = 100,
		Suffix = 's'
	})
end)

run(function()
	local DrunkBeacon, Level, Delay

	DrunkBeacon = vape.Categories.Minigames:CreateModule({
		Name = 'Drunk Beacon',
		Function = function(callback)
			if not callback then
				return
			end
			if not initMince() then
				notif('On Tap', 'Mince remotes failed to load.', 8, 'warning')
				return
			end
			repeat
				remotes.intoxReport:Fire(Level.Value)
				task.wait(Delay.Value)
			until not DrunkBeacon.Enabled
		end,
		Tooltip = 'Spams IntoxicationReport — may replicate drunk visuals to other players.'
	})
	Level = DrunkBeacon:CreateSlider({
		Name = 'Intox Level',
		Min = 0.5,
		Max = 2.3,
		Default = 2,
		Decimal = 10
	})
	Delay = DrunkBeacon:CreateSlider({
		Name = 'Delay',
		Min = 0.1,
		Max = 1,
		Default = 0.2,
		Decimal = 100,
		Suffix = 's'
	})
end)

run(function()
	local FightSpam, Delay

	FightSpam = vape.Categories.Minigames:CreateModule({
		Name = 'Fight Spam',
		Function = function(callback)
			if not callback then
				return
			end
			if not initMince() then
				notif('On Tap', 'Mince remotes failed to load.', 8, 'warning')
				return
			end
			repeat
				remotes.swing:Fire()
				task.wait(Delay.Value)
			until not FightSpam.Enabled
		end,
		Tooltip = 'Spams Swing remote from the fight ring tool.'
	})
	Delay = FightSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.1,
		Max = 2,
		Default = 0.2,
		Decimal = 100,
		Suffix = 's'
	})
end)

run(function()
	local PickupGrabber, Range, AutoDrop, DropDelay

	PickupGrabber = vape.Categories.Minigames:CreateModule({
		Name = 'Pickup Grabber',
		Function = function(callback)
			if not callback then
				return
			end
			if not initMince() then
				notif('On Tap', 'Mince remotes failed to load.', 8, 'warning')
				return
			end
			local carrying = false
			repeat
				if AutoDrop.Enabled and carrying then
					remotes.pickup:Fire('Drop')
					carrying = false
					task.wait(DropDelay.Value)
				else
					for _, plr in getPlayersInRange(Range.Value) do
						if canPickupPlayer(plr) then
							remotes.pickup:Fire(plr)
							carrying = true
							break
						end
					end
					task.wait(0.5)
				end
			until not PickupGrabber.Enabled
		end,
		Tooltip = 'Auto-picks up ragdolled/pass-out players. Needs their pickup mode enabled.'
	})
	Range = PickupGrabber:CreateSlider({
		Name = 'Range',
		Min = 5,
		Max = 30,
		Default = 15,
		Suffix = ' studs'
	})
	AutoDrop = PickupGrabber:CreateToggle({
		Name = 'Auto Drop',
		Default = true,
		Function = function() end,
		Tooltip = 'Drop carried player after picking them up.'
	})
	DropDelay = PickupGrabber:CreateSlider({
		Name = 'Carry Time',
		Min = 0.5,
		Max = 10,
		Default = 2,
		Suffix = 's'
	})
end)

run(function()
	local DrinkPlacer, Delay, Range, AllTargets

	DrinkPlacer = vape.Categories.Minigames:CreateModule({
		Name = 'Drink Placer',
		Function = function(callback)
			if not callback then
				return
			end
			if not initMince() then
				notif('On Tap', 'Mince remotes failed to load.', 8, 'warning')
				return
			end
			repeat
				local targets = getTargetPlayer(Range.Value, AllTargets.Enabled)
				if AllTargets.Enabled then
					for _, plr in targets do
						placeDrinkAt(plr)
					end
				elseif targets then
					placeDrinkAt(targets)
				end
				task.wait(Delay.Value)
			until not DrinkPlacer.Enabled
		end,
		Tooltip = 'PlaceDrink at player feet. Usually needs a placeable drink equipped.'
	})
	Delay = DrinkPlacer:CreateSlider({
		Name = 'Delay',
		Min = 0.1,
		Max = 2,
		Default = 0.5,
		Decimal = 100,
		Suffix = 's'
	})
	Range = DrinkPlacer:CreateSlider({
		Name = 'Range',
		Min = 5,
		Max = 130,
		Default = 80,
		Suffix = ' studs'
	})
	AllTargets = DrinkPlacer:CreateToggle({
		Name = 'All In Range',
		Default = false,
		Function = function() end
	})
end)

run(function()
	local ForceChug, Delay

	ForceChug = vape.Categories.Minigames:CreateModule({
		Name = 'Force Chug',
		Function = function(callback)
			if not callback then
				return
			end
			if not initMince() then
				notif('On Tap', 'Mince remotes failed to load.', 8, 'warning')
				return
			end
			repeat
				remotes.interactDrink:Fire()
				task.wait(Delay.Value)
			until not ForceChug.Enabled
		end,
		Tooltip = 'Spams InteractDrink — force consume equipped drink.'
	})
	Delay = ForceChug:CreateSlider({
		Name = 'Delay',
		Min = 0.1,
		Max = 2,
		Default = 0.3,
		Decimal = 100,
		Suffix = 's'
	})
end)

run(function()
	local EmoteSpam, EmoteName, Delay, Range, AllTargets

	EmoteSpam = vape.Categories.Minigames:CreateModule({
		Name = 'Emote Spam',
		Function = function(callback)
			if not callback then
				return
			end
			if not initMince() then
				notif('On Tap', 'Mince remotes failed to load.', 8, 'warning')
				return
			end
			repeat
				if AllTargets.Enabled then
					for _, plr in getPlayersInRange(Range.Value) do
						pcall(function()
							remotes.lockUpCollab:Fire(plr)
						end)
					end
				else
					remotes.emoteSync:Fire(EmoteName.Value)
				end
				task.wait(Delay.Value)
			until not EmoteSpam.Enabled
		end,
		Tooltip = 'Spams emotes or LockUpEmoteCollab on nearby players doing collab emotes.'
	})
	EmoteName = EmoteSpam:CreateTextBox({
		Name = 'Emote',
		Default = 'Wave',
		Function = function() end
	})
	Delay = EmoteSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.2,
		Max = 3,
		Default = 0.6,
		Decimal = 100,
		Suffix = 's'
	})
	Range = EmoteSpam:CreateSlider({
		Name = 'Range',
		Min = 10,
		Max = 100,
		Default = 50,
		Suffix = ' studs'
	})
	AllTargets = EmoteSpam:CreateToggle({
		Name = 'Target Players',
		Default = false,
		Function = function() end
	})
end)

run(function()
	local RagdollDropper, Delay, Range

	RagdollDropper = vape.Categories.Minigames:CreateModule({
		Name = 'Ragdoll Dropper',
		Function = function(callback)
			if not callback then
				return
			end
			if not initMince() then
				notif('On Tap', 'Mince remotes failed to load.', 8, 'warning')
				return
			end
			repeat
				for _, plr in getPlayersInRange(Range.Value) do
					if isRagdolled(plr) then
						remotes.ragdollDrop:Fire()
					end
				end
				remotes.ragdollDrop:Fire(true, true)
				task.wait(Delay.Value)
			until not RagdollDropper.Enabled
		end,
		Tooltip = 'Spams RequestRagdollDrop on ragdolled players nearby.'
	})
	Delay = RagdollDropper:CreateSlider({
		Name = 'Delay',
		Min = 0.1,
		Max = 2,
		Default = 0.4,
		Decimal = 100,
		Suffix = 's'
	})
	Range = RagdollDropper:CreateSlider({
		Name = 'Range',
		Min = 10,
		Max = 80,
		Default = 40,
		Suffix = ' studs'
	})
end)

run(function()
	local CakeBarrage, Delay, Range, AllTargets

	CakeBarrage = vape.Categories.Minigames:CreateModule({
		Name = 'Cake Barrage',
		Function = function(callback)
			if not callback then
				return
			end
			if not initMince() then
				notif('On Tap', 'Mince remotes failed to load.', 8, 'warning')
				return
			end
			repeat
				local targets = getTargetPlayer(Range.Value, AllTargets.Enabled)
				if AllTargets.Enabled then
					for _, plr in targets do
						throwBall(remotes.cakeThrow, plr, 1)
					end
				elseif targets then
					throwBall(remotes.cakeThrow, targets, 1)
				end
				task.wait(Delay.Value)
			until not CakeBarrage.Enabled
		end,
		Tooltip = 'ThrowCakes/ThrowBall spam with cake smash effects.'
	})
	Delay = CakeBarrage:CreateSlider({
		Name = 'Delay',
		Min = 0.05,
		Max = 2,
		Default = 0.35,
		Decimal = 100,
		Suffix = 's'
	})
	Range = CakeBarrage:CreateSlider({
		Name = 'Range',
		Min = 20,
		Max = 300,
		Default = 200,
		Suffix = ' studs'
	})
	AllTargets = CakeBarrage:CreateToggle({
		Name = 'All In Range',
		Default = false,
		Function = function() end
	})
end)

run(function()
	local SnowballStorm, Delay, Range, AllTargets

	SnowballStorm = vape.Categories.Minigames:CreateModule({
		Name = 'Snowball Storm',
		Function = function(callback)
			if not callback then
				return
			end
			if not initMince() then
				notif('On Tap', 'Mince remotes failed to load.', 8, 'warning')
				return
			end
			repeat
				local targets = getTargetPlayer(Range.Value, AllTargets.Enabled)
				if AllTargets.Enabled then
					for _, plr in targets do
						throwBall(remotes.snowballThrow, plr, 1)
					end
				elseif targets then
					throwBall(remotes.snowballThrow, targets, 1)
				end
				task.wait(Delay.Value)
			until not SnowballStorm.Enabled
		end,
		Tooltip = 'Snowballs/ThrowBall — frostbite hit effects on players.'
	})
	Delay = SnowballStorm:CreateSlider({
		Name = 'Delay',
		Min = 0.05,
		Max = 2,
		Default = 0.3,
		Decimal = 100,
		Suffix = 's'
	})
	Range = SnowballStorm:CreateSlider({
		Name = 'Range',
		Min = 20,
		Max = 300,
		Default = 200,
		Suffix = ' studs'
	})
	AllTargets = SnowballStorm:CreateToggle({
		Name = 'All In Range',
		Default = true,
		Function = function() end
	})
end)
