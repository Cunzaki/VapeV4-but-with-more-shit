-- Decompiled from: ReplicatedStorage.Modules.bintable2_md1.StreamTools.PrefixSizeBlockStream
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__StringStream__1 = require(script.Parent.StringStream);
require(script.Parent.ULEB128Stream);
return {
    Write = function(p1, p2) --[[ Name: Write, Line 7 ]]
        -- upvalues: l__StringStream__1 (copy)
        l__StringStream__1.WriteU8(p1, #p2);
        l__StringStream__1.WriteString(p1, p2);
    end,
    Read = function(p3) --[[ Name: Read, Line 12 ]]
        -- upvalues: l__StringStream__1 (copy)
        return l__StringStream__1.ReadString(p3, l__StringStream__1.ReadU8(p3));
    end
};
