-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__exp__1 = math.exp;
local l__cos__2 = math.cos;
local l__sin__3 = math.sin;
local l__tan__4 = math.tan;
local l__atan__5 = math.atan;
local l__asin__6 = math.asin;
local l__sqrt__7 = math.sqrt;
local l__atan2__8 = math.atan2;
local l__new__9 = CFrame.new;
local l__new__10 = Vector3.new;
local l__Angles__11 = CFrame.Angles;
local u1 = l__new__10();
local l__Dot__12 = u1.Dot;
local u2 = l__new__9();
local l__components__13 = u2.components;
local u3 = l__new__9(0, 0, 10);
local u4 = l__new__9(0, 0, 0.5);
local l__obtain__14 = _G.obtain;
local v5 = l__obtain__14("CustomEnums");
local l__EVENT_CAMERA_PUNCH__15 = v5.EVENT_CAMERA_PUNCH;
local l__EVENT_CAMERA_TRANSFORM__16 = v5.EVENT_CAMERA_TRANSFORM;
local l__EVENT_SETTING_FOV__17 = v5.EVENT_SETTING_FOV;
local l__EVENT_SETTING_VSENSMUL__18 = v5.EVENT_SETTING_VSENSMUL;
local l__EVENT_SETTING_SENSITIVITY__19 = v5.EVENT_SETTING_SENSITIVITY;
local l__EVENT_SETTING_ABSOLUTE_SENS__20 = v5.EVENT_SETTING_ABSOLUTE_SENS;
local v6 = l__obtain__14("StateCalculus");
local v7 = l__obtain__14("Class")();
local u8 = {};
function v7.Event(p9, p10, p11) --[[ Line: 46 ]]
    -- upvalues: u8 (copy)
    local v12 = u8[p10];
    if v12 then
        v12(p9, p11);
    end;
end;
local u13 = {};
function v7.Setting(p14, p15, p16) --[[ Line: 53 ]]
    -- upvalues: u13 (copy)
    local v17 = u13[p15];
    if v17 then
        v17(p14, p16);
    end;
end;
function v7.Age(p18, p19) --[[ Line: 61 ]]
    -- upvalues: u1 (copy), l__Dot__12 (copy), l__exp__1 (copy), l__new__10 (copy)
    local l__Blunder__21 = p18.Blunder;
    local l__BlunderRotVelocity__22 = p18.BlunderRotVelocity;
    if l__Blunder__21 ~= u1 or l__BlunderRotVelocity__22 ~= u1 then
        if l__Dot__12(l__Blunder__21, l__Blunder__21) > 1e-6 or l__Dot__12(l__BlunderRotVelocity__22, l__BlunderRotVelocity__22) > 1e-6 then
            local v20 = l__exp__1(-6 * p19) * (l__Blunder__21 * (1 + 6 * p19) + l__BlunderRotVelocity__22 * p19);
            local v21 = l__exp__1(-6 * p19) * (l__BlunderRotVelocity__22 * (1 - 6 * p19) - l__Blunder__21 * (p19 * 6 * 6));
            p18.Blunder = v20;
            p18.BlunderRotVelocity = v21;
        else
            local v22 = u1;
            p18.Blunder = u1;
            p18.BlunderRotVelocity = v22;
        end;
    end;
    local l__AnglesVelocity__23 = p18.AnglesVelocity;
    if l__AnglesVelocity__23 ~= u1 then
        local l__Angles__24 = p18.Angles;
        local v23 = l__Angles__24.x + l__AnglesVelocity__23.x * p19;
        local v24 = p18.MaxAngle < v23 and p18.MaxAngle;
        if v24 then
            v23 = v24;
        elseif v23 < p18.MinAngle then
            v23 = p18.MinAngle or v23;
        end;
        p18.Angles = l__new__10(v23, l__Angles__24.y - l__AnglesVelocity__23.y * p19, 0);
    end;
end;
function v7.SetUseAbsoluteSens(p25, p26) --[[ Line: 78 ]]
    p25.UseAbsoluteSens = p26 == 1;
end;
function v7.GetPixelsToRadians(p27) --[[ Line: 81 ]]
    if p27.UseAbsoluteSens then
        return p27.Sensitivity / 128;
    else
        return p27.Sensitivity * p27.FOV * p27.Zoom / 128;
    end;
