-- Decompiled from: Start.Client.Classes.MenuManager.Components.DropdownMenu
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
game:GetService("RunService");
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Signal__3 = require(l__ModuleScripts__2.Signal);
local l__Trove__4 = require(l__ModuleScripts__2.Trove);
local l__UIAssets__5 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local l__Classes__6 = require(script.Parent.Parent.Parent.Parent.ClientRoot).Classes;
local l__BaseComponent__7 = require(script.Parent.BaseComponent);
local u1 = {};
u1.__index = u1;
setmetatable(u1, l__BaseComponent__7);
local _ = game.Players.LocalPlayer;
local function u4(p2) --[[ Line: 37 ]]
    local v3 = p2 or {};
    return {
        inst = nil,
        _trove = nil,
        meta = v3.meta or {},
        relative_order = v3.relative_order or 0,
        text = v3.text or "Nil Option",
        preRender = v3.preRender,
        appear_new = v3.appear_new or false,
        appear_locked = v3.appear_locked or false,
        appear_classified = v3.appear_classified or false,
        tooltip = v3.tooltip
    };
end;
function u1.new(p5, p6, p7, p8) --[[ Line: 53 ]]
    -- upvalues: l__BaseComponent__7 (copy), u1 (copy), l__Signal__3 (copy), l__Trove__4 (copy)
    local v9 = l__BaseComponent__7.new(p7);
    setmetatable(v9, u1);
    v9.dropdown_asset = nil;
    v9.x_size = 0;
    v9.y_size = 0;
    v9.button = p5;
    v9.float_layer = p6;
    v9._options = {};
    v9.is_open = false;
    v9.current_search = "";
    v9.list_y_length = 0;
    v9:setReferenceDimensions();
    local v10 = p8 or {};
    local v11 = {
        list_max_length = v10.list_max_length or 5,
        can_search = v10.can_search or false,
        main_text = v10.main_text or (v10.can_search and "Search ..." or "Select ..."),
        initially_visible = v10.initially_visible or false
    };
    for v12, v13 in pairs(v10) do
        v11[v12] = v13;
    end;
    v9.onSelectionFinished = l__Signal__3.new();
    v9.onOpenList = l__Signal__3.new();
    v9.onCollapseList = l__Signal__3.new();
    v9.trove = l__Trove__4.new();
    v9.properties = v11;
    v9.mounted = false;
    v9.selected = nil;
    v9.trove:Add(v9.onSelectionFinished);
    v9.trove:Add(v9.onOpenList);
    v9.trove:Add(v9.onCollapseList);
    return v9;
end;
local l__GuiService__8 = game:GetService("GuiService");
function u1.setReferenceDimensions(p14) --[[ Line: 96 ]]
    local l__AbsoluteSize__9 = p14.target.AbsoluteSize;
    p14.x_size = l__AbsoluteSize__9.X;
    p14.y_size = l__AbsoluteSize__9.Y;
end;
function u1.calibrate(p15) --[[ Line: 102 ]]
    -- upvalues: l__GuiService__8 (copy)
    if p15.dropdown_asset then
        p15:setReferenceDimensions();
        local v16 = Vector2.new(0, 0);
        if l__GuiService__8 and l__GuiService__8.GetGuiInset then
            local v17, v18 = pcall(function() --[[ Line: 108 ]]
                -- upvalues: l__GuiService__8 (ref)
                return l__GuiService__8:GetGuiInset();
            end;
            if v17 and v18 then
                v16 = Vector2.new(v18.X or 0, v18.Y or 0);
            end;
        end;
        local v19 = p15.target.AbsolutePosition - Vector2.new(0, -v16.Y);
        p15.dropdown_asset.Size = UDim2.fromOffset(p15.x_size, 0);
        p15.dropdown_asset.Position = UDim2.fromOffset(v19.X, v19.Y);
        p15.dropdown_asset.DropdownTitle.Size = UDim2.new(1, 0, 0, p15.y_size);
        local v20 = 0;
        for _, v21 in ipairs(p15._options) do
            local l__inst__10 = v21.inst;
            if l__inst__10 and l__inst__10.Visible then
                v20 = v20 + p15.y_size;
                l__inst__10.Size = UDim2.new(1, 0, 0, p15.y_size);
            end;
        end;
        local v22 = tonumber(p15.properties.list_max_length) or 0;
        if v22 <= 0 then
            p15.list_y_length = v20;
        else
            p15.list_y_length = math.min(v20, p15.y_size * v22);
        end;
        p15.dropdown_asset.ListContainer.Size = UDim2.new(0, p15.x_size, 0, p15.list_y_length);
        p15.dropdown_asset.ListContainer.Position = UDim2.fromOffset(0, p15.y_size - 1);
    end;
end;
function u1.openList(p23) --[[ Line: 141 ]]
    -- upvalues: l__TweenService__1 (copy)
    if p23.mounted and p23.dropdown_asset then
        p23.dropdown_asset.Interactable = true;
        p23.is_open = true;
        p23.dropdown_asset.GroupTransparency = 1;
        p23.dropdown_asset.Visible = true;
        p23:calibrate();
        l__TweenService__1:Create(p23.dropdown_asset.ListContainer, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(p23.x_size, p23.list_y_length)
        }):Play();
        l__TweenService__1:Create(p23.dropdown_asset, TweenInfo.new(0.2), {
            GroupTransparency = 0
        }):Play();
        p23.onOpenList:Fire();
    end;
