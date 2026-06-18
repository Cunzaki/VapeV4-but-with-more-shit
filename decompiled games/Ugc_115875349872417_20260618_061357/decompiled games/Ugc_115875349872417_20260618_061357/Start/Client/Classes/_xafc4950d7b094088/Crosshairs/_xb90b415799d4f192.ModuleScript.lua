-- Decompiled from: Start.Client.Classes._xafc4950d7b094088.Crosshairs._xb90b415799d4f192
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

local l___x7bf32b206fec7a03__1 = require(script.Parent.Parent._x7bf32b206fec7a03);
local l__Instances__2 = script:FindFirstAncestor("Client"):WaitForChild("Instances");
local u1 = {};
u1.__index = u1;
setmetatable(u1, l___x7bf32b206fec7a03__1);
function u1._x90d4581ac99dd483() --[[ Line: 8 ]]
    -- upvalues: l___x7bf32b206fec7a03__1 (copy), l__Instances__2 (copy), u1 (copy)
    local v2 = l___x7bf32b206fec7a03__1._x90d4581ac99dd483({
        priority = 2,
        name = script.Name,
        screenspace = { "OUTER-CENTER" }
    });
    v2._x67de9152dd429711 = l__Instances__2.GrapplerCrosshair:Clone();
    v2._x6679dae12d5569bf = true;
    v2._x9d0c0a6d51e5104c = true;
    setmetatable(v2, u1);
    return v2;
end;
function u1._x449065fc95251217(_) --[[ Line: 24 ]] end;
function u1._x4209447529b7cd98(p3) --[[ Line: 28 ]]
    p3._x67de9152dd429711.Visible = p3._x9d0c0a6d51e5104c;
end;
function u1._x8fcdafeb8ad3312d(p4) --[[ Line: 32 ]]
    p4._x67de9152dd429711.Visible = p4._x9d0c0a6d51e5104c;
end;
function u1.cleanUp(p5) --[[ Line: 36 ]]
    p5:_xd00fdb58a7e8416d();
end;
function u1._xe53615d96cf36a6b(p6) --[[ Line: 40 ]]
    p6._x67de9152dd429711.Parent = p6:_x8b1e37aadfd94696();
end;
return u1;
