-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.chrono.Server.Player
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__Warn__3 = require(script.Parent.Parent.Shared.Warn);
local l__Config__4 = require(script.Parent.Parent.Shared.Config);
local l__Entity__5 = require(script.Parent.Parent.Shared.Entity);
local l__Holder__6 = require(script.Parent.Parent.Shared.Holder);
require(script.Parent.Parent.Shared.Types);
local l___playerChars__7 = l__Holder__6._playerChars;
local function u9(p1, p2, p3) --[[ Line: 14 ]]
    -- upvalues: l___playerChars__7 (copy), l__Entity__5 (copy), l__Config__4 (copy), l__Holder__6 (copy)
    local v4 = l___playerChars__7[p1];
    if v4 then
        l__Entity__5.Destroy(v4);
    end;
    local v5 = p3.config or "PLAYER";
    local v6 = p3.modelRepMode or (l__Config__4._EntityConfigs[v5] or {}).MODEL_REPLICATION_MODE;
    p2.Archivable = true;
    local v7 = p2:FindFirstChildWhichIsA("Humanoid");
    if v7 and (p2:FindFirstChild("HumanoidRootPart") and (v7.RigType == Enum.HumanoidRigType.R6 and p2.PrimaryPart == p2:FindFirstChild("Head"))) then
        l__Config__4.SetModelPrimaryForChrono(p2, "HumanoidRootPart");
    end;
    local v8 = l__Entity__5.new(v5, p2, v6);
    l__Holder__6.SetAsCharacter(p1, v8);
    l__Entity__5.SetNetworkOwner(v8, p1);
    return v8;
end;
local function u12(p10) --[[ Line: 56 ]]
    -- upvalues: l___playerChars__7 (copy), l__Entity__5 (copy)
    local v11 = l___playerChars__7[p10];
    if v11 then
        l__Entity__5.Destroy(v11);
    end;
end;
local function u16(u13) --[[ Line: 70 ]]
    -- upvalues: u9 (copy)
    u13.CharacterAdded:Connect(function(p14) --[[ Line: 71 ]]
        -- upvalues: u13 (copy), u9 (ref)
        local v15 = u13;
        task.wait(0.1);
        u9(v15, p14, {
            config = "PLAYER"
        });
    end);
    if u13.Character then
        local l__Character__8 = u13.Character;
        task.wait(0.1);
        u9(u13, l__Character__8, {
            config = "PLAYER"
        });
    end;
end;
l__Config__4._WaitForLock(function() --[[ Line: 79 ]]
    -- upvalues: l__RunService__2 (copy), l__Config__4 (copy), l__Warn__3 (copy), l__Holder__6 (copy), l__Players__1 (copy), u16 (copy), u12 (copy), u9 (copy)
    if l__RunService__2:IsServer() then
        if l__Config__4._GetConfig("PLAYER_REPLICATION") == "AUTOMATIC" then
            local l__Death__9 = script.Parent.Parent.Shared.Remotes.Death;
            local u17 = l__Config__4._GetConfig("REPLICATE_DEATHS");
            l__Death__9.OnServerEvent:Connect(function(p18, p19) --[[ Line: 89 ]]
                -- upvalues: u17 (copy), l__Holder__6 (ref), l__Death__9 (copy)
                if u17 == "NONE" then
                else
                    local v20 = l__Holder__6.GetEntityFromId(p19);
                    if v20 then
                        if v20.networkOwner == p18 then
                            if u17 == "PLAYER_CHARACTERS" and not v20._player then
                            else
                                local l__model__10 = v20.model;
                                if l__model__10 then
                                    local u21 = l__model__10:FindFirstChildWhichIsA("Humanoid");
                                    task.wait();
                                    if u21 and u21:GetState() ~= Enum.HumanoidStateType.Dead then
                                        u21.Health = 0;
                                        task.delay(0, function() --[[ Line: 111 ]]
                                            -- upvalues: u21 (copy)
                                            if u21:GetState() ~= Enum.HumanoidStateType.Dead then
                                                u21.Health = 0;
                                                u21.Health = 10;
                                                u21.Health = 0;
                                            end;
                                        end);
                                    end;
                                end;
                                l__Death__9:FireAllClients(p19);
                            end;
                        end;
                    end;
                end;
            end);
            l__Players__1.PlayerAdded:Connect(u16);
            l__Players__1.PlayerRemoving:Connect(u12);
            for _, u22 in l__Players__1:GetPlayers() do
                u22.CharacterAdded:Connect(function(p23) --[[ Line: 71 ]]
                    -- upvalues: u22 (copy), u9 (ref)
                    local v24 = u22;
                    task.wait(0.1);
                    u9(v24, p23, {
                        config = "PLAYER"
                    });
                end);
                if u22.Character then
                    local l__Character__11 = u22.Character;
                    task.wait(0.1);
                    u9(u22, l__Character__11, {
                        config = "PLAYER"
                    });
                end;
            end;
        else
            l__Warn__3.low("automatic player replication is disabled");
        end;
    end;
end);
return {
    RegisterPlayer = u9,
    UnregisterPlayer = u12
};
