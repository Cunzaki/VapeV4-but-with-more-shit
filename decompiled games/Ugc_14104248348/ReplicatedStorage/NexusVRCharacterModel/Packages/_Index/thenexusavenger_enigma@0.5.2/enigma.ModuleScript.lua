-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_enigma@0.5.2.enigma
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__UserInputService__1 = game:GetService("UserInputService");
local l__VRService__2 = game:GetService("VRService");
local l__TrackerRole__3 = require(script:WaitForChild("Data"):WaitForChild("TrackerRole"));
local l__CombinedInput__4 = require(script:WaitForChild("Input"):WaitForChild("CombinedInput"));
local l__CompanionPluginInput__5 = require(script:WaitForChild("Input"):WaitForChild("CompanionPluginInput"));
local l__TextBoxInput__6 = require(script:WaitForChild("Input"):WaitForChild("TextBoxInput"));
local l__DeserializeOpenVrInputs__7 = require(script:WaitForChild("Serialization"):WaitForChild("DeserializeOpenVrInputs"));
local l__CalculateRolloff__8 = require(script:WaitForChild("Util"):WaitForChild("CalculateRolloff"));
return {
    Enabled = false,
    Input = nil,
    LastInputData = "",
    TrackerRoles = l__TrackerRole__3,
    LastInputTime = tick(),
    LastFloorCFrameToOrigin = CFrame.identity,
    LastInputs = {},
    IsActive = function(p1) --[[ Name: IsActive, Line 34 ]]
        -- upvalues: l__UserInputService__1 (copy)
        local v2 = l__UserInputService__1:GetFocusedTextBox();
        return v2 and (v2.Parent and v2.Name == "EnigmaTextBox") and true or tick() - p1.LastInputTime < 0.5;
    end,
    UpdateUserCFrames = function(u3) --[[ Name: UpdateUserCFrames, Line 50 ]]
        -- upvalues: l__DeserializeOpenVrInputs__7 (copy), l__VRService__2 (copy)
        if u3.Input then
            local u4 = u3.Input:GetCurrentText();
            if u4 == u3.LastInputData then
                if tick() - u3.LastInputTime >= 0.5 then
                    u3.LastInputs = {};
                end;
            else
                pcall(function() --[[ Line: 69 ]]
                    -- upvalues: l__DeserializeOpenVrInputs__7 (ref), u4 (copy), u3 (copy), l__VRService__2 (ref)
                    local v5 = {};
                    for _, v6 in l__DeserializeOpenVrInputs__7(u4) do
                        if not v5[v6.TrackerRole] then
                            v5[v6.TrackerRole] = {};
                        end;
                        table.insert(v5[v6.TrackerRole], v6);
                    end;
                    u3.LastInputData = u4;
                    u3.LastInputTime = tick();
                    u3.LastFloorCFrameToOrigin = l__VRService__2:GetUserCFrame(Enum.UserCFrame.Floor);
                    u3.LastInputs = v5;
                end);
            end;
        else
            warn("Enigma is not enabled. Call Enigma:Enable() before calling.");
        end;
    end,
    GetUserCFrameEnabled = function(p7, p8, p9) --[[ Name: GetUserCFrameEnabled, Line 86 ]]
        p7:UpdateUserCFrames();
        local v10 = p7.LastInputs[p8];
        local v11;
        if v10 == nil then
            v11 = false;
        else
            v11 = v10[p9 or 1] ~= nil;
        end;
        return v11;
    end,
    GetUserCFrame = function(p12, p13, p14) --[[ Name: GetUserCFrame, Line 97 ]]
        -- upvalues: l__CalculateRolloff__8 (copy)
        p12:UpdateUserCFrames();
        local v15 = p12.LastInputs[p13];
        if not v15 then
            return nil;
        end;
        local v16 = v15[p14 or 1];
        if not v16 then
            return nil;
        end;
        local v17 = l__CalculateRolloff__8(0.03, 0.09, tick() - p12.LastInputTime);
        return p12.LastFloorCFrameToOrigin * (CFrame.new(v16.FloorRelativeVelocity * v17) * v16.FloorRelativeCFrame);
    end,
    Enable = function(p18) --[[ Name: Enable, Line 110 ]]
        -- upvalues: l__CombinedInput__4 (copy), l__TextBoxInput__6 (copy), l__CompanionPluginInput__5 (copy)
        if p18.Input then
        else
            p18.Input = l__CombinedInput__4.new({ l__TextBoxInput__6.new(), l__CompanionPluginInput__5.new() });
            p18.Enabled = true;
        end;
    end
};