end;
function v7.Move(p28, p29) --[[ Line: 89 ]]
    -- upvalues: l__new__10 (copy)
    local v30 = p28:GetPixelsToRadians();
    local l__Angles__25 = p28.Angles;
    local v31 = l__Angles__25.x - v30 * p28.VSensMul * p29.y;
    local v32 = p28.MaxAngle < v31 and p28.MaxAngle;
    if v32 then
        v31 = v32;
    elseif v31 < p28.MinAngle then
        v31 = p28.MinAngle or v31;
    end;
    p28.Angles = l__new__10(v31, l__Angles__25.y - v30 * p29.x, 0);
end;
function v7.SetTime(p33, p34) --[[ Line: 96 ]]
    local l__Time__26 = p33.Time;
    if l__Time__26 then
        if l__Time__26 < p34 then
            p33:Age(p34 - l__Time__26);
        end;
    else
        p33:Age(p34);
    end;
    p33.Time = p34;
end;
function v7.MoveTo(p35, p36) --[[ Line: 108 ]]
    local l__MousePos__27 = p35.MousePos;
    if l__MousePos__27 then
        p35:Move(p36 - l__MousePos__27);
    else
        p35:Move(p36);
    end;
    p35.MousePos = p36;
end;
function v7.Advance(p37, p38, p39) --[[ Line: 118 ]]
    p37:MoveTo(p38);
    p37:SetTime(p39);
end;
function v7.GetQuaternion(p40) --[[ Line: 123 ]]
    -- upvalues: l__cos__2 (copy), l__sin__3 (copy), u1 (copy)
    local l__Angles__28 = p40.Angles;
    local v41 = l__Angles__28.x / 2 % 6.283185307179586;
    local v42 = l__Angles__28.y / 2 % 6.283185307179586;
    local v43 = l__cos__2(v41);
    local v44 = l__sin__3(v41);
    local v45 = l__cos__2(v42);
    local v46 = l__sin__3(v42);
    local v47, v48, v49, v50;
    if l__Angles__28.z == 0 then
        v47 = v43 * v45;
        v48 = v45 * v44;
        v49 = v43 * v46;
        v50 = -v44 * v46;
    else
        local v51 = l__Angles__28.z / 2 % 6.283185307179586;
        local v52 = l__cos__2(v51);
        local v53 = l__sin__3(v51);
        v47 = v43 * v45 * v52 + v44 * v46 * v53;
        v48 = v45 * v52 * v44 + v43 * v46 * v53;
        v49 = v43 * v52 * v46 - v45 * v44 * v53;
        v50 = v43 * v45 * v53 - v52 * v44 * v46;
    end;
    local l__Blunder__29 = p40.Blunder;
    if l__Blunder__29 == u1 then
        return v47, v48, v49, v50;
    end;
    local l__magnitude__30 = l__Blunder__29.magnitude;
    local v54 = l__magnitude__30 < 1e-6 and 0.5 - l__magnitude__30 * l__magnitude__30 / 48 or l__sin__3(l__magnitude__30 / 2) / l__magnitude__30;
    local v55 = l__cos__2(l__magnitude__30 / 2);
    local v56 = l__Blunder__29.x * v54;
    local v57 = l__Blunder__29.y * v54;
    local v58 = l__Blunder__29.z * v54;
    return v47 * v55 - v48 * v56 - v49 * v57 - v50 * v58, v47 * v56 + v48 * v55 + v49 * v58 - v50 * v57, v47 * v57 - v48 * v58 + v49 * v55 + v50 * v56, v47 * v58 + v48 * v57 - v49 * v56 + v50 * v55;
end;
function v7.GetCFrame(p59) --[[ Line: 151 ]]
    -- upvalues: l__new__9 (copy)
    local v60, v61, v62, v63 = p59:GetQuaternion();
    return l__new__9(0, 0, 0, v61, v62, v63, v60);
end;
function v7.FirstPerson(p64, p65) --[[ Line: 165 ]]
    return p64:GetCFrame() * p64.CFrameOffset + (p65 + p64.Offset);
end;
function v7.ThirdPerson(p66, p67) --[[ Line: 169 ]]
    -- upvalues: u3 (copy)
    return p66:FirstPerson(p67) * u3;
end;
function v7.ModeCFrame(p68, p69, p70) --[[ Line: 173 ]]
    -- upvalues: u2 (copy)
    if p69 == 1 then
        return p68:FirstPerson(p70);
    elseif p69 == 2 then
        return p68:ThirdPerson(p70);
    else
        return u2;
    end;
