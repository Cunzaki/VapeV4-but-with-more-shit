-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.Inventory
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local l__RunService__2 = game:GetService("RunService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Signal__4 = require(l__ReplicatedStorage__1.Modules.Signal);
local l__Utility__5 = require(l__ReplicatedStorage__1.Modules.Utility);
local l__Deepcopy__6 = require(l__ReplicatedStorage__1.Modules.Deepcopy);
local l__RarityUtil__7 = require(l__ReplicatedStorage__1.Modules.RarityUtil);
local l__Search__8 = require(l__ReplicatedStorage__1.Modules.Search);
local u1 = l__Mince__3:Get("UserProfile");
local u2 = l__Mince__3:Get("ConfirmPrompt");
local u3 = l__Mince__3:Get("Topbar");
local u4 = l__Mince__3:Get("InterfaceHandler");
local v5 = l__Mince__3:GetEvent("Inventory");
local u6 = v5:Extend("Equip");
local u7 = v5:Extend("Switch");
local u8 = v5:Extend("Delete");
local u9 = v5:Extend("Unequip");
local u10 = v5:Extend("Pin");
local u11 = {
    Verbose = false,
    HighlightedCount = 0,
    Items = {},
    IVIDS = {},
    LoadedItems = {},
    EmoteUnlockKeys = {},
    DetailPanels = {},
    CategoryFilter = {},
    Categories = l__Mince__3.Config.InventoryTypes,
    EmoteUnlockKeysChanged = l__Signal__4.new(),
    InvUpdated = l__Signal__4.new(),
    InvNewItemAdded = l__Signal__4.new(),
    DetailOffset = Vector2.new(5, -55)
};
local u12 = {};
u12.__index = u12;
function u12.new(p13, p14) --[[ Line: 51 ]]
    -- upvalues: u12 (copy), u11 (copy)
    local v15 = setmetatable({}, u12);
    v15:Init(p13, p14);
    u11.DetailPanels[v15.Index] = v15;
    return v15;
end;
function u12.SetProperButtonsEnabled(p16, p17) --[[ Line: 60 ]]
    local _ = p17.IsEquipped or p17.MaxEquipped;
    if p17.ShouldShowCount then
        p16.PanelGui.List.Equip.ButtonLabel.Text = `Equip ({p17.CategoryEquippedCount + 1}/{p17.Class.Category.MaximumEquips})`;
    end;
    p16.PanelGui.List.Pin.ButtonLabel.Text = p17.IsPinned and "Unpin" or "Pin";
    if p17.MaxEquipped then
        if p17.Class.Category.MaximumEquips == 1 then
            if p17.IsEquipped then
                p16.PanelGui.List.Equip.Visible = false;
                p16.PanelGui.List.Unequip.Visible = true;
            else
                p16.PanelGui.List.Equip.Visible = false;
                p16.PanelGui.List.Unequip.Visible = false;
                p16.PanelGui.List.Switch.Visible = true;
            end;
        elseif p17.IsEquipped then
            p16.PanelGui.List.Equip.Visible = false;
            p16.PanelGui.List.Unequip.Visible = true;
        else
            p16.PanelGui.List.Equip.Visible = false;
            p16.PanelGui.List.Unequip.Visible = false;
            p16.PanelGui.List.MaxEquip.Visible = true;
        end;
    else
        p16.PanelGui.List.Equip.Visible = not p17.IsEquipped;
        p16.PanelGui.List.Unequip.Visible = p17.IsEquipped;
    end;
    if p17.Class.Category.CustomButton == "Flex" then
        p16.PanelGui.List.Flex.Visible = true;
    end;
    if p17.Class.Category.NonEquippable then
        p16.PanelGui.List.Equip.Visible = false;
        p16.PanelGui.List.Unequip.Visible = false;
    end;
    if p17.Class.Category.HaveUseButtonInstead then
        p16.PanelGui.List.Use.Visible = true;
        p16.PanelGui.List.Equip.Visible = false;
        p16.PanelGui.List.Unequip.Visible = false;
    end;
    if p17.Class.Category.Undeletable or p17.Class.Undeletable then
        p16.PanelGui.List.Delete.Visible = false;
        p16.PanelGui.List.CantDelete.Visible = true;
    end;
end;
function u12.Init(u18, u19, p20) --[[ Line: 120 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u4 (copy), u11 (copy), u2 (copy), u8 (copy), u10 (copy), u6 (copy), u7 (copy), u9 (copy)
    u18.PanelGui = l__ReplicatedStorage__1.Assets.Interface.DetailPanel:Clone();
    u18.PanelGui.Position = p20;
    u4.ScaleDescedantsStrokes(u18.PanelGui, u11.InventoryUI);
    u18.Enabled = true;
    u18.Events = {};
    u18.Index = {};
    local v21 = u19.Rarity.GetColors();
    u18.PanelGui.UIGradient.Color = v21.Graident;
    u18.PanelGui.UIStroke.UIGradient.Color = v21.Graident;
    u18.PanelGui.List.TitleContainer.NameLabel.Text = u19.Class.Name;
    u18:SetProperButtonsEnabled(u19);
    u18.Events.Changes = u19.Updated:Connect(function() --[[ Line: 137 ]]
        -- upvalues: u18 (copy), u19 (copy)
        u18:SetProperButtonsEnabled(u19);
    end);
    u18.Events.DeleteButton = u4.NewButton(u18.PanelGui.List.Delete).Activated:Connect(function() --[[ Line: 141 ]]
        -- upvalues: u2 (ref), u8 (ref), u19 (copy)
        u2.Display("Are you sure delete this? It will be deleted forever!", function() --[[ Line: 142 ]]
            -- upvalues: u8 (ref), u19 (ref)
            u8:Fire(u19.RawData.ID);
        end);
    end);
    u18.Events.PinButotn = u4.NewButton(u18.PanelGui.List.Pin).Activated:Connect(function() --[[ Line: 148 ]]
        -- upvalues: u10 (ref), u19 (copy), u18 (copy)
        u10:Fire(u19.RawData.ID, not u19.IsPinned);
        u18:Hide();
    end);
    u18.Events.FlexButton = u4.NewButton(u18.PanelGui.List.Flex).Activated:Connect(function() --[[ Line: 153 ]] end);
    u18.Events.EquipButton = u4.NewButton(u18.PanelGui.List.Use).Activated:Connect(function() --[[ Line: 157 ]]
        -- upvalues: u2 (ref), u6 (ref), u19 (copy), u18 (copy)
        u2.Display("Are you want to use this it\'s a one-time use!", function() --[[ Line: 158 ]]
            -- upvalues: u6 (ref), u19 (ref)
            u6:Fire(u19.RawData.ID);
        end);
        u18:Hide();
    end);
    u18.Events.EquipButton = u4.NewButton(u18.PanelGui.List.Equip).Activated:Connect(function() --[[ Line: 164 ]]
        -- upvalues: u6 (ref), u19 (copy), u18 (copy)
        u6:Fire(u19.RawData.ID);
        u18:Hide();
    end);
    u18.Events.EquipButton = u4.NewButton(u18.PanelGui.List.Switch).Activated:Connect(function() --[[ Line: 169 ]]
        -- upvalues: u7 (ref), u19 (copy), u18 (copy)
        u7:Fire(u19.RawData.ID);
        u18:Hide();
    end);
    u18.Events.UnequipButton = u4.NewButton(u18.PanelGui.List.Unequip).Activated:Connect(function() --[[ Line: 174 ]]
        -- upvalues: u9 (ref), u19 (copy), u18 (copy)
        u9:Fire(u19.RawData.ID);
        u18:Hide();
    end);
    local l__CanvasPosition__9 = u11.Scroll.CanvasPosition;
    u18.Events.Scrolling = u11.Scroll:GetPropertyChangedSignal("CanvasPosition"):Connect(function() --[[ Line: 180 ]]
        -- upvalues: u11 (ref), l__CanvasPosition__9 (copy), u18 (copy)
        if math.abs(u11.Scroll.CanvasPosition.Y - l__CanvasPosition__9.Y) > 10 then
            u18:Hide();
        end;
    end);
    u18.Events.UponClosing = u11.Inventory.Closed:Connect(function() --[[ Line: 186 ]]
        -- upvalues: u18 (copy)
        u18:Hide();
    end);
end;
function u12.UpdateGUI(_) --[[ Line: 191 ]] end;
function u12.Hide(p22) --[[ Line: 195 ]]
    -- upvalues: u11 (copy)
    for _, v23 in p22.Events do
        v23:Disconnect();
    end;
    p22.Enabled = false;
    p22.PanelGui:Destroy();
    u11.DetailPanels[p22.Index] = nil;
end;
local u24 = {};
u24.__index = u24;
function u24.new(p25, p26) --[[ Line: 206 ]]
    -- upvalues: u24 (copy), l__Signal__4 (copy)
    local v27 = setmetatable({}, u24);
    v27.Updated = l__Signal__4.new();
    v27:UpdateRaw(p25);
    v27:Init(p25, p26);
    return v27;
end;
function u24.GetCheapSortOrder(p28) --[[ Line: 214 ]]
    return p28.Rarity.Order * 100000 - p28.Class.Category.Order * 1000 - string.byte(p28.Class.Name:sub(1, 1));
end;
function u24.CheckMyselfForEquipping(p29, p30) --[[ Line: 218 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy)
    local v31 = p30[p29.Class.Category.CategoryName] or {};
    p29.IsEquipped = table.find(v31, p29.RawData.ID) ~= nil;
    p29.MaxEquipped = #v31 >= p29.Class.Category.MaximumEquips;
    p29.CategoryEquippedCount = #v31;
    p29.ShouldShowCount = p29.Class.Category.MaximumEquips ~= (1 / 0);
    if p29.IsEquipped then
        if not p29.EquippedOverlay then
            p29.EquippedOverlay = l__ReplicatedStorage__1.Assets.Interface.ItemOverlays.Equipped:Clone();
        end;
        p29:AddOverlay(p29.EquippedOverlay);
    else
        p29:RemoveOverlay(p29.EquippedOverlay);
        p29.EquippedOverlay = nil;
    end;
    p29:UpdateLayoutOrder();
    p29.Updated:Fire();
end;
function u24.UpdateLayoutOrder(p32) --[[ Line: 242 ]]
    p32.GUI.LayoutOrder = -p32:GetCheapSortOrder();
    if p32.IsEquipped then
        local l__GUI__10 = p32.GUI;
        l__GUI__10.LayoutOrder = l__GUI__10.LayoutOrder * 100000000;
        if p32.IsPinned then
            local l__GUI__11 = p32.GUI;
            l__GUI__11.LayoutOrder = l__GUI__11.LayoutOrder * 10;
        end;
    elseif p32.IsPinned then
        local l__GUI__12 = p32.GUI;
        l__GUI__12.LayoutOrder = l__GUI__12.LayoutOrder * 1000;
    end;
end;
function u24.Init(u33, p34, p35) --[[ Line: 254 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u4 (copy), u11 (copy), u12 (copy)
    u33.RawData = p34;
    u33.GUI = l__ReplicatedStorage__1.Assets.Interface.InventoryItem:Clone();
    u33.SwordButton = u4.NewButton(u33.GUI, {
        Mult = 0.0625
    });
    u4.ScaleDescedantsStrokes(u33.GUI, u11.InventoryUI);
    u33.GUI.Parent = u11.Scroll;
    u33.Events = {};
    u33.Overlays = {};
    u33.LoadedGraidentTween = {};
    if p35 then
        u33:CreateHighlight();
    end;
    if u11.InventoryEquipped then
        u33:CheckMyselfForEquipping(u11.InventoryEquipped);
    end;
    u33:UpdateGUI();
    u33.Events.UponClicked = u33.SwordButton.Activated:Connect(function(p36) --[[ Line: 278 ]]
        -- upvalues: u11 (ref), u33 (copy), u12 (ref)
        local l__MainFrame__13 = u11.MainFrame;
        local v37 = (p36 - l__MainFrame__13.AbsolutePosition + u11.DetailOffset) / l__MainFrame__13.AbsoluteSize;
        local v38 = UDim2.fromScale(v37.X, v37.Y);
        if u33.DetailPanel and u33.DetailPanel.Enabled then
            u33.DetailPanel:Hide();
            u33.DetailPanel = nil;
        else
            u11.CloseAllPanels();
            task.wait();
            u33.DetailPanel = u12.new(u33, v38);
            u33.DetailPanel.PanelGui.Parent = u11.MainFrame;
            u33:Clear();
        end;
    end);
end;
function u24.UpdateGUI(p39) --[[ Line: 297 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy)
    local v40 = p39.Rarity.GetColors();
    p39.GUI.Button.Icon.Image = p39.Class.Category.Icon;
    p39.GUI.Button.ItemName.Text = p39.Class.Name;
    p39.GUI.Button.UIGradient.Color = v40.Graident;
    p39.GUI.Button.UIStroke.UIGradient.Color = v40.Graident;
    p39.GUI.Button.Pin.Visible = p39.IsPinned;
    if p39.Class.RenderText then
        p39.GUI.Button.Render.Visible = false;
        p39.GUI.Button.RenderText.Visible = true;
        p39.GUI.Button.RenderText.Text = p39.Class.RenderText;
    elseif p39.Class.Render then
        local v41 = (p39.Class.Render or ""):gsub("%D", "");
        local v42 = tonumber(v41);
        p39.GUI.Button.Render.Image = `rbxthumb://type=Asset&id={v42}&w=150&h=150`;
    end;
    if not p39.HasUpdatedItemExtra and p39.Class.Extra then
        p39.HasUpdatedItemExtra = true;
        local v43 = l__ReplicatedStorage__1.Assets.Interface.Extra:FindFirstChild(p39.Class.Extra);
        if v43 then
            v43:Clone().Parent = p39.GUI.Button;
        else
            warn((`Could not find the extra for '{p39.Class.Extra}'`));
        end;
    end;
    if not p39.HasUpdatedRarityExtra and p39.Rarity.Data.Extra then
        p39.HasUpdatedRarityExtra = true;
        local v44 = l__ReplicatedStorage__1.Assets.Interface.Extra:FindFirstChild(p39.Rarity.Data.Extra);
        if v44 then
            v44:Clone().Parent = p39.GUI.Button;
            return;
        end;
        warn((`Could not find the extra for '{p39.Rarity.Data.Extra}'`));
    end;
end;
function u24.UpdateIsPinned(p45, p46) --[[ Line: 340 ]]
    p45.IsPinned = p46[p45.RawData.ID] ~= nil;
end;
function u24.UpdateRaw(p47, p48) --[[ Line: 344 ]]
    -- upvalues: u11 (copy), l__RarityUtil__7 (copy), l__Mince__3 (copy)
    p47.RawData = p48;
    p47.Class = u11.Items[p47.RawData.IVID];
    p47.Rarity = l__RarityUtil__7.GetRarity(p47.Class.Rarity);
    p47:UpdateIsPinned(l__Mince__3.Config.LocalProfile.InventoryPinned);
    p47.Updated:Fire();
end;
function u24.Clear(p49) --[[ Line: 353 ]]
    -- upvalues: u11 (copy), u3 (copy)
    if p49.HighlightCycle then
        p49.HighlightCycle:Disconnect();
    end;
    p49:RemoveOverlay(p49.Highlight);
    if p49.Highlighted then
        p49.Highlighted = false;
        local v50 = u11;
        v50.HighlightedCount = v50.HighlightedCount - 1;
        u3.InventoryButton:clearNotices();
        for _ = 1, u11.HighlightedCount do
            u3.InventoryButton:notify();
        end;
    end;
end;
function u24.AddOverlay(p51, p52, p53) --[[ Line: 371 ]]
    p51.Overlays[p52] = p53;
    p52:SetAttribute("InventoryItemOverlay", true);
    p52.Parent = p51.GUI.Button;
end;
function u24.RemoveOverlay(p54, p55) --[[ Line: 378 ]]
    if p55 then
        p55:Destroy();
        p54.Overlays[p55] = nil;
    end;
end;
function u24.CreateHighlight(p56) --[[ Line: 384 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), l__RunService__2 (copy)
    local u57 = l__ReplicatedStorage__1.Assets.Interface.Highlight:Clone();
    p56.Highlighted = true;
    p56.Highlight = u57;
    p56.HighlightCycle = l__RunService__2.RenderStepped:Connect(function() --[[ Line: 388 ]]
        -- upvalues: u57 (copy)
        local v58 = u57;
        local v59 = tick() * 5;
        v58.BackgroundTransparency = math.sin(v59) / 20 + 0.7;
    end);
    p56:AddOverlay(u57, {
        Normal = true
    });
end;
function u24.Destroy(p60) --[[ Line: 398 ]]
    -- upvalues: u11 (copy)
    p60.GUI:Destroy();
    if p60 == nil then
    else
        if p60.DetailPanel and p60.DetailPanel.Enabled then
            p60.CHide();
            p60.DetailPanel = nil;
        end;
        for _, v61 in p60.Events do
            v61:Disconnect();
        end;
        u11.LoadedItems[p60.RawData.ID] = nil;
    end;
end;
function u11.FilterBySearch(p62) --[[ Line: 417 ]]
    -- upvalues: l__Search__8 (copy), u11 (copy)
    local l__AutoMatch__14 = l__Search__8.GetMethods().AutoMatch;
    local l__Levenshtein__15 = l__Search__8.GetMethods().Levenshtein;
    local v63 = p62:lower();
    local v64 = {};
    for _, v65 in u11.LoadedItems do
        local v66 = v65.Class.Name:lower();
        local v67 = l__AutoMatch__14(v63, v66);
        local v68 = {};
        table.insert(v68, l__Levenshtein__15(v66, v63));
        table.insert(v68, v67);
        if v67 < 0 then
            table.insert(v64, { v66, v67 });
        end;
        for v69, v70 in string.split(v66, " ") do
            if v69 ~= 1 then
                local v71 = l__AutoMatch__14(v63, v70);
                if v71 <= 0 then
                    v71 = v71 / v69;
                end;
                table.insert(v68, v71);
            end;
        end;
        local v72 = v68[1];
        for _, v73 in v68 do
            if v73 < v72 then
                v72 = v73;
            end;
        end;
        if v72 > 10 and p62 ~= "" then
            v65.GUI.Visible = false;
        else
            v65.GUI.Visible = true;
        end;
        if v66 == v63 then
            v72 = v72 - 100;
        end;
        v65.GUI.LayoutOrder = v72 or 0;
    end;
    if #v64 > 0 and #p62 > 0 then
        table.sort(v64, function(p74, p75) --[[ Line: 469 ]]
            return p74[2] < p75[2];
        end);
        local v76 = v64[1][1];
        u11.Tabs.SearchBar.AutoComplete.Text = p62 .. v76:sub(#p62 + 1, #v76);
    else
        u11.Tabs.SearchBar.AutoComplete.Text = "";
    end;
end;
function u11.FilterByCategories(p77) --[[ Line: 480 ]]
    -- upvalues: u11 (copy)
    local v78 = #p77 >= 1;
    for _, v79 in u11.LoadedItems do
        local v80 = v78;
        for _, v81 in p77 do
            if string.find(string.lower(v79.Class.Category.CategoryName), string.lower(v81)) == 1 then
                v80 = false;
                break;
            end;
        end;
        v79.GUI.Visible = not v80;
    end;
end;
function u11.CloseAllPanels() --[[ Line: 499 ]]
    -- upvalues: u11 (copy)
    for _, v82 in u11.DetailPanels do
        v82:Hide();
    end;
end;
function u11.GetSortOrders(p83) --[[ Line: 503 ]]
    -- upvalues: u11 (copy), l__RarityUtil__7 (copy)
    table.sort(p83, function(p84, p85) --[[ Line: 505 ]]
        -- upvalues: u11 (ref), l__RarityUtil__7 (ref)
        local v86 = u11.Items[p84.IVID];
        local v87 = l__RarityUtil__7.GetRarity(v86.Rarity);
        local v88 = u11.Items[p85.IVID];
        local v89 = l__RarityUtil__7.GetRarity(v88.Rarity);
        if v87 ~= v89 then
            return v87.Order > v89.Order;
        end;
        if v86.Category ~= v88.Category then
            return v86.Category.Order > v88.Category.Order;
        end;
        if v86.Equipped == v88.Equipped then
            return false;
        end;
        local l__Equipped__16 = v86.Equipped;
        if l__Equipped__16 then
            l__Equipped__16 = not v88.Equipped;
        end;
        return l__Equipped__16;
    end);
end;
function u11.UpdateFromData(p90) --[[ Line: 532 ]]
    -- upvalues: l__Deepcopy__6 (copy), u11 (copy), u24 (copy), l__Utility__5 (copy), u3 (copy)
    local v91 = l__Deepcopy__6(p90);
    local v92 = u11.LastInventoryData == nil;
    u11.LastInventoryData = u11.InventoryData;
    u11.InventoryData = v91;
    local v93 = {};
    local v94 = 0;
    for _, v95 in pairs(v91) do
        local v96 = u11.LoadedItems[v95.ID];
        if v96 == nil then
            if u11.Verbose and not v92 then
                print((`Item: {v95.ID} was not loaded, now creating...`));
            end;
            u11.LoadedItems[v95.ID] = u24.new(v95, u11.FirstUpdate);
            u11.InvNewItemAdded:Fire(u11.LoadedItems[v95.ID]);
        elseif not l__Utility__5.TableEq(v95, v96.RawData or {}) then
            if u11.Verbose then
                print((`Item: {v95.ID} was just updated.`));
            end;
            v96:UpdateRaw(v95);
        end;
        v93[v95.ID] = true;
        v94 = v94 + 1;
    end;
    local v97 = {};
    local v98 = 0;
    for _, v99 in pairs(u11.LoadedItems) do
        if v93[v99.RawData.ID] then
            if v99.Class.Category.CategoryName == "Emote" then
                v97[v99.Class.ID] = true;
            end;
        else
            if u11.Verbose then
                warn((`Item: {v99.RawData.ID} was not found within the inventory, now deleting...`));
            end;
            v99:Destroy();
        end;
        if v99.Highlighted then
            v98 = v98 + 1;
        end;
    end;
    if not l__Utility__5.TableEq(u11.EmoteUnlockKeys, v97) then
        u11.EmoteUnlockKeys = v97;
        u11.EmoteUnlockKeysChanged:Fire();
    end;
    u11.HighlightedCount = v98;
    u3.InventoryButton:clearNotices();
    for _ = 1, v98 do
        u3.InventoryButton:notify();
    end;
    if not u11.FirstUpdate then
        task.delay(1, function() --[[ Line: 607 ]]
            -- upvalues: u11 (ref)
            u11.FirstUpdate = true;
        end);
    end;
    u11.InvUpdated:Fire();
end;
function u11.WhenUpdated(p100) --[[ Line: 615 ]]
    -- upvalues: u11 (copy)
    p100();
    u11.InvUpdated:Connect(p100);
end;
function u11.MoreThanLast1IVID(p101) --[[ Line: 621 ]]
    -- upvalues: u11 (copy)
    if u11.LastInventoryData then
        for _, v102 in u11.LastInventoryData do
            if p101 == v102.IVID then
                return true;
            end;
        end;
    end;
end;
function u11.MoreThan1IVID(p103) --[[ Line: 631 ]]
    -- upvalues: u11 (copy)
    if not u11.InventoryData then
        return false;
    end;
    for _, v104 in u11.InventoryData do
        if p103 == v104.IVID then
            return true;
        end;
    end;
    return false;
end;
function u11.Trigger() --[[ Line: 643 ]]
    -- upvalues: u11 (copy)
    u11.Inventory.Trigger();
end;
function u11.HandleSearchButton() --[[ Line: 647 ]]
    -- upvalues: u11 (copy)
    print("Opening Search");
    u11.Tabs.SearchBar.Visible = true;
    u11.Tabs.SearchBar.TextBox:CaptureFocus();
    u11.Tabs.SearchBar.TextBox.Text = "";
    u11.Tabs.SearchBar.AutoComplete.Text = "";
end;
function u11.HandleSearchBar() --[[ Line: 655 ]]
    -- upvalues: u11 (copy)
    local l__SearchBar__17 = u11.Tabs.SearchBar;
    l__SearchBar__17.TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 658 ]]
        -- upvalues: u11 (ref), l__SearchBar__17 (copy)
        u11.FilterBySearch(l__SearchBar__17.TextBox.Text);
    end);
    l__SearchBar__17.TextBox.FocusLost:Connect(function() --[[ Line: 662 ]]
        -- upvalues: l__SearchBar__17 (copy)
        if #l__SearchBar__17.TextBox.Text:gsub("%s+", "") < 1 then
            l__SearchBar__17.Visible = false;
        end;
    end);
end;
function u11.HandleFilterButton(p105) --[[ Line: 669 ]]
    -- upvalues: u11 (copy)
    if table.find(u11.CategoryFilter, p105.Name) then
        table.remove(u11.CategoryFilter, table.find(u11.CategoryFilter, p105.Name));
        p105.BackgroundColor3 = Color3.fromRGB(53, 53, 53);
        p105.UIStroke.Color = Color3.fromRGB(93, 93, 93);
    else
        table.insert(u11.CategoryFilter, p105.Name);
        p105.BackgroundColor3 = Color3.fromRGB(165, 165, 165);
        p105.UIStroke.Color = Color3.fromRGB(248, 248, 248);
    end;
    u11.FilterByCategories(u11.CategoryFilter);
end;
function u11.HandleCloseButton() --[[ Line: 683 ]]
    -- upvalues: u11 (copy)
    if u11.Tabs.SearchBar.Visible == true then
        u11.Tabs.SearchBar.TextBox:ReleaseFocus();
        u11.Tabs.SearchBar.Visible = false;
        u11.UpdateAllLayoutOrders();
        task.defer(u11.UpdateAllLayoutOrders);
    else
        u11.Inventory.Close();
    end;
end;
function u11.SetupGUI() --[[ Line: 694 ]]
    -- upvalues: u4 (copy), u11 (copy)
    local v106 = u4.NewButton(u11.InventoryUI.Main.CloseButton);
    u11.Tabs = u11.InventoryUI.Main.Title.TextLabel.Tabs;
    u11.HandleSearchBar();
    for _, u107 in u11.Tabs:GetChildren() do
        if u107:IsA("GuiButton") then
            u4.NewButton(u107).Activated:Connect(function() --[[ Line: 704 ]]
                -- upvalues: u107 (copy), u11 (ref)
                if u107.Name == "Search" then
                    u11.HandleSearchButton();
                else
                    u11.HandleFilterButton(u107);
                end;
            end);
        end;
    end;
    v106.Activated:Connect(u11.HandleCloseButton);
end;
function u11.GetRandomIVID() --[[ Line: 719 ]]
    -- upvalues: u11 (copy)
    return u11.IVIDS[math.random(1, #u11.IVIDS)];
end;
function u11.SetupConfigs() --[[ Line: 723 ]]
    -- upvalues: l__Mince__3 (copy), u11 (copy)
    for v108, v109 in l__Mince__3.Config.Inventory do
        local v110 = u11.Categories[v108];
        local v111 = `Please resolve asap! Inventory items for category '{v108}' cannot be loaded!`;
        assert(v110, v111);
        v110.CategoryName = v108;
        v110.Items = {};
        for v112, v113 in v109 do
            v113.ID = v112;
            v113.IVID = `{v108}.{v112}`;
            v113.Category = v110;
            u11.Items[v113.IVID] = v113;
            table.insert(v110.Items, v113);
            table.insert(u11.IVIDS, v113.IVID);
        end;
    end;
end;
function u11.UpdateAllLayoutOrders() --[[ Line: 742 ]]
    -- upvalues: u11 (copy), l__Mince__3 (copy)
    for _, v114 in pairs(u11.LoadedItems) do
        v114:CheckMyselfForEquipping(l__Mince__3.Config.LocalProfile.InventoryEquipped);
    end;
end;
function u11.Setup() --[[ Line: 748 ]]
    -- upvalues: u11 (copy), u4 (copy), u1 (copy)
    u11.InventoryUI = u4.GetScreenGui("Inventory");
    u11.Inventory = u4.Get("Inventory");
    u11.Scroll = u11.InventoryUI.Main.Scroll;
    u11.MainFrame = u11.InventoryUI.Main;
    u11.SetupGUI();
    u1.Upon("Inventory", u11.UpdateFromData);
    u1.Upon("InventoryEquipped", function(p115) --[[ Line: 756 ]]
        -- upvalues: u11 (ref)
        for _, v116 in pairs(u11.LoadedItems) do
            v116:CheckMyselfForEquipping(p115);
        end;
        u11.InventoryEquipped = p115;
    end);
    u1.Upon("InventoryPinned", function(p117) --[[ Line: 763 ]]
        -- upvalues: u11 (ref)
        for _, v118 in pairs(u11.LoadedItems) do
            local l__IsPinned__18 = v118.IsPinned;
            v118:UpdateIsPinned(p117);
            if l__IsPinned__18 ~= v118.IsPinned then
                v118:UpdateGUI();
                v118:UpdateLayoutOrder();
            end;
        end;
    end);
    u11.Inventory.Opened:Connect(function() --[[ Line: 774 ]]
        -- upvalues: u1 (ref), u11 (ref)
        u1.RequestUpdate("Inventory");
        u11.UpdateAllLayoutOrders();
    end);
    u11.Inventory.Closed:Connect(function() --[[ Line: 779 ]]
        -- upvalues: u11 (ref)
        for _, v119 in pairs(u11.LoadedItems) do
            v119:Clear();
        end;
    end);
end;
u11.SetupConfigs();
return u11;
