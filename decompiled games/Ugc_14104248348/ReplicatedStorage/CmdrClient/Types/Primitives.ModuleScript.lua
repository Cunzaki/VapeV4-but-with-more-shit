-- Decompiled from: ReplicatedStorage.CmdrClient.Types.Primitives
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Util__1 = require(script.Parent.Parent.Shared.Util);
local u3 = {
    Validate = function(p1) --[[ Name: Validate, Line 4 ]]
        return p1 ~= nil;
    end,
    Parse = function(p2) --[[ Name: Parse, Line 8 ]]
        return tostring(p2);
    end
};
local u7 = {
    Transform = function(p4) --[[ Name: Transform, Line 14 ]]
        return tonumber(p4);
    end,
    Validate = function(p5) --[[ Name: Validate, Line 18 ]]
        return p5 ~= nil;
    end,
    Parse = function(p6) --[[ Name: Parse, Line 22 ]]
        return p6;
    end
};
local u12 = {
    Transform = function(p8) --[[ Name: Transform, Line 28 ]]
        return tonumber(p8);
    end,
    Validate = function(p9) --[[ Name: Validate, Line 32 ]]
        local v10;
        if p9 == nil then
            v10 = false;
        else
            v10 = p9 == math.floor(p9);
        end;
        return v10, "Only whole numbers are valid.";
    end,
    Parse = function(p11) --[[ Name: Parse, Line 36 ]]
        return p11;
    end
};
local u13 = l__Util__1.MakeDictionary({
    "true",
    "t",
    "yes",
    "y",
    "on",
    "enable",
    "enabled",
    "1",
    "+"
});
local u14 = l__Util__1.MakeDictionary({
    "false",
    "f",
    "no",
    "n",
    "off",
    "disable",
    "disabled",
    "0",
    "-"
});
local u18 = {
    Transform = function(p15) --[[ Name: Transform, Line 46 ]]
        return p15:lower();
    end,
    Validate = function(p16) --[[ Name: Validate, Line 50 ]]
        -- upvalues: u13 (copy), u14 (copy)
        return u13[p16] ~= nil and true or u14[p16] ~= nil, "Please use true/yes/on or false/no/off.";
    end,
    Parse = function(p17) --[[ Name: Parse, Line 54 ]]
        -- upvalues: u13 (copy), u14 (copy)
        if u13[p17] then
            return true;
        elseif u14[p17] then
            return false;
        else
            return nil;
        end;
    end
};
return function(p19) --[[ Line: 66 ]]
    -- upvalues: u3 (copy), u7 (copy), u12 (copy), u18 (ref), l__Util__1 (copy)
    p19:RegisterType("string", u3);
    p19:RegisterType("number", u7);
    p19:RegisterType("integer", u12);
    p19:RegisterType("boolean", u18);
    p19:RegisterType("strings", l__Util__1.MakeListableType(u3));
    p19:RegisterType("numbers", l__Util__1.MakeListableType(u7));
    p19:RegisterType("integers", l__Util__1.MakeListableType(u12));
    p19:RegisterType("booleans", l__Util__1.MakeListableType(u18));
end;
