-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);
local u1 = {};
return function(u2) --[[ Line: 5 ]]
    -- upvalues: u1 (copy)
    u1.GuiService = game:GetService("GuiService");
    u1.RunService = game:GetService("RunService");
    u1.UserInputService = game:GetService("UserInputService");
    u1.ContextActionService = game:GetService("ContextActionService");
    u1.TextService = game:GetService("TextService");
    u1.ICONS = {
        RIGHT_POINTING_TRIANGLE = "rbxasset://textures/DeveloperFramework/button_arrow_right.png",
        DOWN_POINTING_TRIANGLE = "rbxasset://textures/DeveloperFramework/button_arrow_down.png",
        MULTIPLICATION_SIGN = "rbxasset://textures/AnimationEditor/icon_close.png",
        BOTTOM_RIGHT_CORNER = "◢",
        CHECK_MARK = "rbxasset://textures/AnimationEditor/icon_checkmark.png",
        ALPHA_BACKGROUND_TEXTURE = "rbxasset://textures/meshPartFallback.png"
    };
    u1.GuiInset = u1.GuiService:GetGuiInset();
    u1.IS_STUDIO = u1.RunService:IsStudio();
    function u1.getTime() --[[ Line: 24 ]]
        -- upvalues: u1 (ref)
        if u1.IS_STUDIO then
            return os.clock();
        else
            return time();
        end;
    end;
    function u1.getMouseLocation() --[[ Line: 33 ]]
        -- upvalues: u1 (ref)
        return u1.UserInputService:GetMouseLocation() - u1.GuiInset;
    end;
    function u1.findBestWindowPosForPopup(p3, p4, p5, p6) --[[ Line: 37 ]]
        local v7;
        if p3.X + p4.X + 20 > p6.X then
            if p3.Y + p4.Y + 20 > p6.Y then
                v7 = p3 + Vector2.new(0, -(20 + p4.Y));
            else
                v7 = p3 + Vector2.new(0, 20);
            end;
        else
            v7 = p3 + Vector2.new(20, 0);
        end;
        local l__new__1 = Vector2.new;
        local v8 = math.min(v7.X + p4.X, p6.X) - p4.X;
        local v9 = math.max(v8, p5.X);
        local v10 = math.min(v7.Y + p4.Y, p6.Y) - p4.Y;
        return l__new__1(v9, (math.max(v10, p5.Y)));
    end;
    function u1.isPosInsideRect(p11, p12, p13) --[[ Line: 57 ]]
        local v14;
        if p11.X > p12.X and (p11.X < p13.X and p11.Y > p12.Y) then
            v14 = p11.Y < p13.Y;
        else
            v14 = false;
        end;
        return v14;
    end;
    function u1.extend(p15, p16) --[[ Line: 61 ]]
        local v17 = table.clone(p15);
        for v18, v19 in p16 do
            v17[v18] = v19;
        end;
        return v17;
    end;
    function u1.UIPadding(p20, p21) --[[ Line: 69 ]]
        local v22 = Instance.new("UIPadding");
        v22.PaddingLeft = UDim.new(0, p21.X);
        v22.PaddingRight = UDim.new(0, p21.X);
        v22.PaddingTop = UDim.new(0, p21.Y);
        v22.PaddingBottom = UDim.new(0, p21.Y);
        v22.Parent = p20;
        return v22;
    end;
    function u1.UIListLayout(p23, p24, p25) --[[ Line: 79 ]]
        local v26 = Instance.new("UIListLayout");
        v26.SortOrder = Enum.SortOrder.LayoutOrder;
        v26.Padding = p25;
        v26.FillDirection = p24;
        v26.Parent = p23;
        return v26;
    end;
    function u1.UIStroke(p27, p28, p29, p30) --[[ Line: 88 ]]
        local v31 = Instance.new("UIStroke");
        v31.Thickness = p28;
        v31.Color = p29;
        v31.Transparency = p30;
        v31.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        v31.LineJoinMode = Enum.LineJoinMode.Round;
        v31.Parent = p27;
        return v31;
    end;
    function u1.UICorner(p32, p33) --[[ Line: 99 ]]
        local v34 = Instance.new("UICorner");
        v34.CornerRadius = UDim.new(p33 and 0 or 1, p33 or 0);
        v34.Parent = p32;
        return v34;
    end;
    function u1.UISizeConstraint(p35, p36, p37) --[[ Line: 106 ]]
        local v38 = Instance.new("UISizeConstraint");
        v38.MinSize = p36 or v38.MinSize;
        v38.MaxSize = p37 or v38.MaxSize;
        v38.Parent = p35;
        return v38;
    end;
    function u1.UIReference(p39, p40, p41) --[[ Line: 114 ]]
        local v42 = Instance.new("ObjectValue");
        v42.Name = p41;
        v42.Value = p40;
        v42.Parent = p39;
        return v42;
    end;
    function u1.getScreenSizeForWindow(p43) --[[ Line: 123 ]]
        if p43.usesScreenGUI then
            return p43.Instance.AbsoluteSize;
        else
            local l__Parent__2 = p43.Instance.Parent;
            if l__Parent__2:IsA("GuiBase2d") then
                return l__Parent__2.AbsoluteSize;
            elseif l__Parent__2.Parent:IsA("GuiBase2d") then
                return l__Parent__2.AbsoluteSize;
            else
                return workspace.CurrentCamera.ViewportSize;
            end;
        end;
    end;
    local u44 = Instance.new("GetTextBoundsParams");
    u44.Font = u2._config.TextFont;
    u44.Size = u2._config.TextSize;
    u44.Width = (1 / 0);
    function u1.calculateTextSize(p45, p46) --[[ Line: 148 ]]
        -- upvalues: u44 (copy), u1 (ref)
        if p46 then
            u44.Width = p46;
        end;
        u44.Text = p45;
        local v47 = u1.TextService:GetTextBoundsAsync(u44);
        if p46 then
            u44.Width = (1 / 0);
        end;
        return v47;
    end;
    function u1.applyTextStyle(p48) --[[ Line: 163 ]]
        -- upvalues: u2 (copy)
        p48.FontFace = u2._config.TextFont;
        p48.TextSize = u2._config.TextSize;
        p48.TextColor3 = u2._config.TextColor;
        p48.TextTransparency = u2._config.TextTransparency;
        p48.TextXAlignment = Enum.TextXAlignment.Left;
        p48.AutoLocalize = false;
        p48.RichText = false;
    end;
    function u1.applyInteractionHighlights(p49, u50, u51) --[[ Line: 174 ]]
        -- upvalues: u2 (copy)
        local u52 = false;
        p49.MouseEnter:Connect(function() --[[ Line: 176 ]]
            -- upvalues: u50 (copy), u51 (copy), u52 (ref)
            u50.BackgroundColor3 = u51.ButtonHoveredColor;
            u50.BackgroundTransparency = u51.ButtonHoveredTransparency;
            u52 = false;
        end);
        p49.MouseLeave:Connect(function() --[[ Line: 183 ]]
            -- upvalues: u50 (copy), u51 (copy), u52 (ref)
            u50.BackgroundColor3 = u51.ButtonColor;
            u50.BackgroundTransparency = u51.ButtonTransparency;
            u52 = true;
        end);
        p49.InputBegan:Connect(function(p53) --[[ Line: 190 ]]
            -- upvalues: u50 (copy), u51 (copy)
            if p53.UserInputType == Enum.UserInputType.MouseButton1 or p53.UserInputType == Enum.UserInputType.Gamepad1 then
                u50.BackgroundColor3 = u51.ButtonActiveColor;
                u50.BackgroundTransparency = u51.ButtonActiveTransparency;
            end;
        end);
        p49.InputEnded:Connect(function(p54) --[[ Line: 198 ]]
            -- upvalues: u52 (ref), u50 (copy), u51 (copy)
            if (p54.UserInputType == Enum.UserInputType.MouseButton1 or p54.UserInputType == Enum.UserInputType.Gamepad1) and not u52 then
                if p54.UserInputType == Enum.UserInputType.MouseButton1 then
                    u50.BackgroundColor3 = u51.ButtonHoveredColor;
                    u50.BackgroundTransparency = u51.ButtonHoveredTransparency;
                end;
                if p54.UserInputType == Enum.UserInputType.Gamepad1 then
                    u50.BackgroundColor3 = u51.ButtonColor;
                    u50.BackgroundTransparency = u51.ButtonTransparency;
                end;
            end;
        end);
        p49.SelectionImageObject = u2.SelectionImageObject;
    end;
    function u1.applyInteractionHighlightsWithMultiHighlightee(p55, u56) --[[ Line: 215 ]]
        -- upvalues: u2 (copy)
        local u57 = false;
        p55.MouseEnter:Connect(function() --[[ Line: 217 ]]
            -- upvalues: u56 (copy), u57 (ref)
            for _, v58 in u56 do
                v58[1].BackgroundColor3 = v58[2].ButtonHoveredColor;
                v58[1].BackgroundTransparency = v58[2].ButtonHoveredTransparency;
                u57 = false;
            end;
        end);
        p55.MouseLeave:Connect(function() --[[ Line: 226 ]]
            -- upvalues: u56 (copy), u57 (ref)
            for _, v59 in u56 do
                v59[1].BackgroundColor3 = v59[2].ButtonColor;
                v59[1].BackgroundTransparency = v59[2].ButtonTransparency;
                u57 = true;
            end;
        end);
        p55.InputBegan:Connect(function(p60) --[[ Line: 235 ]]
            -- upvalues: u56 (copy)
            if p60.UserInputType == Enum.UserInputType.MouseButton1 or p60.UserInputType == Enum.UserInputType.Gamepad1 then
                for _, v61 in u56 do
                    v61[1].BackgroundColor3 = v61[2].ButtonActiveColor;
                    v61[1].BackgroundTransparency = v61[2].ButtonActiveTransparency;
                end;
            end;
        end);
        p55.InputEnded:Connect(function(p62) --[[ Line: 245 ]]
            -- upvalues: u57 (ref), u56 (copy)
            if (p62.UserInputType == Enum.UserInputType.MouseButton1 or p62.UserInputType == Enum.UserInputType.Gamepad1) and not u57 then
                for _, v63 in u56 do
                    if p62.UserInputType == Enum.UserInputType.MouseButton1 then
                        v63[1].BackgroundColor3 = v63[2].ButtonHoveredColor;
                        v63[1].BackgroundTransparency = v63[2].ButtonHoveredTransparency;
                    end;
                    if p62.UserInputType == Enum.UserInputType.Gamepad1 then
                        v63[1].BackgroundColor3 = v63[2].ButtonColor;
                        v63[1].BackgroundTransparency = v63[2].ButtonTransparency;
                    end;
                end;
            end;
        end);
        p55.SelectionImageObject = u2.SelectionImageObject;
    end;
    function u1.applyTextInteractionHighlights(p64, u65, u66) --[[ Line: 264 ]]
        -- upvalues: u2 (copy)
        local u67 = false;
        p64.MouseEnter:Connect(function() --[[ Line: 266 ]]
            -- upvalues: u65 (copy), u66 (copy), u67 (ref)
            u65.TextColor3 = u66.ButtonHoveredColor;
            u65.TextTransparency = u66.ButtonHoveredTransparency;
            u67 = false;
        end);
        p64.MouseLeave:Connect(function() --[[ Line: 273 ]]
            -- upvalues: u65 (copy), u66 (copy), u67 (ref)
            u65.TextColor3 = u66.ButtonColor;
            u65.TextTransparency = u66.ButtonTransparency;
            u67 = true;
        end);
        p64.InputBegan:Connect(function(p68) --[[ Line: 280 ]]
            -- upvalues: u65 (copy), u66 (copy)
            if p68.UserInputType == Enum.UserInputType.MouseButton1 or p68.UserInputType == Enum.UserInputType.Gamepad1 then
                u65.TextColor3 = u66.ButtonActiveColor;
                u65.TextTransparency = u66.ButtonActiveTransparency;
            end;
        end);
        p64.InputEnded:Connect(function(p69) --[[ Line: 288 ]]
            -- upvalues: u67 (ref), u65 (copy), u66 (copy)
            if (p69.UserInputType == Enum.UserInputType.MouseButton1 or p69.UserInputType == Enum.UserInputType.Gamepad1) and not u67 then
                if p69.UserInputType == Enum.UserInputType.MouseButton1 then
                    u65.TextColor3 = u66.ButtonHoveredColor;
                    u65.TextTransparency = u66.ButtonHoveredTransparency;
                end;
                if p69.UserInputType == Enum.UserInputType.Gamepad1 then
                    u65.TextColor3 = u66.ButtonColor;
                    u65.TextTransparency = u66.ButtonTransparency;
                end;
            end;
        end);
        p64.SelectionImageObject = u2.SelectionImageObject;
    end;
    function u1.applyFrameStyle(p70, p71, p72) --[[ Line: 305 ]]
        -- upvalues: u2 (copy), u1 (ref)
        local l__FramePadding__3 = u2._config.FramePadding;
        local l__FrameBorderSize__4 = u2._config.FrameBorderSize;
        local l__BorderColor__5 = u2._config.BorderColor;
        local l__ButtonTransparency__6 = u2._config.ButtonTransparency;
        local l__FrameRounding__7 = u2._config.FrameRounding;
        if l__FrameBorderSize__4 > 0 and l__FrameRounding__7 > 0 then
            p70.BorderSizePixel = 0;
            local v73 = Instance.new("UIStroke");
            v73.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
            v73.LineJoinMode = Enum.LineJoinMode.Round;
            v73.Transparency = l__ButtonTransparency__6;
            v73.Thickness = l__FrameBorderSize__4;
            v73.Color = l__BorderColor__5;
            u1.UICorner(p70, l__FrameRounding__7);
            v73.Parent = p70;
            if not p71 then
                u1.UIPadding(p70, u2._config.FramePadding);
            end;
        elseif l__FrameBorderSize__4 < 1 and l__FrameRounding__7 > 0 then
            p70.BorderSizePixel = 0;
            u1.UICorner(p70, l__FrameRounding__7);
            if not p71 then
                u1.UIPadding(p70, u2._config.FramePadding);
            end;
        elseif l__FrameRounding__7 < 1 then
            p70.BorderSizePixel = l__FrameBorderSize__4;
            p70.BorderColor3 = l__BorderColor__5;
            p70.BorderMode = Enum.BorderMode.Inset;
            if not p71 then
                u1.UIPadding(p70, l__FramePadding__3 - Vector2.new(l__FrameBorderSize__4, l__FrameBorderSize__4));
                return;
            end;
            if not p72 then
                u1.UIPadding(p70, -Vector2.new(l__FrameBorderSize__4, l__FrameBorderSize__4));
            end;
        end;
    end;
    function u1.discardState(p74) --[[ Line: 350 ]]
        for _, v75 in p74.state do
            v75.ConnectedWidgets[p74.ID] = nil;
        end;
    end;
    u1.EVENTS = {
        hover = function(u76) --[[ Name: hover, Line 357 ]]
            return {
                Init = function(u77) --[[ Line: 359 ]]
                    -- upvalues: u76 (copy)
                    local v78 = u76(u77);
                    v78.MouseEnter:Connect(function() --[[ Line: 361 ]]
                        -- upvalues: u77 (copy)
                        u77.isHoveredEvent = true;
                    end);
                    v78.MouseLeave:Connect(function() --[[ Line: 364 ]]
                        -- upvalues: u77 (copy)
                        u77.isHoveredEvent = false;
                    end);
                    u77.isHoveredEvent = false;
                end,
                Get = function(p79) --[[ Line: 369 ]]
                    return p79.isHoveredEvent;
                end
            };
        end,
        click = function(u80) --[[ Name: click, Line 375 ]]
            -- upvalues: u2 (copy)
            return {
                Init = function(u81) --[[ Line: 377 ]]
                    -- upvalues: u80 (copy), u2 (ref)
                    local v82 = u80(u81);
                    u81.lastClickedTick = -1;
                    v82.MouseButton1Click:Connect(function() --[[ Line: 381 ]]
                        -- upvalues: u81 (copy), u2 (ref)
                        u81.lastClickedTick = u2._cycleTick + 1;
                    end);
                end,
                Get = function(p83) --[[ Line: 385 ]]
                    -- upvalues: u2 (ref)
                    return p83.lastClickedTick == u2._cycleTick;
                end
            };
        end,
        rightClick = function(u84) --[[ Name: rightClick, Line 391 ]]
            -- upvalues: u2 (copy)
            return {
                Init = function(u85) --[[ Line: 393 ]]
                    -- upvalues: u84 (copy), u2 (ref)
                    local v86 = u84(u85);
                    u85.lastRightClickedTick = -1;
                    v86.MouseButton2Click:Connect(function() --[[ Line: 397 ]]
                        -- upvalues: u85 (copy), u2 (ref)
                        u85.lastRightClickedTick = u2._cycleTick + 1;
                    end);
                end,
                Get = function(p87) --[[ Line: 401 ]]
                    -- upvalues: u2 (ref)
                    return p87.lastRightClickedTick == u2._cycleTick;
                end
            };
        end,
        doubleClick = function(u88) --[[ Name: doubleClick, Line 407 ]]
            -- upvalues: u1 (ref), u2 (copy)
            return {
                Init = function(u89) --[[ Line: 409 ]]
                    -- upvalues: u88 (copy), u1 (ref), u2 (ref)
                    local v90 = u88(u89);
                    u89.lastClickedTime = -1;
                    u89.lastClickedPosition = Vector2.zero;
                    u89.lastDoubleClickedTick = -1;
                    v90.MouseButton1Down:Connect(function(p91, p92) --[[ Line: 415 ]]
                        -- upvalues: u1 (ref), u89 (copy), u2 (ref)
                        local v93 = u1.getTime();
                        if v93 - u89.lastClickedTime < u2._config.MouseDoubleClickTime and (Vector2.new(p91, p92) - u89.lastClickedPosition).Magnitude < u2._config.MouseDoubleClickMaxDist then
                            u89.lastDoubleClickedTick = u2._cycleTick + 1;
                        else
                            u89.lastClickedTime = v93;
                            u89.lastClickedPosition = Vector2.new(p91, p92);
                        end;
                    end);
                end,
                Get = function(p94) --[[ Line: 426 ]]
                    -- upvalues: u2 (ref)
                    return p94.lastDoubleClickedTick == u2._cycleTick;
                end
            };
        end,
        ctrlClick = function(u95) --[[ Name: ctrlClick, Line 432 ]]
            -- upvalues: u1 (ref), u2 (copy)
            return {
                Init = function(u96) --[[ Line: 434 ]]
                    -- upvalues: u95 (copy), u1 (ref), u2 (ref)
                    local v97 = u95(u96);
                    u96.lastCtrlClickedTick = -1;
                    v97.MouseButton1Click:Connect(function() --[[ Line: 438 ]]
                        -- upvalues: u1 (ref), u96 (copy), u2 (ref)
                        if u1.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u1.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
                            u96.lastCtrlClickedTick = u2._cycleTick + 1;
                        end;
                    end);
                end,
                Get = function(p98) --[[ Line: 444 ]]
                    -- upvalues: u2 (ref)
                    return p98.lastCtrlClickedTick == u2._cycleTick;
                end
            };
        end,
        shortcut = function(u99) --[[ Name: shortcut, Line 450 ]]
            -- upvalues: u1 (ref), u2 (copy)
            return {
                Init = function(u100) --[[ Line: 452 ]]
                    -- upvalues: u99 (copy), u1 (ref), u2 (ref)
                    local v101, u102 = u99(u100);
                    u100.lastShortcutTick = -1;
                    u1.ContextActionService:BindAction(u100.ID, function(_, p103, p104) --[[ Line: 456 ]]
                        -- upvalues: u102 (copy), u100 (copy), u2 (ref)
                        if p103 == Enum.UserInputState.Begin and p104:IsModifierKeyDown(u102) then
                            u100.lastShortcutTick = u2._cycleTick + 1;
                        end;
                    end, false, v101);
                end,
                Get = function(p105) --[[ Line: 464 ]]
                    -- upvalues: u2 (ref)
                    return p105.lastShortcutTick == u2._cycleTick;
                end
            };
        end
    };
    require(script.Root)(u2, u1);
    require(script.Window)(u2, u1);
    require(script.Menu)(u2, u1);
    require(script.Format)(u2, u1);
    require(script.Text)(u2, u1);
    require(script.Button)(u2, u1);
    require(script.Checkbox)(u2, u1);
    require(script.RadioButton)(u2, u1);
    require(script.Tree)(u2, u1);
    require(script.Input)(u2, u1);
    require(script.Combo)(u2, u1);
    require(script.Table)(u2, u1);
end;
