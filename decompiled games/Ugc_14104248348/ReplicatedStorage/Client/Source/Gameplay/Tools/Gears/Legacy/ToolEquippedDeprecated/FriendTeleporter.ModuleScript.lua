-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Legacy.ToolEquippedDeprecated.FriendTeleporter
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__LocalPlayer__3 = game:GetService("Players").LocalPlayer;
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Effect__5 = require(l__ReplicatedStorage__1.Modules.Effect);
local u1 = l__Mince__4:Get("PlayerList");
local u2 = l__Mince__4:Get("ToolHandler");
local u3 = l__Mince__4:Get("SeatHandler");
local u4 = l__Mince__4:Get("WorldCulling");
local u5 = l__Mince__4:Get("SoundHandler");
local u6 = l__Mince__4:Get("InterfaceHandler");
local u7 = l__Mince__4:Get("SelectInteractor");
local u8 = l__Mince__4:Get("Settings");
local v9 = l__Mince__4:GetEvent("Teleporter");
local u10 = v9:Extend("Use");
local u11 = v9:Extend("Effect");
local u12 = {
    LoadedAnimations = {},
    Random = Random.new()
};
function tapered(p13)
    local v14 = 0.5 - math.abs(p13 - 0.5);
    local v15 = math.min(v14, 0.5);
    return math.max(0, v15);
end;
function wobbletapered(p16, p17)
    return tapered(p16) * math.sin(p16 * (p17 or 7));
end;
function TeleportPlayerToGroundPosition(p18, p19)
    local v20 = p18:FindFirstChild("Humanoid");
    if v20 then
        local v21 = v20.SeatPart and v20.SeatPart:FindFirstChild("SeatWeld");
        if v21 then
            v21:Destroy();
        end;
        v20.Sit = false;
        p18:PivotTo(CFrame.new(p19 + Vector3.new(0, 1, 0) * v20.HipHeight));
    end;
end;
function u12.CreatePart(p22, p23) --[[ Line: 57 ]]
    local v24 = Instance.new("Part");
    v24.Name = "ParticleSource";
    v24.Transparency = 1;
    v24.Anchored = true;
    v24.CanCollide = false;
    v24.CanQuery = false;
    v24.CanTouch = false;
    v24.Size = Vector3.new(0.2, 0.2, 0.2);
    v24.Position = p22;
    v24.Parent = game.Workspace;
    game:GetService("Debris"):AddItem(v24, p23 or 20);
    return v24;
end;
function u12.Reject(u25) --[[ Line: 74 ]]
    -- upvalues: u12 (copy)
    u12.AnimationActive = true;
    u12.Animations.Press:Play();
    u12.Animations.Press.Stopped:Wait();
    pcall(function() --[[ Line: 81 ]]
        -- upvalues: u25 (copy)
        u25.Handle.Reject:Play();
    end);
    task.wait(1);
    u12.AnimationActive = false;
end;
function u12.DoTeleporting(p26, p27) --[[ Line: 90 ]]
    -- upvalues: u12 (copy), l__Mince__4 (copy), u5 (copy), u10 (copy)
    local l__Character__6 = p27.Character;
    if l__Character__6 then
        l__Character__6 = p27.Character:FindFirstChild("HumanoidRootPart");
    end;
    if l__Character__6 then
        if u12.QuickDebounce then
        elseif l__Mince__4.Config.Humanoid then
            if l__Mince__4.Config.HumanoidRootPart then
                if u12.AnimationActive then
                elseif l__Mince__4.Config.Humanoid.SeatPart then
                    u12.Reject(p26);
                elseif p26:GetAttribute("Uses") >= p26:GetAttribute("MaxUses") then
                    u12.Reject(p26);
                else
                    u12.QuickDebounce = true;
                    u5.StopAllTracks();
                    task.delay(5, function() --[[ Line: 103 ]]
                        -- upvalues: u12 (ref)
                        u12.QuickDebounce = false;
                    end);
                    u12.SitCase:Set(false);
                    local l__Animations__7 = u12.Animations;
                    l__Animations__7.Press:Play();
                    l__Animations__7.Press.Stopped:Wait();
                    u12.LastAnimations = u12.Animations;
                    u10:Fire("Teleport", l__Character__6.Position);
                end;
            end;
        end;
    end;
