-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Character.FootPlanter
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__new__1 = CFrame.new;
local l__Angles__2 = CFrame.Angles;
local l__new__3 = Vector3.new;
local _ = math.rad;
local l__atan2__4 = math.atan2;
local l__acos__5 = math.acos;
local l__min__6 = math.min;
local l__max__7 = math.max;
local l__abs__8 = math.abs;
local l__log__9 = math.log;
function v1.CreateSolver(_, u2, u3) --[[ Line: 20 ]]
    -- upvalues: l__new__1 (copy), l__Angles__2 (copy), l__atan2__4 (copy), l__new__3 (copy), l__log__9 (copy), l__min__6 (copy), l__max__7 (copy), l__abs__8 (copy), l__acos__5 (copy)
    local v4 = {};
    local l__Parent__10 = u2.Parent;
    local u5 = 1.2;
    local u6 = 0.85;
    local u7 = 1.65;
    local u8 = 0.6;
    local u9 = 1;
    local u10 = nil;
    local u11 = nil;
    local u12 = false;
    local function u16(p13) --[[ Line: 51 ]]
        -- upvalues: u12 (ref), u10 (ref), l__new__3 (ref), u11 (ref)
        if u12 then
            u12 = true;
            tick();
            u10 = p13.p;
            return l__new__3();
        end;
        if not u11 then
            u11 = tick();
            u10 = p13.p;
            return l__new__3();
        end;
        local v14 = tick();
        local l__p__11 = p13.p;
        local v15 = (l__p__11 - u10) * 1 / (v14 - u11);
        u11 = v14;
        u10 = l__p__11;
        return v15;
    end;
    local l__FindCollidablePartOnRay__12 = require(script.Parent.Parent:WaitForChild("Util"):WaitForChild("FindCollidablePartOnRay"));
    local u17 = nil;
    local u18 = nil;
    local u19 = {};
    local u20 = nil;
    local function u23() --[[ Line: 116 ]]
        -- upvalues: u2 (copy), l__new__1 (ref), l__Angles__2 (ref), l__atan2__4 (ref), u20 (ref), u17 (ref), u5 (ref), u18 (ref), u19 (ref)
        local v21 = u2.CFrame * l__new__1(0, -u2.Size.Y / 2 - 2, 0);
        local l__X__13 = v21.X;
        local l__Y__14 = v21.Y;
        local l__Z__15 = v21.Z;
        local l__X__16 = v21.lookVector.X;
        local l__Z__17 = v21.lookVector.Z;
        local v22 = l__new__1(l__X__13, l__Y__14, l__Z__15) * l__Angles__2(0, l__atan2__4(l__X__16, l__Z__17), 0);
        u20 = v22;
        u17 = {
            Side = -1,
            StepCycle = 0,
            OffsetModifier = l__new__1(-u5 / 2, 0, 0),
            FootPosition = v22 * l__new__1(-u5 / 2, 0, 0).p,
            LastStepTo = v22 * l__new__1(-u5 / 2, 0, 0).p,
            Takeoff = v22 * l__new__1(-u5 / 2, 0, 0).p
        };
        u18 = {
            Side = 1,
            StepCycle = 0,
            OffsetModifier = l__new__1(u5 / 2, 0, 0),
            FootPosition = v22 * l__new__1(u5 / 2, 0, 0).p,
            LastStepTo = v22 * l__new__1(-u5 / 2, 0, 0).p,
            Takeoff = v22 * l__new__1(-u5 / 2, 0, 0).p
        };
        u17.OtherLeg = u18;
        u18.OtherLeg = u17;
        u19 = { u18, u17 };
    end;
    local u24 = 1;
    if u3 then
        u3.Changed:Connect(function() --[[ Line: 177 ]]
            -- upvalues: u17 (ref), u3 (copy), u24 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), l__new__1 (ref)
            if u17 then
                local v25 = u3 and u3.Value or 1;
                local v26 = v25 / u24;
                u24 = v25;
                u5 = u5 * v26;
                u6 = u6 * v26;
                u7 = u7 * v26;
                u8 = u8 * v26;
                u9 = u9 * v26;
                u17.OffsetModifier = l__new__1(-u5 / 2, 0, 0);
            end;
        end);
    end;
    local u27 = 1;
    local u28 = false;
    local function u44(p29) --[[ Line: 206 ]]
        -- upvalues: l__Parent__10 (copy), l__FindCollidablePartOnRay__12 (copy), u2 (copy)
        local v30 = p29 + Vector3.new(0, 2, 0);
        local v31 = Ray.new(v30, Vector3.new(0, -500, 0));
        local v32, v33 = l__FindCollidablePartOnRay__12(v31.Origin, v31.Direction, l__Parent__10, u2);
        if not v32 then
            return p29, Vector3.new(0, 1, 0);
        end;
        local v34 = Ray.new(v30 + Vector3.new(0, 0, 0.01), Vector3.new(0, -500, 0));
        local v35, v36 = l__FindCollidablePartOnRay__12(v34.Origin, v34.Direction, l__Parent__10, u2);
        local v37 = Ray.new(v30 + Vector3.new(0, 0, -0.01), Vector3.new(0, -500, 0));
        local v38, v39 = l__FindCollidablePartOnRay__12(v37.Origin, v37.Direction, l__Parent__10, u2);
        local v40 = Ray.new(v30 + Vector3.new(0.01, 0, 0), Vector3.new(0, -500, 0));
        local v41, v42 = l__FindCollidablePartOnRay__12(v40.Origin, v40.Direction, l__Parent__10, u2);
        local v43;
        if v35 and (v38 and v41) then
            v43 = (v36 - v39):Cross(v39 - v42).unit;
            if v43.Y < 0 then
                v43 = -v43;
            end;
        else
            v43 = nil;
        end;
        return v33, v43;
    end;
    local u45 = nil;
    function v4.GetFeetCFrames(_) --[[ Line: 236 ]]
        -- upvalues: u18 (ref), u23 (copy), u3 (copy), u24 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u17 (ref), l__new__1 (ref), u45 (ref), u16 (copy), u2 (copy), l__new__3 (ref), l__Angles__2 (ref), l__atan2__4 (ref), u27 (ref), l__log__9 (ref), l__min__6 (ref), l__max__7 (ref), u28 (ref), u44 (copy), u19 (ref), l__abs__8 (ref), l__acos__5 (ref)
        if not u18 then
            u23();
            local v46 = u3 and u3.Value or 1;
            local v47 = v46 / u24;
            u24 = v46;
            u5 = u5 * v47;
            u6 = u6 * v47;
            u7 = u7 * v47;
            u8 = u8 * v47;
            u9 = u9 * v47;
            u17.OffsetModifier = l__new__1(-u5 / 2, 0, 0);
        end;
        local v48 = tick();
        if not u45 then
            u45 = v48;
        end;
        local u49 = v48 - u45;
        u45 = v48;
        local v50 = u16(u2.CFrame);
        local l__magnitude__18 = l__new__3(v50.x, 0, v50.z).magnitude;
        local l__CFrame__19 = u2.CFrame;
        local l__X__20 = l__CFrame__19.X;
        local l__Y__21 = l__CFrame__19.Y;
        local l__Z__22 = l__CFrame__19.Z;
        local l__X__23 = l__CFrame__19.lookVector.X;
        local l__Z__24 = l__CFrame__19.lookVector.Z;
        local v51 = l__new__1(l__X__20, l__Y__21, l__Z__22) * l__Angles__2(0, l__atan2__4(l__X__23, l__Z__24), 0);
        local l__lookVector__25 = v51.lookVector;
        local v52 = l__lookVector__25:Cross(Vector3.new(0, 1, 0));
        local v53 = v50.magnitude <= 0 and Vector3.new(0, 0, -1) or v50.unit;
        local u54 = v53:Cross(Vector3.new(0, 1, 0));
        u27 = l__max__7(-1, (l__min__6(1, l__log__9(l__magnitude__18 / 16) / 0.6931471805599453)));
        local v55 = u18.StepCycle > 0;
        local v56 = u17.StepCycle > 0;
        local function u62(p57, p58, p59) --[[ Line: 263 ]]
            -- upvalues: u62 (copy)
            if p58 == 1 then
                return p59[1];
            end;
            local v60 = 1 - p57;
            for v61 = 1, p58 - 1 do
                p59[v61] = v60 * p59[v61] + p57 * p59[v61 + 1];
            end;
            return u62(p57, p58 - 1, p59);
        end;
        local function v77(p63, p64) --[[ Line: 275 ]]
            -- upvalues: u54 (copy), u5 (ref), u8 (ref), l__new__3 (ref), u62 (copy), u49 (copy), l__magnitude__18 (copy)
            local v65 = p64 - p63.Takeoff;
            local v66 = u54 * p63.Side;
            local _ = v65.magnitude;
            local v67 = v66 * (u5 / 2) * 0.3;
            local v68 = l__new__3(0, u8 * 1.3 * (1 / p63.StepSpeedMod), 0);
            local v69 = p63.Takeoff + v65 * 1 / 2 + v68 + v67;
            local v70 = p63.Takeoff + v65 * 0.9 + v68 + v67;
            local v71 = p63.StepCycle ^ (_G.A or 1);
            local v72 = {
                p63.Takeoff,
                v69,
                v70,
                p64
            };
            local v73 = 1 - v71;
            v72[1] = v73 * v72[1] + v71 * v72[2];
            v72[2] = v73 * v72[2] + v71 * v72[3];
            v72[3] = v73 * v72[3] + v71 * v72[4];
            local v74 = u62(v71, 3, v72);
            local v75;
            if (v74 - p63.FootPosition).magnitude > u49 * l__magnitude__18 * 2 then
                local v76 = (1 - p63.StepCycle) * p63.FootPosition + p63.StepCycle * v74;
                v75 = p63.FootPosition + (v74 - p63.FootPosition).unit * u49 * l__magnitude__18 * 2;
                if (v76 - v74).magnitude < (v75 - v74).magnitude then
                    v75 = v76;
                end;
            else
                v75 = v74;
            end;
            p63.FootPosition = v75;
            p63.LastStepTo = p64;
        end;
        local v78 = l__new__3(v50.x, 0, v50.z).magnitude > 2;
        if v78 then
            u28 = false;
        end;
        if v78 then
            local v79 = u54 * (u5 / 2) * 0.5;
            local v80 = v51 * u17.OffsetModifier;
            local v81;
            if u27 > 0 then
                v81 = u6 + u6 * 1 * u27;
            else
                v81 = u6 + u6 * 0.5 * u27;
            end;
            local l__p__26 = (v80 + v81 * v53 - u17.Side * v79).p;
            local v82 = v51 * u18.OffsetModifier;
            local v83;
            if u27 > 0 then
                v83 = u6 + u6 * 1 * u27;
            else
                v83 = u6 + u6 * 0.5 * u27;
            end;
            local l__p__27 = (v82 + v83 * v53 - u18.Side * v79).p;
            local v84, v85 = u44(l__p__26);
            local v86, v87 = u44(l__p__27);
            if v56 and (u17.AheadStep and (v84 - u17.AheadStep).magnitude >= u49 * l__magnitude__18) then
                u17.AheadStep = u17.AheadStep + (v84 - u17.AheadStep).unit * u49 * l__magnitude__18 * 2;
            else
                u17.AheadStep = v84;
            end;
            u17.NormalHint = v85;
            if v55 and (u18.AheadStep and (v86 - u18.AheadStep).magnitude >= u49 * l__magnitude__18) then
                u18.AheadStep = u18.AheadStep + (v86 - u18.AheadStep).unit * u49 * l__magnitude__18 * 2;
            else
                u18.AheadStep = v86;
            end;
            u18.NormalHint = v87;
            local v88 = 0.9 - l__max__7(0, u27) * 0.3;
            local v89;
            if u27 > 0 then
                v89 = u6 + u7 + (u6 + u7) * 1.5 * u27;
            else
                v89 = u6 + u7 + (u6 + u7) * 0.5 * u27;
            end;
            local v90 = l__magnitude__18 / v89 * v88;
            if v55 or v56 then
                if v55 and v56 then
                    for _, v91 in pairs(u19) do
                        v91.StepCycle = l__min__6(1, v91.StepCycle + u49 * v90 * v91.StepSpeedMod);
                        v77(v91, v91.AheadStep);
                        if v91.StepCycle == 1 then
                            v91.StepCycle = 0;
                        end;
                    end;
                else
                    for _, v92 in pairs(u19) do
                        if v92.StepCycle > 0 then
                            v92.StepCycle = l__min__6(1, v92.StepCycle + u49 * v90 * v92.StepSpeedMod);
                            v77(v92, v92.AheadStep);
                            if v88 < v92.StepCycle then
                                v92.OtherLeg.StepSpeedMod = 1;
                                v92.OtherLeg.StepCycle = u49;
                                v92.OtherLeg.Takeoff = v92.OtherLeg.FootPosition;
                                v77(v92.OtherLeg, v92.AheadStep);
                            end;
                            if v92.StepCycle == 1 then
                                v92.StepCycle = 0;
                            end;
                            break;
                        end;
                    end;
                end;
            elseif (u18.FootPosition - u18.AheadStep).magnitude < (u17.FootPosition - u17.AheadStep).magnitude then
                local v93 = 0.9;
                local v94 = 0;
                local l__magnitude__28 = (u18.FootPosition - u18.AheadStep).magnitude;
                local v95;
                if u27 > 0 then
                    v95 = u6 + u7 + (u6 + u7) * 1.5 * u27;
                else
                    v95 = u6 + u7 + (u6 + u7) * 0.5 * u27;
                end;
                u18.StepSpeedMod = 1 / (1 - l__min__6(v93, (l__max__7(v94, l__magnitude__28 / v95))));
                u18.StepCycle = u49;
                u18.Takeoff = u18.FootPosition;
            else
                local v96 = 0.9;
                local v97 = 0;
                local l__magnitude__29 = (u17.FootPosition - u17.AheadStep).magnitude;
                local v98;
                if u27 > 0 then
                    v98 = u6 + u7 + (u6 + u7) * 1.5 * u27;
                else
                    v98 = u6 + u7 + (u6 + u7) * 0.5 * u27;
                end;
                u17.StepSpeedMod = 1 / (1 - l__min__6(v96, (l__max__7(v97, l__magnitude__29 / v98))));
                u17.StepCycle = u49;
                u17.Takeoff = u17.FootPosition;
            end;
        else
            if v55 or v56 then
                for _, v99 in pairs(u19) do
                    if v99.StepCycle > 0 then
                        v99.StepCycle = l__min__6(1, v99.StepCycle + u49 * 2);
                        local l__p__30 = (v51 * v99.OffsetModifier).p;
                        local v100 = v99.LastStepTo - l__p__30;
                        local v101;
                        if u9 < v100.magnitude then
                            v101 = l__p__30 + v100.unit * u9;
                        else
                            v101 = v99.LastStepTo;
                        end;
                        local v102, v103 = u44(v101);
                        v99.AheadStep = v102;
                        v99.NormalHint = v103;
                        v77(v99, v102);
                        if v99.StepCycle == 1 then
                            v99.StepCycle = 0;
                        end;
                    end;
                end;
            else
                for _, v104 in pairs(u19) do
                    local v105, _ = u44(v104.FootPosition);
                    v104.FootPosition = v105;
                end;
            end;
            if u17.StepCycle == 0 and u18.StepCycle == 0 then
                local l__p__31 = (v51 * u17.OffsetModifier).p;
                local l__p__32 = (v51 * u18.OffsetModifier).p;
                local v106 = u17.FootPosition - l__p__31;
                local v107 = u18.FootPosition - l__p__32;
                local v108 = l__abs__8(v106:Dot(l__lookVector__25) - v107:Dot(l__lookVector__25)) > 3;
                local v109 = l__acos__5((l__min__6(1, (l__max__7(-1, v106.unit:Dot(v107.unit))))));
                local v110 = l__abs__8(v106.magnitude - v107.magnitude);
                if v106:Dot(v52) > u5 / 4 then
                    u28 = false;
                    u17.Takeoff = u17.FootPosition;
                    u17.StepCycle = u49;
                    local v111 = v107.unit * 0.5;
                    if v107.magnitude == 0 then
                        v111 = -v52 * 0.5;
                    elseif v107:Dot(v52) > 0 then
                        v111 = (v107 - 2 * v52 * v107:Dot(v52)).unit * 0.5;
                    end;
                    u17.LastStepTo = l__p__31 + v111;
                    if (u17.LastStepTo - u17.Takeoff).magnitude < 0.5 then
                        u17.StepCycle = 0;
                    end;
                    local v112 = 0.9;
                    local v113 = 0;
                    local l__magnitude__33 = (u17.FootPosition - u17.LastStepTo).magnitude;
                    local v114;
                    if u27 > 0 then
                        v114 = u6 + u7 + (u6 + u7) * 1.5 * u27;
                    else
                        v114 = u6 + u7 + (u6 + u7) * 0.5 * u27;
                    end;
                    u17.StepSpeedMod = 1 / (1 - l__min__6(v112, (l__max__7(v113, l__magnitude__33 / v114))));
                elseif v107:Dot(v52) < -u5 / 4 then
                    u28 = false;
                    u18.Takeoff = u18.FootPosition;
                    u18.StepCycle = u49;
                    local v115 = v106.unit * 0.5;
                    if v106.magnitude == 0 then
                        v115 = v52 * 0.5;
                    elseif v106:Dot(v52) < 0 then
                        v115 = (v106 - 2 * v52 * v106:Dot(v52)).unit * 0.5;
                    end;
                    u18.LastStepTo = l__p__32 + v115;
                    if (u17.LastStepTo - u17.Takeoff).magnitude < 0.5 then
                        u17.StepCycle = 0;
                    end;
                    local v116 = 0.9;
                    local v117 = 0;
                    local l__magnitude__34 = (u18.FootPosition - u18.LastStepTo).magnitude;
                    local v118;
                    if u27 > 0 then
                        v118 = u6 + u7 + (u6 + u7) * 1.5 * u27;
                    else
                        v118 = u6 + u7 + (u6 + u7) * 0.5 * u27;
                    end;
                    u18.StepSpeedMod = 1 / (1 - l__min__6(v116, (l__max__7(v117, l__magnitude__34 / v118))));
                elseif not u28 and (v109 < 2.6179938779914944 or (v110 > 0.2 or v108)) then
                    u28 = true;
                    local v119;
                    if v106.magnitude > v107.magnitude then
                        v119 = u17;
                    else
                        v119 = u18;
                        l__p__31 = l__p__32;
                        v107 = v106;
                    end;
                    v119.StepCycle = u49;
                    v119.Takeoff = v119.FootPosition;
                    v119.StepSpeedMod = 1;
                    if v108 then
                        v119.LastStepTo = l__p__31 - 0.5 * v107;
                    else
                        v119.LastStepTo = l__p__31 - v107;
                    end;
                    if (v119.Takeoff - v119.LastStepTo).magnitude < 0.2 then
                        v119.StepCycle = 0;
                    end;
                end;
            end;
            for _, v120 in pairs(u19) do
                local v121, _ = u44(v120.FootPosition);
                v120.FootPosition = v121;
            end;
        end;
        local l__FootPosition__35 = u18.FootPosition;
        local l__FootPosition__36 = u17.FootPosition;
        local l__lookVector__37 = (u2.CFrame * l__new__1(0, -u2.Size.Y / 2 - 2, 0)).lookVector;
        local v122 = l__atan2__4(l__lookVector__37.X, l__lookVector__37.Z);
        local v123 = l__Angles__2(0, 0.08726646259971647 + v122, 0);
        local v124 = l__Angles__2(0, -0.08726646259971647 + v122, 0);
        return l__new__1(l__FootPosition__35) * v123, l__new__1(l__FootPosition__36) * v124;
    end;
    function v4.OffsetFeet(_, p125) --[[ Line: 504 ]]
        -- upvalues: u12 (ref), u19 (ref)
        u12 = true;
        for _, v126 in pairs(u19) do
            v126.FootPosition = v126.FootPosition + p125;
            v126.LastStepTo = v126.LastStepTo + p125;
            if v126.Takeoff then
                v126.Takeoff = v126.Takeoff + p125;
            end;
            if v126.AheadStep then
                v126.AheadStep = v126.AheadStep + p125;
            end;
        end;
        u12 = true;
    end;
    return v4;
end;
return v1;
