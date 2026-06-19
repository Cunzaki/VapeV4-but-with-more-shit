-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u22 = {
    queryBox = function(p1) --[[ Name: queryBox, Line 3 ]]
        return not p1 and Vector3.new(0, 0, 0) or Vector3.new(p1.x < 0 and -0.5 or 0.5, p1.y < 0 and -0.5 or 0.5, p1.z < 0 and -0.5 or 0.5);
    end,
    queryPseudoCylinder = function(p2) --[[ Name: queryPseudoCylinder, Line 17 ]]
        if not p2 then
            return Vector3.new(0, 0, 0);
        end;
        local v3 = math.abs(p2.y);
        local v4 = math.abs(p2.z);
        local v5 = math.max(v3, v4);
        local v6 = p2.x > 0 and Vector3.new(0.5, 0, 0) or Vector3.new(-0.5, 0, 0);
        if v5 == 0 then
            return v6;
        end;
        local v7 = 3 / v5;
        local v8 = math.round(v7 * p2.y);
        local v9 = math.round(v7 * p2.z);
        return v6 + Vector3.new(0, v8, v9).unit / 2;
    end,
    queryPseudoCylinderY = function(p10) --[[ Name: queryPseudoCylinderY, Line 42 ]]
        if p10 then
            local l__x__1 = p10.x;
            local l__y__2 = p10.y;
            local v11 = math.atan2(l__x__1, p10.z) + 0.1308996938995747;
            local v12 = v11 - v11 % 0.2617993877991494;
            if l__y__2 < 0 then
                local v13 = math.sin(v12) / 2;
                local v14 = math.cos(v12) / 2;
                return Vector3.new(v13, -0.5, v14);
            else
                local v15 = math.sin(v12) / 2;
                local v16 = math.cos(v12) / 2;
                return Vector3.new(v15, 0.5, v16);
            end;
        else
            return Vector3.new(0, 0, 0);
        end;
    end,
    queryPseudoConeY = function(p17) --[[ Name: queryPseudoConeY, Line 57 ]]
        if not p17 then
            return Vector3.new(0, 0, 0);
        end;
        local l__x__3 = p17.x;
        local l__y__4 = p17.y;
        local l__z__5 = p17.z;
        local v18 = math.atan2(l__x__3, l__z__5) + 0.1308996938995747;
        local v19 = v18 - v18 % 0.2617993877991494;
        if 4 * l__y__4 * l__y__4 > l__z__5 * l__z__5 + l__x__3 * l__x__3 then
            return Vector3.new(0, 0.5, 0);
        end;
        local v20 = math.sin(v19) / 2;
        local v21 = math.cos(v19) / 2;
        return Vector3.new(v20, -0.5, v21);
    end
};
local u23 = {
    Vector3.new(-0.5, -0.5, -0.5),
    Vector3.new(-0.5, -0.5, 0.5),
    Vector3.new(0.5, -0.5, -0.5),
    Vector3.new(0.5, -0.5, 0.5),
    Vector3.new(0.5, 0.5, -0.5)
};
function u22.queryCornerWedge(p24) --[[ Line: 84 ]]
    -- upvalues: u23 (copy)
    if not p24 then
        return Vector3.new(0, 0, 0);
    end;
    local v25 = (-1 / 0);
    local v26 = nil;
    for _, v27 in next, u23 do
        local v28 = v27:Dot(p24);
        if v25 < v28 then
            v26 = v27;
            v25 = v28;
        end;
    end;
    return v26;
end;
local u29 = {
    Vector3.new(-0.5, -0.5, -0.5),
    Vector3.new(-0.5, -0.5, 0.5),
    Vector3.new(0.5, -0.5, -0.5),
    Vector3.new(0.5, -0.5, 0.5),
    Vector3.new(-0.5, 0.5, 0.5),
    Vector3.new(0.5, 0.5, 0.5)
};
function u22.queryWedge(p30) --[[ Line: 111 ]]
    -- upvalues: u29 (copy)
    if not p30 then
        return Vector3.new(0, 0, 0);
    end;
    local v31 = (-1 / 0);
    local v32 = nil;
    for _, v33 in next, u29 do
        local v34 = v33:Dot(p30);
        if v31 < v34 then
            v32 = v33;
            v31 = v34;
        end;
    end;
    return v32;
end;
function u22.queryPoint(_) --[[ Line: 129 ]]
    return Vector3.new(0, 0, 0);
end;
function u22.querySphere(p35) --[[ Line: 134 ]]
    if not p35 then
        return Vector3.new(0, 0, 0);
    end;
    local v36 = math.abs(p35.x);
    local v37 = math.abs(p35.y);
    local v38 = math.abs(p35.z);
    local v39 = 3 / math.max(v36, v37, v38) * p35;
    local v40 = math.round(v39.x);
    local v41 = math.round(v39.y);
    local v42 = math.round(v39.z);
    return Vector3.new(v40, v41, v42).unit / 2;
end;
function u22.transformUnitQuery(u43, u44, u45, p46) --[[ Line: 149 ]]
    return function(p47) --[[ Line: 150 ]]
        -- upvalues: u45 (copy), u44 (copy), u43 (copy)
        if p47 then
            p47 = u45 * u44:vectorToObjectSpace(p47);
        end;
        return u44 * (u45 * u43(p47));
    end, p46 or 0;
