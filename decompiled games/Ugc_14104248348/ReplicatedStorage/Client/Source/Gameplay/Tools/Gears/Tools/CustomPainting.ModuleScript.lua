-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Tools.CustomPainting
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__MarketplaceService__1 = game:GetService("MarketplaceService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("Players");
local l__Mince__3 = require(l__ReplicatedStorage__2.Modules.Mince);
local u1 = l__Mince__3:Get("Notices");
local u2 = l__Mince__3:Get("ToolHandler");
local u3 = l__Mince__3:Get("InterfaceHandler");
local u4 = l__Mince__3:GetEvent("ChangePainting");
local u5 = {
    InteractBind = 500,
    Tags = { "CustomPainting" }
};
function u5.Equipped(p6) --[[ Line: 20 ]]
    -- upvalues: u5 (copy)
    local v7 = p6.Tool:GetAttribute("AssetID");
    local v8 = p6.Tool:FindFirstChildWhichIsA("Decal", true);
    if v8 and v7 then
        if p6.Tool:GetAttribute("IsDecal") then
            u5.MainFrame.Preview.Image = `rbxthumb://type=Asset&id={v7}&w=420&h=420`;
        else
            u5.MainFrame.Preview.Image = `http://www.roblox.com/asset/?id={v7}`;
        end;
    elseif not (v7 and v8) then
        u5.MainFrame.Preview.Image = "";
    end;
    u5.Interface:Open();
end;
function u5.Unequipped(_) --[[ Line: 36 ]]
    -- upvalues: u5 (copy)
    u5.Interface:Close();
end;
function u5.SetupGUI() --[[ Line: 40 ]]
    -- upvalues: u3 (copy), u5 (copy), u1 (copy), l__MarketplaceService__1 (copy), u4 (copy)
    u3.NewButton(u5.MainFrame.TextBox.OkayButton).Activated:Connect(function() --[[ Line: 41 ]]
        -- upvalues: u5 (ref), u1 (ref), l__MarketplaceService__1 (ref), u4 (ref)
        local u9 = tonumber(u5.MainFrame.TextBox.TextBox.Text);
        if u9 then
            local v10, v11 = pcall(function() --[[ Line: 45 ]]
                -- upvalues: l__MarketplaceService__1 (ref), u9 (copy)
                return l__MarketplaceService__1:GetProductInfo(u9, Enum.InfoType.Asset);
            end);
            if v10 then
                local v12 = false;
                if v11.IconImageAssetId and v11.IconImageAssetId ~= 0 then
                    if v11.AssetTypeId ~= 1 then
                        u9 = v11.IconImageAssetId;
                    end;
                elseif not v11 or v11.AssetTypeId ~= 1 then
                    if v11.AssetTypeId ~= 13 then
                        u1.Error("Failed to retrieve IconImageAssetId!");
                        return;
                    end;
                    v12 = true;
                end;
                if v12 then
                    u5.MainFrame.Preview.Image = `rbxthumb://type=Asset&id={u9}&w=420&h=420`;
                else
                    u5.MainFrame.Preview.Image = `http://www.roblox.com/asset/?id={u9}`;
                end;
                u4:Fire(u9, v12);
                u1.CreateNotice("Image changed!");
            else
                u1.Error("Invalid ID or failed to retrieve info!");
            end;
        else
            return u1.Error("Invalid ID!");
        end;
    end);
end;
function u5.Setup() --[[ Line: 81 ]]
    -- upvalues: u5 (copy), u3 (copy), u2 (copy)
    u5.Interface = u3.Get("PaintingUI");
    u5.MainFrame = u5.Interface.TweenFrame;
    u5.SetupGUI();
    u2.Component(u5);
end;
return u5;
