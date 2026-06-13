-- Decompiled from: ReplicatedStorage.CmdrClient.Types.EnumTypes
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Inventory__2 = require(l__ReplicatedStorage__1.Config.Shared.Inventory);
require(script.Parent.Parent.Shared.Util);
return function(p1) --[[ Line: 8 ]]
    -- upvalues: l__Inventory__2 (copy)
    local v2 = {};
    local v3 = { "Coins", "Holiday", "Keys" };
    for v4, v5 in l__Inventory__2 do
        for v6, _ in v5 do
            local v7 = `{v4}.{v6}`;
            table.insert(v2, v7);
        end;
    end;
    p1:RegisterType("itemname", p1.Cmdr.Util.MakeEnumType("Item Name", v2));
    p1:RegisterType("currencytype", p1.Cmdr.Util.MakeEnumType("Currency Type", v3));
end;
