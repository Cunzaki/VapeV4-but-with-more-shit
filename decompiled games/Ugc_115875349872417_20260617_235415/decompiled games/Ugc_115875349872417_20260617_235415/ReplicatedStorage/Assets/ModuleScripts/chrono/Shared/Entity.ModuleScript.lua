-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.chrono.Shared.Entity
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local u1 = {};
local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
require(script.Parent.Types);
local l__Config__3 = require(script.Parent.Config);
local l__Snapshots__4 = require(script.Parent.Snapshots);
local l__InterpolationMath__5 = require(script.Parent.InterpolationMath);
local l__ClientClock__6 = require(script.Parent.Parent.Client.ClientClock);
local l__Holder__7 = require(script.Parent.Holder);
local l__Signal__8 = require(script.Parent.Signal);
local l__Events__9 = require(script.Parent.Events);
local l__ModelHelper__10 = require(script.Parent.ModelHelper);
local l__Warn__11 = require(script.Parent.Warn);
local l__VelocityAt__12 = l__InterpolationMath__5.VelocityAt;
local u2 = {};
local l___clientOwned__13 = l__Holder__7._clientOwned;
local u3 = l__RunService__2:IsServer();
local u4;
if u3 then
    u4 = nil;
else
    u4 = l__Players__1.LocalPlayer;
end;
local v5 = Instance.new("Part");
v5.Size = Vector3.new(0.1, 0.1, 0.1);
v5.Name = "__CHRONO_CENTER";
v5.Anchored = true;
v5.Transparency = 1;
v5.CanCollide = false;
v5.CanTouch = false;
v5.CanQuery = false;
local function u12(p6) --[[ Line: 50 ]]
    if p6 then
        local l__CFrame__14 = p6.CFrame;
        local u7 = p6:FindFirstChild("__CHRONO_LOCKER");
        if u7 then
            local v8 = u7:FindFirstChild("__CHRONO_WELD");
            if v8 then
                v8.Part1 = p6;
                p6.CFrame = l__CFrame__14;
                return;
            end;
            if u7 then
                pcall(function() --[[ Line: 38 ]]
                    -- upvalues: u7 (copy)
                    u7:Destroy();
                end);
            end;
        end;
        local v9 = Instance.new("Camera", p6);
        v9.Name = "__CHRONO_LOCKER";
        local v10 = Instance.new("Weld", v9);
        v10.Name = "__CHRONO_WELD";
        local v11 = Instance.new("Part", v9);
        v11.Name = "__CHRONO_LOCKER_PART";
        v11.CanCollide = false;
        v11.CanQuery = false;
        v11.CanTouch = false;
        v11.Color = Color3.new(1, 0, 0);
        v11.Anchored = true;
        v10.Part0 = v11;
        v10.Part1 = p6;
        p6.CFrame = l__CFrame__14;
    end;
end;
local function u18(p13, p14) --[[ Line: 82 ]]
    -- upvalues: u1 (copy), u3 (copy)
    local v15 = u1.GetPrimaryPart(p13);
    if v15 then
        if u3 and p13._lockedCFReplication then
            local v16 = v15:FindFirstChild("__CHRONO_LOCKER");
            if v16 then
                local v17 = v16:FindFirstChild("__CHRONO_LOCKER_PART");
                if v17 and v17:IsA("BasePart") then
                    v17.CFrame = p14;
                end;
            end;
        else
            v15.CFrame = p14;
        end;
    end;
end;
local function u21(p19) --[[ Line: 121 ]]
    -- upvalues: l__Warn__11 (copy)
    local l__model__15 = p19.model;
    if not l__model__15 then
        return nil;
    end;
    if l__model__15:IsA("BasePart") then
        return l__model__15;
    end;
    if l__model__15:IsA("Model") then
        local l___chronoPrimary__16 = p19._chronoPrimary;
        if l___chronoPrimary__16 then
            local v20 = l__model__15:FindFirstChild(l___chronoPrimary__16);
            if v20 and v20:IsA("BasePart") then
                return v20;
            end;
            l__Warn__11.low((`Chrono primary part {l___chronoPrimary__16} not found or not a BasePart in model {l__model__15:GetFullName()} for entity id {p19.id}. Falling back to default PrimaryPart.`));
        end;
        local l__PrimaryPart__17 = l__model__15.PrimaryPart;
        if l__PrimaryPart__17 then
            return l__PrimaryPart__17;
        end;
    end;
    return nil;
