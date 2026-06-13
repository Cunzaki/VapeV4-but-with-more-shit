-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Special-Event-World.NeonSign
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local v1 = require(l__ReplicatedStorage__1.Modules.Mince).Component({
    Tag = "NeonSign"
});
function v1.SetVisible(p2, p3) --[[ Line: 13 ]]
    if p2.Light then
        p2.Light.Enabled = p3;
    end;
    if p2.Sound then
        if p3 then
            p2.Sound:Play();
        else
            p2.Sound:Pause();
        end;
    end;
    p2.Instance.Color = p3 and p2.Color or Color3.new(0, 0, 0);
end;
function v1.Construct(u4) --[[ Line: 28 ]]
    u4.Color = u4.Instance.Color;
    u4.Light = u4.Instance:FindFirstChildWhichIsA("Light");
    u4.Sound = u4.Instance:FindFirstChildWhichIsA("Sound");
    local function u5() --[[ Line: 35 ]]
        -- upvalues: u4 (copy), u5 (ref)
        u4:SetVisible(false);
        task.wait(0.1);
        u4:SetVisible(true);
        task.wait(0.1);
        u4:SetVisible(false);
        task.wait(0.1);
        u4:SetVisible(true);
        task.delay(math.random(5, 22), u5);
    end;
    u5();
end;
return v1;
