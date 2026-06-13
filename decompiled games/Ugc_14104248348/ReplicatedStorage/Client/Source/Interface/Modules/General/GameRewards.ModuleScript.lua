-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.GameRewards
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.Module3D);
local u1 = l__Mince__2:Get("UserProfile");
l__Mince__2:Get("ConfirmPrompt");
local u2 = l__Mince__2:Get("InterfaceHandler");
local u3 = l__Mince__2:Get("ItemFrame");
local u4 = l__Mince__2:GetEvent("ClaimGameReward");
local u5 = {
    Items = {},
    Buttons = {},
    Connections = {},
    Claimed = {}
};
function u5.SetupGui() --[[ Line: 24 ]]
    -- upvalues: u2 (copy), u5 (copy)
    u2.NewButton(u5.MainFrame.CloseButton).Activated:Connect(function() --[[ Line: 27 ]]
        -- upvalues: u5 (ref)
        u5.Interface.Close();
        for _, v6 in u5.Items do
            v6.Gui.Parent:Destroy();
            v6:Destroy();
        end;
        for _, v7 in u5.Connections do
            v7:Disconnect();
        end;
    end);
end;
function u5.ShowRewardsFor(u8) --[[ Line: 40 ]]
    -- upvalues: l__Mince__2 (copy), u5 (copy), l__ReplicatedStorage__1 (copy), u3 (copy), u2 (copy), u4 (copy)
    local v9 = l__Mince__2.Config.GameRewards[u8];
    u5.NumberClaimed = 0;
    for u10, v11 in v9 do
        local v12 = l__ReplicatedStorage__1.Assets.Interface.GameRewardItem:Clone();
        local v13 = u3.GenerateFromItemTable(v11.Reward, v12);
        v12.Parent = u5.Container;
        v13.Gui:SetAttribute("GameID", u8);
        v13.Gui:SetAttribute("Index", u10);
        u5.Items[u10] = v13;
        local v15 = u2.NewButton(v12).Activated:Connect(function() --[[ Line: 56 ]]
            -- upvalues: u4 (ref), u8 (copy), u10 (ref), u5 (ref)
            u4:Fire(u8, u10);
            for _, v14 in u5.Connections do
                v14:Disconnect();
            end;
        end);
        table.insert(u5.Connections, v15);
        if u5.Claimed[u8] and u5.Claimed[u8][u10] then
            local v16 = u5;
            v16.NumberClaimed = v16.NumberClaimed + 1;
        end;
        u5.MainFrame.ClaimedAmount.Text = `{u5.NumberClaimed}/4 claimed`;
        local v17 = v12:FindFirstChild("ShopItem") or v12:FindFirstChild("InventoryItem");
        local v18 = u5.Claimed[u8];
        if v18 then
            v18 = u5.Claimed[u8][u10];
        end;
        v17.Visible = v18;
        local l__Container__3 = v12.Container;
        local v19 = u5.Claimed[u8];
        if v19 then
            v19 = u5.Claimed[u8][u10];
        end;
        l__Container__3.Visible = not v19;
    end;
    u5.Interface.Trigger();
end;
function u5.Setup() --[[ Line: 81 ]]
    -- upvalues: u5 (copy), u2 (copy), u1 (copy)
    u5.Interface = u2.Get("GameReward");
    u5.MainFrame = u5.Interface.TweenFrame;
    u5.Container = u5.MainFrame.Container;
    u5.SetupGui();
    u1.Upon("ClaimedGameRewards", function(p20) --[[ Line: 88 ]]
        -- upvalues: u5 (ref)
        u5.Claimed = p20;
        u5.NumberClaimed = 0;
        for _, v21 in u5.Items do
            local v22 = print;
            local v23 = u5.Claimed[v21.Gui:GetAttribute("GameID")];
            if v23 then
                v23 = u5.Claimed[v21.Gui:GetAttribute("GameID")][v21.Gui:GetAttribute("Index")];
            end;
            v22(v23);
            print(u5.Claimed);
            if u5.Claimed[v21.Gui:GetAttribute("GameID")] and u5.Claimed[v21.Gui:GetAttribute("GameID")][v21.Gui:GetAttribute("Index")] then
                local v24 = u5;
                v24.NumberClaimed = v24.NumberClaimed + 1;
            end;
            local l__Gui__4 = v21.Gui;
            local v25 = u5.Claimed[v21.Gui:GetAttribute("GameID")];
            if v25 then
                v25 = u5.Claimed[v21.Gui:GetAttribute("GameID")][v21.Gui:GetAttribute("Index")];
            end;
            l__Gui__4.Visible = v25;
            local l__Container__5 = v21.Gui.Parent.Container;
            local v26 = u5.Claimed[v21.Gui:GetAttribute("GameID")];
            if v26 then
                v26 = u5.Claimed[v21.Gui:GetAttribute("GameID")][v21.Gui:GetAttribute("Index")];
            end;
            l__Container__5.Visible = not v26;
        end;
        u5.MainFrame.ClaimedAmount.Text = `{u5.NumberClaimed}/4 claimed`;
    end);
end;
return u5;
