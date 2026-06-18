-- Decompiled from: Start.Client.Classes.MenuManager.MenuSession.DeployPage
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__TweenService__1 = game:GetService("TweenService");
game:GetService("UserInputService");
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__3 = require(l__ModuleScripts__2.Packets);
require(l__ModuleScripts__2.Signal);
local l__Promise__4 = require(l__ModuleScripts__2.Promise);
local l__Trove__5 = require(l__ModuleScripts__2.Trove);
require(l__ModuleScripts__2.Spring);
local l__UIAssets__6 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local u1 = {};
u1.__index = u1;
local l__Classes__7 = require(script.Parent.Parent.Parent.Parent.ClientRoot).Classes;
local l__InternalSymbols__8 = require(script.Parent.Parent.Parent.Parent.InternalSymbols);
local l__DuelPresence__9 = game:GetService("ReplicatedStorage").ReadOnly.DuelPresence;
local l__DuelRequests__10 = game:GetService("ReplicatedStorage").ReadOnly.DuelRequests;
local l__LocalPlayer__11 = game.Players.LocalPlayer;
local l__UserId__12 = l__LocalPlayer__11.UserId;
function u1.new(p2, p3) --[[ Line: 28 ]]
    -- upvalues: u1 (copy), l__InternalSymbols__8 (copy), l__UIAssets__6 (copy), l__Trove__5 (copy)
    local v4 = setmetatable({}, u1);
    v4.menu_session = l__InternalSymbols__8.owner("MenuSession", p3);
    v4.parent_os = p2;
    v4.page_origin = l__UIAssets__6.Menu.DeployPage;
    v4.main_page = v4.page_origin.DeployFrame:Clone();
    v4.trove = l__Trove__5.new();
    v4.duel_entries = {};
    return v4;
end;
function u1.cleanUp(p5) --[[ Line: 44 ]]
    p5.trove:Clean();
end;
function u1.close(p6) --[[ Line: 48 ]]
    -- upvalues: l__TweenService__1 (copy)
    local l__main_page__13 = p6.main_page;
    l__main_page__13.Interactable = false;
    l__TweenService__1:Create(l__main_page__13, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 1
    }):Play();
    l__TweenService__1:Create(l__main_page__13, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.In), {
        Position = UDim2.fromScale(0, 1)
    }):Play();
end;
function u1.start(p7) --[[ Line: 57 ]]
    -- upvalues: l__TweenService__1 (copy)
    local _ = p7.page_origin;
    local l__main_page__14 = p7.main_page;
    l__main_page__14.Parent = p7.parent_os.RightContainer.MainOS;
    l__main_page__14.Interactable = true;
    l__main_page__14.GroupTransparency = 1;
    l__TweenService__1:Create(l__main_page__14, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    }):Play();
    l__main_page__14.Position = UDim2.fromScale(0, 0);
    l__main_page__14.Borders.PresenceList.GroupTransparency = 1;
    l__TweenService__1:Create(l__main_page__14.Borders.PresenceList, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        GroupTransparency = 0
    }):Play();
end;
function u1._processDuelRequest(u8, p9) --[[ Line: 71 ]]
    -- upvalues: l__UserId__12 (copy)
    local v10 = p9:GetAttribute("from_id");
    local v11 = p9:GetAttribute("to_id");
    if v10 and v11 then
        if v10 == l__UserId__12 then
            local u12 = u8.duel_entries[tostring(v11)];
            u8:_updateState(u12, "SENT", p9, (p9:GetAttribute("expected_expiry")));
            u8.trove:Add(p9.Destroying:Connect(function() --[[ Line: 82 ]]
                -- upvalues: u12 (copy), u8 (copy)
                u12.send_expiry = workspace:GetServerTimeNow() + 30;
                u8:_updateState(u12);
            end));
        elseif v11 == l__UserId__12 then
            local u13 = u8.duel_entries[tostring(v10)];
            u8:_updateState(u13, "RECIEVED", p9, (p9:GetAttribute("expected_expiry")));
            u8.trove:Add(p9.Destroying:Connect(function() --[[ Line: 95 ]]
                -- upvalues: u8 (copy), u13 (copy)
                u8:_updateState(u13);
            end));
        end;
    else
        warn("MISSING REQUEST FIELDS :", p9);
    end;
