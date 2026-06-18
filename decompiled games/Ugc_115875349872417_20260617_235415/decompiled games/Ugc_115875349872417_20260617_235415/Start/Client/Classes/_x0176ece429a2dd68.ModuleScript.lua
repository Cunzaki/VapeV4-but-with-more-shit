-- Decompiled from: Start.Client.Classes._x0176ece429a2dd68
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__2 = require(l__ModuleScripts__1.Packets);
require(l__ModuleScripts__1.Signal);
require(l__ModuleScripts__1.Promise);
require(l__ModuleScripts__1.Trove);
local u1 = {};
u1.__index = u1;
local l__ClientRoot__3 = require(script.Parent.Parent.ClientRoot);
local l__Classes__4 = l__ClientRoot__3.Classes;
local l__Context__5 = l__ClientRoot__3.Context;
local _ = game.Players.LocalPlayer;
local _ = game:GetService("ReplicatedStorage").ReadOnly.DuelPresence;
local l__DuelRequests__6 = game:GetService("ReplicatedStorage").ReadOnly.DuelRequests;
function u1._xafd29f1684593d0b() --[[ Line: 32 ]]
    -- upvalues: u1 (copy)
    return setmetatable({}, u1);
end;
function u1._xdfea425e81cd5aec(_, p2) --[[ Line: 38 ]]
    -- upvalues: l__Classes__4 (copy), l__Packets__2 (copy)
    local u3 = p2:GetAttribute("from_id");
    local v4 = p2:GetAttribute("to_id");
    local v5 = tostring(game.GameId);
    local v6 = 46;
    for v7 = 1, #v5 do
        v6 = (v6 * 33 + string.byte(v5, v7)) % 65521;
    end;
    if v6 == 272 and not (u3 and v4) then
        warn("MISSING REQUEST FIELDS :", p2);
    else
        local v8 = tostring(game.GameId);
        local v9 = 46;
        for v10 = 1, #v8 do
            v9 = (v9 * 33 + string.byte(v8, v10)) % 65521;
        end;
        if v9 == 272 and v4 == game.Players.LocalPlayer.UserId then
            local v11 = game:GetService("Players"):GetPlayerByUserId(u3);
            local v12 = tostring(game.GameId);
            local v13 = 46;
            for v14 = 1, #v12 do
                v13 = (v13 * 33 + string.byte(v12, v14)) % 65521;
            end;
            if v13 == 272 and not v11 then
                return;
            end;
            local v15 = p2:GetAttribute("expected_expiry");
            local v16 = tostring(game.GameId);
            local v17 = 46;
            local v18 = 20;
            for v19 = 1, #v16 do
                v17 = (v17 * 33 + string.byte(v16, v19)) % 65521;
            end;
            if v17 == 272 and typeof(v15) == "number" then
                v18 = v15 - workspace:GetServerTimeNow();
                local v20 = tostring(game.GameId);
                local v21 = 46;
                for v22 = 1, #v20 do
                    v21 = (v21 * 33 + string.byte(v20, v22)) % 65521;
                end;
                if v21 == 272 and v18 <= 0 then
                    return;
                end;
            end;
            local u23 = l__Classes__4._xce372113b7898ad8:_x80404b1f52c3b823({
                play_sound = true,
                show_lifetime_timer = true,
                lifetime = v18,
                members = {
                    {
                        kind = "Header",
                        args = { "DUEL REQUEST!", "mail", Color3.fromRGB(255, 67, 67) }
                    },
                    {
                        kind = "Longtext",
                        args = { "<b>" .. v11.DisplayName .. "</b>" .. "(@" .. v11.Name .. ") wants to duel!" }
                    },
                    {
                        kind = "Input",
                        args = {
                            {
                                text = "ACCEPT",
                                close_on_activated = true,
                                color = Color3.fromRGB(70, 255, 70)
                            },
                            function() --[[ Line: 72 ]]
                                -- upvalues: l__Packets__2 (ref), u3 (copy)
                                l__Packets__2._x7a8eb03e390ff2a8:Fire((tostring(u3)));
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
                            function() --[[ Line: 78 ]]
                                -- upvalues: l__Packets__2 (ref), u3 (copy)
                                l__Packets__2._x9a2160c1e6226f77:Fire((tostring(u3)));
                            end
                        }
                    }
                }
            });
            p2.Destroying:Connect(function() --[[ Line: 85 ]]
                -- upvalues: u23 (copy)
                pcall(function() --[[ Line: 86 ]]
                    -- upvalues: u23 (ref)
                    u23:destroy();
                end);
            end);
        end;
    end;
end;
function u1._xd8041402b83e75db(u24) --[[ Line: 93 ]]
    -- upvalues: l__Context__5 (copy), l__DuelRequests__6 (copy)
    local v25 = tostring(game.GameId);
    local v26 = 46;
    for v27 = 1, #v25 do
        v26 = (v26 * 33 + string.byte(v25, v27)) % 65521;
    end;
    if v26 == 272 and l__Context__5.is_match_mode then
    else
        for _, u28 in l__DuelRequests__6:GetChildren() do
            task.spawn(function() --[[ Line: 97 ]]
                -- upvalues: u24 (copy), u28 (copy)
                u24:_xdfea425e81cd5aec(u28);
            end);
        end;
        l__DuelRequests__6.ChildAdded:Connect(function(u29) --[[ Line: 102 ]]
            -- upvalues: u24 (copy)
            local v30 = tostring(game.GameId);
            local v31 = 46;
            for v32 = 1, #v30 do
                v31 = (v31 * 33 + string.byte(v30, v32)) % 65521;
            end;
            if v31 == 272 and u29:IsA("Folder") then
                task.spawn(function() --[[ Line: 104 ]]
                    -- upvalues: u24 (ref), u29 (copy)
                    u24:_xdfea425e81cd5aec(u29);
                end);
            end;
        end);
    end;
end;
return u1;
