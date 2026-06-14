-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.Priority.Topbar
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__SocialService__3 = game:GetService("SocialService");
local l__HttpService__4 = game:GetService("HttpService");
local l__LocalPlayer__5 = game:GetService("Players").LocalPlayer;
local l__Icon__6 = require(l__ReplicatedStorage__1.Modules.Icon);
local l__Mince__7 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__VRBottomBar__8 = require(l__ReplicatedStorage__1.Modules.VRBottomBar);
local u1 = l__Mince__7:Get("Level");
local u2 = l__Mince__7:Get("Emote");
local u3 = l__Mince__7:Get("Settings");
local u4 = l__Mince__7:Get("StoreHandler");
local u5 = l__Mince__7:Get("Inventory");
local u6 = l__Mince__7:Get("AchievementsHandler");
local u7 = l__Mince__7:Get("ItemShop");
l__Mince__7:GetEvent("RequestRagdoll");
local u8 = l__Mince__7:GetEvent("EventToggle");
local u9 = {};
function u9.SetupIcons() --[[ Line: 30 ]]
    -- upvalues: u9 (copy), l__Icon__6 (copy), u3 (copy), u1 (copy), u5 (copy), u6 (copy), l__UserInputService__2 (copy), u2 (copy), u4 (copy), u7 (copy), u8 (copy), l__LocalPlayer__5 (copy), l__HttpService__4 (copy), l__SocialService__3 (copy)
    u9.SettingsButton = l__Icon__6.new():setImage(14134003899):setCaption("Settings"):setRight():bindEvent("deselected", function(_) --[[ Line: 35 ]]
        -- upvalues: u3 (ref)
        u3.Trigger();
    end):oneClick();
    u9.LevelsButton = l__Icon__6.new():setImage(14452362614):setCaption("Levels/Stats"):setRight():bindEvent("deselected", function(_) --[[ Line: 43 ]]
        -- upvalues: u1 (ref)
        u1.Trigger();
    end):oneClick();
    u9.InventoryButton = l__Icon__6.new():setImage(16317102935):setCaption("Inventory"):setRight():bindEvent("deselected", function(_) --[[ Line: 51 ]]
        -- upvalues: u5 (ref)
        u5.Trigger();
    end):oneClick();
    u9.AcheivementsButton = l__Icon__6.new():setImage(16021212811):setCaption("Acheivements"):setRight():bindEvent("deselected", function(_) --[[ Line: 59 ]]
        -- upvalues: u6 (ref)
        u6.Achievements.Trigger();
    end):oneClick();
    if not l__UserInputService__2.VREnabled then
        u9.EmoteButton = l__Icon__6.new():setImage(14811345209):setCaption("Emotes"):setRight():bindEvent("deselected", function(_) --[[ Line: 68 ]]
            -- upvalues: u2 (ref)
            u2.Trigger();
        end):oneClick();
    end;
    u9.StoreButton = l__Icon__6.new():setImage(16581895137):setCaption("In-Game Store"):setRight():bindEvent("deselected", function(_) --[[ Line: 77 ]]
        -- upvalues: u4 (ref)
        u4.Trigger();
    end):oneClick();
    u9.ItemShopButton = l__Icon__6.new():setImage(76372701979782):setCaption("Item Shop"):setRight():bindEvent("deselected", function(_) --[[ Line: 85 ]]
        -- upvalues: u7 (ref)
        u7.Trigger();
    end):oneClick();
    u9.EventMode = l__Icon__6.new():setImage(14877246380):setCaption("Enable Event Participation"):bindEvent("toggled", function(p10) --[[ Line: 93 ]]
        -- upvalues: u8 (ref), l__LocalPlayer__5 (ref)
        if p10.isSelected then
            p10:setImage(14877245476);
            if p10.IgnoreNext then
                p10.IgnoreNext = false;
            else
                u8:Fire(p10.isSelected);
            end;
        else
            u8:Fire(p10.isSelected);
            if l__LocalPlayer__5:GetAttribute("Events") then
                p10.IgnoreNext = true;
                p10:select();
            else
                p10:setImage(14877246380);
            end;
        end;
    end):autoDeselect(false):select();
    u9.InvitePlayers = l__Icon__6.new():setImage(16238549052):setLabel("Invite Friends (+60)"):bindEvent("toggled", function(p11) --[[ Line: 120 ]]
        -- upvalues: l__LocalPlayer__5 (ref), l__HttpService__4 (ref), l__SocialService__3 (ref)
        if p11.isSelected then
            p11:deselect();
            local v12 = {
                LaunchDataType = "InvitePlayerFriendConfirmation",
                InviterUserId = l__LocalPlayer__5.UserId
            };
            local v13 = Instance.new("ExperienceInviteOptions");
            v13.PromptMessage = "Invite Friends! They join, you get 60 coins! (once per day)";
            v13.LaunchData = l__HttpService__4:JSONEncode(v12);
            l__SocialService__3:PromptGameInvite(l__LocalPlayer__5, v13);
        end;
    end);
    u9.Icons = { u9.EventMode, u9.SettingsButton, u9.LevelsButton };
    l__LocalPlayer__5:GetAttributeChangedSignal("Events"):Connect(function() --[[ Line: 139 ]]
        -- upvalues: l__LocalPlayer__5 (ref), u9 (ref)
        if l__LocalPlayer__5:GetAttribute("Events") then
            u9.EventMode:select();
        else
            u9.EventMode:deselect();
        end;
    end);
end;
function u9.SetUpGamepadButtonChanges() --[[ Line: 148 ]]
    -- upvalues: u9 (copy), l__Icon__6 (copy), l__UserInputService__2 (copy)
    for _, _ in u9.Icons do

    end;
    task.spawn(function() --[[ Line: 158 ]]
        -- upvalues: l__Icon__6 (ref), l__UserInputService__2 (ref)
        local v14;
        while true do
            v14 = l__Icon__6.getIcon("_TopbarControllerOption");
            if v14 then
                break;
            end;
            task.wait(1);
        end;
        if l__UserInputService__2.VREnabled then
            v14:destroy();
        else
            v14.instances.menuFrame.Selectable = false;
        end;
    end);
end;
function u9.SetUpVRBottomBar() --[[ Line: 174 ]]
    -- upvalues: l__UserInputService__2 (copy), l__VRBottomBar__8 (copy), l__Icon__6 (copy), u9 (copy)
    if l__UserInputService__2.VREnabled then
        local v15 = l__VRBottomBar__8:WithTopbarPlus(l__Icon__6);
        v15:AddNexusVRCharacterModelMenuButton();
        for _, v16 in u9.Icons do
            v15:Add(v16);
        end;
        l__VRBottomBar__8:SetUp();
    end;
end;
function u9.Setup() --[[ Line: 189 ]]
    -- upvalues: u9 (copy)
    u9.SetupIcons();
    u9.SetUpGamepadButtonChanges();
    u9.SetUpVRBottomBar();
end;
return u9;
