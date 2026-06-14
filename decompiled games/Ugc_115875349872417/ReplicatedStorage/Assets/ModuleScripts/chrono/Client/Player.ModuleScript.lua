-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.chrono.Client.Player
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local l__Warn__1 = require(script.Parent.Parent.Shared.Warn);
local l__Events__2 = require(script.Parent.Parent.Shared.Events);
local l__Entity__3 = require(script.Parent.Parent.Shared.Entity);
local l__Holder__4 = require(script.Parent.Parent.Shared.Holder);
require(script.Parent.Parent.Shared.Types);
local l__Config__5 = require(script.Parent.Parent.Shared.Config);
local l__LocalPlayer__6 = game:GetService("Players").LocalPlayer;
l__Events__2.PlayerCharacterRegistered:Connect(function(u1, p2) --[[ Line: 12 ]]
    -- upvalues: l__Config__5 (copy), l__Entity__3 (copy), l__Warn__1 (copy), l__LocalPlayer__6 (copy)
    if l__Config__5._GetConfig("PLAYER_REPLICATION") == "AUTOMATIC" then
        if l__Entity__3.GetModelReplicationType(p2) == "CUSTOM" then
            if not p2.model then
                return l__Warn__1.high((`No model found for {u1}`));
            end;
            if p2.model then
                if not p2.model:IsA("Model") then
                    return l__Warn__1.high((`Model for {u1} is not a Model instance.`));
                end;
                u1.Character = p2.model;
            end;
            local function v6(p3, p4) --[[ Line: 31 ]]
                -- upvalues: l__Warn__1 (ref), u1 (copy), l__LocalPlayer__6 (ref)
                if p4 then
                    if p4:IsA("Model") then
                        l__LocalPlayer__6.Character = p3.model;
                        local l__CFrame__7 = workspace.CurrentCamera.CFrame;
                        workspace.CurrentCamera.CameraSubject = p3.model:FindFirstChildWhichIsA("Humanoid") or p3.model.PrimaryPart;
                        workspace.CurrentCamera.CFrame = l__CFrame__7;
                        for _, v5 in p4:QueryDescendants("LocalScript") do
                            if v5:IsA("LocalScript") and v5.Disabled == false then
                                v5.Disabled = true;
                                v5.Disabled = false;
                            end;
                        end;
                    else
                        l__Warn__1.high((`Model for {u1} is not a Model instance.`));
                    end;
                end;
            end;
            if l__LocalPlayer__6 == u1 then
                l__Entity__3.GetEvent(p2, "ModelChanged"):Connect(v6);
                v6(p2, p2.model);
            end;
        end;
    end;
end);
local l__Death__8 = script.Parent.Parent.Shared.Remotes.Death;
l__Config__5._WaitForLock(function() --[[ Line: 58 ]]
    -- upvalues: l__Config__5 (copy), l__Events__2 (copy), l__Death__8 (copy), l__Entity__3 (copy)
    if l__Config__5._GetConfig("PLAYER_REPLICATION") == "AUTOMATIC" then
        l__Events__2.PlayerOwnedAdded:Connect(function(_, u7) --[[ Line: 62 ]]
            -- upvalues: l__Death__8 (ref), l__Entity__3 (ref)
            local u8 = nil;
            local function v11(_, p9) --[[ Line: 64 ]]
                -- upvalues: u8 (ref), u7 (copy), l__Death__8 (ref)
                if u8 then
                    u8:Disconnect();
                    u8 = nil;
                end;
                if p9 and (u7.isContextOwner and p9:IsA("Model")) then
                    local v10 = p9:FindFirstChildWhichIsA("Humanoid");
                    if v10 then
                        u8 = v10.Died:Connect(function() --[[ Line: 76 ]]
                            -- upvalues: u7 (ref), l__Death__8 (ref)
                            if u7.isContextOwner then
                                l__Death__8:FireServer(u7.id);
                            end;
                        end);
                    end;
                end;
            end;
            l__Entity__3.GetEvent(u7, "ModelChanged"):Connect(v11);
            v11(u7, u7.model);
            l__Entity__3.GetEvent(u7, "Destroying"):Connect(function() --[[ Line: 86 ]]
                -- upvalues: u8 (ref)
                if u8 then
                    u8:Disconnect();
                    u8 = nil;
                end;
            end);
        end);
    end;
end);
l__Death__8.OnClientEvent:Connect(function(p12) --[[ Line: 95 ]]
    -- upvalues: l__Holder__4 (copy)
    local v13 = l__Holder__4.GetEntityFromId(p12);
    if v13 then
        if v13.isContextOwner then
        else
            local l__model__9 = v13.model;
            if l__model__9 then
                task.wait();
                local v14 = l__model__9:FindFirstChildWhichIsA("Humanoid");
                if v14 and v14:GetState() ~= Enum.HumanoidStateType.Dead then
                    v14.Health = 0;
                    v14.Health = 10;
                    v14.Health = 0;
                end;
            end;
        end;
    end;
end);
return nil;
