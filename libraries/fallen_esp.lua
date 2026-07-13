--[[ Fallen Survival ESP + visuals — Iridescent-style ScreenGui boxes ]]
local vape = shared.vape
local FS = vape.Libraries.fallenState
if not FS then return end

local run = function(f)
	local ok, err = pcall(f)
	if not ok then warn('[Fallen ESP]', err) end
end

local cloneref = cloneref or function(o) return o end
local players = cloneref(game:GetService('Players'))
local runService = cloneref(game:GetService('RunService'))
local userInputService = cloneref(game:GetService('UserInputService'))
local lighting = cloneref(game:GetService('Lighting'))
local tweenService = cloneref(game:GetService('TweenService'))
local debris = cloneref(game:GetService('Debris'))
local workspace = cloneref(game:GetService('Workspace'))
local coreGui = cloneref(game:GetService('CoreGui'))

local lplr = players.LocalPlayer
local camera = workspace.CurrentCamera
local Targeting = FS.Targeting
local flags = FS.flags or {}
local getRoot = FS.GetRoot
local colorFromSlider = FS.colorFromSlider
local resolveCharacter = FS.resolveCharacter or function(entity, object)
	if object and object.Character then return object.Character end
	if entity and entity:IsA('Model') then return entity end
	if entity and entity:IsA('Player') then return entity.Character end
end

local DrawingLib = rawget(getfenv(), 'Drawing') or Drawing

local function guiParent()
	return (gethui and gethui()) or coreGui
end

local SKEL_PAIRS = {
	{ 'Head', 'UpperTorso' }, { 'UpperTorso', 'LowerTorso' },
	{ 'UpperTorso', 'LeftUpperArm' }, { 'LeftUpperArm', 'LeftLowerArm' }, { 'LeftLowerArm', 'LeftHand' },
	{ 'UpperTorso', 'RightUpperArm' }, { 'RightUpperArm', 'RightLowerArm' }, { 'RightLowerArm', 'RightHand' },
	{ 'LowerTorso', 'LeftUpperLeg' }, { 'LeftUpperLeg', 'LeftLowerLeg' }, { 'LeftLowerLeg', 'LeftFoot' },
	{ 'LowerTorso', 'RightUpperLeg' }, { 'RightUpperLeg', 'RightLowerLeg' }, { 'RightLowerLeg', 'RightFoot' },
}

local espSpace = Instance.new('ScreenGui')
espSpace.Name = 'FallenESPSpace'
espSpace.IgnoreGuiInset = true
espSpace.ResetOnSpawn = false
espSpace.DisplayOrder = 5
espSpace.Parent = guiParent()
vape:Clean(espSpace)

local entities = {} -- [key] = { components, class }

local function floorVec2(v)
	return Vector2.new(math.floor(v.X), math.floor(v.Y))
end

local function getBoundingBox(model, orientation)
	orientation = orientation or CFrame.new()
	local minX, minY, minZ = math.huge, math.huge, math.huge
	local maxX, maxY, maxZ = -math.huge, -math.huge, -math.huge
	for _, part in model:GetChildren() do
		if part:IsA('BasePart') then
			local cf = orientation:ToObjectSpace(part.CFrame)
			local sx, sy, sz = part.Size.X, part.Size.Y, part.Size.Z
			local x, y, z, r00, r01, r02, r10, r11, r12, r20, r21, r22 = cf:GetComponents()
			local wsx = 0.5 * (math.abs(r00) * sx + math.abs(r01) * sy + math.abs(r02) * sz)
			local wsy = 0.5 * (math.abs(r10) * sx + math.abs(r11) * sy + math.abs(r12) * sz)
			local wsz = 0.5 * (math.abs(r20) * sx + math.abs(r21) * sy + math.abs(r22) * sz)
			minX, minY, minZ = math.min(minX, x - wsx), math.min(minY, y - wsy), math.min(minZ, z - wsz)
			maxX, maxY, maxZ = math.max(maxX, x + wsx), math.max(maxY, y + wsy), math.max(maxZ, z + wsz)
		end
	end
	local minVec = Vector3.new(minX, minY, minZ)
	local maxVec = Vector3.new(maxX, maxY, maxZ)
	local middle = (maxVec + minVec) / 2
	local cf = orientation - orientation.Position + orientation:PointToWorldSpace(middle)
	return cf, maxVec - minVec
end

