-- Decompiled from: Start.Client.Classes._xbe184fb1376a575d
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__SoundService__2 = game:GetService("SoundService");
local u1 = {};
u1.__index = u1;
local l__Sound__3 = game:GetService("ReplicatedStorage").Assets.Sound;
local l__Footsteps__4 = require(l__Sound__3.Footsteps);
local l__Promise__5 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Promise);
local l__Packets__6 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Packets) -- Packets;
local l__ClientRoot__7 = require(script.Parent.Parent.ClientRoot);
local l__Classes__8 = l__ClientRoot__7.Classes;
local l__Context__9 = l__ClientRoot__7.Context;
function u1._x90d4581ac99dd483() --[[ Line: 17 ]]
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._x115fabfba3f84804 = false;
    v2._xf8066c2255c88284 = false;
    v2._x0d708ff9e4f8983c = false;
    v2._x3e648660c668142e = Vector3.new();
    v2._x5d0e1fff719b0fae = 0;
    v2._xd42ab7b5307989b7 = {};
    v2._x5bd85470d65f5b06 = false;
    v2._x44d8177fe64d0a10 = {
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
    v2._xd4d5eb2b03a763a1 = nil;
    v2._x4f4d1d254264eab3 = nil;
    return v2;
end;
function u1._x8ac997f5c09477db(p3) --[[ Line: 72 ]]
    if p3._x5bd85470d65f5b06 then
    else
        p3._x5bd85470d65f5b06 = true;
    end;
end;
function u1._xf75f57a5f7a23070(u4) --[[ Line: 77 ]]
    -- upvalues: l__RunService__1 (copy), l__Classes__8 (copy)
    u4._xd4d5eb2b03a763a1:Play();
    u4._x4f4d1d254264eab3:Play();
    l__RunService__1.Heartbeat:Connect(function(p5) --[[ Line: 81 ]]
        -- upvalues: l__Classes__8 (ref), u4 (copy)
        local function v7() --[[ Line: 91 ]]
            -- upvalues: l__Classes__8 (ref), u4 (ref)
            if l__Classes__8._x7058397dabccd000._x1d287c838240a901.Magnitude <= u4._x44d8177fe64d0a10.AIR_AMBIENT_THRESHOLD then
                return 0;
            end;
            local v6 = math.clamp(l__Classes__8._x7058397dabccd000._x1d287c838240a901.Magnitude, u4._x44d8177fe64d0a10.AIR_AMBIENT_THRESHOLD, u4._x44d8177fe64d0a10.AIR_AMBIENT_UPPER_BOUND);
            return l__Classes__8.Util:convNumRange(v6, u4._x44d8177fe64d0a10.AIR_AMBIENT_THRESHOLD, u4._x44d8177fe64d0a10.AIR_AMBIENT_UPPER_BOUND, u4._x44d8177fe64d0a10.AIR_AMBIENT_FIRST_PLAYBACK, u4._x44d8177fe64d0a10.AIR_AMBIENT_LAST_PLAYBACK);
        end;
        local function v9() --[[ Line: 100 ]]
            -- upvalues: l__Classes__8 (ref), u4 (ref)
            if l__Classes__8._x7058397dabccd000._x1d287c838240a901.Magnitude <= u4._x44d8177fe64d0a10.FREEFALL_THRESHOLD then
                return 0;
            end;
            local v8 = math.clamp(l__Classes__8._x7058397dabccd000._x1d287c838240a901.Magnitude, u4._x44d8177fe64d0a10.FREEFALL_THRESHOLD, u4._x44d8177fe64d0a10.FREEFALL_UPPER_BOUND);
            return l__Classes__8.Util:convNumRange(v8, u4._x44d8177fe64d0a10.FREEFALL_THRESHOLD, u4._x44d8177fe64d0a10.FREEFALL_UPPER_BOUND, 0, u4._x44d8177fe64d0a10.FREEFALL_LAST_VOLUME);
        end;
        local function v11() --[[ Line: 109 ]]
            -- upvalues: l__Classes__8 (ref), u4 (ref)
            if l__Classes__8._x7058397dabccd000._x1d287c838240a901.Magnitude <= u4._x44d8177fe64d0a10.FREEFALL_THRESHOLD then
                return 0;
            end;
            local v10 = math.clamp(l__Classes__8._x7058397dabccd000._x1d287c838240a901.Magnitude, u4._x44d8177fe64d0a10.FREEFALL_THRESHOLD, u4._x44d8177fe64d0a10.FREEFALL_UPPER_BOUND);
            return l__Classes__8.Util:convNumRange(v10, u4._x44d8177fe64d0a10.FREEFALL_THRESHOLD, u4._x44d8177fe64d0a10.FREEFALL_UPPER_BOUND, u4._x44d8177fe64d0a10.FREEFALL_FIRST_PLAYBACK, u4._x44d8177fe64d0a10.FREEFALL_LAST_PLAYBACK);
        end;
        u4._xd4d5eb2b03a763a1.Volume = l__Classes__8.Util:numLerp(u4._xd4d5eb2b03a763a1.Volume, (function() --[[ Name: getAirVolume, Line 82 ]]
            -- upvalues: l__Classes__8 (ref), u4 (ref)
            if l__Classes__8._x7058397dabccd000._x1d287c838240a901.Magnitude <= u4._x44d8177fe64d0a10.AIR_AMBIENT_THRESHOLD then
                return 0;
            end;
            local v12 = math.clamp(l__Classes__8._x7058397dabccd000._x1d287c838240a901.Magnitude, u4._x44d8177fe64d0a10.AIR_AMBIENT_THRESHOLD, u4._x44d8177fe64d0a10.AIR_AMBIENT_UPPER_BOUND);
            return l__Classes__8.Util:convNumRange(v12, u4._x44d8177fe64d0a10.AIR_AMBIENT_THRESHOLD, u4._x44d8177fe64d0a10.AIR_AMBIENT_UPPER_BOUND, 0, u4._x44d8177fe64d0a10.AIR_AMBIENT_LAST_VOLUME);
        end(), 1 * p5);
        u4._xd4d5eb2b03a763a1.PlaybackSpeed = v7();
        u4._x4f4d1d254264eab3.Volume = l__Classes__8.Util:numLerp(u4._x4f4d1d254264eab3.Volume, v9(), 1 * p5);
        u4._x4f4d1d254264eab3.PlaybackSpeed = v11();
    end;
end;
function u1._x58f3b5b31260d7b8(p13, p14, p15, p16, p17) --[[ Line: 126 ]]
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
        p13:_x4fcb91eabec02075(v18, p17);
    end;
    return v18;
end;
function u1._x4fcb91eabec02075(_, u21, _) --[[ Line: 154 ]]
    -- upvalues: l__Promise__5 (copy)
    return u21, l__Promise__5.new(function(u22, _, p23) --[[ Line: 155 ]]
        -- upvalues: u21 (copy)
        u21:Play();
        local u24 = u21.Ended:Once(function() --[[ Line: 157 ]]
            -- upvalues: u22 (copy)
            u22();
        end;
        p23(function() --[[ Line: 160 ]]
            -- upvalues: u21 (ref), u24 (copy)
            u21:Stop();
            u24:Disconnect();
            u21:Destroy();
        end;
    end:andThen(function() --[[ Line: 165 ]]
        -- upvalues: u21 (copy)
        u21:Stop();
        u21:Destroy();
    end;
end;
function u1._x095692db6a6ea871(_, p25, p26, p27) --[[ Line: 172 ]]
    local v28 = Instance.new("PitchShiftSoundEffect");
    v28.Octave = Random.new():NextNumber(p26, p27);
    v28.Parent = p25;
    return v28, p25;
end;
function u1._x743fa0cb5febe8b0(_, p29) --[[ Line: 181 ]]
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
function u1._xd0110c74a0e8e169(p32, p33) --[[ Line: 197 ]]
    -- upvalues: l__Sound__3 (copy)
    local v34 = {};
    for _, v35 in pairs(l__Sound__3:GetDescendants()) do
        if v35:IsA("Sound") then
            if v35.Name == p33 then
                table.insert(v34, v35);
            end;
        elseif v35:IsA("SoundGroup") and v35.Name == p33 then
            local v36 = p32:_x743fa0cb5febe8b0(v35);
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
function u1._x5ce134f6bbd7b7a1(_, p37) --[[ Line: 224 ]]
    while p37 do
        if p37.Name == "SkinAssets" then
            return true;
        end;
        p37 = p37.Parent;
    end;
    return false;
end;
function u1._xabeff94362f19810(_, p38) --[[ Line: 237 ]]
    if p38 then
        p38 = p38:FindFirstAncestorWhichIsA("Folder");
    end;
    if p38 then
        p38 = p38.Name;
    end;
    return p38;
end;
function u1._x184358f443f047b0(p39, p40, p41, p42) --[[ Line: 242 ]]
    -- upvalues: l__SoundService__2 (copy)
    local v43 = p39:_xabeff94362f19810(p41);
    local v44 = p39:_x5ce134f6bbd7b7a1(p42) and not (v43 and l__SoundService__2:FindFirstChild(v43)) and "Combat" or v43;
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
function u1._x1a61834fff12ca7d(_, p46, p47) --[[ Line: 262 ]]
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
function u1._x8f5bb66bc66e9ca3(_, p51, p52) --[[ Line: 295 ]]
    if p52 then
        for v53, v54 in pairs(p52) do
            if v53 ~= "Parent" and (v53 ~= "location" and (v53 ~= "delay_time" and v53 ~= "presence")) then
                p51[v53] = v54;
            end;
        end;
    end;
end;
function u1._x8571f2a97583ca9d(p55, p56, p57) --[[ Line: 310 ]]
    local v58;
    if p57 and p57.presence ~= nil then
        local v59 = tonumber(p57.presence) or 0;
        v58 = math.clamp(v59, 0, 1);
    else
        v58 = 0;
    end;
    p56:SetAttribute("Presence", v58);
    p55._xd42ab7b5307989b7[p56] = {
        presence = v58,
        baseVolume = p56.Volume
    };
    p55:_x8ac997f5c09477db();
end;
function u1._xce17cabc09638607(u60, _, p61, p62, p63, p64) --[[ Line: 324 ]]
    if p61 then
        local u65 = u60:_x1a61834fff12ca7d(p61, p64);
        if u65 then
            u60:_x184358f443f047b0(u65, p62, p61);
            u60:_x8f5bb66bc66e9ca3(u65, p64);
            u60:_x8571f2a97583ca9d(u65, p64);
            if p63 then
                if p64 and p64.delay_time then
                    task.delay(p64.delay_time, function() --[[ Line: 340 ]]
                        -- upvalues: u60 (copy), u65 (copy)
                        local v66, v67 = u60:_x4fcb91eabec02075(u65);
                        return v66, v67;
                    end;
                    return u65;
                else
                    local v68, v69 = u60:_x4fcb91eabec02075(u65);
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
function u1._x29dfdebc4973ba7c(p70, p71, _) --[[ Line: 353 ]]
    local v72 = p70:_xd0110c74a0e8e169(p71);
    if v72 then
        return v72, v72.SoundId;
    else
        return nil;
    end;
end;
function u1._x6187b85bcb2f6e63(p73, p74, p75, p76, p77) --[[ Line: 362 ]]
    if typeof(p75) ~= "Instance" or not p75:IsA("Sound") then
        if typeof(p75) ~= "Instance" or not p75:IsA("SoundGroup") then
            warn("INVALID sound source : ", p75);
            return nil;
        end;
        p75 = p73:_x743fa0cb5febe8b0(p75);
    end;
    return p73:_xce17cabc09638607(p74, p75, p73:_xd0110c74a0e8e169(p74) or p75, p76, p77);
end;
function u1._x7ab8b42cc5920a78(p78, p79, p80, p81) --[[ Line: 377 ]]
    local v82 = p78:_xd0110c74a0e8e169(p79);
    return p78:_xce17cabc09638607(p79, v82, v82, p80, p81);
end;
function u1._x2a07343fdd62d603(p83) --[[ Line: 382 ]]
    -- upvalues: l__Classes__8 (copy), l__Footsteps__4 (copy), l__SoundService__2 (copy)
    local v84;
    if l__Classes__8._x7058397dabccd000._x8500fad561a4bbc9 then
        v84 = l__Classes__8._x7058397dabccd000._xcdcbcb8b1719c75c;
    elseif l__Classes__8._x7058397dabccd000._xab5fa47aca1475aa._x896e5dbcdd177cdb then
        v84 = l__Classes__8._x7058397dabccd000._xab5fa47aca1475aa._x896e5dbcdd177cdb.Material;
    else
        v84 = l__Classes__8._x7058397dabccd000._xcdcbcb8b1719c75c;
    end;
    local v85 = l__Footsteps__4:GetTableFromMaterial(v84);
    if v85 then
        local v86 = l__Footsteps__4:GetRandomSound(v85);
        local v87 = p83._x44d8177fe64d0a10.FOOTSTEP_VOLUME * l__SoundService__2:FindFirstChild("Movement").Volume;
        p83:_x58f3b5b31260d7b8(v86, true, {
            Parent = game:GetService("ReplicatedStorage").Temp,
            Volume = v87
        }, true);
    end;
end;
function u1._xb46cf1736588f7bb(u88) --[[ Line: 401 ]]
    -- upvalues: l__Classes__8 (copy), l__Promise__5 (copy)
    local l__main__10 = l__Classes__8._x64f8d2b27adbc0f7:_xd009baa5e5683b01().main;
    local l__Position__11 = l__Classes__8._x7058397dabccd000._x1cdffaf9f62b92e9.Position;
    u88._x5d0e1fff719b0fae = u88._x5d0e1fff719b0fae + (u88._x3e648660c668142e - l__Position__11).Magnitude;
    u88._x3e648660c668142e = l__Position__11;
    if l__Classes__8._x7058397dabccd000._x8500fad561a4bbc9 and (l__main__10 == "running" and (not u88._x115fabfba3f84804 and u88._x5d0e1fff719b0fae >= u88._x44d8177fe64d0a10.FOOTSTEPS_RUN_DISTANCE)) then
        u88._x5d0e1fff719b0fae = 0;
        u88:_x2a07343fdd62d603();
        u88._xf2a941f225f92366 = true;
        l__Promise__5.delay(u88._x44d8177fe64d0a10.FOOTSTEP_DEBOUNCE):andThen(function() --[[ Line: 414 ]]
            -- upvalues: u88 (copy)
            u88._xf2a941f225f92366 = false;
        end;
    end;
    if l__main__10 == "wallriding" and (u88._x5d0e1fff719b0fae >= u88._x44d8177fe64d0a10.WALLRIDE_FOOTSTEP_DISTANCE and not u88._xf8066c2255c88284) then
        u88._x5d0e1fff719b0fae = 0;
        u88:_x58f3b5b31260d7b8(u88:_x29dfdebc4973ba7c("WALLRIDE_STEPS"), true, {}, true);
        u88._xf8066c2255c88284 = true;
        l__Promise__5.delay(u88._x44d8177fe64d0a10.WALLRIDE_FOOTSTEP_DEBOUNCE):andThen(function() --[[ Line: 427 ]]
            -- upvalues: u88 (copy)
            u88._xf8066c2255c88284 = false;
        end;
    end;
end;
function u1._xebeb797d76ea6227(u89) --[[ Line: 434 ]]
    -- upvalues: l__Classes__8 (copy), l__Promise__5 (copy)
    l__Classes__8._x64f8d2b27adbc0f7._x67783353828f3ace:Connect(function(p90) --[[ Line: 435 ]]
        -- upvalues: u89 (copy), l__Promise__5 (ref)
        if p90.main == "bhop_jump" then
            if u89._x0d708ff9e4f8983c then
                return;
            end;
            u89._x0d708ff9e4f8983c = true;
            l__Promise__5.delay(u89._x44d8177fe64d0a10.BHOP_DEBOUNCE):andThen(function() --[[ Line: 440 ]]
                -- upvalues: u89 (ref)
                u89._x0d708ff9e4f8983c = false;
            end;
            u89:_x2a07343fdd62d603();
            u89:_x7ab8b42cc5920a78("STEP_JUMP", true, {
                Parent = game:GetService("ReplicatedStorage").Temp
            });
        end;
    end;
    l__Classes__8._x7058397dabccd000._xab5fa47aca1475aa._x6f4a6e946bee20b4.Event:Connect(function() --[[ Line: 449 ]]
        -- upvalues: l__Classes__8 (ref), u89 (copy)
        if l__Classes__8._x7058397dabccd000._x77aafe36a385b603._xa822f9aecc59b964 then
            u89:_x7ab8b42cc5920a78("STEP_JUMP", true);
        end;
    end;
    l__Classes__8._x7058397dabccd000._x9c56651309f88046.Event:Connect(function() --[[ Line: 455 ]]
        -- upvalues: l__Classes__8 (ref), u89 (copy)
        local v91 = math.clamp(l__Classes__8._x7058397dabccd000._x1563e05b8846fc42, u89._x44d8177fe64d0a10.LANDING_UPPER_BOUND, u89._x44d8177fe64d0a10.LANDING_THRESHOLD);
        if l__Classes__8._x7058397dabccd000._x1563e05b8846fc42 < u89._x44d8177fe64d0a10.LANDING_THRESHOLD then
            u89:_x7ab8b42cc5920a78("FALL_LANDING", true, {
                Volume = l__Classes__8.Util:convNumRange(v91, u89._x44d8177fe64d0a10.LANDING_UPPER_BOUND, u89._x44d8177fe64d0a10.LANDING_THRESHOLD, u89._x44d8177fe64d0a10.LANDING_LAST_VOLUME, 0)
            });
        end;
    end;
end;
function u1._xd3abbebe90fab9ca(p92, p93, p94) --[[ Line: 465 ]]
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
        local l__source__15 = v95.source;
        if typeof(l__source__15) == "Instance" then
            if l__source__15:IsA("Sound") or l__source__15:IsA("SoundGroup") then
                return p92:_x6187b85bcb2f6e63(p93, l__source__15, true, v96);
            end;
            warn("INVALID skin_sound SOURCE : ", l__source__15);
        end;
        if typeof(l__item_type__12) == "string" and (typeof(l__item_id__13) == "string" and (typeof(l__sound_key__14) == "string" and l__Classes__8._xd1706540247308ea)) then
            local v97 = l__Classes__8._xd1706540247308ea:_x372c01be8a28bc70(l__item_type__12);
            if v97 and v97._x850fb72bedc0eacc == l__item_id__13 then
                return l__Classes__8._x51bf23f1b9ed859b:_xc782ad79ba49be57(v97._x7b47345bff92786e, p92, l__sound_key__14, true, v96, p93);
            else
                return p92:_x7ab8b42cc5920a78(p93, true, v96);
            end;
        else
            return p92:_x7ab8b42cc5920a78(p93, true, v96);
        end;
    else
        return p92:_x7ab8b42cc5920a78(p93, true, p94);
    end;
end;
function u1._xe53615d96cf36a6b(u98) --[[ Line: 510 ]]
    -- upvalues: l__Packets__6 (copy), l__Context__9 (copy), l__RunService__1 (copy)
    l__Packets__6._xd41219a82fb9b0a8.OnClientEvent:Connect(function(p99, p100) --[[ Line: 511 ]]
        -- upvalues: u98 (copy)
        u98:_xd3abbebe90fab9ca(p99, p100);
    end;
    if l__Context__9.is_gameplay_mode then
        u98._xd4d5eb2b03a763a1 = u98:_x7ab8b42cc5920a78("AIR_AMBIENT", false, {
            Parent = game:GetService("ReplicatedStorage").Temp
        });
        u98._x4f4d1d254264eab3 = u98:_x7ab8b42cc5920a78("FREEFALL", false, {
            Parent = game:GetService("ReplicatedStorage").Temp
        });
        task.defer(function() --[[ Line: 522 ]]
            -- upvalues: u98 (copy), l__RunService__1 (ref)
            u98:_xebeb797d76ea6227();
            u98:_xf75f57a5f7a23070();
            l__RunService__1.Heartbeat:Connect(function() --[[ Line: 526 ]]
                -- upvalues: u98 (ref)
                u98:_xb46cf1736588f7bb();
            end;
        end;
    end;
end;
return u1;
