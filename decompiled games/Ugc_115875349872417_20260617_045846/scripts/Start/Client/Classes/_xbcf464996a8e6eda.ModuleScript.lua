-- Decompiled from: Start.Client.Classes._xbcf464996a8e6eda
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__ModuleScripts__3 = l__ReplicatedStorage__2.Assets.ModuleScripts;
local l__Packets__4 = require(l__ModuleScripts__3.Packets);
require(l__ModuleScripts__3.Signal);
local l__Promise__5 = require(l__ModuleScripts__3.Promise);
local l__Trove__6 = require(l__ModuleScripts__3.Trove);
require(l__ModuleScripts__3.Spring);
local u1 = {};
u1.__index = u1;
local l__Classes__7 = require(script.Parent.Parent.ClientRoot).Classes;
local l__LocalPlayer__8 = game.Players.LocalPlayer;
local u2 = {
    "Idle",
    "Walk",
    "RJump",
    "LJump",
    "LAerial",
    "RAerial",
    "LWallride",
    "RWallride",
    "Wallkick",
    "SlideStartArm",
    "SlideLoopArm",
    "SlideLoop",
    "SlideEndArm",
    "SlideAerialArm",
    "GrapplePull",
    "GrappleThrow",
    "PullGrounded",
    "Parry",
    "Deflect",
    "CAttack",
    "LAttack",
    "RAttack",
    "Gundraw",
    "Gunshot",
    "Bonusshot"
};
function u1._x83ed94bfb82a8c9f() --[[ Line: 35 ]]
    -- upvalues: u1 (copy), l__Trove__6 (copy)
    local v3 = setmetatable({}, u1);
    v3._x2f5a2e3a38482ff3 = {};
    v3._xc086a7dd1d36d3cc = {};
    v3._x1ae2e23bae9f4c21 = {};
    v3._x0e9d2cd8e2a1adea = l__Trove__6.new();
    v3._xd8d6f1f98b8ec0b8 = {};
    v3._xb0aa6fedd69bcc2b = false;
    v3._x532ac707743f6d92 = false;
    v3._xd058cad3b393c946 = false;
    v3._xea48ce296baba8ec = {};
    return v3;
end;
function u1._x22b07465d7977ba9(_) --[[ Line: 60 ]]
    -- upvalues: l__LocalPlayer__8 (copy)
    local v4, v5 = pcall(function() --[[ Line: 61 ]]
        -- upvalues: l__LocalPlayer__8 (ref)
        return l__LocalPlayer__8.Character.Humanoid.Animator;
    end);
    if v4 then
        return v5;
    end;
end;
function u1._x397885f7a1912e0d(p6, p7, p8) --[[ Line: 68 ]]
    p6._x2f5a2e3a38482ff3[p7] = p8;
end;
function u1._x7e23f95dc7e22970(u9, p10, p11) --[[ Line: 72 ]]
    -- upvalues: l__Promise__5 (copy)
    local u12 = u9._x2f5a2e3a38482ff3[p10];
    if u12 then
        local v13;
        if p11 then
            v13 = p11.fade_time;
        else
            v13 = p11;
        end;
        local v14;
        if p11 then
            v14 = p11.weight;
        else
            v14 = p11;
        end;
        u12:Play(v13, v14);
        if p11.force_look then
            local u15 = game:GetService("HttpService"):GenerateGUID();
            table.insert(u9._xea48ce296baba8ec, u15);
            task.defer(function() --[[ Line: 83 ]]
                -- upvalues: l__Promise__5 (ref), u12 (copy), u9 (copy), u15 (copy)
                local v19 = { l__Promise__5.delay(5), (l__Promise__5.new(function(u16, _, p17) --[[ Line: 85 ]]
                        -- upvalues: u12 (ref)
                        local u18 = nil;
                        u18 = u12.Stopped:Once(function() --[[ Line: 93 ]]
                            -- upvalues: u16 (copy), u18 (ref)
                            u16();
                            if u18 then
                                u18:Disconnect();
                                u18 = nil;
                            end;
                        end);
                        p17(function() --[[ Line: 97 ]]
                            -- upvalues: u18 (ref)
                            if u18 then
                                u18:Disconnect();
                                u18 = nil;
                            end;
                        end);
                    end)) };
                l__Promise__5.race(v19):finally(function() --[[ Line: 103 ]]
                    -- upvalues: u9 (ref), u15 (ref)
                    local v20 = table.find(u9._xea48ce296baba8ec, u15);
                    if v20 then
                        table.remove(u9._xea48ce296baba8ec, v20);
                    end;
                end);
            end);
        end;
        if p11.override then
            for _, v21 in p11.override do
                local v22 = u9._x2f5a2e3a38482ff3[v21];
                if v22 then
                    v22:Stop();
                end;
            end;
        end;
        return u12;
    end;
    warn(p10 .. " DOES NOT EXIST");
end;
function u1._xe27c47fe2c0cf050(p23, p24, p25) --[[ Line: 130 ]]
    local v26 = p23._x2f5a2e3a38482ff3[p24];
    if v26 then
        v26:Stop(p25);
    end;
