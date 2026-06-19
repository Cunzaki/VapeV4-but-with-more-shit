-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = next;
local u2 = typeof;
local u3 = tonumber;
local l__abs__1 = math.abs;
local l__atan2__2 = math.atan2;
local l__cos__3 = math.cos;
local l__sin__4 = math.sin;
local l__sqrt__5 = math.sqrt;
local l__max__6 = math.max;
local l__match__7 = string.match;
local l__clear__8 = table.clear;
local l__clone__9 = table.clone;
local l__obtain__10 = _G.obtain;
local u4 = l__obtain__10("L1Copy");
local u5 = l__obtain__10("LabelPrint");
local v6 = l__obtain__10("CustomEnums");
local l__MODE_MAIN__11 = v6.MODE_MAIN;
local _ = v6.MODE_INVALID;
local l__FLYMODE_NONE__12 = v6.FLYMODE_NONE;
local l__FLYMODE_FLY__13 = v6.FLYMODE_FLY;
local l__TICKINFO_BIT_TICKEND__14 = v6.TICKINFO_BIT_TICKEND;
local l__TICKINFO_BIT_JUMP__15 = v6.TICKINFO_BIT_JUMP;
local l__TICKINFO_BIT_STRAFE__16 = v6.TICKINFO_BIT_STRAFE;
local l__TICKINFO_BIT_TOUCHING__17 = v6.TICKINFO_BIT_TOUCHING;
local l__FLAGREASON_ANTICHEAT__18 = v6.FLAGREASON_ANTICHEAT;
local l__EVENT_RUN_PREPARE__19 = v6.EVENT_RUN_PREPARE;
local l__EVENT_RUN_START__20 = v6.EVENT_RUN_START;
local _ = v6.EVENT_RUN_FINISH;
local _ = v6.EVENT_RUN_CLEAR;
local l__EVENT_RUN_FLAG__21 = v6.EVENT_RUN_FLAG;
local l__EVENT_WORLD_RESET__22 = v6.EVENT_WORLD_RESET;
local l__EVENT_WORLD_BUTTON__23 = v6.EVENT_WORLD_BUTTON;
local l__EVENT_WORLD_SETTIME__24 = v6.EVENT_WORLD_SETTIME;
local l__EVENT_WORLD_SETPAUSED__25 = v6.EVENT_WORLD_SETPAUSED;
local l__EVENT_CAMERA_PUNCH__26 = v6.EVENT_CAMERA_PUNCH;
local l__EVENT_CAMERA_TRANSFORM__27 = v6.EVENT_CAMERA_TRANSFORM;
local l__SOUND_TRACK_GROUND__28 = v6.SOUND_TRACK_GROUND;
local l__SOUND_TRACK_LADDER__29 = v6.SOUND_TRACK_LADDER;
local l__SOUND_TRACK_WATER__30 = v6.SOUND_TRACK_WATER;
local _ = v6.SOUND_TRACK_AIR;
local l__SOUND_JUMP_GROUND__31 = v6.SOUND_JUMP_GROUND;
local l__SOUND_JUMP_LADDER__32 = v6.SOUND_JUMP_LADDER;
local l__SOUND_SMASH_GROUND__33 = v6.SOUND_SMASH_GROUND;
local l__SOUND_SMASH_WALL__34 = v6.SOUND_SMASH_WALL;
local u7 = l__obtain__10("Styles");
local l__CreateStyleInfo__35 = u7.CreateStyleInfo;
local v8 = l__obtain__10("Class");
local v9 = l__obtain__10("StateCalculus");
local u10 = l__obtain__10("Signal");
local l__BlankGameControls__36 = l__obtain__10("GameControl").BlankGameControls;
local v11 = l__obtain__10("World");
local l__GetPartImplicitAcceleration__37 = v11.Metamethods.GetPartImplicitAcceleration;
local l__GetPartVelocityAtPointImplicit__38 = v11.Metamethods.GetPartVelocityAtPointImplicit;
local l__GetPartVelocityAtPointExplicit__39 = v11.Metamethods.GetPartVelocityAtPointExplicit;
local l__push__40 = l__obtain__10("Trey-InscribedCenter").push;
local v12 = l__obtain__10("Trey-GeometryQuery");
local l__makeFurthestPointRegularPrismYFunctionWorldSpace__41 = v12.makeFurthestPointRegularPrismYFunctionWorldSpace;
local l__makeFurthestPointYBiPyramidMidRiff__42 = v12.makeFurthestPointYBiPyramidMidRiff;
local l__makeQueryFuncFromPart__43 = v12.makeQueryFuncFromPart;
local l__difference__44 = l__obtain__10("Trey-MinimumDifference").difference;
local u13 = l__obtain__10("GameMechanicsObjectRecognition");
local l__Analyze__45 = u13.Analyze;
local l__Lerp__46 = Vector2.zero.Lerp;
local l__new__47 = Vector3.new;
local u14 = l__new__47();
local l__Dot__48 = u14.Dot;
local l__Cross__49 = u14.Cross;
local v15 = CFrame.new();
local l__Inverse__50 = v15.Inverse;
local l__ToAxisAngle__51 = v15.ToAxisAngle;
local l__PointToObjectSpace__52 = v15.PointToObjectSpace;
local l__VectorToWorldSpace__53 = v15.VectorToWorldSpace;
local l__VectorToObjectSpace__54 = v15.VectorToObjectSpace;
local u16 = {
    [3] = 8,
    [2] = 6,
    [1] = 8
};
local u17 = {
    [3] = l__SOUND_TRACK_GROUND__28,
    [2] = l__SOUND_TRACK_WATER__30,
    [1] = l__SOUND_TRACK_LADDER__29
};
local v18 = v8();
local function u22(p19, u20) --[[ Line: 145 ]]
    -- upvalues: l__makeFurthestPointRegularPrismYFunctionWorldSpace__41 (copy), l__makeFurthestPointYBiPyramidMidRiff__42 (copy)
    local l__HSR__55 = p19.HSR;
    local l__StyleInfo__56 = p19.GameMechanics.StyleInfo;
    if l__StyleInfo__56 then
        local l__hitbox__57 = l__StyleInfo__56.hitbox;
        if l__hitbox__57 == "Cylinder" then
            return l__makeFurthestPointRegularPrismYFunctionWorldSpace__41(u20, 2 * l__HSR__55.y, l__HSR__55.x, 24);
        end;
        if l__hitbox__57 == "BiPyramidMidRiff" then
            return l__makeFurthestPointYBiPyramidMidRiff__42(u20, l__HSR__55.y, l__HSR__55.y - l__StyleInfo__56.hitbox_slope * l__HSR__55.x, l__HSR__55.x, 24);
        end;
        if l__hitbox__57 == "BiPyramid" then
            local l__hitbox_offset__58 = l__StyleInfo__56.hitbox_offset;
            return makeBiPyramid(u20 + l__hitbox_offset__58, l__HSR__55.y - l__hitbox_offset__58.y, l__HSR__55.y + l__hitbox_offset__58.y, l__HSR__55.x, 24);
        end;
        if l__hitbox__57 == "Sphere" then
            return function(p21) --[[ Line: 160 ]]
                -- upvalues: u20 (copy), l__HSR__55 (copy)
                if p21 and p21.magnitude > 0 then
                    return u20 + p21.unit * l__HSR__55.x;
                else
                    return u20;
                end;
            end;
        end;
        if l__hitbox__57 == "Point" then
            return function(_) --[[ Line: 168 ]]
                -- upvalues: u20 (copy)
                return u20;
            end;
        end;
    end;
end;
function v18.GetMousePos(p23, p24) --[[ Line: 179 ]]
    -- upvalues: u5 (copy), l__Lerp__46 (copy)
    local l__GameControls__59 = p23.GameControls;
    local l__NextGameControls__60 = p23.NextGameControls;
    if not (l__NextGameControls__60 and p24) then
        u5("GetMousePos External");
        return l__GameControls__59.MousePos;
    end;
    local v25 = (p24 - l__GameControls__59.Time) / (l__NextGameControls__60.Time - l__GameControls__59.Time);
    if p23.debugGetMousePos then
        if v25 - v25 ~= 0 then
            u5("GetMousePos divide by 0");
        end;
        if v25 >= 0 then
            local _ = v25 > 1;
        end;
    end;
    return l__Lerp__46(l__GameControls__59.MousePos, l__NextGameControls__60.MousePos, v25);
end;
function v18.WrapWorldEvent(p26, p27, p28, p29) --[[ Line: 198 ]]
    -- upvalues: u5 (copy), l__EVENT_WORLD_SETTIME__24 (copy), l__EVENT_WORLD_SETPAUSED__25 (copy), l__EVENT_WORLD_RESET__22 (copy), l__MODE_MAIN__11 (copy), l__EVENT_WORLD_BUTTON__23 (copy)
    local l__Simulation__61 = p26.Simulation;
    local l__Phys__62 = l__Simulation__61.Phys;
    if p26.debugEvents then
        u5("WorldEvent", p27, p28, p29);
    end;
    if p28 == l__EVENT_WORLD_SETTIME__24 then
        l__Phys__62.World.Timer:SetTime(p27, p29);
    elseif p28 == l__EVENT_WORLD_SETPAUSED__25 then
        if p29 then
            l__Phys__62.World.Timer:Pause(p27);
        else
            l__Phys__62.World.Timer:Play(p27);
        end;
    elseif p28 == l__EVENT_WORLD_RESET__22 then
        if not p29 then
            local l__Zone__63 = p26.MapInfo.Zone;
            if l__Zone__63 then
                local v30 = l__Zone__63.Start[l__MODE_MAIN__11];
                if v30 then
                    p29 = v30.Position;
                else
                    error("MapStart is nil.");
                end;
            else
                u5("MapInfo.Zone is nil. Ignoring assuming initialization hell");
            end;
        end;
        l__Phys__62.World:Reset(l__Phys__62.World.Timer:Time(p27));
    elseif p28 == l__EVENT_WORLD_BUTTON__23 then
        local l__World__64 = l__Phys__62.World;
        if not l__World__64:ActivateButton(p29, l__World__64.Timer:Time(p27)) then
            return;
        end;
    end;
    l__Simulation__61.OutputMulticall:Call("World", p27, p28, p29, l__Phys__62.World.ID);
