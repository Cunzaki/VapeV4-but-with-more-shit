-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.RagdollClient
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ContextActionService__1 = game:GetService("ContextActionService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Workspace__3 = game:GetService("Workspace");
local l__LocalPlayer__4 = game:GetService("Players").LocalPlayer;
local l__Mince__5 = require(l__ReplicatedStorage__2.Modules.Mince);
local u1 = l__Mince__5:Get("SeatHandler");
local u2 = l__Mince__5:Get("WorldCulling");
local u3 = l__Mince__5:GetEvent("RequestReset");
local u4 = {
    AllowJumping = true
};
function u4.NewCharacter(u5) --[[ Line: 20 ]]
    -- upvalues: l__Workspace__3 (copy), u2 (copy), u1 (copy), u4 (copy), u3 (copy)
    local u6 = l__Workspace__3:FindFirstChildWhichIsA("SpawnLocation");
    local l__Humanoid__6 = u5:WaitForChild("Humanoid");
    u2.SetRenderFocus();
    u5:GetAttributeChangedSignal("Ragdolled"):Connect(function() --[[ Line: 26 ]]
        -- upvalues: u5 (copy), u1 (ref), u4 (ref), l__Humanoid__6 (copy)
        if u5:GetAttribute("Ragdolled") then
            if u1.IsSat then
                u4.AllowJumping = false;
            else
                l__Humanoid__6.PlatformStand = true;
            end;
        else
            u4.AllowJumping = true;
            task.wait(0.1);
            l__Humanoid__6.PlatformStand = false;
        end;
    end);
    u5.Destroying:Connect(function() --[[ Line: 41 ]]
        -- upvalues: u2 (ref), u6 (copy), u3 (ref)
        u2.SetRenderFocus(u6.Position);
        task.wait(3);
        u3:Fire(true);
    end);
    l__Humanoid__6.Died:Connect(function() --[[ Line: 47 ]]
        -- upvalues: u2 (ref), u6 (copy), u5 (copy), u3 (ref)
        u2.SetRenderFocus(u6.Position);
        if u5:GetAttribute("Ragdolled") and not u5:GetAttribute("ForceRespawning") then
            task.wait(3);
            u3:Fire(true);
        end;
    end);
    u4.AllowJumping = true;
end;
function u4.Setup() --[[ Line: 59 ]]
    -- upvalues: l__LocalPlayer__4 (copy), u4 (copy), l__ContextActionService__1 (copy)
    l__LocalPlayer__4.CharacterAdded:Connect(u4.NewCharacter);
    if l__LocalPlayer__4.Character then
        u4.NewCharacter(l__LocalPlayer__4.Character);
    end;
    l__ContextActionService__1:BindActionAtPriority("JumpOverride", function() --[[ Line: 63 ]]
        -- upvalues: u4 (ref)
        if u4.AllowJumping then
            return Enum.ContextActionResult.Pass;
        else
            return Enum.ContextActionResult.Sink;
        end;
    end, false, 3000, Enum.PlayerActions.CharacterJump, Enum.KeyCode.Space);
end;
return u4;
