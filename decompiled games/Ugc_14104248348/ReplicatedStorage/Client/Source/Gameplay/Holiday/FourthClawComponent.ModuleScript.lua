-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.FourthClawComponent
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
game:GetService("RunService");
local l__StarterGui__2 = game:GetService("StarterGui");
local l__TweenService__3 = game:GetService("TweenService");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
local l__LocalPlayer__5 = l__Players__1.LocalPlayer;
local l__Mince__6 = require(l__ReplicatedStorage__4.Modules.Mince);
local u1 = l__Mince__6:Get("NotifPrompt");
local u2 = l__Mince__6:Get("ConfirmPrompt");
local u3 = l__Mince__6:Get("OpeningHandler");
local u4 = l__Mince__6:Get("SelectInteractor");
local u5 = l__Mince__6:GetFunction("LootboxRequest");
local u6 = l__Mince__6.Component({
    Tag = "FourthClaw",
    ExitCameraSpeedMult = 1.25,
    CameraStudsPerSecond = 48,
    MinimumCameraDistanceVariable = 22,
    MaximumCameraDistanceVariable = 40,
    Tween1 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In),
    Tween2 = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true)
});
function QuadBezier(p7, p8, p9, p10)
    return p8:Lerp(p9, p7):Lerp(p9:Lerp(p10, p7), p7);
