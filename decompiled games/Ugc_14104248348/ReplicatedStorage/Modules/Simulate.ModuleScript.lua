-- Decompiled from: ReplicatedStorage.Modules.Simulate
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
return {
    new = function(u1, u2, u3) --[[ Name: new, Line 7 ]]
        -- upvalues: l__RunService__1 (copy)
        local u4 = {
            Events = {}
        };
        u4.Events.Update = l__RunService__1.Heartbeat:Connect(function(p5) --[[ Line: 12 ]]
            -- upvalues: u2 (ref), u3 (copy), u1 (copy)
            u2 = u2 - Vector2.yAxis * u3;
            local v6 = u1;
            v6.Position = v6.Position + UDim2.fromScale(u2.X * p5, u2.Y * p5);
        end);
        function u4.Destroy(_) --[[ Line: 20 ]]
            -- upvalues: u4 (copy)
            for _, v7 in u4.Events do
                v7:Disconnect();
            end;
        end;
        u1.Destroying:Connect(function() --[[ Line: 27 ]]
            -- upvalues: u4 (copy)
            u4:Destroy();
        end);
        return u4;
    end
};
