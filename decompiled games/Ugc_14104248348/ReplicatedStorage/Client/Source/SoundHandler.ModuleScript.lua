-- Decompiled from: ReplicatedStorage.Client.Source.SoundHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__TweenService__3 = game:GetService("TweenService");
local l__SoundService__4 = game:GetService("SoundService");
require(l__ReplicatedStorage__1.Modules.PropertyService);
local l__Signal__5 = require(l__ReplicatedStorage__1.Modules.Signal);
local l__Mince__6 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__6:Get("Settings");
local u2 = {
    DefaultSoundGroup = "SFX",
    StopWhenFadingOver = false,
    ActiveEffect = nil,
    SoundLoaded = false,
    Tween = {
        EffectTween = TweenInfo.new(0.5, Enum.EasingStyle.Sine),
        FadeInTweeen = TweenInfo.new(0.5, Enum.EasingStyle.Linear),
        FadeOutTween = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
    },
    RandomClass = Random.new(os.clock()),
    TotalSoundList = {},
    Tracks = {},
    Sounds = {},
    SoundColletions = {},
    Effects = {},
    EffectGroups = {},
    ActiveSounds = {
        SoundParts = {}
    },
    ActiveTrack = {},
    SoundGroups = {},
    EffectCache = {
        Lookup = {}
    },
    UponSoundLoaded = l__Signal__5.new()
};
function u2.SoundNameFor(p3) --[[ Line: 55 ]]
    -- upvalues: u2 (copy)
    if u2.Sounds[p3] then
        return ("Sound.%s"):format(p3);
    end;
    warn(("There is no sound by the name of \'%s\'"):format(p3));
end;
function u2.CreateWorldSound(p4, p5) --[[ Line: 64 ]]
    -- upvalues: u2 (copy)
    local v6 = u2.Sounds[p4];
    if v6 then
        local u7 = Instance.new("Sound");
        if v6.IgnoreEffects then
            u7.SoundGroup = v6.SoundGroup;
        else
            u7.SoundGroup = v6.EffectSoundGroup;
        end;
        u7.PlayOnRemove = true;
        u7.Looped = false;
        u7.Name = u2.SoundNameFor(p4);
        u7.Parent = u2.SoundFolder;
        if p5 then
            u7.PlayOnRemove = false;
            v6.DontUseHack = true;
        end;
        u2.ActiveSounds[u7] = v6;
        u7.Destroying:Connect(function() --[[ Line: 91 ]]
            -- upvalues: u2 (ref), u7 (copy)
            u2.ActiveSounds[u7] = nil;
        end);
        return u7;
    end;
    warn(("There is no sound by the name of \'%s\'"):format(p4));
end;
function u2.PlaySound(p8, p9) --[[ Line: 98 ]]
    -- upvalues: u2 (copy)
    local v10 = u2.Sounds[p8];
    if v10 then
        v10:GetPosition();
        local v11 = v10[v10.Position];
        local u12 = v10.SoundInstances[v11];
        if not u12 then
            v10.SoundInstances[v11] = {};
            u12 = v10.SoundInstances[v11];
        end;
        for _, v13 in u12 do
            if not (v13.IsPlaying or v13.Looped) then
                v13.Volume = v10.Volume;
                v13.SoundId = v11;
                if v10.Pos then
                    v13.TimePosition = v10.Pos;
                end;
                if p9 then
                    p9(v13);
                end;
                v13:Play();
                return v13;
            end;
        end;
        local u14 = Instance.new("Sound");
        if v10.IgnoreEffects then
            u14.SoundGroup = v10.SoundGroup;
        else
            u14.SoundGroup = v10.EffectSoundGroup;
        end;
        if v10.Pos then
            u14.TimePosition = v10.Pos;
        end;
        u14.Volume = v10.Volume;
        u14.Looped = false;
        u14.SoundId = v11;
        u14.Name = u2.SoundNameFor(p8);
        u14.Parent = u2.SoundFolder;
        if p9 then
            p9(u14);
        end;
        u14:Play();
        u14.Destroying:Connect(function() --[[ Line: 173 ]]
            -- upvalues: u12 (ref), u14 (copy)
            local v15 = table.find(u12, u14);
            if v15 then
                table.remove(u12, v15);
            end;
        end);
        table.insert(u12, u14);
        return u14;
    end;
    local v16 = u2.ActiveSounds[p8];
    if v16 then
        v16:GetPosition();
        p8.SoundId = v16[v16.Position];
        if v16.DontUseHack then
            p8:Play();
            return p8;
        end;
        local l__Parent__7 = p8.Parent;
        p8.Parent = nil;
        p8.Parent = l__Parent__7;
        return p8;
    end;
    warn(("There is no sound by the name of \'%s\'"):format(p8));
