-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__TextService__1 = game:GetService("TextService");
local l__GetTextSize__2 = l__TextService__1.GetTextSize;
local u2 = Vector2.new((1 / 0), (1 / 0));
function v1.TextSize(p3, p4, p5, p6) --[[ Line: 7 ]]
    -- upvalues: u2 (copy), l__GetTextSize__2 (copy), l__TextService__1 (copy)
    local v7 = l__GetTextSize__2(l__TextService__1, p5, p4, p3, p6 or u2);
    return v7.x, v7.y;
end;
function v1.CharSize(p8, p9, p10) --[[ Line: 14 ]]
    -- upvalues: l__GetTextSize__2 (copy), l__TextService__1 (copy), u2 (copy)
    local v11 = l__GetTextSize__2(l__TextService__1, p10, p9, p8, u2);
    return v11.x, v11.y;
end;
function v1.GetHeight(p12, p13) --[[ Line: 20 ]]
    -- upvalues: l__GetTextSize__2 (copy), l__TextService__1 (copy), u2 (copy)
    return l__GetTextSize__2(l__TextService__1, "|", p13, p12, u2).y;
end;
return v1;
