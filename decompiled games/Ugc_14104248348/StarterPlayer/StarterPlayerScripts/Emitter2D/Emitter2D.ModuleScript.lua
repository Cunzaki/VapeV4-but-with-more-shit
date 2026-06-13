-- Decompiled from: StarterPlayer.StarterPlayerScripts.Emitter2D.Emitter2D
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__RunService__2 = game:GetService("RunService");
game:GetService("CoreGui");
local l__Players__3 = game:GetService("Players");
local l__Emitter__4 = script.Emitter;
local u1 = l__Emitter__4:GetAttributes();
local u2;
if l__RunService__2:IsRunning() then
    u2 = l__Players__3.LocalPlayer:WaitForChild("PlayerGui");
else
    u2 = game:GetService("StarterGui");
end;
local u3 = {
    SizeConstraint = { "Offset", "RelativeYY", "RelativeXX" },
    Orientation = { "Normal", "VelocityParallel", "VelocityPerpendicular" },
    EmissionShape = { "Area", "Center" },
    ClassName = { "Emitter2D" },
    ResampleMode = Enum.ResamplerMode,
    EasingStyle = Enum.EasingStyle,
    EasingDirection = Enum.EasingDirection
};
for v4, v5 in pairs(u3) do
    if typeof(v5) == "Enum" then
        local v6 = v5:GetEnumItems();
        for v7, v8 in pairs(v6) do
            v6[v7] = v8.Name;
        end;
        u3[v4] = v6;
    end;