end;
function u2.GetSoundCollection(p17) --[[ Line: 183 ]]
    -- upvalues: u2 (copy)
    local v18 = u2.SoundColletions[p17];
    if v18 then
        return v18;
    end;
    warn(("There is no soundcollection by the name of \'%s\'."):format(p17));
end;
function u2.PlaySoundAt(p19, p20, p21, p22) --[[ Line: 193 ]]
    -- upvalues: u2 (copy)
    local v23 = u2.Sounds[p19];
    if v23 then
        v23:GetPosition();
        local v24 = v23[v23.Position];
        local v25 = Instance.new("Sound");
        if v23.IgnoreEffects then
            v25.SoundGroup = v23.SoundGroup;
        else
            v25.SoundGroup = v23.EffectSoundGroup;
        end;
        v25.Volume = v23.Volume;
        v25.Looped = false;
        v25.SoundId = v24;
        v25.Name = u2.SoundNameFor(p19);
        v25.Parent = p20;
        v25:Play();
        if p22 then
            v23.Looped = p22;
        end;
        if p21 then
            local v26 = typeof(p21) == "number" and { 0, p21 } or p21;
            v23.RollOffMode = Enum.RollOffMode.Linear;
            v23.RollOffMinDistance = v26[1];
            v23.RollOffMaxDistance = v26[2];
        end;
        return v23;
    end;
    warn(("There is no sound by the name of \'%s\'"):format(p19));
end;
function u2.GetSound(p27, _) --[[ Line: 231 ]]
    -- upvalues: u2 (copy)
    local v28 = u2.Sounds[p27];
    if v28 then
        v28:GetPosition();
        local v29 = v28[v28.Position];
        local u30 = v28.SoundInstances[v29];
        if not u30 then
            v28.SoundInstances[v29] = {};
            u30 = v28.SoundInstances[v29];
        end;
        for _, v31 in u30 do
            if not (v31.IsPlaying or v31.Looped) then
                v31.Volume = v28.Volume;
                v31.SoundId = v29;
                return v31;
            end;
        end;
        local u32 = Instance.new("Sound");
        if v28.IgnoreEffects then
            u32.SoundGroup = v28.SoundGroup;
        else
            u32.SoundGroup = v28.EffectSoundGroup;
        end;
        local u33 = {};
        u32.Volume = v28.Volume;
        u32.Looped = false;
        u32.SoundId = v29;
        u32.Name = u2.SoundNameFor(p27);
        u32.Parent = u2.SoundFolder;
        u33.ParentChange = u32:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 274 ]]
            -- upvalues: u32 (copy), u33 (copy)
            if u32.Parent == nil then
                for _, v34 in u33 do
                    v34:Disconnect();
                end;
            end;
        end);
        u33.Destroy = u32.Destroying:Connect(function() --[[ Line: 280 ]]
            -- upvalues: u33 (copy), u30 (ref), u32 (copy)
            for _, v35 in u33 do
                v35:Disconnect();
            end;
            local v36 = table.find(u30, u32);
            if v36 then
                table.remove(u30, v36);
            end;
        end);
        table.insert(u30, u32);
        return u32;
    end;
    warn(("There is no sound by the name of \'%s\'"):format(p27));