end;
local function v27(p22, p23, p24, p25, p26) --[[ Line: 149 ]]
    -- upvalues: u3 (copy), u2 (copy)
    if p25 or p22[p23] ~= p24 then
        p22[p23] = p24;
        if u3 then
            if not u2[p22] then
                u2[p22] = {};
            end;
            u2[p22][p23] = p26 or (p24 or false);
        end;
    end;
end;
local function u31(p28, p29, ...) --[[ Line: 163 ]]
    local l___events__18 = p28._events;
    if l___events__18 then
        local v30 = l___events__18[p29];
        if v30 then
            v30:Fire(p28, ...);
        end;
    end;
end;
local function u40(p32, p33) --[[ Line: 174 ]]
    -- upvalues: u4 (copy), u3 (copy), u21 (copy), u12 (copy), l__Snapshots__4 (copy), l__InterpolationMath__5 (copy), l__ClientClock__6 (copy), u31 (copy), l___clientOwned__13 (copy), l__Events__9 (copy)
    p32.isContextOwner = p32.networkOwner == u4;
    local v34 = p32.networkOwner == p33;
    if not v34 then
        p32.latestTime = 0;
        p32.lastClientClock = 0;
    end;
    if u3 then
        local u35 = u21(p32);
        if u35 then
            local l___lockedCFReplication__19 = p32._lockedCFReplication;
            local u36 = l___lockedCFReplication__19 and u35 and u35:FindFirstChild("__CHRONO_LOCKER");
            if u36 then
                local v37 = u36:FindFirstChild("__CHRONO_WELD");
                if v37 then
                    v37.Part1 = nil;
                elseif u36 then
                    pcall(function() --[[ Line: 38 ]]
                        -- upvalues: u36 (copy)
                        u36:Destroy();
                    end);
                end;
            end;
            local l__networkOwner__20 = p32.networkOwner;
            pcall(function() --[[ Line: 45 ]]
                -- upvalues: u35 (copy), l__networkOwner__20 (copy)
                u35:SetNetworkOwner(l__networkOwner__20);
            end);
            if l___lockedCFReplication__19 then
                u12(u35);
            end;
        end;
        if p32.isContextOwner and not p32.entityConfig.STORE_SNAPSHOTS then
            p32.snapshot = nil;
        else
            p32.snapshot = l__Snapshots__4(l__InterpolationMath__5.Hermite);
        end;
    elseif not v34 then
        if p32._clientClock then
            p32._clientClock:Destroy();
            p32._clientClock = nil;
        end;
        if p32.networkOwner then
            p32._clientClock = l__ClientClock__6.new(p32.entityConfig.TICK_RATE, (`Entity id: {p32.id} plr: {p32.networkOwner.Name}`));
        end;
    end;
    if v34 then
    else
        if p32.snapshot then
            p32.snapshot:Clear();
        end;
        u31(p32, "NetworkOwnerChanged", p32.networkOwner, p33);
        local v38 = p33 and l___clientOwned__13[p33];
        if v38 then
            v38[p32] = nil;
            l__Events__9._Signals.PlayerOwnedRemoved:Fire(p33, p32);
        end;
        if p32.networkOwner then
            local v39 = l___clientOwned__13[p32.networkOwner];
            if not v39 then
                return;
            end;
            v39[p32] = true;
            l__Events__9._Signals.PlayerOwnedAdded:Fire(p32.networkOwner, p32);
        end;
    end;
end;
local function u44(p41, p42) --[[ Line: 239 ]]
    -- upvalues: l__Warn__11 (copy)
    local v43 = (p42 or p41.modelReplicationMode or p41.entityConfig.MODEL_REPLICATION_MODE):upper();
    if v43 ~= "NATIVE" and (v43 ~= "CUSTOM" and v43 ~= "NATIVE_WITH_LOCK") then
        l__Warn__11.medium((`Invalid model replication mode {v43} for entity id {p41.id}, defaulting to NATIVE`));
        v43 = "NATIVE";
    end;
    if v43 == "NATIVE_WITH_LOCK" then
        p41._lockedCFReplication = true;
        v43 = "NATIVE";
    end;
    return v43;
