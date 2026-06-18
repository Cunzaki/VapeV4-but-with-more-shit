-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.Iris.widgets.Text
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

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
            hovered = u2.EVENTS.hover(function(p3) --[[ Line: 15 ]]
                return p3.Instance;
            end
        },
        Generate = function(_) --[[ Name: Generate, Line 19 ]]
            -- upvalues: u2 (copy)
            local v4 = Instance.new("TextLabel");
            v4.Name = "Iris_Text";
            v4.AutomaticSize = Enum.AutomaticSize.XY;
            v4.Size = UDim2.fromOffset(0, 0);
            v4.BackgroundTransparency = 1;
            v4.BorderSizePixel = 0;
            u2.applyTextStyle(v4);
            u2.UIPadding(v4, Vector2.new(0, 2));
            return v4;
        end,
        Update = function(p5) --[[ Name: Update, Line 32 ]]
            -- upvalues: u1 (copy)
            local l__Instance__1 = p5.Instance;
            if p5.arguments.Text == nil then
                error("Text argument is required for Iris.Text().", 5);
            end;
            if p5.arguments.Wrapped == nil then
                l__Instance__1.TextWrapped = u1._config.TextWrapped;
            else
                l__Instance__1.TextWrapped = p5.arguments.Wrapped;
            end;
            if p5.arguments.Color then
                l__Instance__1.TextColor3 = p5.arguments.Color;
            else
                l__Instance__1.TextColor3 = u1._config.TextColor;
            end;
            if p5.arguments.RichText == nil then
                l__Instance__1.RichText = u1._config.RichText;
            else
                l__Instance__1.RichText = p5.arguments.RichText;
            end;
            l__Instance__1.Text = p5.arguments.Text;
        end,
        Discard = function(p6) --[[ Name: Discard, Line 55 ]]
            p6.Instance:Destroy();
        end
    });
    u1.WidgetConstructor("SelectableText", {
        hasState = false,
        hasChildren = false,
        Args = {
            Text = 1,
            Wrapped = 2,
            Color = 3,
            RichText = 4
        },
        Events = {
            hovered = u2.EVENTS.hover(function(p7) --[[ Line: 71 ]]
                return p7.Instance;
            end
        },
        Generate = function(_) --[[ Name: Generate, Line 75 ]]
            -- upvalues: u2 (copy)
            local v8 = Instance.new("TextBox");
            v8.Name = "Iris_SelectableText";
            v8.AutomaticSize = Enum.AutomaticSize.XY;
            v8.Size = UDim2.fromOffset(0, 0);
            v8.BackgroundTransparency = 1;
            v8.BorderSizePixel = 0;
            v8.ClearTextOnFocus = false;
            v8.MultiLine = true;
            v8.TextEditable = false;
            v8.TextXAlignment = Enum.TextXAlignment.Left;
            v8.TextYAlignment = Enum.TextYAlignment.Top;
            u2.applyTextStyle(v8);
            u2.UIPadding(v8, Vector2.new(0, 2));
            return v8;
        end,
        Update = function(p9) --[[ Name: Update, Line 93 ]]
            -- upvalues: u1 (copy)
            local l__Instance__2 = p9.Instance;
            if p9.arguments.Text == nil then
                error("Text argument is required for Iris.SelectableText().", 5);
            end;
            if p9.arguments.Wrapped == nil then
                l__Instance__2.TextWrapped = u1._config.TextWrapped;
            else
                l__Instance__2.TextWrapped = p9.arguments.Wrapped;
            end;
            if p9.arguments.Color then
                l__Instance__2.TextColor3 = p9.arguments.Color;
            else
                l__Instance__2.TextColor3 = u1._config.TextColor;
            end;
            if p9.arguments.RichText == nil then
                l__Instance__2.RichText = u1._config.RichText;
            else
                l__Instance__2.RichText = p9.arguments.RichText;
            end;
            l__Instance__2.TextEditable = false;
            l__Instance__2.Text = p9.arguments.Text;
        end,
        Discard = function(p10) --[[ Name: Discard, Line 117 ]]
            p10.Instance:Destroy();
        end
    });
    u1.WidgetConstructor("SeparatorText", {
        hasState = false,
        hasChildren = false,
        Args = {
            Text = 1
        },
        Events = {
            hovered = u2.EVENTS.hover(function(p11) --[[ Line: 130 ]]
                return p11.Instance;
            end
        },
        Generate = function(_) --[[ Name: Generate, Line 134 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v12 = Instance.new("Frame");
            v12.Name = "Iris_SeparatorText";
            v12.AutomaticSize = Enum.AutomaticSize.Y;
            v12.Size = UDim2.new(u1._config.ItemWidth, UDim.new());
            v12.BackgroundTransparency = 1;
            v12.BorderSizePixel = 0;
            v12.ClipsDescendants = true;
            u2.UIPadding(v12, Vector2.new(0, u1._config.SeparatorTextPadding.Y));
            u2.UIListLayout(v12, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemSpacing.X));
            v12.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
            local v13 = Instance.new("TextLabel");
            v13.Name = "TextLabel";
            v13.AutomaticSize = Enum.AutomaticSize.XY;
            v13.BackgroundTransparency = 1;
            v13.BorderSizePixel = 0;
            v13.LayoutOrder = 1;
            u2.applyTextStyle(v13);
            v13.Parent = v12;
            local v14 = Instance.new("Frame");
            v14.Name = "Left";
            v14.AnchorPoint = Vector2.new(1, 0.5);
            v14.Size = UDim2.fromOffset(u1._config.SeparatorTextPadding.X - u1._config.ItemSpacing.X, u1._config.SeparatorTextBorderSize);
            v14.BackgroundColor3 = u1._config.SeparatorColor;
            v14.BackgroundTransparency = u1._config.SeparatorTransparency;
            v14.BorderSizePixel = 0;
            v14.Parent = v12;
            local v15 = Instance.new("Frame");
            v15.Name = "Right";
            v15.AnchorPoint = Vector2.new(1, 0.5);
            v15.Size = UDim2.new(1, 0, 0, u1._config.SeparatorTextBorderSize);
            v15.BackgroundColor3 = u1._config.SeparatorColor;
            v15.BackgroundTransparency = u1._config.SeparatorTransparency;
            v15.BorderSizePixel = 0;
            v15.LayoutOrder = 2;
            v15.Parent = v12;
            return v12;
        end,
        Update = function(p16) --[[ Name: Update, Line 182 ]]
            local l__TextLabel__3 = p16.Instance.TextLabel;
            if p16.arguments.Text == nil then
                error("Text argument is required for Iris.SeparatorText().", 5);
            end;
            l__TextLabel__3.Text = p16.arguments.Text;
        end,
        Discard = function(p17) --[[ Name: Discard, Line 190 ]]
            p17.Instance:Destroy();
        end
    });
end;
