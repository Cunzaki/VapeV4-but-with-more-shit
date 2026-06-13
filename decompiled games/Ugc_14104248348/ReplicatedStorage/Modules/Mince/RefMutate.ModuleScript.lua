-- Decompiled from: ReplicatedStorage.Modules.Mince.RefMutate
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__MicroID__1 = require(script.Parent.MicroID);
local u1 = {
    InstanceRef = "____Ref0000",
    ConvMethod = {}
};
function u1.ConvMethod.Instance(p2) --[[ Line: 11 ]]
    -- upvalues: u1 (copy), l__MicroID__1 (copy)
    p2:SetAttribute(u1.InstanceRef, p2:GetAttribute(u1.InstanceRef) or l__MicroID__1.gent());
    return p2:GetAttribute(u1.InstanceRef);
end;
function u1.ConvMethod.Generic(u3) --[[ Line: 17 ]]
    local v4, v5 = pcall(function() --[[ Line: 19 ]]
        -- upvalues: u3 (copy)
        return tostring(u3);
    end);
    if v4 then
        return v5;
    else
        return typeof(u3);
    end;
end;
function u1.Typeof(p6) --[[ Line: 30 ]]
    local v7 = typeof(p6);
    if v7 == "Instance" then
        return p6.ClassName, v7;
    elseif v7 == "table" and p6.__type then
        return p6.__type;
    else
        return v7;
    end;
end;
function u1.Convert(p8) --[[ Line: 42 ]]
    -- upvalues: u1 (copy)
    local v9, v10 = u1.Typeof(p8);
    return `{v9}<>{(u1.ConvMethod[v10 or v9] or u1.ConvMethod.Generic)(p8, v9)}`;
end;
return u1;
