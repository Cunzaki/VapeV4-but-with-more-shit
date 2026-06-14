-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.SafeTeleport
-- Class: ModuleScript
-- Place: Ugc (126691165749976)

-- Decompiled with Potassium's decompiler.

local l__TeleportService__1 = game:GetService("TeleportService");
local function u7(u1, u2, u3) --[[ Line: 7 ]]
    -- upvalues: l__TeleportService__1 (copy)
    local v4 = 0;
    while true do
        local v5, v6 = pcall(function() --[[ Line: 12 ]]
            -- upvalues: l__TeleportService__1 (ref), u1 (copy), u2 (copy), u3 (copy)
            return l__TeleportService__1:TeleportAsync(u1, u2, u3);
        end);
        v4 = v4 + 1;
        if not v5 then
            task.wait(1);
        end;
        if v5 or v4 == 5 then
            if not v5 then
                warn(v6);
            end;
            return v5, v6;
        end;
    end;
end;
l__TeleportService__1.TeleportInitFailed:Connect(function(p8, p9, p10, p11, p12) --[[ Name: handleFailedTeleport, Line 28 ]]
    -- upvalues: u7 (copy)
    if p9 == Enum.TeleportResult.Flooded then
        task.wait(15);
    elseif p9 == Enum.TeleportResult.Failure then
        task.wait(1);
    else
        error(("Invalid teleport [%s]: %s"):format(p9.Name, p10));
    end;
    u7(p11, { p8 }, p12);
end);
return u7;
