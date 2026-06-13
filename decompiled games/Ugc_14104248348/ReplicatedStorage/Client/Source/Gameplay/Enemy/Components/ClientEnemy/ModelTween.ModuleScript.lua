-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Enemy.Components.ClientEnemy.ModelTween
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
local u1 = {};
local u2 = {};
u2.__index = u2;
function u2.new(p3, p4, p5, p6) --[[ Line: 87 ]]
    -- upvalues: u2 (copy), u1 (copy)
    local v7 = setmetatable({}, u2);
    if u1[p3] then
        u1[p3]:Destroy();
    end;
    v7.Model = p3;
    v7.TweenInfo = p4;
    v7.DestroyUponFinished = p6 == nil and true or p6;
    v7.IsPlaying = false;
    v7._initialTargetCFrame = p5;
    v7._duration = p4.Time;
    v7._durationElapsed = 0;
    v7._iterationsCompleted = 0;
    v7._isReversedLeg = false;
    v7._connection = nil;
    v7._finishedEvent = Instance.new("BindableEvent");
    v7._tickEvent = Instance.new("BindableEvent");
    v7.Finished = v7._finishedEvent.Event;
    v7.Tick = v7._tickEvent.Event;
    return v7;
end;
function u2.SetTargetCFrame(p8, p9) --[[ Line: 120 ]]
    p8._initialTargetCFrame = p9;
end;
function u2.Play(u10) --[[ Line: 128 ]]
    -- upvalues: l__RunService__1 (copy), u1 (copy), l__TweenService__2 (copy)
    if u10.IsPlaying then
    else
        u10._currentStartCFrame = u10.Model:GetPivot();
        u10._currentEndCFrame = u10._initialTargetCFrame;
        u10._durationElapsed = 0;
        u10._iterationsCompleted = 0;
        u10._isReversedLeg = false;
        u10.IsPlaying = true;
        if u10._connection then
            u10._connection:Disconnect();
        end;
        u10._connection = l__RunService__1.RenderStepped:Connect(function(p11) --[[ Line: 147 ]]
            -- upvalues: u10 (copy), u1 (ref), l__TweenService__2 (ref)
            if u10.IsPlaying then
                local v12 = u1[u10.Model];
                if v12 and v12 ~= u10 then
                    v12:Skip();
                end;
                u1[u10.Model] = u10;
                local v13 = u10;
                v13._durationElapsed = v13._durationElapsed + p11;
                local v14 = math.min(u10._durationElapsed / u10._duration, 1);
                local v15 = l__TweenService__2:GetValue(v14, u10.TweenInfo.EasingStyle, u10.TweenInfo.EasingDirection);
                u10.Model:PivotTo(u10._currentStartCFrame:Lerp(u10._currentEndCFrame, v15));
                u10._tickEvent:Fire(v14, v15);
                if u10._durationElapsed >= u10._duration then
                    u10.Model:PivotTo(u10._currentEndCFrame);
                    local v16 = u10;
                    v16._iterationsCompleted = v16._iterationsCompleted + 1;
                    local l__RepeatCount__3 = u10.TweenInfo.RepeatCount;
                    local l__DelayTime__4 = u10.TweenInfo.DelayTime;
                    local l__Reverses__5 = u10.TweenInfo.Reverses;
                    local v17 = l__RepeatCount__3 < 0 and -1 or (l__RepeatCount__3 + 1) * (l__Reverses__5 and 2 or 1);
                    local v18;
                    if v17 >= 0 then
                        v18 = v17 <= u10._iterationsCompleted;
                    else
                        v18 = false;
                    end;
                    if v18 then
                        u10:Stop();
                        u10._finishedEvent:Fire();
                        if u10.DestroyUponFinished then
                            u10:Destroy();
                        end;
                    else
                        if l__DelayTime__4 > 0 then
                            task.wait(l__DelayTime__4);
                            if not u10.IsPlaying then
                                return;
                            end;
                        end;
                        u10._durationElapsed = 0;
                        if l__Reverses__5 then
                            u10._isReversedLeg = not u10._isReversedLeg;
                            local l___currentEndCFrame__6 = u10._currentEndCFrame;
                            local v19;
                            if u10._isReversedLeg then
                                v19 = u10._currentStartCFrame;
                            else
                                v19 = u10._initialTargetCFrame;
                            end;
                            u10._currentStartCFrame = l___currentEndCFrame__6;
                            u10._currentEndCFrame = v19;
                            return;
                        end;
                        u10._currentStartCFrame = u10._currentEndCFrame;
                        u10._currentEndCFrame = u10._initialTargetCFrame;
                    end;
                end;
            end;
        end);
    end;
end;
function u2.Stop(p20) --[[ Line: 231 ]]
    if p20.IsPlaying then
        if p20._connection then
            p20._connection:Disconnect();
            p20._connection = nil;
        end;
        p20.IsPlaying = false;
    end;
end;
function u2.Skip(p21) --[[ Line: 242 ]]
    -- upvalues: u1 (copy)
    if p21._connection or p21.IsPlaying then
        local l__IsPlaying__7 = p21.IsPlaying;
        p21:Stop();
        if l__IsPlaying__7 then
            local l__DestroyUponFinished__8 = p21.DestroyUponFinished;
            p21._finishedEvent:Fire();
            if l__DestroyUponFinished__8 and u1[p21.Model] == p21 then
                p21:Destroy();
            end;
        end;
    end;
end;
function u2.Destroy(p22) --[[ Line: 262 ]]
    -- upvalues: u1 (copy)
    p22:Stop();
    if p22._finishedEvent then
        p22._finishedEvent:Destroy();
    end;
    if p22._tickEvent then
        p22._tickEvent:Destroy();
    end;
    if u1[p22.Model] == p22 then
        u1[p22.Model] = nil;
    end;
end;
return u2;