end;
function v18.WrapRunEvent(p31, p32, p33, p34) --[[ Line: 237 ]]
    -- upvalues: u5 (copy), l__EVENT_RUN_PREPARE__19 (copy), l__clear__8 (copy), l__EVENT_WORLD_RESET__22 (copy), l__EVENT_WORLD_SETPAUSED__25 (copy), l__EVENT_WORLD_SETTIME__24 (copy), l__EVENT_RUN_START__20 (copy), l__EVENT_RUN_FLAG__21 (copy), l__FLAGREASON_ANTICHEAT__18 (copy)
    if p31.debugEvents then
        u5("RunEvent", p32, p33, p34);
    end;
    local v35 = nil;
    local l__Simulation__65 = p31.Simulation;
    if p33 == l__EVENT_RUN_PREPARE__19 then
        p31.SpawnId = 1;
        p31.JumpPart = nil;
        p31.JumpCount = nil;
        l__clear__8(p31.Simulation.States);
        p31:WrapWorldEvent(p32, l__EVENT_WORLD_RESET__22);
        p31:WrapWorldEvent(p32, l__EVENT_WORLD_SETPAUSED__25, true);
        p31:WrapWorldEvent(p32, l__EVENT_WORLD_SETTIME__24, p31.WorldTimerOffset);
        v35 = p31.Style;
    elseif p33 == l__EVENT_RUN_START__20 then
        if p31.StyleInfo.fly_acceleration then
            p31.FlySpeed = p31.StyleInfo.fly_speed;
        end;
        p31:WrapWorldEvent(p32, l__EVENT_WORLD_SETPAUSED__25, false);
    elseif p33 == l__EVENT_RUN_FLAG__21 then
        v35 = l__FLAGREASON_ANTICHEAT__18;
    end;
    l__Simulation__65.OutputMulticall:Call("Run", p32, p33, p34, v35);
end;
function v18.WrapCameraEvent(p36, p37, p38, p39) --[[ Line: 264 ]]
    local l__Simulation__66 = p36.Simulation;
    l__Simulation__66.Camera:Event(p38, p39);
    l__Simulation__66.OutputMulticall:Call("Camera", p37, p38, p39);
end;
function v18.WrapSettingEvent(p40, p41, p42, p43) --[[ Line: 273 ]]
    local l__Simulation__67 = p40.Simulation;
    l__Simulation__67.Camera:Setting(p42, p43);
    l__Simulation__67.OutputMulticall:Call("Setting", p41, p42, p43);
end;
function v18.WrapSoundEvent(p44, ...) --[[ Line: 278 ]]
    p44.Simulation.OutputMulticall:Call("Sound", ...);
end;
function v18.Reset(p45, p46) --[[ Line: 292 ]]
    -- upvalues: l__MODE_MAIN__11 (copy), l__new__47 (copy), u5 (copy)
    if p45.Simulation.Ready then
        local l__Phys__68 = p45.Simulation.Phys;
        p45.SpawnId = 1;
        p45.JumpPart = nil;
        p45.JumpCount = nil;
        p45.RequireExplicitRestart = nil;
        local v47 = p46 or l__MODE_MAIN__11;
        local v48 = p45.SetSpawns[v47];
        local v49 = p45.StyleInfo.StartZone or "Start";
        local v50 = p45.MapInfo.Zone[v49];
        local v51;
        if v50 then
            v51 = v50[v47];
        else
            print("Your code didn\'t work idiot StyleStartZone=", v49, "Mode=", p46);
            v51 = p45.MapInfo.Zone.Start[l__MODE_MAIN__11];
        end;
        if v51 then
            if v48 then
                l__Phys__68:SetPosition(v48.Position);
                l__Phys__68:SetVelocity(v51.Velocity);
                p45.Simulation.Camera:SetAngles(v48.Angles);
            else
                l__Phys__68:SetPosition(l__Phys__68.World:GetPartCFrame(v51, l__Phys__68.World.Timer:Time(l__Phys__68.Time)) * l__new__47(0, -v51.Size.y / 2, 0) + l__new__47(0, l__Phys__68.HalfSize.y, 0));
                l__Phys__68:SetVelocity(v51.Velocity);
            end;
        else
            u5("Can\'t reset if no zone exists for Mode=", p46);
        end;
    else
        print("Cannot reset before simulation ready");
    end;
end;
function v18.SetSpawn(p52) --[[ Line: 327 ]]
    -- upvalues: u5 (copy)
    if not p52.Simulation.Ready then
        u5("SetSpawn called before simulation ready");
        return;
    end;
    if p52.Zones.VState then
        u5("SetSpawn called while timer is running");
        return;
    end;
    local v53 = nil;
    for _, v54 in p52.Zones.InZones do
        if v54.Type == "Start" then
            v53 = v54.Mode;
            break;
        end;
    end;
    if v53 == nil then
        u5("SetSpawn called but not in a Start zone");
    else
        p52.SetSpawns[v53] = {
            Position = p52.Simulation.Phys.Position,
            Angles = p52.Simulation.Camera.Angles
        };
    end;
end;
function v18.Spawn(p55, p56, p57) --[[ Line: 353 ]]
    -- upvalues: l__new__47 (copy), u5 (copy)
    local l__Phys__69 = p55.Simulation.Phys;
    if p56 then
        p55.SpawnId = p56;
    end;
    local l__Spawn__70 = p55.MapInfo.Spawn;
    if l__Spawn__70 then
        local v58 = l__Spawn__70[p56 or p55.SpawnId];
        if not v58 then
            u5("Spawn does not exist SpawnId=", p56 or p55.SpawnId);
            return;
        end;
        local l__GameMechanics__71 = l__Phys__69.GameMechanics;
        l__GameMechanics__71.JumpPart = nil;
        l__GameMechanics__71.JumpCount = nil;
        l__Phys__69:SetPosition(l__Phys__69.World:GetPartCFrame(v58, l__Phys__69.World.Timer:Time(l__Phys__69.Time)) * l__new__47(0, v58.Size.y / 2, 0) + l__new__47(0, l__Phys__69.HalfSize.y, 0));
        if p57 then
            l__Phys__69:SetVelocity(v58.Velocity);
        end;
    else
        u5("Spawn called but there are no spawns.");
    end;
end;
local function u61(p59, p60) --[[ Line: 380 ]]
    local l__SpawnId__72 = p60.SpawnId;
    local l__GameMechanics__73 = p59.GameMechanics;
    if l__GameMechanics__73.AutoRestart then
        l__GameMechanics__73:Reset();
    else
        l__GameMechanics__73:Spawn(l__SpawnId__72);
    end;
end;
local u81 = {
    Trigger = function(p62, p63) --[[ Name: Trigger, Line 385 ]]
        local l__GameMechanics__74 = p62.GameMechanics;
        if l__GameMechanics__74.AutoRestart then
            l__GameMechanics__74:Reset();
        else
            if p63 < l__GameMechanics__74.SpawnId then
                p63 = l__GameMechanics__74.SpawnId;
            end;
            l__GameMechanics__74:Spawn(p63);
        end;
    end,
    ForceTrigger = function(p64, p65) --[[ Name: ForceTrigger, Line 371 ]]
        local l__GameMechanics__75 = p64.GameMechanics;
        if l__GameMechanics__75.AutoRestart then
            l__GameMechanics__75:Reset();
        else
            l__GameMechanics__75:Spawn(p65);
        end;
    end,
    Teleport = function(p66, p67) --[[ Name: Teleport, Line 397 ]]
        local l__GameMechanics__76 = p66.GameMechanics;
        local l__SpawnId__77 = l__GameMechanics__76.SpawnId;
        if p67 < l__SpawnId__77 then
            p67 = l__SpawnId__77;
        end;
        l__GameMechanics__76:Spawn(p67);
    end,
    ForceTeleport = function(p68, p69) --[[ Name: ForceTeleport, Line 405 ]]
        p68.GameMechanics:Spawn(p69);
    end,
    WormholeIn = function(p70, p71, p72) --[[ Name: WormholeIn, Line 408 ]]
        -- upvalues: l__ToAxisAngle__51 (copy), l__Inverse__50 (copy), l__PointToObjectSpace__52 (copy), l__VectorToWorldSpace__53 (copy), l__VectorToObjectSpace__54 (copy), l__GetPartVelocityAtPointImplicit__38 (copy), l__EVENT_CAMERA_TRANSFORM__27 (copy)
        local l__GameMechanics__78 = p70.GameMechanics;
        local l__Part__79 = p72.Part;
        local v73 = l__GameMechanics__78.MapInfo.WormholeOut[p71];
        if l__Part__79 and v73 then
            local l__Time__80 = p70.Time;
            local l__World__81 = p70.World;
            local v74 = l__World__81.Timer:Time(l__Time__80);
            local v75 = l__World__81:GetPartCFrame(l__Part__79, v74);
            local v76 = l__World__81:GetPartCFrame(v73, v74);
            local v77, v78 = l__ToAxisAngle__51(l__Inverse__50(v75) * v76);
            local l__Position__82 = p70.Position;
            local v79 = v76 * (l__PointToObjectSpace__52(v75, l__Position__82) * (v73.Size / l__Part__79.Size));
            local v80 = l__VectorToWorldSpace__53(v76, l__VectorToObjectSpace__54(v75, p70.Velocity - l__GetPartVelocityAtPointImplicit__38(l__World__81, l__Part__79, l__Position__82, v74))) + l__GetPartVelocityAtPointImplicit__38(l__World__81, v73, v79, v74);
            l__GameMechanics__78:WrapCameraEvent(l__Time__80, l__EVENT_CAMERA_TRANSFORM__27, v77 * v78);
            p70:SetPosition(v79);
            p70:SetVelocity(v80);
        end;
    end
};
local u82 = {
    Water = true,
    Accelerator = true,
    WormholeOut = true
};
local function u84(_, p83) --[[ Line: 479 ]]
    -- upvalues: u82 (copy)
    local l__CanCollide__83 = p83.CanCollide;
    if l__CanCollide__83 then
        l__CanCollide__83 = not u82[p83.Name];
    end;
    return l__CanCollide__83;
