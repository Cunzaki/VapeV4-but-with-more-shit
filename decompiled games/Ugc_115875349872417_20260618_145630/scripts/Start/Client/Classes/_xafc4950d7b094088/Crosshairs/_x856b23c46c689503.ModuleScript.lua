-- Decompiled from: Start.Client.Classes._xafc4950d7b094088.Crosshairs._x856b23c46c689503
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local l___x7bf32b206fec7a03__1 = require(script.Parent.Parent._x7bf32b206fec7a03);
local l__Instances__2 = script:FindFirstAncestor("Client"):WaitForChild("Instances");
local u1 = {};
u1.__index = u1;
setmetatable(u1, l___x7bf32b206fec7a03__1);
function u1._x90d4581ac99dd483(_) --[[ Line: 8 ]]
    -- upvalues: l___x7bf32b206fec7a03__1 (copy), l__Instances__2 (copy), u1 (copy)
    local v2 = l___x7bf32b206fec7a03__1._x90d4581ac99dd483({
        priority = 1,
        name = script.Name,
        screenspace = { "CENTER" }
    });
    v2._x67de9152dd429711 = l__Instances__2.MeleeCrosshair:Clone();
    v2._x6679dae12d5569bf = true;
    v2._x9d0c0a6d51e5104c = true;
    setmetatable(v2, u1);
    return v2;
end;
function u1._x449065fc95251217(p3) --[[ Line: 24 ]]
    p3._x67de9152dd429711.Rotation = p3:_xe86d94ba29814c9e();
    p3._x67de9152dd429711.Position = p3:_xc2323225d7a5fb12();
end;
function u1._x4209447529b7cd98(p4) --[[ Line: 30 ]]
    p4._x67de9152dd429711.Visible = p4._x9d0c0a6d51e5104c;
end;
function u1._x8fcdafeb8ad3312d(p5) --[[ Line: 34 ]]
    p5._x67de9152dd429711.Visible = p5._x9d0c0a6d51e5104c;
end;
function u1.cleanUp(p6) --[[ Line: 38 ]]
    p6:_xd00fdb58a7e8416d();
end;
function u1._xe53615d96cf36a6b(p7) --[[ Line: 42 ]]
    p7._x67de9152dd429711.Parent = p7:_x8b1e37aadfd94696();
end;
return u1;