end;
local function u56(p45, p46, p47, p48) --[[ Line: 259 ]]
    -- upvalues: u3 (copy), l__Config__3 (copy), u44 (copy), l__Holder__7 (copy), u21 (copy), l__Warn__11 (copy), u1 (copy), u12 (copy)
    local v49 = p45.modelReplicationMode == "CUSTOM";
    if u3 then
        local u50 = not p48 and p45.model;
        if u50 then
            pcall(function() --[[ Line: 38 ]]
                -- upvalues: u50 (copy)
                u50:Destroy();
            end);
        end;
        p45.model = nil;
    elseif not u3 and v49 then
        local l__model__21 = p45.model;
        if l__model__21 then
            pcall(function() --[[ Line: 38 ]]
                -- upvalues: l__model__21 (copy)
                l__model__21:Destroy();
            end);
        end;
        p45.model = nil;
    end;
    local l___lockedCFReplication__22 = p45._lockedCFReplication;
    local v51;
    if type(p46) == "string" then
        v51 = l__Config__3._GetEntityModel(p46);
        if v51 then
            v51 = v51:Clone();
        end;
        if v51 then
            v51.Parent = workspace;
        end;
    else
        v51 = p46;
        p46 = nil;
    end;
    local v52 = l__Config__3._GetBroadPhase(p46);
    local v53 = u44(p45, p47);
    p45.modelString = p46;
    p45.model = v51;
    if u3 or not p45.broadPhase then
        p45.broadPhase = v52;
    end;
    if v51 then
        if v53 == "CUSTOM" then
            v51.Parent = l__Holder__7.GetEntityStorageInstance();
        end;
        local v54 = v51:GetAttribute("__CHRONO_PRIMARY");
        if v54 and type(v54) == "string" then
            p45._chronoPrimary = v54;
        end;
    end;
    p45.modelReplicationMode = v53;
    local v55 = u21(p45);
    if v51 and not v55 then
        l__Warn__11.medium((`{v51:GetFullName()} must have a PrimaryPart set for things like autoReplication and movement.`));
    elseif v51 and not v51.Archivable then
        l__Warn__11.medium((`{v51:GetFullName()} is not Archivable. It is recommended to set Archivable to true for entity models to prevent potential issues when cloning. Archivable has been set to true automatically.`));
        v51.Archivable = true;
    end;
    if v55 then
        local l__CFrame__23 = v55.CFrame;
        if not u3 and (not p45.isContextOwner and v53 == "CUSTOM") then
            v55.Anchored = true;
        end;
        if not p45.latestCFrame then
            u1.SetCFrame(p45, l__CFrame__23 or v55.CFrame);
        end;
        if p45.latestCFrame then
            v55.CFrame = p45.latestCFrame;
        end;
        if l___lockedCFReplication__22 and u3 then
            u12(v55);
        end;
        p45.modelReplicationMode = u1.GetModelReplicationType(p45);
        if p45.modelReplicationMode == "NATIVE_WITH_LOCK" then
            p45.modelReplicationMode = "NATIVE";
        end;
    end;
end;
function u1._new(p57, p58, p59, p60) --[[ Line: 348 ]]
    -- upvalues: l__Config__3 (copy), l__Warn__11 (copy), u3 (copy), u4 (copy), l__Snapshots__4 (copy), l__InterpolationMath__5 (copy), u56 (copy), u40 (copy)
    local v61 = l__Config__3._GetEntityType(p57);
    if not v61 then
        l__Warn__11.medium((`Entity config {p57} not found. Using DEFAULT config.`));
        v61 = l__Config__3._GetEntityType("DEFAULT");
    end;
    if p60 == nil and (typeof(p58) == "string" and l__Config__3._GetEntityModel(p58) == false) then
        l__Warn__11.medium("Entity\'s model doesn\'t exist, initCFrame is required. DEFAULTING to CFrame.new(0, 0, 0)");
        p60 = CFrame.new(0, 0, 0);
    end;
    local v62 = {
        id = -1,
        registered = false,
        isContextOwner = false,
        networkOwner = nil,
        paused = false,
        destroyed = false,
        autoUpdatePosition = v61.AUTO_UPDATE_POSITION ~= false,
        latestCFrame = p60,
        entityConfig = v61,
        interpolation = not u3 and true
    };
    if u4 then
        v62.snapshot = l__Snapshots__4(l__InterpolationMath__5.Hermite);
    end;
    u56(v62, p58, p59);
    u40(v62, nil);
    return v62;
