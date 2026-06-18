-- Decompiled from: Start.Client.Classes.MenuManager.MenuSession.MidframeRenderer
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__TweenService__1 = game:GetService("TweenService");
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
require(l__ModuleScripts__2.Packets);
require(l__ModuleScripts__2.Signal);
require(l__ModuleScripts__2.Promise);
local l__Trove__3 = require(l__ModuleScripts__2.Trove);
require(l__ModuleScripts__2.CEnum);
local l__QueueDef__4 = require(l__ModuleScripts__2.QueueDef);
local l__UIAssets__5 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local u1 = {};
u1.__index = u1;
local l__ClientRoot__6 = require(script.Parent.Parent.Parent.Parent.ClientRoot);
local l__Classes__7 = l__ClientRoot__6.Classes;
local l__Context__8 = l__ClientRoot__6.Context;
local l__InternalSymbols__9 = require(script.Parent.Parent.Parent.Parent.InternalSymbols);
local l__LocalPlayer__10 = game.Players.LocalPlayer;
local l__MatchmakingClient__11 = require(script.MatchmakingClient);
local u2 = TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
local u3 = 0;
function u1.new(p4, p5) --[[ Line: 62 ]]
    -- upvalues: u1 (copy), l__InternalSymbols__9 (copy), l__Trove__3 (copy), l__Context__8 (copy), l__MatchmakingClient__11 (copy)
    local u6 = setmetatable({}, u1);
    u6._session = l__InternalSymbols__9.owner("MenuSession", p5);
    u6.mid_ui = p4;
    u6._trove = l__Trove__3.new();
    u6._queue_trove = u6._trove:Extend();
    u6._party_trove = u6._trove:Extend();
    u6.member_entries = {};
    u6.invite_prompts = {
        _trove = u6._trove:Extend()
    };
    if not l__Context__8.is_public_lobby then
        u6:_initDeploy();
        return u6;
    end;
    u6._client = l__MatchmakingClient__11.new();
    u6._trove:Add(function() --[[ Line: 78 ]]
        -- upvalues: u6 (copy)
        u6._client:destroy();
    end);
    u6:_initState();
    return u6;
end;
function u1._showToast(p7, p8) --[[ Line: 89 ]]
    -- upvalues: u3 (ref), l__UIAssets__5 (copy), l__TweenService__1 (copy), u2 (copy)
    local l__ToastList__12 = p7.mid_ui.ToastList;
    u3 = u3 + 1;
    local u9 = l__UIAssets__5.Menu.MidframeToast:Clone();
    u9.Label.Text = p8;
    u9.LayoutOrder = u3;
    u9.Parent = l__ToastList__12;
    game.Debris:AddItem(u9, 8);
    l__TweenService__1:Create(u9.Label, u2, {
        Position = UDim2.fromScale(0, 0)
    }):Play();
    task.delay(7.6, function() --[[ Line: 104 ]]
        -- upvalues: u9 (copy), l__TweenService__1 (ref), u2 (ref)
        if u9 and u9.Parent ~= nil then
            l__TweenService__1:Create(u9.Label, u2, {
                Position = UDim2.fromScale(0, 1)
            }):Play();
        end;
    end);
end;
function u1._formatQueueError(_, p10) --[[ Line: 111 ]]
    return p10 == "already_queued" and "Already queued." or (p10 == "not_leader" and "Only the party leader can do that." or (p10 == "party_too_large" and "Party is too large for this queue." or (p10 == "members_queued" and "A party member is already unavailable." or (p10 == "unknown_queue" and "Unknown queue." or (p10 == "queue_unavailable" and "Queue unavailable." or "Queue error: " .. tostring(p10))))));
end;
function u1._formatQueueLeaveReason(_, p11) --[[ Line: 129 ]]
    return p11 == "party_changed" and "Queue canceled because the party changed." or (p11 == "member_disconnected" and "Queue canceled because a party member disconnected." or nil);
end;
function u1._formatInviteFailure(_, p12, p13) --[[ Line: 139 ]]
    if p12 == "player_unavailable" then
        return "Player unavailable.";
    elseif p12 == "already_in_party" then
        return "That player is already in a party.";
    elseif p12 == "invite_cooldown" then
        return "Wait " .. math.ceil(p13.context.cooldown_left) .. "s to invite this player.";
    else
        return p12 == "in_lobby" and "A lobby participant cannot join a party." or "Invite failed: " .. tostring(p12);
    end;
