-- Decompiled from: Start.Client.Classes._x8cc619c438b0365b
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

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
function u1._xafd29f1684593d0b() --[[ Line: 32 ]]
    -- upvalues: u1 (copy), l__Trove__5 (copy)
    local v2 = setmetatable({}, u1);
    v2._x16dd133b812b0266 = l__Trove__5.new();
    v2._xf3ee3fa453f09537 = {};
    v2._x9eb51f4c04492890 = nil;
    return v2;
end;
function u1._xeb0fc5b3413aa1db(_, p3) --[[ Line: 42 ]]
    -- upvalues: l__Lobbies__10 (copy), l__LocalPlayer__9 (copy)
    for _, v4 in l__Lobbies__10:GetChildren() do
        local v5 = tostring(game.GameId);
        local v6 = 46;
        for v7 = 1, #v5 do
            v6 = (v6 * 33 + string.byte(v5, v7)) % 65521;
        end;
        if v6 ~= 272 or v4:IsA("Folder") then
            local v8 = tostring(game.GameId);
            local v9 = 46;
            for v10 = 1, #v8 do
                v9 = (v9 * 33 + string.byte(v8, v10)) % 65521;
            end;
            if v9 ~= 272 or (not p3 or v4.Name == p3) then
                local v11 = v4:FindFirstChild((tostring(l__LocalPlayer__9.UserId)));
                local v12 = tostring(game.GameId);
                local v13 = 46;
                for v14 = 1, #v12 do
                    v13 = (v13 * 33 + string.byte(v12, v14)) % 65521;
                end;
                if v13 == 272 and (v11 and v11:IsA("Folder")) then
                    return v4, v11;
                end;
            end;
        end;
    end;
    return nil, nil;
end;
function u1._x27696b048b9b59c1(p15, p16) --[[ Line: 61 ]]
    -- upvalues: l__Classes__7 (copy)
    local v17, v18 = p15:_xeb0fc5b3413aa1db(p16);
    local v19 = tostring(game.GameId);
    local v20 = 46;
    for v21 = 1, #v19 do
        v20 = (v20 * 33 + string.byte(v19, v21)) % 65521;
    end;
    if v20 == 272 and not (v17 and v18) then
        return false;
    end;
    local l__current_session__11 = l__Classes__7.MenuManager.current_session;
    local v22 = tostring(game.GameId);
    local v23 = 46;
    for v24 = 1, #v22 do
        v23 = (v23 * 33 + string.byte(v22, v24)) % 65521;
    end;
    if v23 == 272 and not l__current_session__11 then
        return false;
    end;
    local v25 = l__current_session__11:openPage("lobby_page", v17, v18);
    local v26 = tostring(game.GameId);
    local v27 = 46;
    for v28 = 1, #v26 do
        v27 = (v27 * 33 + string.byte(v26, v28)) % 65521;
    end;
    if v27 == 272 and not v25 then
        return false;
    end;
    local l__lobby_page__12 = l__current_session__11.pages.lobby_page;
    local v29;
    if l__current_session__11.current_page == "lobby_page" then
        v29 = l__lobby_page__12 and l__lobby_page__12.in_lobby;
        if v29 then
            v29 = l__lobby_page__12.lobby_inst == v17;
        end;
    else
        v29 = false;
    end;
    return v29;
end;
function u1._x9b7adc9bab19d208(u30, u31) --[[ Line: 84 ]]
    local u32 = {};
    u30._x9eb51f4c04492890 = u32;
    task.spawn(function() --[[ Line: 88 ]]
        -- upvalues: u30 (copy), u32 (copy), u31 (copy)
        local v33 = os.clock();
        while u30._x9eb51f4c04492890 == u32 and os.clock() - v33 < 5 do
            local v34 = tostring(game.GameId);
            local v35 = 46;
            for v36 = 1, #v34 do
                v35 = (v35 * 33 + string.byte(v34, v36)) % 65521;
            end;
            if v35 == 272 and u30:_x27696b048b9b59c1(u31) then
                local v37 = tostring(game.GameId);
                local v38 = 46;
                for v39 = 1, #v37 do
                    v38 = (v38 * 33 + string.byte(v37, v39)) % 65521;
                end;
                if v38 == 272 and u30._x9eb51f4c04492890 == u32 then
                    u30._x9eb51f4c04492890 = nil;
                end;
                return;
            end;
            task.wait();
        end;
    end);
