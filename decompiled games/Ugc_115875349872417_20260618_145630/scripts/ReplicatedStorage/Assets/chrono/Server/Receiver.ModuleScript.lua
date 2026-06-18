-- Decompiled from: ReplicatedStorage.Assets.chrono.Server.Receiver
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local v1 = {};
local u2 = {};
local u3 = {};
local l__Shared__3 = script.Parent.Parent.Shared;
local l__Warn__4 = require(l__Shared__3.Warn);
local l__ServerClock__5 = require(script.Parent.ServerClock);
require(l__Shared__3.Types);
local l__Holder__6 = require(l__Shared__3.Holder);
local l__Entity__7 = require(l__Shared__3.Entity);
local l__Config__8 = require(l__Shared__3.Config);
local l__SERVER__9 = require(l__Shared__3.Stats).SERVER;
local u4 = 3000;
local u5 = 0;
local l__Replicate__10 = l__Shared__3.Remotes.Replicate;
local u6 = {};
local function u12(p7, p8, p9, p10) --[[ Line: 30 ]]
    -- upvalues: u3 (ref)
    if #u3 == 0 then
        return false;
    end;
    debug.profilebegin("FireMiddleMans");
    for _, v11 in u3 do
        if v11.func(p7, p8, p9, p10) then
            debug.profileend();
            return true;
        end;
    end;
    debug.profileend();
    return false;
end;
local function u26(p13, p14) --[[ Line: 48 ]]
    local v15 = buffer.readf32(p13, p14);
    local v16 = p14 + 4;
    local v17 = buffer.readf32(p13, v16);
    local v18 = v16 + 4;
    local v19 = buffer.readf32(p13, v18);
    local v20 = v18 + 4;
    local v21 = buffer.readu16(p13, v20) / 65535 * 6.283185307179586 - 3.141592653589793;
    local v22 = v20 + 2;
    local v23 = buffer.readu16(p13, v22) / 65535 * 6.283185307179586 - 3.141592653589793;
    local v24 = v22 + 2;
    local v25 = buffer.readu16(p13, v24) / 65535 * 6.283185307179586 - 3.141592653589793;
    local _ = v24 + 2;
    return CFrame.new(v15, v17, v19) * CFrame.fromOrientation(v21, v23, v25);
end;
local function u36(p27, p28) --[[ Line: 64 ]]
    local v29 = buffer.readf32(p27, p28);
    local v30 = p28 + 4;
    local v31 = buffer.readf32(p27, v30);
    local v32 = v30 + 4;
    local v33 = buffer.readf32(p27, v32);
    local v34 = v32 + 4;
    local v35 = buffer.readu16(p27, v34) / 65535 * 6.283185307179586 - 3.141592653589793;
    local _ = v34 + 2;
    return CFrame.new(v29, v31, v33) * CFrame.fromOrientation(0, v35, 0);
end;
local function u45(p37, p38) --[[ Line: 87 ]]
    if p38 + 15 > buffer.len(p37) then
        return nil, buffer.len(p37);
    end;
    if buffer.readu8(p37, p38 + 2) ~= 1 then
        return nil, buffer.len(p37);
    end;
    local v39 = p38 + 3;
    local v40 = buffer.readf32(p37, v39);
    local v41 = buffer.readf32(p37, v39 + 4);
    local v42 = buffer.readf32(p37, v39 + 8);
    local v43 = Vector3.new(v40, v41, v42);
    local v44;
    if v43 then
        local l__Magnitude__11 = v43.Magnitude;
        if l__Magnitude__11 == l__Magnitude__11 and l__Magnitude__11 > 0 then
            v44 = v43 / l__Magnitude__11;
        else
            v44 = nil;
        end;
    else
        v44 = nil;
    end;
    return v44, p38 + 15;