end;
function u1.new(p63, p64, p65, p66) --[[ Line: 404 ]]
    -- upvalues: u1 (copy), l__Holder__7 (copy)
    local v67 = u1._new(p63, p64, p65, p66);
    l__Holder__7.RegisterEntity(v67);
    return v67;
end;
function u1.SetModel(p68, p69, p70, p71) --[[ Line: 422 ]]
    -- upvalues: u56 (copy), u3 (copy), l__ModelHelper__10 (copy), u2 (copy), u40 (copy), u31 (copy)
    local l__model__24 = p68.model;
    u56(p68, p69, p70, p71);
    if u3 then
        local v72, v73 = l__ModelHelper__10.ReadyModelFromRep(p68, nil);
        local l__model__25 = p68.model;
        local v74 = v72 or false;
        p68.model = l__model__25;
        if u3 then
            if not u2[p68] then
                u2[p68] = {};
            end;
            u2[p68].model = v74 or (l__model__25 or false);
        end;
        p68._modelMetaData = v73;
        if u3 then
            if not u2[p68] then
                u2[p68] = {};
            end;
            local v75 = u2[p68];
            if not (v73 or v73) then
                v73 = false;
            end;
            v75._modelMetaData = v73;
        end;
        u40(p68, p68.networkOwner);
    end;
    u31(p68, "ModelChanged", p68.model, l__model__24);
end;
u1._FireEvent = u31;
function u1.SetConfig(p76, p77) --[[ Line: 457 ]]
    -- upvalues: l__Config__3 (copy), l__Warn__11 (copy), u3 (copy), u2 (copy)
    local v78 = l__Config__3._GetEntityType(p77);
    if not v78 then
        l__Warn__11.medium((`Entity config {p77} not found. Using Default config.`));
        v78 = l__Config__3._GetEntityType("DEFAULT");
    end;
    local l__NAME__26 = v78.NAME;
    if p76.entityConfig == v78 then
    else
        p76.entityConfig = v78;
        if u3 then
            if not u2[p76] then
                u2[p76] = {};
            end;
            u2[p76].entityConfig = l__NAME__26 or (v78 or false);
        end;
    end;
end;
function u1.SetBroadPhase(p79, p80) --[[ Line: 471 ]]
    -- upvalues: u3 (copy), u2 (copy)
    if p79.broadPhase == p80 then
    else
        p79.broadPhase = p80;
        if u3 then
            if not u2[p79] then
                u2[p79] = {};
            end;
            u2[p79].broadPhase = p80 or false;
        end;
    end;
end;
function u1.GetData(p81) --[[ Line: 480 ]]
    return p81._data;
end;
function u1.GetModel(p82) --[[ Line: 489 ]]
    return p82.model;
end;
function u1.SetData(p83, p84) --[[ Line: 498 ]]
    -- upvalues: u3 (copy), u2 (copy), u31 (copy)
    p83._data = p84;
    if u3 then
        if not u2[p83] then
            u2[p83] = {};
        end;
        u2[p83]._data = p84 or false;
    end;
    u31(p83, "DataChanged", p84);
end;
function u1._SetTickMode(p85, p86) --[[ Line: 503 ]]
    -- upvalues: u3 (copy), u2 (copy), u31 (copy)
    if p85.isHalfTicked == p86 then
    else
        if p85.isContextOwner then
            p85.isHalfTicked = p86;
        elseif p85.isHalfTicked ~= p86 then
            p85.isHalfTicked = p86;
            if u3 then
                if not u2[p85] then
                    u2[p85] = {};
                end;
                u2[p85].isHalfTicked = p86 or false;
            end;
        end;
        u31(p85, "TickChanged", p86 == nil and "NONE" or (p86 and "HALF" or "NORMAL"));
    end;
