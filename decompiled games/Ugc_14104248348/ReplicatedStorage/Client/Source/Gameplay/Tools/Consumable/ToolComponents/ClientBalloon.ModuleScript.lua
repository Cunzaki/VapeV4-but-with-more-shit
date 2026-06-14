-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Consumable.ToolComponents.ClientBalloon
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Workspace__1 = game:GetService("Workspace");
game:GetService("RunService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local l__Mince__3 = require(l__ReplicatedStorage__2.Modules.Mince);
local u1 = l__Mince__3:Get("ToolHandler");
l__Mince__3:Get("VoiceChatHandler");
l__Mince__3:Get("NotifPrompt");
local u2 = l__Mince__3:Get("SoundHandler");
local u3 = l__Mince__3:GetEvent("TrashDrink");
local l__Gravity__4 = l__Workspace__1.Gravity;
local u6 = {
    Tags = { "ClientBalloon" },
    Equipped = function(u4) --[[ Name: Equipped, Line 26 ]]
        -- upvalues: l__Mince__3 (copy), l__Workspace__1 (copy), u2 (copy), l__Gravity__4 (copy), u3 (copy)
        if l__Mince__3.Config.Humanoid then
            l__Workspace__1.Gravity = 100;
            l__Mince__3.Config.Humanoid.JumpHeight = 15;
            local v5 = Instance.new("LinearVelocity");
            v5.VectorVelocity = Vector3.new(0, -10, 0);
            v5.Name = "BalloonVelocity";
            v5.Attachment0 = l__Mince__3.Config.HumanoidRootPart.RootAttachment;
            v5.Parent = l__Mince__3.Config.Character;
            u4.EquipMaid:Add(v5);
            u4.EquipMaid:Add(l__Mince__3.Config.Humanoid.Jumping:Connect(function() --[[ Line: 38 ]]
                -- upvalues: u4 (copy), u2 (ref), l__Workspace__1 (ref), l__Gravity__4 (ref), l__Mince__3 (ref), u3 (ref)
                u4.Tool:SetAttribute("Uses", u4.Tool:GetAttribute("Uses") - 1);
                if u4.Tool:GetAttribute("Uses") < 0 then
                    u2.PlaySound("balloonpop");
                    l__Workspace__1.Gravity = l__Gravity__4;
                    l__Mince__3.Config.Humanoid.JumpHeight = 3;
                    u3:Fire(true);
                end;
            end));
        end;
    end,
    Unequipped = function(_) --[[ Name: Unequipped, Line 50 ]]
        -- upvalues: l__Workspace__1 (copy), l__Gravity__4 (copy), l__Mince__3 (copy)
        l__Workspace__1.Gravity = l__Gravity__4;
        l__Mince__3.Config.Humanoid.JumpHeight = 3;
    end
};
function u6.Setup() --[[ Line: 56 ]]
    -- upvalues: u1 (copy), u6 (copy)
    u1.Component(u6);
end;
return u6;
