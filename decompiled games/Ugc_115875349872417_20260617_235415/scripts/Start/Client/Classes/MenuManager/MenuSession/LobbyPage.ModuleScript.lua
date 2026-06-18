-- Decompiled from: Start.Client.Classes.MenuManager.MenuSession.LobbyPage
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__HttpService__2 = game:GetService("HttpService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__RunService__4 = game:GetService("RunService");
local l__TweenService__5 = game:GetService("TweenService");
local l__ModuleScripts__6 = l__ReplicatedStorage__3.Assets.ModuleScripts;
local l__Packets__7 = require(l__ModuleScripts__6.Packets);
local l__Trove__8 = require(l__ModuleScripts__6.Trove);
local l__CEnum__9 = require(l__ModuleScripts__6.CEnum);
local l__ModesDef__10 = require(l__ModuleScripts__6.ModesDef);
local l__TitleData__11 = require(l__ModuleScripts__6.TitleData);
local l__UIAssets__12 = l__ReplicatedStorage__3.Assets.UIAssets;
local l__Classes__13 = require(script.Parent.Parent.Parent.Parent.ClientRoot).Classes;
local l__InternalSymbols__14 = require(script.Parent.Parent.Parent.Parent.InternalSymbols);
local l__LocalPlayer__15 = l__Players__1.LocalPlayer;
local l__Lobbies__16 = l__ReplicatedStorage__3.ReadOnly.Lobbies;
local u1 = Color3.fromRGB(58, 58, 58);
local u2 = Color3.fromRGB(0, 255, 0);
local u3 = Color3.fromRGB(255, 0, 0);
local u4 = Color3.fromRGB(255, 255, 255);
local u5 = {
    Color3.fromRGB(255, 62, 62),
    Color3.fromRGB(62, 125, 255),
    Color3.fromRGB(188, 82, 255),
    Color3.fromRGB(255, 216, 62)
};
local u6 = {};
u6.__index = u6;
local function u13(p7, p8, p9, p10) --[[ Line: 40 ]]
    p7.BackgroundColor3 = p9;
    p7.Active = p10;
    p7.AutoButtonColor = p10;
    local v11 = p7:FindFirstChildWhichIsA("UIStroke", true);
    if v11 then
        v11.Color = p9;
    end;
    local v12 = p7:FindFirstChild("TextLabel") or p7:FindFirstChildWhichIsA("TextLabel", true);
    if v12 and v12:IsA("TextLabel") then
        v12.Text = p8;
    end;
end;
function u6.new(p14, p15) --[[ Line: 64 ]]
    -- upvalues: u6 (copy), l__InternalSymbols__14 (copy), l__UIAssets__12 (copy), l__Trove__8 (copy)
    local v16 = setmetatable({}, u6);
    v16.menu_session = l__InternalSymbols__14.owner("MenuSession", p15);
    v16.parent_os = p14;
    v16.page_origin = l__UIAssets__12.Menu.LobbyPage;
    v16.main_page = v16.page_origin.LobbyFrame:Clone();
    v16.main_origin_position = v16.main_page.Main.Position;
    v16.main_page.Visible = false;
    v16.in_lobby = false;
    v16.lobby_inst = nil;
    v16.my_inst = nil;
    v16.participants = {};
    v16.trove = l__Trove__8.new();
    v16.lobby_trove = l__Trove__8.new();
    v16.trove:Add(v16.main_page);
    return v16;
end;
function u6.cleanUp(p17) --[[ Line: 86 ]]
    p17.lobby_trove:Clean();
    p17.trove:Clean();
end;
function u6.close(u18) --[[ Line: 91 ]]
    -- upvalues: l__TweenService__5 (copy)
    u18.main_page.Interactable = false;
    l__TweenService__5:Create(u18.main_page, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 1
    }):Play();
    task.delay(0.2, function() --[[ Line: 99 ]]
        -- upvalues: u18 (copy)
        if u18.main_page.Parent and not u18.main_page.Interactable then
            u18.main_page.Visible = false;
        end;
    end);
