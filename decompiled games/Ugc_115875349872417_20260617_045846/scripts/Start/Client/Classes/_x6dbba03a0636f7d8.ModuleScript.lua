-- Decompiled from: Start.Client.Classes._x6dbba03a0636f7d8
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__SoundService__2 = game:GetService("SoundService");
local u1 = {};
u1.__index = u1;
local l__Sound__3 = game:GetService("ReplicatedStorage").Assets.Sound;
local l__Footsteps__4 = require(l__Sound__3.Footsteps);
local l__Promise__5 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Promise);
local l__Packets__6 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Packets);
local l__ClientRoot__7 = require(script.Parent.Parent.ClientRoot);
local l__Classes__8 = l__ClientRoot__7.Classes;
local l__Context__9 = l__ClientRoot__7.Context;
function u1._x83ed94bfb82a8c9f() --[[ Line: 26 ]]
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._x55f1ae731fe94e90 = false;
    v2._x955ab9ae4c391434 = false;
    v2._x8a5dbe420ade44d6 = false;
    v2._x44e7e41132b5732d = Vector3.new();
    v2._x318f7b62533712d0 = 0;
    v2._xbf23baf30cce3cb2 = {};
    v2._xedf929c791d02d18 = false;
    v2._xc0989d1b8c0e05c7 = {
        FOOTSTEPS_RUN_DISTANCE = 10,
        FOOTSTEP_DEBOUNCE = 1,
        FOOTSTEP_VOLUME = 0.075,
        BHOP_DEBOUNCE = 0.2,
        AIR_AMBIENT_THRESHOLD = 60,
        AIR_AMBIENT_UPPER_BOUND = 150,
        AIR_AMBIENT_LAST_VOLUME = 0.35,
        AIR_AMBIENT_FIRST_PLAYBACK = 0.85,
        AIR_AMBIENT_LAST_PLAYBACK = 1,
        FREEFALL_THRESHOLD = 60,
        FREEFALL_UPPER_BOUND = 110,
        FREEFALL_LAST_VOLUME = 0.3,
        FREEFALL_FIRST_PLAYBACK = 0.6,
        FREEFALL_LAST_PLAYBACK = 0.85,
        SLIDE_UPPER_BOUND = 100,
        SLIDE_SPARKING_THRESHOLD = 80,
        SLIDE_SPARKING_UPPER_BOUND = 120,
        SLIDE_SOUND = 0.2,
        SLIDE_LOOP_MULTI = 1.5,
        SLIDE_SPARK_MULTI = 2,
        SLIDE_FIRST_PLAYBACK = 1,
        SLIDE_LAST_PLAYBACK = 1.2,
        WALLRIDE_FOOTSTEP_DISTANCE = 20,
        WALLRIDE_FOOTSTEP_DEBOUNCE = 0.2,
        WALLRIDE_LOOP_LAST_VOLUME = 0.004,
        LANDING_THRESHOLD = -20,
        LANDING_LAST_VOLUME = 0.9,
        LANDING_UPPER_BOUND = -250
    };
    v2._xc809710081556ff1 = nil;
    v2._xd558b5cf16bcbf0d = nil;
    return v2;
end;
function u1._x9940bbd9d4ca5cc1(p3) --[[ Line: 81 ]]
    if p3._xedf929c791d02d18 then
    else
        p3._xedf929c791d02d18 = true;
    end;