end;
local function u91(p85, p86, p87, _, p88, _) --[[ Line: 483 ]]
    -- upvalues: l__FLYMODE_FLY__13 (copy), u82 (copy), l__Analyze__45 (copy), u13 (copy)
    if p85.FlyMode == l__FLYMODE_FLY__13 and (p85.StyleInfo.allow_noclip ~= false and p85.GameControls.Sprint) then
        return false;
    end;
    local l__CanCollide__84 = p86.CanCollide;
    if l__CanCollide__84 then
        l__CanCollide__84 = not u82[p86.Name];
    end;
    if not l__CanCollide__84 then
        return false;
    end;
    if not p87 then
        local v89, v90;
        v89, p88, v90 = l__Analyze__45(u13, p86);
    end;
    return p88 == nil;
end;
local function u95(p92) --[[ Line: 498 ]]
    -- upvalues: u1 (copy)
    local l__GameMechanics__85 = p92.GameMechanics;
    local l__IsPhysicsPart__86 = l__GameMechanics__85.IsPhysicsPart;
    for v93, v94 in u1, p92.Contacts do
        if v94.Normal.y > 0.75 and (v93.Name ~= "Surf" and l__IsPhysicsPart__86(l__GameMechanics__85, v93)) then
            return v94;
        end;
    end;
end;
local function u101(p96, p97) --[[ Line: 507 ]]
    -- upvalues: u1 (copy)
    local l__GameMechanics__87 = p96.GameMechanics;
    local l__IsPhysicsPart__88 = l__GameMechanics__87.IsPhysicsPart;
    local v98 = nil;
    for v99, v100 in u1, p96.Contacts do
        if v100.Normal.y <= 0.75 and (p97 or v99.Name == "Ladder") and (l__IsPhysicsPart__88(l__GameMechanics__87, v99) and (not v98 or v98.Time < v100.Time)) then
            v98 = v100;
        end;
    end;
    return v98;
end;
local u102 = {};
local u103 = {};
local function u110(p104, p105) --[[ Line: 552 ]]
    -- upvalues: u1 (copy), l__clear__8 (copy), u102 (copy), u103 (copy), l__GetPartVelocityAtPointImplicit__38 (copy), l__push__40 (copy)
    if not u1(p104.Contacts) then
        return p105;
    end;
    l__clear__8(u102);
    l__clear__8(u103);
    local l__GameMechanics__89 = p104.GameMechanics;
    local l__IsPhysicsPart__90 = l__GameMechanics__89.IsPhysicsPart;
    local l__World__91 = p104.World;
    local v106 = l__World__91.Timer:Time(p104.Time);
    local v107 = 0;
    for v108, v109 in p104.Contacts do
        if l__IsPhysicsPart__90(l__GameMechanics__89, v108) then
            v107 = v107 + 1;
            u102[v107] = v109.Normal;
            u103[v107] = l__GetPartVelocityAtPointImplicit__38(l__World__91, v108, v109.Position, v106);
        end;
    end;
    return l__push__40(u103, u102, u102, p105);
end;
local u111 = {};
local u112 = {};
local function u120(p113, p114) --[[ Line: 576 ]]
    -- upvalues: u1 (copy), l__clear__8 (copy), u111 (copy), u112 (copy), l__GetPartImplicitAcceleration__37 (copy), u2 (copy), l__push__40 (copy)
    if not u1(p113.Contacts) then
        return p114;
    end;
    l__clear__8(u111);
    l__clear__8(u112);
    local l__GameMechanics__92 = p113.GameMechanics;
    local l__IsPhysicsPart__93 = l__GameMechanics__92.IsPhysicsPart;
    local l__World__94 = p113.World;
    local v115 = l__World__94.Timer:Time(p113.Time);
    local v116 = 0;
    for v117, v118 in p113.Contacts do
        if l__IsPhysicsPart__93(l__GameMechanics__92, v117) then
            v116 = v116 + 1;
            u111[v116] = v118.Normal;
            local v119 = l__GetPartImplicitAcceleration__37(l__World__94, v117, v115);
            if u2(v119) == "CFrame" then
                v119 = v119.p;
            end;
            u112[v116] = v119;
        end;
    end;
    return l__push__40(u112, u111, u111, p114);
end;
local function u126(p121) --[[ Line: 612 ]]
    -- upvalues: l__cos__3 (copy), l__sin__4 (copy), l__new__47 (copy), u14 (copy)
    local l__GameControls__95 = p121.GameControls;
    local v122 = (l__GameControls__95.MoveRight and 1 or 0) - (l__GameControls__95.MoveLeft and 1 or 0);
    local v123 = (l__GameControls__95.MoveBack and 1 or 0) - (l__GameControls__95.MoveForward and 1 or 0);
    if v122 == 0 and v123 == 0 then
        return u14, true;
    end;
    local l__y__96 = p121.Simulation.Camera.Angles.y;
    local v124 = l__cos__3(l__y__96);
    local v125 = l__sin__4(l__y__96);
    return l__new__47(v122 * v124 + v123 * v125, 0, v123 * v124 - v122 * v125).unit, false;
end;
local function u139(p127, p128) --[[ Line: 624 ]]
    -- upvalues: l__cos__3 (copy), l__sin__4 (copy), l__new__47 (copy), u14 (copy)
    local l__StyleInfo__97 = p127.StyleInfo;
    local v129 = l__StyleInfo__97 and l__StyleInfo__97.keys;
    if v129 then
        local l__w__98 = v129.w;
        local l__a__99 = v129.a;
        local l__q__100 = v129.q;
        local l__e__101 = v129.e;
        local l__s__102 = v129.s;
        local l__d__103 = v129.d;
        local l__GameControls__104 = p127.GameControls;
        local l__MoveForward__105 = l__GameControls__104.MoveForward;
        local l__MoveLeft__106 = l__GameControls__104.MoveLeft;
        local l__MoveDown__107 = l__GameControls__104.MoveDown;
        local l__MoveUp__108 = l__GameControls__104.MoveUp;
        local l__MoveBack__109 = l__GameControls__104.MoveBack;
        local l__MoveRight__110 = l__GameControls__104.MoveRight;
        if (not l__StyleInfo__97.total or l__StyleInfo__97.total == (l__MoveForward__105 and l__w__98 and l__w__98 or 0) + (l__MoveLeft__106 and l__a__99 and l__a__99 or 0) + (l__MoveDown__107 and l__q__100 and l__q__100 or 0) + (l__MoveUp__108 and l__e__101 and l__e__101 or 0) + (l__MoveBack__109 and l__s__102 and l__s__102 or 0) + (l__MoveRight__110 and l__d__103 and l__d__103 or 0)) and ((l__w__98 ~= 2 or l__MoveForward__105) and ((l__a__99 ~= 2 or l__MoveLeft__106) and ((l__q__100 ~= 2 or l__MoveDown__107) and ((l__e__101 ~= 2 or l__MoveUp__108) and ((l__s__102 ~= 2 or l__MoveBack__109) and (l__d__103 ~= 2 or l__MoveRight__110)))))) then
            local v130 = ((l__d__103 == 0 or not l__MoveRight__110) and 0 or 1) - ((l__a__99 == 0 or not l__MoveLeft__106) and 0 or 1);
            local v131 = ((l__e__101 == 0 or not l__MoveUp__108) and 0 or 1) - ((l__q__100 == 0 or not l__MoveDown__107) and 0 or 1);
            local v132 = ((l__s__102 == 0 or not l__MoveBack__109) and 0 or 1) - ((l__w__98 == 0 or not l__MoveForward__105) and 0 or 1);
            if v130 ~= 0 or (v132 ~= 0 or l__StyleInfo__97.use_3d_strafe and v131 ~= 0) then
                local l__Angles__111 = p127.Simulation.Camera.Angles;
                local l__y__112 = l__Angles__111.y;
                local v133 = l__cos__3(l__y__112);
                local v134 = l__sin__4(l__y__112);
                local v135;
                if l__StyleInfo__97.use_3d_strafe then
                    local l__x__113 = l__Angles__111.x;
                    local v136 = l__cos__3(l__x__113);
                    local v137 = l__sin__4(l__x__113);
                    v135 = l__new__47(v132 * v136 * v134 + v131 * v137 * v134 + v130 * v133, v131 * v136 - v132 * v137, v132 * v136 * v133 + v131 * v133 * v137 - v130 * v134).unit;
                else
                    v135 = l__new__47(v130 * v133 + v132 * v134, 0, v132 * v133 - v130 * v134).unit;
                end;
                local l__allow_strafe_dir__114 = l__StyleInfo__97.allow_strafe_dir;
                if not l__allow_strafe_dir__114 then
                    return v135, false;
                end;
                local v138 = Vector2.new(v135.x * p128.x + v135.z * p128.z, v135.x * p128.z - v135.z * p128.x):Dot(l__allow_strafe_dir__114);
                if v138 == 0 or v138 < 0 and not l__MoveLeft__106 or v138 > 0 and not l__MoveRight__110 then
                    return v135, false;
                end;
            end;
        end;
    end;
    return u14, true;