end;
local function u56(p46, p47, p48, p49, p50, p51, p52) --[[ Line: 127 ]]
    -- upvalues: l__Holder__6 (copy), u12 (copy), l__Entity__7 (copy), l__RunService__2 (copy)
    local u53 = l__Holder__6.GetEntityFromId(p47);
    if u53 and u53.networkOwner == p46 then
        if p52 then
            local l___teleport__12 = u53._teleport;
            if l___teleport__12 and os.clock() - l___teleport__12 < 0.5 then
                u53._teleport = nil;
            else
                local v54 = buffer.readu8(p51, 2);
                local v55 = bit32.band(v54, 4294967291);
                buffer.writeu8(p51, 2, v55);
            end;
        end;
        if u12(p46, u53, p50, p48) then
        else
            if l__Entity__7.Push(u53, p48, p50) then
                task.spawn(function() --[[ Line: 155 ]]
                    -- upvalues: l__RunService__2 (ref), u53 (copy)
                    l__RunService__2.PreAnimation:Wait();
                    u53.arriveFrame = time();
                end;
                u53.lastClientClock = p49;
                u53.cframeBuffer = p51;
                if u53.modelReplicationMode == "NATIVE" and not u53._lockedCFReplication then
                    return;
                end;
                l__Entity__7._SetPartCFrame(u53, p50);
            end;
        end;
    end;
end;
local u57 = {};
local function v75(p58, p59) --[[ Line: 170 ]]
    -- upvalues: u57 (copy), u5 (ref), u4 (ref), l__Warn__4 (copy), l__ServerClock__5 (copy), u45 (copy), u6 (copy), u26 (copy), u36 (copy), u56 (copy)
    if p59 then
        u57[p58] = (u57[p58] or 0) + buffer.len(p59);
        u5 = u5 + buffer.len(p59);
        if u4 < u57[p58] then
            l__Warn__4.medium("Player", p58.Name, "exceeded max bytes per frame:", u57[p58], "max:", u4);
        else
            debug.profilebegin("Receiver.OnReceive");
            local v60 = 0;
            local v61 = buffer.readf32(p59, v60);
            local v62 = v60 + 4;
            local v63 = os.clock();
            local v64 = buffer.len(p59);
            l__ServerClock__5.Store(p58, v61);
            while v62 < v64 do
                local v65;
                if buffer.readu16(p59, v62) == 0 then
                    local v66;
                    v66, v65 = u45(p59, v62);
                    if v66 then
                        u6[p58] = v66;
                    end;
                else
                    local v67 = buffer.readu16(p59, v62);
                    local v68 = v62 + 2;
                    local v69 = buffer.readu8(p59, v68);
                    local v70 = v68 + 1;
                    local v71 = bit32.band(v69, 1) == 1;
                    local v72 = bit32.band(v69, 4) == 4;
                    local v73;
                    if v71 then
                        v73 = u26(p59, v70);
                        v65 = v70 + 18;
                    else
                        v73 = u36(p59, v70);
                        v65 = v70 + 14;
                    end;
                    local v74 = buffer.create(v65 - v62);
                    buffer.copy(v74, 0, p59, v62, v65 - v62);
                    u56(p58, v67, v63, v61, v73, v74, v72);
                end;
                v62 = v65;
            end;
            debug.profileend();
        end;
    end;
end;
function v1.RegisterMiddleMan(p76, p77, p78) --[[ Line: 223 ]]
    -- upvalues: u2 (copy), u3 (ref)
    u2[p76] = {
        priority = p77,
        func = p78
    };
    u3 = {};
    for _, v79 in u2 do
        table.insert(u3, v79);
    end;
    table.sort(u3, function(p80, p81) --[[ Line: 238 ]]
        return p80.priority > p81.priority;
    end;
end;
function v1.UnregisterMiddleMan(p82) --[[ Line: 247 ]]
    -- upvalues: u2 (copy), u3 (ref)
    u2[p82] = nil;
    u3 = {};
    for _, v83 in u2 do
        table.insert(u3, v83);
    end;
    table.sort(u3, function(p84, p85) --[[ Line: 253 ]]
        return p84.priority > p85.priority;
    end;
end;
function v1.ShouldBlockEntityCFrame(p86, p87, p88, p89) --[[ Line: 258 ]]
    -- upvalues: u12 (copy)
    return u12(p86, p87, p88, p89);
end;
if l__RunService__2:IsServer() then
    local u90 = 0;
    l__RunService__2.Heartbeat:Connect(function(_) --[[ Line: 264 ]]
        -- upvalues: u57 (copy), u90 (ref), l__SERVER__9 (copy), u5 (ref)
        table.clear(u57);
        if os.clock() - u90 > 1 then
            l__SERVER__9.BYTES_RECEIVED_PER_SEC = u5;
            u5 = 0;
            u90 = os.clock();
        end;
    end;
    l__Replicate__10.OnServerEvent:Connect(v75);
    l__Players__1.PlayerRemoving:Connect(function(p91) --[[ Line: 274 ]]
        -- upvalues: u6 (copy)
        u6[p91] = nil;
    end;
end;
l__Config__8._WaitForLock(function() --[[ Line: 279 ]]
    -- upvalues: u4 (ref), l__Config__8 (copy)
    u4 = l__Config__8._GetConfig("MAX_TOTAL_BYTES_PER_FRAME_PER_PLAYER");
end;
function v1.GetCameraLookVector(p92) --[[ Line: 283 ]]
    -- upvalues: u6 (copy), l__Holder__6 (copy), l__Entity__7 (copy)
    local v93 = u6[p92];
    local v94;
    if v93 then
        local l__Magnitude__13 = v93.Magnitude;
        if l__Magnitude__13 == l__Magnitude__13 and l__Magnitude__13 > 0 then
            v94 = v93 / l__Magnitude__13;
        else
            v94 = nil;
        end;
    else
        v94 = nil;
    end;
    if v94 then
        return v94;
    end;
    local v95 = l__Holder__6.GetEntityFromPlayer(p92);
    local v96 = v95 and l__Entity__7.GetCFrame(v95);
    if v96 then
        local l__LookVector__14 = v96.LookVector;
        local v97;
        if l__LookVector__14 then
            local l__Magnitude__15 = l__LookVector__14.Magnitude;
            if l__Magnitude__15 == l__Magnitude__15 and l__Magnitude__15 > 0 then
                v97 = l__LookVector__14 / l__Magnitude__15;
            else
                v97 = nil;
            end;
        else
            v97 = nil;
        end;
        if v97 then
            return v97;
        end;
    end;
    local l__Character__16 = p92.Character;
    if l__Character__16 then
        l__Character__16 = l__Character__16:FindFirstChild("HumanoidRootPart");
    end;
    if l__Character__16 and l__Character__16:IsA("BasePart") then
        local l__LookVector__17 = l__Character__16.CFrame.LookVector;
        local v98;
        if l__LookVector__17 then
            local l__Magnitude__18 = l__LookVector__17.Magnitude;
            if l__Magnitude__18 == l__Magnitude__18 and l__Magnitude__18 > 0 then
                v98 = l__LookVector__17 / l__Magnitude__18;
            else
                v98 = nil;
            end;
        else
            v98 = nil;
        end;
        if v98 then
            return v98;
        end;
    end;
    return Vector3.new(0, 0, -1);
end;
return v1;
