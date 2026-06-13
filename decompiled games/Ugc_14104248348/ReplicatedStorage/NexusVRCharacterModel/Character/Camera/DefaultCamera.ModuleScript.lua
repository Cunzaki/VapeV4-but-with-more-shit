-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Character.Camera.DefaultCamera
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    [Enum.AccessoryType.Hat] = true,
    [Enum.AccessoryType.Hair] = true,
    [Enum.AccessoryType.Face] = true,
    [Enum.AccessoryType.Eyebrow] = true,
    [Enum.AccessoryType.Eyelash] = true
};
local l__Players__1 = game:GetService("Players");
local l__VRService__2 = game:GetService("VRService");
local l__Parent__3 = script.Parent.Parent.Parent;
local l__CommonCamera__4 = require(l__Parent__3:WaitForChild("Character"):WaitForChild("Camera"):WaitForChild("CommonCamera"));
local u2 = require(l__Parent__3:WaitForChild("State"):WaitForChild("Settings")).GetInstance();
local u3 = {};
u3.__index = u3;
setmetatable(u3, l__CommonCamera__4);
function u3.ShouldHidePart(p4) --[[ Line: 33 ]]
    -- upvalues: u1 (copy)
    local l__Parent__5 = p4.Parent;
    if l__Parent__5 then
        if l__Parent__5:IsA("Accessory") then
            return u1[l__Parent__5.AccessoryType] or false;
        elseif l__Parent__5:IsA("Model") then
            return false;
        else
            return not l__Parent__5:IsA("Tool");
        end;
    else
        return not p4:FindFirstChildWhichIsA("WrapLayer");
    end;
end;
function u3.new() --[[ Line: 56 ]]
    -- upvalues: l__CommonCamera__4 (copy), u3 (copy)
    local v5 = l__CommonCamera__4.new();
    return setmetatable(v5, u3);
end;
function u3.Enable(u6) --[[ Line: 63 ]]
    -- upvalues: l__Players__1 (copy), u2 (copy), u3 (copy), l__VRService__2 (copy)
    local u7 = {};
    u6.TransparencyEvents = u7;
    if l__Players__1.LocalPlayer.Character then
        local u8 = u2:GetSetting("Appearance.LocalCharacterTransparency");
        if u8 == 0.5 then
            u8 = 0.501;
        elseif u8 < 0.5 then
            warn("Values of <0.5 with Appearance.LocalCharacterTransparency are currently known to cause black screen issues. This will hopefully be resolved by Roblox in a future update: https://devforum.roblox.com/t/vr-screen-becomes-black-due-to-non-transparent-character/2215099");
        end;
        table.insert(u7, l__Players__1.LocalPlayer.Character.DescendantAdded:Connect(function(u9) --[[ Line: 77 ]]
            -- upvalues: u8 (ref), u3 (ref), u7 (copy)
            if u9:IsA("BasePart") then
                local v10 = u8;
                local u11 = u9:FindFirstAncestorOfClass("Tool") and 0 or (u3.ShouldHidePart(u9) and 1 or v10);
                u9.LocalTransparencyModifier = u11;
                local v12 = u7;
                local v13 = u9:GetPropertyChangedSignal("LocalTransparencyModifier");
                table.insert(v12, v13:Connect(function() --[[ Line: 87 ]]
                    -- upvalues: u9 (copy), u11 (ref)
                    u9.LocalTransparencyModifier = u11;
                end));
            end;
        end));
        for _, u14 in l__Players__1.LocalPlayer.Character:GetDescendants() do
            if u14:IsA("BasePart") then
                local u15 = u14:FindFirstAncestorOfClass("Tool") and 0 or (u3.ShouldHidePart(u14) and 1 or u8);
                u14.LocalTransparencyModifier = u15;
                local v16 = u14:GetPropertyChangedSignal("LocalTransparencyModifier");
                table.insert(u7, v16:Connect(function() --[[ Line: 102 ]]
                    -- upvalues: u14 (copy), u15 (ref)
                    u14.LocalTransparencyModifier = u15;
                end));
            end;
        end;
    end;
    local v17 = l__Players__1.LocalPlayer:GetPropertyChangedSignal("Character");
    table.insert(u7, v17:Connect(function() --[[ Line: 110 ]]
        -- upvalues: u6 (copy)
        u6:Disable();
        u6:Enable();
    end));
    local v18 = u2:GetSettingsChangedSignal("Appearance.LocalCharacterTransparency"):Connect(function() --[[ Line: 114 ]]
        -- upvalues: u6 (copy)
        u6:Disable();
        u6:Enable();
    end);
    table.insert(u7, v18);
    if l__VRService__2.AvatarGestures then
        l__Players__1.LocalPlayer.CameraMaxZoomDistance = l__Players__1.LocalPlayer.CameraMinZoomDistance;
    end;
end;
function u3.Disable(p19) --[[ Line: 128 ]]
    -- upvalues: l__Players__1 (copy)
    if p19.TransparencyEvents then
        for _, v20 in p19.TransparencyEvents do
            v20:Disconnect();
        end;
        p19.TransparencyEvents = {};
    end;
    if l__Players__1.LocalPlayer.Character then
        for _, v21 in l__Players__1.LocalPlayer.Character:GetDescendants() do
            if v21:IsA("BasePart") then
                v21.LocalTransparencyModifier = 0;
            end;
        end;
    end;
end;
function u3.UpdateCamera(p22, p23) --[[ Line: 150 ]]
    -- upvalues: l__VRService__2 (copy)
    if l__VRService__2.AvatarGestures then
    else
        p22:SetCFrame(p23);
    end;
end;
return u3;
