-- Decompiled from: ReplicatedStorage.Modules.Component.Symbol
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return function(p1) --[[ Name: Symbol, Line 45 ]]
    local v2 = newproxy(true);
    local u3 = p1 or "";
    getmetatable(v2).__tostring = function() --[[ Line: 50 ]]
        -- upvalues: u3 (ref)
        return "Symbol(" .. u3 .. ")";
    end;
    return v2;
end;
