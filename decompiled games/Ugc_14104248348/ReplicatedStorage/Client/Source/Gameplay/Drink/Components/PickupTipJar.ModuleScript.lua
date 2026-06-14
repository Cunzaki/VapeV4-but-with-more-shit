-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Drink.Components.PickupTipJar
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__Players__3 = game:GetService("Players");
local l__LocalPlayer__4 = l__Players__3.LocalPlayer;
local l__Mince__5 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__5:GetEvent("PickupDrink");
local u2 = l__Mince__5:Get("Notices");
l__Mince__5:Get("SoundHandler");
local u3 = l__Mince__5:Get("DrinkHandler");
local u4 = l__Mince__5:Get("TipJar");
local u5 = l__Mince__5:Get("SelectInteractor");
l__Mince__5:Get("PlacementHandler");
local v6 = l__Mince__5.Component({
    Tag = "PickupTipJar"
});
function v6.Removing(p7) --[[ Line: 24 ]]
    -- upvalues: u5 (copy)
    for _, v8 in p7.Events do
        v8:Disconnect();
    end;
    for _, v9 in p7.Sounds do
        v9:Destroy();
    end;
    u5.CollapseClass(p7);
end;
function v6.Construct(u10) --[[ Line: 30 ]]
    -- upvalues: l__LocalPlayer__4 (copy), l__Players__3 (copy), l__RunService__2 (copy), l__Mince__5 (copy), u1 (copy), u2 (copy), u3 (copy), u4 (copy), u5 (copy)
    u10.HitCollider = u10.Instance:FindFirstChild("Collider") or u10.Instance:WaitForChild("Handle");
    u10.HoverName = u10.Instance.Name;
    u10.Target = u10.Instance;
    u10.Sounds = {};
    u10.Events = {};
    for _, v11 in u10.Instance:GetChildren() do
        if v11:IsA("BasePart") and v11 ~= u10.HitCollider then
            v11.CanQuery = false;
        end;
    end;
    if u10.AssociatedPlayer and l__LocalPlayer__4.UserId ~= u10.AssociatedPlayer then
        u10.HoverName = `{l__Players__3:GetPlayerByUserId((tonumber(u10.AssociatedPlayer))).Name}'s Tip Jar.`;
    else
        u10.Events.Update = l__RunService__2.Heartbeat:Connect(function(_) --[[ Line: 50 ]]
            -- upvalues: l__Mince__5 (ref), u10 (copy), u1 (ref), u2 (ref)
            if l__Mince__5.Config.HumanoidRootPart then
                if (u10.HitCollider.Position - l__Mince__5.Config.HumanoidRootPart.Position).Magnitude >= 50 and not u10.AlreadyIgnoring then
                    u10.AlreadyIgnoring = true;
                    u1:Fire(u10.Instance);
                    u2.CreateNotice("You\'ve walked too far away from your tip jar.");
                    task.wait(0.5);
                    u10.AlreadyIgnoring = false;
                end;
            end;
        end);
    end;
    function u10.OnHover(p12) --[[ Line: 65 ]]
        -- upvalues: u3 (ref)
        local v13 = u3.GetEquippedTool();
        return (v13 and p12.Instance:GetAttribute("UnblockPlacements") or v13 and v13:GetAttribute("PreventPickupsWhileEquipped")) and "Unselect" or true;
    end;
    function u10.Interact(p14, p15) --[[ Line: 74 ]]
        -- upvalues: l__LocalPlayer__4 (ref), u1 (ref), l__Players__3 (ref), u4 (ref)
        if p14.AssociatedPlayer and l__LocalPlayer__4.UserId == p14.AssociatedPlayer then
            u1:Fire(p14.Instance);
        else
            local v16 = l__Players__3:GetPlayerByUserId((tonumber(p14.AssociatedPlayer)));
            if not v16 then
                return p15();
            end;
            u4.DonatePlayer(v16);
        end;
        p15();
    end;
    u5.NewInteractionClass(u10);
end;
return v6;
