-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.PartyTimeClient
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("TweenService");
game:GetService("Players");
game:GetService("CollectionService");
local l__Mince__3 = require(l__ReplicatedStorage__2.Modules.Mince);
local u1 = l__Mince__3:GetEvent("PartyTime");
l__Mince__3:Get("SelectInteractor");
l__Mince__3:Get("SoundHandler");
local l__LocalPlayer__4 = game.Players.LocalPlayer;
local u2 = {
    IsPartyTime = false,
    Particle = nil
};
function u2.Update() --[[ Line: 22 ]]
    -- upvalues: l__LocalPlayer__4 (copy), u2 (copy)
    if l__LocalPlayer__4.Character then
        if u2.IsPartyTime then
            u2.Particle.Position = l__LocalPlayer__4.Character:GetPivot().Position + Vector3.new(0, 20, 0);
        end;
    end;
end;
function u2.TogglePartyTime(p3) --[[ Line: 29 ]]
    -- upvalues: u2 (copy), l__RunService__1 (copy), l__ReplicatedStorage__2 (copy)
    u2.IsPartyTime = p3;
    if p3 and not u2.UpdateConnection then
        u2.UpdateConnection = l__RunService__1.Heartbeat:Connect(u2.Update);
        u2.Particle.Parent = game.Workspace;
        u2.Particle.Confetti.Enabled = true;
    else
        if u2.UpdateConnection then
            u2.Particle.Parent = l__ReplicatedStorage__2.Assets.Particles;
            u2.Particle.Confetti.Enabled = false;
            u2.UpdateConnection:Disconnect();
            u2.UpdateConnection = nil;
        end;
    end;
end;
function u2.Setup() --[[ Line: 43 ]]
    -- upvalues: u2 (copy), l__ReplicatedStorage__2 (copy), u1 (copy)
    u2.Particle = l__ReplicatedStorage__2.Assets.Particles:WaitForChild("PartyTime");
    u1.Event:Connect(u2.TogglePartyTime);
end;
return u2;