end;
function u1._xc15ac5e9aea11695(u27, u28, p29, p30) --[[ Line: 138 ]]
    -- upvalues: l__Promise__5 (copy)
    if typeof(u28) == "string" then
        u28 = u27._x2f5a2e3a38482ff3[u28];
    end;
    if not u28 then
        print("TRACK DOES NOT EXIST");
        return;
    end;
    local v31 = u27:_x22b07465d7977ba9();
    if not v31 then
        return;
    end;
    local v32 = v31:GetPlayingAnimationTracks();
    local v33 = {
        "SlideEndArm",
        "SlideStartArm",
        "SlideLoopArm",
        "SlideLoop",
        "GrappleThrow",
        "GrapplePull",
        "PullGrounded",
        "Parry",
        "Deflect",
        "CAttack",
        "LAttack",
        "RAttack",
        "Gundraw",
        "Gunshot",
        "Bonusshot"
    };
    if p29.force_look then
        local u34 = game:GetService("HttpService"):GenerateGUID();
        table.insert(u27._xea48ce296baba8ec, u34);
        task.defer(function() --[[ Line: 157 ]]
            -- upvalues: l__Promise__5 (ref), u28 (ref), u27 (copy), u34 (copy)
            local v38 = { l__Promise__5.delay(5), (l__Promise__5.new(function(u35, _, p36) --[[ Line: 159 ]]
                    -- upvalues: u28 (ref)
                    local u37 = nil;
                    u37 = u28.Stopped:Once(function() --[[ Line: 167 ]]
                        -- upvalues: u35 (copy), u37 (ref)
                        print("anim stopped");
                        u35();
                        if u37 then
                            u37:Disconnect();
                            u37 = nil;
                        end;
                    end);
                    p36(function() --[[ Line: 172 ]]
                        -- upvalues: u37 (ref)
                        if u37 then
                            u37:Disconnect();
                            u37 = nil;
                        end;
                    end);
                end)) };
            l__Promise__5.race(v38):finally(function() --[[ Line: 178 ]]
                -- upvalues: u27 (ref), u34 (ref)
                local v39 = table.find(u27._xea48ce296baba8ec, u34);
                if v39 then
                    table.remove(u27._xea48ce296baba8ec, v39);
                    print("removed");
                end;
            end);
        end);
    end;
    if v32 then
        for _, v40 in v32 do
            if v40 ~= u28 then
                local v41 = false;
                for _, v42 in v33 do
                    if u27._x2f5a2e3a38482ff3[v42] and v40 == u27._x2f5a2e3a38482ff3[v42] then
                        v41 = true;
                        break;
                    end;
                end;
                if not (v41 or p30 and table.find(p30, v40)) then
                    local v43;
                    if p29 then
                        v43 = p29.fade_time;
                    else
                        v43 = p29;
                    end;
                    v40:Stop(v43);
                end;
            end;
        end;
    end;
    if table.find(v32, u28) then
        local v44 = 1;
        local v45;
        if p29 then
            v45 = p29.fade_time;
        else
            v45 = p29;
        end;
        u28:AdjustWeight(v44, v45);
        local v46;
        if p29 then
            v46 = p29.fade_time;
        else
            v46 = p29;
        end;
        if p29 then
            p29 = p29.weight;
        end;
        u28:Play(v46, p29);
    else
        local v47;
        if p29 then
            v47 = p29.fade_time;
        else
            v47 = p29;
        end;
        if p29 then
            p29 = p29.weight;
        end;
        u28:Play(v47, p29);
    end;
end;
function u1._xd40bc6b042eab924(p48, p49) --[[ Line: 214 ]]
    -- upvalues: l__Classes__7 (copy)
    if p48._x532ac707743f6d92 then
        local l__main__9 = p49.main;
        local _ = p49.previous;
        local l__context__10 = p49.context;
        local _ = p49.previous_context;
        local _ = p49.corresponding_played;
        local l___x2f5a2e3a38482ff3__11 = p48._x2f5a2e3a38482ff3;
        local l___x1a4ce4062771e36e__12 = l__Classes__7._x1a4ce4062771e36e;
        local _ = l___x1a4ce4062771e36e__12._x0aa5621fbcbe69df._x3b8a76d53cd0b01a;
        local _ = l___x1a4ce4062771e36e__12._x951b8a58c97ff8ca;
        if l__main__9 == "bhop_jump" then
            if p48._xb0aa6fedd69bcc2b then
                p48:_xc15ac5e9aea11695(l___x2f5a2e3a38482ff3__11.LJump, {
                    fade_time = 0.15
                });
            else
                p48:_xc15ac5e9aea11695(l___x2f5a2e3a38482ff3__11.RJump, {
                    fade_time = 0.15
                });
            end;
        elseif l__main__9 == "falling" then
            if p48._xb0aa6fedd69bcc2b then
                p48:_xc15ac5e9aea11695(l___x2f5a2e3a38482ff3__11.LAerial, {
                    fade_time = 0.2
                }, { l___x2f5a2e3a38482ff3__11.RJump, l___x2f5a2e3a38482ff3__11.LJump, l___x2f5a2e3a38482ff3__11.Wallkick });
            else
                p48:_xc15ac5e9aea11695(l___x2f5a2e3a38482ff3__11.RAerial, {
                    fade_time = 0.2
                }, { l___x2f5a2e3a38482ff3__11.RJump, l___x2f5a2e3a38482ff3__11.LJump, l___x2f5a2e3a38482ff3__11.Wallkick });
            end;
            if l__context__10 == "wallkick_right" or l__context__10 == "wallkick_left" then
                l___x2f5a2e3a38482ff3__11.Wallkick:Play(0.08, 1);
                task.wait(0.15, function() --[[ Line: 241 ]]
                    -- upvalues: l___x2f5a2e3a38482ff3__11 (copy)
                    l___x2f5a2e3a38482ff3__11.Wallkick:AdjustWeight(0.001, 0.4);
                end);
            end;
            p48._xb0aa6fedd69bcc2b = not p48._xb0aa6fedd69bcc2b;
        elseif l__main__9 == "running" then
            p48:_xc15ac5e9aea11695(l___x2f5a2e3a38482ff3__11.Walk, {
                fade_time = 0.3
            });
        elseif l__main__9 == "idle" then
            p48:_xc15ac5e9aea11695(l___x2f5a2e3a38482ff3__11.Idle, {
                fade_time = 0.3
            });
        end;
    end;
