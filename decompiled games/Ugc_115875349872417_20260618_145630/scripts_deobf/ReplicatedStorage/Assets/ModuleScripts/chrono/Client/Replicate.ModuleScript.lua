-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.chrono.Client.Replicate
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local l__Shared__1 = script.Parent.Parent.Shared;
game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__Warn__3 = require(l__Shared__1.Warn);
local l__Stats__4 = require(script.Parent.Parent.Shared.Stats);
local l__ApplyMounts__5 = require(script.Parent.Parent.Shared.ApplyMounts);
local l__ClientClock__6 = require(script.Parent.ClientClock);
local l__ModelResolver__7 = require(script.Parent.ModelResolver);
local l__Entity__8 = require(l__Shared__1.Entity);
local l__Holder__9 = require(l__Shared__1.Holder);
local l__Config__10 = require(l__Shared__1.Config);
require(l__Shared__1.Types);
local l__Sender__11 = require(script.Parent.Sender);
require(script.Parent.Receiver);
local l__CLIENT__12 = require(l__Shared__1.Stats).CLIENT;
require(script.Parent.Player);
require(script.Parent.Receiver);
local l__idMap__13 = l__Holder__9.idMap;
local u1 = Vector3.new(0, 0, -1);
local u2 = Vector3.new(1, 0, 0);
local u3 = Vector3.new(0, 1, 0);
local u4 = Vector3.new(0, 0, 0);
local u5 = 0;
local u6 = 0;
local function u77(p7, p8) --[[ Line: 77 ]]
    -- upvalues: u4 (ref), u1 (ref), u2 (ref), u5 (ref), u3 (ref), u6 (ref)
    if p8 == Vector3.new(0, 0, 0) then
        local v9 = p7 - u4;
        local v10 = vector.magnitude(v9);
        if v10 == 0 then
            return true;
        end;
        local v11 = vector.dot(v9, u1);
        local v12 = v11 / v10;
        if v12 < 0 then
            return false;
        end;
        if v11 < 1 then
            return true;
        end;
        local v13 = v9 / v10;
        local v14 = vector.dot(v13, u2);
        if math.abs(v14) > v12 * u5 then
            return false;
        end;
        local v15 = vector.dot(v13, u3);
        return math.abs(v15) <= v12 * u6;
    else
        local v16 = p8 * 0.5;
        local l__x__14 = v16.x;
        local l__y__15 = v16.y;
        local l__z__16 = v16.z;
        local v17 = -l__x__14;
        local v18 = -l__y__15;
        local v19 = -l__z__16;
        local v20 = p7 + vector.create(l__x__14, l__y__15, l__z__16) - u4;
        local v21 = vector.magnitude(v20);
        local v22;
        if v21 == 0 then
            v22 = true;
        else
            local v23 = vector.dot(v20, u1);
            local v24 = v23 / v21;
            if v24 < 0 then
                v22 = false;
            elseif v23 < 1 then
                v22 = true;
            else
                local v25 = v20 / v21;
                local v26 = vector.dot(v25, u2);
                if math.abs(v26) > v24 * u5 then
                    v22 = false;
                else
                    local v27 = vector.dot(v25, u3);
                    v22 = math.abs(v27) <= v24 * u6;
                end;
            end;
        end;
        if not v22 then
            local v28 = p7 + vector.create(v17, l__y__15, l__z__16) - u4;
            local v29 = vector.magnitude(v28);
            if v29 == 0 then
                v22 = true;
            else
                local v30 = vector.dot(v28, u1);
                local v31 = v30 / v29;
                if v31 < 0 then
                    v22 = false;
                elseif v30 < 1 then
                    v22 = true;
                else
                    local v32 = v28 / v29;
                    local v33 = vector.dot(v32, u2);
                    if math.abs(v33) > v31 * u5 then
                        v22 = false;
                    else
                        local v34 = vector.dot(v32, u3);
                        v22 = math.abs(v34) <= v31 * u6;
                    end;
                end;
            end;
            if not v22 then
                local v35 = p7 + vector.create(l__x__14, v18, l__z__16) - u4;
                local v36 = vector.magnitude(v35);
                if v36 == 0 then
                    v22 = true;
                else
                    local v37 = vector.dot(v35, u1);
                    local v38 = v37 / v36;
                    if v38 < 0 then
                        v22 = false;
                    elseif v37 < 1 then
                        v22 = true;
                    else
                        local v39 = v35 / v36;
                        local v40 = vector.dot(v39, u2);
                        if math.abs(v40) > v38 * u5 then
                            v22 = false;
                        else
                            local v41 = vector.dot(v39, u3);
                            v22 = math.abs(v41) <= v38 * u6;
                        end;
                    end;
                end;
                if not v22 then
                    local v42 = p7 + vector.create(v17, v18, l__z__16) - u4;
                    local v43 = vector.magnitude(v42);
                    if v43 == 0 then
                        v22 = true;
                    else
                        local v44 = vector.dot(v42, u1);
                        local v45 = v44 / v43;
                        if v45 < 0 then
                            v22 = false;
                        elseif v44 < 1 then
                            v22 = true;
                        else
                            local v46 = v42 / v43;
                            local v47 = vector.dot(v46, u2);
                            if math.abs(v47) > v45 * u5 then
                                v22 = false;
                            else
                                local v48 = vector.dot(v46, u3);
                                v22 = math.abs(v48) <= v45 * u6;
                            end;
                        end;
                    end;
                    if not v22 then
                        local v49 = p7 + vector.create(l__x__14, l__y__15, v19) - u4;
                        local v50 = vector.magnitude(v49);
                        if v50 == 0 then
                            v22 = true;
                        else
                            local v51 = vector.dot(v49, u1);
                            local v52 = v51 / v50;
                            if v52 < 0 then
                                v22 = false;
                            elseif v51 < 1 then
                                v22 = true;
                            else
                                local v53 = v49 / v50;
                                local v54 = vector.dot(v53, u2);
                                if math.abs(v54) > v52 * u5 then
                                    v22 = false;
                                else
                                    local v55 = vector.dot(v53, u3);
                                    v22 = math.abs(v55) <= v52 * u6;
                                end;
                            end;
                        end;
                        if not v22 then
                            local v56 = p7 + vector.create(v17, l__y__15, v19) - u4;
                            local v57 = vector.magnitude(v56);
                            if v57 == 0 then
                                v22 = true;
                            else
                                local v58 = vector.dot(v56, u1);
                                local v59 = v58 / v57;
                                if v59 < 0 then
                                    v22 = false;
                                elseif v58 < 1 then
                                    v22 = true;
                                else
                                    local v60 = v56 / v57;
                                    local v61 = vector.dot(v60, u2);
                                    if math.abs(v61) > v59 * u5 then
                                        v22 = false;
                                    else
                                        local v62 = vector.dot(v60, u3);
                                        v22 = math.abs(v62) <= v59 * u6;
                                    end;
                                end;
                            end;
                            if not v22 then
                                local v63 = p7 + vector.create(l__x__14, v18, v19) - u4;
                                local v64 = vector.magnitude(v63);
                                if v64 == 0 then
                                    v22 = true;
                                else
                                    local v65 = vector.dot(v63, u1);
                                    local v66 = v65 / v64;
                                    if v66 < 0 then
                                        v22 = false;
                                    elseif v65 < 1 then
                                        v22 = true;
                                    else
                                        local v67 = v63 / v64;
                                        local v68 = vector.dot(v67, u2);
                                        if math.abs(v68) > v66 * u5 then
                                            v22 = false;
                                        else
                                            local v69 = vector.dot(v67, u3);
                                            v22 = math.abs(v69) <= v66 * u6;
                                        end;
                                    end;
                                end;
                                if not v22 then
                                    local v70 = p7 + vector.create(v17, v18, v19) - u4;
                                    local v71 = vector.magnitude(v70);
                                    if v71 == 0 then
                                        return true;
                                    end;
                                    local v72 = vector.dot(v70, u1);
                                    local v73 = v72 / v71;
                                    if v73 < 0 then
                                        return false;
                                    end;
                                    if v72 < 1 then
                                        return true;
                                    end;
                                    local v74 = v70 / v71;
                                    local v75 = vector.dot(v74, u2);
                                    if math.abs(v75) > v73 * u5 then
                                        return false;
                                    end;
                                    local v76 = vector.dot(v74, u3);
                                    if math.abs(v76) > v73 * u6 then
                                        return false;
                                    end;
                                    v22 = true;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
        return v22;
    end;