end;
function u1.ClearMount(p87) --[[ Line: 518 ]]
    -- upvalues: u3 (copy), u2 (copy)
    if not u3 then
        error("ClearMount can only be called on the server");
    end;
    if p87.mountParentId then
        if p87.mountParentId ~= nil then
            p87.mountParentId = nil;
            if u3 then
                if not u2[p87] then
                    u2[p87] = {};
                end;
                u2[p87].mountParentId = false;
            end;
        end;
        if p87.mountOffset == nil then
        else
            p87.mountOffset = nil;
            if u3 then
                if not u2[p87] then
                    u2[p87] = {};
                end;
                u2[p87].mountOffset = false;
            end;
        end;
    end;
end;
function u1.SetMount(p88, p89, p90) --[[ Line: 536 ]]
    -- upvalues: u3 (copy), u1 (copy), l__Warn__11 (copy), u2 (copy)
    if not u3 then
        error("SetMount can only be called on the server");
    end;
    if p89 == nil then
        return u1.ClearMount(p88);
    elseif p88 == p89 then
        l__Warn__11.medium("An entity cannot mount itself");
    elseif p89.id then
        local l__id__27 = p89.id;
        if p88.mountParentId ~= l__id__27 then
            p88.mountParentId = l__id__27;
            if u3 then
                if not u2[p88] then
                    u2[p88] = {};
                end;
                u2[p88].mountParentId = l__id__27 or false;
            end;
        end;
        if p88.mountOffset == p90 then
        else
            p88.mountOffset = p90;
            if u3 then
                if not u2[p88] then
                    u2[p88] = {};
                end;
                u2[p88].mountOffset = p90 or false;
            end;
        end;
    else
        l__Warn__11.high("Parent entity must be registered before mounting");
    end;
end;
u1["设置网络主控玩家"] = function(p91, p92) --[[ Line: 559 ]]
    -- upvalues: u3 (copy), u2 (copy), u40 (copy), u1 (copy)
    if p92 ~= p91.networkOwner then
        local l__networkOwner__28 = p91.networkOwner;
        if p91.networkOwner ~= p92 then
            p91.networkOwner = p92;
            if u3 then
                if not u2[p91] then
                    u2[p91] = {};
                end;
                u2[p91].networkOwner = p92 or false;
            end;
        end;
        u40(p91, l__networkOwner__28);
        u1.Clear(p91);
    end;
    p91.lastCheckedCFrame = nil;
    local v93 = not u3 and (p91.modelReplicationMode == "CUSTOM" and u1.GetPrimaryPart(p91));
    if v93 then
        v93.Anchored = not p91.isContextOwner;
    end;
end;
function u1.SetNetworkOwner(p94, p95) --[[ Line: 580 ]]
    -- upvalues: u3 (copy), u1 (copy), u2 (copy)
    if u3 and p95 ~= p94.networkOwner then
        u1["设置网络主控玩家"](p94, p95);
        local l__isHalfTicked__29 = p94.isHalfTicked;
        p94.isHalfTicked = l__isHalfTicked__29;
        if u3 then
            if not u2[p94] then
                u2[p94] = {};
            end;
            u2[p94].isHalfTicked = l__isHalfTicked__29 or false;
        end;
    else
        if not u3 then
            error("SetNetworkOwner can only be called on the server");
        end;
    end;
end;
function u1.Clear(p96) --[[ Line: 592 ]]
    local l__snapshot__30 = p96.snapshot;
    p96.latestTime = nil;
    p96.lastClientClock = nil;
    if l__snapshot__30 then
        l__snapshot__30:Clear();
    end;
end;
function u1.PauseReplication(p97) --[[ Line: 605 ]]
    -- upvalues: u3 (copy), u2 (copy)
    if p97.paused == true then
    else
        p97.paused = true;
        if u3 then
            if not u2[p97] then
                u2[p97] = {};
            end;
            u2[p97].paused = true;
        end;
    end;
end;
function u1.ResumeReplication(p98) --[[ Line: 612 ]]
    -- upvalues: u3 (copy), u2 (copy)
    if p98.paused == false then
    else
        p98.paused = false;
        if u3 then
            if not u2[p98] then
                u2[p98] = {};
            end;
            u2[p98].paused = false;
        end;
    end;
