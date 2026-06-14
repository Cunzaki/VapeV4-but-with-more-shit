-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Drink.PlacementHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__UserInputService__1 = game:GetService("UserInputService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__CollectionService__3 = game:GetService("CollectionService");
local l__RunService__4 = game:GetService("RunService");
local l__Players__5 = game:GetService("Players");
local l__Debris__6 = game:GetService("Debris");
local l__LocalPlayer__7 = l__Players__5.LocalPlayer;
local u1 = l__LocalPlayer__7:GetMouse();
local l__Mince__8 = require(l__ReplicatedStorage__2.Modules.Mince);
local u2 = l__Mince__8:Get("Settings");
local u3 = l__Mince__8:Get("Highlight");
local u4 = l__Mince__8:Get("BindManager");
local u5 = l__Mince__8:Get("ToolHandler");
local u6 = l__Mince__8:Get("SoundHandler");
local u7 = l__Mince__8:Get("SelectInteractor");
local u8 = l__Mince__8:GetEvent("PlaceDrink");
local u12 = {
    UsePreviewColorHighlight = true,
    Rotation = 0,
    PlacementsEnabled = true,
    PlacementsInternalUpdate = true,
    RotationSpeed = 12,
    LerpSpeed = 25,
    MaxDistance = 130,
    MaxCharacterDistance = 10,
    Colors = {
        Red = Color3.new(1, 0, 0),
        Green = Color3.new(0, 1, 0)
    },
    SurfaceParts = {},
    TargetRotation = CFrame.new(),
    PlacementRotation = CFrame.new(),
    CreatePreviewPart = function(p9, p10) --[[ Name: CreatePreviewPart, Line 54 ]]
        -- upvalues: l__Debris__6 (copy)
        local v11 = Instance.new("Part");
        v11.Transparency = 0.7 - math.random() * 0.5;
        v11.Material = Enum.Material.ForceField;
        v11.Anchored = true;
        v11.CFrame = p9;
        v11.Size = p10;
        v11.CanCollide = false;
        v11.CanTouch = false;
        v11.CanQuery = false;
        v11.Color = Color3.new(0.192157, 1, 0.596078);
        v11.Parent = game.Workspace;
        l__Debris__6:AddItem(v11, 0.1);
    end
};
function u12.SetPreviewColor(p13) --[[ Line: 72 ]]
    -- upvalues: u12 (copy)
    local l__ActivePreviewModel__9 = u12.ActivePreviewModel;
    if l__ActivePreviewModel__9 then
        if l__ActivePreviewModel__9.Color == p13 then
        else
            local v14 = u12.Colors[p13] or Color3.new(1, 1, 0);
            if u12.UsePreviewColorHighlight then
                u12.PreviewColorHighlight.Color = v14;
                u12.PreviewColorHighlight:Refresh();
                u12.PreviewColorHighlight:Set(l__ActivePreviewModel__9.Model);
            else
                for _, v15 in l__ActivePreviewModel__9.HighlightParts do
                    v15.Color = v14;
                end;
            end;
        end;
    end;
end;
function u12.GetPreview() --[[ Line: 91 ]]
    -- upvalues: u12 (copy), l__ReplicatedStorage__2 (copy), l__CollectionService__3 (copy)
    if u12.PlaceTool then
        if u12.ActivePreviewModel then
            if u12.ActivePreviewModel.Hidden then
                u12.ResetRotation();
            end;
            u12.ActivePreviewModel.Hidden = false;
            return u12.ActivePreviewModel;
        end;
        local u16 = {
            Color = "Default",
            Hidden = true,
            HighlightParts = {},
            Events = {},
            OverwriteDistance = u12.PlaceTool:GetAttribute("OverwriteDistance")
        };
        local function u19(p17) --[[ Line: 112 ]]
            -- upvalues: u16 (copy)
            for _, v18 in p17:GetTags() do
                p17:RemoveTag(v18);
            end;
            if p17:IsA("BasePart") then
                p17.Anchored = true;
                p17.CanCollide = false;
                p17.CanQuery = false;
                p17:SetAttribute("PlacedOntoPlatter", nil);
                if p17.Transparency < 1 then
                    p17.LocalTransparencyModifier = 0.5;
                    table.insert(u16.HighlightParts, p17);
                end;
            end;
        end;
        local function v27(p20) --[[ Line: 134 ]]
            -- upvalues: u12 (ref), u16 (copy), l__ReplicatedStorage__2 (ref), l__CollectionService__3 (ref), u19 (copy)
            if p20 or u12.ActivePreviewModel == u16 then
                u16.HighlightParts = {};
                if u16.Model then
                    u16.Model:Destroy();
                end;
                local v21 = u12.PlaceTool:GetAttribute("ReplicatedPlacement");
                if v21 then
                    u16.Model = l__ReplicatedStorage__2.Assets.Placements:FindFirstChild(v21);
                    if u16.Model then
                        u16.Model = u16.Model:Clone();
                    else
                        u16.Model = u12.PlaceTool:Clone();
                    end;
                else
                    u16.Model = u12.PlaceTool:Clone();
                end;
                l__CollectionService__3:RemoveTag(u16.Model, "PlaceSurface");
                u16.Model:PivotTo(CFrame.new(0, -10000, 0));
                local v22 = u16.Model:GetExtentsSize();
                local v23 = u16.Model:GetPivot();
                local v24 = u16.Model:FindFirstChild("Handle");
                u16.BoundingOffset = v22 * Vector3.new(0, 1, 0) * 0.5;
                u16.Offset = u16.BoundingOffset;
                u16.Size = u16.Model:GetAttribute("__PrecalcSize") or v22;
                u16.RotationOffset = u16.Model:GetAttribute("RotationOffset") or CFrame.Angles(0, 0, 0);
                u16.NormalAdd = u16.Model:GetAttribute("NormalAdd") or 0;
                u16.NormalValidate = u16.Model:GetAttribute("NormalValidate");
                if u16.Model:GetAttribute("SizeMult") then
                    local v25 = u16;
                    v25.Size = v25.Size * u16.Model:GetAttribute("SizeMult");
                end;
                if v24 then
                    v24 = v24:FindFirstChild(u16.Model:GetAttribute("PlaceAttachment") or "Place");
                end;
                if v24 then
                    u16.Offset = v23.Position - v24.WorldPosition;
                end;
                u19(u16.Model);
                for _, v26 in u16.Model:GetDescendants() do
                    u19(v26);
                end;
                u16.Model.Parent = u12.PlacementFolder;
                u12.GetNewestToolInformation();
                u12.TargetFloorCFrame = nil;
                u12.ResetRotation();
            end;
        end;
        v27(true);
        u12.ActivePreviewModel = u16;
        u16.Events.AttrChanged = u12.PlaceTool.AttributeChanged:Connect(v27);
        return u16;
    end;
end;
function u12.HidePreviewModel() --[[ Line: 199 ]]
    -- upvalues: u12 (copy)
    local v28 = u12.GetPreview();
    if v28 and not v28.Hidden then
        v28.Hidden = true;
        v28.Model:PivotTo(CFrame.new(0, -10000, 0));
        u12.TargetFloorCFrame = nil;
    end;
    if u12.PlacePreview then
        u12.PlacePreview.Position = Vector3.new(0, 0, 0);
    end;
end;
function u12.IsPreviewVisible() --[[ Line: 212 ]]
    -- upvalues: u12 (copy)
    if u12.ActivePreviewModel then
        return not u12.ActivePreviewModel.Hidden;
    end;
end;
function u12.DestroyPreviewModel() --[[ Line: 217 ]]
    -- upvalues: u12 (copy)
    local l__ActivePreviewModel__10 = u12.ActivePreviewModel;
    if l__ActivePreviewModel__10 then
        for _, v29 in l__ActivePreviewModel__10.Events do
            v29:Disconnect();
        end;
        l__ActivePreviewModel__10.Model:Destroy();
        u12.ActivePreviewModel = nil;
    end;
end;
function u12.Update(p30) --[[ Line: 229 ]]
    -- upvalues: u12 (copy), u7 (copy), u1 (copy), l__UserInputService__1 (copy), l__Mince__8 (copy), l__RunService__4 (copy)
    if u12.PlacementsInternalUpdate then
        u12.PlacementRotation = u12.PlacementRotation:Lerp(u12.TargetRotation, p30 * u12.RotationSpeed);
        if u12.ActivePreviewModel and not (u12.PlaceTool:GetAttribute("DontAllowPlace") or (u7.GetSelection() or (u7.IsInteractionActive() or u7.IsInvalidSelection()))) then
            local l__Position__11 = game.Workspace.Camera.CFrame.Position;
            Vector2.new(u1.X, u1.Y);
            local l__Unit__12 = (u1.Hit.Position - l__Position__11).Unit;
            if l__UserInputService__1.VREnabled and u7.RightHand then
                l__Unit__12 = -u7.RightHand.CFrame.UpVector;
                l__Position__11 = u7.RightHand.Position + 0.5 * l__Unit__12;
            end;
            local v31 = game.Workspace:Raycast(l__Position__11, l__Unit__12 * u12.MaxDistance, u12.SurfaceParams);
            if v31 then
                if v31 then
                    local v32;
                    if v31 then
                        v32 = v31.Position;
                    else
                        v32 = v31;
                    end;
                    local v33 = v31.Instance:GetAttribute("PlaceGroup") or "Default";
                    if (u12.PlaceGroup or v33) and not (u12.PlaceGroup and u12.PlaceGroup[v33 or "Default"]) then
                        return u12.HidePreviewModel();
                    end;
                    local v34 = u12.GetPreview();
                    if (l__Mince__8.Config.HumanoidRootPart.Position - v32).Magnitude > (v34.OverwriteDistance or u12.MaxCharacterDistance) then
                        return u12.HidePreviewModel();
                    end;
                    local v35 = CFrame.new(v32 + v34.Offset);
                    if u12.TargetFloorCFrame then
                        u12.TargetFloorCFrame = u12.TargetFloorCFrame:Lerp(v35, p30 * u12.LerpSpeed);
                    else
                        u12.TargetFloorCFrame = v35;
                    end;
                    local l__TargetFloorCFrame__13 = u12.TargetFloorCFrame;
                    local v36;
                    if v31.Instance:GetAttribute("ApplyNormal") then
                        v36 = l__TargetFloorCFrame__13 * (CFrame.new(Vector3.new(0, 0, 0), v31.Normal).Rotation * CFrame.Angles(-1.5707963267948966, 0, 0));
                    else
                        local _, v37, _ = (CFrame.new(Vector3.new(0, 0, 0), v31.Normal).Rotation * CFrame.Angles(-1.5707963267948966, 0, 0)):ToEulerAnglesXYZ();
                        v36 = l__TargetFloorCFrame__13 * CFrame.fromEulerAnglesXYZ(0, v37, 0);
                    end;
                    if not u12.PlaceTool:GetAttribute("DisableRotation") then
                        v36 = v36 * u12.PlacementRotation;
                    end;
                    if v31.Instance:GetAttribute("ApplyRotation") then
                        v36 = v36 * v31.Instance.CFrame.Rotation;
                    end;
                    if v34.RotationOffset then
                        v36 = v36 * v34.RotationOffset;
                    end;
                    if v34.NormalAdd and v31 then
                        v36 = v36 + v31.Normal * v34.NormalAdd;
                    end;
                    local v38 = v31.Instance.Parent:IsA("Tool") and v31.Instance.Parent or v31.Instance;
                    if (v31.Instance:GetAttribute("IsPlatter") or v38:GetAttribute("PlacedOntoPlatter")) and u12.PlaceTool:GetAttribute("CannotPlaceOnPlatter") then
                        return u12.HidePreviewModel();
                    end;
                    u12.PlacePosition = v36;
                    u12.SurfaceTarget = v31.Instance;
                    local v39 = v36 + (v34.BoundingOffset + Vector3.new(0, 0.1, 0));
                    if v34.NormalValidate then
                        v39 = v36 + v31.Normal * v34.NormalValidate;
                    end;
                    local v40 = game.Workspace:GetPartBoundsInBox(v39, v34.Size, u12.OverlapExclude);
                    if v34.Size.Magnitude > 20 and l__RunService__4:IsStudio() then
                        u12.CreatePreviewPart(v39, v34.Size);
                    end;
                    if l__RunService__4:IsStudio() then
                        u12.PlacePreview.Size = v34.Size;
                        u12.PlacePreview.CFrame = v39;
                    end;
                    for v41 = #v40, 1, -1 do
                        local v42 = v40[v41];
                        if v42.Transparency == 1 or (v42.CollisionGroup == "Players" or (v42.Name == "IGNORE_PLACE" or (v42:GetAttribute("IGNORE_PLACE") or v42.Parent and v42.Parent:GetAttribute("IGNORE_PLACE")))) then
                            table.remove(v40, v41);
                        elseif l__RunService__4:IsStudio() then
                            warn(`BlockingPart->{v42:GetFullName()}`, v42);
                        end;
                    end;
                    u12.SetPreviewColor(#v40 == 0 and "Green" or "Red");
                    u12.PlacingValid = #v40 == 0;
                    if not u12.PlacingValid and l__RunService__4:IsStudio() then
                        for _, v43 in v40 do
                            if v43.Size.Magnitude > 100 then
                                warn("--->", v43, ":", v43:GetFullName());
                            end;
                        end;
                        u12.ObstructHighlight:Set(v40);
                        u12.ObstructHighlight:Expire(2);
                    end;
                    v34.Model:PivotTo(v36);
                end;
            else
                u12.HidePreviewModel();
            end;
        else
            return u12.HidePreviewModel();
        end;
    end;
end;
function u12.Lock(p44) --[[ Line: 368 ]]
    -- upvalues: u12 (copy)
    if u12.PlacementsInternalUpdate then
        u12.PlacementsInternalUpdate = false;
        task.delay(p44, function() --[[ Line: 371 ]]
            -- upvalues: u12 (ref)
            u12.PlacementsInternalUpdate = true;
        end);
    end;
end;
function u12.Interact() --[[ Line: 377 ]]
    -- upvalues: u12 (copy), l__Mince__8 (copy), u6 (copy), u8 (copy)
    if not u12.IsPreviewVisible() or (not u12.PlacementsEnabled or (not u12.PlacingValid or u12.PlaceTool and u12.PlaceTool:GetAttribute("DontAllowPlace"))) then
        return "Pass";
    end;
    local v45 = l__Mince__8.Config.Recipes[u12.PlaceTool:GetAttribute("Recipe")];
    local v46;
    if v45 then
        v46 = v45.PlaceSound;
    else
        v46 = nil;
    end;
    local v47 = u12.PlaceTool:GetAttribute("PlaceSound") or v46;
    u6.PlaySound(v47 or "PlaceSound");
    u12.HidePreviewModel();
    u12.Lock(0.1);
    u8:Fire(u12.PlacePosition, u12.SurfaceTarget);
    return "Sink";
end;
function u12.GetNewestToolInformation() --[[ Line: 398 ]]
    -- upvalues: u12 (copy)
    u12.PlaceGroup = nil;
    if u12.PlaceTool then
        local v48 = u12.PlaceTool:GetAttribute("PlaceGroup") or "Default";
        if not v48 then
            return;
        end;
        local v49 = {};
        for _, v50 in string.split(v48, ",") do
            v49[v50] = true;
        end;
        u12.PlaceGroup = next(v49) and v49 and v49 or nil;
    end;
end;
function u12.PlaceToolUnequipped() --[[ Line: 413 ]]
    -- upvalues: u12 (copy), u4 (copy)
    u12.PlaceTool = nil;
    u12.PlaceGroup = nil;
    u12.PlacingEnabled = false;
    u12.TargetFloorCFrame = nil;
    u12.DestroyPreviewModel();
    u12.GetNewestToolInformation();
    u4.SetMobileBindButtonsEnabled("Rotate", false);
end;
function u12.PlaceToolEquipped(p51) --[[ Line: 423 ]]
    -- upvalues: u12 (copy), u4 (copy)
    u12.PlacingEnabled = true;
    u12.PlaceTool = p51;
    u12.GetNewestToolInformation();
    u12.TargetFloorCFrame = nil;
    u12.GetPreview();
    u4.SetMobileBindButtonsEnabled("Rotate", true);
end;
function u12.SetupPlaceTool() --[[ Line: 432 ]]
    -- upvalues: u5 (copy), u12 (copy)
    local v52 = u5.TagEquipped({ "PlaceableTool" });
    v52.Equipped:Connect(u12.PlaceToolEquipped);
    v52.Unequipped:Connect(u12.PlaceToolUnequipped);
end;
function u12.ResetRotation() --[[ Line: 438 ]]
    -- upvalues: u12 (copy)
    u12.Rotation = 0;
    u12.TargetRotation = CFrame.Angles(0, math.rad(u12.Rotation * 90), 0);
    u12.PlacementRotation = u12.TargetRotation;
end;
function u12.RotateBind(p53) --[[ Line: 445 ]]
    -- upvalues: u12 (copy)
    if u12.IsPreviewVisible() then
        if p53 == Enum.UserInputState.Begin then
            local v54 = u12;
            v54.Rotation = v54.Rotation + 1;
            if u12.Rotation > 3 then
                u12.Rotation = 0;
            end;
            u12.TargetRotation = CFrame.Angles(0, math.rad(u12.Rotation * 90), 0);
        end;
    end;
end;
function u12.RemovePlaceSurface(p55) --[[ Line: 459 ]]
    -- upvalues: u12 (copy)
    local v56 = table.find(u12.SurfaceParts, p55);
    if v56 then
        table.remove(u12.SurfaceParts, v56);
    end;
    u12.SurfaceParams.FilterDescendantsInstances = u12.SurfaceParts;
end;
function u12.AddPlaceSurface(u57) --[[ Line: 466 ]]
    -- upvalues: u12 (copy)
    u57.Destroying:Connect(function() --[[ Line: 467 ]]
        -- upvalues: u12 (ref), u57 (copy)
        u12.RemovePlaceSurface(u57);
    end);
    table.insert(u12.SurfaceParts, u57);
    u12.SurfaceParams.FilterDescendantsInstances = u12.SurfaceParts;
end;
function u12.Init() --[[ Line: 475 ]]
    -- upvalues: u12 (copy), u3 (copy)
    local v58 = Instance.new("Part");
    v58.CanCollide = false;
    v58.CanQuery = false;
    v58.CanTouch = false;
    v58.Transparency = 0.5;
    v58.Anchored = true;
    v58.Color = Color3.new(0, 1, 0);
    v58.Parent = game.Workspace;
    u12.PlacePreview = v58;
    local v59 = OverlapParams.new();
    v59.FilterType = Enum.RaycastFilterType.Exclude;
    v59.MaxParts = 3;
    v59.CollisionGroup = "Default";
    u12.OverlapExclude = v59;
    local v60 = RaycastParams.new();
    v60.FilterType = Enum.RaycastFilterType.Include;
    u12.SurfaceParams = v60;
    local v61 = Instance.new("Folder");
    v61.Name = "Placements";
    v61.Parent = game.Workspace;
    u12.PlacementFolder = v61;
    u12.ExcludedParts = { u12.PlacementFolder };
    v59.FilterDescendantsInstances = u12.ExcludedParts;
    u12.PreviewColorHighlight = u3.newSet({
        ClearLast = true,
        DoesFlash = false,
        HasOutline = false,
        Color = Color3.new(1, 0, 0)
    });
    u12.ObstructHighlight = u3.newSet({
        ClearLast = false,
        Color = Color3.new(1, 0, 0)
    });
end;
function u12.Setup() --[[ Line: 520 ]]
    -- upvalues: u12 (copy), u2 (copy), l__Mince__8 (copy), l__LocalPlayer__7 (copy), u7 (copy), u4 (copy), l__RunService__4 (copy)
    u12.Init();
    u12.SetupPlaceTool();
    u2.SettingChanged("Placements"):Connect(function(p62) --[[ Line: 524 ]]
        -- upvalues: u12 (ref)
        u12.PlacementsEnabled = p62;
    end);
    l__Mince__8.SetupComponent("PlacementIgnore", function(p63) --[[ Line: 528 ]]
        -- upvalues: u12 (ref)
        table.insert(u12.ExcludedParts, p63.Instance);
        u12.OverlapExclude.FilterDescendantsInstances = u12.ExcludedParts;
    end);
    l__LocalPlayer__7.CharacterAdded:Connect(u12.PlaceToolUnequipped);
    u7.BindToInteract(10, u12.Interact);
    u4.Get("Rotate").OnAction:Connect(u12.RotateBind);
    l__RunService__4.Heartbeat:Connect(u12.Update);
end;
return u12;
