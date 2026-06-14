-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Api
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__UserInputService__2 = game:GetService("UserInputService");
return function() --[[ Line: 9 ]]
    -- upvalues: l__RunService__1 (copy), l__UserInputService__2 (copy)
    local l__Parent__3 = script.Parent;
    local u10 = {
        Registered = require(l__Parent__3:WaitForChild("Packages"):WaitForChild("NexusInstance")).TypedEvent.new(),
        Register = function(p1, p2, p3) --[[ Name: Register, Line 19 ]]
            if p1[p2] ~= nil then
                error((`API already registered: {p2}`));
            end;
            p1[p2] = p3;
            p1.Registered:Fire(p2);
        end,
        WaitFor = function(p4, p5) --[[ Name: WaitFor, Line 35 ]]
            while not p4[p5] do
                p4.Registered:Wait();
            end;
            return p4[p5];
        end,
        OnRegistered = function(u6, u7, u8) --[[ Name: OnRegistered, Line 48 ]]
            if u6[u7] then
                task.spawn(function() --[[ Line: 51 ]]
                    -- upvalues: u8 (copy), u6 (copy), u7 (copy)
                    u8(u6[u7]);
                end);
            else
                u6.Registered:Connect(function(p9) --[[ Line: 58 ]]
                    -- upvalues: u7 (copy), u8 (copy), u6 (copy)
                    if u7 == p9 then
                        u8(u6[u7]);
                    end;
                end);
            end;
        end
    };
    if l__RunService__1:IsClient() then
        task.defer(function() --[[ Line: 67 ]]
            -- upvalues: l__Parent__3 (copy), u10 (copy), l__UserInputService__2 (ref)
            local u11 = require(l__Parent__3:WaitForChild("State"):WaitForChild("CameraService")).GetInstance();
            u10:Register("Camera", {
                SetActiveCamera = function(_, p12) --[[ Name: SetActiveCamera, Line 71 ]]
                    -- upvalues: u11 (copy)
                    u11:SetActiveCamera(p12);
                end,
                GetActiveCamera = function(_) --[[ Name: GetActiveCamera, Line 74 ]]
                    -- upvalues: u11 (copy)
                    return u11.ActiveCamera;
                end
            });
            local u13 = {};
            local u14 = require(l__Parent__3:WaitForChild("State"):WaitForChild("ControlService")).GetInstance();
            u10:Register("Controller", {
                SetActiveController = function(_, p15) --[[ Name: SetActiveController, Line 83 ]]
                    -- upvalues: u14 (copy)
                    u14:SetActiveController(p15);
                end,
                GetActiveController = function(_) --[[ Name: GetActiveController, Line 86 ]]
                    -- upvalues: u14 (copy)
                    return u14.ActiveController;
                end,
                SetControllerInputEnabled = function(_, p16, p17) --[[ Name: SetControllerInputEnabled, Line 89 ]]
                    -- upvalues: u13 (copy)
                    if p16 ~= Enum.UserCFrame.LeftHand and p16 ~= Enum.UserCFrame.RightHand then
                        error((`The following UserCFrame is invalid and can't be disabled: {p16}`));
                    end;
                    u13[p16] = p17 ~= false;
                end,
                EnableControllerInput = function(p18, p19) --[[ Name: EnableControllerInput, Line 95 ]]
                    p18:SetControllerInputEnabled(p19, true);
                end,
                DisableControllerInput = function(p20, p21) --[[ Name: DisableControllerInput, Line 98 ]]
                    p20:SetControllerInputEnabled(p21, false);
                end,
                IsControllerInputEnabled = function(_, p22) --[[ Name: IsControllerInputEnabled, Line 101 ]]
                    -- upvalues: u13 (copy)
                    if p22 ~= Enum.UserCFrame.LeftHand and p22 ~= Enum.UserCFrame.RightHand then
                        error((`The following UserCFrame is invalid and can't be disabled: {p22}`));
                    end;
                    return u13[p22] ~= false;
                end
            });
            local u23 = require(l__Parent__3:WaitForChild("State"):WaitForChild("VRInputService")).GetInstance();
            u10:Register("Input", {
                Recentered = u23.Recentered,
                EyeLevelSet = u23.EyeLevelSet,
                Recenter = function(_) --[[ Name: Recenter, Line 114 ]]
                    -- upvalues: u23 (copy)
                    u23:Recenter();
                end,
                SetEyeLevel = function(_) --[[ Name: SetEyeLevel, Line 117 ]]
                    -- upvalues: u23 (copy)
                    u23:SetEyeLevel();
                end
            });
            local u24 = {};
            if l__UserInputService__2.VREnabled then
                u24.Enabled = true;
            else
                u24.Enabled = false;
                l__UserInputService__2:GetPropertyChangedSignal("VREnabled"):Connect(function() --[[ Line: 136 ]]
                    -- upvalues: u24 (copy), l__UserInputService__2 (ref)
                    u24.Enabled = l__UserInputService__2.VREnabled;
                end);
            end;
            function u24.CreateView(_, ...) --[[ Line: 141 ]]
                -- upvalues: u24 (copy), l__Parent__3 (ref)
                if not u24.Enabled then
                    error("Menu API is not enabled for non-VR players. Check Api.Menu.Enabled before calling.");
                end;
                return require(l__Parent__3:WaitForChild("UI"):WaitForChild("MainMenu")).GetInstance():CreateView(...);
            end;
            function u24.IsOpen() --[[ Line: 144 ]]
                -- upvalues: u24 (copy), l__Parent__3 (ref)
                if not u24.Enabled then
                    error("Menu API is not enabled for non-VR players. Check Api.Menu.Enabled before calling.");
                end;
                return require(l__Parent__3:WaitForChild("UI"):WaitForChild("MainMenu")).GetInstance().ScreenGui.Enabled;
            end;
            function u24.Open(p25) --[[ Line: 147 ]]
                -- upvalues: u24 (copy), l__Parent__3 (ref)
                if p25:IsOpen() then
                else
                    if not u24.Enabled then
                        error("Menu API is not enabled for non-VR players. Check Api.Menu.Enabled before calling.");
                    end;
                    require(l__Parent__3:WaitForChild("UI"):WaitForChild("MainMenu")).GetInstance():Toggle();
                end;
            end;
            function u24.Close(p26) --[[ Line: 151 ]]
                -- upvalues: u24 (copy), l__Parent__3 (ref)
                if p26:IsOpen() then
                    if not u24.Enabled then
                        error("Menu API is not enabled for non-VR players. Check Api.Menu.Enabled before calling.");
                    end;
                    require(l__Parent__3:WaitForChild("UI"):WaitForChild("MainMenu")).GetInstance():Toggle();
                end;
            end;
            u10:Register("Menu", u24);
            local u27 = require(l__Parent__3:WaitForChild("State"):WaitForChild("Settings")).GetInstance();
            u10:Register("Settings", {
                GetSetting = function(_, p28) --[[ Name: GetSetting, Line 160 ]]
                    -- upvalues: u27 (copy)
                    return u27:GetSetting(p28);
                end,
                SetSetting = function(_, p29, p30) --[[ Name: SetSetting, Line 163 ]]
                    -- upvalues: u27 (copy)
                    u27:SetSetting(p29, p30);
                end,
                GetSettingsChangedSignal = function(_, p31) --[[ Name: GetSettingsChangedSignal, Line 166 ]]
                    -- upvalues: u27 (copy)
                    return u27:GetSettingsChangedSignal(p31);
                end
            });
        end);
    end;
    return u10;
end;
