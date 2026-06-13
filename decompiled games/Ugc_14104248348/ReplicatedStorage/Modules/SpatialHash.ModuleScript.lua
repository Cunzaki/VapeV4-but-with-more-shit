-- Decompiled from: ReplicatedStorage.Modules.SpatialHash
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u4 = {
    Axis = Vector3.new(1, 0, 1),
    Version = "0.1",
    Round = math.round,
    GridID = function(p1) --[[ Name: GridID, Line 11 ]]
        local v2 = "";
        for _ = 1, p1 or 8 do
            v2 = v2 .. string.format("%x", math.random(0, 255));
        end;
        return v2;
    end,
    MapPositionToGridID = function(p3) --[[ Name: MapPositionToGridID, Line 20 ]]
        return string.format("%x", p3.X) .. string.format("%x", p3.Y) .. string.format("%x", p3.Z);
    end
};
function u4.MapPosition(p5, p6) --[[ Line: 26 ]]
    -- upvalues: u4 (copy)
    local v7 = u4.Round(p6.X / p5.Size) * p5.Size;
    local v8 = u4.Round(p6.Z / p5.Size) * p5.Size;
    return Vector3.new(v7 / p5.Size, v8 / p5.Size);
end;
function u4.NewMap(p9, u10) --[[ Line: 33 ]]
    -- upvalues: u4 (copy)
    local u11 = {
        Object = {},
        Location = {},
        Size = p9
    };
    function u11.Insert(p12, p13) --[[ Line: 40 ]]
        -- upvalues: u11 (copy), u4 (ref)
        local v14 = u11.Object[p12];
        if not v14 then
            u11.Object[p12] = {};
            v14 = u11.Object[p12];
        end;
        v14.ID = u4.GridID();
        table.insert(u11.Location[p13], p12);
        table.insert(v14, p13);
    end;
    function u11.Remove(p15, p16) --[[ Line: 55 ]]
        -- upvalues: u11 (copy)
        local v17 = u11.Object[p15];
        if v17 then
            table.remove(v17, table.find(v17, p16));
            if #v17 == 0 then
                u11.Object[p15] = nil;
            end;
        end;
    end;
    function u11.GetPartsInPart(p18) --[[ Line: 66 ]]
        -- upvalues: u4 (ref), u11 (copy)
        local l__Size__1 = p18.Size;
        local v19 = p18.Position - l__Size__1 / 2;
        local v20 = p18.Position + l__Size__1 / 2;
        local v21 = u4.MapPosition(u11, v19);
        local v22 = u4.MapPosition(u11, v20);
        local v23 = {};
        for v24 = v21.X, v22.X do
            for v25 = v21.Y, v22.Y do
                local v26 = Vector3.new(v24, v25);
                local v27 = u11.Object[v26];
                if v27 then
                    for _, v28 in v27 do
                        table.insert(v23, v28);
                    end;
                end;
            end;
        end;
        return v23;
    end;
    function u11.GetPartsInRadius(p29, p30, p31) --[[ Line: 93 ]]
        -- upvalues: u4 (ref), u11 (copy)
        local v32 = u4.MapPosition(u11, p29);
        local v33 = p30 + 0.5;
        local v34 = (v33 * 2 - 1) / 2;
        local v35 = {};
        for v36 = v32.X - v34, v32.X + v34 do
            for v37 = v32.Y - v34, v32.Y + v34 do
                local v38 = Vector3.new(v36, v37);
                local l__Magnitude__2 = (v32 - v38).Magnitude;
                local v39 = u11.Object[v38];
                if v39 and l__Magnitude__2 < v33 or p31 then
                    for _, v40 in ipairs(v39) do
                        if not v35[v40] then
                            v35[v40] = true;
                            table.insert(v35, v40);
                        end;
                    end;
                end;
            end;
        end;
        return v35;
    end;
    function u11.GetMapPosition(p41) --[[ Line: 122 ]]
        -- upvalues: u4 (ref), u11 (copy)
        return u4.MapPosition(u11, p41);
    end;
    function u11.GetMapID(p42) --[[ Line: 126 ]]
        -- upvalues: u4 (ref), u11 (copy)
        local v43 = u4.MapPosition(u11, p42);
        local v44 = u11.Object[v43];
        return v44 and v44.ID or u4.MapPositionToGridID(v43), v44 or {};
    end;
    function u11.GetPartsAtPosition(p45) --[[ Line: 132 ]]
        -- upvalues: u4 (ref), u11 (copy)
        local v46 = u4.MapPosition(u11, p45);
        return u11.Object[v46] or {};
    end;
    function u11.Add(p47) --[[ Line: 137 ]]
        -- upvalues: u4 (ref), u11 (copy), u10 (copy)
        u4.InsertBasePart(u11, p47, u10);
    end;
    return u11;
end;
function u4.UpdateBasePart(p48, p49) --[[ Line: 145 ]]
    -- upvalues: u4 (copy)
    local v50 = p48.Location[p49];
    if v50 then
        for _, v51 in v50 do
            p48.Remove(v51, p49);
        end;
    end;
    p48.Location[p49] = {};
    local v52 = p49.Size * u4.Axis;
    local l__Orientation__3 = p49.Orientation;
    local v53;
    if l__Orientation__3.X % 90 == 0 and l__Orientation__3.Y % 90 == 0 then
        v53 = l__Orientation__3.Z % 90 == 0;
    else
        v53 = false;
    end;
    if v53 then
        local v54 = p49.Position - v52 / 2;
        local v55 = p49.Position + v52 / 2;
        local v56 = u4.MapPosition(p48, v54);
        local v57 = u4.MapPosition(p48, v55);
        for v58 = v56.X, v57.X do
            for v59 = v56.Y, v57.Y do
                local v60 = Vector3.new(v58, v59);
                p48.Insert(v60, p49);
            end;
        end;
    else
        local v61 = -(v52 / 2);
        local v62 = v52 / 2;
        for v63 = v61.X, v62.X do
            for v64 = v61.Z, v62.Z do
                local l__Position__4 = p49.CFrame:ToWorldSpace(CFrame.new(v63, 0, v64)).Position;
                local v65 = u4.MapPosition(p48, l__Position__4);
                p48.Insert(v65, p49);
            end;
        end;
    end;
end;
function u4.InsertBasePart(u66, u67, p68) --[[ Line: 192 ]]
    -- upvalues: u4 (copy)
    u4.UpdateBasePart(u66, u67);
    if p68 then
        u67:GetPropertyChangedSignal("Position"):Connect(function() --[[ Line: 196 ]]
            -- upvalues: u4 (ref), u66 (copy), u67 (copy)
            u4.UpdateBasePart(u66, u67);
        end);
        u67:GetPropertyChangedSignal("Size"):Connect(function() --[[ Line: 199 ]]
            -- upvalues: u4 (ref), u66 (copy), u67 (copy)
            u4.UpdateBasePart(u66, u67);
        end);
    end;
    if u67.Destroying then
        u67.Destroying:Connect(function() --[[ Line: 205 ]]
            -- upvalues: u66 (copy), u67 (copy)
            local v69 = u66.Location[u67];
            if v69 then
                for _, v70 in v69 do
                    u66.Remove(v70, u67);
                end;
            end;
            u66.Location[u67] = nil;
        end);
    end;
end;
return u4;
