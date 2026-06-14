-- Decompiled from: ReplicatedStorage.Modules.Effect
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local u1 = {};
u1.__index = u1;
function u1.new(p2, p3) --[[ Line: 8 ]]
    -- upvalues: u1 (copy)
    local v4 = p2:GetAttributes();
    local v5 = setmetatable(v4, u1);
    v5:SourceAttachment(p3);
    v5:CreateEffect(p2);
    return v5;
end;
function u1.Destroy(p6) --[[ Line: 15 ]]
    if p6.ThisEffect then
        p6.ThisEffect.Source:Destroy();
        p6.ThisEffect = nil;
    end;
    if p6.DestroyableAttach then
        p6.DestroyableAttach:Destroy();
    end;
end;
function u1.Active(p7) --[[ Line: 28 ]]
    if not p7.ThisEffect then
        return false;
    end;
    local v8 = false;
    for _, v9 in p7.ThisEffect.EffectEnabledStack do
        if v9 then
            return true;
        end;
    end;
    return v8;
end;
function u1.EndingCheck(p10) --[[ Line: 42 ]]
    if p10.ThisEffect then
        for _, v11 in p10.ThisEffect.EffectEnabledStack do
            if not v11 then
                return;
            end;
        end;
        p10.ThisEffect.Source:Destroy();
        p10.ThisEffect = nil;
        if p10.DestroyAfter then
            p10:Destroy();
        end;
    end;
end;
function u1.StartInstance(p12, p13, p14) --[[ Line: 57 ]]
    -- upvalues: l__TweenService__1 (copy)
    if p13:IsA("ParticleEmitter") or (p13:IsA("Light") or p13:IsA("Beam")) then
        p13.Enabled = true;
        if p13:IsA("Light") and not p14.IgnoreTween then
            p14.Tween = p14.Tween or TweenInfo.new((p14.EmitDuration or 0) * 1 / 8, Enum.EasingStyle.Sine);
            p13.Brightness = 0;
            l__TweenService__1:Create(p13, p14.Tween, {
                Brightness = 1
            }):Play();
        end;
    elseif p13:IsA("Sound") then
        p13.Playing = true;
        p13.PlaybackSpeed = 0.8 + 0.4 * math.random();
    end;
    if p12.ThisEffect then
        p12.ThisEffect.EffectEnabledStack[p13] = false;
        p12:EndingCheck();
    end;
end;
function u1.EndInstance(p15, p16, p17) --[[ Line: 79 ]]
    -- upvalues: l__TweenService__1 (copy)
    if p16:IsA("ParticleEmitter") or (p16:IsA("Light") or p16:IsA("Beam")) then
        p16.Enabled = false;
        if p16:IsA("Light") and not p17.IgnoreTween then
            p16.Brightness = 1;
            l__TweenService__1:Create(p16, p17.Tween, {
                Brightness = 0
            }):Play();
        elseif p16:IsA("Beam") and (not p17.IgnoreTween and p17.Value) then
            p17.Value.Value = 1;
            l__TweenService__1:Create(p17.Value, p17.Tween, {
                Value = 0
            }):Play();
        end;
    elseif p16:IsA("Sound") then
        p16.Playing = false;
    end;
    p15.ThisEffect.EffectEnabledStack[p16] = true;
    p15:EndingCheck();
end;
function u1.PlayThenDestroy(p18, ...) --[[ Line: 101 ]]
    p18.DestroyAfter = true;
    p18:Play(...);
end;
function u1.Play(u19, ...) --[[ Line: 106 ]]
    if u19.ThisEffect then
        if u19:Active() then
            warn("Cannot play effect whilst playing");
            return;
        end;
    else
        error("No Effect to play!");
    end;
    for _, u20 in u19.ThisEffect.Source:GetDescendants() do
        if not (u20:IsA("Attachment") or u20:IsA("BasePart")) then
            local u21 = u20:GetAttributes();
            if u19.ThisEffect.EffectEnabledStack[u20] ~= nil then
                local u22 = ...;
                task.delay(u21.EmitDelay or 0, function() --[[ Line: 122 ]]
                    -- upvalues: u21 (copy), u22 (copy), u20 (copy), u19 (copy)
                    local v23 = u21.EmitCount or u22 or 0;
                    if v23 > 0 and u20:IsA("ParticleEmitter") then
                        u20:Emit(v23);
                    end;
                    u19:StartInstance(u20, u21);
                    if u20:IsA("Sound") then
                        task.wait(u20.TimeLength);
                    else
                        task.wait(u21.EmitDuration or 0);
                        task.wait();
                    end;
                    u19:EndInstance(u20, u21);
                end);
            end;
        end;
    end;
    u19:EndingCheck();
end;
function u1.CreateEffect(p24, p25) --[[ Line: 145 ]]
    if not p24.Attach then
        error("There is no attachment!");
    end;
    local v26 = typeof(p25) == "Instance" and p25:IsA("Attachment") or p25:IsA("BasePart");
    assert(v26, "Effect couild not be loaded!");
    local v27 = p25:Clone();
    local v28 = {};
    for _, v29 in v27:GetDescendants() do
        if v29:IsA("ParticleEmitter") or (v29:IsA("Light") or v29:IsA("Beam")) then
            v29.Enabled = false;
            v28[v29] = false;
        elseif v29:IsA("Sound") then
            v29.Playing = false;
            v28[v29] = false;
        end;
    end;
    v27.Parent = p24.Attach;
    if v27:IsA("BasePart") then
        if v27.Anchored then
            v27.Position = p24.Attach.Position;
        else
            local v30 = Instance.new("Weld");
            v30.Name = "ConnectionWeld";
            v30.Part0 = v27;
            v30.Part1 = p24.Attach;
            v30.Parent = v27;
        end;
    end;
    p24.ThisEffect = {
        EffectEnabledStack = v28,
        Source = v27
    };
end;
function u1.SourceAttachment(p31, p32) --[[ Line: 184 ]]
    if typeof(p32) == "CFrame" then
        local v33 = Instance.new("Part");
        v33.Name = "ParticleSource";
        v33.Transparency = 1;
        v33.Anchored = true;
        v33.CanCollide = false;
        v33.CanQuery = false;
        v33.CanTouch = false;
        v33.Size = Vector3.new(0.2, 0.2, 0.2);
        v33.CFrame = p32;
        v33.Parent = game.Workspace;
        p31.DestroyableAttach = v33;
        p31.Attach = v33;
    elseif typeof(p32) == "Vector3" then
        local v34 = Instance.new("Part");
        v34.Name = "ParticleSource";
        v34.Transparency = 1;
        v34.Anchored = true;
        v34.CanCollide = false;
        v34.CanQuery = false;
        v34.CanTouch = false;
        v34.Size = Vector3.new(0.2, 0.2, 0.2);
        v34.Position = p32;
        v34.Parent = game.Workspace;
        p31.DestroyableAttach = v34;
        p31.Attach = v34;
    else
        if typeof(p32) == "Instance" and p32:IsA("Attachment") or p32:IsA("BasePart") then
            p31.Attach = p32;
        end;
    end;
end;
return u1;
