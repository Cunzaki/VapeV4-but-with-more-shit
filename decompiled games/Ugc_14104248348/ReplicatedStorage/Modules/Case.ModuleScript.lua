-- Decompiled from: ReplicatedStorage.Modules.Case
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v1 = {};
local u2 = {
    __index = v1
};
function v1.new() --[[ Line: 4 ]]
    -- upvalues: u2 (copy)
    local v3 = setmetatable({}, u2);
    v3.Cases = {};
    return v3;
end;
function v1.Changed(p4, p5) --[[ Line: 11 ]]
    p4.ChangedCallbackFn = p5;
end;
function v1.Extend(p6) --[[ Line: 15 ]]
    local v10 = {
        Value = true,
        Set = function(p7, p8) --[[ Name: Set, Line 20 ]]
            local v9 = typeof(p8) == "boolean";
            assert(v9, "must set bool");
            p7.Value = p8;
            if p7.ChangedCallbackFn then
                return p7.ChangedCallbackFn(p7:GetValue());
            end;
        end
    };
    table.insert(p6.Cases, v10);
    return v10;
end;
function v1.GetValue(p11) --[[ Line: 32 ]]
    for _, v12 in p11.Cases do
        if not v12.Value then
            return false;
        end;
    end;
    return true;
end;
return v1;
