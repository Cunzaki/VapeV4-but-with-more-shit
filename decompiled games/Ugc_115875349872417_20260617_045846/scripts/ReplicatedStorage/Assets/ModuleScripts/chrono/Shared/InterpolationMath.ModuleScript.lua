-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.chrono.Shared.InterpolationMath
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);
local l__Config__1 = require(script.Parent.Config);
return {
    Hermite = function(p1, p2, p3, p4, p5, p6) --[[ Name: Hermite, Line 4 ]]
        local v7 = p3 or Vector3.new(0, 0, 0);
        local v8 = p4 or Vector3.new(0, 0, 0);
        if not p6 or p6 == 0 then
            return p1:Lerp(p2, p5);
        end;
        local v9 = p5 * p5;
        local v10 = v9 * p5;
        return p1 * (v10 * 2 - v9 * 3 + 1) + v7 * p6 * (v10 - v9 * 2 + p5) + p2 * (v10 * -2 + v9 * 3) + v8 * p6 * (v10 - v9);
    end,
    VelocityAt = function(p11, p12, p13, p14) --[[ Name: VelocityAt, Line 21 ]]
        -- upvalues: l__Config__1 (copy)
        if not p11 then
            return Vector3.new(0, 0, 0);
        end;
        local v15 = p14 or 0.05;
        local v16 = p12 - p11.t;
        if v16 <= 1e-6 then
            return Vector3.new(0, 0, 0);
        end;
        if v15 * 3 < v16 then
            if not l__Config__1.FLAGS.SNAPSHOT_INTERPOLATION_FIX then
                v15 = v16;
            end;
        else
            v15 = v16;
        end;
        return (p13.Position - p11.value.Position) / v15;
    end
};
