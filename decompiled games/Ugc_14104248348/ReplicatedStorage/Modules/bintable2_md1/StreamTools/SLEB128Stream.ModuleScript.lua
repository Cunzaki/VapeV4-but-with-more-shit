-- Decompiled from: ReplicatedStorage.Modules.bintable2_md1.StreamTools.SLEB128Stream
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Write = function(_, p1, p2) --[[ Name: Write, Line 3 ]]
        assert(p2 ~= nil, "Value must be signed");
        while true do
            local v3 = p2 % 128;
            p2 = math.floor(p2 / 128);
            if p2 ~= 0 and p2 ~= -1 or v3 >= 128 and (p2 > 0 or v3 > 0) then
                v3 = v3 + 128;
            end;
            p1:WriteU8(v3);
            if p2 == 0 or p2 == -1 then
                return;
            end;
        end;
    end,
    Read = function(_, p4) --[[ Name: Read, Line 17 ]]
        local v5 = 0;
        local v6 = 0;
        local v7;
        repeat
            v7 = p4:ReadU8();
            v6 = v6 + v7 % 128 * 2 ^ v5;
            v5 = v5 + 7;
        until v7 // 128 == 0;
        if 2 ^ (v5 - 1) <= v6 then
            v6 = v6 - 2 ^ v5;
        end;
        return v6;
    end
};
