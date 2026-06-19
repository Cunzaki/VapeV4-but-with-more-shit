-- Decompiled from: ShopGui
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local v1 = next;
local l__sin__1 = math.sin;
local l__tan__2 = math.tan;
local l__min__3 = math.min;
local l__max__4 = math.max;
local l__floor__5 = math.floor;
local l__ceil__6 = math.ceil;
local l__lshift__7 = bit32.lshift;
local l__concat__8 = table.concat;
local _ = table.remove;
local l__obtain__9 = _G.obtain;
local u2 = l__obtain__9("QBox");
local l__FreeMouse__10 = u2.FreeMouse;
local l__ColourLerp__11 = u2.ColourLerp;
local l__New__12 = u2.New;
local l__Image__13 = u2.Image;
local l__TextBox__14 = u2.TextBox;
local v3 = l__obtain__9("Tween");
local v4 = l__obtain__9("Local");
local _ = v4.Call;
local v5 = l__obtain__9("Remote");
local l__Call__15 = v5.Call;
local l__Gui__16 = l__obtain__9("InputBinds").Gui;
local l__LocalPlayer__17 = l__obtain__9("PlayerManager").LocalPlayer;
local u6 = -l__LocalPlayer__17.userId;
local l__SetCharacterCFrame__18 = l__obtain__9("PositionCharacter").SetCharacterCFrame;
local v7 = l__obtain__9("Character");
local l__WriteInfoState__19 = v7.WriteInfoState;
local l__CreateCharacterClone__20 = v7.CreateCharacterClone;
local l__CreateCharacterInfo__21 = v7.CreateCharacterInfo;
local v8 = l__obtain__9("CharacterManager");
local v9 = l__obtain__9("EquipmentManager");
local l__Equip__22 = v9.Equip;
local l__Unequip__23 = v9.Unequip;
local v10 = l__obtain__9("EquipmentCache");
local l__ItemTypes__24 = v10.ItemTypes;
local l__ItemClasses__25 = v10.ItemClasses;
local l__ItemInstances__26 = v10.ItemInstances;
local l__GetEquipOptions__27 = v10.GetEquipOptions;
local l__SlotDescriptions__28 = v10.SlotDescriptions;
local v11 = l__obtain__9("EquipmentSync");
local l__MakeServerEquip__29 = v11.MakeServerEquip;
local _ = v11.RequestInventory;
local _ = v11.RequestCategoryItems;
local v12 = l__obtain__9("EquipmentCacheHelper");
local l__GetOwnerItemInstances__30 = v12.GetOwnerItemInstances;
local l__GetCachedMetRequirementsClassesOfType__31 = v12.GetCachedMetRequirementsClassesOfType;
local l__Color0__32 = u2.Color0;
local l__Color1__33 = u2.Color1;
local u13 = tick;
local l__new__34 = Vector3.new;
local l__new__35 = CFrame.new;
local u14 = l__New__12();
u14.Visible = false;
u14.DrawBackground = false;
u14.SizeOffsetX = 900;
u14.SizeOffsetY = 675;
u14.PosScaleX = 0.5;
u14.PosScaleY = 1;
local u15 = false;
local u17 = v3.New(0, function(p16) --[[ Line: 85 ]]
    -- upvalues: u15 (ref), u14 (copy)
    u15 = true;
    u14.PosOffsetY = p16;
    u15 = false;
end);
u17.MaxAcceleration = v3.MaxAcceleration(0, u14.SizeY, 0, 0, 1);
u14.Callbacks[{
    PosOffsetY = true
}] = function() --[[ Line: 91 ]]
    -- upvalues: u15 (ref), u17 (copy), u14 (copy)
    if not u15 then
        u17.x1 = u14.PosOffsetY;
    end;
end;
function u14.Resize() --[[ Line: 97 ]]
    -- upvalues: u14 (copy), u17 (copy)
    u14.PosOffsetX = u14.SizeX / -2;
    u14.PosOffsetY = u17:Value();
