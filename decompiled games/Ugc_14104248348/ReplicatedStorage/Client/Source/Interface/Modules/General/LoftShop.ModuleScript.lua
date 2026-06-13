-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.LoftShop
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Module3D__4 = require(l__ReplicatedStorage__1.Modules.Module3D);
local u1 = l__Mince__3:Get("UserProfile");
local u2 = l__Mince__3:Get("ConfirmPrompt");
local u3 = l__Mince__3:Get("InterfaceHandler");
local u4 = l__Mince__3:GetEvent("LoftShop"):Extend("BuyItem");
local u5 = {
    Items = {},
    ItemByName = {}
};
local u6 = {};
u6.__index = u6;
function u6.new(...) --[[ Line: 24 ]]
    -- upvalues: u6 (copy)
    local v7 = setmetatable({}, u6);
    v7:Init(...);
    return v7;
end;
function u6.Init(u8, u9) --[[ Line: 30 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u3 (copy), u4 (copy), u2 (copy), l__Module3D__4 (copy), u5 (copy)
    u8.Item = u9;
    u8.Item.Offset = u8.Item.Offset or CFrame.Angles(0, 0, 0);
    u8.PlacementModel = l__ReplicatedStorage__1.Assets.Placements:WaitForChild(u8.Item.Placement);
    u8.Placement = u8.PlacementModel:Clone();
    u8.GUI = l__ReplicatedStorage__1.Assets.Interface.ShopItem:Clone();
    u8.GUI.ItemName.Text = u8.Item.Name;
    u8.GUI.ItemDesc.Text = u8.Item.Description;
    u8.GUI.CreateButton.CoinLabel.Text = u8.Item.Price;
    u8.Index = u9.Index;
    u3.NewButton(u8.GUI.UseButton).Activated:Connect(function() --[[ Line: 43 ]]
        -- upvalues: u4 (ref), u9 (copy)
        u4:Fire(u9.Index);
    end);
    u3.NewButton(u8.GUI.CreateButton).Activated:Connect(function() --[[ Line: 47 ]]
        -- upvalues: u2 (ref), u8 (copy), u4 (ref), u9 (copy)
        u2.Display(`Are you sure you want to buy '{u8.Item.Name}' for {u8.Item.Price} Coins?`, function() --[[ Line: 48 ]]
            -- upvalues: u4 (ref), u9 (ref)
            u4:Fire(u9.Index);
        end);
    end);
    u8.GUI.Container.MouseEnter:Connect(function() --[[ Line: 53 ]]
        -- upvalues: u8 (copy)
        u8:Start();
    end);
    u8.GUI.Container.MouseLeave:Connect(function() --[[ Line: 57 ]]
        -- upvalues: u8 (copy)
        u8:Stop();
    end);
    u8.Model3D = l__Module3D__4:Attach3D(u8.GUI.Container, u8.Placement);
    u8.Model3D:SetDepthMultiplier(1.2);
    u8.Model3D.CurrentCamera.FieldOfView = 5;
    u8.Model3D.Visible = true;
    u8.Model3D:SetCFrame(u8.Item.Offset);
    u8.GUI.LayoutOrder = 0;
    u8.GUI.Parent = u5.Scroll;
    if u8.Item.NotPurchasable then
        u8.GUI.CreateButton.Visible = false;
    end;
end;
function u6.UpdateSaved(p10, p11) --[[ Line: 76 ]]
    p10.SavedCount = p11;
    p10.GUI.UseButton.AmountLabel.Text = `Use ( {p11} )`;
    if not p10.Item.NotPurchasable then
        p10.GUI.CreateButton.Visible = p10.SavedCount == 0;
    end;
    p10.GUI.UseButton.Visible = p10.SavedCount > 0;
end;
function u6.Start(u12) --[[ Line: 88 ]]
    -- upvalues: l__RunService__2 (copy)
    u12:Stop();
    u12.TimeElapsed = 0;
    u12.__SpinEvent = l__RunService__2.RenderStepped:Connect(function(p13) --[[ Line: 91 ]]
        -- upvalues: u12 (copy)
        local v14 = u12;
        v14.TimeElapsed = v14.TimeElapsed + p13;
        u12.Model3D:SetCFrame(CFrame.Angles(0, u12.TimeElapsed % 6.283185307179586, 0) * u12.Item.Offset);
    end);
end;
function u6.Stop(p15) --[[ Line: 97 ]]
    if p15.__SpinEvent then
        p15.__SpinEvent:Disconnect();
    end;
    p15.Model3D:SetCFrame(p15.Item.Offset);
end;
function u5.SetupGui() --[[ Line: 104 ]]
    -- upvalues: u3 (copy), u5 (copy), l__Mince__3 (copy), u6 (copy)
    u3.NewButton(u5.MainFrame.CloseButton).Activated:Connect(u5.Interface.Close);
    u3.AutoSizeScrollingFrame(u5.Scroll);
    local v16 = {};
    for v17, v18 in l__Mince__3.Config.LoftShopItems do
        v18.Index = v17;
        table.insert(v16, v18);
    end;
    table.sort(v16, function(p19, p20) --[[ Line: 115 ]]
        return string.lower(p19.Name) < string.lower(p20.Name);
    end);
    for _, u21 in v16 do
        task.defer(function() --[[ Line: 120 ]]
            -- upvalues: u6 (ref), u21 (copy), u5 (ref)
            local v22 = u6.new(u21);
            u5.ItemByName[u21.Name] = v22;
            table.insert(u5.Items, v22);
        end);
    end;
end;
function u5.Setup() --[[ Line: 129 ]]
    -- upvalues: u5 (copy), u3 (copy), u1 (copy)
    u5.Interface = u3.Get("LoftShop");
    u5.MainFrame = u5.Interface.TweenFrame;
    u5.Scroll = u5.MainFrame.Scroll;
    u5.SetupGui();
    u1.Upon("AnchorLoftSavedItems", function(p23) --[[ Line: 136 ]]
        -- upvalues: u5 (ref)
        for _, v24 in u5.Items do
            local v25 = p23[v24.Index];
            if v25 then
                v24:UpdateSaved(v25);
            end;
        end;
    end);
end;
return u5;
