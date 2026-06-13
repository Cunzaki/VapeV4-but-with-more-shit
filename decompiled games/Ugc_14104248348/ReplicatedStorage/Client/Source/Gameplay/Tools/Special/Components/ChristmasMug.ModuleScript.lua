-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Special.Components.ChristmasMug
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
game:GetService("UserInputService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("Players");
game:GetService("Debris");
local l__TweenService__2 = game:GetService("TweenService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.Signal);
l__Mince__3:Get("ToolHandler");
local v1 = l__Mince__3.Component({
    Tag = "ChristmasMug"
});
function v1.Construct(p2) --[[ Line: 18 ]]
    -- upvalues: l__TweenService__2 (copy)
    local l__Instance__4 = p2.Instance;
    l__Instance__4:WaitForChild((`Lights{1}`));
    l__Instance__4:WaitForChild((`Lights{2}`));
    l__Instance__4:WaitForChild((`Lights{3}`));
    l__Instance__4:WaitForChild((`Lights{4}`));
    pcall(function() --[[ Line: 25 ]]
        -- upvalues: l__Instance__4 (copy), l__TweenService__2 (ref)
        while true do
            for v3 = 1, 4 do
                local l__Color__5 = l__Instance__4[`Lights{v3 % 4 + 1}`].Color;
                l__TweenService__2:Create(l__Instance__4[`Lights{v3}`], TweenInfo.new(1), {
                    Color = l__Color__5
                }):Play();
            end;
            task.wait(1);
        end;
    end);
end;
return v1;
