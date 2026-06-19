-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = next;
local l__clear__1 = table.clear;
local l__clone__2 = table.clone;
local l__obtain__3 = _G.obtain;
local u2 = l__obtain__3("LabelPrint");
local u3 = l__obtain__3("L1Copy");
local l__mesh__4 = l__obtain__3("Trey-Sweep").mesh;
local l__difference__5 = l__obtain__3("Trey-MinimumDifference").difference;
local v4 = l__obtain__3("SpineFix");
local l__GetConvexSetPart__6 = v4.GetConvexSetPart;
local l__GenerateBasePartMesh__7 = v4.GenerateBasePartMesh;
local u5 = l__obtain__3("World");
local u6 = l__obtain__3("Signal");
local v7 = l__obtain__3("StateCalculus");
local v8 = l__obtain__3("Class")();
local l__new__8 = CFrame.new;
local _ = Vector3.new;
function v8.CalculatePath(p9, p10) --[[ Line: 45 ]]
    local v11 = p10 - p9.Time;
    return p9.Position, p9.Velocity + v11 / 2 * p9.Acceleration, v11;
end;
function v8.SetSize(p12, p13) --[[ Line: 51 ]]
    local v14 = p13 / 2;
    p12.HalfSize = v14;
    p12.HSR = v14 - Vector3.new(0.01, 0.01, 0.01);
end;
function v8.CalculateHitBoxRegion(p15, p16) --[[ Line: 57 ]]
    -- upvalues: l__new__8 (copy)
    local v17 = p15.HalfSize + Vector3.new(0.0004, 0.0004, 0.0004) + Vector3.new(0.01, 0.01, 0.01);
    return l__new__8(p16), 2 * v17;
end;
local function u20(p18, p19) --[[ Line: 92 ]]
    p18.Contacts[p19.Part] = p19;
end;
local function u23(p21, p22) --[[ Line: 96 ]]
    p21.Contacts[p22.Part] = nil;
end;
function v8.Prepare(p24, p25) --[[ Line: 100 ]]
    local l__PhysicsEvent__9 = p24.PhysicsEvent;
    p24.PhysicsEvent = {
        Type = "TickEnd",
        Time = p25
    };
    p24.OnPrepare:Call(p24, p25 - p24.Time, l__PhysicsEvent__9);
end;
function v8.ConsiderPhysicsEvent(p26, p27, p28) --[[ Line: 109 ]]
    -- upvalues: l__clear__1 (copy)
    local l__PhysicsEvent__10 = p26.PhysicsEvent;
    if p26.Time - 1e-6 < p28 and p28 < l__PhysicsEvent__10.Time then
        l__clear__1(l__PhysicsEvent__10);
        l__PhysicsEvent__10.Type = p27;
        l__PhysicsEvent__10.Time = p28;
        return l__PhysicsEvent__10;
    end;
end;
function v8.HandlePhysicsEvent(p29, p30) --[[ Line: 121 ]]
    local v31 = p29.Handlers[p30.Type];
    if v31 then
        v31:Call(p29, p30);
    end;
    return p30.Type == "TickEnd";
end;
local function u53(p32, p33, _, p34) --[[ Line: 131 ]]
    -- upvalues: u1 (copy), l__GenerateBasePartMesh__7 (copy), l__difference__5 (copy)
    if not p34 then
        local l__Time__11 = p32.Time;
        local l__Contacts__12 = p32.Contacts;
        local v35 = nil;
        for v36, _ in u1, l__Contacts__12 do
            local v37 = {
                Type = "CollisionEnd",
                Time = l__Time__11,
                Part = v36
            };
            local v38 = p32.Handlers[v37.Type];
            if v38 then
                v38:Call(p32, v37);
            end;
            local _ = v37.Type == "TickEnd";
        end;
        local l__World__13 = p32.World;
        local v39 = l__World__13.Timer:Time(l__Time__11);
        local v40, v41 = p32:CalculateHitBoxRegion(p33);
        local v42 = l__World__13:FindParts(v40, v41, v39);
        if #v42 ~= 0 then
            local v43 = v35 or p32:CalculateHitBox(p33);
            for v44 = 1, #v42 do
                local v45 = v42[v44];
                if not l__Contacts__12[v45] then
                    local v46, v47 = l__GenerateBasePartMesh__7(v45, (l__World__13:GetPartCFrame(v45, v39)));
                    local _, v48, v49, v50 = l__difference__5(v43, 0.01, v46, v47, 0.0004);
                    if v48 and v48 < 0.0004 then
                        local v51 = {
                            Type = "CollisionStart",
                            Time = l__Time__11,
                            Part = v45,
                            Normal = -v50,
                            Position = v49
                        };
                        local v52 = p32.Handlers[v51.Type];
                        if v52 then
                            v52:Call(p32, v51);
                        end;
                        local _ = v51.Type == "TickEnd";
                    end;
                end;
            end;
        end;
    end;
