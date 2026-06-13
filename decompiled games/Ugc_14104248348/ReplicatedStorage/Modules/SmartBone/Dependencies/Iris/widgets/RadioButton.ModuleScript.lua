-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.RadioButton
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    u1.WidgetConstructor("RadioButton", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            Index = 2
        },
        Events = {
            selected = {
                Init = function(_) --[[ Line: 13 ]] end,
                Get = function(p3) --[[ Line: 14 ]]
                    -- upvalues: u1 (copy)
                    return p3.lastSelectedTick == u1._cycleTick;
                end
            },
            unselected = {
                Init = function(_) --[[ Line: 19 ]] end,
                Get = function(p4) --[[ Line: 20 ]]
                    -- upvalues: u1 (copy)
                    return p4.lastUnselectedTick == u1._cycleTick;
                end
            },
            active = {
                Init = function(_) --[[ Line: 25 ]] end,
                Get = function(p5) --[[ Line: 26 ]]
                    return p5.state.index.value == p5.arguments.Index;
                end
            },
            hovered = u2.EVENTS.hover(function(p6) --[[ Line: 30 ]]
                return p6.Instance;
            end)
        },
        Generate = function(u7) --[[ Name: Generate, Line 34 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v8 = Instance.new("TextButton");
            v8.Name = "Iris_RadioButton";
            v8.BackgroundTransparency = 1;
            v8.BorderSizePixel = 0;
            v8.Size = UDim2.fromOffset(0, 0);
            v8.Text = "";
            v8.AutomaticSize = Enum.AutomaticSize.XY;
            v8.ZIndex = u7.ZIndex;
            v8.AutoButtonColor = false;
            v8.LayoutOrder = u7.ZIndex;
            local v9 = u1._config.TextSize + 2 * (u1._config.FramePadding.Y - 1);
            local v10 = Instance.new("Frame");
            v10.Name = "Button";
            v10.Size = UDim2.fromOffset(v9, v9);
            v10.ZIndex = u7.ZIndex + 1;
            v10.LayoutOrder = u7.ZIndex + 1;
            v10.Parent = v8;
            v10.BackgroundColor3 = u1._config.FrameBgColor;
            v10.BackgroundTransparency = u1._config.FrameBgTransparency;
            u2.UICorner(v10);
            local v11 = Instance.new("Frame");
            v11.Name = "Circle";
            v11.Position = UDim2.fromOffset(u1._config.FramePadding.Y, u1._config.FramePadding.Y);
            v11.Size = UDim2.fromOffset(u1._config.TextSize - 2, u1._config.TextSize - 2);
            v11.ZIndex = u7.ZIndex + 1;
            v11.LayoutOrder = u7.ZIndex + 1;
            v11.Parent = v10;
            v11.BackgroundColor3 = u1._config.CheckMarkColor;
            v11.BackgroundTransparency = u1._config.CheckMarkTransparency;
            u2.UICorner(v11);
            u2.applyInteractionHighlights(v8, v10, {
                ButtonColor = u1._config.FrameBgColor,
                ButtonTransparency = u1._config.FrameBgTransparency,
                ButtonHoveredColor = u1._config.FrameBgHoveredColor,
                ButtonHoveredTransparency = u1._config.FrameBgHoveredTransparency,
                ButtonActiveColor = u1._config.FrameBgActiveColor,
                ButtonActiveTransparency = u1._config.FrameBgActiveTransparency
            });
            v8.MouseButton1Click:Connect(function() --[[ Line: 78 ]]
                -- upvalues: u7 (copy)
                u7.state.index:set(u7.arguments.Index);
            end);
            local v12 = Instance.new("TextLabel");
            v12.Name = "TextLabel";
            u2.applyTextStyle(v12);
            v12.Position = UDim2.new(0, v9 + u1._config.ItemInnerSpacing.X, 0.5, 0);
            v12.ZIndex = u7.ZIndex + 1;
            v12.LayoutOrder = u7.ZIndex + 1;
            v12.AutomaticSize = Enum.AutomaticSize.XY;
            v12.AnchorPoint = Vector2.new(0, 0.5);
            v12.BackgroundTransparency = 1;
            v12.BorderSizePixel = 0;
            v12.Parent = v8;
            return v8;
        end,
        Update = function(p13) --[[ Name: Update, Line 96 ]]
            -- upvalues: u1 (copy)
            p13.Instance.TextLabel.Text = p13.arguments.Text or "Radio Button";
            if p13.state then
                u1._widgets[p13.type].UpdateState(p13);
            end;
        end,
        Discard = function(p14) --[[ Name: Discard, Line 105 ]]
            -- upvalues: u2 (copy)
            p14.Instance:Destroy();
            u2.discardState(p14);
        end,
        GenerateState = function(p15) --[[ Name: GenerateState, Line 109 ]]
            -- upvalues: u1 (copy)
            if p15.state.index == nil then
                p15.state.index = u1._widgetState(p15, "index", p15.arguments.Value);
            end;
        end,
        UpdateState = function(p16) --[[ Name: UpdateState, Line 114 ]]
            -- upvalues: u1 (copy)
            local l__Circle__1 = p16.Instance.Button.Circle;
            if p16.state.index.value == p16.arguments.Index then
                l__Circle__1.BackgroundTransparency = u1._config.CheckMarkTransparency;
                p16.lastSelectedTick = u1._cycleTick + 1;
            else
                l__Circle__1.BackgroundTransparency = 1;
                p16.lastUnselectedTick = u1._cycleTick + 1;
            end;
        end
    });
end;