local function isPartVisible(targetPart, localChar)
	if not (targetPart and localChar) then return false end
	local head = localChar:FindFirstChild('Head')
	if not head then return false end
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { localChar, camera }
	local hit = workspace:Raycast(head.Position, targetPart.Position - head.Position, params)
	return not hit or (hit.Instance and hit.Instance:IsDescendantOf(targetPart.Parent))
end

local function getBoxSize(character, root)
	if not character or not root then
		return { Visible = false, OnScreen = false, Root = nil }
	end
	if (camera.CFrame.Position - root.Position).Magnitude > 2000 then
		return { Visible = false, OnScreen = false, Root = root }
	end
	local bboxPos, bboxSize = getBoundingBox(character, root.CFrame)
	local half = bboxSize / 2
	local offsets = {
		Vector3.new(half.X, half.Y, half.Z), Vector3.new(half.X, half.Y, -half.Z),
		Vector3.new(half.X, -half.Y, half.Z), Vector3.new(half.X, -half.Y, -half.Z),
		Vector3.new(-half.X, half.Y, half.Z), Vector3.new(-half.X, half.Y, -half.Z),
		Vector3.new(-half.X, -half.Y, half.Z), Vector3.new(-half.X, -half.Y, -half.Z),
	}
	local minX, minY, maxX, maxY = math.huge, math.huge, -math.huge, -math.huge
	local onScreenCount = 0
	for _, off in offsets do
		local sp, on = camera:WorldToViewportPoint(bboxPos:PointToWorldSpace(off))
		if on then
			onScreenCount += 1
			minX, minY = math.min(minX, sp.X), math.min(minY, sp.Y)
			maxX, maxY = math.max(maxX, sp.X), math.max(maxY, sp.Y)
		end
	end
	if onScreenCount == 0 then
		local head = character:FindFirstChild('Head')
		local vis = head and isPartVisible(head, FS.ClientCharacter)
		return { Root = root, OnScreen = false, Visible = vis, VisiblePart = vis and head or nil }
	end
	local visiblePart
	for _, name in { 'HumanoidRootPart', 'Head', 'UpperTorso' } do
		local p = character:FindFirstChild(name)
		if p and isPartVisible(p, FS.ClientCharacter) then
			visiblePart = p
			break
		end
	end
	local size = floorVec2(Vector2.new(maxX - minX, maxY - minY))
	local pos = floorVec2(Vector2.new(minX, minY))
	return {
		Visible = visiblePart ~= nil,
		VisiblePart = visiblePart,
		Root = root,
		OnScreen = true,
		Size = size,
		Position = pos,
		Width = size.X,
		Height = size.Y,
		Center2D = Vector2.new(pos.X + size.X / 2, pos.Y + size.Y / 2),
	}
end

local function makeCorner(parent, size, pos, color)
	local f = Instance.new('Frame')
	f.BackgroundColor3 = color
	f.BorderSizePixel = 0
	f.Size = size
	f.Position = pos
	f.Parent = parent
	return f
end

local function createComponents()
	local boxOutline = Instance.new('Frame')
	boxOutline.BackgroundTransparency = 1
	boxOutline.Visible = false
	boxOutline.ZIndex = 2
	boxOutline.Parent = espSpace
	local outlineStroke = Instance.new('UIStroke')
	outlineStroke.Thickness = 3
	outlineStroke.Color = Color3.new(0, 0, 0)
	outlineStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	outlineStroke.LineJoinMode = Enum.LineJoinMode.Miter
	outlineStroke.Parent = boxOutline
	local boxInline = Instance.new('Frame')
	boxInline.BackgroundTransparency = 1
	boxInline.Position = UDim2.new(0, -1, 0, -1)
	boxInline.Size = UDim2.new(1, 2, 1, 2)
	boxInline.Parent = boxOutline
	local inlineStroke = Instance.new('UIStroke')
	inlineStroke.LineJoinMode = Enum.LineJoinMode.Miter
	inlineStroke.Color = Color3.new(1, 1, 1)
	inlineStroke.Parent = boxInline
	local fakeCorner = Instance.new('Frame')
	fakeCorner.BackgroundTransparency = 1
	fakeCorner.Size = UDim2.new(1, 4, 1, 2)
	fakeCorner.Position = UDim2.new(0, -2, 0, -1)
	fakeCorner.Parent = boxOutline
	local corners = {}
	local cw, ch, th = 0.3, 0.3, 1
	for i = 1, 8 do corners[i] = Instance.new('Frame') end
	local nameLabel = Instance.new('TextLabel')
	nameLabel.BackgroundTransparency = 1
	nameLabel.Font = Enum.Font.GothamMedium
	nameLabel.TextSize = 13
	nameLabel.TextStrokeTransparency = 0.5
	nameLabel.Visible = false
	nameLabel.Parent = boxOutline
	local healthBack = Instance.new('Frame')
	healthBack.BackgroundColor3 = Color3.new(0, 0, 0)
	healthBack.BorderSizePixel = 1
	healthBack.BorderColor3 = Color3.new(0, 0, 0)
	healthBack.Size = UDim2.new(0, 2, 1, 4)
	healthBack.Position = UDim2.new(0, -5, 0, -2)
	healthBack.Visible = false
	healthBack.Parent = boxOutline
	local healthFill = Instance.new('Frame')
	healthFill.BorderSizePixel = 0
	healthFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	healthFill.Size = UDim2.fromScale(1, 1)
	healthFill.Parent = healthBack
	return {
		BoxOutline = boxOutline,
		BoxOutlineStroke = outlineStroke,
		BoxInlineStroke = inlineStroke,
		FakeCornerBox = fakeCorner,
		Corners = corners,
		Name = nameLabel,
		Healthbar = healthBack,
		HealthFill = healthFill,
		Skeleton = {},
		Highlight = nil,
	}