end;
function u1._showInvitePrompt(u14, p15) --[[ Line: 153 ]]
    -- upvalues: l__Classes__7 (copy)
    local l__context__13 = p15.context;
    local l__from_id__14 = l__context__13.from_id;
    local l__from_name__15 = l__context__13.from_name;
    local v16 = l__Classes__7._xd0d75b75975ea69f:_x54f11bcb5880e791({
        lifetime = 20,
        play_sound = true,
        show_lifetime_timer = true,
        members = {
            {
                kind = "Header",
                args = { "PARTY REQUEST!", "mail", Color3.fromRGB(255, 220, 67) }
            },
            {
                kind = "Text",
                args = { "<b>" .. l__from_name__15 .. "</b> wants to party up!" }
            },
            {
                kind = "Input",
                args = {
                    {
                        text = "ACCEPT",
                        close_on_activated = true,
                        color = Color3.fromRGB(70, 255, 70)
                    },
                    function() --[[ Line: 173 ]]
                        -- upvalues: u14 (copy), l__from_id__14 (copy)
                        u14._client:acceptInvite(l__from_id__14);
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
                    function() --[[ Line: 179 ]]
                        -- upvalues: u14 (copy), l__from_id__14 (copy)
                        u14._client:declineInvite(l__from_id__14);
                    end
                }
            }
        }
    });
    if v16 then
        u14.invite_prompts[l__from_id__14] = v16;
        u14.invite_prompts._trove:Add(function() --[[ Line: 188 ]]
            -- upvalues: u14 (copy), l__from_id__14 (copy)
            u14.invite_prompts[l__from_id__14] = nil;
        end);
    end;
end;
function u1._removeInvitePrompt(p17, p18) --[[ Line: 194 ]]
    local l__from_id__16 = p18.context.from_id;
    local u19 = p17.invite_prompts[l__from_id__16];
    if u19 then
        pcall(function() --[[ Line: 200 ]]
            -- upvalues: u19 (copy)
            u19:close();
        end);
        p17.invite_prompts[l__from_id__16] = nil;
    end;
end;
function u1._renderQueueFromSnapshot(p20) --[[ Line: 205 ]]
    local l__QuickButton__17 = p20.mid_ui.QuickButton;
    p20._client:localPlayerIsLeader();
    local v21 = p20._client:getQueueState();
    p20:_updateGamemodeLabel();
    if v21.is_queued then
        l__QuickButton__17.ActionLabel.Text = "IN QUEUE";
    else
        l__QuickButton__17.ActionLabel.Text = "START";
    end;
end;
function u1._destroyMemberEntry(p22, p23) --[[ Line: 220 ]]
    local v24 = p22.member_entries[tostring(p23)];
    if v24 then
        p22.member_entries[tostring(p23)] = nil;
        v24._trove:Destroy();
    end;
end;
function u1._syncPartyControlsFromSnapshot(p25) --[[ Line: 230 ]]
    local v26 = p25._client:getPartyState();
    local l__PartyContainer__18 = p25.mid_ui.PartyContainer;
    local v27 = v26.party_id ~= nil;
    p25._client:localPlayerIsLeader();
    l__PartyContainer__18.ExitIcon.Button.Visible = v27;
    l__PartyContainer__18.AddIcon.Button.Visible = true;
end;
function u1._syncLeaderFromSnapshot(p28) --[[ Line: 241 ]]
    -- upvalues: l__LocalPlayer__10 (copy)
    local v29 = nil;
    for _, v30 in p28._client:getPartyState().members do
        if v30.is_leader then
            v29 = v30.user_id;
            break;
        end;
    end;
    for v31, v32 in p28.member_entries do
        local v33 = tonumber(v31);
        local v34 = v33 == l__LocalPlayer__10.UserId;
        local v35 = v33 == v29;
        v32.record.is_leader = v35;
        v32.inst.CrownLabel.Visible = v35;
        v32.inst.SelfOutline.Visible = v34;
        v32.inst.IconButton.AutoButtonColor = p28:_canInteractWithMember(v32.record);
    end;
    p28:_syncPartyControlsFromSnapshot();
end;
function u1._canInteractWithMember(p36, p37) --[[ Line: 266 ]]
    -- upvalues: l__LocalPlayer__10 (copy)
    if p37 then
        if p36._client:localPlayerIsLeader() then
            return p37.user_id ~= l__LocalPlayer__10.UserId;
        else
            return false;
        end;
    else
        return false;
    end;
