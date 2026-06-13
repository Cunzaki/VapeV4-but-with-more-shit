-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Components.Collision.Colliders.Triangle
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Dot__1 = Vector3.new().Dot;
local l__Cross__2 = Vector3.new().Cross;
local l__clamp__3 = math.clamp;
return function(p1, p2, p3, p4) --[[ Name: ClosestPointOnTri, Line 52 ]]
    -- upvalues: l__Dot__1 (copy), l__clamp__3 (copy), l__Cross__2 (copy)
    local v5 = p2 - p1;
    local v6 = p1 + l__clamp__3(l__Dot__1(p4 - p1, v5) / l__Dot__1(v5, v5), 0, 1) * v5;
    local v7 = p3 - p2;
    local v8 = p2 + l__clamp__3(l__Dot__1(p4 - p2, v7) / l__Dot__1(v7, v7), 0, 1) * v7;
    local v9 = p1 - p3;
    local v10 = p3 + l__clamp__3(l__Dot__1(p4 - p3, v9) / l__Dot__1(v9, v9), 0, 1) * v9;
    local v11 = l__Cross__2(p2 - p1, p3 - p1);
    local v12 = v11.Magnitude == 0 and Vector3.new(0, 0, 0) or v11.Unit;
    local v13 = p4 - (p4 - (p1 + p2 + p3) * 0.3333):Dot(v12) * v12;
    local v14;
    if l__Dot__1(l__Cross__2(p3 - p2, p4 - p2), (l__Cross__2(p3 - p2, p1 - p2))) >= 0 and l__Dot__1(l__Cross__2(p3 - p1, p4 - p1), (l__Cross__2(p3 - p1, p2 - p1))) >= 0 then
        v14 = l__Dot__1(l__Cross__2(p2 - p1, p4 - p1), (l__Cross__2(p2 - p1, p3 - p1))) >= 0;
    else
        v14 = false;
    end;
    if v14 then
        return v13, v12;
    else
        local l__Magnitude__4 = (v6 - p4).Magnitude;
        local l__Magnitude__5 = (v8 - p4).Magnitude;
        local l__Magnitude__6 = (v10 - p4).Magnitude;
        local v15 = math.min(l__Magnitude__4, l__Magnitude__5, l__Magnitude__6);
        if v15 == l__Magnitude__4 then
            return v6, v12;
        elseif v15 == l__Magnitude__5 then
            return v8, v12;
        elseif v15 == l__Magnitude__6 then
            return v10, v12;
        else
            return p4, v12;
        end;
    end;
end;