end;
local function u153(p140, p141) --[[ Line: 667 ]]
    -- upvalues: l__cos__3 (copy), l__sin__4 (copy), l__new__47 (copy), l__sqrt__5 (copy), l__Dot__48 (copy), l__Cross__49 (copy), u14 (copy)
    local l__GameControls__115 = p140.GameControls;
    local v142 = (l__GameControls__115.MoveRight and 1 or 0) - (l__GameControls__115.MoveLeft and 1 or 0);
    local v143 = (l__GameControls__115.MoveUp and 1 or 0) - (l__GameControls__115.MoveDown and 1 or 0);
    local v144 = (l__GameControls__115.MoveBack and 1 or 0) - (l__GameControls__115.MoveForward and 1 or 0);
    local v145 = v142 * v142 + v143 * v143 + v144 * v144;
    if v145 == 0 then
        return u14, true;
    else
        local l__Angles__116 = p140.Simulation.Camera.Angles;
        local l__x__117 = l__Angles__116.x;
        local l__y__118 = l__Angles__116.y;
        local v146 = l__cos__3(l__x__117);
        local v147 = l__sin__4(l__x__117);
        local v148 = l__cos__3(l__y__118);
        local v149 = l__sin__4(l__y__118);
        local v150 = l__new__47(v144 * v146 * v149 + v143 * v147 * v149 + v142 * v148, v143 * v146 - v144 * v147, v144 * v146 * v148 + v143 * v148 * v147 - v142 * v149);
        local v151 = l__sqrt__5(v145);
        local v152 = l__Dot__48(p141, v150) / v151;
        if v152 < -0.7071067811865476 then
            v150 = Vector3.new(0, 1, 0) * v151;
            v152 = l__Dot__48(p141, Vector3.new(0, 1, 0));
        elseif v152 > 0.7071067811865476 then
            v150 = Vector3.new(0, 1, 0) * -v151;
            v152 = -l__Dot__48(p141, Vector3.new(0, 1, 0));
        end;
        if v152 * v152 == 1 then
            return u14, true;
        else
            return l__Cross__49(l__Cross__49(p141, v150), p141) / l__sqrt__5(1 - v152 * v152), false;
        end;
    end;
end;
local function u163(p154) --[[ Line: 697 ]]
    -- upvalues: u14 (copy), l__cos__3 (copy), l__sin__4 (copy), l__new__47 (copy)
    local l__GameControls__119 = p154.GameControls;
    local v155 = (l__GameControls__119.MoveRight and 1 or 0) - (l__GameControls__119.MoveLeft and 1 or 0);
    local v156 = (l__GameControls__119.MoveUp and 1 or 0) - (l__GameControls__119.MoveDown and 1 or 0);
    local v157 = (l__GameControls__119.MoveBack and 1 or 0) - (l__GameControls__119.MoveForward and 1 or 0);
    local v158 = u14;
    if v155 ~= 0 or (v156 ~= 0 or v157 ~= 0) then
        local l__Angles__120 = p154.Simulation.Camera.Angles;
        local l__x__121 = l__Angles__120.x;
        local l__y__122 = l__Angles__120.y;
        local v159 = l__cos__3(l__x__121);
        local v160 = l__sin__4(l__x__121);
        local v161 = l__cos__3(l__y__122);
        local v162 = l__sin__4(l__y__122);
        v158 = l__new__47(v157 * v159 * v162 + v156 * v160 * v162 + v155 * v161, v156 * v159 - v157 * v160, v157 * v159 * v161 + v156 * v161 * v160 - v155 * v162).unit;
    end;
    return v158;
end;
local function u173(p164, p165, p166) --[[ Line: 713 ]]
    -- upvalues: u14 (copy), l__GetPartVelocityAtPointImplicit__38 (copy), l__GetPartVelocityAtPointExplicit__39 (copy), l__Dot__48 (copy), u110 (copy)
    local v167 = p166 or Vector3.new(0, 1, 0);
    local l__GameMechanics__123 = p164.GameMechanics;
    local v168 = u14;
    local v169 = u14;
    if p165 then
        local l__World__124 = p164.World;
        local v170 = l__World__124.Timer:Time(p164.Time);
        v168 = l__GetPartVelocityAtPointImplicit__38(l__World__124, p165, p164.Position, v170);
        v169 = l__GetPartVelocityAtPointExplicit__39(l__World__124, p165, p164.Position, v170);
    end;
    local l__Velocity__125 = p164.Velocity;
    local v171 = l__Velocity__125 - v168 + v169;
    local v172 = l__Dot__48(v171, v167);
    local l__JumpVelocity__126 = l__GameMechanics__123.JumpVelocity;
    if v172 < l__JumpVelocity__126 then
        return u110(p164, v168 + v171 + (l__JumpVelocity__126 - v172) * v167);
    end;
    if v169 ~= u14 then
        return u110(p164, l__Velocity__125 + v169);
    end;
end;
local function u181(p174, p175, p176, p177) --[[ Line: 763 ]]
    -- upvalues: l__match__7 (copy), u3 (copy), u173 (copy)
    local l__GameMechanics__127 = p174.GameMechanics;
    local v178 = p175 and u3(l__match__7(p175.Name, "^Jump(%d+)$"));
    if v178 then
        local v179 = 1;
        if l__GameMechanics__127.JumpPart == p175 then
            v179 = l__GameMechanics__127.JumpCount + 1;
        else
            l__GameMechanics__127.JumpPart = p175;
        end;
        if v178 < v179 then
            local l__GameMechanics__128 = p174.GameMechanics;
            if l__GameMechanics__128.AutoRestart then
                l__GameMechanics__128:Reset();
                return;
            else
                l__GameMechanics__128:Spawn(nil);
                return;
            end;
        end;
        l__GameMechanics__127.JumpCount = v179;
    end;
    local v180 = u173(p174, p175, p176);
    if v180 then
        p174:SetVelocity(v180);
        if p175 then
            l__GameMechanics__127:WrapSoundEvent(p174.Time, p177, p175.Material.Value);
        end;
    end;
end;
local function u184(p182, p183) --[[ Line: 798 ]]
    -- upvalues: u181 (copy)
    u181(p182, p183.Part, p183.Normal, p183.Sound);