end;
function u1._refreshPartyFromSnapshot(p38) --[[ Line: 278 ]]
    -- upvalues: l__LocalPlayer__10 (copy)
    local v39 = p38._client:getPartyState();
    p38._party_trove:Clean();
    p38._party_trove = p38._trove:Extend();
    table.clear(p38.member_entries);
    local v40 = v39.party_id ~= nil;
    p38:_syncPartyControlsFromSnapshot();
    if v40 then
        for _, v41 in v39.members do
            p38:_createEntryFromMemberRecord(v41);
        end;
    else
        p38:_createEntryFromMemberRecord({
            is_leader = false,
            user_id = l__LocalPlayer__10.UserId,
            display_name = l__LocalPlayer__10.DisplayName
        });
    end;
end;
function u1._renderAll(p42) --[[ Line: 303 ]]
    local v43 = p42._client:getSnapshot();
    p42:_renderQueueFromSnapshot(v43.queue, v43.party);
    p42:_refreshPartyFromSnapshot(v43.party, v43.queue);
end;
function u1._onQueueStart(p44) --[[ Line: 309 ]]
    -- upvalues: l__Classes__7 (copy), l__TweenService__1 (copy)
    p44:_showToast("Started queuing.");
    p44:_renderQueueFromSnapshot();
    l__Classes__7._xbe184fb1376a575d:_x7ab8b42cc5920a78("BEEP2", true);
    local l__mid_ui__19 = p44.mid_ui;
    local _ = l__mid_ui__19.PartyContainer;
    l__mid_ui__19.QuickButton.Background.CycleFrame.Visible = true;
    l__mid_ui__19.QuickButton.Background.CycleFrame.Position = UDim2.fromScale(0, 0.5);
    l__TweenService__1:Create(l__mid_ui__19.QuickButton.Background.CycleFrame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
        Position = UDim2.fromScale(1, 0.5)
    }):Play();
    l__mid_ui__19.PartyGlow.Size = UDim2.fromScale(0.75, 0.4);
    l__TweenService__1:Create(l__mid_ui__19.PartyGlow, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(0.75, 0.11)
    }):Play();
    l__TweenService__1:Create(l__mid_ui__19.PartyGlow, TweenInfo.new(0.4, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0
    }):Play();
    l__TweenService__1:Create(l__mid_ui__19.QuickButton.SelectionOutline.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        Transparency = 0
    }):Play();
    l__mid_ui__19.QuickButton.HoverLabel.Visible = false;
    l__mid_ui__19.QuickButton.ActionLabel.Visible = true;
