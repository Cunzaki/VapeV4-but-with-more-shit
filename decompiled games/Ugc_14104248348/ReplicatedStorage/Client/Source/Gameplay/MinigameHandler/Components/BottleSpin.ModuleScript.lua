-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.MinigameHandler.Components.BottleSpin
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local _ = workspace.CurrentCamera;
l__LocalPlayer__1:GetMouse();
game:GetService("Debris");
game:GetService("Chat");
local l__TweenService__2 = game:GetService("TweenService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("RunService");
local l__Mince__4 = require(l__ReplicatedStorage__3.Modules.Mince);
l__Mince__4:Get("BindManager");
l__Mince__4:Get("SoundHandler");
l__Mince__4:Get("InterfaceHandler");
local u1 = l__Mince__4:Get("SelectInteractor");
local v2 = {
    ButtonPressTween = nil,
    Client = {}
};
local u3 = TweenInfo.new(7, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut);
function v2.Construct(u4) --[[ Line: 31 ]]
    -- upvalues: u1 (copy)
    local l__PrimaryPart__5 = u4.Instance.PrimaryPart;
    u1.NewInteractionClass({
        HoverName = "Spin Bottle",
        Name = "Spin Bottle",
        Model = u4.Instance,
        HitCollider = l__PrimaryPart__5,
        Interact = function(_, p5) --[[ Name: Interact, Line 39 ]]
            -- upvalues: u4 (copy)
            u4.Server:SpinBottle();
            p5();
        end,
        OnHover = function() --[[ Line: 44 ]]
            -- upvalues: u4 (copy)
            return u4.ReplicatedState.Ready;
        end
    });
    u4.Bottle = l__PrimaryPart__5;
end;
function v2.SpectateStart(u6) --[[ Line: 53 ]]
    -- upvalues: l__TweenService__2 (copy), u3 (copy)
    local v8 = u6:GetStateChangedSignal("Orientation"):Connect(function() --[[ Line: 57 ]]
        -- upvalues: u6 (copy), l__TweenService__2 (ref), u3 (ref)
        local u7 = l__TweenService__2:Create(u6.Bottle, u3, {
            Orientation = u6.ReplicatedState.Orientation
        });
        u7.Completed:Once(function() --[[ Line: 65 ]]
            -- upvalues: u7 (copy)
            u7:Destroy();
        end);
        u7:Play();
    end);
    u6.SpectateMaid:Mark(v8);
end;
return v2;
