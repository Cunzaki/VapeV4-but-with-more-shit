-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = next;
local l__move__1 = table.move;
local l__clear__2 = table.clear;
local l__insert__3 = table.insert;
local l__remove__4 = table.remove;
local l__IsA__5 = game.IsA;
local l__GetChildren__6 = game.GetChildren;
local v2 = _G.obtain("Class")();
function v2.DefCategory(p3, p4, p5) --[[ Line: 15 ]]
    p3.Categories[p4] = p5;
end;
function v2.DefClassification(p6, p7, p8) --[[ Line: 18 ]]
    p6.Classifications[p7] = p8;
end;
function v2.DefObject(p9, p10, p11, p12, p13) --[[ Line: 21 ]]
    -- upvalues: l__insert__3 (copy)
    local l__ObjectsFromClass__7 = p9.ObjectsFromClass;
    local v14 = l__ObjectsFromClass__7[p12];
    if not v14 then
        v14 = {};
        l__ObjectsFromClass__7[p12] = v14;
    end;
    l__insert__3(v14, p10);
    p9.Objects[p10] = {
        Name = p10,
        Category = p11,
        Classification = p12,
        Analysis = p13
    };
end;
local function u27(p15, p16, p17) --[[ Line: 38 ]]
    -- upvalues: u1 (copy)
    local l__Cache__8 = p15.Cache;
    local v18 = l__Cache__8[p16];
    if v18 then
        local l__Analysis__9 = v18.Analysis;
        if l__Analysis__9 then
            local v19 = l__Analysis__9(p16);
            if v19 ~= nil then
                return v19, v18.Name, v18.Category;
            end;
            l__Cache__8[p16] = nil;
        end;
    elseif v18 == false then
        return;
    end;
    local l__Objects__10 = p15.Objects;
    local l__ObjectsFromClass__11 = p15.ObjectsFromClass;
    for v20, v21 in u1, p15.Classifications do
        if v21(p16) then
            local v22 = l__ObjectsFromClass__11[v20];
            if v22 then
                for v23 = 1, #v22 do
                    local v24 = v22[v23];
                    local v25 = l__Objects__10[v24];
                    if v25 then
                        local l__Analysis__12 = v25.Analysis;
                        if l__Analysis__12 then
                            local v26 = l__Analysis__12(p16);
                            if v26 ~= nil then
                                if not p17 then
                                    l__Cache__8[p16] = v25;
                                end;
                                return v26, v24, v25.Category;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
    if not p17 then
        l__Cache__8[p16] = false;
    end;
end;
v2.Analyze = u27;
function v2.ClearCache(p28) --[[ Line: 85 ]]
    -- upvalues: l__clear__2 (copy)
    l__clear__2(p28.Cache);
end;
function v2.AnalyzeDescendants(p29, p30) --[[ Line: 89 ]]
    -- upvalues: l__GetChildren__6 (copy), l__remove__4 (copy), u27 (copy), l__move__1 (copy), u1 (copy)
    local l__Categories__13 = p29.Categories;
    local v31 = { p30 };
    local v32 = {};
    while true do
        local v33 = l__GetChildren__6(l__remove__4(v31));
        local v34 = #v33;
        local v35 = #v31;
        for v36 = 1, v34 do
            local v37 = v33[v36];
            local v38, v39, v40 = u27(p29, v37, true);
            if l__Categories__13[v40] then
                local v41 = v32[v40];
                if not v41 then
                    v41 = {};
                    v32[v40] = v41;
                end;
                local v42 = v41[v39];
                if not v42 then
                    v42 = {};
                    v41[v39] = v42;
                end;
                v42[v37] = v38;
            end;
        end;
        l__move__1(v33, 1, v34, v35 + 1, v31);
        if v35 + v34 == 0 then
            local v43 = {};
            for v44, v45 in u1, v32 do
                v43[v44] = l__Categories__13[v44](v45);
            end;
            return v43;
        end;
    end;
end;
local function u47(p46) --[[ Line: 142 ]]
    -- upvalues: l__IsA__5 (copy)
    return l__IsA__5(p46, "BasePart");
end;
function v2.Constructor(p48) --[[ Line: 145 ]]
    -- upvalues: u47 (copy)
    p48.Categories = {};
    p48.Classifications = {};
    p48.Objects = {};
    p48.ObjectsFromClass = {};
    p48.Cache = {};
    p48:DefClassification("BasePart", u47);
end;
return v2;
