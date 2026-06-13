-- Decompiled from: ReplicatedStorage.Modules.RotatedRegion3.Supports
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    PointCloud = function(p1, p2) --[[ Name: PointCloud, Line 16 ]]
        local v3 = p1[1];
        local v4 = p1[1]:Dot(p2);
        for v5 = 2, #p1 do
            local v6 = p1[v5]:Dot(p2);
            if v4 < v6 then
                v3 = p1[v5];
                v4 = v6;
            end;
        end;
        return v3;
    end,
    Cylinder = function(p7, p8) --[[ Name: Cylinder, Line 28 ]]
        local v9, v10 = unpack(p7);
        local v11 = v9:VectorToObjectSpace(p8);
        local v12 = math.min(v10.y, v10.z);
        local v13 = v11:Dot(Vector3.new(1, 0, 0));
        local v14 = Vector3.new(v10.x, 0, 0);
        local v15;
        if v13 == 0 then
            v15 = v11.Unit * v12;
        else
            local v16 = v13 > 0 and v14 and v14 or -v14;
            v15 = v16 + (Vector3.new(0, 0, 0) + -(Vector3.new(0, 0, 0) - v16):Dot(Vector3.new(1, 0, 0)) / v11:Dot(Vector3.new(1, 0, 0)) * v11 - v16).Unit * v12;
        end;
        return v9:PointToWorldSpace(v15);
    end,
    Ellipsoid = function(p17, p18) --[[ Name: Ellipsoid, Line 46 ]]
        local v19, v20 = unpack(p17);
        return v19:PointToWorldSpace(v20 * (v20 * v19:VectorToObjectSpace(p18)).Unit);
    end
};
