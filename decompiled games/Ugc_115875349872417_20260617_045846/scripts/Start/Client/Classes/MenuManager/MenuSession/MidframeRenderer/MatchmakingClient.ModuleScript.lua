-- Decompiled from: Start.Client.Classes.MenuManager.MenuSession.MidframeRenderer.MatchmakingClient
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__2 = require(l__ModuleScripts__1.Packets);
local l__Signal__3 = require(l__ModuleScripts__1.Signal);
local l__Trove__4 = require(l__ModuleScripts__1.Trove);
local u1 = {};
u1.__index = u1;
local function u8(p2) --[[ Line: 20 ]]
    local v3 = {};
    local v4 = {};
    if typeof(p2) ~= "table" then
        return v3;
    end;
    for _, v5 in p2 do
        if typeof(v5) == "number" and not v4[v5] then
            v4[v5] = true;
            table.insert(v3, v5);
        end;
    end;
    table.sort(v3, function(p6, p7) --[[ Line: 35 ]]
        return p6 < p7;
    end);
    return v3;
end;
local function u12(p9) --[[ Line: 42 ]]
    local v10 = {};
    for _, v11 in p9 do
        table.insert(v10, {
            user_id = v11.user_id,
            display_name = v11.display_name,
            is_leader = v11.is_leader == true
        });
    end;
    return v10;
end;
local function u22(p13) --[[ Line: 56 ]]
    -- upvalues: u12 (copy)
    if typeof(p13) ~= "table" then
        return p13;
    end;
    local v14 = {};
    for v15, v16 in p13 do
        if typeof(v16) == "table" then
            if v15 == "queue_ids" then
                local v17 = {};
                for _, v18 in v16 do
                    table.insert(v17, v18);
                end;
                v14[v15] = v17;
            elseif v15 == "members" then
                v14[v15] = u12(v16);
            else
                local v19 = {};
                for v20, v21 in v16 do
                    v19[v20] = v21;
                end;
                v14[v15] = v19;
            end;
        else
            v14[v15] = v16;
        end;
    end;
    return v14;
end;
function u1.new() --[[ Line: 84 ]]
    -- upvalues: u1 (copy), l__Trove__4 (copy), l__Signal__3 (copy)
    local v23 = setmetatable({}, u1);
    v23._trove = l__Trove__4.new();
    v23._queue_state = {
        is_queued = false,
        is_desperate = false,
        is_match_pending = false,
        matched_queue_id = nil,
        last_leave_reason = nil,
        last_leave_payload = nil,
        last_error = nil,
        last_error_payload = nil,
        queue_ids = {}
    };
    v23._party_state = {
        party_id = nil,
        is_desperate = false,
        is_awaiting_reconstruction = false,
        last_exit_op = nil,
        last_exit_payload = nil,
        members = {}
    };
    v23.stateChanged = v23._trove:Add(l__Signal__3.new());
    v23.queueChanged = v23._trove:Add(l__Signal__3.new());
    v23.partyChanged = v23._trove:Add(l__Signal__3.new());
    v23.queueEvent = v23._trove:Add(l__Signal__3.new());
    v23.partyEvent = v23._trove:Add(l__Signal__3.new());
    v23.inviteEvent = v23._trove:Add(l__Signal__3.new());
    v23:_bindPackets();
    return v23;
end;
function u1._bindPackets(u24) --[[ Line: 123 ]]
    -- upvalues: l__Packets__2 (copy)
    u24._trove:Connect(l__Packets__2._xbddb58201adb89be.OnClientEvent, function(p25) --[[ Line: 124 ]]
        -- upvalues: u24 (copy)
        u24:_handleQueueOp(p25);
    end);
    u24._trove:Connect(l__Packets__2._xf7747bc86b651d7a.OnClientEvent, function(p26) --[[ Line: 128 ]]
        -- upvalues: u24 (copy)
        u24:_handlePartyOp(p26);
    end);
end;
function u1._emitStateChanged(p27, p28) --[[ Line: 133 ]]
    local v29 = p27:getSnapshot();
    p27.stateChanged:Fire(v29, p28);
    if p28 == "queue" then
        p27.queueChanged:Fire(v29.queue);
    elseif p28 == "party" then
        p27.partyChanged:Fire(v29.party);
    else
        p27.queueChanged:Fire(v29.queue);
        p27.partyChanged:Fire(v29.party);
    end;
