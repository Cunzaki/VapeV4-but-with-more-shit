-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.SpaceLobby.TableRings
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
local v1 = require(l__ReplicatedStorage__1.Modules.Mince).Component({
    Tag = "TableRings"
});
function v1.Construct(p2) --[[ Line: 11 ]]
    -- upvalues: l__TweenService__2 (copy)
    local l__Instance__3 = p2.Instance;
    l__TweenService__2:Create(l__Instance__3, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
        Position = l__Instance__3.Position + Vector3.new(0, 0.35, 0)
    }):Play();
end;
return v1;