end;
local function u239(p185, p186, p187) --[[ Line: 802 ]]
    -- upvalues: l__FLYMODE_FLY__13 (copy), u163 (copy), u120 (copy), u14 (copy), u110 (copy), u1 (copy), l__difference__44 (copy), l__makeQueryFuncFromPart__43 (copy), l__GetPartVelocityAtPointExplicit__39 (copy), l__new__47 (copy), u101 (copy), u95 (copy), u126 (copy), l__Dot__48 (copy), l__GetPartVelocityAtPointImplicit__38 (copy), l__FLYMODE_NONE__12 (copy), u173 (copy), l__SOUND_JUMP_GROUND__31 (copy), l__SOUND_JUMP_LADDER__32 (copy), u153 (copy), u5 (copy), l__sqrt__5 (copy)
    local l__GameMechanics__129 = p185.GameMechanics;
    local l__MapInfo__130 = l__GameMechanics__129.MapInfo;
    local l__Position__131 = p185.Position;
    local l__Time__132 = p185.Time;
    if l__Position__131.y + p185.HalfSize.y < l__MapInfo__130.MinY then
        p185:ConsiderPhysicsEvent("ForceTrigger", l__Time__132);
        return;
    end;
    if l__GameMechanics__129.FlyMode == l__FLYMODE_FLY__13 then
        local v188 = u163(l__GameMechanics__129);
        local l__FlySpeed__133 = l__GameMechanics__129.FlySpeed;
        local l__GameControls__134 = l__GameMechanics__129.GameControls;
        local l__StyleInfo__135 = l__GameMechanics__129.StyleInfo;
        if l__StyleInfo__135.allow_crouch == false or (not l__GameControls__134.Crouch or l__GameControls__134.Sprint) then
            if l__StyleInfo__135.allow_sprint ~= false and (l__GameControls__134.Sprint and not l__GameControls__134.Crouch) then
                l__FlySpeed__133 = l__FlySpeed__133 * 5;
            end;
        else
            l__FlySpeed__133 = l__FlySpeed__133 * 0.2;
        end;
        if l__StyleInfo__135.fly_acceleration then
            p185.Acceleration = u120(p185, v188 * l__StyleInfo__135.fly_acceleration);
        else
            p185.Acceleration = u14;
        end;
        p185:SetVelocity(u110(p185, v188 * l__FlySpeed__133));
        if l__GameMechanics__129.Track then
            l__GameMechanics__129.Track = nil;
            l__GameMechanics__129.TrackType = MOVE_AIR;
            l__GameMechanics__129.TrackDistance = 0;
        end;
        return;
    end;
    local l__Gravity__136 = p185.Gravity;
    local l__World__137 = p185.World;
    local v189 = l__World__137.Timer:Time(l__Time__132);
    for v190, _ in u1, p185.Contacts do
        if v190.Name == "Accelerator" and l__difference__44(function() --[[ Line: 82 ]]
            -- upvalues: l__Position__131 (copy)
            return l__Position__131;
        end, 0, l__makeQueryFuncFromPart__43(v190, (l__World__137:GetPartCFrame(v190, v189))), 0, 0, true) then
            l__Gravity__136 = l__Gravity__136 + l__GetPartVelocityAtPointExplicit__39(l__World__137, v190, l__Position__131, v189);
        end;
    end;
    local v191 = false;
    local v192 = nil;
    local l__rocket_force__138 = l__GameMechanics__129.StyleInfo.rocket_force;
    local v193, v194;
    if l__rocket_force__138 then
        v193 = u163(l__GameMechanics__129);
        v194 = l__Gravity__136 + l__rocket_force__138 * v193;
    else
        v194 = l__Gravity__136;
        v193 = nil;
    end;
    for v195, v196 in u1, p185.Contacts do
        if v195.Name == "Water" then
            if not v191 then
                v191 = true;
                v193 = v193 or u163(l__GameMechanics__129);
                if l__GameMechanics__129.GameControls.Jump then
                    v193 = l__new__47(v193.x, 1, v193.z);
                end;
            end;
            if l__difference__44(function() --[[ Line: 82 ]]
                -- upvalues: l__Position__131 (copy)
                return l__Position__131;
            end, 0, l__makeQueryFuncFromPart__43(v195, (l__World__137:GetPartCFrame(v195))), 0, 0, true) then
                local v197, v198;
                if v195.CustomPhysicalProperties then
                    v197 = v195.CustomPhysicalProperties.Friction;
                    v198 = v195.CustomPhysicalProperties.Density;
                else
                    v198 = 1;
                    v197 = 0.1;
                end;
                local v199 = p185.Velocity - l__GetPartVelocityAtPointExplicit__39(l__World__137, v195, l__Position__131, v189);
                local v200 = v197 * v199.magnitude;
                v194 = v194 - v198 / l__GameMechanics__129.Density * l__Gravity__136 - v200 / (1 + v200 * p186) * v199 + v198 * 12 * v193;
                v192 = v196;
            end;
        end;
    end;
    local v201 = u120(p185, v194);
    local v202 = v201 - v194;
    local v203 = nil;
    local v204 = nil;
    local v205 = u101;
    if v191 then
        v191 = not v192;
    end;
    local v206 = v205(p185, v191);
    local v207 = u95(p185);
    if v207 and v206 then
        if not v203 then
            v203, v204 = u126(l__GameMechanics__129);
        end;
        if l__Dot__48(v203, v206.Normal) < 0 then
            v207 = nil;
        else
            v206 = nil;
        end;
    end;
    local v208 = nil;
    local v209 = nil;
    local v210 = nil;
    local v211 = nil;
    local v212 = nil;
    if v207 then
        v211 = v207.Part;
        v212 = v207.Normal;
        local v213 = l__GetPartVelocityAtPointImplicit__38(l__World__137, v211, l__Position__131, v189);
        local v214 = p185.Velocity - v213;
        local l__allow_jump__139 = l__GameMechanics__129.StyleInfo.allow_jump;
        if l__allow_jump__139 then
            if l__GameMechanics__129.FlyMode == l__FLYMODE_NONE__12 then
                local v215 = p187 and (p187.Type == "Jump" or p187.Type ~= "TickEnd" and l__GameMechanics__129.StyleInfo.autohop == false) and true or l__Dot__48(v214, v212) > 0.003;
                l__allow_jump__139 = not v215;
            else
                l__allow_jump__139 = false;
            end;
        end;
        if l__allow_jump__139 then
            local v216;
            if l__GameMechanics__129.GameControls.Jump then
                local l__StyleInfo__140 = l__GameMechanics__129.StyleInfo;
                if l__StyleInfo__140 and l__StyleInfo__140.autohop == false then
                    l__GameMechanics__129.JumpDebounce = true;
                    v216 = true;
                else
                    v216 = true;
                end;
            else
                v216 = false;
            end;
            if not v216 then
                if v211.Name == "Platform" and l__GameMechanics__129.StyleInfo.platform_stand_time then
                    p185:ConsiderPhysicsEvent("ForceTrigger", v207.Time + l__GameMechanics__129.StyleInfo.platform_stand_time);
                end;
                if not v203 then
                    v203, v204 = u126(l__GameMechanics__129);
                end;
                if not v204 then
                    v203 = (v203 - l__Dot__48(v203, v212) / v212.y * Vector3.new(0, 1, 0)).unit;
                end;
                v210 = v203 * 18;
                if l__Dot__48(v214, v214) > 327.24 then
                    v209 = 3 * l__Dot__48(v212, v202);
                else
                    v209 = 2 * l__Dot__48(v212, v202);
                    v208 = true;
                end;
            end;
            local v217 = u173(p185, v211, Vector3.new(0, 1, 0));
            if v217 then
                v217 = l__Dot__48(v217 - v213, v212) > 0.003;
            end;
            local v218 = v217 and p185:ConsiderPhysicsEvent("Jump", l__Time__132);
            if v218 then
                v218.Part = v211;
                v218.Sound = l__SOUND_JUMP_GROUND__31;
            end;
            l__GameMechanics__129.AllowStrafe = true;
        else
            if v211.Name == "Platform" and l__GameMechanics__129.StyleInfo.platform_stand_time then
                p185:ConsiderPhysicsEvent("ForceTrigger", v207.Time + l__GameMechanics__129.StyleInfo.platform_stand_time);
            end;
            if not v203 then
                v203, v204 = u126(l__GameMechanics__129);
            end;
            if not v204 then
                v203 = (v203 - l__Dot__48(v203, v212) / v212.y * Vector3.new(0, 1, 0)).unit;
            end;
            v210 = v203 * 18;
            if l__Dot__48(v214, v214) > 327.24 then
                v209 = 3 * l__Dot__48(v212, v202);
            else
                v209 = 2 * l__Dot__48(v212, v202);
                v208 = true;
            end;
        end;
    elseif v206 then
        v211 = v206.Part;
        v212 = v206.Normal;
        local v219 = l__GetPartVelocityAtPointImplicit__38(l__World__137, v211, l__Position__131, v189);
        local v220 = p185.Velocity - v219;
        local l__allow_jump__141 = l__GameMechanics__129.StyleInfo.allow_jump;
        if l__allow_jump__141 then
            if l__GameMechanics__129.FlyMode == l__FLYMODE_NONE__12 then
                local v221 = p187 and (p187.Type == "Jump" or p187.Type ~= "TickEnd" and l__GameMechanics__129.StyleInfo.autohop == false) and true or l__Dot__48(v220, v212) > 0.003;
                l__allow_jump__141 = not v221;
            else
                l__allow_jump__141 = false;
            end;
        end;
        local v222, v223;
        if l__allow_jump__141 then
            local v224;
            if l__GameMechanics__129.GameControls.Jump then
                v224 = l__GameMechanics__129.StyleInfo;
                if v224 and v224.autohop == false then
                    l__GameMechanics__129.JumpDebounce = true;
                end;
                local l__JumpEdge__142 = l__GameMechanics__129.JumpEdge;
                if l__JumpEdge__142 then
                    v224 = l__JumpEdge__142;
                elseif v224 then
                    v224 = v224.scroll_jump;
                end;
            else
                v224 = false;
            end;
            if not v224 then
                v222, v223 = u153(l__GameMechanics__129, v212);
                v210 = v222 * 18;
                v209 = 180;
            end;
            local v225 = u173(p185, v211, v212);
            if v225 then
                v225 = l__Dot__48(v225 - v219, v212) > 0.003;
            end;
            local v226 = v225 and p185:ConsiderPhysicsEvent("Jump", l__Time__132);
            if v226 then
                v226.Part = v211;
                v226.Normal = v212;
                v226.Sound = l__SOUND_JUMP_LADDER__32;
            end;
            l__GameMechanics__129.AllowStrafe = true;
        else
            v222, v223 = u153(l__GameMechanics__129, v212);
            v210 = v222 * 18;
            v209 = 180;
        end;
    else
        l__GameMechanics__129.AllowStrafe = true;
    end;
    if v209 and v209 > 0 then
        local v227 = l__GetPartVelocityAtPointImplicit__38(l__World__137, v211, l__Position__131, v189);
        local v228 = v210 - (p185.Velocity - v227);
        local v229 = l__Dot__48(v212, v228);
        if v229 < 0 then
            v228 = v228 - v212 * v229;
        end;
        if v228.y > 0 and l__GameMechanics__129.debugEvents then
            u5("Illegal TargetVelocityDelta Normal=", v212, "Out-of-plane dot=", v229);
        end;
        local v230 = v228:Dot(v228);
        local v231 = v201:Dot(v228);
        local v232 = v201:Dot(v201);
        local v233 = v232 - v209 * v209;
        if v231 * v231 < v230 * v233 then
            if v232 > 1e-6 then
                v201 = u120(p185, v201 - v209 * v201.unit);
            end;
        else
            local v234 = v230 < 1e-6 and 0 or (v231 + l__sqrt__5(v231 * v231 - v230 * v233)) / v230;
            local l__magnitude__143 = v228.magnitude;
            local v235;
            if v208 and v234 * l__magnitude__143 > 90 then
                v235 = 90 / l__magnitude__143 * v228;
            else
                v235 = v234 * v228;
            end;
            if v235.y > 0 and l__GameMechanics__129.debugEvents then
                u5("Illegal acceleration");
            end;
            local l__magnitude__144 = v235.magnitude;
            local v236 = l__magnitude__144 <= 0 and 0 or l__magnitude__143 / l__magnitude__144;
            if p186 < v236 then
                v201 = u120(p185, v235);
            elseif l__GameMechanics__129.WalkSplitCount < 2 then
                l__GameMechanics__129.WalkSplitCount = l__GameMechanics__129.WalkSplitCount + 1;
                p185:ConsiderPhysicsEvent("Split", l__Time__132 + v236);
                v201 = u120(p185, v235);
            elseif p186 > 0 then
                v201 = u120(p185, v235 * v236 / p186);
            end;
        end;
    else
        l__GameMechanics__129.AllowStrafe = true;
    end;
    if v194 ~= p185.EffectiveGravity then
        p185.EffectiveGravity = v194;
        l__GameMechanics__129.Simulation.OutputMulticall:Call("Gravity", l__Time__132, v194);
    end;
    p185.Acceleration = v201;
    l__GameMechanics__129.Strafed = nil;
    local v237 = nil;
    local v238 = MOVE_AIR;
    if v206 then
        v207 = v206;
        v238 = 1;
    elseif v192 then
        v207 = v192;
        v238 = 2;
    elseif v207 then
        v238 = 3;
    else
        v207 = v237;
    end;
    l__GameMechanics__129.Track = v207;
    if l__GameMechanics__129.TrackType ~= v238 then
        l__GameMechanics__129.TrackType = v238;
        l__GameMechanics__129.TrackDistance = 0;
    end;
