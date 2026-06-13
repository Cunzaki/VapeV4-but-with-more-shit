-- Decompiled from: ReplicatedStorage.Modules.ModelTweenOG
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
local u1 = require("./Signal");
return {
    new = function(u2, u3, u4, p5) --[[ Name: new, Line 18 ]]
        -- upvalues: u1 (copy), l__RunService__1 (copy), l__TweenService__2 (copy)
        local l__Time__3 = u3.Time;
        local u6 = 0;
        local u7 = nil;
        local u8 = {
            Iterations = 0,
            ShouldReverse = false,
            DestroyUponFinished = true,
            Playing = false,
            Finished = u1.new(),
            Tick = u1.new()
        };
        if p5 then
            u8.DestroyUponFinished = false;
        end;
        function u8.Destroy() --[[ Line: 37 ]]
            -- upvalues: u7 (ref), u8 (copy)
            u7:Disconnect();
            u8.Finished:Destroy();
            u8.Tick:Destroy();
        end;
        function u8.Play() --[[ Line: 43 ]]
            -- upvalues: u6 (ref), u8 (copy), u2 (copy), u7 (ref), l__RunService__1 (ref), l__Time__3 (copy), l__TweenService__2 (ref), u3 (copy), u4 (ref)
            u6 = 0;
            u8.Iterations = 0;
            local u9 = u2:GetPivot();
            if u7 then
                u7:Disconnect();
                u7 = nil;
            end;
            u7 = l__RunService__1.RenderStepped:Connect(function(p10) --[[ Line: 48 ]]
                -- upvalues: u6 (ref), l__Time__3 (ref), l__TweenService__2 (ref), u3 (ref), u8 (ref), u2 (ref), u9 (ref), u4 (ref), u7 (ref)
                if l__Time__3 <= u6 then
                else
                    u6 = u6 + p10;
                    local v11 = u6 / l__Time__3;
                    local v12 = l__TweenService__2:GetValue(v11, u3.EasingStyle, u3.EasingDirection);
                    u8.Tick:Fire(v11, v12);
                    u2:PivotTo(u9:Lerp(u4, v12));
                    if l__Time__3 <= u6 then
                        if u3.Reverses then
                            local v13 = u4;
                            u4 = u9;
                            u9 = v13;
                        end;
                        local v14 = u8;
                        v14.Iterations = v14.Iterations + 1;
                        if u8.Iterations > u3.RepeatCount and u3.RepeatCount >= 0 then
                            u8.Finished:Fire();
                            u7:Disconnect();
                            if u8.DestroyUponFinished then
                                u8.Destroy();
                            end;
                        else
                            u6 = 0;
                        end;
                    end;
                end;
            end);
        end;
        function u8.Skip() --[[ Line: 84 ]]
            -- upvalues: u8 (copy)
            u8.Finished:Fire();
            if u8 then
                u8.Stop();
            end;
            task.wait();
            task.wait();
        end;
        function u8.Stop() --[[ Line: 90 ]]
            -- upvalues: u7 (ref), u8 (copy)
            if u7 then
                u7:Disconnect();
                if not u8 then
                    return;
                end;
                if u8.DestroyUponFinished then
                    u8.Destroy();
                end;
            end;
        end;
        return u8;
    end
};
