-- Decompiled from: ReplicatedStorage.Modules.TwoHandNexusVRBackpack
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Workspace__1 = game:GetService("Workspace");
local l__Players__2 = game:GetService("Players");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__GuiService__4 = game:GetService("GuiService");
local l__RunService__5 = game:GetService("RunService");
local l__UserInputService__6 = game:GetService("UserInputService");
local l__CharacterBackpack__7 = require(script.Parent:WaitForChild("NexusVRBackpack"):WaitForChild("NexusVRBackpack"):WaitForChild("CharacterBackpack"));
local v1 = {
    UseKeyboardTestInputs = false,
    CurrentBackpacks = {},
    CurrentCharacterEvents = {},
    ToolEvents = {}
};
local u2 = script:FindFirstChild("EquipVRTool");
if not u2 then
    if l__RunService__5:IsClient() then
        u2 = script:WaitForChild("EquipVRTool");
    else
        u2 = Instance.new("RemoteEvent");
        u2.Name = "EquipVRTool";
        u2.Parent = script;
    end;
end;
function v1.GetGrip(_, p3, p4) --[[ Line: 42 ]]
    if p4 == Enum.UserCFrame.LeftHand then
        return CFrame.new(0, 0, -2 * p3.Grip.Z) * p3.Grip;
    else
        return p3.Grip;
    end;
end;
function v1.UpdateGrips(p5, p6) --[[ Line: 52 ]]
    for _, v7 in p6:GetChildren() do
        if v7:IsA("Tool") then
            local v8 = v7:FindFirstChild("Handle");
            if v8 then
                local v9 = v7:GetAttribute("Hand") or Enum.UserCFrame.RightHand;
                local v10 = p6:FindFirstChild(v9 == Enum.UserCFrame.LeftHand and "LeftHand" or "RightHand");
                local v11 = p6:FindFirstChild(v9 == Enum.UserCFrame.LeftHand and "RightHand" or "LeftHand");
                if v10 then
                    local v12 = v10:FindFirstChild(v9 == Enum.UserCFrame.LeftHand and "LeftGripAttachment" or "RightGripAttachment");
                    if v12 then
                        if v11 then
                            for _, v13 in v11:GetChildren() do
                                if v13:IsA("JointInstance") and v13.Part1 == v8 then
                                    v13:Destroy();
                                end;
                            end;
                        end;
                        local v14 = nil;
                        for _, v15 in v10:GetChildren() do
                            if v15:IsA("JointInstance") and v15.Part1 == v8 then
                                v14 = v15;
                                break;
                            end;
                        end;
                        if not v14 then
                            v14 = Instance.new("Weld");
                            v14.Name = (v9 == Enum.UserCFrame.LeftHand and "Left" or "Right") .. "Grip";
                            v14.Part0 = v10;
                            v14.Part1 = v8;
                            v14.Parent = v10;
                        end;
                        v14.C0 = v12.CFrame;
                        v14.C1 = p5:GetGrip(v7, v9);
                    end;
                end;
            end;
        end;
    end;
end;
function v1.UnequipTools(p16, p17, p18, p19) --[[ Line: 101 ]]
    -- upvalues: l__Players__2 (copy)
    local v20 = l__Players__2:GetPlayerFromCharacter(p17);
    for _, v21 in p17:GetChildren() do
        if v21 ~= p19 and v21:IsA("Tool") and (v21:GetAttribute("Hand") or Enum.UserCFrame.RightHand) == p18 then
            v21.Parent = l__Players__2:GetPlayerFromCharacter(p17):FindFirstChildOfClass("Backpack");
            v21:SetAttribute("Hand", nil);
            if v20 and (p16.ToolEvents[v20] and p16.ToolEvents[v20][v21]) then
                for _, v22 in p16.ToolEvents[v20][v21] do
                    v22:Disconnect();
                end;
                p16.ToolEvents[v20][v21] = nil;
            end;
            local v23 = v21:FindFirstChild("Handle");
            local v24 = p17:FindFirstChild((p18 == Enum.UserCFrame.LeftHand and "Left" or "Right") .. "Grip");
            if v23 and v24 then
                for _, v25 in v24:GetChildren() do
                    if v25:IsA("JointInstance") and v25.Part1 == v23 then
                        v25:Destroy();
                    end;
                end;
            end;
        end;
    end;
