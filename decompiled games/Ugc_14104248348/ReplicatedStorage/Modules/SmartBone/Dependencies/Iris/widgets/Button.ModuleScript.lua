-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.Button
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    local u12 = {
        hasState = false,
        hasChildren = false,
        Args = {
            Text = 1
        },
        Events = {
            clicked = u2.EVENTS.click(function(p3) --[[ Line: 11 ]]
                return p3.Instance;
            end),
            rightClicked = u2.EVENTS.rightClick(function(p4) --[[ Line: 14 ]]
                return p4.Instance;
            end),
            doubleClicked = u2.EVENTS.doubleClick(function(p5) --[[ Line: 17 ]]
                return p5.Instance;
            end),
            ctrlClicked = u2.EVENTS.ctrlClick(function(p6) --[[ Line: 20 ]]
                return p6.Instance;
            end),
            hovered = u2.EVENTS.hover(function(p7) --[[ Line: 23 ]]
                return p7.Instance;
            end)
        },
        Generate = function(p8) --[[ Name: Generate, Line 27 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v9 = Instance.new("TextButton");
            v9.Size = UDim2.fromOffset(0, 0);
            v9.BackgroundColor3 = u1._config.ButtonColor;
            v9.BackgroundTransparency = u1._config.ButtonTransparency;
            v9.AutoButtonColor = false;
            u2.applyTextStyle(v9);
            v9.AutomaticSize = Enum.AutomaticSize.XY;
            u2.applyFrameStyle(v9);
            u2.applyInteractionHighlights(v9, v9, {
                ButtonColor = u1._config.ButtonColor,
                ButtonTransparency = u1._config.ButtonTransparency,
                ButtonHoveredColor = u1._config.ButtonHoveredColor,
                ButtonHoveredTransparency = u1._config.ButtonHoveredTransparency,
                ButtonActiveColor = u1._config.ButtonActiveColor,
                ButtonActiveTransparency = u1._config.ButtonActiveTransparency
            });
            v9.ZIndex = p8.ZIndex;
            v9.LayoutOrder = p8.ZIndex;
            return v9;
        end,
        Update = function(p10) --[[ Name: Update, Line 53 ]]
            p10.Instance.Text = p10.arguments.Text or "Button";
        end,
        Discard = function(p11) --[[ Name: Discard, Line 57 ]]
            p11.Instance:Destroy();
        end
    };
    u2.abstractButton = u12;
    u1.WidgetConstructor("Button", u2.extend(u12, {
        Generate = function(p13) --[[ Name: Generate, Line 66 ]]
            -- upvalues: u12 (copy)
            local v14 = u12.Generate(p13);
            v14.Name = "Iris_Button";
            return v14;
        end
    }));
    u1.WidgetConstructor("SmallButton", u2.extend(u12, {
        Generate = function(p15) --[[ Name: Generate, Line 78 ]]
            -- upvalues: u12 (copy)
            local v16 = u12.Generate(p15);
            v16.Name = "Iris_SmallButton";
            local l__UIPadding__1 = v16.UIPadding;
            l__UIPadding__1.PaddingLeft = UDim.new(0, 2);
            l__UIPadding__1.PaddingRight = UDim.new(0, 2);
            l__UIPadding__1.PaddingTop = UDim.new(0, 0);
            l__UIPadding__1.PaddingBottom = UDim.new(0, 0);
            return v16;
        end
    }));
end;
