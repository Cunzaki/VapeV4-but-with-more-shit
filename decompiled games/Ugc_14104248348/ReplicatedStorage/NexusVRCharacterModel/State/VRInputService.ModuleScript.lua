-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.State.VRInputService
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__TypedEvent__1 = require(script.Parent.Parent:WaitForChild("Packages"):WaitForChild("NexusInstance")).TypedEvent;
local u1 = {};
u1.__index = u1;
local u2 = nil;
function u1.new(p3, p4) --[[ Line: 31 ]]
    -- upvalues: l__TypedEvent__1 (copy), u1 (copy)
    local v5 = {
        RecenterOffset = CFrame.identity,
        ThumbstickValues = {
            [Enum.KeyCode.Thumbstick1] = Vector3.new(0, 0, 0),
            [Enum.KeyCode.Thumbstick2] = Vector3.new(0, 0, 0)
        },
        VRService = p3 or game:GetService("VRService"),
        UserInputService = p4 or game:GetService("UserInputService"),
        Recentered = l__TypedEvent__1.new(),
        EyeLevelSet = l__TypedEvent__1.new()
    };
    local u6 = setmetatable(v5, u1);
    u6.UserInputService.InputEnded:Connect(function(p7) --[[ Line: 46 ]]
        -- upvalues: u6 (copy)
        if u6.ThumbstickValues[p7.KeyCode] then
            u6.ThumbstickValues[p7.KeyCode] = Vector3.new(0, 0, 0);
        end;
    end);
    u6.UserInputService.InputChanged:Connect(function(p8) --[[ Line: 51 ]]
        -- upvalues: u6 (copy)
        if u6.ThumbstickValues[p8.KeyCode] then
            u6.ThumbstickValues[p8.KeyCode] = p8.Position;
        end;
    end);
    return u6;
end;
function u1.GetInstance() --[[ Line: 64 ]]
    -- upvalues: u2 (ref), u1 (copy)
    if not u2 then
        u2 = u1.new();
    end;
    return u2;
end;
function u1.GetVRInputs(p9) --[[ Line: 75 ]]
    local v10 = {
        [Enum.UserCFrame.Head] = p9.VRService:GetUserCFrame(Enum.UserCFrame.Head)
    };
    if p9.VRService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand) then
        v10[Enum.UserCFrame.LeftHand] = p9.VRService:GetUserCFrame(Enum.UserCFrame.LeftHand);
    else
        v10[Enum.UserCFrame.LeftHand] = v10[Enum.UserCFrame.Head] * CFrame.new(-1, -2.5, 0.5);
    end;
    if p9.VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) then
        v10[Enum.UserCFrame.RightHand] = p9.VRService:GetUserCFrame(Enum.UserCFrame.RightHand);
    else
        v10[Enum.UserCFrame.RightHand] = v10[Enum.UserCFrame.Head] * CFrame.new(1, -2.5, 0.5);
    end;
    local v11;
    if p9.ManualNormalHeadLevel then
        v11 = -p9.ManualNormalHeadLevel;
    else
        local l__Y__2 = (v10[Enum.UserCFrame.Head] * CFrame.new(0, 0, 0.5)).Y;
        if not p9.HighestHeadHeight or p9.HighestHeadHeight < l__Y__2 then
            p9.HighestHeadHeight = l__Y__2;
        end;
        v11 = -p9.HighestHeadHeight;
    end;
    for _, v12 in { Enum.UserCFrame.Head, Enum.UserCFrame.LeftHand, Enum.UserCFrame.RightHand } do
        v10[v12] = CFrame.new(0, v11, 0) * p9.RecenterOffset * v10[v12];
    end;
    return v10;
end;
function u1.Recenter(p13) --[[ Line: 122 ]]
    local v14 = p13.VRService:GetUserCFrame(Enum.UserCFrame.Head);
    p13.RecenterOffset = CFrame.Angles(0, -math.atan2(-v14.LookVector.X, -v14.LookVector.Z), 0) * CFrame.new(-v14.X, 0, -v14.Z);
    p13.Recentered:Fire();
end;
function u1.SetEyeLevel(p15) --[[ Line: 131 ]]
    p15.ManualNormalHeadLevel = p15.VRService:GetUserCFrame(Enum.UserCFrame.Head).Y;
    p15.EyeLevelSet:Fire();
end;
function u1.GetThumbstickPosition(p16, p17) --[[ Line: 139 ]]
    return p16.ThumbstickValues[p17] or Vector3.new(0, 0, 0);
end;
return u1;
