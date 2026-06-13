-- Decompiled from: Workspace.Map.Areas.DiepolderBar._DiepolderBuilding.Stage._Mechanics.GrandPiano.PianoModule
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local v1 = l__RunService__1:IsClient();
local l__Parent__2 = script.Parent;
local v2 = {
    DefaultSoundFont = 1,
    Seat = l__Parent__2.Bench.Seat,
    Origin = l__Parent__2.KeyBox,
    Camera = {
        l__Parent__2.CameraA,
        l__Parent__2.CameraB,
        l__Parent__2.CameraC,
        l__Parent__2.CameraD,
        l__Parent__2.CameraE,
        l__Parent__2.CameraF
    },
    Zone = l__Parent__2.Zone
};
if not v1 then
    return v2;
end;
local l__Tween__3 = require(script.Tween);
local l__Keys__4 = l__Parent__2.Keys;
local u3 = {};
local u4 = {};
local u5 = nil;
for _, v6 in pairs(l__Keys__4:GetChildren()) do
    u3[v6] = v6.CFrame;
end;
local u7 = CFrame.fromEulerAnglesYXZ(0, 0, 0.04363323129985824);
local u8 = CFrame.fromEulerAnglesYXZ(0, 0, 0.026179938779914945);
local u9 = TweenInfo.new(0.1);
local u10 = nil;
local u11 = CFrame.fromEulerAnglesYXZ(0, 0, 1.2217304763960306) * CFrame.fromEulerAnglesYXZ(0, -1.5707963267948966, 0);
function v2.AnimateKeyDown(_, p12, p13, p14, _, _, _) --[[ Line: 54 ]]
    -- upvalues: u4 (copy), l__Keys__4 (copy), l__Tween__3 (copy), u9 (copy), u3 (copy), u8 (copy), u7 (copy), u10 (ref), u11 (copy), l__RunService__1 (copy)
    local v15 = math.clamp(p13 + p14 + 15, 1, 88);
    u4[v15] = p12;
    local v16 = l__Keys__4[v15];
    local v17 = l__Tween__3;
    local v18 = u9;
    local v19 = {};
    local v20 = u3[v16];
    local v21 = (p13 - 1) % 12 + 1;
    v19.CFrame = v20 * (((v21 % 12 == 2 or (v21 % 12 == 5 or (v21 % 12 == 7 or (v21 % 12 == 10 or v21 % 12 == 0)))) and true or nil) and u8 or u7);
    v17:Play(v16, v18, v19);
    local v22 = nil;
    local v23;
    if u10 then
        local v24 = v15 <= 44;
        if v24 then
            v23 = u10.leftLowerIKAttachment;
        else
            v23 = u10.rightLowerIKAttachment;
        end;
        local v25 = (v15 - (v24 and 1 or 44)) / 44;
        if u10.rigType == Enum.HumanoidRigType.R6 then
            local v26 = v25 * 60 + (v24 and -15 or 45) * (v24 and 1 or -1);
            v23.CFrame = v23:GetAttribute("originCFrame") * CFrame.fromEulerAnglesYXZ(0, 0, (math.rad(v26)));
            v22 = v23.CFrame;
            l__Tween__3:Play(v23, u9, {
                CFrame = v22 * CFrame.fromEulerAnglesYXZ(-0.08726646259971647, 0, 0)
            });
        elseif u10.rigType == Enum.HumanoidRigType.R15 then
            local v27;
            if v24 then
                v27 = u10.leftUpperIKAttachment;
            else
                v27 = u10.rightUpperIKAttachment;
            end;
            v27.CFrame = CFrame.new(v25 * 3 + (v24 and -5 or 2), -1.5, -2.5);
            v23.CFrame = v23.Parent.CFrame:toObjectSpace(v16.CFrame * u11);
            v22 = v23.CFrame;
            l__Tween__3:Play(v23, u9, {
                CFrame = v22 - Vector3.new(0, 0.5, 0)
            });
        end;
    else
        v23 = nil;
    end;
    local v28 = 0;
    while u4[v15] ~= p12 and v28 < 0.1 or u4[v15] == p12 and v28 < 4 do
        v28 = v28 + l__RunService__1.Heartbeat:Wait();
    end;
    l__Tween__3:Play(v16, u9, {
        CFrame = u3[v16]
    });
    if u10 then
        l__Tween__3:Play(v23, u9, {
            CFrame = v22
        });
    end;
end;
function v2.AnimateKeyUp(_, p29) --[[ Line: 97 ]]
    -- upvalues: u4 (copy)
    for v30, v31 in pairs(u4) do
        if v31 == p29 then
            u4[v30] = nil;
        end;
    end;
end;
function v2.AnimateSustainDown(_, _, p32) --[[ Line: 105 ]]
    -- upvalues: u5 (ref), l__RunService__1 (copy)
    if p32 == nil then
    else
        local v33 = 0;
        local v34 = os.clock();
        u5 = v34;
        while u5 ~= v34 and v33 < 0.1 or u5 == v34 and v33 < 4 do
            v33 = v33 + l__RunService__1.Heartbeat:Wait();
        end;
    end;
end;
function v2.AnimateSustainUp(_, _) --[[ Line: 125 ]]
    -- upvalues: u5 (ref)
    u5 = nil;
end;
function v2.ResetEffects() --[[ Line: 129 ]]
    -- upvalues: u4 (copy), u5 (ref), l__Keys__4 (copy), l__Tween__3 (copy), u9 (copy)
    table.clear(u4);
    u5 = nil;
    for v35 = 1, 88 do
        local v36 = l__Keys__4[v35];
        l__Tween__3:Play(v36, u9, {
            CFrame = originCFrames[v36]
        });
    end;
