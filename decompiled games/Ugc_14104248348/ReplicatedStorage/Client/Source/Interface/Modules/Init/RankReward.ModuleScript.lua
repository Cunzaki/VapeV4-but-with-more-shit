-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.Init.RankReward
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local _ = game:GetService("Players").LocalPlayer;
local l__Maid__2 = require(l__ReplicatedStorage__1.Modules.Maid);
local l__Signal__3 = require(l__ReplicatedStorage__1.Modules.Signal);
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.Numerics);
local u1 = l__Mince__4:Get("ItemFrame");
local u2 = l__Mince__4:Get("InterfaceHandler");
local u3 = l__Mince__4:GetEvent("RecieveRankReward");
local u4 = {
    HasRecieved = false,
    Recieving = l__Signal__3.new(),
    Maid = l__Maid__2.new(),
    CleanupLast = function() --[[ Name: CleanupLast, Line 25 ]] end
};
function u4.DipIn() --[[ Line: 29 ]]
    -- upvalues: u4 (copy), u1 (copy)
    if not u4.HasRecieved then
        u4.Recieving:Wait();
    end;
    if #u4.GainedRewards.Items == 0 then
    else
        u4.Maid:Clean();
        u4.Interface.TweenFrame.Descriptor.Text = `Rewards based on your rank <b>"{u4.GainedRewards.RoleID}"</b>!`;
        for _, v5 in u4.GainedRewards.Items do
            local v6 = u1.GenerateFromItemTable(v5, u4.Interface.TweenFrame.Container);
            u4.Maid:Add(v6);
        end;
        u4.Interface.Trigger();
        u4.Interface.Closed:Wait();
    end;
end;
function u4.SetupGUI() --[[ Line: 50 ]]
    -- upvalues: u2 (copy), u4 (copy)
    u2.NewButton(u4.Interface.TweenFrame.DismissButton).Activated:Connect(function() --[[ Line: 53 ]]
        -- upvalues: u4 (ref)
        u4.Interface.Close();
    end);
end;
function u4.Setup() --[[ Line: 58 ]]
    -- upvalues: u4 (copy), u2 (copy)
    u4.Interface = u2.Get("RankReward");
    u4.Trigger = u4.Interface.Trigger;
    u4.SetupGUI();
end;
function u4.Init() --[[ Line: 66 ]]
    -- upvalues: u3 (copy), u4 (copy)
    u3.Event:Connect(function(p7) --[[ Line: 68 ]]
        -- upvalues: u4 (ref)
        u4.GainedRewards = p7;
        u4.HasRecieved = true;
        u4.Recieving:Fire();
        warn("recieving...!", p7);
    end);
end;
u4.Init();
return u4;
