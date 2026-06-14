-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.UI.View.SettingsView
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__UserInputService__1 = game:GetService("UserInputService");
local l__VRService__2 = game:GetService("VRService");
local l__Parent__3 = script.Parent.Parent.Parent;
local l__NexusButton__4 = require(l__Parent__3:WaitForChild("Packages"):WaitForChild("NexusButton"));
local u1 = require(l__Parent__3:WaitForChild("State"):WaitForChild("CameraService")).GetInstance();
local u2 = require(l__Parent__3:WaitForChild("State"):WaitForChild("ControlService")).GetInstance();
local u3 = require(l__Parent__3:WaitForChild("State"):WaitForChild("DefaultCursorService")).GetInstance();
local u4 = require(l__Parent__3:WaitForChild("State"):WaitForChild("Settings")).GetInstance();
local u5 = require(l__Parent__3:WaitForChild("State"):WaitForChild("VRInputService")).GetInstance();
require(l__Parent__3:WaitForChild("UI"):WaitForChild("View"):WaitForChild("ApiBaseView"));
local u6 = l__NexusButton__4.TextButtonFactory.CreateDefault(Color3.fromRGB(0, 170, 255));
u6:SetDefault("Theme", "RoundedCorners");
local u7 = {};
u7.__index = u7;
function u7.new(p8) --[[ Line: 31 ]]
    -- upvalues: u7 (copy), l__VRService__2 (copy), u4 (copy), u1 (copy), u2 (copy), u3 (copy), u6 (copy), u5 (copy), l__UserInputService__1 (copy)
    p8:AddBackground();
    local v9 = setmetatable({}, u7);
    local v10 = p8:GetContainer();
    local v11 = Instance.new("ImageLabel");
    v11.BackgroundTransparency = 1;
    v11.Size = UDim2.new(0.4, 0, 0.4, 0);
    v11.Position = UDim2.new(0.3, 0, -0.075, 0);
    v11.Image = "http://www.roblox.com/asset/?id=1499731139";
    v11.Parent = v10;
    local v12 = Instance.new("TextLabel");
    v12.BackgroundTransparency = 1;
    v12.Size = UDim2.new(0.8, 0, 0.1, 0);
    v12.Position = UDim2.new(0.1, 0, 0.225, 0);
    v12.Font = Enum.Font.SourceSansBold;
    v12.Text = "Nexus VR Character Model";
    v12.TextScaled = true;
    v12.TextColor3 = Color3.fromRGB(255, 255, 255);
    v12.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
    v12.TextStrokeTransparency = 0;
    v12.Parent = v10;
    local v13 = Instance.new("Frame");
    v13.BackgroundTransparency = 1;
    v13.Size = UDim2.new(0.8, 0, 0.11, 0);
    v13.Position = UDim2.new(0.1, 0, 0.325, 0);
    v13.Parent = v10;
    v9:PopulateSettingsFrame(v13, "View", function() --[[ Line: 64 ]]
        -- upvalues: l__VRService__2 (ref), u4 (ref)
        return l__VRService__2.AvatarGestures and { "Default" } or (u4:GetSetting("Camera.EnabledCameraOptions") or {});
    end, function() --[[ Line: 69 ]]
        -- upvalues: u1 (ref)
        return u1.ActiveCamera;
    end, function(p14) --[[ Line: 71 ]]
        -- upvalues: u1 (ref)
        u1:SetActiveCamera(p14);
    end);
    local v15 = Instance.new("Frame");
    v15.BackgroundTransparency = 1;
    v15.Size = UDim2.new(0.8, 0, 0.11, 0);
    v15.Position = UDim2.new(0.1, 0, 0.475, 0);
    v15.Parent = v10;
    v9:PopulateSettingsFrame(v15, "Control", "Movement.EnabledMovementMethods", function() --[[ Line: 80 ]]
        -- upvalues: u2 (ref)
        return u2.ActiveController;
    end, function(p16) --[[ Line: 82 ]]
        -- upvalues: u2 (ref)
        u2:SetActiveController(p16);
    end);
    local v17 = Instance.new("Frame");
    v17.BackgroundTransparency = 1;
    v17.Size = UDim2.new(0.8, 0, 0.11, 0);
    v17.Position = UDim2.new(0.1, 0, 0.625, 0);
    v17.Parent = v10;
    v9:PopulateSettingsFrame(v17, "Roblox VR Cursor", function() --[[ Line: 91 ]]
        -- upvalues: u3 (ref)
        return u3.CursorOptionsList;
    end, function() --[[ Line: 93 ]]
        -- upvalues: u3 (ref)
        return u3.CurrentCursorState;
    end, function(p18) --[[ Line: 95 ]]
        -- upvalues: u3 (ref)
        u3:SetCursorState(p18);
    end);
    local v19, v20 = u6:Create();
    v19.Size = UDim2.new(0.4, 0, 0.075, 0);
    v19.Position = UDim2.new(l__VRService__2.AvatarGestures and 0.3 or 0.075, 0, 0.85, 0);
    v19.SizeConstraint = Enum.SizeConstraint.RelativeYY;
    v19.Parent = v10;
    v20.Text = "Recenter";
    v19.MouseButton1Down:Connect(function() --[[ Line: 107 ]]
        -- upvalues: l__VRService__2 (ref), u5 (ref), l__UserInputService__1 (ref)
        if l__VRService__2.AvatarGestures then
            l__UserInputService__1:RecenterUserHeadCFrame();
        else
            u5:Recenter();
        end;
    end);
    if not l__VRService__2.AvatarGestures then
        local v21, v22 = u6:Create();
        v21.Size = UDim2.new(0.4, 0, 0.075, 0);
        v21.Position = UDim2.new(0.525, 0, 0.85, 0);
        v21.SizeConstraint = Enum.SizeConstraint.RelativeYY;
        v21.Parent = v10;
        v22.Text = " Set Eye Level ";
        v21.MouseButton1Down:Connect(function() --[[ Line: 123 ]]
            -- upvalues: u5 (ref)
            u5:SetEyeLevel();
        end);
    end;
    local v23 = Instance.new("TextLabel");
    v23.BackgroundTransparency = 1;
    v23.AnchorPoint = Vector2.new(0.5, 1);
    v23.Size = UDim2.new(0.8, 0, 0.04, 0);
    v23.Position = UDim2.new(0.5, 0, 1, 0);
    v23.Font = Enum.Font.SourceSansBold;
    v23.Text = `Version {u4:GetSetting("Version.Tag")} ({u4:GetSetting("Version.Commit")})`;
    v23.TextScaled = true;
    v23.TextColor3 = Color3.fromRGB(255, 255, 255);
    v23.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
    v23.TextStrokeTransparency = 0;
    v23.Parent = v10;
    return u7;
