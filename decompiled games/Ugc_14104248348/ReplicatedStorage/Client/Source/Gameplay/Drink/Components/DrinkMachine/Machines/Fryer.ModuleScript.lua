-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Drink.Components.DrinkMachine.Machines.Fryer
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local l__LocalPlayer__2 = game:GetService("Players").LocalPlayer;
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__ModelTweenOG__4 = require(l__ReplicatedStorage__1.Modules.ModelTweenOG);
local u1 = l__Mince__3:Get("Notices");
local u2 = l__Mince__3:Get("SelectInteractor");
local u3 = l__Mince__3:GetEvent("UseMachine");
local u4 = {
    Tween = TweenInfo.new(0.5)
};
function u4.Created(u5) --[[ Line: 20 ]]
    -- upvalues: u2 (copy), l__LocalPlayer__2 (copy), u3 (copy), u1 (copy), l__ModelTweenOG__4 (copy), u4 (copy)
    u5.HoverName = u5.Config.HoverName;
    u5.Target = u5.Instance;
    u5.HitCollider = u5.Instance:WaitForChild("Collider");
    u5.StartingPivot = u5.Instance:GetPivot();
    function u5.OnHover(p6) --[[ Line: 27 ]]
        -- upvalues: u2 (ref), l__LocalPlayer__2 (ref)
        p6.HoverName = p6.Config.HoverName;
        if p6.Instance:GetAttribute("Frying") or p6.Instance:GetAttribute("Waiting") then
            local v7 = p6.Instance:FindFirstChildWhichIsA("Tool");
            if v7 then
                if p6.HoverName ~= v7.Name then
                    for _, v8 in u2.GetSelections() do
                        if v8 == p6 and v8.CurrentSource then
                            v8.CurrentSource:Unselect();
                        end;
                    end;
                end;
                p6.HoverName = `{v7.Name}`;
            end;
            return true;
        else
            local l__Character__5 = l__LocalPlayer__2.Character;
            if l__Character__5 then
                l__Character__5 = l__LocalPlayer__2.Character:FindFirstChildWhichIsA("Tool");
            end;
            if l__Character__5 then
                if p6.Config.AllowedUses[l__Character__5:GetAttribute("DrinkID")] then
                    return true;
                end;
            end;
        end;
    end;
    function u5.Interact(p9, p10) --[[ Line: 55 ]]
        -- upvalues: u3 (ref), l__LocalPlayer__2 (ref), u1 (ref)
        if p9.Instance:GetAttribute("Frying") or p9.Instance:GetAttribute("Waiting") then
            u3:Fire(p9.Instance);
            return p10();
        end;
        local l__Character__6 = l__LocalPlayer__2.Character;
        if l__Character__6 then
            l__Character__6 = l__LocalPlayer__2.Character:FindFirstChildWhichIsA("Tool");
        end;
        if not l__Character__6 then
            u1.Error("You must have an item equipped to use this.");
            return p10();
        end;
        if not p9.Config.AllowedUses[l__Character__6:GetAttribute("DrinkID")] then
            u1.Error("You cannot use this with that item.");
            return p10();
        end;
        u3:Fire(p9.Instance);
        p10();
    end;
    u5.Instance:GetAttributeChangedSignal("Frying"):Connect(function() --[[ Line: 79 ]]
        -- upvalues: u5 (copy), l__ModelTweenOG__4 (ref), u4 (ref)
        if u5.Instance:GetAttribute("Frying") then
            u5.HitCollider.Frying:Play();
            l__ModelTweenOG__4.new(u5.Instance, u4.Tween, u5.StartingPivot + Vector3.new(0, -1, 0)).Play();
            task.wait(u4.Tween.Time);
            for _, v11 in u5.Instance:GetDescendants() do
                if v11:IsA("ParticleEmitter") then
                    v11.Enabled = true;
                end;
            end;
        else
            u5.HitCollider.Frying:Stop();
            l__ModelTweenOG__4.new(u5.Instance, u4.Tween, u5.StartingPivot).Play();
            for _, v12 in u5.Instance:GetDescendants() do
                if v12:IsA("ParticleEmitter") then
                    v12.Enabled = false;
                end;
            end;
        end;
    end);
    u5:NewClass();
end;
return u4;
