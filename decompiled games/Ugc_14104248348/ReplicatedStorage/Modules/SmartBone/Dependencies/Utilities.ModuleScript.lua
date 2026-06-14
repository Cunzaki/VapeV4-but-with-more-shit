-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Utilities
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__HttpService__1 = game:GetService("HttpService");
local l__Config__2 = require(script.Parent:WaitForChild("Config"));
local l__DefaultObjectSettings__3 = require(script.Parent:WaitForChild("DefaultObjectSettings"));
local u1 = {
    Block = "Box",
    Ball = "Sphere",
    Capsule = "Capsule",
    Sphere = "Sphere",
    Box = "Box",
    Cylinder = "Cylinder"
};
local u55 = {
    LogIndent = 0,
    GetRotationBetween = function(p2, p3) --[[ Name: GetRotationBetween, Line 25 ]]
        local v4 = p2:Dot(p3);
        local l__Magnitude__4 = p2:Cross(p3).Magnitude;
        local v5 = math.atan2(l__Magnitude__4, v4);
        local v6 = p2:Cross(p3);
        return CFrame.fromAxisAngle(v6.Magnitude == 0 and Vector3.new(-0, -1, -0) or v6.Unit, v5);
    end,
    GetCFrameAxis = function(p7, p8) --[[ Name: GetCFrameAxis, Line 34 ]]
        local v9, v10, v11 = p7:ToEulerAnglesXYZ();
        if p8 == "X" then
            return v9;
        elseif p8 == "Y" then
            return v10;
        elseif p8 == "Z" then
            return v11;
        else
            return nil;
        end;
    end,
    GatherObjectSettings = function(p12) --[[ Name: GatherObjectSettings, Line 46 ]]
        -- upvalues: l__DefaultObjectSettings__3 (copy)
        local v13 = {};
        for v14, v15 in l__DefaultObjectSettings__3 do
            local v16 = p12:GetAttribute(v14);
            if v16 ~= nil then
                local v17 = typeof(v15);
                local v18;
                if typeof(v16) == v17 then
                    v18 = true;
                else
                    warn((`[SmartBone][Object] Expected attribute {v14} on {p12.Name} to be of type {v17}, got type {typeof(v16)}`));
                    v18 = false;
                end;
                if not v18 then
                    v16 = nil;
                end;
            end;
            v13[v14] = v16 == nil and v15 and v15 or v16;
        end;
        return v13;
    end,
    GatherBoneSettings = function(p19) --[[ Name: GatherBoneSettings, Line 73 ]]
        local v20 = p19:GetAttribute("XAxisLocked") or false;
        local v21 = p19:GetAttribute("YAxisLocked") or false;
        local v22 = p19:GetAttribute("ZAxisLocked") or false;
        local v23 = p19:GetAttribute("XAxisLimits") or NumberRange.new((-1 / 0), (1 / 0));
        local v24 = p19:GetAttribute("YAxisLimits") or NumberRange.new((-1 / 0), (1 / 0));
        local v25 = p19:GetAttribute("ZAxisLimits") or NumberRange.new((-1 / 0), (1 / 0));
        local v26 = p19:GetAttribute("Radius") or 0.25;
        local v27 = p19:GetAttribute("RotationLimit") or 180;
        local v28 = p19:GetAttribute("Force") or "¬";
        local v29 = p19:GetAttribute("Gravity") or "¬";
        if typeof(v20) ~= "boolean" then
            warn((`[SmartBone][Bone] Expected attribute XAxisLocked on {p19.Name} to be of type boolean, got type {typeof(v20)}`));
        end;
        if typeof(v21) ~= "boolean" then
            warn((`[SmartBone][Bone] Expected attribute YAxisLocked on {p19.Name} to be of type boolean, got type {typeof(v21)}`));
        end;
        if typeof(v22) ~= "boolean" then
            warn((`[SmartBone][Bone] Expected attribute ZAxisLocked on {p19.Name} to be of type boolean, got type {typeof(v22)}`));
        end;
        if typeof(v23) ~= "NumberRange" then
            warn((`[SmartBone][Bone] Expected attribute XAxisLimits on {p19.Name} to be of type NumberRange, got type {typeof(v23)}`));
        end;
        if typeof(v24) ~= "NumberRange" then
            warn((`[SmartBone][Bone] Expected attribute YAxisLimits on {p19.Name} to be of type NumberRange, got type {typeof(v24)}`));
        end;
        if typeof(v25) ~= "NumberRange" then
            warn((`[SmartBone][Bone] Expected attribute ZAxisLimits on {p19.Name} to be of type NumberRange, got type {typeof(v25)}`));
        end;
        if typeof(v26) ~= "number" then
            warn((`[SmartBone][Bone] Expected attribute Radius on {p19.Name} to be of type number, got type {typeof(v26)}`));
        end;
        if typeof(v27) ~= "number" then
            warn((`[SmartBone][Bone] Expected attribute RotationLimit on {p19.Name} to be of type number, got type {typeof(v27)}`));
        end;
        if v28 ~= "¬" and typeof(v28) ~= "Vector3" then
            warn((`[SmartBone][Bone] Expected attribute Force on {p19.Name} to be of type Vector3, got type {typeof(v28)}`));
        end;
        if v28 ~= "¬" and typeof(v29) ~= "Vector3" then
            warn((`[SmartBone][Bone] Expected attribute Gravity on {p19.Name} to be of type Vector3, got type {typeof(v29)}`));
        end;
        return {
            AxisLocked = { v20, v21, v22 },
            XAxisLimits = v23,
            YAxisLimits = v24,
            ZAxisLimits = v25,
            RotationLimit = v27,
            Radius = v26,
            Force = v28,
            Gravity = v29
        };
    end,
    ClosestPointOnLine = function(p30, p31, p32, p33) --[[ Name: ClosestPointOnLine, Line 132 ]]
        local v34 = (p33 - p30):Dot(p31);
        return p30 + p31 * math.clamp(v34, -p32, p32);
    end,
    ClosestPointInBox = function(p35, p36, p37) --[[ Name: ClosestPointInBox, Line 140 ]]
        local v38 = p35:PointToObjectSpace(p37);
        local l__X__5 = p36.X;
        local l__X__6 = p36.X;
        local l__Z__7 = p36.Z;
        local l__X__8 = v38.X;
        local l__Y__9 = v38.Y;
        local l__Z__10 = v38.Z;
        if v38 ~= v38 or p36 ~= p36 then
            return false, p35.Position, Vector3.new(0, 1, 0);
        end;
        local v39 = math.clamp(l__X__8, -l__X__5 * 0.5, l__X__5 * 0.5);
        local v40 = math.clamp(l__Y__9, -l__X__6 * 0.5, l__X__6 * 0.5);
        local v41 = math.clamp(l__Z__10, -l__Z__7 * 0.5, l__Z__7 * 0.5);
        if v39 ~= l__X__8 or (v40 ~= l__Y__9 or v41 ~= l__Z__10) then
            local v42 = p35 * Vector3.new(v39, v40, v41);
            return false, v42, (p37 - v42).unit;
        end;
        local v43 = l__X__8 - l__X__5 * 0.5;
        local v44 = l__Y__9 - l__X__6 * 0.5;
        local v45 = l__Z__10 - l__Z__7 * 0.5;
        local v46 = -l__X__8 - l__X__5 * 0.5;
        local v47 = -l__Y__9 - l__X__6 * 0.5;
        local v48 = -l__Z__10 - l__Z__7 * 0.5;
        local v49 = math.max(v43, v44, v45, v46, v47, v48);
        if v49 == v43 then
            return true, p35 * Vector3.new(l__X__5 * 0.5, l__Y__9, l__Z__10), p35.XVector;
        end;
        if v49 == v44 then
            return true, p35 * Vector3.new(l__X__8, l__X__6 * 0.5, l__Z__10), p35.YVector;
        end;
        if v49 == v45 then
            return true, p35 * Vector3.new(l__X__8, l__Y__9, l__Z__7 * 0.5), p35.ZVector;
        end;
        if v49 == v46 then
            return true, p35 * Vector3.new(-l__X__5 * 0.5, l__Y__9, l__Z__10), -p35.XVector;
        end;
        if v49 == v47 then
            return true, p35 * Vector3.new(l__X__8, -l__X__6 * 0.5, l__Z__10), -p35.YVector;
        end;
        if v49 == v48 then
            return true, p35 * Vector3.new(l__X__8, l__Y__9, -l__Z__7 * 0.5), -p35.ZVector;
        end;
        warn("CLOSEST POINT ON BOX FAIL");
        return false, Vector3.new(0, 0, 0), Vector3.new(0, 1, 0);
    end,
    GetCollider = function(p50) --[[ Name: GetCollider, Line 195 ]]
        -- upvalues: l__HttpService__1 (copy), u1 (copy)
        local v51 = p50:FindFirstChild("self.Collider");
        local v52;
        if v51 and v51:IsA("ModuleScript") then
            local u53 = require(v51);
            local u54 = nil;
            pcall(function() --[[ Line: 204 ]]
                -- upvalues: u54 (ref), l__HttpService__1 (ref), u53 (copy)
                u54 = l__HttpService__1:JSONDecode(u53);
            end);
            v52 = u54;
        else
            v52 = nil;
        end;
        return v52 or {
            {
                ScaleX = 1,
                ScaleY = 1,
                ScaleZ = 1,
                OffsetX = 0,
                OffsetY = 0,
                OffsetZ = 0,
                RotationX = 0,
                RotationY = 0,
                RotationZ = 0,
                Type = u1[p50:GetAttribute("ColliderShape") or (not p50:IsA("Part") and "Box" or p50.Shape.Name)] or "Box"
            }
        };
    end
};
function u55.SB_INDENT_LOG() --[[ Line: 251 ]]
    -- upvalues: u55 (copy)
    local v56 = u55;
    v56.LogIndent = v56.LogIndent + 1;
