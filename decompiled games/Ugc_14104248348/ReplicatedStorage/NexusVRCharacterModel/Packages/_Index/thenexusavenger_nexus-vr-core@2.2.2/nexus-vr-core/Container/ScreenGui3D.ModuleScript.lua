-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_nexus-vr-core@2.2.2.nexus-vr-core.Container.ScreenGui3D
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Workspace__1 = game:GetService("Workspace");
local l__RunService__2 = game:GetService("RunService");
local l__NexusInstance__3 = require(script.Parent.Parent:WaitForChild("Packages"):WaitForChild("NexusInstance"));
local l__BaseScreenGui__4 = require(script.Parent:WaitForChild("BaseScreenGui"));
local v1 = {
    ClassName = "ScreenGui3D"
};
v1.__index = v1;
setmetatable(v1, l__BaseScreenGui__4);
function v1.__new(u2) --[[ Line: 27 ]]
    -- upvalues: l__BaseScreenGui__4 (copy), l__Workspace__1 (copy), l__RunService__2 (copy)
    l__BaseScreenGui__4.__new(u2, Instance.new("SurfaceGui"));
    local v3 = l__Workspace__1.CurrentCamera:FindFirstChild("NexusVRCoreContainer");
    if not v3 then
        v3 = Instance.new("Folder");
        v3.Name = "NexusVRCoreContainer";
        v3.Parent = l__Workspace__1.CurrentCamera;
    end;
    local v4 = Instance.new("Part");
    v4.Transparency = 1;
    v4.Anchored = true;
    v4.CanCollide = false;
    v4.Parent = v3;
    u2.Adornee = v4;
    u2.Face = Enum.NormalId.Back;
    u2.AlwaysOnTop = true;
    u2:OnPropertyChanged("PointingEnabled", function() --[[ Line: 47 ]]
        -- upvalues: u2 (copy)
        local l__Adornee__5 = u2.Adornee;
        local l__Enabled__6 = u2.Enabled;
        if l__Enabled__6 then
            l__Enabled__6 = u2.PointingEnabled;
        end;
        l__Adornee__5.CanQuery = l__Enabled__6;
    end);
    u2:OnPropertyChanged("Enabled", function() --[[ Line: 50 ]]
        -- upvalues: u2 (copy)
        local l__Adornee__7 = u2.Adornee;
        local l__Enabled__8 = u2.Enabled;
        if l__Enabled__8 then
            l__Enabled__8 = u2.PointingEnabled;
        end;
        l__Adornee__7.CanQuery = l__Enabled__8;
    end);
    u2:DisableChangeReplication("DisplayOrder");
    u2:DisableChangeReplication("IgnoreGuiInset");
    u2:DisableChangeReplication("LastRotation");
    u2.LastRotation = CFrame.new(l__Workspace__1.CurrentCamera:GetRenderCFrame().Position):Inverse() * l__Workspace__1.CurrentCamera:GetRenderCFrame();
    u2:OnPropertyChanged("Depth", function() --[[ Line: 61 ]]
        -- upvalues: u2 (copy)
        u2:UpdateSize();
    end);
    u2:OnPropertyChanged("FieldOfView", function() --[[ Line: 64 ]]
        -- upvalues: u2 (copy)
        u2:UpdateSize();
    end);
    u2:OnPropertyChanged("CanvasSize", function(_) --[[ Line: 67 ]]
        -- upvalues: u2 (copy)
        u2:UpdateSize();
    end);
    u2:UpdateSize();
    u2:DisableChangeReplication("UpdateEvent");
    if l__RunService__2:IsClient() then
        u2.UpdateEvent = l__RunService__2.RenderStepped:Connect(function(p5) --[[ Line: 75 ]]
            -- upvalues: u2 (copy)
            if u2.Enabled then
                u2:UpdateCFrame(p5);
            end;
        end);
    end;
end;
function v1.UpdateSize(p6) --[[ Line: 86 ]]
    local v7 = math.tan(p6.FieldOfView / 2) * 2 * p6.Depth;
    local l__CanvasSize__9 = p6.CanvasSize;
    if l__CanvasSize__9.Y <= l__CanvasSize__9.X then
        p6.Adornee.Size = Vector3.new(v7, v7 * (p6.CanvasSize.Y / p6.CanvasSize.X), 0);
    else
        p6.Adornee.Size = Vector3.new(v7 * (p6.CanvasSize.X / p6.CanvasSize.Y), v7, 0);
    end;
    p6.CanvasSize = p6.CanvasSize;
end;
function v1.UpdateCFrame(p8, p9) --[[ Line: 100 ]]
    -- upvalues: l__Workspace__1 (copy)
    local v10 = p9 or p8.Easing;
    local v11 = l__Workspace__1.CurrentCamera:GetRenderCFrame();
    local v12 = CFrame.new(v11.Position):Inverse() * v11;
    if p8.Easing == 0 then
        p8.LastRotation = v12;
    else
        p8.LastRotation = p8.LastRotation:Lerp(v12, (math.clamp(v10 / p8.Easing, 0, 1)));
    end;
    p8.Adornee.CFrame = CFrame.new(v11.Position) * p8.LastRotation * p8.RotationOffset * CFrame.new(0, 0, -p8.Depth);
end;
function v1.Destroy(p13) --[[ Line: 119 ]]
    -- upvalues: l__BaseScreenGui__4 (copy)
    l__BaseScreenGui__4.Destroy(p13);
    if p13.UpdateEvent then
        p13.UpdateEvent:Disconnect();
        p13.UpdateEvent = nil;
    end;
    p13.Adornee:Destroy();
end;
return l__NexusInstance__3.ToInstance(v1);
