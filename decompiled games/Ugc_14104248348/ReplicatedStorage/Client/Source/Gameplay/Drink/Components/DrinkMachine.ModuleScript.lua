-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Drink.Components.DrinkMachine
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__LocalPlayer__2 = game:GetService("Players").LocalPlayer;
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__3:Get("Notices");
local u2 = l__Mince__3:Get("SelectInteractor");
local u3 = l__Mince__3:GetEvent("UseMachine");
local u4 = l__Mince__3.Component({
    Tag = "DrinkMachine",
    CreationParents = { game.Workspace },
    MachineExtenders = {},
    MainStub = {
        __index = {
            NewClass = u2.NewInteractionClass
        }
    }
});
function u4.Construct(p5) --[[ Line: 29 ]]
    -- upvalues: l__Mince__3 (copy), u4 (copy), l__LocalPlayer__2 (copy), u1 (copy), u3 (copy), u2 (copy)
    assert(p5.Name, "Requires a machine name.");
    p5.Config = l__Mince__3.Config.Machines[p5.Name];
    local l__Config__4 = p5.Config;
    local v6 = `Cannot load config for machine ('{p5.Name}')`;
    assert(l__Config__4, v6);
    if p5.Config.Disabled then
    elseif p5.Config.ShouldNotRegisterInteractionClass then
        local v7 = u4.MachineExtenders[p5.Name];
        if v7 and v7.Created then
            p5.MachineSub = setmetatable({
                Component = p5,
                Config = p5.Config,
                Instance = p5.Instance
            }, u4.MainStub);
            v7.Created(p5.MachineSub);
        else
            warn((`ShouldNotRegisterInteractionClass is enabled but yet no :Created() method for MachineExtender '{p5.Name}'! Consider fixing configuration. .Disabled = true????`));
            if not v7 then
                warn((`ShouldNotRegisterInteractionClass is enabled! And no MachineExtend '{p5.Name}'! `));
            end;
        end;
    else
        p5.HoverName = p5.Config.HoverName;
        p5.Target = p5.Instance;
        p5.HitCollider = p5.Instance:WaitForChild("Collider");
        function p5.OnHover(p8) --[[ Line: 59 ]]
            -- upvalues: l__LocalPlayer__2 (ref)
            local l__Character__5 = l__LocalPlayer__2.Character;
            if l__Character__5 then
                l__Character__5 = l__LocalPlayer__2.Character:FindFirstChildWhichIsA("Tool");
            end;
            if l__Character__5 then
                if p8.Config.AllowedUses[l__Character__5:GetAttribute("DrinkID")] then
                    return true;
                end;
            end;
        end;
        function p5.Interact(p9, p10) --[[ Line: 67 ]]
            -- upvalues: l__LocalPlayer__2 (ref), u1 (ref), u3 (ref)
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
        u2.NewInteractionClass(p5);
    end;
end;
function u4.Setup() --[[ Line: 87 ]]
    -- upvalues: u4 (copy)
    for _, v11 in script.Machines:GetChildren() do
        u4.MachineExtenders[v11.Name] = require(v11);
    end;
end;
return u4;