end;
function u55.SB_UNINDENT_LOG() --[[ Line: 255 ]]
    -- upvalues: u55 (copy)
    local v57 = u55;
    v57.LogIndent = v57.LogIndent - 1;
    u55.LogIndent = math.max(u55.LogIndent, 0);
end;
function u55.SB_ASSERT_CB(p58, p59, ...) --[[ Line: 260 ]]
    if p58 == false or p58 == nil then
        p59(...);
    end;
end;
function u55.SB_VERBOSE_LOG(p60) --[[ Line: 266 ]]
    -- upvalues: l__Config__2 (copy), u55 (copy)
    if l__Config__2.LOG_VERBOSE then
        local v61 = string.rep("    ", u55.LogIndent);
        print((`{v61}[SmartBone][Log]: {p60}`));
    end;
end;
function u55.SB_VERBOSE_WARN(p62) --[[ Line: 276 ]]
    -- upvalues: l__Config__2 (copy), u55 (copy)
    if l__Config__2.LOG_VERBOSE then
        local v63 = string.rep("    ", u55.LogIndent);
        warn((`{v63}[SmartBone][Warn]: {p62}`));
    end;
end;
function u55.SB_VERBOSE_ERROR(p64) --[[ Line: 286 ]]
    -- upvalues: l__Config__2 (copy), u55 (copy)
    if l__Config__2.LOG_VERBOSE then
        local v65 = string.rep("    ", u55.LogIndent);
        error((`{v65}[SmartBone][Error]: {p64}`));
    end;
end;
return u55;
