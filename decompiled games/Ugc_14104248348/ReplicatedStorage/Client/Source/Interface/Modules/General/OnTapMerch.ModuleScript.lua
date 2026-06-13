-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.OnTapMerch
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__CommerceService__2 = game:GetService("CommerceService");
local l__PolicyService__3 = game:GetService("PolicyService");
local l__LocalPlayer__4 = game:GetService("Players").LocalPlayer;
local u1 = l__PolicyService__3:GetPolicyInfoForPlayerAsync(l__LocalPlayer__4);
local l__Mince__5 = require(l__ReplicatedStorage__1.Modules.Mince);
l__Mince__5:GetEvent("InvShop"):Extend("PurchaseItem");
l__Mince__5:Get("ItemShop");
local u2 = l__Mince__5:Get("InterfaceHandler");
local u3 = {};
function u3.__SetupUI() --[[ Line: 19 ]]
    -- upvalues: u2 (copy), u3 (copy), l__Mince__5 (copy), l__CommerceService__2 (copy), l__LocalPlayer__4 (copy)
    u2.NewButton(u3.Interface.TweenFrame.CloseButton).Activated:Connect(function() --[[ Line: 21 ]]
        -- upvalues: u3 (ref)
        u3.Interface.Close();
    end);
    for v4, u5 in l__Mince__5.Config.Commerce do
        u2.NewButton(u3.Interface.TweenFrame[v4].ShopButton).Activated:Connect(function() --[[ Line: 27 ]]
            -- upvalues: l__CommerceService__2 (ref), l__LocalPlayer__4 (ref), u5 (copy)
            l__CommerceService__2:PromptCommerceProductPurchase(l__LocalPlayer__4, u5);
        end);
    end;
end;
function u3.Setup() --[[ Line: 33 ]]
    -- upvalues: u1 (copy), u3 (copy), u2 (copy)
    if u1.IsEligibleToPurchaseCommerceProduct then
        u3.Interface = u2.Get("Commerce");
        u3.__SetupUI();
    end;
end;
return u3;
