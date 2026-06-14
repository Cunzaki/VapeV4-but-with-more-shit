-- Decompiled from: ReplicatedStorage.Modules.ModelTween
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
local u1 = require("./Signal");
local u2 = {};
local u3 = {};
u3.__index = u3;
function u3.new(p4, p5, p6, p7) --[[ Line: 87 ]]
    -- upvalues: u3 (copy), u2 (copy), u1 (copy)
    local v8 = setmetatable({}, u3);
    if u2[p4] then
        u2[p4]:Destroy();
    end;
    v8.Model = p4;
    v8.TweenInfo = p5;
    v8.DestroyUponFinished = p7 == nil and true or p7;
    v8.IsPlaying = false;
    v8._initialTargetCFrame = p6;
    v8._duration = p5.Time;
    v8._durationElapsed = 0;
    v8._iterationsCompleted = 0;
    v8._isReversedLeg = false;
    v8._connection = nil;
    v8.Finished = u1.new();
    v8.Tick = u1.new();
    return v8;
end;
function u3.SetTargetCFrame(p9, p10) --[[ Line: 118 ]]
    p9._initialTargetCFrame = p10;
end;
function u3.Play(u11) --[[ Line: 126 ]]
    -- upvalues: l__RunService__1 (copy), u2 (copy), l__TweenService__2 (copy)
    if u11.IsPlaying then
    else
        u11._currentStartCFrame = u11.Model:GetPivot();
        u11._currentEndCFrame = u11._initialTargetCFrame;
        u11._durationElapsed = 0;
        u11._iterationsCompleted = 0;
        u11._isReversedLeg = false;
        u11.IsPlaying = true;
        if u11._connection then
            u11._connection:Disconnect();
        end;
        u11._connection = l__RunService__1.RenderStepped:Connect(function(p12) --[[ Line: 145 ]]
            -- upvalues: u11 (copy), u2 (ref), l__TweenService__2 (ref)
            if u11.IsPlaying then
                local v13 = u2[u11.Model];
                if v13 and v13 ~= u11 then
                    v13:Skip();
                end;
                u2[u11.Model] = u11;
                local v14 = u11;
                v14._durationElapsed = v14._durationElapsed + p12;
                local v15 = math.min(u11._durationElapsed / u11._duration, 1);
                local v16 = l__TweenService__2:GetValue(v15, u11.TweenInfo.EasingStyle, u11.TweenInfo.EasingDirection);
                u11.Model:PivotTo(u11._currentStartCFrame:Lerp(u11._currentEndCFrame, v16));
                u11.Tick:Fire(v15, v16);
                if u11._durationElapsed >= u11._duration then
                    u11.Model:PivotTo(u11._currentEndCFrame);
                    local v17 = u11;
                    v17._iterationsCompleted = v17._iterationsCompleted + 1;
                    local l__RepeatCount__3 = u11.TweenInfo.RepeatCount;
                    local l__DelayTime__4 = u11.TweenInfo.DelayTime;
                    local l__Reverses__5 = u11.TweenInfo.Reverses;
                    local v18 = l__RepeatCount__3 < 0 and -1 or (l__RepeatCount__3 + 1) * (l__Reverses__5 and 2 or 1);
                    local v19;
                    if v18 >= 0 then
                        v19 = v18 <= u11._iterationsCompleted;
                    else
                        v19 = false;
                    end;
                    if v19 then
                        u11:Stop();
                        u11.Finished:Fire();
                        if u11.DestroyUponFinished then
                            u11:Destroy();
                        end;
                    else
                        if l__DelayTime__4 > 0 then
                            task.wait(l__DelayTime__4);
                            if not u11.IsPlaying then
                                return;
                            end;
                        end;
                        u11._durationElapsed = 0;
                        if l__Reverses__5 then
                            u11._isReversedLeg = not u11._isReversedLeg;
                            local l___currentEndCFrame__6 = u11._currentEndCFrame;
                            local v20;
                            if u11._isReversedLeg then
                                v20 = u11._currentStartCFrame;
                            else
                                v20 = u11._initialTargetCFrame;
                            end;
                            u11._currentStartCFrame = l___currentEndCFrame__6;
                            u11._currentEndCFrame = v20;
                            return;
                        end;
                        u11._currentStartCFrame = u11._currentEndCFrame;
                        u11._currentEndCFrame = u11._initialTargetCFrame;
                    end;
                end;
            end;
        end);
    end;
end;
function u3.Stop(p21) --[[ Line: 229 ]]
    if p21.IsPlaying then
        if p21._connection then
            p21._connection:Disconnect();
            p21._connection = nil;
        end;
        p21.IsPlaying = false;
    end;
end;
function u3.Skip(p22) --[[ Line: 240 ]]
    -- upvalues: u2 (copy)
    if p22._connection or p22.IsPlaying then
        local l__IsPlaying__7 = p22.IsPlaying;
        p22:Stop();
        if l__IsPlaying__7 then
            local l__DestroyUponFinished__8 = p22.DestroyUponFinished;
            p22.Finished:Fire();
            if l__DestroyUponFinished__8 and u2[p22.Model] == p22 then
                p22:Destroy();
            end;
        end;
    end;
end;
function u3.Destroy(p23) --[[ Line: 260 ]]
    -- upvalues: u2 (copy)
    p23:Stop();
    if p23.Finished then
        p23.Finished:Destroy();
    end;
    if p23.Tick then
        p23.Tick:Destroy();
    end;
    if u2[p23.Model] == p23 then
        u2[p23.Model] = nil;
    end;
end;
return u3;
