-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.chrono.Client.Receiver
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

game:GetService("CollectionService");
game:GetService("ReplicatedStorage");
local l__RunService__1 = game:GetService("RunService");
local l__Shared__2 = script.Parent.Parent.Shared;
local l__Warn__3 = require(l__Shared__2.Warn);
local l__Entity__4 = require(l__Shared__2.Entity);
local l__Holder__5 = require(l__Shared__2.Holder);
local l__ModelHelper__6 = require(l__Shared__2.ModelHelper);
require(l__Shared__2.Types);
local l__CLIENT__7 = require(l__Shared__2.Stats).CLIENT;
local u1 = 0;
local u2 = 0;
local u3 = 0;
local u4 = 0;
local l___SetTickMode__8 = l__Entity__4._SetTickMode;
local l__Replicate__9 = l__Shared__2.Remotes.Replicate;
local l__ReplicateFull__10 = l__Shared__2.Remotes.ReplicateFull;
local function u18(p5, p6) --[[ Line: 43 ]]
    local v7 = buffer.readf32(p5, p6);
    local v8 = p6 + 4;
    local v9 = buffer.readf32(p5, v8);
    local v10 = v8 + 4;
    local v11 = buffer.readf32(p5, v10);
    local v12 = v10 + 4;
    local v13 = buffer.readu16(p5, v12) / 65535 * 6.283185307179586 - 3.141592653589793;
    local v14 = v12 + 2;
    local v15 = buffer.readu16(p5, v14) / 65535 * 6.283185307179586 - 3.141592653589793;
    local v16 = v14 + 2;
    local v17 = buffer.readu16(p5, v16) / 65535 * 6.283185307179586 - 3.141592653589793;
    local _ = v16 + 2;
    return CFrame.new(v7, v9, v11) * CFrame.fromOrientation(v13, v15, v17);
end;
local function u28(p19, p20) --[[ Line: 61 ]]
    local v21 = buffer.readf32(p19, p20);
    local v22 = p20 + 4;
    local v23 = buffer.readf32(p19, v22);
    local v24 = v22 + 4;
    local v25 = buffer.readf32(p19, v24);
    local v26 = v24 + 4;
    local v27 = buffer.readu16(p19, v26) / 65535 * 6.283185307179586 - 3.141592653589793;
    local _ = v26 + 2;
    return CFrame.new(v21, v23, v25) * CFrame.fromOrientation(0, v27, 0);
end;
local u33 = {
    networkOwner = l__Entity__4["设置网络主控玩家"],
    isHalfTicked = l___SetTickMode__8,
    _data = l__Entity__4.SetData,
    entityConfig = l__Entity__4.SetConfig,
    autoUpdatePos = l__Entity__4.SetAutoUpdatePos,
    mountParentId = function(p29, p30) --[[ Name: SetMountId, Line 84 ]]
        p29.mountParentId = p30;
    end,
    mountOffset = function(p31, p32) --[[ Name: SetMountOffset, Line 88 ]]
        p31.mountOffset = p32 or CFrame.identity;
    end,
    broadPhase = l__Entity__4.SetBroadPhase
};
local function u44(p34) --[[ Line: 103 ]]
    -- upvalues: l__Holder__5 (copy), u33 (copy), l__Entity__4 (copy), l__Warn__3 (copy), l__ModelHelper__6 (copy)
    local v35 = l__Holder__5.GetEntityFromId(p34.id);
    if v35 then
        local v36 = nil;
        local v37 = nil;
        for _, v38 in p34.data do
            local v39 = v38[1];
            local v40 = v38[2];
            local v41 = u33[v39];
            if v41 then
                v41(v35, v40);
            elseif v39 == "latestCFrame" then
                if v35.isContextOwner or not v35.networkOwner then
                    l__Entity__4.SetCFrame(v35, v40);
                end;
            elseif v39 == "_modelMetaData" then
                v37 = v40;
            elseif v39 == "model" then
                v36 = v40;
            elseif v39 == "_player" then
                if v40 then
                    l__Holder__5.SetAsCharacter(v40, v35);
                else
                    l__Holder__5.RemovePlayerCharacter(v35);
                end;
            elseif v39 == "paused" then
                if v40 then
                    l__Entity__4.PauseReplication(v35);
                else
                    l__Entity__4.ResumeReplication(v35);
                end;
            else
                l__Warn__3.high("Unhandled entity change key:", v39);
            end;
        end;
        if v36 ~= nil then
            local v42, v43 = l__ModelHelper__6.CreateModelFromData(v36);
            l__Entity__4.SetModel(v35, v42, v43);
            v35._modelMetaData = v37;
        end;
    end;
