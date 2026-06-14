-- Decompiled from: StarterGui.PV2Piano.PianoController.Note
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Parent__1 = script.Parent;
local u1 = {};
u1.__index = u1;
local u2 = Instance.new("SoundGroup");
u2.Volume = 1;
u2.Parent = game:GetService("SoundService");
local l__Tween__2 = require(l__Parent__1.Tween);
local l__SoundCache__3 = require(script.SoundCache);
function u1.new(p3, p4, p5, p6, p7, p8, p9) --[[ Line: 13 ]]
    -- upvalues: l__SoundCache__3 (copy), u2 (copy), u1 (copy), l__Tween__2 (copy)
    local v10 = p6 + (p8.Transposition or 0);
    local v11, v12, v13;
    if p8.CustomFunction then
        v11, v12, v13 = p8.CustomFunction(v10);
    else
        if v10 > 61 then
            v13 = 1.059463 ^ (v10 - 61);
        else
            v13 = v10 >= 1 and 1 or 1.059463 ^ (-(1 - v10));
        end;
        local v14 = math.clamp(v10, 1, 61);
        local v15 = (v14 - 1) % 12 + 1;
        v12 = (math.ceil(v14 / 12) - 1) * 16 + (1 - v15 % 2) * 8;
        v11 = math.ceil(v15 / 2);
    end;
    local v16 = l__SoundCache__3:GetSound();
    v16.SoundId = "rbxassetid://" .. p8.AssetIds[v11];
    v16.Volume = p7 * (p8.VolumeModifier or 1);
    v16.TimePosition = v12 + (p8.Offset or 0.04);
    v16.Pitch = v13;
    v16.Parent = u2;
    local v17 = {};
    setmetatable(v17, u1);
    v17.Source = p3;
    v17.Origin = p4 or u2;
    v17.Index = p5;
    v17.Volume = v16.Volume;
    v17.Sustained = p9;
    v17.Sound = v16;
    v17.State = "Inactive";
    v17.Lifetime = 0;
    v17.MaxLifetime = p8.MaxLifetime;
    v17.Tween = l__Tween__2.new(v16, TweenInfo.new(p8.Fadeout), {
        Volume = 0
    });
    return v17;
end;
function u1.Play(p18) --[[ Line: 51 ]]
    if p18.State == "Inactive" then
        p18.State = "Active";
        p18.Sound:Play();
    else
        warn("[Note]: Attempted to Play non-Inactive note");
    end;
end;
function u1.Fade(u19) --[[ Line: 60 ]]
    if u19.State == "Active" then
        u19.State = "Fading";
        task.spawn(function() --[[ Line: 66 ]]
            -- upvalues: u19 (copy)
            u19.Tween:Play();
            u19.Tween.Completed:Wait();
            if u19.State ~= "Destroying" then
                u19:Destroy();
            end;
        end);
    else
        warn("[Note]: Attempted to Fade non-Active note");
    end;
end;
function u1.Destroy(p20) --[[ Line: 75 ]]
    -- upvalues: l__SoundCache__3 (copy)
    if p20.State == "Destroying" then
    else
        p20.State = "Destroying";
        p20.Sound:Stop();
        p20.Tween:Cancel();
        p20.Tween:Destroy();
        l__SoundCache__3:ReturnSound(p20.Sound);
    end;
end;
return u1;
