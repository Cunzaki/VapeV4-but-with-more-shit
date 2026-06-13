-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Character.Controller.Visual.Arc
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Workspace__1 = game:GetService("Workspace");
local l__Players__2 = game:GetService("Players");
local l__FindCollidablePartOnRay__3 = require(script.Parent.Parent.Parent.Parent:WaitForChild("Util"):WaitForChild("FindCollidablePartOnRay"));
local u1 = {};
u1.__index = u1;
function u1.new() --[[ Line: 27 ]]
    -- upvalues: u1 (copy)
    local v2 = setmetatable({
        BeamParts = {}
    }, u1);
    v2:Hide();
    return v2;
end;
function u1.Update(p3, p4) --[[ Line: 39 ]]
    -- upvalues: l__Workspace__1 (copy), l__FindCollidablePartOnRay__3 (copy), l__Players__2 (copy)
    local l__Position__4 = p4.Position;
    local v5 = math.atan2(-p4.LookVector.X, -p4.LookVector.Z);
    local v6 = math.asin(p4.LookVector.Y);
    local v7 = v6 + 1.0471975511965976 * (1.5707963267948966 - math.abs(v6)) / 1.5707963267948966;
    local v8 = CFrame.new(l__Position__4) * CFrame.Angles(0, v5, 0);
    local v9 = math.tan(v7) / -0.4;
    local v10 = v9 ^ 2 * -0.2;
    for v11 = 0, 99 do
        local l__Position__5 = (v8 * CFrame.new(0, (v11 + v9) ^ 2 * -0.2 - v10, v11 * -2)).Position;
        local l__Position__6 = (v8 * CFrame.new(0, (v11 + 1 + v9) ^ 2 * -0.2 - v10, (v11 + 1) * -2)).Position;
        if not p3.BeamParts[v11] then
            p3.BeamParts[v11] = Instance.new("Part");
            p3.BeamParts[v11].Transparency = 1;
            p3.BeamParts[v11].Size = Vector3.new(0, 0, 0);
            p3.BeamParts[v11].Anchored = true;
            p3.BeamParts[v11].CanCollide = false;
            p3.BeamParts[v11].CanQuery = false;
            p3.BeamParts[v11].Parent = l__Workspace__1.CurrentCamera;
            local v12 = Instance.new("Attachment");
            v12.Name = "BeamAttachment";
            v12.CFrame = CFrame.Angles(0, 0, 1.5707963267948966);
            v12.Parent = p3.BeamParts[v11];
        end;
        if not p3.BeamParts[v11 + 1] then
            p3.BeamParts[v11 + 1] = Instance.new("Part");
            p3.BeamParts[v11 + 1].Transparency = 1;
            p3.BeamParts[v11 + 1].Size = Vector3.new(0, 0, 0);
            p3.BeamParts[v11 + 1].Anchored = true;
            p3.BeamParts[v11 + 1].CanCollide = false;
            p3.BeamParts[v11 + 1].CanQuery = false;
            p3.BeamParts[v11 + 1].Parent = l__Workspace__1.CurrentCamera;
            local v13 = Instance.new("Attachment");
            v13.Name = "BeamAttachment";
            v13.CFrame = CFrame.Angles(0, 0, 1.5707963267948966);
            v13.Parent = p3.BeamParts[v11 + 1];
            local v14 = Instance.new("Beam");
            v14.Name = "Beam";
            v14.Attachment0 = p3.BeamParts[v11].BeamAttachment;
            v14.Attachment1 = v13;
            v14.Segments = 1;
            v14.Width0 = 0.1;
            v14.Width1 = 0.1;
            v14.Parent = p3.BeamParts[v11 + 1];
        end;
        local v15 = l__FindCollidablePartOnRay__3;
        local v16 = l__Position__6 - l__Position__5;
        local l__LocalPlayer__7 = l__Players__2.LocalPlayer;
        if l__LocalPlayer__7 then
            l__LocalPlayer__7 = l__Players__2.LocalPlayer.Character;
        end;
        local v17 = l__Players__2.LocalPlayer and l__Players__2.LocalPlayer.Character;
        if v17 then
            v17 = l__Players__2.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
        end;
        local v18, v19 = v15(l__Position__5, v16, l__LocalPlayer__7, v17);
        p3.BeamParts[v11].CFrame = CFrame.new(l__Position__5) * CFrame.Angles(0, v5, 0);
        p3.BeamParts[v11 + 1].Beam.Enabled = true;
        if v18 then
            p3.BeamParts[v11 + 1].CFrame = CFrame.new(v19);
            for v20 = 0, v11 do
                p3.BeamParts[v20 + 1].Beam.Color = ColorSequence.new(Color3.fromRGB(0, 170, 255));
            end;
            for v21 = v11 + 1, #p3.BeamParts - 1 do
                p3.BeamParts[v21 + 1].Beam.Enabled = false;
            end;
            return v18, v19;
        end;
        p3.BeamParts[v11 + 1].CFrame = CFrame.new(l__Position__6);
    end;
    for v22 = 0, #p3.BeamParts - 1 do
        p3.BeamParts[v22 + 1].Beam.Color = ColorSequence.new(Color3.fromRGB(200, 0, 0));
    end;
    return nil, nil;
end;
function u1.Hide(p23) --[[ Line: 128 ]]
    for v24 = 0, #p23.BeamParts - 1 do
        p23.BeamParts[v24 + 1].Beam.Enabled = false;
    end;
end;
function u1.Destroy(p25) --[[ Line: 137 ]]
    for _, v26 in p25.BeamParts do
        v26:Destroy();
    end;
    p25.BeamParts = {};
end;
return u1;