end;
local l__Players__5 = game:GetService("Players");
local function u39(p37) --[[ Line: 145 ]]
    -- upvalues: l__Players__5 (copy)
    if p37.Occupant then
        return p37.Occupant;
    end;
    local v38 = p37:FindFirstChild("SeatWeld");
    if v38 and (v38.Part1 and (v38.Part1.Parent and (v38.Part1.Parent:FindFirstChild("Humanoid") and l__Players__5:FindFirstChild(v38.Part1.Parent.Name)))) then
        return v38.Part1.Parent.Humanoid;
    end;
end;
local l__Seat__6 = v2.Seat;
local u40;
if u39(l__Seat__6) then
    u40 = l__Players__5:GetPlayerFromCharacter(u39(l__Seat__6).Parent) or nil;
else
    u40 = nil;
end;
local function u54(p41) --[[ Line: 159 ]]
    -- upvalues: l__Keys__4 (copy), u11 (copy), u10 (ref)
    local l__Character__7 = p41.Character;
    if l__Character__7 then
        local v42 = l__Character__7:FindFirstChild("Humanoid");
        local l__RigType__8 = v42.RigType;
        if v42 then
            local v43 = l__Character__7:FindFirstChild("HumanoidRootPart");
            if v43 then
                local v44 = Instance.new("IKControl");
                local v45 = Instance.new("IKControl");
                local v46 = Instance.new("Attachment");
                local v47 = Instance.new("Attachment");
                local v48 = Instance.new("IKControl");
                local v49 = Instance.new("IKControl");
                local v50 = Instance.new("Attachment");
                local v51 = Instance.new("Attachment");
                v44.Parent = v42;
                v45.Parent = v42;
                v46.Parent = v43;
                v47.Parent = v43;
                v48.Parent = v42;
                v49.Parent = v42;
                v50.Parent = v43;
                v51.Parent = v43;
                v48.Target = v50;
                v49.Target = v51;
                if l__RigType__8 == Enum.HumanoidRigType.R6 then
                    v50.CFrame = v50.CFrame * CFrame.fromEulerAnglesYXZ(1.0471975511965976, 0, 0);
                    v51.CFrame = v51.CFrame * CFrame.fromEulerAnglesYXZ(1.0471975511965976, 0, 0);
                    v50:SetAttribute("originCFrame", v50.CFrame);
                    v51:SetAttribute("originCFrame", v51.CFrame);
                    v48.EndEffector = l__Character__7:FindFirstChild("Left Arm");
                    v49.EndEffector = l__Character__7:FindFirstChild("Right Arm");
                    v48.ChainRoot = l__Character__7:FindFirstChild("Left Arm");
                    v49.ChainRoot = l__Character__7:FindFirstChild("Right Arm");
                elseif l__RigType__8 == Enum.HumanoidRigType.R15 then
                    local v52 = l__Keys__4:FindFirstChild(22).CFrame * u11;
                    v50.CFrame = v50.Parent.CFrame:toObjectSpace(v52);
                    local v53 = l__Keys__4:FindFirstChild(66).CFrame * u11;
                    v51.CFrame = v51.Parent.CFrame:toObjectSpace(v53);
                    v44.Parent = v42;
                    v45.Parent = v42;
                    v46.Parent = v43;
                    v47.Parent = v43;
                    v46.CFrame = CFrame.new(-3, -1.5, -2.5);
                    v47.CFrame = CFrame.new(3, -1.5, -2.5);
                    v44.Target = v46;
                    v45.Target = v47;
                    v44.EndEffector = l__Character__7:FindFirstChild("LeftLowerArm");
                    v45.EndEffector = l__Character__7:FindFirstChild("RightLowerArm");
                    v44.ChainRoot = l__Character__7:FindFirstChild("LeftUpperArm");
                    v45.ChainRoot = l__Character__7:FindFirstChild("RightUpperArm");
                    v48.EndEffector = l__Character__7:FindFirstChild("LeftHand");
                    v49.EndEffector = l__Character__7:FindFirstChild("RightHand");
                    v48.ChainRoot = l__Character__7:FindFirstChild("LeftLowerArm");
                    v49.ChainRoot = l__Character__7:FindFirstChild("RightLowerArm");
                    v48.Type = Enum.IKControlType.Position;
                    v49.Type = Enum.IKControlType.Position;
                end;
                u10 = {
                    rigType = v42.RigType,
                    leftUpperIKControl = v44,
                    rightUpperIKControl = v45,
                    leftUpperIKAttachment = v46,
                    rightUpperIKAttachment = v47,
                    leftLowerIKControl = v48,
                    rightLowerIKControl = v49,
                    leftLowerIKAttachment = v50,
                    rightLowerIKAttachment = v51
                };
            end;
        end;
    end;
end;
local function u56() --[[ Line: 225 ]]
    -- upvalues: u10 (ref)
    if u10 then
        for _, v55 in pairs(u10) do
            if typeof(v55) == "Instance" then
                v55:Destroy();
            end;
        end;
        u10 = nil;
    end;
end;
l__Seat__6:GetPropertyChangedSignal("Occupant"):Connect(function() --[[ Line: 234 ]]
    -- upvalues: u39 (copy), l__Seat__6 (copy), u40 (ref), l__Players__5 (copy), u56 (copy), u54 (copy)
    local v57 = u39(l__Seat__6);
    local v58;
    if v57 then
        v58 = l__Players__5:GetPlayerFromCharacter(v57.Parent);
    else
        v58 = nil;
    end;
    u40 = v58;
    u56();
    if u40 then
        u54(u40);
    end;
end);
if u40 then
    u54(u40);
end;
return v2;