end;
function u1._updateState(u14, u15, p16, _) --[[ Line: 103 ]]
    -- upvalues: l__Classes__7 (copy), l__Packets__3 (copy), l__Promise__4 (copy), l__TweenService__1 (copy)
    if u15 then
        u15._state_trove:Clean();
        workspace:GetServerTimeNow();
        local _ = u14.page_origin;
        local l__duel_entry__15 = u15.duel_entry;
        local l__Info__16 = l__duel_entry__15.Container.Back.Info;
        local l__TextLabel__17 = l__Info__16.Button1.TextLabel;
        local l__TextLabel__18 = l__Info__16.Button2.TextLabel;
        local l__TextLabel__19 = l__Info__16.Button3.TextLabel;
        l__duel_entry__15.Container.Darken.Visible = false;
        local function v20() --[[ Line: 127 ]]
            -- upvalues: u15 (copy), l__TextLabel__17 (copy), l__TextLabel__19 (copy), l__Classes__7 (ref), l__Packets__3 (ref), l__Promise__4 (ref), u14 (copy), l__Info__16 (copy), l__TweenService__1 (ref), l__TextLabel__18 (copy)
            u15.state = "SENT";
            l__TextLabel__17.Text = "SENT";
            l__TextLabel__17.BackgroundTransparency = 0;
            l__TextLabel__17.TextColor3 = Color3.fromRGB(0, 0, 0);
            l__TextLabel__19.Text = "CANCEL";
            l__TextLabel__19.BackgroundTransparency = 1;
            l__TextLabel__19.TextColor3 = Color3.fromRGB(255, 0, 0);
            local u17 = nil;
            u17 = l__TextLabel__19.MouseButton1Click:Connect(function() --[[ Line: 139 ]]
                -- upvalues: u17 (ref), l__Classes__7 (ref), l__TextLabel__19 (ref), l__Packets__3 (ref), u15 (ref), l__Promise__4 (ref), u14 (ref)
                u17:Disconnect();
                l__Classes__7._x02c5f8f89640473a:_xa2c2f0587694a915("TAPE_MOVE", true);
                l__TextLabel__19.Text = "CANCELLING...";
                l__TextLabel__19.BackgroundTransparency = 1;
                l__TextLabel__19.TextColor3 = Color3.fromRGB(141, 141, 141);
                l__Packets__3._x9a2160c1e6226f77:Fire(u15.entry_userid);
                local v18 = l__Promise__4.delay(10);
                v18:andThen(function() --[[ Line: 150 ]]
                    -- upvalues: u14 (ref), u15 (ref)
                    u14:_updateState(u15);
                end);
                u15._state_trove:AddPromise(v18);
            end);
            u15._state_trove:Add(u17);
            l__Info__16.Countdown.Value = 30;
            local v19 = l__TweenService__1:Create(l__Info__16.Countdown, TweenInfo.new(30, Enum.EasingStyle.Linear), {
                Value = 0
            });
            v19:Play();
            l__TextLabel__18.Text = l__Info__16.Countdown.Value .. "s";
            l__TextLabel__18.BackgroundTransparency = 1;
            l__TextLabel__18.TextColor3 = Color3.fromRGB(141, 141, 141);
            u15._state_trove:Add(l__Info__16.Countdown.Changed:Connect(function() --[[ Line: 170 ]]
                -- upvalues: l__TextLabel__18 (ref), l__Info__16 (ref)
                l__TextLabel__18.Text = l__Info__16.Countdown.Value .. "s";
                l__TextLabel__18.BackgroundTransparency = 1;
                l__TextLabel__18.TextColor3 = Color3.fromRGB(141, 141, 141);
            end));
            u15._state_trove:Add(v19);
        end;
        local function v25() --[[ Line: 177 ]]
            -- upvalues: u15 (copy), l__TextLabel__17 (copy), l__TextLabel__18 (copy), l__TextLabel__19 (copy), l__Classes__7 (ref), l__Packets__3 (ref), l__Promise__4 (ref), u14 (copy)
            u15.state = "RECIEVED";
            l__TextLabel__17.Text = "DUEL?";
            l__TextLabel__17.BackgroundTransparency = 0;
            l__TextLabel__17.TextColor3 = Color3.fromRGB(0, 0, 0);
            l__TextLabel__18.Text = "ACCEPT";
            l__TextLabel__18.BackgroundTransparency = 1;
            l__TextLabel__18.TextColor3 = Color3.fromRGB(0, 255, 0);
            l__TextLabel__19.Text = "DECLINE";
            l__TextLabel__19.BackgroundTransparency = 1;
            l__TextLabel__19.TextColor3 = Color3.fromRGB(255, 0, 0);
            local u21 = nil;
            local u22 = nil;
            u22 = l__TextLabel__18.MouseButton1Click:Connect(function() --[[ Line: 194 ]]
                -- upvalues: u22 (ref), u21 (ref), l__Classes__7 (ref), l__TextLabel__18 (ref), l__Packets__3 (ref), u15 (ref), l__Promise__4 (ref), u14 (ref)
                u22:Disconnect();
                u21:Disconnect();
                l__Classes__7._x02c5f8f89640473a:_xa2c2f0587694a915("TAPE_MOVE", true);
                l__TextLabel__18.Text = "ACCEPTING...";
                l__TextLabel__18.BackgroundTransparency = 1;
                l__TextLabel__18.TextColor3 = Color3.fromRGB(141, 141, 141);
                l__Packets__3._x7a8eb03e390ff2a8:Fire(u15.entry_userid);
                local v23 = l__Promise__4.delay(10);
                v23:andThen(function() --[[ Line: 206 ]]
                    -- upvalues: u14 (ref), u15 (ref)
                    u14:_updateState(u15);
                end);
                u15._state_trove:AddPromise(v23);
            end);
            u21 = l__TextLabel__19.MouseButton1Click:Connect(function() --[[ Line: 212 ]]
                -- upvalues: u22 (ref), u21 (ref), l__Classes__7 (ref), l__TextLabel__19 (ref), l__Packets__3 (ref), u15 (ref), l__Promise__4 (ref), u14 (ref)
                u22:Disconnect();
                u21:Disconnect();
                l__Classes__7._x02c5f8f89640473a:_xa2c2f0587694a915("TAPE_MOVE", true);
                l__TextLabel__19.Text = "DECLINING...";
                l__TextLabel__19.BackgroundTransparency = 1;
                l__TextLabel__19.TextColor3 = Color3.fromRGB(141, 141, 141);
                l__Packets__3._x9a2160c1e6226f77:Fire(u15.entry_userid);
                local v24 = l__Promise__4.delay(10);
                v24:andThen(function() --[[ Line: 224 ]]
                    -- upvalues: u14 (ref), u15 (ref)
                    u14:_updateState(u15);
                end);
                u15._state_trove:AddPromise(v24);
            end);
            u15._state_trove:Add(u22);
            u15._state_trove:Add(u21);
        end;
        local function v33() --[[ Line: 246 ]]
            -- upvalues: u15 (copy), l__TextLabel__17 (copy), l__Classes__7 (ref), l__Packets__3 (ref), l__Promise__4 (ref), u14 (copy), l__Info__16 (copy), l__TweenService__1 (ref), l__TextLabel__18 (copy), l__TextLabel__19 (copy)
            u15.state = "FREE";
            local v26 = u15.send_expiry - workspace:GetServerTimeNow();
            local function u29() --[[ Line: 250 ]]
                -- upvalues: l__TextLabel__17 (ref), l__Classes__7 (ref), l__Packets__3 (ref), u15 (ref), l__Promise__4 (ref), u14 (ref)
                l__TextLabel__17.Text = "DUEL";
                l__TextLabel__17.BackgroundTransparency = 1;
                l__TextLabel__17.TextColor3 = Color3.fromRGB(255, 0, 0);
                local u27 = nil;
                u27 = l__TextLabel__17.MouseButton1Click:Connect(function() --[[ Line: 256 ]]
                    -- upvalues: u27 (ref), l__Classes__7 (ref), l__TextLabel__17 (ref), l__Packets__3 (ref), u15 (ref), l__Promise__4 (ref), u14 (ref)
                    u27:Disconnect();
                    l__Classes__7._x02c5f8f89640473a:_xa2c2f0587694a915("TAPE_MOVE", true);
                    l__TextLabel__17.Text = "SENDING...";
                    l__TextLabel__17.BackgroundTransparency = 1;
                    l__TextLabel__17.TextColor3 = Color3.fromRGB(141, 141, 141);
                    l__Packets__3._x7a8eb03e390ff2a8:Fire(u15.entry_userid);
                    local v28 = l__Promise__4.delay(10);
                    v28:andThen(function() --[[ Line: 267 ]]
                        -- upvalues: u14 (ref), u15 (ref)
                        u14:_updateState(u15);
                    end);
                    u15._state_trove:AddPromise(v28);
                end);
                u15._state_trove:Add(u27);
            end;
            if v26 > 0 then
                l__Info__16.Countdown.Value = v26;
                local v30 = l__TweenService__1:Create(l__Info__16.Countdown, TweenInfo.new(v26, Enum.EasingStyle.Linear), {
                    Value = 0
                });
                v30:Play();
                l__TextLabel__17.Text = "WAIT " .. l__Info__16.Countdown.Value .. "s";
                l__TextLabel__17.BackgroundTransparency = 1;
                l__TextLabel__17.TextColor3 = Color3.fromRGB(141, 141, 141);
                u15._state_trove:Add(v30.Completed:Connect(function() --[[ Line: 289 ]]
                    -- upvalues: u29 (copy)
                    u29();
                end));
                u15._state_trove:Add(l__Info__16.Countdown.Changed:Connect(function() --[[ Line: 293 ]]
                    -- upvalues: l__TextLabel__17 (ref), l__Info__16 (ref)
                    l__TextLabel__17.Text = "WAIT " .. l__Info__16.Countdown.Value .. "s";
                    l__TextLabel__17.BackgroundTransparency = 1;
                    l__TextLabel__17.TextColor3 = Color3.fromRGB(141, 141, 141);
                end));
                u15._state_trove:Add(v30);
            else
                u29();
            end;
            local v31 = l__TextLabel__18;
            v31.Text = "--";
            v31.BackgroundTransparency = 1;
            v31.TextColor3 = Color3.fromRGB(63, 63, 63);
            local v32 = l__TextLabel__19;
            v32.Text = "--";
            v32.BackgroundTransparency = 1;
            v32.TextColor3 = Color3.fromRGB(63, 63, 63);
        end;
        local v34 = u15.presence_inst:GetAttribute("state");
        local v35 = u15.presence_inst:GetAttribute("request_mode");
        if p16 then
            if p16 == "SENT" then
                v20();
            elseif p16 == "RECIEVED" then
                v25();
            end;
        elseif v34 == "BUSY" then
            u15.state = "BUSY";
            l__TextLabel__17.Text = "BUSY";
            l__TextLabel__17.BackgroundTransparency = 1;
            l__TextLabel__17.TextColor3 = Color3.fromRGB(141, 141, 141);
            l__duel_entry__15.Container.Darken.Visible = true;
            l__TextLabel__18.Text = "--";
            l__TextLabel__18.BackgroundTransparency = 1;
            l__TextLabel__18.TextColor3 = Color3.fromRGB(63, 63, 63);
            l__TextLabel__19.Text = "--";
            l__TextLabel__19.BackgroundTransparency = 1;
            l__TextLabel__19.TextColor3 = Color3.fromRGB(63, 63, 63);
        elseif v34 == "FREE" then
            if v35 == "Friends Only" and u15.is_friend then
                v33();
            elseif v35 == "All" then
                v33();
            else
                u15.state = "BUSY";
                l__TextLabel__17.Text = "BUSY";
                l__TextLabel__17.BackgroundTransparency = 1;
                l__TextLabel__17.TextColor3 = Color3.fromRGB(141, 141, 141);
                l__duel_entry__15.Container.Darken.Visible = true;
                l__TextLabel__18.Text = "--";
                l__TextLabel__18.BackgroundTransparency = 1;
                l__TextLabel__18.TextColor3 = Color3.fromRGB(63, 63, 63);
                l__TextLabel__19.Text = "--";
                l__TextLabel__19.BackgroundTransparency = 1;
                l__TextLabel__19.TextColor3 = Color3.fromRGB(63, 63, 63);
            end;
        end;
        u14:_refreshDuelList();
    else
        warn("NIL ENTRY DATA");
    end;
