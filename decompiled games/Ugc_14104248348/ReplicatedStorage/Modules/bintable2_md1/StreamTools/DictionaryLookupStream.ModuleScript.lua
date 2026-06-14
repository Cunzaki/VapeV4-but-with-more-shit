-- Decompiled from: ReplicatedStorage.Modules.bintable2_md1.StreamTools.DictionaryLookupStream
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__StringStream__1 = require(script.Parent.StringStream);
require(script.Parent.ULEB128Stream);
return {
    Write = function(p1, p2, p3) --[[ Name: Write, Line 6 ]]
        -- upvalues: l__StringStream__1 (copy)
        l__StringStream__1.WriteU8(p1, p2.Lookup[p3]);
    end,
    Read = function(p4, p5) --[[ Name: Read, Line 11 ]]
        -- upvalues: l__StringStream__1 (copy)
        local v6 = l__StringStream__1.ReadU8(p4);
        return p5.List[v6];
    end,
    Create = function(p7) --[[ Name: Create, Line 18 ]]
        local v8 = {
            List = p7,
            Lookup = {}
        };
        for v9, v10 in ipairs(p7) do
            v8.Lookup[v10] = v9;
        end;
        return v8;
    end
};