end;
function v8.CollectEvents(p54) --[[ Line: 179 ]]
    -- upvalues: u1 (copy), l__GenerateBasePartMesh__7 (copy), l__mesh__4 (copy), l__difference__5 (copy), l__clear__1 (copy), u2 (copy), l__GetConvexSetPart__6 (copy)
    local l__Time__14 = p54.Time;
    local l__Time__15 = p54.PhysicsEvent.Time;
    if l__Time__15 == l__Time__14 then
        return p54.Velocity;
    end;
    local v55, v56, v57 = p54:CalculatePath(l__Time__15);
    local l__World__16 = p54.World;
    local v58 = l__World__16.Timer:Time(l__Time__14);
    local l__Contacts__17 = p54.Contacts;
    local v59, v60, v61, v62, v63, v64, v65, v66, v67, v68, v69, v70, v71, v72, v73, v74, v75, v76, v77, v78, v79, v80, v81, v82, v83, v84, v85, v86, v87, v88, v89;
    if not u1(l__Contacts__17) then
        v59 = nil;
        v60 = p54.World:GetPathParts(v55, v55 + v56 * v57, p54.HalfSize + Vector3.new(0.0004, 0.0004, 0.0004) + Vector3.new(0.01, 0.01, 0.01), v58, l__World__16.Timer:Time(l__Time__15));
        if #v60 ~= 0 then
            v61 = v59 or p54:CalculateHitBox(v55);
            for v104 = 1, #v60 do
                v62 = l__GetConvexSetPart__6(v60[v104], l__World__16, v58);
                if not l__Contacts__17[v62] then
                    v63, v64 = l__GenerateBasePartMesh__7(v62, (l__World__16:GetPartCFrame(v62, v58)));
                    v65 = l__World__16:GetPartImplicitVelocity(v62, v58);
                    v66, v67, v68, v69, v70, v71 = l__mesh__4(v61, 0.01, v56, v63, v64, v65, 0);
                    if not v66 then
                        v68 = nil;
                        v67 = nil;
                        v71 = nil;
                    end;
                    if v67 then
                        if v67 < 0 then
                            v72, v73, v74, v75, v76, v77 = l__mesh__4(v61, 0.01, -v56, v63, v64 + 1e-6 + 0.0004, -v65);
                            if v73 then
                                v78 = -v73;
                                v79 = v56 - v65;
                                v80 = v78 - 0.0004 * v77:Dot(v79) / v79:Dot(v79);
                            else
                                v80 = nil;
                            end;
                            v81 = -v67 < v80;
                            v67 = 0;
                            if v81 then
                                v82, v83, v84, v85, v86, v87 = l__difference__5(v61, 0.01, v63, v64, 0);
                                if v82 then
                                    v71 = v87;
                                    v68 = v84;
                                else
                                    v81 = false;
                                end;
                            end;
                        else
                            v81 = true;
                        end;
                        if v81 then
                            v88 = l__Time__14 + v67;
                            v89 = p54.PhysicsEvent;
                            if p54.Time - 1e-6 < v88 and v88 < v89.Time then
                                l__clear__1(v89);
                                v89.Type = "CollisionStart";
                                v89.Time = v88;
                            else
                                v89 = nil;
                            end;
                            if v89 then
                                v89.Part = v62;
                                v89.Normal = v71;
                                v89.Position = v68;
                            end;
                        end;
                    end;
                end;
            end;
        end;
        return v56;
    end;
    v59 = p54:CalculateHitBox(v55);
    for v91, _ in u1, l__Contacts__17 do
        local v92, v93 = l__GenerateBasePartMesh__7(v91, (l__World__16:GetPartCFrame(v91, v58)));
        local v94 = l__World__16:GetPartImplicitVelocity(v91, v58);
        local _, v95, v96, _, _, v97 = l__mesh__4(v59, 0.01, -v56, v92, v93 + 1e-6 + 0.0004, -v94);
        local v98;
        if v95 then
            local v99 = -v95;
            local v100 = v56 - v94;
            v98 = v99 - 0.0004 * v97:Dot(v100) / v100:Dot(v100);
        else
            v96 = nil;
            v98 = nil;
            v97 = nil;
        end;
        if v98 then
            local v101, v102;
            if v98 < 0 then
                local v103, _, _, _, _, _ = l__difference__5(v59, 0.01, v92, v93, 0);
                if not v103 then
                    v98 = 0;
                    v101 = l__Time__14 + v98;
                    v102 = p54.PhysicsEvent;
                    if p54.Time - 1e-6 < v101 and v101 < v102.Time then
                        l__clear__1(v102);
                        v102.Type = "CollisionEnd";
                        v102.Time = v101;
                    else
                        v102 = nil;
                    end;
                    if v102 then
                        v102.Part = v91;
                        v102.Normal = v97;
                        v102.Position = v96;
                    end;
                end;
            else
                v101 = l__Time__14 + v98;
                v102 = p54.PhysicsEvent;
                if p54.Time - 1e-6 < v101 and v101 < v102.Time then
                    l__clear__1(v102);
                    v102.Type = "CollisionEnd";
                    v102.Time = v101;
                else
                    v102 = nil;
                end;
                if v102 then
                    v102.Part = v91;
                    v102.Normal = v97;
                    v102.Position = v96;
                end;
            end;
        elseif v56 ~= Vector3.new(0, 0, 0) and p54.GameMechanics.debugEvents then
            u2("SweepMesh did not return any hit or closest approach Velocity=", v56);
        end;
    end;
    v60 = p54.World:GetPathParts(v55, v55 + v56 * v57, p54.HalfSize + Vector3.new(0.0004, 0.0004, 0.0004) + Vector3.new(0.01, 0.01, 0.01), v58, l__World__16.Timer:Time(l__Time__15));
    if #v60 ~= 0 then
        v61 = v59 or p54:CalculateHitBox(v55);
        for v104 = 1, #v60 do
            v62 = l__GetConvexSetPart__6(v60[v104], l__World__16, v58);
            if not l__Contacts__17[v62] then
                v63, v64 = l__GenerateBasePartMesh__7(v62, (l__World__16:GetPartCFrame(v62, v58)));
                v65 = l__World__16:GetPartImplicitVelocity(v62, v58);
                v66, v67, v68, v69, v70, v71 = l__mesh__4(v61, 0.01, v56, v63, v64, v65, 0);
                if not v66 then
                    v68 = nil;
                    v67 = nil;
                    v71 = nil;
                end;
                if v67 then
                    if v67 < 0 then
                        v72, v73, v74, v75, v76, v77 = l__mesh__4(v61, 0.01, -v56, v63, v64 + 1e-6 + 0.0004, -v65);
                        if v73 then
                            v78 = -v73;
                            v79 = v56 - v65;
                            v80 = v78 - 0.0004 * v77:Dot(v79) / v79:Dot(v79);
                        else
                            v80 = nil;
                        end;
                        v81 = -v67 < v80;
                        v67 = 0;
                        if v81 then
                            v82, v83, v84, v85, v86, v87 = l__difference__5(v61, 0.01, v63, v64, 0);
                            if v82 then
                                v71 = v87;
                                v68 = v84;
                            else
                                v81 = false;
                            end;
                        end;
                    else
                        v81 = true;
                    end;
                    if v81 then
                        v88 = l__Time__14 + v67;
                        v89 = p54.PhysicsEvent;
                        if p54.Time - 1e-6 < v88 and v88 < v89.Time then
                            l__clear__1(v89);
                            v89.Type = "CollisionStart";
                            v89.Time = v88;
                        else
                            v89 = nil;
                        end;
                        if v89 then
                            v89.Part = v62;
                            v89.Normal = v71;
                            v89.Position = v68;
                        end;
                    end;
                end;
            end;
        end;
    end;
    return v56;
