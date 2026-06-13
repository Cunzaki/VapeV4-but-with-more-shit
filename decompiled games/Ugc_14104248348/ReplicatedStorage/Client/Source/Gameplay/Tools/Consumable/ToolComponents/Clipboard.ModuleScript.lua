-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Consumable.ToolComponents.Clipboard
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("MarketplaceService");
game:GetService("CollectionService");
game:GetService("TweenService");
local _ = game:GetService("Players").LocalPlayer;
game.Players.LocalPlayer:GetMouse();
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
l__Mince__2:Get("Notices");
l__Mince__2:Get("Locomotion");
l__Mince__2:Get("ToolHandler");
l__Mince__2:Get("SelectInteractor");
l__Mince__2:Get("InterfaceHandler");
local u1 = l__Mince__2:Get("SelectInteractor");
l__Mince__2:GetEvent("ChangePetition");
local u2 = l__Mince__2:GetEvent("SignPetition");
l__Mince__2.Component({
    Tag = "PetitionClipboard"
}).Construct = function(u3) --[[ Name: Construct, Line 31 ]]
    -- upvalues: u2 (copy), u1 (copy)
    local v4 = {};
    local l__Paper__3 = u3.Instance:WaitForChild("Paper");
    v4.HoverName = "Add Signature";
    v4.Name = "Add Signature";
    v4.Model = u3.Instance;
    v4.Target = l__Paper__3;
    v4.HitCollider = l__Paper__3;
    function v4.Interact(_, p5) --[[ Line: 44 ]]
        -- upvalues: u2 (ref), u3 (copy)
        u2:Fire(u3.Instance);
        u3.Instance:SetAttribute("Signed", true);
        p5();
    end;
    function v4.OnHover(_) --[[ Line: 50 ]]
        -- upvalues: u3 (copy)
        return u3.Instance.Parent ~= game.Players.LocalPlayer.Character and not u3.Instance:GetAttribute("Signed") and true or false;
    end;
    u3.Instance.Paper.SurfaceGui.Main.Header.Subject:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 59 ]]
        -- upvalues: u3 (copy)
        u3.Instance:SetAttribute("Signed", false);
    end);
    u1.NewInteractionClass(v4);
end;
return {
    Animations = {}
};
