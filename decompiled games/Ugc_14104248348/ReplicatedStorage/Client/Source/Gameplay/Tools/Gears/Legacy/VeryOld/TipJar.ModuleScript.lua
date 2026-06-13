-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Legacy.VeryOld.TipJar
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("MarketplaceService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Players__2 = game:GetService("Players");
local l__LocalPlayer__3 = l__Players__2.LocalPlayer;
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Numerics__5 = require(l__ReplicatedStorage__1.Modules.Numerics);
local u1 = l__Mince__4:Get("InterfaceHandler");
local u2 = l__Mince__4:Get("MarketHandler");
local u3 = l__Mince__4:Get("SelectInteractor");
local u4 = l__Mince__4:GetEvent("RequestRobuxTransfer");
local u5 = l__Mince__4:Get("ConfirmPrompt");
local u6 = l__Mince__4:GetEvent("RefreshTipJar");
local u7 = {
    MainFrame = nil,
    ActivePlayer = nil,
    Icons = {
        Robux = "",
        Premium = "",
        Verified = ""
    },
    LoadedProducts = {}
};
function u7.UpdateScroll() --[[ Line: 37 ]]
    -- upvalues: u7 (copy)
    local v8 = -1;
    for _, v9 in u7.Donate.TweenFrame.Scroll:GetChildren() do
        if v9:IsA("ImageButton") and v8 < v9.AbsolutePosition.X then
            v8 = v9.AbsolutePosition.X + v9.AbsoluteSize.X;
        end;
    end;
    local v10 = math.max(v8 / u7.Donate.TweenFrame.Scroll.AbsoluteSize.X, 1);
    u7.Donate.TweenFrame.Scroll.CanvasSize = UDim2.fromScale(v10, 0);
end;
function u7.GenerateName(p11) --[[ Line: 54 ]]
    -- upvalues: u7 (copy)
    local v12 = "";
    if p11.MembershipType == Enum.MembershipType.Premium then
        v12 = v12 .. u7.Icons.Premium;
    end;
    if p11.HasVerifiedBadge then
        v12 = v12 .. u7.Icons.Verified;
    end;
    return `{p11.Name}{v12}`;
end;
function u7.DonatePlayer(p13) --[[ Line: 66 ]]
    -- upvalues: u3 (copy), u7 (copy), l__LocalPlayer__3 (copy), l__ReplicatedStorage__1 (copy), u1 (copy), u2 (copy), u5 (copy), l__Numerics__5 (copy)
    local v14 = p13:FindFirstChild("Products");
    if not v14 then
        return u3.EndInteractions();
    end;
    u7.Donate.TweenFrame.RefreshButton.Visible = p13 == l__LocalPlayer__3;
    u7.Donate:Switch();
    u7.ActivePlayer = p13;
    u7.MainFrame.PlayerName.Text = u7.GenerateName(p13);
    for _, v15 in u7.LoadedProducts do
        v15:Destroy();
    end;
    for _, v16 in v14:GetChildren() do
        local u17 = v16:GetAttributes();
        local v18 = l__ReplicatedStorage__1.Assets.Interface.RobuxItem:Clone();
        if u17.Price ~= "?" then
            u1.ScaleDescedantsStrokes(v18, u7.Donate.ScreenGui);
            u1.NewButton(v18).Activated:Connect(function() --[[ Line: 92 ]]
                -- upvalues: u17 (copy), u2 (ref), u5 (ref)
                u5.Display("Are you sure? Donations are NOT recorded for this type.", function() --[[ Line: 101 ]]
                    -- upvalues: u17 (ref), u2 (ref)
                    if u17.Type == "Gamepass" then
                        u2.StartGamepassPurchase(u17.ItemID);
                    else
                        u2.StartPurchase(u17.ItemID);
                    end;
                end);
            end);
            v18.LayoutOrder = u17.Price;
            v18.RobuxCount.Text = `{l__Numerics__5.WithCommas(u17.Price)}`;
            v18.Parent = u7.Donate.TweenFrame.Scroll;
            table.insert(u7.LoadedProducts, v18);
        end;
    end;
    u7.UpdateScroll();
end;
function u7.SetupJars() --[[ Line: 118 ]]
    -- upvalues: l__Mince__4 (copy), l__Players__2 (copy), u7 (copy), u3 (copy), u1 (copy), u6 (copy)
    l__Mince__4.SetupComponent("TipJar", function(u19) --[[ Line: 119 ]]
        -- upvalues: l__Players__2 (ref), u7 (ref), u3 (ref)
        local function u23() --[[ Line: 120 ]]
            -- upvalues: u19 (copy), l__Players__2 (ref), u7 (ref), u3 (ref)
            local v22 = {
                HitCollider = u19.Instance:WaitForChild("Handle"),
                Target = u19.Instance,
                HoverName = "Tip Jar",
                Interact = function(_, p20) --[[ Name: Interact, Line 129 ]]
                    -- upvalues: l__Players__2 (ref), u19 (ref), u7 (ref)
                    local v21 = l__Players__2:GetPlayerFromCharacter(u19.Instance.Parent);
                    if not v21 then
                        return p20();
                    end;
                    u7.DonatePlayer(v21);
                end
            };
            u3.NewInteractionClass(v22);
        end;
        local function u25() --[[ Line: 142 ]]
            -- upvalues: u19 (copy), l__Players__2 (ref)
            local v24 = false;
            if u19.Instance.Parent then
                if u19.Instance.Parent:IsA("Backpack") then
                    return true;
                end;
                v24 = u19.Instance.Parent:IsA("Model") and l__Players__2:GetPlayerFromCharacter(u19.Instance.Parent) and true or v24;
            end;
            return v24;
        end;
        if u19.DontRegisterWhenNotToolLocation then
            if u25() then
                u23();
            else
                local u26 = nil;
                u26 = u19.Instance.AncestryChanged:Connect(function() --[[ Line: 161 ]]
                    -- upvalues: u25 (copy), u26 (ref), u23 (copy)
                    if u25() then
                        u26:Disconnect();
                        u23();
                    end;
                end);
            end;
        else
            u23();
        end;
    end);
    u1.NewButton(u7.Donate.TweenFrame.RefreshButton).Activated:Connect(function() --[[ Line: 179 ]]
        -- upvalues: u6 (ref)
        u6:Fire();
    end);
    u1.NewButton(u7.Donate.TweenFrame.CloseButton).Activated:Connect(function() --[[ Line: 182 ]]
        -- upvalues: u7 (ref), u3 (ref)
        u7.Donate.Close();
        u3.EndInteractions();
    end);
end;
function u7.SetupDirectDeposit() --[[ Line: 188 ]]
    -- upvalues: u1 (copy), u7 (copy), u3 (copy), u4 (copy), u5 (copy)
    u1.NewButton(u7.DirectDonationMain.CloseButton).Activated:Connect(function() --[[ Line: 189 ]]
        -- upvalues: u3 (ref), u7 (ref)
        u3.EndInteractions();
        u7.DirectDonation.Close();
    end);
    u1.NewButton(u7.MainFrame.Scroll.Direct).Activated:Connect(function() --[[ Line: 195 ]]
        -- upvalues: u7 (ref)
        u7.DirectDonation.Open();
    end);
    local l__Donate__6 = u7.DirectDonationMain:WaitForChild("Donate");
    u1.NewButton(l__Donate__6).Activated:Connect(function() --[[ Line: 200 ]]
        -- upvalues: u7 (ref), u4 (ref), u3 (ref), u5 (ref)
        u5.Display("Are you sure? Donations / stats may not appear sometimes due to API issues.", function() --[[ Line: 217 ]]
            -- upvalues: u7 (ref), u4 (ref), u3 (ref)
            u4:Fire(u7.ActivePlayer, u7.DirectDonationMain.Amount.Text);
            u7.DirectDonation.Close();
            u3.EndInteractions();
        end, function() --[[ Line: 219 ]]
            -- upvalues: u7 (ref), u3 (ref)
            u7.DirectDonation.Close();
            u3.EndInteractions();
        end);
    end);
end;
function u7.Setup() --[[ Line: 225 ]]
    -- upvalues: u7 (copy), u1 (copy)
    u7.Donate = u1.Get("Donate");
    u7.MainFrame = u7.Donate.TweenFrame;
    u7.DirectDonation = u1.Get("DonatePopup");
    u7.DirectDonationMain = u7.DirectDonation.TweenFrame;
    u7.SetupJars();
    u7.SetupDirectDeposit();
end;
return u7;
