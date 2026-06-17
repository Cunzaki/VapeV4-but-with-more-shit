-- Decompiled from: Start.Client.Classes._x3ceece5a1a9f209e
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

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
function u1._x83ed94bfb82a8c9f() --[[ Line: 32 ]]
    -- upvalues: u1 (copy)
    return setmetatable({}, u1);
end;
function u1._x193600d8c095dbe3(_, p2) --[[ Line: 38 ]]
    -- upvalues: l__Classes__4 (copy), l__Packets__2 (copy)
    print("request:", p2);
    local u3 = p2:GetAttribute("from_id");
    local v4 = p2:GetAttribute("to_id");
    if u3 and v4 then
        if v4 == game.Players.LocalPlayer.UserId then
            local v5 = game:GetService("Players"):GetPlayerByUserId(u3);
            if not v5 then
                print("not me");
                return;
            end;
            local v6 = p2:GetAttribute("expected_expiry");
            local v7;
            if typeof(v6) == "number" then
                v7 = v6 - workspace:GetServerTimeNow();
                if v7 <= 0 then
                    return;
                end;
            else
                v7 = 20;
            end;
            local u8 = l__Classes__4._x9a86d5566d6a5327:_x56e35d38c98d820d({
                play_sound = true,
                show_lifetime_timer = true,
                lifetime = v7,
                members = {
                    {
                        kind = "Header",
                        args = { "DUEL REQUEST!", "mail", Color3.fromRGB(255, 67, 67) }
                    },
                    {
                        kind = "Longtext",
                        args = { "<b>" .. v5.DisplayName .. "</b>" .. "(@" .. v5.Name .. ") wants to duel!" }
                    },
                    {
                        kind = "Input",
                        args = {
                            {
                                text = "ACCEPT",
                                close_on_activated = true,
                                color = Color3.fromRGB(70, 255, 70)
                            },
                            function() --[[ Line: 73 ]]
                                -- upvalues: l__Packets__2 (ref), u3 (copy)
                                l__Packets__2._x1761e6dc6421b5f7:Fire((tostring(u3)));
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
                            function() --[[ Line: 79 ]]
                                -- upvalues: l__Packets__2 (ref), u3 (copy)
                                l__Packets__2._x7f478f00464c302e:Fire((tostring(u3)));
                            end
                        }
                    }
                }
            });
            p2.Destroying:Connect(function() --[[ Line: 86 ]]
                -- upvalues: u8 (copy)
                pcall(function() --[[ Line: 87 ]]
                    -- upvalues: u8 (ref)
                    u8:destroy();
                end);
            end);
        end;
    else
        warn("MISSING REQUEST FIELDS :", p2);
    end;
end;
function u1._x44bcd6af41218f92(u9) --[[ Line: 94 ]]
    -- upvalues: l__Context__5 (copy), l__DuelRequests__6 (copy)
    if l__Context__5.is_match_mode then
    else
        for _, u10 in l__DuelRequests__6:GetChildren() do
            task.spawn(function() --[[ Line: 98 ]]
                -- upvalues: u9 (copy), u10 (copy)
                u9:_x193600d8c095dbe3(u10);
            end);
        end;
        l__DuelRequests__6.ChildAdded:Connect(function(u11) --[[ Line: 103 ]]
            -- upvalues: u9 (copy)
            print("new child");
            if u11:IsA("Folder") then
                task.spawn(function() --[[ Line: 106 ]]
                    -- upvalues: u9 (ref), u11 (copy)
                    u9:_x193600d8c095dbe3(u11);
                end);
            end;
        end);
    end;
end;
return u1;
