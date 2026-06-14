-- Decompiled from: ReplicatedStorage.Modules.Timer
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__Signal__2 = require(script.Parent.Signal);
local u1 = {};
u1.__index = u1;
function u1.Throw(p2) --[[ Line: 23 ]]
    warn("[Timer]:" .. p2);
end;
function u1.fromTweenInfo(p3) --[[ Line: 27 ]]
    -- upvalues: u1 (copy)
    local v4 = u1.new(p3.Time);
    v4.Loop = p3.RepeatCount < 0;
    v4.Reverses = p3.Reverses;
    v4.EasingStyle = p3.EasingStyle;
    v4.EasingDirection = p3.EasingDirection;
    return v4;
end;
function u1.new(p5) --[[ Line: 36 ]]
    -- upvalues: u1 (copy), l__Signal__2 (copy)
    local v6 = setmetatable({
        Enabled = true,
        Loop = false,
        Reverses = false,
        Time = 0,
        Progress = 0,
        DestroyOnFinish = false,
        __IsForward = true,
        __TimeElapsed = 0,
        __Running = false,
        Duration = p5 or 1
    }, u1);
    v6.Completed = l__Signal__2.new();
    v6.Tick = l__Signal__2.new();
    return v6;
end;
function u1.delay(p7, u8) --[[ Line: 55 ]]
    -- upvalues: u1 (copy)
    local v9 = typeof(u8) == "function";
    assert(v9, "Timer.defer([2]) must be a function.");
    local u10 = u1.new(p7);
    u10:Start();
    u10.Completed:Connect(function() --[[ Line: 59 ]]
        -- upvalues: u8 (copy), u10 (copy)
        u8();
        u10:Destroy();
    end);
    return u10;
end;
function u1.interval(p11, u12) --[[ Line: 66 ]]
    -- upvalues: u1 (copy)
    local v13 = typeof(u12) == "function";
    assert(v13, "Timer.interval([2]) must be a function.");
    local v14 = u1.new(p11);
    v14:Start();
    v14.Loop = true;
    v14.Completed:Connect(function() --[[ Line: 71 ]]
        -- upvalues: u12 (copy)
        u12();
    end);
    return v14;
end;
function u1.Tween(p15, p16) --[[ Line: 78 ]]
    p15.Duration = p16.Time;
    p15.Loop = p16.RepeatCount < 0;
    p15.Reverses = p16.Reverses;
    p15.EasingStyle = p16.EasingStyle;
    p15.EasingDirection = p16.EasingDirection;
    p15:Reset();
end;
function u1.Start(u17, p18) --[[ Line: 87 ]]
    -- upvalues: l__TweenService__1 (copy)
    if not u17.__Running and u17.Enabled then
        if u17.Thread and coroutine.status(u17.Thread) == "running" then
            task.wait();
        end;
        u17.Duration = p18 or u17.Duration;
        u17.Thread = task.spawn(function() --[[ Line: 91 ]]
            -- upvalues: u17 (copy), l__TweenService__1 (ref)
            u17.__Running = true;
            if u17.__IsForward then
                while u17.__Running do
                    if u17.Enabled then
                        local v19 = u17.__TimeElapsed / u17.Duration;
                        u17.Progress = v19;
                        if u17.EasingStyle and u17.EasingDirection then
                            v19 = l__TweenService__1:GetValue(v19, u17.EasingStyle, u17.EasingDirection);
                        end;
                        u17.TimeValue = v19;
                        u17.Tick:Fire(v19, u17.__TimeElapsed);
                        local v20 = u17;
                        v20.__TimeElapsed = v20.__TimeElapsed + task.wait();
                    end;
                    if u17.__TimeElapsed > u17.Duration then
                        break;
                    end;
                end;
            else
                while u17.__Running do
                    if u17.Enabled then
                        local v21 = u17.__TimeElapsed / u17.Duration;
                        u17.Progress = v21;
                        if u17.EasingStyle and u17.EasingDirection then
                            v21 = l__TweenService__1:GetValue(v21, u17.EasingStyle, u17.EasingDirection);
                        end;
                        u17.TimeValue = v21;
                        u17.Tick:Fire(v21, u17.__TimeElapsed);
                        local v22 = u17;
                        v22.__TimeElapsed = v22.__TimeElapsed - task.wait();
                    end;
                    if u17.__TimeElapsed < 0 then
                        break;
                    end;
                end;
            end;
            if u17.__Running then
            else
                u17.Tick:Fire(1);
                u17.Completed:Fire();
                if u17.DestroyOnFinish then
                    task.wait();
                    u17:Destroy();
                else
                    if u17.Reverses then
                        u17.__IsForward = not u17.__IsForward;
                    end;
                    if u17.__IsForward then
                        u17.__TimeElapsed = 0;
                    else
                        u17.__TimeElapsed = math.min(u17.__TimeElapsed, u17.Duration);
                    end;
                    if u17.Loop then
                        u17.__Running = false;
                        u17:Start();
                    else
                        u17.__Running = false;
                    end;
                end;
            end;
        end);
    end;
end;
function u1.Reset(p23) --[[ Line: 151 ]]
    p23.__Running = false;
    p23.__TimeElapsed = 0;
    p23:Start(p23.Duration);
end;
function u1.Pause(p24) --[[ Line: 157 ]]
    p24.Enabled = false;
end;
function u1.Resume(p25) --[[ Line: 161 ]]
    p25.Enabled = true;
end;
function u1.Stop(p26) --[[ Line: 165 ]]
    p26.__Running = false;
    if p26.Thread then
        coroutine.close(p26.Thread);
    end;
end;
function u1.Destroy(p27) --[[ Line: 172 ]]
    p27:Stop();
    p27.__CompletedEvent:Destroy();
    p27.__Tick:Destroy();
end;
return u1;