end;
function u1._refreshDuelList(p36) --[[ Line: 335 ]]
    -- upvalues: l__Classes__7 (copy), l__TweenService__1 (copy)
    local _ = p36.page_origin;
    local l__main_page__20 = p36.main_page;
    local l__ScrollingFrame__21 = l__main_page__20.Borders.PresenceList.ScrollingFrame;
    local l__NoPlayers__22 = l__main_page__20.Borders.PresenceList.NoPlayers;
    local l___x6c5abddbda8a829c__23 = l__Classes__7._x596eb619070480ba._x6c5abddbda8a829c;
    local function v40(p37, p38) --[[ Line: 350 ]]
        -- upvalues: l__TweenService__1 (ref)
        local v39 = 0.2 * (p38 - 1);
        l__TweenService__1:Create(p37, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0, v39)
        }):Play();
    end;
    local v41 = {};
    local u42 = {
        SENT = 1,
        RECIEVED = 2,
        FREE = 3,
        BUSY = 4
    };
    local v43 = 0;
    local v44 = 0.12;
    for _, v45 in p36.duel_entries do
        table.insert(v41, v45);
    end;
    table.sort(v41, function(p46, p47) --[[ Line: 367 ]]
        -- upvalues: u42 (copy), l___x6c5abddbda8a829c__23 (copy)
        local v48 = u42[p46.state] or (1 / 0);
        local v49 = u42[p47.state] or (1 / 0);
        if v48 == v49 then
            return math.abs(p46.level - l___x6c5abddbda8a829c__23) < math.abs(p47.level - l___x6c5abddbda8a829c__23);
        else
            return v48 < v49;
        end;
    end);
    for v50, v51 in ipairs(v41) do
        local l__duel_entry__24 = v51.duel_entry;
        v43 = v43 + 1;
        v44 = v44 + 0.2;
        v40(l__duel_entry__24, v50);
    end;
    if v43 > 0 then
        l__TweenService__1:Create(l__NoPlayers__22, TweenInfo.new(1), {
            TextTransparency = 1
        }):Play();
    else
        l__TweenService__1:Create(l__NoPlayers__22, TweenInfo.new(1), {
            TextTransparency = 0.5
        }):Play();
    end;
    l__ScrollingFrame__21.CanvasSize = UDim2.fromScale(1, v44);