end;
function v7.SetSensitivity(p71, p72) --[[ Line: 182 ]]
    p71.Sensitivity = p72;
end;
function v7.SetVSensMul(p73, p74) --[[ Line: 185 ]]
    p73.VSensMul = p74;
end;
function v7.SetFOV(p75, p76) --[[ Line: 188 ]]
    -- upvalues: l__tan__4 (copy)
    p75.FOV = l__tan__4(p76 * 0.008726646259971648);
end;
function v7.GetFOV(p77) --[[ Line: 192 ]]
    -- upvalues: l__atan__5 (copy)
    return 114.59155902616465 * l__atan__5(p77.FOV * p77.Zoom);
end;
function v7.SetZooming(p78, p79) --[[ Line: 195 ]]
    p78.Zoom = p79 and 0.2 or 1;
end;
function v7.NoBlunder(p80) --[[ Line: 199 ]]
    -- upvalues: u1 (copy)
    p80.Blunder = u1;
    p80.BlunderRotVelocity = u1;
end;
function v7.SetBlunder(p81, p82) --[[ Line: 203 ]]
    p81.Blunder = p82;
end;
function v7.SetBlunderRotVelocity(p83, p84) --[[ Line: 206 ]]
    p83.BlunderRotVelocity = p84;
end;
function v7.Punch(p85, p86) --[[ Line: 209 ]]
    p85.BlunderRotVelocity = p85.BlunderRotVelocity + p86;
end;
function v7.TransformRotVelocity(p87, p88) --[[ Line: 213 ]]
    -- upvalues: u1 (copy), l__sin__3 (copy), l__cos__2 (copy), l__new__10 (copy)
    local l__BlunderRotVelocity__31 = p87.BlunderRotVelocity;
    if l__BlunderRotVelocity__31 ~= u1 then
        local l__x__32 = l__BlunderRotVelocity__31.x;
        local l__y__33 = l__BlunderRotVelocity__31.y;
        local l__z__34 = l__BlunderRotVelocity__31.z;
        local l__magnitude__35 = p88.magnitude;
        local v89 = l__magnitude__35 < 1e-6 and 0.5 - l__magnitude__35 * l__magnitude__35 / 48 or l__sin__3(l__magnitude__35 / 2) / l__magnitude__35;
        local v90 = l__cos__2(l__magnitude__35 / 2);
        local v91 = p88.x * v89;
        local v92 = p88.y * v89;
        local v93 = p88.z * v89;
        local v94 = -l__x__32 * v91 - l__y__33 * v92 - l__z__34 * v93;
        local v95 = l__x__32 * v90 + l__z__34 * v92 - l__y__33 * v93;
        local v96 = l__y__33 * v90 - l__z__34 * v91 + l__x__32 * v93;
        local v97 = l__z__34 * v90 + l__y__33 * v91 - l__x__32 * v92;
        p87.BlunderRotVelocity = l__new__10(v95 * v90 - v94 * v91 + v97 * v92 - v96 * v93, v96 * v90 - v97 * v91 - v94 * v92 + v95 * v93, v97 * v90 + v96 * v91 - v95 * v92 - v94 * v93);
    end;
end;
function v7.SetAngles(p98, p99) --[[ Line: 230 ]]
    assert(p99 ~= nil, "Angles cannot be nil");
    p98.Angles = p99;
end;
local function u111(p100) --[[ Line: 239 ]]
    -- upvalues: l__components__13 (copy), l__atan2__8 (copy)
    local _, _, _, v101, v102, v103, _, v104, v105, v106, v107, v108 = l__components__13(p100);
    local v109 = l__atan2__8(-v105, v104);
    local v110 = l__atan2__8(-v106, v101);
    if v109 < -1.5707963267948966 then
        return -1.5707963267948966, l__atan2__8(-v106 + v103 * 6.123233995736766e-17 + v102 * -1, v101 + v108 * 6.123233995736766e-17 + v107 * -1);
    end;
    if v109 > 1.5707963267948966 then
        v110 = l__atan2__8(-v106 + v103 * 6.123233995736766e-17 + v102 * 1, v101 + v108 * 6.123233995736766e-17 + v107 * 1);
        v109 = 1.5707963267948966;
    end;
    return v109, v110;