end;
local function u252(p240, p241) --[[ Line: 1112 ]]
    -- upvalues: u163 (copy), u139 (copy), u110 (copy), l__Dot__48 (copy), u14 (copy), l__Cross__49 (copy), l__atan2__2 (copy), l__abs__1 (copy), l__max__6 (copy)
    local l__Time__145 = p240.Time;
    local l__GameMechanics__146 = p240.GameMechanics;
    local l__StyleInfo__147 = l__GameMechanics__146.StyleInfo;
    local v242;
    if l__StyleInfo__147.fly_turn_penalty or l__StyleInfo__147.fly_acceleration then
        v242 = u163(l__GameMechanics__146);
    else
        v242 = nil;
    end;
    l__GameMechanics__146.Simulation.Camera:Advance(l__GameMechanics__146:GetMousePos(l__Time__145), l__Time__145);
    if l__StyleInfo__147.fly_acceleration then
        l__GameMechanics__146.FlySpeed = l__GameMechanics__146.FlySpeed + l__StyleInfo__147.fly_acceleration * p241;
    end;
    if p240.PhysicsEvent.Type == "TickEnd" then
        l__GameMechanics__146:PropagateControls();
        if l__GameMechanics__146.AllowStrafe and l__StyleInfo__147.allow_strafe ~= false then
            local v243, v244 = u139(l__GameMechanics__146, p240.Velocity);
            if not v244 then
                local v245;
                if l__StyleInfo__147.air_accel then
                    v245 = l__StyleInfo__147.air_accel * p241;
                else
                    v245 = nil;
                end;
                local v246 = u110;
                local l__Velocity__148 = p240.Velocity;
                local v247 = l__Dot__48(l__Velocity__148, v243);
                if v247 < l__GameMechanics__146.StyleInfo.mv then
                    local v248 = l__GameMechanics__146.StyleInfo.mv - v247;
                    if v245 and v245 < v248 then
                        l__Velocity__148 = l__Velocity__148 + v245 * v243;
                    else
                        l__Velocity__148 = l__Velocity__148 + v248 * v243;
                    end;
                end;
                p240:SetVelocity(v246(p240, l__Velocity__148));
            end;
            l__GameMechanics__146.Strafed = true;
        else
            l__GameMechanics__146.Strafed = nil;
        end;
    end;
    local v249;
    if l__StyleInfo__147.fly_acceleration then
        v249 = u163(l__GameMechanics__146);
        if v249 == u14 then
            l__GameMechanics__146.FlySpeed = l__StyleInfo__147.fly_speed;
        end;
    else
        v249 = nil;
    end;
    if l__StyleInfo__147.fly_turn_penalty then
        local v250 = v249 or u163(l__GameMechanics__146);
        local v251 = l__abs__1((l__atan2__2(l__Cross__49(v242, v250).magnitude, (l__Dot__48(v242, v250)))));
        l__GameMechanics__146.FlySpeed = l__max__6(l__StyleInfo__147.fly_speed, l__GameMechanics__146.FlySpeed - v251 * l__StyleInfo__147.fly_turn_penalty);
    end;
end;
local function u254(p253, _) --[[ Line: 1155 ]]
    local l__GameMechanics__149 = p253.GameMechanics;
    l__GameMechanics__149.AllowStrafe = nil;
    l__GameMechanics__149.WalkSplitCount = 0;
    l__GameMechanics__149.JumpDebounce = nil;
end;
local l__Debris__150 = game:GetService("Debris");
local u255 = Instance.new("Part");
u255.Name = "DisplayPart";
u255.CanCollide = false;
u255.Anchored = true;
u255.Shape = Enum.PartType.Ball;
u255.Size = Vector3.new(0.2, 0.2, 0.2);
u255.BrickColor = BrickColor.new("Bright red");
local v256 = Instance.new("ConeHandleAdornment", u255);
v256.Name = "known";
v256.Adornee = u255;
v256.Radius = 0.05;
local v257 = Instance.new("Part", u255);
v257.Name = "Locator";
v257.Anchored = true;
v257.CanCollide = false;
v257.Transparency = 1;
local v258 = Instance.new("LineHandleAdornment", u255);
v258.Adornee = v257;
v258.Name = "Line";
local function u261(p259) --[[ Line: 1183 ]]
    -- upvalues: u255 (copy), l__Debris__150 (copy)
    if p259.Position then
        local v260 = u255:Clone();
        v260.CFrame = CFrame.new(Vector3.new(0, 0, 0), p259.Normal) + p259.Position;
        v260.Parent = workspace;
        if p259.Type == "CollisionStart" then
            if p259.Normal.y < 0.9999 then
                v260.known.Color = BrickColor.new("New Yeller");
            end;
        elseif p259.Type == "CollisionEnd" then
            v260.known.Color = BrickColor.new("Black");
        end;
        local l__Position__151 = p259.Part.Position;
        v260.Locator.CFrame = CFrame.new(p259.Position, l__Position__151);
        v260.Line.Length = (l__Position__151 - p259.Position).magnitude;
        l__Debris__150:AddItem(v260, 10);
    end;
