-- Decompiled from: ReplicatedStorage.Modules.NexusVRBackpack.NexusVRBackpack.UI.Backpack3D
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__ToolGrid__2 = require(script.Parent:WaitForChild("ToolGrid"));
local l__Inventory__3 = require(script.Parent.Parent:WaitForChild("State"):WaitForChild("Inventory"));
local u1 = {};
u1.__index = u1;
function u1.new(p2, p3) --[[ Line: 36 ]]
    -- upvalues: u1 (copy), l__ToolGrid__2 (copy), l__Inventory__3 (copy)
    local u4 = {
        Opened = false
    };
    setmetatable(u4, u1);
    local v5 = Instance.new("SurfaceGui");
    v5.Name = "NexusVRBackpack";
    v5.AlwaysOnTop = true;
    v5.Enabled = false;
    v5.LightInfluence = 0;
    v5.Face = Enum.NormalId.Back;
    v5.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
    v5.PixelsPerStud = 250;
    v5.Parent = p2;
    u4.SurfaceGui = v5;
    local v6 = Instance.new("Part");
    v6.Transparency = 1;
    v6.Size = Vector3.new(0, 0, 0);
    v6.Anchored = true;
    v6.CanCollide = false;
    v6.CanQuery = false;
    v6.Parent = v5;
    v5.Adornee = v6;
    u4.Part = v6;
    local v7 = Instance.new("Frame");
    v7.BackgroundTransparency = 1;
    v7.AnchorPoint = Vector2.new(0.5, 0.5);
    v7.Position = UDim2.new(0.5, 0, 0.5, 0);
    v7.Parent = v5;
    u4.CenterFrame = v7;
    local v8 = Instance.new("Frame");
    v8.BackgroundColor3 = Color3.new(1, 1, 1);
    v8.Size = UDim2.new(0.1, 0, 0.1, 0);
    v8.AnchorPoint = Vector2.new(0.5, 0.5);
    v8.ZIndex = 10;
    v8.Parent = v7;
    u4.Cursor = v8;
    local v9 = Instance.new("UICorner");
    v9.CornerRadius = UDim.new(1, 0);
    v9.Parent = v8;
    local v10 = l__ToolGrid__2.new();
    v10.AdornFrame.Size = UDim2.new(0, 0, 0, 0);
    v10.AdornFrame.Parent = v7;
    u4.ToolGrid = v10;
    local v11 = l__Inventory__3.new(p3);
    u4.Inventory = v11;
    v11.ToolsChanged:Connect(function() --[[ Line: 93 ]]
        -- upvalues: u4 (copy)
        u4:UpdateInventory();
    end);
    u4:UpdateInventory();
    return u4;
end;
function u1.GetFocusedTool(p12) --[[ Line: 105 ]]
    local l__FocusedIcon__4 = p12.ToolGrid.FocusedIcon;
    if l__FocusedIcon__4 then
        l__FocusedIcon__4 = p12.ToolGrid.FocusedIcon.Tool;
    end;
    return l__FocusedIcon__4;
end;
function u1.UpdateInventory(p13) --[[ Line: 112 ]]
    p13.ToolGrid:SetTools(p13.Inventory.Tools);
    local v14 = (#p13.ToolGrid.IconGroups * 2 + 1) * 0.8660254037844386;
    p13.Part.Size = Vector3.new(v14 * 0.5, v14 * 0.5, 0);
    p13.CenterFrame.Size = UDim2.new(1 / v14, 0, 1 / v14, 0);
end;
function u1.UpdateFocusedToolLocalSpace(p15, p16, p17) --[[ Line: 126 ]]
    if p15.Opened then
        local v18 = p15.SurfaceGui.AbsoluteSize.X * p16;
        local v19 = p15.SurfaceGui.AbsoluteSize.Y * p17;
        local v20 = (v18 - p15.CenterFrame.AbsolutePosition.X) / p15.CenterFrame.AbsoluteSize.X;
        local v21 = (v19 - p15.CenterFrame.AbsolutePosition.Y) / p15.CenterFrame.AbsoluteSize.Y;
        p15.Cursor.Position = UDim2.new(v20, 0, v21, 0);
        p15.ToolGrid:UpdateFocusedIcon(v20, v21);
    end;
end;
function u1.UpdateFocusedToolWorldSpace(p22, p23) --[[ Line: 138 ]]
    local v24 = p22.Part.CFrame:Inverse() * CFrame.new(p23);
    local l__Size__5 = p22.Part.Size;
    p22:UpdateFocusedToolLocalSpace(v24.X / l__Size__5.X + 0.5, 0.5 - v24.Y / l__Size__5.Y);
end;
function u1.MoveTo(p25, p26) --[[ Line: 147 ]]
    p25.Part.CFrame = p26;
end;
function u1.Open(p27) --[[ Line: 154 ]]
    -- upvalues: l__TweenService__1 (copy)
    if p27.Opened then
    else
        p27.Opened = true;
        p27.SurfaceGui.Enabled = true;
        l__TweenService__1:Create(p27.ToolGrid.AdornFrame, TweenInfo.new(0.1), {
            Size = UDim2.new(1, 0, 1, 0)
        }):Play();
    end;
end;
function u1.Close(u28) --[[ Line: 166 ]]
    -- upvalues: l__TweenService__1 (copy)
    if u28.Opened then
        u28:UpdateFocusedToolLocalSpace((1 / 0), (1 / 0));
        u28.Opened = false;
        l__TweenService__1:Create(u28.ToolGrid.AdornFrame, TweenInfo.new(0.1), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play();
        task.delay(0.1, function() --[[ Line: 173 ]]
            -- upvalues: u28 (copy)
            if u28.Opened then
            else
                u28.SurfaceGui.Enabled = false;
            end;
        end);
    end;
end;
function u1.Destroy(p29) --[[ Line: 182 ]]
    p29.SurfaceGui:Destroy();
    p29.ToolGrid:Destroy();
    p29.Inventory:Destroy();
end;
return u1;