end;
function v8.Update(p105, p106) --[[ Line: 279 ]]
    local l__Time__18 = p105.PhysicsEvent.Time;
    local l__Time__19 = p105.Time;
    if l__Time__18 < l__Time__19 then
        l__Time__18 = l__Time__19;
    end;
    local v107 = l__Time__18 - l__Time__19;
    p105.Time = l__Time__18;
    if v107 ~= 0 and p105.Acceleration ~= Vector3.new(0, 0, 0) then
        p105:SetVelocity(p105.Velocity + v107 * p105.Acceleration);
    end;
    if v107 ~= 0 and p106 ~= Vector3.new(0, 0, 0) then
        p105:SetPosition(p105.Position + v107 * p106, true);
    end;
    p105.OnUpdate:Call(p105, v107);
    p105.PositionAdvanced:Call(p105, v107, p106);
end;
function v8.Tick(p108, p109) --[[ Line: 300 ]]
    debug.profilebegin("Physics");
    local v110 = 0;
    local v111 = true;
    repeat
        v110 = v110 + 1;
        p108:Prepare(p109);
        p108:Update((p108:CollectEvents()));
    until p108:HandlePhysicsEvent(p108.PhysicsEvent) or v110 >= 32;
    if v110 >= 32 then
        print("Over 32 steps xD!!!");
        v111 = false;
    end;
    debug.profileend();
    return v111;
