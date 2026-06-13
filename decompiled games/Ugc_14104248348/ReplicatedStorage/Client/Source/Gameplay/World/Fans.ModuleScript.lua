-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.Fans
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local u1 = {
    Tag = "FanBlade",
    RotationsPerSecond = 7200,
    FanParts = {}
};
function u1.AddFan(p2) --[[ Line: 14 ]]
    -- upvalues: u1 (copy)
    local l__FanParts__3 = u1.FanParts;
    local v3 = { p2, p2:GetAttribute("Speed") or 1 };
    table.insert(l__FanParts__3, v3);
end;
function u1.Setup() --[[ Line: 18 ]]
    -- upvalues: l__CollectionService__1 (copy), u1 (copy), l__RunService__2 (copy)
    for _, v4 in l__CollectionService__1:GetTagged(u1.Tag) do
        u1.AddFan(v4);
    end;
    l__CollectionService__1:GetInstanceAddedSignal(u1.Tag):Connect(function(p5) --[[ Line: 23 ]]
        -- upvalues: u1 (ref)
        u1.AddFan(p5);
    end);
    l__RunService__2.Heartbeat:Connect(function(p6) --[[ Line: 27 ]]
        -- upvalues: u1 (ref)
        for _, v7 in u1.FanParts do
            v7[1]:PivotTo(v7[1]:GetPivot() * CFrame.fromOrientation(0, math.rad(u1.RotationsPerSecond * p6 * v7[2]), 0));
        end;
    end);
end;
return u1;