end;
function v1.EquipTool(u26, u27, u28, p29) --[[ Line: 134 ]]
    -- upvalues: l__RunService__5 (copy), u2 (ref), l__Players__2 (copy)
    u26:UnequipTools(u28, p29, u27);
    u27:SetAttribute("Hand", p29);
    u27.Parent = u28;
    if l__RunService__5:IsClient() then
        u2:FireServer(u27, p29);
    end;
    local v30 = l__Players__2:GetPlayerFromCharacter(u28);
    u26:UpdateGrips(u28);
    if v30 then
        if not u26.ToolEvents[v30] then
            u26.ToolEvents[v30] = {};
        end;
        local v31 = {};
        u26.ToolEvents[v30][u27] = v31;
        local v32 = u27:GetPropertyChangedSignal("Grip");
        table.insert(v31, v32:Connect(function() --[[ Line: 155 ]]
            -- upvalues: u26 (copy), u28 (copy)
            u26:UpdateGrips(u28);
        end));
        table.insert(v31, u27.AncestryChanged:Connect(function() --[[ Line: 158 ]]
            -- upvalues: u27 (copy), u28 (copy)
            if u27.Parent == u28 then
            else
                u27:SetAttribute("Hand", nil);
            end;
        end));
    end;
end;
function v1.ReplaceHumanoid(u33, p34, u35, u36) --[[ Line: 169 ]]
    p34.Humanoid = {
        EquipTool = function(_, p37) --[[ Name: EquipTool, Line 172 ]]
            -- upvalues: u33 (copy), u35 (copy), u36 (copy)
            u33:EquipTool(p37, u35, u36);
        end,
        UnequipTools = function(_) --[[ Name: UnequipTools, Line 176 ]]
            -- upvalues: u33 (copy), u35 (copy), u36 (copy)
            u33:UnequipTools(u35, u36);
        end
    };
end;
function v1.SetUpCharacter(u38, u39) --[[ Line: 185 ]]
    -- upvalues: l__CharacterBackpack__7 (copy)
    if u39 then
        for _, v40 in u38.CurrentBackpacks do
            v40:Destroy();
        end;
        u38.CurrentBackpacks = {};
        for _, v41 in u38.CurrentCharacterEvents do
            v41:Disconnect();
        end;
        u38.CurrentCharacterEvents = {};
        local v42 = l__CharacterBackpack__7.new(u39);
        v42:SetUserCFrame(Enum.UserCFrame.LeftHand);
        v42:SetKeyCode(u38.UseKeyboardTestInputs and Enum.KeyCode.Q or Enum.KeyCode.ButtonL3);
        u38:ReplaceHumanoid(v42, u39, Enum.UserCFrame.LeftHand);
        table.insert(u38.CurrentBackpacks, v42);
        local v43 = l__CharacterBackpack__7.new(u39);
        v43:SetUserCFrame(Enum.UserCFrame.RightHand);
        v43:SetKeyCode(u38.UseKeyboardTestInputs and Enum.KeyCode.E or Enum.KeyCode.ButtonR3);
        u38:ReplaceHumanoid(v43, u39, Enum.UserCFrame.RightHand);
        table.insert(u38.CurrentBackpacks, v43);
        local l__RightHand__8 = u39:WaitForChild("RightHand");
        table.insert(u38.CurrentCharacterEvents, l__RightHand__8.ChildAdded:Connect(function(p44) --[[ Line: 213 ]]
            -- upvalues: u38 (copy), u39 (copy)
            if p44:IsA("JointInstance") then
                local l__Part1__9 = p44.Part1;
                if l__Part1__9 then
                    local l__Parent__10 = l__Part1__9.Parent;
                    if l__Parent__10 and l__Parent__10:IsA("Tool") then
                        task.defer(function() --[[ Line: 219 ]]
                            -- upvalues: u38 (ref), u39 (ref)
                            u38:UpdateGrips(u39);
                        end);
                    end;
                end;
            end;
        end));
    end;