end;
function u1._setupDuelEntry(u52, p53) --[[ Line: 400 ]]
    -- upvalues: l__UserId__12 (copy), l__Classes__7 (copy), l__LocalPlayer__11 (copy)
    local l__page_origin__25 = u52.page_origin;
    local l__main_page__26 = u52.main_page;
    local u54 = l__page_origin__25.DuelEntry:Clone();
    local l__Name__27 = p53.Name;
    if u52.duel_entries[l__Name__27] then
        warn("DUPLICATE ENTRY");
    elseif tonumber(l__Name__27) == l__UserId__12 then
    else
        local v55 = game:GetService("Players"):GetPlayerByUserId((tonumber(l__Name__27)));
        if v55 then
            local u56 = {
                duel_entry = u54,
                entry_userid = l__Name__27,
                presence_inst = p53,
                player = v55,
                _trove = u52.trove:Extend(),
                _state_trove = u52.trove:Extend(),
                is_friend = l__Classes__7.FriendsService:isFriendsWith(l__LocalPlayer__11, v55),
                send_expiry = 0,
                level = 0,
                state = "FREE"
            };
            local function u57() --[[ Line: 427 ]]
                -- upvalues: u56 (copy), u52 (copy), l__Name__27 (copy)
                u56._trove:Clean();
                u56._state_trove:Clean();
                u52.duel_entries[l__Name__27] = nil;
                u52:_refreshDuelList();
            end;
            u56._trove:Add(u54);
            local l__Info__28 = u54.Container.Back.Info;
            l__Info__28.NameLabel.Text = v55.Name;
            task.spawn(function() --[[ Name: setupFromReadableFolder, Line 441 ]]
                -- upvalues: l__Name__27 (copy), u56 (copy), u52 (copy), u57 (copy), l__Info__28 (copy), u54 (copy), l__Classes__7 (ref)
                local v58 = l__Name__27;
                local u59 = game:GetService("ReplicatedStorage").ReadOnly.Players:WaitForChild(v58);
                if u59 then
                    u56._trove:Add(u59.Destroying:Connect(u57));
                    u56.readable_folder = u59;
                    local function u61(p60) --[[ Line: 465 ]]
                        -- upvalues: l__Info__28 (ref), u56 (ref)
                        l__Info__28.Level.Text = "Lv" .. tostring(p60);
                        u56.level = p60;
                    end;
                    local u62 = "level";
                    task.spawn(function() --[[ Line: 452 ]]
                        -- upvalues: u59 (copy), u62 (copy), u61 (copy), u56 (ref)
                        local u63 = u59:WaitForChild(u62);
                        if u63 then
                            local v64 = u63.Changed:Connect(function() --[[ Line: 456 ]]
                                -- upvalues: u61 (ref), u63 (copy)
                                u61(u63.Value);
                            end);
                            u61(u63.Value);
                            u56._trove:Add(v64);
                        else
                            warn("COULD NOT FIND VALUE INSTANCE : ", u62);
                        end;
                    end);
                    local function u66(p65) --[[ Line: 470 ]]
                        -- upvalues: u54 (ref)
                        u54.Container.Back.Portrait.PlayerPortrait.Image = p65;
                    end;
                    local u67 = "player_icon";
                    task.spawn(function() --[[ Line: 452 ]]
                        -- upvalues: u59 (copy), u67 (copy), u66 (copy), u56 (ref)
                        local u68 = u59:WaitForChild(u67);
                        if u68 then
                            local v69 = u68.Changed:Connect(function() --[[ Line: 456 ]]
                                -- upvalues: u66 (ref), u68 (copy)
                                u66(u68.Value);
                            end);
                            u66(u68.Value);
                            u56._trove:Add(v69);
                        else
                            warn("COULD NOT FIND VALUE INSTANCE : ", u67);
                        end;
                    end);
                    local function u73(p70) --[[ Line: 474 ]]
                        -- upvalues: l__Classes__7 (ref), u54 (ref)
                        local v71 = l__Classes__7.Util:convNumRange(p70, 0, 20, 0, 1);
                        local v72 = Color3.fromRGB(255, 255, 255):Lerp(Color3.fromRGB(255, 0, 0), v71);
                        u54.Container.Back.Portrait.Gradient.BackgroundColor3 = v72;
                    end;
                    local u74 = "casual_duel_winstreak";
                    task.spawn(function() --[[ Line: 452 ]]
                        -- upvalues: u59 (copy), u74 (copy), u73 (copy), u56 (ref)
                        local u75 = u59:WaitForChild(u74);
                        if u75 then
                            local v76 = u75.Changed:Connect(function() --[[ Line: 456 ]]
                                -- upvalues: u73 (ref), u75 (copy)
                                u73(u75.Value);
                            end);
                            u73(u75.Value);
                            u56._trove:Add(v76);
                        else
                            warn("COULD NOT FIND VALUE INSTANCE : ", u74);
                        end;
                    end);
                else
                    u56._trove:Clean();
                    u56._state_trove:Clean();
                    u52.duel_entries[l__Name__27] = nil;
                    u52:_refreshDuelList();
                end;
            end);
            local function v77() --[[ Line: 485 ]]
                -- upvalues: u52 (copy), u56 (copy)
                u52:_updateState(u56);
            end;
            u52:_updateState(u56);
            u56._trove:Add(p53:GetAttributeChangedSignal("state"):Connect(v77));
            u56._trove:Add(p53:GetAttributeChangedSignal("request_mode"):Connect(v77));
            u52.duel_entries[l__Name__27] = u56;
            u56._trove:Add(p53.Destroying:Connect(u57));
            u54.Parent = l__main_page__26.Borders.PresenceList.ScrollingFrame;
            u52:_refreshDuelList();
        else
            warn("NO SUCH PLAYER IN THE SERVER");
        end;
    end;
