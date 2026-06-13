-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Lifeforms.Butters
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:GetEvent("ButtersJump");
local u2 = l__Mince__2:GetEvent("ButtersTurn");
local v3 = l__Mince__2.Component({
    Tag = "Butters"
});
function QuadBezier(p4, p5, p6, p7)
    return p5:Lerp(p6, p4):Lerp(p6:Lerp(p7, p4), p4);
end;
function v3.Construct(u8) --[[ Line: 19 ]]
    -- upvalues: u1 (copy), u2 (copy)
    u1.Event:Connect(function(p9, p10, p11) --[[ Line: 20 ]]
        -- upvalues: u8 (copy)
        local l__HumanoidRootPart__3 = u8.Instance.HumanoidRootPart;
        local l__Rotation__4 = l__HumanoidRootPart__3.CFrame.Rotation;
        local v12 = 0;
        local v13 = 0.8;
        repeat
            v12 = v12 + task.wait();
            local v14 = QuadBezier(v12 / 0.8, p9, p10, p11);
            l__HumanoidRootPart__3.CFrame = CFrame.new(v14) * l__Rotation__4;
        until v13 < v12;
        l__HumanoidRootPart__3.Position = p11;
    end);
    u2.Event:Connect(function(p15) --[[ Line: 37 ]]
        -- upvalues: u8 (copy)
        local l__HumanoidRootPart__5 = u8.Instance.HumanoidRootPart;
        game:GetService("TweenService"):Create(l__HumanoidRootPart__5, TweenInfo.new(0.5), {
            CFrame = p15
        }):Play();
    end);
end;
return v3;