end;
local u69 = {
    PushToGroup = function(p37, p38, p39) --[[ Name: PushToGroup, Line 296 ]]
        p37.Groups[p38] = p37.Groups[p38] or {};
        table.insert(p37.Groups[p38], p39);
    end,
    Play = function(u40, p41, p42, _) --[[ Name: Play, Line 303 ]]
        -- upvalues: u2 (copy)
        if p41 then
            local v43 = u2.GetSound(p41);
            if v43 then
                v43.RollOffMinDistance = u40.RollOff[1];
                v43.RollOffMaxDistance = u40.RollOff[2];
                v43:Play();
                table.insert(u40.Sounds, v43);
                v43.Ended:Connect(function() --[[ Line: 312 ]]
                    -- upvalues: u40 (copy)
                    u40:CheckForEndings();
                end);
                if p42 then
                    v43.Parent = p42;
                end;
                u40:PushToGroup(p41, v43);
                return v43;
            end;
        end;
    end,
    Stop = function(p44, p45) --[[ Name: Stop, Line 320 ]]
        if p45 then
            local v46 = p44.Groups[p45];
            if v46 then
                for _, v47 in v46 do
                    v47:Stop();
                end;
            end;
        end;
    end,
    FadeOut = function(p48, p49, p50) --[[ Name: FadeOut, Line 327 ]]
        -- upvalues: l__TweenService__3 (copy)
        local v51 = p50 or 0.5;
        if p49 then
            local v52 = p48.Groups[p49];
            if v52 then
                local v53 = TweenInfo.new(v51, Enum.EasingStyle.Sine);
                for _, u54 in v52 do
                    local v55 = l__TweenService__3:Create(u54, v53, {
                        Volume = 0
                    });
                    v55.Completed:Connect(function() --[[ Line: 335 ]]
                        -- upvalues: u54 (copy)
                        u54:Stop();
                    end);
                    v55:Play();
                end;
            end;
        end;
    end,
    Loop = function(p56, p57, p58) --[[ Name: Loop, Line 340 ]]
        -- upvalues: u2 (copy)
        if p57 then
            local v59 = u2.GetSound(p57);
            if v59 then
                v59.RollOffMinDistance = p56.RollOff[1];
                v59.RollOffMaxDistance = p56.RollOff[2];
                v59.Looped = true;
                v59:Play();
                table.insert(p56.Sounds, v59);
                v59.Ended:Connect(p56.CheckForEndings);
                if p58 then
                    v59.Parent = p58;
                end;
                p56:PushToGroup(p57, v59);
                return p57;
            end;
        end;
    end,
    StopAll = function(p60) --[[ Name: StopAll, Line 357 ]]
        for _, v61 in p60.Sounds do
            v61:Stop();
        end;
        p60:CheckForEndings(true);
    end,
    CheckForEndings = function(p62, p63) --[[ Name: CheckForEndings, Line 362 ]]
        if not p63 then
            task.wait(p62.WaitExpireTime);
        end;
        if not p62.DestroyingEnabled then
            return;
        end;
        if not (p62.AutoExpire or p63) then
            return;
        end;
        local v64 = true;
        for _, v65 in p62.Sounds do
            if v65.IsPlaying then
                v64 = false;
                break;
            end;
        end;
        if v64 or p63 then
            for _, v66 in p62.Sounds do
                v66:Destroy();
            end;
        end;
    end,
    Destroy = function(p67) --[[ Name: Destroy, Line 376 ]]
        for _, v68 in p67.Sounds do
            v68:Destroy();
        end;
    end
};
function u2.controller(p70) --[[ Line: 382 ]]
    -- upvalues: u69 (copy)
    return setmetatable({
        AutoExpire = true,
        WaitExpireTime = 0.5,
        Sounds = {},
        Groups = {},
        RollOff = { 10, 200 },
        DestroyingEnabled = p70 == nil and true or p70
    }, {
        __index = u69
    });
