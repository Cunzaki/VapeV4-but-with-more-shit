-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.CharacterPickup
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("PhysicsService");
local l__Players__2 = game:GetService("Players");
local l__ContextActionService__3 = game:GetService("ContextActionService");
game:GetService("Debris");
local l__LocalPlayer__4 = l__Players__2.LocalPlayer;
local _ = script.Parent;
local _ = game.StarterGui;
local l__Mince__5 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__5:Get("InterfaceHandler");
local u2 = l__Mince__5:Get("SelectInteractor");
local u3 = l__Mince__5:Get("ProximityManager");
l__Mince__5:Get("PlayerProfile");
local u4 = l__Mince__5:Get("SeatHandler");
local u5 = l__Mince__5:Get("Intoxication");
local u6 = l__Mince__5:GetEvent("RequestPickupCharacter");
local u7 = l__Mince__5:GetEvent("RequestRagdoll");
local u8 = l__Mince__5:GetEvent("RequestRagdollDrop");
local u9 = {
    IsPickedUp = false,
    IsPicking = false,
    Animations = {}
};
function u9.ValidatePickup() --[[ Line: 32 ]]
    -- upvalues: u9 (copy)
    return not (u9.IsPickedUp or u9.IsPicking);
end;
function u9.Dropped() --[[ Line: 36 ]]
    -- upvalues: u9 (copy), u3 (copy), u2 (copy), u5 (copy), u7 (copy)
    u9.Animations.Picked:Stop();
    u9.IsPickedUp = false;
    task.wait(5);
    u3:SetAllEnabled(true);
    u9.SitCase:Set(true);
    u2.EndInteractions();
    if not (u9.IsPickedUp or u5.IsPassedOut()) then
        u7:Fire(false);
    end;
end;
function u9.GetPicked() --[[ Line: 53 ]]
    -- upvalues: u9 (copy), u3 (copy), u2 (copy)
    u9.Animations.Picked:Play();
    u3:SetAllEnabled(false);
    u2.StartInteractions();
    u9.IsPickedUp = true;
    u9.SitCase:Set(false);
end;
function u9.DoPickup() --[[ Line: 61 ]]
    -- upvalues: u9 (copy), u3 (copy), l__LocalPlayer__4 (copy), u2 (copy)
    task.wait(0.1);
    u9.Animations.Picker:Play();
    u3:SetAllEnabled(false);
    u9.IsPicking = true;
    u9.SitCase:Set(false);
    l__LocalPlayer__4.Character.Humanoid:UnequipTools();
    u2.StartInteractions();
    u9.Button.Visible = true;
end;
function u9.StopPicking() --[[ Line: 74 ]]
    -- upvalues: u9 (copy), u3 (copy), u2 (copy)
    u9.Animations.Picker:Stop();
    u3:SetAllEnabled(true);
    u9.SitCase:Set(true);
    u2.EndInteractions();
    u9.Button.Visible = false;
    u9.IsPicking = false;
end;
function u9.CharacterAdded(p10) --[[ Line: 83 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u9 (copy), u8 (copy)
    for _, v11 in l__ReplicatedStorage__1.Assets.Misc.PickupAnims:GetChildren() do
        u9.Animations[v11.Name] = p10:WaitForChild("Humanoid"):WaitForChild("Animator"):LoadAnimation(v11);
    end;
    p10.Humanoid.HealthChanged:Connect(function(p12) --[[ Line: 88 ]]
        -- upvalues: u9 (ref), u8 (ref)
        if p12 > 0 then
        elseif u9.IsPicking or u9.IsPickedUp then
            u8:Fire();
        else
            u8:Fire(true, true);
        end;
    end);
end;
function u9.Setup() --[[ Line: 99 ]]
    -- upvalues: u9 (copy), l__Players__2 (copy), u4 (copy), l__ContextActionService__3 (copy), u6 (copy), l__Mince__5 (copy), u1 (copy), l__LocalPlayer__4 (copy)
    u9.Button = l__Players__2.LocalPlayer.PlayerGui:WaitForChild("MainPriority"):WaitForChild("DropPlayer");
    u9.SitCase = u4.CanSitCase:Extend();
    l__ContextActionService__3.LocalToolEquipped:Connect(function() --[[ Line: 104 ]]
        -- upvalues: u9 (ref), u6 (ref), l__Mince__5 (ref)
        if u9.IsPicking then
            u6:Fire("Drop");
        else
            if u9.IsPickedUp then
                l__Mince__5.Config.Humanoid:UnequipTools();
            end;
        end;
    end);
    u1.NewButton(u9.Button).Activated:Connect(function() --[[ Line: 112 ]]
        -- upvalues: u6 (ref)
        u6:Fire("Drop");
    end);
    u6.Event:Connect(function(p13) --[[ Line: 116 ]]
        -- upvalues: u9 (ref)
        if p13 == "Picked" then
            u9.GetPicked();
        elseif p13 == "Picker" then
            u9.DoPickup();
        elseif p13 == "DropPlayer" then
            u9.StopPicking();
        else
            u9.Dropped();
        end;
    end);
    if l__LocalPlayer__4.Character then
        u9.CharacterAdded(l__LocalPlayer__4.Character);
    end;
    l__LocalPlayer__4.CharacterAdded:Connect(u9.CharacterAdded);
end;
return u9;