end;
function u1._x60bd6a58e711ba4f(u4) --[[ Line: 86 ]]
    -- upvalues: l__RunService__1 (copy), l__Classes__8 (copy)
    u4._xc809710081556ff1:Play();
    u4._xd558b5cf16bcbf0d:Play();
    l__RunService__1.Heartbeat:Connect(function(p5) --[[ Line: 90 ]]
        -- upvalues: l__Classes__8 (ref), u4 (copy)
        local function v7() --[[ Line: 100 ]]
            -- upvalues: l__Classes__8 (ref), u4 (ref)
            if l__Classes__8._x1a4ce4062771e36e._xfd7cc994ccc60ad7.Magnitude <= u4._xc0989d1b8c0e05c7.AIR_AMBIENT_THRESHOLD then
                return 0;
            end;
            local v6 = math.clamp(l__Classes__8._x1a4ce4062771e36e._xfd7cc994ccc60ad7.Magnitude, u4._xc0989d1b8c0e05c7.AIR_AMBIENT_THRESHOLD, u4._xc0989d1b8c0e05c7.AIR_AMBIENT_UPPER_BOUND);
            return l__Classes__8.Util:convNumRange(v6, u4._xc0989d1b8c0e05c7.AIR_AMBIENT_THRESHOLD, u4._xc0989d1b8c0e05c7.AIR_AMBIENT_UPPER_BOUND, u4._xc0989d1b8c0e05c7.AIR_AMBIENT_FIRST_PLAYBACK, u4._xc0989d1b8c0e05c7.AIR_AMBIENT_LAST_PLAYBACK);
        end;
        local function v9() --[[ Line: 109 ]]
            -- upvalues: l__Classes__8 (ref), u4 (ref)
            if l__Classes__8._x1a4ce4062771e36e._xfd7cc994ccc60ad7.Magnitude <= u4._xc0989d1b8c0e05c7.FREEFALL_THRESHOLD then
                return 0;
            end;
            local v8 = math.clamp(l__Classes__8._x1a4ce4062771e36e._xfd7cc994ccc60ad7.Magnitude, u4._xc0989d1b8c0e05c7.FREEFALL_THRESHOLD, u4._xc0989d1b8c0e05c7.FREEFALL_UPPER_BOUND);
            return l__Classes__8.Util:convNumRange(v8, u4._xc0989d1b8c0e05c7.FREEFALL_THRESHOLD, u4._xc0989d1b8c0e05c7.FREEFALL_UPPER_BOUND, 0, u4._xc0989d1b8c0e05c7.FREEFALL_LAST_VOLUME);
        end;
        local function v11() --[[ Line: 118 ]]
            -- upvalues: l__Classes__8 (ref), u4 (ref)
            if l__Classes__8._x1a4ce4062771e36e._xfd7cc994ccc60ad7.Magnitude <= u4._xc0989d1b8c0e05c7.FREEFALL_THRESHOLD then
                return 0;
            end;
            local v10 = math.clamp(l__Classes__8._x1a4ce4062771e36e._xfd7cc994ccc60ad7.Magnitude, u4._xc0989d1b8c0e05c7.FREEFALL_THRESHOLD, u4._xc0989d1b8c0e05c7.FREEFALL_UPPER_BOUND);
            return l__Classes__8.Util:convNumRange(v10, u4._xc0989d1b8c0e05c7.FREEFALL_THRESHOLD, u4._xc0989d1b8c0e05c7.FREEFALL_UPPER_BOUND, u4._xc0989d1b8c0e05c7.FREEFALL_FIRST_PLAYBACK, u4._xc0989d1b8c0e05c7.FREEFALL_LAST_PLAYBACK);
        end;
        u4._xc809710081556ff1.Volume = l__Classes__8.Util:numLerp(u4._xc809710081556ff1.Volume, (function() --[[ Name: getAirVolume, Line 91 ]]
            -- upvalues: l__Classes__8 (ref), u4 (ref)
            if l__Classes__8._x1a4ce4062771e36e._xfd7cc994ccc60ad7.Magnitude <= u4._xc0989d1b8c0e05c7.AIR_AMBIENT_THRESHOLD then
                return 0;
            end;
            local v12 = math.clamp(l__Classes__8._x1a4ce4062771e36e._xfd7cc994ccc60ad7.Magnitude, u4._xc0989d1b8c0e05c7.AIR_AMBIENT_THRESHOLD, u4._xc0989d1b8c0e05c7.AIR_AMBIENT_UPPER_BOUND);
            return l__Classes__8.Util:convNumRange(v12, u4._xc0989d1b8c0e05c7.AIR_AMBIENT_THRESHOLD, u4._xc0989d1b8c0e05c7.AIR_AMBIENT_UPPER_BOUND, 0, u4._xc0989d1b8c0e05c7.AIR_AMBIENT_LAST_VOLUME);
        end)(), 1 * p5);
        u4._xc809710081556ff1.PlaybackSpeed = v7();
        u4._xd558b5cf16bcbf0d.Volume = l__Classes__8.Util:numLerp(u4._xd558b5cf16bcbf0d.Volume, v9(), 1 * p5);
        u4._xd558b5cf16bcbf0d.PlaybackSpeed = v11();
    end);