end;
function v8.SetPosition(p112, p113, p114) --[[ Line: 324 ]]
    p112.Position = p113;
    p112.PositionChanged:Call(p112, p113, p, p114);
end;
function v8.SetVelocity(p115, p116) --[[ Line: 333 ]]
    local l__Velocity__20 = p115.Velocity;
    if l__Velocity__20 ~= p116 then
        p115.Velocity = p116;
        p115.VelocityChanged:Call(p115, p116, l__Velocity__20);
    end;
end;
local u117 = v7({
    "Time",
    "Position",
    "Velocity",
    "Gravity"
});
v8.StateCalculus = v7;
function v8.GetState(p118) --[[ Line: 344 ]]
    -- upvalues: u117 (copy), l__clone__2 (copy)
    local v119 = u117:GetState(p118);
    v119.Contacts = l__clone__2(p118.Contacts);
    v119.World = p118.World:GetState();
    return v119;
end;
function v8.SetState(p120, p121) --[[ Line: 350 ]]
    -- upvalues: u117 (copy)
    u117:SetState(p120, p121);
    p120.Contacts = p121.Contacts;
    p120.World:SetState(p121.World);
end;
function v8.CopyState(p122, p123) --[[ Line: 355 ]]
    -- upvalues: u117 (copy), l__clear__1 (copy), u3 (copy)
    u117:SetState(p122, p123);
    l__clear__1(p122.Contacts);
    u3(p123.Contacts, p122.Contacts);
    p122.World:CopyState(p123.World);
end;
function v8.SyncState(p124, p125) --[[ Line: 361 ]]
    -- upvalues: u117 (copy), l__clear__1 (copy), u3 (copy)
    u117:SetState(p124, p125);
    l__clear__1(p124.Contacts);
    u3(p125.Contacts, p124.Contacts);
end;
function v8.DifferentiateState(p126, p127, p128) --[[ Line: 366 ]]
    -- upvalues: u117 (copy)
    assert(p128 ~= nil, "DifferentiateState Instructions cannot be nil");
    local v129, v130 = u117:Differentiate(p126, p127);
    p128.PhysRemovals = v129;
    p128.PhysChanges = v130;
    p126.World:DifferentiateState(p127.World, p128);
end;
function v8.IntegrateState(p131, p132) --[[ Line: 371 ]]
    -- upvalues: u117 (copy)
    u117:Integrate(p131, p132.PhysRemovals, p132.PhysChanges);
    p131.World:IntegrateState(p132);
end;
function v8.Constructor(p133) --[[ Line: 376 ]]
    -- upvalues: u6 (copy), u20 (copy), u23 (copy), u53 (copy), u5 (copy)
    p133.Time = 0;
    p133.Position = Vector3.new(0, 0, 0);
    p133.Velocity = Vector3.new(0, 0, 0);
    p133.Acceleration = Vector3.new(0, 0, 0);
    p133.Gravity = Vector3.new(0, 0, 0);
    p133.Contacts = {};
    p133.Handlers = {
        CollisionStart = u6():Add(u20),
        CollisionEnd = u6():Add(u23)
    };
    p133.OnPrepare = u6();
    p133.OnUpdate = u6();
    p133.PositionChanged = u6():Add(u53);
    p133.VelocityChanged = u6();
    p133.PositionAdvanced = u6();
    p133.World = u5();
    p133:SetSize(Vector3.new(0, 0, 0));
end;
return v8;
