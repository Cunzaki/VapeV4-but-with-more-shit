-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.Table
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    local u3 = {};
    table.insert(u1._postCycleCallbacks, function() --[[ Line: 7 ]]
        -- upvalues: u3 (copy)
        for _, v4 in u3 do
            v4.RowColumnIndex = 0;
        end;
    end);
    u1.WidgetConstructor("Table", {
        hasState = false,
        hasChildren = true,
        Args = {
            NumColumns = 1,
            RowBg = 2,
            BordersOuter = 3,
            BordersInner = 4
        },
        Events = {
            hovered = u2.EVENTS.hover(function(p5) --[[ Line: 23 ]]
                return p5.Instance;
            end)
        },
        Generate = function(p6) --[[ Name: Generate, Line 27 ]]
            -- upvalues: u3 (copy), u1 (copy), u2 (copy)
            u3[p6.ID] = p6;
            p6.InitialNumColumns = -1;
            p6.RowColumnIndex = 0;
            p6.ColumnInstances = {};
            p6.CellInstances = {};
            local v7 = Instance.new("Frame");
            v7.Name = "Iris_Table";
            v7.Size = UDim2.new(u1._config.ItemWidth, UDim.new(0, 0));
            v7.AutomaticSize = Enum.AutomaticSize.Y;
            v7.BackgroundTransparency = 1;
            v7.BorderSizePixel = 0;
            v7.ZIndex = p6.ZIndex + 1024;
            v7.LayoutOrder = p6.ZIndex;
            v7.ClipsDescendants = true;
            u2.UIListLayout(v7, Enum.FillDirection.Horizontal, UDim.new(0, 0));
            u2.UIStroke(v7, 1, u1._config.TableBorderStrongColor, u1._config.TableBorderStrongTransparency);
            return v7;
        end,
        Update = function(p8) --[[ Name: Update, Line 51 ]]
            -- upvalues: u2 (copy), u1 (copy)
            local l__Instance__1 = p8.Instance;
            if p8.arguments.BordersOuter == false then
                l__Instance__1.UIStroke.Thickness = 0;
            else
                l__Instance__1.UIStroke.Thickness = 1;
            end;
            if p8.InitialNumColumns == -1 then
                if p8.arguments.NumColumns == nil then
                    error("Iris.Table NumColumns argument is required", 5);
                end;
                p8.InitialNumColumns = p8.arguments.NumColumns;
                for v9 = 1, p8.InitialNumColumns do
                    local v10 = p8.ZIndex + 1 + v9;
                    local v11 = Instance.new("Frame");
                    v11.Name = `Column_{v9}`;
                    v11.Size = UDim2.new(1 / p8.InitialNumColumns, 0, 0, 0);
                    v11.AutomaticSize = Enum.AutomaticSize.Y;
                    v11.BackgroundTransparency = 1;
                    v11.BorderSizePixel = 0;
                    v11.ZIndex = v10;
                    v11.LayoutOrder = v10;
                    v11.ClipsDescendants = true;
                    u2.UIListLayout(v11, Enum.FillDirection.Vertical, UDim.new(0, 0));
                    p8.ColumnInstances[v9] = v11;
                    v11.Parent = l__Instance__1;
                end;
            elseif p8.arguments.NumColumns ~= p8.InitialNumColumns then
                error("Iris.Table NumColumns Argument must be static");
            end;
            if p8.arguments.RowBg == false then
                for _, v12 in p8.CellInstances do
                    v12.BackgroundTransparency = 1;
                end;
            else
                for v13, v14 in p8.CellInstances do
                    local v15;
                    if math.ceil(v13 / p8.InitialNumColumns) % 2 == 0 then
                        v15 = u1._config.TableRowBgAltTransparency;
                    else
                        v15 = u1._config.TableRowBgTransparency;
                    end;
                    v14.BackgroundTransparency = v15;
                end;
            end;
            if p8.arguments.BordersInner == false then
                for _, v16 in p8.CellInstances do
                    v16.UIStroke.Thickness = 0;
                end;
            else
                for _, v17 in p8.CellInstances do
                    v17.UIStroke.Thickness = 0.5;
                end;
            end;
        end,
        Discard = function(p18) --[[ Name: Discard, Line 113 ]]
            -- upvalues: u3 (copy)
            u3[p18.ID] = nil;
            p18.Instance:Destroy();
        end,
        ChildAdded = function(p19) --[[ Name: ChildAdded, Line 117 ]]
            -- upvalues: u2 (copy), u1 (copy)
            if p19.RowColumnIndex == 0 then
                p19.RowColumnIndex = 1;
            end;
            local v20 = p19.CellInstances[p19.RowColumnIndex];
            if v20 then
                return v20;
            end;
            local v21 = p19.ColumnInstances[(p19.RowColumnIndex - 1) % p19.InitialNumColumns + 1];
            local v22 = v21.ZIndex + p19.RowColumnIndex;
            local v23 = Instance.new("Frame");
            v23.Name = `Cell_{p19.RowColumnIndex}`;
            v23.Size = UDim2.new(1, 0, 0, 0);
            v23.AutomaticSize = Enum.AutomaticSize.Y;
            v23.BackgroundTransparency = 1;
            v23.BorderSizePixel = 0;
            v23.ZIndex = v22;
            v23.LayoutOrder = v22;
            v23.ClipsDescendants = true;
            u2.UIPadding(v23, u1._config.CellPadding);
            u2.UIListLayout(v23, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.Y));
            if p19.arguments.BordersInner == false then
                u2.UIStroke(v23, 0, u1._config.TableBorderLightColor, u1._config.TableBorderLightTransparency);
            else
                u2.UIStroke(v23, 0.5, u1._config.TableBorderLightColor, u1._config.TableBorderLightTransparency);
            end;
            if p19.arguments.RowBg ~= false then
                local v24 = math.ceil(p19.RowColumnIndex / p19.InitialNumColumns);
                local v25;
                if v24 % 2 == 0 then
                    v25 = u1._config.TableRowBgAltColor;
                else
                    v25 = u1._config.TableRowBgColor;
                end;
                local v26;
                if v24 % 2 == 0 then
                    v26 = u1._config.TableRowBgAltTransparency;
                else
                    v26 = u1._config.TableRowBgTransparency;
                end;
                v23.BackgroundColor3 = v25;
                v23.BackgroundTransparency = v26;
            end;
            p19.CellInstances[p19.RowColumnIndex] = v23;
            v23.Parent = v21;
            return v23;
        end
    });
end;