end;
function u6._exitLobby(u19) --[[ Line: 106 ]]
    if u19.in_lobby then
        u19.in_lobby = false;
        u19.lobby_inst = nil;
        u19.my_inst = nil;
        u19.participants = {};
        u19.lobby_trove:Clean();
        if u19.menu_session.current_page == "lobby_page" or u19.menu_session.current_page == "loadout_page" then
            task.defer(function() --[[ Line: 120 ]]
                -- upvalues: u19 (copy)
                if not u19.in_lobby then
                    u19.menu_session:openPage("empty_page");
                end;
            end);
        end;
    end;
end;
function u6._renderConfig(p20) --[[ Line: 128 ]]
    -- upvalues: l__ModesDef__10 (copy), l__LocalPlayer__15 (copy), l__CEnum__9 (copy)
    local l__lobby_inst__17 = p20.lobby_inst;
    local l__my_inst__18 = p20.my_inst;
    if l__lobby_inst__17 and l__my_inst__18 then
        local l__main_page__19 = p20.main_page;
        local l__SetupFrame__20 = l__main_page__19.Main.Top.SetupFrame;
        local l__SummaryFrame__21 = l__main_page__19.Main.Top.SummaryFrame;
        local v21 = l__lobby_inst__17:GetAttribute("gamemode");
        local v22, v23 = pcall(l__ModesDef__10.getDef, v21);
        if v22 then
            local v24 = l__lobby_inst__17:GetAttribute("host_userid") == l__LocalPlayer__15.UserId;
            local v25 = l__my_inst__18:GetAttribute("is_ready") == true;
            l__SetupFrame__20.Visible = v24;
            l__SummaryFrame__21.Thumbnail.Image = v23.thumbnail;
            l__SummaryFrame__21.ModeLabel.Text = v23.display_name;
            local l__MapLabel__22 = l__SummaryFrame__21.MapLabel;
            local v26 = l__lobby_inst__17:GetAttribute("map");
            local v27;
            if v26 == l__ModesDef__10.RANDOM_MAP then
                v27 = l__ModesDef__10.RANDOM_MAP;
            else
                v27 = l__CEnum__9.reverse(l__CEnum__9.Maps, v26) or tostring(v26);
            end;
            l__MapLabel__22.Text = v27;
            l__SetupFrame__20.ModeSelect.TextLabel.Text = "Mode: " .. v23.display_name;
            local l__TextLabel__23 = l__SetupFrame__20.MapSelect.TextLabel;
            local v28 = "Map: ";
            local v29 = l__lobby_inst__17:GetAttribute("map");
            local v30;
            if v29 == l__ModesDef__10.RANDOM_MAP then
                v30 = l__ModesDef__10.RANDOM_MAP;
            else
                v30 = l__CEnum__9.reverse(l__CEnum__9.Maps, v29) or tostring(v29);
            end;
            l__TextLabel__23.Text = v28 .. v30;
            l__SetupFrame__20.ModeSelect.LeftArrow.Active = not v25;
            l__SetupFrame__20.ModeSelect.RightArrow.Active = not v25;
            l__SetupFrame__20.MapSelect.LeftArrow.Active = not v25;
            l__SetupFrame__20.MapSelect.RightArrow.Active = not v25;
            l__SetupFrame__20.ModeSelect.LeftArrow.AutoButtonColor = not v25;
            l__SetupFrame__20.ModeSelect.RightArrow.AutoButtonColor = not v25;
            l__SetupFrame__20.MapSelect.LeftArrow.AutoButtonColor = not v25;
            l__SetupFrame__20.MapSelect.RightArrow.AutoButtonColor = not v25;
        end;
    end;
