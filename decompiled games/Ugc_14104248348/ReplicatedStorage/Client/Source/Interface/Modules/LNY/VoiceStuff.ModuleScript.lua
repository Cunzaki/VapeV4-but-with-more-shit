-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.LNY.VoiceStuff
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local l__Workspace__2 = game:GetService("Workspace");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
l__Mince__3:Get("InterfaceHandler");
local u1 = l__Mince__3:GetState("VoiceGaugeState");
local u2 = l__Mince__3:GetEvent("ReportRms");
local u3 = {
    __IsAsyncSetup = true,
    MaxPeak = 0.05,
    MinPeak = 0,
    Stage = 1,
    Offset = -90,
    RotationPerStage = 60,
    CurrentProgress = 0,
    TimeElapsed = 0,
    PreviousDelta = 0,
    TimeSinceLastReport = 0,
    StageText = { "Level 1", "Level 2", "Level 3" }
};
function u3.DrawStage(p4) --[[ Line: 31 ]]
    -- upvalues: u1 (copy), u3 (copy), u2 (copy), l__Workspace__2 (copy)
    local v5 = u1.Progress or 0;
    local v6 = (u3.Stage - 1) * u3.RotationPerStage + u3.Offset;
    local v7 = u3;
    local l__CurrentProgress__4 = u3.CurrentProgress;
    v7.CurrentProgress = l__CurrentProgress__4 + (v5 - l__CurrentProgress__4) * (p4 * 5);
    local v8 = v6 + u3.RotationPerStage * u3.CurrentProgress;
    local l__RmsLevel__5 = u3.Analyzer.RmsLevel;
    local v9 = math.clamp(l__RmsLevel__5 / u3.MaxPeak, 0.01, 0.99);
    local v10 = u3;
    v10.TimeSinceLastReport = v10.TimeSinceLastReport + p4;
    if u3.TimeSinceLastReport >= 0.5 then
        local v11 = u3;
        v11.TimeSinceLastReport = v11.TimeSinceLastReport - 0.5;
        if l__RmsLevel__5 > 0 then
            u2:Fire(l__RmsLevel__5);
        end;
    end;
    local v12 = u3.PreviousDelta < v9;
    u3.PreviousDelta = v9;
    u3.Interface.Gauge.Pointer.Rotation = v8;
    u3.Interface.PersonalMeter.Fill.UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, v9 == 0.99 and 0 or 1),
        NumberSequenceKeypoint.new(1 - v9, v9 == 0.99 and 0 or 1),
        NumberSequenceKeypoint.new(1 - v9 + 0.01, 0),
        NumberSequenceKeypoint.new(1, 0)
    });
    local v13 = u3;
    v13.TimeElapsed = v13.TimeElapsed + p4;
    local v14 = 0.5 + v5 * 0.25;
    local v15 = u3.TimeElapsed * (3 + u3.CurrentProgress * 15);
    local v16 = Vector2.new(math.noise(0, v15), math.noise(0, v15)) * v14;
    u3.Gauge.Position = UDim2.new(0.5, 0 + v16.X, 1, 4 + v16.Y);
    if v9 >= 0.99 then
        local v17 = math.noise(u3.TimeElapsed * 35, 0) * 15;
        local v18 = math.noise(0, u3.TimeElapsed * 35) * 15;
        u3.Interface.PersonalMeter.Position = u3.OriginalMeterPosition + UDim2.fromOffset(v17, v18);
    else
        u3.Interface.PersonalMeter.Position = u3.OriginalMeterPosition;
    end;
    if v12 then
        local l__CurrentCamera__6 = l__Workspace__2.CurrentCamera;
        local v19 = u3.CurrentProgress * 0.01;
        local v20 = math.noise(u3.TimeElapsed * 45, 0) * v19;
        local v21 = math.noise(0, u3.TimeElapsed * 45) * v19;
        local v22 = math.noise(u3.TimeElapsed * 45, u3.TimeElapsed * 45) * v19;
        l__CurrentCamera__6.CFrame = l__CurrentCamera__6.CFrame * CFrame.Angles(math.rad(v20), math.rad(v21), (math.rad(v22)));
    end;
end;
function u3.WhenStageChanges(p23) --[[ Line: 102 ]]
    -- upvalues: u3 (copy)
    u3.CurrentProgress = 0;
    u3.Stage = p23 or 1;
    u3.Gauge.Text.Text = u3.StageText[u3.Stage];
end;
function u3.Setup() --[[ Line: 108 ]] end;
return u3;
