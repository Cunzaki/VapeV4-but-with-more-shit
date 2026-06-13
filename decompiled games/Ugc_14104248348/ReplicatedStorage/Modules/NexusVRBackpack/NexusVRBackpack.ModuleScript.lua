-- Decompiled from: ReplicatedStorage.Modules.NexusVRBackpack.NexusVRBackpack
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__CharacterBackpack__3 = require(script:WaitForChild("CharacterBackpack"));
return {
    Enabled = true,
    CreateBackpack = function(p1) --[[ Name: CreateBackpack, Line 21 ]]
        -- upvalues: l__Players__1 (copy), l__CharacterBackpack__3 (copy)
        if p1.CurrentBackpack then
            p1.CurrentBackpack:Destroy();
            p1.CurrentBackpack = nil;
        end;
        if l__Players__1.LocalPlayer.Character then
            p1.CurrentBackpack = l__CharacterBackpack__3.new(l__Players__1.LocalPlayer.Character);
            p1.CurrentBackpack.Enabled = p1.Enabled;
            if p1.OverrideKeyCode then
                p1.CurrentBackpack:SetKeyCode(p1.OverrideKeyCode);
            end;
            if p1.OverrideUserCFrame then
                p1.CurrentBackpack:SetUserCFrame(p1.OverrideUserCFrame);
            end;
        end;
    end,
    Load = function(u2) --[[ Name: Load, Line 43 ]]
        -- upvalues: l__Players__1 (copy), l__ReplicatedStorage__2 (copy), l__CharacterBackpack__3 (copy)
        l__Players__1.LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 45 ]]
            -- upvalues: u2 (copy)
            u2:CreateBackpack();
        end);
        u2:CreateBackpack();
        task.spawn(function() --[[ Line: 51 ]]
            -- upvalues: l__ReplicatedStorage__2 (ref), l__CharacterBackpack__3 (ref), u2 (copy)
            local l__NexusVRCharacterModel__4 = require(l__ReplicatedStorage__2:WaitForChild("NexusVRCharacterModel", 1e99));
            if l__NexusVRCharacterModel__4.Api then
                l__CharacterBackpack__3.NexusVRCharacterModelControllerApi = l__NexusVRCharacterModel__4.Api:WaitFor("Controller");
                l__NexusVRCharacterModel__4.Api:Register("Backpack", {
                    GetBackpackEnabled = function(_) --[[ Name: GetBackpackEnabled, Line 62 ]]
                        -- upvalues: u2 (ref)
                        return u2:GetBackpackEnabled();
                    end,
                    SetBackpackEnabled = function(_, p3) --[[ Name: SetBackpackEnabled, Line 65 ]]
                        -- upvalues: u2 (ref)
                        u2:SetBackpackEnabled(p3);
                    end,
                    SetKeyCode = function(_, p4) --[[ Name: SetKeyCode, Line 68 ]]
                        -- upvalues: u2 (ref)
                        u2:SetKeyCode(p4);
                    end,
                    SetUserCFrame = function(_, p5) --[[ Name: SetUserCFrame, Line 71 ]]
                        -- upvalues: u2 (ref)
                        u2:SetUserCFrame(p5);
                    end
                });
            else
                warn("Nexus VR Character Model is loaded by no API is found. This was added in V.2.4.0. Inputs on the right controller won\'t be disabled when interacting with the backpack.");
            end;
        end);
    end,
    GetBackpackEnabled = function(p6) --[[ Name: GetBackpackEnabled, Line 81 ]]
        return p6.Enabled;
    end,
    SetBackpackEnabled = function(p7, p8) --[[ Name: SetBackpackEnabled, Line 88 ]]
        p7.Enabled = p8 ~= false;
        if p7.CurrentBackpack then
            p7.CurrentBackpack.Enabled = p7.Enabled;
            if not p7.Enabled then
                p7.CurrentBackpack:Close();
            end;
        end;
    end,
    SetKeyCode = function(p9, p10) --[[ Name: SetKeyCode, Line 101 ]]
        p9.OverrideKeyCode = p10;
        if p9.CurrentBackpack then
            p9.CurrentBackpack:SetKeyCode(p10 or Enum.KeyCode.ButtonR3);
        end;
    end,
    SetUserCFrame = function(p11, p12) --[[ Name: SetUserCFrame, Line 111 ]]
        p11.OverrideUserCFrame = p12;
        if p11.CurrentBackpack then
            p11.CurrentBackpack:SetUserCFrame(p12 or Enum.UserCFrame.RightHand);
        end;
    end
};