end;
local function u275(p262, p263) --[[ Line: 1210 ]]
    -- upvalues: u5 (copy), u261 (copy), u101 (copy), u110 (copy), l__GetPartVelocityAtPointImplicit__38 (copy), l__SOUND_TRACK_LADDER__29 (copy), l__Analyze__45 (copy), u13 (copy), l__FLYMODE_NONE__12 (copy), u81 (copy), u95 (copy), l__Dot__48 (copy), l__GetPartVelocityAtPointExplicit__39 (copy), u82 (copy), u14 (copy), l__SOUND_SMASH_GROUND__33 (copy), l__Cross__49 (copy), l__SOUND_SMASH_WALL__34 (copy), l__EVENT_CAMERA_PUNCH__26 (copy), l__match__7 (copy), u3 (copy), l__EVENT_WORLD_BUTTON__23 (copy)
    local l__GameMechanics__152 = p262.GameMechanics;
    local l__Simulation__153 = l__GameMechanics__152.Simulation;
    local l__Part__154 = p263.Part;
    if l__GameMechanics__152.debugEvents then
        u5("CollisionStart Part=", l__Part__154, "Time=", p263.Time, "Normal=", p263.Normal);
        u261(p263);
    end;
    local l__Time__155 = p263.Time;
    local l__World__156 = p262.World;
    local v264 = l__World__156.Timer:Time(l__Time__155);
    if u101(p262) == p263 then
        p262:SetVelocity(u110(p262, l__GetPartVelocityAtPointImplicit__38(l__World__156, l__Part__154, p262.Position, v264)));
        l__GameMechanics__152:WrapSoundEvent(l__Time__155, l__SOUND_TRACK_LADDER__29, l__Part__154.Material.Value);
    else
        local v265, v266, v267 = l__Analyze__45(u13, l__Part__154);
        if v267 == "Zone" then
            if l__GameMechanics__152.Zones then
                l__GameMechanics__152.Zones:Enter(l__Part__154, v266, v265, l__Time__155, l__GameMechanics__152);
            end;
        else
            if v267 == "Runtime" and (l__GameMechanics__152.FlyMode == l__FLYMODE_NONE__12 or (l__GameMechanics__152.StyleInfo.allow_noclip == false or not l__GameMechanics__152.GameControls.Sprint)) then
                u81[v266](p262, v265, p263);
                return;
            end;
            if u95(p262) == p263 then
                local v268 = l__GetPartVelocityAtPointImplicit__38(l__World__156, l__Part__154, p262.Position, v264);
                if l__Dot__48(p262.Velocity - v268, p263.Normal) < 0.003 then
                    l__GameMechanics__152.AllowStrafe = false;
                end;
            end;
            local l__Name__157 = l__Part__154.Name;
            if l__Name__157 == "SetVelocity" then
                p262:SetVelocity(u110(p262, l__GetPartVelocityAtPointExplicit__39(l__World__156, l__Part__154, p262.Position, v264)));
            elseif not (u82[l__Name__157] or l__Part__154.CanCollide) then
                p262:SetVelocity(u110(p262, p262.Velocity + l__GetPartVelocityAtPointExplicit__39(l__World__156, l__Part__154, p262.Position, v264)));
            end;
            if l__GameMechanics__152:IsPhysicsPart(l__Part__154, true, v265, v266, v267) then
                local l__Velocity__158 = p262.Velocity;
                local v269 = u110(p262, l__Velocity__158);
                if l__Name__157 == "Bounce" then
                    v269 = u110(p262, v269 + (not l__Part__154.CustomPhysicalProperties and 1 or l__Part__154.CustomPhysicalProperties.Elasticity) * (v269 - l__Velocity__158));
                end;
                p262:SetVelocity(v269);
                local v270 = v269 - l__Velocity__158;
                local l__y__159 = v270.y;
                local v271 = u14;
                local v272;
                if l__y__159 > 150 then
                    l__GameMechanics__152:WrapSoundEvent(l__Time__155, l__SOUND_SMASH_GROUND__33, l__Part__154.Material.Value);
                    v272 = l__Simulation__153.Camera:GetCFrame():VectorToObjectSpace(v270);
                    v271 = v271 + l__Cross__49(v272, Vector3.new(1, 0, 0)) / 30;
                else
                    v272 = nil;
                end;
                if l__Dot__48(v270, v270) - l__y__159 * l__y__159 > 22500 then
                    l__GameMechanics__152:WrapSoundEvent(l__Time__155, l__SOUND_SMASH_WALL__34, l__Part__154.Material.Value);
                    v271 = v271 + l__Cross__49(v272 or l__Simulation__153.Camera:GetCFrame():VectorToObjectSpace(v270), Vector3.new(0, 1, 0)) / 30;
                end;
                if v271 ~= u14 then
                    l__GameMechanics__152:WrapCameraEvent(l__Time__155, l__EVENT_CAMERA_PUNCH__26, v271);
                end;
            end;
            local v273 = u3(l__match__7(l__Name__157, "^Spawn(%d+)$")) or u3(l__match__7(l__Name__157, "^SpawnAt(%d+)$"));
            if v273 then
                if l__GameMechanics__152.SpawnId < v273 and (not l__Part__154.CanCollide or p263.Normal.y > 0.75) then
                    l__GameMechanics__152.SpawnId = v273;
                end;
                return;
            end;
            local v274 = u3(l__match__7(l__Name__157, "^ForceSpawnAt(%d+)$"));
            if v274 then
                if not l__Part__154.CanCollide or p263.Normal.y > 0.75 then
                    l__GameMechanics__152.SpawnId = v274;
                end;
                return;
            end;
            l__GameMechanics__152:WrapWorldEvent(l__Time__155, l__EVENT_WORLD_BUTTON__23, (u3(l__match__7(l__Name__157, "^Button(%d+)$"))));
        end;
    end;
end;
local function u281(p276, p277) --[[ Line: 1312 ]]
    -- upvalues: u5 (copy), u261 (copy), l__Analyze__45 (copy), u13 (copy)
    local l__Part__160 = p277.Part;
    if p276.GameMechanics.debugEvents then
        u5("CollisionEnd Part=", l__Part__160, "Time=", p277.Time, "Normal=", p277.Normal);
        u261(p277);
    end;
    local v278, v279, v280 = l__Analyze__45(u13, l__Part__160);
    if v280 == "Zone" then
        local l__GameMechanics__161 = p276.GameMechanics;
        if l__GameMechanics__161.Zones then
            l__GameMechanics__161.Zones:Leave(l__Part__160, v279, v278, p277.Time, l__GameMechanics__161);
        end;
    end;
end;
local function u286(p282, p283, _) --[[ Line: 1329 ]]
    local l__GameMechanics__162 = p282.GameMechanics;
    local l__Zones__163 = l__GameMechanics__162.Zones;
    if l__GameMechanics__162.StyleInfo.use_vstate then
        local v284 = p283.x * p283.x + p283.z * p283.z;
        local v285 = p283.y * p283.y;
        if l__Zones__163.VState then
            if v284 < 327.24 and (not l__GameMechanics__162.AllowStrafe or v284 == 0 and v285 == 0) and not l__GameMechanics__162.RequireExplicitRestart then
                l__Zones__163:SetVState(false, p282.Time, l__GameMechanics__162);
            end;
        elseif v284 > 330.48 or (l__GameMechanics__162.jv2 < v285 or l__GameMechanics__162.AllowStrafe and (v284 ~= 0 or v285 ~= 0)) then
            l__Zones__163:SetVState(true, p282.Time, l__GameMechanics__162);
        end;
    elseif l__Zones__163.VState then
        l__Zones__163:SetVState(false, p282.Time, l__GameMechanics__162);
    end;
end;
local function u294(p287, p288, p289) --[[ Line: 1351 ]]
    -- upvalues: l__GetPartVelocityAtPointImplicit__38 (copy), u16 (copy), u17 (copy)
    local l__GameMechanics__164 = p287.GameMechanics;
    local l__Track__165 = l__GameMechanics__164.Track;
    local l__TrackDistance__166 = l__GameMechanics__164.TrackDistance;
    local v290;
    if l__Track__165 then
        local l__Part__167 = l__Track__165.Part;
        local l__World__168 = p287.World;
        v290 = l__TrackDistance__166 + p288 * (p289 - l__GetPartVelocityAtPointImplicit__38(l__World__168, l__Part__167, p287.Position, l__World__168.Timer:Time(p287.Time))).magnitude;
    else
        v290 = l__TrackDistance__166 + p288 * p289.magnitude;
    end;
    local l__TrackType__169 = l__GameMechanics__164.TrackType;
    local v291 = u16[l__TrackType__169];
    if v291 and v291 < v290 then
        v290 = v290 % v291;
        local l__Time__170 = p287.Time;
        local v292 = u17[l__TrackType__169];
        local v293 = l__Track__165 and l__Track__165.Part;
        if v293 then
            v293 = l__Track__165.Part.Material.Value;
        end;
        l__GameMechanics__164:WrapSoundEvent(l__Time__170, v292, v293);
    end;
    l__GameMechanics__164.TrackDistance = v290;
end;
function v18.MakeTickInfo(p295) --[[ Line: 1373 ]]
    -- upvalues: l__TICKINFO_BIT_TICKEND__14 (copy), l__TICKINFO_BIT_JUMP__15 (copy), l__TICKINFO_BIT_STRAFE__16 (copy), u1 (copy), l__TICKINFO_BIT_TOUCHING__17 (copy)
    local l__Phys__171 = p295.Simulation.Phys;
    local v296 = 0;
    if l__Phys__171.PhysicsEvent ~= nil and l__Phys__171.PhysicsEvent.Type == "TickEnd" then
        v296 = v296 + l__TICKINFO_BIT_TICKEND__14;
    end;
    if l__Phys__171.PhysicsEvent ~= nil and l__Phys__171.PhysicsEvent.Type == "Jump" then
        v296 = v296 + l__TICKINFO_BIT_JUMP__15;
    end;
    if p295.Strafed then
        v296 = v296 + l__TICKINFO_BIT_STRAFE__16;
    end;
    local l__IsPhysicsPart__172 = p295.IsPhysicsPart;
    local v297 = false;
    for v298, _ in u1, l__Phys__171.Contacts do
        if l__IsPhysicsPart__172(p295, v298) then
            v297 = true;
            break;
        end;
    end;
    if v297 then
        v296 = v296 + l__TICKINFO_BIT_TOUCHING__17;
    end;
    return v296;
