-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Legacy.ToolEquippedDeprecated.Teleporter
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__LocalPlayer__3 = game:GetService("Players").LocalPlayer;
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Effect__5 = require(l__ReplicatedStorage__1.Modules.Effect);
local u1 = l__Mince__4:Get("ToolHandler");
local u2 = l__Mince__4:Get("SeatHandler");
local u3 = l__Mince__4:Get("WorldCulling");
local u4 = l__Mince__4:Get("SoundHandler");
local u5 = l__Mince__4:Get("InterfaceHandler");
local u6 = l__Mince__4:Get("SelectInteractor");
local u7 = l__Mince__4:Get("Settings");
local v8 = l__Mince__4:GetEvent("Teleporter");
local u9 = v8:Extend("Use");
local u10 = v8:Extend("Effect");
local u11 = {
    LoadedAnimations = {},
    PossiblePositions = {
        { 0.2, Vector3.new(397.149, 6.634, -341.001), "Rift\'s Courtyard" },
        { 0.2, Vector3.new(391.258, 8.968, -48.04), "Main Bar" },
        { 0.2, Vector3.new(497.086, 6.273, -88.691), "Aquarium" },
        { 0.2, Vector3.new(77.831, 14.381, -136.527), "Waterfall" },
        { 0.1, Vector3.new(-178.142, 7.036, 79.703), "Minecraft" },
        { 0.05, Vector3.new(-418.946, 89.708, -70.523), "Rooftop" }
    },
    Random = Random.new()
};
function tapered(p12)
    local v13 = 0.5 - math.abs(p12 - 0.5);
    local v14 = math.min(v13, 0.5);
    return math.max(0, v14);
end;
function wobbletapered(p15, p16)
    return tapered(p15) * math.sin(p15 * (p16 or 7));
end;
function TeleportPlayerToGroundPosition(p17, p18)
    local v19 = p17:FindFirstChild("Humanoid");
    if v19 then
        local v20 = v19.SeatPart and v19.SeatPart:FindFirstChild("SeatWeld");
        if v20 then
            v20:Destroy();
        end;
        v19.Sit = false;
        p17:PivotTo(CFrame.new(p18 + Vector3.new(0, 1, 0) * v19.HipHeight));
    end;
end;
function u11.CreatePart(p21, p22) --[[ Line: 69 ]]
    local v23 = Instance.new("Part");
    v23.Name = "ParticleSource";
    v23.Transparency = 1;
    v23.Anchored = true;
    v23.CanCollide = false;
    v23.CanQuery = false;
    v23.CanTouch = false;
    v23.Size = Vector3.new(0.2, 0.2, 0.2);
    v23.Position = p21;
    v23.Parent = game.Workspace;
    game:GetService("Debris"):AddItem(v23, p22 or 20);
    return v23;
end;
function u11.Reject(u24) --[[ Line: 86 ]]
    -- upvalues: u11 (copy)
    u11.AnimationActive = true;
    u11.Animations.Press:Play();
    u11.Animations.Press.Stopped:Wait();
    pcall(function() --[[ Line: 93 ]]
        -- upvalues: u24 (copy)
        u24.Handle.Reject:Play();
    end);
    task.wait(1);
    u11.AnimationActive = false;
end;
function u11.SyncToCursor() --[[ Line: 102 ]]
    -- upvalues: u11 (copy)
    local v25 = u11.PossiblePositions[u11.Cursor];
    u11.NextLocation = v25;
    u11.TeleportUI.Main.Container.ActiveTeleport.TextLabel.Text = v25[3];
