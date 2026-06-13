-- Decompiled from: ReplicatedStorage.Modules.CameraShake
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__RunService__1 = game:GetService("RunService");
local u2 = l__RunService__1:IsServer() and l__RunService__1.Heartbeat or l__RunService__1.RenderStepped;
function v1.Create(p3, u4) --[[ Line: 6 ]]
    -- upvalues: u2 (copy)
    local u5 = setmetatable(p3, {
        __index = {
            Duration = 1.5,
            FadeInTime = 0.5,
            FadeOutTime = 0.5,
            Roughness = 100,
            Intensity = 10,
            PositionInfluence = 1,
            RotationInfluence = 1,
            RotMultiplier = 0.0001,
            ZEnabled = false,
            SamplingMethod = "",
            AMult = 1,
            AllowFadeOverlap = true,
            DoesLoop = false,
            HasFinished = false
        }
    });
    local u6 = math.random() * 100 + math.random();
    local v7 = u5.Duration / 2;
    local u8 = 0;
    u5.FadeInTime = math.min(u5.FadeInTime, v7);
    u5.FadeOutTime = math.min(u5.FadeOutTime, v7);
    local u9 = CFrame.new(Vector3.new(0, 0, 0));
    u4(u9);
    u5.UpdateEvent = nil;
    u5.UpdateEvent = u2:Connect(function(p10) --[[ Line: 44 ]]
        -- upvalues: u8 (ref), u5 (copy), u6 (copy), u4 (copy), u9 (copy)
        u8 = u8 + p10;
        local v11 = u8 * u5.Roughness;
        local v12;
        if u5.SamplingMethod == "SeededX" then
            local v13 = math.noise(u6, v11);
            local v14 = math.noise(u6 + 1, v11);
            v12 = Vector3.new(v13, v14, math.noise(u6 + 2, v11));
        else
            local v15 = v11 + u6 * 10;
            local v16 = math.noise(v15, 0);
            local v17 = math.noise(0, v15);
            v12 = Vector3.new(v16, v17, math.noise(v15, v15));
        end;
        if u5.ZEnabled == false then
            v12 = v12 * Vector3.new(1, 1, 0);
        end;
        local v18 = math.max(0, u5.Duration - u8);
        local v19, v20;
        if u8 < u5.FadeInTime then
            v19 = u8 / u5.FadeInTime;
            v20 = u5.AllowFadeOverlap;
        else
            v20 = true;
            v19 = 1;
        end;
        if v18 < u5.FadeOutTime and v20 then
            v19 = v18 / u5.FadeOutTime;
        end;
        local v21 = math.clamp(v19, 0, 1);
        local v22 = v12 * u5.Intensity * v21;
        if u8 > u5.Duration then
            if not u5.DoesLoop then
                u4(u9);
                u5.HasFinished = true;
                u5.UpdateEvent:Disconnect();
                return;
            end;
            u8 = 0;
        end;
        local v23 = v22 * u5.PositionInfluence * u5.AMult;
        local v24 = v22 * u5.RotationInfluence * u5.RotMultiplier * u5.AMult;
        u4(CFrame.new(v23) * CFrame.Angles(math.deg(v24.X), math.deg(v24.Y), (math.deg(v24.Z))));
    end);
    function u5.Stop() --[[ Line: 98 ]]
        -- upvalues: u8 (ref), u5 (copy)
        u8 = u5.Duration;
        u5.UpdateEvent:Disconnect();
    end;
    return u5;
end;
return v1;