end;
local function u48(p45) --[[ Line: 150 ]]
    -- upvalues: l__ModelHelper__6 (copy), l__Entity__4 (copy), l___SetTickMode__8 (copy), l__Holder__5 (copy)
    local v46, _ = l__ModelHelper__6.CreateModelFromData(p45.model);
    local v47 = l__Entity__4._new(p45.config, v46, nil, p45.cframe);
    v47.id = p45.id;
    v47._player = p45._player;
    v47._modelMetaData = p45._modelMetaData;
    v47.paused = p45.paused or false;
    v47.isHalfTicked = p45.isHalfTicked;
    v47._data = p45._data;
    v47.mountParentId = p45.mountParentId;
    v47.mountOffset = p45.mountOffset or CFrame.identity;
    v47.broadPhase = p45.broadPhase or v47.broadPhase;
    l__Entity__4.Push(v47, p45.time, p45.cframe);
    l__Entity__4["设置网络主控玩家"](v47, p45.networkOwner);
    l___SetTickMode__8(v47, p45.isHalfTicked);
    l__Holder__5.RegisterEntity(v47);
end;
local function u56(p49, p50, p51, p52, p53) --[[ Line: 171 ]]
    -- upvalues: l__Holder__5 (copy), l__Warn__3 (copy), l___SetTickMode__8 (copy), l__Entity__4 (copy)
    local v54 = l__Holder__5.GetEntityFromId(p49);
    if not v54 then
        l__Warn__3.high("Received update for non existent entity with id", p49);
        return false;
    end;
    if p50 then
        local l___clientClock__11 = v54._clientClock;
        if l___clientClock__11 then
            if p53 then
                l___clientClock__11:SetTickRate(l___clientClock__11._baseTickRate * 2);
            else
                l___clientClock__11:SetTickRate(l___clientClock__11._baseTickRate);
            end;
            l___clientClock__11:OnSnapShot(p52);
        end;
    else
        local l__CLIENT_CLOCK__12 = v54.entityConfig.CLIENT_CLOCK;
        local v55 = l__CLIENT_CLOCK__12 and (p53 and l__CLIENT_CLOCK__12.HALF or l__CLIENT_CLOCK__12.NORMAL);
        if v55 then
            v55:OnSnapShot(p52);
        end;
    end;
    if v54.isHalfTicked ~= p53 then
        l___SetTickMode__8(v54, p53);
    end;
    v54.isHalfTicked = p53;
    l__Entity__4.Push(v54, p52, p51);
    return true;
end;
local function u72(p57) --[[ Line: 211 ]]
    -- upvalues: u1 (ref), u18 (copy), u28 (copy), l__Holder__5 (copy), l__Warn__3 (copy), l__Entity__4 (copy), u56 (copy)
    u1 = u1 + buffer.len(p57);
    local v58 = buffer.len(p57);
    local v59 = 0;
    while v59 < v58 do
        local v60 = buffer.readf32(p57, v59);
        local v61 = v59 + 4;
        local v62 = buffer.readu8(p57, v61);
        v59 = v61 + 1;
        for _ = 1, v62 do
            local v63 = buffer.readu16(p57, v59);
            local v64 = v59 + 2;
            local v65 = buffer.readu8(p57, v64);
            local v66 = v64 + 1;
            local v67 = bit32.band(v65, 1) == 1;
            local v68 = bit32.band(v65, 2) == 2;
            local v69 = bit32.band(v65, 4) == 4;
            local v70;
            if v67 then
                v70 = u18(p57, v66);
                v59 = v66 + 18;
            else
                v70 = u28(p57, v66);
                v59 = v66 + 14;
            end;
            if v69 then
                local v71 = l__Holder__5.GetEntityFromId(v63);
                if v71 then
                    l__Entity__4.SetCFrame(v71, v70);
                else
                    l__Warn__3.medium("Received teleport for non existent entity with id", v63);
                end;
            else
                u56(v63, true, v70, v60, v68);
            end;
        end;
    end;