end;
function u11.SetNextDeterministicTeleportLocation() --[[ Line: 109 ]]
    -- upvalues: u11 (copy)
    u11.Cursor = math.random(1, #u11.PossiblePositions);
    u11.SyncToCursor();
end;
function u11.UseTool(p26) --[[ Line: 115 ]]
    -- upvalues: u11 (copy), l__Mince__4 (copy), u4 (copy), u9 (copy)
    if u11.QuickDebounce then
    elseif l__Mince__4.Config.Humanoid then
        if l__Mince__4.Config.HumanoidRootPart then
            if u11.AnimationActive then
            elseif l__Mince__4.Config.Humanoid.SeatPart then
                u11.Reject(p26);
            elseif p26:GetAttribute("Uses") >= p26:GetAttribute("MaxUses") then
                u11.Reject(p26);
            else
                u11.QuickDebounce = true;
                u4.StopAllTracks();
                task.delay(5, function() --[[ Line: 126 ]]
                    -- upvalues: u11 (ref)
                    u11.QuickDebounce = false;
                end);
                u11.SitCase:Set(false);
                local l__Animations__6 = u11.Animations;
                l__Animations__6.Press:Play();
                l__Animations__6.Press.Stopped:Wait();
                local v27 = p26:GetAttribute("MaxUses");
                local v28 = p26:GetAttribute("Uses") / v27;
                local v29 = math.abs(v28);
                u11.Cover.Fill.Size = UDim2.fromScale(v29, 1);
                u11.LastAnimations = u11.Animations;
                u9:Fire("Teleport", u11.NextLocation[2]);
            end;
        end;
    end;
end;
function u11.LocalAnimation(u30, u31, u32) --[[ Line: 148 ]]
    -- upvalues: l__LocalPlayer__3 (copy), u11 (copy), u3 (copy), l__Effect__5 (copy), l__ReplicatedStorage__1 (copy), u6 (copy), u4 (copy), l__RunService__2 (copy), u7 (copy)
    local l__Character__7 = l__LocalPlayer__3.Character;
    if l__Character__7 then
        u31:PivotTo((l__Character__7:GetPivot()));
        local l__CurrentCamera__8 = game.Workspace.CurrentCamera;
        local l__HumanoidRootPart__9 = u31.HumanoidRootPart;
        local u33 = l__Character__7:FindFirstChild("HumanoidRootPart");
        if u33 then
            u11.LocalAnimationActive = true;
            u3.SetRenderFocus(u32);
            local function v34() --[[ Line: 164 ]]
                -- upvalues: l__Effect__5 (ref), l__ReplicatedStorage__1 (ref), u31 (copy)
                l__Effect__5.new(l__ReplicatedStorage__1.Assets.Particles.Groups.TeleportRings, u31.UpperTorso):PlayThenDestroy();
            end;
            local function v35() --[[ Line: 167 ]]
                -- upvalues: l__Effect__5 (ref), l__ReplicatedStorage__1 (ref), u31 (copy)
                l__Effect__5.new(l__ReplicatedStorage__1.Assets.Particles.Groups.TeleportGlow, u31.UpperTorso.Position):PlayThenDestroy();
            end;
            u30.Start:GetMarkerReachedSignal("Rings"):Connect(v34);
            u30.Start:GetMarkerReachedSignal("Explode"):Connect(v35);
            u30.End:GetMarkerReachedSignal("Explode"):Connect(v35);
            u11.AnimationActive = true;
            u6.StartInteractions();
            local u36 = CFrame.new(l__HumanoidRootPart__9.Position):ToObjectSpace(l__CurrentCamera__8.CFrame);
            l__CurrentCamera__8.CameraType = Enum.CameraType.Scriptable;
            u4.PlaySound("Teleport.Out");
            u30.Start:Play();
            l__HumanoidRootPart__9.Anchored = true;
            u33.Anchored = true;
            u30.End.Stopped:Connect(function() --[[ Line: 195 ]]
                -- upvalues: u31 (copy), u3 (ref), l__Character__7 (copy), u32 (copy), u33 (copy), u11 (ref)
                u31:Destroy();
                u3.SetRenderFocus(nil);
                TeleportPlayerToGroundPosition(l__Character__7, u32);
                u33.Anchored = false;
                for _, v37 in l__Character__7:GetDescendants() do
                    if v37:IsA("BasePart") or v37:IsA("Decal") then
                        v37.LocalTransparencyModifier = 0;
                    end;
                end;
                task.wait(0.5);
                u11.SitCase:Set(true);
            end);
            local u38 = {};
            local u39 = false;
            local u40 = 0;
            local u41 = 0;
            local u42 = 0;
            local u43 = nil;
            u43 = l__RunService__2.RenderStepped:Connect(function(p44) --[[ Line: 218 ]]
                -- upvalues: u41 (ref), u11 (ref), u38 (copy), u39 (ref), l__Character__7 (copy), u32 (copy), u31 (copy), u40 (ref), u4 (ref), u30 (copy), u42 (ref), l__HumanoidRootPart__9 (copy), u36 (copy), u7 (ref), l__CurrentCamera__8 (copy), u6 (ref), u43 (ref)
                local v45 = u41 / 4;
                local v46 = 1;
                local v47 = 0.5 - v45;
                if v45 <= 0.5 then
                    if v47 < 0.2 then
                        v46 = v47 / 0.2;
                    end;
                    if v47 < 0.1 then
                        u11.MainPriority.Flashbang.BackgroundTransparency = v47 / 0.1;
                    end;
                end;
                if v47 < 0 and not u38.Counted2 then
                    u38.Counted2 = true;
                    u39 = true;
                    u11.SetNextDeterministicTeleportLocation();
                    u11.MainPriority.Flashbang.BackgroundTransparency = 0;
                    TeleportPlayerToGroundPosition(l__Character__7, u32);
                    TeleportPlayerToGroundPosition(u31, u32);
                end;
                if u39 and u40 <= 1 then
                    u40 = u40 + p44;
                else
                    if u39 and not u38.Counted1 then
                        u38.Counted1 = true;
                        u4.PlaySound("Teleport.In");
                        u30.End:Play();
                    end;
                    u41 = u41 + p44;
                    local v48 = u41 / 4;
                    local v49 = wobbletapered(v48, 25);
                    u42 = u42 + u41 * 6 * tapered(v48);
                    if u39 then
                        u11.MainPriority.Flashbang.BackgroundTransparency = 1 - wobbletapered(v48 - 0.05, 25.5);
                    end;
                    local v50 = (CFrame.new(l__HumanoidRootPart__9.Position) * CFrame.Angles(0, math.rad(u42), 0)):ToWorldSpace(u36) * CFrame.new(0, 0, 0, v46, 0, 0, v49 * 2, 1, 0, 0, 0, 1);
                    if not u7.GetValue("NoMotion") then
                        l__CurrentCamera__8.CFrame = v50;
                    end;
                    if u41 > 4 or not l__HumanoidRootPart__9.Parent then
                        u6.EndInteractions();
                        u11.AnimationActive = false;
                        u11.MainPriority.Flashbang.BackgroundTransparency = 1;
                        u11.LocalAnimationActive = false;
                        l__CurrentCamera__8.CameraType = Enum.CameraType.Custom;
                        u43:Disconnect();
                    end;
                end;
            end);
        end;
    end;
end;
function u11.Animation(p51, p52, u53) --[[ Line: 295 ]]
    -- upvalues: l__LocalPlayer__3 (copy), u11 (copy), u4 (copy), l__Effect__5 (copy), l__ReplicatedStorage__1 (copy)
    local l__Character__10 = l__LocalPlayer__3.Character;
    local l__Character__11 = p51.Character;
    local v54 = l__Character__11:FindFirstChild("Humanoid");
    if l__Character__10 and l__Character__11 then
        local u55 = script.Base:Clone();
        u55.Parent = game.Workspace;
        local l__Humanoid__12 = u55:WaitForChild("Humanoid");
        l__Humanoid__12:ApplyDescription(v54:GetAppliedDescription());
        local u56 = {};
        for _, v57 in script.Animations:GetChildren() do
            local v58 = l__Humanoid__12.Animator:LoadAnimation(v57);
            if v58:GetAttribute("Speed") then
                v58:AdjustSpeed(v58:GetAttribute("Speed"));
            end;
            u56[v57.Name] = v58;
        end;
        for _, v59 in l__Character__11:GetDescendants() do
            if v59:IsA("BasePart") or v59:IsA("Decal") then
                v59.LocalTransparencyModifier = 1;
            end;
        end;
        if p51 == l__LocalPlayer__3 then
            task.spawn(function() --[[ Line: 329 ]]
                -- upvalues: u11 (ref), u56 (copy), u55 (copy), u53 (copy)
                u11.LocalAnimation(u56, u55, u53);
            end);
        else
            u55:PivotTo(p52);
            u4.PlaySoundAt("Teleport.Out", u11.CreatePart(u55.HumanoidRootPart.Position), { 5, 35 });
            local function v60() --[[ Line: 342 ]]
                -- upvalues: l__Effect__5 (ref), l__ReplicatedStorage__1 (ref), u55 (copy)
                l__Effect__5.new(l__ReplicatedStorage__1.Assets.Particles.Groups.TeleportRings, u55.UpperTorso):PlayThenDestroy();
            end;
            local function v61() --[[ Line: 345 ]]
                -- upvalues: l__Effect__5 (ref), l__ReplicatedStorage__1 (ref), u55 (copy)
                l__Effect__5.new(l__ReplicatedStorage__1.Assets.Particles.Groups.TeleportGlow, u55.UpperTorso.Position):PlayThenDestroy();
            end;
            u56.Start:GetMarkerReachedSignal("Rings"):Connect(v60);
            u56.Start:GetMarkerReachedSignal("Explode"):Connect(v61);
            u56.End:GetMarkerReachedSignal("Explode"):Connect(v61);
            u56.End.Stopped:Connect(function() --[[ Line: 352 ]]
                -- upvalues: u55 (copy)
                u55:Destroy();
            end);
            u56.Start:Play();
            u56.Start.Stopped:Wait();
            TeleportPlayerToGroundPosition(u55, Vector3.new(-0, -20, -0));
            task.wait(1);
            TeleportPlayerToGroundPosition(u55, u53);
            u4.PlaySoundAt("Teleport.In", u11.CreatePart(u55.HumanoidRootPart.Position), { 5, 35 });
            u56.End:Play();
            u56.End.Stopped:Wait();
            for _, v62 in l__Character__11:GetDescendants() do
                if v62:IsA("BasePart") or v62:IsA("Decal") then
                    v62.LocalTransparencyModifier = 0;
                end;
            end;
        end;
    end;
end;
function u11.StartTool(p63) --[[ Line: 377 ]]
    -- upvalues: u11 (copy), l__Mince__4 (copy)
    u11.IsEquipped = true;
    u11.ThisTool = p63;
    u11.Cover = p63:WaitForChild("Cover");
    u11.Light = p63:WaitForChild("Light");
    u11.TeleportUI.Enabled = true;
    u11.Light.Transparency = 0;
    local v64 = p63:GetAttribute("MaxUses");
    local v65 = p63:GetAttribute("Uses") / v64;
    local v66 = math.abs(v65);
    u11.Cover.Fill.Size = UDim2.fromScale(v66, 1);
    u11.Animations = {};
    if l__Mince__4.Config.Humanoid then
        if p63:FindFirstChild("Animations") then
            for _, v67 in p63.Animations:GetChildren() do
                local v68 = l__Mince__4.Config.Humanoid.Animator:LoadAnimation(v67);
                if v68:GetAttribute("Speed") then
                    v68:AdjustSpeed(v68:GetAttribute("Speed"));
                end;
                u11.Animations[v67.Name] = v68;
            end;
        end;
    end;
end;
function u11.EndTool() --[[ Line: 406 ]]
    -- upvalues: u11 (copy)
    u11.TeleportUI.Enabled = false;
    u11.IsEquipped = false;
    u11.Animations = nil;
end;
function u11.Setup() --[[ Line: 412 ]]
    -- upvalues: u11 (copy), u2 (copy), u1 (copy), u5 (copy), u4 (copy), l__LocalPlayer__3 (copy), u6 (copy), u10 (copy)
    u11.SitCase = u2.CanSitCase:Extend();
    local v69 = u1.TagEquipped({ "Teleporter" });
    v69.Equipped:Connect(u11.StartTool);
    v69.Unequipped:Connect(u11.EndTool);
    u11.MainPriority = u5.GetScreenGui("MainPriority");
    u11.TeleportUI = u5.GetScreenGui("TeleportUI");
    u5.NewButton(u11.TeleportUI.Main.Container.LeftArrowButton).Activated:Connect(function() --[[ Line: 423 ]]
        -- upvalues: u11 (ref), u4 (ref)
        if u11.LocalAnimationActive then
            u4.PlaySound("block_interact");
        else
            local v70 = u11;
            v70.Cursor = v70.Cursor + 1;
            if u11.Cursor > #u11.PossiblePositions then
                u11.Cursor = 1;
            end;
            u11.SyncToCursor();
        end;
    end);
    u5.NewButton(u11.TeleportUI.Main.Container.RightArrowButton).Activated:Connect(function() --[[ Line: 436 ]]
        -- upvalues: u11 (ref), u4 (ref)
        if u11.LocalAnimationActive then
            u4.PlaySound("block_interact");
        else
            local v71 = u11;
            v71.Cursor = v71.Cursor - 1;
            if u11.Cursor < 1 then
                u11.Cursor = #u11.PossiblePositions;
            end;
            u11.SyncToCursor();
        end;
    end);
    u11.SetNextDeterministicTeleportLocation();
    l__LocalPlayer__3.CharacterAdded:Connect(function() --[[ Line: 453 ]]
        -- upvalues: u11 (ref)
        u11.SitCase:Set(true);
    end);
    u6.BindToInteract(150, function() --[[ Line: 457 ]]
        -- upvalues: u11 (ref)
        if not u11.IsEquipped then
            return "Pass";
        end;
        u11.UseTool(u11.ThisTool);
        return "Sink";
    end);
    u10.Event:Connect(function(p72, p73, p74) --[[ Line: 464 ]]
        -- upvalues: u11 (ref)
        u11.Animation(p72, p73, p74);
    end);
end;
return u11;
