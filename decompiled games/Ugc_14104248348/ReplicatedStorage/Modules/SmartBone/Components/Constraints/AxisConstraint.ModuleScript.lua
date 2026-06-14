-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Components.Constraints.AxisConstraint
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3, p4) --[[ Line: 11 ]]
    local v5 = p4:Inverse() * p2;
    local l__X__1 = v5.X;
    local l__Y__2 = v5.Y;
    local l__Z__3 = v5.Z;
    local l__XAxisLimits__4 = p1.XAxisLimits;
    local l__YAxisLimits__5 = p1.YAxisLimits;
    local l__ZAxisLimits__6 = p1.ZAxisLimits;
    local v6 = p1.AxisLocked[1] and 0 or 1;
    local v7 = p1.AxisLocked[2] and 0 or 1;
    local v8 = p1.AxisLocked[3] and 0 or 1;
    if l__XAxisLimits__4.Min == (-1 / 0) and (l__XAxisLimits__4.Max == (1 / 0) and (l__YAxisLimits__5.Min == (-1 / 0) and (l__YAxisLimits__5.Max == (1 / 0) and (l__ZAxisLimits__6.Min == (-1 / 0) and l__ZAxisLimits__6.Max == (1 / 0))))) then
        if v6 == 1 and (v7 == 1 and v8 == 1) then
            return p2;
        else
            return p4 * Vector3.new(l__X__1 * v6, l__Y__2 * v7, l__Z__3 * v8);
        end;
    else
        local v9 = l__XAxisLimits__4.Min + p1.Radius;
        local v10;
        if v9 <= l__XAxisLimits__4.Max - p1.Radius then
            v10 = l__XAxisLimits__4.Max - p1.Radius or v9;
        else
            v10 = v9;
        end;
        local v11 = l__YAxisLimits__5.Min + p1.Radius;
        local v12;
        if v11 <= l__YAxisLimits__5.Max - p1.Radius then
            v12 = l__YAxisLimits__5.Max - p1.Radius or v11;
        else
            v12 = v11;
        end;
        local v13 = l__ZAxisLimits__6.Min + p1.Radius;
        local v14;
        if v13 <= l__ZAxisLimits__6.Max - p1.Radius then
            v14 = l__ZAxisLimits__6.Max - p1.Radius or v13;
        else
            v14 = v13;
        end;
        if l__X__1 < v9 and v9 then
            l__X__1 = v9;
        elseif v10 < l__X__1 then
            l__X__1 = v10 or l__X__1;
        end;
        if l__Y__2 < v11 and v11 then
            l__Y__2 = v11;
        elseif v12 < l__Y__2 then
            l__Y__2 = v12 or l__Y__2;
        end;
        if l__Z__3 < v13 and v13 then
            l__Z__3 = v13;
        elseif v14 < l__Z__3 then
            l__Z__3 = v14 or l__Z__3;
        end;
        local v15 = l__X__1 * v6;
        local v16 = l__Y__2 * v7;
        local v17 = l__Z__3 * v8;
        local v18 = p4 * Vector3.new(v15, v16, v17);
        local l__RightVector__7 = p4.RightVector;
        local l__UpVector__8 = p4.UpVector;
        local l__LookVector__9 = p4.LookVector;
        local v19 = v18 - p3;
        local v20 = v19.Magnitude == 0 and Vector3.new(0, 0, 0) or v19.Unit;
        if v15 ~= v5.X then
            if l__RightVector__7:Dot(v20) < 0 then
                l__RightVector__7 = -l__RightVector__7 or l__RightVector__7;
            end;
            p1:ClipVelocity(v18, l__RightVector__7);
        end;
        if v16 ~= v5.Y then
            if l__UpVector__8:Dot(v20) < 0 then
                l__UpVector__8 = -l__UpVector__8 or l__UpVector__8;
            end;
            p1:ClipVelocity(v18, l__UpVector__8);
        end;
        if v17 ~= v5.Z then
            if l__LookVector__9:Dot(v20) > 0 then
                l__LookVector__9 = -l__LookVector__9 or l__LookVector__9;
            end;
            p1:ClipVelocity(v18, l__LookVector__9);
        end;
        return v18;
    end;
end;
