-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.UI.R6Message
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__Parent__3 = script.Parent.Parent;
local l__NexusButton__4 = require(l__Parent__3:WaitForChild("Packages"):WaitForChild("NexusButton"));
local l__NexusVRCore__5 = require(l__Parent__3:WaitForChild("Packages"):WaitForChild("NexusVRCore"));
local u1 = l__NexusButton__4.TextButtonFactory.CreateDefault(Color3.fromRGB(0, 170, 255));
u1:SetDefault("Theme", "RoundedCorners");
local l__ScreenGui3D__6 = l__NexusVRCore__5.ScreenGui3D;
local u2 = {};
u2.__index = u2;
function u2.new() --[[ Line: 29 ]]
    -- upvalues: l__ScreenGui3D__6 (copy), u2 (copy), u1 (copy), l__Players__1 (copy)
    local u3 = l__ScreenGui3D__6.new();
    u3.ResetOnSpawn = false;
    u3.Enabled = false;
    u3.CanvasSize = Vector2.new(500, 500);
    u3.FieldOfView = 0;
    u3.Easing = 0.25;
    local u4 = setmetatable({
        ScreenGui = u3
    }, u2);
    local v5 = Instance.new("ImageLabel");
    v5.BackgroundTransparency = 1;
    v5.Size = UDim2.new(0.4, 0, 0.4, 0);
    v5.Position = UDim2.new(0.3, 0, -0.1, 0);
    v5.Image = "http://www.roblox.com/asset/?id=1499731139";
    v5.Parent = u3:GetContainer();
    local v6 = Instance.new("TextLabel");
    v6.BackgroundTransparency = 1;
    v6.Size = UDim2.new(0.8, 0, 0.1, 0);
    v6.Position = UDim2.new(0.1, 0, 0.25, 0);
    v6.Font = Enum.Font.SourceSansBold;
    v6.Text = "R6 Not Supported";
    v6.TextScaled = true;
    v6.TextColor3 = Color3.fromRGB(255, 255, 255);
    v6.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
    v6.TextStrokeTransparency = 0;
    v6.Parent = u3:GetContainer();
    local v7 = Instance.new("TextLabel");
    v7.BackgroundTransparency = 1;
    v7.Size = UDim2.new(0.8, 0, 0.25, 0);
    v7.Position = UDim2.new(0.1, 0, 0.4, 0);
    v7.Font = Enum.Font.SourceSansBold;
    v7.Text = "Nexus VR Character Model does not support using R6. Use R15 instead.";
    v7.TextScaled = true;
    v7.TextColor3 = Color3.fromRGB(255, 255, 255);
    v7.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
    v7.TextStrokeTransparency = 0;
    v7.Parent = u3:GetContainer();
    local v8, v9 = u1:Create();
    v8.Size = UDim2.new(0.3, 0, 0.1, 0);
    v8.Position = UDim2.new(0.35, 0, 0.7, 0);
    v8.Parent = u3:GetContainer();
    v9.Text = "Ok";
    v8.MouseButton1Down:Connect(function() --[[ Line: 82 ]]
        -- upvalues: u4 (copy), u3 (copy)
        u4:SetOpen(false);
        u3:Destroy();
    end);
    u3.Parent = l__Players__1.LocalPlayer:WaitForChild("PlayerGui");
    return u4;
end;
function u2.SetOpen(p10, p11) --[[ Line: 95 ]]
    -- upvalues: l__RunService__2 (copy)
    local v12 = p11 and 0 or 0.6981317007977318;
    local v13 = p11 and 0.6981317007977318 or 0;
    if p11 then
        p10.ScreenGui.Enabled = true;
    end;
    local v14 = tick();
    while tick() - v14 < 0.25 do
        local v15 = ((tick() - v14) / 0.25 - 0.5) * 3.141592653589793;
        local v16 = math.sin(v15) / 2 + 0.5;
        p10.ScreenGui.FieldOfView = v12 + (v13 - v12) * v16;
        l__RunService__2.RenderStepped:Wait();
    end;
    if v13 == 0 then
        p10.ScreenGui.Enabled = false;
    end;
end;
function u2.Open(p17) --[[ Line: 122 ]]
    p17:SetOpen(true);
end;
return u2;
