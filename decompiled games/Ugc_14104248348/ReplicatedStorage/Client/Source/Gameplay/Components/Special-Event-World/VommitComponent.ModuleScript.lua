-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Special-Event-World.VommitComponent
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("TeleportService");
local l__LocalPlayer__3 = game:GetService("Players").LocalPlayer;
local l__Mince__4 = require(l__ReplicatedStorage__2.Modules.Mince);
local u1 = l__Mince__4:GetEvent("Vomit"):Extend("Clean");
local u2 = l__Mince__4:Get("SelectInteractor");
local u3 = l__Mince__4:Get("Mop");
local v4 = l__Mince__4.Component({
    Tag = "VommitPuddle"
});
local u5 = TweenInfo.new(1.5);
function v4.Construct(p6) --[[ Line: 22 ]]
    -- upvalues: l__TweenService__1 (copy), u5 (copy), l__LocalPlayer__3 (copy), u3 (copy), u1 (copy), u2 (copy)
    p6.HoverName = "Clean vomit!";
    p6.HitCollider = p6.Instance;
    local v7 = l__TweenService__1:Create(p6.Instance, u5, {
        Position = p6.Instance.Position + Vector3.new(0, p6.Instance.Size.Y, 0)
    });
    local u8 = l__TweenService__1:Create(p6.Instance, u5, {
        Position = p6.Instance.Position
    });
    function p6.OnHover(_) --[[ Line: 38 ]]
        -- upvalues: l__LocalPlayer__3 (ref)
        local v9 = l__LocalPlayer__3.Character:FindFirstChildOfClass("Tool");
        return v9 and v9:HasTag("Mop") and true or false;
    end;
    function p6.Interact(p10, p11) --[[ Line: 48 ]]
        -- upvalues: u3 (ref), u8 (copy), u1 (ref)
        u3.StartClean();
        u8:Play();
        u8.Completed:Wait();
        u1:Fire(p10.Instance);
        u3.StopClean();
        p11();
    end;
    v7:Play();
    v7.Completed:Wait();
    u2.NewInteractionClass(p6);
end;
return v4;
