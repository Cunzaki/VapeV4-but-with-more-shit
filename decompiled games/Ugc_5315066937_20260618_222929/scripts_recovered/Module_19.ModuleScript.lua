-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = {};
local v2 = l__obtain__1("LuCAS-Base");
local l__Evaluate__2 = v2.Evaluate;
local l__Derivative__3 = v2.Derivative;
v1.Evaluate = l__Evaluate__2;
v1.Derivative = l__Derivative__3;
local v3 = l__obtain__1("LuCAS-Constructor");
local l__Compile__4 = v3.Compile;
local l__Metatable__5 = v3.Metatable;
local l__DefaultConstructor__6 = v3.DefaultConstructor;
v1.Compile = l__Compile__4;
l__obtain__1("LuCAS-Core");
l__obtain__1("LuCAS-Logic");
l__obtain__1("LuCAS-Vector");
l__obtain__1("LuCAS-Quaternion");
l__obtain__1("LuCAS-Extra");
for v4, v5 in next, v3.Constructors do
    v1[v4] = v5;
end;
for v6, _ in next, v2.Evaluates do
    if not v1[v6] then
        v1[v6] = l__DefaultConstructor__6(v6);
    end;
end;
v1.Var = v1.Scalar;
v1.Bool = v1.Boolean;
v1.Func = l__DefaultConstructor__6;
l__Metatable__5.__index = {
    Compile = l__Compile__4,
    Evaluate = function(p7, p8) --[[ Name: Evaluate, Line 44 ]]
        -- upvalues: l__Evaluate__2 (copy), l__Compile__4 (copy)
        return l__Evaluate__2(l__Compile__4(p7), p8);
    end,
    Derivative = function(p9, p10, p11) --[[ Name: Derivative, Line 48 ]]
        -- upvalues: l__Evaluate__2 (copy), l__Derivative__3 (copy), l__Compile__4 (copy)
        if p11 then
            return l__Evaluate__2(l__Derivative__3(l__Compile__4(p9), p10), p11);
        else
            return l__Derivative__3(l__Compile__4(p9), p10);
        end;
    end
};
return v1;
