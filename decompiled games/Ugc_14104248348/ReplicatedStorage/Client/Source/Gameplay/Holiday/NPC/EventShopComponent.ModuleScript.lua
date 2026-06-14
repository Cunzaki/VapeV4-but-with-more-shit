-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.NPC.EventShopComponent
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
game:GetService("RunService");
game:GetService("StarterGui");
local l__TweenService__2 = game:GetService("TweenService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
game:GetService("Debris");
local _ = l__Players__1.LocalPlayer;
local l__Maid__4 = require(l__ReplicatedStorage__3.Modules.Maid);
local l__Mince__5 = require(l__ReplicatedStorage__3.Modules.Mince);
local l__Bucket__6 = require(l__ReplicatedStorage__3.Modules.Bucket);
local u1 = l__Mince__5:Get("EventShop");
local u2 = l__Mince__5:Get("IndicatorHandler");
local u3 = l__Mince__5:Get("SelectInteractor");
local u4 = l__Mince__5:Get("Voicelines");
local u5 = l__Bucket__6.new({ "THANKS25Hello1", "THANKS25Hello2", "THANKS25Hello3" });
local u6 = l__Bucket__6.new({ "THANKS25Bye1", "THANKS25Bye2" });
local u7 = l__Mince__5.Component({
    Tag = "EventShop"
});
function QuadBezier(p8, p9, p10, p11)
    return p9:Lerp(p10, p8):Lerp(p10:Lerp(p11, p8), p8);
end;
function u7.DistanceRoundedCameraPan(p12, p13) --[[ Line: 34 ]]
    -- upvalues: l__TweenService__2 (copy)
    local l__CurrentCamera__7 = game.Workspace.CurrentCamera;
    local v14 = l__CurrentCamera__7:GetRenderCFrame();
    l__CurrentCamera__7.CameraType = Enum.CameraType.Scriptable;
    p12.LastStartingCFrame = v14;
    if l__CurrentCamera__7.CameraSubject:IsA("Humanoid") then
        local l__Parent__8 = l__CurrentCamera__7.CameraSubject.Parent;
        if l__Parent__8 then
            l__Parent__8 = l__Parent__8:FindFirstChild("HumanoidRootPart");
        end;
        if l__Parent__8 then
            p12.LastRelativeCFrame = CFrame.new(l__Parent__8.Position + l__CurrentCamera__7.CameraSubject.CameraOffset):ToObjectSpace(v14);
        end;
    end;
    local l__Position__9 = v14.Position;
    local l__Position__10 = p13.Position;
    local v15 = l__Position__9 * Vector3.new(1, 0, 1) + l__Position__10 * Vector3.new(0, 1, 0);
    local v16 = math.clamp((l__Position__9 - l__Position__10).Magnitude, 22, 40);
    local l__Rotation__11 = v14.Rotation;
    local l__Rotation__12 = p13.Rotation;
    local v17 = 0.020833333333333332 * v16;
    local v18 = 0;
    repeat
        v18 = v18 + task.wait();
        local v19 = l__TweenService__2:GetValue(math.clamp(v18 / v17, 0, 1), Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
        l__CurrentCamera__7.CFrame = CFrame.new(QuadBezier(v19, l__Position__9, v15, l__Position__10)) * l__Rotation__11:Lerp(l__Rotation__12, v19);
    until v17 < v18;
    l__CurrentCamera__7.CFrame = p13;
end;
function u7.PlayEmote(u20, p21) --[[ Line: 78 ]]
    local u22 = u20.Animations[p21];
    if u20.CurrentEmote then
        u20.CurrentEmote:Stop();
    end;
    if u20.EmoteThread then
        task.cancel(u20.EmoteThread);
    end;
    u20.CurrentEmote = u22;
    u20.Animations.Idle:Stop();
    u22:Play();
    u20.EmoteThread = task.delay(u22.Length, function() --[[ Line: 94 ]]
        -- upvalues: u22 (copy), u20 (copy)
        u22:Stop();
        u20.CurrentEmote = nil;
        u20.Animations.Idle:Play();
    end);
    return u22.Length;
end;
function u7.Construct(u23) --[[ Line: 103 ]]
    -- upvalues: l__Maid__4 (copy), u2 (copy), u4 (copy), u5 (copy), u3 (copy), u1 (copy), u7 (copy), l__Mince__5 (copy), u6 (copy)
    local l__Interact__13 = u23.Instance:WaitForChild("Interact");
    local l__Character__14 = u23.Instance:WaitForChild("Character");
    local l__Indicator__15 = u23.Instance:WaitForChild("Indicator");
    local l__Animations__16 = l__Character__14:WaitForChild("Animations");
    local v24 = Instance.new("ProximityPrompt");
    v24:SetAttribute("Type", "Radial");
    v24:SetAttribute("SizeMultipler", 2);
    v24.ObjectText = "Talk";
    v24.MaxActivationDistance = 5;
    v24.Style = Enum.ProximityPromptStyle.Custom;
    v24.Parent = l__Interact__13;
    v24.RequiresLineOfSight = false;
    u23.Events = {};
    u23.Maid = l__Maid__4.new();
    u23.ProximityPrompt = v24;
    u23.Character = l__Character__14;
    u23.Indicator = u2.CreateIndicator(l__Indicator__15);
    u23.Indicator:SetEnabled(false);
    u23.Animations = {};
    for _, v25 in l__Animations__16:GetChildren() do
        u23.Animations[v25.Name] = u23.Character.Humanoid:LoadAnimation(v25);
    end;
    u23.Animations.Idle:Play();
    local l__CurrentCamera__17 = workspace.CurrentCamera;
    v24.Triggered:Connect(function() --[[ Line: 135 ]]
        -- upvalues: u23 (copy), u4 (ref), u5 (ref), u3 (ref), u1 (ref), u7 (ref), l__Mince__5 (ref)
        u23.Indicator:SetEnabled(false);
        u4.PlayLine(u5:Next());
        u3.StartInteractions();
        u1.Interface.Open();
        u7:DistanceRoundedCameraPan(u23.Instance.CameraPart.CFrame);
        l__Mince__5.Config.Humanoid:UnequipTools();
    end);
    u1.Closed:Connect(function() --[[ Line: 144 ]]
        -- upvalues: u3 (ref), u4 (ref), u6 (ref), l__CurrentCamera__17 (copy)
        u3.EndInteractions();
        u4.PlayLine(u6:Next());
        l__CurrentCamera__17.CameraType = Enum.CameraType.Custom;
    end);
end;
return u7;