end;
function u2.__DetermineSoundPosition(p71) --[[ Line: 399 ]]
    -- upvalues: u2 (copy)
    if p71.Shuffle then
        p71.LastPosition = p71.Position;
        if p71.TotalSounds <= 1 then
            p71.Position = u2.RandomClass:NextInteger(1, p71.TotalSounds);
            return;
        end;
        repeat
            p71.Position = u2.RandomClass:NextInteger(1, p71.TotalSounds);
        until p71.Position ~= p71.LastPosition;
    else
        if p71.Random then
            p71.Position = u2.RandomClass:NextInteger(1, p71.TotalSounds);
            return;
        end;
        p71.Position = p71.Position + 1;
        if p71.Position > p71.TotalSounds then
            p71.Position = 1;
        end;
    end;
end;
function u2.GetTrack(p72) --[[ Line: 424 ]]
    -- upvalues: u2 (copy)
    local v73 = u2.Tracks[p72];
    if v73 then
        return v73;
    end;
    warn(("There is no track by the name of \'%s\'"):format(p72));
end;
function u2.PlayTrack(p74, p75) --[[ Line: 434 ]]
    -- upvalues: u2 (copy)
    local v76 = u2.Tracks[p74];
    if v76 then
        if v76.IgnoreStack then
            if v76.Paused then
                v76:PlayNextSound();
            end;
        else
            local v77 = u2.ActiveTrack[v76.Stack];
            if v76.Overplay or v77 ~= v76 then
                if v77 and (v77 ~= v76 and not v77.Paused) then
                    v77:Stop(p75);
                end;
                if v76.Paused then
                    if p75 and v77 then
                        v76:PlayNextSound(v77.SoundInstance.TimePosition);
                    else
                        v76:PlayNextSound();
                    end;
                end;
                u2.ActiveTrack[v76.Stack] = v76;
            end;
        end;
    else
        warn(("There is no track by the name of \'%s\'"):format(p74));
    end;
end;
function u2.StopTrack(p78) --[[ Line: 472 ]]
    -- upvalues: u2 (copy)
    local v79 = u2.Tracks[p78];
    if v79 then
        if v79.IgnoreStack then
            if not v79.Paused then
                v79:Stop();
            end;
        else
            if not v79.Paused then
                if u2.ActiveTrack[v79.Stack] == v79 then
                    u2.ActiveTrack[v79.Stack] = nil;
                end;
                v79:Stop();
            end;
        end;
    else
        warn(("There is no track by the name of \'%s\'"):format(p78));
    end;
end;
function u2.StopAllTracks() --[[ Line: 498 ]]
    -- upvalues: u2 (copy)
    for v80, _ in u2.Tracks do
        u2.StopTrack(v80);
    end;
end;
function u2.SwitchEffect(p81) --[[ Line: 504 ]]
    -- upvalues: u2 (copy), l__SoundService__4 (copy)
    local v82 = u2.Effects[p81];
    if v82 then
        if v82 == u2.ActiveEffect then
        else
            l__SoundService__4.AmbientReverb = v82.AmbientReverb or Enum.ReverbType.NoReverb;
            u2.ActiveEffect = v82;
            u2.__ApplyActiveEffectsToGroups();
        end;
    else
        warn(("There is no effect by the name of \'%s\'"):format(p81));
    end;
end;
function u2.RemoveEffects() --[[ Line: 520 ]]
    -- upvalues: l__SoundService__4 (copy), u2 (copy)
    l__SoundService__4.AmbientReverb = Enum.ReverbType.NoReverb;
    u2.ActiveEffect = nil;
    u2.__ApplyActiveEffectsToGroups();
end;
function u2.StopTrackSound(p83, p84) --[[ Line: 531 ]]
    -- upvalues: l__TweenService__3 (copy), u2 (copy)
    local l__SoundInstance__8 = p83.SoundInstance;
    p83.Position = p83.Position - 1;
    if p83.FadeOut then
        if p83.LastActiveTween then
            p83.LastActiveTween:Pause();
            p83.LastActiveTween = nil;
        end;
        local v85 = l__TweenService__3:Create(l__SoundInstance__8, u2.Tween.FadeOutTween, {
            Volume = 0,
            Playing = false
        });
        v85:Play();
        p83.LastActiveTween = v85;
        if p84 or not u2.StopWhenFadingOver then
            p83.Paused = true;
        else
            v85.Completed:Wait();
            p83.Paused = true;
        end;
    else
        l__SoundInstance__8.Volume = 0;
        l__SoundInstance__8:Pause();
        p83.Paused = true;
    end;
    if p83.ResetOnStop then
        l__SoundInstance__8.TimePosition = 0;
    end;
