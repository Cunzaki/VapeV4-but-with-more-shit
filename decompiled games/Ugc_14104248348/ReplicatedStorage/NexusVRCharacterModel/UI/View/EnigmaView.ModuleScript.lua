-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.UI.View.EnigmaView
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    ["1"] = true,
    ["2"] = true
};
local l__Workspace__1 = game:GetService("Workspace");
local l__Players__2 = game:GetService("Players");
local l__RunService__3 = game:GetService("RunService");
local l__UserInputService__4 = game:GetService("UserInputService");
local l__VRService__5 = game:GetService("VRService");
local l__Parent__6 = script.Parent.Parent.Parent;
local l__Enigma__7 = require(l__Parent__6:WaitForChild("Packages"):WaitForChild("Enigma"));
local l__NexusButton__8 = require(l__Parent__6:WaitForChild("Packages"):WaitForChild("NexusButton"));
local u2 = require(l__Parent__6:WaitForChild("State"):WaitForChild("CharacterService")).GetInstance();
local u3 = require(l__Parent__6:WaitForChild("State"):WaitForChild("EnigmaService")).GetInstance();
local u4 = require(l__Parent__6:WaitForChild("State"):WaitForChild("Settings")).GetInstance();
require(l__Parent__6:WaitForChild("UI"):WaitForChild("View"):WaitForChild("ApiBaseView"));
local u5 = l__NexusButton__8.TextButtonFactory.CreateDefault(Color3.fromRGB(0, 170, 255));
u5:SetDefault("Theme", "RoundedCorners");
local u6 = {};
u6.__index = u6;
function u6.new(u7, u8) --[[ Line: 48 ]]
    -- upvalues: u6 (copy), u4 (copy), u5 (copy), u2 (copy), l__Players__2 (copy), u3 (copy), l__Enigma__7 (copy)
    u7:AddBackground();
    local v9 = u7:GetContainer();
    local v10 = Instance.new("TextLabel");
    v10.BackgroundTransparency = 1;
    v10.Size = UDim2.new(0.9, 0, 0.6, 0);
    v10.Position = UDim2.new(0.05, 0, 0.075, 0);
    v10.Font = Enum.Font.SourceSansBold;
    v10.Text = "";
    v10.RichText = true;
    v10.TextWrapped = true;
    v10.TextColor3 = Color3.fromRGB(255, 255, 255);
    v10.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
    v10.TextStrokeTransparency = 0;
    v10.TextSize = 28;
    v10.TextYAlignment = Enum.TextYAlignment.Top;
    v10.Parent = v9;
    local u11 = setmetatable({
        EnigmaText = v10
    }, u6);
    if u4:GetSetting("Extra.EnigmaEnabled") == false then
        v10.Text = "This game has disabled Enigma.";
        return u11;
    end;
    local v12, u13 = u5:Create();
    v12.Size = UDim2.new(0.5, 0, 0.075, 0);
    v12.Position = UDim2.new(0.25, 0, 0.775, 0);
    v12.SizeConstraint = Enum.SizeConstraint.RelativeYY;
    v12.Parent = v9;
    u13.Text = " Show Trackers ";
    u11.ShowTrackersButton = v12;
    u11.DebugTrackersVisible = false;
    local u14 = true;
    v12.MouseButton1Down:Connect(function() --[[ Line: 89 ]]
        -- upvalues: u14 (ref), u11 (copy), u13 (copy)
        if u14 then
            u14 = false;
            u11.DebugTrackersVisible = not u11.DebugTrackersVisible;
            if u11.DebugTrackersVisible then
                task.spawn(function() --[[ Line: 94 ]]
                    -- upvalues: u11 (ref)
                    u11:ShowDebugTrackers();
                end);
            end;
            u13.Text = u11.DebugTrackersVisible and " Hide Trackers" or " Show Trackers ";
            task.wait();
            u14 = true;
        end;
    end);
    local v15, v16 = u5:Create();
    v15.Size = UDim2.new(0.5, 0, 0.075, 0);
    v15.Position = UDim2.new(0.25, 0, 0.875, 0);
    v15.SizeConstraint = Enum.SizeConstraint.RelativeYY;
    v15.Parent = v9;
    v16.Text = " Calibrate Trackers ";
    u11.CalibrateButton = v15;
    v15.MouseButton1Down:Connect(function() --[[ Line: 111 ]]
        -- upvalues: u14 (ref), u2 (ref), l__Players__2 (ref), u3 (ref)
        if u14 then
            u14 = false;
            local v17 = u2:GetCharacter(l__Players__2.LocalPlayer);
            if v17 then
                u3:Calibrate(v17);
            end;
            task.wait();
            u14 = true;
        end;
    end);
    u11:UpdateText();
    task.spawn(function() --[[ Line: 124 ]]
        -- upvalues: u11 (copy)
        while true do
            u11:UpdateText();
            task.wait(0.1);
        end;
    end);
    task.spawn(function() --[[ Line: 132 ]]
        -- upvalues: l__Enigma__7 (ref), u3 (ref), u8 (copy), u7 (copy), u11 (copy)
        local v18 = {
            LeftFoot = false,
            RightFoot = false
        };
        while true do
            local v19 = {};
            local v20 = true;
            for v21, v22 in v18 do
                if not v22 then
                    if not v22 then
                        v20 = false;
                    end;
                    if l__Enigma__7.Enabled and (l__Enigma__7:GetUserCFrameEnabled(v21) and not u3.Offsets[v21]) then
                        table.insert(v19, v21);
                    end;
                end;
            end;
            for _, v23 in v19 do
                v18[v23] = true;
            end;
            if #v19 > 0 then
                u8:UpdateVisibleView(u7.Name);
                u8:Toggle(true);
                u11:UpdateText();
            end;
            if v20 then
                return;
            end;
            task.wait();
        end;
    end);
    return u11;
