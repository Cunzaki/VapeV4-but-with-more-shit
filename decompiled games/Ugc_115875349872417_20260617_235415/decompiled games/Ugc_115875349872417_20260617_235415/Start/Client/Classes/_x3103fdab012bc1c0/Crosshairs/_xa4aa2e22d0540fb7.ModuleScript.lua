-- Decompiled from: Start.Client.Classes._x3103fdab012bc1c0.Crosshairs._xa4aa2e22d0540fb7
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l___xd9651ce0ed707b35__1 = require(script.Parent.Parent._xd9651ce0ed707b35);
local l__Instances__2 = script:FindFirstAncestor("Client"):WaitForChild("Instances");
local u1 = {};
u1.__index = u1;
setmetatable(u1, l___xd9651ce0ed707b35__1);
function u1._xafd29f1684593d0b() --[[ Line: 17 ]]
    -- upvalues: l___xd9651ce0ed707b35__1 (copy), l__Instances__2 (copy), u1 (copy)
    local v2 = l___xd9651ce0ed707b35__1._xafd29f1684593d0b({
        priority = 2,
        name = script.Name,
        screenspace = { "OUTER-CENTER" }
    });
    v2._x381bb2c0bb6b001d = l__Instances__2.GrapplerCrosshair:Clone();
    v2._x30b7fa927c2a08c1 = true;
    v2._x749d90cdd9e719a2 = true;
    setmetatable(v2, u1);
    return v2;
end;
function u1._xf7257db113ac48be(_) --[[ Line: 33 ]] end;
function u1._x4a2acc75c78612a5(p3) --[[ Line: 37 ]]
    p3._x381bb2c0bb6b001d.Visible = p3._x749d90cdd9e719a2;
end;
function u1._xcc5f292712de0f3a(p4) --[[ Line: 41 ]]
    p4._x381bb2c0bb6b001d.Visible = p4._x749d90cdd9e719a2;
end;
function u1.cleanUp(p5) --[[ Line: 45 ]]
    p5:_x6248c17a976ba5a4();
end;
function u1._xd8041402b83e75db(p6) --[[ Line: 49 ]]
    p6._x381bb2c0bb6b001d.Parent = p6:_x3932c200bdc15bb5();
end;
return u1;