end;
function u6.DistanceRoundedCameraPan(p11, p12) --[[ Line: 44 ]]
    -- upvalues: l__TweenService__3 (copy)
    local l__CurrentCamera__7 = game.Workspace.CurrentCamera;
    local v13 = l__CurrentCamera__7:GetRenderCFrame();
    l__CurrentCamera__7.CameraType = Enum.CameraType.Scriptable;
    p11.LastStartingCFrame = v13;
    if l__CurrentCamera__7.CameraSubject:IsA("Humanoid") then
        local l__Parent__8 = l__CurrentCamera__7.CameraSubject.Parent;
        if l__Parent__8 then
            l__Parent__8 = l__Parent__8:FindFirstChild("HumanoidRootPart");
        end;
        if l__Parent__8 then
            p11.LastRelativeCFrame = CFrame.new(l__Parent__8.Position + l__CurrentCamera__7.CameraSubject.CameraOffset):ToObjectSpace(v13);
        end;
    end;
    local l__Position__9 = v13.Position;
    local l__Position__10 = p12.Position;
    local v14 = l__Position__9 * Vector3.new(1, 0, 1) + l__Position__10 * Vector3.new(0, 1, 0);
    local v15 = math.clamp((l__Position__9 - l__Position__10).Magnitude, p11.MinimumCameraDistanceVariable, p11.MaximumCameraDistanceVariable);
    local l__Rotation__11 = v13.Rotation;
    local l__Rotation__12 = p12.Rotation;
    local v16 = 1 / p11.CameraStudsPerSecond * v15;
    local v17 = 0;
    repeat
        v17 = v17 + task.wait();
        local v18 = l__TweenService__3:GetValue(math.clamp(v17 / v16, 0, 1), Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
        l__CurrentCamera__7.CFrame = CFrame.new(QuadBezier(v18, l__Position__9, v14, l__Position__10)) * l__Rotation__11:Lerp(l__Rotation__12, v18);
    until v16 < v17;
    l__CurrentCamera__7.CFrame = p12;
end;
function u6.DistanceLinearRevertCamera(p19) --[[ Line: 88 ]]
    -- upvalues: l__Mince__6 (copy), l__TweenService__3 (copy)
    if not p19.LastStartingCFrame then
        return;
    end;
    local l__HumanoidRootPart__13 = l__Mince__6.Config.HumanoidRootPart;
    local l__CurrentCamera__14 = game.Workspace.CurrentCamera;
    local v20 = l__CurrentCamera__14:GetRenderCFrame();
    local l__LastStartingCFrame__15 = p19.LastStartingCFrame;
    local v21 = math.clamp((v20.Position - l__LastStartingCFrame__15.Position).Magnitude, p19.MinimumCameraDistanceVariable, p19.MaximumCameraDistanceVariable);
    local v22 = 1 / p19.CameraStudsPerSecond * v21 * p19.ExitCameraSpeedMult;
    local v23 = 0;
    while true do
        v23 = v23 + task.wait();
        local v24 = l__TweenService__3:GetValue(math.clamp(v23 / v22, 0, 1), Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
        if p19.LastRelativeCFrame and l__HumanoidRootPart__13 then
            l__LastStartingCFrame__15 = CFrame.new(l__HumanoidRootPart__13.Position):ToWorldSpace(p19.LastRelativeCFrame);
        end;
        l__CurrentCamera__14.CFrame = v20:Lerp(l__LastStartingCFrame__15, v24);
        if v22 < v23 then
            if l__Mince__6.Config.Humanoid then
                l__CurrentCamera__14.CameraSubject = l__Mince__6.Config.Humanoid;
            else
                task.spawn(function() --[[ Line: 119 ]]
                    -- upvalues: l__Mince__6 (ref), l__CurrentCamera__14 (copy)
                    repeat
                        task.wait();
                    until l__Mince__6.Config.Humanoid;
                    l__CurrentCamera__14.CameraSubject = l__Mince__6.Config.Humanoid;
                end);
            end;
            l__CurrentCamera__14.CameraType = Enum.CameraType.Custom;
            return;
        end;
    end;
end;
function u6.Start(u25) --[[ Line: 128 ]]
    -- upvalues: l__Mince__6 (copy), l__StarterGui__2 (copy), l__LocalPlayer__5 (copy)
    if u25.InMachine then
    else
        if l__Mince__6.Config.Humanoid then
            l__Mince__6.Config.Humanoid:UnequipTools();
        end;
        l__StarterGui__2:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
        u25.Firework.Transparency = 0;
        u25.Firework.Position = u25.FireworkStartPosition;
        u25.InteractGrabPoint.Disabled = true;
        u25.ButtonAnim:Play();
        u25.InMachine = true;
        u25.Events.Death = l__LocalPlayer__5.CharacterAdded:Connect(function() --[[ Line: 143 ]]
            -- upvalues: u25 (copy)
            u25:Exit();
        end);
        u25.ProximityPrompt.Enabled = false;
        u25:DistanceRoundedCameraPan(u25.CamerasPart.Focus.WorldCFrame);
        u25.FireworkComeDown.Completed:Once(function() --[[ Line: 148 ]]
            -- upvalues: u25 (copy)
            u25.InteractGrabPoint.Disabled = false;
        end);
        u25.FireworkComeDown:Play();
        if l__Mince__6.Config.HumanoidRootPart then
            l__Mince__6.Config.HumanoidRootPart.Anchored = true;
        end;
    end;
end;
function u6.Exit(p26) --[[ Line: 158 ]]
    -- upvalues: u5 (copy), u3 (copy), l__Mince__6 (copy)
    if p26.InMachine then
        p26.ButtonAnim:Pause();
        p26.GrabPoint.Transparency = 1;
        p26.Firework.Transparency = 1;
        p26.InteractGrabPoint.Disabled = true;
        local v27, v28 = pcall(function() --[[ Line: 169 ]]
            -- upvalues: u5 (ref)
            return u5:Invoke("JulyFourth2024");
        end);
        if v27 and v28 then
            u3.StartFireworkOpening({
                IVID = v28
            });
        end;
        if l__Mince__6.Config.HumanoidRootPart then
            l__Mince__6.Config.HumanoidRootPart.Anchored = false;
        end;
        p26.ProximityPrompt.Enabled = true;
        for _, v29 in p26.Events do
            v29:Disconnect();
        end;
        p26.Events = {};
        p26:DistanceLinearRevertCamera();
        p26.InMachine = false;
    end;
end;
function u6.Construct(u30) --[[ Line: 195 ]]
    -- upvalues: l__TweenService__3 (copy), u6 (copy), u4 (copy), l__Mince__6 (copy), u1 (copy), u2 (copy)
    local l__Interact__16 = u30.Instance:WaitForChild("Interact");
    local l__Firework__17 = u30.Instance:WaitForChild("Firework");
    local l__GrabPoint__18 = u30.Instance:WaitForChild("GrabPoint");
    local l__Cameras__19 = u30.Instance:WaitForChild("Cameras");
    local v31 = Instance.new("ProximityPrompt");
    v31:SetAttribute("Type", "Radial");
    v31:SetAttribute("SizeMultipler", 2);
    v31.ObjectText = "Play (100 Freedom Coins)";
    v31.MaxActivationDistance = 5;
    v31.Style = Enum.ProximityPromptStyle.Custom;
    v31.Parent = l__Interact__16;
    v31.RequiresLineOfSight = false;
    u30.Events = {};
    u30.GrabPoint = l__GrabPoint__18;
    u30.Firework = l__Firework__17;
    u30.FireworkEndPosition = l__Firework__17.Position;
    u30.FireworkStartPosition = l__Firework__17.Position + Vector3.new(0, 2, 0);
    u30.ProximityPrompt = v31;
    u30.CamerasPart = l__Cameras__19;
    u30.FireworkComeDown = l__TweenService__3:Create(l__Firework__17, u6.Tween1, {
        Position = u30.FireworkEndPosition
    });
    u30.ButtonAnim = l__TweenService__3:Create(l__GrabPoint__18, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
        Transparency = 0.5
    });
    u30.Firework.Transparency = 1;
    u30.Firework.Position = u30.FireworkStartPosition;
    local v33 = {
        HoverName = "Grab Firework!",
        MaxCharacterDistance = 100,
        Disabled = true,
        Target = l__Firework__17,
        HitCollider = l__GrabPoint__18,
        Interact = function(_, p32) --[[ Name: Interact, Line 234 ]]
            -- upvalues: u30 (copy)
            task.spawn(function() --[[ Line: 235 ]]
                -- upvalues: u30 (ref)
                u30:Exit();
            end);
            p32();
        end
    };
    u4.NewInteractionClass(v33);
    u30.InteractGrabPoint = v33;
    v31.Triggered:Connect(function() --[[ Line: 246 ]]
        -- upvalues: l__Mince__6 (ref), u1 (ref), u2 (ref), u30 (copy)
        if l__Mince__6.Config.LocalProfile.Holiday < 100 then
            u1.Display("You don\'t have enough to use this!");
        else
            u2.Display("Would you like to play gacha for 100 freedom coins?", function() --[[ Line: 252 ]]
                -- upvalues: u30 (ref)
                u30:Start();
            end);
        end;
    end);
end;
return u6;
