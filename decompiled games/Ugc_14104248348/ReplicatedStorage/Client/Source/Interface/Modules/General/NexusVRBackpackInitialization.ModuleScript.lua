-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.NexusVRBackpackInitialization
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__StarterGui__2 = game:GetService("StarterGui");
local l__UserInputService__3 = game:GetService("UserInputService");
local l__TwoHandNexusVRBackpack__4 = require(l__ReplicatedStorage__1.Modules.TwoHandNexusVRBackpack);
local u1 = require(l__ReplicatedStorage__1.Modules.Mince):Get("Settings");
return {
    Setup = function() --[[ Name: Setup, Line 16 ]]
        -- upvalues: l__UserInputService__3 (copy), l__TwoHandNexusVRBackpack__4 (copy), u1 (copy), l__StarterGui__2 (copy)
        if l__UserInputService__3.VREnabled then
            l__TwoHandNexusVRBackpack__4:SetUp();
            local u2 = u1.GetValue("VRExperimentalMode");
            u1.SettingChanged("VRExperimentalMode"):Connect(function(p3) --[[ Line: 34 ]]
                -- upvalues: u2 (ref), l__StarterGui__2 (ref)
                u2 = p3;
                if not p3 then
                    l__StarterGui__2:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
                end;
            end);
            task.spawn(function() --[[ Line: 43 ]]
                -- upvalues: u2 (ref), l__StarterGui__2 (ref), l__TwoHandNexusVRBackpack__4 (ref)
                while true do
                    if u2 and l__StarterGui__2:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack) then
                        l__StarterGui__2:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
                    end;
                    local v4 = nil;
                    for _, v5 in l__TwoHandNexusVRBackpack__4.CurrentBackpacks do
                        if v5.UserCFrame == Enum.UserCFrame.LeftHand then
                            v4 = v5;
                        end;
                    end;
                    if v4 then
                        if u2 then
                            v4.Enabled = true;
                        else
                            v4.Enabled = false;
                            v4:Close();
                        end;
                    end;
                    task.wait();
                end;
            end);
        end;
    end
};
