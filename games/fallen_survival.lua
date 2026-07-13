--[[
	Fallen Survival shared place hooks.
	Loaded by 16849012343 (Medium) and 13800717766 (Large) place scripts.
]]

local cloneref = cloneref or function(obj)
	return obj
end

local playersService = cloneref(game:GetService('Players'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local runService = cloneref(game:GetService('RunService'))

local lplr = playersService.LocalPlayer
local vape = shared.vape
if not vape then
	return
end

local entitylib = vape.Libraries.entity
local FALLEN_PLACE_IDS = {
	[16849012343] = 'Medium',
	[13800717766] = 'Large',
}

vape.Libraries.fallen = vape.Libraries.fallen or {
	PlaceId = game.PlaceId,
	ServerType = FALLEN_PLACE_IDS[game.PlaceId] or 'Unknown',
	Modules = replicatedStorage:WaitForChild('Modules'),
	Values = replicatedStorage:FindFirstChild('Values'),
	CharacterScripts = replicatedStorage:FindFirstChild('CharacterScripts'),
	VFX = replicatedStorage:FindFirstChild('VFX'),
	VMs = replicatedStorage:FindFirstChild('VMs'),
}

local fallen = vape.Libraries.fallen

-- Fallen uses viewmodels + world models; keep entity refresh in sync after spawn.
local function refreshEntityState()
	if entitylib and entitylib.refresh then
		pcall(entitylib.refresh)
	end
end

lplr.CharacterAdded:Connect(function()
	task.delay(0.5, refreshEntityState)
	task.delay(2, refreshEntityState)
end)

-- Animals / hostile models use Humanoid under workspace folders — entitylib fake scan already covers these.
for _, folderName in {'Animals', 'Events', 'Bases'} do
	local folder = workspace:FindFirstChild(folderName)
	if folder and entitylib then
		vape:Clean(folder.DescendantAdded:Connect(function(obj)
			if obj:IsA('Model') and entitylib.tryAddFakePlayer then
				task.defer(entitylib.tryAddFakePlayer, obj)
			end
		end))
	end
end

-- Tag silent-aim visualizer ignores for Fallen VFX viewmodels when present.
vape:Clean(runService.Heartbeat:Connect(function()
	local vfx = workspace:FindFirstChild('VFX')
	if not vfx then return end
	local vms = vfx:FindFirstChild('VMs')
	if vms and vape.Libraries.visualizerModels then
		for _, model in vms:GetChildren() do
			if model:IsA('Model') and not table.find(vape.Libraries.visualizerModels, model) then
				table.insert(vape.Libraries.visualizerModels, model)
			end
		end
	end
end))

if vape.CreateNotification then
	local serverLabel = fallen.ServerType ~= 'Unknown' and (' ('..fallen.ServerType..')') or ''
	vape:CreateNotification('Fallen Survival', 'Bypass active · Universal modules loaded'..serverLabel, 5)
end
