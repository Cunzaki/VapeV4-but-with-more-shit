-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Character.Controller.Visual.Beacon
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Workspace__1 = game:GetService("Workspace");
local u1 = {};
u1.__index = u1;
function u1.new() --[[ Line: 22 ]]
    -- upvalues: u1 (copy), l__Workspace__1 (copy)
    setmetatable({}, u1);
    local v2 = Instance.new("Part");
    v2.Transparency = 1;
    v2.Material = Enum.Material.Neon;
    v2.Anchored = true;
    v2.CanCollide = false;
    v2.CanQuery = false;
    v2.Size = Vector3.new(0.5, 0.5, 0.5);
    v2.Shape = Enum.PartType.Ball;
    v2.Parent = l__Workspace__1.CurrentCamera;
    local v3 = Instance.new("ImageHandleAdornment");
    v3.Adornee = v2;
    v3.Size = Vector2.new(2, 2);
    v3.Image = "rbxasset://textures/ui/VR/VRPointerDiscBlue.png";
    v3.Visible = false;
    v3.Parent = v2;
    local v4 = Instance.new("ImageHandleAdornment");
    v4.Adornee = v2;
    v4.Size = Vector2.new(2, 2);
    v4.Image = "rbxasset://textures/ui/VR/VRPointerDiscBlue.png";
    v4.Visible = false;
    v4.Parent = v2;
    return setmetatable({
        Sphere = v2,
        ConstantRing = v3,
        MovingRing = v4
    }, u1);
end;
function u1.Update(p5, p6, p7) --[[ Line: 63 ]]
    local v8 = tick() * 2 * 2;
    local v9 = -math.cos(v8) / 8 + 0.4;
    local v10 = 2 * (tick() * 2 % 3.141592653589793) / 3.141592653589793;
    p5.Sphere.CFrame = p6 * CFrame.new(0, v9, 0);
    p5.ConstantRing.CFrame = CFrame.new(0, -v9, 0) * CFrame.Angles(1.5707963267948966, 0, 0);
    p5.MovingRing.CFrame = CFrame.new(0, -v9, 0) * CFrame.Angles(1.5707963267948966, 0, 0);
    p5.MovingRing.Transparency = v10 / 2;
    p5.MovingRing.Size = Vector2.new(v10, v10);
    local v11 = Color3.fromRGB(0, 170, 0);
    if p7 then
        local v12 = p7:FindFirstChild("VRBeaconColor");
        if v12 then
            v11 = v12.Value;
        elseif (p7:IsA("Seat") or p7:IsA("VehicleSeat")) and not p7.Disabled then
            v11 = Color3.fromRGB(0, 170, 255);
        end;
    end;
    p5.Sphere.Color = v11;
    p5.Sphere.Transparency = 0;
    p5.ConstantRing.Visible = true;
    p5.MovingRing.Visible = true;
end;
function u1.Hide(p13) --[[ Line: 96 ]]
    p13.Sphere.Transparency = 1;
    p13.ConstantRing.Visible = false;
    p13.MovingRing.Visible = false;
end;
function u1.Destroy(p14) --[[ Line: 106 ]]
    p14.Sphere:Destroy();
end;
return u1;