end;
function u2.PlayNextTrackSound(p86, p87) --[[ Line: 568 ]]
    -- upvalues: u2 (copy), l__TweenService__3 (copy)
    local l__SoundInstance__9 = p86.SoundInstance;
    p86.Position = math.max(p86.Position, 0);
    p86.Position = p86.Position + 1;
    if p86.Position > p86.TotalSounds then
        p86.Position = 1;
    end;
    if p86.Random then
        p86.Position = u2.RandomClass:NextInteger(1, p86.TotalSounds);
    end;
    p86.Paused = false;
    if p86.LastActiveTween then
        p86.LastActiveTween:Pause();
        p86.LastActiveTween = nil;
    end;
    l__SoundInstance__9.SoundId = p86[p86.Position];
    l__SoundInstance__9:Resume();
    l__SoundInstance__9.Volume = 0;
    if p87 then
        l__SoundInstance__9.Volume = p86.Volume;
        l__SoundInstance__9.TimePosition = p87;
    end;
    if p86.FadeIn and not p87 then
        local v88 = l__TweenService__3:Create(l__SoundInstance__9, u2.Tween.FadeInTweeen, {
            Volume = p86.Volume
        });
        p86.LastActiveTween = v88;
        v88:Play();
    else
        warn("set immedtet");
        l__SoundInstance__9.Volume = p86.Volume;
    end;
end;
function u2.__ApplyActiveEffectsToGroups() --[[ Line: 616 ]]
    -- upvalues: u2 (copy)
    for _, v89 in u2.EffectGroups do
        u2.__ApplyActiveEffects(v89);
    end;
end;
function u2.__GetEffect(p90, p91) --[[ Line: 623 ]]
    -- upvalues: u2 (copy)
    local v92 = u2.EffectCache[p90];
    if not v92 then
        v92 = {};
        u2.EffectCache[p90] = v92;
    end;
    for _, v93 in ipairs(v92) do
        if not v93.InUse then
            v93.InUse = true;
            return v93.EffectInstance;
        end;
    end;
    local v94 = {
        InUse = true,
        EffectInstance = Instance.new(p90),
        Effect = p91
    };
    for v95, v96 in p91.DisabledProperties do
        v94.EffectInstance[v95] = v96;
    end;
    v94.EffectInstance.Parent = script.Effects;
    u2.EffectCache.Lookup[v94.EffectInstance] = v94;
    table.insert(v92, v94);
    return v94.EffectInstance;
end;
function u2.__FreeEffect(u97) --[[ Line: 655 ]]
    -- upvalues: u2 (copy), l__TweenService__3 (copy)
    local u98 = u2.EffectCache.Lookup[u97];
    local v99 = l__TweenService__3:Create(u97, u2.Tween.EffectTween, u98.Effect.DisabledProperties);
    v99:Play();
    v99.Completed:Connect(function() --[[ Line: 659 ]]
        -- upvalues: u97 (copy), u98 (copy)
        u97.Parent = script.Effects;
        u98.InUse = false;
    end);
end;
function u2.__ApplyActiveEffects(p100) --[[ Line: 665 ]]
    -- upvalues: u2 (copy), l__TweenService__3 (copy)
    local v101 = {};
    if u2.ActiveEffect then
        for _, v102 in ipairs(u2.ActiveEffect) do
            local v103 = u2.__GetEffect(v102.Class, v102);
            for v104, v105 in v102.DisabledProperties do
                v103[v104] = v105;
            end;
            l__TweenService__3:Create(v103, u2.Tween.EffectTween, v102.Properties):Play();
            v103.Parent = p100;
            v101[v103] = true;
        end;
    end;
    for _, v106 in p100:GetChildren() do
        if not v101[v106] then
            u2.__FreeEffect(v106);
        end;
    end;
