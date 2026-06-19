-- Decompiled from: Rules
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("QBox");
local l__FreeMouse__2 = v1.FreeMouse;
local v2 = l__obtain__1("Tween");
l__obtain__1("Local");
local v3 = l__obtain__1("Remote");
local u4 = v1.New();
u4.Visible = false;
u4.DrawBackground = false;
u4.SizeOffsetX = 500;
u4.SizeOffsetY = 800;
u4.PosScaleX = 0.5;
u4.PosScaleY = 1;
local u5 = false;
local u7 = v2.New(0, function(p6) --[[ Line: 21 ]]
    -- upvalues: u5 (ref), u4 (copy)
    u5 = true;
    u4.PosOffsetY = p6;
    u5 = false;
end);
u7.MaxAcceleration = v2.MaxAcceleration(0, u4.SizeY, 0, 0, 1);
u4.Callbacks[{
    PosOffsetY = true
}] = function() --[[ Line: 27 ]]
    -- upvalues: u5 (ref), u7 (copy), u4 (copy)
    if not u5 then
        u7.x1 = u4.PosOffsetY;
    end;
end;
function u4.Resize() --[[ Line: 33 ]]
    -- upvalues: u4 (copy), u7 (copy)
    u4.PosOffsetX = u4.SizeX / -2;
    u4.PosOffsetY = u7:Value();
end;
local v8 = v1.TextBox(u4, "Rules");
v8.TextSize = 12 * v1.roblox_messing_with_guis_factor;
v8.TextAlignment = "Center";
v8.BackgroundColor = v1.Color2;
v8.SizeScaleX = 1;
v8.SizeOffsetX = -40;
v8.SizeOffsetY = 40;
v1.DragBar(v8, u4);
local v9 = v1.TextBox(u4, "x");
v9.TextSize = 12 * v1.roblox_messing_with_guis_factor;
v9.TextAlignment = "Center";
v9.SizeOffsetX = 40;
v9.SizeOffsetY = 40;
v9.PosOffsetX = -40;
v9.PosScaleX = 1;
local v10 = v1.New(u4);
v10.SizeScaleX = 1;
v10.SizeScaleY = 1;
v10.SizeOffsetY = -40;
v10.PosOffsetY = 40;
local v11 = v1.New();
v11.SizeScaleX = 1;
local v12 = v1.TextBox(v11, "Welcome to bhop/surf! To keep things fair for all players, we have a set few rules all players must abide by to be permitted to get leaderboard times, alongside rules to follow within the chat.\n\nIf you have any questions with the rules listed below, please contact an In Game Moderator or Chat Moderator via the Discord Server (13+) in the game description.\n\nAppealing any punishment is also done through the Discord server, by making a ticket on \"Other In-Game\" or \"In-game Chat\"");
v12.TextSize = 11 * v1.roblox_messing_with_guis_factor;
v12.TextAlignment = "Top";
v12.TextWraps = true;
v12.SizeScaleX = 1;
v12.SizeOffsetY = 240;
local v13 = v1.TextBox(v11, "Leaderboard Guidelines");
v13.TextSize = 11 * v1.roblox_messing_with_guis_factor;
v13.TextAlignment = "Top";
v13.TextWraps = true;
v13.SizeScaleX = 1;
v13.PosOffsetY = v12.SizeOffsetY;
v13.SizeOffsetY = 40;
local v14 = v1.TextBox(v11, "- Only one account per player (Alternative accounts will be blacklisted if caught and may result in main account consequences)\n\n- Cheating via tools such as unlocking scroll wheels/autoscrolling, autostrafing, rawaccelling, binding 1 input to more than 1 output, or other disallowed tools in main runs will result in your account being blacklisted\n\n- Bouncing on edges/slopes for a vertical/horizontal speed advantage will result in a blacklist\n(Unintended edgeboosts will be deleted and result in no punishment, reach out to the Head Moderator, littlefarrell, for more info if needed)\n\n- FPS Unlocker, Turnbinds, and Nulls are permitted for gameplay (Turnbinds can be acquired in the Server via #binds)\n\n- Boosting other users, acquiring times on another users account, will result in both the boosted user and your account being blacklisted upon being caught\n\n- Accounts in pending that are under a month old will be blacklisted UNLESS proven to be a non alternative account (Contact a moderator if you need assistance)");
v14.TextSize = 11 * v1.roblox_messing_with_guis_factor;
v14.TextAlignment = "TopLeft";
v14.TextWraps = true;
v14.SizeScaleX = 1;
v14.PosOffsetY = v12.SizeOffsetY + v13.SizeOffsetY;
v14.SizeOffsetY = 360;
local v15 = v1.TextBox(v11, "Chat Guidelines");
v15.TextSize = 11 * v1.roblox_messing_with_guis_factor;
v15.TextAlignment = "Top";
v15.TextWraps = true;
v15.SizeScaleX = 1;
v15.PosOffsetY = v12.SizeOffsetY + v13.SizeOffsetY + v14.SizeOffsetY;
v15.SizeOffsetY = 40;
local v16 = v1.TextBox(v11, "- Anything violating Roblox ToS will immediately result in a mute\n\n- Inappropriate language (slurs, censored words, etc) under any circumstances\n\n- Extreme harassment of other users (Harassment leading to threatening, see rule 5 for more info)\n\n- Discrimination amongst groups of users (ex. race, heritage)\n\n- Threatening users by blackmailing or doxing or any reason to hurt another user unrelated to gameplay legitimacy\n\n- Flooding chat constantly with no purpose (for example, clearing chat with no rule violating messages visible or repeating similar messages over and over again)\n\n- Distributing cheats or other disallowed gameplay methods in game");
v16.TextSize = 11 * v1.roblox_messing_with_guis_factor;
v16.TextAlignment = "TopLeft";
v16.TextWraps = true;
v16.SizeScaleX = 1;
v16.PosOffsetY = v12.SizeOffsetY + v13.SizeOffsetY + v14.SizeOffsetY + v15.SizeOffsetY;
v16.SizeOffsetY = 280;
v11.SizeOffsetY = v12.SizeOffsetY + v13.SizeOffsetY + v14.SizeOffsetY + v15.SizeOffsetY + v16.SizeOffsetY;
v1.Scroll(v11, v10);
local u17 = false;
function v9.Button1Down() --[[ Line: 139 ]]
    -- upvalues: u17 (ref), l__FreeMouse__2 (copy), u7 (copy), u4 (copy)
    u17 = false;
    l__FreeMouse__2("Rules", false);
    u7:Target(0, function() --[[ Line: 142 ]]
        -- upvalues: u4 (ref)
        u4.Visible = false;
    end);
end;
v3.Add("ToggleRules", function() --[[ Line: 156 ]]
    -- upvalues: u17 (ref), l__FreeMouse__2 (copy), u7 (copy), u4 (copy)
    if u17 then
        u17 = false;
        l__FreeMouse__2("Rules", false);
        u7:Target(0, function() --[[ Line: 142 ]]
            -- upvalues: u4 (ref)
            u4.Visible = false;
        end);
    else
        u17 = true;
        l__FreeMouse__2("Rules", true);
        u4.Visible = true;
        u7:Target(-u4.Parent.SizeY / 2 - u4.SizeY / 2);
    end;
end);
return true;