end;
function u6._renderDescriptor(u31) --[[ Line: 164 ]]
    -- upvalues: l__HttpService__2 (copy), l__TweenService__5 (copy), l__RunService__4 (copy)
    local l__lobby_inst__24 = u31.lobby_inst;
    local l__descriptor_trove__25 = u31.descriptor_trove;
    if l__lobby_inst__24 and l__descriptor_trove__25 then
        local l__Main__26 = u31.main_page.Main;
        local u32 = l__Main__26.Bot:FindFirstChild("LobbyText", true);
        if u32 and u32:IsA("TextLabel") then
            l__descriptor_trove__25:Clean();
            l__Main__26.Position = u31.main_origin_position;
            u32.Text = "";
            local v33 = u32:FindFirstChild("Countdown");
            if v33 and v33:IsA("NumberValue") then
                v33.Value = 0;
            end;
            local u34 = l__lobby_inst__24:GetAttribute("lobby_descriptor");
            if typeof(u34) == "string" then
                local v35, u36 = pcall(function() --[[ Line: 191 ]]
                    -- upvalues: l__HttpService__2 (ref), u34 (copy)
                    return l__HttpService__2:JSONDecode(u34);
                end);
                if v35 and typeof(u36) == "table" then
                    if u36.mode == "static" then
                        u32.Text = u36.text or "";
                    elseif u36.mode == "countdown" and (typeof(u36.text) == "string" and typeof(u36.meta) == "number") then
                        local l__meta__27 = u36.meta;
                        local v37 = l__meta__27 - workspace:GetServerTimeNow();
                        local u38 = math.max(0, v37);
                        local u39 = u38;
                        local u40 = Random.new();
                        local function v42(p41) --[[ Line: 215 ]]
                            -- upvalues: u39 (ref), u32 (copy), u36 (copy)
                            u39 = math.max(p41, 0);
                            u32.Text = string.format(u36.text, (math.floor(u39)));
                        end;
                        l__descriptor_trove__25:Connect(l__RunService__4.Heartbeat, function() --[[ Name: shake, Line 220 ]]
                            -- upvalues: u38 (copy), u39 (ref), l__TweenService__5 (ref), l__Main__26 (copy), u31 (copy), u40 (copy)
                            if u38 <= 0 then
                            else
                                local v43 = 0.01 * l__TweenService__5:GetValue(math.clamp(1 - u39 / u38, 0, 1), Enum.EasingStyle.Quart, Enum.EasingDirection.In);
                                l__Main__26.Position = u31.main_origin_position + UDim2.fromScale(u40:NextNumber(0, v43), u40:NextNumber(0, v43));
                            end;
                        end);
                        u39 = math.max(u38, 0);
                        u32.Text = string.format(u36.text, (math.floor(u39)));
                        if u38 <= 0 then
                        elseif v33 and v33:IsA("NumberValue") then
                            v33.Value = u38;
                            local v44 = l__TweenService__5:Create(v33, TweenInfo.new(u38, Enum.EasingStyle.Linear), {
                                Value = 0
                            });
                            l__descriptor_trove__25:Add(v44, "Cancel");
                            l__descriptor_trove__25:Connect(v33.Changed, v42);
                            v44:Play();
                        else
                            l__descriptor_trove__25:Connect(l__RunService__4.Heartbeat, function() --[[ Line: 255 ]]
                                -- upvalues: l__meta__27 (copy), u39 (ref), u32 (copy), u36 (copy)
                                local v45 = l__meta__27 - workspace:GetServerTimeNow();
                                u39 = math.max(v45, 0);
                                u32.Text = string.format(u36.text, (math.floor(u39)));
                            end);
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
function u6._modeOptions(_) --[[ Line: 260 ]]
    -- upvalues: l__ModesDef__10 (copy)
    return l__ModesDef__10.getCustomDefs();
end;
function u6._mapOptions(p46) --[[ Line: 264 ]]
    -- upvalues: l__ModesDef__10 (copy)
    local l__lobby_inst__28 = p46.lobby_inst;
    if not l__lobby_inst__28 then
        return {};
    end;
    local v47 = l__ModesDef__10.getDef(l__lobby_inst__28:GetAttribute("gamemode"));
    local v48 = { l__ModesDef__10.RANDOM_MAP };
    for _, v49 in v47.eligible_maps do
        table.insert(v48, v49);
    end;
    return v48;
