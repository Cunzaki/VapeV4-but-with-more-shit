-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Enemy.NewEnemies.ClientEnemy.Impacts.SuperJump
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
game:GetService("Debris");
local l__Effect__3 = require(l__ReplicatedStorage__1.Modules.Effect);
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.ModelTweenOG);
require(l__ReplicatedStorage__1.Modules.InstanceCache);
require(l__ReplicatedStorage__1.Modules.ParticleSource);
local u1 = l__Mince__4:Get("ScreenEffects");
return {
    Init = function(p2, p3) --[[ Name: Init, Line 17 ]]
        p2.DontAutoMove = true;
        p2:StopTrack("Walk");
        p2:StopTrack("Run");
        p2.Animations.JumpSlam:Play(0.2, 1, (p2.Animations.JumpSlam.Length - 1) / p3.TimeUntilImpact);
        p2.Sounds.Jump:Play();
    end,
    Spawn = function(p4, p5) --[[ Name: Spawn, Line 27 ]]
        -- upvalues: l__Effect__3 (copy), l__ReplicatedStorage__1 (copy), u1 (copy), l__TweenService__2 (copy)
        local v6 = TweenInfo.new(0.9);
        local l__Position__5 = p5.Position;
        p4.DontAutoMove = false;
        l__Effect__3.new(l__ReplicatedStorage__1.Assets.Particles.Boss.MassiveImpact, l__Position__5):PlayThenDestroy();
        u1.PlayAt("Impact", 250, l__Position__5);
        p4.Sounds.Impact3.PlaybackSpeed = 0.9 + math.random() * 0.2;
        p4.Sounds.Impact3:Play();
        local u7 = l__ReplicatedStorage__1.Assets.Models.ShockwaveSmall:Clone();
        u7.Position = l__Position__5;
        u7.Parent = game.Workspace;
        local v8 = l__TweenService__2:Create(u7, v6, {
            Transparency = 1,
            Size = u7.Size * 300
        });
        v8:Play();
        v8.Completed:Connect(function() --[[ Line: 46 ]]
            -- upvalues: u7 (copy)
            u7:Destroy();
        end);
    end,
    Progress = function(p9, _, p10) --[[ Name: Progress, Line 51 ]]
        -- upvalues: l__TweenService__2 (copy)
        local v11 = 1 - math.abs(p10 - 0.5) * 2;
        local v12;
        if p10 - 0.5 > 0 then
            v12 = l__TweenService__2:GetValue(v11, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
        else
            v12 = l__TweenService__2:GetValue(v11, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
        end;
        local l__Rotation__6 = p9.TargetCFrame.Rotation;
        local v13 = CFrame.new(p9.TargetCFrame.Position + Vector3.new(0, 60, 0) * v12) * l__Rotation__6;
        p9.HitCFrame = v13;
        p9.ThisRoot:PivotTo(v13);
    end
};
