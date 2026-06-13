-- Decompiled from: ReplicatedStorage.Modules.bintable2_md1.StreamTools.UVF128Stream
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ULEB128Stream__1 = require(script.Parent.ULEB128Stream);
return {
    Write = function(_, p1, p2) --[[ Name: Write, Line 6 ]]
        -- upvalues: l__ULEB128Stream__1 (copy)
        assert(p2 > 0, "Value must be unsigned");
        if p2 == 0 then
            l__ULEB128Stream__1:Write(p1, 0);
        else
            local v3;
            if p2 < 0 then
                p2 = -p2;
                v3 = -1;
            else
                v3 = 1;
            end;
            local v4, v5 = math.frexp(p2);
            local v6 = math.floor(v4 * 9007199254740992 + 0.5);
            local v7 = v5 + 100;
            if v3 == -1 then
                v6 = -v6;
            end;
            l__ULEB128Stream__1:Write(p1, v6);
            l__ULEB128Stream__1:Write(p1, v7);
        end;
    end,
    Read = function(_, p8) --[[ Name: Read, Line 33 ]]
        -- upvalues: l__ULEB128Stream__1 (copy)
        local v9 = l__ULEB128Stream__1:Read(p8);
        if v9 == 0 then
            return 0;
        end;
        local v10 = l__ULEB128Stream__1:Read(p8);
        local v11;
        if v9 < 0 then
            v9 = -v9;
            v11 = -1;
        else
            v11 = 1;
        end;
        return math.ldexp(v9 / 9007199254740992, v10 - 100) * v11;
    end
};
