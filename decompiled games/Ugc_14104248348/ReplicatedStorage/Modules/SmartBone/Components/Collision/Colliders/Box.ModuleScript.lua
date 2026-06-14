-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Components.Collision.Colliders.Box
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local function u17(p1, p2, p3) --[[ Line: 9 ]]
    local v4 = p1:pointToObjectSpace(p3);
    local l__x__1 = p2.x;
    local l__y__2 = p2.y;
    local l__z__3 = p2.z;
    local l__x__4 = v4.x;
    local l__y__5 = v4.y;
    local l__z__6 = v4.z;
    local v5 = math.clamp(l__x__4, -l__x__1 * 0.5, l__x__1 * 0.5);
    local v6 = math.clamp(l__y__5, -l__y__2 * 0.5, l__y__2 * 0.5);
    local v7 = math.clamp(l__z__6, -l__z__3 * 0.5, l__z__3 * 0.5);
    if v5 ~= l__x__4 or (v6 ~= l__y__5 or v7 ~= l__z__6) then
        local v8 = p1 * Vector3.new(v5, v6, v7);
        local v9 = p3 - v8;
        return false, v8, v9.Magnitude == 0 and Vector3.new(0, 0, 0) or v9.Unit;
    end;
    local v10 = l__x__4 - l__x__1 * 0.5;
    local v11 = l__y__5 - l__y__2 * 0.5;
    local v12 = l__z__6 - l__z__3 * 0.5;
    local v13 = -l__x__4 - l__x__1 * 0.5;
    local v14 = -l__y__5 - l__y__2 * 0.5;
    local v15 = -l__z__6 - l__z__3 * 0.5;
    local v16 = math.max(v10, v11, v12, v13, v14, v15);
    if v16 == v10 then
        return true, p1 * Vector3.new(l__x__1 * 0.5, l__y__5, l__z__6), p1.XVector;
    end;
    if v16 == v11 then
        return true, p1 * Vector3.new(l__x__4, l__y__2 * 0.5, l__z__6), p1.YVector;
    end;
    if v16 == v12 then
        return true, p1 * Vector3.new(l__x__4, l__y__5, l__z__3 * 0.5), p1.ZVector;
    end;
    if v16 == v13 then
        return true, p1 * Vector3.new(-l__x__1 * 0.5, l__y__5, l__z__6), -p1.XVector;
    end;
    if v16 == v14 then
        return true, p1 * Vector3.new(l__x__4, -l__y__2 * 0.5, l__z__6), -p1.YVector;
    end;
    if v16 == v15 then
        return true, p1 * Vector3.new(l__x__4, l__y__5, -l__z__3 * 0.5), -p1.ZVector;
    end;
    warn("CLOSEST POINT ON BOX FAIL");
    return false, p1.Position, Vector3.new(0, 0, 0);
end;
return function(p18, p19, p20, p21) --[[ Line: 60 ]]
    -- upvalues: u17 (copy)
    local v22, v23, v24 = u17(p18, p19, p20);
    if v22 then
        return v22, v23, v24;
    else
        return (v23 - p20).Magnitude < p21, v23, v24;
    end;
end;