end;
local u78 = 0;
local u79 = 0;
local u80 = 0;
local u81 = 0;
local u82 = 0;
local u83 = 0;
local u84 = 0;
local function u90(p85) --[[ Line: 108 ]]
    -- upvalues: l__Entity__8 (copy), u79 (ref), l__Warn__3 (copy), u82 (ref), u77 (copy), u83 (ref), u78 (ref), u84 (ref)
    if p85.interpolation and not p85.entityConfig.CUSTOM_INTERPOLATION then
        local v86 = l__Entity__8.GetPrimaryPart(p85);
        if v86 then
            if p85.isContextOwner then
            else
                local l___outofBroadPhaseTick__17 = p85._outofBroadPhaseTick;
                if l___outofBroadPhaseTick__17 and l___outofBroadPhaseTick__17 ~= u79 then
                else
                    local l__snapshot__18 = p85.snapshot;
                    if l__snapshot__18 then
                        u82 = u82 + 1;
                        debug.profilebegin("Get Render CFrame");
                        local v87 = l__snapshot__18:GetAt((l__Entity__8.GetTargetRenderTime(p85)));
                        debug.profileend();
                        if v87 then
                            local l__broadPhase__19 = p85.broadPhase;
                            if l__broadPhase__19 then
                                local l__lastCheckedCFrame__20 = p85.lastCheckedCFrame;
                                debug.profilebegin("Prepare Frustum");
                                local v88 = u77(v87.Position, l__broadPhase__19);
                                debug.profileend();
                                if not v88 then
                                    if not l__lastCheckedCFrame__20 or l__lastCheckedCFrame__20.Position == v87.Position then
                                        if not l__lastCheckedCFrame__20 then
                                            p85.lastCheckedCFrame = v87;
                                        end;
                                        if not p85._outofBroadPhaseTick then
                                            p85._outofBroadPhaseTick = u78;
                                            u78 = u78 + 1;
                                            if u78 % 4 == 0 then
                                                u78 = 0;
                                            end;
                                        end;
                                        u83 = u83 + 1;
                                        return;
                                    end;
                                    debug.profilebegin("Check Last CFrame");
                                    local v89 = u77(l__lastCheckedCFrame__20.Position, l__broadPhase__19);
                                    debug.profileend();
                                    if not v89 then
                                        u83 = u83 + 1;
                                        return;
                                    end;
                                end;
                                p85.lastCheckedCFrame = nil;
                                p85._outofBroadPhaseTick = nil;
                            end;
                            debug.profilebegin("Set CFrame");
                            if v87 == v87 then
                                v86.CFrame = v87;
                            end;
                            u84 = u84 + 1;
                            debug.profileend();
                        end;
                    else
                        l__Warn__3.medium("No snapshot for entity", p85);
                    end;
                end;
            end;
        end;
    end;
