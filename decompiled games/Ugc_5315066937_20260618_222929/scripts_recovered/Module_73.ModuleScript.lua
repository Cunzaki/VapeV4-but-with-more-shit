-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__clear__1 = table.clear;
local l__obtain__2 = _G.obtain;
local u1 = l__obtain__2("LabelPrint");
local u2 = l__obtain__2("L1Copy");
local l__makeQueryFuncFromPart__3 = l__obtain__2("Trey-GeometryQuery").makeQueryFuncFromPart;
local v3 = l__obtain__2("MapManager");
local l__Dot__4 = (Vector3.new(0, 0, 0)).Dot;
local v4 = CFrame.new();
local l__VectorToWorldSpace__5 = v4.VectorToWorldSpace;
local l__VectorToObjectSpace__6 = v4.VectorToObjectSpace;
local u5 = {};
local u6 = {};
local u7 = {};
v3.MapInfoChanged:Add(function() --[[ Name: Clear, Line 31 ]]
    -- upvalues: u1 (copy), l__clear__1 (copy), u5 (copy), u6 (copy), u7 (copy)
    u1("Clearing unions");
    l__clear__1(u5);
    l__clear__1(u6);
    l__clear__1(u7);
end);
local u8 = {
    Vector3.new(0, 0, 0.5),
    Vector3.new(0, -0.5, 0),
    Vector3.new(0, 0.5, -0.5),
    Vector3.new(0.5, 0, 0),
    Vector3.new(-0.5, 0, 0)
};
local u9 = { Vector3.new(0.5, 0, 0), Vector3.new(0.5, 0, 0), Vector3.new(0, 0.5, 0.5) };
local u10 = { Vector3.new(0, 0.5, 0), Vector3.new(0, 0, 0.5), Vector3.new(0.5, 0, 0) };
local u11 = {
    Vector3.new(0, 0, 0.5),
    Vector3.new(0, 0, -0.5),
    Vector3.new(0, 0.5, 0),
    Vector3.new(0, -0.5, 0),
    Vector3.new(0.5, 0, 0),
    Vector3.new(-0.5, 0, 0)
};
local u12 = {
    Vector3.new(0.5, 0, 0),
    Vector3.new(0.5, 0, 0),
    Vector3.new(0, 0, 0.5),
    Vector3.new(0, 0, 0.5),
    Vector3.new(0, 0.5, 0),
    Vector3.new(0, 0.5, 0)
};
local u13 = {
    Vector3.new(0, 0.5, 0),
    Vector3.new(0, 0.5, 0),
    Vector3.new(0.5, 0, 0),
    Vector3.new(0.5, 0, 0),
    Vector3.new(0, 0, 0.5),
    Vector3.new(0, 0, 0.5)
};
local function u26(p14, p15, p16) --[[ Line: 89 ]]
    -- upvalues: l__VectorToObjectSpace__6 (copy), u8 (copy), l__Dot__4 (copy), l__VectorToWorldSpace__5 (copy), u9 (copy), u10 (copy), u11 (copy), u12 (copy), u13 (copy)
    local l__Size__7 = p14.Size;
    local v17 = l__VectorToObjectSpace__6(p15, p16) / l__Size__7;
    if p14.ClassName ~= "WedgePart" then
        local v18 = (-1 / 0);
        local v19 = nil;
        for v20 = 1, #u11 do
            local v21 = l__Dot__4(u11[v20], v17);
            if v18 < v21 then
                v19 = v20;
                v18 = v21;
            end;
        end;
        return p15 * (l__Size__7 * u11[v19]), l__VectorToWorldSpace__5(p15, l__Size__7 * u12[v19]), l__VectorToWorldSpace__5(p15, l__Size__7 * u13[v19]);
    end;
    local v22 = (-1 / 0);
    local v23 = nil;
    for v24 = 1, #u8 do
        local v25 = l__Dot__4(u8[v24], v17);
        if v22 < v25 then
            v23 = v24;
            v22 = v25;
        end;
    end;
    if v23 <= 2 then
        return p15 * (l__Size__7 * u8[v23]), l__VectorToWorldSpace__5(p15, l__Size__7 * u9[v23]), l__VectorToWorldSpace__5(p15, l__Size__7 * u10[v23]);
    end;
