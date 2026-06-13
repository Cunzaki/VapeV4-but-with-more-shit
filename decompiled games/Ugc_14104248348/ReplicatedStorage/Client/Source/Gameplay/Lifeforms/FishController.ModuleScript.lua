-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Lifeforms.FishController
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__Assets__3 = l__ReplicatedStorage__1.Assets;
local l__Library__4 = l__Assets__3.Library;
local u1 = {};
u1.__index = u1;
local l__Database__5 = require(l__Library__4.Database);
local l__FishBehavior__6 = require(script.FishBehavior);
u1.Fishes = {};
u1.Connections = {};
function u1.new(p2) --[[ Line: 16 ]]
    -- upvalues: l__Database__5 (copy), u1 (copy)
    local v3 = {
        Animations = {},
        Node = p2,
        Data = l__Database__5[p2.Name]
    };
    if v3.Data then
        v3.Attributes = p2:GetAttributes();
        return u1.AddFish(v3);
    else
        warn(string.format("No data found for %s", p2.Name));
        return false;
    end;
end;
function u1.AddFish(p4) --[[ Line: 31 ]]
    -- upvalues: u1 (copy), l__Assets__3 (copy), l__FishBehavior__6 (copy), l__CollectionService__2 (copy)
    if not p4.Data then
        warn(string.format("No data found for %s", p4.Node.Name));
        return false;
    end;
    u1.Fishes[p4.Node] = p4;
    p4.Folder = Instance.new("Folder", workspace);
    p4.Folder.Name = p4.Node.Name;
    p4.Boids = {};
    p4.Clonable = l__Assets__3["Fish Models"]:FindFirstChild(p4.Node.Name, true);
    assert(p4.Clonable, string.format("No clonable model found in Assets for %s", p4.Node.Name));
    local v5 = Instance.new("Animation");
    v5.AnimationId = p4.Data.Animations.Swim;
    for v6 = 1, p4.Attributes.SchoolSize do
        local v7 = p4.Clonable:Clone();
        v7.Name = string.format("%s %d", p4.Node.Name, v6);
        v7.Parent = p4.Folder;
        v7:PivotTo(p4.Node.CFrame);
        table.insert(p4.Animations, v7.AnimationController:LoadAnimation(v5));
        p4.Boids[v6] = l__FishBehavior__6.CreateBoid(v7);
        l__CollectionService__2:AddTag(v7, "LocalFish");
        v7:SetAttribute("FishID", p4.ID);
    end;
    p4.Group = l__FishBehavior__6.new(p4);
    for v8 = 1, #p4.Boids do
        p4.Group:AddBoid(p4.Boids[v8]);
    end;
    p4.Node.Transparency = 1;
    p4.Node.CanCollide = false;
    return p4;
end;
return u1;
