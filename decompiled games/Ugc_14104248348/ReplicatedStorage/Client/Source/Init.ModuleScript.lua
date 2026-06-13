-- Decompiled from: ReplicatedStorage.Client.Source.Init
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__UserInputService__3 = game:GetService("UserInputService");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
local l__LocalPlayer__5 = l__Players__1.LocalPlayer;
local l__Mince__6 = require(l__ReplicatedStorage__4.Modules.Mince);
require(l__ReplicatedStorage__4.Modules.LoadingPoint);
local u1 = l__Mince__6:Get("Notices");
local u2 = l__Mince__6:Get("Effects");
local u3 = l__Mince__6:Get("ItemShop");
local u4 = l__Mince__6:Get("Settings");
local u5 = l__Mince__6:Get("UpdateLog");
l__Mince__6:Get("Voicelines");
local u6 = l__Mince__6:Get("RankReward");
local u7 = l__Mince__6:Get("NotifPrompt");
local u8 = l__Mince__6:Get("UserProfile");
local u9 = l__Mince__6:Get("DailyRewards");
l__Mince__6:Get("Intoxication");
local u10 = l__Mince__6:Get("ConfirmPrompt");
l__Mince__6:Get("ActivityReward");
l__Mince__6:Get("InterfaceHandler");
local u11 = l__Mince__6:Get("SocialPlatformAdvert");
local u12 = l__Mince__6:Get("DailyCoinBonus");
l__Mince__6:GetEvent("ExpireIntent");
local u13 = l__Mince__6:GetState("DataServer");
l__Mince__6:GetState("Matchmaking");
local u14 = {
    __IsAsyncSetup = true
};
function TeleportPlayerToGroundPosition(p15, p16)
    -- upvalues: u2 (copy)
    local l__Character__7 = p15.Character;
    if l__Character__7 then
        l__Character__7 = p15.Character:FindFirstChild("Humanoid");
    end;
    if l__Character__7 then
        u2.PlayBlackout(0.6);
        task.wait(0.4);
        if l__Character__7.SeatPart then
            l__Character__7.Sit = false;
            local v17 = l__Character__7.SeatPart:FindFirstChild("SeatWeld");
            if v17 then
                v17:Destroy();
            end;
        end;
        p15.Character:PivotTo(CFrame.new(p16 + Vector3.new(0, 1, 0) * l__Character__7.HipHeight));
    end;
end;
function u14.SetupCharacterStuffs() --[[ Line: 54 ]]
    -- upvalues: l__Mince__6 (copy), l__LocalPlayer__5 (copy)
    local function v19(p18) --[[ Line: 55 ]]
        -- upvalues: l__Mince__6 (ref)
        l__Mince__6.Config.Character = p18;
        local l__Humanoid__8 = p18:WaitForChild("Humanoid");
        local l__HumanoidRootPart__9 = p18:WaitForChild("HumanoidRootPart");
        l__Mince__6.Config.Humanoid = l__Humanoid__8;
        l__Mince__6.Config.HumanoidRootPart = l__HumanoidRootPart__9;
        l__Humanoid__8.Died:Connect(function() --[[ Line: 63 ]]
            -- upvalues: l__Mince__6 (ref)
            l__Mince__6.Config.Humanoid = nil;
            l__Mince__6.Config.Character = nil;
        end);
    end;
    l__LocalPlayer__5.CharacterAdded:Connect(v19);
    if l__LocalPlayer__5.Character then
        task.spawn(v19, l__LocalPlayer__5.Character);
    end;
end;
function u14.SetupDebugTracking() --[[ Line: 73 ]]
    -- upvalues: l__Mince__6 (copy), l__LocalPlayer__5 (copy)
    l__Mince__6.Config.Stats.Drop = { 200, " IDLE" };
    l__Mince__6.Config.Stats.System = { 0, "IDLE" };
    game:GetService("Stats");
    game:GetService("RunService").RenderStepped:Connect(function(p20) --[[ Line: 78 ]]
        -- upvalues: l__Mince__6 (ref), l__LocalPlayer__5 (ref)
        local _ = 1 / p20;
        l__Mince__6.Config.Stats.System[2] = `RenderStepLastTick:{p20}`;
        l__Mince__6.Config.Stats.Drop[2] = `serverdrops: {l__LocalPlayer__5:GetAttribute("DropCount") or 0}`;
    end);
end;
function u14.DoIntialNotices() --[[ Line: 86 ]]
    -- upvalues: l__UserInputService__3 (copy), u1 (copy)
    if l__UserInputService__3.VREnabled then
        u1.CreateNotice("Please let us know any suggestions you have for VR!", nil, 8);
    end;
end;
function u14.DoProfileIntialNotices() --[[ Line: 92 ]]
    -- upvalues: l__Mince__6 (copy), u1 (copy)
    task.wait(1);
    local l__Tolerance__10 = l__Mince__6.Config.LocalProfile.Tolerance;
    if l__Tolerance__10 > 1.2 then
        u1.CreateNotice("You are a light drinker... You should be careful.", nil, 8);
    elseif l__Tolerance__10 < 0.8 then
        u1.CreateNotice("You are a HEAVY drinker... You\'ll need alot more.", nil, 8);
    else
        u1.CreateNotice("You are a normal drinker.", nil, 8);
    end;
    task.wait(9);
    u1.CreateNotice("please drink responsibly", nil, 10);
end;
function u14.Setup() --[[ Line: 109 ]]
    -- upvalues: u14 (copy), u8 (copy), u4 (copy), u7 (copy), u11 (copy), l__RunService__2 (copy), u13 (copy), l__Mince__6 (copy), u5 (copy), u6 (copy), u9 (copy), u12 (copy), u10 (copy), u3 (copy)
    u14.SetupDebugTracking();
    u14.SetupCharacterStuffs();
    u8:WaitUntilLoaded();
    task.spawn(u14.DoProfileIntialNotices);
    local u21 = false;
    u8:WaitUntilLoaded();
    if not u4.GetValue("GraphicModeToggleAcknowledged4") then
        u4.ChangeSetting("GraphicMode", 2);
        u4.ChangeSetting("GraphicModeToggleAcknowledged4", true);
        u7.Display("Your graphics have been set to \'low\' goto your settings to change this.", function() --[[ Line: 121 ]]
            -- upvalues: u21 (ref)
            u21 = true;
        end);
        repeat
            task.wait();
        until u21;
    end;
    if not u4.GetValue("ShownSocialReward3") then
        u4.ChangeSetting("ShownSocialReward3", true);
        u11:Start();
    end;
    if l__RunService__2:IsStudio() or u13.ThisGameVersionKey ~= l__Mince__6.Config.LocalProfile.LastGameVersionKey then
        u5.ShowNotes();
    end;
    u6.DipIn();
    if l__Mince__6.Config.HolidayConfigure.DAILY_REWARDS_ENABLED then
        u9.ShowDaily();
    end;
    u12:OpenAndWait();
    if not u4.GetValue("ShownShopAskToOpen1") then
        u4.ChangeSetting("ShownShopAskToOpen1", true);
        u10.Display("There are new items in the shop check it out?", function() --[[ Line: 148 ]]
            -- upvalues: u3 (ref)
            u3.Trigger();
        end);
    end;
end;
return u14;
