-- Decompiled from: Start.Client.Classes._xd0d75b75975ea69f
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__TweenService__1 = game:GetService("TweenService");
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__3 = require(l__ModuleScripts__2.Packets);
local l__Signal__4 = require(l__ModuleScripts__2.Signal);
require(l__ModuleScripts__2.Promise);
local l__Trove__5 = require(l__ModuleScripts__2.Trove);
require(l__ModuleScripts__2.Spring);
local u1 = {};
u1.__index = u1;
local l__Classes__6 = require(script.Parent.Parent.ClientRoot).Classes;
local l__InternalSymbols__7 = require(script.Parent.Parent.InternalSymbols);
local l__LocalPlayer__8 = game.Players.LocalPlayer;
local l__UIAssets__9 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local u2 = 0;
function u1._x90d4581ac99dd483() --[[ Line: 27 ]]
    -- upvalues: u1 (copy), l__Signal__4 (copy)
    local v3 = setmetatable({}, u1);
    v3._x573dc8ad3e0460fc = nil;
    v3._xf937c18a9822145c = nil;
    v3._x569b3e5c6eca6d3f = {};
    v3._x3ea326512e2ff25c = l__Signal__4.new();
    return v3;
end;
function u1._xfbe5ecce6cf9cb86(p4, p5, p6) --[[ Line: 39 ]]
    -- upvalues: l__InternalSymbols__7 (copy)
    if p5 then
        p4._x573dc8ad3e0460fc = p5;
        if p6 then
            p4._xf937c18a9822145c = p5;
        end;
        for v7 in p4._x569b3e5c6eca6d3f do
            local v8 = l__InternalSymbols__7.owner("", v7);
            if v8:_xb12f917d3f269459() then
                v8:_x674404a40be09c8c(p5);
            else
                p4._x569b3e5c6eca6d3f[v8] = nil;
            end;
        end;
    end;
end;
function u1._x8ad7adc7f7f0508f(p9, p10) --[[ Line: 57 ]]
    local v11 = p10 or p9:_xb6b5eb80e16aa458();
    p9:_xfbe5ecce6cf9cb86(v11);
    if p9._xf937c18a9822145c == v11 then
    else
        p9._xf937c18a9822145c = v11;
        p9._x3ea326512e2ff25c:Fire(v11);
    end;
end;
function u1._xb6b5eb80e16aa458(_) --[[ Line: 69 ]]
    -- upvalues: l__LocalPlayer__8 (copy), l__Classes__6 (copy)
    local v12 = nil;
    if l__LocalPlayer__8.PlayerGui:FindFirstChild("MatchResultsScreen") then
        return l__LocalPlayer__8.PlayerGui:FindFirstChild("MatchResultsScreen").Main.NotificationList;
    end;
    if l__Classes__6.MenuManager and l__Classes__6.MenuManager.current_session then
        return l__Classes__6.MenuManager.current_session.os_ui.RightContainer.MainOS.NotificationList;
    end;
    if l__Classes__6._xafc4950d7b094088 and l__Classes__6._xafc4950d7b094088._x964f370fda99e2af then
        v12 = l__Classes__6._xafc4950d7b094088._x964f370fda99e2af.Misc.NotificationList;
    end;
    return v12;