end;
function u1._onQueueEnd(p45) --[[ Line: 331 ]]
    -- upvalues: l__Classes__7 (copy), l__TweenService__1 (copy)
    local l__mid_ui__20 = p45.mid_ui;
    local _ = l__mid_ui__20.PartyContainer;
    l__mid_ui__20.QuickButton.Background.CycleFrame.Visible = false;
    l__Classes__7._xbe184fb1376a575d:_x7ab8b42cc5920a78("BEEP1", true);
    p45:_renderQueueFromSnapshot();
    l__TweenService__1:Create(l__mid_ui__20.PartyGlow, TweenInfo.new(0.4, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
    l__TweenService__1:Create(l__mid_ui__20.QuickButton.SelectionOutline.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        Transparency = 1
    }):Play();
    l__mid_ui__20.QuickButton.HoverLabel.Visible = false;
    l__mid_ui__20.QuickButton.ActionLabel.Visible = true;
end;
function u1._handleQueueEvent(p46, p47) --[[ Line: 348 ]]
    local l__kind__21 = p47.kind;
    local l__context__22 = p47.context;
    if l__kind__21 == "entered" then
        p46:_onQueueStart();
    elseif l__kind__21 == "left" then
        local v48 = p46:_formatQueueLeaveReason(l__context__22.reason);
        if v48 then
            p46:_showToast(v48);
        else
            p46:_showToast("Left queue.");
        end;
        p46:_onQueueEnd();
    elseif l__kind__21 == "match_found" then
        p46:_showToast("< MATCH FOUND >");
    else
        if l__kind__21 == "error" then
            p46:_showToast(p46:_formatQueueError(l__context__22.reason));
        end;
    end;
end;
function u1._handlePartyEvent(p49, p50) --[[ Line: 370 ]]
    local l__kind__23 = p50.kind;
    local l__context__24 = p50.context;
    if l__kind__23 == "updated" then
        if l__context__24.change == "party_replaced" then
            p49:_refreshPartyFromSnapshot();
            p49:_renderQueueFromSnapshot();
        else
            p49:_syncPartyControlsFromSnapshot();
        end;
    elseif l__kind__23 == "cleared" then
        if l__context__24.reason == "kicked" then
            p49:_showToast("You were removed from the party.");
        elseif l__context__24.reason == "disbanded" then
            p49:_showToast("Party disbanded.");
        end;
        p49:_refreshPartyFromSnapshot();
    else
        if l__kind__23 == "member_added" then
            local l__member__25 = l__context__24.member;
            if l__member__25 and not p49.member_entries[tostring(l__member__25.user_id)] then
                p49:_createEntryFromMemberRecord(l__member__25);
                p49:_syncLeaderFromSnapshot();
                p49:_showToast(l__member__25.display_name .. " joined the party.");
            end;
        elseif l__kind__23 == "member_removed" then
            local l__member__26 = l__context__24.member;
            if l__member__26 and p49.member_entries[tostring(l__member__26.user_id)] then
                p49:_destroyMemberEntry(l__member__26.user_id);
                p49:_syncLeaderFromSnapshot();
                p49:_showToast(l__member__26.display_name .. " left the party.");
            end;
        elseif l__kind__23 == "leader_changed" then
            p49:_syncLeaderFromSnapshot();
        end;
    end;
end;
function u1._handleInviteEvent(p51, p52) --[[ Line: 407 ]]
    local l__kind__27 = p52.kind;
    if l__kind__27 == "sent" then
        p51:_showToast("Invite sent to " .. p52.context.target_name .. ".");
    elseif l__kind__27 == "received" then
        p51:_showInvitePrompt(p52);
    elseif l__kind__27 == "rescinded" then
        p51:_removeInvitePrompt(p52);
    elseif l__kind__27 == "declined" then
        p51:_showToast("Invite declined.");
    else
        if l__kind__27 == "failed" then
            p51:_showToast(p51:_formatInviteFailure(p52.context.reason, p52));
        end;
    end;
end;
function u1._onMemberIconHover(p53, p54) --[[ Line: 424 ]]
    -- upvalues: l__LocalPlayer__10 (copy), l__TweenService__1 (copy), u2 (copy)
    if p53:_canInteractWithMember(p54) then
        if p54.user_id == l__LocalPlayer__10.UserId then
        else
            local v55 = p53.member_entries[tostring(p54.user_id)];
            if v55 then
                l__TweenService__1:Create(v55.inst.MinusLabel, u2, {
                    ImageTransparency = 0
                }):Play();
            end;
        end;
    end;
end;
function u1._onMemberIconUnhover(p56, p57) --[[ Line: 441 ]]
    -- upvalues: l__LocalPlayer__10 (copy), l__TweenService__1 (copy), u2 (copy)
    local v58 = p56.member_entries[tostring(p57.user_id)];
    if v58 then
        if p57.user_id == l__LocalPlayer__10.UserId then
        else
            l__TweenService__1:Create(v58.inst.MinusLabel, u2, {
                ImageTransparency = 1
            }):Play();
        end;
    end;
end;
function u1._onMemberIconActivated(p59, p60) --[[ Line: 454 ]]
    if p59:_canInteractWithMember(p60) then
        p59._client:kick(p60.user_id);
    end;
end;
function u1._createEntryFromMemberRecord(u61, u62) --[[ Line: 462 ]]
    -- upvalues: l__LocalPlayer__10 (copy), l__UIAssets__5 (copy)
    local v63 = u62.user_id == l__LocalPlayer__10.UserId;
    local l__PartyContainer__28 = u61.mid_ui.PartyContainer;
    local u64 = {};
    local u65 = l__UIAssets__5.Menu.MemberFrame:Clone();
    u64._trove = u61._party_trove:Extend();
    u64.record = {
        user_id = u62.user_id,
        display_name = u62.display_name,
        is_leader = u62.is_leader == true
    };
    task.spawn(function() --[[ Name: setupAvatarPic, Line 478 ]]
        -- upvalues: u62 (copy), u64 (copy), u65 (copy)
        local v66 = tostring(u62.user_id);
        local u67 = game:GetService("ReplicatedStorage").ReadOnly.Players:WaitForChild(v66);
        if u67 then
            u64.readable_folder = u67;
            (function(p68, u69) --[[ Name: setupFromValueInstance, Line 484 ]]
                -- upvalues: u67 (copy), u64 (ref)
                local u70 = u67:WaitForChild(p68);
                if u70 then
                    local v71 = u70.Changed:Connect(function() --[[ Line: 488 ]]
                        -- upvalues: u69 (copy), u70 (copy)
                        u69(u70.Value);
                    end);
                    u69(u70.Value);
                    u64._trove:Add(v71);
                else
                    warn("COULD NOT FIND VALUE INSTANCE : ", p68);
                end;
            end)("player_icon", function(p72) --[[ Line: 496 ]]
                -- upvalues: u65 (ref)
                u65.PortraitLabel.Image = p72;
            end);
        else
            warn("NO READABLE FOLDER");
        end;
    end);
    u65.SelfOutline.Visible = v63;
    u65.CrownLabel.Visible = u62.is_leader;
    u65.IconButton.AutoButtonColor = u61:_canInteractWithMember(u64.record);
    u64._trove:Connect(u65.IconButton.MouseEnter, function() --[[ Line: 507 ]]
        -- upvalues: u61 (copy), u64 (copy)
        u61:_onMemberIconHover(u64.record);
    end);
    u64._trove:Connect(u65.IconButton.MouseLeave, function() --[[ Line: 511 ]]
        -- upvalues: u61 (copy), u64 (copy)
        u61:_onMemberIconUnhover(u64.record);
    end);
    u64._trove:Connect(u65.IconButton.Activated, function() --[[ Line: 515 ]]
        -- upvalues: u61 (copy), u64 (copy)
        u61:_onMemberIconActivated(u64.record);
    end);
    u64.inst = u65;
    u64._trove:Add(u65);
    u65.Parent = l__PartyContainer__28;
    u61.member_entries[tostring(u62.user_id)] = u64;
end;
function u1._updateGamemodeLabel(p73) --[[ Line: 527 ]]
    -- upvalues: l__QueueDef__4 (copy)
    local l__QuickButton__29 = p73.mid_ui.QuickButton;
    local v74 = p73._client:getQueueState();
    local v75 = p73._client:localPlayerIsLeader();
    local function v80(p76) --[[ Line: 533 ]]
        -- upvalues: l__QueueDef__4 (ref)
        local v77 = "[ ";
        if #p76 > 0 then
            for v78, v79 in p76 do
                local l__display_name__30 = l__QueueDef__4.getDef(v79).display_name;
                if v78 == 1 then
                    v77 = v77 .. l__display_name__30;
                else
                    v77 = v77 .. ", " .. l__display_name__30;
                end;
            end;
        else
            v77 = v77 .. "NONE";
        end;
        return v77 .. " ]";
    end;
    if v74.is_queued then
        l__QuickButton__29.GamemodeLabel.Text = v80(v74.queue_ids);
    elseif v75 then
        l__QuickButton__29.GamemodeLabel.Text = v80(p73._session.queue_cart);
    else
        l__QuickButton__29.GamemodeLabel.Text = "[ AWAITING HOST ]";
    end;
end;
function u1._onQueueButtonActivated(p81) --[[ Line: 566 ]]
    local _ = p81.mid_ui.QuickButton;
    local v82 = p81._client:localPlayerIsLeader();
    local v83 = p81._client:getQueueState();
    if v82 then
        if v83.is_queued then
            p81._client:dequeue();
        else
            local l__queue_cart__31 = p81._session.queue_cart;
            if #l__queue_cart__31 > 0 then
                p81._client:enqueue(l__queue_cart__31);
            else
                p81._session:openPage("gamemodes_page");
            end;
        end;
    else
        p81:_showToast("Only the host can start/stop queue.");
    end;
end;
function u1._onQueueButtonHover(p84) --[[ Line: 590 ]]
    local l__QuickButton__32 = p84.mid_ui.QuickButton;
    local v85 = p84._client:localPlayerIsLeader();
    local v86 = p84._client:getQueueState();
    if v85 then
        if v86.is_queued then
            l__QuickButton__32.HoverLabel.Text = "STOP QUEUE?";
            l__QuickButton__32.HoverLabel.Visible = true;
            l__QuickButton__32.ActionLabel.Visible = false;
        end;
    else
        l__QuickButton__32.HoverLabel.Text = "NOT LEADER";
        l__QuickButton__32.HoverLabel.Visible = true;
        l__QuickButton__32.ActionLabel.Visible = false;
    end;
end;
function u1._onQueueButtonUnhover(p87) --[[ Line: 611 ]]
    p87._client:localPlayerIsLeader();
    local l__QuickButton__33 = p87.mid_ui.QuickButton;
    l__QuickButton__33.HoverLabel.Visible = false;
    l__QuickButton__33.ActionLabel.Visible = true;
end;
function u1._initState(u88) --[[ Line: 621 ]]
    -- upvalues: l__Classes__7 (copy)
    local l__mid_ui__34 = u88.mid_ui;
    local l__PartyContainer__35 = l__mid_ui__34.PartyContainer;
    local l__QuickButton__36 = l__mid_ui__34.QuickButton;
    l__PartyContainer__35.Visible = true;
    u88._trove:Connect(u88._client.queueEvent, function(p89) --[[ Line: 628 ]]
        -- upvalues: u88 (copy)
        u88:_handleQueueEvent(p89);
    end);
    u88._trove:Connect(u88._client.partyEvent, function(p90) --[[ Line: 632 ]]
        -- upvalues: u88 (copy)
        u88:_handlePartyEvent(p90);
    end);
    u88._trove:Connect(u88._client.inviteEvent, function(p91) --[[ Line: 636 ]]
        -- upvalues: u88 (copy)
        u88:_handleInviteEvent(p91);
    end);
    u88:_refreshPartyFromSnapshot();
    u88:_renderQueueFromSnapshot();
    u88._trove:Connect(l__PartyContainer__35.ExitIcon.Button.Activated, function() --[[ Line: 643 ]]
        -- upvalues: u88 (copy)
        u88._client:leaveParty();
        u88:_showToast("You left the party.");
    end);
    u88._trove:Connect(l__PartyContainer__35.AddIcon.Button.Activated, function() --[[ Line: 648 ]]
        -- upvalues: u88 (copy), l__Classes__7 (ref)
        l__Classes__7._xd00ac57201023755:_x4782af5368e4c758("PlayerBrowser", {
            header_text = "SELECT A PLAYER TO QUEUE WITH",
            selected_callback = function(p92) --[[ Line: 651 ]]
                -- upvalues: u88 (ref)
                local v93 = tonumber(p92[1]);
                if game:GetService("Players"):GetPlayerByUserId(v93) then
                    u88._client:partyIntent(v93);
                else
                    u88:_showToast("This player is not in the server.");
                end;
            end
        });
    end);
    u88._trove:Connect(l__QuickButton__36.Button.Activated, function() --[[ Line: 662 ]]
        -- upvalues: u88 (copy)
        u88:_onQueueButtonActivated();
    end);
    u88._trove:Connect(l__QuickButton__36.Button.MouseEnter, function() --[[ Line: 666 ]]
        -- upvalues: u88 (copy)
        u88:_onQueueButtonHover();
    end);
    u88._trove:Connect(l__QuickButton__36.Button.MouseLeave, function() --[[ Line: 670 ]]
        -- upvalues: u88 (copy)
        u88:_onQueueButtonUnhover();
    end);
end;
function u1._initDeploy(u94) --[[ Line: 675 ]]
    local l__mid_ui__37 = u94.mid_ui;
    local l__PartyContainer__38 = l__mid_ui__37.PartyContainer;
    local l__QuickButton__39 = l__mid_ui__37.QuickButton;
    l__QuickButton__39.ActionLabel.Text = "DROP-IN";
    l__QuickButton__39.GamemodeLabel.Visible = false;
    l__PartyContainer__38.Visible = false;
    l__mid_ui__37.PartyGlow.Visible = false;
    l__mid_ui__37.PartyGlow1.Visible = false;
    l__QuickButton__39.Position = UDim2.fromScale(0.5, 0.9);
    u94._trove:Connect(l__QuickButton__39.Button.Activated, function() --[[ Line: 688 ]]
        -- upvalues: u94 (copy)
        u94._session:requestDeploy();
    end);
end;
function u1._initAll(_) --[[ Line: 693 ]] end;
function u1.destroy(p95) --[[ Line: 696 ]]
    p95._trove:Clean();
end;
return u1;