end

local function hideEntity(entry)
	if not entry then return end
	local c = entry.components
	if not c then return end
	c.BoxOutline.Visible = false
	c.Name.Visible = false
	c.Healthbar.Visible = false
	if c.Highlight then c.Highlight.Enabled = false end
	for _, line in c.Skeleton do
		if line then line.Visible = false end
	end
end

local function destroyEntity(key)
	local entry = entities[key]
	if not entry then return end
	hideEntity(entry)
	if entry.components then
		if entry.components.BoxOutline then entry.components.BoxOutline:Destroy() end
		if entry.components.Highlight then entry.components.Highlight:Destroy() end
		for _, line in entry.components.Skeleton do
			pcall(function() line:Remove() end)
		end
	end
	entities[key] = nil
end

-- Tracers / hitmarkers (combat hooks call these)
local TRACER_STYLES = {
	Default = { Asset = 'rbxassetid://128372145766358', Width = 0.4 },
	Lightning = { Asset = 'rbxassetid://16892528550', Width = 2 },
	Dark = { Asset = 'rbxassetid://119588180395545', Width = 1 },
}

FS.SpawnTracer = function(position, originPos)
	if not flags.BulletTracers then return end
	local origin = originPos
	if not origin then
		local head = FS.ClientCharacter and FS.ClientCharacter:FindFirstChild('Head')
		origin = head and head.Position
	end
	if not origin then return end
	local vms = workspace:FindFirstChild('VFX') and workspace.VFX:FindFirstChild('VMs') or workspace.Terrain
	local info = TRACER_STYLES[flags.BulletTracersStyle or 'Default'] or TRACER_STYLES.Default
	local att0, att1 = Instance.new('Attachment'), Instance.new('Attachment')
	att0.WorldPosition, att1.WorldPosition = origin, origin
	att0.Parent, att1.Parent = vms, vms
	local beam = Instance.new('Beam')
	beam.Attachment0, beam.Attachment1 = att0, att1
	beam.Texture = info.Asset
	beam.Width0, beam.Width1 = info.Width, info.Width
	beam.FaceCamera, beam.LightEmission, beam.Brightness = true, 1, flags.BulletTracersBrightness or 8
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

FS.SpawnHitmarker = function(position)
	if not flags.Hitmarkers then return end
	local part = Instance.new('Part')
	part.Anchored, part.CanCollide, part.Transparency = true, false, 1
	part.Size = Vector3.new(0.2, 0.2, 0.2)
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

