-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = assert;
local l__new__1 = Region3.new;
local l__new__2 = Vector3.new;
local u2 = {
    Vector3.new(1, 1, 1),
    Vector3.new(1, 1, -1),
    Vector3.new(1, -1, 1),
    Vector3.new(1, -1, -1),
    Vector3.new(-1, 1, 1),
    Vector3.new(-1, 1, -1),
    Vector3.new(-1, -1, 1),
    Vector3.new(-1, -1, -1)
};
local function u15(p3, p4) --[[ Line: 51 ]]
    -- upvalues: l__new__2 (copy), u2 (copy), l__new__1 (copy)
    local u5 = (1 / 0);
    local u6 = (1 / 0);
    local u7 = (1 / 0);
    local u8 = (-1 / 0);
    local u9 = (-1 / 0);
    local u10 = (-1 / 0);
    local function v12(p11) --[[ Line: 14 ]]
        -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref)
        u5 = p11.x < u5 and p11.x or u5;
        u6 = p11.y < u6 and p11.y or u6;
        u7 = p11.z < u7 and p11.z or u7;
        u8 = u8 < p11.x and p11.x or u8;
        u9 = u9 < p11.y and p11.y or u9;
        u10 = u10 < p11.z and p11.z or u10;
    end;
    local function v13() --[[ Line: 22 ]]
        -- upvalues: u5 (ref), u6 (ref), u7 (ref), l__new__2 (ref), u8 (ref), u9 (ref), u10 (ref)
        return l__new__2(u5, u6, u7), l__new__2(u8, u9, u10);
    end;
    for v14 = 1, #u2 do
        v12(p3 * (p4 * u2[v14]));
    end;
    return l__new__1(v13());
end;
return {
    BoundingBox = function() --[[ Name: BoundingBox, Line 7 ]]
        -- upvalues: l__new__2 (copy)
        local u16 = (1 / 0);
        local u17 = (1 / 0);
        local u18 = (1 / 0);
        local u19 = (-1 / 0);
        local u20 = (-1 / 0);
        local u21 = (-1 / 0);
        return function(p22) --[[ Line: 14 ]]
            -- upvalues: u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref)
            u16 = p22.x < u16 and p22.x or u16;
            u17 = p22.y < u17 and p22.y or u17;
            u18 = p22.z < u18 and p22.z or u18;
            u19 = u19 < p22.x and p22.x or u19;
            u20 = u20 < p22.y and p22.y or u20;
            u21 = u21 < p22.z and p22.z or u21;
        end, function() --[[ Line: 22 ]]
            -- upvalues: u16 (ref), u17 (ref), u18 (ref), l__new__2 (ref), u19 (ref), u20 (ref), u21 (ref)
            return l__new__2(u16, u17, u18), l__new__2(u19, u20, u21);
        end;
    end,
    BoundingSphere = function(u23) --[[ Name: BoundingSphere, Line 26 ]]
        -- upvalues: u1 (copy)
        u1(u23 ~= nil, "Must give initial point");
        local u24 = 0;
        return function(p25) --[[ Line: 29 ]]
            -- upvalues: u23 (ref), u24 (ref)
            local l__magnitude__3 = (p25 - u23).magnitude;
            if u24 < l__magnitude__3 then
                u24 = (u24 + l__magnitude__3) / 2;
                u23 = (u23 * u24 + p25 * (l__magnitude__3 - u24)) / l__magnitude__3;
            end;
        end, function() --[[ Line: 37 ]]
            -- upvalues: u23 (ref), u24 (ref)
            return u23, u24;
        end;
    end,
    FromPart = function(p26) --[[ Name: FromPart, Line 58 ]]
        -- upvalues: u15 (copy)
        return u15(p26.CFrame, p26.Size / 2);
    end,
    FromPositionHalfSize = function(p27, p28) --[[ Name: FromPositionHalfSize, Line 66 ]]
        -- upvalues: l__new__1 (copy)
        return l__new__1(p27 - p28, p27 + p28);
    end,
    AddCFrameHalfSize = function(p29, p30, p31) --[[ Name: AddCFrameHalfSize, Line 61 ]]
        -- upvalues: u2 (copy)
        for v32 = 1, #u2 do
            p29(p30 * (p31 * u2[v32]));
        end;
    end,
    FromCFrameHalfSize = u15,
    FromAxisAlignedPart = function(p33) --[[ Name: FromAxisAlignedPart, Line 69 ]]
        -- upvalues: l__new__1 (copy)
        local l__Position__4 = p33.Position;
        local v34 = p33.Size / 2;
        return l__new__1(l__Position__4 - v34, l__Position__4 + v34);
    end
};
