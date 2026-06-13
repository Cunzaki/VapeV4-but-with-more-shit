-- Decompiled from: ReplicatedStorage.Modules.Projectile
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
return {
    new = function(u1, u2) --[[ Name: new, Line 13 ]]
        -- upvalues: l__RunService__1 (copy)
        local u3 = 0;
        local l__Position__2 = u1.Position;
        local l__Velocity__3 = u1.Velocity;
        local u4 = false;
        local u5 = nil;
        local u6 = nil;
        u5 = l__RunService__1.Heartbeat:Connect(function(p7) --[[ Line: 19 ]]
            -- upvalues: u3 (ref), u1 (copy), u4 (ref), u5 (ref), l__Velocity__3 (ref), l__Position__2 (ref), u6 (ref), u2 (copy)
            u3 = u3 + p7;
            if u3 >= u1.Lifetime then
                u4 = true;
                u5:Disconnect();
            else
                l__Velocity__3 = l__Velocity__3 - Vector3.new(0, 1, 0) * u1.Gravity * p7;
                local v8 = l__Position__2 + l__Velocity__3 * p7;
                local v9 = workspace:Spherecast(l__Position__2, 2, v8 - l__Position__2, u1.Params);
                if v9 then
                    u6 = v9;
                    u4 = true;
                    u5:Disconnect();
                end;
                l__Position__2 = v8;
                if u2 then
                    u2(l__Position__2, l__Velocity__3, u3, p7);
                end;
            end;
        end);
        local v10 = u3;
        local v11 = u6;
        repeat
            task.wait();
        until u4 or (v11 or u1.Lifetime < v10);
        return v11;
    end
};