end;
function u1._x53e234f33280d323(p13, p14, p15, p16, p17) --[[ Line: 135 ]]
    local v18;
    if typeof(p14) == "string" then
        v18 = Instance.new("Sound");
        v18.SoundId = p14;
    else
        if not p14:IsA("Sound") then
            warn("INVALID sound_id : ", p14);
            return;
        end;
        v18 = p14:Clone();
    end;
    if not p16.Parent then
        v18.Parent = game:GetService("ReplicatedStorage").Temp;
    end;
    if p16 then
        for v19, v20 in pairs(p16) do
            v18[v19] = v20;
        end;
    end;
    if p15 then
        p13:_xaaad61114bab4a13(v18, p17);
    end;
    return v18;
end;
function u1._xaaad61114bab4a13(_, u21, _) --[[ Line: 163 ]]
    -- upvalues: l__Promise__5 (copy)
    return u21, l__Promise__5.new(function(u22, _, p23) --[[ Line: 164 ]]
        -- upvalues: u21 (copy)
        u21:Play();
        local u24 = u21.Ended:Once(function() --[[ Line: 166 ]]
            -- upvalues: u22 (copy)
            u22();
        end);
        p23(function() --[[ Line: 169 ]]
            -- upvalues: u21 (ref), u24 (copy)
            u21:Stop();
            u24:Disconnect();
            u21:Destroy();
        end);
    end):andThen(function() --[[ Line: 174 ]]
        -- upvalues: u21 (copy)
        u21:Stop();
        u21:Destroy();
    end);
end;
function u1._xa14b624022539602(_, p25, p26, p27) --[[ Line: 181 ]]
    local v28 = Instance.new("PitchShiftSoundEffect");
    v28.Octave = Random.new():NextNumber(p26, p27);
    v28.Parent = p25;
    return v28, p25;