end;
function u12.LocalAnimation(u28, u29, u30) --[[ Line: 120 ]]
    -- upvalues: l__LocalPlayer__3 (copy), u12 (copy), u4 (copy), l__Effect__5 (copy), l__ReplicatedStorage__1 (copy), u7 (copy), u5 (copy), l__RunService__2 (copy), u8 (copy)
    local l__Character__8 = l__LocalPlayer__3.Character;
    if l__Character__8 then
        u29:PivotTo((l__Character__8:GetPivot()));
        local l__CurrentCamera__9 = game.Workspace.CurrentCamera;
        local l__HumanoidRootPart__10 = u29.HumanoidRootPart;
        local u31 = l__Character__8:FindFirstChild("HumanoidRootPart");
        if u31 then
            u12.LocalAnimationActive = true;
            u4.SetRenderFocus(u30);
            local function v32() --[[ Line: 136 ]]
                -- upvalues: l__Effect__5 (ref), l__ReplicatedStorage__1 (ref), u29 (copy)
                l__Effect__5.new(l__ReplicatedStorage__1.Assets.Particles.Groups.TeleportRings, u29.UpperTorso):PlayThenDestroy();
            end;
            local function v33() --[[ Line: 139 ]]
                -- upvalues: l__Effect__5 (ref), l__ReplicatedStorage__1 (ref), u29 (copy)
                l__Effect__5.new(l__ReplicatedStorage__1.Assets.Particles.Groups.TeleportGlow, u29.UpperTorso.Position):PlayThenDestroy();
            end;
            u28.Start:GetMarkerReachedSignal("Rings"):Connect(v32);
            u28.Start:GetMarkerReachedSignal("Explode"):Connect(v33);
            u28.End:GetMarkerReachedSignal("Explode"):Connect(v33);
            u12.AnimationActive = true;
            u7.StartInteractions();
            local u34 = CFrame.new(l__HumanoidRootPart__10.Position):ToObjectSpace(l__CurrentCamera__9.CFrame);
            l__CurrentCamera__9.CameraType = Enum.CameraType.Scriptable;
            u5.PlaySound("Teleport.Out");
            u28.Start:Play();
            l__HumanoidRootPart__10.Anchored = true;
            u31.Anchored = true;
            u28.End.Stopped:Connect(function() --[[ Line: 167 ]]
                -- upvalues: u29 (copy), u4 (ref), l__Character__8 (copy), u30 (copy), u31 (copy), u12 (ref)
                u29:Destroy();
                u4.SetRenderFocus(nil);
                TeleportPlayerToGroundPosition(l__Character__8, u30);
                u31.Anchored = false;
                for _, v35 in l__Character__8:GetDescendants() do
                    if v35:IsA("BasePart") or v35:IsA("Decal") then
                        v35.LocalTransparencyModifier = 0;
                    end;
                end;
                task.wait(0.5);
                u12.SitCase:Set(true);
            end);
            local u36 = {};
            local u37 = false;
            local u38 = 0;
            local u39 = 0;
            local u40 = 0;
            local u41 = nil;
            u41 = l__RunService__2.RenderStepped:Connect(function(p42) --[[ Line: 190 ]]
                -- upvalues: u39 (ref), u12 (ref), u36 (copy), u37 (ref), l__Character__8 (copy), u30 (copy), u29 (copy), u38 (ref), u5 (ref), u28 (copy), u40 (ref), l__HumanoidRootPart__10 (copy), u34 (copy), u8 (ref), l__CurrentCamera__9 (copy), u7 (ref), u41 (ref)
                local v43 = u39 / 4;
                local v44 = 1;
                local v45 = 0.5 - v43;
                if v43 <= 0.5 then
                    if v45 < 0.2 then
                        v44 = v45 / 0.2;
                    end;
                    if v45 < 0.1 then
                        u12.MainPriority.Flashbang.BackgroundTransparency = v45 / 0.1;
                    end;
                end;
                if v45 < 0 and not u36.Counted2 then
                    u36.Counted2 = true;
                    u37 = true;
                    u12.MainPriority.Flashbang.BackgroundTransparency = 0;
                    TeleportPlayerToGroundPosition(l__Character__8, u30);
                    TeleportPlayerToGroundPosition(u29, u30);
                end;
                if u37 and u38 <= 1 then
                    u38 = u38 + p42;
                else
                    if u37 and not u36.Counted1 then
                        u36.Counted1 = true;
                        u5.PlaySound("Teleport.In");
                        u28.End:Play();
                    end;
                    u39 = u39 + p42;
                    local v46 = u39 / 4;
                    local v47 = wobbletapered(v46, 25);
                    u40 = u40 + u39 * 6 * tapered(v46);
                    if u37 then
                        u12.MainPriority.Flashbang.BackgroundTransparency = 1 - wobbletapered(v46 - 0.05, 25.5);
                    end;
                    local v48 = (CFrame.new(l__HumanoidRootPart__10.Position) * CFrame.Angles(0, math.rad(u40), 0)):ToWorldSpace(u34) * CFrame.new(0, 0, 0, v44, 0, 0, v47 * 2, 1, 0, 0, 0, 1);
                    if not u8.GetValue("NoMotion") then
                        l__CurrentCamera__9.CFrame = v48;
                    end;
                    if u39 > 4 or not l__HumanoidRootPart__10.Parent then
                        u7.EndInteractions();
                        u12.AnimationActive = false;
                        u12.MainPriority.Flashbang.BackgroundTransparency = 1;
                        u12.LocalAnimationActive = false;
                        l__CurrentCamera__9.CameraType = Enum.CameraType.Custom;
                        u41:Disconnect();
                    end;
                end;
            end);
        end;
    end;
