-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.Window
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    local function u6() --[[ Line: 4 ]]
        -- upvalues: u1 (copy), u2 (copy)
        if u1._rootInstance == nil then
        else
            local v3 = u1._rootInstance:FindFirstChild("PopupScreenGui");
            if v3 then
                local l__TooltipContainer__1 = v3.TooltipContainer;
                local v4 = u2.getMouseLocation();
                local v5 = u2.findBestWindowPosForPopup(v4, l__TooltipContainer__1.AbsoluteSize, u1._config.DisplaySafeAreaPadding, v3.AbsoluteSize);
                l__TooltipContainer__1.Position = UDim2.fromOffset(v5.X, v5.Y);
            end;
        end;
    end;
    u2.UserInputService.InputChanged:Connect(u6);
    u1.WidgetConstructor("Tooltip", {
        hasState = false,
        hasChildren = false,
        Args = {
            Text = 1
        },
        Events = {},
        Generate = function(p7) --[[ Name: Generate, Line 32 ]]
            -- upvalues: u1 (copy), u2 (copy)
            p7.parentWidget = u1._rootWidget;
            local v8 = Instance.new("Frame");
            v8.Name = "Iris_Tooltip";
            v8.Size = UDim2.new(u1._config.ContentWidth, UDim.new(0, 0));
            v8.AutomaticSize = Enum.AutomaticSize.Y;
            v8.BorderSizePixel = 0;
            v8.BackgroundTransparency = 1;
            v8.ZIndex = p7.ZIndex + 1;
            v8.LayoutOrder = p7.ZIndex + 1;
            local v9 = Instance.new("TextLabel");
            v9.Name = "TooltipText";
            v9.Size = UDim2.fromOffset(0, 0);
            v9.AutomaticSize = Enum.AutomaticSize.XY;
            v9.BackgroundColor3 = u1._config.WindowBgColor;
            v9.BackgroundTransparency = u1._config.WindowBgTransparency;
            v9.BorderSizePixel = u1._config.PopupBorderSize;
            v9.TextWrapped = true;
            v9.ZIndex = p7.ZIndex + 1;
            v9.LayoutOrder = p7.ZIndex + 1;
            u2.applyTextStyle(v9);
            u2.UIStroke(v9, u1._config.WindowBorderSize, u1._config.BorderActiveColor, u1._config.BorderActiveTransparency);
            u2.UIPadding(v9, u1._config.WindowPadding);
            if u1._config.PopupRounding > 0 then
                u2.UICorner(v9, u1._config.PopupRounding);
            end;
            v9.Parent = v8;
            return v8;
        end,
        Update = function(p10) --[[ Name: Update, Line 66 ]]
            -- upvalues: u6 (copy)
            local l__TooltipText__2 = p10.Instance.TooltipText;
            if p10.arguments.Text == nil then
                error("Iris.Text Text Argument is required", 5);
            end;
            l__TooltipText__2.Text = p10.arguments.Text;
            u6();
        end,
        Discard = function(p11) --[[ Name: Discard, Line 75 ]]
            p11.Instance:Destroy();
        end
    });
    local u12 = 0;
    local u13 = nil;
    local u14 = false;
    local u15 = nil;
    local u16 = nil;
    local u17 = false;
    local u18 = false;
    local u19 = false;
    local l__Top__3 = Enum.TopBottom.Top;
    local l__Left__4 = Enum.LeftRight.Left;
    local u20 = nil;
    local u21 = nil;
    local u22 = false;
    local u23 = {};
    local function u27() --[[ Line: 99 ]]
        -- upvalues: u1 (copy), u23 (copy)
        if u1._config.UseScreenGUIs == false then
        else
            local v24 = 65535;
            local v25 = nil;
            for _, v26 in u23 do
                if v26.state.isOpened.value and (not v26.arguments.NoNav and v26.Instance:IsA("ScreenGui")) then
                    local l__DisplayOrder__5 = v26.Instance.DisplayOrder;
                    if l__DisplayOrder__5 < v24 then
                        v25 = v26;
                        v24 = l__DisplayOrder__5;
                    end;
                end;
            end;
            if v25.state.isUncollapsed.value == false then
                v25.state.isUncollapsed:set(true);
            end;
            u1.SetFocusedWindow(v25);
        end;
    end;
    local function u38(p28, p29) --[[ Line: 126 ]]
        -- upvalues: u1 (copy), u2 (copy)
        local v30 = Vector2.new(p28.state.position.value.X, p28.state.position.value.Y);
        local v31 = (u1._config.TextSize + u1._config.FramePadding.Y * 2) * 2;
        local v32 = u2.getScreenSizeForWindow(p28);
        local v33 = Vector2.new(u1._config.WindowBorderSize + u1._config.DisplaySafeAreaPadding.X, u1._config.WindowBorderSize + u1._config.DisplaySafeAreaPadding.Y);
        local v34 = v32 - v30 - v33;
        local l__new__6 = Vector2.new;
        local l__X__7 = p29.X;
        local v35 = math.max(v34.X, v31);
        local v36 = math.clamp(l__X__7, v31, v35);
        local l__Y__8 = p29.Y;
        local v37 = math.max(v34.Y, v31);
        return l__new__6(v36, (math.clamp(l__Y__8, v31, v37)));
    end;
    local function u46(p39, p40) --[[ Line: 142 ]]
        -- upvalues: u2 (copy), u1 (copy)
        local l__Instance__9 = p39.Instance;
        local v41 = u2.getScreenSizeForWindow(p39);
        local v42 = Vector2.new(u1._config.WindowBorderSize + u1._config.DisplaySafeAreaPadding.X, u1._config.WindowBorderSize + u1._config.DisplaySafeAreaPadding.Y);
        local l__new__10 = Vector2.new;
        local l__X__11 = p40.X;
        local l__X__12 = v42.X;
        local v43 = math.max(v42.X, v41.X - l__Instance__9.WindowButton.AbsoluteSize.X - v42.X);
        local v44 = math.clamp(l__X__11, l__X__12, v43);
        local l__Y__13 = p40.Y;
        local l__Y__14 = v42.Y;
        local v45 = math.max(v42.Y, v41.Y - l__Instance__9.WindowButton.AbsoluteSize.Y - v42.Y);
        return l__new__10(v44, (math.clamp(l__Y__13, l__Y__14, v45)));
    end;
    function u1.SetFocusedWindow(p47) --[[ Line: 164 ]]
        -- upvalues: u21 (ref), u22 (ref), u23 (copy), u1 (copy), u12 (ref), u2 (copy)
        if u21 == p47 then
        else
            if u22 and u21 ~= nil then
                if u23[u21.ID] then
                    local l__WindowButton__15 = u21.Instance.WindowButton;
                    local l__TitleBar__16 = l__WindowButton__15.TitleBar;
                    if u21.state.isUncollapsed.value then
                        l__TitleBar__16.BackgroundColor3 = u1._config.TitleBgColor;
                        l__TitleBar__16.BackgroundTransparency = u1._config.TitleBgTransparency;
                    else
                        l__TitleBar__16.BackgroundColor3 = u1._config.TitleBgCollapsedColor;
                        l__TitleBar__16.BackgroundTransparency = u1._config.TitleBgCollapsedTransparency;
                    end;
                    l__WindowButton__15.UIStroke.Color = u1._config.BorderColor;
                end;
                u22 = false;
                u21 = nil;
            end;
            if p47 ~= nil then
                u22 = true;
                u21 = p47;
                local l__Instance__17 = p47.Instance;
                local l__WindowButton__18 = l__Instance__17.WindowButton;
                local l__TitleBar__19 = l__WindowButton__18.TitleBar;
                l__TitleBar__19.BackgroundColor3 = u1._config.TitleBgActiveColor;
                l__TitleBar__19.BackgroundTransparency = u1._config.TitleBgActiveTransparency;
                l__WindowButton__18.UIStroke.Color = u1._config.BorderActiveColor;
                u12 = u12 + 1;
                if p47.usesScreenGUI then
                    l__Instance__17.DisplayOrder = u12 + u1._config.DisplayOrderOffset;
                end;
                if p47.state.isUncollapsed.value == false then
                    p47.state.isUncollapsed:set(true);
                end;
                if u2.GuiService.SelectedObject then
                    if l__TitleBar__19.Visible then
                        u2.GuiService:Select(l__TitleBar__19);
                        return;
                    end;
                    u2.GuiService:Select(l__Instance__17.ChildContainer);
                end;
            end;
        end;
    end;
    u2.UserInputService.InputBegan:Connect(function(p48, p49) --[[ Line: 221 ]]
        -- upvalues: u1 (copy), u2 (copy), u27 (copy), u18 (ref), u19 (ref), u22 (ref), u21 (ref), l__Top__3 (ref), l__Left__4 (ref), u17 (ref), u16 (ref)
        if not p49 and p48.UserInputType == Enum.UserInputType.MouseButton1 then
            u1.SetFocusedWindow(nil);
        end;
        if p48.KeyCode == Enum.KeyCode.Tab and (u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)) then
            u27();
        end;
        if p48.UserInputType == Enum.UserInputType.MouseButton1 and (u18 and (not u19 and (u22 and u21))) then
            local v50 = u21.state.position.value + u21.state.size.value * 0.5;
            local v51 = u2.getMouseLocation() - v50;
            if math.abs(v51.X) * u21.state.size.value.Y >= math.abs(v51.Y) * u21.state.size.value.X then
                l__Top__3 = Enum.TopBottom.Center;
                local v52;
                if math.sign(v51.X) == -1 then
                    v52 = Enum.LeftRight.Left;
                else
                    v52 = Enum.LeftRight.Right;
                end;
                l__Left__4 = v52;
            else
                l__Left__4 = Enum.LeftRight.Center;
                local v53;
                if math.sign(v51.Y) == -1 then
                    v53 = Enum.TopBottom.Top;
                else
                    v53 = Enum.TopBottom.Bottom;
                end;
                l__Top__3 = v53;
            end;
            u17 = true;
            u16 = u21;
        end;
    end);
    u2.UserInputService.TouchTapInWorld:Connect(function(_, p54) --[[ Line: 252 ]]
        -- upvalues: u1 (copy)
        if not p54 then
            u1.SetFocusedWindow(nil);
        end;
    end);
    u2.UserInputService.InputChanged:Connect(function(p55) --[[ Line: 258 ]]
        -- upvalues: u14 (ref), u13 (ref), u2 (copy), u15 (ref), u46 (copy), u17 (ref), u16 (ref), u20 (ref), l__Left__4 (ref), l__Top__3 (ref), u38 (copy)
        if u14 and u13 then
            local v56;
            if p55.UserInputType == Enum.UserInputType.Touch then
                local l__Position__20 = p55.Position;
                v56 = Vector2.new(l__Position__20.X, l__Position__20.Y);
            else
                v56 = u2.getMouseLocation();
            end;
            local l__WindowButton__21 = u13.Instance.WindowButton;
            local v57 = u46(u13, v56 - u15);
            l__WindowButton__21.Position = UDim2.fromOffset(v57.X, v57.Y);
            u13.state.position.value = v57;
        end;
        if u17 and (u16 and u16.arguments.NoResize ~= true) then
            local l__WindowButton__22 = u16.Instance.WindowButton;
            local v58 = Vector2.new(l__WindowButton__22.Position.X.Offset, l__WindowButton__22.Position.Y.Offset);
            local v59 = Vector2.new(l__WindowButton__22.Size.X.Offset, l__WindowButton__22.Size.Y.Offset);
            local v60;
            if p55.UserInputType == Enum.UserInputType.Touch then
                v60 = p55.Delta;
            else
                v60 = u2.getMouseLocation() - u20;
            end;
            local v61 = v58 + Vector2.new(l__Left__4 ~= Enum.LeftRight.Left and 0 or v60.X, l__Top__3 ~= Enum.TopBottom.Top and 0 or v60.Y);
            local l__new__23 = Vector2.new;
            local v62;
            if l__Left__4 == Enum.LeftRight.Left then
                v62 = -v60.X;
            else
                v62 = l__Left__4 ~= Enum.LeftRight.Right and 0 or v60.X;
            end;
            local v63;
            if l__Top__3 == Enum.TopBottom.Top then
                v63 = -v60.Y;
            else
                v63 = l__Top__3 ~= Enum.TopBottom.Bottom and 0 or v60.Y;
            end;
            local v64 = u38(u16, v59 + l__new__23(v62, v63));
            local v65 = u46(u16, v61);
            l__WindowButton__22.Size = UDim2.fromOffset(v64.X, v64.Y);
            u16.state.size.value = v64;
            l__WindowButton__22.Position = UDim2.fromOffset(v65.X, v65.Y);
            u16.state.position.value = v65;
        end;
        u20 = u2.getMouseLocation();
    end);
    u2.UserInputService.InputEnded:Connect(function(p66, _) --[[ Line: 319 ]]
        -- upvalues: u14 (ref), u13 (ref), u17 (ref), u16 (ref), u27 (copy)
        if (p66.UserInputType == Enum.UserInputType.MouseButton1 or p66.UserInputType == Enum.UserInputType.Touch) and (u14 and u13) then
            local l__WindowButton__24 = u13.Instance.WindowButton;
            u14 = false;
            u13.state.position:set(Vector2.new(l__WindowButton__24.Position.X.Offset, l__WindowButton__24.Position.Y.Offset));
        end;
        if (p66.UserInputType == Enum.UserInputType.MouseButton1 or p66.UserInputType == Enum.UserInputType.Touch) and (u17 and u16) then
            local l__Instance__25 = u16.Instance;
            u17 = false;
            u16.state.size:set(l__Instance__25.WindowButton.AbsoluteSize);
        end;
        if p66.KeyCode == Enum.KeyCode.ButtonX then
            u27();
        end;
    end);
    u1.WidgetConstructor("Window", {
        hasState = true,
        hasChildren = true,
        Args = {
            Title = 1,
            NoTitleBar = 2,
            NoBackground = 3,
            NoCollapse = 4,
            NoClose = 5,
            NoMove = 6,
            NoScrollbar = 7,
            NoResize = 8,
            NoNav = 9,
            NoMenu = 10
        },
        Events = {
            closed = {
                Init = function(_) --[[ Line: 362 ]] end,
                Get = function(p67) --[[ Line: 363 ]]
                    -- upvalues: u1 (copy)
                    return p67.lastClosedTick == u1._cycleTick;
                end
            },
            opened = {
                Init = function(_) --[[ Line: 368 ]] end,
                Get = function(p68) --[[ Line: 369 ]]
                    -- upvalues: u1 (copy)
                    return p68.lastOpenedTick == u1._cycleTick;
                end
            },
            collapsed = {
                Init = function(_) --[[ Line: 374 ]] end,
                Get = function(p69) --[[ Line: 375 ]]
                    -- upvalues: u1 (copy)
                    return p69.lastCollapsedTick == u1._cycleTick;
                end
            },
            uncollapsed = {
                Init = function(_) --[[ Line: 380 ]] end,
                Get = function(p70) --[[ Line: 381 ]]
                    -- upvalues: u1 (copy)
                    return p70.lastUncollapsedTick == u1._cycleTick;
                end
            },
            hovered = u2.EVENTS.hover(function(p71) --[[ Line: 385 ]]
                return p71.Instance.WindowButton;
            end)
        },
        Generate = function(u72) --[[ Name: Generate, Line 390 ]]
            -- upvalues: u1 (copy), u23 (copy), u2 (copy), u13 (ref), u14 (ref), u15 (ref), u22 (ref), u21 (ref), u17 (ref), l__Top__3 (ref), l__Left__4 (ref), u16 (ref), u18 (ref), u19 (ref)
            u72.parentWidget = u1._rootWidget;
            u72.usesScreenGUI = u1._config.UseScreenGUIs;
            u23[u72.ID] = u72;
            local v73;
            if u72.usesScreenGUI then
                v73 = Instance.new("ScreenGui");
                v73.ResetOnSpawn = false;
                v73.DisplayOrder = u1._config.DisplayOrderOffset;
                v73.IgnoreGuiInset = u1._config.IgnoreGuiInset;
            else
                v73 = Instance.new("Folder");
            end;
            v73.Name = "Iris_Window";
            local v74 = Instance.new("TextButton");
            v74.Name = "WindowButton";
            v74.Size = UDim2.fromOffset(0, 0);
            v74.BackgroundTransparency = 1;
            v74.BorderSizePixel = 0;
            v74.Text = "";
            v74.ClipsDescendants = false;
            v74.AutoButtonColor = false;
            v74.Selectable = false;
            v74.SelectionImageObject = u1.SelectionImageObject;
            v74.ZIndex = u72.ZIndex + 1;
            v74.LayoutOrder = u72.ZIndex + 1;
            v74.SelectionGroup = true;
            v74.SelectionBehaviorUp = Enum.SelectionBehavior.Stop;
            v74.SelectionBehaviorDown = Enum.SelectionBehavior.Stop;
            v74.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop;
            v74.SelectionBehaviorRight = Enum.SelectionBehavior.Stop;
            u2.UIStroke(v74, u1._config.WindowBorderSize, u1._config.BorderColor, u1._config.BorderTransparency);
            v74.Parent = v73;
            v74.InputBegan:Connect(function(p75) --[[ Line: 430 ]]
                -- upvalues: u72 (copy), u1 (ref), u13 (ref), u14 (ref), u15 (ref), u2 (ref)
                if p75.UserInputType == Enum.UserInputType.MouseMovement or p75.UserInputType == Enum.UserInputType.Keyboard then
                else
                    if u72.state.isUncollapsed.value then
                        u1.SetFocusedWindow(u72);
                    end;
                    if not u72.arguments.NoMove and p75.UserInputType == Enum.UserInputType.MouseButton1 then
                        u13 = u72;
                        u14 = true;
                        u15 = u2.getMouseLocation() - u72.state.position.value;
                    end;
                end;
            end);
            local u76 = Instance.new("ScrollingFrame");
            u76.Name = "ChildContainer";
            u76.Size = UDim2.fromScale(1, 1);
            u76.Position = UDim2.fromOffset(0, 0);
            u76.BackgroundColor3 = u1._config.WindowBgColor;
            u76.BackgroundTransparency = u1._config.WindowBgTransparency;
            u76.BorderSizePixel = 0;
            u76.AutomaticCanvasSize = Enum.AutomaticSize.Y;
            u76.ScrollBarImageTransparency = u1._config.ScrollbarGrabTransparency;
            u76.ScrollBarImageColor3 = u1._config.ScrollbarGrabColor;
            u76.CanvasSize = UDim2.fromScale(0, 1);
            u76.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar;
            u76.ZIndex = u72.ZIndex + 3;
            u76.LayoutOrder = u72.ZIndex + 3;
            u76.ClipsDescendants = true;
            u2.UIPadding(u76, u1._config.WindowPadding);
            u76.Parent = v74;
            u76:GetPropertyChangedSignal("CanvasPosition"):Connect(function() --[[ Line: 466 ]]
                -- upvalues: u72 (copy), u76 (copy)
                u72.state.scrollDistance.value = u76.CanvasPosition.Y;
            end);
            u76.InputBegan:Connect(function(p77) --[[ Line: 471 ]]
                -- upvalues: u72 (copy), u1 (ref)
                if p77.UserInputType == Enum.UserInputType.MouseMovement or p77.UserInputType == Enum.UserInputType.Keyboard then
                else
                    if u72.state.isUncollapsed.value then
                        u1.SetFocusedWindow(u72);
                    end;
                end;
            end);
            local v78 = Instance.new("Frame");
            v78.Name = "TerminatingFrame";
            v78.Size = UDim2.fromOffset(0, u1._config.WindowPadding.Y + u1._config.FramePadding.Y);
            v78.BackgroundTransparency = 1;
            v78.BorderSizePixel = 0;
            v78.LayoutOrder = 2147483632;
            u2.UIListLayout(u76, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.Y)).VerticalAlignment = Enum.VerticalAlignment.Top;
            v78.Parent = u76;
            local v79 = Instance.new("Frame");
            v79.Name = "TitleBar";
            v79.Size = UDim2.fromScale(1, 0);
            v79.AutomaticSize = Enum.AutomaticSize.Y;
            v79.BorderSizePixel = 0;
            v79.ZIndex = u72.ZIndex + 1;
            v79.LayoutOrder = u72.ZIndex + 1;
            v79.ClipsDescendants = true;
            v79.Parent = v74;
            v79.InputBegan:Connect(function(p80) --[[ Line: 504 ]]
                -- upvalues: u72 (copy), u13 (ref), u14 (ref), u15 (ref)
                if p80.UserInputType == Enum.UserInputType.Touch and not u72.arguments.NoMove then
                    u13 = u72;
                    u14 = true;
                    local l__Position__26 = p80.Position;
                    u15 = Vector2.new(l__Position__26.X, l__Position__26.Y) - u72.state.position.value;
                end;
            end);
            local v81 = u1._config.TextSize + (u1._config.FramePadding.Y - 1) * 2;
            local v82 = Instance.new("TextButton");
            v82.Name = "CollapseButton";
            v82.AnchorPoint = Vector2.new(0, 0.5);
            v82.Size = UDim2.fromOffset(v81, v81);
            v82.Position = UDim2.new(0, u1._config.FramePadding.X + 1, 0.5, 0);
            v82.AutomaticSize = Enum.AutomaticSize.None;
            v82.BackgroundTransparency = 1;
            v82.BorderSizePixel = 0;
            v82.AutoButtonColor = false;
            v82.Text = "";
            v82.ZIndex = u72.ZIndex + 4;
            u2.UICorner(v82);
            v82.Parent = v79;
            v82.MouseButton1Click:Connect(function() --[[ Line: 533 ]]
                -- upvalues: u72 (copy)
                u72.state.isUncollapsed:set(not u72.state.isUncollapsed.value);
            end);
            u2.applyInteractionHighlights(v82, v82, {
                ButtonTransparency = 1,
                ButtonColor = u1._config.ButtonColor,
                ButtonHoveredColor = u1._config.ButtonHoveredColor,
                ButtonHoveredTransparency = u1._config.ButtonHoveredTransparency,
                ButtonActiveColor = u1._config.ButtonActiveColor,
                ButtonActiveTransparency = u1._config.ButtonActiveTransparency
            });
            local v83 = Instance.new("ImageLabel");
            v83.Name = "Arrow";
            v83.AnchorPoint = Vector2.new(0.5, 0.5);
            v83.Size = UDim2.fromOffset(math.floor(v81 * 0.7), (math.floor(v81 * 0.7)));
            v83.Position = UDim2.fromScale(0.5, 0.5);
            v83.BackgroundTransparency = 1;
            v83.BorderSizePixel = 0;
            v83.Image = u2.ICONS.MULTIPLICATION_SIGN;
            v83.ImageColor3 = u1._config.TextColor;
            v83.ImageTransparency = u1._config.TextTransparency;
            v83.ZIndex = u72.ZIndex + 5;
            v83.Parent = v82;
            local v84 = Instance.new("TextButton");
            v84.Name = "CloseButton";
            v84.AnchorPoint = Vector2.new(1, 0.5);
            v84.Size = UDim2.fromOffset(v81, v81);
            v84.Position = UDim2.new(1, -(u1._config.FramePadding.X + 1), 0.5, 0);
            v84.AutomaticSize = Enum.AutomaticSize.None;
            v84.BackgroundTransparency = 1;
            v84.BorderSizePixel = 0;
            v84.Text = "";
            v84.ZIndex = u72.ZIndex + 4;
            v84.AutoButtonColor = false;
            u2.UICorner(v84);
            v84.MouseButton1Click:Connect(function() --[[ Line: 574 ]]
                -- upvalues: u72 (copy)
                u72.state.isOpened:set(false);
            end);
            u2.applyInteractionHighlights(v84, v84, {
                ButtonTransparency = 1,
                ButtonColor = u1._config.ButtonColor,
                ButtonHoveredColor = u1._config.ButtonHoveredColor,
                ButtonHoveredTransparency = u1._config.ButtonHoveredTransparency,
                ButtonActiveColor = u1._config.ButtonActiveColor,
                ButtonActiveTransparency = u1._config.ButtonActiveTransparency
            });
            v84.Parent = v79;
            local v85 = Instance.new("ImageLabel");
            v85.Name = "Icon";
            v85.AnchorPoint = Vector2.new(0.5, 0.5);
            v85.Size = UDim2.fromOffset(math.floor(v81 * 0.7), (math.floor(v81 * 0.7)));
            v85.Position = UDim2.fromScale(0.5, 0.5);
            v85.BackgroundTransparency = 1;
            v85.BorderSizePixel = 0;
            v85.Image = u2.ICONS.MULTIPLICATION_SIGN;
            v85.ImageColor3 = u1._config.TextColor;
            v85.ImageTransparency = u1._config.TextTransparency;
            v85.ZIndex = u72.ZIndex + 5;
            v85.Parent = v84;
            local v86 = u1._config.WindowTitleAlign == Enum.LeftRight.Left and 0 or (u1._config.WindowTitleAlign == Enum.LeftRight.Center and 0.5 or 1);
            local v87 = Instance.new("TextLabel");
            v87.Name = "Title";
            v87.AnchorPoint = Vector2.new(v86, 0);
            v87.Position = UDim2.fromScale(v86, 0);
            v87.AutomaticSize = Enum.AutomaticSize.XY;
            v87.BorderSizePixel = 0;
            v87.BackgroundTransparency = 1;
            v87.ZIndex = u72.ZIndex + 3;
            u2.applyTextStyle(v87);
            u2.UIPadding(v87, u1._config.FramePadding);
            v87.Parent = v79;
            local v88 = u1._config.TextSize + u1._config.FramePadding.X;
            local v89 = Instance.new("TextButton");
            v89.Name = "ResizeGrip";
            v89.AnchorPoint = Vector2.new(1, 1);
            v89.Size = UDim2.fromOffset(v88, v88);
            v89.Position = UDim2.fromScale(1, 1);
            v89.AutoButtonColor = false;
            v89.BorderSizePixel = 0;
            v89.BackgroundTransparency = 1;
            v89.Text = u2.ICONS.BOTTOM_RIGHT_CORNER;
            v89.TextSize = v88;
            v89.TextColor3 = u1._config.ButtonColor;
            v89.TextTransparency = u1._config.ButtonTransparency;
            v89.LineHeight = 1.1;
            v89.Selectable = false;
            v89.ZIndex = u72.ZIndex + 3;
            v89.Parent = v74;
            u2.applyTextInteractionHighlights(v89, v89, {
                ButtonColor = u1._config.ButtonColor,
                ButtonTransparency = u1._config.ButtonTransparency,
                ButtonHoveredColor = u1._config.ButtonHoveredColor,
                ButtonHoveredTransparency = u1._config.ButtonHoveredTransparency,
                ButtonActiveColor = u1._config.ButtonActiveColor,
                ButtonActiveTransparency = u1._config.ButtonActiveTransparency
            });
            v89.MouseButton1Down:Connect(function() --[[ Line: 655 ]]
                -- upvalues: u22 (ref), u21 (ref), u72 (copy), u1 (ref), u17 (ref), l__Top__3 (ref), l__Left__4 (ref), u16 (ref)
                if not u22 or u21 ~= u72 then
                    u1.SetFocusedWindow(u72);
                end;
                u17 = true;
                l__Top__3 = Enum.TopBottom.Bottom;
                l__Left__4 = Enum.LeftRight.Right;
                u16 = u72;
            end);
            local v90 = Instance.new("TextButton");
            v90.Name = "ResizeBorder";
            v90.Size = UDim2.new(1, u1._config.WindowResizePadding.X * 2, 1, u1._config.WindowResizePadding.Y * 2);
            v90.Position = UDim2.fromOffset(-u1._config.WindowResizePadding.X, -u1._config.WindowResizePadding.Y);
            v90.BackgroundTransparency = 1;
            v90.BorderSizePixel = 0;
            v90.Text = "";
            v90.AutoButtonColor = false;
            v90.Active = true;
            v90.Selectable = false;
            v90.ZIndex = u72.ZIndex;
            v90.LayoutOrder = u72.ZIndex;
            v90.ClipsDescendants = false;
            v90.Parent = v74;
            v90.MouseEnter:Connect(function() --[[ Line: 681 ]]
                -- upvalues: u21 (ref), u72 (copy), u18 (ref)
                if u21 == u72 then
                    u18 = true;
                end;
            end);
            v90.MouseLeave:Connect(function() --[[ Line: 686 ]]
                -- upvalues: u21 (ref), u72 (copy), u18 (ref)
                if u21 == u72 then
                    u18 = false;
                end;
            end);
            v74.MouseEnter:Connect(function() --[[ Line: 692 ]]
                -- upvalues: u21 (ref), u72 (copy), u19 (ref)
                if u21 == u72 then
                    u19 = true;
                end;
            end);
            v74.MouseLeave:Connect(function() --[[ Line: 697 ]]
                -- upvalues: u21 (ref), u72 (copy), u19 (ref)
                if u21 == u72 then
                    u19 = false;
                end;
            end);
            return v73;
        end,
        Update = function(p91) --[[ Name: Update, Line 705 ]]
            -- upvalues: u1 (copy)
            local l__WindowButton__27 = p91.Instance.WindowButton;
            local l__TitleBar__28 = l__WindowButton__27.TitleBar;
            local l__Title__29 = l__TitleBar__28.Title;
            local v92 = l__WindowButton__27:FindFirstChild("MenuBar");
            local l__ChildContainer__30 = l__WindowButton__27.ChildContainer;
            local l__ResizeGrip__31 = l__WindowButton__27.ResizeGrip;
            local v93 = 0;
            local v94 = 0;
            if p91.arguments.NoResize == true then
                l__ResizeGrip__31.Visible = false;
            else
                l__ResizeGrip__31.Visible = true;
            end;
            if p91.arguments.NoScrollbar then
                l__ChildContainer__30.ScrollBarThickness = 0;
            else
                l__ChildContainer__30.ScrollBarThickness = u1._config.ScrollbarSize;
            end;
            if p91.arguments.NoTitleBar then
                l__TitleBar__28.Visible = false;
            else
                l__TitleBar__28.Visible = true;
                local l__Y__32 = l__TitleBar__28.AbsoluteSize.Y;
                v93 = v93 + l__Y__32;
                v94 = v94 + l__Y__32;
            end;
            if v92 then
                if p91.arguments.NoMenu then
                    v92.Visible = false;
                else
                    v92.Visible = true;
                    v93 = v93 + v92.AbsoluteSize.Y;
                end;
                v92.Position = UDim2.fromOffset(0, v94);
            end;
            if p91.arguments.NoBackground then
                l__ChildContainer__30.BackgroundTransparency = 1;
            else
                l__ChildContainer__30.BackgroundTransparency = u1._config.WindowBgTransparency;
            end;
            local v95 = u1._config.FramePadding.X + u1._config.TextSize + u1._config.FramePadding.X * 2;
            if p91.arguments.NoCollapse then
                l__TitleBar__28.CollapseButton.Visible = false;
                l__TitleBar__28.Title.UIPadding.PaddingLeft = UDim.new(0, u1._config.FramePadding.X);
            else
                l__TitleBar__28.CollapseButton.Visible = true;
                l__TitleBar__28.Title.UIPadding.PaddingLeft = UDim.new(0, v95);
            end;
            if p91.arguments.NoClose then
                l__TitleBar__28.CloseButton.Visible = false;
                l__TitleBar__28.Title.UIPadding.PaddingRight = UDim.new(0, u1._config.FramePadding.X);
            else
                l__TitleBar__28.CloseButton.Visible = true;
                l__TitleBar__28.Title.UIPadding.PaddingRight = UDim.new(0, v95);
            end;
            l__ChildContainer__30.Size = UDim2.new(1, 0, 1, -v93);
            l__ChildContainer__30.CanvasSize = UDim2.new(0, 0, 1, -v93);
            l__ChildContainer__30.Position = UDim2.fromOffset(0, v93);
            l__Title__29.Text = p91.arguments.Title or "";
        end,
        Discard = function(p96) --[[ Name: Discard, Line 775 ]]
            -- upvalues: u21 (ref), u22 (ref), u13 (ref), u14 (ref), u16 (ref), u17 (ref), u23 (copy), u2 (copy)
            if u21 == p96 then
                u21 = nil;
                u22 = false;
            end;
            if u13 == p96 then
                u13 = nil;
                u14 = false;
            end;
            if u16 == p96 then
                u16 = nil;
                u17 = false;
            end;
            u23[p96.ID] = nil;
            p96.Instance:Destroy();
            u2.discardState(p96);
        end,
        ChildAdded = function(p97) --[[ Name: ChildAdded, Line 792 ]]
            return p97.Instance.WindowButton.ChildContainer;
        end,
        UpdateState = function(p98) --[[ Name: UpdateState, Line 797 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local l__value__33 = p98.state.size.value;
            local l__value__34 = p98.state.position.value;
            local l__value__35 = p98.state.isUncollapsed.value;
            local l__value__36 = p98.state.isOpened.value;
            local l__value__37 = p98.state.scrollDistance.value;
            local l__Instance__38 = p98.Instance;
            local l__WindowButton__39 = l__Instance__38.WindowButton;
            local l__TitleBar__40 = l__WindowButton__39.TitleBar;
            local l__ChildContainer__41 = l__WindowButton__39.ChildContainer;
            local l__ResizeGrip__42 = l__WindowButton__39.ResizeGrip;
            l__WindowButton__39.Size = UDim2.fromOffset(l__value__33.X, l__value__33.Y);
            l__WindowButton__39.Position = UDim2.fromOffset(l__value__34.X, l__value__34.Y);
            if l__value__36 then
                if p98.usesScreenGUI then
                    l__Instance__38.Enabled = true;
                    l__WindowButton__39.Visible = true;
                else
                    l__WindowButton__39.Visible = true;
                end;
                p98.lastOpenedTick = u1._cycleTick + 1;
            else
                if p98.usesScreenGUI then
                    l__Instance__38.Enabled = false;
                    l__WindowButton__39.Visible = false;
                else
                    l__WindowButton__39.Visible = false;
                end;
                p98.lastClosedTick = u1._cycleTick + 1;
            end;
            if l__value__35 then
                l__TitleBar__40.CollapseButton.Arrow.Image = u2.ICONS.DOWN_POINTING_TRIANGLE;
                l__ChildContainer__41.Visible = true;
                if p98.arguments.NoResize ~= true then
                    l__ResizeGrip__42.Visible = true;
                end;
                l__WindowButton__39.AutomaticSize = Enum.AutomaticSize.None;
                p98.lastUncollapsedTick = u1._cycleTick + 1;
            else
                local l__Y__43 = l__TitleBar__40.AbsoluteSize.Y;
                l__TitleBar__40.CollapseButton.Arrow.Image = u2.ICONS.RIGHT_POINTING_TRIANGLE;
                l__ChildContainer__41.Visible = false;
                l__ResizeGrip__42.Visible = false;
                l__WindowButton__39.Size = UDim2.fromOffset(l__value__33.X, l__Y__43);
                p98.lastCollapsedTick = u1._cycleTick + 1;
            end;
            if l__value__36 and l__value__35 then
                u1.SetFocusedWindow(p98);
            else
                l__TitleBar__40.BackgroundColor3 = u1._config.TitleBgCollapsedColor;
                l__TitleBar__40.BackgroundTransparency = u1._config.TitleBgCollapsedTransparency;
                l__WindowButton__39.UIStroke.Color = u1._config.BorderColor;
                u1.SetFocusedWindow(nil);
            end;
            if l__value__37 and l__value__37 ~= 0 then
                local u99 = #u1._postCycleCallbacks + 1;
                local u100 = u1._cycleTick + 1;
                u1._postCycleCallbacks[u99] = function() --[[ Line: 863 ]]
                    -- upvalues: u1 (ref), u100 (copy), l__ChildContainer__41 (copy), l__value__37 (copy), u99 (copy)
                    if u1._cycleTick == u100 then
                        l__ChildContainer__41.CanvasPosition = Vector2.new(0, l__value__37);
                        u1._postCycleCallbacks[u99] = nil;
                    end;
                end;
            end;
        end,
        GenerateState = function(p101) --[[ Name: GenerateState, Line 871 ]]
            -- upvalues: u1 (copy), u22 (ref), u21 (ref), u46 (copy), u38 (copy)
            if p101.state.size == nil then
                p101.state.size = u1._widgetState(p101, "size", Vector2.new(400, 300));
            end;
            if p101.state.position == nil then
                local l__state__44 = p101.state;
                local l___widgetState__45 = u1._widgetState;
                local v102 = "position";
                local v103;
                if u22 and u21 then
                    v103 = u21.state.position.value + Vector2.new(15, 45);
                else
                    v103 = Vector2.new(150, 250);
                end;
                l__state__44.position = l___widgetState__45(p101, v102, v103);
            end;
            p101.state.position.value = u46(p101, p101.state.position.value);
            p101.state.size.value = u38(p101, p101.state.size.value);
            if p101.state.isUncollapsed == nil then
                p101.state.isUncollapsed = u1._widgetState(p101, "isUncollapsed", true);
            end;
            if p101.state.isOpened == nil then
                p101.state.isOpened = u1._widgetState(p101, "isOpened", true);
            end;
            if p101.state.scrollDistance == nil then
                p101.state.scrollDistance = u1._widgetState(p101, "scrollDistance", 0);
            end;
        end
    });
end;