end;
local function u106() --[[ Line: 182 ]]
    -- upvalues: l__Stats__4 (copy), l__CLIENT__12 (copy), l__idMap__13 (copy), l__ClientClock__6 (copy), l__Entity__8 (copy)
    if l__Stats__4.SERVER._SHOULD_REPLICATE and not l__CLIENT__12._PAUSE then
        local v91 = {};
        for _, v92 in l__idMap__13 do
            local l__id__21 = v92.id;
            local l__entityConfig__22 = v92.entityConfig;
            local v93 = l__entityConfig__22 and l__entityConfig__22.NAME or "DEFAULT";
            local l__networkOwner__23 = v92.networkOwner;
            local v94 = v92._player ~= nil;
            local v95 = v92.latestTime or 0;
            local v96 = v92.lastReplicatedTime or 0;
            local l___clientClock__24 = v92._clientClock;
            if not l___clientClock__24 then
                local l__CLIENT_CLOCK__25 = v92.entityConfig.CLIENT_CLOCK;
                if l__CLIENT_CLOCK__25 then
                    l___clientClock__24 = v92.isHalfTicked and l__CLIENT_CLOCK__25.HALF or l__CLIENT_CLOCK__25.NORMAL;
                end;
            end;
            local v97 = 0;
            local v98 = 0;
            local v99 = 0;
            local v100;
            if l___clientClock__24 then
                v100 = l___clientClock__24:GetTargetRenderTime();
                local l__buffer__26 = l___clientClock__24.buffer;
                if l__buffer__26 then
                    v97 = l__buffer__26.averageLatency;
                    v98 = l__buffer__26.deviation;
                    v99 = l__ClientClock__6._getBuffer(l___clientClock__24);
                end;
            else
                v100 = 0;
            end;
            local v101 = l__Entity__8.GetPrimaryPart(v92);
            local l__snapshot__27 = v92.snapshot;
            if v101 then
                v101 = v101.Position;
            end;
            local v102 = {};
            if l__snapshot__27 then
                for _, v103 in l__snapshot__27.cache do
                    table.insert(v102, {
                        t = v103.t,
                        value = v103.value,
                        velocity = v103.velocity
                    });
                end;
                table.sort(v102, function(p104, p105) --[[ Line: 227 ]]
                    return p104.t > p105.t;
                end;
            end;
            table.insert(v91, {
                id = l__id__21,
                networkOwner = l__networkOwner__23,
                isCharacter = v94,
                config = v93,
                lastReceivedTime = v95,
                lastReplicatedTime = v96,
                targetTime = v100,
                averageLatency = v97,
                deviation = v98,
                bufferedTime = v99,
                currentPosition = v101,
                snapshots = v102
            });
        end;
        l__CLIENT__12.CLIENT_ENTITIES = v91;
    end;
end;
l__Config__10._WaitForLock(function() --[[ Line: 249 ]]
    -- upvalues: l__RunService__2 (copy), u79 (ref), l__CLIENT__12 (copy), u83 (ref), l__ClientClock__6 (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), l__idMap__13 (copy), l__ModelResolver__7 (copy), u90 (copy), u106 (copy), u80 (ref), u81 (ref), l__ApplyMounts__5 (copy), u84 (ref), u82 (ref), l__Sender__11 (copy), l__Shared__1 (copy)
    l__RunService__2.Heartbeat:Connect(function(p107) --[[ Line: 250 ]]
        -- upvalues: u79 (ref), l__CLIENT__12 (ref), u83 (ref), l__ClientClock__6 (ref), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), l__idMap__13 (ref), l__ModelResolver__7 (ref), u90 (ref), u106 (ref), u80 (ref), u81 (ref), l__ApplyMounts__5 (ref), u84 (ref), u82 (ref)
        u79 = u79 + 1;
        if u79 % 4 == 0 then
            l__CLIENT__12.TOTAL_ENTITIES_CULLED = u83;
            u83 = 0;
            u79 = 0;
        end;
        l__ClientClock__6.UpdateAll(p107);
        debug.profilebegin("Prepare Frustum Check");
        local l__CFrame__28 = workspace.CurrentCamera.CFrame;
        u1 = l__CFrame__28.LookVector;
        u2 = l__CFrame__28.RightVector;
        u3 = l__CFrame__28.UpVector;
        u4 = l__CFrame__28.Position;
        local l__CurrentCamera__29 = workspace.CurrentCamera;
        local v108 = math.rad(l__CurrentCamera__29.FieldOfView / 2);
        local v109 = l__CurrentCamera__29.ViewportSize.X / l__CurrentCamera__29.ViewportSize.Y;
        u5 = math.tan(v108) * v109;
        u6 = math.tan(v108);
        debug.profileend();
        local v110 = os.clock();
        debug.profilebegin("Interpolate Entities");
        local v111 = 0;
        for _, v112 in l__idMap__13 do
            l__ModelResolver__7(v112);
            if not (v112.destroyed or (v112.paused or v112.mountParentId)) then
                v111 = v111 + 1;
                u90(v112);
            end;
        end;
        debug.profileend();
        local v113 = os.clock();
        debug.profilebegin("Update Entity Stats");
        u106();
        debug.profileend();
        u80 = u80 + (v113 - v110);
        u81 = u81 + 1;
        debug.profilebegin("Apply Mounts");
        l__ApplyMounts__5();
        debug.profileend();
        if not l__CLIENT__12._PAUSE then
            l__CLIENT__12.TOTAL_CLIENT_ENTITIES_CHECKED_THIS_FRAME = v111;
            l__CLIENT__12.ENTITIES_MOVED_THIS_FRAME = u84;
            l__CLIENT__12.TOTAL_CLIENT_ENTITIES = v111;
            l__CLIENT__12.AVG_INTERPOLATION_TIME_MS = u80 / u81 * 1000;
        end;
        u84 = 0;
        u82 = 0;
        if u81 > 60 then
            u80 = 0;
            u81 = 0;
        end;
    end;
    l__RunService__2.Heartbeat:Connect(l__Sender__11.Update);
    l__Shared__1.Remotes.ClientLoaded:FireServer();
end;
return nil;
