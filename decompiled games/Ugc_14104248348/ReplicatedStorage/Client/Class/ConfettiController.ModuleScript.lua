-- Decompiled from: ReplicatedStorage.Client.Class.ConfettiController
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ConfettiParticles__1 = require(script.ConfettiParticles);
l__ConfettiParticles__1.setGravity(Vector2.new(0, 1));
local u1 = {
    DefaultParams = {
        Generator = function() --[[ Name: Generator, Line 8 ]]
            return {
                Vector2.new(math.random(0, 100) / 100, -(math.random(0, 5) / 10)),
                Vector2.new(math.random(-20, 20), math.random(0, 10)),
                script.Parent,
                {
                    Color3.fromRGB(255, 17, 21),
                    Color3.fromRGB(255, 240, 26),
                    Color3.fromRGB(20, 224, 255),
                    Color3.fromRGB(58, 255, 14),
                    Color3.fromRGB(180, 29, 255)
                }
            };
        end
    }
};
function u1.CreateHost(p2, p3, p4) --[[ Line: 19 ]]
    -- upvalues: u1 (copy), l__ConfettiParticles__1 (copy)
    assert(p2 > 0, "You must create more than one particle!");
    assert(p3, "Where should the particles go?");
    local v5 = p4 or u1.DefaultParams;
    local u6 = {
        IsEnabled = false,
        IsRunning = false,
        ClosingTime = 10,
        ConfettiParticles = {}
    };
    function u6.Update() --[[ Line: 32 ]]
        -- upvalues: u6 (copy)
        for _, v7 in ipairs(u6.ConfettiParticles) do
            v7.Enabled = u6.IsEnabled;
            v7:Update();
        end;
    end;
    function u6.UpdateColors(p8) --[[ Line: 39 ]]
        -- upvalues: u6 (copy)
        for _, v9 in ipairs(u6.ConfettiParticles) do
            v9:SetColors(p8);
        end;
    end;
    function u6.StartConfetti(p10) --[[ Line: 45 ]]
        -- upvalues: u6 (copy)
        u6.IsRunning = true;
        u6.IsEnabled = true;
        task.delay(p10, function() --[[ Line: 50 ]]
            -- upvalues: u6 (ref)
            u6.IsEnabled = false;
            u6.IsRunning = false;
        end);
    end;
    u6.Thread = coroutine.create(function() --[[ Line: 58 ]]
        -- upvalues: u6 (copy)
        while true do
            task.wait();
            u6.Update();
        end;
    end);
    task.spawn(u6.Thread);
    for _ = 1, p2 do
        local v11 = v5.Generator();
        v11[3] = p3;
        local v12 = l__ConfettiParticles__1.createParticle(table.unpack(v11));
        table.insert(u6.ConfettiParticles, v12);
    end;
    return u6;
end;
return u1;
