-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = tostring;
local v2 = _G.obtain("Remote");
local l__Add__1 = v2.Add;
local l__Call__2 = v2.Call;
return {
    Add = function(p3, p4, p5) --[[ Name: Add, Line 11 ]]
        -- upvalues: u1 (copy), l__Add__1 (copy), l__Call__2 (copy)
        local v6 = u1(p5);
        l__Add__1(v6, p5);
        l__Call__2("AddClientCommand", p3, p4, v6);
    end
};