end;
local function u14(p9, p10) --[[ Line: 85 ]]
    if p10 == 0 then
        return p9.Keypoints[1].Value;
    end;
    if p10 == 1 then
        return p9.Keypoints[#p9.Keypoints].Value;
    end;
    for v11 = 1, #p9.Keypoints - 1 do
        local v12 = p9.Keypoints[v11];
        local v13 = p9.Keypoints[v11 + 1];
        if v12.Time <= p10 and p10 < v13.Time then
            return v12.Value + (v13.Value - v12.Value) * ((p10 - v12.Time) / (v13.Time - v12.Time));
        end;
    end;
end;
local function u20(p15) --[[ Line: 106 ]]
    local l__Keypoints__5 = p15.Keypoints;
    if typeof(p15) == "NumberSequence" then
        local v16 = {};
        for v17 = 1, #l__Keypoints__5 do
            local v18 = l__Keypoints__5[v17];
            local v19 = {
                Time = v18.Time,
                Value = v18.Value + v18.Envelope * 2 * (math.random() - 0.5)
            };
            table.insert(v16, v19);
        end;
        return v16;
    end;
    if typeof(p15) == "ColorSequence" then
        return l__Keypoints__5;
    end;
end;
local u21 = {};
u21.__index = u21;
function u21.__tostring(p22) --[[ Line: 164 ]]
    return string.format("Emitter2D [%s] - ", p22.Config:GetFullName());
end;
u21.GlobalEnabled = true;
function u21.new() --[[ Line: 170 ]]
    -- upvalues: u21 (copy)
    return setmetatable({}, u21);
end;
function u21.Initiate(u23, u24) --[[ Line: 174 ]]
    -- upvalues: u1 (copy), u3 (copy), l__Emitter__4 (copy), u2 (ref)
    u23.Config = u24;
    u23.Active = false;
    u23.Events = {};
    u23.Cache = {};
    u23.CacheCount = 0;
    u23.Particles = {};
    u23.ParticleCount = 0;
    u23.Time = 0;
    u23.NextSpawn = 0;
    u23.Seed = Vector2.new(math.random(), math.random());
    u23.LastPosition = nil;
    u23.LastRotation = nil;
    if u24:FindFirstChild("Particles") then
        u24.Particles:Destroy();
    end;
    local u25 = Instance.new("Folder");
    u25.Name = "Particles_" .. u24.Name;
    u25.Archivable = false;
    u25.Parent = u24;
    u23.ParticleFolder = u25;
    u23.Events.ConfigNameChanged = u24:GetPropertyChangedSignal("Name"):Connect(function() --[[ Line: 207 ]]
        -- upvalues: u25 (copy), u24 (copy)
        u25.Name = "Particles_" .. u24.Name;
    end);
    local u26 = u24:GetAttributes();
    local function v35(p27, p28) --[[ Line: 215 ]]
        -- upvalues: u24 (copy), u1 (ref), u3 (ref), u26 (copy), u23 (copy)
        local v29 = p28 or u24:GetAttribute(p27);
        local v30, v31, v32;
        if typeof(v29) == typeof(u1[p27]) then
            local v33 = u3[p27];
            if v33 then
                for v34 = 1, #v33 do
                    if v29 == v33[v34] then
                        v30 = true;
                        v31 = nil;
                        if v30 then
                            u26[p27] = v29;
                            return;
                        else
                            v32 = u1[p27];
                            if v31 == "InvalidEnum" then
                                warn(("%s\'%s\' is not a valid value for attribute \'%s\'"):format(tostring(u23), tostring(v29), p27));
                                warn(("Valid values for %s are \'%s\'"):format(p27, table.concat(u3[p27], "\', \'")));
                            elseif v31 == "InvalidType" then
                                warn(("%s\'%s\' is not a valid type for attribute \'%s\'"):format(tostring(u23), typeof(v29), p27));
                            end;
                            warn(("Attribute has been reset to default value (%s)"):format((tostring(v32))));
                            u24:SetAttribute(p27, v32);
                            return;
                        end;
                    end;
                end;
                v30 = false;
                v31 = "InvalidEnum";
                if v30 then
                    u26[p27] = v29;
                    return;
                else
                    v32 = u1[p27];
                    if v31 == "InvalidEnum" then
                        warn(("%s\'%s\' is not a valid value for attribute \'%s\'"):format(tostring(u23), tostring(v29), p27));
                        warn(("Valid values for %s are \'%s\'"):format(p27, table.concat(u3[p27], "\', \'")));
                    elseif v31 == "InvalidType" then
                        warn(("%s\'%s\' is not a valid type for attribute \'%s\'"):format(tostring(u23), typeof(v29), p27));
                    end;
                    warn(("Attribute has been reset to default value (%s)"):format((tostring(v32))));
                    u24:SetAttribute(p27, v32);
                    return;
                end;
            end;
            v30 = true;
            v31 = nil;
        else
            v30 = false;
            v31 = "InvalidType";
        end;
        if v30 then
            u26[p27] = v29;
        else
            v32 = u1[p27];
            if v31 == "InvalidEnum" then
                warn(("%s\'%s\' is not a valid value for attribute \'%s\'"):format(tostring(u23), tostring(v29), p27));
                warn(("Valid values for %s are \'%s\'"):format(p27, table.concat(u3[p27], "\', \'")));
            elseif v31 == "InvalidType" then
                warn(("%s\'%s\' is not a valid type for attribute \'%s\'"):format(tostring(u23), typeof(v29), p27));
            end;
            warn(("Attribute has been reset to default value (%s)"):format((tostring(v32))));
            u24:SetAttribute(p27, v32);
        end;
    end;
    u23.Events.AttributeChanged = u24.AttributeChanged:Connect(v35);
    for v36, v37 in pairs(u26) do
        v35(v36, v37);
    end;
    for v38, v39 in pairs(l__Emitter__4:GetAttributes()) do
        if u26[v38] == nil then
            warn(("%sMissing attribute \'%s\', value has been set to default (%s)"):format(tostring(u23), v38, (tostring(v39))));
            u24:SetAttribute(v38, v39);
        end;
    end;
    u23.Attributes = u26;
    local function v40() --[[ Line: 253 ]]
        -- upvalues: u23 (copy), u26 (copy)
        u23.Time = 0;
        u23.NextSpawn = u26.EmissionRate.Min > 0 and 0 or (1 / 0);
    end;
    u23.Time = 0;
    u23.NextSpawn = u26.EmissionRate.Min > 0 and 0 or (1 / 0);
    u23.Events.RateChanged = u24:GetAttributeChangedSignal("EmissionRate"):Connect(v40);
    u23.Events.EnabledChanged = u24:GetAttributeChangedSignal("Enabled"):Connect(v40);
    u23.Events.TimeScaleChanged = u24:GetAttributeChangedSignal("TimeScale"):Connect(v40);
    local function v67() --[[ Line: 284 ]]
        -- upvalues: u24 (copy), u2 (ref), u23 (copy), u26 (copy)
        local l__Parent__6 = u24.Parent;
        local v41;
        if l__Parent__6 and l__Parent__6:IsA("GuiObject") then
            v41 = l__Parent__6:IsDescendantOf(u2);
        else
            v41 = false;
        end;
        if v41 then
            u23.Time = 0;
            u23.NextSpawn = u26.EmissionRate.Min > 0 and 0 or (1 / 0);
            u23.AbsoluteRotation = l__Parent__6.AbsoluteRotation;
            u23.AbsolutePosition = l__Parent__6.AbsolutePosition;
            u23.AbsoluteSize = l__Parent__6.AbsoluteSize;
            u23.LastPosition = nil;
            u23.LastRotation = nil;
            if u23.AncestorEvents then
                for _, v42 in pairs(u23.AncestorEvents) do
                    for _, v43 in pairs(v42) do
                        v43:Disconnect();
                    end;
                end;
            end;
            u23.AncestorEvents = {};
            u23.NotVisibleCount = 0;
            u23.ClipCount = 0;
            local l__Parent__7 = l__Parent__6.Parent;
            while l__Parent__7 do
                local u44 = {};
                if l__Parent__7:IsA("GuiObject") then
                    local u45 = false;
                    local function v48() --[[ Line: 326 ]]
                        -- upvalues: l__Parent__7 (copy), u45 (ref), u23 (ref)
                        if l__Parent__7.Visible then
                            if u45 == true then
                                u45 = false;
                                local v46 = u23;
                                v46.NotVisibleCount = v46.NotVisibleCount - 1;
                            end;
                        elseif u45 == false then
                            u45 = true;
                            local v47 = u23;
                            v47.NotVisibleCount = v47.NotVisibleCount + 1;
                        end;
                    end;
                    u44.VisibleChanged = l__Parent__7:GetPropertyChangedSignal("Visible"):Connect(v48);
                    if l__Parent__7.Visible then
                        if u45 == true then
                            u45 = false;
                            local v49 = u23;
                            v49.NotVisibleCount = v49.NotVisibleCount - 1;
                        end;
                    elseif u45 == false then
                        u45 = true;
                        local v50 = u23;
                        v50.NotVisibleCount = v50.NotVisibleCount + 1;
                    end;
                    local u51 = false;
                    local function u54() --[[ Line: 346 ]]
                        -- upvalues: l__Parent__6 (copy), l__Parent__7 (copy), u51 (ref), u23 (ref)
                        local l__AbsolutePosition__8 = l__Parent__6.AbsolutePosition;
                        local l__AbsoluteSize__9 = l__Parent__6.AbsoluteSize;
                        local l__AbsolutePosition__10 = l__Parent__7.AbsolutePosition;
                        local l__AbsoluteSize__11 = l__Parent__7.AbsoluteSize;
                        if (l__AbsolutePosition__10.x > l__AbsolutePosition__8.x + l__AbsoluteSize__9.x or (l__AbsolutePosition__10.x + l__AbsoluteSize__11.x < l__AbsolutePosition__8.x or l__AbsolutePosition__10.y > l__AbsolutePosition__8.y + l__AbsoluteSize__9.y)) and true or l__AbsolutePosition__10.y + l__AbsoluteSize__11.y < l__AbsolutePosition__8.y then
                            if u51 == false then
                                u51 = true;
                                local v52 = u23;
                                v52.ClipCount = v52.ClipCount + 1;
                            end;
                        elseif u51 == true then
                            u51 = false;
                            local v53 = u23;
                            v53.ClipCount = v53.ClipCount - 1;
                        end;
                    end;
                    local function v58() --[[ Line: 367 ]]
                        -- upvalues: l__Parent__7 (copy), u44 (copy), u54 (copy), l__Parent__6 (copy), u51 (ref), u23 (ref)
                        if l__Parent__7.ClipsDescendants then
                            u44.SizeChanged = l__Parent__7:GetPropertyChangedSignal("AbsoluteSize"):Connect(u54);
                            u44.ParentPositionChanged = l__Parent__6:GetPropertyChangedSignal("AbsolutePosition"):Connect(u54);
                            local l__AbsolutePosition__12 = l__Parent__6.AbsolutePosition;
                            local l__AbsoluteSize__13 = l__Parent__6.AbsoluteSize;
                            local l__AbsolutePosition__14 = l__Parent__7.AbsolutePosition;
                            local l__AbsoluteSize__15 = l__Parent__7.AbsoluteSize;
                            if (l__AbsolutePosition__14.x > l__AbsolutePosition__12.x + l__AbsoluteSize__13.x or (l__AbsolutePosition__14.x + l__AbsoluteSize__15.x < l__AbsolutePosition__12.x or l__AbsolutePosition__14.y > l__AbsolutePosition__12.y + l__AbsoluteSize__13.y)) and true or l__AbsolutePosition__14.y + l__AbsoluteSize__15.y < l__AbsolutePosition__12.y then
                                if u51 == false then
                                    u51 = true;
                                    local v55 = u23;
                                    v55.ClipCount = v55.ClipCount + 1;
                                end;
                            elseif u51 == true then
                                u51 = false;
                                local v56 = u23;
                                v56.ClipCount = v56.ClipCount - 1;
                            end;
                        else
                            if u44.SizeChanged then
                                u44.SizeChanged:Disconnect();
                            end;
                            if u44.ParentPositionChanged then
                                u44.ParentPositionChanged:Disconnect();
                            end;
                            if u51 then
                                u51 = false;
                                local v57 = u23;
                                v57.ClipCount = v57.ClipCount - 1;
                            end;
                        end;
                    end;
                    u44.ClipDescendantsChanged = l__Parent__7:GetPropertyChangedSignal("ClipsDescendants"):Connect(v58);
                    v58();
                elseif l__Parent__7:IsA("ScreenGui") then
                    local u59 = false;
                    local function v62() --[[ Line: 393 ]]
                        -- upvalues: l__Parent__7 (copy), u59 (ref), u23 (ref)
                        if l__Parent__7.Enabled then
                            if u59 == true then
                                u59 = false;
                                local v60 = u23;
                                v60.NotVisibleCount = v60.NotVisibleCount - 1;
                            end;
                        elseif u59 == false then
                            u59 = true;
                            local v61 = u23;
                            v61.NotVisibleCount = v61.NotVisibleCount + 1;
                        end;
                    end;
                    u44.EnabledChanged = l__Parent__7:GetPropertyChangedSignal("Enabled"):Connect(v62);
                    if l__Parent__7.Enabled then
                        if u59 == true then
                            u59 = false;
                            local v63 = u23;
                            v63.NotVisibleCount = v63.NotVisibleCount - 1;
                        end;
                    elseif u59 == false then
                        u59 = true;
                        local v64 = u23;
                        v64.NotVisibleCount = v64.NotVisibleCount + 1;
                    end;
                elseif l__Parent__7.ClassName ~= "Folder" then
                    break;
                end;
                u23.AncestorEvents[l__Parent__7] = u44;
                l__Parent__7 = l__Parent__7.Parent;
            end;
        else
            if u23.Events.Updater then
                u23.Events.Updater:Disconnect();
                u23.Events.Updater = nil;
            end;
            if u23.ParticleScreen then
                u23.ParticleScreen:Destroy();
                u23.ParticleScreen = nil;
            end;
            if u23.AncestorEvents then
                for _, v65 in pairs(u23.AncestorEvents) do
                    for _, v66 in pairs(v65) do
                        v66:Disconnect();
                    end;
                end;
            end;
            u23:ClearAllParticles();
            if u24:IsDescendantOf(u2) then
                warn(tostring(u23) .. "Emitter2D must be parented to a gui object!");
            end;
        end;
        u23.Active = v41;
    end;
    u23.Events.ParentChanged = u24.AncestryChanged:Connect(v67);
    v67();
    local v68 = u24:FindFirstChild("Emit") or Instance.new("BindableEvent");
    u23.Events.EmitFired = v68.Event:Connect(function(p69) --[[ Line: 452 ]]
        -- upvalues: u23 (copy)
        if u23.Active then
            for _ = 1, p69 or 1 do
                u23:SpawnParticle();
            end;
        else
            warn(tostring(u23) .. "Cannot emit particles while emitter is inactive. Make sure the emitter is parented to a gui in the players PlayerGui.");
        end;
    end);
    v68.Name = "Emit";
    v68.Archivable = false;
    v68.Parent = u24;
    local v70 = u24:FindFirstChild("TimeStep") or Instance.new("BindableEvent");
    u23.Events.TimeStepFired = v70.Event:Connect(function(p71) --[[ Line: 470 ]]
        -- upvalues: u23 (copy)
        if u23.Active then
            u23:Update(p71);
        else
            warn(tostring(u23) .. "Cannot update time while emitter is inactive. Make sure the emitter is parented to a gui in the players PlayerGui.");
        end;
    end);
    v70.Name = "TimeStep";
    v70.Archivable = false;
    v70.Parent = u24;
    local v72 = u24:FindFirstChild("Clear") or Instance.new("BindableEvent");
    u23.Events.ClearFired = v72.Event:Connect(function() --[[ Line: 486 ]]
        -- upvalues: u23 (copy)
        u23:ClearAllParticles();
    end);
    v72.Name = "Clear";
    v72.Archivable = false;
    v72.Parent = u24;
end;
function u21.Update(p73, p74) --[[ Line: 495 ]]
    local l__Attributes__16 = p73.Attributes;
    local l__Parent__17 = p73.Config.Parent;
    p73.Time = p73.Time + p74;
    local l__AbsoluteRotation__18 = l__Parent__17.AbsoluteRotation;
    local l__AbsolutePosition__19 = l__Parent__17.AbsolutePosition;
    local l__AbsoluteSize__20 = l__Parent__17.AbsoluteSize;
    p73.AbsoluteRotation = l__AbsoluteRotation__18;
    p73.AbsolutePosition = l__AbsolutePosition__19;
    p73.AbsoluteSize = l__AbsoluteSize__20;
    local l__LastPosition__21 = p73.LastPosition;
    if l__LastPosition__21 then
        if l__AbsolutePosition__19 == p73.Position then
            l__LastPosition__21 = false;
        else
            l__LastPosition__21 = l__AbsolutePosition__19 - p73.LastPosition;
        end;
    end;
    local l__LastRotation__22 = p73.LastRotation;
    if l__LastRotation__22 then
        if l__AbsoluteRotation__18 == p73.LastRotation then
            l__LastRotation__22 = false;
        else
            l__LastRotation__22 = l__AbsoluteRotation__18 - p73.LastRotation;
        end;
    end;
    local l__LastSize__23 = p73.LastSize;
    if l__LastSize__23 then
        if l__AbsoluteSize__20 == p73.LastSize then
            l__LastSize__23 = false;
        else
            l__LastSize__23 = Vector2.new(l__AbsoluteSize__20.X / p73.LastSize.X, l__AbsoluteSize__20.Y / p73.LastSize.Y);
        end;
    end;
    if l__LastRotation__22 or (p73.WorldDown == nil or p73.WorldRight == nil) then
        local v75 = math.rad(-l__AbsoluteRotation__18 + 180 - 90);
        p73.WorldDown = Vector2.new(math.cos(v75), (math.sin(v75)));
        local v76 = math.rad(-l__AbsoluteRotation__18 + 90 - 90);
        p73.WorldRight = Vector2.new(math.cos(v76), (math.sin(v76)));
    end;
    if l__Attributes__16.LockedToGui then
        if l__LastSize__23 then
            for _, v77 in pairs(p73.Particles) do
                v77.Position = v77.Position * l__LastSize__23;
            end;
        end;
    else
        if l__LastRotation__22 then
            local v78 = l__AbsoluteSize__20 / 2;
            for _, v79 in pairs(p73.Particles) do
                local v80 = v79.Position - v78;
                local l__Magnitude__24 = v80.Magnitude;
                local v81 = math.atan2(v80.X, -v80.Y);
                local v82 = math.deg(v81);
                local v83 = math.rad((v82 < (1 / 0) == false and 0 or v82) - l__LastRotation__22 - 90);
                v79.Position = v78 + Vector2.new(math.cos(v83), (math.sin(v83))) * l__Magnitude__24;
                if l__Attributes__16.Orientation == "Normal" then
                    v79.Rotation = v79.Rotation - l__LastRotation__22;
                end;
                local l__Velocity__25 = v79.Velocity;
                local l__Magnitude__26 = l__Velocity__25.Magnitude;
                local v84 = math.atan2(l__Velocity__25.X, -l__Velocity__25.Y);
                local v85 = math.deg(v84);
                local v86 = math.rad((v85 < (1 / 0) == false and 0 or v85) - l__LastRotation__22 - 90);
                v79.Velocity = Vector2.new(math.cos(v86), (math.sin(v86))) * l__Magnitude__26;
            end;
        end;
        if l__LastPosition__21 then
            if l__AbsoluteRotation__18 == 0 then
                for _, v87 in pairs(p73.Particles) do
                    v87.Position = v87.Position - l__LastPosition__21;
                end;
            else
                for _, v88 in pairs(p73.Particles) do
                    v88.Position = v88.Position - p73.WorldRight * l__LastPosition__21.X;
                    v88.Position = v88.Position - p73.WorldDown * l__LastPosition__21.Y;
                end;
            end;
        end;
    end;
    p73.LastPosition = l__AbsolutePosition__19;
    p73.LastRotation = l__AbsoluteRotation__18;
    p73.LastSize = l__AbsoluteSize__20;
    for _, v89 in pairs(p73.Particles) do
        p73:UpdateParticle(v89, p74);
    end;
    while p73.Time > p73.NextSpawn and l__Attributes__16.Enabled do
        local v90 = p73:SpawnParticle();
        if l__LastPosition__21 then
            v90.Velocity = v90.Velocity + l__LastPosition__21 * l__Attributes__16.VelocityInheritance / l__Attributes__16.MasterScale;
        end;
        p73:UpdateParticle(v90, p73.Time - p73.NextSpawn);
        local l__NextSpawn__27 = p73.NextSpawn;
        local l__Min__28 = l__Attributes__16.EmissionRate.Min;
        local l__Max__29 = l__Attributes__16.EmissionRate.Max;
        local v91 = math.random();
        p73.NextSpawn = l__NextSpawn__27 + 1 / (l__Min__28 + (l__Max__29 - l__Min__28) * v91);
    end;
end;
function u21.SpawnParticle(p92, p93, p94) --[[ Line: 598 ]]
    -- upvalues: u20 (copy)
    local l__Attributes__30 = p92.Attributes;
    local l__Parent__31 = p92.Config.Parent;
    local v95 = p92.Cache[p92.CacheCount];
    if v95 then
        p92.Cache[p92.CacheCount] = nil;
        p92.CacheCount = p92.CacheCount - 1;
    else
        v95 = Instance.new("ImageLabel");
    end;
    v95.Name = "Particle";
    v95.Image = l__Attributes__30.Texture;
    v95.Archivable = false;
    v95.BackgroundTransparency = 1;
    v95.AnchorPoint = Vector2.new(0.5, 0.5);
    v95.ResampleMode = Enum.ResamplerMode[l__Attributes__30.ResampleMode];
    local v96 = {
        Time = 0,
        ParticleGui = v95,
        ParentGui = l__Parent__31,
        Events = {},
        Seed = Vector2.new(math.random(), math.random()),
        Position = p93,
        Velocity = p94,
        Size = l__Attributes__30.Size.Min + (l__Attributes__30.Size.Max - l__Attributes__30.Size.Min) * math.random(),
        LifeTime = l__Attributes__30.LifeTime.Min + (l__Attributes__30.LifeTime.Max - l__Attributes__30.LifeTime.Min) * math.random(),
        Rotation = l__Attributes__30.Rotation.Min + (l__Attributes__30.Rotation.Max - l__Attributes__30.Rotation.Min) * math.random(),
        RotationSpeed = l__Attributes__30.RotationSpeed.Min + (l__Attributes__30.RotationSpeed.Max - l__Attributes__30.RotationSpeed.Min) * math.random()
    };
    if l__Attributes__30.RandomNoiseBias then
        v96.NoiseBias = ({ -1, 1 })[math.random(1, 2)];
    else
        v96.NoiseBias = 1;
    end;
    if p93 == nil then
        local _ = p92.AbsoluteRotation;
        local _ = p92.AbsolutePosition;
        local l__AbsoluteSize__32 = p92.AbsoluteSize;
        if l__Attributes__30.EmissionShape == "Area" then
            p93 = Vector2.new(l__AbsoluteSize__32.X * math.random(), l__AbsoluteSize__32.Y * math.random());
        elseif l__Attributes__30.EmissionShape == "Center" then
            p93 = l__AbsoluteSize__32 * 0.5;
        else
            error(tostring(p92) .. "Invalid EmissionShape -  Must be either \'Area\' or \'Center\'");
        end;
        v96.Position = p93;
    end;
    if p94 == nil then
        local v97 = l__Attributes__30.SpreadAngle * (math.random() - 0.5) * 2;
        local v98 = math.rad(l__Attributes__30.EmissionDirection - 90 + v97);
        local v99 = l__Attributes__30.Speed.Min + (l__Attributes__30.Speed.Max - l__Attributes__30.Speed.Min) * math.random();
        v96.Velocity = Vector2.new(math.cos(v98), (math.sin(v98))) * v99;
    end;
    v96.scaleSequence = u20(l__Attributes__30.Scale);
    v96.scaleSequenceIndex = 1;
    v96.squashSequence = u20(l__Attributes__30.Squash);
    v96.squashSequenceIndex = 1;
    v96.transparencySequence = u20(l__Attributes__30.Transparency);
    v96.transparencySequenceIndex = 1;
    v96.colorSequence = u20(l__Attributes__30.Color);
    v96.colorSequenceIndex = 1;
    p92.Particles[v95] = v96;
    p92.ParticleCount = p92.ParticleCount + 1;
    return v96;
end;
function u21.UpdateParticle(p100, p101, p102) --[[ Line: 705 ]]
    -- upvalues: u14 (copy), l__TweenService__1 (copy)
    local l__Attributes__33 = p100.Attributes;
    local l__ParticleGui__34 = p101.ParticleGui;
    local _ = p101.ParentGui;
    local v103 = l__Attributes__33.MasterScale * (l__Attributes__33.VeloScale or 1);
    p101.Time = p101.Time + p102;
    local v104 = p101.Time / p101.LifeTime;
    if l__Attributes__33.UseVelocitySequence and l__Attributes__33.Velocity then
        v103 = v103 * u14(l__Attributes__33.Velocity, (math.clamp(v104, 0, 1)));
    end;
    if v104 > 1 then
        return p100:RemoveParticle(p101);
    end;
    local v105 = Enum.EasingStyle[l__Attributes__33.EasingStyle];
    local v106 = Enum.EasingDirection[l__Attributes__33.EasingDirection];
    p101.Velocity = p101.Velocity + l__Attributes__33.Acceleration * p102;
    p101.Velocity = p101.Velocity * (2 ^ (1 - 1 / (1 / p102 / l__Attributes__33.Drag)) / 2);
    local l__squashSequence__35 = p101.squashSequence;
    local l__squashSequenceIndex__36 = p101.squashSequenceIndex;
    local v107 = l__squashSequence__35[l__squashSequenceIndex__36];
    local v108 = l__squashSequence__35[l__squashSequenceIndex__36 + 1];
    while v108.Time < v104 do
        l__squashSequenceIndex__36 = l__squashSequenceIndex__36 + 1;
        local v109 = l__squashSequence__35[l__squashSequenceIndex__36 + 1];
        p101.squashSequenceIndex = l__squashSequenceIndex__36;
        v107 = v108;
        v108 = v109;
    end;
    local v110 = 6 * (v107.Value + (v108.Value - v107.Value) * l__TweenService__1:GetValue((v104 - v107.Time) / (v108.Time - v107.Time), v105, v106) - 0.5);
    local l__scaleSequence__37 = p101.scaleSequence;
    local l__scaleSequenceIndex__38 = p101.scaleSequenceIndex;
    local v111 = l__scaleSequence__37[l__scaleSequenceIndex__38];
    local v112 = l__scaleSequence__37[l__scaleSequenceIndex__38 + 1];
    while v112.Time < v104 do
        l__scaleSequenceIndex__38 = l__scaleSequenceIndex__38 + 1;
        local v113 = l__scaleSequence__37[l__scaleSequenceIndex__38 + 1];
        p101.scaleSequenceIndex = l__scaleSequenceIndex__38;
        v111 = v112;
        v112 = v113;
    end;
    local v114 = (v111.Value + (v112.Value - v111.Value) * l__TweenService__1:GetValue((v104 - v111.Time) / (v112.Time - v111.Time), v105, v106)) * p101.Size * l__Attributes__33.MasterScale;
    if l__Attributes__33.SizeConstraint == "RelativeXX" then
        local l__X__39 = p100.AbsoluteSize.X;
        v103 = v103 * (l__X__39 / 150);
        v114 = v114 * (l__X__39 / 150);
    elseif l__Attributes__33.SizeConstraint == "RelativeYY" then
        local l__Y__40 = p100.AbsoluteSize.Y;
        v103 = v103 * (l__Y__40 / 150);
        v114 = v114 * (l__Y__40 / 100);
    end;
    local v115;
    if v110 >= 0 then
        v115 = Vector2.new(v114 / (v110 + 1), v114 * (v110 + 1));
    else
        v115 = Vector2.new(v114 * -(v110 - 1), v114 / -(v110 - 1));
    end;
    if l__Attributes__33.UseJitterFix then
        l__ParticleGui__34.Size = UDim2.fromOffset(math.round(v115.X / 2) * 2 + -1, math.round(v115.Y / 2) * 2 + -1);
    else
        l__ParticleGui__34.Size = UDim2.fromOffset(math.round(v115.X), (math.round(v115.Y)));
    end;
    local v116 = Vector2.new(math.noise((v104 + p101.Seed.X) * l__Attributes__33.NoiseSpeed, 0) * 0.5 * (l__Attributes__33.Noise.X * p101.NoiseBias), math.noise((v104 + p101.Seed.Y) * l__Attributes__33.NoiseSpeed, 0) * 0.5 * (l__Attributes__33.Noise.Y * p101.NoiseBias));
    if p101.Velocity ~= Vector2.zero then
        local l__Magnitude__41 = p101.Velocity.Magnitude;
        local l__X__42 = v116.X;
        p101.Velocity = Vector2.new(p101.Velocity.X * math.cos(l__X__42) + p101.Velocity.Y * math.sin(l__X__42), -p101.Velocity.X * math.sin(l__X__42) + p101.Velocity.Y * math.cos(l__X__42));
        p101.Velocity = p101.Velocity.Unit * (1 - v116.Y) * l__Magnitude__41;
    end;
    p101.Position = p101.Position + p101.Velocity * v103 * p102;
    l__ParticleGui__34.Position = UDim2.fromOffset(math.round(p101.Position.X), (math.round(p101.Position.Y)));
    p101.Rotation = p101.Rotation + p101.RotationSpeed * p102;
    if l__Attributes__33.Orientation == "Normal" then
        l__ParticleGui__34.Rotation = p101.Rotation;
    elseif l__Attributes__33.Orientation == "VelocityParallel" then
        local l__Rotation__43 = p101.Rotation;
        local l__Unit__44 = p101.Velocity.Unit;
        local v117 = math.atan2(l__Unit__44.X, -l__Unit__44.Y);
        local v118 = math.deg(v117);
        l__ParticleGui__34.Rotation = l__Rotation__43 + (v118 < (1 / 0) == false and 0 or v118) + 90;
    elseif l__Attributes__33.Orientation == "VelocityPerpendicular" then
        local l__Rotation__45 = p101.Rotation;
        local l__Unit__46 = p101.Velocity.Unit;
        local v119 = math.atan2(l__Unit__46.X, -l__Unit__46.Y);
        local v120 = math.deg(v119);
        l__ParticleGui__34.Rotation = l__Rotation__45 + (v120 < (1 / 0) == false and 0 or v120);
    else
        error(tostring(p100) .. "Invalid Orientation");
    end;
    local l__transparencySequence__47 = p101.transparencySequence;
    local l__transparencySequenceIndex__48 = p101.transparencySequenceIndex;
    local v121 = l__transparencySequence__47[l__transparencySequenceIndex__48];
    local v122 = l__transparencySequence__47[l__transparencySequenceIndex__48 + 1];
    while v122.Time < v104 do
        l__transparencySequenceIndex__48 = l__transparencySequenceIndex__48 + 1;
        local v123 = l__transparencySequence__47[l__transparencySequenceIndex__48 + 1];
        p101.transparencySequenceIndex = l__transparencySequenceIndex__48;
        v121 = v122;
        v122 = v123;
    end;
    l__ParticleGui__34.ImageTransparency = v121.Value + (v122.Value - v121.Value) * ((v104 - v121.Time) / (v122.Time - v121.Time));
    local l__colorSequence__49 = p101.colorSequence;
    local l__colorSequenceIndex__50 = p101.colorSequenceIndex;
    local v124 = l__colorSequence__49[l__colorSequenceIndex__50];
    local v125 = l__colorSequence__49[l__colorSequenceIndex__50 + 1];
    while v125.Time < v104 do
        l__colorSequenceIndex__50 = l__colorSequenceIndex__50 + 1;
        local v126 = l__colorSequence__49[l__colorSequenceIndex__50 + 1];
        p101.colorSequenceIndex = l__colorSequenceIndex__50;
        v124 = v125;
        v125 = v126;
    end;
    l__ParticleGui__34.ImageColor3 = v124.Value:Lerp(v125.Value, (v104 - v124.Time) / (v125.Time - v124.Time));
    l__ParticleGui__34.ZIndex = l__Attributes__33.ZIndex;
    l__ParticleGui__34.Visible = true;
    l__ParticleGui__34.Parent = p100.ParticleFolder;
end;
function u21.RemoveParticle(p127, p128, p129) --[[ Line: 878 ]]
    local l__ParticleGui__51 = p128.ParticleGui;
    if l__ParticleGui__51 then
        p127.Particles[l__ParticleGui__51] = nil;
        p127.ParticleCount = p127.ParticleCount - 1;
        if p129 then
            l__ParticleGui__51:Destroy();
        else
            l__ParticleGui__51.Visible = false;
            p127.CacheCount = p127.CacheCount + 1;
            p127.Cache[p127.CacheCount] = l__ParticleGui__51;
        end;
    end;
    local l__Events__52 = p128.Events;
    if l__Events__52 then
        for _, v130 in pairs(l__Events__52) do
            v130:Disconnect();
        end;
    end;
end;
function u21.ClearAllParticles(p131, p132) --[[ Line: 902 ]]
    for _, v133 in pairs(p131.Particles) do
        p131:RemoveParticle(v133, p132);
    end;
end;
function u21.Disable(p134) --[[ Line: 908 ]]
    if p134.Events then
        for _, v135 in pairs(p134.Events) do
            v135:Disconnect();
        end;
    end;
    if p134.AncestorEvents then
        for _, v136 in pairs(p134.AncestorEvents) do
            for _, v137 in pairs(v136) do
                v137:Disconnect();
            end;
        end;
    end;
    if p134.ParticleFolder then
        p134.ParticleFolder:Destroy();
    end;
end;
game:GetService("RunService"):BindToRenderStep("Emitter2D", Enum.RenderPriority.First.Value, function(p138) --[[ Line: 928 ]]
    -- upvalues: u21 (copy)
    if u21.EntityList then
        for v139, v140 in pairs(u21.EntityList) do
            v140.ParticleFolder.Parent = v139.Parent;
            if u21.GlobalEnabled and (v140.Active and (v140.NotVisibleCount == 0 and (v140.Attributes.IgnoreClipDescendants or v140.ClipCount == 0))) then
                v140:Update(p138 * v140.Attributes.TimeScale);
            elseif v140.ParticleCount > 0 then
                v140:ClearAllParticles();
            end;
        end;
    end;
end);
return u21;
