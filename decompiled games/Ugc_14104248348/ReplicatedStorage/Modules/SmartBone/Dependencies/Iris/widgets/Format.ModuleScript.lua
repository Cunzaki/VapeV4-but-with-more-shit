-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.Format
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    u1.WidgetConstructor("Separator", {
        hasState = false,
        hasChildren = false,
        Args = {},
        Events = {},
        Generate = function(p3) --[[ Name: Generate, Line 9 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v4 = Instance.new("Frame");
            v4.Name = "Iris_Separator";
            v4.BackgroundColor3 = u1._config.SeparatorColor;
            v4.BackgroundTransparency = u1._config.SeparatorTransparency;
            v4.BorderSizePixel = 0;
            if p3.parentWidget.type == "SameLine" then
                v4.Size = UDim2.new(0, 1, 1, 0);
            else
                v4.Size = UDim2.new(1, 0, 0, 1);
            end;
            v4.ZIndex = p3.ZIndex;
            v4.LayoutOrder = p3.ZIndex;
            u2.UIListLayout(v4, Enum.FillDirection.Vertical, UDim.new(0, 0));
            return v4;
        end,
        Update = function(_) --[[ Name: Update, Line 28 ]] end,
        Discard = function(p5) --[[ Name: Discard, Line 29 ]]
            p5.Instance:Destroy();
        end
    });
    u1.WidgetConstructor("Indent", {
        hasState = false,
        hasChildren = true,
        Args = {
            Width = 1
        },
        Events = {},
        Generate = function(p6) --[[ Name: Generate, Line 41 ]]
            -- upvalues: u2 (copy), u1 (copy)
            local v7 = Instance.new("Frame");
            v7.Name = "Iris_Indent";
            v7.BackgroundTransparency = 1;
            v7.BorderSizePixel = 0;
            v7.Size = UDim2.fromScale(1, 0);
            v7.AutomaticSize = Enum.AutomaticSize.Y;
            v7.ZIndex = p6.ZIndex;
            v7.LayoutOrder = p6.ZIndex;
            u2.UIListLayout(v7, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.Y));
            u2.UIPadding(v7, Vector2.new(0, 0));
            return v7;
        end,
        Update = function(p8) --[[ Name: Update, Line 56 ]]
            -- upvalues: u1 (copy)
            local l__Instance__1 = p8.Instance;
            local v9;
            if p8.arguments.Width then
                v9 = p8.arguments.Width;
            else
                v9 = u1._config.IndentSpacing;
            end;
            l__Instance__1.UIPadding.PaddingLeft = UDim.new(0, v9);
        end,
        Discard = function(p10) --[[ Name: Discard, Line 67 ]]
            p10.Instance:Destroy();
        end,
        ChildAdded = function(p11, _) --[[ Name: ChildAdded, Line 70 ]]
            return p11.Instance;
        end
    });
    u1.WidgetConstructor("SameLine", {
        hasState = false,
        hasChildren = true,
        Args = {
            Width = 1,
            VerticalAlignment = 2
        },
        Events = {},
        Generate = function(p12) --[[ Name: Generate, Line 83 ]]
            -- upvalues: u2 (copy)
            local v13 = Instance.new("Frame");
            v13.Name = "Iris_SameLine";
            v13.BackgroundTransparency = 1;
            v13.BorderSizePixel = 0;
            v13.Size = UDim2.fromScale(1, 0);
            v13.AutomaticSize = Enum.AutomaticSize.Y;
            v13.ZIndex = p12.ZIndex;
            v13.LayoutOrder = p12.ZIndex;
            u2.UIListLayout(v13, Enum.FillDirection.Horizontal, UDim.new(0, 0));
            return v13;
        end,
        Update = function(p14) --[[ Name: Update, Line 97 ]]
            -- upvalues: u1 (copy)
            local l__UIListLayout__2 = p14.Instance.UIListLayout;
            local v15;
            if p14.arguments.Width then
                v15 = p14.arguments.Width;
            else
                v15 = u1._config.ItemSpacing.X;
            end;
            l__UIListLayout__2.Padding = UDim.new(0, v15);
            if p14.arguments.VerticalAlignment then
                l__UIListLayout__2.VerticalAlignment = p14.arguments.VerticalAlignment;
            else
                l__UIListLayout__2.VerticalAlignment = Enum.VerticalAlignment.Center;
            end;
        end,
        Discard = function(p16) --[[ Name: Discard, Line 113 ]]
            p16.Instance:Destroy();
        end,
        ChildAdded = function(p17, _) --[[ Name: ChildAdded, Line 116 ]]
            return p17.Instance;
        end
    });
    u1.WidgetConstructor("Group", {
        hasState = false,
        hasChildren = true,
        Args = {},
        Events = {},
        Generate = function(p18) --[[ Name: Generate, Line 126 ]]
            -- upvalues: u2 (copy), u1 (copy)
            local v19 = Instance.new("Frame");
            v19.Name = "Iris_Group";
            v19.BackgroundTransparency = 1;
            v19.BorderSizePixel = 0;
            v19.Size = UDim2.fromOffset(0, 0);
            v19.AutomaticSize = Enum.AutomaticSize.XY;
            v19.ZIndex = p18.ZIndex;
            v19.LayoutOrder = p18.ZIndex;
            v19.ClipsDescendants = true;
            u2.UIListLayout(v19, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.X));
            return v19;
        end,
        Update = function(_) --[[ Name: Update, Line 141 ]] end,
        Discard = function(p20) --[[ Name: Discard, Line 142 ]]
            p20.Instance:Destroy();
        end,
        ChildAdded = function(p21, _) --[[ Name: ChildAdded, Line 145 ]]
            return p21.Instance;
        end
    });
end;
