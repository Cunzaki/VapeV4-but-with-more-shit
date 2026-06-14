-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Drink.Components.DrinkMachine.Machines.HotPot
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local l__LocalPlayer__2 = game:GetService("Players").LocalPlayer;
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.ModelTweenOG);
local u1 = l__Mince__3:Get("Notices");
local u2 = l__Mince__3:Get("SelectInteractor");
local u3 = l__Mince__3:GetEvent("UseMachine");
return {
    Created = function(u4) --[[ Name: Created, Line 18 ]]
        -- upvalues: l__LocalPlayer__2 (copy), u3 (copy), u1 (copy), u2 (copy)
        u4.HoverName = u4.Config.HoverName;
        u4.Target = u4.Instance;
        u4.HitCollider = u4.Instance:WaitForChild("Collider");
        function u4.OnHover(p5) --[[ Line: 23 ]]
            -- upvalues: l__LocalPlayer__2 (ref)
            if p5.Instance:GetAttribute("Cooking") then
                return true;
            else
                local l__Character__4 = l__LocalPlayer__2.Character;
                if l__Character__4 then
                    l__Character__4 = l__LocalPlayer__2.Character:FindFirstChildWhichIsA("Tool");
                end;
                if l__Character__4 then
                    if p5.Config.AllowedUses[l__Character__4:GetAttribute("DrinkID")] then
                        return true;
                    end;
                end;
            end;
        end;
        function u4.Interact(p6, p7) --[[ Line: 35 ]]
            -- upvalues: u3 (ref), l__LocalPlayer__2 (ref), u1 (ref)
            if p6.Instance:GetAttribute("Cooking") then
                u3:Fire(p6.Instance);
                return p7();
            end;
            local l__Character__5 = l__LocalPlayer__2.Character;
            if l__Character__5 then
                l__Character__5 = l__LocalPlayer__2.Character:FindFirstChildWhichIsA("Tool");
            end;
            if not l__Character__5 then
                u1.Error("You must have an item equipped to use this.");
                return p7();
            end;
            if not p6.Config.AllowedUses[l__Character__5:GetAttribute("DrinkID")] then
                u1.Error("You cannot use this with that item.");
                return p7();
            end;
            u3:Fire(p6.Instance);
            p7();
        end;
        local function v10() --[[ Line: 58 ]]
            -- upvalues: u4 (copy), u2 (ref)
            task.wait();
            local l__HoverName__6 = u4.HoverName;
            local v8 = u4.Instance:FindFirstChildWhichIsA("Tool");
            if v8 then
                u4.HoverName = `{v8.Name}`;
            else
                u4.HoverName = u4.Config.HoverName;
            end;
            if u4.HoverName ~= l__HoverName__6 then
                for _, v9 in u2.GetSelections() do
                    if v9 == u4 and v9.CurrentSource then
                        v9.CurrentSource:Unselect();
                    end;
                end;
            end;
        end;
        u4.Instance:GetAttributeChangedSignal("UpdateKey"):Connect(v10);
        u4.Instance:GetAttributeChangedSignal("Cooking"):Connect(v10);
        u4:NewClass();
    end
};
