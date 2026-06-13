-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.ToolComponents.Teddies
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Players");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
l__Mince__2:Get("UserProfile");
local u1 = l__Mince__2:Get("BindManager").Get("Interact");
local u2 = CFrame.new(-1.52084351, -1.22692871, -1.21998596, -0.77261728, -0.634872079, 1.19705442e-6, 9.69754979e-7, 7.05346849e-7, 1, -0.634872079, 0.77261728, 7.07072445e-8);
local u3 = CFrame.new(Vector3.new(0, -0.204, -0.349)) * CFrame.Angles(1.5707963267948966, 0, 0);
local v4 = l__Mince__2.Component({
    Tag = "Teddies"
});
function v4.Activate(p5) --[[ Line: 22 ]]
    -- upvalues: l__Mince__2 (copy), u2 (copy), u3 (copy)
    if l__Mince__2.Config.Humanoid and not p5.Active then
        p5.Active = true;
        local l__Instance__3 = p5.Instance;
        l__Instance__3.Grip = u2;
        local v6 = l__Instance__3.Handle:GetChildren();
        v6[math.random(1, #v6)]:Play();
        task.wait(2);
        l__Instance__3.Grip = u3;
        p5.Active = false;
    end;
end;
function v4.Equipped(p7) --[[ Line: 37 ]]
    -- upvalues: u3 (copy)
    p7.Instance.Grip = u3;
    p7.IsEquipped = true;
end;
function v4.Unequipped(p8) --[[ Line: 42 ]]
    p8.IsEquipped = false;
end;
function v4.Construct(u9) --[[ Line: 46 ]]
    -- upvalues: u1 (copy)
    local l__Instance__4 = u9.Instance;
    u1.OnAction:Connect(function(_) --[[ Line: 49 ]]
        -- upvalues: u9 (copy)
        if u9.IsEquipped then
            u9:Activate();
        end;
    end);
    l__Instance__4.Equipped:Connect(function() --[[ Line: 54 ]]
        -- upvalues: u9 (copy)
        u9:Equipped();
    end);
    l__Instance__4.Unequipped:Connect(function() --[[ Line: 58 ]]
        -- upvalues: u9 (copy)
        u9:Unequipped();
    end);
end;
return v4;
