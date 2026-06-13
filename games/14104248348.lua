local run = function(func)
	func()
end
local cloneref = cloneref or function(obj)
	return obj
end

local playersService = cloneref(game:GetService('Players'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local collectionService = cloneref(game:GetService('CollectionService'))

local lplr = playersService.LocalPlayer
local vape = shared.vape

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
local Backpack
local DrinkHandler
local UserProfile
local remotes = {}
local remoteFolder
local placeRayParams = RaycastParams.new()
placeRayParams.FilterType = Enum.RaycastFilterType.Exclude

local RECIPE_TOOLS = {
	Snowball = {Recipe = 'Snowball', Tag = 'Snowball', Throw = 'snowballThrow', Dart = false},
	Bottle = {Recipe = 'FightBottle', Tag = 'FightBottle', Throw = 'bottleThrow', Dart = false},
	Cake = {Recipe = 'ThrowCake', Tag = 'ThrowCake', Throw = 'cakeThrow', Dart = false},
	Dart = {Recipe = 'Dart', Tag = 'Dart', Throw = 'dartThrow', Dart = true},
}

local CONSUME_IVIDS = {
	ConfettiPopper = 'ConsumeGear.ConfettiPopper',
	BlueFirecracker = 'ConsumeGear.BlueFirecracker',
	PinkFirecracker = 'ConsumeGear.PinkFirecracker',
	RedFirecracker = 'ConsumeGear.RedFirecracker',
}

local function initMince()
	if Mince then
		return true
	end
	local modules = replicatedStorage:WaitForChild('Modules', 30)
	local minceMod = modules:WaitForChild('Mince', 30)
	local ok, loaded = pcall(require, minceMod)
	if not ok or not loaded then
		return false
	end
	Mince = loaded
	local ready, err = pcall(function()
		Mince:WaitUntilSetup('Server')
		Mince:WaitUntilSetup('Client')
	end)
	if not ready then
		warn('[OnTap] Mince setup failed:', err)
		return false
	end
	pcall(function()
		if Mince.HandshakeRemote then
			Mince.HandshakeRemote:FireServer()
		end
	end)
	Backpack = require(modules:WaitForChild('Backpack'))
	pcall(function()
		DrinkHandler = Mince:Get('DrinkHandler')
	end)
	pcall(function()
		UserProfile = Mince:Get('UserProfile')
		if UserProfile and UserProfile.WaitUntilLoaded then
			UserProfile:WaitUntilLoaded()
		end
	end)
	remoteFolder = modules.Mince:WaitForChild('Addons'):WaitForChild('remote')

	remotes.giveDrink = Mince:GetEvent('GiveDrink')
	remotes.pickupDrink = Mince:GetEvent('PickupDrink')
	remotes.inventoryEquip = Mince:GetEvent('Inventory'):Extend('Equip')
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

local function getHandPart(char)
	if not char then
		return
	end
	return char:FindFirstChild('RightHand')
		or char:FindFirstChild('Right Arm')
		or char:FindFirstChild('HumanoidRootPart')
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
	local nearest = getNearestPlayer(range)
	return nearest and {nearest} or {}
end

local function findDrinkGiver(recipeName)
	local myRoot = getRoot(lplr)
	if not myRoot then
		return
	end
	local nearest, nearestDist
	for _, inst in collectionService:GetTagged('DrinkGiver') do
		if inst.Name == recipeName and inst.Parent then
			local pos
			if inst:IsA('BasePart') then
				pos = inst.Position
			elseif inst:IsA('Model') then
				local col = inst:FindFirstChild('Collider') or inst.PrimaryPart
				pos = col and col.Position
			end
			if pos then
				local dist = (pos - myRoot.Position).Magnitude
				if not nearestDist or dist < nearestDist then
					nearest = inst
					nearestDist = dist
				end
			end
		end
	end
	return nearest
end

local function getToolByRecipe(recipeName, tag)
	if DrinkHandler and DrinkHandler.GetTaggedTool then
		local tool = DrinkHandler.GetTaggedTool(tag, recipeName)
		if tool and tool.Parent then
			return tool
		end
	end
	if not Backpack then
		return
	end
	local found
	Backpack.IterateBackpackItems(function(entry)
		if found then
			return
		end
		local tool = entry.Tool
		if tool and tool.Parent and tool:GetAttribute('Recipe') == recipeName then
			found = tool
		elseif tool and collectionService:HasTag(tool, tag) then
			found = tool
		end
	end)
	return found
end

local function equipTool(tool)
	if not (tool and tool.Parent and Backpack) then
		return false
	end
	local hum = lplr.Character and lplr.Character:FindFirstChildOfClass('Humanoid')
	if not hum then
		return false
	end
	if tool.Parent ~= lplr.Character then
		hum:EquipTool(tool)
		task.wait(0.15)
	end
	return lplr.Character and tool.Parent == lplr.Character
end

local function grabRecipeTool(recipeName)
	if not remotes.giveDrink then
		return false
	end
	local giver = findDrinkGiver(recipeName)
	if not giver then
		return false
	end
	remotes.giveDrink:Fire(giver)
	return true
end

local function ensureRecipeTool(recipeName, tag, waitTime)
	local tool = getToolByRecipe(recipeName, tag)
	if tool then
		return tool
	end
	if not grabRecipeTool(recipeName) then
		return
	end
	local deadline = tick() + (waitTime or 1.5)
	repeat
		task.wait(0.1)
		tool = getToolByRecipe(recipeName, tag)
	until tool or tick() >= deadline
	return tool
end

local function getInventoryItemId(ivid)
	if not (Mince and Mince.Config and Mince.Config.LocalProfile) then
		return
	end
	local inventory = Mince.Config.LocalProfile.Inventory
	if type(inventory) ~= 'table' then
		return
	end
	for id, data in inventory do
		if type(data) == 'table' and data.IVID == ivid then
			return id
		end
	end
end

local function equipInventoryIVID(ivid)
	local itemId = getInventoryItemId(ivid)
	if itemId and remotes.inventoryEquip then
		remotes.inventoryEquip:Fire(itemId)
		task.wait(0.3)
		return true
	end
	return false
end

local function fireThrow(remoteKey, origin, targetPos, power, isDart)
	if not (origin and targetPos) then
		return false
	end
	local remote = remotes[remoteKey]
	if not remote then
		return false
	end
	local ok = pcall(function()
		if isDart then
			remote:Fire(origin, targetPos, false)
		else
			remote:Fire(power or 1, origin, targetPos - origin)
		end
	end)
	if ok then
		return true
	end
	if not remoteFolder then
		return false
	end
	local baseName = ({
		snowballThrow = 'Snowballs',
		bottleThrow = 'FightBottle',
		cakeThrow = 'ThrowCakes',
		dartThrow = 'Darts',
	})[remoteKey]
	local baseRemote = baseName and remoteFolder:FindFirstChild(baseName)
	if not baseRemote then
		return false
	end
	return pcall(function()
		if isDart then
			baseRemote:FireServer('Throw', origin, targetPos, false)
		else
			baseRemote:FireServer('ThrowBall', power or 1, origin, targetPos - origin)
		end
	end)
end

local function throwAtPlayer(toolInfo, target, power)
	local targetRoot = getRoot(target)
	if not targetRoot then
		return false
	end
	local tool = ensureRecipeTool(toolInfo.Recipe, toolInfo.Tag, 0.5)
	if tool then
		equipTool(tool)
	end
	local char = lplr.Character
	local origin
	if tool and tool:FindFirstChild('Handle') then
		origin = tool.Handle.Position
	elseif char then
		local hand = getHandPart(char)
		origin = hand and hand.Position
	end
	if not origin then
		return false
	end
	return fireThrow(toolInfo.Throw, origin, targetRoot.Position, power, toolInfo.Dart)
end

local function vomitAt(target)
	local targetRoot = getRoot(target)
	if remotes.vomitCreate and targetRoot then
		pcall(function()
			remotes.vomitCreate:Fire(targetRoot.Position)
		end)
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
		pcall(function()
			remotes.placeDrink:Fire(result.Position, result.Instance)
		end)
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

local function requireMince()
	if initMince() then
		return true
	end
	notif('On Tap', 'Failed to connect to game remotes. Wait until fully loaded.', 8, 'warning')
	return false
end

run(function()
	local ItemGrabber, Recipe, GrabCount, AutoEquip, GrabDelay

	ItemGrabber = vape.Categories.Minigames:CreateModule({
		Name = 'Item Grabber',
		Function = function(callback)
			if not callback then
				return
			end
			if not requireMince() then
				return
			end
			local recipes = Recipe.Value == 'All'
				and {'Snowball', 'FightBottle', 'ThrowCake', 'Dart'}
				or {RECIPE_TOOLS[Recipe.Value] and RECIPE_TOOLS[Recipe.Value].Recipe or Recipe.Value}
			repeat
				for _ = 1, GrabCount.Value do
					for _, recipeName in recipes do
						local giver = findDrinkGiver(recipeName)
						if giver then
							pcall(function()
								remotes.giveDrink:Fire(giver)
							end)
							task.wait(0.2)
							if AutoEquip.Enabled then
								local info
								for _, entry in RECIPE_TOOLS do
									if entry.Recipe == recipeName then
										info = entry
										break
									end
								end
								if info then
									local tool = getToolByRecipe(info.Recipe, info.Tag)
									if tool then
										equipTool(tool)
									end
								end
							end
						end
					end
				end
				task.wait(GrabDelay.Value)
			until not ItemGrabber.Enabled
		end,
		Tooltip = 'Grabs throwable items from nearest DrinkGiver stations (Snowball bar, etc).'
	})
	Recipe = ItemGrabber:CreateDropdown({
		Name = 'Item',
		List = {'Snowball', 'Bottle', 'Cake', 'Dart', 'All'},
		Function = function() end
	})
	GrabCount = ItemGrabber:CreateSlider({
		Name = 'Per Cycle',
		Min = 1,
		Max = 3,
		Default = 1
	})
	AutoEquip = ItemGrabber:CreateToggle({
		Name = 'Auto Equip',
		Default = true,
		Function = function() end
	})
	GrabDelay = ItemGrabber:CreateSlider({
		Name = 'Delay',
		Min = 0.2,
		Max = 3,
		Default = 0.5,
		Decimal = 10,
		Suffix = 's'
	})
end)

run(function()
	local InventoryTools, Item, AutoUse

	InventoryTools = vape.Categories.Minigames:CreateModule({
		Name = 'Inventory Tools',
		Function = function(callback)
			if not callback then
				return
			end
			if not requireMince() then
				return
			end
			repeat
				local ivid = CONSUME_IVIDS[Item.Value]
				if ivid then
					equipInventoryIVID(ivid)
					if AutoUse.Enabled then
						task.wait(0.2)
						if Item.Value == 'ConfettiPopper' and remotes.confetti then
							pcall(function()
								remotes.confetti:Fire()
							end)
						end
					end
				end
				task.wait(1)
			until not InventoryTools.Enabled
		end,
		Tooltip = 'Equips consumable inventory items (confetti, firecrackers) from your inventory.'
	})
	Item = InventoryTools:CreateDropdown({
		Name = 'Item',
		List = {'ConfettiPopper', 'BlueFirecracker', 'PinkFirecracker', 'RedFirecracker'},
		Function = function() end
	})
	AutoUse = InventoryTools:CreateToggle({
		Name = 'Auto Use',
		Default = true,
		Function = function() end
	})
end)

run(function()
	local TrollCombo, Projectile, Power, Delay, Range, AllTargets, AutoGrab

	TrollCombo = vape.Categories.Minigames:CreateModule({
		Name = 'Troll Combo',
		Function = function(callback)
			if not callback then
				return
			end
			if not requireMince() then
				return
			end
			local toolInfo = RECIPE_TOOLS[Projectile.Value]
			if not toolInfo then
				notif('On Tap', 'Unknown projectile type.', 5, 'warning')
				return
			end
			repeat
				if AutoGrab.Enabled then
					ensureRecipeTool(toolInfo.Recipe, toolInfo.Tag, 1)
				end
				local targets = getTargetPlayer(Range.Value, AllTargets.Enabled)
				for _, plr in targets do
					throwAtPlayer(toolInfo, plr, Power.Value)
				end
				task.wait(Delay.Value)
			until not TrollCombo.Enabled
		end,
		Tooltip = 'Grab item → equip → throw at players. Best all-in-one troll module.'
	})
	Projectile = TrollCombo:CreateDropdown({
		Name = 'Projectile',
		List = {'Snowball', 'Bottle', 'Cake', 'Dart'},
		Function = function() end
	})
	Power = TrollCombo:CreateSlider({
		Name = 'Power',
		Min = 0.1,
		Max = 1,
		Default = 1,
		Decimal = 10
	})
	Delay = TrollCombo:CreateSlider({
		Name = 'Delay',
		Min = 0.15,
		Max = 2,
		Default = 0.4,
		Decimal = 100,
		Suffix = 's'
	})
	Range = TrollCombo:CreateSlider({
		Name = 'Range',
		Min = 20,
		Max = 300,
		Default = 200,
		Suffix = ' studs'
	})
	AllTargets = TrollCombo:CreateToggle({
		Name = 'All In Range',
		Default = false,
		Function = function() end
	})
	AutoGrab = TrollCombo:CreateToggle({
		Name = 'Auto Grab Items',
		Default = true,
		Function = function() end,
		Tooltip = 'Automatically grabs tools from DrinkGivers before throwing.'
	})
end)

run(function()
	local ThrowSpammer, Projectile, Power, Delay, Range, AllTargets, AutoGrab

	ThrowSpammer = vape.Categories.Minigames:CreateModule({
		Name = 'Throw Spammer',
		Function = function(callback)
			if not callback then
				return
			end
			if not requireMince() then
				return
			end
			local toolInfo = RECIPE_TOOLS[Projectile.Value]
			if not toolInfo then
				return
			end
			repeat
				if AutoGrab.Enabled then
					ensureRecipeTool(toolInfo.Recipe, toolInfo.Tag, 0.75)
				end
				for _, plr in getTargetPlayer(Range.Value, AllTargets.Enabled) do
					throwAtPlayer(toolInfo, plr, Power.Value)
				end
				task.wait(Delay.Value)
			until not ThrowSpammer.Enabled
		end,
		Tooltip = 'Rapid throwable spam with auto-grab support.'
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
		Min = 0.1,
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
	AutoGrab = ThrowSpammer:CreateToggle({
		Name = 'Auto Grab Items',
		Default = true,
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
			if not requireMince() then
				return
			end
			repeat
				for _, plr in getTargetPlayer(Range.Value, AllTargets.Enabled) do
					vomitAt(plr)
				end
				task.wait(Delay.Value)
			until not VomitRain.Enabled
		end,
		Tooltip = 'Spawns vomit puddles at players.'
	})
	Delay = VomitRain:CreateSlider({
		Name = 'Delay',
		Min = 0.2,
		Max = 3,
		Default = 0.6,
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
	local DrunkBeacon, Level, Delay

	DrunkBeacon = vape.Categories.Minigames:CreateModule({
		Name = 'Drunk Beacon',
		Function = function(callback)
			if not callback then
				return
			end
			if not requireMince() then
				return
			end
			repeat
				pcall(function()
					remotes.intoxReport:Fire(Level.Value)
				end)
				task.wait(Delay.Value)
			until not DrunkBeacon.Enabled
		end,
		Tooltip = 'Replicates high intoxication level to other players.'
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
	local ConfettiSpam, UseInventory, Delay

	ConfettiSpam = vape.Categories.Minigames:CreateModule({
		Name = 'Confetti Spam',
		Function = function(callback)
			if not callback then
				return
			end
			if not requireMince() then
				return
			end
			repeat
				if UseInventory.Enabled then
					equipInventoryIVID(CONSUME_IVIDS.ConfettiPopper)
					task.wait(0.15)
				end
				pcall(function()
					remotes.confetti:Fire()
				end)
				task.wait(Delay.Value)
			until not ConfettiSpam.Enabled
		end,
		Tooltip = 'Confetti popper spam. Enable Use Inventory if you own one.'
	})
	UseInventory = ConfettiSpam:CreateToggle({
		Name = 'Use Inventory',
		Default = true,
		Function = function() end
	})
	Delay = ConfettiSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.1,
		Max = 2,
		Default = 0.3,
		Decimal = 100,
		Suffix = 's'
	})
end)

run(function()
	local FightSpam, AutoGrab, Delay

	FightSpam = vape.Categories.Minigames:CreateModule({
		Name = 'Fight Spam',
		Function = function(callback)
			if not callback then
				return
			end
			if not requireMince() then
				return
			end
			repeat
				if AutoGrab.Enabled then
					local tool = getToolByRecipe('FightBottle', 'FightBottle')
						or ensureRecipeTool('FightBottle', 'FightBottle', 0.5)
					if tool then
						equipTool(tool)
					end
				end
				pcall(function()
					remotes.swing:Fire()
				end)
				task.wait(Delay.Value)
			until not FightSpam.Enabled
		end,
		Tooltip = 'Fight ring punch spam. Auto Grab equips a bottle first.'
	})
	AutoGrab = FightSpam:CreateToggle({
		Name = 'Auto Grab Bottle',
		Default = false,
		Function = function() end
	})
	Delay = FightSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.15,
		Max = 2,
		Default = 0.25,
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
			if not requireMince() then
				return
			end
			local carrying = false
			repeat
				if AutoDrop.Enabled and carrying then
					pcall(function()
						remotes.pickup:Fire('Drop')
					end)
					carrying = false
					task.wait(DropDelay.Value)
				else
					for _, plr in getPlayersInRange(Range.Value) do
						if canPickupPlayer(plr) then
							pcall(function()
								remotes.pickup:Fire(plr)
							end)
							carrying = true
							break
						end
					end
					task.wait(0.5)
				end
			until not PickupGrabber.Enabled
		end,
		Tooltip = 'Picks up ragdolled players (they must allow pickup).'
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
		Function = function() end
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
	local DrinkPlacer, Delay, Range, AllTargets, AutoGrab

	DrinkPlacer = vape.Categories.Minigames:CreateModule({
		Name = 'Drink Placer',
		Function = function(callback)
			if not callback then
				return
			end
			if not requireMince() then
				return
			end
			repeat
				if AutoGrab.Enabled and DrinkHandler then
					local drink = DrinkHandler.GetEquippedDrinkTool and DrinkHandler.GetEquippedDrinkTool()
					if not drink then
						for _, recipe in {'Snowball', 'FightBottle', 'ThrowCake'} do
							local tool = ensureRecipeTool(recipe, recipe == 'ThrowCake' and 'ThrowCake' or recipe, 0.5)
							if tool and equipTool(tool) then
								break
							end
						end
					end
				end
				for _, plr in getTargetPlayer(Range.Value, AllTargets.Enabled) do
					placeDrinkAt(plr)
				end
				task.wait(Delay.Value)
			until not DrinkPlacer.Enabled
		end,
		Tooltip = 'Places equipped drink at player feet.'
	})
	Delay = DrinkPlacer:CreateSlider({
		Name = 'Delay',
		Min = 0.2,
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
	AutoGrab = DrinkPlacer:CreateToggle({
		Name = 'Auto Grab Drink',
		Default = true,
		Function = function() end
	})
end)

run(function()
	local ForceChug, AutoGrab, Delay

	ForceChug = vape.Categories.Minigames:CreateModule({
		Name = 'Force Chug',
		Function = function(callback)
			if not callback then
				return
			end
			if not requireMince() then
				return
			end
			repeat
				if AutoGrab.Enabled then
					for _, recipe in {'Snowball', 'FightBottle', 'ThrowCake', 'Dart'} do
						local tag = recipe == 'ThrowCake' and 'ThrowCake' or recipe
						local tool = ensureRecipeTool(recipe, tag, 0.5)
						if tool and equipTool(tool) then
							break
						end
					end
				end
				pcall(function()
					remotes.interactDrink:Fire()
				end)
				task.wait(Delay.Value)
			until not ForceChug.Enabled
		end,
		Tooltip = 'Force-chug equipped drink (get one with Item Grabber first).'
	})
	AutoGrab = ForceChug:CreateToggle({
		Name = 'Auto Grab Drink',
		Default = true,
		Function = function() end
	})
	Delay = ForceChug:CreateSlider({
		Name = 'Delay',
		Min = 0.15,
		Max = 2,
		Default = 0.35,
		Decimal = 100,
		Suffix = 's'
	})
end)

run(function()
	local EmoteSpam, EmoteName, Delay, Range, TargetPlayers

	EmoteSpam = vape.Categories.Minigames:CreateModule({
		Name = 'Emote Spam',
		Function = function(callback)
			if not callback then
				return
			end
			if not requireMince() then
				return
			end
			repeat
				if TargetPlayers.Enabled then
					for _, plr in getPlayersInRange(Range.Value) do
						pcall(function()
							remotes.lockUpCollab:Fire(plr)
						end)
					end
				else
					pcall(function()
						remotes.emoteSync:Fire(EmoteName.Value)
					end)
				end
				task.wait(Delay.Value)
			until not EmoteSpam.Enabled
		end,
		Tooltip = 'Spam emotes or lock onto players doing collab emotes.'
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
	TargetPlayers = EmoteSpam:CreateToggle({
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
			if not requireMince() then
				return
			end
			repeat
				for _, plr in getPlayersInRange(Range.Value) do
					if isRagdolled(plr) then
						pcall(function()
							remotes.ragdollDrop:Fire()
						end)
					end
				end
				pcall(function()
					remotes.ragdollDrop:Fire(true, true)
				end)
				task.wait(Delay.Value)
			until not RagdollDropper.Enabled
		end,
		Tooltip = 'Drops ragdolled players nearby.'
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
	local TeleportGiver, Recipe

	TeleportGiver = vape.Categories.Minigames:CreateModule({
		Name = 'TP To Giver',
		Function = function(callback)
			if not callback then
				return
			end
			if not requireMince() then
				return
			end
			local recipeName = RECIPE_TOOLS[Recipe.Value] and RECIPE_TOOLS[Recipe.Value].Recipe or Recipe.Value
			local giver = findDrinkGiver(recipeName)
			local root = getRoot(lplr)
			if not (giver and root) then
				notif('On Tap', 'No DrinkGiver found for ' .. recipeName, 5, 'warning')
				return
			end
			local pos
			if giver:IsA('BasePart') then
				pos = giver.Position
			else
				local col = giver:FindFirstChild('Collider') or giver.PrimaryPart
				pos = col and col.Position
			end
			if pos then
				root.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
				notif('On Tap', 'Teleported to ' .. recipeName .. ' giver', 3)
			end
		end,
		Tooltip = 'Teleport to nearest DrinkGiver for snowballs, bottles, etc.'
	})
	Recipe = TeleportGiver:CreateDropdown({
		Name = 'Item',
		List = {'Snowball', 'Bottle', 'Cake', 'Dart'},
		Function = function() end
	})
end)

run(function()
	local PickupWorldDrinks, Range, Delay

	PickupWorldDrinks = vape.Categories.Minigames:CreateModule({
		Name = 'Pickup Drinks',
		Function = function(callback)
			if not callback then
				return
			end
			if not requireMince() then
				return
			end
			local myRoot = getRoot(lplr)
			repeat
				if myRoot then
					local nearest, nearestDist
					for _, inst in workspace:GetDescendants() do
						if inst:IsA('BasePart') and inst:GetAttribute('Recipe') then
							local dist = (inst.Position - myRoot.Position).Magnitude
							if dist <= Range.Value and (not nearestDist or dist < nearestDist) then
								nearest = inst
								nearestDist = dist
							end
						end
					end
					if nearest and remotes.pickupDrink then
						pcall(function()
							remotes.pickupDrink:Fire(nearest.Parent or nearest)
						end)
					end
				end
				task.wait(Delay.Value)
			until not PickupWorldDrinks.Enabled
		end,
		Tooltip = 'Picks up placed drinks/tools in the world near you.'
	})
	Range = PickupWorldDrinks:CreateSlider({
		Name = 'Range',
		Min = 5,
		Max = 50,
		Default = 25,
		Suffix = ' studs'
	})
	Delay = PickupWorldDrinks:CreateSlider({
		Name = 'Delay',
		Min = 0.1,
		Max = 2,
		Default = 0.3,
		Decimal = 100,
		Suffix = 's'
	})
end)