end;
function u1._x7821e70d7e4d1096(p50) --[[ Line: 257 ]]
    -- upvalues: l__Classes__7 (copy)
    if p50._x532ac707743f6d92 then
        local l___x2f5a2e3a38482ff3__13 = p50._x2f5a2e3a38482ff3;
        local l___x1a4ce4062771e36e__14 = l__Classes__7._x1a4ce4062771e36e;
        local l___x3b8a76d53cd0b01a__15 = l___x1a4ce4062771e36e__14._x0aa5621fbcbe69df._x3b8a76d53cd0b01a;
        local l___x951b8a58c97ff8ca__16 = l___x1a4ce4062771e36e__14._x951b8a58c97ff8ca;
        if l___x951b8a58c97ff8ca__16 then
            local l___x53e94b51b4ca2b03__17 = l___x951b8a58c97ff8ca__16._x53e94b51b4ca2b03;
            if l___x53e94b51b4ca2b03__17 then
                local v51 = l___x53e94b51b4ca2b03__17:Dot(((workspace.CurrentCamera and workspace.CurrentCamera.CFrame.LookVector or Vector3.new(0, 0, 1)) * Vector3.new(1, 0, 1)).Unit);
                if l___x951b8a58c97ff8ca__16._x233608aa6099009b then
                    v51 = -v51 or v51;
                end;
                if l___x951b8a58c97ff8ca__16._xeee95dd21a2f10e9 then
                    local v52 = v51 <= 0;
                    p50._xd058cad3b393c946 = v52;
                    local v53;
                    if v52 then
                        v53 = l___x951b8a58c97ff8ca__16._x2eec252e734cb573 and l___x2f5a2e3a38482ff3__13.LWallride or l___x2f5a2e3a38482ff3__13.RWallride;
                    else
                        v53 = l___x951b8a58c97ff8ca__16._x2eec252e734cb573 and l___x2f5a2e3a38482ff3__13.RWallride or l___x2f5a2e3a38482ff3__13.LWallride;
                    end;
                    if v53 and not v53.IsPlaying then
                        p50:_xc15ac5e9aea11695(v53, {
                            fade_time = 0.15
                        });
                    end;
                end;
                pcall(function() --[[ Line: 294 ]]
                    -- upvalues: l___x3b8a76d53cd0b01a__15 (copy), l__Classes__7 (ref), l___x2f5a2e3a38482ff3__13 (copy), l___x1a4ce4062771e36e__14 (copy)
                    if l___x3b8a76d53cd0b01a__15 then
                        if l__Classes__7._x1a4ce4062771e36e._xb27a7643bee832df > 2.5 and not l___x2f5a2e3a38482ff3__13.SlideAerialArm.IsPlaying then
                            l___x2f5a2e3a38482ff3__13.SlideAerialArm:Play();
                        elseif l___x2f5a2e3a38482ff3__13.SlideAerialArm.IsPlaying then
                            l___x2f5a2e3a38482ff3__13.SlideAerialArm:Stop();
                        end;
                        if not l___x2f5a2e3a38482ff3__13.SlideLoopArm.IsPlaying and l___x1a4ce4062771e36e__14._x0aa5621fbcbe69df._x3e030bdad063688a > 0.05 then
                            l___x2f5a2e3a38482ff3__13.SlideLoopArm:Play();
                            l___x2f5a2e3a38482ff3__13.SlideStartArm:Play();
                        end;
                        if l__Classes__7._x1a4ce4062771e36e._xb27a7643bee832df <= 2.5 and not (l___x2f5a2e3a38482ff3__13.SlideLoop.IsPlaying or l__Classes__7._xf1ad98d2d70b7408:_x93fd21adac562b5e("JUMP").Held) then
                            l___x2f5a2e3a38482ff3__13.SlideLoop:Play(0.15);
                        end;
                        if l___x2f5a2e3a38482ff3__13.SlideLoop.IsPlaying and l__Classes__7._x1a4ce4062771e36e._xb27a7643bee832df > 2.5 then
                            l___x2f5a2e3a38482ff3__13.SlideLoop:Stop(0.25);
                        end;
                    else
                        if l___x2f5a2e3a38482ff3__13.SlideAerialArm.IsPlaying then
                            l___x2f5a2e3a38482ff3__13.SlideAerialArm:Stop();
                        end;
                        if l___x2f5a2e3a38482ff3__13.SlideLoop.IsPlaying then
                            l___x2f5a2e3a38482ff3__13.SlideLoop:Stop(0.25);
                        end;
                        if l___x2f5a2e3a38482ff3__13.SlideLoopArm.IsPlaying then
                            l___x2f5a2e3a38482ff3__13.SlideLoopArm:Stop();
                            l___x2f5a2e3a38482ff3__13.SlideEndArm:Play();
                        end;
                    end;
                end);
            end;
        end;
    end;
end;
local function u57(p54, p55) --[[ Line: 338 ]]
    if not p54 then
        return nil;
    end;
    if typeof(p55) == "string" then
        if not string.find(p55, "/") then
            return p54:FindFirstChild(p55, true);
        end;
        p55 = string.split(p55, "/");
    end;
    if typeof(p55) ~= "table" then
        return nil;
    end;
    for _, v56 in ipairs(p55) do
        if typeof(v56) ~= "string" then
            return nil;
        end;
        p54 = p54:FindFirstChild(v56);
        if not p54 then
            return nil;
        end;
    end;
    return p54;
end;
local function u61(p58) --[[ Line: 385 ]]
    -- upvalues: u2 (copy)
    local v59 = p58:lower();
    if not v59:find("3p") then
        return nil;
    end;
    for _, v60 in u2 do
        if v59:find(v60:lower()) then
            return v60;
        end;
    end;
    return nil;
