-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.HalloweenComponent
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:GetEvent("InteractHalloween");
local u2 = l__Mince__2:Get("SoundHandler");
local u3 = l__Mince__2:Get("SelectInteractor");
local u4 = l__Mince__2.Component({
    Tag = "Halloween",
    TargetColors = {
        [false] = Color3.new(0, 0, 0),
        [true] = Color3.new(0.796078, 0.635294, 0.478431)
    }
});
function u4.Start(p5) --[[ Line: 19 ]]
    p5.LoadedAnimations.Start:Play();
    p5.LoadedAnimations.Idle:Play();
end;
function u4.End(p6) --[[ Line: 24 ]]
    p6.LoadedAnimations.Start:Stop();
    p6.LoadedAnimations.End:Play();
    p6.LoadedAnimations.Idle:Stop();
end;
function u4.UpdateLightsStatus(p7, p8) --[[ Line: 30 ]]
    -- upvalues: u4 (copy)
    for _, v9 in p7.Instance.Parent:GetDescendants() do
        if v9:IsA("BasePart") and v9.Material == Enum.Material.Neon then
            v9.Color = u4.TargetColors[p8];
        end;
    end;
end;
function u4.InitBasket(u10) --[[ Line: 39 ]]
    -- upvalues: u1 (copy), u3 (copy)
    local v12 = {
        HoverName = "Get Candy!",
        Disabled = true,
        HitCollider = u10.Instance:WaitForChild("Character"):WaitForChild("Basket").Handle,
        Interact = function(_, p11) --[[ Name: Interact, Line 50 ]]
            -- upvalues: u1 (ref), u10 (copy)
            u1:Fire(u10.Instance, "CollectCandy");
            p11();
        end
    };
    u3.NewInteractionClass(v12);
    u10.BasketInteraction = v12;
end;
function u4.InitDoorbell(u13) --[[ Line: 61 ]]
    -- upvalues: u1 (copy), u3 (copy)
    local l__Doorbell__3 = u13.Instance:WaitForChild("Doorbell");
    local v15 = {
        HoverName = "Ring :)",
        HitCollider = l__Doorbell__3.Collider,
        Target = l__Doorbell__3,
        Interact = function(_, p14) --[[ Name: Interact, Line 70 ]]
            -- upvalues: u1 (ref), u13 (copy)
            u1:Fire(u13.Instance, "RingDoor");
            p14();
        end
    };
    u3.NewInteractionClass(v15);
    u13.DoorBellInteraction = v15;
end;
function u4.Construct(u16) --[[ Line: 81 ]]
    -- upvalues: l__Mince__2 (copy), u2 (copy)
    if l__Mince__2.Config.Holiday.HALLOWEEN_ENABLED then
        local l__Character__4 = u16.Instance:WaitForChild("Character");
        local l__Base__5 = u16.Instance:WaitForChild("Base");
        u16.SoundController = u2.controller();
        u16.SoundController.DestroyingEnabled = false;
        u16.SoundController.RollOff = { 1, 50 };
        u16.LoadedAnimations = {};
        for _, v17 in u16.Instance.Animations:GetChildren() do
            local v18 = l__Character__4.Humanoid:LoadAnimation(v17);
            u16.LoadedAnimations[v17.Name] = v18;
            v18:GetMarkerReachedSignal("PlaySound"):Connect(function(p19) --[[ Line: 100 ]]
                -- upvalues: u16 (copy), l__Base__5 (copy)
                if p19 then
                    u16.SoundController:Play(p19, l__Base__5);
                end;
            end);
        end;
        u16:InitBasket();
        u16:InitDoorbell();
        u16.Instance:GetAttributeChangedSignal("LightsActive"):Connect(function() --[[ Line: 111 ]]
            -- upvalues: u16 (copy)
            u16:UpdateLightsStatus(u16.LightsActive);
        end);
        u16.Instance:GetAttributeChangedSignal("IsLocked"):Connect(function() --[[ Line: 115 ]]
            -- upvalues: u16 (copy)
            u16.DoorBellInteraction.Disabled = u16.IsLocked;
        end);
        u16.Instance:GetAttributeChangedSignal("WaitingCandy"):Connect(function() --[[ Line: 119 ]]
            -- upvalues: u16 (copy)
            if u16.WaitingCandy then
                u16:Start();
            else
                u16:End();
            end;
            u16.BasketInteraction.Disabled = not u16.WaitingCandy;
        end);
        u16.Instance:GetAttributeChangedSignal("DiffSignal"):Connect(function() --[[ Line: 124 ]]
            -- upvalues: u16 (copy)
            u16.LoadedAnimations.Diff:Play();
        end);
    else
        u16.Instance:WaitForChild("Doorbell"):Destroy();
    end;
end;
function u4.Setup() --[[ Line: 129 ]] end;
return u4;
