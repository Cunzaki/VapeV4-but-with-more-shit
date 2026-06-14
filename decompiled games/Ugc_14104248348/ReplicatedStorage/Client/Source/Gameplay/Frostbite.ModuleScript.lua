-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Frostbite
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("StarterPlayer");
game:GetService("TweenService");
local l__RunService__2 = game:GetService("RunService");
local l__LocalPlayer__3 = game:GetService("Players").LocalPlayer;
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__4:Get("SoundHandler");
local u2 = l__Mince__4:Get("Locomotion");
local u3 = l__Mince__4:Get("InterfaceHandler");
l__Mince__4:Get("Effects");
l__Mince__4:GetEvent("RequestRagdoll");
local u4 = l__Mince__4:GetEvent("RequestReset");
function lerp(p5, p6, p7)
    return p5 * (1 - p7) + p6 * p7;
end;
local u8 = {
    FrostLevel = 0,
    FatalLevel = 1,
    WarmRate = 0.02,
    ApplyTimePerFrost = 5,
    PlayerFrosts = {}
};
function u8.Consume(p9) --[[ Line: 35 ]]
    -- upvalues: u8 (copy)
    local v10 = math.abs(p9) * u8.ApplyTimePerFrost;
    local l__Humanoid__5 = u8.Humanoid;
    local v11 = 0;
    local v12 = 0;
    while true do
        local v13 = task.wait();
        v11 = v11 + v13;
        local v14 = v13 / v10;
        if v11 < v10 then
            local v15 = u8;
            v15.FrostLevel = v15.FrostLevel + v14 * p9;
            v12 = v12 + v14 * p9;
        end;
        if u8.Humanoid ~= l__Humanoid__5 then
            return;
        end;
        if u8.Humanoid == nil then
            return;
        end;
        if v10 < v11 then
            if u8.Humanoid == l__Humanoid__5 then
                if u8.Humanoid == nil then
                    return;
                else
                    local v16 = p9 - v12;
                    if v16 > 0 then
                        local v17 = u8;
                        v17.FrostLevel = v17.FrostLevel + v16;
                    end;
                    return;
                end;
            else
                return;
            end;
        end;
    end;
end;
function u8.Update(p18) --[[ Line: 65 ]]
    -- upvalues: u8 (copy), u1 (copy), u4 (copy), l__Mince__4 (copy)
    if u8.Frozen then
        u8.MainPriority.SnowTexture.ImageTransparency = 0.25;
    else
        u8.MainPriority.SnowTexture.ImageTransparency = 1;
        local v19 = u8;
        v19.FrostLevel = v19.FrostLevel - p18 * u8.WarmRate;
        u8.FrostLevel = math.clamp(u8.FrostLevel, 0, u8.FatalLevel);
        local v20 = u8.FrostLevel / u8.FatalLevel;
        if u8.FrostLevel >= u8.FatalLevel then
            u1.PlaySound("frostbite_die");
            u8.Frozen = true;
            u4:Fire();
        end;
        u8.FrostBiteLoop.Volume = u8.FrostLevel;
        u8.FrostBiteLoop.PlaybackSpeed = u8.FrostLevel;
        u8.MainPriority.SnowVignette.ImageTransparency = 1 - v20;
        u8.MainPriority.Snow.UIGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0, 1),
            NumberSequenceKeypoint.new(math.clamp(v20, 0.01, 0.98), 0, 1),
            NumberSequenceKeypoint.new(math.clamp(v20 + 0.01, 0.02, 0.99), 1, 1),
            NumberSequenceKeypoint.new(1, 1, 1)
        });
        l__Mince__4.Config.Stats.Frost[2] = `Frost: {u8.FrostLevel}`;
    end;
end;
function u8.NewCharacter(p21) --[[ Line: 101 ]]
    -- upvalues: u8 (copy), u2 (copy)
    local l__Humanoid__6 = p21:WaitForChild("Humanoid");
    u8.IntoxLevel = u8.FloorIntox;
    u2.MovementEnabled = true;
    u8.Humanoid = l__Humanoid__6;
    u8.FrostLevel = 0;
    u8.Frozen = false;
    l__Humanoid__6.Died:Connect(function() --[[ Line: 111 ]]
        -- upvalues: u8 (ref)
        u8.Humanoid = nil;
    end);
end;
function u8.Setup() --[[ Line: 116 ]]
    -- upvalues: l__Mince__4 (copy), u1 (copy), u8 (copy), u3 (copy), l__LocalPlayer__3 (copy), l__RunService__2 (copy)
    l__Mince__4.Config.Stats.Frost = { 45, "IDLE" };
    u1.WaitUntilSoundLoaded();
    u8.MainPriority = u3.GetScreenGui("MainPriority");
    u8.FrostBiteLoop = u1.PlaySound("frostbite_loop");
    u8.FrostBiteLoop.Looped = true;
    u8.FrostBiteLoop:Play();
    u8.FrostBiteLoop.Volume = 0;
    if l__LocalPlayer__3.Character then
        u8.NewCharacter(l__LocalPlayer__3.Character);
    end;
    l__LocalPlayer__3.CharacterAdded:Connect(u8.NewCharacter);
    l__RunService__2.Heartbeat:Connect(u8.Update);
end;
return u8;