end;
function u1._fireQueueEvent(p30, p31, p32) --[[ Line: 147 ]]
    -- upvalues: u22 (copy)
    p30.queueEvent:Fire({
        kind = p31,
        context = u22(p32),
        queue = p30:getQueueState(),
        party = p30:getPartyState()
    });
end;
function u1._firePartyEvent(p33, p34, p35) --[[ Line: 156 ]]
    -- upvalues: u22 (copy)
    p33.partyEvent:Fire({
        kind = p34,
        context = u22(p35),
        queue = p33:getQueueState(),
        party = p33:getPartyState()
    });
end;
function u1._fireInviteEvent(p36, p37, p38) --[[ Line: 165 ]]
    -- upvalues: u22 (copy)
    p36.inviteEvent:Fire({
        kind = p37,
        context = u22(p38),
        queue = p36:getQueueState(),
        party = p36:getPartyState()
    });
end;
function u1._clearQueueState(p39, p40, p41) --[[ Line: 174 ]]
    -- upvalues: u22 (copy)
    p39._queue_state.is_queued = false;
    p39._queue_state.queue_ids = {};
    p39._queue_state.is_desperate = false;
    p39._queue_state.is_match_pending = false;
    p39._queue_state.matched_queue_id = nil;
    p39._queue_state.last_leave_reason = p40;
    p39._queue_state.last_leave_payload = p41 and u22(p41) or nil;
end;
function u1._clearPartyState(p42, p43, p44) --[[ Line: 184 ]]
    -- upvalues: u22 (copy)
    p42._party_state.party_id = nil;
    p42._party_state.members = {};
    p42._party_state.is_desperate = false;
    p42._party_state.is_awaiting_reconstruction = false;
    p42._party_state.last_exit_op = p43;
    p42._party_state.last_exit_payload = p44 and u22(p44) or nil;
end;
function u1.localPlayerIsLeader(p45) --[[ Line: 193 ]]
    if p45._party_state.party_id == nil then
        return true;
    end;
    for _, v46 in p45._party_state.members do
        if v46.user_id == game.Players.LocalPlayer.UserId then
            return v46.is_leader == true;
        end;
    end;
    return false;
end;
function u1._handleQueueOp(p47, p48) --[[ Line: 208 ]]
    -- upvalues: u22 (copy), u8 (copy)
    if typeof(p48) == "table" and typeof(p48.op) == "string" then
        local l__op__5 = p48.op;
        local v49 = u22(p48);
        if l__op__5 == "queue_entered" then
            p47._queue_state.is_queued = true;
            p47._queue_state.queue_ids = u8(p48.queue_ids);
            p47._queue_state.is_desperate = false;
            p47._queue_state.is_match_pending = false;
            p47._queue_state.matched_queue_id = nil;
            p47._queue_state.last_leave_reason = nil;
            p47._queue_state.last_leave_payload = nil;
            p47._queue_state.last_error = nil;
            p47._queue_state.last_error_payload = nil;
            p47:_emitStateChanged("queue");
            p47:_fireQueueEvent("entered", v49);
        elseif l__op__5 == "queue_left" then
            p47:_clearQueueState(p48.reason, p48);
            p47:_emitStateChanged("queue");
            p47:_fireQueueEvent("left", v49);
        elseif l__op__5 == "queue_desperate_changed" then
            local v50 = p48.value == true;
            p47._queue_state.is_desperate = v50;
            if p47._party_state.party_id == nil then
                p47:_emitStateChanged("queue");
            else
                p47._party_state.is_desperate = v50;
                p47:_emitStateChanged("all");
            end;
            p47:_fireQueueEvent("desperate_changed", v49);
        elseif l__op__5 == "match_found" then
            p47._queue_state.is_queued = false;
            p47._queue_state.queue_ids = {};
            p47._queue_state.is_desperate = false;
            p47._queue_state.is_match_pending = true;
            p47._queue_state.matched_queue_id = p48.queue_id;
            p47._queue_state.last_leave_reason = nil;
            p47._queue_state.last_leave_payload = nil;
            p47:_emitStateChanged("queue");
            p47:_fireQueueEvent("match_found", v49);
        else
            if l__op__5 == "queue_error" then
                p47._queue_state.last_error = p48.reason;
                p47._queue_state.last_error_payload = v49;
                p47:_emitStateChanged("queue");
                p47:_fireQueueEvent("error", v49);
            end;
        end;
    end;