end;
local v18 = l__TextBox__14(u14, "Faste Shop");
v18.TextSize = 12 * u2.roblox_messing_with_guis_factor;
v18.TextAlignment = "Center";
v18.BackgroundColor = u2.Color2;
v18.SizeScaleX = 1;
v18.SizeOffsetX = -40;
v18.SizeOffsetY = 40;
u2.DragBar(v18, u14);
local v19 = l__TextBox__14(u14, "x");
v19.TextSize = 12 * u2.roblox_messing_with_guis_factor;
v19.TextAlignment = "Center";
v19.SizeOffsetX = 40;
v19.SizeOffsetY = 40;
v19.PosOffsetX = -40;
v19.PosScaleX = 1;
local v20 = l__New__12(u14);
v20.PosOffsetY = 40;
v20.SizeScaleY = 1;
v20.SizeOffsetX = 240;
v20.SizeOffsetY = -40;
v20.BackgroundColor = u2.Color2;
local v21 = 0;
local u22 = u2.Color(34, 177, 76);
local u23 = u2.Color(21, 108, 48);
local u24 = l__TextBox__14(v20, "Buy Premium Currency");
u24.PosOffsetY = v21;
u24.SizeScaleX = 1;
u24.SizeOffsetY = 50;
u24.TextStrokeColor = u2.Color(0, 0, 0);
function u24.Fade(p25) --[[ Line: 139 ]]
    -- upvalues: u24 (copy), l__ColourLerp__11 (copy), u22 (copy), u23 (copy)
    u24.BackgroundColor = l__ColourLerp__11(u22, u23, p25);
end;
local v26 = v21 + u24.SizeY;
local l__Color2__36 = u2.Color2;
local u27 = l__New__12(v20);
u27.PosOffsetY = v26;
u27.SizeScaleX = 1;
u27.SizeOffsetY = 310;
function u27.Fade(p28) --[[ Line: 150 ]]
    -- upvalues: u27 (copy), l__ColourLerp__11 (copy), l__Color2__36 (copy), u2 (copy)
    u27.BackgroundColor = l__ColourLerp__11(l__Color2__36, u2.Color0, p28);
end;
local v29 = v26 + u27.SizeY;
local u30 = u2.Viewport(u27);
u30.PosOffsetX = 10;
u30.PosOffsetY = 10;
u30.SizeScaleX = 1;
u30.SizeOffsetX = -20;
u30.SizeOffsetY = 220;
local u31 = nil;
local l__Camera__37 = u30.Camera;
local u32 = l__new__35(Vector3.new(0, 4.5, 6), Vector3.new(0, 3.5, 0));
l__Camera__37.CFrame = u32;
local u33 = u13();
function u30.Think() --[[ Line: 179 ]]
    -- upvalues: u31 (ref), l__Camera__37 (copy), l__tan__2 (copy), u30 (copy), u2 (copy), u13 (copy), u33 (copy), l__sin__1 (copy), l__new__34 (copy), l__SetCharacterCFrame__18 (copy), l__new__35 (copy), u32 (copy)
    if u31 then
        local v34 = l__Camera__37.CFrame:PointToObjectSpace(u31.Head.Position);
        local v35 = 2 * v34.z * l__tan__2(l__Camera__37.FieldOfView * 0.008726646259971648);
        local l__SizeX__38 = u30.SizeX;
        local l__SizeY__39 = u30.SizeY;
        local v36 = -0.5 + (u2.MouseX - u30.PosX - l__SizeY__39 * v34.x / v35) / l__SizeX__38;
        local v37 = -0.5 + (u2.MouseY - u30.PosY) / l__SizeY__39 - v34.y / v35;
        local v38 = u13() - u33;
        local v39 = v38 % 0.715588 - 0.357794;
        local v40 = l__new__34(l__sin__1(v38 % 6.283185307179586) * 5, 25.603309287200002 + (71.5588 + 50 * v39) * v39, 80 * v38 % 100000);
        l__SetCharacterCFrame__18(u31, l__new__35(Vector3.new(0, 2.5, 0), Vector3.new(0, 2.5, 0) + l__new__34(v36, -v37, 4)) + v40, 1);
        l__Camera__37.CFrame = u32 + v40;
    end;
