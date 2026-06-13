-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Consumable.Legacy.EqupippedDeprecated.AnniversaryBalloon
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local l__Mince__3 = require(l__ReplicatedStorage__2.Modules.Mince);
local u1 = l__Mince__3:Get("ToolHandler");
l__Mince__3:Get("VoiceChatHandler");
l__Mince__3:Get("NotifPrompt");
local l__Gravity__4 = game.Workspace.Gravity;
local u2 = {
    Animations = {}
};
function u2.StartTool(u3) --[[ Line: 17 ]]
    -- upvalues: l__Mince__3 (copy), u2 (copy), l__RunService__1 (copy)
    if l__Mince__3.Config.Humanoid then
        u2.ToolActive = true;
        u2.CurrentTool = u3;
        game.Workspace.Gravity = 100;
        l__Mince__3.Config.Humanoid.JumpHeight = 15;
        u2.Update = l__RunService__1.Heartbeat:Connect(function() --[[ Line: 26 ]]
            -- upvalues: l__Mince__3 (ref), u3 (copy)
            local v4 = l__Mince__3.Config.Humanoid:GetState();
            if v4 == Enum.HumanoidStateType.Freefall or v4 == Enum.HumanoidStateType.Jumping then
                u3.BalloonPart.LinearVelocity.VectorVelocity = Vector3.new(0, 100, 0);
            else
                u3.BalloonPart.LinearVelocity.VectorVelocity = Vector3.new(0, 10, 0);
            end;
        end);
    end;
end;
function u2.EndTool() --[[ Line: 38 ]]
    -- upvalues: u2 (copy), l__Gravity__4 (copy), l__Mince__3 (copy)
    u2.ToolActive = false;
    game.Workspace.Gravity = l__Gravity__4;
    if u2.Update then
        u2.Update:Disconnect();
    end;
    l__Mince__3.Config.Humanoid.JumpHeight = 3;
    for _, v5 in u2.Animations do
        v5:Stop();
    end;
end;
function u2.Setup() --[[ Line: 54 ]]
    -- upvalues: u1 (copy), u2 (copy)
    local v6 = u1.TagEquipped({ "AnniversaryBalloon" });
    v6.Equipped:Connect(u2.StartTool);
    v6.Unequipped:Connect(u2.EndTool);
end;
return u2;
