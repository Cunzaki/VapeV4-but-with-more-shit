-- Decompiled from: ReplicatedStorage.Modules.Backpack
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
game:GetService("StarterGui");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__LocalPlayer__3 = l__Players__1.LocalPlayer;
local l__Signal__4 = require(l__ReplicatedStorage__2.Modules.Signal);
local u1 = {
    Backpack = {},
    Added = l__Signal__4.new(),
    Removed = l__Signal__4.new(),
    GetEquipped = function() --[[ Name: GetEquipped, Line 17 ]]
        -- upvalues: l__LocalPlayer__3 (copy)
        local l__Character__5 = l__LocalPlayer__3.Character;
        if l__Character__5 then
            l__Character__5 = l__LocalPlayer__3.Character:FindFirstChildWhichIsA("Tool");
        end;
        return l__Character__5;
    end
};
function u1.IterateBackpackItems(p2) --[[ Line: 21 ]]
    -- upvalues: u1 (copy)
    for v3, v4 in u1.Backpack do
        p2({
            Position = v3,
            Tool = v4
        });
    end;
end;
function u1.EquipRawTool(p5) --[[ Line: 30 ]]
    -- upvalues: l__LocalPlayer__3 (copy)
    local v6 = l__LocalPlayer__3.Character:FindFirstChild("Humanoid");
    if v6 ~= nil then
        v6:EquipTool(p5);
    end;
end;
function u1.EquipItem(p7) --[[ Line: 37 ]]
    -- upvalues: l__LocalPlayer__3 (copy)
    if p7.Tool and (p7.Tool.Parent ~= nil and (l__LocalPlayer__3.Character and p7.Tool.Parent ~= l__LocalPlayer__3.Character)) then
        local v8 = l__LocalPlayer__3.Character:FindFirstChild("Humanoid");
        if v8 ~= nil then
            v8:EquipTool(p7.Tool);
        end;
    end;
end;
function u1.CheckNewReferenceExisting(u9) --[[ Line: 47 ]]
    -- upvalues: u1 (copy), l__LocalPlayer__3 (copy)
    for _, v10 in u1.Backpack do
        if v10 == u9 then
            return;
        end;
    end;
    local u11 = #u1.Backpack + 1;
    u9.AncestryChanged:Connect(function() --[[ Line: 56 ]]
        -- upvalues: u9 (copy), u1 (ref), l__LocalPlayer__3 (ref), u11 (copy)
        if u9.Parent == nil or u9.Parent ~= u1.BackpackInstance and u9.Parent ~= l__LocalPlayer__3.Character then
            u1.Removed:Fire({
                Position = u11,
                Tool = u9
            });
            u1.Backpack[u11] = nil;
        end;
    end);
    u1.Backpack[u11] = u9;
    u1.Added:Fire({
        Position = u11,
        Tool = u9
    });
end;
function u1.NewCharacter(p12) --[[ Line: 73 ]]
    -- upvalues: u1 (copy)
    local v13 = p12:FindFirstChildWhichIsA("Tool");
    if v13 then
        u1.CheckNewReferenceExisting(v13);
    end;
    p12.ChildAdded:Connect(function(p14) --[[ Line: 79 ]]
        -- upvalues: u1 (ref)
        if p14:IsA("Tool") then
            u1.CheckNewReferenceExisting(p14);
        end;
    end);
end;
function u1.CheckForBackpack() --[[ Line: 86 ]]
    -- upvalues: l__LocalPlayer__3 (copy), u1 (copy)
    local v15 = l__LocalPlayer__3:FindFirstChild("Backpack") or l__LocalPlayer__3:WaitForChild("Backpack");
    if v15 ~= u1.BackpackInstance then
        u1.Backpack = {};
        u1.BackpackInstance = v15;
        v15.ChildAdded:Connect(u1.CheckNewReferenceExisting);
    end;
end;
function u1.Setup() --[[ Line: 96 ]]
    -- upvalues: l__LocalPlayer__3 (copy), u1 (copy)
    if l__LocalPlayer__3.Character then
        u1.NewCharacter(l__LocalPlayer__3.Character);
    end;
    l__LocalPlayer__3.CharacterAdded:Connect(u1.NewCharacter);
    u1.CheckForBackpack();
    l__LocalPlayer__3.ChildAdded:Connect(u1.CheckForBackpack);
end;
u1.Setup();
return u1;
