-- Decompiled from: Flail
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("PersistentData");
local v2 = l__obtain__1("CharacterManager");
local l__CharacterAdded__2 = v2.CharacterAdded;
local l__CharacterInfos__3 = v2.CharacterInfos;
local l__new__4 = CFrame.new;
local l__pointToObjectSpace__5 = l__new__4().pointToObjectSpace;
local l__toObjectSpace__6 = l__new__4().toObjectSpace;
local _ = Vector3.new;
local u3 = {};
local u4 = l__new__4(0, 0, 0, 1, 0, 0, 0, -1, 0, 0, 0, -1);
local function u10(p5, p6) --[[ Line: 18 ]]
    -- upvalues: l__pointToObjectSpace__5 (copy), l__new__4 (copy), u4 (copy)
    local v7 = l__pointToObjectSpace__5(p5, p6);
    local l__x__7 = v7.x;
    local l__y__8 = v7.y;
    local l__z__9 = v7.z;
    local v8 = (l__x__7 * l__x__7 + l__y__8 * l__y__8 + l__z__9 * l__z__9) ^ 0.5;
    if l__y__8 < -0.99999 * v8 then
        return p5;
    end;
    if l__y__8 >= 0.99999 * v8 then
        return p5 * u4;
    end;
    local v9 = (2 * v8 * (v8 - l__y__8)) ^ 0.5;
    return p5 * l__new__4(0, 0, 0, -l__z__9 / v9, 0, l__x__7 / v9, (v8 - l__y__8) / v9);
