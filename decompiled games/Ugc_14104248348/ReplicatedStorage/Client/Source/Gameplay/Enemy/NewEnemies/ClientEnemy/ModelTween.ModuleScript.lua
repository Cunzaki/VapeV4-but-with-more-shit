-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Enemy.NewEnemies.ClientEnemy.ModelTween
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
local u1 = {};
return {
    new = function(u2, u3, u4) --[[ Name: new, Line 18 ]]
        -- upvalues: u1 (copy), l__RunService__1 (copy), l__TweenService__2 (copy)
        local u5 = u2:GetPivot();
        local l__Time__3 = u3.Time;
        local u6 = 0;
        local u7 = Instance.new("BindableEvent");
        local u8 = Instance.new("BindableEvent");
        local u9 = nil;
        if u1[u2] then
            u1[u2].Destroy();
        end;
        local u10 = {
            Iterations = 0,
            ShouldReverse = false,
            DestroyUponFinished = true,
            Finished = u7.Event,
            Tick = u8.Event
        };
        function u10.Destroy() --[[ Line: 42 ]]
            -- upvalues: u10 (ref), u9 (ref), u7 (copy), u8 (copy)
            u10 = nil;
            u9:Disconnect();
            u7:Destroy();
            u8:Destroy();
        end;
        function u10.Play() --[[ Line: 49 ]]
            -- upvalues: u9 (ref), l__RunService__1 (ref), u6 (ref), l__Time__3 (copy), l__TweenService__2 (ref), u3 (copy), u2 (copy), u5 (copy), u4 (ref), u8 (copy), u10 (ref), u7 (copy)
            u9 = l__RunService__1.RenderStepped:Connect(function(p11) --[[ Line: 50 ]]
                -- upvalues: u6 (ref), l__Time__3 (ref), l__TweenService__2 (ref), u3 (ref), u2 (ref), u5 (ref), u4 (ref), u8 (ref), u10 (ref), u7 (ref), u9 (ref)
                u6 = u6 + p11;
                local v12 = u6 / l__Time__3;
                local v13 = l__TweenService__2:GetValue(v12, u3.EasingStyle, u3.EasingDirection);
                u2:PivotTo(u5:Lerp(u4, v13));
                u8:Fire(v12, v13);
                if l__Time__3 <= u6 then
                    if u3.Reverses then
                        u10.ShouldReverse = not u10.ShouldReverse;
                    end;
                    if u10.ShouldReverse then
                        u4 = u5;
                    end;
                    local v14 = u10;
                    v14.Iterations = v14.Iterations + 1;
                    if u10.Iterations > u3.RepeatCount then
                        u7:Fire();
                        u9:Disconnect();
                        if u10.DestroyUponFinished then
                            u10.Destroy();
                        end;
                    end;
                end;
            end);
        end;
        function u10.Stop() --[[ Line: 84 ]]
            -- upvalues: u9 (ref), u10 (ref)
            if u9 then
                u9:Disconnect();
                if u10.DestroyUponFinished then
                    u10.Destroy();
                end;
            end;
        end;
        u1[u2] = u10;
        return u10;
    end
};
