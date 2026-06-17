-- Decompiled from: Start.Client.Classes._xf6883d450b9ed3fb
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Players__2 = game:GetService("Players");
local l__ModuleScripts__3 = l__ReplicatedStorage__1.Assets.ModuleScripts;
local l__Packets__4 = require(l__ModuleScripts__3.Packets);
local l__Trove__5 = require(l__ModuleScripts__3.Trove);
local l__ClientRoot__6 = require(script.Parent.Parent.ClientRoot);
local l__Classes__7 = l__ClientRoot__6.Classes;
local l__Context__8 = l__ClientRoot__6.Context;
local l__LocalPlayer__9 = l__Players__2.LocalPlayer;
local l__Lobbies__10 = l__ReplicatedStorage__1.ReadOnly.Lobbies;
local u1 = {};
u1.__index = u1;
function u1._x83ed94bfb82a8c9f() --[[ Line: 32 ]]
    -- upvalues: u1 (copy), l__Trove__5 (copy)
    local v2 = setmetatable({}, u1);
    v2._x8d84400c8eb19e1b = l__Trove__5.new();
    v2._xc8b8710bc289c666 = {};
    v2._x64b15d8a6079f9da = nil;
    return v2;
end;
function u1._xc607b8e3e87116eb(_, p3) --[[ Line: 42 ]]
    -- upvalues: l__Lobbies__10 (copy), l__LocalPlayer__9 (copy)
    for _, v4 in l__Lobbies__10:GetChildren() do
        if v4:IsA("Folder") and (not p3 or v4.Name == p3) then
            local v5 = v4:FindFirstChild((tostring(l__LocalPlayer__9.UserId)));
            if v5 and v5:IsA("Folder") then
                return v4, v5;
            end;
        end;
    end;
    return nil, nil;
end;
function u1._xf8444bf35c0c9cc9(p6, p7) --[[ Line: 61 ]]
    -- upvalues: l__Classes__7 (copy)
    local v8, v9 = p6:_xc607b8e3e87116eb(p7);
    if not (v8 and v9) then
        return false;
    end;
    local l__current_session__11 = l__Classes__7.MenuManager.current_session;
    if not l__current_session__11 then
        return false;
    end;
    if not l__current_session__11:openPage("lobby_page", v8, v9) then
        return false;
    end;
    local l__lobby_page__12 = l__current_session__11.pages.lobby_page;
    local v10;
    if l__current_session__11.current_page == "lobby_page" then
        v10 = l__lobby_page__12 and l__lobby_page__12.in_lobby;
        if v10 then
            v10 = l__lobby_page__12.lobby_inst == v8;
        end;
    else
        v10 = false;
    end;
    return v10;
end;
function u1._x5cd8162fb0e6dea9(u11, u12) --[[ Line: 84 ]]
    local u13 = {};
    u11._x64b15d8a6079f9da = u13;
    task.spawn(function() --[[ Line: 88 ]]
        -- upvalues: u11 (copy), u13 (copy), u12 (copy)
        local v14 = os.clock();
        while u11._x64b15d8a6079f9da == u13 and os.clock() - v14 < 5 do
            if u11:_xf8444bf35c0c9cc9(u12) then
                if u11._x64b15d8a6079f9da == u13 then
                    u11._x64b15d8a6079f9da = nil;
                end;
                return;
            end;
            task.wait();
        end;
    end);
end;
function u1._xbcabbd3e9e702352(p15, p16) --[[ Line: 103 ]]
    -- upvalues: l__LocalPlayer__9 (copy), l__Lobbies__10 (copy)
    if p16:IsA("Folder") and p16.Name == tostring(l__LocalPlayer__9.UserId) then
        local l__Parent__13 = p16.Parent;
        if l__Parent__13 and (l__Parent__13:IsA("Folder") and l__Parent__13.Parent == l__Lobbies__10) then
            p15:_x5cd8162fb0e6dea9(l__Parent__13.Name);
        end;
    end;
end;
function u1._x46acb4cec7538d80(_, p17) --[[ Line: 116 ]]
    -- upvalues: l__Classes__7 (copy)
    l__Classes__7._x9a86d5566d6a5327:_x56e35d38c98d820d({
        lifetime = 8,
        play_sound = true,
        members = {
            {
                kind = "Text",
                args = { p17 }
            }
        }
    });
end;
function u1._x57d7466d20d7d7d8(p18, p19) --[[ Line: 129 ]]
    local v20 = p18._xc8b8710bc289c666[p19];
    if v20 then
        p18._xc8b8710bc289c666[p19] = nil;
        v20:destroy();
    end;
