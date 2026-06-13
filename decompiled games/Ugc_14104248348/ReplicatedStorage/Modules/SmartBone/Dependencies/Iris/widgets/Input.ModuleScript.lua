-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.Input
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    local u4 = {
        Init = function(_) --[[ Line: 5 ]] end,
        Get = function(p3) --[[ Line: 6 ]]
            -- upvalues: u1 (copy)
            return p3.lastNumberChangedTick == u1._cycleTick;
        end
    };
    local function u9(p5, p6, p7) --[[ Line: 11 ]]
        if typeof(p5) == "number" then
            return p5;
        end;
        if typeof(p5) == "Vector2" then
            if p6 == 1 then
                return p5.X;
            end;
            if p6 == 2 then
                return p5.Y;
            end;
        elseif typeof(p5) == "Vector3" then
            if p6 == 1 then
                return p5.X;
            end;
            if p6 == 2 then
                return p5.Y;
            end;
            if p6 == 3 then
                return p5.Z;
            end;
        elseif typeof(p5) == "UDim" then
            if p6 == 1 then
                return p5.Scale;
            end;
            if p6 == 2 then
                return p5.Offset;
            end;
        elseif typeof(p5) == "UDim2" then
            if p6 == 1 then
                return p5.X.Scale;
            end;
            if p6 == 2 then
                return p5.X.Offset;
            end;
            if p6 == 3 then
                return p5.Y.Scale;
            end;
            if p6 == 4 then
                return p5.Y.Offset;
            end;
        elseif typeof(p5) == "Color3" then
            local v8 = p7.UseHSV and { p5:ToHSV() } or { p5.R, p5.G, p5.B };
            if p6 == 1 then
                return v8[1];
            end;
            if p6 == 2 then
                return v8[2];
            end;
            if p6 == 3 then
                return v8[3];
            end;
        elseif typeof(p5) == "Rect" then
            if p6 == 1 then
                return p5.Min.X;
            end;
            if p6 == 2 then
                return p5.Min.Y;
            end;
            if p6 == 3 then
                return p5.Max.X;
            end;
            if p6 == 4 then
                return p5.Max.Y;
            end;
        elseif typeof(p5) == "table" then
            return p5[p6];
        end;
        error((`Incorrect datatype or value: {p5} {typeof(p5)} {p6}`));
    end;
    local function u17(p10, p11, p12, p13) --[[ Line: 70 ]]
        if typeof(p10) == "number" then
            return p12;
        end;
        if typeof(p10) == "Vector2" then
            if p11 == 1 then
                return Vector2.new(p12, p10.Y);
            end;
            if p11 == 2 then
                return Vector2.new(p10.X, p12);
            end;
        elseif typeof(p10) == "Vector3" then
            if p11 == 1 then
                return Vector3.new(p12, p10.Y, p10.Z);
            end;
            if p11 == 2 then
                return Vector3.new(p10.X, p12, p10.Z);
            end;
            if p11 == 3 then
                return Vector3.new(p10.X, p10.Y, p12);
            end;
        elseif typeof(p10) == "UDim" then
            if p11 == 1 then
                return UDim.new(p12, p10.Offset);
            end;
            if p11 == 2 then
                return UDim.new(p10.Scale, p12);
            end;
        elseif typeof(p10) == "UDim2" then
            if p11 == 1 then
                return UDim2.new(UDim.new(p12, p10.X.Offset), p10.Y);
            end;
            if p11 == 2 then
                return UDim2.new(UDim.new(p10.X.Scale, p12), p10.Y);
            end;
            if p11 == 3 then
                return UDim2.new(p10.X, UDim.new(p12, p10.Y.Offset));
            end;
            if p11 == 4 then
                return UDim2.new(p10.X, UDim.new(p10.Y.Scale, p12));
            end;
        elseif typeof(p10) == "Rect" then
            if p11 == 1 then
                return Rect.new(Vector2.new(p12, p10.Min.Y), p10.Max);
            end;
            if p11 == 2 then
                return Rect.new(Vector2.new(p10.Min.X, p12), p10.Max);
            end;
            if p11 == 3 then
                return Rect.new(p10.Min, Vector2.new(p12, p10.Max.Y));
            end;
            if p11 == 4 then
                return Rect.new(p10.Min, Vector2.new(p10.Max.X, p12));
            end;
        elseif typeof(p10) == "Color3" then
            if p13.UseHSV then
                local v14, v15, v16 = p10:ToHSV();
                if p11 == 1 then
                    return Color3.fromHSV(p12, v15, v16);
                end;
                if p11 == 2 then
                    return Color3.fromHSV(v14, p12, v16);
                end;
                if p11 == 3 then
                    return Color3.fromHSV(v14, v15, p12);
                end;
            end;
            if p11 == 1 then
                return Color3.new(p12, p10.G, p10.B);
            end;
            if p11 == 2 then
                return Color3.new(p10.R, p12, p10.B);
            end;
            if p11 == 3 then
                return Color3.new(p10.R, p10.G, p12);
            end;
        end;
        error((`Incorrect datatype or value {p10} {typeof(p10)} {p11}`));
    end;
    local u18 = {
        Num = { 1 },
        Vector2 = { 1, 1 },
        Vector3 = { 1, 1, 1 },
        UDim = { 0.01, 1 },
        UDim2 = {
            0.01,
            1,
            0.01,
            1
        },
        Color3 = { 1, 1, 1 },
        Color4 = {
            1,
            1,
            1,
            1
        },
        Rect = {
            1,
            1,
            1,
            1
        }
    };
    local u19 = {
        Num = { 0 },
        Vector2 = { 0, 0 },
        Vector3 = { 0, 0, 0 },
        UDim = { 0, 0 },
        UDim2 = {
            0,
            0,
            0,
            0
        },
        Rect = {
            0,
            0,
            0,
            0
        }
    };
    local u20 = {
        Num = { 100 },
        Vector2 = { 100, 100 },
        Vector3 = { 100, 100, 100 },
        UDim = { 1, 960 },
        UDim2 = {
            1,
            960,
            1,
            960
        },
        Rect = {
            960,
            960,
            960,
            960
        }
    };
    local u21 = {
        Num = { "" },
        Vector2 = { "X: ", "Y: " },
        Vector3 = { "X: ", "Y: ", "Z: " },
        UDim = { "", "" },
        UDim2 = {
            "",
            "",
            "",
            ""
        },
        Color3_RGB = { "R: ", "G: ", "B: " },
        Color3_HSV = { "H: ", "S: ", "V: " },
        Color4_RGB = {
            "R: ",
            "G: ",
            "B: ",
            "T: "
        },
        Color4_HSV = {
            "H: ",
            "S: ",
            "V: ",
            "T: "
        },
        Rect = {
            "X: ",
            "Y: ",
            "X: ",
            "Y: "
        }
    };
    local u22 = {
        Num = { 0 },
        Vector2 = { 0, 0 },
        Vector3 = { 0, 0, 0 },
        UDim = { 3, 0 },
        UDim2 = {
            3,
            0,
            3,
            0
        },
        Color3 = { 0, 0, 0 },
        Color4 = {
            0,
            0,
            0,
            0
        },
        Rect = {
            0,
            0,
            0,
            0
        }
    };
    local function u36(u23, p24, p25, p26) --[[ Line: 194 ]]
        -- upvalues: u1 (copy), u2 (copy), u9 (copy)
        local v27 = p25 + (2 * u1._config.ItemInnerSpacing.X + p26 * 2);
        local v28 = u2.abstractButton.Generate(u23);
        v28.Name = "SubButton";
        v28.ZIndex = u23.ZIndex + 5;
        v28.LayoutOrder = u23.ZIndex + 5;
        v28.TextXAlignment = Enum.TextXAlignment.Center;
        v28.Text = "-";
        v28.Size = UDim2.fromOffset(u1._config.TextSize + 2 * u1._config.FramePadding.Y, u1._config.TextSize);
        v28.Parent = p24;
        v28.MouseButton1Click:Connect(function() --[[ Line: 206 ]]
            -- upvalues: u2 (ref), u23 (copy), u9 (ref), u1 (ref)
            local v29 = u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl);
            local v30 = u23.arguments.Increment and u9(u23.arguments.Increment, 1, u23.arguments) or 1;
            local v31 = u23.state.number.value - v30 * (v29 and 100 or 1);
            if u23.arguments.Min ~= nil then
                v31 = math.max(v31, u9(u23.arguments.Min, 1, u23.arguments));
            end;
            if u23.arguments.Max ~= nil then
                v31 = math.min(v31, u9(u23.arguments.Max, 1, u23.arguments));
            end;
            u23.state.number:set(v31);
            u23.lastNumberChangedTick = u1._cycleTick + 1;
        end);
        local v32 = u2.abstractButton.Generate(u23);
        v32.Name = "AddButton";
        v32.ZIndex = u23.ZIndex + 6;
        v32.LayoutOrder = u23.ZIndex + 6;
        v32.TextXAlignment = Enum.TextXAlignment.Center;
        v32.Text = "+";
        v32.Size = UDim2.fromOffset(u1._config.TextSize + 2 * u1._config.FramePadding.Y, u1._config.TextSize);
        v32.Parent = p24;
        v32.MouseButton1Click:Connect(function() --[[ Line: 232 ]]
            -- upvalues: u2 (ref), u23 (copy), u9 (ref), u1 (ref)
            local v33 = u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl);
            local v34 = u23.arguments.Increment and u9(u23.arguments.Increment, 1, u23.arguments) or 1;
            local v35 = u23.state.number.value + v34 * (v33 and 100 or 1);
            if u23.arguments.Min ~= nil then
                v35 = math.max(v35, u9(u23.arguments.Min, 1, u23.arguments));
            end;
            if u23.arguments.Max ~= nil then
                v35 = math.min(v35, u9(u23.arguments.Max, 1, u23.arguments));
            end;
            u23.state.number:set(v35);
            u23.lastNumberChangedTick = u1._cycleTick + 1;
        end);
        return v27;
    end;
    local function v73(u37, u38, u39) --[[ Line: 252 ]]
        -- upvalues: u4 (copy), u2 (copy), u1 (copy), u36 (copy), u9 (copy), u17 (copy), u22 (copy), u21 (copy)
        return {
            hasState = true,
            hasChildren = false,
            Args = {
                Text = 1,
                Increment = 2,
                Min = 3,
                Max = 4,
                Format = 5
            },
            Events = {
                numberChanged = u4,
                hovered = u2.EVENTS.hover(function(p40) --[[ Line: 265 ]]
                    return p40.Instance;
                end)
            },
            Generate = function(u41) --[[ Name: Generate, Line 269 ]]
                -- upvalues: u37 (copy), u2 (ref), u1 (ref), u38 (copy), u36 (ref), u9 (ref), u17 (ref)
                local v42 = Instance.new("Frame");
                v42.Name = "Iris_Input" .. u37;
                v42.Size = UDim2.fromScale(1, 0);
                v42.BackgroundTransparency = 1;
                v42.BorderSizePixel = 0;
                v42.ZIndex = u41.ZIndex;
                v42.LayoutOrder = u41.ZIndex;
                v42.AutomaticSize = Enum.AutomaticSize.Y;
                u2.UIListLayout(v42, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X));
                local v43 = 0;
                local v44 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
                if u38 == 1 then
                    v43 = u36(u41, v42, v43, v44);
                end;
                local v45 = UDim.new(u1._config.ContentWidth.Scale / u38, (u1._config.ContentWidth.Offset - u1._config.ItemInnerSpacing.X * (u38 - 1) - v43) / u38);
                local v46 = UDim.new(v45.Scale * (u38 - 1), v45.Offset * (u38 - 1) + u1._config.ItemInnerSpacing.X * (u38 - 1) + v43);
                local v47 = u1._config.ContentWidth - v46;
                for u48 = 1, u38 do
                    local u49 = Instance.new("TextBox");
                    u49.Name = "InputField" .. tostring(u48);
                    u49.ZIndex = u41.ZIndex + u48;
                    u49.LayoutOrder = u41.ZIndex + u48;
                    if u48 == u38 then
                        u49.Size = UDim2.new(v47, UDim.new());
                    else
                        u49.Size = UDim2.new(v45, UDim.new());
                    end;
                    u49.AutomaticSize = Enum.AutomaticSize.Y;
                    u49.BackgroundColor3 = u1._config.FrameBgColor;
                    u49.BackgroundTransparency = u1._config.FrameBgTransparency;
                    u49.ClearTextOnFocus = false;
                    u49.TextTruncate = Enum.TextTruncate.AtEnd;
                    u49.ClipsDescendants = true;
                    u2.applyFrameStyle(u49);
                    u2.applyTextStyle(u49);
                    u2.UISizeConstraint(u49, Vector2.new(1, 0));
                    u49.Parent = v42;
                    u49.FocusLost:Connect(function() --[[ Line: 325 ]]
                        -- upvalues: u49 (copy), u41 (copy), u9 (ref), u48 (copy), u17 (ref), u1 (ref)
                        local v50 = tonumber(u49.Text:match("-?%d*%.?%d*"));
                        if v50 ~= nil then
                            if u41.arguments.Min ~= nil then
                                v50 = math.max(v50, u9(u41.arguments.Min, u48, u41.arguments));
                            end;
                            if u41.arguments.Max ~= nil then
                                v50 = math.min(v50, u9(u41.arguments.Max, u48, u41.arguments));
                            end;
                            if u41.arguments.Increment then
                                local v51 = v50 / u9(u41.arguments.Increment, u48, u41.arguments);
                                v50 = math.round(v51) * u9(u41.arguments.Increment, u48, u41.arguments);
                            end;
                            u41.state.number:set(u17(u41.state.number.value, u48, v50, u41.arguments));
                            u41.lastNumberChangedTick = u1._cycleTick + 1;
                        end;
                        local v52 = u41.arguments.Format[u48] or u41.arguments.Format[1];
                        if u41.arguments.Prefix then
                            v52 = u41.arguments.Prefix[u48] .. v52;
                        end;
                        u49.Text = string.format(v52, u9(u41.state.number.value, u48, u41.arguments));
                        u41.state.editingText:set(0);
                    end);
                    u49.Focused:Connect(function() --[[ Line: 352 ]]
                        -- upvalues: u49 (copy), u41 (copy), u48 (copy)
                        u49.CursorPosition = #u49.Text + 1;
                        u49.SelectionStart = 1;
                        u41.state.editingText:set(u48);
                    end);
                end;
                local v53 = Instance.new("TextLabel");
                v53.Name = "TextLabel";
                v53.Size = UDim2.fromOffset(0, v44);
                v53.BackgroundTransparency = 1;
                v53.BorderSizePixel = 0;
                v53.ZIndex = u41.ZIndex + 7;
                v53.LayoutOrder = u41.ZIndex + 7;
                v53.AutomaticSize = Enum.AutomaticSize.X;
                u2.applyTextStyle(v53);
                v53.Parent = v42;
                return v42;
            end,
            Update = function(p54) --[[ Name: Update, Line 376 ]]
                -- upvalues: u37 (copy), u38 (copy), u22 (ref), u9 (ref), u21 (ref)
                local l__Instance__1 = p54.Instance;
                l__Instance__1.TextLabel.Text = p54.arguments.Text or `Input {u37}`;
                if u38 == 1 then
                    l__Instance__1.SubButton.Visible = not p54.arguments.NoButtons;
                    l__Instance__1.AddButton.Visible = not p54.arguments.NoButtons;
                end;
                if p54.arguments.Format and typeof(p54.arguments.Format) ~= "table" then
                    p54.arguments.Format = { p54.arguments.Format };
                else
                    local v55 = {};
                    for v56 = 1, u38 do
                        local v57 = u22[u37][v56];
                        if p54.arguments.Increment then
                            local v58 = u9(p54.arguments.Increment, v56, p54.arguments);
                            local v59 = -math.log10(v58 == 0 and 1 or v58);
                            local v60 = math.ceil(v59);
                            v57 = math.max(v57, v60, v57);
                        end;
                        if p54.arguments.Max then
                            local v61 = u9(p54.arguments.Max, v56, p54.arguments);
                            local v62 = -math.log10(v61 == 0 and 1 or v61);
                            local v63 = math.ceil(v62);
                            v57 = math.max(v57, v63, v57);
                        end;
                        if p54.arguments.Min then
                            local v64 = u9(p54.arguments.Min, v56, p54.arguments);
                            local v65 = -math.log10(v64 == 0 and 1 or v64);
                            local v66 = math.ceil(v65);
                            v57 = math.max(v57, v66, v57);
                        end;
                        if v57 > 0 then
                            v55[v56] = `%.{v57}f`;
                        else
                            v55[v56] = "%d";
                        end;
                    end;
                    p54.arguments.Format = v55;
                    p54.arguments.Prefix = u21[u37];
                end;
            end,
            Discard = function(p67) --[[ Name: Discard, Line 421 ]]
                -- upvalues: u2 (ref)
                p67.Instance:Destroy();
                u2.discardState(p67);
            end,
            GenerateState = function(p68) --[[ Name: GenerateState, Line 425 ]]
                -- upvalues: u1 (ref), u39 (copy)
                if p68.state.number == nil then
                    p68.state.number = u1._widgetState(p68, "number", u39);
                end;
                if p68.state.editingText == nil then
                    p68.state.editingText = u1._widgetState(p68, "editingText", 0);
                end;
            end,
            UpdateState = function(p69) --[[ Name: UpdateState, Line 433 ]]
                -- upvalues: u38 (copy), u9 (ref)
                local l__Instance__2 = p69.Instance;
                for v70 = 1, u38 do
                    local v71 = l__Instance__2:FindFirstChild("InputField" .. tostring(v70));
                    local v72 = p69.arguments.Format[v70] or p69.arguments.Format[1];
                    if p69.arguments.Prefix then
                        v72 = p69.arguments.Prefix[v70] .. v72;
                    end;
                    v71.Text = string.format(v72, u9(p69.state.number.value, v70, p69.arguments));
                end;
            end
        };
    end;
    local u74 = 0;
    local u75 = false;
    local u76 = nil;
    local u77 = 0;
    local u78 = "";
    local function u82() --[[ Line: 461 ]]
        -- upvalues: u2 (copy), u74 (ref), u75 (ref), u76 (ref), u78 (ref), u77 (ref), u9 (copy), u18 (copy), u17 (copy), u1 (copy)
        local l__X__3 = u2.getMouseLocation().X;
        local v79 = l__X__3 - u74;
        u74 = l__X__3;
        if u75 == false then
        elseif u76 == nil then
        else
            local l__number__4 = u76.state.number;
            if u78 == "Color3" or u78 == "Color4" then
                l__number__4 = u76.state.color;
                if u77 == 4 then
                    l__number__4 = u76.state.transparency;
                end;
            end;
            local v80 = (u76.arguments.Increment and u9(u76.arguments.Increment, u77, u76.arguments) or u18[u78][u77]) * ((u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightShift)) and 10 or 1) * ((u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightAlt)) and 0.1 or 1) * ((u78 == "Color3" or u78 == "Color4") and 5 or 1);
            local v81 = u9(l__number__4.value, u77, u76.arguments) + v79 * v80;
            if u76.arguments.Min ~= nil then
                v81 = math.max(v81, u9(u76.arguments.Min, u77, u76.arguments));
            end;
            if u76.arguments.Max ~= nil then
                v81 = math.min(v81, u9(u76.arguments.Max, u77, u76.arguments));
            end;
            l__number__4:set(u17(l__number__4.value, u77, v81, u76.arguments));
            u76.lastNumberChangedTick = u1._cycleTick + 1;
        end;
    end;
    local function u91(p83, p84, p85, p86, p87) --[[ Line: 502 ]]
        -- upvalues: u2 (copy), u1 (copy), u75 (ref), u76 (ref), u77 (ref), u78 (ref), u82 (copy)
        local v88 = u2.getTime();
        local v89 = v88 - p83.lastClickedTime < u1._config.MouseDoubleClickTime;
        local v90 = u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl);
        if v89 and (Vector2.new(p86, p87) - p83.lastClickedPosition).Magnitude < u1._config.MouseDoubleClickMaxDist or v90 then
            p83.state.editingText:set(p85);
        else
            p83.lastClickedTime = v88;
            p83.lastClickedPosition = Vector2.new(p86, p87);
            u75 = true;
            u76 = p83;
            u77 = p85;
            u78 = p84;
            u82();
        end;
    end;
    u2.UserInputService.InputChanged:Connect(u82);
    u2.UserInputService.InputEnded:Connect(function(p92) --[[ Line: 525 ]]
        -- upvalues: u75 (ref), u76 (ref), u77 (ref)
        if p92.UserInputType == Enum.UserInputType.MouseButton1 and u75 then
            u75 = false;
            u76 = nil;
            u77 = 0;
        end;
    end);
    local function u135(u93, u94, u95) --[[ Line: 533 ]]
        -- upvalues: u4 (copy), u2 (copy), u1 (copy), u9 (copy), u17 (copy), u91 (copy), u22 (copy), u21 (copy)
        return {
            hasState = true,
            hasChildren = false,
            Args = {
                Text = 1,
                Increment = 2,
                Min = 3,
                Max = 4,
                Format = 5
            },
            Events = {
                numberChanged = u4,
                hovered = u2.EVENTS.hover(function(p96) --[[ Line: 546 ]]
                    return p96.Instance;
                end)
            },
            Generate = function(u97) --[[ Name: Generate, Line 550 ]]
                -- upvalues: u93 (copy), u2 (ref), u1 (ref), u94 (copy), u9 (ref), u17 (ref), u91 (ref)
                u97.lastClickedTime = -1;
                u97.lastClickedPosition = Vector2.zero;
                local v98 = Instance.new("Frame");
                v98.Name = "Iris_Drag" .. u93;
                v98.Size = UDim2.fromScale(1, 0);
                v98.BackgroundTransparency = 1;
                v98.BorderSizePixel = 0;
                v98.ZIndex = u97.ZIndex;
                v98.LayoutOrder = u97.ZIndex;
                v98.AutomaticSize = Enum.AutomaticSize.Y;
                u2.UIListLayout(v98, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X));
                local v99 = 0;
                local v100 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
                if u93 == "Color3" or u93 == "Color4" then
                    v99 = v99 + (u1._config.ItemInnerSpacing.X + v100);
                    local v101 = Instance.new("ImageLabel");
                    v101.Name = "ColorBox";
                    v101.BorderSizePixel = 0;
                    v101.Size = UDim2.fromOffset(v100, v100);
                    v101.ZIndex = u97.ZIndex + 5;
                    v101.LayoutOrder = u97.ZIndex + 5;
                    v101.Image = u2.ICONS.ALPHA_BACKGROUND_TEXTURE;
                    v101.ImageTransparency = 1;
                    u2.applyFrameStyle(v101, true, true);
                    v101.Parent = v98;
                end;
                local v102 = UDim.new(u1._config.ContentWidth.Scale / u94, (u1._config.ContentWidth.Offset - u1._config.ItemInnerSpacing.X * (u94 - 1) - v99) / u94);
                local v103 = UDim.new(v102.Scale * (u94 - 1), v102.Offset * (u94 - 1) + u1._config.ItemInnerSpacing.X * (u94 - 1) + v99);
                local v104 = u1._config.ContentWidth - v103;
                for u105 = 1, u94 do
                    local v106 = Instance.new("TextButton");
                    v106.Name = "DragField" .. tostring(u105);
                    v106.ZIndex = u97.ZIndex + u105;
                    v106.LayoutOrder = u97.ZIndex + u105;
                    if u105 == u94 then
                        v106.Size = UDim2.new(v104, UDim.new());
                    else
                        v106.Size = UDim2.new(v102, UDim.new());
                    end;
                    v106.AutomaticSize = Enum.AutomaticSize.Y;
                    v106.BackgroundColor3 = u1._config.FrameBgColor;
                    v106.BackgroundTransparency = u1._config.FrameBgTransparency;
                    v106.AutoButtonColor = false;
                    v106.Text = "";
                    v106.ClipsDescendants = true;
                    u2.applyFrameStyle(v106);
                    u2.applyTextStyle(v106);
                    u2.UISizeConstraint(v106, Vector2.new(1, 0));
                    v106.TextXAlignment = Enum.TextXAlignment.Center;
                    v106.Parent = v98;
                    u2.applyInteractionHighlights(v106, v106, {
                        ButtonColor = u1._config.FrameBgColor,
                        ButtonTransparency = u1._config.FrameBgTransparency,
                        ButtonHoveredColor = u1._config.FrameBgHoveredColor,
                        ButtonHoveredTransparency = u1._config.FrameBgHoveredTransparency,
                        ButtonActiveColor = u1._config.FrameBgActiveColor,
                        ButtonActiveTransparency = u1._config.FrameBgActiveTransparency
                    });
                    local u107 = Instance.new("TextBox");
                    u107.Name = "InputField";
                    u107.ZIndex = u97.ZIndex + 5;
                    u107.LayoutOrder = u97.ZIndex + 2;
                    u107.Size = UDim2.new(1, 0, 1, 0);
                    u107.BackgroundTransparency = 1;
                    u107.ClearTextOnFocus = false;
                    u107.TextTruncate = Enum.TextTruncate.AtEnd;
                    u107.ClipsDescendants = true;
                    u107.Visible = false;
                    u2.applyFrameStyle(u107, true);
                    u2.applyTextStyle(u107);
                    u107.Parent = v106;
                    u107.FocusLost:Connect(function() --[[ Line: 648 ]]
                        -- upvalues: u107 (copy), u97 (copy), u93 (ref), u105 (copy), u9 (ref), u17 (ref), u1 (ref)
                        local v108 = tonumber(u107.Text:match("-?%d*%.?%d*"));
                        local l__number__5 = u97.state.number;
                        if u93 == "Color4" and u105 == 4 then
                            l__number__5 = u97.state.transparency;
                        elseif u93 == "Color3" or u93 == "Color4" then
                            l__number__5 = u97.state.color;
                        end;
                        if v108 ~= nil then
                            if u93 == "Color3" or u93 == "Color4" and not u97.arguments.UseFloats then
                                v108 = v108 / 255;
                            end;
                            if u97.arguments.Min ~= nil then
                                v108 = math.max(v108, u9(u97.arguments.Min, u105, u97.arguments));
                            end;
                            if u97.arguments.Max ~= nil then
                                v108 = math.min(v108, u9(u97.arguments.Max, u105, u97.arguments));
                            end;
                            if u97.arguments.Increment then
                                local v109 = v108 / u9(u97.arguments.Increment, u105, u97.arguments);
                                v108 = math.round(v109) * u9(u97.arguments.Increment, u105, u97.arguments);
                            end;
                            l__number__5:set(u17(l__number__5.value, u105, v108, u97.arguments));
                            u97.lastNumberChangedTick = u1._cycleTick + 1;
                        end;
                        local v110 = u9(l__number__5.value, u105, u97.arguments);
                        if u93 == "Color3" or u93 == "Color4" and not u97.arguments.UseFloats then
                            v110 = math.round(v110 * 255);
                        end;
                        local v111 = u97.arguments.Format[u105] or u97.arguments.Format[1];
                        if u97.arguments.Prefix then
                            v111 = u97.arguments.Prefix[u105] .. v111;
                        end;
                        u107.Text = string.format(v111, v110);
                        u97.state.editingText:set(0);
                        u107:ReleaseFocus(true);
                    end);
                    u107.Focused:Connect(function() --[[ Line: 691 ]]
                        -- upvalues: u107 (copy), u97 (copy), u105 (copy)
                        u107.CursorPosition = #u107.Text + 1;
                        u107.SelectionStart = 1;
                        u97.state.editingText:set(u105);
                    end);
                    v106.MouseButton1Down:Connect(function(p112, p113) --[[ Line: 699 ]]
                        -- upvalues: u91 (ref), u97 (copy), u93 (ref), u105 (copy)
                        u91(u97, u93, u105, p112, p113);
                    end);
                end;
                local v114 = Instance.new("TextLabel");
                v114.Name = "TextLabel";
                v114.Size = UDim2.fromOffset(0, v100);
                v114.BackgroundTransparency = 1;
                v114.BorderSizePixel = 0;
                v114.ZIndex = u97.ZIndex + 5;
                v114.LayoutOrder = u97.ZIndex + 5;
                v114.AutomaticSize = Enum.AutomaticSize.X;
                u2.applyTextStyle(v114);
                v114.Parent = v98;
                return v98;
            end,
            Update = function(p115) --[[ Name: Update, Line 719 ]]
                -- upvalues: u93 (copy), u94 (copy), u22 (ref), u9 (ref), u21 (ref)
                p115.Instance.TextLabel.Text = p115.arguments.Text or `Drag {u93}`;
                if p115.arguments.Format and typeof(p115.arguments.Format) ~= "table" then
                    p115.arguments.Format = { p115.arguments.Format };
                else
                    if not p115.arguments.Format then
                        local v116 = {};
                        for v117 = 1, u94 do
                            local v118 = u22[u93][v117];
                            if p115.arguments.Increment then
                                local v119 = u9(p115.arguments.Increment, v117, p115.arguments);
                                local v120 = -math.log10(v119 == 0 and 1 or v119);
                                local v121 = math.ceil(v120);
                                v118 = math.max(v118, v121, v118);
                            end;
                            if p115.arguments.Max then
                                local v122 = u9(p115.arguments.Max, v117, p115.arguments);
                                local v123 = -math.log10(v122 == 0 and 1 or v122);
                                local v124 = math.ceil(v123);
                                v118 = math.max(v118, v124, v118);
                            end;
                            if p115.arguments.Min then
                                local v125 = u9(p115.arguments.Min, v117, p115.arguments);
                                local v126 = -math.log10(v125 == 0 and 1 or v125);
                                local v127 = math.ceil(v126);
                                v118 = math.max(v118, v127, v118);
                            end;
                            if v118 > 0 then
                                v116[v117] = `%.{v118}f`;
                            else
                                v116[v117] = "%d";
                            end;
                        end;
                        p115.arguments.Format = v116;
                        p115.arguments.Prefix = u21[u93];
                    end;
                end;
            end,
            Discard = function(p128) --[[ Name: Discard, Line 759 ]]
                -- upvalues: u2 (ref)
                p128.Instance:Destroy();
                u2.discardState(p128);
            end,
            GenerateState = function(p129) --[[ Name: GenerateState, Line 763 ]]
                -- upvalues: u1 (ref), u95 (copy)
                if p129.state.number == nil then
                    p129.state.number = u1._widgetState(p129, "number", u95);
                end;
                if p129.state.editingText == nil then
                    p129.state.editingText = u1._widgetState(p129, "editingText", false);
                end;
            end,
            UpdateState = function(p130) --[[ Name: UpdateState, Line 771 ]]
                -- upvalues: u94 (copy), u93 (copy), u9 (ref), u1 (ref)
                local l__Instance__6 = p130.Instance;
                for v131 = 1, u94 do
                    local l__number__7 = p130.state.number;
                    if u93 == "Color3" or u93 == "Color4" then
                        l__number__7 = p130.state.color;
                        if v131 == 4 then
                            l__number__7 = p130.state.transparency;
                        end;
                    end;
                    local v132 = l__Instance__6:FindFirstChild("DragField" .. tostring(v131));
                    local l__InputField__8 = v132.InputField;
                    local v133 = u9(l__number__7.value, v131, p130.arguments);
                    if (u93 == "Color3" or u93 == "Color4") and not p130.arguments.UseFloats then
                        v133 = math.round(v133 * 255);
                    end;
                    local v134 = p130.arguments.Format[v131] or p130.arguments.Format[1];
                    if p130.arguments.Prefix then
                        v134 = p130.arguments.Prefix[v131] .. v134;
                    end;
                    v132.Text = string.format(v134, v133);
                    l__InputField__8.Text = tostring(v133);
                    if p130.state.editingText.value == v131 then
                        l__InputField__8.Visible = true;
                        l__InputField__8:CaptureFocus();
                        v132.TextTransparency = 1;
                    else
                        l__InputField__8.Visible = false;
                        v132.TextTransparency = u1._config.TextTransparency;
                    end;
                end;
                if u93 == "Color3" or u93 == "Color4" then
                    local l__ColorBox__9 = l__Instance__6.ColorBox;
                    l__ColorBox__9.BackgroundColor3 = p130.state.color.value;
                    if u93 == "Color4" then
                        l__ColorBox__9.ImageTransparency = 1 - p130.state.transparency.value;
                    end;
                end;
            end
        };
    end;
    local function v141(u136, ...) --[[ Line: 819 ]]
        -- upvalues: u135 (ref), u2 (copy), u21 (copy), u1 (copy)
        local u137 = { ... };
        local v138 = u135(u136, u136 == "Color4" and 4 or 3, u137[1]);
        return u2.extend(v138, {
            Args = {
                Text = 1,
                UseFloats = 2,
                UseHSV = 3,
                Format = 4
            },
            Update = function(p139) --[[ Name: Update, Line 830 ]]
                -- upvalues: u136 (copy), u21 (ref), u1 (ref)
                p139.Instance.TextLabel.Text = p139.arguments.Text or `Drag {u136}`;
                if p139.arguments.Format and typeof(p139.arguments.Format) ~= "table" then
                    p139.arguments.Format = { p139.arguments.Format };
                else
                    if p139.arguments.UseFloats then
                        p139.arguments.Format = { "%.3f" };
                    else
                        p139.arguments.Format = { "%d" };
                    end;
                    p139.arguments.Prefix = u21[u136 .. (p139.arguments.UseHSV and "_HSV" or "_RGB")];
                end;
                p139.arguments.Min = {
                    0,
                    0,
                    0,
                    0
                };
                p139.arguments.Max = {
                    1,
                    1,
                    1,
                    1
                };
                p139.arguments.Increment = {
                    0.001,
                    0.001,
                    0.001,
                    0.001
                };
                if p139.state then
                    u1._widgets[p139.type].UpdateState(p139);
                end;
            end,
            GenerateState = function(p140) --[[ Name: GenerateState, Line 857 ]]
                -- upvalues: u1 (ref), u137 (copy), u136 (copy)
                if p140.state.color == nil then
                    p140.state.color = u1._widgetState(p140, "color", u137[1]);
                end;
                if u136 == "Color4" and p140.state.transparency == nil then
                    p140.state.transparency = u1._widgetState(p140, "transparency", u137[2]);
                end;
                if p140.state.editingText == nil then
                    p140.state.editingText = u1._widgetState(p140, "editingText", false);
                end;
            end
        });
    end;
    local u142 = false;
    local u143 = nil;
    local u144 = 0;
    local u145 = "";
    local function u154() --[[ Line: 885 ]]
        -- upvalues: u142 (ref), u143 (ref), u144 (ref), u9 (copy), u18 (copy), u145 (ref), u19 (copy), u20 (copy), u1 (copy), u2 (copy), u17 (copy)
        if u142 == false then
        elseif u143 == nil then
        else
            local v146 = u143.Instance:FindFirstChild("SliderField" .. tostring(u144));
            local v147 = u143.arguments.Increment and u9(u143.arguments.Increment, u144, u143.arguments) or u18[u145][u144];
            local v148 = u143.arguments.Min and u9(u143.arguments.Min, u144, u143.arguments) or u19[u145][u144];
            local v149 = u143.arguments.Max and u9(u143.arguments.Max, u144, u143.arguments) or u20[u145][u144];
            local l__X__10 = u1._config.FramePadding.X;
            local v150 = math.floor(((v147 < 1 and 0 or 1) + v149 - v148) / v147);
            local v151 = (u2.getMouseLocation().X - (v146.AbsolutePosition.X + l__X__10)) / (v146.AbsoluteSize.X - l__X__10 * 2) * v150;
            local v152 = math.floor(v151) * v147 + v148;
            local v153 = math.clamp(v152, v148, v149);
            u143.state.number:set(u17(u143.state.number.value, u144, v153, u143.arguments));
            u143.lastNumberChangedTick = u1._cycleTick + 1;
        end;
    end;
    local function u158(p155, p156, p157) --[[ Line: 915 ]]
        -- upvalues: u2 (copy), u142 (ref), u143 (ref), u144 (ref), u145 (ref), u154 (copy)
        if u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
            p155.state.editingText:set(p157);
        else
            u142 = true;
            u143 = p155;
            u144 = p157;
            u145 = p156;
            u154();
        end;
    end;
    u2.UserInputService.InputChanged:Connect(u154);
    u2.UserInputService.InputEnded:Connect(function(p159) --[[ Line: 931 ]]
        -- upvalues: u142 (ref), u143 (ref), u144 (ref), u145 (ref)
        if p159.UserInputType == Enum.UserInputType.MouseButton1 and u142 then
            u142 = false;
            u143 = nil;
            u144 = 0;
            u145 = "";
        end;
    end);
    local function v214(u160, u161, u162, ...) --[[ Line: 940 ]]
        -- upvalues: u4 (copy), u2 (copy), u1 (copy), u9 (copy), u17 (copy), u158 (copy), u22 (copy), u21 (copy), u18 (copy), u19 (copy), u20 (copy)
        return {
            hasState = true,
            hasChildren = false,
            Args = {
                Text = 1,
                Increment = 2,
                Min = 3,
                Max = 4,
                Format = 5
            },
            Events = {
                numberChanged = u4,
                hovered = u2.EVENTS.hover(function(p163) --[[ Line: 953 ]]
                    return p163.Instance;
                end)
            },
            Generate = function(u164) --[[ Name: Generate, Line 957 ]]
                -- upvalues: u160 (copy), u2 (ref), u1 (ref), u161 (copy), u9 (ref), u17 (ref), u158 (ref)
                local v165 = Instance.new("Frame");
                v165.Name = "Iris_Slider" .. u160;
                v165.Size = UDim2.fromScale(1, 0);
                v165.BackgroundTransparency = 1;
                v165.BorderSizePixel = 0;
                v165.ZIndex = u164.ZIndex;
                v165.LayoutOrder = u164.ZIndex;
                v165.AutomaticSize = Enum.AutomaticSize.Y;
                u2.UIListLayout(v165, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X));
                local v166 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
                local v167 = UDim.new(u1._config.ContentWidth.Scale / u161, (u1._config.ContentWidth.Offset - u1._config.ItemInnerSpacing.X * (u161 - 1)) / u161);
                local v168 = UDim.new(v167.Scale * (u161 - 1), v167.Offset * (u161 - 1) + u1._config.ItemInnerSpacing.X * (u161 - 1));
                local v169 = u1._config.ContentWidth - v168;
                for u170 = 1, u161 do
                    local v171 = Instance.new("TextButton");
                    v171.Name = "SliderField" .. tostring(u170);
                    v171.ZIndex = u164.ZIndex + u170;
                    v171.LayoutOrder = u164.ZIndex + u170;
                    if u170 == u161 then
                        v171.Size = UDim2.new(v169, UDim.new());
                    else
                        v171.Size = UDim2.new(v167, UDim.new());
                    end;
                    v171.AutomaticSize = Enum.AutomaticSize.Y;
                    v171.BackgroundColor3 = u1._config.FrameBgColor;
                    v171.BackgroundTransparency = u1._config.FrameBgTransparency;
                    v171.AutoButtonColor = false;
                    v171.Text = "";
                    v171.ClipsDescendants = true;
                    u2.applyFrameStyle(v171);
                    u2.applyTextStyle(v171);
                    u2.UISizeConstraint(v171, Vector2.new(1, 0));
                    v171.Parent = v165;
                    local v172 = Instance.new("TextLabel");
                    v172.Name = "OverlayText";
                    v172.Size = UDim2.fromScale(1, 1);
                    v172.BackgroundTransparency = 1;
                    v172.BorderSizePixel = 0;
                    v172.ZIndex = u164.ZIndex + 10;
                    v172.ClipsDescendants = true;
                    u2.applyTextStyle(v172);
                    v172.TextXAlignment = Enum.TextXAlignment.Center;
                    v172.Parent = v171;
                    u2.applyInteractionHighlights(v171, v171, {
                        ButtonColor = u1._config.FrameBgColor,
                        ButtonTransparency = u1._config.FrameBgTransparency,
                        ButtonHoveredColor = u1._config.FrameBgHoveredColor,
                        ButtonHoveredTransparency = u1._config.FrameBgHoveredTransparency,
                        ButtonActiveColor = u1._config.FrameBgActiveColor,
                        ButtonActiveTransparency = u1._config.FrameBgActiveTransparency
                    });
                    local u173 = Instance.new("TextBox");
                    u173.Name = "InputField";
                    u173.ZIndex = u164.ZIndex + 5;
                    u173.LayoutOrder = u164.ZIndex + 2;
                    u173.Size = UDim2.new(1, 0, 1, 0);
                    u173.BackgroundTransparency = 1;
                    u173.ClearTextOnFocus = false;
                    u173.TextTruncate = Enum.TextTruncate.AtEnd;
                    u173.ClipsDescendants = true;
                    u173.Visible = false;
                    u2.applyFrameStyle(u173, true);
                    u2.applyTextStyle(u173);
                    u173.Parent = v171;
                    u173.FocusLost:Connect(function() --[[ Line: 1045 ]]
                        -- upvalues: u173 (copy), u164 (copy), u9 (ref), u170 (copy), u17 (ref), u1 (ref)
                        local v174 = tonumber(u173.Text:match("-?%d*%.?%d*"));
                        if v174 ~= nil then
                            if u164.arguments.Min ~= nil then
                                v174 = math.max(v174, u9(u164.arguments.Min, u170, u164.arguments));
                            end;
                            if u164.arguments.Max ~= nil then
                                v174 = math.min(v174, u9(u164.arguments.Max, u170, u164.arguments));
                            end;
                            if u164.arguments.Increment then
                                local v175 = v174 / u9(u164.arguments.Increment, u170, u164.arguments);
                                v174 = math.round(v175) * u9(u164.arguments.Increment, u170, u164.arguments);
                            end;
                            u164.state.number:set(u17(u164.state.number.value, u170, v174, u164.arguments));
                            u164.lastNumberChangedTick = u1._cycleTick + 1;
                        end;
                        local v176 = u164.arguments.Format[u170] or u164.arguments.Format[1];
                        if u164.arguments.Prefix then
                            v176 = u164.arguments.Prefix[u170] .. v176;
                        end;
                        u173.Text = string.format(v176, u9(u164.state.number.value, u170, u164.arguments));
                        u164.state.editingText:set(0);
                        u173:ReleaseFocus(true);
                    end);
                    u173.Focused:Connect(function() --[[ Line: 1075 ]]
                        -- upvalues: u173 (copy), u164 (copy), u170 (copy)
                        u173.CursorPosition = #u173.Text + 1;
                        u173.SelectionStart = 1;
                        u164.state.editingText:set(u170);
                    end);
                    v171.MouseButton1Down:Connect(function() --[[ Line: 1083 ]]
                        -- upvalues: u158 (ref), u164 (copy), u160 (ref), u170 (copy)
                        u158(u164, u160, u170);
                    end);
                    local v177 = Instance.new("Frame");
                    v177.Name = "GrabBar";
                    v177.ZIndex = u164.ZIndex + 5;
                    v177.LayoutOrder = u164.ZIndex + 5;
                    v177.AnchorPoint = Vector2.new(0, 0.5);
                    v177.Position = UDim2.new(0, 0, 0.5, 0);
                    v177.BorderSizePixel = 0;
                    v177.BackgroundColor3 = u1._config.SliderGrabColor;
                    v177.Transparency = u1._config.SliderGrabTransparency;
                    if u1._config.GrabRounding > 0 then
                        u2.UICorner(v177, u1._config.GrabRounding);
                    end;
                    v177.Parent = v171;
                end;
                local v178 = Instance.new("TextLabel");
                v178.Name = "TextLabel";
                v178.Size = UDim2.fromOffset(0, v166);
                v178.BackgroundTransparency = 1;
                v178.BorderSizePixel = 0;
                v178.ZIndex = u164.ZIndex + 5;
                v178.LayoutOrder = u164.ZIndex + 5;
                v178.AutomaticSize = Enum.AutomaticSize.X;
                u2.applyTextStyle(v178);
                v178.Parent = v165;
                return v165;
            end,
            Update = function(p179) --[[ Name: Update, Line 1118 ]]
                -- upvalues: u160 (copy), u161 (copy), u22 (ref), u9 (ref), u21 (ref), u18 (ref), u19 (ref), u20 (ref), u1 (ref)
                local l__Instance__11 = p179.Instance;
                l__Instance__11.TextLabel.Text = p179.arguments.Text or `Slider {u160}`;
                if p179.arguments.Format and typeof(p179.arguments.Format) ~= "table" then
                    p179.arguments.Format = { p179.arguments.Format };
                else
                    local v180 = {};
                    for v181 = 1, u161 do
                        local v182 = u22[u160][v181];
                        if p179.arguments.Increment then
                            local v183 = u9(p179.arguments.Increment, v181, p179.arguments);
                            local v184 = -math.log10(v183 == 0 and 1 or v183);
                            local v185 = math.ceil(v184);
                            v182 = math.max(v182, v185, v182);
                        end;
                        if p179.arguments.Max then
                            local v186 = u9(p179.arguments.Max, v181, p179.arguments);
                            local v187 = -math.log10(v186 == 0 and 1 or v186);
                            local v188 = math.ceil(v187);
                            v182 = math.max(v182, v188, v182);
                        end;
                        if p179.arguments.Min then
                            local v189 = u9(p179.arguments.Min, v181, p179.arguments);
                            local v190 = -math.log10(v189 == 0 and 1 or v189);
                            local v191 = math.ceil(v190);
                            v182 = math.max(v182, v191, v182);
                        end;
                        if v182 > 0 then
                            v180[v181] = `%.{v182}f`;
                        else
                            v180[v181] = "%d";
                        end;
                    end;
                    p179.arguments.Format = v180;
                    p179.arguments.Prefix = u21[u160];
                end;
                for v192 = 1, u161 do
                    local v193 = l__Instance__11:FindFirstChild("SliderField" .. tostring(v192));
                    local l__GrabBar__12 = v193.GrabBar;
                    local v194 = p179.arguments.Increment and u9(p179.arguments.Increment, v192, p179.arguments) or u18[u160][v192];
                    local v195 = p179.arguments.Min and u9(p179.arguments.Min, v192, p179.arguments) or u19[u160][v192];
                    local v196 = p179.arguments.Max and u9(p179.arguments.Max, v192, p179.arguments) or u20[u160][v192];
                    local v197 = 1 / math.floor((v196 + 1 - v195) / v194);
                    local v198 = math.max(v197, u1._config.GrabMinSize / v193.AbsoluteSize.X);
                    l__GrabBar__12.Size = UDim2.new(v198, 0, 1, 0);
                end;
            end,
            Discard = function(p199) --[[ Name: Discard, Line 1176 ]]
                -- upvalues: u2 (ref)
                p199.Instance:Destroy();
                u2.discardState(p199);
            end,
            GenerateState = function(p200) --[[ Name: GenerateState, Line 1180 ]]
                -- upvalues: u1 (ref), u162 (copy)
                if p200.state.number == nil then
                    p200.state.number = u1._widgetState(p200, "number", u162);
                end;
                if p200.state.editingText == nil then
                    p200.state.editingText = u1._widgetState(p200, "editingText", false);
                end;
            end,
            UpdateState = function(p201) --[[ Name: UpdateState, Line 1188 ]]
                -- upvalues: u161 (copy), u9 (ref), u18 (ref), u160 (copy), u19 (ref), u20 (ref), u1 (ref)
                local l__Instance__13 = p201.Instance;
                for v202 = 1, u161 do
                    local v203 = l__Instance__13:FindFirstChild("SliderField" .. tostring(v202));
                    local l__InputField__14 = v203.InputField;
                    local l__OverlayText__15 = v203.OverlayText;
                    local l__GrabBar__16 = v203.GrabBar;
                    local v204 = u9(p201.state.number.value, v202, p201.arguments);
                    local v205 = p201.arguments.Format[v202] or p201.arguments.Format[1];
                    if p201.arguments.Prefix then
                        v205 = p201.arguments.Prefix[v202] .. v205;
                    end;
                    l__OverlayText__15.Text = string.format(v205, v204);
                    l__InputField__14.Text = tostring(v204);
                    local v206 = p201.arguments.Increment and u9(p201.arguments.Increment, v202, p201.arguments) or u18[u160][v202];
                    local v207 = p201.arguments.Min and u9(p201.arguments.Min, v202, p201.arguments) or u19[u160][v202];
                    local v208 = p201.arguments.Max and u9(p201.arguments.Max, v202, p201.arguments) or u20[u160][v202];
                    local l__X__17 = u1._config.FramePadding.X;
                    local v209 = math.floor(((v206 < 1 and 0 or 1) + v208 - v207) / v206);
                    local v210 = (v204 - v207) / (v208 - v207);
                    local v211 = 1 - l__GrabBar__16.AbsoluteSize.X / (v203.AbsoluteSize.X - l__X__17 * 2);
                    local v212 = math.floor(v210 * v209) / v209;
                    local v213 = math.clamp(v212, 0, v211);
                    l__GrabBar__16.Position = UDim2.new(v213, 0, 0.5, 0);
                    if p201.state.editingText.value == v202 then
                        l__InputField__14.Visible = true;
                        l__OverlayText__15.Visible = false;
                        l__GrabBar__16.Visible = false;
                        l__InputField__14:CaptureFocus();
                    else
                        l__InputField__14.Visible = false;
                        l__OverlayText__15.Visible = true;
                        l__GrabBar__16.Visible = true;
                    end;
                end;
            end
        };
    end;
    local v215 = v73("Num", 1, 0);
    v215.Args.NoButtons = 6;
    u1.WidgetConstructor("InputNum", v215);
    u1.WidgetConstructor("InputVector2", v73("Vector2", 2, Vector2.zero));
    u1.WidgetConstructor("InputVector3", v73("Vector3", 3, Vector3.new(0, 0, 0)));
    u1.WidgetConstructor("InputUDim", v73("UDim", 2, UDim.new()));
    u1.WidgetConstructor("InputUDim2", v73("UDim2", 4, UDim2.new()));
    u1.WidgetConstructor("InputRect", v73("Rect", 4, Rect.new(0, 0, 0, 0)));
    u1.WidgetConstructor("DragNum", u135("Num", 1, 0));
    u1.WidgetConstructor("DragVector2", u135("Vector2", 2, Vector2.zero));
    u1.WidgetConstructor("DragVector3", u135("Vector3", 3, Vector3.new(0, 0, 0)));
    u1.WidgetConstructor("DragUDim", u135("UDim", 2, UDim.new()));
    u1.WidgetConstructor("DragUDim2", u135("UDim2", 4, UDim2.new()));
    u1.WidgetConstructor("DragRect", u135("Rect", 4, Rect.new(0, 0, 0, 0)));
    u1.WidgetConstructor("InputColor3", v141("Color3", Color3.fromRGB(0, 0, 0)));
    u1.WidgetConstructor("InputColor4", v141("Color4", Color3.fromRGB(0, 0, 0), 0));
    u1.WidgetConstructor("SliderNum", v214("Num", 1, 0));
    u1.WidgetConstructor("SliderVector2", v214("Vector2", 2, Vector2.zero));
    u1.WidgetConstructor("SliderVector3", v214("Vector3", 3, Vector3.new(0, 0, 0)));
    u1.WidgetConstructor("SliderUDim", v214("UDim", 2, UDim.new()));
    u1.WidgetConstructor("SliderUDim2", v214("UDim2", 4, UDim2.new()));
    u1.WidgetConstructor("SliderRect", v214("Rect", 4, Rect.new(0, 0, 0, 0)));
    u1.WidgetConstructor("InputText", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            TextHint = 2
        },
        Events = {
            textChanged = {
                Init = function(p216) --[[ Line: 1319 ]]
                    p216.lastTextchangeTick = 0;
                end,
                Get = function(p217) --[[ Line: 1322 ]]
                    -- upvalues: u1 (copy)
                    return p217.lastTextchangeTick == u1._cycleTick;
                end
            },
            hovered = u2.EVENTS.hover(function(p218) --[[ Line: 1326 ]]
                return p218.Instance;
            end)
        },
        Generate = function(u219) --[[ Name: Generate, Line 1330 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v220 = Instance.new("Frame");
            v220.Name = "Iris_InputText";
            v220.Size = UDim2.new(u1._config.ContentWidth, UDim.new(0, 0));
            v220.BackgroundTransparency = 1;
            v220.BorderSizePixel = 0;
            v220.ZIndex = u219.ZIndex;
            v220.LayoutOrder = u219.ZIndex;
            v220.AutomaticSize = Enum.AutomaticSize.Y;
            u2.UIListLayout(v220, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X));
            local u221 = Instance.new("TextBox");
            u221.Name = "InputField";
            u221.Size = UDim2.new(1, 0, 0, 0);
            u221.AutomaticSize = Enum.AutomaticSize.Y;
            u221.BackgroundColor3 = u1._config.FrameBgColor;
            u221.BackgroundTransparency = u1._config.FrameBgTransparency;
            u221.Text = "";
            u221.PlaceholderColor3 = u1._config.TextDisabledColor;
            u221.TextTruncate = Enum.TextTruncate.AtEnd;
            u221.ClearTextOnFocus = false;
            u221.ZIndex = u219.ZIndex + 1;
            u221.LayoutOrder = u219.ZIndex + 1;
            u221.ClipsDescendants = true;
            u2.applyFrameStyle(u221);
            u2.applyTextStyle(u221);
            u2.UISizeConstraint(u221, Vector2.new(1, 0));
            u221.Parent = v220;
            u221.FocusLost:Connect(function() --[[ Line: 1362 ]]
                -- upvalues: u219 (copy), u221 (copy), u1 (ref)
                u219.state.text:set(u221.Text);
                u219.lastTextchangeTick = u1._cycleTick + 1;
            end);
            local v222 = u1._config.TextSize + u1._config.FramePadding.Y * 2;
            local v223 = Instance.new("TextLabel");
            v223.Name = "TextLabel";
            v223.Size = UDim2.fromOffset(0, v222);
            v223.AutomaticSize = Enum.AutomaticSize.X;
            v223.BackgroundTransparency = 1;
            v223.BorderSizePixel = 0;
            v223.ZIndex = u219.ZIndex + 4;
            v223.LayoutOrder = u219.ZIndex + 4;
            u2.applyTextStyle(v223);
            v223.Parent = v220;
            return v220;
        end,
        Update = function(p224) --[[ Name: Update, Line 1384 ]]
            local l__Instance__18 = p224.Instance;
            local l__TextLabel__19 = l__Instance__18.TextLabel;
            local l__InputField__20 = l__Instance__18.InputField;
            l__TextLabel__19.Text = p224.arguments.Text or "Input Text";
            l__InputField__20.PlaceholderText = p224.arguments.TextHint or "";
        end,
        Discard = function(p225) --[[ Name: Discard, Line 1392 ]]
            -- upvalues: u2 (copy)
            p225.Instance:Destroy();
            u2.discardState(p225);
        end,
        GenerateState = function(p226) --[[ Name: GenerateState, Line 1396 ]]
            -- upvalues: u1 (copy)
            if p226.state.text == nil then
                p226.state.text = u1._widgetState(p226, "text", "");
            end;
        end,
        UpdateState = function(p227) --[[ Name: UpdateState, Line 1401 ]]
            p227.Instance.InputField.Text = p227.state.text.value;
        end
    });
end;
