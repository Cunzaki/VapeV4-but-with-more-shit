-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.API
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);
return function(u1) --[[ Line: 3 ]]
    local u2 = "Window";
    function u1.Window(p3, p4) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u2 (copy)
        return u1.Internal._Insert(u2, p3, p4);
    end;
    u1.SetFocusedWindow = u1.Internal.SetFocusedWindow;
    local u5 = "Tooltip";
    function u1.Tooltip(p6, p7) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u5 (copy)
        return u1.Internal._Insert(u5, p6, p7);
    end;
    local u8 = "MenuBar";
    function u1.MenuBar(p9, p10) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u8 (copy)
        return u1.Internal._Insert(u8, p9, p10);
    end;
    local u11 = "Menu";
    function u1.Menu(p12, p13) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u11 (copy)
        return u1.Internal._Insert(u11, p12, p13);
    end;
    local u14 = "MenuItem";
    function u1.MenuItem(p15, p16) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u14 (copy)
        return u1.Internal._Insert(u14, p15, p16);
    end;
    local u17 = "MenuToggle";
    function u1.MenuToggle(p18, p19) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u17 (copy)
        return u1.Internal._Insert(u17, p18, p19);
    end;
    local u20 = "Separator";
    function u1.Separator(p21, p22) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u20 (copy)
        return u1.Internal._Insert(u20, p21, p22);
    end;
    local u23 = "Indent";
    function u1.Indent(p24, p25) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u23 (copy)
        return u1.Internal._Insert(u23, p24, p25);
    end;
    local u26 = "SameLine";
    function u1.SameLine(p27, p28) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u26 (copy)
        return u1.Internal._Insert(u26, p27, p28);
    end;
    local u29 = "Group";
    function u1.Group(p30, p31) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u29 (copy)
        return u1.Internal._Insert(u29, p30, p31);
    end;
    local u32 = "Text";
    function u1.Text(p33, p34) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u32 (copy)
        return u1.Internal._Insert(u32, p33, p34);
    end;
    function u1.TextWrapped(p35) --[[ Line: 41 ]]
        -- upvalues: u1 (copy)
        p35[2] = true;
        return u1.Internal._Insert("Text", p35);
    end;
    function u1.TextColored(p36) --[[ Line: 46 ]]
        -- upvalues: u1 (copy)
        p36[3] = p36[2];
        p36[2] = nil;
        return u1.Internal._Insert("Text", p36);
    end;
    local u37 = "SeparatorText";
    function u1.SeparatorText(p38, p39) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u37 (copy)
        return u1.Internal._Insert(u37, p38, p39);
    end;
    local u40 = "InputText";
    function u1.InputText(p41, p42) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u40 (copy)
        return u1.Internal._Insert(u40, p41, p42);
    end;
    local u43 = "Button";
    function u1.Button(p44, p45) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u43 (copy)
        return u1.Internal._Insert(u43, p44, p45);
    end;
    local u46 = "SmallButton";
    function u1.SmallButton(p47, p48) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u46 (copy)
        return u1.Internal._Insert(u46, p47, p48);
    end;
    local u49 = "Checkbox";
    function u1.Checkbox(p50, p51) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u49 (copy)
        return u1.Internal._Insert(u49, p50, p51);
    end;
    local u52 = "RadioButton";
    function u1.RadioButton(p53, p54) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u52 (copy)
        return u1.Internal._Insert(u52, p53, p54);
    end;
    local u55 = "Tree";
    function u1.Tree(p56, p57) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u55 (copy)
        return u1.Internal._Insert(u55, p56, p57);
    end;
    local u58 = "CollapsingHeader";
    function u1.CollapsingHeader(p59, p60) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u58 (copy)
        return u1.Internal._Insert(u58, p59, p60);
    end;
    local u61 = "InputNum";
    function u1.InputNum(p62, p63) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u61 (copy)
        return u1.Internal._Insert(u61, p62, p63);
    end;
    local u64 = "InputVector2";
    function u1.InputVector2(p65, p66) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u64 (copy)
        return u1.Internal._Insert(u64, p65, p66);
    end;
    local u67 = "InputVector3";
    function u1.InputVector3(p68, p69) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u67 (copy)
        return u1.Internal._Insert(u67, p68, p69);
    end;
    local u70 = "InputUDim";
    function u1.InputUDim(p71, p72) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u70 (copy)
        return u1.Internal._Insert(u70, p71, p72);
    end;
    local u73 = "InputUDim2";
    function u1.InputUDim2(p74, p75) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u73 (copy)
        return u1.Internal._Insert(u73, p74, p75);
    end;
    local u76 = "InputRect";
    function u1.InputRect(p77, p78) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u76 (copy)
        return u1.Internal._Insert(u76, p77, p78);
    end;
    local u79 = "DragNum";
    function u1.DragNum(p80, p81) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u79 (copy)
        return u1.Internal._Insert(u79, p80, p81);
    end;
    local u82 = "DragVector2";
    function u1.DragVector2(p83, p84) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u82 (copy)
        return u1.Internal._Insert(u82, p83, p84);
    end;
    local u85 = "DragVector3";
    function u1.DragVector3(p86, p87) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u85 (copy)
        return u1.Internal._Insert(u85, p86, p87);
    end;
    local u88 = "DragUDim";
    function u1.DragUDim(p89, p90) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u88 (copy)
        return u1.Internal._Insert(u88, p89, p90);
    end;
    local u91 = "DragUDim2";
    function u1.DragUDim2(p92, p93) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u91 (copy)
        return u1.Internal._Insert(u91, p92, p93);
    end;
    local u94 = "DragRect";
    function u1.DragRect(p95, p96) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u94 (copy)
        return u1.Internal._Insert(u94, p95, p96);
    end;
    local u97 = "InputColor3";
    function u1.InputColor3(p98, p99) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u97 (copy)
        return u1.Internal._Insert(u97, p98, p99);
    end;
    local u100 = "InputColor4";
    function u1.InputColor4(p101, p102) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u100 (copy)
        return u1.Internal._Insert(u100, p101, p102);
    end;
    local u103 = "SliderNum";
    function u1.SliderNum(p104, p105) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u103 (copy)
        return u1.Internal._Insert(u103, p104, p105);
    end;
    local u106 = "SliderVector2";
    function u1.SliderVector2(p107, p108) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u106 (copy)
        return u1.Internal._Insert(u106, p107, p108);
    end;
    local u109 = "SliderVector3";
    function u1.SliderVector3(p110, p111) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u109 (copy)
        return u1.Internal._Insert(u109, p110, p111);
    end;
    local u112 = "SliderUDim";
    function u1.SliderUDim(p113, p114) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u112 (copy)
        return u1.Internal._Insert(u112, p113, p114);
    end;
    local u115 = "SliderUDim2";
    function u1.SliderUDim2(p116, p117) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u115 (copy)
        return u1.Internal._Insert(u115, p116, p117);
    end;
    local u118 = "SliderRect";
    function u1.SliderRect(p119, p120) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u118 (copy)
        return u1.Internal._Insert(u118, p119, p120);
    end;
    local u121 = "Selectable";
    function u1.Selectable(p122, p123) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u121 (copy)
        return u1.Internal._Insert(u121, p122, p123);
    end;
    local u124 = "Combo";
    function u1.Combo(p125, p126) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u124 (copy)
        return u1.Internal._Insert(u124, p125, p126);
    end;
    function u1.ComboArray(p127, p128, p129) --[[ Line: 112 ]]
        -- upvalues: u1 (copy)
        if p128 == nil then
            p128 = u1.State(p129[1]);
        end;
        local v130 = u1.Internal._Insert("Combo", p127, p128);
        local l__index__1 = v130.state.index;
        for _, v131 in p129 do
            u1.Internal._Insert("Selectable", { v131, v131 }, {
                index = l__index__1
            });
        end;
        u1.End();
        return v130;
    end;
    function u1.ComboEnum(p132, p133, p134) --[[ Line: 129 ]]
        -- upvalues: u1 (copy)
        if p133 == nil then
            p133 = u1.State(p134[1]);
        end;
        local v135 = u1.Internal._Insert("Combo", p132, p133);
        local l__index__2 = v135.state.index;
        for _, v136 in p134:GetEnumItems() do
            u1.Internal._Insert("Selectable", { v136.Name, v136 }, {
                index = l__index__2
            });
        end;
        u1.End();
        return v135;
    end;
    u1.InputEnum = u1.ComboEnum;
    local u137 = "Table";
    function u1.Table(p138, p139) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u137 (copy)
        return u1.Internal._Insert(u137, p138, p139);
    end;
    function u1.NextColumn() --[[ Line: 149 ]]
        -- upvalues: u1 (copy)
        local v140 = u1.Internal._GetParentWidget();
        v140.RowColumnIndex = v140.RowColumnIndex + 1;
    end;
    function u1.SetColumnIndex(p141) --[[ Line: 153 ]]
        -- upvalues: u1 (copy)
        local v142 = u1.Internal._GetParentWidget();
        assert(v142.InitialNumColumns <= p141, "Iris.SetColumnIndex Argument must be in column range");
        v142.RowColumnIndex = math.floor(v142.RowColumnIndex / v142.InitialNumColumns) + (p141 - 1);
    end;
    function u1.NextRow() --[[ Line: 159 ]]
        -- upvalues: u1 (copy)
        local v143 = u1.Internal._GetParentWidget();
        local l__InitialNumColumns__3 = v143.InitialNumColumns;
        v143.RowColumnIndex = math.floor((v143.RowColumnIndex + 1) / l__InitialNumColumns__3) * l__InitialNumColumns__3;
    end;
end;