end;
local l__Block__6 = Enum.PartType.Block;
local l__Ball__7 = Enum.PartType.Ball;
local l__Cylinder__8 = Enum.PartType.Cylinder;
local l__Wedge__9 = Enum.PartType.Wedge;
local l__CornerWedge__10 = Enum.PartType.CornerWedge;
local l__Wedge__11 = Enum.MeshType.Wedge;
local l__Sphere__12 = Enum.MeshType.Sphere;
local l__Cylinder__13 = Enum.MeshType.Cylinder;
local l__Brick__14 = Enum.MeshType.Brick;
local l__CornerWedge__15 = Enum.MeshType.CornerWedge;
local u48 = CFrame.new(0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 1);
function u22.getUnitQueryFuncFromPart(p49, p50, p51) --[[ Line: 175 ]]
    -- upvalues: u22 (copy), u48 (copy), l__Wedge__11 (copy), l__Wedge__9 (copy), l__Sphere__12 (copy), l__Cylinder__13 (copy), l__Cylinder__8 (copy), l__Brick__14 (copy), l__Block__6 (copy), l__CornerWedge__15 (copy), l__CornerWedge__10 (copy), l__Ball__7 (copy)
    local l__ClassName__16 = p49.ClassName;
    if l__ClassName__16 == "Part" then
        local v52 = nil;
        local v53 = p49:FindFirstChild("Mesh");
        if v53 then
            local l__ClassName__17 = v53.ClassName;
            if l__ClassName__17 == "CylinderMesh" then
                local l__queryPseudoCylinder__18 = u22.queryPseudoCylinder;
                local v54 = p50 * u48;
                local l__y__19 = p51.y;
                local v55 = math.min(p51.x, p51.z);
                local v56 = math.min(p51.x, p51.z);
                return l__queryPseudoCylinder__18, v54, Vector3.new(l__y__19, v55, v56);
            end;
            if l__ClassName__17 == "SpecialMesh" then
                local l__MeshType__20 = v53.MeshType;
                if l__MeshType__20 == l__Wedge__11 then
                    v52 = l__Wedge__9;
                else
                    if l__MeshType__20 == l__Sphere__12 then
                        return u22.querySphere, p50, p51;
                    end;
                    if l__MeshType__20 == l__Cylinder__13 then
                        v52 = l__Cylinder__8;
                    elseif l__MeshType__20 == l__Brick__14 then
                        v52 = l__Block__6;
                    elseif l__MeshType__20 == l__CornerWedge__15 then
                        v52 = l__CornerWedge__10;
                    end;
                end;
            end;
        else
            v52 = p49.Shape;
        end;
        if v52 ~= l__Block__6 then
            if v52 == l__Ball__7 then
                return u22.queryPoint, p50, p51, math.min(p51.x, p51.y, p51.z) / 2;
            end;
            if v52 == l__Cylinder__8 then
                local l__queryPseudoCylinder__21 = u22.queryPseudoCylinder;
                local l__x__22 = p51.x;
                local v57 = math.min(p51.y, p51.z);
                local v58 = math.min(p51.y, p51.z);
                return l__queryPseudoCylinder__21, p50, Vector3.new(l__x__22, v57, v58);
            end;
            if v52 == l__Wedge__9 then
                return u22.queryWedge, p50, p51;
            end;
            if v52 == l__CornerWedge__10 then
                return u22.queryCornerWedge, p50, p51;
            end;
        end;
    else
        if l__ClassName__16 == "WedgePart" then
            return u22.queryWedge, p50, p51;
        end;
        if l__ClassName__16 == "CornerWedgePart" then
            return u22.queryCornerWedge, p50, p51;
        end;
        if l__ClassName__16 == "MeshPart" and p49.MeshId == "rbxassetid://1778999" then
            return u22.queryPseudoConeY, p50, p51;
        end;
    end;
    return u22.queryBox, p50, p51;
end;
function u22.makeQueryFuncFromPart(p59, p60) --[[ Line: 226 ]]
    -- upvalues: u22 (copy)
    return u22.transformUnitQuery(u22.getUnitQueryFuncFromPart(p59, p60, p59.Size));
end;
function u22.makeFurthestPointYBiPyramidMidRiff(u61, p62, p63, u64, p65) --[[ Line: 231 ]]
    local u66 = 6.283185307179586 / p65;
    local u67 = Vector3.new(0, p62, 0);
    local u68 = Vector3.new(0, p63, 0);
    local u69 = p62 - p63;
    return function(p70) --[[ Line: 238 ]]
        -- upvalues: u61 (copy), u66 (copy), u64 (copy), u69 (copy), u67 (copy), u68 (copy)
        if p70 then
            local v71 = math.atan2(p70.x, p70.z) + u66 / 2;
            local v72 = v71 - v71 % u66;
            local v73 = u64 * math.cos(v72);
            local v74 = u64 * math.sin(v72);
            local v75 = Vector3.new(v74, 0, v73);
            local v76 = v75:Dot(p70);
            local v77 = u69 * p70.y;
            if v76 < v77 then
                return u61 + u67;
            elseif v76 < -v77 then
                return u61 - u67;
            elseif p70.y > 0 then
                return u61 + u68 + v75;
            elseif p70.y < 0 then
                return u61 - u68 + v75;
            else
                return u61 + v75;
            end;
        else
            return u61;
        end;
    end;
end;
function u22.makeFurthestPointRegularPrismYFunctionWorldSpace(p78, p79, p80, _) --[[ Line: 267 ]]
    -- upvalues: u22 (copy)
    return u22.transformUnitQuery(u22.queryPseudoCylinderY, CFrame.new(p78), (Vector3.new(2 * p80, p79, 2 * p80)));
end;
function u22.makeFurthestPointConeFunction(p81, p82) --[[ Line: 271 ]]
    -- upvalues: u22 (copy)
    return u22.transformUnitQuery(u22.queryPseudoConeY, p81, p82);
end;
return u22;