end;
function u6.UpdateText(p24) --[[ Line: 174 ]]
    -- upvalues: l__Enigma__7 (copy), u3 (copy), l__UserInputService__4 (copy), u1 (copy)
    local v25 = "";
    local l__Enabled__9 = l__Enigma__7.Enabled;
    if l__Enabled__9 then
        l__Enabled__9 = l__Enigma__7:GetUserCFrameEnabled("LeftFoot");
    end;
    local l__Enabled__10 = l__Enigma__7.Enabled;
    if l__Enabled__10 then
        l__Enabled__10 = l__Enigma__7:GetUserCFrameEnabled("RightFoot");
    end;
    local v26;
    if l__Enabled__9 then
        if u3.Offsets.LeftFoot then
            v26 = `{v25}Left Foot Tracker: {`<font color="rgb({0},{200},{0})">Active</font>`}`;
        else
            v26 = `{v25}Left Foot Tracker: {`<font color="rgb({200},{150},{0})">Requires Calibration</font>`}`;
        end;
    else
        v26 = `{v25}Left Foot Tracker: {`<font color="rgb({200},{0},{0})">Inactive</font>`}`;
    end;
    local v27;
    if l__Enabled__10 then
        if u3.Offsets.RightFoot then
            v27 = `{v26}\nRight Foot Tracker: {`<font color="rgb({0},{200},{0})">Active</font>`}`;
        else
            v27 = `{v26}\nRight Foot Tracker: {`<font color="rgb({200},{150},{0})">Requires Calibration</font>`}`;
        end;
    else
        v27 = `{v26}\nRight Foot Tracker: {`<font color="rgb({200},{0},{0})">Inactive</font>`}`;
    end;
    local v28;
    if l__Enigma__7:IsActive() then
        local v29 = l__UserInputService__4:GetFocusedTextBox();
        local v30;
        if v29 and (not v29.Parent or v29.Parent.Name ~= "EnigmaTextBoxInput") then
            v30 = `{v27}\nData transfer: {`<font color="rgb({200},{0},{0})">Inactive</font>`}`;
        else
            v30 = `{v27}\nData transfer: {`<font color="rgb({0},{200},{0})">Active</font>`}`;
            if l__Enigma__7.Input then
                local v31 = string.split(l__Enigma__7.Input:GetCurrentText(), "|")[1];
                if u1[v31] then
                    v30 = `{v30}\n\nProtocol version: {v31}`;
                else
                    v30 = `{v30}\n\nProtocol version: {`<font color="rgb({200},{150},{0})">{`{v31} (Unsupported)`}</font>`}`;
                end;
            end;
        end;
        if l__Enabled__9 or (l__Enabled__10 or not l__Enigma__7:GetUserCFrameEnabled("None")) then
            v28 = `{v30}\n\nTo calibrate, stand up straight with your head level and facing forward with your feet next to each other pointing forward.`;
        else
            v28 = `{v30}\n\n⚠️ Trackers are detected, but the role in SteamVR is "None". They need to have assigned roles through the SteamVR menu.`;
        end;
        if p24.ShowTrackersButton then
            p24.ShowTrackersButton.Visible = true;
        end;
        if p24.CalibrateButton then
            p24.CalibrateButton.Visible = true;
        end;
    else
        v28 = `{`{v27}\nData transfer: {`<font color="rgb({200},{150},{0})">Inactive</font>`}`}\n\n⚠️ Enigma requires a desktop application. There may be experience-specific issues when Enigma is active.`;
        if p24.ShowTrackersButton then
            p24.ShowTrackersButton.Visible = false;
        end;
        if p24.CalibrateButton then
            p24.CalibrateButton.Visible = false;
        end;
    end;
    p24.EnigmaText.Text = v28;
