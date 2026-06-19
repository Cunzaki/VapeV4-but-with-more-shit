-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__band__1 = bit32.band;
local l__lshift__2 = bit32.lshift;
local u1 = {
    Boolean = false,
    Integer = 0,
    Vector2 = Vector2.zero
};
local v2 = 0;
local u3 = {};
local u4 = {};
local v5 = {};
v2 = v2 + 1;
u3[v2] = "Boolean";
u4[v2] = "MoveForward";
v5[v2] = "W";
v2 = v2 + 1;
u3[v2] = "Boolean";
u4[v2] = "MoveLeft";
v5[v2] = "A";
v2 = v2 + 1;
u3[v2] = "Boolean";
u4[v2] = "MoveBack";
v5[v2] = "S";
v2 = v2 + 1;
u3[v2] = "Boolean";
u4[v2] = "MoveRight";
v5[v2] = "D";
v2 = v2 + 1;
u3[v2] = "Boolean";
u4[v2] = "MoveUp";
v5[v2] = "E";
v2 = v2 + 1;
u3[v2] = "Boolean";
u4[v2] = "MoveDown";
v5[v2] = "Q";
v2 = v2 + 1;
u3[v2] = "Boolean";
u4[v2] = "LookUp";
v5[v2] = nil;
v2 = v2 + 1;
u3[v2] = "Boolean";
u4[v2] = "LookLeft";
v5[v2] = nil;
v2 = v2 + 1;
u3[v2] = "Boolean";
u4[v2] = "LookDown";
v5[v2] = nil;
v2 = v2 + 1;
u3[v2] = "Boolean";
u4[v2] = "LookRight";
v5[v2] = nil;
v2 = v2 + 1;
u3[v2] = "Boolean";
u4[v2] = "Jump";
v5[v2] = "Space";
v2 = v2 + 1;
u3[v2] = "Boolean";
u4[v2] = "Crouch";
v5[v2] = "LeftControl";
v2 = v2 + 1;
u3[v2] = "Boolean";
u4[v2] = "Sprint";
v5[v2] = "LeftShift";
v2 = v2 + 1;
u3[v2] = "Boolean";
u4[v2] = "Zoom";
v5[v2] = "Z";
v2 = v2 + 1;
u3[v2] = "Boolean";
u4[v2] = "Use";
v5[v2] = "F";
v2 = v2 + 1;
u3[v2] = "Boolean";
u4[v2] = "Action1";
v5[v2] = "MouseButton1";
v2 = v2 + 1;
u3[v2] = "Boolean";
u4[v2] = "Action2";
v5[v2] = "MouseButton2";
local u6 = v2;
v2 = v2 + 1;
u3[v2] = "Vector2";
u4[v2] = "MousePos";
v5[v2] = nil;
v2 = v2 + 1;
u3[v2] = "Integer";
u4[v2] = "ScrollPos";
v5[v2] = nil;
local u7 = v2;
local u8 = {};
for v9 = 1, v2 do
    u8[u4[v9]] = v9;
end;
return {
    PackageControls = function(p10) --[[ Name: PackageControls, Line 52 ]]
        -- upvalues: u6 (copy), u4 (copy), l__lshift__2 (copy)
        local v11 = 0;
        for v12 = 1, u6 do
            if p10[u4[v12]] then
                v11 = v11 + l__lshift__2(1, v12 - 1);
            end;
        end;
        return p10.Time, v11, p10.MousePos, p10.ScrollPos;
    end,
    UnpackageControls = function(p13, p14, p15) --[[ Name: UnpackageControls, Line 62 ]]
        -- upvalues: u6 (copy), l__lshift__2 (copy), u4 (copy), l__band__1 (copy)
        local v16 = {};
        for v17 = 1, u6 do
            local v18 = l__lshift__2(1, v17 - 1);
            v16[u4[v17]] = l__band__1(p14, v18) == v18;
        end;
        v16.Time = p13;
        v16.MousePos = p15;
        return v16;
    end,
    BlankGameControls = function() --[[ Name: BlankGameControls, Line 72 ]]
        -- upvalues: u7 (ref), u4 (copy), u1 (copy), u3 (copy)
        local v19 = {};
        for v20 = 1, u7 do
            v19[u4[v20]] = u1[u3[v20]];
        end;
        v19.Time = 0;
        return v19;
    end,
    GetControlBit = function(p21) --[[ Name: GetControlBit, Line 80 ]]
        -- upvalues: u8 (copy), l__lshift__2 (copy)
        return l__lshift__2(1, u8[p21] - 1);
    end,
    GetControlState = function(p22, p23) --[[ Name: GetControlState, Line 83 ]]
        -- upvalues: u8 (copy), l__lshift__2 (copy), l__band__1 (copy)
        local v24 = l__lshift__2(1, u8[p23] - 1);
        return l__band__1(p22, v24) == v24;
    end,
    NBooleanControls = u6,
    ControlTypes = u3,
    ControlNames = u4,
    ControlBinds = v5
};