end;
function u1.collapseList(p24) --[[ Line: 162 ]]
    -- upvalues: l__TweenService__1 (copy)
    if p24.mounted and p24.dropdown_asset then
        p24.dropdown_asset.Interactable = false;
        p24.is_open = false;
        p24:calibrate();
        l__TweenService__1:Create(p24.dropdown_asset.ListContainer, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(p24.x_size, 0)
        }):Play();
        l__TweenService__1:Create(p24.dropdown_asset, TweenInfo.new(0.2), {
            GroupTransparency = 1
        }):Play();
        p24.onCollapseList:Fire();
    end;
end;
function u1.addOption(p25, p26) --[[ Line: 180 ]]
    -- upvalues: u4 (copy)
    local v27 = u4(p26);
    table.insert(p25._options, v27);
    p25:sortOptions();
    if p25.mounted then
        p25:renderOption(v27);
        p25:calibrate();
    end;
    return p25;
end;
function u1.sortOptions(p28) --[[ Line: 192 ]]
    table.sort(p28._options, function(p29, p30) --[[ Line: 193 ]]
        return (p29.appear_classified and 200 or (p29.appear_locked and 100 or 0)) + (p29.relative_order or 0) < (p30.appear_classified and 200 or (p30.appear_locked and 100 or 0)) + (p30.relative_order or 0);
    end;
end;
function u1.renderOption(u31, u32) --[[ Line: 200 ]]
    -- upvalues: l__Trove__4 (copy), l__UIAssets__5 (copy), l__Classes__6 (copy), l__TweenService__1 (copy)
    if u31.mounted then
        if u32._trove then
            u32._trove:Clean();
        end;
        u32._trove = l__Trove__4.new();
        local l__Dropdown__11 = l__UIAssets__5.Dropdown;
        local v33;
        if u32.appear_classified then
            v33 = l__Dropdown__11.ClassifiedOptionFrame:Clone();
        elseif u32.appear_locked then
            v33 = l__Dropdown__11.LockedOptionFrame:Clone();
        else
            v33 = l__Dropdown__11.OptionFrame:Clone();
        end;
        local v34 = v33:FindFirstChild("Background");
        if v34 then
            local v35 = v34:FindFirstChild("OptionText");
            if v35 then
                v35.Text = u32.text or "";
            end;
            if v35 and typeof(u32.preRender) == "function" then
                pcall(u32.preRender, v35);
            end;
            local v36 = (u32.appear_classified and 200 or (u32.appear_locked and 100 or 0)) + (u32.relative_order or 0);
            local v37 = v34:FindFirstChild("Button");
            if v37 and typeof(u32.tooltip) == "string" then
                local v38 = l__Classes__6.MenuManager:createTooltip(v37, u32.tooltip, (u32.appear_classified or u32.appear_locked) and 0 or 1);
                u32._trove:AddPromise(v38);
            end;
            if v37 then
                local v39 = v37.MouseButton1Click:Connect(function() --[[ Line: 247 ]]
                    -- upvalues: u31 (copy), u32 (copy)
                    u31.selected = u32;
                    u31.onSelectionFinished:Fire(u32);
                    u31:collapseList();
                end;
                u32._trove:Add(v39);
            end;
            local u40 = v34:FindFirstChild("NewNotif");
            if u40 and u32.appear_new then
                v36 = -100 + u32.relative_order;
                u40.Visible = true;
                if v37 then
                    local u41 = nil;
                    local u42 = nil;
                    u41 = v37.MouseEnter:Connect(function() --[[ Line: 264 ]]
                        -- upvalues: u41 (ref), u42 (ref), l__TweenService__1 (ref), u40 (copy)
                        if u41 then
                            u41:Disconnect();
                            u41 = nil;
                        end;
                        if u42 then
                            u42:Disconnect();
                            u42 = nil;
                        end;
                        l__TweenService__1:Create(u40, TweenInfo.new(0.7), {
                            TextTransparency = 1,
                            BackgroundTransparency = 1
                        }):Play();
                    end;
                    u42 = v37.MouseLeave:Connect(function() --[[ Line: 276 ]]
                        -- upvalues: u41 (ref), u42 (ref), l__TweenService__1 (ref), u40 (copy)
                        if u41 then
                            u41:Disconnect();
                            u41 = nil;
                        end;
                        if u42 then
                            u42:Disconnect();
                            u42 = nil;
                        end;
                        l__TweenService__1:Create(u40, TweenInfo.new(0.7), {
                            TextTransparency = 1,
                            BackgroundTransparency = 1
                        }):Play();
                    end;
                    u32._trove:Add(u41);
                    u32._trove:Add(u42);
                end;
            end;
            v33.LayoutOrder = v36;
            v33.Parent = u31.dropdown_asset.ListContainer;
            u32.inst = v33;
        else
            v33:Destroy();
            u32._trove:Clean();
            u32._trove = nil;
        end;
    end;
end;
function u1.refresh(p43) --[[ Line: 298 ]]
    local v44 = tostring(p43.current_search or ""):lower();
    for _, v45 in ipairs(p43._options) do
        if p43.mounted and not v45.inst then
            p43:renderOption(v45);
        end;
        local l__inst__12 = v45.inst;
        if l__inst__12 then
            if #v44 > 0 and v45.appear_classified then
                l__inst__12.Visible = false;
            else
                l__inst__12.Visible = true;
                if #v44 > 0 then
                    local v46 = tostring(v45.text or ""):lower();
                    l__inst__12.Visible = string.find(v46, v44, 1, true) ~= nil;
                else
                    l__inst__12.Visible = true;
                end;
            end;
        end;
    end;
    p43:calibrate();
end;
function u1.mount(u47) --[[ Line: 327 ]]
    -- upvalues: l__UIAssets__5 (copy)
    if u47.mounted then
    else
        u47.mounted = true;
        local v48 = l__UIAssets__5.Dropdown.DropdownMenu:Clone();
        u47.dropdown_asset = v48;
        u47.trove:Add(v48);
        local u49 = v48.DropdownTitle:FindFirstChild("Search");
        if u47.properties.can_search and (u49 and u49:IsA("TextBox")) then
            u49.PlaceholderText = u47.properties.main_text;
            u49.TextEditable = true;
            local v50 = u49:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 339 ]]
                -- upvalues: u47 (copy), u49 (copy)
                u47.current_search = u49.Text or "";
                u47:refresh();
            end;
            u47.trove:Add(v50);
        else
            v48.DropdownTitle.Search.PlaceholderText = u47.properties.main_text;
        end;
        v48.Parent = u47.float_layer;
        for _, v51 in ipairs(u47._options) do
            u47:renderOption(v51);
        end;
        local v52 = u47.target:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 355 ]]
            -- upvalues: u47 (copy)
            u47:calibrate();
        end;
        local v53 = u47.target:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() --[[ Line: 358 ]]
            -- upvalues: u47 (copy)
            u47:calibrate();
        end;
        u47.trove:Add(v52);
        u47.trove:Add(v53);
        local v54 = u47.button.MouseButton1Click:Connect(function() --[[ Line: 365 ]]
            -- upvalues: u47 (copy)
            if u47.is_open then
                u47:collapseList();
            else
                u47:openList();
            end;
        end;
        u47.trove:Add(v54);
        if u47.properties.initially_visible then
            v48.GroupTransparency = 0;
            v48.Interactable = true;
        else
            v48.GroupTransparency = 1;
            v48.Interactable = false;
        end;
        u47:calibrate();
    end;
end;
function u1.unmount(p55) --[[ Line: 386 ]]
    if p55.mounted then
        p55.mounted = false;
        for _, v56 in ipairs(p55._options) do
            if v56._trove then
                v56._trove:Clean();
                v56._trove = nil;
            end;
            if v56.inst then
                v56.inst:Destroy();
                v56.inst = nil;
            end;
        end;
        if p55.trove then
            p55.trove:Clean();
        end;
        p55.dropdown_asset = nil;
        p55.is_open = false;
    end;
end;
function u1.clearOptions(p57) --[[ Line: 411 ]]
    for _, v58 in ipairs(p57._options) do
        if v58._trove then
            v58._trove:Clean();
            v58._trove = nil;
        end;
        if v58.inst then
            v58.inst:Destroy();
            v58.inst = nil;
        end;
    end;
    p57._options = {};
    p57:calibrate();
end;
return u1;
