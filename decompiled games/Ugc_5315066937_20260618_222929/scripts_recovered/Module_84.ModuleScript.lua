-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local v1 = _G.obtain("EquipmentCache");
local l__ItemTypes__1 = v1.ItemTypes;
local l__ItemClasses__2 = v1.ItemClasses;
local l__ItemInstances__3 = v1.ItemInstances;
local u2 = {};
local u3 = {};
return {
    GetOwnerItemInstances = function() --[[ Name: GetOwnerItemInstances, Line 91 ]]
        -- upvalues: u2 (ref)
        return u2;
    end,
    SetOwnerItemInstances = function(p4) --[[ Name: SetOwnerItemInstances, Line 96 ]]
        -- upvalues: u2 (ref), l__ItemInstances__3 (copy)
        u2 = p4;
        local v5 = {};
        local v6 = {};
        local v7 = false;
        for v8 = 1, #p4 do
            local v9 = p4[v8];
            local l__ID__4 = v9.ID;
            local v10 = l__ItemInstances__3[l__ID__4];
            if v10 then
                if v9.Updated ~= v10.Updated then
                    v5[l__ID__4] = v9.Updated;
                    v7 = true;
                end;
            else
                v6[#v6 + 1] = l__ID__4;
            end;
            l__ItemInstances__3[l__ID__4] = v9;
        end;
        local _ = #v6 > 0;
    end,
    GetCachedMetRequirementsClassesOfType = function(p11) --[[ Name: GetCachedMetRequirementsClassesOfType, Line 132 ]]
        -- upvalues: u3 (copy)
        return u3[p11];
    end,
    SetCachedMetRequirementsClassesOfType = function(p12, p13) --[[ Name: SetCachedMetRequirementsClassesOfType, Line 135 ]]
        -- upvalues: u3 (copy)
        u3[p12] = p13;
    end,
    GenerateIDListICT = function(p14, p15, p16) --[[ Name: GenerateIDListICT, Line 54 ]]
        -- upvalues: l__ItemTypes__1 (copy), l__ItemClasses__2 (copy), l__ItemInstances__3 (copy)
        local v17 = {};
        local v18 = {};
        local v19 = {};
        if p16 then
            for v20 = 1, #p16 do
                local v21 = p16[v20];
                if not v17[v21] then
                    v17[v21] = true;
                    v19[#v19 + 1] = v21;
                    local v22 = l__ItemTypes__1[v21];
                    if v22 then
                        v18[v21] = v22.Updated;
                    end;
                end;
            end;
        end;
        local v23 = {};
        local v24 = {};
        local v25 = {};
        if p15 then
            for v26 = 1, #p15 do
                local v27 = p15[v26];
                local v28;
                if v23[v27] then
                    v28 = nil;
                else
                    v23[v27] = true;
                    v25[#v25 + 1] = v27;
                    local v29 = l__ItemClasses__2[v27];
                    if v29 then
                        v24[v27] = v29.Updated;
                        v28 = v29.Type;
                    else
                        v28 = nil;
                    end;
                end;
                if v28 and not v17[v28] then
                    v17[v28] = true;
                    v19[#v19 + 1] = v28;
                    local v30 = l__ItemTypes__1[v28];
                    if v30 then
                        v18[v28] = v30.Updated;
                    end;
                end;
            end;
        end;
        local v31 = {};
        local v32 = {};
        local v33 = {};
        if p14 then
            for v34 = 1, #p14 do
                local v35 = p14[v34];
                local v36;
                if v31[v35] then
                    v36 = nil;
                else
                    v31[v35] = true;
                    v33[#v33 + 1] = v35;
                    local v37 = l__ItemInstances__3[v35];
                    if v37 then
                        v32[v35] = v37.Updated;
                        v36 = v37.Class;
                    else
                        v36 = nil;
                    end;
                end;
                if v36 then
                    local v38;
                    if v23[v36] then
                        v38 = nil;
                    else
                        v23[v36] = true;
                        v25[#v25 + 1] = v36;
                        local v39 = l__ItemClasses__2[v36];
                        if v39 then
                            v24[v36] = v39.Updated;
                            v38 = v39.Type;
                        else
                            v38 = nil;
                        end;
                    end;
                    if v38 and not v17[v38] then
                        v17[v38] = true;
                        v19[#v19 + 1] = v38;
                        local v40 = l__ItemTypes__1[v38];
                        if v40 then
                            v18[v38] = v40.Updated;
                        end;
                    end;
                end;
            end;
        end;
        return v33, v25, v19, v32, v24, v18;
    end
};
