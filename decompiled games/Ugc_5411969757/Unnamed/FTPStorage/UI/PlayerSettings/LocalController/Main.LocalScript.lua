-- Decompiled from: .FTPStorage.UI.PlayerSettings.LocalController.Main
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = setmetatable({}, {
    __index = function(_, p1) --[[ Name: __index, Line 1 ]]
        return game:GetService(p1);
    end
}).Players.LocalPlayer;
local l__Frame__2 = script.Parent:WaitForChild("Mainframe"):WaitForChild("ScrollFalso"):WaitForChild("Frame");
local l__floor__3 = math.floor;
local function u7(p2) --[[ Line: 20 ]]
    -- upvalues: l__floor__3 (copy)
    if typeof(p2) ~= "number" then
        return p2;
    end;
    local v3 = p2 % 60;
    local v4 = l__floor__3(p2 / 60);
    if v4 < 60 then
        if v3 < 10 then
            v3 = "0" .. tostring(v3);
        end;
        if v4 < 10 then
            v4 = "0" .. tostring(v4);
        end;
        return "00h " .. v4 .. "m" .. v3 .. "s";
    end;
    local v5 = l__floor__3(v4 / 60);
    local v6 = v4 % 60;
    if v3 < 10 then
        v3 = "0" .. tostring(v3);
    end;
    if v6 < 10 then
        v6 = "0" .. tostring(v6);
    end;
    if v5 < 10 then
        v5 = "0" .. tostring(v5);
    end;
    return v5 .. "h " .. v6 .. "m" .. v3 .. "s";
end;
local function u17(p8) --[[ Line: 44 ]]
    -- upvalues: l__Frame__2 (copy)
    local l__Center__4 = l__Frame__2:WaitForChild("SERVER_PRIVACY"):WaitForChild("Options"):WaitForChild("Center");
    if p8 == 1 then
        local v9 = l__Center__4:FindFirstChildOfClass("TextLabel");
        if v9 ~= nil then
            v9.Text = "PRIVATE";
        end;
        local v10 = l__Frame__2:FindFirstChild("SERVER_ASKPASSWORD");
        local v11 = l__Frame__2:FindFirstChild("SERVER_FRIENDCANJOIN");
        local v12 = l__Frame__2:FindFirstChild("SERVER_PASSWORDCODE");
        if v10 ~= nil then
            v10.Visible = false;
        end;
        if v11 ~= nil then
            v11.Visible = false;
        end;
        if v12 ~= nil then
            v12.Visible = false;
        end;
    elseif p8 == 2 then
        local v13 = l__Center__4:FindFirstChildOfClass("TextLabel");
        if v13 ~= nil then
            v13.Text = "PUBLIC";
        end;
        local v14 = l__Frame__2:FindFirstChild("SERVER_ASKPASSWORD");
        local v15 = l__Frame__2:FindFirstChild("SERVER_FRIENDCANJOIN");
        local v16 = l__Frame__2:FindFirstChild("SERVER_PASSWORDCODE");
        if v14 ~= nil then
            v14.Visible = true;
        end;
        if v15 ~= nil then
            v15.Visible = true;
        end;
        if v16 ~= nil then
            v16.Visible = true;
        end;
    end;
end;
local function u29() --[[ Line: 93 ]]
    -- upvalues: l__LocalPlayer__1 (copy), l__Frame__2 (copy), u7 (copy), u17 (copy)
    local v18 = l__LocalPlayer__1:FindFirstChild("isAdmin") and true or false;
    local v19 = game.HttpService:JSONDecode(Server_data.Value);
    local v20 = game.Lighting:FindFirstChild("ServerOwner");
    local v21 = game.Lighting:FindFirstChild("ServerVisits");
    local v22 = game.Lighting:FindFirstChild("TotalServerTime");
    local v23 = v20 == nil and "ERROR" or v20.Value;
    local v24 = v21 == nil and "ERROR" or v21.Value;
    local v25 = v22 == nil and "ERROR" or v22.Value;
    l__Frame__2:WaitForChild("STATS_OWNER"):WaitForChild("Value").Text = v23;
    l__Frame__2:WaitForChild("STATS_VISITS"):WaitForChild("Value").Text = v24;
    l__Frame__2:WaitForChild("STATS_TIME"):WaitForChild("Value").Text = u7(v25);
    local v26 = v19.Public_settings.Name or "Unnamed Futuretops Server";
    local v27 = v19.Public_settings.Icon or "";
    local v28 = v19.Public_settings.Privacy or 2;
    local l__FollowEnabled__5 = v19.Public_settings.FollowEnabled;
    local l__PasswordEnabled__6 = v19.Public_settings.PasswordEnabled;
    l__Frame__2:WaitForChild("SERVER_NAME"):WaitForChild("ImageLabel"):WaitForChild("TextBox").Text = v26;
    l__Frame__2:WaitForChild("SERVER_ICON"):WaitForChild("ImageLabel"):WaitForChild("TextBox").Text = v27;
    l__Frame__2:WaitForChild("SERVER_FRIENDCANJOIN"):WaitForChild("FunctionGet"):Invoke(l__FollowEnabled__5);
    l__Frame__2:WaitForChild("SERVER_ASKPASSWORD"):WaitForChild("FunctionGet"):Invoke(l__PasswordEnabled__6);
    u17(v28 or 1);
    if v18 == true then
        local l__Options__7 = l__Frame__2:WaitForChild("SERVER_PRIVACY"):WaitForChild("Options");
        l__Options__7:WaitForChild("Derecha").Visible = true;
        l__Options__7:WaitForChild("Izquierda").Visible = true;
    end;
