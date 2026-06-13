-- Decompiled from: ReplicatedStorage.NexusVRCharacterModelClientLoader
-- Class: Script
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__StarterGui__3 = game:GetService("StarterGui");
local l__HttpService__4 = game:GetService("HttpService");
local l__RunService__5 = game:GetService("RunService");
local l__UserInputService__6 = game:GetService("UserInputService");
local l__VRService__7 = game:GetService("VRService");
local l__NexusVRCharacterModel__8 = l__ReplicatedStorage__2:WaitForChild("NexusVRCharacterModel");
local l__NexusBufferedReplication__9 = require(l__NexusVRCharacterModel__8:WaitForChild("Packages"):WaitForChild("NexusBufferedReplication"));
local v1 = require(l__NexusVRCharacterModel__8:WaitForChild("State"):WaitForChild("CameraService")).GetInstance();
local u2 = require(l__NexusVRCharacterModel__8:WaitForChild("State"):WaitForChild("CharacterService")).GetInstance();
local u3 = require(l__NexusVRCharacterModel__8:WaitForChild("State"):WaitForChild("ControlService")).GetInstance();
local u4 = require(l__NexusVRCharacterModel__8:WaitForChild("State"):WaitForChild("DefaultCursorService")).GetInstance();
local v5 = require(l__NexusVRCharacterModel__8:WaitForChild("State"):WaitForChild("EnigmaService")).GetInstance();
local u6 = require(l__NexusVRCharacterModel__8:WaitForChild("State"):WaitForChild("Settings")).GetInstance();
local l__BufferProtocol__10 = require(l__NexusVRCharacterModel__8:WaitForChild("Util"):WaitForChild("BufferProtocol"));
local l__UpdateInputs__11 = l__NexusVRCharacterModel__8:WaitForChild("UpdateInputs");
local l__ReplicationReady__12 = l__NexusVRCharacterModel__8:WaitForChild("ReplicationReady");
local l__PlayerBufferedRemoteEventReceiver__13 = l__NexusBufferedReplication__9.Receiver.PlayerBufferedRemoteEventReceiver;
local l__BaseScreenGui__14 = require(l__ReplicatedStorage__2:WaitForChild("NexusVRCore")).BaseScreenGui;
if l__BaseScreenGui__14 then
    local l____new__15 = l__BaseScreenGui__14.__new;
    function l__BaseScreenGui__14.__new(...) --[[ Line: 33 ]]
        -- upvalues: l____new__15 (copy)
        warn("Using the bundled (automically loaded) Nexus VR Core with Nexus VR Character Model is deprecated.\nIt is recommended to move to a fixed version, which can be downloaded from GitHub.");
        return l____new__15(...);
    end;
end;
u6:SetDefaults(l__HttpService__4:JSONDecode(l__NexusVRCharacterModel__8:WaitForChild("Configuration").Value));
local u7 = {};
l__PlayerBufferedRemoteEventReceiver__13.new(l__UpdateInputs__11, function(p8) --[[ Line: 44 ]]
    -- upvalues: l__BufferProtocol__10 (copy)
    return l__BufferProtocol__10.Deserialize(p8);
end):OnDataReceived(function(p9, p10) --[[ Line: 47 ]]
    -- upvalues: l__Players__1 (copy), u7 (copy), u2 (copy)
    if p9 == l__Players__1.LocalPlayer then
    else
        local l__UpdateTime__16 = p10.UpdateTime;
        if l__UpdateTime__16 then
            if u7[p9] and l__UpdateTime__16 < u7[p9] then
                return;
            end;
            u7[p9] = l__UpdateTime__16;
        end;
        local v11 = u2:GetCharacter(p9);
        if v11 then
            v11:UpdateFromInputs(p10.HeadCFrame, p10.LeftHandCFrame, p10.RightHandCFrame, p10.CurrentWalkspeed, {
                LeftFoot = p10.LeftFootCFrame,
                RightFoot = p10.RightFootCFrame
            });
        end;
    end;
end);
l__Players__1.PlayerRemoving:Connect(function(p12) --[[ Line: 67 ]]
    -- upvalues: u7 (copy)
    u7[p12] = nil;
end);
l__ReplicationReady__12:FireServer();
l__RunService__5.Stepped:Connect(function() --[[ Line: 74 ]]
    -- upvalues: u2 (copy)
    u2:RefreshAllCharacters();
end);
local u13 = false;
l__UserInputService__6.InputBegan:Connect(function(p14) --[[ Line: 80 ]]
    -- upvalues: u13 (ref), l__UserInputService__6 (copy), u6 (copy)
    if not u13 and (p14.KeyCode == Enum.KeyCode.F9 and (l__UserInputService__6:IsKeyDown(Enum.KeyCode.LeftControl) or l__UserInputService__6:IsKeyDown(Enum.KeyCode.RightControl))) and u6:GetSetting("Output.AllowClientToOutputLoadedMessage") ~= false then
        u13 = true;
        print((`Nexus VR Character Model version {u6:GetSetting("Version.Tag")} ({u6:GetSetting("Version.Commit")}) is loaded.`));
    end;
end);
while not l__UserInputService__6.VREnabled do
    l__UserInputService__6:GetPropertyChangedSignal("VREnabled"):Wait();
    warn("VR was detected later than when Nexus VR Character Model loaded. This may be a Roblox bug.");
end;
task.spawn(function() --[[ Line: 95 ]]
    -- upvalues: l__StarterGui__3 (copy), u4 (copy)
    for _ = 1, 600 do
        if pcall(function() --[[ Line: 97 ]]
            -- upvalues: l__StarterGui__3 (ref), u4 (ref)
            l__StarterGui__3:SetCore("VREnableControllerModels", false);
            u4:SetCursorState("Detect");
        end) then
            break;
        end;
        task.wait(0.1);
    end;
end);
local l__Character__17 = l__Players__1.LocalPlayer.Character;
while not l__Character__17 do
    l__Character__17 = l__Players__1.LocalPlayer.CharacterAdded:Wait();
end;
if l__Character__17:WaitForChild("Humanoid").RigType == Enum.HumanoidRigType.R6 then
    require(l__NexusVRCharacterModel__8:WaitForChild("UI"):WaitForChild("R6Message")).new():Open();
else
    u3:SetActiveController(u6:GetSetting("Movement.DefaultMovementMethod"));
    v1:SetActiveCamera(u6:GetSetting("Camera.DefaultCameraOption"));
    require(l__NexusVRCharacterModel__8:WaitForChild("UI"):WaitForChild("MainMenu")).GetInstance():SetUpOpening();
    if u6:GetSetting("Extra.NexusVRBackpackEnabled") ~= false then
        task.defer(function() --[[ Line: 128 ]]
            -- upvalues: l__ReplicatedStorage__2 (copy)
            require(l__ReplicatedStorage__2:WaitForChild("NexusVRBackpack")):Load();
        end);
    end;
    if u6:GetSetting("Extra.EnigmaEnabled") ~= false then
        v5:Enable();
    end;
    l__RunService__5:BindToRenderStep("NexusVRCharacterModelUpdate", Enum.RenderPriority.Camera.Value - 1, function() --[[ Line: 140 ]]
        -- upvalues: u3 (copy)
        u3:UpdateCharacter();
    end);
    if u6:GetSetting("DisableFadeOutViewOnCollision") == true then
        l__VRService__7.FadeOutViewOnCollision = false;
    end;
end;
