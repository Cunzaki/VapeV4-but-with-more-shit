-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Enemy.Components.ClientEnemy.Routines.EffectAtRoot
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Effect__2 = require(l__ReplicatedStorage__1.Modules.Effect);
return {
    Called = function(p1, p2) --[[ Name: Called, Line 7 ]]
        -- upvalues: l__ReplicatedStorage__1 (copy), l__Effect__2 (copy)
        local l__Position__3 = p1.ThisRoot.Position;
        local v3 = l__ReplicatedStorage__1.Assets.Particles:FindFirstChild(p2);
        if v3 then
            l__Effect__2.new(v3, l__Position__3):PlayThenDestroy();
        end;
    end
};
