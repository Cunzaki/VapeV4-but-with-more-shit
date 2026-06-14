-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.UnderwaterSeatSecret
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("ContextActionService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local l__TweenService__2 = game:GetService("TweenService");
game:GetService("Players");
game:GetService("CollectionService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__3:GetEvent("CaveEvent");
l__Mince__3:Get("SelectInteractor");
l__Mince__3:Get("SoundHandler");
local u2 = {
    OrderBuffer = {}
};
local u3 = TweenInfo.new(1, Enum.EasingStyle.Elastic);
function u2.Start(p4, p5) --[[ Line: 20 ]]
    -- upvalues: l__TweenService__2 (copy), u3 (copy)
    l__TweenService__2:Create(p4.Collider, u3, {
        Position = Vector3.new(50.751, 28.894, -81.546)
    }):Play();
    l__TweenService__2:Create(p5.PointLight, u3, {
        Brightness = 0.5
    }):Play();
end;
function u2.End(p6, p7) --[[ Line: 25 ]]
    -- upvalues: l__TweenService__2 (copy), u3 (copy)
    l__TweenService__2:Create(p6.Collider, u3, {
        Position = Vector3.new(50.751, 28.381, -81.546)
    }):Play();
    l__TweenService__2:Create(p7.PointLight, u3, {
        Brightness = 2
    }):Play();
end;
function u2.Setup() --[[ Line: 30 ]]
    -- upvalues: u1 (copy), u2 (copy)
    u1.Event:Connect(function(p8, p9, p10) --[[ Line: 31 ]]
        -- upvalues: u2 (ref)
        if p10 then
            u2.End(p8, p9);
        else
            u2.Start(p8, p9);
        end;
    end);
end;
return u2;