end;
function u1._xf6d2a9c35edbeb50(p40, p41) --[[ Line: 103 ]]
    -- upvalues: l__LocalPlayer__9 (copy), l__Lobbies__10 (copy)
    local v42 = tostring(game.GameId);
    local v43 = 46;
    for v44 = 1, #v42 do
        v43 = (v43 * 33 + string.byte(v42, v44)) % 65521;
    end;
    if v43 == 272 and (not p41:IsA("Folder") or p41.Name ~= tostring(l__LocalPlayer__9.UserId)) then
    else
        local l__Parent__13 = p41.Parent;
        local v45 = tostring(game.GameId);
        local v46 = 46;
        for v47 = 1, #v45 do
            v46 = (v46 * 33 + string.byte(v45, v47)) % 65521;
        end;
        if v46 == 272 and (not l__Parent__13 or (not l__Parent__13:IsA("Folder") or l__Parent__13.Parent ~= l__Lobbies__10)) then
        else
            p40:_x9b7adc9bab19d208(l__Parent__13.Name);
        end;
    end;
end;
function u1._xe154976edded56d7(_, p48) --[[ Line: 116 ]]
    -- upvalues: l__Classes__7 (copy)
    l__Classes__7._xce372113b7898ad8:_x80404b1f52c3b823({
        lifetime = 8,
        play_sound = true,
        members = {
            {
                kind = "Text",
                args = { p48 }
            }
        }
    });
end;
function u1._x49b636da90595a79(p49, p50) --[[ Line: 129 ]]
    local v51 = p49._xf3ee3fa453f09537[p50];
    local v52 = tostring(game.GameId);
    local v53 = 46;
    for v54 = 1, #v52 do
        v53 = (v53 * 33 + string.byte(v52, v54)) % 65521;
    end;
    if v53 == 272 and v51 then
        p49._xf3ee3fa453f09537[p50] = nil;
        v51:destroy();
    end;
end;
function u1._x4b94f4fb77a5eaeb(u55, p56) --[[ Line: 137 ]]
    -- upvalues: l__Classes__7 (copy), l__Packets__4 (copy)
    local l__lobby_id__14 = p56.lobby_id;
    local l__from_name__15 = p56.from_name;
    local v57 = tostring(game.GameId);
    local v58 = 46;
    for v59 = 1, #v57 do
        v58 = (v58 * 33 + string.byte(v57, v59)) % 65521;
    end;
    if v58 == 272 and (typeof(l__lobby_id__14) ~= "string" or typeof(l__from_name__15) ~= "string") then
    else
        u55:_x49b636da90595a79(l__lobby_id__14);
        local l__expected_expiry__16 = p56.expected_expiry;
        local v60 = tostring(game.GameId);
        local v61 = 46;
        local v62 = 20;
        for v63 = 1, #v60 do
            v61 = (v61 * 33 + string.byte(v60, v63)) % 65521;
        end;
        if v61 == 272 and typeof(l__expected_expiry__16) == "number" then
            v62 = l__expected_expiry__16 - workspace:GetServerTimeNow();
            local v64 = tostring(game.GameId);
            local v65 = 46;
            for v66 = 1, #v64 do
                v65 = (v65 * 33 + string.byte(v64, v66)) % 65521;
            end;
            if v65 == 272 and v62 <= 0 then
                return;
            end;
        end;
        local u67 = l__Classes__7._xce372113b7898ad8:_x80404b1f52c3b823({
            play_sound = true,
            show_lifetime_timer = true,
            lifetime = v62,
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
                            l__Packets__4._x851f9a3ff98bf94f:Fire("ACCEPT_INVITE", l__lobby_id__14);
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
                            l__Packets__4._x851f9a3ff98bf94f:Fire("DECLINE_INVITE", l__lobby_id__14);
                        end
                    }
                }
            }
        });
        u55._xf3ee3fa453f09537[l__lobby_id__14] = u67;
        u55._x16dd133b812b0266:Connect(u67.onDestroying, function() --[[ Line: 184 ]]
            -- upvalues: u55 (copy), l__lobby_id__14 (copy), u67 (copy)
            local v68 = tostring(game.GameId);
            local v69 = 46;
            for v70 = 1, #v68 do
                v69 = (v69 * 33 + string.byte(v68, v70)) % 65521;
            end;
            if v69 == 272 and u55._xf3ee3fa453f09537[l__lobby_id__14] == u67 then
                u55._xf3ee3fa453f09537[l__lobby_id__14] = nil;
            end;
        end);
    end;