end;
function u1._x54f11bcb5880e791(u13, p14) --[[ Line: 83 ]]
    -- upvalues: u2 (ref)
    u2 = u2 + 100;
    local l___x1d60eeaf052175c4__10 = require(script._x1d60eeaf052175c4);
    local v15 = u13:_xb6b5eb80e16aa458();
    u13._x573dc8ad3e0460fc = v15;
    local u16 = l___x1d60eeaf052175c4__10._x90d4581ac99dd483(v15, u2, p14);
    u13._x569b3e5c6eca6d3f[u16] = true;
    u16._x8d41d387e09a2404:Connect(function() --[[ Line: 90 ]]
        -- upvalues: u13 (copy), u16 (copy)
        u13._x569b3e5c6eca6d3f[u16] = nil;
    end;
    return u16;
end;
function u1._x00e1d9aa2084cbf1(p17, p18) --[[ Line: 96 ]]
    -- upvalues: l__UIAssets__9 (copy), l__Classes__6 (copy), l__TweenService__1 (copy)
    local u19 = l__UIAssets__9.SystemNotif:Clone();
    u19.Parent = p17._xa65ae184af63fc97.List;
    local v20 = p18.color or Color3.fromRGB(255, 69, 72);
    local v21 = p18.lifetime or 8;
    u19.BackgroundColor3 = v20;
    u19.Message.Text = p18.main_text;
    u19.Message.TextColor3 = l__Classes__6.Util:getContrastColor(v20);
    u19.Fill.BackgroundColor3 = l__Classes__6.Util:getContrastColor(v20);
    task.delay(0.06, function() --[[ Line: 108 ]]
        -- upvalues: u19 (copy)
        u19.Flash.Visible = false;
    end;
    task.delay(v21 - 0.06, function() --[[ Line: 112 ]]
        -- upvalues: u19 (copy), l__TweenService__1 (ref)
        u19.Flash.Visible = true;
        l__TweenService__1:Create(u19, TweenInfo.new(0.06, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(1, 0)
        }):Play();
    end;
    if p18.play_sound then
        l__Classes__6._xbe184fb1376a575d:_x7ab8b42cc5920a78("BLIP", true);
    end;
    l__TweenService__1:Create(u19.Fill, TweenInfo.new(v21 - 0.1, Enum.EasingStyle.Linear), {
        Size = UDim2.fromScale(1, 0.1)
    }):Play();
    l__TweenService__1:Create(u19, TweenInfo.new(0.1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(1, 0.035)
    }):Play();
    game.Debris:AddItem(u19, v21);
end;
function u1._xe53615d96cf36a6b(u22) --[[ Line: 127 ]]
    -- upvalues: l__Packets__3 (copy), l__UIAssets__9 (copy), l__LocalPlayer__8 (copy), l__Classes__6 (copy), l__Trove__5 (copy), l__InternalSymbols__7 (copy)
    l__Packets__3._x63c8955f84a980a6.OnClientEvent:Connect(function(p23, p24) --[[ Line: 128 ]]
        -- upvalues: u22 (copy)
        if p24 == "system" then
            u22:_x00e1d9aa2084cbf1(p23);
        else
            u22:_x54f11bcb5880e791(p23);
        end;
    end;
    u22._xa65ae184af63fc97 = l__UIAssets__9.SystemMessages:Clone();
    u22._xa65ae184af63fc97.Parent = l__LocalPlayer__8.PlayerGui;
    local u25 = {};
    l__Packets__3._x6c53c187238c8a23.OnClientEvent:Connect(function(u26) --[[ Line: 141 ]]
        -- upvalues: l__Classes__6 (ref), l__Trove__5 (ref), u25 (copy), u22 (copy), l__InternalSymbols__7 (ref), l__Packets__3 (ref)
        if u26.op == "votekick_start" then
            local u27 = game:GetService("Players"):GetPlayerByUserId(u26.target_userid);
            if u27 then
                local l__KeyCode__11 = l__Classes__6._x3e046bec2684f59c:_xc9966245cd0a44a8("LEADERBOARD_OPEN").KeyCode;
                local u28 = l__Classes__6._x3e046bec2684f59c:_xfeef7f7b762e94d9(l__KeyCode__11);
                local u29 = l__Trove__5.new();
                local u30 = os.clock() + 23;
                local u31 = false;
                local u32 = false;
                local u33 = nil;
                local u34 = nil;
                local u35 = nil;
                local u36 = nil;
                local u37 = nil;
                local function u39(p38) --[[ Line: 156 ]]
                    -- upvalues: u37 (ref), u36 (ref)
                    if p38 == "yes" and u37 then
                        u37.Main.TextButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120);
                    else
                        if p38 == "no" and u36 then
                            u36.Main.TextButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120);
                        end;
                    end;
                end;
                local function v40() --[[ Line: 164 ]]
                    -- upvalues: u32 (ref), u25 (ref), u26 (copy), u33 (ref), u29 (copy)
                    if u32 then
                    else
                        u32 = true;
                        u25[u26.target_userid] = nil;
                        if u33 then
                            u33:close();
                        end;
                        u29:Clean();
                    end;
                end;
                local function u45() --[[ Line: 175 ]]
                    -- upvalues: u30 (copy), u33 (ref), u22 (ref), u27 (copy), u28 (copy), l__InternalSymbols__7 (ref), u37 (ref), u31 (ref), l__Packets__3 (ref), u26 (copy), u36 (ref), u34 (ref), u35 (ref), u39 (copy)
                    if u30 <= os.clock() then
                    else
                        u33 = u22:_x54f11bcb5880e791({
                            lifetime = 23,
                            expires_at = u30,
                            play_sound = u33 == nil,
                            members = {
                                {
                                    kind = "Header",
                                    args = { "KICK " .. u27.Name .. "?", "exclamation", Color3.fromRGB(255, 67, 67) }
                                },
                                {
                                    kind = "Text",
                                    args = { "You can hold [" .. u28 .. "] to free your mouse." }
                                }
                            }
                        });
                        u33 = l__InternalSymbols__7.owner("", u33);
                        local v41, v42 = u33:_xef011e5e4aa6f4d3({
                            text = "(0 Voted) No",
                            close_on_activated = false,
                            color = Color3.fromRGB(255, 67, 67)
                        }, function() --[[ Line: 201 ]]
                            -- upvalues: u31 (ref), l__Packets__3 (ref), u26 (ref), u36 (ref)
                            if u31 then
                            else
                                u31 = "no";
                                l__Packets__3._x6c53c187238c8a23:Fire({
                                    op = "votekick_vote",
                                    choice = "no",
                                    target_userid = u26.target_userid
                                });
                                if u36 then
                                    u36.Main.TextButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120);
                                end;
                            end;
                        end;
                        _ = v41;
                        u37 = v42;
                        local v43, v44 = u33:_xef011e5e4aa6f4d3({
                            text = "(0 Voted) Yes",
                            close_on_activated = false,
                            color = Color3.fromRGB(80, 255, 80)
                        }, function() --[[ Line: 218 ]]
                            -- upvalues: u31 (ref), l__Packets__3 (ref), u26 (ref), u37 (ref)
                            if u31 then
                            else
                                u31 = "yes";
                                l__Packets__3._x6c53c187238c8a23:Fire({
                                    op = "votekick_vote",
                                    choice = "yes",
                                    target_userid = u26.target_userid
                                });
                                if u37 then
                                    u37.Main.TextButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120);
                                end;
                            end;
                        end;
                        _ = v43;
                        u36 = v44;
                        u34 = u36.Main.TextLabel;
                        u35 = u37.Main.TextLabel;
                        if u31 then
                            u39(u31);
                        end;
                        u33:_x771df8767d455f39();
                    end;
                end;
                u45();
                task.delay(23, v40);
                u29:Connect(u22._x3ea326512e2ff25c, function(p46) --[[ Line: 245 ]]
                    -- upvalues: u30 (copy), u32 (ref), u25 (ref), u26 (copy), u33 (ref), u29 (copy), u45 (copy)
                    if u30 <= os.clock() then
                        if u32 then
                        else
                            u32 = true;
                            u25[u26.target_userid] = nil;
                            if u33 then
                                u33:close();
                            end;
                            u29:Clean();
                        end;
                    elseif u33 and (u33:_xb12f917d3f269459() and u33._x0da22addcae663b5 == p46) then
                    else
                        u45();
                        local v47 = u25[u26.target_userid];
                        if v47 and v47.last_yes then
                            v47.update_votes(v47.last_yes, v47.last_no);
                        end;
                    end;
                end;
                u29:Connect(u27.AncestryChanged, function(_, p48) --[[ Line: 264 ]]
                    -- upvalues: u32 (ref), u25 (ref), u26 (copy), u33 (ref), u29 (copy)
                    if not p48 then
                        if u32 then
                            return;
                        end;
                        u32 = true;
                        u25[u26.target_userid] = nil;
                        if u33 then
                            u33:close();
                        end;
                        u29:Clean();
                    end;
                end;
                u25[u26.target_userid] = {
                    last_yes = 0,
                    last_no = 0,
                    update_votes = function(p49, p50) --[[ Name: update_votes, Line 272 ]]
                        -- upvalues: u32 (ref), u25 (ref), u26 (copy), u33 (ref), u34 (ref), u35 (ref), u31 (ref)
                        if u32 then
                        else
                            local v51 = u25[u26.target_userid];
                            if v51 then
                                v51.last_yes = p49;
                                v51.last_no = p50;
                            end;
                            if u33 and (u34 and u35) then
                                u34.Text = "(" .. p49 .. " Voted) " .. (u31 == "yes" and "You voted Yes" or "Yes");
                                u35.Text = "(" .. p50 .. " Voted) " .. (u31 == "no" and "You voted No" or "No");
                            end;
                        end;
                    end,
                    close = v40
                };
            end;
        else
            if u26.op == "votekick_update" then
                local v52 = u25[u26.target_userid];
                if v52 then
                    v52.update_votes(u26.yes_votes, u26.no_votes);
                end;
            else
                local v53 = u26.op == "votekick_close" and u25[u26.target_userid];
                if v53 then
                    v53.close();
                end;
            end;
        end;
    end;
end;
return u1;