end;
function v7.Transform(p112, p113) --[[ Line: 284 ]]
    -- upvalues: l__sin__3 (copy), l__cos__2 (copy), l__new__9 (copy), l__components__13 (copy), l__asin__6 (copy), l__atan2__8 (copy), u111 (copy), l__Angles__11 (copy), l__sqrt__7 (copy), l__new__10 (copy)
    local l__magnitude__36 = p113.magnitude;
    local v114 = l__magnitude__36 < 1e-6 and 0.5 - l__magnitude__36 * l__magnitude__36 / 48 or l__sin__3(l__magnitude__36 / 2) / l__magnitude__36;
    local v115 = l__cos__2(l__magnitude__36 / 2);
    local v116 = p113.x * v114;
    local v117 = p113.y * v114;
    local v118 = p113.z * v114;
    local v119, v120, v121, v122 = p112:GetQuaternion();
    local v123 = l__new__9(0, 0, 0, v115 * v120 + v116 * v119 + v117 * v122 - v118 * v121, v115 * v121 - v116 * v122 + v117 * v119 + v118 * v120, v115 * v122 + v116 * v121 - v117 * v120 + v118 * v119, v115 * v119 - v116 * v120 - v117 * v121 - v118 * v122);
    local _, _, _, _, _, v124, _, _, v125, _, _, v126 = l__components__13(v123);
    local v127 = l__asin__6(-v125);
    local v128 = l__atan2__8(v124, v126);
    local v129, v130 = u111(v123);
    local _, _, _, v131, v132, v133, v134, v135, v136, v137, v138, v139 = (l__Angles__11(-v127, -v128, 0) * v123):components();
    local v140 = v138 - v136;
    local v141 = v133 - v137;
    local v142 = v134 - v132;
    local v143 = v131 + v135 + v139 - 1;
    local v144 = l__sqrt__7(v140 * v140 + v141 * v141 + v142 * v142);
    local v145 = Vector3.new(v140, v141, v142) / v144;
    local v146 = math.atan2(v144, v143);
    local _, _, _, v147, v148, v149, v150, v151, v152, v153, v154, v155 = (l__Angles__11(-v129, -v130, 0) * v123):components();
    local v156 = v154 - v152;
    local v157 = v149 - v153;
    local v158 = v150 - v148;
    local v159 = v147 + v151 + v155 - 1;
    local v160 = l__sqrt__7(v156 * v156 + v157 * v157 + v158 * v158);
    local v161 = Vector3.new(v156, v157, v158) / v160;
    local v162 = math.atan2(v160, v159);
    local v163;
    if v146 < v162 * 2 then
        v163 = v145 * v146;
        v130 = v128;
        v129 = v127;
    else
        v163 = v161 * v162;
    end;
    p112:SetAngles((l__new__10(v129, v130, 0)));
    p112:SetBlunder(v163);
    p112:TransformRotVelocity(p113);
end;
function v7.SetOffset(p164, p165) --[[ Line: 316 ]]
    p164.Offset = p165;
end;
u8[l__EVENT_CAMERA_PUNCH__15] = v7.Metamethods.Punch;
u8[l__EVENT_CAMERA_TRANSFORM__16] = v7.Metamethods.Transform;
u13[l__EVENT_SETTING_FOV__17] = v7.Metamethods.SetFOV;
u13[l__EVENT_SETTING_VSENSMUL__18] = v7.Metamethods.SetVSensMul;
u13[l__EVENT_SETTING_SENSITIVITY__19] = v7.Metamethods.SetSensitivity;
u13[l__EVENT_SETTING_ABSOLUTE_SENS__20] = v7.Metamethods.SetUseAbsoluteSens;
v6({
    "FOV",
    "Zoom",
    "Angles",
    "AnglesVelocity",
    "Blunder",
    "BlunderRotVelocity",
    "Sensitivity",
    "UseAbsoluteSens",
    "VSensMul",
    "MousePos",
    "Time",
    "Offset"
}):Simple(v7);
function v7.Constructor(p166) --[[ Line: 343 ]]
    -- upvalues: u1 (copy), u4 (copy)
    p166.UseAbsoluteSens = false;
    p166.Sensitivity = 0.3;
    p166.VSensMul = 1;
    p166.Zoom = 1;
    p166.FOV = 1;
    p166.Angles = u1;
    p166.AnglesVelocity = u1;
    p166.MaxAngle = 1.5707963267948966;
    p166.MinAngle = -1.5707963267948966;
    p166.Blunder = u1;
    p166.BlunderRotVelocity = u1;
    p166.CFrameOffset = u4;
    p166.Offset = u1;
end;
return v7;