end;
local function u301(p299) --[[ Line: 1400 ]]
    local l__GameMechanics__173 = p299.GameMechanics;
    local l__Simulation__174 = l__GameMechanics__173.Simulation;
    local l__Time__175 = p299.Time;
    local v300 = l__GameMechanics__173:MakeTickInfo();
    local l__Angles__176 = l__Simulation__174.Camera.Angles;
    local l__Position__177 = p299.Position;
    local l__Velocity__178 = p299.Velocity;
    local l__Acceleration__179 = p299.Acceleration;
    if l__GameMechanics__173.LastOutputTime ~= l__Time__175 or (l__GameMechanics__173.LastOutputTickInfo ~= v300 or (l__GameMechanics__173.LastOutputAngles ~= l__Angles__176 or (l__GameMechanics__173.LastOutputPosition ~= l__Position__177 or (l__GameMechanics__173.LastOutputVelocity ~= l__Velocity__178 or l__GameMechanics__173.LastOutputAcceleration ~= l__Acceleration__179)))) then
        l__GameMechanics__173.LastOutputTime = l__Time__175;
        l__GameMechanics__173.LastOutputTickInfo = v300;
        l__GameMechanics__173.LastOutputAngles = l__Angles__176;
        l__GameMechanics__173.LastOutputPosition = l__Position__177;
        l__GameMechanics__173.LastOutputVelocity = l__Velocity__178;
        l__GameMechanics__173.LastOutputAcceleration = l__Acceleration__179;
        l__Simulation__174.OutputMulticall:Call("Output", l__Time__175, v300, l__Angles__176, l__Position__177, l__Velocity__178, l__Acceleration__179);
    end;
end;
local function u304(p302, _, _, p303) --[[ Line: 1439 ]]
    -- upvalues: u301 (copy)
    if not p303 then
        u301(p302);
    end;
end;
function v18.SetGravity(p305, p306) --[[ Line: 1445 ]]
    assert(p306 ~= nil, "You have to know what the gravity is before hand");
    p305.Simulation.Phys.Gravity = p306;
    local l__y__180 = p306.y;
    local v307 = -p305.JumpTime * l__y__180 / 2;
    p305.JumpVelocity = v307;
    p305.jv2 = (v307 + l__y__180 / 50) * (v307 + l__y__180 / 50);
end;
function v18.SetJumpTime(p308, p309) --[[ Line: 1453 ]]
    p308.JumpTime = p309;
    local l__Gravity__181 = p308.Simulation.Phys.Gravity;
    local v310 = -p309 * l__Gravity__181 / 2;
    p308.JumpVelocity = v310;
    p308.jv2 = (v310 + l__Gravity__181 / 50) * (v310 + l__Gravity__181 / 50);
end;
function v18.AttachPhysics(p311, p312) --[[ Line: 1461 ]]
    -- upvalues: l__FLYMODE_NONE__12 (copy), u22 (copy), u239 (copy), u252 (copy), u286 (copy), u304 (copy), u294 (copy), u301 (copy), u275 (copy), u281 (copy), u10 (copy), u254 (copy), u184 (copy), u61 (copy)
    p311.FlyMode = l__FLYMODE_NONE__12;
    p312.GameMechanics = p311;
    p312.CalculateHitBox = u22;
    p312.OnPrepare:Add(u239);
    p312.OnUpdate:Add(u252);
    p312.VelocityChanged:Add(u286);
    p312.PositionChanged:Add(u304);
    p312.PositionAdvanced:Add(u294):Add(u301);
    local l__Handlers__182 = p312.Handlers;
    l__Handlers__182.CollisionStart:Add(u275);
    l__Handlers__182.CollisionEnd:Add(u281);
    l__Handlers__182.TickEnd = u10():Add(u254);
    l__Handlers__182.Jump = u10():Add(u184);
    l__Handlers__182.ForceTrigger = u10():Add(u61);
    return p312;
end;
function v18.SetMapInfo(p313, p314) --[[ Line: 1481 ]]
    -- upvalues: l__clear__8 (copy)
    p313.MapInfo = p314;
    l__clear__8(p313.SetSpawns);
end;
function v18.GetStyle(p315) --[[ Line: 1486 ]]
    -- upvalues: u7 (copy)
    return p315.Style or u7.DefaultStyle;
end;
function v18.SetStyle(p316, p317) --[[ Line: 1489 ]]
    -- upvalues: l__clear__8 (copy), l__CreateStyleInfo__35 (copy)
    p316.Style = p317;
    l__clear__8(p316.SetSpawns);
    local v318 = l__CreateStyleInfo__35(p317, p316.MapInfo.GameID);
    p316.StyleInfo = v318;
    p316:SetJumpTime(v318.jump_time);
    p316:SetGravity(v318.gravity);
    p316:SetFlyMode(v318.fly_mode);
    p316.FlySpeed = v318.fly_speed;
    p316.Simulation.Phys:SetSize(v318.size);
    p316.Simulation.Camera:SetOffset(v318.camera_offset);
end;
function v18.GetFlyMode(p319) --[[ Line: 1504 ]]
    return p319.FlyMode;
end;
function v18.SetFlyMode(p320, p321) --[[ Line: 1507 ]]
    p320.FlyMode = p321;
end;
function v18.SetNextControls(p322, p323) --[[ Line: 1510 ]]
    -- upvalues: l__new__47 (copy)
    local l__GameControls__183 = p322.GameControls;
    p322.NextGameControls = p323;
    local l__Jump__184 = p323.Jump;
    if l__Jump__184 then
        l__Jump__184 = not l__GameControls__183.Jump;
    end;
    p322.NextJumpEdge = l__Jump__184;
    local l__Camera__185 = p322.Simulation.Camera;
    l__Camera__185:SetZooming(l__GameControls__183.Zoom);
    l__Camera__185.AnglesVelocity = l__new__47((l__GameControls__183.LookUp and 1 or 0) - (l__GameControls__183.LookDown and 1 or 0), (l__GameControls__183.LookRight and 1 or 0) - (l__GameControls__183.LookLeft and 1 or 0), 0) * p322.TurnSpeed;
end;
function v18.PropagateControls(p324) --[[ Line: 1518 ]]
    assert(p324.NextGameControls ~= nil, "NextGameControls==nil");
    p324.GameControls = p324.NextGameControls;
    p324.NextGameControls = nil;
    p324.JumpEdge = p324.NextJumpEdge;
    p324.NextJumpEdge = nil;
end;
local u325 = v9({
    "SpawnId",
    "JumpEdge",
    "JumpPart",
    "JumpCount",
    "FlyMode",
    "FlySpeed",
    "TrackDistance",
    "Density",
    "WorldTimerOffset",
    "RequireExplicitRestart",
    "Gravity",
    "JumpVelocity",
    "TurnSpeed",
    "jv2",
    "JumpTime"
});
v18.StateCalculus = v9;
function v18.GetState(p326) --[[ Line: 1545 ]]
    -- upvalues: u325 (copy), l__clone__9 (copy)
    local v327 = u325:GetState(p326);
    v327.Style = p326.Style;
    v327.GameControls = l__clone__9(p326.GameControls);
    v327.Zones = p326.Zones:GetState();
    return v327;
end;
function v18.SetState(p328, p329) --[[ Line: 1554 ]]
    -- upvalues: u325 (copy)
    p328:SetStyle(p329.Style);
    u325:SetState(p328, p329);
    p328.GameControls = p329.GameControls;
    p328.Zones:SetState(p329.Zones);
end;
function v18.CopyState(p330, p331) --[[ Line: 1560 ]]
    -- upvalues: u325 (copy), l__clear__8 (copy), u4 (copy)
    p330:SetStyle(p331.Style);
    u325:SetState(p330, p331);
    l__clear__8(p330.GameControls);
    u4(p331.GameControls, p330.GameControls);
    p330.Zones:CopyState(p331.Zones);
end;
function v18.DifferentiateState(p332, p333, p334) --[[ Line: 1567 ]]
    -- upvalues: u325 (copy)
    assert(p334 ~= nil, "DifferentiateState Instructions cannot be nil");
    local v335, v336 = u325:Differentiate(p332, p333);
    p334.GameMechanicsRemovals = v335;
    p334.GameMechanicsChanges = v336;
    if p333.Style ~= p332.Style then
        p334.Style = p333.Style;
    end;
    if p333.Zones.VState ~= p332.Zones.VState then
        p334.ZoneVState = p333.Zones.VState;
    end;
end;
function v18.IntegrateState(p337, p338) --[[ Line: 1577 ]]
    -- upvalues: u325 (copy)
    if p338 then
        u325:Integrate(p337, p338.GameMechanicsRemovals, p338.GameMechanicsChanges);
        if p338.Style then
            p337:SetStyle(p338.Style);
        end;
        if p338.ZoneVState ~= nil then
            p337.Zones.VState = p338.ZoneVState;
        end;
    end;
end;
function v18.Constructor(p339, p340) --[[ Line: 1589 ]]
    -- upvalues: l__FLYMODE_NONE__12 (copy), l__BlankGameControls__36 (copy), u84 (copy), u91 (copy)
    p339.SpawnId = 1;
    p339.FlyMode = l__FLYMODE_NONE__12;
    p339.FlySpeed = 80;
    p339.TurnSpeed = 1;
    p339.Density = 0.985;
    p339.TrackDistance = 0;
    p339.WorldTimerOffset = 0;
    p339.WalkSplitCount = 0;
    p339.SetSpawns = {};
    p339.MapInfo = {};
    p339.GameControls = l__BlankGameControls__36();
    p339.Zones = p340.Zones;
    p339.Simulation = p340;
    p339.IsTouchable = u84;
    p339.IsPhysicsPart = u91;
    p339.GameControls.Time = -1;
end;
return v18;