end;
function u1._handlePartyOp(p51, p52) --[[ Line: 262 ]]
    -- upvalues: u22 (copy), u12 (copy)
    if typeof(p52) == "table" and typeof(p52.op) == "string" then
        local l__op__6 = p52.op;
        local v53 = u22(p52);
        if l__op__6 == "party_update" then
            local l__members__7 = p51._party_state.members;
            local l__party_id__8 = p51._party_state.party_id;
            p51._party_state.party_id = p52.party_id;
            p51._party_state.members = u12(p52.members or {});
            p51._party_state.is_desperate = p52.is_desperate == true;
            p51._party_state.is_awaiting_reconstruction = false;
            p51._party_state.last_exit_op = nil;
            p51._party_state.last_exit_payload = nil;
            p51:_emitStateChanged("party");
            if l__party_id__8 == p52.party_id then
                p51:_firePartyEvent("updated", {
                    change = "party_refreshed",
                    op = l__op__6,
                    payload = v53
                });
            else
                p51:_firePartyEvent("updated", {
                    change = "party_replaced",
                    op = l__op__6,
                    payload = v53
                });
            end;
            local v54 = {};
            for _, v55 in l__members__7 do
                v54[v55.user_id] = v55;
            end;
            local v56 = {};
            for _, v57 in p51._party_state.members do
                v56[v57.user_id] = v57;
                if v54[v57.user_id] then
                    if v54[v57.user_id].is_leader ~= v57.is_leader then
                        p51:_firePartyEvent("leader_changed", {
                            op = l__op__6,
                            payload = v53,
                            member = v57
                        });
                    end;
                else
                    p51:_firePartyEvent("member_added", {
                        op = l__op__6,
                        payload = v53,
                        member = v57
                    });
                end;
            end;
            for _, v58 in l__members__7 do
                if not v56[v58.user_id] then
                    p51:_firePartyEvent("member_removed", {
                        reason = "party_update",
                        op = l__op__6,
                        payload = v53,
                        member = v58
                    });
                end;
            end;
        elseif l__op__6 == "disbanded" or (l__op__6 == "left_party" or l__op__6 == "kicked") then
            p51:_clearPartyState(l__op__6, p52);
            p51:_emitStateChanged("party");
            p51:_firePartyEvent("cleared", {
                op = l__op__6,
                payload = v53,
                reason = l__op__6
            });
        elseif l__op__6 == "invite_received" then
            p51:_fireInviteEvent("received", v53);
        elseif l__op__6 == "invite_sent" then
            p51:_fireInviteEvent("sent", v53);
        elseif l__op__6 == "invite_rescinded" then
            p51:_fireInviteEvent("rescinded", v53);
        elseif l__op__6 == "invite_declined" then
            p51:_fireInviteEvent("declined", v53);
        else
            if l__op__6 == "invite_failed" then
                p51:_fireInviteEvent("failed", v53);
            end;
        end;
    end;
end;
function u1.getQueueState(p59) --[[ Line: 350 ]]
    -- upvalues: u22 (copy)
    local v60 = {
        is_queued = p59._queue_state.is_queued
    };
    local v61 = {};
    for _, v62 in p59._queue_state.queue_ids do
        table.insert(v61, v62);
    end;
    v60.queue_ids = v61;
    v60.is_desperate = p59._queue_state.is_desperate;
    v60.is_match_pending = p59._queue_state.is_match_pending;
    v60.matched_queue_id = p59._queue_state.matched_queue_id;
    v60.last_leave_reason = p59._queue_state.last_leave_reason;
    v60.last_leave_payload = u22(p59._queue_state.last_leave_payload);
    v60.last_error = p59._queue_state.last_error;
    v60.last_error_payload = u22(p59._queue_state.last_error_payload);
    return v60;
