-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Drink.Components.DrinkMachine.Machines.Blender
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local l__RunService__2 = game:GetService("RunService");
local l__LocalPlayer__3 = game:GetService("Players").LocalPlayer;
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.ModelTweenOG);
local u1 = l__Mince__4:Get("Notices");
local u2 = l__Mince__4:GetEvent("UseMachine");
return {
    Tween = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1),
    Created = function(u3) --[[ Name: Created, Line 19 ]]
        -- upvalues: l__LocalPlayer__3 (copy), u2 (copy), u1 (copy), l__RunService__2 (copy)
        u3.HoverName = u3.Config.HoverName;
        u3.Target = u3.Instance;
        u3.HitCollider = u3.Instance:WaitForChild("Collider");
        local l__Fill__5 = u3.Instance:WaitForChild("Fill");
        function u3.OnHover(p4) --[[ Line: 27 ]]
            -- upvalues: l__LocalPlayer__3 (ref)
            if p4.Instance:GetAttribute("Finished") then
                return true;
            else
                local l__Character__6 = l__LocalPlayer__3.Character;
                if l__Character__6 then
                    l__Character__6 = l__LocalPlayer__3.Character:FindFirstChildWhichIsA("Tool");
                end;
                if l__Character__6 then
                    if p4.Config.AllowedUses[l__Character__6:GetAttribute("DrinkID")] then
                        return true;
                    end;
                end;
            end;
        end;
        function u3.Interact(p5, p6) --[[ Line: 39 ]]
            -- upvalues: u2 (ref), l__LocalPlayer__3 (ref), u1 (ref)
            if p5.Instance:GetAttribute("Finished") then
                u2:Fire(p5.Instance);
                return p6();
            end;
            local l__Character__7 = l__LocalPlayer__3.Character;
            if l__Character__7 then
                l__Character__7 = l__LocalPlayer__3.Character:FindFirstChildWhichIsA("Tool");
            end;
            if not l__Character__7 then
                u1.Error("You must have an item equipped to use this.");
                return p6();
            end;
            if not p5.Config.AllowedUses[l__Character__7:GetAttribute("DrinkID")] then
                u1.Error("You cannot use this with that item.");
                return p6();
            end;
            u2:Fire(p5.Instance);
            p6();
        end;
        local u7 = nil;
        u3.Instance:GetAttributeChangedSignal("Blending"):Connect(function() --[[ Line: 62 ]]
            -- upvalues: u3 (copy), u7 (ref), l__RunService__2 (ref), l__Fill__5 (copy)
            local v8 = u3.Instance:GetAttribute("Blending");
            if u7 then
                u7:Disconnect();
            end;
            if v8 then
                u3.HitCollider.Blender:Play();
                u7 = l__RunService__2.Heartbeat:Connect(function(p9) --[[ Line: 68 ]]
                    -- upvalues: l__Fill__5 (ref)
                    local v10 = l__Fill__5;
                    v10.CFrame = v10.CFrame * CFrame.Angles(0, math.rad(360 * p9 * 2), 0);
                end);
            else
                u3.HitCollider.Blender:Stop();
            end;
        end);
        u3.Instance:GetAttributeChangedSignal("HasLiquid"):Connect(function() --[[ Line: 76 ]]
            -- upvalues: u3 (copy), l__Fill__5 (copy)
            if u3.Instance:GetAttribute("HasLiquid") then
                l__Fill__5.Transparency = 0;
            else
                l__Fill__5.Transparency = 1;
            end;
        end);
        u3:NewClass();
    end
};
