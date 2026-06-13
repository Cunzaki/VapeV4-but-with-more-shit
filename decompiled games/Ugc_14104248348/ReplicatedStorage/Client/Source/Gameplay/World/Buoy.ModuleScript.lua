-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.Buoy
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
game:GetService("ReplicatedStorage");
game:GetService("RunService");
local u1 = {
    Tag = "BuoyLight",
    Position = 0
};
function u1.AddFan(u2) --[[ Line: 13 ]]
    -- upvalues: u1 (copy)
    local v3 = u1;
    v3.Position = v3.Position + 1;
    task.wait(u1.Position + math.random(1, 10) / 10);
    local l__Color__2 = u2.Color;
    local function u4() --[[ Line: 20 ]]
        -- upvalues: u2 (copy), l__Color__2 (copy), u4 (ref)
        u2.Color = l__Color__2;
        task.wait(5);
        u2.Color = Color3.new(0, 0, 0);
        task.wait(1);
        task.spawn(u4);
    end;
    task.defer(u4);
end;
function u1.Setup() --[[ Line: 30 ]]
    -- upvalues: l__CollectionService__1 (copy), u1 (copy)
    for _, v5 in l__CollectionService__1:GetTagged(u1.Tag) do
        task.defer(u1.AddFan, v5);
    end;
    l__CollectionService__1:GetInstanceAddedSignal(u1.Tag):Connect(function(p6) --[[ Line: 35 ]]
        -- upvalues: u1 (ref)
        u1.AddFan(p6);
    end);
end;
return u1;
