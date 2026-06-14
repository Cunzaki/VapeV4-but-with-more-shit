-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.Combo
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    u1.WidgetConstructor("Selectable", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            Index = 2,
            NoClick = 3
        },
        Events = {
            selected = {
                Init = function(_) --[[ Line: 22 ]] end,
                Get = function(p3) --[[ Line: 23 ]]
                    -- upvalues: u1 (copy)
                    return p3.lastSelectedTick == u1._cycleTick;
                end
            },
            unselected = {
                Init = function(_) --[[ Line: 28 ]] end,
                Get = function(p4) --[[ Line: 29 ]]
                    -- upvalues: u1 (copy)
                    return p4.lastUnselectedTick == u1._cycleTick;
                end
            },
            active = {
                Init = function(_) --[[ Line: 34 ]] end,
                Get = function(p5) --[[ Line: 35 ]]
                    return p5.state.index.value == p5.arguments.Index;
                end
            },
            clicked = u2.EVENTS.click(function(p6) --[[ Line: 39 ]]
                return p6.Instance.SelectableButton;
            end),
            rightClicked = u2.EVENTS.rightClick(function(p7) --[[ Line: 43 ]]
                return p7.Instance.SelectableButton;
            end),
            doubleClicked = u2.EVENTS.doubleClick(function(p8) --[[ Line: 47 ]]
                return p8.Instance.SelectableButton;
            end),
            ctrlClicked = u2.EVENTS.ctrlClick(function(p9) --[[ Line: 51 ]]
                return p9.Instance.SelectableButton;
            end),
            hovered = u2.EVENTS.hover(function(p10) --[[ Line: 55 ]]
                return p10.Instance.SelectableButton;
            end)
        },
        Generate = function(u11) --[[ Name: Generate, Line 60 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v12 = Instance.new("Frame");
            v12.Name = "Iris_Selectable";
            v12.Size = UDim2.new(u1._config.ItemWidth, UDim.new(0, u1._config.TextSize));
            v12.AutomaticSize = Enum.AutomaticSize.None;
            v12.BackgroundTransparency = 1;
            v12.BorderSizePixel = 0;
            v12.ZIndex = u11.ZIndex;
            v12.LayoutOrder = u11.ZIndex;
            local v13 = Instance.new("TextButton");
            v13.Name = "SelectableButton";
            v13.Size = UDim2.new(1, 0, 1, u1._config.ItemSpacing.Y - 1);
            v13.Position = UDim2.fromOffset(0, -bit32.rshift(u1._config.ItemSpacing.Y, 1));
            v13.BackgroundColor3 = u1._config.HeaderColor;
            v13.ZIndex = u11.ZIndex + 1;
            v13.LayoutOrder = u11.ZIndex + 1;
            u2.applyFrameStyle(v13);
            u2.applyTextStyle(v13);
            u11.ButtonColors = {
                ButtonTransparency = 1,
                ButtonColor = u1._config.HeaderColor,
                ButtonHoveredColor = u1._config.HeaderHoveredColor,
                ButtonHoveredTransparency = u1._config.HeaderHoveredTransparency,
                ButtonActiveColor = u1._config.HeaderActiveColor,
                ButtonActiveTransparency = u1._config.HeaderActiveTransparency
            };
            u2.applyInteractionHighlights(v13, v13, u11.ButtonColors);
            v13.MouseButton1Click:Connect(function() --[[ Line: 92 ]]
                -- upvalues: u11 (copy)
                if u11.arguments.NoClick ~= true then
                    local v14 = u11;
                    if type(v14.state.index.value) == "boolean" then
                        v14.state.index:set(not v14.state.index.value);
                        return;
                    end;
                    v14.state.index:set(v14.arguments.Index);
                end;
            end);
            v13.Parent = v12;
            return v12;
        end,
        Update = function(p15) --[[ Name: Update, Line 102 ]]
            p15.Instance.SelectableButton.Text = p15.arguments.Text or "Selectable";
        end,
        Discard = function(p16) --[[ Name: Discard, Line 107 ]]
            -- upvalues: u2 (copy)
            p16.Instance:Destroy();
            u2.discardState(p16);
        end,
        GenerateState = function(p17) --[[ Name: GenerateState, Line 111 ]]
            -- upvalues: u1 (copy)
            if p17.state.index == nil then
                if p17.arguments.Index ~= nil then
                    error("a shared state index is required for Selectables with an Index argument", 5);
                end;
                p17.state.index = u1._widgetState(p17, "index", false);
            end;
        end,
        UpdateState = function(p18) --[[ Name: UpdateState, Line 119 ]]
            -- upvalues: u1 (copy)
            local l__SelectableButton__1 = p18.Instance.SelectableButton;
            if p18.state.index.value == (p18.arguments.Index or true) then
                p18.ButtonColors.ButtonTransparency = u1._config.HeaderTransparency;
                l__SelectableButton__1.BackgroundTransparency = u1._config.HeaderTransparency;
                p18.lastSelectedTick = u1._cycleTick + 1;
            else
                p18.ButtonColors.ButtonTransparency = 1;
                l__SelectableButton__1.BackgroundTransparency = 1;
                p18.lastUnselectedTick = u1._cycleTick + 1;
            end;
        end
    });
    local u19 = false;
    local u20 = -1;
    local u21 = nil;
    local function u26(p22) --[[ Line: 138 ]]
        -- upvalues: u1 (copy)
        local l__PreviewContainer__2 = p22.Instance.PreviewContainer;
        local l__PreviewLabel__3 = l__PreviewContainer__2.PreviewLabel;
        local l__ChildContainer__4 = p22.ChildContainer;
        local v23 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
        local l__PopupBorderSize__5 = u1._config.PopupBorderSize;
        local v24 = v23 * math.min(p22.ComboChildrenHeight, 8) - l__PopupBorderSize__5 * 2 + 3 * u1._config.FramePadding.Y;
        local v25 = UDim.new(0, l__PreviewContainer__2.AbsoluteSize.X - l__PopupBorderSize__5 * 2);
        l__ChildContainer__4.Size = UDim2.new(v25, UDim.new(0, v24));
        if l__PreviewLabel__3.AbsolutePosition.Y + v23 + v24 > l__ChildContainer__4.Parent.AbsoluteSize.Y then
            l__ChildContainer__4.Position = UDim2.new(0, l__PreviewLabel__3.AbsolutePosition.X + l__PopupBorderSize__5, 0, l__PreviewLabel__3.AbsolutePosition.Y - l__PopupBorderSize__5 - v24);
        else
            l__ChildContainer__4.Position = UDim2.new(0, l__PreviewLabel__3.AbsolutePosition.X + l__PopupBorderSize__5, 0, l__PreviewLabel__3.AbsolutePosition.Y + v23 + l__PopupBorderSize__5);
        end;
    end;
    u2.UserInputService.InputBegan:Connect(function(p27) --[[ Line: 161 ]]
        -- upvalues: u19 (ref), u20 (ref), u1 (copy), u2 (copy), u21 (ref)
        if p27.UserInputType == Enum.UserInputType.MouseButton1 or (p27.UserInputType == Enum.UserInputType.MouseButton2 or p27.UserInputType == Enum.UserInputType.Touch) then
            if u19 == false then
            elseif u20 == u1._cycleTick then
            else
                local v28 = u2.getMouseLocation();
                local l__ChildContainer__6 = u21.ChildContainer;
                local v29 = l__ChildContainer__6.AbsolutePosition - Vector2.new(0, u21.LabelHeight);
                if not u2.isPosInsideRect(v28, v29, l__ChildContainer__6.AbsolutePosition + l__ChildContainer__6.AbsoluteSize) then
                    u21.state.isOpened:set(false);
                end;
            end;
        end;
    end);
    u1.WidgetConstructor("Combo", {
        hasState = true,
        hasChildren = true,
        Args = {
            Text = 1,
            NoButton = 2,
            NoPreview = 3
        },
        Events = {
            opened = {
                Init = function(_) --[[ Line: 190 ]] end,
                Get = function(p30) --[[ Line: 191 ]]
                    -- upvalues: u1 (copy)
                    return p30.lastOpenedTick == u1._cycleTick;
                end
            },
            closed = {
                Init = function(_) --[[ Line: 196 ]] end,
                Get = function(p31) --[[ Line: 197 ]]
                    -- upvalues: u1 (copy)
                    return p31.lastClosedTick == u1._cycleTick;
                end
            },
            clicked = u2.EVENTS.click(function(p32) --[[ Line: 201 ]]
                return p32.Instance;
            end),
            hovered = u2.EVENTS.hover(function(p33) --[[ Line: 204 ]]
                return p33.Instance;
            end)
        },
        Generate = function(u34) --[[ Name: Generate, Line 208 ]]
            -- upvalues: u1 (copy), u2 (copy), u19 (ref), u21 (ref)
            local v35 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
            u34.ComboChildrenHeight = 0;
            local v36 = Instance.new("Frame");
            v36.Name = "Iris_Combo";
            v36.Size = UDim2.fromScale(1, 0);
            v36.AutomaticSize = Enum.AutomaticSize.Y;
            v36.BackgroundTransparency = 1;
            v36.BorderSizePixel = 0;
            v36.ZIndex = u34.ZIndex;
            v36.LayoutOrder = u34.ZIndex;
            u2.UIListLayout(v36, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.Y + 1));
            local v37 = Instance.new("TextButton");
            v37.Name = "PreviewContainer";
            v37.Size = UDim2.new(u1._config.ContentWidth, UDim.new(0, 0));
            v37.AutomaticSize = Enum.AutomaticSize.Y;
            v37.BackgroundTransparency = 1;
            v37.Text = "";
            v37.ZIndex = u34.ZIndex + 2;
            v37.LayoutOrder = u34.ZIndex + 2;
            v37.AutoButtonColor = false;
            u2.applyFrameStyle(v37, true, true);
            u2.UIListLayout(v37, Enum.FillDirection.Horizontal, UDim.new(0, 0));
            v37.Parent = v36;
            local v38 = Instance.new("TextLabel");
            v38.Name = "PreviewLabel";
            v38.Size = UDim2.new(1, 0, 0, 0);
            v38.AutomaticSize = Enum.AutomaticSize.Y;
            v38.BackgroundColor3 = u1._config.FrameBgColor;
            v38.BackgroundTransparency = u1._config.FrameBgTransparency;
            v38.BorderSizePixel = 0;
            v38.ZIndex = u34.ZIndex + 3;
            v38.LayoutOrder = u34.ZIndex + 3;
            u2.applyTextStyle(v38);
            u2.UIPadding(v38, u1._config.FramePadding);
            v38.Parent = v37;
            local v39 = Instance.new("TextLabel");
            v39.Name = "DropdownButton";
            v39.Size = UDim2.new(0, v35, 0, v35);
            v39.BorderSizePixel = 0;
            v39.BackgroundColor3 = u1._config.ButtonColor;
            v39.BackgroundTransparency = u1._config.ButtonTransparency;
            v39.Text = "";
            v39.ZIndex = u34.ZIndex + 4;
            v39.LayoutOrder = u34.ZIndex + 4;
            local v40 = math.round(v35 * 0.2);
            local v41 = v35 - v40 * 2;
            local v42 = Instance.new("ImageLabel");
            v42.Name = "Dropdown";
            v42.Size = UDim2.fromOffset(v41, v41);
            v42.Position = UDim2.fromOffset(v40, v40);
            v42.BackgroundTransparency = 1;
            v42.BorderSizePixel = 0;
            v42.ImageColor3 = u1._config.TextColor;
            v42.ImageTransparency = u1._config.TextTransparency;
            v42.ZIndex = u34.ZIndex + 5;
            v42.LayoutOrder = u34.ZIndex + 5;
            v42.Parent = v39;
            v39.Parent = v37;
            u2.applyInteractionHighlightsWithMultiHighlightee(v37, {
                {
                    v38,
                    {
                        ButtonColor = u1._config.FrameBgColor,
                        ButtonTransparency = u1._config.FrameBgTransparency,
                        ButtonHoveredColor = u1._config.FrameBgHoveredColor,
                        ButtonHoveredTransparency = u1._config.FrameBgHoveredTransparency,
                        ButtonActiveColor = u1._config.FrameBgActiveColor,
                        ButtonActiveTransparency = u1._config.FrameBgActiveTransparency
                    }
                },
                {
                    v39,
                    {
                        ButtonColor = u1._config.ButtonColor,
                        ButtonTransparency = u1._config.ButtonTransparency,
                        ButtonHoveredColor = u1._config.ButtonHoveredColor,
                        ButtonHoveredTransparency = u1._config.ButtonHoveredTransparency,
                        ButtonActiveColor = u1._config.ButtonHoveredColor,
                        ButtonActiveTransparency = u1._config.ButtonHoveredColor
                    }
                }
            });
            v37.InputBegan:Connect(function(p43) --[[ Line: 308 ]]
                -- upvalues: u19 (ref), u21 (ref), u34 (copy)
                if u19 and u21 ~= u34 then
                else
                    if p43.UserInputType == Enum.UserInputType.MouseButton1 or p43.UserInputType == Enum.UserInputType.Touch then
                        u34.state.isOpened:set(not u34.state.isOpened.value);
                    end;
                end;
            end);
            local v44 = Instance.new("TextLabel");
            v44.Name = "TextLabel";
            v44.Size = UDim2.fromOffset(0, v35);
            v44.AutomaticSize = Enum.AutomaticSize.X;
            v44.BackgroundTransparency = 1;
            v44.BorderSizePixel = 0;
            v44.ZIndex = u34.ZIndex + 5;
            v44.LayoutOrder = u34.ZIndex + 5;
            u2.applyTextStyle(v44);
            v44.Parent = v36;
            local v45 = Instance.new("ScrollingFrame");
            v45.Name = "ChildContainer";
            v45.BackgroundColor3 = u1._config.WindowBgColor;
            v45.BackgroundTransparency = u1._config.WindowBgTransparency;
            v45.BorderSizePixel = 0;
            v45.AutomaticCanvasSize = Enum.AutomaticSize.Y;
            v45.ScrollBarImageTransparency = u1._config.ScrollbarGrabTransparency;
            v45.ScrollBarImageColor3 = u1._config.ScrollbarGrabColor;
            v45.ScrollBarThickness = u1._config.ScrollbarSize;
            v45.CanvasSize = UDim2.fromScale(0, 0);
            v45.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar;
            v45.ZIndex = u34.ZIndex + 6;
            v45.LayoutOrder = u34.ZIndex + 6;
            v45.ClipsDescendants = true;
            u2.UIStroke(v45, u1._config.WindowBorderSize, u1._config.BorderColor, u1._config.BorderTransparency);
            u2.UIPadding(v45, Vector2.new(2, 2 * u1._config.FramePadding.Y));
            u2.UIListLayout(v45, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.Y)).VerticalAlignment = Enum.VerticalAlignment.Top;
            local l___rootInstance__7 = u1._rootInstance;
            if l___rootInstance__7 then
                l___rootInstance__7 = u1._rootInstance:WaitForChild("PopupScreenGui");
            end;
            v45.Parent = l___rootInstance__7;
            u34.ChildContainer = v45;
            return v36;
        end,
        Update = function(p46) --[[ Name: Update, Line 365 ]]
            -- upvalues: u1 (copy)
            local l__Instance__8 = p46.Instance;
            local l__PreviewContainer__9 = l__Instance__8.PreviewContainer;
            local l__PreviewLabel__10 = l__PreviewContainer__9.PreviewLabel;
            local l__DropdownButton__11 = l__PreviewContainer__9.DropdownButton;
            l__Instance__8.TextLabel.Text = p46.arguments.Text or "Combo";
            if p46.arguments.NoButton then
                l__DropdownButton__11.Visible = false;
                l__PreviewLabel__10.Size = UDim2.new(1, 0, 0, 0);
            else
                l__DropdownButton__11.Visible = true;
                l__PreviewLabel__10.Size = UDim2.new(1, -(u1._config.TextSize + 2 * u1._config.FramePadding.Y), 0, 0);
            end;
            if p46.arguments.NoPreview then
                l__PreviewLabel__10.Visible = false;
                l__PreviewContainer__9.Size = UDim2.new(0, 0, 0, 0);
                l__PreviewContainer__9.AutomaticSize = Enum.AutomaticSize.X;
            else
                l__PreviewLabel__10.Visible = true;
                l__PreviewContainer__9.Size = UDim2.new(u1._config.ContentWidth, UDim.new(0, 0));
                l__PreviewContainer__9.AutomaticSize = Enum.AutomaticSize.Y;
            end;
        end,
        ChildAdded = function(p47, p48) --[[ Name: ChildAdded, Line 393 ]]
            -- upvalues: u26 (copy)
            if p48.type == "Selectable" then
                p47.ComboChildrenHeight = p47.ComboChildrenHeight + 1;
            else
                p47.ComboChildrenHeight = p47.ComboChildrenHeight + 10;
            end;
            u26(p47);
            return p47.ChildContainer;
        end,
        ChildDiscarded = function(p49, p50) --[[ Name: ChildDiscarded, Line 403 ]]
            if p50.type == "Selectable" then
                p49.ComboChildrenHeight = p49.ComboChildrenHeight - 1;
            else
                p49.ComboChildrenHeight = p49.ComboChildrenHeight - 10;
            end;
        end,
        GenerateState = function(u51) --[[ Name: GenerateState, Line 410 ]]
            -- upvalues: u1 (copy)
            if u51.state.index == nil then
                u51.state.index = u1._widgetState(u51, "index", "No Selection");
            end;
            u51.state.index:onChange(function() --[[ Line: 414 ]]
                -- upvalues: u51 (copy)
                if u51.state.isOpened.value then
                    u51.state.isOpened:set(false);
                end;
            end);
            if u51.state.isOpened == nil then
                u51.state.isOpened = u1._widgetState(u51, "isOpened", false);
            end;
        end,
        UpdateState = function(p52) --[[ Name: UpdateState, Line 423 ]]
            -- upvalues: u19 (ref), u21 (ref), u20 (ref), u1 (copy), u2 (copy), u26 (copy)
            local l__PreviewContainer__12 = p52.Instance.PreviewContainer;
            local l__PreviewLabel__13 = l__PreviewContainer__12.PreviewLabel;
            local l__Dropdown__14 = l__PreviewContainer__12.DropdownButton.Dropdown;
            local l__ChildContainer__15 = p52.ChildContainer;
            if p52.state.isOpened.value then
                u19 = true;
                u21 = p52;
                u20 = u1._cycleTick;
                p52.lastOpenedTick = u1._cycleTick + 1;
                l__Dropdown__14.Image = u2.ICONS.RIGHT_POINTING_TRIANGLE;
                l__ChildContainer__15.Visible = true;
                u26(p52);
            else
                if u19 then
                    u19 = false;
                    u21 = nil;
                    p52.lastClosedTick = u1._cycleTick + 1;
                end;
                l__Dropdown__14.Image = u2.ICONS.DOWN_POINTING_TRIANGLE;
                l__ChildContainer__15.Visible = false;
            end;
            local l__value__16 = p52.state.index.value;
            local v53;
            if typeof(l__value__16) == "EnumItem" then
                v53 = l__value__16.Name;
            else
                v53 = tostring(l__value__16);
            end;
            l__PreviewLabel__13.Text = v53;
        end,
        Discard = function(p54) --[[ Name: Discard, Line 455 ]]
            -- upvalues: u2 (copy)
            p54.Instance:Destroy();
            u2.discardState(p54);
        end
    });
end;
