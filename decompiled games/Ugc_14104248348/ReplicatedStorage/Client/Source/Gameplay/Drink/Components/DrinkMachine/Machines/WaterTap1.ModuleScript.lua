-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Drink.Components.DrinkMachine.Machines.WaterTap1
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local l__LocalPlayer__2 = game:GetService("Players").LocalPlayer;
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__ModelTweenOG__4 = require(l__ReplicatedStorage__1.Modules.ModelTweenOG);
local u1 = l__Mince__3:Get("Notices");
local u2 = l__Mince__3:Get("DrinkHandler");
l__Mince__3:Get("SelectInteractor");
local u3 = l__Mince__3:GetEvent("UseMachine");
local u12 = {
    Tween = TweenInfo.new(6),
    Tween2 = TweenInfo.new(0.3),
    CreateKnob = function(u4) --[[ Name: CreateKnob, Line 22 ]]
        -- upvalues: u3 (copy)
        u4.NewClass({
            HoverName = "Knob",
            Target = u4.Knob,
            HitCollider = u4.Knob,
            Interact = function(_, p5) --[[ Name: Interact, Line 31 ]]
                -- upvalues: u3 (ref), u4 (copy)
                u3:Fire(u4.Instance, "Turn");
                p5();
            end
        });
    end,
    CreateTap = function(u6) --[[ Name: CreateTap, Line 39 ]]
        -- upvalues: l__LocalPlayer__2 (copy), u1 (copy), u2 (copy), u3 (copy)
        u6.NewClass({
            HoverName = "Water",
            Target = u6.Faucet,
            HitCollider = u6.Faucet,
            OnHover = function(_) --[[ Name: OnHover, Line 47 ]]
                -- upvalues: u6 (copy), l__LocalPlayer__2 (ref)
                if u6.Instance:GetAttribute("IsRunning") then
                    local l__Character__5 = l__LocalPlayer__2.Character;
                    if l__Character__5 then
                        l__Character__5 = l__LocalPlayer__2.Character:FindFirstChildWhichIsA("Tool");
                    end;
                    if l__Character__5 then
                        if u6.Config.AllowedUses[l__Character__5:GetAttribute("DrinkID")] then
                            return true;
                        end;
                    end;
                end;
            end,
            Interact = function(_, p7) --[[ Name: Interact, Line 58 ]]
                -- upvalues: l__LocalPlayer__2 (ref), u1 (ref), u6 (copy), u2 (ref), u3 (ref)
                local l__Character__6 = l__LocalPlayer__2.Character;
                if l__Character__6 then
                    l__Character__6 = l__LocalPlayer__2.Character:FindFirstChildWhichIsA("Tool");
                end;
                if not l__Character__6 then
                    u1.Error("You must have an item equipped to use this.");
                    return p7();
                end;
                if not u6.Config.AllowedUses[l__Character__6:GetAttribute("DrinkID")] then
                    u1.Error("You cannot use this with that item.");
                    return p7();
                end;
                u2.DoProcessingText(u6.Modifier.Action, u6.Modifier.ActionTime, u6.Modifier.AltSound or nil);
                task.wait(0.05);
                u3:Fire(u6.Instance, "Water");
                p7();
            end
        });
    end,
    CreateSinkWater = function(u8) --[[ Name: CreateSinkWater, Line 81 ]]
        -- upvalues: l__LocalPlayer__2 (copy), u1 (copy), u2 (copy), u3 (copy)
        u8.NewClass({
            HoverName = "Sink",
            Target = u8.Water,
            HitCollider = u8.Water,
            OnHover = function(_) --[[ Name: OnHover, Line 89 ]]
                -- upvalues: l__LocalPlayer__2 (ref)
                local l__Character__7 = l__LocalPlayer__2.Character;
                if l__Character__7 then
                    l__Character__7 = l__LocalPlayer__2.Character:FindFirstChildWhichIsA("Tool");
                end;
                if l__Character__7 then
                    if l__Character__7:GetAttribute("SinkPlate") and l__Character__7:GetAttribute("PlateIsDirty") then
                        return true;
                    end;
                end;
            end,
            Interact = function(_, p9) --[[ Name: Interact, Line 97 ]]
                -- upvalues: l__LocalPlayer__2 (ref), u1 (ref), u2 (ref), u8 (copy), u3 (ref)
                local l__Character__8 = l__LocalPlayer__2.Character;
                if l__Character__8 then
                    l__Character__8 = l__LocalPlayer__2.Character:FindFirstChildWhichIsA("Tool");
                end;
                if not l__Character__8 then
                    u1.Error("You must have an item equipped to use this.");
                    return p9();
                end;
                if not l__Character__8:GetAttribute("SinkPlate") then
                    u1.Error("You cannot use this with that item.");
                    return p9();
                end;
                local v10 = u2.GetAnimations();
                local v11 = 0.5 * u2.GetLevelBasedActionTime();
                if v10 and v10.GeneralAnimation then
                    v10.GeneralAnimation:Play(0.2, 1, v10.GeneralAnimation.Length / v11);
                end;
                u2.DoProcessingText("Washing in sink.", v11, u8.Modifier.AltSound or nil);
                task.wait(0.05);
                u3:Fire(u8.Instance, "SinkWater");
                p9();
            end
        });
    end
};
function u12.Created(u13) --[[ Line: 128 ]]
    -- upvalues: l__Mince__3 (copy), u12 (copy), l__ModelTweenOG__4 (copy)
    u13.Modifier = l__Mince__3.Config.Modifiers[u13.Config.Modifier];
    u13.Knob = u13.Instance:WaitForChild("Knob");
    u13.Water = u13.Instance:WaitForChild("Water");
    u13.Faucet = u13.Instance:WaitForChild("Faucet");
    u13.BeamPart = u13.Instance:WaitForChild("Beams").Top;
    u13.ThisPivot = u13.Water:GetPivot();
    u13.ThisKnobPivot = u13.Knob:GetPivot();
    u12.CreateTap(u13);
    u12.CreateKnob(u13);
    u12.CreateSinkWater(u13);
    local u14 = nil;
    local u15 = nil;
    u13.Instance:GetAttributeChangedSignal("IsRunning"):Connect(function() --[[ Line: 143 ]]
        -- upvalues: u13 (copy), u15 (ref), u14 (ref), l__ModelTweenOG__4 (ref), u12 (ref)
        local v16 = u13.Instance:GetAttribute("IsRunning");
        if u15 then
            u15.Stop();
        end;
        if u14 then
            u14.Stop();
        end;
        if v16 then
            u15 = l__ModelTweenOG__4.new(u13.Water, u12.Tween, u13.ThisPivot + Vector3.new(0, 1, 0));
            u14 = l__ModelTweenOG__4.new(u13.Knob, u12.Tween2, u13.ThisKnobPivot * CFrame.Angles(1.0471975511965976, 0, 0));
            u14.Play();
            u15.Play();
            for _, v17 in u13.BeamPart:GetChildren() do
                if v17:IsA("Beam") then
                    v17.Enabled = true;
                end;
            end;
        else
            u15 = l__ModelTweenOG__4.new(u13.Water, u12.Tween, u13.ThisPivot);
            u14 = l__ModelTweenOG__4.new(u13.Knob, u12.Tween2, u13.ThisKnobPivot);
            u14.Play();
            u15.Play();
            for _, v18 in u13.BeamPart:GetChildren() do
                if v18:IsA("Beam") then
                    v18.Enabled = false;
                end;
            end;
        end;
    end);
end;
return u12;
