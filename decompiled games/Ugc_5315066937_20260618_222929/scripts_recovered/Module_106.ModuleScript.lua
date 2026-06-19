-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = select;
local l__obtain__1 = _G.obtain;
local v2 = l__obtain__1("Remote");
local l__Call__2 = v2.Call;
local v3 = l__obtain__1("EquipmentCache");
local l__IDList__3 = v3.IDList;
local l__ItemTypes__4 = v3.ItemTypes;
local l__ItemClasses__5 = v3.ItemClasses;
local l__ItemInstances__6 = v3.ItemInstances;
local v4 = l__obtain__1("EquipmentCacheHelper");
local l__GenerateIDListICT__7 = v4.GenerateIDListICT;
local l__GetOwnerItemInstances__8 = v4.GetOwnerItemInstances;
local l__SetOwnerItemInstances__9 = v4.SetOwnerItemInstances;
local l__GetCachedMetRequirementsClassesOfType__10 = v4.GetCachedMetRequirementsClassesOfType;
local l__SetCachedMetRequirementsClassesOfType__11 = v4.SetCachedMetRequirementsClassesOfType;
local u5 = 0;
local u6 = {};
local function v12(p7, p8, p9, p10) --[[ Line: 42 ]]
    -- upvalues: l__Call__2 (copy), u5 (ref), u6 (copy), l__GenerateIDListICT__7 (copy)
    local v11 = l__Call__2;
    u5 = u5 + 1;
    u6[u5] = p7;
    v11("RequestICT", u5, l__GenerateIDListICT__7(p8, p9, p10));
end;
v2.Add("ReceiveICT", function(p13, p14, p15, p16, p17) --[[ Name: ReceiveICT, Line 48 ]]
    -- upvalues: l__ItemInstances__6 (copy), l__ItemClasses__5 (copy), l__ItemTypes__4 (copy), u6 (copy)
    local v18 = p15 and (#p15 or 0) or 0;
    local v19 = p16 and (#p16 or 0) or 0;
    local v20 = p17 and (#p17 or 0) or 0;
    local v21 = (v18 > 0 or v19 > 0) and true or v20 > 0;
    for v22 = 1, v18 do
        local v23 = p15[v22];
        print("Downloaded Instance ID=", v23.ID);
        l__ItemInstances__6[v23.ID] = v23;
    end;
    for v24 = 1, v19 do
        local v25 = p16[v24];
        print("Downloaded Class ID=", v25.ID);
        l__ItemClasses__5[v25.ID] = v25;
    end;
    for v26 = 1, v20 do
        local v27 = p17[v26];
        print("Downloaded Type ID=", v27.ID);
        l__ItemTypes__4[v27.ID] = v27;
    end;
    local v28 = u6[p13];
    if v28 then
        v28(v21, p14);
    end;
end);
local function v37(u29) --[[ Line: 74 ]]
    -- upvalues: l__GetOwnerItemInstances__8 (copy), l__ItemInstances__6 (copy), l__SetOwnerItemInstances__9 (copy), u5 (ref), u6 (copy), l__Call__2 (copy), u1 (copy), l__GenerateIDListICT__7 (copy), l__IDList__3 (copy)
    local u30 = l__GetOwnerItemInstances__8();
    local function v35(p31, p32) --[[ Line: 76 ]]
        -- upvalues: u30 (copy), l__ItemInstances__6 (ref), l__SetOwnerItemInstances__9 (ref), u29 (copy)
        if p32 then
            p31 = not u30 and true or p31;
            local v33 = {};
            for v34 = 1, #p32 do
                v33[v34] = l__ItemInstances__6[p32[v34]];
            end;
            l__SetOwnerItemInstances__9(v33);
        end;
        if u29 then
            u29(p31);
        end;
    end;
    u5 = u5 + 1;
    u6[u5] = v35;
    local v36 = u5;
    if u30 then
        l__Call__2("RequestInventory", v36, u1(2, l__GenerateIDListICT__7(l__IDList__3(u30))));
    else
        l__Call__2("RequestInventory", v36);
    end;
end;
local function v47(u38, u39) --[[ Line: 100 ]]
    -- upvalues: l__GetCachedMetRequirementsClassesOfType__10 (copy), l__ItemClasses__5 (copy), l__SetCachedMetRequirementsClassesOfType__11 (copy), u5 (ref), u6 (copy), l__Call__2 (copy), u1 (copy), l__GenerateIDListICT__7 (copy), l__IDList__3 (copy)
    local u40 = l__GetCachedMetRequirementsClassesOfType__10(u38);
    local function v45(p41, p42) --[[ Line: 102 ]]
        -- upvalues: u40 (copy), l__ItemClasses__5 (ref), l__SetCachedMetRequirementsClassesOfType__11 (ref), u38 (copy), u39 (copy)
        if p42 then
            p41 = not u40 and true or p41;
            local v43 = {};
            for v44 = 1, #p42 do
                v43[v44] = l__ItemClasses__5[p42[v44]];
            end;
            l__SetCachedMetRequirementsClassesOfType__11(u38, v43);
        end;
        if u39 then
            u39(p41);
        end;
    end;
    u5 = u5 + 1;
    u6[u5] = v45;
    local v46 = u5;
    if u40 then
        l__Call__2("RequestCategoryItems", v46, u38, u1(2, l__GenerateIDListICT__7(nil, l__IDList__3(u40))));
    else
        l__Call__2("RequestCategoryItems", v46, u38);
    end;
end;
local function v50(p48) --[[ Line: 129 ]]
    -- upvalues: l__Call__2 (copy), u5 (ref), u6 (copy), l__GenerateIDListICT__7 (copy)
    local v49 = l__Call__2;
    u5 = u5 + 1;
    u6[u5] = nil;
    v49("RequestICT", u5, l__GenerateIDListICT__7(p48, nil, nil));
end;
v2.Add("ReplicateInstanceIDList", v50);
return {
    RequestICT = v12,
    RequestInventory = v37,
    RequestCategoryItems = v47,
    MakeServerEquip = function(p51, p52, p53, p54) --[[ Name: MakeServerEquip, Line 125 ]]
        -- upvalues: l__Call__2 (copy)
        l__Call__2("SetEquipTo", p51, p52, p53, p54);
    end,
    ReplicateInstanceIDList = v50
};
