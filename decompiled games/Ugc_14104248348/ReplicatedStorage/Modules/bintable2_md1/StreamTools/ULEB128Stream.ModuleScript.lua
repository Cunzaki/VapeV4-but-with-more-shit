-- Decompiled from: ReplicatedStorage.Modules.bintable2_md1.StreamTools.ULEB128Stream
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__StringStream__1 = require(script.Parent.StringStream);
return {
    Write = function(_, p1, p2) --[[ Name: Write, Line 5 ]]
        -- upvalues: l__StringStream__1 (copy)
        assert(p2 > 0, "Value must be unsigned");
        while true do
            local v3 = p2 % 128;
            p2 = p2 // 128;
            if p2 > 0 then
                v3 = v3 + 128;
            end;
            l__StringStream__1.WriteU8(p1, v3);
            if p2 == 0 then
                return;
            end;
        end;
    end,
    Read = function(_, p4) --[[ Name: Read, Line 19 ]]
        -- upvalues: l__StringStream__1 (copy)
        local v5 = 0;
        local v6 = 0;
        local v7;
        repeat
            v7 = l__StringStream__1.ReadU8(p4);
            v6 = v6 + v7 % 128 * 2 ^ v5;
            v5 = v5 + 7;
        until math.floor(v7 / 128) == 0;
        return v6;
    end
};
