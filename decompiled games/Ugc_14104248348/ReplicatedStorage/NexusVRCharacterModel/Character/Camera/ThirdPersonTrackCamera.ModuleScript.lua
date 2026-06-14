-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Character.Camera.ThirdPersonTrackCamera
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__CommonCamera__2 = require(script.Parent.Parent.Parent:WaitForChild("Character"):WaitForChild("Camera"):WaitForChild("CommonCamera"));
local u1 = {};
u1.__index = u1;
setmetatable(u1, l__CommonCamera__2);
function u1.new() --[[ Line: 25 ]]
    -- upvalues: l__CommonCamera__2 (copy), u1 (copy)
    local v2 = l__CommonCamera__2.new();
    return setmetatable(v2, u1);
end;
function u1.Enable(p3) --[[ Line: 32 ]]
    p3.FetchInitialCFrame = true;
end;
function u1.Disable(p4) --[[ Line: 39 ]]
    p4.FetchInitialCFrame = nil;
end;
function u1.UpdateCamera(p5, p6) --[[ Line: 46 ]]
    -- upvalues: l__Players__1 (copy)
    if p5.FetchInitialCFrame then
        local v7 = math.atan2(-p6.LookVector.X, -p6.LookVector.Z);
        p5.BaseFaceAngleY = v7;
        p5.BaseCFrame = CFrame.new(p6.Position) * CFrame.Angles(0, v7, 0);
        p5.FetchInitialCFrame = nil;
    end;
    local v8 = 1;
    local l__Character__3 = l__Players__1.LocalPlayer.Character;
    if l__Character__3 then
        local v9 = l__Character__3:FindFirstChildOfClass("Humanoid");
        if v9 then
            local v10 = v9:FindFirstChild("BodyHeightScale");
            if v10 then
                v8 = v10.Value;
            end;
        end;
    end;
    local l__BaseCFrame__4 = p5.BaseCFrame;
    local v11 = l__BaseCFrame__4:Inverse() * p6;
    p5:SetCFrame(l__BaseCFrame__4 * CFrame.new(0, 0, v8 * -10) * CFrame.Angles(0, 3.141592653589793, 0) * v11);
end;
return u1;