end;
function u2.ModifySoundVolumeOf(p107, p108) --[[ Line: 703 ]]
    -- upvalues: u2 (copy)
    local v109 = u2.SoundGroups[p107];
    if not v109 then
        return warn((`There is no sound group by the name of '{p107}'.`));
    end;
    v109.SoundGroup.Volume = v109.BaseVolume * p108;
end;
function u2.GetSoundGroup(p110) --[[ Line: 713 ]]
    -- upvalues: u2 (copy)
    local v111 = u2.SoundGroups[p110];
    if v111 then
        if not v111.SoundGroup:FindFirstChild("Effect") then
            local v112 = Instance.new("SoundGroup");
            v112.Name = "Effect";
            v112.Parent = v111.SoundGroup;
            table.insert(u2.EffectGroups, v112);
        end;
        return v111.SoundGroup;
    end;
end;
function u2.ConstructSounds() --[[ Line: 730 ]]
    -- upvalues: l__Mince__6 (copy), u2 (copy), l__CollectionService__2 (copy)
    local l__Sounds__10 = l__Mince__6.Config.Sounds;
    u2.Effects = l__Sounds__10.Effects;
    for _, v113 in l__Sounds__10.Effects do
        for _, v114 in ipairs(v113) do
            v114.DisabledProperties = {};
        end;
    end;
    for v115, v116 in l__Sounds__10.SoundGroups do
        u2.SoundGroups[v115] = {
            SoundGroup = v116,
            BaseVolume = v116.Volume or 0.5
        };
    end;
    for v117, v118 in l__Sounds__10.Tracks do
        local v119 = u2.GetSoundGroup(v117);
        if v119 then
            local l__Effect__11 = v119.Effect;
            for v120, u121 in v118 do
                local v122 = #u121;
                local v123 = Instance.new("Sound");
                if u121.IgnoreEffects then
                    v123.SoundGroup = v119;
                else
                    v123.SoundGroup = l__Effect__11;
                end;
                v123.Volume = u121.Volume or 0.5;
                v123.Parent = u2.SoundFolder;
                v123.Name = ("Track.%s.%s"):format(v117, v120);
                u121.PlayNextSound = u2.PlayNextTrackSound;
                u121.Stop = u2.StopTrackSound;
                u121.FadeIn = u121.FadeIn or true;
                u121.FadeOut = u121.FadeOut or true;
                u121.Volume = u121.Volume or 0.5;
                u121.TrackName = v120;
                u121.Stack = u121.Stack or "Default";
                u121.Paused = true;
                u121.Position = 0;
                u121.TotalSounds = v122;
                u121.SoundInstance = v123;
                u121.SoundGroup = v119;
                u121.EffectSoundGroup = l__Effect__11;
                u121.Overplay = v118.Overplay or false;
                v123.Ended:Connect(function() --[[ Line: 839 ]]
                    -- upvalues: u121 (copy)
                    u121:PlayNextSound();
                end);
                u2.Tracks[v120] = u121;
            end;
        else
            warn(("Cannot register a TrackGroup because there is no group by the name of \'%s\'."):format(v117));
        end;
    end;
    for v124, v125 in l__Sounds__10.Sounds do
        local u126 = u2.GetSoundGroup(v124);
        if u126 then
            local l__Effect__12 = u126.Effect;
            for v127, v128 in v125 do
                if v128.Collection then
                    local function u135(p129, p130) --[[ Line: 879 ]]
                        -- upvalues: u126 (copy), u2 (ref), l__Effect__12 (copy), u135 (ref)
                        for v131, v132 in p129 do
                            if type(v132) == "table" then
                                if v132.Sound or v132[1] then
                                    local v133 = p130 .. "." .. v131;
                                    local v134 = #v132;
                                    v132.SoundInstances = {};
                                    v132.SoundGroup = u126;
                                    v132.GetPosition = u2.__DetermineSoundPosition;
                                    v132.Volume = v132.Volume or 0.5;
                                    v132.Position = 0;
                                    v132.SoundName = v133;
                                    v132.TotalSounds = v134;
                                    v132.EffectSoundGroup = l__Effect__12;
                                    v132.SoundGroup = u126;
                                    u2.Sounds[v133] = v132;
                                else
                                    u135(v132, p130 .. "." .. v131);
                                end;
                            end;
                        end;
                    end;
                    u135(v128, v127);
                    u2.SoundColletions[v127] = v128;
                else
                    local v136 = #v128;
                    v128.SoundInstances = {};
                    v128.SoundGroup = u126;
                    v128.GetPosition = u2.__DetermineSoundPosition;
                    v128.Volume = v128.Volume or 0.5;
                    v128.Position = 0;
                    v128.SoundName = v127;
                    v128.TotalSounds = v136;
                    v128.EffectSoundGroup = l__Effect__12;
                    v128.SoundGroup = u126;
                    u2.Sounds[v127] = v128;
                end;
            end;
        else
            warn(("Cannot register a TrackGroup because there is no group by the name of \'%s\'."):format(v124));
        end;
    end;
    for _, v137 in l__CollectionService__2:GetTagged("SoundAssigner") do
        local v138 = v137:GetAttributes();
        local v139 = u2.GetSoundGroup(v138.Type);
        if v139 then
            local l__Effect__13 = v139.Effect;
            if v138.ApplyEffects then
                v137.SoundGroup = l__Effect__13;
            else
                v137.SoundGroup = v139;
            end;
        end;
    end;
    l__CollectionService__2:GetInstanceAddedSignal("SoundAssigner"):Connect(function(p140) --[[ Line: 927 ]]
        -- upvalues: u2 (ref)
        local v141 = p140:GetAttributes();
        local v142 = u2.GetSoundGroup(v141.Type);
        if v142 then
            local l__Effect__14 = v142.Effect;
            if v141.ApplyEffects then
                p140.SoundGroup = l__Effect__14;
                return;
            end;
            p140.SoundGroup = v142;
        end;
    end);
