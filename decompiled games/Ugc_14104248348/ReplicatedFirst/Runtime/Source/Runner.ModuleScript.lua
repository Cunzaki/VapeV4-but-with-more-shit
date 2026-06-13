-- Decompiled from: ReplicatedFirst.Runtime.Source.Runner
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__LightRunner__1 = _G.LightRunner;
local v10 = {
    Runners = {
        StarterGui = { function() --[[ Line: 4 ]]
                return game:GetService("StarterGui");
            end },
        TweenService = { function() --[[ Line: 7 ]]
                return game:GetService("TweenService");
            end },
        ReplicatedStorage = { function() --[[ Line: 10 ]]
                return game:GetService("ReplicatedStorage");
            end },
        Mince = { function() --[[ Line: 13 ]]
                -- upvalues: l__LightRunner__1 (copy)
                return require(l__LightRunner__1:Get("Runner"):Get("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Mince"));
            end },
        PlayerGui = { function() --[[ Line: 16 ]]
                return game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
            end }
    },
    Get = function(p1, p2) --[[ Name: Get, Line 23 ]]
        local v3 = p1.Runners[p2];
        local v4 = `No runner by the name of '{p2}'!`;
        assert(v3, v4);
        if not v3.IsReady then
            v3.Ready:Wait();
        end;
        return v3.Value;
    end,
    When = function(p5, p6, u7) --[[ Name: When, Line 34 ]]
        local u8 = p5.Runners[p6];
        local v9 = `No runner by the name of '{p6}'!`;
        assert(u8, v9);
        if u8.IsReady then
            u7(u8.Value);
        else
            u8.Ready:Connect(function() --[[ Line: 39 ]]
                -- upvalues: u7 (copy), u8 (copy)
                u7(u8.Value);
            end);
        end;
    end
};
for _, u11 in v10.Runners do
    u11.IsReady = false;
    u11.Ready = l__LightRunner__1.Signal.new();
    task.defer(function() --[[ Line: 51 ]]
        -- upvalues: u11 (copy)
        u11.Value = u11[1]();
        u11.IsReady = true;
        u11.Ready:Fire();
    end);
end;
return v10;
