-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.Menu
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    local u3 = false;
    local u4 = nil;
    local u5 = {};
    local function u9(p6) --[[ Line: 8 ]]
        -- upvalues: u5 (copy), u1 (copy), u3 (ref), u4 (ref)
        for v7 = #u5, p6 and p6 + 1 or 1, -1 do
            local v8 = u5[v7];
            v8.state.isOpened:set(false);
            v8.Instance.BackgroundColor3 = u1._config.HeaderColor;
            v8.Instance.BackgroundTransparency = 1;
            table.remove(u5, v7);
        end;
        if #u5 == 0 then
            u3 = false;
            u4 = nil;
        end;
    end;
    local function u14(p10) --[[ Line: 25 ]]
        -- upvalues: u1 (copy)
        local v11 = p10.parentWidget.type == "Menu";
        local l__Instance__1 = p10.Instance;
        local l__ChildContainer__2 = p10.ChildContainer;
        l__ChildContainer__2.Size = UDim2.fromOffset(math.max(l__ChildContainer__2.AbsoluteSize.X, l__Instance__1.AbsoluteSize.X), (math.max(l__ChildContainer__2.AbsoluteSize.Y, l__Instance__1.AbsoluteSize.Y)));
        if l__ChildContainer__2.Parent == nil then
        else
            local l__AbsolutePosition__3 = l__Instance__1.AbsolutePosition;
            local l__AbsoluteSize__4 = l__Instance__1.AbsoluteSize;
            local l__AbsoluteSize__5 = l__ChildContainer__2.AbsoluteSize;
            local l__PopupBorderSize__6 = u1._config.PopupBorderSize;
            local l__AbsoluteSize__7 = l__ChildContainer__2.Parent.AbsoluteSize;
            local v12 = l__AbsolutePosition__3.X + l__PopupBorderSize__6;
            if p10.parentWidget.type == "Menu" then
                if l__AbsolutePosition__3.X + l__AbsoluteSize__5.X > l__AbsoluteSize__7.X then
                    v12 = l__AbsolutePosition__3.X - l__PopupBorderSize__6 - (v11 and (l__AbsoluteSize__5.X or 0) or 0);
                else
                    v12 = l__AbsolutePosition__3.X + l__PopupBorderSize__6 + (v11 and (l__AbsoluteSize__4.X or 0) or 0);
                end;
            end;
            local v13;
            if l__AbsolutePosition__3.Y + l__AbsoluteSize__5.Y > l__AbsoluteSize__7.Y then
                v13 = l__AbsolutePosition__3.Y - l__PopupBorderSize__6 - l__AbsoluteSize__5.Y + (v11 and l__AbsoluteSize__4.Y or 0);
            else
                v13 = l__AbsolutePosition__3.Y + l__PopupBorderSize__6 + (v11 and 0 or l__AbsoluteSize__4.Y);
            end;
            l__ChildContainer__2.Position = UDim2.fromOffset(v12, v13);
        end;
    end;
    u2.UserInputService.InputBegan:Connect(function(p15) --[[ Line: 62 ]]
        -- upvalues: u3 (ref), u4 (ref), u2 (copy), u5 (copy), u9 (copy)
        if p15.UserInputType ~= Enum.UserInputType.MouseButton1 and p15.UserInputType ~= Enum.UserInputType.MouseButton2 then
            return;
        end;
        if u3 == false then
            return;
        end;
        if u4 == nil then
            return;
        end;
        local v16 = u2.getMouseLocation();
        local v17 = false;
        for _, v18 in u5 do
            for _, v19 in { v18.ChildContainer, v18.Instance } do
                local l__AbsolutePosition__8 = v19.AbsolutePosition;
                if u2.isPosInsideRect(v16, l__AbsolutePosition__8, l__AbsolutePosition__8 + v19.AbsoluteSize) then
                    v17 = true;
                    break;
                end;
            end;
        end;
        if not v17 then
            u9();
        end;
    end);
    u1.WidgetConstructor("MenuBar", {
        hasState = false,
        hasChildren = true,
        Args = {},
        Events = {},
        Generate = function(p20) --[[ Name: Generate, Line 97 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v21 = Instance.new("Frame");
            v21.Name = "MenuBar";
            v21.Size = UDim2.fromScale(1, 0);
            v21.AutomaticSize = Enum.AutomaticSize.Y;
            v21.BackgroundColor3 = u1._config.MenubarBgColor;
            v21.BackgroundTransparency = u1._config.MenubarBgTransparency;
            v21.BorderSizePixel = 0;
            v21.ZIndex = p20.ZIndex;
            v21.LayoutOrder = p20.ZIndex;
            v21.ClipsDescendants = true;
            u2.UIPadding(v21, Vector2.new(u1._config.ItemSpacing.X, 2));
            u2.UIListLayout(v21, Enum.FillDirection.Horizontal, UDim.new()).VerticalAlignment = Enum.VerticalAlignment.Center;
            return v21;
        end,
        Update = function(p22) --[[ Name: Update, Line 114 ]]
            -- upvalues: u1 (copy)
            local l__parentWidget__9 = p22.parentWidget;
            if l__parentWidget__9.type == "Window" then
                local l__Instance__10 = l__parentWidget__9.Instance;
                if l__Instance__10 then
                    l__Instance__10 = l__parentWidget__9.Instance:FindFirstChild("WindowButton");
                end;
                if l__Instance__10 then
                    p22.Instance.Parent = l__Instance__10;
                    local u23 = #u1._postCycleCallbacks + 1;
                    local u24 = u1._cycleTick + 1;
                    u1._postCycleCallbacks[u23] = function() --[[ Line: 125 ]]
                        -- upvalues: u1 (ref), u24 (copy), l__parentWidget__9 (copy), u23 (copy)
                        if u1._cycleTick == u24 then
                            u1._widgets.Window.Update(l__parentWidget__9);
                            u1._postCycleCallbacks[u23] = nil;
                        end;
                    end;
                end;
            elseif l__parentWidget__9.type == "Root" then
            else
                error("The MenuBar was not created directly under a window or root.");
            end;
        end,
        ChildAdded = function(p25) --[[ Name: ChildAdded, Line 139 ]]
            return p25.Instance;
        end,
        Discard = function(p26) --[[ Name: Discard, Line 142 ]]
            -- upvalues: u1 (copy)
            local l__parentWidget__11 = p26.parentWidget;
            p26.Instance:Destroy();
            u1._widgets.Window.Update(l__parentWidget__11);
        end
    });
    u1.WidgetConstructor("Menu", {
        hasState = true,
        hasChildren = true,
        Args = {
            Text = 1
        },
        Events = {
            clicked = u2.EVENTS.click(function(p27) --[[ Line: 157 ]]
                return p27.Instance;
            end),
            hovered = u2.EVENTS.hover(function(p28) --[[ Line: 160 ]]
                return p28.Instance;
            end),
            opened = {
                Init = function(_) --[[ Line: 164 ]] end,
                Get = function(p29) --[[ Line: 165 ]]
                    -- upvalues: u1 (copy)
                    return p29.lastOpenedTick == u1._cycleTick;
                end
            },
            closed = {
                Init = function(_) --[[ Line: 170 ]] end,
                Get = function(p30) --[[ Line: 171 ]]
                    -- upvalues: u1 (copy)
                    return p30.lastClosedTick == u1._cycleTick;
                end
            }
        },
        Generate = function(u31) --[[ Name: Generate, Line 176 ]]
            -- upvalues: u1 (copy), u2 (copy), u5 (copy), u3 (ref), u4 (ref), u9 (copy)
            u31.ButtonColors = {
                ButtonTransparency = 1,
                ButtonColor = u1._config.HeaderColor,
                ButtonHoveredColor = u1._config.HeaderHoveredColor,
                ButtonHoveredTransparency = u1._config.HeaderHoveredTransparency,
                ButtonActiveColor = u1._config.HeaderHoveredColor,
                ButtonActiveTransparency = u1._config.HeaderHoveredTransparency
            };
            local v32;
            if u31.parentWidget.type == "Menu" then
                v32 = Instance.new("TextButton");
                v32.Name = "Menu";
                v32.BackgroundColor3 = u1._config.HeaderColor;
                v32.BackgroundTransparency = 1;
                v32.BorderSizePixel = 0;
                v32.Size = UDim2.fromScale(1, 0);
                v32.Text = "";
                v32.AutomaticSize = Enum.AutomaticSize.Y;
                v32.ZIndex = u31.ZIndex;
                v32.LayoutOrder = u31.ZIndex;
                v32.AutoButtonColor = false;
                local v33 = u2.UIPadding(v32, u1._config.FramePadding);
                v33.PaddingTop = v33.PaddingTop - UDim.new(0, 1);
                u2.UIListLayout(v32, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
                local v34 = Instance.new("TextLabel");
                v34.Name = "TextLabel";
                v34.AnchorPoint = Vector2.new(0, 0);
                v34.BackgroundTransparency = 1;
                v34.BorderSizePixel = 0;
                v34.ZIndex = u31.ZIndex + 2;
                v34.LayoutOrder = u31.ZIndex + 2;
                v34.AutomaticSize = Enum.AutomaticSize.XY;
                u2.applyTextStyle(v34);
                v34.Parent = v32;
                local v35 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
                local v36 = v35 - math.round(v35 * 0.2) * 2;
                local v37 = Instance.new("ImageLabel");
                v37.Name = "Icon";
                v37.Size = UDim2.fromOffset(v36, v36);
                v37.BackgroundTransparency = 1;
                v37.BorderSizePixel = 0;
                v37.ImageColor3 = u1._config.TextColor;
                v37.ImageTransparency = u1._config.TextTransparency;
                v37.Image = u2.ICONS.RIGHT_POINTING_TRIANGLE;
                v37.ZIndex = u31.ZIndex + 3;
                v37.LayoutOrder = u31.ZIndex + 3;
                v37.Parent = v32;
            else
                v32 = Instance.new("TextButton");
                v32.Name = "Menu";
                v32.Size = UDim2.fromScale(0, 0);
                v32.AutomaticSize = Enum.AutomaticSize.XY;
                v32.BackgroundColor3 = u1._config.HeaderColor;
                v32.BackgroundTransparency = 1;
                v32.BorderSizePixel = 0;
                v32.Text = "";
                v32.LayoutOrder = u31.ZIndex;
                v32.ZIndex = u31.ZIndex;
                v32.AutoButtonColor = false;
                v32.ClipsDescendants = true;
                u2.applyTextStyle(v32);
                u2.UIPadding(v32, Vector2.new(u1._config.ItemSpacing.X, u1._config.FramePadding.Y));
            end;
            u2.applyInteractionHighlights(v32, v32, u31.ButtonColors);
            v32.MouseButton1Click:Connect(function() --[[ Line: 252 ]]
                -- upvalues: u5 (ref), u31 (copy), u3 (ref), u4 (ref)
                local v38 = #u5 > 1 and true or not u31.state.isOpened.value;
                u31.state.isOpened:set(v38);
                u3 = v38;
                u4 = v38 and u31 or nil;
                if #u5 <= 1 then
                    if v38 then
                        table.insert(u5, u31);
                        return;
                    end;
                    table.remove(u5);
                end;
            end);
            v32.MouseEnter:Connect(function() --[[ Line: 267 ]]
                -- upvalues: u3 (ref), u4 (ref), u31 (copy), u5 (ref), u9 (ref)
                if u3 and (u4 and u4 ~= u31) then
                    u9((table.find(u5, u31.parentWidget)));
                    u31.state.isOpened:set(true);
                    u4 = u31;
                    u3 = true;
                    table.insert(u5, u31);
                end;
            end);
            local v39 = Instance.new("ScrollingFrame");
            v39.Name = "ChildContainer";
            v39.BackgroundColor3 = u1._config.WindowBgColor;
            v39.BackgroundTransparency = u1._config.WindowBgTransparency;
            v39.BorderSizePixel = 0;
            v39.Size = UDim2.fromOffset(0, 0);
            v39.AutomaticSize = Enum.AutomaticSize.XY;
            v39.AutomaticCanvasSize = Enum.AutomaticSize.Y;
            v39.ScrollBarImageTransparency = u1._config.ScrollbarGrabTransparency;
            v39.ScrollBarImageColor3 = u1._config.ScrollbarGrabColor;
            v39.ScrollBarThickness = u1._config.ScrollbarSize;
            v39.CanvasSize = UDim2.fromScale(0, 0);
            v39.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar;
            v39.ZIndex = u31.ZIndex + 6;
            v39.LayoutOrder = u31.ZIndex + 6;
            v39.ClipsDescendants = true;
            u2.UIListLayout(v39, Enum.FillDirection.Vertical, UDim.new(0, 1)).VerticalAlignment = Enum.VerticalAlignment.Top;
            local l___rootInstance__12 = u1._rootInstance;
            if l___rootInstance__12 then
                l___rootInstance__12 = u1._rootInstance:FindFirstChild("PopupScreenGui");
            end;
            v39.Parent = l___rootInstance__12;
            u31.ChildContainer = v39;
            u2.UIStroke(v39, u1._config.WindowBorderSize, u1._config.BorderColor, u1._config.BorderTransparency);
            u2.UIPadding(v39, Vector2.new(2, u1._config.WindowPadding.Y - u1._config.ItemSpacing.Y));
            return v32;
        end,
        Update = function(p40) --[[ Name: Update, Line 316 ]]
            local l__Instance__13 = p40.Instance;
            if p40.parentWidget.type == "Menu" then
                l__Instance__13 = l__Instance__13.TextLabel;
            end;
            l__Instance__13.Text = p40.arguments.Text or "Menu";
        end,
        ChildAdded = function(p41, _) --[[ Name: ChildAdded, Line 326 ]]
            -- upvalues: u14 (copy)
            u14(p41);
            return p41.ChildContainer;
        end,
        ChildDiscarded = function(p42, _) --[[ Name: ChildDiscarded, Line 330 ]]
            -- upvalues: u14 (copy)
            u14(p42);
        end,
        GenerateState = function(p43) --[[ Name: GenerateState, Line 333 ]]
            -- upvalues: u1 (copy)
            if p43.state.isOpened == nil then
                p43.state.isOpened = u1._widgetState(p43, "isOpened", false);
            end;
        end,
        UpdateState = function(p44) --[[ Name: UpdateState, Line 338 ]]
            -- upvalues: u1 (copy), u14 (copy)
            local l__ChildContainer__14 = p44.ChildContainer;
            if p44.state.isOpened.value then
                p44.lastOpenedTick = u1._cycleTick + 1;
                p44.ButtonColors.ButtonTransparency = u1._config.HeaderTransparency;
                l__ChildContainer__14.Visible = true;
                u14(p44);
            else
                p44.lastClosedTick = u1._cycleTick + 1;
                p44.ButtonColors.ButtonTransparency = 1;
                l__ChildContainer__14.Visible = false;
            end;
        end,
        Discard = function(p45) --[[ Name: Discard, Line 353 ]]
            -- upvalues: u2 (copy)
            p45.Instance:Destroy();
            u2.discardState(p45);
        end
    });
    u1.WidgetConstructor("MenuItem", {
        hasState = false,
        hasChildren = false,
        Args = {
            Text = 1,
            KeyCode = 2,
            ModifierKey = 3
        },
        Events = {
            clicked = u2.EVENTS.click(function(p46) --[[ Line: 368 ]]
                return p46.Instance;
            end),
            hovered = u2.EVENTS.hover(function(p47) --[[ Line: 371 ]]
                return p47.Instance;
            end)
        },
        Generate = function(u48) --[[ Name: Generate, Line 375 ]]
            -- upvalues: u2 (copy), u1 (copy), u9 (copy), u3 (ref), u4 (ref), u5 (copy)
            local v49 = Instance.new("TextButton");
            v49.Name = "MenuItem";
            v49.BackgroundTransparency = 1;
            v49.BorderSizePixel = 0;
            v49.Size = UDim2.fromScale(1, 0);
            v49.Text = "";
            v49.AutomaticSize = Enum.AutomaticSize.Y;
            v49.ZIndex = u48.ZIndex;
            v49.LayoutOrder = u48.ZIndex;
            v49.AutoButtonColor = false;
            local v50 = u2.UIPadding(v49, u1._config.FramePadding);
            v50.PaddingTop = v50.PaddingTop - UDim.new(0, 1);
            u2.UIListLayout(v49, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X));
            u2.applyInteractionHighlights(v49, v49, {
                ButtonTransparency = 1,
                ButtonColor = u1._config.HeaderColor,
                ButtonHoveredColor = u1._config.HeaderHoveredColor,
                ButtonHoveredTransparency = u1._config.HeaderHoveredTransparency,
                ButtonActiveColor = u1._config.HeaderHoveredColor,
                ButtonActiveTransparency = u1._config.HeaderHoveredTransparency
            });
            v49.MouseButton1Click:Connect(function() --[[ Line: 400 ]]
                -- upvalues: u9 (ref)
                u9();
            end);
            v49.MouseEnter:Connect(function() --[[ Line: 404 ]]
                -- upvalues: u48 (copy), u3 (ref), u4 (ref), u5 (ref), u9 (ref)
                local l__parentWidget__15 = u48.parentWidget;
                if u3 and (u4 and u4 ~= l__parentWidget__15) then
                    u9((table.find(u5, l__parentWidget__15)));
                    u4 = l__parentWidget__15;
                    u3 = true;
                end;
            end);
            local v51 = Instance.new("TextLabel");
            v51.Name = "TextLabel";
            v51.AnchorPoint = Vector2.new(0, 0);
            v51.BackgroundTransparency = 1;
            v51.BorderSizePixel = 0;
            v51.ZIndex = u48.ZIndex + 2;
            v51.LayoutOrder = u48.ZIndex + 2;
            v51.AutomaticSize = Enum.AutomaticSize.XY;
            u2.applyTextStyle(v51);
            v51.Parent = v49;
            local v52 = Instance.new("TextLabel");
            v52.Name = "Shortcut";
            v52.AnchorPoint = Vector2.new(0, 0);
            v52.BackgroundTransparency = 1;
            v52.BorderSizePixel = 0;
            v52.ZIndex = u48.ZIndex + 3;
            v52.LayoutOrder = u48.ZIndex + 3;
            v52.AutomaticSize = Enum.AutomaticSize.XY;
            u2.applyTextStyle(v52);
            v52.Text = "";
            v52.TextColor3 = u1._config.TextDisabledColor;
            v52.TextTransparency = u1._config.TextDisabledTransparency;
            v52.Parent = v49;
            return v49;
        end,
        Update = function(p53) --[[ Name: Update, Line 447 ]]
            local l__Instance__16 = p53.Instance;
            local l__TextLabel__17 = l__Instance__16.TextLabel;
            local l__Shortcut__18 = l__Instance__16.Shortcut;
            l__TextLabel__17.Text = p53.arguments.Text;
            if p53.arguments.KeyCode then
                l__Shortcut__18.Text = p53.arguments.ModifierKey.Name .. " + " .. p53.arguments.KeyCode.Name;
            end;
        end,
        Discard = function(p54) --[[ Name: Discard, Line 457 ]]
            p54.Instance:Destroy();
        end
    });
    u1.WidgetConstructor("MenuToggle", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            KeyCode = 2,
            ModifierKey = 3
        },
        Events = {
            checked = {
                Init = function(_) --[[ Line: 472 ]] end,
                Get = function(p55) --[[ Line: 473 ]]
                    -- upvalues: u1 (copy)
                    return p55.lastCheckedTick == u1._cycleTick;
                end
            },
            unchecked = {
                Init = function(_) --[[ Line: 478 ]] end,
                Get = function(p56) --[[ Line: 479 ]]
                    -- upvalues: u1 (copy)
                    return p56.lastUncheckedTick == u1._cycleTick;
                end
            },
            hovered = u2.EVENTS.hover(function(p57) --[[ Line: 483 ]]
                return p57.Instance;
            end)
        },
        Generate = function(u58) --[[ Name: Generate, Line 487 ]]
            -- upvalues: u2 (copy), u1 (copy), u9 (copy), u3 (ref), u4 (ref), u5 (copy)
            local v59 = Instance.new("TextButton");
            v59.Name = "MenuItem";
            v59.BackgroundTransparency = 1;
            v59.BorderSizePixel = 0;
            v59.Size = UDim2.fromScale(1, 0);
            v59.Text = "";
            v59.AutomaticSize = Enum.AutomaticSize.Y;
            v59.ZIndex = u58.ZIndex;
            v59.LayoutOrder = u58.ZIndex;
            v59.AutoButtonColor = false;
            local v60 = u2.UIPadding(v59, u1._config.FramePadding);
            v60.PaddingTop = v60.PaddingTop - UDim.new(0, 1);
            u2.UIListLayout(v59, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            u2.applyInteractionHighlights(v59, v59, {
                ButtonTransparency = 1,
                ButtonColor = u1._config.HeaderColor,
                ButtonHoveredColor = u1._config.HeaderHoveredColor,
                ButtonHoveredTransparency = u1._config.HeaderHoveredTransparency,
                ButtonActiveColor = u1._config.HeaderHoveredColor,
                ButtonActiveTransparency = u1._config.HeaderHoveredTransparency
            });
            v59.MouseButton1Click:Connect(function() --[[ Line: 512 ]]
                -- upvalues: u58 (copy), u9 (ref)
                u58.state.isChecked:set(not u58.state.isChecked.value);
                u9();
            end);
            v59.MouseEnter:Connect(function() --[[ Line: 518 ]]
                -- upvalues: u58 (copy), u3 (ref), u4 (ref), u5 (ref), u9 (ref)
                local l__parentWidget__19 = u58.parentWidget;
                if u3 and (u4 and u4 ~= l__parentWidget__19) then
                    u9((table.find(u5, l__parentWidget__19)));
                    u4 = l__parentWidget__19;
                    u3 = true;
                end;
            end);
            local v61 = Instance.new("TextLabel");
            v61.Name = "TextLabel";
            v61.AnchorPoint = Vector2.new(0, 0);
            v61.BackgroundTransparency = 1;
            v61.BorderSizePixel = 0;
            v61.ZIndex = u58.ZIndex + 2;
            v61.LayoutOrder = u58.ZIndex + 2;
            v61.AutomaticSize = Enum.AutomaticSize.XY;
            u2.applyTextStyle(v61);
            v61.Parent = v59;
            local v62 = Instance.new("TextLabel");
            v62.Name = "Shortcut";
            v62.AnchorPoint = Vector2.new(0, 0);
            v62.BackgroundTransparency = 1;
            v62.BorderSizePixel = 0;
            v62.ZIndex = u58.ZIndex + 3;
            v62.LayoutOrder = u58.ZIndex + 3;
            v62.AutomaticSize = Enum.AutomaticSize.XY;
            u2.applyTextStyle(v62);
            v62.Text = "";
            v62.TextColor3 = u1._config.TextDisabledColor;
            v62.TextTransparency = u1._config.TextDisabledTransparency;
            v62.Parent = v59;
            local v63 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
            local v64 = v63 - math.round(v63 * 0.2) * 2;
            local v65 = Instance.new("ImageLabel");
            v65.Name = "Icon";
            v65.Size = UDim2.fromOffset(v64, v64);
            v65.BackgroundTransparency = 1;
            v65.BorderSizePixel = 0;
            v65.ImageColor3 = u1._config.TextColor;
            v65.ImageTransparency = u1._config.TextTransparency;
            v65.Image = u2.ICONS.CHECK_MARK;
            v65.ZIndex = u58.ZIndex + 4;
            v65.LayoutOrder = u58.ZIndex + 4;
            v65.Parent = v59;
            return v59;
        end,
        GenerateState = function(p66) --[[ Name: GenerateState, Line 578 ]]
            -- upvalues: u1 (copy)
            if p66.state.isChecked == nil then
                p66.state.isChecked = u1._widgetState(p66, "isChecked", false);
            end;
        end,
        Update = function(p67) --[[ Name: Update, Line 583 ]]
            local l__Instance__20 = p67.Instance;
            local l__TextLabel__21 = l__Instance__20.TextLabel;
            local l__Shortcut__22 = l__Instance__20.Shortcut;
            l__TextLabel__21.Text = p67.arguments.Text;
            if p67.arguments.KeyCode then
                l__Shortcut__22.Text = p67.arguments.ModifierKey.Name .. " + " .. p67.arguments.KeyCode.Name;
            end;
        end,
        UpdateState = function(p68) --[[ Name: UpdateState, Line 593 ]]
            -- upvalues: u2 (copy), u1 (copy)
            local l__Icon__23 = p68.Instance.Icon;
            if p68.state.isChecked.value then
                l__Icon__23.Image = u2.ICONS.CHECK_MARK;
                p68.lastCheckedTick = u1._cycleTick + 1;
            else
                l__Icon__23.Image = "";
                p68.lastUncheckedTick = u1._cycleTick + 1;
            end;
        end,
        Discard = function(p69) --[[ Name: Discard, Line 605 ]]
            -- upvalues: u2 (copy)
            p69.Instance:Destroy();
            u2.discardState(p69);
        end
    });
end;
