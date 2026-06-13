-- Decompiled from: ReplicatedStorage.Modules.Dropdown
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    MaxItems = 5,
    Dropdowns = {}
};
function u1.DisableAllDropdowns() --[[ Line: 6 ]]
    -- upvalues: u1 (copy)
    for _, v2 in ipairs(u1.Dropdowns) do
        v2.SetDropState(false);
    end;
end;
function u1.SetupDropbox(u3, p4) --[[ Line: 12 ]]
    -- upvalues: u1 (copy)
    local u5 = {
        Selected = 0,
        SelectedText = "",
        Dropped = false,
        HideTarget = false,
        ListItems = p4 or {
            "none",
            "market",
            "diamonds",
            "diamonds",
            "last"
        },
        Switched = function() --[[ Name: Switched, Line 21 ]] end,
        UIItems = {}
    };
    local l__Parent__1 = u3.Parent;
    u5.TargetContainer = u3.DropdownContainer;
    if #u5.ListItems > u1.MaxItems then
        local v6 = script.SubContainer:Clone();
        v6.Parent = u5.TargetContainer;
        v6.CanvasSize = UDim2.fromScale(0, #u5.ListItems * 0.21052631578947367);
        u5.HideTarget = true;
        u5.TargetContainer = v6;
    end;
    function u5.Default() --[[ Line: 41 ]]
        -- upvalues: u5 (copy)
        u5.SelectListItem(1);
    end;
    function u5.SelectListItem(p7) --[[ Line: 45 ]]
        -- upvalues: u5 (copy), u3 (copy)
        u5.Selected = p7;
        local v8 = u5.ListItems[u5.Selected];
        u5.SelectedText = v8;
        u3.DropdownName.Text = v8;
        u5.Switched();
    end;
    function u5.SetDropState(p9) --[[ Line: 55 ]]
        -- upvalues: u5 (copy), l__Parent__1 (copy), u3 (copy)
        u5.Dropped = p9;
        if u5.Dropped then
            l__Parent__1.ZIndex = 6;
            u3.DropdownContainer.ZIndex = 0;
            u5.SetVisibility(true);
            u3.DropdownButton.Icon.Rotation = 270;
        else
            l__Parent__1.ZIndex = 1;
            u3.DropdownContainer.ZIndex = -1;
            u5.SetVisibility(false);
            u3.DropdownButton.Icon.Rotation = 90;
        end;
    end;
    function u5.SetVisibility(p10) --[[ Line: 72 ]]
        -- upvalues: u5 (copy)
        for _, v11 in ipairs(u5.UIItems) do
            v11.Visible = p10;
        end;
        if u5.HideTarget then
            u5.TargetContainer.Visible = p10;
        end;
    end;
    function u5.CreateItems() --[[ Line: 81 ]]
        -- upvalues: u5 (copy)
        for u12, v13 in ipairs(u5.ListItems) do
            local v14 = script.Item:Clone();
            v14.Visible = false;
            v14.Container.Title.Text = v13;
            v14.Parent = u5.TargetContainer;
            v14.Container.MouseButton1Down:Connect(function() --[[ Line: 89 ]]
                -- upvalues: u5 (ref), u12 (copy)
                u5.SelectListItem(u12);
                u5.SetDropState(false);
            end);
            table.insert(u5.UIItems, v14);
        end;
    end;
    u3.DropdownButton.MouseButton1Down:Connect(function() --[[ Line: 98 ]]
        -- upvalues: u5 (copy), u1 (ref)
        if u5.Dropped then
            u5.SetDropState(not u5.Dropped);
        else
            u1.DisableAllDropdowns();
            u5.SetDropState(true);
        end;
    end);
    table.insert(u1.Dropdowns, u5);
    u5.SetVisibility(false);
    u5.SelectListItem(1);
    u5.CreateItems();
    return u5;
end;
return u1;
