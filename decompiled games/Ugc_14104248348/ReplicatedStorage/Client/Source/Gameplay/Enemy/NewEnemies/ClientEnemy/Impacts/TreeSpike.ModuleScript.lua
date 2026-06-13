-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Enemy.NewEnemies.ClientEnemy.Impacts.TreeSpike
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("Debris");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Effect__3 = require(l__ReplicatedStorage__1.Modules.Effect);
local l__ModelTweenOG__4 = require(l__ReplicatedStorage__1.Modules.ModelTweenOG);
local l__InstanceCache__5 = require(l__ReplicatedStorage__1.Modules.InstanceCache);
local u1 = l__Mince__2:Get("ScreenEffects");
local u2 = {
    RiseTween = TweenInfo.new(0.1),
    LowerTween = TweenInfo.new(0.5),
    Item = l__InstanceCache__5.new(5, l__ReplicatedStorage__1.Assets.Models.TreeSpike),
    Init = function(_, _) --[[ Name: Init, Line 19 ]] end
};
function u2.Spawn(p3, p4) --[[ Line: 22 ]]
    -- upvalues: u2 (copy), l__ModelTweenOG__4 (copy), u1 (copy), l__Effect__3 (copy)
    local l__Position__6 = p4.Position;
    local u5 = u2.Item:Get(p3.ExtrasFolder);
    u5.Position = p4.Position - u5.Size.Y * Vector3.new(0, 1, 0);
    local v6 = math.random(0, 360);
    u5.Orientation = Vector3.new(0, v6, 0);
    local v7 = CFrame.new(l__Position__6 + u5.Size * Vector3.new(0, 1, 0) * 0.12);
    local u8 = CFrame.new(l__Position__6 - u5.Size * Vector3.new(0, 1, 0) * 0.8);
    task.wait();
    local l__Rotation__7 = u5.CFrame.Rotation;
    u5.Appear.PlaybackSpeed = 0.8 + 0.4 * math.random();
    u5.Appear:Play();
    local v9 = l__ModelTweenOG__4.new(u5, u2.RiseTween, v7 * l__Rotation__7);
    v9.Play();
    v9.Finished:Connect(function() --[[ Line: 40 ]]
        -- upvalues: u1 (ref), l__Position__6 (copy), l__Effect__3 (ref), l__ModelTweenOG__4 (ref), u5 (copy), u2 (ref), u8 (copy), l__Rotation__7 (copy)
        u1.PlayAt("Impact", 14, l__Position__6);
        l__Effect__3.new(game.ReplicatedStorage.Assets.Particles.Boss.GroundImpact, l__Position__6):PlayThenDestroy();
        task.wait(0.5);
        local v10 = l__ModelTweenOG__4.new(u5, u2.LowerTween, u8 * l__Rotation__7);
        v10.Play();
        v10.Finished:Connect(function() --[[ Line: 50 ]]
            -- upvalues: u5 (ref), u2 (ref)
            u5.Position = Vector3.new(-0, -100, -0);
            u2.Item:Free(u5);
        end);
    end);
    v9.Tick:Connect(function() --[[ Line: 55 ]]
        -- upvalues: u5 (copy)
        u5.CFrame = u5.CFrame:ToWorldSpace(CFrame.new(math.random() * 1 - 0.5, 0, math.random() * 1 - 0.5));
    end);
end;
return u2;
