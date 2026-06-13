-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Frustum
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Parent__1 = script.Parent;
local l__Config__2 = require(l__Parent__1:WaitForChild("Config"));
local l__Utilities__3 = require(l__Parent__1:WaitForChild("Utilities"));
local u22 = {
    GetCFrames = function(p1, p2) --[[ Name: GetCFrames, Line 8 ]]
        local l__CFrame__4 = p1.CFrame;
        local l__Position__5 = l__CFrame__4.Position;
        local l__RightVector__6 = l__CFrame__4.RightVector;
        local l__UpVector__7 = l__CFrame__4.UpVector;
        local v3 = p2 * 0.5;
        local v4 = math.tan((p1.FieldOfView + 5) * 0.5 * 0.017453) * p2;
        local v5 = v4 * (p1.ViewportSize.X / p1.ViewportSize.Y);
        local v6 = l__CFrame__4 * CFrame.new(0, 0, -p2);
        local v7 = v6 * Vector3.new(v5, v4, 0);
        local v8 = v6 * Vector3.new(-v5, -v4, 0);
        local v9 = v6 * Vector3.new(v5, -v4, 0);
        return (l__CFrame__4 * CFrame.new(0, 0, -v3)):Inverse(), v5, v4, v3, l__UpVector__7:Cross(v9 - l__Position__5).Unit, l__UpVector__7:Cross(v8 - l__Position__5).Unit, l__RightVector__6:Cross(l__Position__5 - v7).Unit, l__RightVector__6:Cross(l__Position__5 - v9).Unit, l__CFrame__4;
    end,
    InViewFrustum = function(p10, p11, p12, p13, p14, p15, p16, p17, p18, p19) --[[ Name: InViewFrustum, Line 32 ]]
        local l__Position__8 = p19.Position;
        local v20 = p11 * p10;
        if p12 < v20.X or (v20.X < -p12 or (p13 < v20.Y or (v20.Y < -p13 or (p14 < v20.Z or v20.Z < -p14)))) then
            return false;
        end;
        local v21 = p10 - l__Position__8;
        return p15:Dot(v21) >= 0 and (p16:Dot(v21) <= 0 and (p17:Dot(v21) >= 0 and p18:Dot(v21) <= 0));
    end
};
function u22.ObjectInFrustum(p23, p24, p25, p26, p27, p28, p29, p30, p31, p32) --[[ Line: 73 ]]
    -- upvalues: l__Config__2 (copy), l__Utilities__3 (copy), u22 (copy)
    local l__CFrame__9 = p23.CFrame;
    local l__Size__10 = p23.Size;
    local v33 = l__Config__2.FAR_PLANE * 0.5;
    local v34 = l__Utilities__3.ClosestPointOnLine(p32.Position + p32.LookVector * v33, p32.LookVector, v33, l__CFrame__9.Position);
    local v35, v36 = l__Utilities__3.ClosestPointInBox(l__CFrame__9, l__Size__10, v34);
    return v35 and true or (u22.InViewFrustum(v36, p24, p25, p26, p27, p28, p29, p30, p31, p32) and true or false);
end;
return u22;
