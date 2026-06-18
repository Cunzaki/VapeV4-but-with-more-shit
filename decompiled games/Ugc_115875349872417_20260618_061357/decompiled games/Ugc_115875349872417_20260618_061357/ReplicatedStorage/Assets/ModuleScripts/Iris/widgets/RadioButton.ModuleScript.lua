-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.Iris.widgets.RadioButton
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    u1.WidgetConstructor("RadioButton", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            Index = 2,
            Toggle = 3
        },
        Events = {
            clicked = u2.EVENTS.click(function(p3) --[[ Line: 14 ]]
                return p3.Instance;
            end),
            selected = {
                Init = function(_) --[[ Line: 18 ]] end,
                Get = function(p4) --[[ Line: 19 ]]
                    -- upvalues: u1 (copy)
                    return p4.lastSelectedTick == u1._cycleTick;
                end
            },
            unselected = {
                Init = function(_) --[[ Line: 24 ]] end,
                Get = function(p5) --[[ Line: 25 ]]
                    -- upvalues: u1 (copy)
                    return p5.lastUnselectedTick == u1._cycleTick;
                end
            },
            active = {
                Init = function(_) --[[ Line: 30 ]] end,
                Get = function(p6) --[[ Line: 31 ]]
                    return p6.state.index.value == p6.arguments.Index;
                end
            },
            hovered = u2.EVENTS.hover(function(p7) --[[ Line: 35 ]]
                return p7.Instance;
            end)
        },
        Generate = function(u8) --[[ Name: Generate, Line 39 ]]
            -- upvalues: u2 (copy), u1 (copy)
            local v9 = Instance.new("TextButton");
            v9.Name = "Iris_RadioButton";
            v9.AutomaticSize = Enum.AutomaticSize.XY;
            v9.Size = UDim2.fromOffset(0, 0);
            v9.BackgroundTransparency = 1;
            v9.BorderSizePixel = 0;
            v9.Text = "";
            v9.AutoButtonColor = false;
            u2.UIListLayout(v9, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            local v10 = u1._config.TextSize + 2 * (u1._config.FramePadding.Y - 1);
            local v11 = Instance.new("Frame");
            v11.Name = "Button";
            v11.Size = UDim2.fromOffset(v10, v10);
            v11.BackgroundColor3 = u1._config.FrameBgColor;
            v11.BackgroundTransparency = u1._config.FrameBgTransparency;
            v11.Parent = v9;
            u2.UICorner(v11);
            local l__UIPadding__1 = u2.UIPadding;
            local l__new__2 = Vector2.new;
            local v12 = math.floor(v10 / 5);
            local v13 = math.max(1, v12);
            local v14 = math.floor(v10 / 5);
            l__UIPadding__1(v11, l__new__2(v13, (math.max(1, v14))));
            local v15 = Instance.new("Frame");
            v15.Name = "Circle";
            v15.Size = UDim2.fromScale(1, 1);
            v15.BackgroundColor3 = u1._config.CheckMarkColor;
            v15.BackgroundTransparency = u1._config.CheckMarkTransparency;
            u2.UICorner(v15);
            v15.Parent = v11;
            u2.applyInteractionHighlights("Background", v9, v11, {
                Color = u1._config.FrameBgColor,
                Transparency = u1._config.FrameBgTransparency,
                HoveredColor = u1._config.FrameBgHoveredColor,
                HoveredTransparency = u1._config.FrameBgHoveredTransparency,
                ActiveColor = u1._config.FrameBgActiveColor,
                ActiveTransparency = u1._config.FrameBgActiveTransparency
            });
            u2.applyButtonClick(v9, function() --[[ Line: 80 ]]
                -- upvalues: u8 (copy)
                if u8.arguments.Toggle == true and type(u8.state.index.value) == "boolean" then
                    u8.state.index:set(not u8.state.index.value);
                else
                    u8.state.index:set(u8.arguments.Index);
                end;
            end);
            local v16 = Instance.new("TextLabel");
            v16.Name = "TextLabel";
            v16.AutomaticSize = Enum.AutomaticSize.XY;
            v16.BackgroundTransparency = 1;
            v16.BorderSizePixel = 0;
            v16.LayoutOrder = 1;
            u2.applyTextStyle(v16);
            v16.Parent = v9;
            return v9;
        end,
        Update = function(p17) --[[ Name: Update, Line 100 ]]
            -- upvalues: u1 (copy)
            p17.Instance.TextLabel.Text = p17.arguments.Text or "Radio Button";
            if p17.state then
                p17.state.index.lastChangeTick = u1._cycleTick;
                u1._widgets[p17.type].UpdateState(p17);
            end;
        end,
        Discard = function(p18) --[[ Name: Discard, Line 110 ]]
            -- upvalues: u2 (copy)
            p18.Instance:Destroy();
            u2.discardState(p18);
        end,
        GenerateState = function(p19) --[[ Name: GenerateState, Line 114 ]]
            -- upvalues: u1 (copy)
            if p19.state.index == nil then
                p19.state.index = u1._widgetState(p19, "index", p19.arguments.Index);
            end;
        end,
        UpdateState = function(p20) --[[ Name: UpdateState, Line 119 ]]
            -- upvalues: u1 (copy)
            local l__Circle__3 = p20.Instance.Button.Circle;
            if p20.state.index.value == p20.arguments.Index then
                l__Circle__3.BackgroundTransparency = u1._config.CheckMarkTransparency;
                p20.lastSelectedTick = u1._cycleTick + 1;
            else
                l__Circle__3.BackgroundTransparency = 1;
                p20.lastUnselectedTick = u1._cycleTick + 1;
            end;
        end
    });
end;
