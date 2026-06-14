-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Drink.Components.DrinkMachine.Machines.BeerTap
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local l__CollectionService__2 = game:GetService("CollectionService");
local _ = game:GetService("Players").LocalPlayer;
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__ModelTweenOG__4 = require(l__ReplicatedStorage__1.Modules.ModelTweenOG);
l__Mince__3:Get("Notices");
local u1 = l__Mince__3:Get("DrinkHandler");
local l__Modifiers__5 = l__Mince__3.Config.Modifiers;
local u2 = l__Mince__3:GetEvent("UseMachine");
local v3 = {
    Tween = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1)
};
local u4 = TweenInfo.new(0.5);
local u5 = false;
function v3.Created(u6) --[[ Line: 24 ]]
    -- upvalues: l__Modifiers__5 (copy), l__ModelTweenOG__4 (copy), u4 (copy), u1 (copy), l__CollectionService__2 (copy), u5 (ref), u2 (copy)
    local u7 = u6.Instance:GetAttribute("Modifier");
    local u8 = l__Modifiers__5[u7];
    if u8 then
        u6.HoverName = u8.HoverName;
        u6.Target = u6.Instance;
        u6.HitCollider = u6.Instance:WaitForChild("Collider");
        local l__Tap__6 = u6.Instance:WaitForChild("Tap");
        local v9 = l__Tap__6:GetPivot();
        local u10 = l__ModelTweenOG__4.new(l__Tap__6, u4, v9 * CFrame.Angles(0.4363323129985824, 0, 0), true);
        local u11 = l__ModelTweenOG__4.new(l__Tap__6, u4, v9, true);
        u6.Instance:GetAttributeChangedSignal("InUse"):Connect(function() --[[ Line: 54 ]]
            -- upvalues: u6 (copy), u10 (copy), u11 (copy)
            if u6.Instance:GetAttribute("InUse") then
                u10:Play();
            else
                u11:Play();
            end;
        end);
        function u6.OnHover(_) --[[ Line: 66 ]]
            -- upvalues: u1 (ref), l__CollectionService__2 (ref), u8 (copy), u7 (copy)
            local v12, v13 = u1.GetEquippedDrinkTool();
            if v13 then
                if l__CollectionService__2:HasTag(v12, "Drink") then
                    if u1.IsValidOption(v12, v13, u8) then
                        if not v12:GetAttribute(u7) then
                            return true;
                        end;
                    end;
                end;
            end;
        end;
        function u6.Interact(p14, p15) --[[ Line: 79 ]]
            -- upvalues: u5 (ref), u10 (copy), u1 (ref), u8 (copy), u2 (ref), u11 (copy)
            u5 = true;
            u10:Play();
            u1.DoProcessingText(u8.Action, u8.ActionTime * u1.GetLevelBasedActionTime(), u8.AltSound or nil);
            task.wait(0.05);
            u2:Fire(p14.Instance);
            u11:Play();
            u5 = false;
            p15();
        end;
        u6:NewClass();
    else
        warn("[Beer Tap]: Failed to create a beer tap, no modifier does not exist!");
    end;
end;
return v3;