end;
u29();
Server_data:GetPropertyChangedSignal("Value"):connect(function() --[[ Line: 136 ]]
    -- upvalues: u29 (copy)
    u29();
end);
OverConnect:Fire("connect", l__Frame__2:WaitForChild("STATS_OWNER"), 1, "Owner of this server");
OverConnect:Fire("connect", l__Frame__2:WaitForChild("STATS_LEADERBOARD"), 1, "Statistics of all players together");
OverConnect:Fire("connect", l__Frame__2:WaitForChild("STATS_TIME"), 1, "Total game time since the server was created");
OverConnect:Fire("connect", l__Frame__2:WaitForChild("STATS_VISITS"), 1, "Total server visits since it was created");
OverConnect:Fire("connect", l__Frame__2:WaitForChild("SERVER_PRIVACY"), 1, "You will change the server privacy\n(Only Owner and Server Owner can change this)");
OverConnect:Fire("connect", l__Frame__2:WaitForChild("SERVER_ICON"), 1, "This is seen by people in the Game Lobby");
OverConnect:Fire("connect", l__Frame__2:WaitForChild("SERVER_NAME"), 1, "You will change the name of your server");
OverConnect:Fire("connect", l__Frame__2:WaitForChild("SERVER_ASKPASSWORD"), 1, "You will ask for the password from unknown players from Game Lobby");
OverConnect:Fire("connect", l__Frame__2:WaitForChild("SERVER_FRIENDCANJOIN"), 1, "Unknown people can enter the server if they follow someone from the profile");
OverConnect:Fire("connect", l__Frame__2:WaitForChild("SERVER_PASSWORDCODE"), 1, "Password required to enter the server");
OverConnect:Fire("connect", l__Frame__2:WaitForChild("COMMAND_ADMINTYPE"), 1, "Changing this requires restarting the server \n(Only Server Owner can change this)");
OverConnect:Fire("connect", l__Frame__2:WaitForChild("COMMAND_GAMEPREFIX"), 1, "Prefix for games\n(Ex: Varcia, Vulturist, SMO)");
OverConnect:Fire("connect", l__Frame__2:WaitForChild("SETTINGS_OUTSCORE"), 1, "When you die you will be automatically sent to the lobby");
OverConnect:Fire("connect", l__Frame__2:WaitForChild("SETTINGS_RESPAWNTIME"), 1, "Amount of time for spawn at death");
OverConnect:Fire("connect", l__Frame__2:WaitForChild("SETTINGS_FORCEFIELD"), 1, "Amount of protection time (ForceField)");
OverConnect:Fire("connect", l__Frame__2:WaitForChild("SETTINGS_BUBBLECHAT"), 1, "Enable or Disable Bubble Chat for all players");
OverConnect:Fire("connect", l__Frame__2:WaitForChild("SETTINGS_AFTERLIFE"), 1, "Enable this will make dead players unable to kill you\n(This is for those players with a lot of lag)");
OverConnect:Fire("connect", l__Frame__2:WaitForChild("SETTINGS_ANTIRCM"), 1, "Enable this could cause many errors to Gears and our Games");
l__Frame__2:WaitForChild("SERVER_PRIVACY"):WaitForChild("Options"):WaitForChild("Derecha").MouseButton1Down:connect(function() --[[ Line: 162 ]]
    -- upvalues: l__LocalPlayer__1 (copy)
    local _ = (l__LocalPlayer__1:FindFirstChild("isAdmin") and true or false) == true;
end);
l__Frame__2:WaitForChild("SERVER_PRIVACY"):WaitForChild("Options"):WaitForChild("Izquierda").MouseButton1Down:connect(function() --[[ Line: 168 ]]
    -- upvalues: l__LocalPlayer__1 (copy)
    local _ = (l__LocalPlayer__1:FindFirstChild("isAdmin") and true or false) == true;
end);
