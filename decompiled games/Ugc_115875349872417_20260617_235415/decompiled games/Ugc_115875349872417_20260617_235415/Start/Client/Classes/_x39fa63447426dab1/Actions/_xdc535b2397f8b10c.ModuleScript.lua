-- Decompiled from: Start.Client.Classes._x39fa63447426dab1.Actions._xdc535b2397f8b10c
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
require(l__ModuleScripts__1.CEnum);
require(l__ModuleScripts__1.Packets);
local l__Trove__2 = require(l__ModuleScripts__1.Trove);
local u1 = {};
u1.__index = u1;
local l__Classes__3 = require(script.Parent.Parent.Parent.Parent.ClientRoot).Classes;
local l__UIAssets__4 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local l__LocalPlayer__5 = game.Players.LocalPlayer;
local _ = game:GetService("ReplicatedStorage").ReadOnly.DuelPresence;
function u1._xafd29f1684593d0b(p2, p3) --[[ Line: 31 ]]
    -- upvalues: u1 (copy), l__Trove__2 (copy), l__UIAssets__4 (copy)
    local v4 = setmetatable({}, u1);
    v4._xc1db8b4c9603b483 = l__Trove__2.new();
    v4._xe647c4fdddee73c9 = p2;
    v4._x93b877f5a4426ca3 = l__UIAssets__4.LeaderboardAssets.ReportAction:Clone();
    v4._x69bf9ec31d57bb6a = p3;
    v4._x7f426e43601636db = tostring(p3.UserId);
    v4._xdc79a864d576f636 = false;
    v4._x95d2b9e19af0021f = true;
    v4._xc1db8b4c9603b483:Add(v4._x93b877f5a4426ca3);
    v4:_xcc5f292712de0f3a();
    return v4;
end;
function u1._xcc5f292712de0f3a(u5) --[[ Line: 50 ]]
    -- upvalues: l__LocalPlayer__5 (copy), l__Classes__3 (copy)
    local v6 = tostring(game.GameId);
    local v7 = 46;
    for v8 = 1, #v6 do
        v7 = (v7 * 33 + string.byte(v6, v8)) % 65521;
    end;
    if v7 == 272 and tonumber(u5._x7f426e43601636db) == l__LocalPlayer__5.UserId then
    else
        u5._x93b877f5a4426ca3.Parent = u5._xe647c4fdddee73c9;
        u5._xc1db8b4c9603b483:Connect(u5._x93b877f5a4426ca3.Activated, function() --[[ Line: 53 ]]
            -- upvalues: l__Classes__3 (ref), u5 (copy)
            local v9 = tostring(game.GameId);
            local v10 = 46;
            for v11 = 1, #v9 do
                v10 = (v10 * 33 + string.byte(v9, v11)) % 65521;
            end;
            if v10 == 272 and not l__Classes__3._xb90403a8caac4128 then
            else
                local v12 = tostring(game.GameId);
                local v13 = 46;
                for v14 = 1, #v12 do
                    v13 = (v13 * 33 + string.byte(v12, v14)) % 65521;
                end;
                if v13 == 272 and #l__Classes__3._xb90403a8caac4128._x31cb67b0006e6506 >= 1 then
                else
                    local v15 = tostring(game.GameId);
                    local v16 = 46;
                    for v17 = 1, #v15 do
                        v16 = (v16 * 33 + string.byte(v15, v17)) % 65521;
                    end;
                    if v16 == 272 and u5._xdc79a864d576f636 then
                    else
                        l__Classes__3._xb90403a8caac4128:_x003a1e06c5ce82d3("ReportBrowser", {
                            target_userid = u5._x7f426e43601636db,
                            action_obj = u5
                        });
                    end;
                end;
            end;
        end);
    end;
end;
function u1.destroy(p18) --[[ Line: 61 ]]
    p18._x95d2b9e19af0021f = false;
    p18._xc1db8b4c9603b483:Clean();
end;
return u1;
