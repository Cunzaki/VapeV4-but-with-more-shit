-- Decompiled from: ReplicatedStorage.Modules.rbxbpm
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local u2 = {
    Tracks = {}
};
function RoundTo(p3, p4)
    return math.ceil(p3 / p4 + p4 / 2) * p4;
end;
function u2.new(p5) --[[ Line: 14 ]]
    -- upvalues: u1 (copy), u2 (copy)
    local v6;
    if p5 then
        v6 = p5:IsA("Sound");
    else
        v6 = p5;
    end;
    assert(v6, "Rbxbpm.new([1]) was expected to be a Sound.");
    local v7 = Instance.new("BindableEvent");
    local v8 = setmetatable({
        IsSet = false,
        BeatPosition = 0,
        SubBeat = 1,
        LastBeat = 0,
        Offset = 0,
        PreOffset = 0,
        Instance = p5,
        OnBeat = v7.Event,
        __Events = {
            OnBeat = v7
        }
    }, u1);
    table.insert(u2.Tracks, v8);
    return v8;
end;
function u1.SetBpm(p9, p10) --[[ Line: 36 ]]
    p9.OrginalBPM = p9.Bpm;
    p9.Bpm = p10;
    p9.Bps = 60 / p10;
    p9.IsSet = true;
end;
function u1.Scale(p11, p12) --[[ Line: 43 ]]
    p11:SetBpm(p11.OrginalBPM * p12);
end;
function u1.GetTotalBeats(p13) --[[ Line: 48 ]]
    return p13.Instance.TimeLength / p13.Bps;
end;
function u1.SetSubBeat(p14, p15) --[[ Line: 52 ]]
    if p15 > 1 or p15 < 0 then
        warn("Sub beat must be inbetween one and zero. (0-1)");
    else
        p14.SubBeat = p15;
    end;
end;
function u1.Start(p16) --[[ Line: 60 ]]
    if p16.IsSet then
        p16.DoesLoop = p16.Instance.Looped;
        p16.Instance:Play();
    else
        warn("You must use :SetBpm() before attempting to start.");
    end;
end;
function u1.GeatBeat(p17) --[[ Line: 70 ]]
    return RoundTo(p17.BeatPosition, p17.SubBeat), p17.BeatPosition % 1;
end;
function u1.Destroy(p18) --[[ Line: 74 ]]
    -- upvalues: u2 (copy)
    table.remove(u2.Tracks, table.find(u2.Tracks, p18));
    setmetatable(p18, nil);
end;
function u2.Update(_) --[[ Line: 79 ]]
    -- upvalues: u2 (copy)
    for _, v19 in ipairs(u2.Tracks) do
        if v19.IsSet and (v19.Instance.Playing and v19.Instance.IsLoaded) then
            v19.BeatPosition = (v19.Instance.TimePosition + v19.Offset - v19.PreOffset) / v19.Bps;
            local v20, v21 = v19:GeatBeat();
            if v20 ~= v19.LastBeat then
                v19.LastBeat = v20;
                v19.__Events.OnBeat:Fire(v20, v21, v19.BeatPosition);
            end;
        end;
    end;
end;
task.spawn(function() --[[ Line: 94 ]]
    -- upvalues: u2 (copy)
    while true do
        local v22 = task.wait();
        u2.Update(v22);
    end;
end);
return u2;
