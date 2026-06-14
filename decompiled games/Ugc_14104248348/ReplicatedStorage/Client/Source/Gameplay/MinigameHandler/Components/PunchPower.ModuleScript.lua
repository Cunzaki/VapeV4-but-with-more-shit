-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.MinigameHandler.Components.PunchPower
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local _ = workspace.CurrentCamera;
l__LocalPlayer__1:GetMouse();
game:GetService("Debris");
local l__TweenService__2 = game:GetService("TweenService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("RunService");
local l__Mince__4 = require(l__ReplicatedStorage__3.Modules.Mince);
l__Mince__4:Get("BindManager");
l__Mince__4:Get("SoundHandler");
local u1 = l__Mince__4:Get("InterfaceHandler");
local u2 = l__Mince__4:Get("SelectInteractor");
local v3 = {
    Playing = false,
    TextLabel = nil,
    Client = {}
};
local u4 = {
    Idle = nil,
    Punch = nil
};
local u5 = nil;
local u6 = CFrame.new(Vector3.new(0, 0, 0), Vector3.new(0, 70, -70));
local u7 = CFrame.new(Vector3.new(0, 0, 0), Vector3.new(70, 0, 0));
local u8 = TweenInfo.new(0.1);
local u9 = TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out);
local u10 = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, -1, true);
function v3.Reset(p11) --[[ Line: 47 ]]
    -- upvalues: u5 (ref)
    if u5 then
        u5:Cancel();
    end;
    p11.TextLabel.Text = 0;
end;
function v3.EmulatePunch(u12, p13) --[[ Line: 55 ]]
    -- upvalues: u5 (ref), l__TweenService__2 (copy), u8 (copy), u6 (copy), u9 (copy), u7 (copy)
    local l__Punch__5 = u12.Instance.Punch;
    local v14 = math.clamp(p13 / 100 * 1000 - 100, 1, 900);
    local u15 = Instance.new("IntValue");
    local v16 = TweenInfo.new(v14 / 90, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    u12:Reset();
    u15.Changed:Connect(function(p17) --[[ Line: 68 ]]
        -- upvalues: u12 (copy)
        u12.TextLabel.Text = p17;
    end);
    u5 = l__TweenService__2:Create(u15, v16, {
        Value = v14
    });
    local u18 = l__TweenService__2:Create(l__Punch__5, u8, {
        CFrame = l__Punch__5.CFrame * u6
    });
    local u19 = l__TweenService__2:Create(l__Punch__5, u9, {
        CFrame = l__Punch__5.CFrame * u7
    });
    l__Punch__5.Punch:Play();
    u18:Play();
    u5:Play();
    task.delay(0.4, function() --[[ Line: 90 ]]
        -- upvalues: u19 (copy)
        u19:Play();
    end);
    u5.Completed:Connect(function() --[[ Line: 94 ]]
        -- upvalues: u18 (copy), u19 (copy), u5 (ref), u15 (copy), u12 (copy)
        task.delay(5, function() --[[ Line: 96 ]]
            -- upvalues: u18 (ref), u19 (ref), u5 (ref), u15 (ref), u12 (ref)
            u18:Destroy();
            u19:Destroy();
            u5:Destroy();
            u15:Destroy();
            u12.TextLabel.Text = 0;
        end);
    end);
end;
function v3.ThrowPunch(u20) --[[ Line: 107 ]]
    -- upvalues: u4 (ref)
    if not u20.Playing then
        return "Pass";
    end;
    u20.Playing = false;
    local u21 = nil;
    u21 = u4.Punch:GetMarkerReachedSignal("IK"):Connect(function(p22) --[[ Line: 113 ]]
        -- upvalues: u20 (copy), u21 (ref)
        if p22 == "1" then
            local v23 = -math.abs(u20.PowerMeter.Value - 50) / 50;
            local v24 = math.exp(v23) * 100;
            u20:EmulatePunch(v24);
            u20.Server:ThrowPunch(v24);
            u21:Disconnect();
        end;
    end);
    u4.Punch:Play();
    u20.TweenMeter:Pause();
    return "Sink";
end;
function v3.Construct(u25) --[[ Line: 131 ]]
    -- upvalues: u2 (copy), u1 (copy), l__TweenService__2 (copy), u10 (copy)
    for _, v26 in u25.Instance.Players:GetChildren() do
        u25:AddProximityJoinSource(v26:WaitForChild("Position"), (tonumber(v26.Name)));
    end;
    u2.BindToInteract(100, function() --[[ Line: 136 ]]
        -- upvalues: u25 (copy)
        return u25:ThrowPunch();
    end);
    local v27 = Instance.new("NumberValue");
    local l__Arrow__6 = u1.GetScreenGui("MainPriority").PowerMeter.Arrow;
    local v28 = l__TweenService__2:Create(v27, u10, {
        Value = 100
    });
    v27.Changed:Connect(function(p29) --[[ Line: 145 ]]
        -- upvalues: l__Arrow__6 (copy)
        l__Arrow__6.Position = UDim2.fromScale(0, p29 / 100);
    end);
    local l__SurfaceGui__7 = u25.Instance.Model.Screen.SurfaceGui;
    u25.Arrow = l__Arrow__6;
    u25.TextLabel = l__SurfaceGui__7.TextLabel;
    u25.TweenMeter = v28;
    u25.PowerMeter = v27;
end;
function v3.SpectateStart(u30) --[[ Line: 158 ]]
    local v31 = u30:GetStateChangedSignal("Punch"):Connect(function() --[[ Line: 162 ]]
        -- upvalues: u30 (copy)
        u30:EmulatePunch(u30.ReplicatedState.Punch);
    end);
    u30.SpectateMaid:Mark(v31);
end;
function v3.Enter(p32) --[[ Line: 171 ]]
    -- upvalues: l__LocalPlayer__1 (copy), u4 (ref), l__Mince__4 (copy)
    local l__Animator__8 = l__LocalPlayer__1.Character.Humanoid.Animator;
    u4 = {
        Idle = l__Animator__8:LoadAnimation(script.Idle),
        Punch = l__Animator__8:LoadAnimation(script.Punch)
    };
    if l__Mince__4.Config.Humanoid then
        l__Mince__4.Config.Humanoid:UnequipTools();
    end;
    u4.Idle:Play(0.5);
    p32:Reset();
    p32.TweenMeter:Play();
    p32.Arrow.Parent.Visible = true;
end;
function v3.Start(p33) --[[ Line: 190 ]]
    p33.Playing = true;
end;
function v3.Exit(p34) --[[ Line: 195 ]]
    -- upvalues: u4 (ref)
    p34.Playing = false;
    u4.Idle:Stop();
    u4.Punch:Stop();
    p34.TweenMeter:Pause();
    p34.Arrow.Parent.Visible = false;
    p34:UnlockPlayerMovement();
end;
return v3;
