-- Decompiled from: ReplicatedStorage.Modules.Leveler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    new = function(p1, p2) --[[ Name: new, Line 3 ]]
        if typeof(p1) == "table" then
            p1, p2 = table.unpack(p1);
        end;
        local u3 = p1 or 0.05;
        local u4 = p2 or 2;
        local v5 = type(u3) == "number";
        assert(v5, ".new([1]) must be an number!");
        local v6 = type(u4) == "number";
        assert(v6, ".new([2]) must be an number!");
        local u8 = {
            ConvertXPtoLevelFloat = function(p7) --[[ Line: 16 ]]
                -- upvalues: u3 (ref), u4 (ref)
                return u3 * p7 ^ (1 / u4);
            end
        };
        function u8.ConvertXPToLevel(p9) --[[ Line: 20 ]]
            -- upvalues: u8 (copy)
            local v10 = u8.ConvertXPtoLevelFloat(p9);
            return math.ceil(v10);
        end;
        function u8.ConvertLevelToXPFloat(p11) --[[ Line: 24 ]]
            -- upvalues: u3 (ref), u4 (ref)
            return (p11 / u3) ^ u4;
        end;
        function u8.ConvertLeveltoXP(p12) --[[ Line: 28 ]]
            -- upvalues: u8 (copy)
            local v13 = u8.ConvertLevelToXPFloat(p12);
            return math.floor(v13);
        end;
        return u8;
    end
};
