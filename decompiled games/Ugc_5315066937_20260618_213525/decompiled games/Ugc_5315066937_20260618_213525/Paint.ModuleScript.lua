-- Decompiled from: Paint
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 12a7ca22-cd63-42d4-a557-a631ea165de3

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("Command");
local v2 = l__obtain__1("MapManager");
local l__Hotkey__2 = l__obtain__1("InputBinds").Hotkey;
local u3 = l__obtain__1("RobloxCamera");
local l__GeometryService__3 = game:GetService("GeometryService");
local l__IntersectAsync__4 = l__GeometryService__3.IntersectAsync;
local l__Plastic__5 = Enum.Material.Plastic;
local u4 = 0.5;
local u5 = false;
local u6 = false;
local u7 = false;
local u8 = false;
local u9 = Instance.new("Folder", workspace);
local u10 = RaycastParams.new();
u10.FilterType = Enum.RaycastFilterType.Include;
u10.FilterDescendantsInstances = {};
local u11 = OverlapParams.new();
u11.FilterType = Enum.RaycastFilterType.Include;
u11.FilterDescendantsInstances = {};
local u12 = OverlapParams.new();
u12.FilterType = Enum.RaycastFilterType.Include;
u12.FilterDescendantsInstances = { u9 };
local u13 = Instance.new("Part");
u13.Shape = Enum.PartType.Cylinder;
u13.Anchored = true;
u13.CanCollide = false;
u13.Color = Color3.new(0.1, 0.5, 1);
u13.Size = Vector3.new(0.1, u4, u4);
u13.Material = l__Plastic__5;
local u14 = u13:Clone();
u14.Transparency = 0.6;
u14.Color = Color3.new(1, 1, 1);
u14.Size = u14.Size + Vector3.new(0.005, 0.005, 0.005);
v2.MapInfoChanged:Add(function(p15) --[[ Line: 54 ]]
    -- upvalues: u10 (copy), u11 (copy), u9 (copy)
    u10.FilterDescendantsInstances = { p15.RobloxModel };
    u11.FilterDescendantsInstances = { p15.RobloxModel };
    u9:ClearAllChildren();
end);
local function u23(p16) --[[ Line: 60 ]]
    -- upvalues: u8 (ref), u13 (copy), u4 (ref), u11 (copy), l__IntersectAsync__4 (copy), l__GeometryService__3 (copy), u9 (copy)
    local l__Instance__6 = p16.Instance;
    if l__Instance__6:IsA("BasePart") and (u8 or not (l__Instance__6:IsA("UnionOperation") or l__Instance__6:IsA("MeshPart"))) and l__Instance__6 ~= workspace.Terrain then
        local l__Position__7 = p16.Position;
        local l__Normal__8 = p16.Normal;
        local v17 = u13:Clone();
        v17.CFrame = CFrame.lookAt(l__Position__7, l__Position__7 - l__Normal__8) * CFrame.Angles(0, 1.5707963267948966, 0);
        local v18 = workspace:GetPartBoundsInRadius(l__Position__7, u4, u11);
        if not u8 then
            for _, v19 in next, v18 do
                if v19:IsA("UnionOperation") or v19:IsA("MeshPart") then
                    return;
                end;
            end;
        end;
        local v20, v21 = pcall(l__IntersectAsync__4, l__GeometryService__3, v17, v18);
        if v20 then
            for _, v22 in next, v21 do
                v22.Position = v22.Position + l__Normal__8 / 20;
                v22.UsePartColor = true;
                v22.Parent = u9;
            end;
        end;
        v17:Destroy();
    end;