end;
function u1.Init(u78) --[[ Line: 502 ]]
    -- upvalues: l__DuelPresence__9 (copy), l__DuelRequests__10 (copy), l__Classes__7 (copy), l__TweenService__1 (copy)
    local _ = u78.page_origin;
    local l__main_page__29 = u78.main_page;
    for _, u79 in l__DuelPresence__9:GetChildren() do
        task.spawn(function() --[[ Line: 507 ]]
            -- upvalues: u78 (copy), u79 (copy)
            u78:_setupDuelEntry(u79);
        end);
    end;
    for _, u80 in l__DuelRequests__10:GetChildren() do
        task.spawn(function() --[[ Line: 513 ]]
            -- upvalues: u78 (copy), u80 (copy)
            u78:_processDuelRequest(u80);
        end);
    end;
    u78.trove:Add(l__DuelRequests__10.ChildAdded:Connect(function(u81) --[[ Line: 518 ]]
        -- upvalues: u78 (copy)
        if u81:IsA("Folder") then
            task.spawn(function() --[[ Line: 520 ]]
                -- upvalues: u78 (ref), u81 (copy)
                u78:_processDuelRequest(u81);
            end);
        end;
    end));
    u78.trove:Add(l__DuelPresence__9.ChildAdded:Connect(function(u82) --[[ Line: 526 ]]
        -- upvalues: u78 (copy)
        if u82:IsA("Folder") then
            task.spawn(function() --[[ Line: 528 ]]
                -- upvalues: u78 (ref), u82 (copy)
                u78:_setupDuelEntry(u82);
            end);
        end;
    end));
    local l__ServerRegion__30 = game:GetService("ReplicatedStorage").ReadOnly.ServerRegion;
    l__main_page__29.Borders.PresenceList.Bottomline1.Text = "REGION: " .. l__ServerRegion__30.Value;
    u78.trove:Add(l__ServerRegion__30.Changed:Connect(function() --[[ Line: 537 ]]
        -- upvalues: l__main_page__29 (copy), l__ServerRegion__30 (copy)
        l__main_page__29.Borders.PresenceList.Bottomline1.Text = "REGION: " .. l__ServerRegion__30.Value;
    end));
    u78.trove:Add(l__Classes__7._x596eb619070480ba:_x0b64af9146930e4b("pingChanged"):Connect(function(p83) --[[ Line: 541 ]]
        -- upvalues: l__main_page__29 (copy)
        l__main_page__29.Borders.PresenceList.Bottomline2.Text = "PING: " .. math.floor(p83 * 1000) .. "ms";
    end));
    local v84 = l__Classes__7._x596eb619070480ba:_x99c2a19f9a3f5eff("casual_duel_winstreak");
    if v84 then
        l__main_page__29.Borders.PresenceList.MatchTopbar.Winstreak.Text = "WINSTREAK :" .. v84.Value;
    else
        warn("COULD NOT FIND CASUAL DUEL WINSTREAK INST");
    end;
    local l__Frame__31 = l__main_page__29.Borders.MainContainer.Frame;
    local l__Button__32 = l__Frame__31.Button;
    l__Button__32.MouseButton1Click:Connect(function() --[[ Line: 555 ]]
        -- upvalues: u78 (copy)
        u78.menu_session:requestDeploy();
    end);
    l__Button__32.MouseEnter:Connect(function() --[[ Line: 559 ]]
        -- upvalues: l__TweenService__1 (ref), l__Frame__31 (copy)
        local v85 = TweenInfo.new(0.35, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out);
        l__TweenService__1:Create(l__Frame__31.SelectionOutline, v85, {
            BackgroundTransparency = 0.9
        }):Play();
        l__TweenService__1:Create(l__Frame__31.SelectionOutline.UIStroke, v85, {
            Transparency = 0
        }):Play();
    end);
    l__Button__32.MouseLeave:Connect(function() --[[ Line: 565 ]]
        -- upvalues: l__TweenService__1 (ref), l__Frame__31 (copy)
        local v86 = TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
        l__TweenService__1:Create(l__Frame__31.SelectionOutline, v86, {
            BackgroundTransparency = 1
        }):Play();
        l__TweenService__1:Create(l__Frame__31.SelectionOutline.UIStroke, v86, {
            Transparency = 1
        }):Play();
    end);
end;
return u1;
