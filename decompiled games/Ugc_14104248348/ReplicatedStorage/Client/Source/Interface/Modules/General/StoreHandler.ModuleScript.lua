-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.StoreHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__MarketplaceService__1 = game:GetService("MarketplaceService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__PolicyService__3 = game:GetService("PolicyService");
local l__LocalPlayer__4 = game:GetService("Players").LocalPlayer;
local u1 = l__PolicyService__3:GetPolicyInfoForPlayerAsync(l__LocalPlayer__4);
local l__Mince__5 = require(l__ReplicatedStorage__2.Modules.Mince);
local l__Numerics__6 = require(l__ReplicatedStorage__2.Modules.Numerics);
local l__RarityUtil__7 = require(l__ReplicatedStorage__2.Modules.RarityUtil);
local l__LootboxUtil__8 = require(l__ReplicatedStorage__2.Modules.LootboxUtil);
local u2 = l__Mince__5:Get("PlayerList");
local u3 = l__Mince__5:Get("ConfirmPrompt");
local u4 = l__Mince__5:Get("MarketHandler");
local u5 = l__Mince__5:Get("Inventory");
local u6 = l__Mince__5:Get("OpeningHandler");
local u7 = l__Mince__5:Get("InterfaceHandler");
local u8 = l__Mince__5:Get("CoinController");
local u9 = l__Mince__5:Get("GamepassHandler");
local u10 = l__Mince__5:GetEvent("RequestConvert");
local u11 = l__Mince__5:GetFunction("LootboxRequest");
local u12 = l__Mince__5:GetEvent("SelectGiftingPerson");
local u13 = l__Mince__5:GetFunction("GetGamepassDetailing");
local u14 = l__Mince__5:GetFunction("DoGiftProductStart");
local u15 = {
    __IsAsyncSetup = true,
    SetupMethod = {}
};
function u15.SetupMethod.Subscription(p16, p17) --[[ Line: 39 ]]
    -- upvalues: l__Mince__5 (copy), u7 (copy), u4 (copy)
    local l__Container__9 = p16:WaitForChild("Container");
    local u18 = l__Mince__5.Config.Products.Subscriptions[p17];
    u7.NewButton(l__Container__9.Purchase).Activated:Connect(function() --[[ Line: 43 ]]
        -- upvalues: u4 (ref), u18 (copy)
        u4.StartSubscriptionPurchase(u18);
    end);
end;
function u15.SetupMethod.ExclusiveSection(p19, p20) --[[ Line: 48 ]]
    -- upvalues: l__Mince__5 (copy), u1 (copy), l__LootboxUtil__8 (copy), u5 (copy), l__RarityUtil__7 (copy), l__ReplicatedStorage__2 (copy), l__Numerics__6 (copy), u7 (copy), u3 (copy), u11 (copy), u6 (copy)
    p19.Visible = l__Mince__5.Config.HolidayConfigure.SHOW_EVENT_LOOTBOX;
    local l__Container__10 = p19:WaitForChild("Container");
    if u1.ArePaidRandomItemsRestricted then
        l__Container__10.Visible = false;
        p19.RegionWarning.Visible = true;
    else
        l__Container__10.Visible = true;
        p19.RegionWarning.Visible = false;
        local u21 = l__Mince__5.Config.HolidayConfigure.BUYLOOTBOXID or p20;
        local u22 = l__LootboxUtil__8.GetLootbox(u21);
        local v23 = `Failed to load the lootbox by the name of '{u21}'!`;
        assert(u22, v23);
        local function v31(p24, p25) --[[ Line: 65 ]]
            -- upvalues: u5 (ref), l__RarityUtil__7 (ref), l__ReplicatedStorage__2 (ref)
            local v26 = u5.Items[p25.IVID];
            local v27 = l__RarityUtil__7.GetRarity(v26.Rarity).GetColors();
            p24.Button.Icon.Image = v26.Category.Icon;
            p24.Button.Render.Image = v26.Render;
            p24.Button.UIGradient.Color = v27.Graident;
            p24.Button.UIStroke.UIGradient.Color = v27.Graident;
            local l__Chance__11 = p24.Button.Chance;
            local l__format__12 = string.format;
            local v28 = -math.log10(p25.Chance);
            local v29 = math.ceil(v28);
            l__Chance__11.Text = l__format__12(`%.{math.max(0, v29)}f%%`, 100 * p25.Chance);
            if v26.Extra then
                local v30 = l__ReplicatedStorage__2.Assets.Interface.Extra:FindFirstChild(v26.Extra);
                if v30 then
                    v30:Clone().Parent = p24.Button;
                    return;
                end;
                warn((`Could not find the extra for '{v26.Extra}'`));
            end;
        end;
        local v32 = u22.Chances[#u22.Chances];
        if v32 then
            v31(l__Container__10.ChanceItem, v32);
        end;
        for v33 = #u22.Chances - 1, 1, -1 do
            local v34 = l__ReplicatedStorage__2.Assets.Interface.ChanceItem:Clone();
            v34.Size = UDim2.new(0.235, 0, 0.494, 0);
            v34.Parent = l__Container__10.Others;
            v31(v34, u22.Chances[v33]);
        end;
        l__Container__10.Purchase.CoinLabel.Text = l__Numerics__6.WithCommas(u22.Cost.Amount);
        u7.NewButton(l__Container__10.Purchase).Activated:Connect(function() --[[ Line: 103 ]]
            -- upvalues: u3 (ref), u22 (copy), u11 (ref), u21 (copy), u6 (ref)
            u3.Display(`Are you sure you want to purcahse this for {u22.Cost.Amount} {u22.Cost.Currency}?`, function() --[[ Line: 104 ]]
                -- upvalues: u11 (ref), u21 (ref), u6 (ref)
                local v35, v36 = pcall(function() --[[ Line: 105 ]]
                    -- upvalues: u11 (ref), u21 (ref)
                    return u11:Invoke(u21);
                end);
                if v35 and v36 then
                    u6.StartFireworkOpening({
                        IVID = v36
                    });
                end;
            end);
        end);
    end;
end;
function u15.SetupMethod.Gamepass(u37, u38) --[[ Line: 118 ]]
    -- upvalues: u9 (copy), l__MarketplaceService__1 (copy), u15 (copy), u7 (copy), l__Mince__5 (copy), u13 (copy), u2 (copy), l__LocalPlayer__4 (copy), u12 (copy), u4 (copy), l__Numerics__6 (copy)
    local u39 = u9:GetGamepassIDFromName(u38);
    local v40, v41 = pcall(function() --[[ Line: 120 ]]
        -- upvalues: l__MarketplaceService__1 (ref), u39 (copy)
        return l__MarketplaceService__1:GetProductInfo(u39, Enum.InfoType.GamePass);
    end);
    if v40 then
        local v42 = u7.NewButton(u37.Purchase);
        local u43 = l__Mince__5.Config.Products.Gamepasses[u9:GetGamepassNameFromID(u39)];
        local u44 = u13:Invoke(u38);
        u7.NewButton(u37.Gift).Activated:Connect(function() --[[ Line: 137 ]]
            -- upvalues: u2 (ref), u37 (copy), u44 (copy), l__LocalPlayer__4 (ref), u12 (ref), u4 (ref), u43 (copy)
            u2:OpenList({
                CloseWhenSelect = true,
                Title = `Gift '{u37.Title.Text}'`,
                ApplyToAll = {
                    ButtonText = "Gift"
                },
                ForEach = function(p45, p46) --[[ Name: ForEach, Line 144 ]]
                    -- upvalues: u44 (ref), l__LocalPlayer__4 (ref)
                    if u44[tostring(p46.UserId)] then
                        p45:SetVisible(true);
                        p45:Apply({
                            ButtonGone = true,
                            ButtonText = "Owns Already"
                        });
                    else
                        p45:SetVisible(p46 ~= l__LocalPlayer__4);
                    end;
                end,
                WhenPressed = function(_, p47) --[[ Name: WhenPressed, Line 156 ]]
                    -- upvalues: u12 (ref), u4 (ref), u43 (ref)
                    u12:Fire(p47);
                    u4.StartProductPurchase(u43.DevProduct);
                end
            });
        end);
        u4.ProcessStatus(u39, function() --[[ Line: 163 ]]
            -- upvalues: u37 (copy)
            u37.Purchase.Visible = false;
            u37.Owned.Visible = true;
        end);
        v42.Activated:Connect(function() --[[ Line: 168 ]]
            -- upvalues: u4 (ref), u39 (copy)
            u4.StartGamepassPurchase(u39);
        end);
        if v41.PriceInRobux then
            u37.Purchase.Text = l__Numerics__6.WithCommas(v41.PriceInRobux);
        else
            u37.Purchase.Text = "???";
        end;
    else
        task.delay(5, function() --[[ Line: 126 ]]
            -- upvalues: u15 (ref), u37 (copy), u38 (copy)
            u15.SetupMethod.Gamepass(u37, u38);
        end);
    end;
end;
function u15.SetupMethod.EventSection(p48) --[[ Line: 179 ]]
    -- upvalues: l__Mince__5 (copy), l__Numerics__6 (copy), u7 (copy), u3 (copy), u10 (copy)
    for _, v49 in p48:GetChildren() do
        if v49:IsA("Frame") then
            local u50 = v49:GetAttributes();
            local u51, u52 = table.unpack(l__Mince__5.Config.HolidayConfigure.EVENT_CONVERT[u50.Index]);
            v49.Title.Text = `Convert {u50.Index}`;
            v49.AmountLabel.Text = l__Numerics__6.WithCommas(u52);
            v49.Purchase.CoinLabel.Text = l__Numerics__6.WithCommas(u51);
            u7.NewButton(v49.Purchase).Activated:Connect(function() --[[ Line: 189 ]]
                -- upvalues: u3 (ref), u51 (copy), u52 (copy), l__Mince__5 (ref), u10 (ref), u50 (copy)
                u3.Display(`Are you sure you want to exchange {u51} Coins, for {u52} {l__Mince__5.Config.HolidayConfigure.EVENT_CURRENCY_NAME}`, function() --[[ Line: 190 ]]
                    -- upvalues: u10 (ref), u50 (ref)
                    u10:Fire(u50.Index);
                end);
            end);
        end;
    end;
end;
function u15.SetupMethod.CurrencySection(p53, u54) --[[ Line: 198 ]]
    -- upvalues: l__Mince__5 (copy), l__Numerics__6 (copy), u7 (copy), u2 (copy), l__LocalPlayer__4 (copy), u14 (copy), u4 (copy)
    assert(l__Mince__5.Config.Products.Dev[u54], "");
    for _, u55 in p53:GetChildren() do
        if u55:IsA("Frame") then
            local v56 = u55:GetAttributes();
            local v57 = l__Mince__5.Config.Products.Dev[u54][tonumber(v56.Position)];
            local u58, v59 = table.unpack(v57);
            local u60 = l__Mince__5.Config.Products.Dev[`{u54}Gift`][tonumber(v56.Position)];
            u55.AmountLabel.Text = l__Numerics__6.WithCommas(v59);
            u7.NewButton(u55.Gift).Activated:Connect(function() --[[ Line: 210 ]]
                -- upvalues: u2 (ref), u54 (copy), u55 (copy), l__LocalPlayer__4 (ref), u14 (ref), u60 (copy), u4 (ref)
                u2:OpenList({
                    CloseWhenSelect = true,
                    Title = `Gift {u54} '{u55.Title.Text}'`,
                    ApplyToAll = {
                        ButtonText = "Gift"
                    },
                    ForEach = function(p61, p62) --[[ Name: ForEach, Line 217 ]]
                        -- upvalues: l__LocalPlayer__4 (ref)
                        p61:SetVisible(p62 ~= l__LocalPlayer__4);
                    end,
                    WhenPressed = function(_, u63) --[[ Name: WhenPressed, Line 220 ]]
                        -- upvalues: u14 (ref), u60 (ref), u4 (ref)
                        local v64, v65 = pcall(function() --[[ Line: 221 ]]
                            -- upvalues: u14 (ref), u63 (copy), u60 (ref)
                            return u14:Invoke(u63, u60);
                        end);
                        if v64 and (v65 and v65 == "StartProductPrompting") then
                            u4.StartProductPurchase(u60);
                        end;
                        warn(v64, v65);
                    end
                });
            end);
            u7.NewButton(u55.Purchase).Activated:Connect(function() --[[ Line: 234 ]]
                -- upvalues: u4 (ref), u58 (copy)
                u4.StartProductPurchase(u58);
            end);
        end;
    end;
end;
function u15.SetupMethod.GamepassSection(p66) --[[ Line: 241 ]]
    -- upvalues: u9 (copy), u15 (copy)
    for _, u67 in p66:GetChildren() do
        if u67:IsA("Frame") then
            task.defer(function() --[[ Line: 244 ]]
                -- upvalues: u67 (copy), u9 (ref), u15 (ref)
                local v68 = u67:GetAttribute("Name");
                if u9:GetGamepassIDFromName(v68) then
                    u15.SetupMethod.Gamepass(u67, v68);
                end;
            end);
        end;
    end;
end;
function u15.SetupGUI() --[[ Line: 255 ]]
    -- upvalues: u7 (copy), u15 (copy)
    local v69 = u7.NewButton(u15.Interface.TweenFrame.CloseButton);
    local v70 = u7.NewButton(u15.MainPriority.Coins.Add);
    local v71 = u7.NewButton(u15.MainPriority.Holiday.Add);
    v70.Activated:Connect(function() --[[ Line: 259 ]]
        -- upvalues: u15 (ref)
        u15.Interface.Switch();
    end);
    v71.Activated:Connect(function() --[[ Line: 263 ]]
        -- upvalues: u15 (ref)
        u15.Interface.Switch();
    end);
    v69.Activated:Connect(function() --[[ Line: 268 ]]
        -- upvalues: u15 (ref)
        u15.Interface.Close();
    end);
    for _, v72 in u15.Interface.TweenFrame.Container:GetChildren() do
        if v72:IsA("Frame") then
            local v73 = v72:GetAttribute("Type");
            local v74 = v72:GetAttribute("Name");
            if v73 then
                v73 = u15.SetupMethod[v73];
            end;
            if v73 then
                v73(v72, v74);
            end;
        end;
    end;
end;
function u15.Trigger() --[[ Line: 288 ]]
    -- upvalues: u15 (copy)
    u15.Interface.Trigger();
end;
function u15.Setup() --[[ Line: 292 ]]
    -- upvalues: u15 (copy), u7 (copy), u8 (copy)
    u15.Interface = u7.Get("Shop");
    u15.MainPriority = u7.GetScreenGui("MainPriority");
    u15.Interface.Opened:Connect(function() --[[ Line: 296 ]]
        -- upvalues: u8 (ref)
        u8.SetForceEnabled(true);
    end);
    u15.Interface.Closed:Connect(function() --[[ Line: 300 ]]
        -- upvalues: u8 (ref)
        u8.SetForceEnabled(false);
    end);
    u15.SetupGUI();
end;
return u15;