end;
function u6._cycleMode(p50, p51) --[[ Line: 278 ]]
    -- upvalues: l__Packets__7 (copy)
    if not p50.my_inst or p50.my_inst:GetAttribute("is_ready") then
        return;
    end;
    local v52 = p50:_modeOptions();
    if #v52 == 0 then
        return;
    end;
    local v53 = p50.lobby_inst:GetAttribute("gamemode");
    local v54 = 1;
    for v55, v56 in v52 do
        if v56.mode_id == v53 then
            v54 = v55;
            break;
        end;
    end;
    l__Packets__7._x851f9a3ff98bf94f:Fire("SET_MODE", v52[(v54 - 1 + p51) % #v52 + 1].mode_id);
end;
function u6._cycleMap(p57, p58) --[[ Line: 301 ]]
    -- upvalues: l__Packets__7 (copy)
    if p57.my_inst and not p57.my_inst:GetAttribute("is_ready") then
        local v59 = p57:_mapOptions();
        if #v59 == 0 then
        else
            local v60 = p57.lobby_inst:GetAttribute("map");
            local v61 = ((table.find(v59, v60) or 1) - 1 + p58) % #v59 + 1;
            l__Packets__7._x851f9a3ff98bf94f:Fire("SET_MAP", v59[v61]);
        end;
    end;
end;
function u6._renderActions(p62) --[[ Line: 317 ]]
    -- upvalues: u13 (copy), u3 (copy), u1 (copy), u2 (copy), u4 (copy)
    local l__lobby_inst__29 = p62.lobby_inst;
    local l__my_inst__30 = p62.my_inst;
    if l__lobby_inst__29 and l__my_inst__30 then
        local l__ActionList__31 = p62.main_page.Main.Bot.ActionList;
        local l__ReadyButton__32 = l__ActionList__31.ReadyButton;
        local l__LoadoutButton__33 = l__ActionList__31.LoadoutButton;
        local l__SwapTeamsButton__34 = l__ActionList__31.SwapTeamsButton;
        local l__LeaveButton__35 = l__ActionList__31.LeaveButton;
        local v63 = l__my_inst__30:GetAttribute("is_ready") == true;
        local v64 = l__lobby_inst__29:GetAttribute("config_eligible") == true;
        local v65 = (l__lobby_inst__29:GetAttribute("required_slot_size") or 1) > 1;
        l__SwapTeamsButton__34.Visible = v65;
        if v63 then
            u13(l__ReadyButton__32, "UNREADY", u3, true);
            u13(l__LoadoutButton__33, "LOADOUT", u1, false);
            u13(l__SwapTeamsButton__34, "SWAP TEAMS", u1, false);
            u13(l__LeaveButton__35, "LEAVE", u1, false);
        else
            u13(l__ReadyButton__32, "READY", v64 and u2 or u1, v64);
            u13(l__LoadoutButton__33, "LOADOUT", u4, true);
            u13(l__SwapTeamsButton__34, "SWAP TEAMS", u4, v65);
            u13(l__LeaveButton__35, "LEAVE", u4, true);
        end;
    end;
end;
function u6._clearInviteEntries(p66) --[[ Line: 349 ]]
    if p66.invite_trove then
        p66.invite_trove:Clean();
    end;
end;
function u6._renderInviteEntries(u67) --[[ Line: 355 ]]
    -- upvalues: l__LocalPlayer__15 (copy), l__Classes__13 (copy), l__Packets__7 (copy)
    u67:_clearInviteEntries();
    local l__lobby_inst__36 = u67.lobby_inst;
    local l__my_inst__37 = u67.my_inst;
    if l__lobby_inst__36 and l__my_inst__37 then
        local l__ParticipantList__38 = u67.main_page.Main.Bot.ParticipantFrame.ParticipantList;
        local v68 = l__lobby_inst__36:GetAttribute("max_participants") or 0;
        local v69 = l__lobby_inst__36:GetAttribute("participant_count") or 0;
        local u70 = l__lobby_inst__36:GetAttribute("host_userid") == l__LocalPlayer__15.UserId;
        local v71 = l__my_inst__37:GetAttribute("is_ready") == true;
        for v72 = 1, math.max(0, v68 - v69) do
            local v73 = u67.page_origin.InviteFrame:Clone();
            v73.LayoutOrder = v72 + 10000;
            v73.Visible = u70;
            local l__Button__39 = v73.Button;
            local v74;
            if u70 then
                v74 = not v71;
            else
                v74 = u70;
            end;
            l__Button__39.Active = v74;
            local l__Button__40 = v73.Button;
            local v75;
            if u70 then
                v75 = not v71;
            else
                v75 = u70;
            end;
            l__Button__40.AutoButtonColor = v75;
            v73.Parent = l__ParticipantList__38;
            u67.invite_trove:Add(v73);
            u67.invite_trove:Connect(v73.Button.Activated, function() --[[ Line: 379 ]]
                -- upvalues: u70 (copy), u67 (copy), l__Classes__13 (ref), l__Packets__7 (ref)
                if u70 and (u67.my_inst and not u67.my_inst:GetAttribute("is_ready")) then
                    l__Classes__13._xb90403a8caac4128:_x003a1e06c5ce82d3("PlayerBrowser", {
                        header_text = "SELECT A PLAYER TO INVITE",
                        selected_callback = function(p76) --[[ Name: selected_callback, Line 386 ]]
                            -- upvalues: l__Packets__7 (ref)
                            local v77 = tonumber(p76[1]);
                            if v77 then
                                l__Packets__7._x851f9a3ff98bf94f:Fire("INVITE", v77);
                            end;
                        end
                    });
                end;
            end);
        end;
    end;
end;
function u6._setupParticipant(u78, u79) --[[ Line: 397 ]]
    -- upvalues: l__Players__1 (copy), u2 (copy), u4 (copy), u5 (copy), l__LocalPlayer__15 (copy), l__ReplicatedStorage__3 (copy), l__CEnum__9 (copy), l__TitleData__11 (copy)
    local l__Name__41 = u79.Name;
    if u78.participants[l__Name__41] then
    else
        local u80 = l__Players__1:GetPlayerByUserId((tonumber(l__Name__41)));
        if u80 then
            local u81 = {
                trove = u78.lobby_trove:Extend(),
                entry = u78.page_origin.ParticipantEntry:Clone()
            };
            local l__entry__42 = u81.entry;
            u81.trove:Add(l__entry__42);
            u78.participants[l__Name__41] = u81;
            local function v86() --[[ Line: 417 ]]
                -- upvalues: u79 (copy), u78 (copy), l__entry__42 (copy), u2 (ref), u4 (ref), u5 (ref)
                local v82 = u79:GetAttribute("is_ready") == true;
                local v83 = u79:GetAttribute("team_id");
                local v84 = u78.lobby_inst and u78.lobby_inst:GetAttribute("required_slot_size") or 1;
                if v82 then
                    l__entry__42.ReadyFrame.BackgroundColor3 = u2;
                    l__entry__42.ReadyFrame.ReadyText.UIStroke.Enabled = true;
                else
                    l__entry__42.ReadyFrame.BackgroundColor3 = u4;
                    l__entry__42.ReadyFrame.ReadyText.UIStroke.Enabled = false;
                end;
                local v85 = l__entry__42:FindFirstChild("Edge");
                if v85 and (v85:IsA("GuiObject") and (v84 > 1 and u5[v83])) then
                    v85.BackgroundColor3 = u5[v83];
                else
                    v85.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                end;
                l__entry__42.LayoutOrder = (tonumber(v83) or 0) * 100;
            end;
            u81.refresh = v86;
            l__entry__42.Info.NameLabel.Text = u80.Name;
            l__entry__42.Parent = u78.main_page.Main.Bot.ParticipantFrame.ParticipantList;
            u81.trove:Connect(u79:GetAttributeChangedSignal("is_ready"), v86);
            u81.trove:Connect(u79:GetAttributeChangedSignal("team_id"), v86);
            u81.trove:Connect(u79.Destroying, function() --[[ Line: 446 ]]
                -- upvalues: u81 (copy), u78 (copy), l__Name__41 (copy), u80 (copy), l__LocalPlayer__15 (ref)
                u81.trove:Clean();
                u78.participants[l__Name__41] = nil;
                if u80 == l__LocalPlayer__15 then
                    u78:_exitLobby();
                end;
            end);
            task.spawn(function() --[[ Line: 454 ]]
                -- upvalues: l__ReplicatedStorage__3 (ref), l__Name__41 (copy), l__entry__42 (copy), u81 (copy), l__CEnum__9 (ref), l__TitleData__11 (ref)
                local v87 = l__ReplicatedStorage__3.ReadOnly.Players:WaitForChild(l__Name__41, 5);
                if v87 and l__entry__42.Parent then
                    local function v89(p88) --[[ Line: 470 ]]
                        -- upvalues: l__entry__42 (ref)
                        l__entry__42.Info.PlayerPortrait.Image = p88;
                    end;
                    local l__player_icon__43 = v87:WaitForChild("player_icon", 5);
                    if l__player_icon__43 and l__entry__42.Parent then
                        l__entry__42.Info.PlayerPortrait.Image = l__player_icon__43.Value;
                        u81.trove:Connect(l__player_icon__43.Changed, v89);
                    end;
                    local function v91(p90) --[[ Line: 473 ]]
                        -- upvalues: l__entry__42 (ref)
                        l__entry__42.Info.Level.Text = "Lv" .. tostring(p90);
                    end;
                    local l__level__44 = v87:WaitForChild("level", 5);
                    if l__level__44 and l__entry__42.Parent then
                        l__entry__42.Info.Level.Text = "Lv" .. tostring(l__level__44.Value);
                        u81.trove:Connect(l__level__44.Changed, v91);
                    end;
                    local function v94(p92) --[[ Line: 476 ]]
                        -- upvalues: l__CEnum__9 (ref), l__entry__42 (ref)
                        local _, v93 = l__CEnum__9.GetPingData(p92 * 1000);
                        l__entry__42.Info.Network.Circle.BackgroundColor3 = v93.color;
                    end;
                    local l__rtt__45 = v87:WaitForChild("rtt", 5);
                    if l__rtt__45 and l__entry__42.Parent then
                        local _, v95 = l__CEnum__9.GetPingData(l__rtt__45.Value * 1000);
                        l__entry__42.Info.Network.Circle.BackgroundColor3 = v95.color;
                        u81.trove:Connect(l__rtt__45.Changed, v94);
                    end;
                    local function v97(p96) --[[ Line: 482 ]]
                        -- upvalues: l__TitleData__11 (ref), l__entry__42 (ref)
                        l__TitleData__11.renderFromLabel(l__entry__42.Info.Title, p96);
                    end;
                    local l__equipped_title__46 = v87:WaitForChild("equipped_title", 5);
                    if l__equipped_title__46 then
                        if not l__entry__42.Parent then
                            return;
                        end;
                        l__TitleData__11.renderFromLabel(l__entry__42.Info.Title, l__equipped_title__46.Value);
                        u81.trove:Connect(l__equipped_title__46.Changed, v97);
                    end;
                end;
            end);
            v86();
        end;
    end;
end;
function u6._bindLobby(u98, p99, p100) --[[ Line: 490 ]]
    -- upvalues: l__Packets__7 (copy)
    u98.lobby_trove:Clean();
    u98.participants = {};
    u98.invite_trove = u98.lobby_trove:Extend();
    u98.descriptor_trove = u98.lobby_trove:Extend();
    u98.lobby_inst = p99;
    u98.my_inst = p100;
    u98.in_lobby = true;
    local l__SetupFrame__47 = u98.main_page.Main.Top.SetupFrame;
    local l__ActionList__48 = u98.main_page.Main.Bot.ActionList;
    u98.lobby_trove:Connect(l__SetupFrame__47.ModeSelect.LeftArrow.Activated, function() --[[ Line: 502 ]]
        -- upvalues: u98 (copy)
        u98:_cycleMode(-1);
    end);
    u98.lobby_trove:Connect(l__SetupFrame__47.ModeSelect.RightArrow.Activated, function() --[[ Line: 505 ]]
        -- upvalues: u98 (copy)
        u98:_cycleMode(1);
    end);
    u98.lobby_trove:Connect(l__SetupFrame__47.MapSelect.LeftArrow.Activated, function() --[[ Line: 508 ]]
        -- upvalues: u98 (copy)
        u98:_cycleMap(-1);
    end);
    u98.lobby_trove:Connect(l__SetupFrame__47.MapSelect.RightArrow.Activated, function() --[[ Line: 511 ]]
        -- upvalues: u98 (copy)
        u98:_cycleMap(1);
    end);
    u98.lobby_trove:Connect(l__ActionList__48.ReadyButton.Activated, function() --[[ Line: 515 ]]
        -- upvalues: u98 (copy), l__Packets__7 (ref)
        local l__my_inst__49 = u98.my_inst;
        if l__my_inst__49 then
            l__my_inst__49 = u98.my_inst:GetAttribute("is_ready") == true;
        end;
        l__Packets__7._x851f9a3ff98bf94f:Fire("READY", not l__my_inst__49);
    end);
    u98.lobby_trove:Connect(l__ActionList__48.LoadoutButton.Activated, function() --[[ Line: 519 ]]
        -- upvalues: u98 (copy)
        if u98.my_inst and not u98.my_inst:GetAttribute("is_ready") then
            u98.menu_session:openPage("loadout_page");
        end;
    end);
    u98.lobby_trove:Connect(l__ActionList__48.SwapTeamsButton.Activated, function() --[[ Line: 524 ]]
        -- upvalues: u98 (copy), l__Packets__7 (ref)
        if u98.my_inst and not u98.my_inst:GetAttribute("is_ready") then
            l__Packets__7._x851f9a3ff98bf94f:Fire("SWAP_TEAM");
        end;
    end);
    u98.lobby_trove:Connect(l__ActionList__48.LeaveButton.Activated, function() --[[ Line: 529 ]]
        -- upvalues: u98 (copy), l__Packets__7 (ref)
        if u98.my_inst and not u98.my_inst:GetAttribute("is_ready") then
            l__Packets__7._x851f9a3ff98bf94f:Fire("LEAVE");
        end;
    end);
    local function v102() --[[ Line: 535 ]]
        -- upvalues: u98 (copy)
        u98:_renderConfig();
        u98:_renderActions();
        u98:_renderInviteEntries();
        for _, v101 in u98.participants do
            v101.refresh();
        end;
    end;
    for _, v103 in {
        "map",
        "gamemode",
        "host_userid",
        "participant_count",
        "max_participants",
        "required_slot_size",
        "config_eligible"
    } do
        u98.lobby_trove:Connect(p99:GetAttributeChangedSignal(v103), v102);
    end;
    u98.lobby_trove:Connect(p100:GetAttributeChangedSignal("is_ready"), v102);
    u98.lobby_trove:Connect(p99:GetAttributeChangedSignal("lobby_descriptor"), function() --[[ Line: 557 ]]
        -- upvalues: u98 (copy)
        u98:_renderDescriptor();
    end);
    u98.lobby_trove:Connect(p100.Destroying, function() --[[ Line: 560 ]]
        -- upvalues: u98 (copy)
        u98:_exitLobby();
    end);
    for _, v104 in p99:GetChildren() do
        if v104:IsA("Folder") then
            u98:_setupParticipant(v104);
        end;
    end;
    u98.lobby_trove:Connect(p99.ChildAdded, function(p105) --[[ Line: 570 ]]
        -- upvalues: u98 (copy)
        if p105:IsA("Folder") then
            u98:_setupParticipant(p105);
            u98:_renderInviteEntries();
        end;
    end);
    v102();
    u98:_renderDescriptor();
end;
function u6.start(p106, p107, p108) --[[ Line: 581 ]]
    -- upvalues: l__TweenService__5 (copy)
    if p107 and (p108 and p107 ~= p106.lobby_inst) then
        p106:_bindLobby(p107, p108);
    end;
    if p106.in_lobby then
        p106.main_page.Parent = p106.parent_os;
        p106.main_page.Visible = true;
        p106.main_page.Interactable = true;
        p106.main_page.GroupTransparency = 1;
        l__TweenService__5:Create(p106.main_page, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            GroupTransparency = 0
        }):Play();
    end;
end;
function u6.Init(u109) --[[ Line: 601 ]]
    -- upvalues: l__LocalPlayer__15 (copy), l__Lobbies__16 (copy)
    local function v111(u110) --[[ Line: 602 ]]
        -- upvalues: l__LocalPlayer__15 (ref), l__Lobbies__16 (ref), u109 (copy)
        if not u110:IsA("Folder") or u110.Name ~= tostring(l__LocalPlayer__15.UserId) then
            return false;
        end;
        local l__Parent__50 = u110.Parent;
        if not l__Parent__50 or (not l__Parent__50:IsA("Folder") or l__Parent__50.Parent ~= l__Lobbies__16) then
            return false;
        end;
        task.defer(function() --[[ Line: 612 ]]
            -- upvalues: u109 (ref), l__Parent__50 (copy), u110 (copy)
            if not u109.in_lobby then
                u109.menu_session:openPage("lobby_page", l__Parent__50, u110);
            end;
        end);
        return true;
    end;
    for _, v112 in l__Lobbies__16:GetDescendants() do
        if v111(v112) then
            break;
        end;
    end;
    u109.trove:Connect(l__Lobbies__16.DescendantAdded, v111);
end;
return u6;
