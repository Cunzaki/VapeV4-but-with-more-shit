-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Character.Head
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Parent__1 = script.Parent.Parent;
local l__NexusAppendage__2 = require(script.Parent.Parent:WaitForChild("Packages"):WaitForChild("NexusAppendage"));
local u1 = require(l__Parent__1:WaitForChild("State"):WaitForChild("Settings")).GetInstance();
local l__Limb__3 = l__NexusAppendage__2.Limb;
local u2 = {};
u2.__index = u2;
setmetatable(u2, l__Limb__3);
function u2.new(p3) --[[ Line: 24 ]]
    -- upvalues: l__Limb__3 (copy), u2 (copy)
    local v4 = l__Limb__3.new();
    local v5 = setmetatable(v4, u2);
    v5.Head = p3;
    return v5;
end;
function u2.GetEyesOffset(p6) --[[ Line: 34 ]]
    return p6:GetAttachmentCFrame(p6.Head, "FaceFrontAttachment") * CFrame.new(0, p6.Head.Size.Y / 4, 0);
end;
function u2.GetHeadCFrame(p7, p8) --[[ Line: 42 ]]
    return p8 * p7:GetEyesOffset():Inverse();
end;
function u2.GetNeckCFrame(p9, p10, p11) --[[ Line: 50 ]]
    -- upvalues: u1 (copy)
    local v12 = p9:GetHeadCFrame(p10) * p9:GetAttachmentCFrame(p9.Head, "NeckRigAttachment");
    local l__LookVector__4 = v12.LookVector;
    local v13 = math.atan2(l__LookVector__4.X, l__LookVector__4.Z) + 3.141592653589793;
    local v14 = math.asin(l__LookVector__4.Y);
    local v15 = 0;
    local v16 = u1:GetSetting("Appearance.MaxNeckTilt") or 1.0471975511965976;
    if v16 < v14 then
        v15 = v14 - v16;
    elseif v14 < -v16 then
        v15 = v14 + v16;
    end;
    local v17;
    if p11 then
        local v18 = v13 - p11;
        while v18 > 3.141592653589793 do
            v18 = v18 - 6.283185307179586;
        end;
        while v18 < -3.141592653589793 do
            v18 = v18 + 6.283185307179586;
        end;
        local v19 = u1:GetSetting("Appearance.MaxNeckSeatedRotation") or 1.0471975511965976;
        if v19 < v18 then
            v17 = v18 - v19;
        elseif v18 < -v19 then
            v17 = v18 + v19;
        else
            v17 = 0;
        end;
    else
        local v20 = u1:GetSetting("Appearance.MaxNeckRotation") or 0.6108652381980153;
        v17 = p9.LastNeckRotationGlobal;
        if v17 then
            local v21 = v13 - v17;
            while v21 > 3.141592653589793 do
                v21 = v21 - 6.283185307179586;
            end;
            while v21 < -3.141592653589793 do
                v21 = v21 + 6.283185307179586;
            end;
            if math.abs(v21) < 1.5 * v20 then
                if v20 < v21 then
                    v17 = v13 - v20;
                elseif v21 < -v20 then
                    v17 = v13 + v20;
                end;
            else
                v17 = v13;
            end;
        else
            v17 = v13;
        end;
    end;
    p9.LastNeckRotationGlobal = v17;
    return CFrame.new(v12.Position) * CFrame.Angles(0, v17, 0) * CFrame.Angles(v15, 0, 0);
end;
return u2;