end;
function u1._x727468555a08428c(p62, p63) --[[ Line: 400 ]]
    if p63 == nil then
    else
        local v64 = p62._xc086a7dd1d36d3cc[p63];
        if v64 then
            for v65 in v64 do
                if p62._x1ae2e23bae9f4c21[v65] == p63 then
                    local v66 = p62._x2f5a2e3a38482ff3[v65];
                    if v66 then
                        v66:Stop(0);
                        v66:Destroy();
                    end;
                    p62._x2f5a2e3a38482ff3[v65] = nil;
                    p62._x1ae2e23bae9f4c21[v65] = nil;
                end;
            end;
            p62._xc086a7dd1d36d3cc[p63] = {};
        else
            p62._xc086a7dd1d36d3cc[p63] = {};
        end;
    end;
end;
function u1._x33f6d3463a2de988(p67, p68) --[[ Line: 429 ]]
    p67:_x727468555a08428c(p68);
end;
function u1._x1fa58561dbe3c5fb(p69, p70, p71, p72) --[[ Line: 433 ]]
    local v73 = p69._x1ae2e23bae9f4c21[p71];
    local v74 = v73 and p69._xc086a7dd1d36d3cc[v73];
    if v74 then
        v74[p71] = nil;
    end;
    local v75 = p69._x2f5a2e3a38482ff3[p71];
    if v75 and v75 ~= p72 then
        v75:Stop(0);
        v75:Destroy();
    end;
    p69._x2f5a2e3a38482ff3[p71] = p72;
    p69._x1ae2e23bae9f4c21[p71] = p70;
    p69._xc086a7dd1d36d3cc[p70] = p69._xc086a7dd1d36d3cc[p70] or {};
    p69._xc086a7dd1d36d3cc[p70][p71] = true;
end;
function u1._xc901cf423becbbc6(p76, p77, p78, p79) --[[ Line: 454 ]]
    -- upvalues: u61 (copy)
    local v80 = false;
    for _, v81 in p79:GetChildren() do
        if v81:IsA("Animation") then
            local v82 = u61(v81.Name);
            if v82 then
                local v83 = p78:LoadAnimation(v81);
                local v84 = v81:GetAttribute("Looped");
                local v85 = v81:GetAttribute("Priority");
                if typeof(v84) == "boolean" then
                    v83.Looped = v84;
                end;
                if typeof(v85) == "string" and Enum.AnimationPriority[v85] then
                    v83.Priority = Enum.AnimationPriority[v85];
                end;
                p76:_x1fa58561dbe3c5fb(p77, v82, v83);
                v80 = true;
            end;
        end;
    end;
    return v80;
end;
function u1._x72f76da19780a32d(u86, p87, p88) --[[ Line: 487 ]]
    -- upvalues: u1 (copy), l__LocalPlayer__8 (copy), l__ReplicatedStorage__2 (copy), u57 (copy), l__Promise__5 (copy)
    local v89 = u1:_x22b07465d7977ba9();
    if v89 and l__LocalPlayer__8.Character then
        u86:_x727468555a08428c(p87);
        local v90;
        if typeof(p87) == "Instance" then
            v90 = p87;
        elseif typeof(p87) == "string" then
            local v91 = l__ReplicatedStorage__2:FindFirstChild("Assets");
            if v91 then
                v91 = v91:FindFirstChild("Animations");
            end;
            v90 = u57(v91, p87);
        else
            v90 = nil;
        end;
        if v90 then
            u86:_xc901cf423becbbc6(p87, v89, v90);
        else
            warn("NO 3P ANIMATION FOLDER FOR ITEM : ", p87);
        end;
        if p88 ~= nil then
            local v92;
            if typeof(p88) == "Instance" then
                v92 = p88;
            elseif typeof(p88) == "string" then
                local v93 = l__ReplicatedStorage__2:FindFirstChild("Assets");
                if v93 then
                    v93 = v93:FindFirstChild("Animations");
                end;
                v92 = u57(v93, p88);
            else
                v92 = nil;
            end;
            if v92 then
                u86:_xc901cf423becbbc6(p87, v89, v92);
            else
                warn("NO 3P SKIN ANIMATION FOLDER FOR ITEM : ", p87, p88);
            end;
        end;
        l__Promise__5.defer(function() --[[ Line: 514 ]]
            -- upvalues: u86 (copy)
            u86._x532ac707743f6d92 = true;
        end);
    else
        warn("NO ANIMATOR OR NO CHARACTER");
    end;
end;
function u1._xbd1832fa1c400a7b(p94, p95, u96) --[[ Line: 519 ]]
    -- upvalues: l__Promise__5 (copy)
    local u97 = p94._x2f5a2e3a38482ff3[p95];
    if u97 then
        local v98 = 0.001;
        local v99;
        if u96 then
            v99 = u96.weight;
        else
            v99 = u96;
        end;
        local v100;
        if u96 then
            v100 = u96.speed;
        else
            v100 = u96;
        end;
        u97:Play(v98, v99, v100);
    end;
    if u96 and u96.fade_out then
        l__Promise__5.defer(function() --[[ Line: 526 ]]
            -- upvalues: u97 (copy), u96 (copy)
            u97:AdjustWeight(0, u96.fade_out - 0.03);
        end);
    end;
