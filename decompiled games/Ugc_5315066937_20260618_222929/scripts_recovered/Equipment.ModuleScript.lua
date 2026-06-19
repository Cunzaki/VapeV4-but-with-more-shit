-- Decompiled from: Equipment
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("Local");
local v2 = l__obtain__1("Remote");
local l__RequestICT__2 = l__obtain__1("EquipmentSync").RequestICT;
local v3 = l__obtain__1("EquipmentManager");
local l__Equip__3 = v3.Equip;
local l__Unequip__4 = v3.Unequip;
local l__EquipmentChanged__5 = v3.EquipmentChanged;
local l__CharacterInfos__6 = l__obtain__1("CharacterManager").CharacterInfos;
local u4 = {};
v2.Add("ReplicateAndRunEquipList", function(u5, u6) --[[ Name: ReplicateAndRunEquipList, Line 36 ]]
    -- upvalues: l__RequestICT__2 (copy), l__CharacterInfos__6 (copy), l__Unequip__4 (copy), l__Equip__3 (copy), l__EquipmentChanged__5 (copy), u4 (copy)
    l__RequestICT__2(function() --[[ Line: 39 ]]
        -- upvalues: l__CharacterInfos__6 (ref), u5 (copy), l__Unequip__4 (ref), l__Equip__3 (ref), u6 (copy), l__EquipmentChanged__5 (ref), u4 (ref)
        local v7 = l__CharacterInfos__6[u5];
        if v7 then
            l__Unequip__4(v7);
            l__Equip__3(v7, u6);
            l__EquipmentChanged__5:Call(u5, u6);
        else
            u4[u5] = u6;
        end;
    end, u6);
end);
v2.Add("ByeByeLastEquipList", function(p8) --[[ Line: 52 ]]
    -- upvalues: l__CharacterInfos__6 (copy), l__Unequip__4 (copy)
    local v9 = l__CharacterInfos__6[p8];
    if v9 then
        l__Unequip__4(v9);
    end;
end);
v1.Add("EquipDefaultCharacter", function(p10, p11) --[[ Name: EquipDefaultCharacter, Line 60 ]]
    -- upvalues: u4 (copy), l__Equip__3 (copy), l__EquipmentChanged__5 (copy)
    local v12 = u4[p10];
    if v12 then
        u4[p10] = nil;
        l__Equip__3(p11, v12);
        l__EquipmentChanged__5:Call(p10, v12);
    end;
end);
return true;
