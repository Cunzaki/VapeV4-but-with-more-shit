-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.Voicelines
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Signal__4 = require(l__ReplicatedStorage__1.Modules.Signal);
require(l__ReplicatedStorage__1.Modules.microid);
local l__SRTParser__5 = require(l__ReplicatedStorage__1.Modules.SRTParser);
local u1 = l__Mince__3:Get("InterfaceHandler");
local u2 = l__Mince__3:GetEvent("PlayClientVoiceline");
local u3 = {
    FadeOut = true,
    CachedParsedSRTSections = {},
    CachedVoicelines = {},
    ActiveUISections = {},
    FadeOutTween = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0.2)
};
function u3.SectionStarted(p4, p5) --[[ Line: 25 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u3 (copy)
    local v6 = {};
    for _, v7 in p5.Subtitles do
        local v8 = l__ReplicatedStorage__1.Assets.Interface.Subtitle:Clone();
        v8.TextLabel.Text = v7;
        v8.LayoutOrder = p5.SectionNumber;
        v8.Parent = u3.Interface.Voiceline;
        local l__TextBounds__6 = v8.TextLabel.TextBounds;
        v8.Fill.Size = UDim2.fromScale((l__TextBounds__6.X + l__TextBounds__6.Y * 0.5) / v8.TextLabel.AbsoluteSize.X, 1);
        table.insert(v6, v8);
    end;
    p4.UISections[p5.SectionNumber] = { v6, p5 };
    u3.ActiveUISections[v6] = v6;
end;
function u3.SectionStopped(p9, p10) --[[ Line: 47 ]]
    -- upvalues: u3 (copy), l__TweenService__2 (copy)
    if p9.UISections[p10.SectionNumber] then
        if u3.FadeOut then
            local v11 = p9.UISections[p10.SectionNumber][1];
            u3.ActiveUISections[v11] = nil;
            for _, u12 in v11 do
                local v13 = l__TweenService__2:Create(u12, u3.FadeOutTween, {
                    GroupTransparency = 1
                });
                v13.Completed:Connect(function() --[[ Line: 56 ]]
                    -- upvalues: u12 (copy)
                    u12:Destroy();
                end);
                v13:Play();
            end;
        else
            local v14 = p9.UISections[p10.SectionNumber][1];
            u3.ActiveUISections[v14] = nil;
            for _, v15 in v14 do
                v15:Destroy();
            end;
        end;
        p9.UISections[p10.SectionNumber] = nil;
    end;
end;
function u3.GetVoicelineSettings(u16) --[[ Line: 73 ]]
    -- upvalues: u3 (copy), l__Mince__3 (copy), l__SRTParser__5 (copy), l__Signal__4 (copy)
    local v17 = u3.CachedVoicelines[u16];
    if v17 then
        return v17;
    end;
    local v18 = l__Mince__3.Config.Voicelines[u16];
    local v19 = `Could not find the config for the '{u16}'!`;
    assert(v18, v19);
    assert(v18.SoundID, "Missing SoundID");
    assert(v18.SRTData, "Missing SRTData");
    local v20 = u3.CachedParsedSRTSections[u16] or l__SRTParser__5:Parse(v18.SRTData);
    u3.CachedParsedSRTSections[u16] = v20;
    local u21 = script.Sound:Clone();
    u21.SoundId = v18.SoundID;
    u21.Parent = script;
    u21.Volume = v18.Volume or 2;
    repeat
        task.wait();
    until u21.Loaded;
    local u22 = l__SRTParser__5:SyncSubtitleSoundInstanceEvents(v20, u21);
    u22.UISections = {};
    local u23 = {
        Sound = u21,
        Tracker = u22,
        Volume = u21.Volume,
        Played = l__Signal__4.new(),
        Stopped = l__Signal__4.new()
    };
    u22.Started:Connect(function(p24) --[[ Line: 108 ]]
        -- upvalues: u3 (ref), u22 (copy)
        u3.SectionStarted(u22, p24);
    end);
    u22.Stopped:Connect(function(p25) --[[ Line: 111 ]]
        -- upvalues: u3 (ref), u22 (copy)
        u3.SectionStopped(u22, p25);
    end);
    u21.Ended:Connect(function() --[[ Line: 115 ]]
        -- upvalues: u23 (copy), u3 (ref), u21 (copy)
        u23.Stopped:Fire();
        u3.ClearUI();
        u21.Parent = script;
    end);
    function u23.Play(_, p26) --[[ Line: 122 ]]
        -- upvalues: u3 (ref), u16 (copy)
        u3.PlayLine(u16, p26);
    end;
    function u23.Stop() --[[ Line: 126 ]]
        -- upvalues: u3 (ref), u16 (copy)
        u3.StopLine(u16);
    end;
    u21.Destroying:Once(function() --[[ Line: 131 ]]
        -- upvalues: u3 (ref), u16 (copy), u23 (copy)
        u3.CachedVoicelines[u16] = nil;
        for v27, v28 in u3.GetVoicelineSettings(u16) do
            u23[v27] = v28;
        end;
    end);
    u3.CachedVoicelines[u16] = u23;
    return u23;
end;
function u3.PlayLine(p29, p30) --[[ Line: 144 ]]
    -- upvalues: u3 (copy)
    local v31 = u3.CachedVoicelines[p29] or u3.GetVoicelineSettings(p29);
    v31.Sound.Volume = v31.Volume;
    v31.Sound.Parent = p30 or script;
    v31.Sound:Stop();
    v31.Sound.TimePosition = 0;
    v31.Sound:Play();
    v31.Played:Fire();
    return v31;
end;
function u3.StopLine(p32) --[[ Line: 161 ]]
    -- upvalues: u3 (copy)
    local v33 = u3.CachedVoicelines[p32];
    if v33 then
        for _, v34 in v33.Tracker.UISections do
            local _, v35 = table.unpack(v34);
            u3.SectionStopped(v33.Tracker, v35);
        end;
        v33.Sound:Stop();
        v33.Stopped:Fire();
    else
        warn((`Could not find a voiceline by the name of '{p32}'`));
    end;
end;
function u3.ClearUI() --[[ Line: 176 ]]
    -- upvalues: u3 (copy)
    for _, v36 in u3.ActiveUISections do
        for _, v37 in v36 do
            v37:Destroy();
        end;
    end;
    u3.ActiveUISections = {};
end;
function u3.Setup() --[[ Line: 187 ]]
    -- upvalues: u3 (copy), u1 (copy), u2 (copy)
    u3.Interface = u1.GetScreenGui("MainPriority");
    u2.Event:Connect(function(p38) --[[ Line: 190 ]]
        -- upvalues: u3 (ref)
        u3.PlayLine(p38);
    end);
end;
return u3;