end;
function u1.getPartyState(p63) --[[ Line: 364 ]]
    -- upvalues: u12 (copy), u22 (copy)
    return {
        party_id = p63._party_state.party_id,
        members = u12(p63._party_state.members),
        is_desperate = p63._party_state.is_desperate,
        is_awaiting_reconstruction = p63._party_state.is_awaiting_reconstruction,
        last_exit_op = p63._party_state.last_exit_op,
        last_exit_payload = u22(p63._party_state.last_exit_payload)
    };
end;
function u1.getSnapshot(p64) --[[ Line: 375 ]]
    return {
        queue = p64:getQueueState(),
        party = p64:getPartyState()
    };
end;
function u1.isQueued(p65) --[[ Line: 382 ]]
    return p65._queue_state.is_queued;
end;
function u1.isInParty(p66) --[[ Line: 386 ]]
    return p66._party_state.party_id ~= nil;
end;
function u1.isMatchPending(p67) --[[ Line: 390 ]]
    return p67._queue_state.is_match_pending;
end;
function u1.isAwaitingReconstruction(p68) --[[ Line: 394 ]]
    return p68._party_state.is_awaiting_reconstruction;
end;
function u1.canQueue(p69) --[[ Line: 398 ]]
    local v70 = not p69._queue_state.is_queued;
    if v70 then
        v70 = not p69._queue_state.is_match_pending;
    end;
    return v70;
end;
function u1.canToggleDesperate(p71) --[[ Line: 402 ]]
    local l__is_queued__9 = p71._queue_state.is_queued;
    if l__is_queued__9 then
        l__is_queued__9 = not p71._queue_state.is_match_pending;
    end;
    return l__is_queued__9;
end;
function u1.canPartyMutate(p72) --[[ Line: 406 ]]
    return not p72._queue_state.is_match_pending;
end;
function u1.enqueue(_, p73) --[[ Line: 410 ]]
    -- upvalues: u8 (copy), l__Packets__2 (copy)
    local v74 = u8(p73);
    if #v74 == 0 then
    else
        l__Packets__2._xbddb58201adb89be:Fire({
            op = "enqueue",
            queue_ids = v74
        });
    end;
end;
function u1.dequeue(_) --[[ Line: 422 ]]
    -- upvalues: l__Packets__2 (copy)
    l__Packets__2._xbddb58201adb89be:Fire({
        op = "dequeue"
    });
end;
function u1.setDesperate(_, p75) --[[ Line: 428 ]]
    -- upvalues: l__Packets__2 (copy)
    l__Packets__2._xbddb58201adb89be:Fire({
        op = "set_desperate",
        value = p75 == true
    });
end;
function u1.partyIntent(_, p76) --[[ Line: 435 ]]
    -- upvalues: l__Packets__2 (copy)
    if typeof(p76) == "number" then
        l__Packets__2._xf7747bc86b651d7a:Fire({
            op = "party_intent",
            target_id = p76
        });
    end;
end;
function u1.acceptInvite(_, p77) --[[ Line: 446 ]]
    -- upvalues: l__Packets__2 (copy)
    if typeof(p77) == "number" then
        l__Packets__2._xf7747bc86b651d7a:Fire({
            op = "accept_invite",
            from_id = p77
        });
    end;
end;
function u1.declineInvite(_, p78) --[[ Line: 457 ]]
    -- upvalues: l__Packets__2 (copy)
    if typeof(p78) == "number" then
        l__Packets__2._xf7747bc86b651d7a:Fire({
            op = "decline_invite",
            from_id = p78
        });
    end;
end;
function u1.leaveParty(_) --[[ Line: 468 ]]
    -- upvalues: l__Packets__2 (copy)
    l__Packets__2._xf7747bc86b651d7a:Fire({
        op = "leave"
    });
end;
function u1.kick(_, p79) --[[ Line: 474 ]]
    -- upvalues: l__Packets__2 (copy)
    if typeof(p79) == "number" then
        l__Packets__2._xf7747bc86b651d7a:Fire({
            op = "kick",
            target_id = p79
        });
    end;
end;
function u1.transferLead(_, p80) --[[ Line: 485 ]]
    -- upvalues: l__Packets__2 (copy)
    if typeof(p80) == "number" then
        l__Packets__2._xf7747bc86b651d7a:Fire({
            op = "transfer_lead",
            target_id = p80
        });
    end;
end;
function u1.destroy(p81) --[[ Line: 496 ]]
    p81._trove:Destroy();
end;
return u1;
