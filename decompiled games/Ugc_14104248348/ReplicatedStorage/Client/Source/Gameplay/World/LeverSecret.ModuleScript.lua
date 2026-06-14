-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.LeverSecret
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("ContextActionService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local l__TweenService__2 = game:GetService("TweenService");
game:GetService("Players");
local l__CollectionService__3 = game:GetService("CollectionService");
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__4:GetEvent("GateEvent");
local u2 = l__Mince__4:Get("SelectInteractor");
local u3 = l__Mince__4:Get("SoundHandler");
local u4 = l__Mince__4:Get("Settings");
local u5 = {
    OrderBuffer = {}
};
local v6 = l__Mince__4.Component({
    Tag = "MysteriousSwitch"
});
local u7 = l__Mince__4.Component({
    Tag = "Gate"
});
function u7.Construct(_) --[[ Line: 28 ]] end;
function u5.Setup() --[[ Line: 32 ]] end;
function u5.SetLightStatus(p8) --[[ Line: 36 ]]
    -- upvalues: l__CollectionService__3 (copy)
    for _, v9 in l__CollectionService__3:GetTagged("FlickerLight") do
        if v9:IsA("BasePart") then
            v9.Material = p8 and Enum.Material.Neon or Enum.Material.SmoothPlastic;
        elseif v9:IsA("Light") then
            v9.Enabled = p8;
        end;
    end;
end;
function u5.BufferUpdated() --[[ Line: 48 ]]
    -- upvalues: u5 (copy), u3 (copy), u4 (copy), u1 (copy)
    if u5.OrderBuffer[1] == 3 and (u5.OrderBuffer[2] == 2 and u5.OrderBuffer[3] == 1) then
        u3.PlaySound("WitchSecret.LightFlickering");
        if not u4.GetValue("NoFlash") then
            u5.SetLightStatus(false);
            task.wait(0.03);
            u5.SetLightStatus(true);
            task.wait(0.02);
            u5.SetLightStatus(false);
            task.wait(0.02);
            u5.SetLightStatus(true);
            task.wait(0.02);
            u5.SetLightStatus(false);
            u3.PlaySound("WitchSecret.WitchLaughing");
            task.wait(2);
            u3.PlaySound("WitchSecret.LightOn");
            u5.SetLightStatus(true);
            task.wait(0.1);
            u5.SetLightStatus(false);
            task.wait(0.2);
            u5.SetLightStatus(true);
        end;
        u1:Fire();
    end;
end;
function v6.Construct(p10) --[[ Line: 75 ]]
    -- upvalues: l__TweenService__2 (copy), u5 (copy), u1 (copy), u7 (copy), u2 (copy)
    local v11 = {};
    local l__Lever__5 = p10.Instance.Lever;
    local l__PrimaryPart__6 = p10.Instance.PrimaryPart;
    local l__SwitchID__7 = p10.SwitchID;
    v11.HoverName = "Pull";
    v11.Name = "Pull";
    v11.Model = p10.Instance;
    v11.HitCollider = l__PrimaryPart__6;
    function v11.Interact(_, p12) --[[ Line: 86 ]]
        -- upvalues: l__Lever__5 (copy), l__PrimaryPart__6 (copy), l__TweenService__2 (ref), u5 (ref), l__SwitchID__7 (copy)
        local v13 = l__Lever__5.CFrame:ToWorldSpace(CFrame.Angles(0, 0, -3.141592653589793) * CFrame.new(0, l__Lever__5.Size.Y, 0));
        l__PrimaryPart__6.Switch:Play();
        l__TweenService__2:Create(l__Lever__5, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out, 0, true), {
            CFrame = v13
        }):Play();
        task.wait(0.5);
        table.insert(u5.OrderBuffer, 1, l__SwitchID__7);
        if u5.OrderBuffer[4] then
            u5.OrderBuffer[4] = nil;
        end;
        u5.BufferUpdated();
        task.wait(0.5);
        p12();
    end;
    u1.Event:Connect(function() --[[ Line: 102 ]]
        -- upvalues: u7 (ref)
        for _, v14 in u7:GetAll() do
            v14.Instance:Destroy();
        end;
        u7:GetComponentAddedSignal():Once(function(p15) --[[ Line: 107 ]]
            p15:Destroy();
        end);
    end);
    u2.NewInteractionClass(v11);
end;
return u5;
