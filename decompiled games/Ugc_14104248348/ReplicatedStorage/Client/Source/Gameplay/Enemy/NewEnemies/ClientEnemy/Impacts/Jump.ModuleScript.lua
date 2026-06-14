-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Enemy.NewEnemies.ClientEnemy.Impacts.Jump
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
local l__Effect__2 = require(l__ReplicatedStorage__1.Modules.Effect);
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.ModelTweenOG);
require(l__ReplicatedStorage__1.Modules.InstanceCache);
require(l__ReplicatedStorage__1.Modules.ParticleSource);
local u1 = l__Mince__3:Get("ScreenEffects");
return {
    Init = function(p2, p3) --[[ Name: Init, Line 17 ]]
        p2.Animations.JumpSlam:Play(0.2, 1, (p2.Animations.JumpSlam.Length - 1) / p3.TimeUntilImpact);
        p2.Sounds.Jump2:Play();
    end,
    Spawn = function(p4, p5) --[[ Name: Spawn, Line 23 ]]
        -- upvalues: l__Effect__2 (copy), l__ReplicatedStorage__1 (copy), u1 (copy)
        local l__Position__4 = p5.Position;
        l__Effect__2.new(l__ReplicatedStorage__1.Assets.Particles.Boss.MainImpact2, l__Position__4):PlayThenDestroy();
        u1.PlayAt("Impact", 30, l__Position__4);
        p4.Sounds.Impact1.PlaybackSpeed = 0.9 + math.random() * 0.2;
        p4.Sounds.Impact1:Play();
    end
};
