-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
return function(p1) --[[ Line: 2 ]]
    -- upvalues: l__LocalPlayer__1 (copy)
    if p1 == "Local" then
        return l__LocalPlayer__1;
    else
        return p1;
    end;
end;
