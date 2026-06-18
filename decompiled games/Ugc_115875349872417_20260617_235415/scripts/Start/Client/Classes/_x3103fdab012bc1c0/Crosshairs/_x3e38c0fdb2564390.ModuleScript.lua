-- Decompiled from: Start.Client.Classes._x3103fdab012bc1c0.Crosshairs._x3e38c0fdb2564390
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l___xd9651ce0ed707b35__1 = require(script.Parent.Parent._xd9651ce0ed707b35);
local l__Instances__2 = script:FindFirstAncestor("Client"):WaitForChild("Instances");
local u1 = {};
u1.__index = u1;
setmetatable(u1, l___xd9651ce0ed707b35__1);
function u1._xafd29f1684593d0b(_) --[[ Line: 17 ]]
    -- upvalues: l___xd9651ce0ed707b35__1 (copy), l__Instances__2 (copy), u1 (copy)
    local v2 = l___xd9651ce0ed707b35__1._xafd29f1684593d0b({
        priority = 1,
        name = script.Name,
        screenspace = { "CENTER" }
    });
    v2._x381bb2c0bb6b001d = l__Instances__2.MeleeCrosshair:Clone();
    v2._x30b7fa927c2a08c1 = true;
    v2._x749d90cdd9e719a2 = true;
    setmetatable(v2, u1);
    return v2;
end;
function u1._xf7257db113ac48be(p3) --[[ Line: 33 ]]
    p3._x381bb2c0bb6b001d.Rotation = p3:_xa5bf5f5d86c85c9c();
    p3._x381bb2c0bb6b001d.Position = p3:_x4a104c3ca06bfdda();
end;
function u1._x4a2acc75c78612a5(p4) --[[ Line: 39 ]]
    p4._x381bb2c0bb6b001d.Visible = p4._x749d90cdd9e719a2;
end;
function u1._xcc5f292712de0f3a(p5) --[[ Line: 43 ]]
    p5._x381bb2c0bb6b001d.Visible = p5._x749d90cdd9e719a2;
end;
function u1.cleanUp(p6) --[[ Line: 47 ]]
    p6:_x6248c17a976ba5a4();
end;
function u1._xd8041402b83e75db(p7) --[[ Line: 51 ]]
    p7._x381bb2c0bb6b001d.Parent = p7:_x3932c200bdc15bb5();
end;
return u1;