end;
local function u98(p11, p12) --[[ Line: 60 ]]
    -- upvalues: l__new__4 (copy), l__toObjectSpace__6 (copy), u10 (copy), u3 (copy)
    local l__Torso__10 = p12.Torso;
    local l__RightShoulder__11 = p12.RightShoulder;
    local l__LeftShoulder__12 = p12.LeftShoulder;
    local l__RightHip__13 = p12.RightHip;
    local l__LeftHip__14 = p12.LeftHip;
    if l__RightShoulder__11 and (l__LeftShoulder__12 and (l__RightHip__13 and l__LeftHip__14)) then
        local u13 = l__new__4(1, 1, 0);
        local u14 = l__new__4(0.5, 0, 0);
        local u15 = 1;
        local u16 = l__Torso__10.CFrame * u13 * Vector3.new(0, 0, -0.5);
        local u17 = l__Torso__10.CFrame * u13 * Vector3.new(0, 0, -2);
        local u18 = u16;
        local u19 = u17;
        l__RightShoulder__11.C1 = l__new__4();
        local u20 = 0.5;
        local u21 = 1.5;
        local function u33(p22) --[[ Line: 39 ]]
            -- upvalues: l__Torso__10 (copy), u16 (ref), u18 (ref), u15 (ref), u17 (ref), u19 (ref), u13 (copy), u20 (copy), u21 (copy), l__RightShoulder__11 (copy), l__toObjectSpace__6 (ref), u10 (ref), l__new__4 (ref), u14 (copy)
            local l__CFrame__15 = l__Torso__10.CFrame;
            local v23 = p22 * p22 / 2 * Vector3.new(0, -100, 0);
            local v24 = u18 - v23;
            local v25 = u18 + p22 / u15 * (u18 - u16) + v23;
            u16 = v24;
            u18 = v25;
            local v26 = u19 - v23;
            local v27 = u19 + p22 / u15 * (u19 - u17) + v23;
            u17 = v26;
            u19 = v27;
            local v28 = l__CFrame__15 * u13;
            local l__p__16 = v28.p;
            for _ = 1, 7 do
                u18 = l__p__16 + u20 * (u18 - l__p__16).unit;
                local v29 = u19 - u18;
                local v30 = (1 + u21 / v29.magnitude) / 2 * v29;
                local v31 = u19 - v30;
                local v32 = u18 + v30;
                u18 = v31;
                u19 = v32;
            end;
            u18 = l__p__16 + u20 * (u18 - l__p__16).unit;
            u19 = u18 + u21 * (u19 - u18).unit;
            u15 = p22;
            l__RightShoulder__11.C0 = l__toObjectSpace__6(l__CFrame__15, u10(u10(v28, u18) * l__new__4(0, -u20, 0), u19) * u14) * l__new__4(0, u20 - 1, 0);
        end;
        local u34 = l__new__4(-1, 1, 0);
        local u35 = l__new__4(-0.5, 0, 0);
        local u36 = 1;
        local u37 = l__Torso__10.CFrame * u34 * Vector3.new(0, 0, -0.5);
        local u38 = l__Torso__10.CFrame * u34 * Vector3.new(0, 0, -2);
        local u39 = u37;
        local u40 = u38;
        l__LeftShoulder__12.C1 = l__new__4();
        local u41 = 0.5;
        local u42 = 1.5;
        local function u54(p43) --[[ Line: 39 ]]
            -- upvalues: l__Torso__10 (copy), u37 (ref), u39 (ref), u36 (ref), u38 (ref), u40 (ref), u34 (copy), u41 (copy), u42 (copy), l__LeftShoulder__12 (copy), l__toObjectSpace__6 (ref), u10 (ref), l__new__4 (ref), u35 (copy)
            local l__CFrame__17 = l__Torso__10.CFrame;
            local v44 = p43 * p43 / 2 * Vector3.new(0, -100, 0);
            local v45 = u39 - v44;
            local v46 = u39 + p43 / u36 * (u39 - u37) + v44;
            u37 = v45;
            u39 = v46;
            local v47 = u40 - v44;
            local v48 = u40 + p43 / u36 * (u40 - u38) + v44;
            u38 = v47;
            u40 = v48;
            local v49 = l__CFrame__17 * u34;
            local l__p__18 = v49.p;
            for _ = 1, 7 do
                u39 = l__p__18 + u41 * (u39 - l__p__18).unit;
                local v50 = u40 - u39;
                local v51 = (1 + u42 / v50.magnitude) / 2 * v50;
                local v52 = u40 - v51;
                local v53 = u39 + v51;
                u39 = v52;
                u40 = v53;
            end;
            u39 = l__p__18 + u41 * (u39 - l__p__18).unit;
            u40 = u39 + u42 * (u40 - u39).unit;
            u36 = p43;
            l__LeftShoulder__12.C0 = l__toObjectSpace__6(l__CFrame__17, u10(u10(v49, u39) * l__new__4(0, -u41, 0), u40) * u35) * l__new__4(0, u41 - 1, 0);
        end;
        local u55 = l__new__4(0.5, -1, 0);
        local u56 = l__new__4();
        local u57 = 1;
        local u58 = l__Torso__10.CFrame * u55 * Vector3.new(0, 0, -0.5);
        local u59 = l__Torso__10.CFrame * u55 * Vector3.new(0, 0, -2);
        local u60 = u58;
        local u61 = u59;
        l__RightHip__13.C1 = l__new__4();
        local u62 = 0.5;
        local u63 = 1.5;
        local function u75(p64) --[[ Line: 39 ]]
            -- upvalues: l__Torso__10 (copy), u58 (ref), u60 (ref), u57 (ref), u59 (ref), u61 (ref), u55 (copy), u62 (copy), u63 (copy), l__RightHip__13 (copy), l__toObjectSpace__6 (ref), u10 (ref), l__new__4 (ref), u56 (copy)
            local l__CFrame__19 = l__Torso__10.CFrame;
            local v65 = p64 * p64 / 2 * Vector3.new(0, -100, 0);
            local v66 = u60 - v65;
            local v67 = u60 + p64 / u57 * (u60 - u58) + v65;
            u58 = v66;
            u60 = v67;
            local v68 = u61 - v65;
            local v69 = u61 + p64 / u57 * (u61 - u59) + v65;
            u59 = v68;
            u61 = v69;
            local v70 = l__CFrame__19 * u55;
            local l__p__20 = v70.p;
            for _ = 1, 7 do
                u60 = l__p__20 + u62 * (u60 - l__p__20).unit;
                local v71 = u61 - u60;
                local v72 = (1 + u63 / v71.magnitude) / 2 * v71;
                local v73 = u61 - v72;
                local v74 = u60 + v72;
                u60 = v73;
                u61 = v74;
            end;
            u60 = l__p__20 + u62 * (u60 - l__p__20).unit;
            u61 = u60 + u63 * (u61 - u60).unit;
            u57 = p64;
            l__RightHip__13.C0 = l__toObjectSpace__6(l__CFrame__19, u10(u10(v70, u60) * l__new__4(0, -u62, 0), u61) * u56) * l__new__4(0, u62 - 1, 0);
        end;
        local u76 = l__new__4(-0.5, -1, 0);
        local u77 = l__new__4();
        local u78 = 1;
        local u79 = l__Torso__10.CFrame * u76 * Vector3.new(0, 0, -0.5);
        local u80 = l__Torso__10.CFrame * u76 * Vector3.new(0, 0, -2);
        local u81 = u79;
        local u82 = u80;
        l__LeftHip__14.C1 = l__new__4();
        local u83 = 0.5;
        local u84 = 1.5;
        local function u96(p85) --[[ Line: 39 ]]
            -- upvalues: l__Torso__10 (copy), u79 (ref), u81 (ref), u78 (ref), u80 (ref), u82 (ref), u76 (copy), u83 (copy), u84 (copy), l__LeftHip__14 (copy), l__toObjectSpace__6 (ref), u10 (ref), l__new__4 (ref), u77 (copy)
            local l__CFrame__21 = l__Torso__10.CFrame;
            local v86 = p85 * p85 / 2 * Vector3.new(0, -100, 0);
            local v87 = u81 - v86;
            local v88 = u81 + p85 / u78 * (u81 - u79) + v86;
            u79 = v87;
            u81 = v88;
            local v89 = u82 - v86;
            local v90 = u82 + p85 / u78 * (u82 - u80) + v86;
            u80 = v89;
            u82 = v90;
            local v91 = l__CFrame__21 * u76;
            local l__p__22 = v91.p;
            for _ = 1, 7 do
                u81 = l__p__22 + u83 * (u81 - l__p__22).unit;
                local v92 = u82 - u81;
                local v93 = (1 + u84 / v92.magnitude) / 2 * v92;
                local v94 = u82 - v93;
                local v95 = u81 + v93;
                u81 = v94;
                u82 = v95;
            end;
            u81 = l__p__22 + u83 * (u81 - l__p__22).unit;
            u82 = u81 + u84 * (u82 - u81).unit;
            u78 = p85;
            l__LeftHip__14.C0 = l__toObjectSpace__6(l__CFrame__21, u10(u10(v91, u81) * l__new__4(0, -u83, 0), u82) * u77) * l__new__4(0, u83 - 1, 0);
        end;
        u3[p11] = {
            func = function(p97) --[[ Name: func, Line 72 ]]
                -- upvalues: u33 (copy), u54 (copy), u75 (copy), u96 (copy)
                u33(p97);
                u54(p97);
                u75(p97);
                u96(p97);
            end,
            reset = function() --[[ Name: reset, Line 78 ]]
                -- upvalues: l__RightShoulder__11 (copy), l__new__4 (ref), l__LeftShoulder__12 (copy), l__RightHip__13 (copy), l__LeftHip__14 (copy)
                l__RightShoulder__11.C0 = l__new__4(1.5, 0, 0);
                l__LeftShoulder__12.C0 = l__new__4(-1.5, 0, 0);
                l__RightHip__13.C0 = l__new__4(0.5, -2, 0);
                l__LeftHip__14.C0 = l__new__4(-0.5, -2, 0);
            end
        };
    end;
end;
local u99 = nil;
local u100 = tick();
local function u104() --[[ Line: 108 ]]
    -- upvalues: u100 (ref), u3 (copy)
    local v101 = tick();
    local v102 = v101 - u100;
    u100 = v101;
    for _, v103 in u3 do
        v103.func(v102);
    end;
end;
v1.Global:MonitorKey("Flail", function(p105) --[[ Line: 117 ]]
    -- upvalues: l__CharacterInfos__3 (copy), u98 (copy), u99 (ref), l__CharacterAdded__2 (copy), u3 (copy)
    if p105 then
        for v106, v107 in l__CharacterInfos__3 do
            u98(v106, v107);
        end;
        u99 = l__CharacterAdded__2:Add(u98);
    else
        for v108, v109 in u3 do
            v109.reset();
            u3[v108] = nil;
        end;
        if u99 then
            u99:Remove(u98);
            u99 = nil;
        end;
    end;
end);
return function() --[[ Line: 125 ]]
    -- upvalues: u104 (copy)
    game:GetService("RunService").RenderStepped:connect(u104);
end;