end;
function u12.Animation(p49, p50, u51) --[[ Line: 266 ]]
    -- upvalues: l__LocalPlayer__3 (copy), u12 (copy), u5 (copy), l__Effect__5 (copy), l__ReplicatedStorage__1 (copy)
    local l__Character__11 = l__LocalPlayer__3.Character;
    local l__Character__12 = p49.Character;
    local v52 = l__Character__12:FindFirstChild("Humanoid");
    if l__Character__11 and l__Character__12 then
        local u53 = script.Base:Clone();
        u53.Parent = game.Workspace;
        local l__Humanoid__13 = u53:WaitForChild("Humanoid");
        l__Humanoid__13:ApplyDescription(v52:GetAppliedDescription());
        local u54 = {};
        for _, v55 in script.Animations:GetChildren() do
            local v56 = l__Humanoid__13.Animator:LoadAnimation(v55);
            if v56:GetAttribute("Speed") then
                v56:AdjustSpeed(v56:GetAttribute("Speed"));
            end;
            u54[v55.Name] = v56;
        end;
        for _, v57 in l__Character__12:GetDescendants() do
            if v57:IsA("BasePart") or v57:IsA("Decal") then
                v57.LocalTransparencyModifier = 1;
            end;
        end;
        if p49 == l__LocalPlayer__3 then
            task.spawn(function() --[[ Line: 300 ]]
                -- upvalues: u12 (ref), u54 (copy), u53 (copy), u51 (copy)
                u12.LocalAnimation(u54, u53, u51);
            end);
        else
            u53:PivotTo(p50);
            u5.PlaySoundAt("Teleport.Out", u12.CreatePart(u53.HumanoidRootPart.Position), { 5, 35 });
            local function v58() --[[ Line: 313 ]]
                -- upvalues: l__Effect__5 (ref), l__ReplicatedStorage__1 (ref), u53 (copy)
                l__Effect__5.new(l__ReplicatedStorage__1.Assets.Particles.Groups.TeleportRings, u53.UpperTorso):PlayThenDestroy();
            end;
            local function v59() --[[ Line: 316 ]]
                -- upvalues: l__Effect__5 (ref), l__ReplicatedStorage__1 (ref), u53 (copy)
                l__Effect__5.new(l__ReplicatedStorage__1.Assets.Particles.Groups.TeleportGlow, u53.UpperTorso.Position):PlayThenDestroy();
            end;
            u54.Start:GetMarkerReachedSignal("Rings"):Connect(v58);
            u54.Start:GetMarkerReachedSignal("Explode"):Connect(v59);
            u54.End:GetMarkerReachedSignal("Explode"):Connect(v59);
            u54.End.Stopped:Connect(function() --[[ Line: 323 ]]
                -- upvalues: u53 (copy)
                u53:Destroy();
            end);
            u54.Start:Play();
            u54.Start.Stopped:Wait();
            TeleportPlayerToGroundPosition(u53, Vector3.new(-0, -20, -0));
            task.wait(1);
            TeleportPlayerToGroundPosition(u53, u51);
            u5.PlaySoundAt("Teleport.In", u12.CreatePart(u53.HumanoidRootPart.Position), { 5, 35 });
            u54.End:Play();
            u54.End.Stopped:Wait();
            for _, v60 in l__Character__12:GetDescendants() do
                if v60:IsA("BasePart") or v60:IsA("Decal") then
                    v60.LocalTransparencyModifier = 0;
                end;
            end;
        end;
    end;
