-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Enemy.NewEnemies.ClientEnemy.Impacts.ThrowHead
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
game:GetService("Debris");
local l__Effect__3 = require(l__ReplicatedStorage__1.Modules.Effect);
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.ModelTweenOG);
local l__InstanceCache__5 = require(l__ReplicatedStorage__1.Modules.InstanceCache);
require(l__ReplicatedStorage__1.Modules.ParticleSource);
local u1 = l__Mince__4:Get("ScreenEffects");
local u2 = {
    TweenIn = TweenInfo.new(0.1),
    Item = l__InstanceCache__5.new(5, l__ReplicatedStorage__1.Assets.Models.PumpkinHead)
};
function QuadBezier(p3, p4, p5, p6)
    return p4:Lerp(p5, p3):Lerp(p5:Lerp(p6, p3), p3);
end;
function u2.Init(p7, p8) --[[ Line: 31 ]]
    -- upvalues: u2 (copy)
    local v9 = u2.Item:Get(p7.ExtrasFolder);
    v9.Position = Vector3.new(-0, -100, -0);
    p8.Pumpkin = v9;
    p7.Sounds[`Attack{math.random(1, 2)}`]:Play();
    p7.Animations.TakeOffHead:Play(0.2);
    p8.P0 = p7.Character.PumpkinHead.Position;
    p8.P2 = p8.Position + p7.Height * Vector3.new(0, 1, 0);
    p8.P1 = p8.P0:Lerp(p8.P2, 0.5) + Vector3.new(0, 30, 0);
    p8.Rotation = CFrame.new(p8.P0, p8.P2).Rotation;
end;
function u2.Spawn(p10, p11) --[[ Line: 49 ]]
    -- upvalues: l__Effect__3 (copy), l__ReplicatedStorage__1 (copy), u1 (copy), l__TweenService__2 (copy), u2 (copy)
    local l__Position__6 = p11.Position;
    l__Effect__3.new(l__ReplicatedStorage__1.Assets.Particles.Boss.MainImpact2, l__Position__6):PlayThenDestroy();
    u1.PlayAt("Impact", 30, l__Position__6);
    p10.Sounds.Impact1.PlaybackSpeed = 0.9 + math.random() * 0.2;
    p10.Sounds.Impact1:Play();
    p11.Pumpkin.Position = Vector3.new(-0, -100, -0);
    task.wait(0.5);
    l__TweenService__2:Create(p10.Character.PumpkinHead, u2.TweenIn, {
        Transparency = 0
    }):Play();
end;
function u2.Progress(p12, p13, p14) --[[ Line: 66 ]]
    local v15 = 0.5 / p13.TimeUntilImpact;
    local v16 = math.max(0, p14 - v15) / (1 - v15);
    if v16 == 0 then
    else
        p12.Character.PumpkinHead.Transparency = 1;
        local v17 = QuadBezier(v16, p13.P0, p13.P1, p13.P2);
        local v18 = CFrame.new(v17) * p13.Rotation;
        p13.Pumpkin.CFrame = v18;
    end;
end;
return u2;