run(function()
	local ESP
	local settings = {
		Players = true, AI = true, Boss = true,
		Box = true, BoxStyle = 'Outline',
		Name = true, Distance = true, Healthbar = true,
		Skeleton = false, Chams = false,
		MaxDistance = 2000,
	}
	local colVis, colOcc, chamsVis, chamsOcc

	ESP = vape.Categories.Render:CreateModule({
		Name = 'Fallen ESP',
		Function = function(callback)
			settings.Enabled = callback
			if not callback then
				for key in pairs(entities) do destroyEntity(key) end
			end
		end,
		Tooltip = 'Iridescent-style player / AI / boss ESP',
	})
	settings.Enabled = false

	ESP:CreateToggle({ Name = 'Players', Default = true, Function = function(v) settings.Players = v end })
	ESP:CreateToggle({ Name = 'AI', Default = true, Function = function(v) settings.AI = v end })
	ESP:CreateToggle({ Name = 'Boss', Default = true, Function = function(v) settings.Boss = v end })
	ESP:CreateToggle({ Name = 'Box', Default = true, Function = function(v) settings.Box = v end })
	ESP:CreateDropdown({
		Name = 'Box Style',
		List = { 'Outline', 'Corner' },
		Function = function(v) settings.BoxStyle = v end,
	})
	ESP:CreateToggle({ Name = 'Name', Default = true, Function = function(v) settings.Name = v end })
	ESP:CreateToggle({ Name = 'Distance', Default = true, Function = function(v) settings.Distance = v end })
	ESP:CreateToggle({ Name = 'Healthbar', Default = true, Function = function(v) settings.Healthbar = v end })
	ESP:CreateToggle({ Name = 'Skeleton', Function = function(v) settings.Skeleton = v end })
	ESP:CreateToggle({ Name = 'Chams', Function = function(v) settings.Chams = v end })
	ESP:CreateSlider({
		Name = 'Max Distance', Min = 100, Max = 4000, Default = 2000,
		Function = function(v) settings.MaxDistance = v end,
	})
	colVis = ESP:CreateColorSlider({ Name = 'Visible Color', DefaultHue = 0.33 })
	colOcc = ESP:CreateColorSlider({ Name = 'Occluded Color', DefaultHue = 0 })
	chamsVis = ESP:CreateColorSlider({ Name = 'Chams Visible', DefaultHue = 0.55 })
	chamsOcc = ESP:CreateColorSlider({ Name = 'Chams Hidden', DefaultHue = 0.05 })

	local function classEnabled(class)
		if class == 'Player' then return settings.Players end
		if class == 'AI' then return settings.AI end
		if class == 'Boss' then return settings.Boss end
		return false
	end

	local function updateEntity(key, object, character, hum, root, core, dist)
		local class = object.Class
		if not classEnabled(class) then
			if entities[key] then hideEntity(entities[key]) end
			return
		end
		local entry = entities[key]
		if not entry then
			entry = { components = createComponents() }
			entities[key] = entry
		end
		local c = entry.components
		local visible = core.Visible
		local statusColor = visible and colorFromSlider(colVis) or colorFromSlider(colOcc)

		if settings.Chams then
			if not c.Highlight then
				c.Highlight = Instance.new('Highlight')
				c.Highlight.FillTransparency = 0.5
				c.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				c.Highlight.Parent = guiParent()
			end
			c.Highlight.Adornee = character
			c.Highlight.Enabled = true
			c.Highlight.FillColor = visible and colorFromSlider(chamsVis) or colorFromSlider(chamsOcc)
			c.Highlight.OutlineColor = statusColor
		elseif c.Highlight then
			c.Highlight.Enabled = false
		end

		if not core.OnScreen or not settings.Box then
			c.BoxOutline.Visible = false
		else
			c.BoxOutline.Visible = true
			c.BoxOutline.Position = UDim2.fromOffset(core.Position.X, core.Position.Y)
			c.BoxOutline.Size = UDim2.fromOffset(core.Size.X, core.Size.Y)
			c.BoxInlineStroke.Color = statusColor
			c.BoxOutlineStroke.Transparency = hum.Health <= 0 and 1 or 0
		end

		if settings.Name and core.OnScreen then
			local text = object.Player and object.Player.Name or character.Name
			if settings.Distance then
				text = string.format('%s [%dm]', text, math.floor(dist))
			end
			c.Name.Visible = true
			c.Name.Text = text
			c.Name.TextColor3 = statusColor
			c.Name.Position = UDim2.new(0, 0, 1, 2)
			c.Name.Size = UDim2.new(1, 0, 0, 14)
		else
			c.Name.Visible = false
		end

		if settings.Healthbar and core.OnScreen and hum.MaxHealth > 0 then
			c.Healthbar.Visible = true
			local pct = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
			c.HealthFill.Size = UDim2.new(1, 0, pct, 0)
			c.HealthFill.Position = UDim2.new(0, 0, 1 - pct, 0)
			c.HealthFill.BackgroundColor3 = Color3.fromRGB(255 * (1 - pct), 255 * pct, 0)
		else
			c.Healthbar.Visible = false
		end

		if settings.Skeleton and DrawingLib and core.OnScreen then
			if #c.Skeleton == 0 then
				for i = 1, #SKEL_PAIRS do
					local line = DrawingLib.new('Line')
					line.Thickness = 1
					line.Visible = false
					c.Skeleton[i] = line
				end
			end
			local idx = 0
			for _, pair in SKEL_PAIRS do
				idx += 1
				local a, b = character:FindFirstChild(pair[1]), character:FindFirstChild(pair[2])
				local line = c.Skeleton[idx]
				if a and b and line then
					local sa, oa = camera:WorldToViewportPoint(a.Position)
					local sb, ob = camera:WorldToViewportPoint(b.Position)
					if oa and ob and sa.Z > 0 and sb.Z > 0 then
						line.From = Vector2.new(sa.X, sa.Y)
						line.To = Vector2.new(sb.X, sb.Y)
						line.Color = statusColor
						line.Visible = true
					else
						line.Visible = false
					end
				elseif line then
					line.Visible = false
				end
			end
		else
			for _, line in c.Skeleton do
				if line then line.Visible = false end
			end
		end

		if object.CoreInformation then
			object.CoreInformation.Visible = visible
			object.CoreInformation.OnScreen = core.OnScreen
			object.CoreInformation.Root = root
		end
	end

	vape:Clean(runService.RenderStepped:Connect(function()
		if not settings.Enabled then return end
		camera = workspace.CurrentCamera
		local seen = {}
		local localChar = FS.ClientCharacter

		for entity, object in pairs(Targeting.Targets) do
			local class = object.Class
			if not classEnabled(class) then continue end
			local character = resolveCharacter(entity, object)
			if not character or not character.Parent then continue end
			local root = getRoot(character)
			local hum = character:FindFirstChildOfClass('Humanoid')
			if not root or not hum or hum.Health <= 0 then continue end
			local dist = (camera.CFrame.Position - root.Position).Magnitude
			if dist > settings.MaxDistance then continue end
			local core = getBoxSize(character, root)
			local key = tostring(entity)
			seen[key] = true
			updateEntity(key, object, character, hum, root, core, dist)
		end

		for key in pairs(entities) do
			if not seen[key] then destroyEntity(key) end
		end
	end))
end)

