-- Decompiled from: StarterPlayer.StarterPlayerScripts.Importantes.Spectate.SpectateService
-- Class: ModuleScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local u1 = {};
local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local u2 = l__LocalPlayer__1:GetMouse();
game:GetService("UserInputService");
local l__RunService__2 = game:GetService("RunService");
local l__SpectateEvent__3 = game:GetService("ReplicatedStorage"):WaitForChild("SpectateEvent");
local l__Spectate__4 = workspace:WaitForChild("Terrain"):WaitForChild("Spectate");
local l__Beam__5 = script:WaitForChild("Beam");
local l__Dot__6 = script:WaitForChild("Dot");
local u3 = {};
local u4 = 0;
function u1.SendServerData() --[[ Line: 25 ]]
    -- upvalues: l__LocalPlayer__1 (copy), u4 (ref), u2 (copy), l__SpectateEvent__3 (copy)
    local l__CurrentCamera__7 = workspace.CurrentCamera;
    if l__CurrentCamera__7 == nil then
    else
        local l__Character__8 = l__LocalPlayer__1.Character;
        if l__Character__8 == nil then
        else
            local v5 = l__Character__8:FindFirstChild("HumanoidRootPart");
            if v5 == nil then
            else
                local v6 = os.clock();
                if v6 - u4 <= 0.006060606060606061 then
                else
                    u4 = v6;
                    l__SpectateEvent__3:FireServer("data", {
                        Camera = l__CurrentCamera__7.CFrame,
                        Focus = l__CurrentCamera__7.Focus,
                        Mouse = u2.Hit.Position,
                        HRP = v5.CFrame
                    });
                end;
            end;
        end;
    end;
end;
function u1.EndSpectating() --[[ Line: 49 ]]
    -- upvalues: l__LocalPlayer__1 (copy), l__RunService__2 (copy), u3 (copy)
    local l__CurrentCamera__9 = workspace.CurrentCamera;
    if l__CurrentCamera__9 ~= nil then
        local l__Character__10 = l__LocalPlayer__1.Character;
        local v7;
        if l__Character__10 == nil then
            v7 = nil;
        else
            v7 = l__Character__10:FindFirstChildOfClass("Humanoid");
        end;
        l__CurrentCamera__9.CameraSubject = v7;
    end;
    l__RunService__2:UnbindFromRenderStep("SPECTATE_BIND");
    for _, v8 in u3 do
        v8:Destroy();
    end;
end;
function u1.StartTracking() --[[ Line: 60 ]]
    -- upvalues: u1 (copy), l__RunService__2 (copy)
    u1.EndSpectating();
    local l__CurrentCamera__11 = workspace.CurrentCamera;
    if l__CurrentCamera__11 ~= nil then
        l__CurrentCamera__11.CameraType = Enum.CameraType.Custom;
    end;
    l__RunService__2:BindToRenderStep("SPECTATE_BIND", Enum.RenderPriority.Camera.Value + 3, function() --[[ Line: 65 ]]
        -- upvalues: u1 (ref)
        u1.SendServerData();
    end);
end;
function u1.SpectatePlayer(u9) --[[ Line: 70 ]]
    -- upvalues: l__LocalPlayer__1 (copy), l__Spectate__4 (copy), u1 (copy), l__Beam__5 (copy), l__Dot__6 (copy), u3 (copy), l__RunService__2 (copy)
    if u9 == l__LocalPlayer__1 then
    else
        local l__CurrentCamera__12 = workspace.CurrentCamera;
        if l__CurrentCamera__12 == nil then
            warn("[SpectateService]: No se puede Espectear a un jugador sin una camara");
        else
            local v10 = l__Spectate__4:FindFirstChild((tostring(u9.UserId)));
            if v10 == nil then
                warn("[SpectateService]: No fue posible encontrar los datos de ese jugador");
            else
                local v11 = v10:FindFirstChild("Mouse");
                if v11 == nil then
                else
                    local u12 = v10:FindFirstChild("Camera");
                    if u12 == nil then
                    else
                        local u13 = v10:FindFirstChild("Focus");
                        if u13 == nil then
                        else
                            local u14 = v10:FindFirstChild("HRP");
                            if u14 == nil then
                            else
                                u1.EndSpectating();
                                local v15 = l__Beam__5:Clone();
                                local v16 = l__Beam__5:Clone();
                                local v17 = l__Dot__6:Clone();
                                v17.Parent = v11;
                                v15.Parent = l__CurrentCamera__12;
                                v16.Parent = l__CurrentCamera__12;
                                v15.Attachment0 = u13;
                                v15.Attachment1 = v11;
                                v16.Attachment0 = u13;
                                v16.Attachment1 = u12;
                                v17.Adornee = v11;
                                table.insert(u3, v15);
                                table.insert(u3, v16);
                                table.insert(u3, v17);
                                local l__Character__13 = u9.Character;
                                if l__Character__13 ~= nil then
                                    l__Character__13:FindFirstChildOfClass("Humanoid");
                                end;
                                l__RunService__2:BindToRenderStep("SPECTATE_BIND", Enum.RenderPriority.Camera.Value + 3, function() --[[ Line: 112 ]]
                                    -- upvalues: l__CurrentCamera__12 (copy), u12 (copy), u13 (copy), u9 (copy), u14 (copy)
                                    l__CurrentCamera__12.CameraType = Enum.CameraType.Scriptable;
                                    l__CurrentCamera__12.CFrame = u12.WorldCFrame;
                                    l__CurrentCamera__12.Focus = u13.WorldCFrame;
                                    local l__Character__14 = u9.Character;
                                    if l__Character__14 ~= nil then
                                        local v18 = l__Character__14:FindFirstChild("HumanoidRootPart");
                                        if v18 ~= nil then
                                            v18.CFrame = u14.WorldCFrame;
                                        end;
                                    end;
                                end);
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
return u1;
