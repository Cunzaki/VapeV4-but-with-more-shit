-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Canvas.WallCanvas
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__Players__3 = game:GetService("Players");
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__LocalPlayer__5 = l__Players__3.LocalPlayer;
local u1 = l__Mince__4:Get("ConfirmPrompt");
local u2 = l__Mince__4:Get("SelectInteractor");
local u3 = l__Mince__4:GetEvent("ReportCanvas");
local u4 = l__Mince__4:GetEvent("PickupDrink");
local v5 = l__Mince__4.Component({
    Tag = "CanvasPickup"
});
function v5.Construct(p6) --[[ Line: 19 ]]
    -- upvalues: l__LocalPlayer__5 (copy), l__RunService__2 (copy), u4 (copy), u1 (copy), u3 (copy), u2 (copy)
    if p6.PlayerID == l__LocalPlayer__5.UserId then
        p6.HoverName = "Pickup Canvas!";
    else
        p6.HoverName = `{p6.PlayerName}'s Canvas!`;
    end;
    p6.HitCollider = p6.Instance:WaitForChild("Paper");
    function p6.Interact(u7, p8) --[[ Line: 28 ]]
        -- upvalues: l__LocalPlayer__5 (ref), l__RunService__2 (ref), u4 (ref), u1 (ref), u3 (ref)
        p8();
        if u7.PlayerID == l__LocalPlayer__5.UserId and not l__RunService__2:IsStudio() then
            u4:Fire(u7.Instance);
        else
            u1.Display(`Are you sure you want to report {u7.PlayerName}'s Canvas?`, function() --[[ Line: 36 ]]
                -- upvalues: u3 (ref), u7 (copy)
                u3:Fire(u7.Instance);
            end);
        end;
    end;
    u2.NewInteractionClass(p6);
end;
function v5.Removing(p9) --[[ Line: 45 ]]
    -- upvalues: u2 (copy)
    u2.CollapseClass(p9);
end;
return v5;