end;
function v1.EnableNonVRTesting(p45) --[[ Line: 229 ]]
    -- upvalues: l__UserInputService__6 (copy), l__CharacterBackpack__7 (copy), l__Workspace__1 (copy), l__GuiService__4 (copy)
    if l__UserInputService__6.VREnabled then
    else
        p45.UseKeyboardTestInputs = true;
        function l__CharacterBackpack__7.GetBackpackCFrame(p46) --[[ Line: 233 ]]
            -- upvalues: l__Workspace__1 (ref)
            return l__Workspace__1.CurrentCamera.CFrame * CFrame.new(p46.UserCFrame == Enum.UserCFrame.RightHand and 1 or -1, 0, -2);
        end;
        function l__CharacterBackpack__7.GetHandPosition(p47) --[[ Line: 237 ]]
            -- upvalues: l__UserInputService__6 (ref), l__GuiService__4 (ref), l__Workspace__1 (ref)
            local l__Size__11 = p47.Backpack.Part.Size;
            local v48 = p47:GetBackpackCFrame();
            local v49 = l__UserInputService__6:GetMouseLocation() - l__GuiService__4:GetGuiInset();
            local v50 = l__Workspace__1.CurrentCamera:WorldToScreenPoint((v48 * CFrame.new(-l__Size__11.X / 2, l__Size__11.Y / 2, 0)).Position);
            local v51 = l__Workspace__1.CurrentCamera:WorldToScreenPoint((v48 * CFrame.new(l__Size__11.X / 2, -l__Size__11.Y / 2, 0)).Position);
            return (v48 * CFrame.new(l__Size__11.X * ((v49.X - v50.X) / (v51.X - v50.X) - 0.5), l__Size__11.Y * (0.5 - (v49.Y - v50.Y) / (v51.Y - v50.Y)), 0)).Position;
        end;
    end;
end;
function v1.SetUp(u52) --[[ Line: 254 ]]
    -- upvalues: l__RunService__5 (copy), l__UserInputService__6 (copy), l__Players__2 (copy), l__ReplicatedStorage__3 (copy), l__CharacterBackpack__7 (copy), u2 (ref)
    if l__RunService__5:IsClient() then
        if l__UserInputService__6.VREnabled or u52.UseKeyboardTestInputs then
            l__Players__2.LocalPlayer.CharacterAdded:Connect(function(p53) --[[ Line: 262 ]]
                -- upvalues: u52 (copy)
                u52:SetUpCharacter(p53);
            end);
            task.spawn(function() --[[ Line: 265 ]]
                -- upvalues: u52 (copy), l__Players__2 (ref)
                u52:SetUpCharacter(l__Players__2.LocalPlayer.Character);
            end);
            task.spawn(function() --[[ Line: 270 ]]
                -- upvalues: l__ReplicatedStorage__3 (ref), l__CharacterBackpack__7 (ref)
                local l__NexusVRCharacterModel__12 = require(l__ReplicatedStorage__3:WaitForChild("NexusVRCharacterModel", 1e99));
                if l__NexusVRCharacterModel__12.Api then
                    l__CharacterBackpack__7.NexusVRCharacterModelControllerApi = l__NexusVRCharacterModel__12.Api:WaitFor("Controller");
                else
                    warn("Nexus VR Character Model is loaded by no API is found. This was added in V.2.4.0. Inputs on the right controller won\'t be disabled when interacting with the backpack.");
                end;
            end);
        end;
    else
        u2.OnServerEvent:Connect(function(p54, p55, p56) --[[ Line: 280 ]]
            -- upvalues: u52 (copy)
            if p55 and p56 then
                local v57 = p54:FindFirstChildOfClass("Backpack");
                local l__Character__13 = p54.Character;
                if v57 and l__Character__13 then
                    if p55:IsDescendantOf(v57) or p55:IsDescendantOf(l__Character__13) then
                        u52:EquipTool(p55, l__Character__13, p56);
                    end;
                end;
            end;
        end);
        l__Players__2.PlayerRemoving:Connect(function(p58) --[[ Line: 290 ]]
            -- upvalues: u52 (copy)
            if u52.ToolEvents[p58] then
                for _, v59 in u52.ToolEvents[p58] do
                    for _, v60 in v59 do
                        v60:Disconnect();
                    end;
                end;
                u52.ToolEvents[p58] = nil;
            end;
        end);
    end;
end;
return v1;
