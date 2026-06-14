-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.IntyComponent
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
game:GetService("RunService");
game:GetService("StarterGui");
game:GetService("TweenService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("Debris");
local _ = l__Players__1.LocalPlayer;
local l__Maid__3 = require(l__ReplicatedStorage__2.Modules.Maid);
local l__Mince__4 = require(l__ReplicatedStorage__2.Modules.Mince);
local u1 = l__Mince__4:Get("Voicelines");
l__Mince__4:Get("NotifPrompt");
l__Mince__4:Get("ConfirmPrompt");
l__Mince__4:Get("Notices");
l__Mince__4:Get("OpeningHandler");
l__Mince__4:Get("IndicatorHandler");
l__Mince__4:Get("SelectInteractor");
l__Mince__4:Get("ObjectiveHandler");
local u2 = Random.new(os.clock());
local u3 = l__Mince__4.Component({
    Tag = "IntyNpc",
    IdleEnabled = true,
    Voicelines = {
        StartGame = { "INTY24StartGame1", "INTY24StartGame2", "INTY24StartGame3" },
        HitIntyAfterLine = { "INTY24HitInty6", "INTY24HitInty7", "INTY24HitInty8" },
        WinPrize = {
            "INTY24WinPrize1",
            "INTY24WinPrize2",
            "INTY24WinPrize3",
            "INTY24WinPrize4"
        },
        Miss = {
            "INTY24MissTarget1",
            "INTY24MissTarget2",
            "INTY24MissTarget3",
            "INTY24MissTarget4",
            "INTY24MissTarget5"
        },
        Hit = {
            "INTY24HitTarget1",
            "INTY24HitTarget2",
            "INTY24HitTarget3",
            "INTY24HitTarget4"
        },
        HitInty = {
            "INTY24HitInty1",
            "INTY24HitInty2",
            "INTY24HitInty3",
            "INTY24HitInty4",
            "INTY24HitInty5"
        }
    },
    LineBuckets = {}
});
function u3.PlayVoiceline(_, p4, p5) --[[ Line: 43 ]]
    -- upvalues: u3 (copy), u2 (copy), u1 (copy)
    if u3.CurrentLine and not p5 then
    else
        if u3.CurrentLine then
            u3.CurrentLine:Stop();
        end;
        local v6 = u3.Voicelines[p4];
        local v7 = u3.LineBuckets[p4];
        if not v7 or #v7 < 1 then
            u3.LineBuckets[p4] = table.clone(v6);
            u2:Shuffle(u3.LineBuckets[p4]);
            v7 = u3.LineBuckets[p4];
        end;
        local v8 = u2:NextInteger(1, #v7);
        local v9 = u1.GetVoicelineSettings(v7[v8]);
        v9:Play();
        table.remove(u3.LineBuckets[p4], v8);
        u3.CurrentLine = v9.Sound;
        repeat
            task.wait();
        until v9.Sound.TimeLength ~= 0;
        task.wait(v9.Sound.TimeLength);
        u3.CurrentLine = nil;
    end;
end;
function u3.PlayEmote(u10, p11) --[[ Line: 74 ]]
    local u12 = u10.Animations[p11];
    if u10.CurrentEmote then
        u10.CurrentEmote:Stop();
    end;
    if u10.EmoteThread then
        task.cancel(u10.EmoteThread);
    end;
    u10.CurrentEmote = u12;
    u10.Animations.Idle:Stop();
    u12:Play();
    u10.EmoteThread = task.delay(u12.Length, function() --[[ Line: 90 ]]
        -- upvalues: u12 (copy), u10 (copy)
        u12:Stop();
        u10.CurrentEmote = nil;
        u10.Animations.Idle:Play();
    end);
    return u12.Length;
end;
function u3.DoIdleEmote(p13) --[[ Line: 99 ]]
    if p13.IdleEnabled then
        task.wait(p13:PlayEmote("Bored"));
    end;
end;
function u3.Construct(p14) --[[ Line: 104 ]]
    -- upvalues: l__Maid__3 (copy)
    local l__Instance__5 = p14.Instance;
    local l__Animations__6 = p14.Instance:WaitForChild("Animations");
    p14.Events = {};
    p14.Maid = l__Maid__3.new();
    p14.Character = l__Instance__5;
    p14.Animations = {};
    for _, v15 in l__Animations__6:GetChildren() do
        p14.Animations[v15.Name] = p14.Character.Humanoid:LoadAnimation(v15);
    end;
    p14.Animations.Idle:Play();
    task.defer(function() --[[ Line: 120 ]] end);
end;
return u3;