-- Crosshair + tracers + hitmarkers + lighting
run(function()
	local Visuals = vape.Categories.Render:CreateModule({
		Name = 'Fallen Visuals',
		Function = function(callback)
			flags.FallenVisuals = callback
		end,
		Tooltip = 'Crosshair, bullet tracers, hitmarkers, lighting',
	})

	local crossGui = Instance.new('ScreenGui')
	crossGui.Name = 'FallenCrosshair'
	crossGui.IgnoreGuiInset = true
	crossGui.ResetOnSpawn = false
	crossGui.Parent = guiParent()
	local holder = Instance.new('Frame')
	holder.AnchorPoint = Vector2.new(0.5, 0.5)
	holder.BackgroundTransparency = 1
	holder.Size = UDim2.fromOffset(100, 100)
	holder.Parent = crossGui
	local bars = {}
	for i, rot in { 0, 180, 90, 270 } do
		local f = Instance.new('Frame')
		f.AnchorPoint = Vector2.new(0.5, 0.5)
		f.BackgroundColor3 = Color3.new(1, 1, 1)
		f.BorderSizePixel = 0
		f.Size = (rot == 90 or rot == 270) and UDim2.fromOffset(20, 2) or UDim2.fromOffset(2, 20)
		f.Position = UDim2.new(0.5, 0, 0.5, rot == 0 and -12 or rot == 180 and 12 or 0)
		if rot == 90 then f.Position = UDim2.new(0.5, -12, 0.5, 0) end
		if rot == 270 then f.Position = UDim2.new(0.5, 12, 0.5, 0) end
		f.Parent = holder
		bars[i] = f
	end
	vape:Clean(crossGui)

	local crossToggle = Visuals:CreateToggle({ Name = 'Crosshair', Default = true })
	local crossLen = Visuals:CreateSlider({ Name = 'Crosshair Length', Min = 4, Max = 24, Default = 10 })
	local crossGap = Visuals:CreateSlider({ Name = 'Crosshair Gap', Min = 0, Max = 16, Default = 6 })
	local crossCol = Visuals:CreateColorSlider({ Name = 'Crosshair Color' })
	local stickTarget = Visuals:CreateToggle({ Name = 'Stick To Target' })

	local tracerToggle = Visuals:CreateToggle({ Name = 'Bullet Tracers' })
	Visuals:CreateDropdown({
		Name = 'Tracer Style',
		List = { 'Default', 'Lightning', 'Dark' },
		Function = function(v) flags.BulletTracersStyle = v end,
	})
	local trCol1 = Visuals:CreateColorSlider({ Name = 'Tracer Color 1' })
	local trCol2 = Visuals:CreateColorSlider({ Name = 'Tracer Color 2', DefaultHue = 0.08 })
	Visuals:CreateSlider({
		Name = 'Tracer Brightness', Min = 1, Max = 16, Default = 8,
		Function = function(v) flags.BulletTracersBrightness = v end,
	})
	Visuals:CreateSlider({
		Name = 'Tracer Lifetime', Min = 0.2, Max = 3, Default = 1, Decimal = 10,
		Function = function(v) flags.BulletTracersLifetime = v end,
	})

	local hitToggle = Visuals:CreateToggle({ Name = 'Hitmarkers' })
	Visuals:CreateSlider({
		Name = 'Hitmarker Size', Min = 8, Max = 48, Default = 24,
		Function = function(v) flags.HitmarkerSize = v end,
	})
	Visuals:CreateSlider({
		Name = 'Hitmarker Lifetime', Min = 0.1, Max = 2, Default = 0.4, Decimal = 10,
		Function = function(v) flags.HitmarkerLifetime = v end,
	})
	local hitCol = Visuals:CreateColorSlider({ Name = 'Hitmarker Color' })

	local lightToggle = Visuals:CreateToggle({ Name = 'Fullbright' })
	local savedLight = {}

	vape:Clean(runService.RenderStepped:Connect(function()
		if not flags.FallenVisuals then
			crossGui.Enabled = false
			return
		end
		flags.BulletTracers = tracerToggle.Enabled
		flags.Hitmarkers = hitToggle.Enabled
		flags.BulletTracerColor1 = colorFromSlider(trCol1)
		flags.BulletTracerColor2 = colorFromSlider(trCol2)
		flags.HitmarkerColor = colorFromSlider(hitCol)

		if crossToggle.Enabled then
			crossGui.Enabled = true
			local pos = userInputService:GetMouseLocation()
			if stickTarget.Enabled and Targeting.TargetPart then
				local sp, on = camera:WorldToViewportPoint(Targeting.TargetPart.Position)
				if on then pos = Vector2.new(sp.X, sp.Y) end
			end
			holder.Position = UDim2.fromOffset(pos.X, pos.Y)
			local col = colorFromSlider(crossCol)
			local L, G = crossLen.Value, crossGap.Value
			bars[1].Size = UDim2.fromOffset(2, L)
			bars[1].Position = UDim2.new(0.5, 0, 0.5, -(G + L / 2))
			bars[2].Size = UDim2.fromOffset(2, L)
			bars[2].Position = UDim2.new(0.5, 0, 0.5, G + L / 2)
			bars[3].Size = UDim2.fromOffset(L, 2)
			bars[3].Position = UDim2.new(0.5, -(G + L / 2), 0.5, 0)
			bars[4].Size = UDim2.fromOffset(L, 2)
			bars[4].Position = UDim2.new(0.5, G + L / 2, 0.5, 0)
			for _, f in bars do f.BackgroundColor3 = col end
		else
			crossGui.Enabled = false
		end

		if lightToggle.Enabled then
			if not savedLight.Ambient then
				savedLight.Ambient = lighting.Ambient
				savedLight.Brightness = lighting.Brightness
				savedLight.ClockTime = lighting.ClockTime
				savedLight.FogEnd = lighting.FogEnd
			end
			lighting.Ambient = Color3.new(1, 1, 1)
			lighting.Brightness = 2
			lighting.ClockTime = 14
			lighting.FogEnd = 100000
		elseif savedLight.Ambient then
			lighting.Ambient = savedLight.Ambient
			lighting.Brightness = savedLight.Brightness
			lighting.ClockTime = savedLight.ClockTime
			lighting.FogEnd = savedLight.FogEnd
			table.clear(savedLight)
		end
	end))
end)