end;
function u1.Push(p99, p100, p101, p102) --[[ Line: 625 ]]
    -- upvalues: u3 (copy), u1 (copy), l__Warn__11 (copy), l__VelocityAt__12 (copy), u31 (copy)
    local l__snapshot__31 = p99.snapshot;
    local v103 = not p99.latestTime or p99.latestTime < p100;
    if v103 then
        p99.latestTime = p100;
        p99.latestCFrame = p101;
    end;
    if l__snapshot__31 then
        local v104 = l__snapshot__31:GetLatest();
        if not u3 and (v103 and (v104 and (p100 - v104.t < 5 and not p99.isContextOwner))) then
            local v105 = u1.GetTargetRenderTime(p99) - v104.t;
            if math.abs(v105) > 5 then
                l__snapshot__31:Clear();
                l__Warn__11.low("Clearing Snapshot due to large time difference");
            end;
        end;
        local l__TICK_RATE__32 = p99.entityConfig.TICK_RATE;
        if p99.isHalfTicked then
            l__TICK_RATE__32 = l__TICK_RATE__32 * 2;
        end;
        l__snapshot__31:PushWithCheck(p100, p101, p102 or l__VelocityAt__12(l__snapshot__31:GetLatest(), p100, p101, l__TICK_RATE__32), l__TICK_RATE__32);
    end;
    u31(p99, "PushedSnapShot", p100, p101, v103);
    return v103;
end;
function u1.GetAt(p106, p107) --[[ Line: 663 ]]
    local l__snapshot__33 = p106.snapshot;
    if l__snapshot__33 then
        return l__snapshot__33:GetAt(p107);
    else
        return p106.latestCFrame;
    end;
end;
function u1.GetTargetRenderTime(p108) --[[ Line: 677 ]]
    local l___clientClock__34 = p108._clientClock;
    if not l___clientClock__34 then
        local l__CLIENT_CLOCK__35 = p108.entityConfig.CLIENT_CLOCK;
        if not l__CLIENT_CLOCK__35 then
            return 0;
        end;
        l___clientClock__34 = p108.isHalfTicked and l__CLIENT_CLOCK__35.HALF or l__CLIENT_CLOCK__35.NORMAL;
    end;
    return not l___clientClock__34 and 0 or l___clientClock__34:GetTargetRenderTime();
end;
function u1.SetAutoUpdatePos(p109, p110) --[[ Line: 698 ]]
    -- upvalues: u3 (copy), u2 (copy)
    if p109.autoUpdatePos == p110 then
    else
        p109.autoUpdatePos = p110;
        if u3 then
            if not u2[p109] then
                u2[p109] = {};
            end;
            u2[p109].autoUpdatePos = p110 or false;
        end;
    end;
end;
function u1.GetCFrame(p111) --[[ Line: 707 ]]
    -- upvalues: u21 (copy)
    local v112 = u21(p111);
    local l__latestCFrame__36 = p111.latestCFrame;
    if l__latestCFrame__36 then
        v112 = l__latestCFrame__36;
    elseif v112 then
        v112 = v112.CFrame;
    end;
    return v112;
end;
function u1.SetCFrame(p113, p114) --[[ Line: 717 ]]
    -- upvalues: l__Config__3 (copy), u3 (copy), u1 (copy), u2 (copy), u18 (copy)
    local v115 = (p113.latestTime or 0) + 0.02;
    local _ = p113.snapshot;
    if l__Config__3.FLAGS.SET_CFRAME_FIX then
        if u3 then
            p113._teleport = os.clock();
        elseif p113.isContextOwner then
            p113._teleport = os.clock();
        else
            u1.Clear(p113);
        end;
    end;
    u1.Push(p113, v115, p114);
    p113.latestCFrame = p114;
    if u3 then
        if not u2[p113] then
            u2[p113] = {};
        end;
        u2[p113].latestCFrame = p114 or false;
    end;
    if p113.isContextOwner or not u3 then
        u18(p113, p114);
    end;
end;
function u1.GetPrimaryPart(p116) --[[ Line: 744 ]]
    -- upvalues: u21 (copy)
    if p116.model then
        return u21(p116);
    else
        return nil;
    end;
