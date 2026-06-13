-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Legacy.IncorrectNewTools.AnniMask
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local l__Players__2 = game:GetService("Players");
local l__Debris__3 = game:GetService("Debris");
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.SpringVector3);
local u1 = l__Mince__4:Get("ToolHandler");
local u2 = l__Mince__4:GetEvent("SyncState");
l__Players__2.LocalPlayer:GetMouse();
local u7 = {
    Tags = { "Anniversarymask" },
    Animations = {},
    GetMaskPositionOffsetZ = function() --[[ Name: GetMaskPositionOffsetZ, Line 21 ]]
        -- upvalues: l__Players__2 (copy), l__ReplicatedStorage__1 (copy), l__Debris__3 (copy)
        repeat
            task.wait();
        until l__Players__2.LocalPlayer:HasAppearanceLoaded();
        local l__Character__5 = l__Players__2.LocalPlayer.Character;
        l__Character__5:WaitForChild("Head");
        local v3 = Instance.new("Model");
        for _, v4 in l__Character__5:GetDescendants() do
            local v5;
            if v4.Parent:IsA("Accessory") and v4:IsA("BasePart") then
                if v4.Parent.AccessoryType == Enum.AccessoryType.Hat or v4.Parent.AccessoryType == Enum.AccessoryType.Face then
                    v5 = v4:Clone();
                    v5.Parent = v3;
                    v5.Anchored = true;
                end;
            elseif v4:IsA("BasePart") and v4.Name == "Head" then
                v5 = v4:Clone();
                v5.Parent = v3;
                v5.Anchored = true;
            end;
        end;
        v3.Parent = l__ReplicatedStorage__1;
        l__Debris__3:AddItem(v3, 1);
        local _, v6 = v3:GetBoundingBox();
        return CFrame.new(Vector3.new(0, 0, 1) * -(v6.Z / 2 + 0.5));
    end
};
function u7.Setup() --[[ Line: 54 ]]
    -- upvalues: l__Players__2 (copy), u7 (copy), u1 (copy)
    if l__Players__2.LocalPlayer.Character then
        u7.Offset = u7.GetMaskPositionOffsetZ();
    end;
    l__Players__2.LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 59 ]]
        -- upvalues: u7 (ref)
        u7.Offset = u7.GetMaskPositionOffsetZ();
    end);
    u1.Component(u7);
end;
function u7.Update(p8) --[[ Line: 66 ]]
    -- upvalues: u7 (copy), l__Players__2 (copy)
    local l__Part__6 = u7.Tool.Part;
    u7.MaskSpring:SetTarget((game.Players.LocalPlayer.Character.Head.CFrame * u7.Offset).Position);
    local v9 = u7.MaskSpring:Update(p8);
    l__Part__6.CFrame = CFrame.lookAt(v9, l__Players__2.LocalPlayer.Character.Head.Position);
end;
function u7.Equipped(_) --[[ Line: 75 ]]
    -- upvalues: u2 (copy), u7 (copy)
    u2:Fire("AnniMask", u7.Offset or CFrame.new());
end;
function u7.Unequipped(_) --[[ Line: 85 ]]
    -- upvalues: u2 (copy)
    u2:Fire("AnniMask", CFrame.new(17, 17, 17));
end;
return u7;
