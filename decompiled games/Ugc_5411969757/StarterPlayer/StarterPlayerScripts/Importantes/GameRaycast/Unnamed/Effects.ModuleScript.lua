-- Decompiled from: StarterPlayer.StarterPlayerScripts.Importantes.GameRaycast..Effects
-- Class: ModuleScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local u1 = {
    Flesh = script.Sounds.FleshHit,
    Concrete = script.Sounds.ConcreteHit,
    Metal = script.Sounds.MetalHit,
    CorrodedMetal = script.Sounds.MetalHit,
    Glass = script.Sounds.GlassHit
};
local l__TweenService__1 = game:GetService("TweenService");
game:GetService("RunService");
local l__Debris__2 = game:GetService("Debris");
local v16 = {
    CreateBeam = function(_, p2, p3, p4, _) --[[ Name: CreateBeam, Line 31 ]]
        -- upvalues: l__Debris__2 (copy)
        local v5 = Instance.new("Attachment", workspace.Terrain);
        local v6 = Instance.new("Attachment", workspace.Terrain);
        local v7 = p2:Clone();
        v7.Attachment0 = v5;
        v7.Attachment1 = v6;
        v7.Parent = workspace.Terrain;
        v5.Position = p3;
        local _ = (p4 - p3).Magnitude;
        v6.Position = p4;
        l__Debris__2:AddItem(v5, 0.06);
        l__Debris__2:AddItem(v6, 0.06);
        l__Debris__2:AddItem(v7, 0.06);
    end,
    CreateFireLight = function(_, p8) --[[ Name: CreateFireLight, Line 76 ]]
        -- upvalues: l__TweenService__1 (copy), l__Debris__2 (copy)
        local v9 = p8:Clone();
        v9.Parent = p8.Parent;
        v9.Enabled = true;
        l__TweenService__1:Create(v9, TweenInfo.new(0.3), {
            Range = 0,
            Brightness = 0
        }):Play();
        l__Debris__2:AddItem(v9, 0.3);
    end,
    CreateBulletImpact = function(_, p10, p11, p12) --[[ Name: CreateBulletImpact, Line 95 ]]
        -- upvalues: u1 (copy), l__Debris__2 (copy)
        local v13 = Instance.new("Attachment", workspace.Terrain);
        v13.Position = p10;
        local v14 = (p12 and script.Particles.HumanoidImpactParticle or script.Particles.PartImpactParticle):Clone();
        v14.Parent = v13;
        v14:Emit(v14.Rate);
        local v15 = (u1[p12 and "Flesh" or p11.Name] or u1.Concrete):Clone();
        v15.PlaybackSpeed = 1 + (math.random() * 0.2 - 0.1);
        v15.Parent = v13;
        v15:Play();
        l__Debris__2:AddItem(v13, v14.Lifetime.Max);
    end
};
local u17 = { script.Hitboxes.HealBox1, script.Hitboxes.HealBox2, script.Hitboxes.HealBox3 };
function v16.CreateHealbox(_, p18, p19) --[[ Line: 118 ]]
    -- upvalues: u17 (copy), l__Debris__2 (copy)
    local v20 = u17[p19];
    for _, v21 in pairs(p18:GetChildren()) do
        if v21:IsA("BasePart") then
            local v22 = v20:Clone();
            v22.Parent = v21;
            v22.Adornee = v21;
            l__Debris__2:AddItem(v22, 0.1);
        end;
    end;
end;
function v16.PlayClonedSound(_, p23, p24) --[[ Line: 132 ]]
    -- upvalues: l__Debris__2 (copy)
    local v25 = p23:Clone();
    v25.Parent = p24 or p23.Parent;
    v25:Play();
    l__Debris__2:AddItem(v25, v25.TimeLength);
end;
function v16.HandleStandardFiredGunEffects(p26, p27, p28, p29, p30) --[[ Line: 140 ]]
    local l__Barrel__3 = p27.Barrel;
    l__Barrel__3.Fire:Emit(1);
    p26:CreateBeam(l__Barrel__3.Beam, l__Barrel__3.WorldPosition, p28.Position, p30);
    p26:CreateFireLight(l__Barrel__3.Light);
    p26:PlayClonedSound(p27.Fire);
    if p28.Instance and p30 >= 4 then
        p26:CreateBulletImpact(p28.Position, p28.Instance.Material, p29);
    end;
end;
function v16.PlayHitsound(p31) --[[ Line: 156 ]]
    p31:PlayClonedSound(script.Sounds.Hitsound, workspace);
end;
function v16.PlayKillsound(p32) --[[ Line: 163 ]]
    p32:PlayClonedSound(script.Sounds.Killsound, workspace);
end;
function v16.CreateHitbox(_, p33, p34) --[[ Line: 170 ]]
    -- upvalues: l__TweenService__1 (copy), l__Debris__2 (copy)
    local v35 = script.Hitboxes[p34 and "CriticalHitBox" or "HitBox"]:Clone();
    v35.Parent = p33;
    v35.Adornee = p33;
    l__TweenService__1:Create(v35, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Transparency = 1
    }):Play();
    l__Debris__2:AddItem(v35, 0.3);
end;
function v16.CreateKillMarker(_, p36) --[[ Line: 190 ]]
    -- upvalues: l__TweenService__1 (copy), l__Debris__2 (copy)
    local v37 = Instance.new("Attachment", workspace.Terrain);
    v37.WorldPosition = p36;
    local v38 = script.KillMarker:Clone();
    v38.Parent = v37;
    l__TweenService__1:Create(v38.ImageLabel, TweenInfo.new(0.8, Enum.EasingStyle.Quad), {
        ImageTransparency = 1,
        Size = UDim2.fromOffset(60, 60)
    }):Play();
    l__Debris__2:AddItem(v38, 0.8);
end;
return v16;