end;
l__Hotkey__2:RegisterBindable("AddPaint", function(p24) --[[ Line: 93 ]]
    -- upvalues: u6 (ref)
    u6 = p24;
end, "MouseButton1");
l__Hotkey__2:RegisterBindable("RemovePaint", function(p25) --[[ Line: 96 ]]
    -- upvalues: u7 (ref)
    u7 = p25;
end, "MouseButton2");
v1.Add("paint", {}, function() --[[ Line: 100 ]]
    -- upvalues: u5 (ref), u14 (copy)
    u5 = not u5;
    u14.Parent = u5 and workspace or nil;
    return "You have " .. (u5 and "enabled" or "disabled") .. " painting." .. (u5 and "\nLeft Click to draw paint, Right Click to remove paint.\nType !clearpaint to remove all paint. Type !paintsize or !paintcolor to customise the paint.\nMeshes/unions aren\'t paintable due to crash issues. Type !riskypaint to enable this." or "");
end);
v1.Add("clearpaint", {}, function() --[[ Line: 106 ]]
    -- upvalues: u9 (copy)
    u9:ClearAllChildren();
end);
v1.Add("paintsize", { "Number" }, function(p26) --[[ Line: 110 ]]
    -- upvalues: u4 (ref), u13 (copy), u14 (copy)
    if p26 < 0.1 or p26 > 10 then
        return "Paint must be between 0.1 and 10 studs large.";
    end;
    u4 = p26;
    u13.Size = Vector3.new(0.1, u4, u4);
    u14.Size = u13.Size + Vector3.new(0.005, 0.005, 0.005);
end);
v1.Add("paintsize", { "Default" }, function() --[[ Line: 118 ]]
    -- upvalues: u4 (ref), u13 (copy), u14 (copy)
    u4 = 0.5;
    u13.Size = Vector3.new(0.1, u4, u4);
    u14.Size = u13.Size + Vector3.new(0.005, 0.005, 0.005);
end);
v1.Add("paintcolor", { "Color3" }, function(p27) --[[ Line: 124 ]]
    -- upvalues: u13 (copy)
    u13.Color = p27;
end);
v1.Add("paintcolor", { "Default" }, function() --[[ Line: 127 ]]
    -- upvalues: u13 (copy)
    u13.Color = Color3.new(0.1, 0.5, 1);
end);
v1.Add("paintmaterial", { "Material" }, function(p28) --[[ Line: 131 ]]
    -- upvalues: u13 (copy)
    u13.Material = p28;
    return "Set painting material to " .. p28.Name;
end);
v1.Add("paintmaterial", { "Default" }, function() --[[ Line: 135 ]]
    -- upvalues: u13 (copy), l__Plastic__5 (copy)
    u13.Material = l__Plastic__5;
    return "Set painting material to " .. l__Plastic__5.Name;
end);
v1.Add("riskypaint", {}, function() --[[ Line: 140 ]]
    -- upvalues: u8 (ref)
    u8 = not u8;
    return "You have " .. (u8 and "enabled" or "disabled") .. " painting meshes/unions." .. (u8 and "\nThere currently exists a known crash case when doing CSG operations.\nDo not report any crashes due to this, there\'s nothing we can do about this." or "");
end);
local u29 = tick();
game:GetService("RunService").RenderStepped:connect(function() --[[ Line: 146 ]]
    -- upvalues: u5 (ref), u3 (copy), u10 (copy), u14 (copy), u29 (ref), u7 (ref), u6 (ref), u4 (ref), u12 (copy), u23 (copy)
    if u5 then
        local l__CFrame__9 = u3.CFrame;
        local v30 = workspace:Raycast(l__CFrame__9.p, l__CFrame__9.LookVector * 500, u10);
        if v30 then
            u14.CFrame = CFrame.lookAt(v30.Position, v30.Position - v30.Normal) * CFrame.Angles(0, 1.5707963267948966, 0);
            if tick() - u29 > 0.03333333333333333 then
                u29 = tick();
                if u7 and not u6 then
                    local v31 = next;
                    local v32, v33 = workspace:GetPartBoundsInRadius(v30.Position, u4 / 2, u12);
                    for _, v34 in v31, v32, v33 do
                        v34:Destroy();
                    end;
                    return;
                end;
                if u6 and not u7 then
                    u23(v30);
                end;
            end;
        end;
    end;
end);
return true;
