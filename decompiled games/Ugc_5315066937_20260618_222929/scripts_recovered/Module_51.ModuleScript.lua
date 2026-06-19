-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local v1 = pcall;
local v2 = Enum;
local v3 = {
    "ActionType",
    "ActuatorType",
    "AnimationPriority",
    "Axis",
    "BinType",
    "BodyPart",
    "Button",
    "ButtonStyle",
    "CameraMode",
    "CameraPanMode",
    "CameraType",
    "CellBlock",
    "CellMaterial",
    "CellOrientation",
    "CenterDialogType",
    "ChatColor",
    "ChatMode",
    "ChatStyle",
    "CollisionFidelity",
    "ComputerCameraMovementMode",
    "ComputerMovementMode",
    "ControlMode",
    "CoreGuiType",
    "CreatorType",
    "CurrencyType",
    "CustomCameraMode",
    "DevCameraOcclusionMode",
    "DevComputerCameraMovementMode",
    "DevComputerMovementMode",
    "DevTouchCameraMovementMode",
    "DevTouchMovementMode",
    "DialogPurpose",
    "DialogTone",
    "EasingDirection",
    "EasingStyle",
    "EnviromentalPhysicsThrottle",
    "ExplosionType",
    "FilterResult",
    "Font",
    "FontSize",
    "FormFactor",
    "FrameStyle",
    "FriendRequestEvent",
    "FriendStatus",
    "FunctionalTestResult",
    "GearGenreSetting",
    "GearType",
    "Genre",
    "HandlesStyle",
    "HttpContentType",
    "HumanoidDisplayDistanceType",
    "HumanoidRigType",
    "HumanoidStateType",
    "InfoType",
    "InOut",
    "InputType",
    "JointCreationMode",
    "KeyCode",
    "KeywordFilterType",
    "LeftRight",
    "LevelOfDetailSetting",
    "ListenerType",
    "Material",
    "MembershipType",
    "MeshType",
    "MessageType",
    "MouseBehavior",
    "MoveState",
    "NameOcclusion",
    "NetworkOwnership",
    "NormalId",
    "OverrideMouseIconBehavior",
    "PacketPriority",
    "PartType",
    "PathStatus",
    "Platform",
    "PlayerActions",
    "PlayerChatType",
    "PoseEasingDirection",
    "PoseEasingStyle",
    "PrivilegeType",
    "ProductPurchaseDecision",
    "RenderPriority",
    "ReverbType",
    "RollOffMode",
    "RotationType",
    "RuntimeUndoBehavior",
    "SavedQualitySetting",
    "SaveFilter",
    "ScaleType",
    "SizeConstraint",
    "SoundType",
    "SpecialKey",
    "Status",
    "Style",
    "SurfaceConstraint",
    "SurfaceType",
    "SwipeDirection",
    "TeleportState",
    "TeleportType",
    "TextXAlignment",
    "TextYAlignment",
    "ThreadPoolConfig",
    "ThrottlingPriority",
    "TickCountSampleMethod",
    "TopBottom",
    "TouchCameraMovementMode",
    "TouchMovementMode",
    "TweenStatus",
    "UiMessageType",
    "UploadSetting",
    "UserCFrame",
    "UserInputState",
    "UserInputType",
    "VibrationMotor",
    "VideoQualitySettings",
    "WaterDirection",
    "WaterForce"
};
local u4 = {};
local u5 = {};
local u6 = {};
local v7 = 0;
local function v10(p8, p9) --[[ Line: 2 ]]
    return p8[p9];
end;
local v11 = 0;
for v12 = 1, #v3 do
    local v13, v14 = v1(v10, v2, v3[v12]);
    if v13 then
        v11 = v11 + 1;
        local v15 = v14:GetEnumItems();
        local v16 = {};
        local v17 = {};
        for v18 = 1, #v15 do
            local v19 = v15[v18];
            u4[v19] = { v11, v18 };
            v16[v18] = v19;
            v17[v19] = v19;
            v17[v19.Name] = v19;
            v17[v19.Name:lower()] = v19;
            v17[v19.Value] = v19;
        end;
        u5[v11] = v16;
        u6[v14] = v17;
        if v7 < #v15 then
            v7 = #v15;
        end;
    else
        print(v3[v12], "is not a valid Enum item... anymore");
    end;
end;
return {
    Enumify = function(p20, _) --[[ Name: Enumify, Line 40 ]]
        -- upvalues: u6 (copy)
        local v21 = u6[p20];
        if v21 then
            return v21;
        end;
    end,
    ToEnumId = function(p22) --[[ Name: ToEnumId, Line 46 ]]
        -- upvalues: u4 (copy)
        local v23 = u4[p22];
        if v23 then
            return v23[1], v23[2];
        end;
    end,
    FromEnumId = function(p24, p25) --[[ Name: FromEnumId, Line 52 ]]
        -- upvalues: u5 (copy)
        local v26 = u5[p24];
        if v26 then
            return v26[p25];
        end;
        print("Invalid Enum index #1");
    end
};
