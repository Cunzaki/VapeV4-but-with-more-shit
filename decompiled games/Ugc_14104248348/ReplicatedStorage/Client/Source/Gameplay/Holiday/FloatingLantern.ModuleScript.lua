-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.FloatingLantern
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local v1 = require(l__ReplicatedStorage__3.Modules.Mince).Component({
    Tag = "FloatingLantern"
});
function v1.ShouldAnimate(p2) --[[ Line: 12 ]]
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - p2.LanternPos).Magnitude <= 50;
    else
        return false;
    end;
end;
function v1.Update(p3) --[[ Line: 18 ]]
    local l__Tween__4 = p3.Tween;
    if not p3:ShouldAnimate() and l__Tween__4.PlaybackState == Enum.PlaybackState.Playing then
        l__Tween__4:Pause();
    end;
    if l__Tween__4.PlaybackState ~= Enum.PlaybackState.Playing then
        l__Tween__4:Play();
    end;
end;
function v1.Construct(u4) --[[ Line: 24 ]]
    -- upvalues: l__TweenService__2 (copy), l__RunService__1 (copy)
    task.wait(math.random(5, 20) / 5);
    local l__Part__5 = u4.Instance.Part;
    u4.LanternPos = l__Part__5.Position;
    for _, v5 in pairs(u4.Instance:GetChildren()) do
        if v5 ~= l__Part__5 then
            v5.Anchored = false;
            local v6 = Instance.new("WeldConstraint");
            v6.Part0 = l__Part__5;
            v6.Part1 = v5;
            v6.Parent = l__Part__5;
        end;
    end;
    u4.Tween = l__TweenService__2:Create(l__Part__5, TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
        CFrame = CFrame.new(l__Part__5.Position * Vector3.new(1, 0.9, 1))
    });
    l__RunService__1.Heartbeat:Connect(function() --[[ Line: 43 ]]
        -- upvalues: u4 (copy)
        u4:Update();
    end);
end;
return v1;
