-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = error;
local u2 = tostring;
local l__RunService__1 = game:GetService("RunService");
local l__BindToRenderStep__2 = l__RunService__1.BindToRenderStep;
local u3 = {
    TimerStep = 110,
    Simulation = 120,
    SmoothingSimulation = 130,
    PositionCharacters = 140,
    UpdateTransparency = 150,
    Gauges = 160,
    Guis = 170,
    View = 180
};
return {
    Bind = function(u4, u5) --[[ Name: Bind, Line 18 ]]
        -- upvalues: u3 (copy), l__BindToRenderStep__2 (copy), l__RunService__1 (copy), u1 (copy), u2 (copy)
        local v6 = u3[u4];
        if v6 then
            l__BindToRenderStep__2(l__RunService__1, u4, v6, function(...) --[[ Line: 21 ]]
                -- upvalues: u4 (copy), u5 (copy)
                debug.profilebegin(u4);
                u5(...);
                debug.profileend();
            end);
        else
            u1("Name does not exist: " .. u2(u4));
        end;
    end
};
