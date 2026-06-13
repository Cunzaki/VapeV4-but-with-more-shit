-- Decompiled from: ReplicatedStorage.Modules.bintable2_md1.StreamTools.SVF128Stream
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__SLEB128Stream__1 = require(script.Parent.SLEB128Stream);
return {
    Write = function(_, p1, p2) --[[ Name: Write, Line 4 ]]
        -- upvalues: l__SLEB128Stream__1 (copy)
        if p2 == 0 then
            l__SLEB128Stream__1:Write(p1, 0);
        else
            local v3, v4 = math.frexp(p2);
            l__SLEB128Stream__1:Write(p1, (math.floor(v3 * 9007199254740992 + 0.5)));
            l__SLEB128Stream__1:Write(p1, v4);
        end;
    end,
    Read = function(_, p5) --[[ Name: Read, Line 27 ]]
        -- upvalues: l__SLEB128Stream__1 (copy)
        local v6 = l__SLEB128Stream__1:Read(p5);
        if v6 == 0 then
            return 0;
        end;
        local v7 = l__SLEB128Stream__1:Read(p5);
        return math.ldexp(v6 / 9007199254740992, v7);
    end
};
