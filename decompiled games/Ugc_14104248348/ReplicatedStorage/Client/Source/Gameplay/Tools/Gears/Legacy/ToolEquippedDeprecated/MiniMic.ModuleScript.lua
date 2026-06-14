-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Legacy.ToolEquippedDeprecated.MiniMic
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Mince__3 = require(l__ReplicatedStorage__2.Modules.Mince);
local u1 = l__Mince__3:Get("ToolHandler");
local u2 = l__Mince__3:Get("VoiceChatHandler");
l__Mince__3:Get("NotifPrompt");
local u3 = l__Mince__3:GetEvent("SyncState");
local u4 = {};
function u4.StartTool(u5) --[[ Line: 13 ]]
    -- upvalues: l__Mince__3 (copy), u4 (copy), u2 (copy), l__RunService__1 (copy), u3 (copy)
    if l__Mince__3.Config.Humanoid then
        u4.ToolActive = true;
        u4.CurrentTool = u5;
        u4.Animations = {};
        for _, v6 in u5.Animations:GetChildren() do
            u4.Animations[v6.Name] = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(v6);
        end;
        u4.Animations.Idle:Play();
        local v7 = u2.GetHandlerIfExists(game.Players.LocalPlayer);
        if v7 then
            local u8 = v7:GetAnalyzer();
            u4.SmoothedVolume = 0.1;
            u4.Update = l__RunService__1.Heartbeat:Connect(function() --[[ Line: 33 ]]
                -- upvalues: u8 (copy), u4 (ref), u5 (copy)
                local v9 = math.clamp(u8.RmsLevel / 1.5 * 7, 0.1, 0.9);
                u4.SmoothedVolume = u4.SmoothedVolume + (v9 - u4.SmoothedVolume) * 0.1;
                if v9 < 0.15 then
                    if u4.Animations.Speaking.IsPlaying then
                        u4.Animations.Speaking:Stop();
                    end;
                else
                    if u5.Handle:FindFirstChildOfClass("ParticleEmitter") and not u5.Handle:FindFirstChildOfClass("ParticleEmitter").Enabled then
                        u5.Handle:FindFirstChildOfClass("ParticleEmitter").Enabled = true;
                    end;
                    u4.Animations.Speaking:AdjustWeight(u4.SmoothedVolume);
                    u4.Animations.Idle:AdjustWeight(1 - u4.SmoothedVolume);
                end;
            end);
        end;
        u3:Fire("MiniMic", true);
    end;
end;
function u4.EndTool() --[[ Line: 55 ]]
    -- upvalues: u4 (copy), u3 (copy)
    u4.ToolActive = false;
    if u4.Update then
        u4.Update:Disconnect();
    end;
    for _, v10 in u4.Animations do
        v10:Stop();
    end;
    u3:Fire("MiniMic", false);
end;
function u4.Setup() --[[ Line: 69 ]]
    -- upvalues: u1 (copy), u4 (copy)
    local v11 = u1.TagEquipped({ "MiniMic" });
    v11.Equipped:Connect(u4.StartTool);
    v11.Unequipped:Connect(u4.EndTool);
end;
return u4;
