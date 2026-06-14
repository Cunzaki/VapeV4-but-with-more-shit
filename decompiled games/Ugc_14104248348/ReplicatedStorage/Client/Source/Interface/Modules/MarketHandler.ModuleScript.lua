-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.MarketHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("AvatarEditorService");
local l__Lighting__1 = game:GetService("Lighting");
local l__MarketplaceService__2 = game:GetService("MarketplaceService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__TweenService__4 = game:GetService("TweenService");
local l__UserInputService__5 = game:GetService("UserInputService");
local l__LocalPlayer__6 = game:GetService("Players").LocalPlayer;
local l__Signal__7 = require(l__ReplicatedStorage__3.Modules.Signal);
local l__Mince__8 = require(l__ReplicatedStorage__3.Modules.Mince);
require(l__ReplicatedStorage__3.Modules.Utility);
local u1 = l__Mince__8:Get("NotifPrompt");
local u2 = l__Mince__8:Get("SoundHandler");
local u3 = l__Mince__8:Get("GamepassHandler");
local u4 = l__Mince__8:Get("InterfaceHandler");
local u6 = {
    PurchaseInProgress = false,
    Tween = TweenInfo.new(0.5, Enum.EasingStyle.Quint),
    StatusTable = {},
    Listners = {},
    StatusChanged = l__Signal__7.new(),
    GetStatus = function(p5) --[[ Name: GetStatus, Line 33 ]]
        -- upvalues: u3 (copy)
        return u3:PlayerOwnsGamepass(u3:GetGamepassNameFromID(p5));
    end
};
function u6.ProcessStatus(p7, u8) --[[ Line: 37 ]]
    -- upvalues: u6 (copy), u3 (copy)
    if u6.GetStatus(p7) then
        return u8();
    end;
    local u9 = nil;
    u9 = u3:GetGamepassOwnershipChangedSignal(u3:GetGamepassNameFromID(p7)):Connect(function(_, _) --[[ Line: 43 ]]
        -- upvalues: u8 (copy), u9 (ref)
        u8();
        u9:Disconnect();
    end);
end;
function u6.StartPurchase(u10, u11) --[[ Line: 53 ]]
    -- upvalues: u6 (copy), l__MarketplaceService__2 (copy), l__LocalPlayer__6 (copy), u1 (copy)
    if u6.PurchaseInProgress then
    else
        u6.StartPause();
        local v12, v13 = pcall(function() --[[ Line: 58 ]]
            -- upvalues: l__MarketplaceService__2 (ref), l__LocalPlayer__6 (ref), u10 (copy), u11 (copy)
            return l__MarketplaceService__2:PromptPurchase(l__LocalPlayer__6, u10, u11);
        end);
        if v12 then
            local _, _, v14 = l__MarketplaceService__2.PromptPurchaseFinished:Wait();
            u6.EndPause();
            return v14;
        end;
        u1.Display((`Unexpected error whilst prompting ({v13})`));
    end;
end;
function u6.StartSubscriptionPurchase(u15) --[[ Line: 72 ]]
    -- upvalues: u6 (copy), l__MarketplaceService__2 (copy), l__LocalPlayer__6 (copy), u1 (copy)
    if u6.PurchaseInProgress then
    else
        u6.StartPause();
        local v16, v17 = pcall(function() --[[ Line: 77 ]]
            -- upvalues: l__MarketplaceService__2 (ref), l__LocalPlayer__6 (ref), u15 (copy)
            return l__MarketplaceService__2:PromptSubscriptionPurchase(l__LocalPlayer__6, u15);
        end);
        if v16 then
            l__MarketplaceService__2.PromptSubscriptionPurchaseFinished:Wait();
            u6.EndPause();
        else
            u1.Display((`Unexpected error whilst prompting ({v17})`));
        end;
    end;
end;
function u6.StartProductPurchase(u18) --[[ Line: 89 ]]
    -- upvalues: u6 (copy), l__MarketplaceService__2 (copy), l__LocalPlayer__6 (copy), u1 (copy)
    if u6.PurchaseInProgress then
    else
        u6.StartPause();
        local v19, v20 = pcall(function() --[[ Line: 94 ]]
            -- upvalues: l__MarketplaceService__2 (ref), l__LocalPlayer__6 (ref), u18 (copy)
            return l__MarketplaceService__2:PromptProductPurchase(l__LocalPlayer__6, u18);
        end);
        if v19 then
            l__MarketplaceService__2.PromptProductPurchaseFinished:Wait();
            u6.EndPause();
        else
            u1.Display((`Unexpected error whilst prompting ({v20})`));
        end;
    end;
end;
function u6.StartGamepassPurchase(u21) --[[ Line: 106 ]]
    -- upvalues: u1 (copy), u6 (copy), l__MarketplaceService__2 (copy), l__LocalPlayer__6 (copy)
    if u21 then
        if u6.PurchaseInProgress then
        else
            u6.StartPause();
            local v22, v23 = pcall(function() --[[ Line: 116 ]]
                -- upvalues: l__MarketplaceService__2 (ref), l__LocalPlayer__6 (ref), u21 (copy)
                return l__MarketplaceService__2:PromptGamePassPurchase(l__LocalPlayer__6, u21);
            end);
            local v24 = task.delay(5, u6.EndPause);
            if v22 then
                local _, _, _ = l__MarketplaceService__2.PromptGamePassPurchaseFinished:Wait();
                if coroutine.status(v24) == "suspended" then
                    task.cancel(v24);
                end;
                u6.EndPause();
            else
                u6.EndPause();
                u1.Display((`Unexpected error whilst prompting ({v23})`));
            end;
        end;
    else
        u1.Display("Unexpected Developer Problem: No GamepassID");
    end;
end;
function u6.StartPause() --[[ Line: 138 ]]
    -- upvalues: u6 (copy), u2 (copy)
    u6.Tweens.Start:Play();
    u6.Tweens.StartImage:Play();
    u2.PlaySound("dingshop");
    u6.PurchaseInProgress = true;
end;
function u6.EndPause() --[[ Line: 145 ]]
    -- upvalues: u6 (copy)
    u6.Tweens.End:Play();
    u6.Tweens.EndImage:Play();
    u6.PurchaseInProgress = false;
end;
function u6.SetupUI() --[[ Line: 152 ]]
    -- upvalues: u6 (copy), l__TweenService__4 (copy), l__UserInputService__5 (copy), l__Lighting__1 (copy)
    u6.Interface.Overlay.Visible = true;
    u6.Interface.Overlay.BackgroundTransparency = 1;
    u6.Tweens = {
        Start = l__TweenService__4:Create(u6.Interface.Overlay, u6.Tween, {
            BackgroundTransparency = 0.4
        }),
        StartImage = l__TweenService__4:Create(u6.Interface.Overlay.GIF, u6.Tween, {
            ImageTransparency = 0
        }),
        End = l__TweenService__4:Create(u6.Interface.Overlay, u6.Tween, {
            BackgroundTransparency = 1
        }),
        EndImage = l__TweenService__4:Create(u6.Interface.Overlay.GIF, u6.Tween, {
            ImageTransparency = 1
        })
    };
    if l__UserInputService__5.VREnabled then
        local v25 = Instance.new("ColorCorrectionEffect");
        v25.TintColor = Color3.fromRGB(255, 255, 255);
        v25.Name = "MarketHandlerCover";
        v25.Parent = l__Lighting__1;
        u6.Tweens.Start = l__TweenService__4:Create(v25, u6.Tween, {
            TintColor = Color3.fromRGB(153, 153, 153)
        });
        u6.Tweens.End = l__TweenService__4:Create(v25, u6.Tween, {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
    end;
end;
function u6.Setup() --[[ Line: 189 ]]
    -- upvalues: u6 (copy), u4 (copy)
    u6.Interface = u4.GetScreenGui("MainPriority");
    u6.SetupUI();
    u6.StatusChanged:Connect(function(p26, p27) --[[ Line: 194 ]]
        -- upvalues: u6 (ref)
        local v28 = u6.Listners[p26];
        if v28 then
            v28:Fire(p27);
        end;
    end);
end;
return u6;