end;
function u1._xd4beaf9f9c5f1504(u21, p22) --[[ Line: 137 ]]
    -- upvalues: l__Classes__7 (copy), l__Packets__4 (copy)
    local l__lobby_id__14 = p22.lobby_id;
    local l__from_name__15 = p22.from_name;
    if typeof(l__lobby_id__14) == "string" and typeof(l__from_name__15) == "string" then
        u21:_x57d7466d20d7d7d8(l__lobby_id__14);
        local l__expected_expiry__16 = p22.expected_expiry;
        local v23;
        if typeof(l__expected_expiry__16) == "number" then
            v23 = l__expected_expiry__16 - workspace:GetServerTimeNow();
            if v23 <= 0 then
                return;
            end;
        else
            v23 = 20;
        end;
        local u24 = l__Classes__7._x9a86d5566d6a5327:_x56e35d38c98d820d({
            play_sound = true,
            show_lifetime_timer = true,
            lifetime = v23,
            members = {
                {
                    kind = "Header",
                    args = { "LOBBY INVITE!", "mail", Color3.fromRGB(255, 220, 67) }
                },
                {
                    kind = "Text",
                    args = { "<b>" .. l__from_name__15 .. "</b> invited you to a custom lobby!" }
                },
                {
                    kind = "Input",
                    args = {
                        {
                            text = "ACCEPT",
                            close_on_activated = true,
                            color = Color3.fromRGB(70, 255, 70)
                        },
                        function() --[[ Line: 170 ]]
                            -- upvalues: l__Packets__4 (ref), l__lobby_id__14 (copy)
                            l__Packets__4._xa873db53beaadf6d:Fire("ACCEPT_INVITE", l__lobby_id__14);
                        end
                    }
                },
                {
                    kind = "Input",
                    args = {
                        {
                            text = "DECLINE",
                            close_on_activated = true,
                            color = Color3.fromRGB(255, 70, 70)
                        },
                        function() --[[ Line: 176 ]]
                            -- upvalues: l__Packets__4 (ref), l__lobby_id__14 (copy)
                            l__Packets__4._xa873db53beaadf6d:Fire("DECLINE_INVITE", l__lobby_id__14);
                        end
                    }
                }
            }
        });
        u21._xc8b8710bc289c666[l__lobby_id__14] = u24;
        u21._x8d84400c8eb19e1b:Connect(u24.onDestroying, function() --[[ Line: 184 ]]
            -- upvalues: u21 (copy), l__lobby_id__14 (copy), u24 (copy)
            if u21._xc8b8710bc289c666[l__lobby_id__14] == u24 then
                u21._xc8b8710bc289c666[l__lobby_id__14] = nil;
            end;
        end);
    end;
end;
function u1._x160c434bb4e32d63(u25, u26) --[[ Line: 191 ]]
    -- upvalues: l__Classes__7 (copy)
    if typeof(u26) == "table" and typeof(u26.host_name) == "string" then
        task.spawn(function() --[[ Line: 196 ]]
            -- upvalues: l__Classes__7 (ref), u25 (copy), u26 (copy)
            local v27 = os.clock();
            while l__Classes__7.MenuManager and (not l__Classes__7.MenuManager.current_session and os.clock() - v27 < 3) do
                task.wait();
            end;
            u25:_x5cd8162fb0e6dea9();
            u25:_x46acb4cec7538d80("Joined " .. u26.host_name .. "\'s lobby.");
        end);
    end;
end;
function u1._x44bcd6af41218f92(u28) --[[ Line: 210 ]]
    -- upvalues: l__Context__8 (copy), l__Packets__4 (copy), l__Lobbies__10 (copy)
    if l__Context__8.is_match_mode then
    else
        u28._x8d84400c8eb19e1b:Connect(l__Packets__4._xa873db53beaadf6d.OnClientEvent, function(p29, p30) --[[ Line: 215 ]]
            -- upvalues: u28 (copy)
            if p29 == "INVITE_RECEIVED" and typeof(p30) == "table" then
                u28:_xd4beaf9f9c5f1504(p30);
            elseif p29 == "INVITE_CLOSED" and typeof(p30) == "table" then
                u28:_x57d7466d20d7d7d8(p30.lobby_id);
            else
                if p29 == "JOINED_LOBBY" then
                    u28:_x160c434bb4e32d63(p30);
                end;
            end;
        end);
        for _, v31 in l__Lobbies__10:GetDescendants() do
            u28:_xbcabbd3e9e702352(v31);
        end;
        u28._x8d84400c8eb19e1b:Connect(l__Lobbies__10.DescendantAdded, function(p32) --[[ Line: 229 ]]
            -- upvalues: u28 (copy)
            u28:_xbcabbd3e9e702352(p32);
        end);
    end;
end;
return u1;
