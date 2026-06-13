-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Special-Event-World.IceCream
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local v1 = l__Mince__2.Component({
    Tag = "IceCream"
});
function v1.Construct(p2) --[[ Line: 11 ]]
    -- upvalues: l__Mince__2 (copy)
    local l__Name__3 = p2.Name;
    local v3 = `Requires a modifier name. :{p2.Instance:GetFullName()} `;
    assert(l__Name__3, v3);
    p2.Config = l__Mince__2.Config.Modifiers[p2.Name];
    local l__Config__4 = p2.Config;
    local v4 = "DrinkModifier config unable to be loaded. ->" .. p2.Name .. `<LC->{p2.Instance:GetFullName()}`;
    assert(l__Config__4, v4);
    local l__IceCreamModifier__5 = p2.Config.IceCreamModifier;
    local v5 = "IceCream modifier config missing IceCreamModifier flag. ->" .. p2.Name .. `<LC->{p2.Instance:GetFullName()}`;
    assert(l__IceCreamModifier__5, v5);
    p2.Cream = p2.Instance:WaitForChild("Cream");
    p2.Cream:SetAttribute("Name", p2.Name);
    p2.Cream:AddTag("DrinkModifier");
    p2.Cream:SetAttribute("RequiresFoodMaster", true);
    if p2.Config.MaterialVariant then
        p2.Cream.MaterialVariant = p2.Config.MaterialVariant;
    end;
    if p2.Config.Material then
        p2.Cream.Material = p2.Config.Material;
    end;
    if p2.Config.Color then
        p2.Cream.Color = p2.Config.Color;
    end;
end;
return v1;
