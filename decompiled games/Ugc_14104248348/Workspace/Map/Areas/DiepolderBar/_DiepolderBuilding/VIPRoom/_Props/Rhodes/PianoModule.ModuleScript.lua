-- Decompiled from: Workspace.Map.Areas.DiepolderBar._DiepolderBuilding.VIPRoom._Props.Rhodes.PianoModule
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local v1 = l__RunService__1:IsClient();
local l__Parent__2 = script.Parent;
local v2 = {
    DefaultSoundFont = 3,
    Seat = l__Parent__2.Bench.Seat,
    Origin = l__Parent__2.KeyBox,
    Camera = { l__Parent__2.CameraA, l__Parent__2.CameraB, l__Parent__2.CameraC },
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
local v7 = CFrame.fromEulerAnglesXYZ(-0.05235987755982989, 0, 0);
local u8 = CFrame.new(Vector3.new(0, -0.066, 0)) * v7;
local u9 = CFrame.new(Vector3.new(0, -0.056, 0)) * v7;
local u10 = TweenInfo.new(0.1);
local u11 = nil;
local u12 = CFrame.fromEulerAnglesYXZ(0, 0, 1.2217304763960306) * CFrame.fromEulerAnglesYXZ(0, -1.5707963267948966, 0);
function v2.AnimateKeyDown(_, p13, p14, p15, _, _, _) --[[ Line: 55 ]]
    -- upvalues: u4 (copy), l__Keys__4 (copy), l__Tween__3 (copy), u10 (copy), u3 (copy), u9 (copy), u8 (copy), u11 (ref), u12 (copy), l__RunService__1 (copy)
    local v16 = math.clamp(p14 + p15 + 15, 1, 88);
    u4[v16] = p13;
    local v17 = l__Keys__4[v16];
    local v18 = l__Tween__3;
    local v19 = u10;
    local v20 = {};
    local v21 = u3[v17];
    local v22 = (p14 - 1) % 12 + 1;
    v20.CFrame = v21 * (((v22 % 12 == 2 or (v22 % 12 == 5 or (v22 % 12 == 7 or (v22 % 12 == 10 or v22 % 12 == 0)))) and true or nil) and u9 or u8);
    v18:Play(v17, v19, v20);
    local v23 = nil;
    local v24;
    if u11 then
        local v25 = v16 <= 44;
        if v25 then
            v24 = u11.leftLowerIKAttachment;
        else
            v24 = u11.rightLowerIKAttachment;
        end;
        local v26 = (v16 - (v25 and 1 or 44)) / 44;
        if u11.rigType == Enum.HumanoidRigType.R6 then
            local v27 = v26 * 60 + (v25 and -15 or 45) * (v25 and 1 or -1);
            v24.CFrame = v24:GetAttribute("originCFrame") * CFrame.fromEulerAnglesYXZ(0, 0, (math.rad(v27)));
            v23 = v24.CFrame;
            l__Tween__3:Play(v24, u10, {
                CFrame = v23 * CFrame.fromEulerAnglesYXZ(-0.08726646259971647, 0, 0)
            });
        elseif u11.rigType == Enum.HumanoidRigType.R15 then
            local v28;
            if v25 then
                v28 = u11.leftUpperIKAttachment;
            else
                v28 = u11.rightUpperIKAttachment;
            end;
            v28.CFrame = CFrame.new(v26 * 3 + (v25 and -5 or 2), -1.5, -2.5);
            v24.CFrame = v24.Parent.CFrame:toObjectSpace(v17.CFrame * u12);
            v23 = v24.CFrame;
            l__Tween__3:Play(v24, u10, {
                CFrame = v23 - Vector3.new(0, 0.5, 0)
            });
        end;
    else
        v24 = nil;
    end;
    local v29 = 0;
    while u4[v16] ~= p13 and v29 < 0.1 or u4[v16] == p13 and v29 < 4 do
        v29 = v29 + l__RunService__1.Heartbeat:Wait();
    end;
    l__Tween__3:Play(v17, u10, {
        CFrame = u3[v17]
    });
    if u11 then
        l__Tween__3:Play(v24, u10, {
            CFrame = v23
        });
    end;
end;
function v2.AnimateKeyUp(_, p30) --[[ Line: 98 ]]
    -- upvalues: u4 (copy)
    for v31, v32 in pairs(u4) do
        if v32 == p30 then
            u4[v31] = nil;
        end;
    end;
end;
function v2.AnimateSustainDown(_, _, p33) --[[ Line: 106 ]]
    -- upvalues: u5 (ref), l__RunService__1 (copy)
    if p33 == nil then
    else
        local v34 = 0;
        local v35 = os.clock();
        u5 = v35;
        while u5 ~= v35 and v34 < 0.1 or u5 == v35 and v34 < 4 do
            v34 = v34 + l__RunService__1.Heartbeat:Wait();
        end;
    end;
end;
function v2.AnimateSustainUp(_, _) --[[ Line: 126 ]]
    -- upvalues: u5 (ref)
    u5 = nil;
end;
function v2.ResetEffects() --[[ Line: 130 ]]
    -- upvalues: u4 (copy), u5 (ref), l__Keys__4 (copy), l__Tween__3 (copy), u10 (copy)
    table.clear(u4);
    u5 = nil;
    for v36 = 1, 88 do
        local v37 = l__Keys__4[v36];
        l__Tween__3:Play(v37, u10, {
            CFrame = originCFrames[v37]
        });
    end;
end;
local l__Players__5 = game:GetService("Players");
local function u40(p38) --[[ Line: 146 ]]
    -- upvalues: l__Players__5 (copy)
    if p38.Occupant then
        return p38.Occupant;
    end;
    local v39 = p38:FindFirstChild("SeatWeld");
    if v39 and (v39.Part1 and (v39.Part1.Parent and (v39.Part1.Parent:FindFirstChild("Humanoid") and l__Players__5:FindFirstChild(v39.Part1.Parent.Name)))) then
        return v39.Part1.Parent.Humanoid;
    end;
end;
local l__Seat__6 = v2.Seat;
local u41;
if u40(l__Seat__6) then
    u41 = l__Players__5:GetPlayerFromCharacter(u40(l__Seat__6).Parent) or nil;
else
    u41 = nil;
end;
local function u55(p42) --[[ Line: 160 ]]
    -- upvalues: l__Keys__4 (copy), u12 (copy), u11 (ref)
    local l__Character__7 = p42.Character;
    if l__Character__7 then
        local v43 = l__Character__7:FindFirstChild("Humanoid");
        local l__RigType__8 = v43.RigType;
        if v43 then
            local v44 = l__Character__7:FindFirstChild("HumanoidRootPart");
            if v44 then
                local v45 = Instance.new("IKControl");
                local v46 = Instance.new("IKControl");
                local v47 = Instance.new("Attachment");
                local v48 = Instance.new("Attachment");
                local v49 = Instance.new("IKControl");
                local v50 = Instance.new("IKControl");
                local v51 = Instance.new("Attachment");
                local v52 = Instance.new("Attachment");
                v45.Parent = v43;
                v46.Parent = v43;
                v47.Parent = v44;
                v48.Parent = v44;
                v49.Parent = v43;
                v50.Parent = v43;
                v51.Parent = v44;
                v52.Parent = v44;
                v49.Target = v51;
                v50.Target = v52;
                if l__RigType__8 == Enum.HumanoidRigType.R6 then
                    v51.CFrame = v51.CFrame * CFrame.fromEulerAnglesYXZ(1.0471975511965976, 0, 0);
                    v52.CFrame = v52.CFrame * CFrame.fromEulerAnglesYXZ(1.0471975511965976, 0, 0);
                    v51:SetAttribute("originCFrame", v51.CFrame);
                    v52:SetAttribute("originCFrame", v52.CFrame);
                    v49.EndEffector = l__Character__7:FindFirstChild("Left Arm");
                    v50.EndEffector = l__Character__7:FindFirstChild("Right Arm");
                    v49.ChainRoot = l__Character__7:FindFirstChild("Left Arm");
                    v50.ChainRoot = l__Character__7:FindFirstChild("Right Arm");
                elseif l__RigType__8 == Enum.HumanoidRigType.R15 then
                    local v53 = l__Keys__4:FindFirstChild(22).CFrame * u12;
                    v51.CFrame = v51.Parent.CFrame:toObjectSpace(v53);
                    local v54 = l__Keys__4:FindFirstChild(66).CFrame * u12;
                    v52.CFrame = v52.Parent.CFrame:toObjectSpace(v54);
                    v45.Parent = v43;
                    v46.Parent = v43;
                    v47.Parent = v44;
                    v48.Parent = v44;
                    v47.CFrame = CFrame.new(-3, -1.5, -2.5);
                    v48.CFrame = CFrame.new(3, -1.5, -2.5);
                    v45.Target = v47;
                    v46.Target = v48;
                    v45.EndEffector = l__Character__7:FindFirstChild("LeftLowerArm");
                    v46.EndEffector = l__Character__7:FindFirstChild("RightLowerArm");
                    v45.ChainRoot = l__Character__7:FindFirstChild("LeftUpperArm");
                    v46.ChainRoot = l__Character__7:FindFirstChild("RightUpperArm");
                    v49.EndEffector = l__Character__7:FindFirstChild("LeftHand");
                    v50.EndEffector = l__Character__7:FindFirstChild("RightHand");
                    v49.ChainRoot = l__Character__7:FindFirstChild("LeftLowerArm");
                    v50.ChainRoot = l__Character__7:FindFirstChild("RightLowerArm");
                    v49.Type = Enum.IKControlType.Position;
                    v50.Type = Enum.IKControlType.Position;
                end;
                u11 = {
                    rigType = v43.RigType,
                    leftUpperIKControl = v45,
                    rightUpperIKControl = v46,
                    leftUpperIKAttachment = v47,
                    rightUpperIKAttachment = v48,
                    leftLowerIKControl = v49,
                    rightLowerIKControl = v50,
                    leftLowerIKAttachment = v51,
                    rightLowerIKAttachment = v52
                };
            end;
        end;
    end;
end;
local function u57() --[[ Line: 226 ]]
    -- upvalues: u11 (ref)
    if u11 then
        for _, v56 in pairs(u11) do
            if typeof(v56) == "Instance" then
                v56:Destroy();
            end;
        end;
        u11 = nil;
    end;
end;
l__Seat__6:GetPropertyChangedSignal("Occupant"):Connect(function() --[[ Line: 235 ]]
    -- upvalues: u40 (copy), l__Seat__6 (copy), u41 (ref), l__Players__5 (copy), u57 (copy), u55 (copy)
    local v58 = u40(l__Seat__6);
    local v59;
    if v58 then
        v59 = l__Players__5:GetPlayerFromCharacter(v58.Parent);
    else
        v59 = nil;
    end;
    u41 = v59;
    u57();
    if u41 then
        u55(u41);
    end;
end);
if u41 then
    u55(u41);
end;
return v2;
