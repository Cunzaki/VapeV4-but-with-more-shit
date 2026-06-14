-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.UserGenerated.Store.AccessoryList
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__AvatarEditorService__1 = game:GetService("AvatarEditorService");
local l__MarketplaceService__2 = game:GetService("MarketplaceService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__TweenService__4 = game:GetService("TweenService");
local l__RunService__5 = game:GetService("RunService");
local l__Players__6 = game:GetService("Players");
local l__LocalPlayer__7 = l__Players__6.LocalPlayer;
local l__Signal__8 = require(l__ReplicatedStorage__3.Modules.Signal);
local l__Mince__9 = require(l__ReplicatedStorage__3.Modules.Mince);
local u1 = l__Mince__9:Get("TriggerHandler");
local u2 = l__Mince__9:Get("ConfirmPrompt");
local u3 = l__Mince__9:Get("MarketHandler");
local u4 = l__Mince__9:Get("UGCStandManager");
local u5 = l__Mince__9:Get("InterfaceHandler");
local u6 = l__Mince__9:Get("HumanoidDescriptionApplier");
local u7 = Enum.RenderPriority.Character.Value - 5;
local u8 = {
    LastCountEquipped = 0,
    IsCollapsed = false,
    __IsAsyncSetup = true,
    AccessoryListUIEvents = {},
    AcesssoryListUIs = {},
    AssetEquippedMemory = {},
    CachedProductInfo = {},
    EquippedExtras = {},
    SearchUIS = {},
    SearchEvents = {},
    CharacterUIS = {},
    CharacterEvents = {},
    EquippedUpdate = l__Signal__8.new(),
    Positions = { UDim2.fromScale(0.3, 0.5), UDim2.fromScale(0, 0.5) },
    OpenTween = TweenInfo.new(0.3, Enum.EasingStyle.Back),
    Icons = {
        Robux = "",
        Premium = "",
        Verified = ""
    }
};
function u8.UpdateEquippedList() --[[ Line: 64 ]]
    -- upvalues: u8 (copy)
    local v9 = 0;
    for _, _ in u8.AssetEquippedMemory do
        v9 = v9 + 1;
    end;
    if u8.LastCountEquipped == 0 and v9 > 0 then
        u8.EquippedItems:Show();
    end;
    if v9 == 0 then
        u8.EquippedItems:Hide();
    end;
    u8.LastCountEquipped = v9;
end;
function u8.CleanupAcessorieUIs() --[[ Line: 81 ]]
    -- upvalues: u8 (copy)
    for _, v10 in u8.AcesssoryListUIs do
        v10:Destroy();
    end;
    for _, v11 in u8.AccessoryListUIEvents do
        v11:Disconnect();
    end;
end;
function u8.GetCachedProductInfo(u12) --[[ Line: 91 ]]
    -- upvalues: u4 (copy), l__MarketplaceService__2 (copy)
    if u4.CachedProductInfo[u12] then
        return u4.CachedProductInfo[u12];
    end;
    local v13, v14 = pcall(function() --[[ Line: 96 ]]
        -- upvalues: l__MarketplaceService__2 (ref), u12 (copy)
        return l__MarketplaceService__2:GetProductInfo(u12, Enum.InfoType.Asset);
    end);
    if v13 then
        u4.CachedProductInfo[u12] = v14;
        return v14;
    end;
end;
function u8.GenerateNameString(p15) --[[ Line: 107 ]]
    -- upvalues: l__Players__6 (copy), u8 (copy)
    local v16 = p15.Name or l__Players__6:GetNameFromUserIdAsync(p15.Id or 0) or "Could Not Load...";
    if p15.HasVerifiedBadge then
        v16 = u8.Icons.Verified .. v16;
    end;
    return v16;
end;
function u8.HandleOpen(p17) --[[ Line: 118 ]]
    -- upvalues: u8 (copy), l__ReplicatedStorage__3 (copy), u5 (copy), u3 (copy)
    u8.AccessoryItems:Show();
    u8.CleanupAcessorieUIs();
    local l__TweenFrame__10 = u8.AccessoryItems.TweenFrame;
    l__TweenFrame__10.Scroll.CanvasPosition = Vector2.zero;
    for _, u18 in p17.AcessoryChoices do
        local u19 = l__ReplicatedStorage__3.Assets.Interface.AccessoryItem:Clone();
        local function v20() --[[ Line: 129 ]]
            -- upvalues: u8 (ref), u18 (copy), u19 (copy)
            if u8.IsOnIntialCharacter(u18.AssetID) then
                u19.ApplyButton.Text = "Equipped";
            elseif u8.AssetEquippedMemory[u18.AssetID] then
                u19.ApplyButton.Text = "Take Off";
            else
                u19.ApplyButton.Text = "Try on";
            end;
        end;
        u5.NewButton(u19.BuyButton).Activated:Connect(function() --[[ Line: 145 ]]
            -- upvalues: u3 (ref), u18 (copy)
            u3.StartPurchase(u18.AssetID);
        end);
        u5.NewButton(u19.ApplyButton).Activated:Connect(function() --[[ Line: 149 ]]
            -- upvalues: u8 (ref), u18 (copy), u19 (copy)
            if u8.IsOnIntialCharacter(u18.AssetID) then
            else
                if u8.AssetEquippedMemory[u18.AssetID] then
                    u8.RemoveTestAccessory(u18.AssetID);
                else
                    u8.TestAccessory(u18.AssetID, u18.HumanoidAcessoryTable);
                end;
                if u8.IsOnIntialCharacter(u18.AssetID) then
                    u19.ApplyButton.Text = "Equipped";
                elseif u8.AssetEquippedMemory[u18.AssetID] then
                    u19.ApplyButton.Text = "Take Off";
                else
                    u19.ApplyButton.Text = "Try on";
                end;
            end;
        end);
        if u8.IsOnIntialCharacter(u18.AssetID) then
            u19.ApplyButton.Text = "Equipped";
        elseif u8.AssetEquippedMemory[u18.AssetID] then
            u19.ApplyButton.Text = "Take Off";
        else
            u19.ApplyButton.Text = "Try on";
        end;
        u19.Parent = l__TweenFrame__10.Scroll;
        u8.AccessoryListUIEvents[u19] = u8.EquippedUpdate:Connect(v20);
        table.insert(u8.AcesssoryListUIs, u19);
        task.spawn(function() --[[ Line: 169 ]]
            -- upvalues: u18 (copy), u8 (ref), u19 (copy)
            local v21 = u18.ProductInfo or u8.GetCachedProductInfo(u18.AssetID);
            if v21 then
                u19.UGCPrice.Text = ` {v21.PriceInRobux}`;
                u19.UGCName.Text = v21.Name;
                u19.UGCCreatorName.Text = `by {u8.GenerateNameString(v21.Creator)}`;
                u19.Icon.Image = `http://www.roblox.com/asset-thumbnail/image?assetId={u18.AssetID}&width=420&height=420&format=png`;
            else
                warn("Failure to load item! So the acessory was deleted fomr the list ");
                u19:Destroy();
            end;
        end);
    end;
    l__TweenFrame__10.Scroll:SetAttribute("Update", math.random());
end;
function u8.HandleClose() --[[ Line: 190 ]]
    -- upvalues: u8 (copy), u4 (copy)
    u8.AccessoryItems:Hide();
    u4.ClearStand();
end;
function u8.TestAccessory(u22, u23) --[[ Line: 196 ]]
    -- upvalues: u8 (copy), l__ReplicatedStorage__3 (copy), u5 (copy), l__MarketplaceService__2 (copy), l__LocalPlayer__7 (copy), l__AvatarEditorService__1 (copy), u2 (copy), u3 (copy), u6 (copy)
    if not u8.FakeCharacter or (not u8.FakeCharacter.Humanoid or u8.AssetEquippedMemory[u22]) then
        return false;
    end;
    local l__TweenFrame__11 = u8.EquippedItems.TweenFrame;
    local v24 = u8.GetCachedProductInfo(u22);
    local v25 = l__ReplicatedStorage__3.Assets.Interface.EquipItem:Clone();
    u5.NewButton(v25.RemoveButton).Activated:Connect(function() --[[ Line: 203 ]]
        -- upvalues: u8 (ref), u22 (copy)
        u8.RemoveTestAccessory(u22);
    end);
    u5.NewButton(v25.BuyButton).Activated:Connect(function() --[[ Line: 207 ]]
        -- upvalues: l__MarketplaceService__2 (ref), l__LocalPlayer__7 (ref), u22 (copy), u8 (ref), u23 (copy), l__AvatarEditorService__1 (ref), u2 (ref), u3 (ref)
        if l__MarketplaceService__2:PlayerOwnsAsset(l__LocalPlayer__7, u22) then
            if u8.IntialHumanoidDescription then
                local l__Humanoid__12 = u8.FakeCharacter.Humanoid;
                local l__IntialHumanoidDescription__13 = u8.IntialHumanoidDescription;
                local v26 = l__IntialHumanoidDescription__13:GetAccessories(true);
                table.insert(v26, u23);
                l__IntialHumanoidDescription__13:SetAccessories(v26, true);
                l__AvatarEditorService__1:PromptSaveAvatar(l__IntialHumanoidDescription__13, l__Humanoid__12.RigType);
            end;
        else
            u2.Display("You dont own this! Would you like to purchase this first?", function() --[[ Line: 219 ]]
                -- upvalues: u3 (ref), u22 (ref), u8 (ref), u23 (ref), l__AvatarEditorService__1 (ref)
                if u3.StartPurchase(u22) then
                    local l__Humanoid__14 = u8.FakeCharacter.Humanoid;
                    local l__IntialHumanoidDescription__15 = u8.IntialHumanoidDescription;
                    local v27 = l__IntialHumanoidDescription__15:GetAccessories(true);
                    table.insert(v27, u23);
                    l__IntialHumanoidDescription__15:SetAccessories(v27, true);
                    l__AvatarEditorService__1:PromptSaveAvatar(l__IntialHumanoidDescription__15, l__Humanoid__14.RigType);
                end;
            end);
        end;
    end);
    v25.UGCName.Text = v24.Name;
    v25.UGCCreatorName.Text = `by {u8.GenerateNameString(v24.Creator)}`;
    v25.Icon.Image = `http://www.roblox.com/asset-thumbnail/image?assetId={u22}&width=420&height=420&format=png`;
    v25.Parent = l__TweenFrame__11.Scroll;
    u8.AssetEquippedMemory[u22] = { v24, v25 };
    local v28 = u8.FakeCharacter.Humanoid:GetAppliedDescription():GetAccessories(true);
    if u23.AccessoryType == Enum.AccessoryType.Shirt then
        u8.EquippedExtras.Shirt = u23.AssetId;
        v24.IsExtra = true;
        v24.Index = "Shirt";
    end;
    if u23.AccessoryType == Enum.AccessoryType.Pants then
        u8.EquippedExtras.Pants = u23.AssetId;
        v24.IsExtra = true;
        v24.Index = "Pants";
    end;
    if not v24.IsExtra then
        table.insert(v28, u23);
    end;
    u8.LiteralAccessoriesList = v28;
    if u8.FakeCharacter and u8.LiteralAccessoriesList then
        u6.ModifyAccessories(u8.FakeCharacter.Humanoid, u8.IntialHumanoidDescription, u8.LiteralAccessoriesList, u8.EquippedExtras);
    end;
    u8.EquippedUpdate:Fire();
    u8.UpdateEquippedList();
    return true;
end;
function u8.RemoveTestAccessory(p29) --[[ Line: 281 ]]
    -- upvalues: u8 (copy), u6 (copy)
    if not (u8.FakeCharacter and (u8.FakeCharacter.Humanoid and u8.AssetEquippedMemory[p29])) then
        return false;
    end;
    local v30 = u8.AssetEquippedMemory[p29];
    if v30 and v30[2] then
        v30[2]:Destroy();
    end;
    u8.AssetEquippedMemory[p29] = nil;
    local v31 = u8.GetCachedProductInfo(p29);
    local v32 = u8.FakeCharacter.Humanoid:GetAppliedDescription():GetAccessories(true);
    local v33 = nil;
    for v34, v35 in v32 do
        if v35.AssetId == p29 then
            v33 = v34;
            break;
        end;
    end;
    if v31 and (v31.IsExtra and v31.Index) then
        u8.EquippedExtras[v31.Index] = nil;
        if u8.FakeCharacter then
            u6.ModifyAccessories(u8.FakeCharacter.Humanoid, u8.IntialHumanoidDescription, v32, u8.EquippedExtras);
        end;
        u8.EquippedUpdate:Fire();
    elseif v33 then
        table.remove(v32, v33);
        if u8.FakeCharacter then
            u6.ModifyAccessories(u8.FakeCharacter.Humanoid, u8.IntialHumanoidDescription, v32, u8.EquippedExtras);
        end;
        u8.EquippedUpdate:Fire();
    end;
    u8.UpdateEquippedList();
    return true;
end;
function u8.IsOnIntialCharacter(p36) --[[ Line: 324 ]]
    -- upvalues: u8 (copy)
    for _, v37 in u8.IntialHumanoidDescription:GetAccessories(true) do
        if v37.AssetId == p36 then
            return true;
        end;
    end;
    return false;
end;
function u8.DoClearing() --[[ Line: 336 ]]
    -- upvalues: u8 (copy)
    for _, v38 in u8.AssetEquippedMemory do
        if v38 and v38[2] then
            v38[2]:Destroy();
        end;
    end;
    u8.EquippedExtras = {};
    u8.AssetEquippedMemory = {};
    u8.UpdateEquippedList();
    u8.CleanupAcessorieUIs();
end;
function u8.StartCharacterCopy() --[[ Line: 346 ]]
    -- upvalues: u8 (copy), l__RunService__5 (copy), u6 (copy), u7 (copy)
    if u8.FakeCharacter then
    elseif u8.Character then
        local u39 = u8.Character:Clone();
        local l__Animator__16 = u39.Humanoid.Animator;
        u39.Parent = game.Workspace;
        u39.Humanoid.NameDisplayDistance = 0;
        u39.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        u39.HumanoidRootPart.Anchored = true;
        u8.FakeCharacter = u39;
        local function u43(p40) --[[ Line: 360 ]]
            -- upvalues: l__Animator__16 (copy)
            local u41 = l__Animator__16:LoadAnimation(p40.Animation);
            p40:GetPropertyChangedSignal("IsPlaying"):Connect(function(p42) --[[ Line: 362 ]]
                -- upvalues: u41 (copy)
                if p42 then
                    u41:Play();
                else
                    u41:Stop();
                end;
            end);
            if p40.IsPlaying then
                u41:Play();
            else
                u41:Stop();
            end;
            u41.TimePosition = p40.TimePosition;
            u41:AdjustWeight(p40.WeightTarget);
            u41:AdjustSpeed(p40.Speed);
            p40.Destroying:Connect(function() --[[ Line: 377 ]]
                -- upvalues: u41 (copy)
                u41:Destroy();
            end);
        end;
        task.wait();
        task.wait();
        pcall(function() --[[ Line: 385 ]]
            -- upvalues: u8 (ref), u43 (copy)
            for _, v44 in u8.Animator:GetPlayingAnimationTracks() do
                u43(v44);
            end;
        end);
        u8.FakeAnimationPlayed = u8.Animator.AnimationPlayed:Connect(function(p45) --[[ Line: 391 ]]
            -- upvalues: u43 (copy)
            u43(p45);
        end);
        u8.FakeCharacterUpdate = l__RunService__5.RenderStepped:Connect(function() --[[ Line: 395 ]]
            -- upvalues: u8 (ref), u39 (copy)
            if u8.Character then
                u39:PivotTo(u8.Character:GetPivot());
            end;
        end);
        if u8.FakeCharacter and u8.LiteralAccessoriesList then
            u6.ModifyAccessories(u8.FakeCharacter.Humanoid, u8.IntialHumanoidDescription, u8.LiteralAccessoriesList, u8.EquippedExtras);
        end;
        l__RunService__5:UnbindFromRenderStep("CharacterTransparency");
        l__RunService__5:BindToRenderStep("CharacterTransparency", u7, function() --[[ Line: 406 ]]
            -- upvalues: u8 (ref)
            if u8.Character then
                for _, v46 in u8.Character:GetDescendants() do
                    if v46:IsA("BasePart") then
                        v46.LocalTransparencyModifier = 1;
                    elseif v46:IsA("Decal") then
                        v46.Transparency = 1;
                    end;
                end;
            end;
        end);
    end;
end;
function u8.EndCharacterCopy() --[[ Line: 420 ]]
    -- upvalues: l__RunService__5 (copy), u8 (copy)
    l__RunService__5:UnbindFromRenderStep("CharacterTransparency");
    if u8.Character then
        for _, v47 in u8.Character:GetDescendants() do
            if v47:IsA("BasePart") then
                v47.LocalTransparencyModifier = 0;
            elseif v47:IsA("Decal") then
                v47.Transparency = 0;
            end;
        end;
    end;
    if u8.FakeCharacterUpdate then
        u8.FakeCharacterUpdate:Disconnect();
        u8.FakeCharacterUpdate = nil;
    end;
    if u8.FakeAnimationPlayed then
        u8.FakeAnimationPlayed:Disconnect();
        u8.FakeAnimationPlayed = nil;
    end;
    if u8.FakeCharacter then
        u8.FakeCharacter:Destroy();
        u8.FakeCharacter = nil;
    end;
end;
function u8.NewCharacter(p48) --[[ Line: 449 ]]
    -- upvalues: l__LocalPlayer__7 (copy), u8 (copy), l__Players__6 (copy)
    if not l__LocalPlayer__7:HasAppearanceLoaded() then
        repeat
            task.wait();
        until l__LocalPlayer__7:HasAppearanceLoaded();
    end;
    local l__Humanoid__17 = p48:WaitForChild("Humanoid");
    local l__Animator__18 = l__Humanoid__17:WaitForChild("Animator");
    p48:WaitForChild("HumanoidRootPart");
    l__Humanoid__17:GetAppliedDescription():Clone();
    l__Humanoid__17.Died:Connect(function() --[[ Line: 460 ]]
        -- upvalues: u8 (ref)
        u8.Humanoid = nil;
        u8.Character = nil;
        u8.IntialHumanoidDescription = nil;
        u8.EndCharacterCopy();
        u8.DoClearing();
    end);
    u8.DoClearing();
    p48.Archivable = true;
    u8.Character = p48;
    u8.Humanoid = l__Humanoid__17;
    u8.Animator = l__Animator__18;
    u8.IntialHumanoidDescription = l__Players__6:GetHumanoidDescriptionFromUserId(l__LocalPlayer__7.UserId);
end;
function u8.Work() --[[ Line: 479 ]]
    -- upvalues: u8 (copy)
    u8.CurrentJob = u8.CurrentJob or 0;
    local v49 = u8;
    v49.CurrentJob = v49.CurrentJob + 1;
    if u8.CurrentJob > 100 then
        u8.CurrentJob = 0;
        task.wait();
    end;
end;
function u8.SetupUI() --[[ Line: 489 ]]
    -- upvalues: u8 (copy), u5 (copy), l__TweenService__4 (copy), l__MarketplaceService__2 (copy), l__LocalPlayer__7 (copy), u2 (copy), u3 (copy), l__AvatarEditorService__1 (copy)
    local v50 = u5.NewButton(u8.AccessoryItems.TweenFrame.CloseButton);
    u5.GetScreenGui("MainPriority");
    local l__TweenFrame__19 = u8.EquippedItems.TweenFrame;
    local v51 = u5.NewButton(l__TweenFrame__19.EquipToAvatar);
    local v52 = u5.NewButton(l__TweenFrame__19.SaveOutfit);
    u5.NewButton(l__TweenFrame__19.HideButton).Activated:Connect(function() --[[ Line: 501 ]]
        -- upvalues: u8 (ref), l__TweenService__4 (ref)
        local l__TweenFrame__20 = u8.EquippedItems.TweenFrame;
        u8.IsCollapsed = not u8.IsCollapsed;
        if u8.IsCollapsed then
            l__TweenFrame__20.HideButton.Rotation = 180;
            l__TweenService__4:Create(l__TweenFrame__20, u8.OpenTween, {
                Position = u8.Positions[1]
            }):Play();
        else
            l__TweenFrame__20.HideButton.Rotation = 0;
            l__TweenService__4:Create(l__TweenFrame__20, u8.OpenTween, {
                Position = u8.Positions[2]
            }):Play();
        end;
    end);
    v51.Activated:Connect(function() --[[ Line: 514 ]]
        -- upvalues: u8 (ref), l__MarketplaceService__2 (ref), l__LocalPlayer__7 (ref), u2 (ref), u3 (ref), l__AvatarEditorService__1 (ref)
        if u8.FakeCharacter and u8.FakeCharacter.Humanoid then
            local v53 = u8.FakeCharacter.Humanoid:GetAppliedDescription();
            local u54 = {};
            for u55, v56 in u8.AssetEquippedMemory do
                if not l__MarketplaceService__2:PlayerOwnsAsset(l__LocalPlayer__7, u55) then
                    local v57 = v56[1];
                    local u58 = false;
                    u2.Display(`You cant equip '{v57.Name}' because you dont own it. Would you like to purchase it?`, function() --[[ Line: 524 ]]
                        -- upvalues: u3 (ref), u55 (copy), u58 (ref)
                        u3.StartPurchase(u55);
                        u58 = true;
                    end, function() --[[ Line: 527 ]]
                        -- upvalues: u54 (copy), u55 (copy), u58 (ref)
                        u54[u55] = true;
                        u58 = true;
                    end);
                    repeat
                        task.wait();
                    until u58;
                end;
            end;
            local v59 = v53:GetAccessories(true);
            for v60 = #v59, 1, -1 do
                if u54[v59[v60].AssetId] then
                    table.remove(v59, v60);
                end;
            end;
            v53.Pants = u8.EquippedExtras.Pants or u8.IntialHumanoidDescription.Pants;
            v53.Shirt = u8.EquippedExtras.Shirt or u8.IntialHumanoidDescription.Shirt;
            v53:SetAccessories(v59, true);
            l__AvatarEditorService__1:PromptSaveAvatar(v53, u8.Humanoid.RigType);
        end;
    end);
    v52.Activated:Connect(function() --[[ Line: 551 ]]
        -- upvalues: u8 (ref), l__MarketplaceService__2 (ref), l__LocalPlayer__7 (ref), u2 (ref), u3 (ref), l__AvatarEditorService__1 (ref)
        if u8.FakeCharacter and u8.FakeCharacter.Humanoid then
            local v61 = u8.FakeCharacter.Humanoid:GetAppliedDescription();
            local u62 = {};
            for u63, v64 in u8.AssetEquippedMemory do
                if not l__MarketplaceService__2:PlayerOwnsAsset(l__LocalPlayer__7, u63) then
                    local v65 = v64[1];
                    local u66 = false;
                    u2.Display(`You cant add '{v65.Name}' to your outfit because you dont own it. Would you like to purchase it?`, function() --[[ Line: 561 ]]
                        -- upvalues: u3 (ref), u63 (copy), u66 (ref)
                        u3.StartPurchase(u63);
                        u66 = true;
                    end, function() --[[ Line: 564 ]]
                        -- upvalues: u62 (copy), u63 (copy), u66 (ref)
                        u62[u63] = true;
                        u66 = true;
                    end);
                    repeat
                        task.wait();
                    until u66;
                end;
            end;
            local v67 = v61:GetAccessories(true);
            for v68 = #v67, 1, -1 do
                if u62[v67[v68].AssetId] then
                    warn("removing....");
                    table.remove(v67, v68);
                end;
            end;
            v61.Pants = u8.EquippedExtras.Pants or u8.IntialHumanoidDescription.Pants;
            v61.Shirt = u8.EquippedExtras.Shirt or u8.IntialHumanoidDescription.Shirt;
            v61:SetAccessories(v67, true);
            l__AvatarEditorService__1:PromptCreateOutfit(v61, u8.Humanoid.RigType);
        end;
    end);
    v50.Activated:Connect(u8.HandleClose);
end;
function u8.Setup() --[[ Line: 593 ]]
    -- upvalues: u8 (copy), u5 (copy), u1 (copy), l__LocalPlayer__7 (copy), u4 (copy)
    u8.AccessoryItems = u5.Get("AccessoryItems", "RightFrame");
    u8.EquippedItems = u5.Get("AccessoryItems", "LeftFrame");
    u8.Trigger = u1.GetTrigger("GameStore");
    u8.Trigger.Entered:Connect(function() --[[ Line: 600 ]]
        -- upvalues: u8 (ref)
        u8.AccessoryItems.ScreenGui.Enabled = true;
        u8.StartCharacterCopy();
    end);
    u8.Trigger.Leaved:Connect(function() --[[ Line: 605 ]]
        -- upvalues: u8 (ref)
        u8.AccessoryItems.ScreenGui.Enabled = false;
        u8.EndCharacterCopy();
    end);
    u8.AccessoryItems.ScreenGui.Enabled = false;
    u8.EquippedItems.TweenFrame.Visible = false;
    u8.EquippedItems.TweenFrame.Position = u8.Positions[2];
    u8.SetupUI();
    l__LocalPlayer__7.CharacterAdded:Connect(u8.NewCharacter);
    if l__LocalPlayer__7.Character then
        u8.NewCharacter(l__LocalPlayer__7.Character);
    end;
    u4.InteractBegin:Connect(u8.HandleOpen);
end;
return u8;