end;
local u41 = nil;
v9.EquipmentChanged:Add(function(p42, p43) --[[ Line: 198 ]]
    -- upvalues: l__LocalPlayer__17 (copy), u41 (ref), u31 (ref), l__Unequip__23 (copy), l__Equip__22 (copy)
    if p42 == l__LocalPlayer__17 then
        u41 = p43;
        if u31 then
            l__Unequip__23(u31);
            l__Equip__22(u31, p43);
        end;
    end;
end);
v8.CharacterAdded:Add(function(p44, _) --[[ Line: 209 ]]
    -- upvalues: l__LocalPlayer__17 (copy), l__CreateCharacterClone__20 (copy), u30 (copy), u31 (ref), l__CreateCharacterInfo__21 (copy), l__WriteInfoState__19 (copy), u41 (ref), l__Equip__22 (copy)
    if p44 == l__LocalPlayer__17 then
        local v45 = l__CreateCharacterClone__20(l__LocalPlayer__17);
        v45.Parent = u30.Content;
        u31 = l__CreateCharacterInfo__21(v45);
        u31.ItemContainerParent = u30.Content;
        l__WriteInfoState__19(u31);
        if u41 then
            l__Equip__22(u31, u41);
        end;
    end;
end);
local v46 = l__TextBox__14(u27, l__LocalPlayer__17.Name);
v46.PosOffsetX = 10;
v46.PosOffsetY = 240;
v46.SizeOffsetY = 30;
v46.SizeScaleX = 1;
v46.SizeOffsetX = -20;
v46.TextAlignment = "Left";
v46.DrawBackground = false;
local u47 = l__TextBox__14(u27, "Loading...");
u47.PosOffsetX = 10;
u47.PosOffsetY = 270;
u47.SizeOffsetY = 30;
u47.SizeScaleX = 1;
u47.SizeOffsetX = -20;
u47.TextAlignment = "Right";
u47.DrawBackground = false;
local u48 = 0;
v5.Add("SetBalance", function(p49) --[[ Line: 246 ]]
    -- upvalues: u48 (ref), u47 (copy)
    u48 = p49;
    u47.Text = p49 .. "Pr";
end);
v5.Add("IncrementBalance", function(p50) --[[ Line: 251 ]]
    -- upvalues: u48 (ref), u47 (copy)
    u48 = u48 + p50;
    u47.Text = u48 .. "Pr";
end);
local v51 = l__New__12();
v51.DrawBackground = false;
v51.SizeScaleX = 1;
local v52 = l__New__12(v20);
v52.PosOffsetY = v29;
v52.SizeScaleX = 1;
v52.SizeScaleY = 1;
v52.SizeOffsetY = -v29;
v52.BackgroundColor = u2.Color2;
u2.Scroll(v51, v52);
local v53 = {
    [0] = "Inventory",
    [2] = "Gamepasses",
    [3] = "Character Models",
    [5] = "Trails",
    [7] = "Surf Boards"
};
local v54 = 0;
local u55 = nil;
for u56, _ in v1, l__ItemTypes__24 do
    local v57 = v53[u56];
    if v57 then
        local l__Color1__40 = u2.Color1;
        local l__Color0__41 = u2.Color0;
        local u58 = l__TextBox__14(v51, v57);
        u58.PosOffsetY = v54;
        u58.SizeOffsetY = 60;
        u58.SizeScaleX = 1;
        u58.TextAlignment = "Center";
        u58.BackgroundColor = l__Color1__40;
        function u58.Fade(p59) --[[ Line: 294 ]]
            -- upvalues: u58 (copy), l__ColourLerp__11 (copy), l__Color1__40 (copy), l__Color0__41 (copy)
            u58.BackgroundColor = l__ColourLerp__11(l__Color1__40, l__Color0__41, p59);
        end;
        function u58.Button1Down() --[[ Line: 297 ]]
            -- upvalues: u55 (ref), u56 (copy)
            u55(u56);
        end;
        v54 = v54 + u58.SizeY;
    end;
