-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__find__1 = table.find;
local l__insert__2 = table.insert;
local l__remove__3 = table.remove;
local v1 = _G.obtain("Class")();
function v1.Call(p2, ...) --[[ Line: 9 ]]
    local l__List__4 = p2.List;
    for v3 = 1, #l__List__4 do
        l__List__4[v3](...);
    end;
    return p2;
end;
function v1.Add(p4, p5) --[[ Line: 17 ]]
    -- upvalues: l__insert__2 (copy)
    if p4.Init then
        p4.Init(p5);
    end;
    l__insert__2(p4.List, p5);
    return p4;
end;
function v1.Remove(p6, p7) --[[ Line: 25 ]]
    -- upvalues: l__find__1 (copy), l__remove__3 (copy)
    local l__List__5 = p6.List;
    local v8 = l__find__1(l__List__5, p7);
    if v8 then
        l__remove__3(l__List__5, v8);
    end;
    return p6;
end;
function v1.Constructor(p9) --[[ Line: 34 ]]
    p9.List = {};
end;
return v1;