end;
function u1._x868cb7efd0a7c7f0(_, p29) --[[ Line: 190 ]]
    local v30 = {};
    for _, v31 in p29:GetChildren() do
        if v31:IsA("Sound") then
            table.insert(v30, v31);
        end;
    end;
    if #v30 > 0 then
        return v30[math.random(1, #v30)];
    end;
    warn("NO SOUND CHILDREN FOR sound_group : " .. p29.Name);
    return nil;
end;
function u1._xe82b36e3c63e9c6f(p32, p33) --[[ Line: 206 ]]
    -- upvalues: l__Sound__3 (copy)
    local v34 = {};
    for _, v35 in pairs(l__Sound__3:GetDescendants()) do
        if v35:IsA("Sound") then
            if v35.Name == p33 then
                table.insert(v34, v35);
            end;
        elseif v35:IsA("SoundGroup") and v35.Name == p33 then
            local v36 = p32:_x868cb7efd0a7c7f0(v35);
            if v36 then
                table.insert(v34, v36);
            end;
        end;
    end;
    if #v34 > 1 then
        warn("MULTIPLE CANDIDATES FOR sound_name : " .. p33);
    else
        local _ = #v34 == 0;
    end;
    return v34[1];
end;
function u1._xe87f5b6b2f42d186(_, p37) --[[ Line: 233 ]]
    while p37 do
        if p37.Name == "SkinAssets" then
            return true;
        end;
        p37 = p37.Parent;
    end;
    return false;
end;
function u1._x280829f3fff1f940(_, p38) --[[ Line: 246 ]]
    if p38 then
        p38 = p38:FindFirstAncestorWhichIsA("Folder");
    end;
    if p38 then
        p38 = p38.Name;
    end;
    return p38;
end;
function u1._x9b16e68e4e5311ac(p39, p40, p41, p42) --[[ Line: 251 ]]
    -- upvalues: l__SoundService__2 (copy)
    local v43 = p39:_x280829f3fff1f940(p41);
    local v44 = p39:_xe87f5b6b2f42d186(p42) and not (v43 and l__SoundService__2:FindFirstChild(v43)) and "Combat" or v43;
    if v44 then
        local v45 = l__SoundService__2:FindFirstChild(v44);
        if v45 then
            p40.SoundGroup = v45;
            return p40;
        else
            warn("NO SOUND GROUP FOR sound_folder : " .. v44);
            return p40;
        end;
    else
        return p40;
    end;
end;
function u1._xd92c16a04eadf74c(_, p46, p47) --[[ Line: 271 ]]
    if not (p47 and p47.location) then
        local v48 = p46:Clone();
        v48.Parent = p47 and p47.Parent or game:GetService("ReplicatedStorage").Temp;
        return v48;
    end;
    if not game.Workspace:WaitForChild("Effects") then
        warn("NO EFFECTS FOLDER");
        return nil;
    end;
    local v49 = Instance.new("Part");
    v49.Transparency = 1;
    v49.CanCollide = false;
    v49.CanQuery = false;
    v49.Anchored = true;
    v49.Position = typeof(p47.location) == "CFrame" and p47.location.Position or p47.location;
    v49.Parent = game.Workspace.Effects;
    local v50 = p46:Clone();
    v50.Parent = p47 and p47.Parent or game:GetService("ReplicatedStorage").Temp;
    v50.Parent = v49;
    game.Debris:AddItem(v49, p46.TimeLength + 1);
    return v50;
end;
function u1._x57386e2103c11a20(_, p51, p52) --[[ Line: 304 ]]
    if p52 then
        for v53, v54 in pairs(p52) do
            if v53 ~= "Parent" and (v53 ~= "location" and (v53 ~= "delay_time" and v53 ~= "presence")) then
                p51[v53] = v54;
            end;
        end;
    end;
end;
function u1._xb54e039fb880d248(p55, p56, p57) --[[ Line: 319 ]]
    local v58;
    if p57 and p57.presence ~= nil then
        local v59 = tonumber(p57.presence) or 0;
        v58 = math.clamp(v59, 0, 1);
    else
        v58 = 0;
    end;
    p56:SetAttribute("Presence", v58);
    p55._xbf23baf30cce3cb2[p56] = {
        presence = v58,
        baseVolume = p56.Volume
    };
    p55:_x9940bbd9d4ca5cc1();
end;
function u1._x0398a45a0009d999(u60, _, p61, p62, p63, p64) --[[ Line: 333 ]]
    if p61 then
        local u65 = u60:_xd92c16a04eadf74c(p61, p64);
        if u65 then
            u60:_x9b16e68e4e5311ac(u65, p62, p61);
            u60:_x57386e2103c11a20(u65, p64);
            u60:_xb54e039fb880d248(u65, p64);
            if p63 then
                if p64 and p64.delay_time then
                    task.delay(p64.delay_time, function() --[[ Line: 349 ]]
                        -- upvalues: u60 (copy), u65 (copy)
                        local v66, v67 = u60:_xaaad61114bab4a13(u65);
                        return v66, v67;
                    end);
                    return u65;
                else
                    local v68, v69 = u60:_xaaad61114bab4a13(u65);
                    return v68, v69;
                end;
            else
                return u65;
            end;
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function u1._x9ee2f6b7fa34c7a4(p70, p71, _) --[[ Line: 362 ]]
    local v72 = p70:_xe82b36e3c63e9c6f(p71);
    if v72 then
        return v72, v72.SoundId;
    else
        return nil;
    end;
end;
function u1._x96bdbb48d62a3075(p73, p74, p75, p76, p77) --[[ Line: 371 ]]
    if typeof(p75) ~= "Instance" or not p75:IsA("Sound") then
        if typeof(p75) ~= "Instance" or not p75:IsA("SoundGroup") then
            warn("INVALID sound source : ", p75);
            return nil;
        end;
        p75 = p73:_x868cb7efd0a7c7f0(p75);
    end;
    return p73:_x0398a45a0009d999(p74, p75, p73:_xe82b36e3c63e9c6f(p74) or p75, p76, p77);
end;
function u1._x282746dbf42c87cb(p78, p79, p80, p81) --[[ Line: 386 ]]
    local v82 = p78:_xe82b36e3c63e9c6f(p79);
    return p78:_x0398a45a0009d999(p79, v82, v82, p80, p81);
end;
function u1._x74d204afa3b0a5ee(p83) --[[ Line: 391 ]]
    -- upvalues: l__Classes__8 (copy), l__Footsteps__4 (copy), l__SoundService__2 (copy)
    local v84;
    if l__Classes__8._x1a4ce4062771e36e._x9baf9bb47de1af88 then
        v84 = l__Classes__8._x1a4ce4062771e36e._x6afad09dc0eadae4;
    elseif l__Classes__8._x1a4ce4062771e36e._x951b8a58c97ff8ca._xd3b8638e21ed0941 then
        v84 = l__Classes__8._x1a4ce4062771e36e._x951b8a58c97ff8ca._xd3b8638e21ed0941.Material;
    else
        v84 = l__Classes__8._x1a4ce4062771e36e._x6afad09dc0eadae4;
    end;
    local v85 = l__Footsteps__4:GetTableFromMaterial(v84);
    if v85 then
        local v86 = l__Footsteps__4:GetRandomSound(v85);
        local v87 = p83._xc0989d1b8c0e05c7.FOOTSTEP_VOLUME * l__SoundService__2:FindFirstChild("Movement").Volume;
        p83:_x53e234f33280d323(v86, true, {
            Parent = game:GetService("ReplicatedStorage").Temp,
            Volume = v87
        }, true);
    end;
end;
function u1._xe48759f6c9d6a816(u88) --[[ Line: 410 ]]
    -- upvalues: l__Classes__8 (copy), l__Promise__5 (copy)
    local l__main__10 = l__Classes__8._xec10753807252baa:_x1aa0845d51ab47a4().main;
    local l__Position__11 = l__Classes__8._x1a4ce4062771e36e._xde8b8f659627fa3f.Position;
    u88._x318f7b62533712d0 = u88._x318f7b62533712d0 + (u88._x44e7e41132b5732d - l__Position__11).Magnitude;
    u88._x44e7e41132b5732d = l__Position__11;
    if l__Classes__8._x1a4ce4062771e36e._x9baf9bb47de1af88 and (l__main__10 == "running" and (not u88._x55f1ae731fe94e90 and u88._x318f7b62533712d0 >= u88._xc0989d1b8c0e05c7.FOOTSTEPS_RUN_DISTANCE)) then
        u88._x318f7b62533712d0 = 0;
        u88:_x74d204afa3b0a5ee();
        u88._x7e4e29b6d5e0094a = true;
        l__Promise__5.delay(u88._xc0989d1b8c0e05c7.FOOTSTEP_DEBOUNCE):andThen(function() --[[ Line: 423 ]]
            -- upvalues: u88 (copy)
            u88._x7e4e29b6d5e0094a = false;
        end);
    end;
    if l__main__10 == "wallriding" and (u88._x318f7b62533712d0 >= u88._xc0989d1b8c0e05c7.WALLRIDE_FOOTSTEP_DISTANCE and not u88._x955ab9ae4c391434) then
        u88._x318f7b62533712d0 = 0;
        u88:_x53e234f33280d323(u88:_x9ee2f6b7fa34c7a4("WALLRIDE_STEPS"), true, {}, true);
        u88._x955ab9ae4c391434 = true;
        l__Promise__5.delay(u88._xc0989d1b8c0e05c7.WALLRIDE_FOOTSTEP_DEBOUNCE):andThen(function() --[[ Line: 436 ]]
            -- upvalues: u88 (copy)
            u88._x955ab9ae4c391434 = false;
        end);
    end;
end;
function u1._x01224f6816860aab(u89) --[[ Line: 443 ]]
    -- upvalues: l__Classes__8 (copy), l__Promise__5 (copy)
    l__Classes__8._xec10753807252baa._xb113ba88524e9dcd:Connect(function(p90) --[[ Line: 444 ]]
        -- upvalues: u89 (copy), l__Promise__5 (ref)
        if p90.main == "bhop_jump" then
            if u89._x8a5dbe420ade44d6 then
                return;
            end;
            u89._x8a5dbe420ade44d6 = true;
            l__Promise__5.delay(u89._xc0989d1b8c0e05c7.BHOP_DEBOUNCE):andThen(function() --[[ Line: 449 ]]
                -- upvalues: u89 (ref)
                u89._x8a5dbe420ade44d6 = false;
            end);
            u89:_x74d204afa3b0a5ee();
            u89:_x282746dbf42c87cb("STEP_JUMP", true, {
                Parent = game:GetService("ReplicatedStorage").Temp
            });
        end;
    end);
    l__Classes__8._x1a4ce4062771e36e._x951b8a58c97ff8ca._x338212fc581251d3.Event:Connect(function() --[[ Line: 458 ]]
        -- upvalues: l__Classes__8 (ref), u89 (copy)
        if l__Classes__8._x1a4ce4062771e36e._x0aa5621fbcbe69df._x3b8a76d53cd0b01a then
            u89:_x282746dbf42c87cb("STEP_JUMP", true);
        end;
    end);
    l__Classes__8._x1a4ce4062771e36e._x120e1025f793eae7.Event:Connect(function() --[[ Line: 464 ]]
        -- upvalues: l__Classes__8 (ref), u89 (copy)
        local v91 = math.clamp(l__Classes__8._x1a4ce4062771e36e._xdcc0b66c047f13fd, u89._xc0989d1b8c0e05c7.LANDING_UPPER_BOUND, u89._xc0989d1b8c0e05c7.LANDING_THRESHOLD);
        if l__Classes__8._x1a4ce4062771e36e._xdcc0b66c047f13fd < u89._xc0989d1b8c0e05c7.LANDING_THRESHOLD then
            u89:_x282746dbf42c87cb("FALL_LANDING", true, {
                Volume = l__Classes__8.Util:convNumRange(v91, u89._xc0989d1b8c0e05c7.LANDING_UPPER_BOUND, u89._xc0989d1b8c0e05c7.LANDING_THRESHOLD, u89._xc0989d1b8c0e05c7.LANDING_LAST_VOLUME, 0)
            });
        end;
    end);
end;
function u1._xd60838b8b7c3adfd(p92, p93, p94) --[[ Line: 474 ]]
    -- upvalues: l__Classes__8 (copy)
    local v95;
    if typeof(p94) == "table" then
        v95 = p94.skin_sound or nil;
    else
        v95 = nil;
    end;
    if typeof(v95) == "table" then
        local v96 = table.clone(p94);
        v96.skin_sound = nil;
        local l__item_type__12 = v95.item_type;
        local l__item_id__13 = v95.item_id;
        local l__sound_key__14 = v95.sound_key;
        if typeof(v95.fallback) == "string" then
            p93 = v95.fallback;
        end;
        if typeof(l__item_type__12) == "string" and (typeof(l__item_id__13) == "string" and (typeof(l__sound_key__14) == "string" and l__Classes__8._x8613500a592ecb35)) then
            local v97 = l__Classes__8._x8613500a592ecb35:_x743a226b34a5008a(l__item_type__12);
            if v97 and v97._x54a15972d659cdb0 == l__item_id__13 then
                return l__Classes__8._x21d532a942394db8:_x1cb0a480fdf821f4(v97._xcb0c9fdbaf1f513a, p92, l__sound_key__14, true, v96, p93);
            else
                return p92:_x282746dbf42c87cb(p93, true, v96);
            end;
        else
            return p92:_x282746dbf42c87cb(p93, true, v96);
        end;
    else
        return p92:_x282746dbf42c87cb(p93, true, p94);
    end;
end;
function u1._x44bcd6af41218f92(u98) --[[ Line: 510 ]]
    -- upvalues: l__Packets__6 (copy), l__Context__9 (copy), l__RunService__1 (copy)
    l__Packets__6._x6e9214eccf062dbf.OnClientEvent:Connect(function(p99, p100) --[[ Line: 511 ]]
        -- upvalues: u98 (copy)
        u98:_xd60838b8b7c3adfd(p99, p100);
    end);
    if l__Context__9.is_gameplay_mode then
        u98._xc809710081556ff1 = u98:_x282746dbf42c87cb("AIR_AMBIENT", false, {
            Parent = game:GetService("ReplicatedStorage").Temp
        });
        u98._xd558b5cf16bcbf0d = u98:_x282746dbf42c87cb("FREEFALL", false, {
            Parent = game:GetService("ReplicatedStorage").Temp
        });
        task.defer(function() --[[ Line: 522 ]]
            -- upvalues: u98 (copy), l__RunService__1 (ref)
            u98:_x01224f6816860aab();
            u98:_x60bd6a58e711ba4f();
            l__RunService__1.Heartbeat:Connect(function() --[[ Line: 526 ]]
                -- upvalues: u98 (ref)
                u98:_xe48759f6c9d6a816();
            end);
        end);
    end;
end;
return u1;
