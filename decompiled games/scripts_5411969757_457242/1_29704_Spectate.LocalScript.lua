-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__SpectateService__2 = require(script:WaitForChild("SpectateService"));
game:GetService("ReplicatedStorage"):WaitForChild("SpectateServer").OnClientEvent:Connect(function(p1, ...) --[[ Line: 5 ]]
    -- upvalues: l__SpectateService__2 (copy), l__LocalPlayer__1 (copy)
    local v2 = { ... };
    if p1 == "unspec" then
        l__SpectateService__2.EndSpectating();
        l__SpectateService__2.StartTracking();
        return;
    end;
    if p1 == "spec" then
        local v3 = v2[1];
        local v4 = nil;
        for _, v5 in game:GetService("Players"):GetPlayers() do
            if v5 ~= l__LocalPlayer__1 and v5.Name:lower():sub(1, v3:len()) == v3:lower() then
                v4 = v5;
                break;
            end;
        end;
        if v4 == nil then
            return;
        end;
        l__SpectateService__2.SpectatePlayer(v4);
    end;
end);
l__SpectateService__2.StartTracking();