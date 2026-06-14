-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Enemy.NewEnemies.ClientEnemy.Impacts.AirJump
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
l__Mince__3:Get("SoundHandler");
local v2 = {
    PreTrigger = 0,
    ProOffset = 0.2
};
function QuadBezier(p3, p4, p5, p6)
    return p4:Lerp(p5, p3):Lerp(p5:Lerp(p6, p3), p3);
end;
function v2.Init(p7, p8) --[[ Line: 27 ]]
    p7.DontAutoMove = true;
    p7:StopTrack("Walk");
    p7:StopTrack("Run");
    task.wait();
    p8.P0 = p7.TargetCFrame.Position;
    p8.P2 = p8.Position + p7.Height * Vector3.new(0, 1, 0);
    p8.P1 = p8.P0:Lerp(p8.P2, 0.5) + Vector3.new(0, 30, 0);
    p8.Rotation = CFrame.new(p8.P0, p8.P2).Rotation;
    p7.Animations.JumpSlam:Play(0.2, 1, (p7.Animations.JumpSlam.Length - 1) / p8.TimeUntilImpact);
    p7.Sounds.Jump:Play();
end;
function v2.Spawn(p9, p10) --[[ Line: 53 ]]
    -- upvalues: l__Effect__2 (copy), l__ReplicatedStorage__1 (copy), u1 (copy)
    local l__Position__4 = p10.Position;
    p9.DontAutoMove = false;
    l__Effect__2.new(l__ReplicatedStorage__1.Assets.Particles.Boss.MainImpact2, l__Position__4):PlayThenDestroy();
    u1.PlayAt("Impact", 30, l__Position__4);
    p9.Sounds.Impact3.PlaybackSpeed = 0.9 + math.random() * 0.2;
    p9.Sounds.Impact3:Play();
end;
function v2.Progress(p11, p12, p13) --[[ Line: 64 ]]
    local _ = p11.TargetCFrame.Rotation;
    local v14 = QuadBezier(p13, p12.P0, p12.P1, p12.P2);
    local v15 = CFrame.new(v14) * p12.Rotation;
    p11.HitCFrame = v15;
    p11.ThisRoot:PivotTo(v15);
end;
return v2;
