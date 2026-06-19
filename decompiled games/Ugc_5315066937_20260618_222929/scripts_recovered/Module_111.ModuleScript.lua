-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("Signal");
local v2 = l__obtain__1("Character");
local l__AppendInfoState__2 = v2.AppendInfoState;
local l__CullInfoState__3 = v2.CullInfoState;
local v3 = l__obtain__1("EquipmentInstantiation");
local l__RunEquipList__4 = v3.RunEquipList;
local l__UndoEquipList__5 = v3.UndoEquipList;
return {
    Equip = function(p4, p5) --[[ Name: Equip, Line 15 ]]
        -- upvalues: l__RunEquipList__4 (copy), l__AppendInfoState__2 (copy)
        l__RunEquipList__4(p4.LocalEquipData, p4, p5);
        l__AppendInfoState__2(p4);
        p4.EquippedList = p5;
    end,
    Unequip = function(p6) --[[ Name: Unequip, Line 20 ]]
        -- upvalues: l__UndoEquipList__5 (copy), l__CullInfoState__3 (copy)
        local l__EquippedList__6 = p6.EquippedList;
        if l__EquippedList__6 then
            l__UndoEquipList__5(p6.LocalEquipData, l__EquippedList__6);
            l__CullInfoState__3(p6);
            p6.EquippedList = nil;
        end;
    end,
    EquipmentChanged = v1()
};
