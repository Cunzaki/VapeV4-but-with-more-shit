-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.Text
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    u1.WidgetConstructor("Text", {
        hasState = false,
        hasChildren = false,
        Args = {
            Text = 1,
            Wrapped = 2,
            Color = 3,
            RichText = 4
        },
        Events = {
            hovered = u2.EVENTS.hover(function(p3) --[[ Line: 14 ]]
                return p3.Instance;
            end)
        },
        Generate = function(p4) --[[ Name: Generate, Line 18 ]]
            -- upvalues: u2 (copy)
            local v5 = Instance.new("TextLabel");
            v5.Name = "Iris_Text";
            v5.Size = UDim2.fromOffset(0, 0);
            v5.BackgroundTransparency = 1;
            v5.BorderSizePixel = 0;
            v5.ZIndex = p4.ZIndex;
            v5.LayoutOrder = p4.ZIndex;
            v5.AutomaticSize = Enum.AutomaticSize.XY;
            u2.applyTextStyle(v5);
            u2.UIPadding(v5, Vector2.new(0, 2));
            return v5;
        end,
        Update = function(p6) --[[ Name: Update, Line 33 ]]
            -- upvalues: u1 (copy)
            local l__Instance__1 = p6.Instance;
            if p6.arguments.Text == nil then
                error("Iris.Text Text Argument is required", 5);
            end;
            if p6.arguments.Wrapped then
                l__Instance__1.TextWrapped = true;
            else
                l__Instance__1.TextWrapped = false;
            end;
            if p6.arguments.Color then
                l__Instance__1.TextColor3 = p6.arguments.Color;
            else
                l__Instance__1.TextColor3 = u1._config.TextColor;
            end;
            if p6.arguments.RichText then
                l__Instance__1.RichText = true;
            else
                l__Instance__1.RichText = false;
            end;
            l__Instance__1.Text = p6.arguments.Text;
        end,
        Discard = function(p7) --[[ Name: Discard, Line 56 ]]
            p7.Instance:Destroy();
        end
    });
    u1.WidgetConstructor("SeparatorText", {
        hasState = false,
        hasChildren = false,
        Args = {
            Text = 1
        },
        Events = {
            hovered = u2.EVENTS.hover(function(p8) --[[ Line: 68 ]]
                return p8.Instance;
            end)
        },
        Generate = function(p9) --[[ Name: Generate, Line 72 ]]
            -- upvalues: u2 (copy), u1 (copy)
            local v10 = Instance.new("Frame");
            v10.Name = "Iris_SeparatorText";
            v10.Size = UDim2.fromScale(1, 0);
            v10.BackgroundTransparency = 1;
            v10.BorderSizePixel = 0;
            v10.AutomaticSize = Enum.AutomaticSize.Y;
            v10.ZIndex = p9.ZIndex;
            v10.LayoutOrder = p9.ZIndex;
            v10.ClipsDescendants = true;
            u2.UIPadding(v10, Vector2.new(0, u1._config.SeparatorTextPadding.Y));
            u2.UIListLayout(v10, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemSpacing.X));
            v10.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
            local v11 = Instance.new("TextLabel");
            v11.Name = "TextLabel";
            v11.BackgroundTransparency = 1;
            v11.BorderSizePixel = 0;
            v11.AutomaticSize = Enum.AutomaticSize.XY;
            v11.ZIndex = p9.ZIndex + 1;
            v11.LayoutOrder = p9.ZIndex + 1;
            u2.applyTextStyle(v11);
            v11.Parent = v10;
            local v12 = Instance.new("Frame");
            v12.Name = "Left";
            v12.AnchorPoint = Vector2.new(1, 0.5);
            v12.BackgroundColor3 = u1._config.SeparatorColor;
            v12.BackgroundTransparency = u1._config.SeparatorTransparency;
            v12.BorderSizePixel = 0;
            v12.Size = UDim2.fromOffset(u1._config.SeparatorTextPadding.X - u1._config.ItemSpacing.X, u1._config.SeparatorTextBorderSize);
            v12.ZIndex = p9.ZIndex;
            v12.LayoutOrder = p9.ZIndex;
            v12.Parent = v10;
            local v13 = Instance.new("Frame");
            v13.Name = "Right";
            v13.AnchorPoint = Vector2.new(1, 0.5);
            v13.BackgroundColor3 = u1._config.SeparatorColor;
            v13.BackgroundTransparency = u1._config.SeparatorTransparency;
            v13.BorderSizePixel = 0;
            v13.Size = UDim2.new(1, 0, 0, u1._config.SeparatorTextBorderSize);
            v13.ZIndex = p9.ZIndex + 2;
            v13.LayoutOrder = p9.ZIndex + 2;
            v13.Parent = v10;
            return v10;
        end,
        Update = function(p14) --[[ Name: Update, Line 126 ]]
            local l__TextLabel__2 = p14.Instance.TextLabel;
            if p14.arguments.Text == nil then
                error("Iris.Text Text Argument is required", 5);
            end;
            l__TextLabel__2.Text = p14.arguments.Text;
        end,
        Discard = function(p15) --[[ Name: Discard, Line 134 ]]
            p15.Instance:Destroy();
        end
    });
end;