end;
function u12.StartTool(p61) --[[ Line: 347 ]]
    -- upvalues: u12 (copy), l__Mince__4 (copy), u1 (copy), l__RunService__2 (copy), l__LocalPlayer__3 (copy)
    u12.IsEquipped = true;
    u12.ThisTool = p61;
    u12.Animations = {};
    if l__Mince__4.Config.Humanoid then
        if p61:FindFirstChild("Animations") then
            for _, v62 in p61.Animations:GetChildren() do
                local v63 = l__Mince__4.Config.Humanoid.Animator:LoadAnimation(v62);
                if v63:GetAttribute("Speed") then
                    v63:AdjustSpeed(v63:GetAttribute("Speed"));
                end;
                u12.Animations[v62.Name] = v63;
            end;
            u1:OpenList({
                DefaultVisibility = true,
                CloseWhenSelect = true,
                Title = `Teleporter Uses: ({p61:GetAttribute("Uses")}/{p61:GetAttribute("MaxUses")})`,
                ApplyToAll = {
                    ButtonText = "Teleport"
                },
                ForEach = function(p64, p65) --[[ Name: ForEach, Line 370 ]]
                    -- upvalues: l__RunService__2 (ref), l__LocalPlayer__3 (ref)
                    if l__RunService__2:IsStudio() then
                        p64:SetVisible(true);
                    elseif p65 == l__LocalPlayer__3 then
                        p64:SetVisible(false);
                    else
                        p64:SetVisible(l__LocalPlayer__3:IsFriendsWith(p65.UserId));
                    end;
                end,
                WhenPressed = function(_, u66) --[[ Name: WhenPressed, Line 381 ]]
                    -- upvalues: u12 (ref)
                    task.defer(function() --[[ Line: 382 ]]
                        -- upvalues: u12 (ref), u66 (copy)
                        u12.DoTeleporting(u12.ThisTool, u66);
                    end);
                end
            });
        end;
    end;
end;
function u12.EndTool() --[[ Line: 389 ]]
    -- upvalues: u12 (copy)
    u12.IsEquipped = false;
    u12.Animations = nil;
end;
function u12.Setup() --[[ Line: 394 ]]
    -- upvalues: u12 (copy), u3 (copy), u2 (copy), u6 (copy), l__LocalPlayer__3 (copy), u11 (copy)
    u12.SitCase = u3.CanSitCase:Extend();
    local v67 = u2.TagEquipped({ "FriendTeleporter" });
    v67.Equipped:Connect(u12.StartTool);
    v67.Unequipped:Connect(u12.EndTool);
    u12.MainPriority = u6.GetScreenGui("MainPriority");
    l__LocalPlayer__3.CharacterAdded:Connect(function() --[[ Line: 404 ]]
        -- upvalues: u12 (ref)
        u12.SitCase:Set(true);
    end);
    u11.Event:Connect(function(p68, p69, p70) --[[ Line: 409 ]]
        -- upvalues: u12 (ref)
        u12.Animation(p68, p69, p70);
    end);
end;
return u12;