end;
local function u44(p27, p28, p29, p30) --[[ Line: 123 ]]
    -- upvalues: u26 (copy)
    local v31;
    if p27.ClassName == "WedgePart" then
        local l__Size__8 = p27.Size;
        v31 = p28 * Vector3.new(0, -l__Size__8.y / 6, l__Size__8.z / 6);
    else
        v31 = p28.p;
    end;
    local v32;
    if p29.ClassName == "WedgePart" then
        local l__Size__9 = p29.Size;
        v32 = p30 * Vector3.new(0, -l__Size__9.y / 6, l__Size__9.z / 6);
    else
        v32 = p30.p;
    end;
    local v33, v34, v35 = u26(p27, p28, v32 - v31);
    local v36, v37, v38 = u26(p29, p30, v31 - v32);
    if not (v33 and v36) then
        return false;
    end;
    for v39 = -1, 1, 2 do
        for v40 = -1, 1, 2 do
            local v41 = v33 + v39 * v34 + v40 * v35;
            local v42 = false;
            for v43 = -1, 1, 2 do
                v42 = (v36 + v43 * v37 + -1 * v38 - v41).magnitude <= 0.01 and true or ((v36 + v43 * v37 + 1 * v38 - v41).magnitude <= 0.01 and true or v42);
                if v42 then
                    break;
                end;
            end;
            if not v42 then
                return false;
            end;
        end;
    end;
    return true;
end;
local function u57(p45, p46) --[[ Line: 159 ]]
    -- upvalues: l__makeQueryFuncFromPart__3 (copy), u5 (copy), u6 (copy), u7 (copy), l__Dot__4 (copy)
    local u47 = {
        [p45] = l__makeQueryFuncFromPart__3(p45, p46)
    };
    u5[p45] = p45;
    u6[p45] = u47;
    u7[p45] = function(p48) --[[ Line: 164 ]]
        -- upvalues: u47 (copy), l__Dot__4 (ref)
        if p48 then
            local v49 = (-1 / 0);
            local v50 = nil;
            for _, v51 in u47 do
                local v52 = v51(p48);
                local v53 = l__Dot__4(v52, p48);
                if v49 < v53 then
                    v50 = v52;
                    v49 = v53;
                end;
            end;
            return v50;
        else
            local v54 = Vector3.new(0, 0, 0);
            local v55 = 0;
            for _, v56 in u47 do
                v54 = v54 + v56(p48);
                v55 = v55 + 1;
            end;
            return v54 / v55;
        end;
    end;
end;
local l__Block__10 = Enum.PartType.Block;
local u58 = {};
return {
    GenerateBasePartMesh = function(p59, p60) --[[ Name: GenerateBasePartMesh, Line 255 ]]
        -- upvalues: u5 (copy), u7 (copy), u58 (copy), u1 (copy), l__makeQueryFuncFromPart__3 (copy)
        local v61 = p59.ClassName == "WedgePart" and p59.CanCollide and u5[p59];
        if v61 then
            local v62 = u7[v61];
            if v62 then
                return v62, 0;
            end;
            if not u58[v61] then
                u1("Brother=", p59, "points to group leader=", v61, "but no mesh exists!");
            end;
        end;
        return l__makeQueryFuncFromPart__3(p59, p60);
    end,
    GetConvexSetPart = function(p63, p64, p65) --[[ Name: GetConvexSetPart, Line 189 ]]
        -- upvalues: u5 (copy), l__VectorToWorldSpace__5 (copy), l__Block__10 (copy), u44 (copy), u6 (copy), u2 (copy), u7 (copy), l__makeQueryFuncFromPart__3 (copy), u57 (copy)
        if p63.ClassName == "WedgePart" and p63.CanCollide then
            local v66 = u5[p63];
            if v66 == nil then
                local v67 = p64:GetPartCFrame(p63, p65);
                local v68 = p64:FindParts(v67 + l__VectorToWorldSpace__5(v67, Vector3.new(0, -1, 1)), p63.Size + Vector3.new(1, 1, 1));
                for v69 = 1, #v68 do
                    local v70 = v68[v69];
                    if v70 ~= p63 and (v70.CanCollide and (v70.Velocity == p63.Velocity and (v70.ClassName == "WedgePart" or v70.ClassName == "Part" and v70.Shape == l__Block__10))) then
                        local v71 = p64:GetPartCFrame(v70, p65);
                        if u44(p63, v67, v70, v71) then
                            local v72 = u5[v70];
                            if v72 then
                                if v66 then
                                    if v66 ~= v72 then
                                        local v73 = u6[v72];
                                        u2(v73, u6[v66]);
                                        for v74 in v73 do
                                            u5[v74] = v66;
                                        end;
                                        u6[v72] = nil;
                                        u7[v72] = nil;
                                    end;
                                else
                                    v66 = v72;
                                end;
                            end;
                            if v66 then
                                if not u5[p63] then
                                    u5[p63] = v66;
                                    u6[v66][p63] = l__makeQueryFuncFromPart__3(p63, v67);
                                end;
                            else
                                u57(p63, v67);
                                v66 = p63;
                            end;
                            if not u5[v70] then
                                u5[v70] = v66;
                                u6[v66][v70] = l__makeQueryFuncFromPart__3(v70, v71);
                            end;
                        end;
                    end;
                end;
                if not v66 then
                    u5[p63] = false;
                end;
            end;
            if v66 then
                return v66;
            end;
        end;
        return p63;
    end
};
