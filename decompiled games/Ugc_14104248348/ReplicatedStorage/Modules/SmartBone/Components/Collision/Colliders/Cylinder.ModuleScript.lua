-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Components.Collision.Colliders.Cylinder
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local function u29(p1, p2, p3) --[[ Line: 25 ]]
    local v4 = (p2.Y < p2.Z and p2.Y or p2.Z) * 0.5;
    local v5 = p2.X * 0.5;
    local l__Position__1 = p1.Position;
    local l__RightVector__2 = p1.RightVector;
    local v6 = (p3 - l__Position__1):Dot(l__RightVector__2);
    local v7 = math.clamp(v6, -v5, v5);
    local v8 = l__Position__1 + l__RightVector__2 * v7;
    local v9 = p1.Position + -p1.RightVector * v5;
    local v10 = p1.Position + p1.RightVector * v5;
    local v11 = -p1.RightVector;
    local l__RightVector__3 = p1.RightVector;
    local v12 = p3 - (p3 - v9):Dot(v11) * v11;
    local v13 = p3 - (p3 - v10):Dot(l__RightVector__3) * l__RightVector__3;
    local v14 = v12 - v9;
    local v15 = v14.Magnitude == 0 and Vector3.new(0, 0, 0) or v14.Unit;
    local l__Magnitude__4 = (v12 - v9).Magnitude;
    local v16;
    if l__Magnitude__4 < v4 then
        v16 = l__Magnitude__4 or v4;
    else
        v16 = v4;
    end;
    local v17 = v9 + v15 * v16;
    local v18 = v13 - v10;
    local v19 = v18.Magnitude == 0 and Vector3.new(0, 0, 0) or v18.Unit;
    local l__Magnitude__5 = (v13 - v10).Magnitude;
    local v20;
    if l__Magnitude__5 < v4 then
        v20 = l__Magnitude__5 or v4;
    else
        v20 = v4;
    end;
    local v21 = v10 + v19 * v20;
    local l__Magnitude__6 = (v8 - p3).Magnitude;
    local v22 = p3 - v8;
    local v23 = v22.Magnitude == 0 and Vector3.new(0, 0, 0) or v22.Unit;
    local v24 = l__Magnitude__6 <= v4;
    local v25 = v8 + v23 * v4;
    local l__Magnitude__7 = (v21 - p3).Magnitude;
    local l__Magnitude__8 = (v17 - p3).Magnitude;
    local v26 = math.min(l__Magnitude__7, l__Magnitude__8, (v25 - p3).Magnitude);
    if v7 == v5 or v26 == l__Magnitude__7 then
        local v27 = p3 - v21;
        return (v27.Magnitude == 0 and Vector3.new(0, 0, 0) or v27.Unit):Dot(l__RightVector__3) < 0, v21, l__RightVector__3;
    end;
    if v7 ~= -v5 and v26 ~= l__Magnitude__8 then
        return v24, v25, v23;
    end;
    local v28 = p3 - v17;
    return (v28.Magnitude == 0 and Vector3.new(0, 0, 0) or v28.Unit):Dot(v11) < 0, v17, v11;
end;
return function(p30, p31, p32, p33) --[[ Line: 70 ]]
    -- upvalues: u29 (copy)
    local v34, v35, v36 = u29(p30, p31, p32);
    if v34 then
        return v34, v35, v36;
    else
        return (v35 - p32).Magnitude < p33, v35, v36;
    end;
end;