end;
function u6.ShowDebugTrackers(p32) --[[ Line: 242 ]]
    -- upvalues: l__Enigma__7 (copy), l__Workspace__1 (copy), l__VRService__5 (copy), l__RunService__3 (copy)
    if l__Enigma__7.Enabled then
        local v33 = Instance.new("Folder");
        v33.Name = "NexusVRCharacterModelEnigmaDebugTrackers";
        v33.Parent = l__Workspace__1.CurrentCamera;
        local v34 = {};
        local v35 = {};
        while p32.DebugTrackersVisible do
            local v36 = l__Workspace__1.CurrentCamera:GetRenderCFrame() * l__VRService__5:GetUserCFrame(Enum.UserCFrame.Head):Inverse();
            local v37 = {};
            local v38 = 0;
            for _, v39 in l__Enigma__7.TrackerRoles do
                local v40 = 1;
                while l__Enigma__7:GetUserCFrameEnabled(v39, v40) do
                    v37[v40 == 1 and v39 and v39 or `{v39} ({v40})`] = v36 * l__Enigma__7:GetUserCFrame(v39, v40);
                    v38 = v38 + 1;
                    v40 = v40 + 1;
                end;
            end;
            local v41 = 1;
            for v42, v43 in v37 do
                if not v34[v41] then
                    local v44 = Instance.new("Part");
                    v44.BrickColor = BrickColor.new("Institutional white");
                    v44.Material = Enum.Material.Neon;
                    v44.Anchored = true;
                    v44.CanCollide = false;
                    v44.CanTouch = false;
                    v44.CanQuery = false;
                    v44.Shape = Enum.PartType.Ball;
                    v44.Size = Vector3.new(0.2, 0.2, 0.2);
                    v44.Parent = v33;
                    v34[v41] = v44;
                    local v45 = Instance.new("SphereHandleAdornment");
                    v45.Transparency = 0.5;
                    v45.AlwaysOnTop = true;
                    v45.Color3 = Color3.fromRGB(255, 255, 255);
                    v45.ZIndex = 1;
                    v45.Radius = 0.1;
                    v45.Adornee = v44;
                    v45.Parent = v44;
                    local v46 = Instance.new("BillboardGui");
                    v46.AlwaysOnTop = true;
                    v46.Adornee = v44;
                    v46.Size = UDim2.new(2, 0, 0.4, 0);
                    v46.StudsOffset = Vector3.new(0, 0.3, 0);
                    v46.Parent = v44;
                    local v47 = Instance.new("TextLabel");
                    v47.BackgroundTransparency = 1;
                    v47.Size = UDim2.new(1, 0, 1, 0);
                    v47.TextScaled = true;
                    v47.TextColor3 = Color3.fromRGB(255, 255, 255);
                    v47.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
                    v47.TextStrokeTransparency = 0;
                    v47.Parent = v46;
                    v35[v41] = v47;
                end;
                v34[v41].CFrame = v43;
                v35[v41].Text = v42;
                v41 = v41 + 1;
            end;
            for v48 = #v34, v38 + 1, -1 do
                v34[v48]:Destroy();
                v34[v48] = nil;
                v35[v48]:Destroy();
                v35[v48] = nil;
            end;
            l__RunService__3.RenderStepped:Wait();
        end;
        v33:Destroy();
    end;
end;
return u6;
