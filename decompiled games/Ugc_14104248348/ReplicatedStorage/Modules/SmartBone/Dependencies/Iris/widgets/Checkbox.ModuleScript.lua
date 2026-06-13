-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.Checkbox
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    u1.WidgetConstructor("Checkbox", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1
        },
        Events = {
            checked = {
                Init = function(_) --[[ Line: 12 ]] end,
                Get = function(p3) --[[ Line: 13 ]]
                    -- upvalues: u1 (copy)
                    return p3.lastCheckedTick == u1._cycleTick;
                end
            },
            unchecked = {
                Init = function(_) --[[ Line: 18 ]] end,
                Get = function(p4) --[[ Line: 19 ]]
                    -- upvalues: u1 (copy)
                    return p4.lastUncheckedTick == u1._cycleTick;
                end
            },
            hovered = u2.EVENTS.hover(function(p5) --[[ Line: 23 ]]
                return p5.Instance;
            end)
        },
        Generate = function(u6) --[[ Name: Generate, Line 27 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v7 = Instance.new("TextButton");
            v7.Name = "Iris_Checkbox";
            v7.BackgroundTransparency = 1;
            v7.BorderSizePixel = 0;
            v7.Size = UDim2.fromOffset(0, 0);
            v7.Text = "";
            v7.AutomaticSize = Enum.AutomaticSize.XY;
            v7.ZIndex = u6.ZIndex;
            v7.AutoButtonColor = false;
            v7.LayoutOrder = u6.ZIndex;
            local v8 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
            local v9 = Instance.new("Frame");
            v9.Name = "CheckboxBox";
            v9.Size = UDim2.fromOffset(v8, v8);
            v9.BackgroundColor3 = u1._config.FrameBgColor;
            v9.BackgroundTransparency = u1._config.FrameBgTransparency;
            v9.ZIndex = u6.ZIndex + 1;
            v9.LayoutOrder = u6.ZIndex + 1;
            u2.applyFrameStyle(v9, true);
            u2.applyInteractionHighlights(v7, v9, {
                ButtonColor = u1._config.FrameBgColor,
                ButtonTransparency = u1._config.FrameBgTransparency,
                ButtonHoveredColor = u1._config.FrameBgHoveredColor,
                ButtonHoveredTransparency = u1._config.FrameBgHoveredTransparency,
                ButtonActiveColor = u1._config.FrameBgActiveColor,
                ButtonActiveTransparency = u1._config.FrameBgActiveTransparency
            });
            v9.Parent = v7;
            local v10 = math.ceil(v8 * 0.1);
            local v11 = v8 - v10 * 2;
            local v12 = Instance.new("ImageLabel");
            v12.Name = "Checkmark";
            v12.Size = UDim2.fromOffset(v11, v11);
            v12.Position = UDim2.fromOffset(v10, v10);
            v12.BackgroundTransparency = 1;
            v12.ImageColor3 = u1._config.CheckMarkColor;
            v12.ImageTransparency = u1._config.CheckMarkTransparency;
            v12.ScaleType = Enum.ScaleType.Fit;
            v12.ZIndex = u6.ZIndex + 2;
            v12.LayoutOrder = u6.ZIndex + 2;
            v12.Parent = v7;
            v7.MouseButton1Click:Connect(function() --[[ Line: 77 ]]
                -- upvalues: u6 (copy)
                u6.state.isChecked:set(not u6.state.isChecked.value);
            end);
            local v13 = Instance.new("TextLabel");
            v13.Name = "TextLabel";
            u2.applyTextStyle(v13);
            v13.AnchorPoint = Vector2.new(0, 0.5);
            v13.Position = UDim2.new(0, v8 + u1._config.ItemInnerSpacing.X, 0.5, 0);
            v13.ZIndex = u6.ZIndex + 1;
            v13.LayoutOrder = u6.ZIndex + 1;
            v13.AutomaticSize = Enum.AutomaticSize.XY;
            v13.BackgroundTransparency = 1;
            v13.BorderSizePixel = 0;
            v13.Parent = v7;
            return v7;
        end,
        Update = function(p14) --[[ Name: Update, Line 96 ]]
            p14.Instance.TextLabel.Text = p14.arguments.Text or "Checkbox";
        end,
        Discard = function(p15) --[[ Name: Discard, Line 100 ]]
            -- upvalues: u2 (copy)
            p15.Instance:Destroy();
            u2.discardState(p15);
        end,
        GenerateState = function(p16) --[[ Name: GenerateState, Line 104 ]]
            -- upvalues: u1 (copy)
            if p16.state.isChecked == nil then
                p16.state.isChecked = u1._widgetState(p16, "checked", false);
            end;
        end,
        UpdateState = function(p17) --[[ Name: UpdateState, Line 109 ]]
            -- upvalues: u2 (copy), u1 (copy)
            local l__Checkmark__1 = p17.Instance.Checkmark;
            if p17.state.isChecked.value then
                l__Checkmark__1.Image = u2.ICONS.CHECK_MARK;
                p17.lastCheckedTick = u1._cycleTick + 1;
            else
                l__Checkmark__1.Image = "";
                p17.lastUncheckedTick = u1._cycleTick + 1;
            end;
        end
    });
end;