end;
function u2.__SetupInstances() --[[ Line: 932 ]]
    -- upvalues: u2 (copy)
    local v143 = Instance.new("Folder", game.Workspace);
    v143.Name = "__SoundInstances";
    u2.SoundFolder = v143;
end;
function u2.WaitUntilSoundLoaded() --[[ Line: 939 ]]
    -- upvalues: u2 (copy)
    if not u2.SoundLoaded then
        u2.UponSoundLoaded:Wait();
    end;
end;
function u2.Setup() --[[ Line: 945 ]]
    -- upvalues: u2 (copy), u1 (copy)
    u2.__SetupInstances();
    u2.ConstructSounds();
    u2.SoundLoaded = true;
    u2.UponSoundLoaded:Fire();
    local v144 = 0;
    local v145 = 0;
    local v146 = "==============================\n";
    for _, v147 in u2.Sounds do
        for _, v148 in ipairs(v147) do
            v144 = v144 + 1;
            v145 = v145 + 1;
            v146 = v146 .. `{v148:gsub("rbxassetid://", "")} , `;
            if v145 > 49 then
                v146 = v146 .. "\n===========================\n";
                v145 = 0;
            end;
            if v144 > 5 then
                v146 = v146 .. "\n";
                v144 = 0;
            end;
        end;
    end;
    local _ = v146 .. "\n\n==============================";
    u1.SettingChanged("SFXVol"):Connect(function(p149) --[[ Line: 974 ]]
        -- upvalues: u2 (ref)
        u2.ModifySoundVolumeOf("SFX", p149);
    end);
    u1.SettingChanged("MusicVol"):Connect(function(p150) --[[ Line: 977 ]]
        -- upvalues: u2 (ref)
        u2.ModifySoundVolumeOf("Music", p150);
    end);
    game.Workspace.DescendantAdded:Connect(function(p151) --[[ Line: 981 ]]
        -- upvalues: u2 (ref)
        if p151:IsA("Sound") then
            if p151.Parent ~= u2.SoundFolder and p151.SoundGroup == nil then
                p151.SoundGroup = u2.GetSoundGroup(u2.DefaultSoundGroup);
            end;
        end;
    end);
end;
return u2;
