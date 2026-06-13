-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Mirror.Reflect
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return function(p1, p2) --[[ Name: reflectCFrame, Line 5 ]]
    local l__p__1 = p2.p;
    local l__LookVector__2 = p2.LookVector;
    local v3 = p1.p - l__p__1;
    local v4 = l__p__1 + (v3 - 2 * l__LookVector__2 * v3:Dot(l__LookVector__2));
    local l__RightVector__3 = p1.RightVector;
    local v5 = -(l__RightVector__3 - 2 * l__LookVector__2 * l__RightVector__3:Dot(l__LookVector__2));
    local l__UpVector__4 = p1.UpVector;
    local v6 = l__UpVector__4 - 2 * l__LookVector__2 * l__UpVector__4:Dot(l__LookVector__2);
    local v7 = -p1.LookVector;
    local v8 = v7 - 2 * l__LookVector__2 * v7:Dot(l__LookVector__2);
    return CFrame.fromMatrix(v4, v5, v6, v8);
end;