end;
v51.SizeOffsetY = v54;
local u60 = l__New__12();
u60.DrawBackground = false;
u60.SizeScaleX = 1;
local v61 = l__New__12(u14);
v61.PosOffsetX = 240;
v61.PosOffsetY = 40;
v61.SizeScaleX = 1;
v61.SizeScaleY = 1;
v61.SizeOffsetX = -240;
v61.SizeOffsetY = -40;
u2.Scroll(u60, v61);
local function u73(p62, u63) --[[ Line: 395 ]]
    -- upvalues: l__New__12 (copy), l__min__3 (copy), l__TextBox__14 (copy), u2 (copy), l__ColourLerp__11 (copy)
    local u64 = l__New__12();
    u64.DrawBackground = false;
    u64.SizeOffsetX = 400;
    u64.SizeOffsetY = l__min__3(6, #p62) * 100 + 40;
    u64.PosScaleX = 0.5;
    u64.PosScaleY = 0.5;
    u64.PosOffsetX = u64.SizeX / -2;
    u64.PosOffsetY = u64.SizeY / -2;
    local v65 = l__TextBox__14(u64, "Equip to what?");
    v65.TextSize = 16 * u2.roblox_messing_with_guis_factor;
    v65.TextAlignment = "Center";
    v65.BackgroundColor = u2.Color2;
    v65.SizeScaleX = 1;
    v65.SizeOffsetX = -40;
    v65.SizeOffsetY = 40;
    u2.DragBar(v65, u64);
    local v66 = l__TextBox__14(u64, "x");
    v66.TextSize = 12 * u2.roblox_messing_with_guis_factor;
    v66.TextAlignment = "Center";
    v66.SizeOffsetX = 40;
    v66.SizeOffsetY = 40;
    v66.PosOffsetX = -40;
    v66.PosScaleX = 1;
    local v67 = l__New__12(u64);
    v67.PosOffsetY = 40;
    v67.SizeScaleY = 1;
    v67.SizeScaleX = 1;
    v67.SizeOffsetY = -40;
    v67.BackgroundColor = u2.Color2;
    local u68 = l__New__12();
    u68.SizeScaleX = 1;
    u68.SizeOffsetY = #p62 * 100;
    u2.Scroll(u68, v67);
    u2.FromList(p62, function(u69, p70) --[[ Line: 438 ]]
        -- upvalues: l__TextBox__14 (ref), u68 (copy), u2 (ref), l__ColourLerp__11 (ref), u64 (copy), u63 (copy)
        local u71 = l__TextBox__14(u68, p70);
        u71.TextSize = 20 * u2.roblox_messing_with_guis_factor;
        u71.TextAlignment = "Center";
        function u71.Fade(p72) --[[ Line: 442 ]]
            -- upvalues: u71 (copy), l__ColourLerp__11 (ref), u2 (ref)
            u71.BackgroundColor = l__ColourLerp__11(u2.Color1, u2.Color2, p72);
        end;
        function u71.Button1Down() --[[ Line: 445 ]]
            -- upvalues: u64 (ref), u63 (ref), u69 (copy)
            u64:Remove();
            u63(u69);
        end;
        return u71;
    end);
    function v66.Button1Down() --[[ Line: 451 ]]
        -- upvalues: u64 (copy)
        u64:Remove();
    end;
end;
local function u89(u74, u75) --[[ Line: 456 ]]
    -- upvalues: l__ItemInstances__26 (copy), l__GetEquipOptions__27 (copy), u6 (copy), l__SlotDescriptions__28 (copy), l__concat__8 (copy), u73 (copy), l__lshift__7 (copy), l__MakeServerEquip__29 (copy)
    local _ = l__ItemInstances__26[u74];
    local u76 = l__GetEquipOptions__27(u6, u74);
    if #u76 > 1 then
        local v77 = {};
        for v78 = 1, #u76 do
            local v79 = u76[v78];
            local _ = v79.EquipTo;
            local l__Slots__42 = v79.Slots;
            local v80 = {};
            for v81 = 1, #l__Slots__42 do
                v80[v81] = l__SlotDescriptions__28[l__Slots__42[v81]];
            end;
            v77[v78] = l__concat__8({ v79.Title, #l__Slots__42 == 1 and " slot " or " slots ", l__concat__8(v80, ", ") });
        end;
        u73(v77, function(p82) --[[ Line: 491 ]]
            -- upvalues: u76 (copy), l__lshift__7 (ref), l__MakeServerEquip__29 (ref), u74 (copy), u75 (copy)
            local v83 = u76[p82];
            local l__Slots__43 = v83.Slots;
            local v84 = 0;
            for v85 = 1, #l__Slots__43 do
                v84 = v84 + l__lshift__7(1, l__Slots__43[v85] - 1);
            end;
            l__MakeServerEquip__29(u74, v83.EquipTo, v84, u75);
        end);
    elseif #u76 == 1 then
        local v86 = u76[1];
        local l__Slots__44 = v86.Slots;
        local v87 = 0;
        for v88 = 1, #l__Slots__44 do
            v87 = v87 + l__lshift__7(1, l__Slots__44[v88] - 1);
        end;
        l__MakeServerEquip__29(u74, v86.EquipTo, v87, u75);
    else
        print("[ShopGui] No equip options.");
    end;
end;
local u91 = { function(_) --[[ Line: 516 ]]
        return "Equip";
    end, function(p90) --[[ Line: 524 ]]
        -- upvalues: l__ItemInstances__26 (copy)
        return l__ItemInstances__26[p90.ID].EquippedTo ~= 0 and "Unequip" or false;
    end };
local u94 = { function(p92) --[[ Line: 531 ]]
        -- upvalues: u89 (copy)
        u89(p92.ID);
    end, function(p93) --[[ Line: 534 ]]
        -- upvalues: l__MakeServerEquip__29 (copy)
        l__MakeServerEquip__29(p93.ID, 0, 0);
    end };
local u95 = nil;
local function u108(u96, p97, p98) --[[ Line: 540 ]]
    -- upvalues: u95 (ref), l__New__12 (copy), u94 (copy), u91 (copy), l__TextBox__14 (copy), u2 (copy), l__max__4 (copy), l__ColourLerp__11 (copy), l__min__3 (copy)
    if u95 then
        u95:Remove();
    end;
    local u99 = l__New__12();
    local v100 = {};
    local v101 = 0;
    local v102 = false;
    for v103 = 1, #u94 do
        local v104 = u91[v103](u96);
        if v104 then
            local u105 = u94[v103];
            local u106 = l__TextBox__14(u99, v104);
            u106.TextAlignment = "Center";
            u106.BackgroundColor = u2.Color0;
            v101 = l__max__4(v101, 10 + u106.TextSizeX);
            u106.SizeScaleX = 1;
            u106.SizeOffsetY = 20;
            u106.PosOffsetY = #v100 * 20;
            function u106.Button1Down() --[[ Line: 560 ]]
                -- upvalues: u96 (copy), u105 (copy), u99 (copy), u95 (ref)
                if u96 then
                    u105(u96);
                end;
                u99:Remove();
                u95 = nil;
            end;
            function u106.Fade(p107) --[[ Line: 567 ]]
                -- upvalues: u106 (copy), l__ColourLerp__11 (ref), u2 (ref)
                u106.BackgroundColor = l__ColourLerp__11(u2.Color0, u2.Color2, p107);
            end;
            v100[#v100 + 1] = u106;
            v102 = true;
        end;
    end;
    if v102 then
        u99.SizeOffsetX = v101;
        u99.SizeOffsetY = #v100 * 20;
        u99.PosOffsetX = l__max__4(0, (l__min__3(u99.Parent.SizeX - u99.SizeX, p97)));
        u99.PosOffsetY = l__max__4(0, (l__min__3(u99.Parent.SizeY - u99.SizeY, p98)));
        function u99.MouseLeave() --[[ Line: 578 ]]
            -- upvalues: u99 (copy), u95 (ref)
            u99:Remove();
            u95 = nil;
        end;
        u95 = u99;
    else
        u99:Remove();
    end;
end;
local u109 = u2.Color(192, 192, 192, 255);
local u110 = u2.Color(40, 190, 40);
local u111 = u2.Color(0, 0, 0);
local function u126(p112) --[[ Line: 592 ]]
    -- upvalues: u60 (copy), l__New__12 (copy), l__floor__5 (copy), l__Image__13 (copy), u2 (copy), l__TextBox__14 (copy), u110 (copy), u111 (copy), u109 (copy), l__ColourLerp__11 (copy), l__Color0__32 (copy), l__Color1__33 (copy), u89 (copy), u108 (copy), l__Call__15 (copy), l__ceil__6 (copy)
    local l__Children__45 = u60.Children;
    for v113 = #l__Children__45, 1, -1 do
        l__Children__45[v113]:Remove();
    end;
    for v114 = 1, #p112 do
        local u115 = p112[v114];
        local u116 = l__New__12(u60);
        u116.PosOffsetX = (v114 - 1) % 3 * 210 + 10;
        u116.PosOffsetY = l__floor__5((v114 - 1) / 3) * 265 + 10;
        u116.SizeOffsetX = 200;
        u116.SizeOffsetY = 255;
        if u115.Structure then
            local v117 = Gen(u115.Structure);
            if v117 then
                v117.Parent = u116;
            end;
        else
            if u115.Image then
                local v118 = l__Image__13(u116, u115.Image);
                v118.PosOffsetX = 5;
                v118.PosOffsetY = 5;
                v118.SizeOffsetX = 190;
                v118.SizeOffsetY = 190;
                v118.DrawBackground = false;
            elseif u115.ImageColor then
                local v119 = l__New__12(u116);
                v119.PosOffsetX = 5;
                v119.PosOffsetY = 5;
                v119.SizeOffsetX = 190;
                v119.SizeOffsetY = 190;
                local l__ImageColor__46 = u115.ImageColor;
                v119.BackgroundColor = u2.Color(l__ImageColor__46[1], l__ImageColor__46[2], l__ImageColor__46[3]);
            end;
            local _ = u115.ViewModel;
            if u115.Price then
                local v120 = l__TextBox__14(u116, u115.Price .. "Pr");
                v120.TextColor = u110;
                v120.TextStrokeColor = u111;
                v120.PosOffsetX = 10;
                v120.PosOffsetY = 170;
                v120.SizeOffsetY = 20;
                v120.SizeScaleX = 1;
                v120.TextAlignment = "Left";
                v120.DrawBackground = false;
            end;
            local v121 = l__TextBox__14(u116, u115.Name);
            v121.PosOffsetY = 200;
            v121.SizeOffsetY = 20;
            v121.SizeScaleX = 1;
            v121.TextAlignment = "Center";
            v121.DrawBackground = false;
            local v122 = l__TextBox__14(u116, u115.Description);
            v122.PosOffsetX = 5;
            v122.PosOffsetY = 220;
            v122.SizeOffsetX = -10;
            v122.SizeOffsetY = 30;
            v122.SizeScaleX = 1;
            v122.TextSize = 10 * u2.roblox_messing_with_guis_factor;
            v122.TextWraps = true;
            v122.TextColor = u109;
            v122.TextAlignment = "Center";
            v122.DrawBackground = false;
        end;
        function u116.Fade(p123) --[[ Line: 667 ]]
            -- upvalues: u116 (copy), l__ColourLerp__11 (ref), l__Color0__32 (ref), l__Color1__33 (ref)
            u116.BackgroundColor = l__ColourLerp__11(l__Color0__32, l__Color1__33, p123);
        end;
        if u115.IsOwned then
            function u116.Button1Down() --[[ Line: 671 ]]
                -- upvalues: u89 (ref), u115 (copy)
                u89(u115.ID, true);
            end;
            function u116.Button2Down(p124, p125) --[[ Line: 674 ]]
                -- upvalues: u108 (ref), u115 (copy), u116 (copy)
                u108(u115, u116.PosX + p124 + 1, u116.PosY + p125 + 1);
            end;
        end;
        if u115.ID and u115.Price then
            function u116.Button1Down(_, _) --[[ Line: 680 ]]
                -- upvalues: l__Call__15 (ref), u115 (copy)
                l__Call__15("RequestPurchase", u115.ID);
            end;
        end;
    end;
    u60.SizeOffsetY = l__ceil__6(#p112 / 3) * 265 + 10;
end;
local u127 = {
    {
        Name = "Lvl 1 noob",
        Price = 1000,
        Image = "rbxassetid://4978868408",
        Description = "Buy 1000 Pr for 100 Robux."
    },
    {
        Name = "Lvl 5 beginner",
        Price = 2000,
        Image = "rbxassetid://4978868719",
        Description = "Buy 2000 Pr for 200 Robux."
    },
    {
        Name = "Lvl 20 gangster",
        Price = 5000,
        Image = "rbxassetid://4978869038",
        Description = "Buy 5000 Pr for 500 Robux."
    },
    {
        Name = "Lvl 100 boss",
        Price = 10000,
        Image = "rbxassetid://4978869506",
        Description = "Buy 10000 Pr for 1000 Robux."
    }
};
function u24.Button1Down() --[[ Line: 721 ]]
    -- upvalues: u60 (copy), u127 (copy), l__New__12 (copy), l__floor__5 (copy), l__Image__13 (copy), l__TextBox__14 (copy), u110 (copy), u111 (copy), u2 (copy), u109 (copy), l__ColourLerp__11 (copy), l__Color0__32 (copy), l__Color1__33 (copy), l__Call__15 (copy), l__ceil__6 (copy)
    local l__Children__47 = u60.Children;
    for v128 = #l__Children__47, 1, -1 do
        l__Children__47[v128]:Remove();
    end;
    for v129 = 1, #u127 do
        local u130 = u127[v129];
        local u131 = l__New__12(u60);
        u131.PosOffsetX = (v129 - 1) % 3 * 210 + 10;
        u131.PosOffsetY = l__floor__5((v129 - 1) / 3) * 265 + 10;
        u131.SizeOffsetX = 200;
        u131.SizeOffsetY = 255;
        local v132 = l__Image__13(u131, u130.Image);
        v132.PosOffsetX = 5;
        v132.PosOffsetY = 5;
        v132.SizeOffsetX = 190;
        v132.SizeOffsetY = 190;
        v132.DrawBackground = false;
        local v133 = l__TextBox__14(u131, u130.Price .. "Pr");
        v133.TextColor = u110;
        v133.TextStrokeColor = u111;
        v133.PosOffsetX = 10;
        v133.PosOffsetY = 170;
        v133.SizeOffsetY = 20;
        v133.SizeScaleX = 1;
        v133.TextAlignment = "Left";
        v133.DrawBackground = false;
        local v134 = l__TextBox__14(u131, u130.Name);
        v134.PosOffsetY = 200;
        v134.SizeOffsetY = 20;
        v134.SizeScaleX = 1;
        v134.TextAlignment = "Center";
        v134.DrawBackground = false;
        local v135 = l__TextBox__14(u131, u130.Description);
        v135.PosOffsetX = 5;
        v135.PosOffsetY = 220;
        v135.SizeOffsetX = -10;
        v135.SizeOffsetY = 30;
        v135.SizeScaleX = 1;
        v135.TextSize = 10 * u2.roblox_messing_with_guis_factor;
        v135.TextWraps = true;
        v135.TextColor = u109;
        v135.TextAlignment = "Center";
        v135.DrawBackground = false;
        function u131.Fade(p136) --[[ Line: 766 ]]
            -- upvalues: u131 (copy), l__ColourLerp__11 (ref), l__Color0__32 (ref), l__Color1__33 (ref)
            u131.BackgroundColor = l__ColourLerp__11(l__Color0__32, l__Color1__33, p136);
        end;
        function u131.Button1Down() --[[ Line: 769 ]]
            -- upvalues: l__Call__15 (ref), u130 (copy)
            l__Call__15("BuyCurrency", u130.Price);
        end;
    end;
    u60.SizeOffsetY = l__ceil__6(#u127 / 3) * 265 + 10;
end;
local function u140(p137, p138) --[[ Line: 777 ]]
    if p137 then
        local v139 = {
            Name = p137.Title,
            Description = p137.Description
        };
        if p138 then
            v139.IsOwned = true;
        else
            v139.ID = p137.ID;
            v139.Price = p137.PriceP;
        end;
        local l__Type__48 = p137.Type;
        if l__Type__48 == 3 then
            v139.Image = "rbxthumb://type=Asset&id=" .. p137.Data.AssetID .. "&w=420&h=420";
            return v139;
        elseif l__Type__48 == 5 then
            local l__Texture__49 = p137.Data.Trail.Texture;
            if l__Texture__49 then
                v139.Image = "rbxassetid://" .. l__Texture__49;
                return v139;
            else
                local l__Color__50 = p137.Data.Trail.Color;
                if l__Color__50 and #l__Color__50 == 1 then
                    v139.ImageColor = l__Color__50[1];
                    return v139;
                else
                    v139.Image = "rbxassetid://512104556";
                    return v139;
                end;
            end;
        else
            if l__Type__48 == 7 then
                if p137.Data.Mode == 0 then
                    v139.Image = "rbxthumb://type=Asset&id=" .. p137.Data.AssetID .. "&w=420&h=420";
                    return v139;
                end;
                if p137.Data.Mode == 1 then
                    v139.Image = "rbxassetid://" .. p137.Data.Image;
                end;
            end;
            return v139;
        end;
    end;
end;
local u141 = 0;
local function u150() --[[ Line: 816 ]]
    -- upvalues: u141 (ref), l__GetOwnerItemInstances__30 (copy), u140 (copy), l__ItemClasses__25 (copy), u126 (copy), l__GetCachedMetRequirementsClassesOfType__31 (copy)
    if u141 == 0 then
        local v142 = l__GetOwnerItemInstances__30();
        if v142 then
            local v143 = {};
            for v144 = 1, #v142 do
                local v145 = v142[v144];
                local v146 = u140(l__ItemClasses__25[v145.Class], true);
                if v146 then
                    v146.ID = v145.ID;
                    v143[#v143 + 1] = v146;
                else
                    print("[Shop] Missing Class ID=", v145.Class);
                end;
            end;
            u126(v143);
        end;
    else
        local v147 = l__GetCachedMetRequirementsClassesOfType__31(u141);
        if v147 then
            local v148 = {};
            for v149 = 1, #v147 do
                v148[#v148 + 1] = u140(v147[v149], false);
            end;
            u126(v148);
        end;
    end;
end;
local u151 = false;
function v19.Button1Down() --[[ Line: 868 ]]
    -- upvalues: u151 (ref), l__FreeMouse__10 (copy), u17 (copy), u60 (copy), u14 (copy)
    u151 = false;
    l__FreeMouse__10("ShopGui", false);
    u17:Target(0, function() --[[ Line: 871 ]]
        -- upvalues: u60 (ref), u14 (ref)
        local l__Children__51 = u60.Children;
        for v152 = #l__Children__51, 1, -1 do
            l__Children__51[v152]:Remove();
        end;
        u14.Visible = false;
    end);
end;
v4.Add("OpenShop", function() --[[ Line: 891 ]]
    -- upvalues: u151 (ref), l__FreeMouse__10 (copy), l__Call__15 (copy), u14 (copy), u17 (copy), u150 (copy)
    if not u151 then
        u151 = true;
        l__FreeMouse__10("ShopGui", true);
        l__Call__15("GetBalance");
        u14.Visible = true;
        u17:Target(-u14.Parent.SizeY / 2 - u14.SizeY / 2);
        u150();
    end;
end);
local function v154() --[[ Line: 897 ]]
    -- upvalues: u151 (ref), l__FreeMouse__10 (copy), u17 (copy), u60 (copy), u14 (copy), l__Call__15 (copy), u150 (copy)
    if u151 then
        u151 = false;
        l__FreeMouse__10("ShopGui", false);
        u17:Target(0, function() --[[ Line: 871 ]]
            -- upvalues: u60 (ref), u14 (ref)
            local l__Children__52 = u60.Children;
            for v153 = #l__Children__52, 1, -1 do
                l__Children__52[v153]:Remove();
            end;
            u14.Visible = false;
        end);
    else
        u151 = true;
        l__FreeMouse__10("ShopGui", true);
        l__Call__15("GetBalance");
        u14.Visible = true;
        u17:Target(-u14.Parent.SizeY / 2 - u14.SizeY / 2);
        u150();
    end;
end;
l__Gui__16:RegisterBindable("ToggleShop", function(p155) --[[ Line: 905 ]]
    -- upvalues: u151 (ref), l__FreeMouse__10 (copy), u17 (copy), u60 (copy), u14 (copy), l__Call__15 (copy), u150 (copy)
    if p155 == true then
        if u151 then
            u151 = false;
            l__FreeMouse__10("ShopGui", false);
            u17:Target(0, function() --[[ Line: 871 ]]
                -- upvalues: u60 (ref), u14 (ref)
                local l__Children__53 = u60.Children;
                for v156 = #l__Children__53, 1, -1 do
                    l__Children__53[v156]:Remove();
                end;
                u14.Visible = false;
            end);
            return;
        end;
        u151 = true;
        l__FreeMouse__10("ShopGui", true);
        l__Call__15("GetBalance");
        u14.Visible = true;
        u17:Target(-u14.Parent.SizeY / 2 - u14.SizeY / 2);
        u150();
    end;
end, "P");
v4.Add("ToggleShop", v154);
v5.Add("ToggleShop", v154);
return true;
