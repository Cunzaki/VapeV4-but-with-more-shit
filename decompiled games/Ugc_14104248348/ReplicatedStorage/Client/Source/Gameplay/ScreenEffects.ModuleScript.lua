-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.ScreenEffects
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__LocalPlayer__3 = game:GetService("Players").LocalPlayer;
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__CameraShake__5 = require(l__ReplicatedStorage__1.Modules.CameraShake);
local u1 = l__Mince__4:Get("Effects");
local u2 = l__Mince__4:Get("MinigameHandler");
return {
    PlayUI = function(_) --[[ Name: PlayUI, Line 15 ]] end,
    PlayAndApplyManualForce = function(p3, p4) --[[ Name: PlayAndApplyManualForce, Line 19 ]]
        -- upvalues: l__ReplicatedStorage__1 (copy), l__CameraShake__5 (copy)
        local v5 = l__ReplicatedStorage__1.Assets.ScreenEffects:FindFirstChild(p3);
        if v5 then
            local _ = game.Workspace.CurrentCamera;
            local v6 = v5:GetAttributes();
            v6.AMult = v6.AMult * 1;
            l__CameraShake__5.Create(v6, p4);
            return v6;
        end;
        warn((`There is no ScreenEffect by the name of '{p3}'.`));
    end,
    Play = function(p7, p8) --[[ Name: Play, Line 34 ]]
        -- upvalues: u1 (copy), u2 (copy), l__ReplicatedStorage__1 (copy), l__CameraShake__5 (copy)
        if u1.CameraEffectDisabled() then
        elseif p7 == "Punch" and u2.WithinMinigame then
        else
            local v9 = l__ReplicatedStorage__1.Assets.ScreenEffects:FindFirstChild(p7);
            if v9 then
                local l__CurrentCamera__6 = game.Workspace.CurrentCamera;
                local v10 = v9:GetAttributes();
                v10.AMult = v10.AMult * (p8 or 1);
                l__CameraShake__5.Create(v10, function(p11) --[[ Line: 50 ]]
                    -- upvalues: l__CurrentCamera__6 (copy)
                    local v12 = l__CurrentCamera__6;
                    v12.CFrame = v12.CFrame * p11;
                end);
                return v10;
            end;
            warn((`There is no ScreenEffect by the name of '{p7}'.`));
        end;
    end,
    PlayAt = function(p13, u14, u15, p16) --[[ Name: PlayAt, Line 57 ]]
        -- upvalues: u1 (copy), l__ReplicatedStorage__1 (copy), l__LocalPlayer__3 (copy), l__CameraShake__5 (copy)
        if u1.CameraEffectDisabled() then
        else
            local v17 = p16 or l__ReplicatedStorage__1.Assets.ScreenEffects:FindFirstChild(p13);
            if v17 then
                local u18 = l__LocalPlayer__3.Character:FindFirstChild("HumanoidRootPart");
                if u18 then
                    local l__Magnitude__7 = (u18.Position - u15).Magnitude;
                    local l__CurrentCamera__8 = game.Workspace.CurrentCamera;
                    local u19 = v17:GetAttributes();
                    u19.AMult = math.clamp(1 - l__Magnitude__7 / u14, 0, 1);
                    l__CameraShake__5.Create(u19, function(p20) --[[ Line: 79 ]]
                        -- upvalues: u18 (copy), u15 (copy), u19 (copy), u14 (copy), l__CurrentCamera__8 (copy)
                        u19.AMult = math.clamp(1 - (u18.Position - u15).Magnitude / u14, 0, 1);
                        local v21 = l__CurrentCamera__8;
                        v21.CFrame = v21.CFrame * p20;
                    end);
                else
                    warn("There is currently no HumanoidRootPart atm.");
                end;
            else
                warn((`There is no ScreenEffect by the name of '{p13}'.`));
            end;
        end;
    end,
    PlayFrom = function(p22, u23, u24) --[[ Name: PlayFrom, Line 86 ]]
        -- upvalues: u1 (copy), l__ReplicatedStorage__1 (copy), l__LocalPlayer__3 (copy), l__CameraShake__5 (copy), l__RunService__2 (copy)
        if u1.CameraEffectDisabled() then
        else
            local v25 = l__ReplicatedStorage__1.Assets.ScreenEffects:FindFirstChild(p22);
            if v25 then
                local u26 = l__LocalPlayer__3.Character:FindFirstChild("HumanoidRootPart");
                if u26 then
                    local l__CurrentCamera__9 = game.Workspace.CurrentCamera;
                    local u27 = v25:GetAttributes();
                    l__CameraShake__5.Create(u27, function(p28) --[[ Line: 105 ]]
                        -- upvalues: l__CurrentCamera__9 (copy)
                        local v29 = l__CurrentCamera__9;
                        v29.CFrame = v29.CFrame * p28;
                    end);
                    local u30 = nil;
                    u30 = l__RunService__2.RenderStepped:Connect(function() --[[ Line: 110 ]]
                        -- upvalues: u26 (copy), u24 (copy), u27 (copy), u23 (copy), u30 (ref)
                        u27.AMult = math.clamp(1 - (u26.Position - u24.Position).Magnitude / u23, 0, 1);
                        if u27.HasFinished then
                            u30:Disconnect();
                        end;
                    end);
                    u24.Destroying:Connect(function() --[[ Line: 119 ]]
                        -- upvalues: u30 (ref)
                        u30:Disconnect();
                    end);
                else
                    warn("There is currently no HumanoidRootPart atm.");
                end;
            else
                warn((`There is no ScreenEffect by the name of '{p22}'.`));
            end;
        end;
    end
};