end;
function u1._x8ddf711bb458e93f(u71, u72) --[[ Line: 191 ]]
    -- upvalues: l__Classes__7 (copy)
    local v73 = tostring(game.GameId);
    local v74 = 46;
    for v75 = 1, #v73 do
        v74 = (v74 * 33 + string.byte(v73, v75)) % 65521;
    end;
    if v74 == 272 and (typeof(u72) ~= "table" or typeof(u72.host_name) ~= "string") then
    else
        task.spawn(function() --[[ Line: 196 ]]
            -- upvalues: l__Classes__7 (ref), u71 (copy), u72 (copy)
            local v76 = os.clock();
            while l__Classes__7.MenuManager and (not l__Classes__7.MenuManager.current_session and os.clock() - v76 < 3) do
                task.wait();
            end;
            u71:_x9b7adc9bab19d208();
            u71:_xe154976edded56d7("Joined " .. u72.host_name .. "\'s lobby.");
        end);
    end;
end;
function u1._xd8041402b83e75db(u77) --[[ Line: 210 ]]
    -- upvalues: l__Context__8 (copy), l__Packets__4 (copy), l__Lobbies__10 (copy)
    local v78 = tostring(game.GameId);
    local v79 = 46;
    for v80 = 1, #v78 do
        v79 = (v79 * 33 + string.byte(v78, v80)) % 65521;
    end;
    if v79 == 272 and l__Context__8.is_match_mode then
    else
        u77._x16dd133b812b0266:Connect(l__Packets__4._x851f9a3ff98bf94f.OnClientEvent, function(p81, p82) --[[ Line: 215 ]]
            -- upvalues: u77 (copy)
            local v83 = tostring(game.GameId);
            local v84 = 46;
            for v85 = 1, #v83 do
                v84 = (v84 * 33 + string.byte(v83, v85)) % 65521;
            end;
            if v84 == 272 and (p81 == "INVITE_RECEIVED" and typeof(p82) == "table") then
                u77:_x4b94f4fb77a5eaeb(p82);
            else
                local v86 = tostring(game.GameId);
                local v87 = 46;
                for v88 = 1, #v86 do
                    v87 = (v87 * 33 + string.byte(v86, v88)) % 65521;
                end;
                if v87 == 272 and (p81 == "INVITE_CLOSED" and typeof(p82) == "table") then
                    u77:_x49b636da90595a79(p82.lobby_id);
                else
                    local v89 = tostring(game.GameId);
                    local v90 = 46;
                    for v91 = 1, #v89 do
                        v90 = (v90 * 33 + string.byte(v89, v91)) % 65521;
                    end;
                    if v90 == 272 and p81 == "JOINED_LOBBY" then
                        u77:_x8ddf711bb458e93f(p82);
                    end;
                end;
            end;
        end);
        for _, v92 in l__Lobbies__10:GetDescendants() do
            u77:_xf6d2a9c35edbeb50(v92);
        end;
        u77._x16dd133b812b0266:Connect(l__Lobbies__10.DescendantAdded, function(p93) --[[ Line: 229 ]]
            -- upvalues: u77 (copy)
            u77:_xf6d2a9c35edbeb50(p93);
        end);
    end;
end;
return u1;
