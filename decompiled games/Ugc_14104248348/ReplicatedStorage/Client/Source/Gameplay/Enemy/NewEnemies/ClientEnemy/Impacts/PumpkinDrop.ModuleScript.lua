-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Enemy.NewEnemies.ClientEnemy.Impacts.PumpkinDrop
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("Debris");
local l__Effect__2 = require(l__ReplicatedStorage__1.Modules.Effect);
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.ModelTweenOG);
local l__InstanceCache__4 = require(l__ReplicatedStorage__1.Modules.InstanceCache);
require(l__ReplicatedStorage__1.Modules.ParticleSource);
local u1 = l__Mince__3:Get("ScreenEffects");
local u2 = {
    RiseTween = TweenInfo.new(0.1),
    LowerTween = TweenInfo.new(0.5),
    Item = l__InstanceCache__4.new(5, l__ReplicatedStorage__1.Assets.Models.Pumpkin)
};
function u2.Init(p3, p4) --[[ Line: 19 ]]
    -- upvalues: u2 (copy)
    local v5 = u2.Item:Get(p3.ExtrasFolder);
    v5.Position = Vector3.new(-0, -100, -0);
    local v6 = math.random();
    local v7 = math.random();
    p4.Seed = Vector3.new(v6, v7, math.random());
    p4.Pumpkin = v5;
    p4.Top = p4.Position + Vector3.new(0, 70, 0);
end;
function u2.Spawn(_, p8) --[[ Line: 30 ]]
    -- upvalues: u1 (copy), l__Effect__2 (copy), l__ReplicatedStorage__1 (copy), u2 (copy)
    u1.PlayAt("Impact", 14, p8.Position);
    l__Effect__2.new(l__ReplicatedStorage__1.Assets.Particles.Boss.DirtImpact, p8.Position):PlayThenDestroy();
    p8.Pumpkin.Appear.PlaybackSpeed = 0.8 + 0.4 * math.random();
    p8.Pumpkin.Appear:Play();
    p8.Pumpkin.Position = Vector3.new(-0, -100, -0);
    u2.Item:Free(p8.Pumpkin);
end;
function u2.Progress(_, p9, p10) --[[ Line: 43 ]]
    local v11 = CFrame.new(p9.Top:Lerp(p9.Position, p10)) * CFrame.Angles(-((p9.Seed.X + p10 * 3.141592653589793 * 2 * 1) % 6.283185307179586), (p9.Seed.Y + p10 * 3.141592653589793 * 2 * 1) % 6.283185307179586, -((p9.Seed.Z + p10 * 3.141592653589793 * 2 * 1) % 6.283185307179586));
    p9.Pumpkin.CFrame = v11;
end;
return u2;
