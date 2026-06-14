-- Decompiled from: ReplicatedStorage.CmdrClient.CmdrInterface.AutoComplete
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
return function(p1) --[[ Line: 5 ]]
    -- upvalues: l__LocalPlayer__1 (copy)
    local u2 = {
        SelectedItem = 0,
        Items = {},
        ItemOptions = {}
    };
    local l__Util__2 = p1.Util;
    local u3 = l__Util__2.MakeDictionary({
        "me",
        "all",
        ".",
        "*",
        "others"
    });
    local l__Autocomplete__3 = l__LocalPlayer__1:WaitForChild("PlayerGui"):WaitForChild("Cmdr"):WaitForChild("Autocomplete");
    local l__TextButton__4 = l__Autocomplete__3:WaitForChild("TextButton");
    local l__Title__5 = l__Autocomplete__3:WaitForChild("Title");
    local l__Description__6 = l__Autocomplete__3:WaitForChild("Description");
    local l__Entry__7 = l__Autocomplete__3.Parent:WaitForChild("Frame"):WaitForChild("Entry");
    l__TextButton__4.Parent = nil;
    local function u8(p4, p5, p6, p7) --[[ Line: 23 ]]
        -- upvalues: l__Util__2 (copy)
        p4.Visible = p6 ~= nil;
        p5.Text = p6 or "";
        if p7 then
            p5.Size = UDim2.new(0, l__Util__2.GetTextSize(p6 or "", p5, Vector2.new(1000, 1000), 1, 0).X, p4.Size.Y.Scale, p4.Size.Y.Offset);
        end;
    end;
    local function u12(p9) --[[ Line: 33 ]]
        -- upvalues: u8 (copy), l__Title__5 (copy), l__Description__6 (copy), l__Autocomplete__3 (copy)
        u8(l__Title__5, l__Title__5.Field, p9.name, true);
        local l__Type__8 = l__Title__5.Field.Type;
        local l__Type__9 = l__Title__5.Field.Type;
        local l__type__10 = p9.type;
        if l__type__10 then
            l__type__10 = ": " .. p9.type:sub(1, 1):upper() .. p9.type:sub(2);
        end;
        l__Type__8.Visible = l__type__10 ~= nil;
        l__Type__9.Text = l__type__10 or "";
        local v10 = l__Description__6;
        local l__Label__11 = l__Description__6.Label;
        local l__description__12 = p9.description;
        v10.Visible = l__description__12 ~= nil;
        l__Label__11.Text = l__description__12 or "";
        l__Description__6.Label.TextColor3 = p9.invalid and Color3.fromRGB(255, 73, 73) or Color3.fromRGB(255, 255, 255);
        local v11 = math.max(l__Title__5.Field.TextBounds.X + l__Title__5.Field.Type.TextBounds.X, l__Autocomplete__3.Size.X.Offset);
        l__Description__6.Size = UDim2.new(1, 0, 0, 40);
        while not l__Description__6.Label.TextFits do
            l__Description__6.Size = l__Description__6.Size + UDim2.new(0, 0, 0, 2);
            if l__Description__6.Size.Y.Offset > 500 then
                break;
            end;
        end;
        wait();
        l__Autocomplete__3.UIListLayout:ApplyLayout();
        l__Autocomplete__3.Size = UDim2.new(0, v11, 0, l__Autocomplete__3.UIListLayout.AbsoluteContentSize.Y);
    end;
    function u2.Show(p13, p14, p15) --[[ Line: 73 ]]
        -- upvalues: u3 (copy), l__TextButton__4 (copy), l__Autocomplete__3 (copy), l__Entry__7 (copy), l__Util__2 (copy), u12 (copy)
        local v16 = p15 or {};
        for _, v17 in pairs(p13.Items) do
            if v17.gui then
                v17.gui:Destroy();
            end;
        end;
        p13.SelectedItem = 1;
        p13.Items = p14;
        p13.Prefix = v16.prefix or "";
        p13.LastItem = v16.isLast or false;
        p13.Command = v16.command;
        p13.Arg = v16.arg;
        p13.NumArgs = v16.numArgs;
        p13.IsPartial = v16.isPartial;
        local v18 = 200;
        for v19, v20 in pairs(p13.Items) do
            local v21 = v20[1];
            local v22 = v20[2];
            if u3[v21] then
                v21 = v22;
            end;
            local v23 = l__TextButton__4:Clone();
            v23.Name = v21 .. v22;
            v23.BackgroundTransparency = v19 == p13.SelectedItem and 0.5 or 1;
            v23.Typed.Text = v21;
            v23.Suggest.Text = string.rep(" ", #v21) .. v22:sub(#v21 + 1);
            v23.Parent = l__Autocomplete__3;
            v23.LayoutOrder = v19;
            local v24 = math.max(v23.Typed.TextBounds.X, v23.Suggest.TextBounds.X) + 20;
            if v18 < v24 then
                v18 = v24;
            end;
            v20.gui = v23;
        end;
        l__Autocomplete__3.UIListLayout:ApplyLayout();
        local l__Text__13 = l__Entry__7.TextBox.Text;
        local v25 = l__Util__2.SplitString(l__Text__13);
        if l__Text__13:sub(#l__Text__13, #l__Text__13) == " " and not v16.at then
            v25[#v25 + 1] = "e";
        end;
        table.remove(v25, #v25);
        local v26 = v16.at and v16.at or #table.concat(v25, " ") + 1;
        l__Autocomplete__3.Position = UDim2.new(0, l__Entry__7.TextBox.AbsolutePosition.X - 10 + v26 * 7, 0, l__Entry__7.TextBox.AbsolutePosition.Y + 30);
        l__Autocomplete__3.Size = UDim2.new(0, v18, 0, l__Autocomplete__3.UIListLayout.AbsoluteContentSize.Y);
        l__Autocomplete__3.Visible = true;
        local v27 = u12;
        if p13.Items[1] then
            v16 = p13.Items[1].options or v16;
        end;
        v27(v16);
    end;
    function u2.GetSelectedItem(_) --[[ Line: 141 ]]
        -- upvalues: l__Autocomplete__3 (copy), u2 (copy)
        if l__Autocomplete__3.Visible == false then
            return nil;
        else
            return u2.Items[u2.SelectedItem];
        end;
    end;
    function u2.Hide(_) --[[ Line: 150 ]]
        -- upvalues: l__Autocomplete__3 (copy)
        l__Autocomplete__3.Visible = false;
    end;
    function u2.IsVisible(_) --[[ Line: 155 ]]
        -- upvalues: l__Autocomplete__3 (copy)
        return l__Autocomplete__3.Visible;
    end;
    function u2.Select(p28, p29) --[[ Line: 160 ]]
        -- upvalues: l__Autocomplete__3 (copy), u12 (copy)
        if l__Autocomplete__3.Visible then
            p28.SelectedItem = p28.SelectedItem + p29;
            if p28.SelectedItem > #p28.Items then
                p28.SelectedItem = 1;
            elseif p28.SelectedItem < 1 then
                p28.SelectedItem = #p28.Items;
            end;
            for v30, v31 in pairs(p28.Items) do
                v31.gui.BackgroundTransparency = v30 == p28.SelectedItem and 0.5 or 1;
            end;
            if p28.Items[p28.SelectedItem] and p28.Items[p28.SelectedItem].options then
                u12(p28.Items[p28.SelectedItem].options or {});
            end;
        end;
    end;
    return u2;
end;
