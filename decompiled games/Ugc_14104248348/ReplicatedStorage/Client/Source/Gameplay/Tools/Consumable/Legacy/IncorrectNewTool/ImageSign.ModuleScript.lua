-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Consumable.Legacy.IncorrectNewTool.ImageSign
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__MarketplaceService__2 = game:GetService("MarketplaceService");
game:GetService("CollectionService");
game:GetService("TweenService");
local _ = game:GetService("Players").LocalPlayer;
game.Players.LocalPlayer:GetMouse();
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__3:Get("Notices");
l__Mince__3:Get("Locomotion");
local u2 = l__Mince__3:Get("ToolHandler");
l__Mince__3:Get("SelectInteractor");
local u3 = l__Mince__3:Get("InterfaceHandler");
l__Mince__3:Get("SelectInteractor");
local u4 = l__Mince__3:GetEvent("ChangeImageSign");
local u5 = {
    Tags = { "SignImageGear" },
    Animations = {}
};
function u5.Equipped(p6) --[[ Line: 27 ]]
    -- upvalues: l__Mince__3 (copy), u5 (copy)
    if l__Mince__3.Config.Humanoid then
        local l__Tool__4 = p6.Tool;
        u5.ToolActive = true;
        u5.CurrentTool = l__Tool__4;
        u5.UI.Main.Visible = true;
        local l__Animations__5 = l__Tool__4:WaitForChild("Animations");
        u5.Animations = {};
        for _, v7 in l__Animations__5:GetChildren() do
            local v8 = l__Mince__3.Config.Humanoid.Animator:LoadAnimation(v7);
            if v8:GetAttribute("Speed") then
                v8:AdjustSpeed(v8:GetAttribute("Speed"));
            end;
            u5.Animations[v7.Name] = v8;
        end;
    end;
end;
function u5.Unequipped(_) --[[ Line: 51 ]]
    -- upvalues: u5 (copy)
    u5.ToolActive = false;
    u5.HoldingOut = false;
    u5.UI.Main.Visible = false;
    for _, v9 in u5.Animations do
        v9:Stop();
    end;
end;
function u5.SetupUI() --[[ Line: 61 ]]
    -- upvalues: u3 (copy), u5 (copy), u1 (copy), l__MarketplaceService__2 (copy), u4 (copy)
    u3.NewButton(u5.UI.Main.TextBox.OkayButton).Activated:Connect(function() --[[ Line: 64 ]]
        -- upvalues: u5 (ref), u1 (ref), l__MarketplaceService__2 (ref), u4 (ref)
        local u10 = tonumber(u5.UI.Main.TextBox.TextBox.Text);
        if u10 then
            local v11, v12 = pcall(function() --[[ Line: 68 ]]
                -- upvalues: l__MarketplaceService__2 (ref), u10 (copy)
                return l__MarketplaceService__2:GetProductInfo(u10, Enum.InfoType.Asset);
            end);
            if v11 then
                u5.IsDecal = false;
                if v12.IconImageAssetId and v12.IconImageAssetId ~= 0 then
                    if v12.AssetTypeId ~= 1 then
                        u10 = v12.IconImageAssetId;
                    end;
                elseif not v12 or v12.AssetTypeId ~= 1 then
                    if v12.AssetTypeId ~= 13 then
                        u1.Error("Failed to retrieve IconImageAssetId!");
                        return;
                    end;
                    u5.IsDecal = true;
                end;
                u1.CreateNotice("Image changed!");
                u5.CurrentDecal = u10;
                u4:Fire(u5.CurrentDecal, u5.IsDecal);
            else
                u1.Error("Invalid ID or failed to retrieve info!");
            end;
        else
            return u1.Error("Invalid ID!");
        end;
    end);
end;
function u5.Setup() --[[ Line: 102 ]]
    -- upvalues: u5 (copy), u3 (copy), u2 (copy)
    u5.UI = u3.GetScreenGui("ImgSignUI");
    u5.SetupUI();
    u2.Component(u5);
end;
return u5;
