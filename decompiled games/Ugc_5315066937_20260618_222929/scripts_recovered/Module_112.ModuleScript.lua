-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__fromMatrix__1 = CFrame.fromMatrix;
return function(p1) --[[ Line: 3 ]]
    -- upvalues: l__fromMatrix__1 (copy)
    local v2 = p1:GetAttribute("p");
    local v3 = p1:GetAttribute("x");
    local v4 = p1:GetAttribute("y");
    local v5 = p1:GetAttribute("z");
    if v2 or (v3 or (v4 or v5)) then
        if not (v2 and (v3 and (v4 and v5))) then
            local l__CFrame__2 = p1.CFrame;
            v2 = v2 or l__CFrame__2.p;
            v3 = v3 or l__CFrame__2.XVector;
            v4 = v4 or l__CFrame__2.YVector;
            v5 = v5 or l__CFrame__2.ZVector;
        end;
        p1.CFrame = l__fromMatrix__1(v2, v3, v4, v5);
        p1:SetAttribute("p", nil);
        p1:SetAttribute("x", nil);
        p1:SetAttribute("y", nil);
        p1:SetAttribute("z", nil);
    end;
    return p1.CFrame;
end;