end;
function u7.PopulateSettingsFrame(_, p24, p25, u26, u27, u28) --[[ Line: 149 ]]
    -- upvalues: u4 (copy), u6 (copy)
    local v29;
    if typeof(u26) == "string" then
        local u30 = u26;
        u26 = function() --[[ Line: 154 ]]
            -- upvalues: u4 (ref), u30 (ref)
            return u4:GetSetting(u30) or {};
        end;
        v29 = u30;
    else
        v29 = nil;
    end;
    local u31, v32 = u6:Create();
    u31.Size = UDim2.new(1, 0, 1, 0);
    u31.Position = UDim2.new(0, 0, 0, 0);
    u31.SizeConstraint = Enum.SizeConstraint.RelativeYY;
    u31.Parent = p24;
    v32.Text = "<";
    local u33, v34 = u6:Create();
    u33.AnchorPoint = Vector2.new(1, 0);
    u33.Size = UDim2.new(1, 0, 1, 0);
    u33.Position = UDim2.new(1, 0, 0, 0);
    u33.SizeConstraint = Enum.SizeConstraint.RelativeYY;
    u33.Parent = p24;
    v34.Text = ">";
    local v35 = Instance.new("TextLabel");
    v35.BackgroundTransparency = 1;
    v35.Size = UDim2.new(0.8, 0, 0.5, 0);
    v35.Position = UDim2.new(0.1, 0, -0.0125, 0);
    v35.Font = Enum.Font.SourceSansBold;
    v35.Text = p25;
    v35.TextScaled = true;
    v35.TextColor3 = Color3.fromRGB(255, 255, 255);
    v35.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
    v35.TextStrokeTransparency = 0;
    v35.Parent = p24;
    local u36 = Instance.new("TextLabel");
    u36.BackgroundTransparency = 1;
    u36.Size = UDim2.new(0.6, 0, 0.7, 0);
    u36.Position = UDim2.new(0.2, 0, 0.3, 0);
    u36.Font = Enum.Font.SourceSansBold;
    u36.TextScaled = true;
    u36.TextColor3 = Color3.fromRGB(255, 255, 255);
    u36.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
    u36.TextStrokeTransparency = 0;
    u36.Parent = p24;
    local function u45(p37) --[[ Line: 201 ]]
        -- upvalues: u27 (copy), u26 (ref), u31 (copy), u33 (copy), u36 (copy), u28 (copy)
        local v38 = u27();
        local v39 = u26();
        local v40 = 1;
        for v41, v42 in v39 do
            if v42 == v38 then
                v40 = v41;
                break;
            end;
        end;
        if p37 and p37 ~= 0 then
            local v43 = v40 + p37;
            local v44 = v43 <= 0 and #v39 or v43;
            v40 = #v39 < v44 and 1 or v44;
        end;
        u31.Visible = #v39 > 1;
        u33.Visible = #v39 > 1;
        u36.Text = v39[v40] or "(N/A)";
        if p37 and (p37 ~= 0 and v39[v40]) then
            u28(v39[v40]);
        end;
    end;
    local u46 = true;
    if v29 then
        u4:GetSettingsChangedSignal(v29):Connect(u45);
    end;
    u31.MouseButton1Down:Connect(function() --[[ Line: 242 ]]
        -- upvalues: u46 (ref), u45 (copy)
        if u46 then
            u46 = false;
            u45(-1);
            task.wait();
            u46 = true;
        end;
    end);
    u33.MouseButton1Down:Connect(function() --[[ Line: 249 ]]
        -- upvalues: u46 (ref), u45 (copy)
        if u46 then
            u46 = false;
            u45(1);
            task.wait();
            u46 = true;
        end;
    end);
    u45();
end;
return u7;
