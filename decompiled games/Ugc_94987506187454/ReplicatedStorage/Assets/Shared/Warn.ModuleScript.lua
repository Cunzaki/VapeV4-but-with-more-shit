-- Decompiled from: ReplicatedStorage.Assets.Shared.Warn
-- Class: ModuleScript
-- Place: Ugc (94987506187454)

-- Decompiled with Potassium's decompiler.

local l__Config__1 = require(script.Parent.Config);
return setmetatable({}, {
    __index = function(_, p1) --[[ Name: __index, Line 22 ]]
        -- upvalues: l__Config__1 (copy)
        local v2 = p1:upper();
        local v3 = {
            NONE = 0,
            LOW = 1,
            MEDIUM = 2,
            HIGH = 3
        };
        local v4 = v3[l__Config__1._GetConfig("WARNING_SEVERITY")] or 0;
        local v5;
        if v4 == 0 then
            v5 = false;
        else
            v5 = v4 <= (v3[v2] or 0);
        end;
        return not v5 and function() --[[ Line: 24 ]] end or warn;
    end
});