end;
local function u85(p73) --[[ Line: 251 ]]
    -- upvalues: u1 (ref), u18 (copy), u28 (copy), u56 (copy)
    local v74 = buffer.len(p73);
    u1 = u1 + v74;
    local v75 = 0;
    while v75 < v74 do
        local v76 = buffer.readf32(p73, v75);
        local v77 = buffer.readu8(p73, v75 + 4);
        local v78 = bit32.band(v77, 1) == 1;
        local v79 = bit32.band(v77, 2) == 2;
        local v80 = v75 + 5;
        local v81 = buffer.readu8(p73, v80);
        v75 = v80 + 1;
        for _ = 1, v81 do
            local v82 = buffer.readu16(p73, v75);
            local v83 = v75 + 2;
            local v84;
            if v79 then
                v84 = u18(p73, v83);
                v75 = v83 + 18;
            else
                v84 = u28(p73, v83);
                v75 = v83 + 14;
            end;
            u56(v82, false, v84, v76, v78);
        end;
    end;
end;
local function v93(p86, p87, p88) --[[ Line: 286 ]]
    -- upvalues: l__Holder__5 (copy), l__Entity__4 (copy), l__Warn__3 (copy), u3 (ref), u48 (copy), u2 (ref), u44 (copy), u4 (ref)
    if p87 then
        for _, v89 in p87 do
            local v90 = l__Holder__5.GetEntityFromId(v89);
            if v90 then
                l__Entity__4.Destroy(v90);
            else
                l__Warn__3.high("Tried to remove non existent entity with id", v89);
            end;
        end;
        u3 = u3 + #p87;
    end;
    if p86 then
        for _, v91 in p86 do
            u48(v91);
        end;
        u2 = u2 + #p86;
    end;
    if p88 then
        for _, v92 in p88 do
            u44(v92);
        end;
        u4 = u4 + #p88;
    end;
end;
l__Replicate__9.OnClientEvent:Connect(function(p94, p95) --[[ Name: HandleUnreliable, Line 276 ]]
    -- upvalues: u85 (copy), u72 (copy), l__Warn__3 (copy)
    if p94 == "X" then
        u85(p95);
    elseif p94 == "O" then
        u72(p95);
    else
        l__Warn__3.high("Unknown unreliable replicate id", p94);
    end;
end;
l__ReplicateFull__10.OnClientEvent:Connect(v93);
local u96 = 0;
l__RunService__1.Heartbeat:Connect(function() --[[ Line: 314 ]]
    -- upvalues: u96 (ref), l__CLIENT__7 (copy), u1 (ref), u2 (ref), u4 (ref), u3 (ref)
    if os.clock() - u96 > 1 then
        if not l__CLIENT__7._PAUSE then
            l__CLIENT__7.BYTES_RECEIVED_PER_SEC = u1;
            l__CLIENT__7.NEW_ENTITIES_PER_SEC = u2;
            l__CLIENT__7.ENTITY_CHANGES_PER_SEC = u4;
            l__CLIENT__7.ENTITY_REMOVALS_PER_SEC = u3;
        end;
        u2 = 0;
        u3 = 0;
        u4 = 0;
        u1 = 0;
        u96 = os.clock();
    end;
end;
return nil;