end;
function u1.LockNativeServerCFrameReplication(p117) --[[ Line: 758 ]]
    -- upvalues: u3 (copy), u21 (copy), u12 (copy), u31 (copy)
    if u3 then
        if p117.modelReplicationMode ~= "NATIVE" then
            error("LockNativeServerCFrameReplication can only be called on NATIVE model replication mode entities");
        end;
        if p117._lockedCFReplication then
        else
            p117._lockedCFReplication = true;
            u12((u21(p117)));
            u31(p117, "LockChanged", true);
        end;
    else
        error("LockNativeServerCFrameReplication can only be called on the server");
    end;
end;
function u1.UnlockNativeServerCFrameReplication(p118) --[[ Line: 782 ]]
    -- upvalues: u3 (copy), u21 (copy), u31 (copy)
    if u3 then
        if p118.modelReplicationMode ~= "NATIVE" then
            error("LockNativeServerCFrameReplication can only be called on NATIVE model replication mode entities");
        end;
        if p118._lockedCFReplication then
            p118._lockedCFReplication = false;
            local v119 = u21(p118);
            local u120 = v119 and v119:FindFirstChild("__CHRONO_LOCKER");
            if u120 then
                local v121 = u120:FindFirstChild("__CHRONO_WELD");
                if v121 then
                    v121.Part1 = nil;
                elseif u120 then
                    pcall(function() --[[ Line: 38 ]]
                        -- upvalues: u120 (copy)
                        u120:Destroy();
                    end);
                end;
            end;
            u31(p118, "LockChanged", false);
        end;
    else
        error("LockNativeServerCFrameReplication can only be called on the server");
    end;
end;
function u1.GetModelReplicationType(p122) --[[ Line: 803 ]]
    return (p122.modelReplicationMode or p122.entityConfig.MODEL_REPLICATION_MODE) == "CUSTOM" and "CUSTOM" or (p122._lockedCFReplication and "NATIVE_WITH_LOCK" or "NATIVE");
end;
function u1.Destroy(p123) --[[ Line: 820 ]]
    -- upvalues: u31 (copy), l__Holder__7 (copy), u3 (copy), u21 (copy)
    p123.destroyed = true;
    u31(p123, "Destroying");
    l__Holder__7.UnregisterEntity(p123);
    if p123._clientClock then
        p123._clientClock:Destroy();
    end;
    if u3 then
        local l__model__37 = p123.model;
        if l__model__37 then
            pcall(function() --[[ Line: 38 ]]
                -- upvalues: l__model__37 (copy)
                l__model__37:Destroy();
            end);
        end;
    else
        local l__modelReplicationMode__38 = p123.modelReplicationMode;
        local v124 = u21(p123);
        if l__modelReplicationMode__38 == "CUSTOM" then
            local l__model__39 = p123.model;
            if l__model__39 then
                pcall(function() --[[ Line: 38 ]]
                    -- upvalues: l__model__39 (copy)
                    l__model__39:Destroy();
                end);
            end;
        elseif v124 then
            v124.CFrame = CFrame.new(0, 1000000, 0);
        end;
    end;
    for _, v125 in p123._events or {} do
        v125:DisconnectAll();
    end;
end;
function u1.GetEvent(p126, p127) --[[ Line: 441 ]]
    -- upvalues: l__Signal__8 (copy)
    if not p126._events then
        p126._events = {};
    end;
    local l___events__40 = p126._events;
    if not l___events__40[p127] then
        l___events__40[p127] = l__Signal__8.new();
    end;
    return l___events__40[p127].Event;
end;
l__Players__1.PlayerAdded:Connect(function(p128) --[[ Line: 891 ]]
    -- upvalues: l___clientOwned__13 (copy)
    l___clientOwned__13[p128] = {};
end);
if l__Players__1.LocalPlayer then
    l___clientOwned__13[l__Players__1.LocalPlayer] = {};
end;
l__Players__1.PlayerRemoving:Connect(function(p129) --[[ Line: 899 ]]
    -- upvalues: l___clientOwned__13 (copy)
    l___clientOwned__13[p129] = nil;
end);
l__Events__9._Signals["请不要使用_内部_设置值_拜托谢谢_嗨_这个名字有点长_好吧_再见_算了_这个确实被用了_因为递归错误_而我懒得去解决_所以这是一个能用的_创可贴式修复_好吧"].Event:Connect(v27);
u1._Changes = u2;
u1._GetPart = u21;
u1._SetPartCFrame = u18;
return u1;
