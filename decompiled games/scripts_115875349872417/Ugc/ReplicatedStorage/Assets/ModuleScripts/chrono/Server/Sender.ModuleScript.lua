-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__EntityGrid__2 = require(script.Parent.EntityGrid);
require(script.Parent.Parent.Shared.Types);
local l__Shared__3 = script.Parent.Parent.Shared;
local l__ModelHelper__4 = require(l__Shared__3.ModelHelper);
local l__SERVER__5 = require(l__Shared__3.Stats).SERVER;
local u1 = 0;
local u2 = 0;
local u3 = buffer.create(951);
local l__Replicate__6 = l__Shared__3.Remotes.Replicate;
local l__ReplicateFull__7 = l__Shared__3.Remotes.ReplicateFull;
local function u16(p4, p5) --[[ Line: 48 ]]
    -- upvalues: u3 (copy), l__Replicate__6 (copy), u1 (ref), u2 (ref)
    local v6 = 0;
    for v7, v8 in p5 do
        buffer.writef32(u3, v6, v7);
        local v9 = v6 + 4;
        v6 = v9 + 1;
        local v10 = 0;
        for _, v11 in v8 do
            local v12 = buffer.len(v11);
            if v6 + v12 > 900 then
                buffer.writeu8(u3, v9, v10);
                local v13 = buffer.create(v6);
                buffer.copy(v13, 0, u3, 0, v6);
                l__Replicate__6:FireClient(p4, "O", v13);
                u1 = u1 + v6;
                u2 = u2 + 1;
                local v14 = 0;
                buffer.writef32(u3, v14, v7);
                v9 = v14 + 4;
                v6 = v9 + 1;
                v10 = 0;
            end;
            buffer.copy(u3, v6, v11, 0, v12);
            v10 = v10 + 1;
            v6 = v6 + v12;
        end;
        buffer.writeu8(u3, v9, v10);
    end;
    if v6 > 0 then
        local v15 = buffer.create(v6);
        buffer.copy(v15, 0, u3, 0, v6);
        l__Replicate__6:FireClient(p4, "O", v15);
        u1 = u1 + v6;
        u2 = u2 + 1;
    end;
end;
local function u35(p17, p18, p19) --[[ Line: 84 ]]
    -- upvalues: u3 (copy), l__Replicate__6 (copy), u1 (ref), u2 (ref)
    local v20 = u3;
    local v21 = 0;
    for v22, v23 in p18 do
        local v24 = v22.config.FULL_ROTATION and 20 or 16;
        local l__lastTicked__8 = v22.lastTicked;
        local l__FULL_ROTATION__9 = v22.config.FULL_ROTATION;
        buffer.writef32(v20, v21, l__lastTicked__8);
        local v25 = v21 + 4;
        local v26 = p19 and 1 or 0;
        if l__FULL_ROTATION__9 then
            v26 = v26 + 2;
        end;
        buffer.writeu8(v20, v25, v26);
        local v27 = v25 + 1;
        v21 = v27 + 1;
        local v28 = 0;
        for _, v29 in v23 do
            if v21 + v24 > 900 then
                buffer.writeu8(v20, v27, v28);
                local v30 = buffer.create(v21);
                buffer.copy(v30, 0, u3, 0, v21);
                l__Replicate__6:FireClient(p17, "X", v30);
                u1 = u1 + v21;
                u2 = u2 + 1;
                local v31 = 0;
                local l__lastTicked__10 = v22.lastTicked;
                local l__FULL_ROTATION__11 = v22.config.FULL_ROTATION;
                buffer.writef32(v20, v31, l__lastTicked__10);
                local v32 = v31 + 4;
                local v33 = p19 and 1 or 0;
                if l__FULL_ROTATION__11 then
                    v33 = v33 + 2;
                end;
                buffer.writeu8(v20, v32, v33);
                v27 = v32 + 1;
                v21 = v27 + 1;
                v28 = 0;
            end;
            v28 = v28 + 1;
            buffer.copy(v20, v21, v29, 0, v24);
            v21 = v21 + v24;
        end;
        buffer.writeu8(v20, v27, v28);
    end;
    if v21 > 0 then
        local v34 = buffer.create(v21);
        buffer.copy(v34, 0, u3, 0, v21);
        l__Replicate__6:FireClient(p17, "X", v34);
        u1 = u1 + v21;
        u2 = u2 + 1;
    end;
