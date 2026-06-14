-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Character.Controller.TeleportController
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Workspace__1 = game:GetService("Workspace");
local l__Parent__2 = script.Parent.Parent.Parent;
local l__Api__3 = require(l__Parent__2).Api;
local l__BaseController__4 = require(script.Parent:WaitForChild("BaseController"));
local l__ArcWithBeacon__5 = require(script.Parent:WaitForChild("Visual"):WaitForChild("ArcWithBeacon"));
local u1 = require(l__Parent__2:WaitForChild("State"):WaitForChild("VRInputService")).GetInstance();
local u2 = {};
u2.__index = u2;
setmetatable(u2, l__BaseController__4);
function u2.new() --[[ Line: 38 ]]
    -- upvalues: l__BaseController__4 (copy), u2 (copy)
    local v3 = l__BaseController__4.new();
    local v4 = setmetatable(v3, u2);
    v4.ActionsToLock = { Enum.KeyCode.Thumbstick1, Enum.KeyCode.ButtonR3 };
    return v4;
end;
function u2.Enable(p5) --[[ Line: 47 ]]
    -- upvalues: l__BaseController__4 (copy), l__ArcWithBeacon__5 (copy)
    l__BaseController__4.Enable(p5);
    p5.LeftArc = l__ArcWithBeacon__5.new();
    p5.RightArc = l__ArcWithBeacon__5.new();
    p5.ArcControls = {
        {
            Thumbstick = Enum.KeyCode.Thumbstick1,
            UserCFrame = Enum.UserCFrame.LeftHand,
            Arc = p5.LeftArc
        },
        {
            Thumbstick = Enum.KeyCode.Thumbstick2,
            UserCFrame = Enum.UserCFrame.RightHand,
            Arc = p5.RightArc
        }
    };
end;
function u2.Disable(p6) --[[ Line: 70 ]]
    -- upvalues: l__BaseController__4 (copy)
    l__BaseController__4.Disable(p6);
    p6.LeftArc:Destroy();
    p6.RightArc:Destroy();
end;
function u2.UpdateCharacter(u7) --[[ Line: 81 ]]
    -- upvalues: l__BaseController__4 (copy), u1 (copy), l__Api__3 (copy), l__Workspace__1 (copy)
    l__BaseController__4.UpdateCharacter(u7);
    if u7.Character then
        local v8 = u1:GetVRInputs();
        for _, v9 in Enum.UserCFrame:GetEnumItems() do
            v8[v9] = u7:ScaleInput(v8[v9]);
        end;
        local v10 = u7.Character:GetHumanoidSeatPart();
        for _, u11 in u7.ArcControls do
            if u11.Thumbstick == Enum.KeyCode.Thumbstick1 and (v10 and v10:IsA("VehicleSeat")) then
                u11.Arc:Hide();
            else
                local v12 = not l__Api__3.Controller or l__Api__3.Controller:IsControllerInputEnabled(u11.UserCFrame);
                local v13, v14, v15 = u7:GetJoystickState(u11);
                if v12 then
                    local l__HumanoidRootPart__6 = u7.Character.Parts.HumanoidRootPart;
                    if v13 ~= "Forward" or v14 == "Released" then
                        u11.Arc:Hide();
                    end;
                    if v15 == "Released" then
                        u11.Arc:Hide();
                        if v13 == "Forward" then
                            local l__LastHitPart__7 = u11.LastHitPart;
                            if l__LastHitPart__7 and u11.LastHitPosition then
                                u7:PlayBlur();
                                local v16;
                                if v10 then
                                    u7.IgnoreNextExternalTeleport = true;
                                    u7.Character.Humanoid.Sit = false;
                                    v16 = true;
                                else
                                    v16 = false;
                                end;
                                if (l__LastHitPart__7:IsA("Seat") or l__LastHitPart__7:IsA("VehicleSeat")) and not (l__LastHitPart__7.Occupant or l__LastHitPart__7.Disabled) then
                                    if v16 then
                                        task.spawn(function() --[[ Line: 140 ]]
                                            -- upvalues: u7 (copy), l__LastHitPart__7 (copy)
                                            while u7.Character.Humanoid.SeatPart do
                                                task.wait();
                                            end;
                                            l__LastHitPart__7:Sit(u7.Character.Humanoid);
                                        end);
                                    else
                                        l__LastHitPart__7:Sit(u7.Character.Humanoid);
                                    end;
                                elseif v16 then
                                    task.spawn(function() --[[ Line: 151 ]]
                                        -- upvalues: u7 (copy), l__HumanoidRootPart__6 (copy), u11 (copy)
                                        while u7.Character.Humanoid.SeatPart do
                                            task.wait();
                                        end;
                                        l__HumanoidRootPart__6.CFrame = CFrame.new(u11.LastHitPosition) * CFrame.new(0, 4.5 * u7.Character:GetHumanoidScale("BodyHeightScale"), 0) * (CFrame.new(-l__HumanoidRootPart__6.Position) * l__HumanoidRootPart__6.CFrame);
                                    end);
                                else
                                    l__HumanoidRootPart__6.CFrame = CFrame.new(u11.LastHitPosition) * CFrame.new(0, 4.5 * u7.Character:GetHumanoidScale("BodyHeightScale"), 0) * (CFrame.new(-l__HumanoidRootPart__6.Position) * l__HumanoidRootPart__6.CFrame);
                                end;
                            end;
                        end;
                    elseif v15 == "Cancel" then
                        u11.Arc:Hide();
                    elseif v13 == "Forward" and v14 == "Extended" then
                        local v17, v18 = u11.Arc:Update(l__Workspace__1.CurrentCamera:GetRenderCFrame() * v8[Enum.UserCFrame.Head]:Inverse() * v8[u11.UserCFrame]);
                        u11.LastHitPart = v17;
                        u11.LastHitPosition = v18;
                    end;
                    u7:UpdateRotating(u11.UserCFrame, v13, v15);
                else
                    u11.Arc:Hide();
                    u11.WaitForRelease = false;
                    u11.RadiusState = nil;
                end;
            end;
        end;
    end;
end;
return u2;
