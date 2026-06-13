-- Decompiled from: ReplicatedStorage.Modules.NexusVRBackpack.NexusVRBackpack.CharacterBackpack
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__VRService__1 = game:GetService("VRService");
local l__Workspace__2 = game:GetService("Workspace");
local l__Players__3 = game:GetService("Players");
local l__RunService__4 = game:GetService("RunService");
local l__UserInputService__5 = game:GetService("UserInputService");
local l__Backpack3D__6 = require(script.Parent:WaitForChild("UI"):WaitForChild("Backpack3D"));
local u1 = {};
u1.__index = u1;
function u1.new(p2) --[[ Line: 35 ]]
    -- upvalues: l__Players__3 (copy), u1 (copy), l__Backpack3D__6 (copy), l__UserInputService__5 (copy)
    local u3 = {
        Enabled = true,
        Player = l__Players__3:GetPlayerFromCharacter(p2),
        KeyCode = Enum.KeyCode.ButtonR3,
        UserCFrame = Enum.UserCFrame.RightHand,
        Events = {}
    };
    setmetatable(u3, u1);
    u3.Humanoid = p2:FindFirstChildOfClass("Humanoid");
    while not u3.Humanoid do
        p2.ChildAdded:Wait();
        u3.Humanoid = p2:FindFirstChildOfClass("Humanoid");
    end;
    u3.Backpack = l__Backpack3D__6.new(u3.Player:WaitForChild("PlayerGui"), { p2, u3.Player:WaitForChild("Backpack") });
    table.insert(u3.Events, l__UserInputService__5.InputBegan:Connect(function(p4) --[[ Line: 57 ]]
        -- upvalues: l__UserInputService__5 (ref), u3 (copy)
        if l__UserInputService__5:GetFocusedTextBox() then
        elseif p4.KeyCode == u3.KeyCode then
            if #u3.Backpack.Inventory.Tools == 0 then
            else
                u3:Open();
            end;
        end;
    end));
    table.insert(u3.Events, l__UserInputService__5.InputEnded:Connect(function(p5) --[[ Line: 63 ]]
        -- upvalues: u3 (copy)
        if p5.KeyCode == u3.KeyCode then
            u3:Close();
        end;
    end));
    table.insert(u3.Events, u3.Humanoid.Died:Connect(function() --[[ Line: 69 ]]
        -- upvalues: u3 (copy)
        u3:Destroy();
    end));
    table.insert(u3.Events, u3.Player.CharacterAdded:Connect(function() --[[ Line: 72 ]]
        -- upvalues: u3 (copy)
        u3:Destroy();
    end));
    table.insert(u3.Events, u3.Player.CharacterRemoving:Connect(function() --[[ Line: 75 ]]
        -- upvalues: u3 (copy)
        u3:Destroy();
    end));
    u3:SetKeyCode(Enum.KeyCode.ButtonR3);
    return u3;
end;
function u1.GetBackpackCFrame(p6) --[[ Line: 90 ]]
    -- upvalues: l__Workspace__2 (copy), l__UserInputService__5 (copy)
    return l__Workspace__2.CurrentCamera:GetRenderCFrame() * l__UserInputService__5:GetUserCFrame(Enum.UserCFrame.Head):Inverse() * l__UserInputService__5:GetUserCFrame(p6.UserCFrame);
end;
function u1.GetHandPosition(p7) --[[ Line: 97 ]]
    return p7:GetBackpackCFrame().Position;
end;
function u1.SetKeyCode(p8, p9) --[[ Line: 104 ]]
    -- upvalues: l__UserInputService__5 (copy)
    p8.KeyCode = p9;
    if l__UserInputService__5:IsKeyDown(p9) then
        p8:Open();
    end;
end;
function u1.SetUserCFrame(p10, p11) --[[ Line: 114 ]]
    p10.UserCFrame = p11;
end;
function u1.Open(u12) --[[ Line: 121 ]]
    -- upvalues: l__Workspace__2 (copy), l__VRService__1 (copy), l__RunService__4 (copy)
    if u12.Enabled then
        if u12.Backpack.Opened then
        else
            u12.Backpack:Open();
            local l__NexusVRCharacterModelControllerApi__7 = u12.NexusVRCharacterModelControllerApi;
            if l__NexusVRCharacterModelControllerApi__7 then
                l__NexusVRCharacterModelControllerApi__7:DisableControllerInput(u12.UserCFrame);
            end;
            local u13 = (l__Workspace__2.CurrentCamera:GetRenderCFrame() * l__VRService__1:GetUserCFrame(Enum.UserCFrame.Head):Inverse()):Inverse() * u12:GetBackpackCFrame();
            u12.UpdateFocusEvent = l__RunService__4.RenderStepped:Connect(function() --[[ Line: 133 ]]
                -- upvalues: u12 (copy), l__Workspace__2 (ref), l__VRService__1 (ref), u13 (copy)
                u12.Backpack:MoveTo(l__Workspace__2.CurrentCamera:GetRenderCFrame() * l__VRService__1:GetUserCFrame(Enum.UserCFrame.Head):Inverse() * u13);
                u12.Backpack:UpdateFocusedToolWorldSpace(u12:GetHandPosition());
            end);
        end;
    end;
end;
function u1.Close(p14) --[[ Line: 142 ]]
    if p14.Backpack.Opened then
        if p14.UpdateFocusEvent then
            p14.UpdateFocusEvent:Disconnect();
            p14.UpdateFocusEvent = nil;
        end;
        local v15 = p14.Backpack:GetFocusedTool();
        if v15 then
            p14.Humanoid:EquipTool(v15);
        else
            p14.Humanoid:UnequipTools();
        end;
        p14.Backpack:Close();
        local l__NexusVRCharacterModelControllerApi__8 = p14.NexusVRCharacterModelControllerApi;
        if l__NexusVRCharacterModelControllerApi__8 then
            l__NexusVRCharacterModelControllerApi__8:EnableControllerInput(p14.UserCFrame);
        end;
    end;
end;
function u1.Destroy(u16) --[[ Line: 168 ]]
    if u16.UpdateFocusEvent then
        u16.UpdateFocusEvent:Disconnect();
        u16.UpdateFocusEvent = nil;
    end;
    for _, v17 in u16.Events do
        v17:Disconnect();
    end;
    u16.Events = {};
    if u16.Backpack.Opened then
        u16.Backpack:Close();
        task.delay(0.1, function() --[[ Line: 182 ]]
            -- upvalues: u16 (copy)
            u16.Backpack:Destroy();
        end);
    else
        u16.Backpack:Destroy();
    end;
end;
return u1;
