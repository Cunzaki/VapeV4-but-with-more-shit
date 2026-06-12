-- Decompiled with Potassium's decompiler.

return function(p1, p2) --[[ Line: 1 ]]
    if p1 == nil then
        return nil;
    end;
    if p2 == nil then
        return nil;
    end;
    local l__Size__1 = p1.Size;
    local l__p__2 = p1.CFrame.p;
    local v3 = l__p__2 + Vector3.new(-l__Size__1.X / 2, 0, 0);
    local v4 = l__p__2 + Vector3.new(l__Size__1.X / 2, 0, 0);
    local v5 = l__p__2 + Vector3.new(0, 0, -l__Size__1.Z / 2);
    local v6 = l__p__2 + Vector3.new(0, 0, l__Size__1.Z / 2);
    return p2.CFrame.p.x >= v3.X and p2.CFrame.p.x <= v4.X and (p2.CFrame.p.z >= v5.Z and p2.CFrame.p.z <= v6.Z and true or false) and true or false;
end;