end;
function u1._xd30bf399914b7a4a(u101) --[[ Line: 532 ]]
    -- upvalues: l__Classes__7 (copy), l__Packets__4 (copy)
    local l__RunService__18 = game:GetService("RunService");
    local l__CurrentCamera__19 = workspace.CurrentCamera;
    local u102 = nil;
    local u103 = 0;
    local u104 = 0;
    local u105 = CFrame.Angles(1.5707963267948966, 3.141592653589793, 0);
    local u106 = Vector3.new();
    local u107 = 0;
    local l___x1a4ce4062771e36e__20 = l__Classes__7._x1a4ce4062771e36e;
    local _ = l___x1a4ce4062771e36e__20._x0aa5621fbcbe69df._x3b8a76d53cd0b01a;
    local u108 = setmetatable({}, {
        __mode = "k"
    });
    local function u117(p109, p110, p111, p112) --[[ Line: 559 ]]
        if not (p109 and (p110 and p111)) then
            return nil;
        end;
        if not (p111.Position and p111.Normal) then
            return nil;
        end;
        local l__Position__21 = p111.Position;
        local l__Normal__22 = p111.Normal;
        if l__Normal__22.Magnitude == 0 then
            return nil;
        end;
        local l__Unit__23 = l__Normal__22.Unit;
        local v113 = p109.CFrame * p110.C0 * p110.C1:Inverse();
        local l__Position__24 = v113.Position;
        local v114 = p112 - (l__Position__24 - l__Position__21):Dot(l__Unit__23);
        if math.abs(v114) < 0.0001 then
            return nil;
        end;
        local v115 = l__Position__24 + l__Unit__23 * v114;
        local v116 = CFrame.new(l__Position__24):Inverse() * v113;
        return CFrame.new(v115) * v116;
    end;
    local function u124(p118) --[[ Line: 587 ]]
        local v119 = {};
        for _, v120 in ipairs(p118:GetChildren()) do
            if v120:IsA("Motor6D") and v120.Part0 == p118 then
                local v121 = v120.Name:lower();
                local v122 = v120.Part1 and v120.Part1.Name and (v120.Part1.Name:lower() or "") or "";
                if v121:find("hip") or (v122:find("leg") or (v121:find("thigh") or (v121:find("upperleg") or v122:find("thigh")))) then
                    table.insert(v119, v120);
                end;
            end;
        end;
        if #v119 == 0 then
            for _, v123 in ipairs(p118.Parent:GetDescendants()) do
                if v123:IsA("Motor6D") and v123.Part0 == p118 then
                    table.insert(v119, v123);
                end;
            end;
        end;
        return v119;
    end;
    u101._xd8d6f1f98b8ec0b8 = u101._xd8d6f1f98b8ec0b8 or {};
    local u125 = {};
    local u126 = 0;
    l__RunService__18.Heartbeat:Connect(function(p127) --[[ Line: 665 ]]
        -- upvalues: u126 (ref), l__CurrentCamera__19 (ref), l__Classes__7 (ref), u101 (copy), u125 (copy), u106 (ref), u117 (copy), u102 (ref), u103 (ref), u104 (ref), u105 (copy), l___x1a4ce4062771e36e__20 (copy), u108 (copy), u124 (copy), u107 (ref), l__Packets__4 (ref)
        u126 = u126 + p127;
        local v128 = tick();
        local l__Position__25 = l__CurrentCamera__19.CFrame.Position;
        local l___xb6e091f68afb5ee8__26 = l__Classes__7._xb6e091f68afb5ee8;
        local v129;
        if l___xb6e091f68afb5ee8__26 and type(l___xb6e091f68afb5ee8__26._x04f89106f69c0765) == "function" then
            v129 = l___xb6e091f68afb5ee8__26:_x04f89106f69c0765();
        else
            v129 = nil;
        end;
        local v130 = 0;
        for v131, _ in pairs(u101._xd8d6f1f98b8ec0b8) do
            if v131 and v131.Parent then
                local v132 = l__Classes__7.Util:getLikelyVec3(v131);
                local v133 = v131 == v129;
                local v134, v135;
                if v133 then
                    if v133 then
                        v134 = 0;
                    else
                        v135 = l__Position__25 - v132;
                        v134 = v135:Dot(v135);
                    end;
                    u125[v131] = v134;
                    v130 = v130 + 1;
                else
                    local _, v136 = l__CurrentCamera__19:WorldToViewportPoint(v132);
                    if v136 then
                        if v133 then
                            v134 = 0;
                        else
                            v135 = l__Position__25 - v132;
                            v134 = v135:Dot(v135);
                        end;
                        u125[v131] = v134;
                        v130 = v130 + 1;
                    end;
                    u125[v131] = nil;
                end;
            else
                u125[v131] = nil;
                u101._xd8d6f1f98b8ec0b8[v131] = nil;
            end;
        end;
        local v137 = math.max(v130, 1);
        local v138 = 1 / math.sqrt(v137);
        local v139 = 0.016666666666666666 / math.clamp(v138, 0.4, 1);
        local v140 = math.clamp(v139, 0.016666666666666666, 0.125);
        if u126 < v140 then
            return;
        end;
        u126 = 0;
        for v141, v142 in pairs(u101._xd8d6f1f98b8ec0b8) do
            local l__meta__27 = v142.meta;
            if not l__meta__27 then
                l__meta__27 = {
                    next_update_at = 0,
                    last_packet_at = 0,
                    since_last_update = 10
                };
                v142.meta = l__meta__27;
            end;
            local v143, v144, v145, v146, v147;
            if l__meta__27.since_last_update then
                l__meta__27.since_last_update = l__meta__27.since_last_update - v140;
                if l__meta__27.since_last_update > 0 then
                    v143 = u125[v141];
                    if v143 then
                        v144 = v141 == v129;
                        v145 = v144 and 0.016666666666666666 or (v143 <= 1600 and 0.016666666666666666 or (v143 <= 15625 and 0.05 or (v143 <= 1690000 and 0.125 or nil)));
                        if v145 and (not l__meta__27.next_update_at or v128 >= l__meta__27.next_update_at) then
                            if v144 or (v143 <= 15625 or l__Classes__7.Util:hasLineOfSight(l__Position__25, v141)) then
                                for _, v149 in ipairs(v142.joints) do
                                    if not v149.C0 or v149.C0.Position.Magnitude <= 2 then
                                        v146 = v149.joint_name;
                                        if v146 == "Right Hip" or (v146 == "Left Hip" or v146 == "Neck") then
                                            if v141:FindFirstChild("Torso") then
                                                v147 = v141.Torso[v146];
                                            else
                                                v147 = nil;
                                            end;
                                        elseif v146 == "RootJoint" and v141:FindFirstChild("HumanoidRootPart") then
                                            v147 = v141.HumanoidRootPart.RootJoint;
                                        else
                                            v147 = nil;
                                        end;
                                        if v147 then
                                            v147.C0 = v147.C0:Lerp(v149.C0, v143 > 15625 and 0.25 or 0.5);
                                        end;
                                    end;
                                end;
                                l__meta__27.next_update_at = v128 + v145;
                                l__meta__27.since_last_update = 10;
                            else
                                l__meta__27.next_update_at = v128 + 0.2;
                            end;
                        end;
                    end;
                end;
                u101._xd8d6f1f98b8ec0b8[v141] = nil;
                u125[v141] = nil;
            else
                v143 = u125[v141];
                if v143 then
                    v144 = v141 == v129;
                    v145 = v144 and 0.016666666666666666 or (v143 <= 1600 and 0.016666666666666666 or (v143 <= 15625 and 0.05 or (v143 <= 1690000 and 0.125 or nil)));
                    if v145 and (not l__meta__27.next_update_at or v128 >= l__meta__27.next_update_at) then
                        if v144 or (v143 <= 15625 or l__Classes__7.Util:hasLineOfSight(l__Position__25, v141)) then
                            for _, v149 in ipairs(v142.joints) do
                                if not v149.C0 or v149.C0.Position.Magnitude <= 2 then
                                    v146 = v149.joint_name;
                                    if v146 == "Right Hip" or (v146 == "Left Hip" or v146 == "Neck") then
                                        if v141:FindFirstChild("Torso") then
                                            v147 = v141.Torso[v146];
                                        else
                                            v147 = nil;
                                        end;
                                    elseif v146 == "RootJoint" and v141:FindFirstChild("HumanoidRootPart") then
                                        v147 = v141.HumanoidRootPart.RootJoint;
                                    else
                                        v147 = nil;
                                    end;
                                    if v147 then
                                        v147.C0 = v147.C0:Lerp(v149.C0, v143 > 15625 and 0.25 or 0.5);
                                    end;
                                end;
                            end;
                            l__meta__27.next_update_at = v128 + v145;
                            l__meta__27.since_last_update = 10;
                        else
                            l__meta__27.next_update_at = v128 + 0.2;
                        end;
                    end;
                end;
            end;
        end;
        if l__Classes__7._x8399b2bb73e12808._x69155c6c2c2143d0 == "alive" then
            if l__Classes__7._xdca80115d2839102._xb7ba9dddb83899b5 then
            elseif l__Classes__7._x1a4ce4062771e36e._xfd7cc994ccc60ad7 then
                local l___x7c0477cd83a7fb82__28 = l__Classes__7._x1a4ce4062771e36e._x7c0477cd83a7fb82;
                if l___x7c0477cd83a7fb82__28 then
                    if l___x7c0477cd83a7fb82__28:FindFirstChild("Head") then
                        local v150 = l___x7c0477cd83a7fb82__28:FindFirstChild("Torso");
                        if v150 then
                            local v151 = v150:FindFirstChild("Neck");
                            if v151 and v151:IsA("Motor6D") then
                                if not l__CurrentCamera__19 then
                                    l__CurrentCamera__19 = workspace.CurrentCamera;
                                end;
                                if l__CurrentCamera__19 then
                                    local v152 = l___x7c0477cd83a7fb82__28:FindFirstChild("HumanoidRootPart");
                                    if v152 then
                                        local l__lookVector__29 = v150.CFrame:ToObjectSpace(l__CurrentCamera__19.CFrame).lookVector;
                                        v151.C0 = CFrame.new(0, 1, 0) * CFrame.Angles(4.71238898038469, 0, 3.141592653589793) * CFrame.Angles(0, 0, -math.asin(l__lookVector__29.x)) * CFrame.Angles(-math.asin(l__lookVector__29.y), 0, 0);
                                        local v153 = l__Classes__7._x1a4ce4062771e36e._xfd7cc994ccc60ad7 or Vector3.new();
                                        local v154 = Vector3.new(v153.X, 0, v153.Z);
                                        local l___x951b8a58c97ff8ca__30 = l__Classes__7._x1a4ce4062771e36e._x951b8a58c97ff8ca;
                                        local v155 = nil;
                                        if #u101._xea48ce296baba8ec > 0 then
                                            u106 = (workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit;
                                        elseif l___x951b8a58c97ff8ca__30 and l___x951b8a58c97ff8ca__30._xeee95dd21a2f10e9 then
                                            u106 = l__Classes__7._x1a4ce4062771e36e._xfd7cc994ccc60ad7 * Vector3.new(1, 0, 1);
                                            if u106.Magnitude > 0 then
                                                u106 = u106.Unit;
                                            end;
                                            if u101._xd058cad3b393c946 then
                                                u106 = -u106;
                                            end;
                                            if l___x951b8a58c97ff8ca__30._x233608aa6099009b then
                                                u106 = -u106;
                                            end;
                                            v155 = u117(v152, v152.RootJoint, l___x951b8a58c97ff8ca__30._xd3b8638e21ed0941, 2.5);
                                        else
                                            local l__LookVector__31 = l__CurrentCamera__19.CFrame.LookVector;
                                            local v156 = Vector3.new(l__LookVector__31.X, 0, l__LookVector__31.Z);
                                            if v156.Magnitude < 1e-6 then
                                                v156 = Vector3.new(v152.CFrame.LookVector.X, 0, v152.CFrame.LookVector.Z);
                                            end;
                                            local l__Unit__32 = v156.Unit;
                                            local v157 = math.atan2(l__Unit__32.X, l__Unit__32.Z) + 0;
                                            local v158;
                                            if v154.Magnitude > 0.05 then
                                                v158 = v154.Unit;
                                            else
                                                v158 = Vector3.new(v152.CFrame.LookVector.X, 0, v152.CFrame.LookVector.Z).Unit;
                                            end;
                                            local v159 = l__Unit__32:Dot(v158);
                                            if math.clamp(v159, -1, 1) <= -0.5000000000000001 then
                                                u106 = u106:Lerp(l__Unit__32, (math.clamp(10 * p127, 0, 1)));
                                            else
                                                local v160 = math.atan2(v158.X, v158.Z) - v157;
                                                while v160 > 3.141592653589793 do
                                                    v160 = v160 - 6.283185307179586;
                                                end;
                                                while v160 < -3.141592653589793 do
                                                    v160 = v160 + 6.283185307179586;
                                                end;
                                                local v161 = v157 + (math.abs(v160) > 0.7853981633974483 and (v160 > 0 and 0.7853981633974483 or -0.7853981633974483) or v160);
                                                while v161 > 3.141592653589793 do
                                                    v161 = v161 - 6.283185307179586;
                                                end;
                                                while v161 < -3.141592653589793 do
                                                    v161 = v161 + 6.283185307179586;
                                                end;
                                                local v162 = math.sin(v161);
                                                local v163 = math.cos(v161);
                                                u106 = u106:Lerp(Vector3.new(v162, 0, v163), (math.clamp(25 * p127, 0, 1)));
                                            end;
                                            if u106.Magnitude > 0 then
                                                u106 = u106.Unit;
                                            end;
                                        end;
                                        local v164 = CFrame.new();
                                        if u106.Magnitude > 0.001 then
                                            local l__Rotation__33 = v152.CFrame.Rotation;
                                            local v165 = CFrame.lookAt(Vector3.new(0, 0, 0), u106);
                                            local _, v166, _ = (l__Rotation__33:Inverse() * v165):ToOrientation();
                                            v164 = CFrame.Angles(0, v166, 0);
                                        end;
                                        local _ = v152.CFrame:ToObjectSpace(l___x7c0477cd83a7fb82__28.Torso.CFrame).Position;
                                        if v153 and v153.Magnitude > 2 then
                                            u102 = v153.Unit;
                                            local v167 = CFrame.lookAt(Vector3.new(0, 0, 0), u106);
                                            local v168 = v167.RightVector:Dot(u102);
                                            local v169;
                                            if l__Classes__7._x1a4ce4062771e36e._x9baf9bb47de1af88 then
                                                v169 = 5.5;
                                            else
                                                local v170 = math.clamp((l__Classes__7._x1a4ce4062771e36e._xfd7cc994ccc60ad7 * Vector3.new(1, 0, 1)).Magnitude, 0, 75);
                                                v169 = l__Classes__7.Util:convNumRange(v170, 0, 75, 5.5, 2);
                                            end;
                                            u103 = v168 / v169;
                                            local v171 = v167.LookVector:Dot(u102);
                                            local v172;
                                            if l__Classes__7._x1a4ce4062771e36e._x9baf9bb47de1af88 then
                                                v172 = 5.5;
                                            else
                                                local v173 = math.clamp((l__Classes__7._x1a4ce4062771e36e._xfd7cc994ccc60ad7 * Vector3.new(1, 0, 1)).Magnitude, 0, 75);
                                                v172 = l__Classes__7.Util:convNumRange(v173, 0, 75, 5.5, 2);
                                            end;
                                            u104 = v171 / v172;
                                        else
                                            u103 = 0;
                                            u104 = 0;
                                        end;
                                        local v174 = math.clamp(l__CurrentCamera__19.CFrame.LookVector.Y, -1, 1);
                                        local v175 = math.asin(v174) * 1 * 0.65;
                                        local v176 = math.abs(v175) < 0.00001 and 0 or v175;
                                        local l__RootJoint__34 = v152.RootJoint;
                                        local v177 = v164 * (u105 * CFrame.Angles(u104, -u103, 0)) * CFrame.Angles(-v176, 0, 0);
                                        if v155 then
                                            local v178 = v152.CFrame * v177 * v152.RootJoint.C1:Inverse();
                                            local v179 = CFrame.new(v178.Position):Inverse() * v178;
                                            local v180 = CFrame.new(v155.Position) * v179;
                                            v177 = v152.CFrame:Inverse() * v180 * v152.RootJoint.C1;
                                        end;
                                        local v181;
                                        if l___x1a4ce4062771e36e__20._x0aa5621fbcbe69df and type(l___x1a4ce4062771e36e__20._x0aa5621fbcbe69df._x3b8a76d53cd0b01a) == "boolean" then
                                            v181 = l___x1a4ce4062771e36e__20._x0aa5621fbcbe69df._x3b8a76d53cd0b01a;
                                        else
                                            v181 = false;
                                        end;
                                        if v181 and l__Classes__7._x1a4ce4062771e36e._xb27a7643bee832df < 2.5 then
                                            local l___xa3ff6193531a2bbd__35 = l__Classes__7._x1a4ce4062771e36e._xa3ff6193531a2bbd;
                                            local v182 = (not l___xa3ff6193531a2bbd__35 or (not l___xa3ff6193531a2bbd__35.Normal or l___xa3ff6193531a2bbd__35.Normal.Magnitude <= 1e-6)) and Vector3.new(0, 1, 0) or l___xa3ff6193531a2bbd__35.Normal.Unit;
                                            local v183 = l__Classes__7._x1a4ce4062771e36e._xfd7cc994ccc60ad7 or Vector3.new();
                                            local v184 = v183 - v182 * v183:Dot(v182);
                                            if v184.Magnitude < 1e-6 then
                                                local v185 = Vector3.new(v152.CFrame.LookVector.X, 0, v152.CFrame.LookVector.Z);
                                                v184 = v185 - v182 * v185:Dot(v182);
                                            end;
                                            local l__Y__36 = (v184.Magnitude <= 1e-6 and Vector3.new(0, 0, -1) or v184.Unit).Y;
                                            local v186 = math.clamp(-l__Y__36, 0, 1);
                                            local v187 = math.clamp(l__Y__36, 0, 1);
                                            local v188 = math.clamp(v186 * 0.7068583470577035 + 0.7853981633974483 - v187 * 0.39269908169872414, 0, 1.3962634015954636);
                                            v177 = v177 * CFrame.Angles(-v188, 0, 0);
                                        end;
                                        l__RootJoint__34.C0 = v177;
                                        if not u108[l___x7c0477cd83a7fb82__28] then
                                            local v189 = u124(v150);
                                            local v190 = {};
                                            for _, v191 in ipairs(v189) do
                                                v190[v191.Name] = v191.C0;
                                            end;
                                            u108[l___x7c0477cd83a7fb82__28] = v190;
                                        end;
                                        local v192 = u108[l___x7c0477cd83a7fb82__28] or {};
                                        local v193 = nil;
                                        local v194 = nil;
                                        for v195, v196 in pairs(v192) do
                                            local v197 = v150:FindFirstChild(v195);
                                            if v197 and v197:IsA("Motor6D") then
                                                if v197.Name == "Right Hip" then
                                                    v197.C0 = v196 * CFrame.Angles(0, 0, -v176 * 0.74);
                                                    v193 = v197;
                                                elseif v197.Name == "Left Hip" then
                                                    v197.C0 = v196 * CFrame.Angles(0, 0, v176 * 0.74);
                                                    v194 = v197;
                                                end;
                                            else
                                                v192[v195] = nil;
                                            end;
                                        end;
                                        v152.RootJoint.C0 = v152.RootJoint.C0:Lerp(v164 * u105 * CFrame.Angles(u104, -u103, 0), 0.1);
                                        u107 = u107 + p127;
                                        if u107 >= 0.05 then
                                            u107 = u107 - 0.05;
                                            local v198 = {};
                                            local v199 = {};
                                            for _, v200 in {
                                                v152.RootJoint,
                                                v151,
                                                v193,
                                                v194
                                            } do
                                                table.insert(v198, {
                                                    joint_name = v200.Name,
                                                    C0 = v200.C0
                                                });
                                            end;
                                            v199.joints = v198;
                                            l__Packets__4.unreliablePackets._xe68977d6b045970c:Fire(v199);
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end);
end;
function u1._x44bcd6af41218f92(u201) --[[ Line: 1102 ]]
    -- upvalues: l__Packets__4 (copy), l__Classes__7 (copy), l__RunService__1 (copy)
    local u202 = {
        ["Right Hip"] = true,
        ["Left Hip"] = true,
        Neck = true,
        RootJoint = true
    };
    l__Packets__4.unreliablePackets._xe68977d6b045970c.OnClientEvent:Connect(function(p203) --[[ Line: 1109 ]]
        -- upvalues: u201 (copy), u202 (copy)
        if p203 and p203.character then
            local l__character__37 = p203.character;
            if l__character__37.Parent then
                local v204 = tick();
                local v205 = u201._xd8d6f1f98b8ec0b8[l__character__37];
                if p203.ts and (v205 and (v205.meta and (v205.meta.last_packet_at and p203.ts <= v205.meta.last_packet_at))) then
                else
                    if not v205 then
                        v205 = {
                            joints = {},
                            meta = {
                                next_update_at = 0,
                                last_packet_at = 0,
                                since_last_update = 3
                            }
                        };
                        u201._xd8d6f1f98b8ec0b8[l__character__37] = v205;
                    end;
                    v205.joints = {};
                    if p203.joints and type(p203.joints) == "table" then
                        for v206 = 1, #p203.joints do
                            local v207 = p203.joints[v206];
                            if v207 and (v207.joint_name and (u202[v207.joint_name] and v207.C0)) then
                                table.insert(v205.joints, {
                                    joint_name = v207.joint_name,
                                    C0 = v207.C0
                                });
                            end;
                        end;
                    end;
                    v205.meta.last_packet_at = p203.ts or v204;
                    v205.meta.since_last_update = 3;
                end;
            end;
        end;
    end);
    task.defer(function() --[[ Line: 1164 ]]
        -- upvalues: l__Classes__7 (ref), u201 (copy), l__RunService__1 (ref)
        l__Classes__7._xec10753807252baa._x80da228185a26245:Connect(function(...) --[[ Line: 1165 ]]
            -- upvalues: u201 (ref)
            u201:_xd40bc6b042eab924(...);
        end);
        l__RunService__1.Heartbeat:Connect(function() --[[ Line: 1169 ]]
            -- upvalues: u201 (ref)
            u201:_x7821e70d7e4d1096();
        end);
        u201:_xd30bf399914b7a4a();
    end);
end;
return u1;