end;
local function u40(p36, p37) --[[ Line: 118 ]]
    -- upvalues: l__ModelHelper__4 (copy)
    if p37.destroyed then
        return nil;
    end;
    local v38, v39 = l__ModelHelper__4.ReadyModelFromRep(p37, p36);
    local l__NAME__12 = p37.entityConfig.NAME;
    if l__NAME__12 == "DEFAULT" then
        l__NAME__12 = nil;
    end;
    return {
        id = p37.id,
        _player = p37._player,
        networkOwner = p37.networkOwner,
        cframe = p37.latestCFrame or CFrame.new(),
        time = p37.lastClientClock or 0,
        config = l__NAME__12,
        model = v38,
        _modelMetaData = v39,
        paused = p37.paused,
        isHalfTicked = p37.isHalfTicked,
        _data = p37._data,
        mountParentId = p37.mountParentId,
        mountOffset = p37.mountOffset,
        broadPhase = p37.broadPhase
    };
end;
local u41 = 0;
local u42 = 0;
local function v66(u43) --[[ Line: 152 ]]
    -- upvalues: l__EntityGrid__2 (copy), u40 (copy), u16 (copy), u35 (copy), l__ReplicateFull__7 (copy), u41 (ref), u42 (ref)
    local v44 = l__EntityGrid__2.GetEntityHolder(u43);
    if v44 then
        debug.profilebegin("ReplicatePlayer");
        local l__REPLICATED__13 = v44.REPLICATED;
        local u45 = table.clone(l__REPLICATED__13);
        v44.REPLICATED = u45;
        local l__NORMAL__14 = v44.NORMAL;
        local l__HALF__15 = v44.HALF;
        local u46 = {};
        local u47 = {};
        local u48 = {};
        local u49 = {};
        local u50 = {};
        local u51 = time();
        local function v60(p52, p53) --[[ Line: 188 ]]
            -- upvalues: u45 (copy), l__REPLICATED__13 (copy), u46 (copy), u40 (ref), u43 (copy), u48 (copy), u51 (copy), u47 (copy), u50 (copy), u49 (copy)
            if p52.destroyed then
            else
                u45[p52] = true;
                if l__REPLICATED__13[p52] then
                    if p52._changes then
                        table.insert(u48, p52._changes);
                    end;
                    l__REPLICATED__13[p52] = nil;
                    if p52.paused then
                    elseif p52.isContextOwner then
                        local l___ticker__16 = p52._ticker;
                        if l___ticker__16 and (l___ticker__16.tickedFrame == u51 and p52.cframeBuffer) then
                            local v54 = p52.isHalfTicked or not p53;
                            if v54 and not l___ticker__16.tickedHalf then
                            else
                                local v55;
                                if v54 then
                                    v55 = u50;
                                else
                                    v55 = u49;
                                end;
                                local v56 = v55[l___ticker__16];
                                if not v56 then
                                    v56 = {};
                                    v55[l___ticker__16] = v56;
                                end;
                                table.insert(v56, p52.cframeBuffer);
                            end;
                        end;
                    elseif p52.arriveFrame == u51 then
                        if p52.networkOwner == u43 then
                        else
                            local v57 = p52.lastClientClock or 0;
                            if not u47[v57] then
                                u47[v57] = {};
                            end;
                            table.insert(u47[v57], p52.cframeBuffer);
                        end;
                    end;
                else
                    local v58 = u46;
                    local v59 = u40(u43, p52);
                    table.insert(v58, v59);
                end;
            end;
        end;
        local v61 = os.clock();
        local v62 = {};
        for _, v63 in l__NORMAL__14 do
            v60(v63, true);
        end;
        for _, v64 in l__HALF__15 do
            v60(v64, false);
        end;
        for v65, _ in l__REPLICATED__13 do
            u45[v65] = nil;
            table.insert(v62, v65._lastId or v65.id);
        end;
        u16(u43, u47);
        u35(u43, u49);
        u35(u43, u50, true);
        if #v62 > 0 or (#u46 > 0 or #u48 > 0) then
            l__ReplicateFull__7:FireClient(u43, u46, v62, u48);
        end;
        debug.profileend();
        u41 = u41 + (os.clock() - v61);
        u42 = u42 + 1;
    end;
end;
local u67 = os.clock();
l__RunService__1.Heartbeat:Connect(function() --[[ Line: 267 ]]
    -- upvalues: l__SERVER__5 (copy), u41 (ref), u42 (ref), u67 (ref), u1 (ref), u2 (ref)
    l__SERVER__5.REPLICATE_PLAYER_TIME_MS = u41 / math.max(u42, 1) * 1000;
    if os.clock() - u67 > 1 then
        l__SERVER__5.BYTES_SENT_PER_SEC = u1;
        l__SERVER__5.PACKETS_SENT_PER_SEC = u2;
        u1 = 0;
        u2 = 0;
        u67 = os.clock();
        u41 = 0;
        u42 = 0;
    end;
end);
return {
    ReplicatePlayer = v66
};