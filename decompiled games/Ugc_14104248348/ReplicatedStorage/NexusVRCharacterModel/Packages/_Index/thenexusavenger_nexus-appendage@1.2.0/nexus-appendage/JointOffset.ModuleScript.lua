-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_nexus-appendage@1.2.0.nexus-appendage.JointOffset
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local u1 = {};
u1.__index = u1;
function u1.new(p2, p3, u4) --[[ Line: 26 ]]
    -- upvalues: u1 (copy)
    local u5 = setmetatable({
        Destroyed = false,
        JointType = p2.ClassName,
        Motor = p2,
        Part0 = p3,
        AttachmentCFrame = CFrame.identity,
        ActiveTweens = {},
        EventConnections = {}
    }, u1);
    table.insert(u5.EventConnections, p3.ChildAdded:Connect(function(p6) --[[ Line: 39 ]]
        -- upvalues: u4 (copy), u5 (copy)
        if p6.Name == u4 and p6:IsA("Attachment") then
            u5:ConnectAttachment(p6);
        end;
    end));
    u5:ConnectAttachment((p3:FindFirstChild(u4)));
    return u5;
end;
function u1.ConnectAttachment(u7, u8) --[[ Line: 52 ]]
    if u8 then
        u7.AttachmentCFrame = u8.CFrame;
        u7.StartAttachment = u8;
        local l__EventConnections__2 = u7.EventConnections;
        local v9 = u7.Part0:GetPropertyChangedSignal("Size");
        table.insert(l__EventConnections__2, v9:Connect(function() --[[ Line: 62 ]]
            -- upvalues: u7 (copy), u8 (copy)
            if u7.StartAttachment == u8 then
                u7.AttachmentCFrame = u8.CFrame;
            end;
        end));
    end;
end;
function u1.SetProperty(p10, p11, p12, p13, p14) --[[ Line: 71 ]]
    -- upvalues: l__TweenService__1 (copy)
    if p10.Destroyed then
    elseif p14 then
        if not p10.ActiveTweens[p11] then
            p10.ActiveTweens[p11] = {};
        end;
        local v15 = l__TweenService__1:Create(p11, p14, {
            [p12] = p13
        });
        v15:Play();
        p10.ActiveTweens[p11][p12] = v15;
    else
        p11[p12] = p13;
    end;
end;
function u1.SetOffset(p16, p17, p18) --[[ Line: 88 ]]
    if p16.JointType == "Motor6D" then
        p16:SetProperty(p16.Motor, "C0", p16.AttachmentCFrame * p17, p18);
    else
        if p16.JointType == "AnimationConstraint" and p16.StartAttachment then
            p16:SetProperty(p16.StartAttachment, "CFrame", p16.AttachmentCFrame * p17, p18);
        end;
    end;
end;
function u1.Destroy(p19) --[[ Line: 99 ]]
    p19.Destroyed = true;
    for _, v20 in p19.EventConnections do
        v20:Disconnect();
    end;
    for _, v21 in p19.ActiveTweens do
        for _, v22 in v21 do
            v22:Cancel();
        end;
    end;
    p19.ActiveTweens = {};
    if p19.Motor:IsA("Motor6D") then
        p19.Motor.C0 = p19.AttachmentCFrame;
    else
        if p19.Motor:IsA("AnimationConstraint") and p19.StartAttachment then
            p19.StartAttachment.CFrame = p19.AttachmentCFrame;
        end;
    end;
end;
return u1;
