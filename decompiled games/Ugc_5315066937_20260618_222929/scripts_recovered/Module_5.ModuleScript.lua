-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = _G.obtain("Simulation");
return function(u2, u3, u4) --[[ Line: 3 ]]
    -- upvalues: u1 (copy)
    local u5 = u1();
    u2.PostTick:Add(function() --[[ Line: 6 ]]
        -- upvalues: u5 (copy), u2 (copy), u4 (copy), u3 (copy)
        local v6 = {};
        u5:DifferentiateState(u2, v6);
        u4:Post({ u3.NextInputN, v6 });
        u5:IntegrateState(v6);
    end);
end;
