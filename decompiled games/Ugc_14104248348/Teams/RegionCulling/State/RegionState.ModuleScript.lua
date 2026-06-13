-- Decompiled from: Teams.RegionCulling.State.RegionState
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__StarterPlayer__1 = game:GetService("StarterPlayer");
local l__Workspace__2 = game:GetService("Workspace");
local l__Players__3 = game:GetService("Players");
local l__Event__4 = require(script.Parent.Parent:WaitForChild("Event"));
local u1 = {};
u1.__index = u1;
function u1.new() --[[ Line: 32 ]]
    -- upvalues: l__Workspace__2 (copy), l__Players__3 (copy), l__Event__4 (copy), u1 (copy)
    local v3 = {
        Regions = {},
        DefaultPositionSources = { function() --[[ Line: 36 ]]
                -- upvalues: l__Workspace__2 (ref)
                return l__Workspace__2.CurrentCamera:GetRenderCFrame().Position;
            end, function() --[[ Line: 39 ]]
                -- upvalues: l__Players__3 (ref)
                local l__Character__5 = l__Players__3.LocalPlayer.Character;
                if l__Character__5 then
                    local v2 = l__Character__5:FindFirstChild("HumanoidRootPart");
                    if v2 then
                        return v2.Position;
                    end;
                end;
            end },
        VisibleWhenOutsideRegionsMap = {},
        CurrentVisibleRegionsMap = {},
        CurrentVisibleRegions = {},
        RegionVisible = l__Event__4.new(),
        RegionHidden = l__Event__4.new(),
        RegionsChanged = l__Event__4.new()
    };
    return setmetatable(v3, u1);
end;
function u1.IsInRegion(p4, p5, p6) --[[ Line: 59 ]]
    local v7 = CFrame.new(p6);
    if not p4.Regions[p5] then
        return false;
    end;
    for _, v8 in p4.Regions[p5].InRegionFunctions do
        if v8(v7) then
            return true;
        end;
    end;
    return false;
end;
function u1.GetVisibleRegions(p9, p10) --[[ Line: 72 ]]
    local v11 = {};
    local v12 = {};
    for _, v13 in p10 do
        local v14 = false;
        for v15, v16 in p9.Regions do
            if p9:IsInRegion(v15, v13) then
                v11[v15] = true;
                v12[v15] = true;
                v14 = true;
                for _, v17 in v16.VisibleRegions do
                    v11[v17] = true;
                end;
            end;
        end;
        if not v14 then
            for v18, _ in p9.VisibleWhenOutsideRegionsMap do
                v11[v18] = true;
            end;
        end;
    end;
    return v11, v12;
end;
function u1.GetCurrentVisibleRegions(p19) --[[ Line: 98 ]]
    return p19.CurrentVisibleRegions;
end;
function u1.IsRegionVisible(p20, p21) --[[ Line: 105 ]]
    return p20.CurrentVisibleRegionsMap[p21] == true;
end;
function u1.AddRegionFunction(p22, p23, p24) --[[ Line: 113 ]]
    if not p22.Regions[p23] then
        p22.Regions[p23] = {
            InRegionFunctions = {},
            VisibleRegions = {}
        };
    end;
    table.insert(p22.Regions[p23].InRegionFunctions, p24);
end;
function u1.AddRegion(p25, p26, u27, u28) --[[ Line: 127 ]]
    p25:AddRegionFunction(p26, function(p29) --[[ Line: 128 ]]
        -- upvalues: u27 (copy), u28 (copy)
        local v30 = u27:Inverse() * p29;
        local v31;
        if math.abs(v30.X) <= u28.X / 2 and math.abs(v30.Y) <= u28.Y / 2 then
            v31 = math.abs(v30.Z) <= u28.Z / 2;
        else
            v31 = false;
        end;
        return v31;
    end);
end;
function u1.ConnectRegions(p32, p33, p34) --[[ Line: 137 ]]
    if not p32.Regions[p33] then
        error((`Region "{p33}" does not exist.`));
    end;
    if not p32.Regions[p34] then
        error((`Region "{p34}" does not exist.`));
    end;
    table.insert(p32.Regions[p33].VisibleRegions, p34);
    table.insert(p32.Regions[p34].VisibleRegions, p33);
end;
function u1.SetVisibleWhenOutsideRegions(p35, p36) --[[ Line: 151 ]]
    p35.VisibleWhenOutsideRegionsMap[p36] = true;
end;
function u1.UpdateVisibleRegions(p37, p38) --[[ Line: 158 ]]
    -- upvalues: l__Workspace__2 (copy), l__StarterPlayer__1 (copy)
    local v39 = p38 or {};
    if not p38 then
        local v40 = nil;
        local l__CurrentCamera__6 = l__Workspace__2.CurrentCamera;
        local l__Position__7 = l__CurrentCamera__6:GetRenderCFrame().Position;
        if l__CurrentCamera__6.CameraSubject and l__CurrentCamera__6.CameraSubject:IsA("Humanoid") then
            if l__CurrentCamera__6.CameraSubject.RootPart then
                v40 = l__CurrentCamera__6.CameraSubject.RootPart.Position;
                if (v40 - l__Position__7).Magnitude > l__StarterPlayer__1.CameraMaxZoomDistance * 1.1 then
                    if not l__CurrentCamera__6.CameraSubject:GetAttribute("DebugIgnoreDistance") then
                        v40 = l__Position__7;
                    end;
                end;
            end;
            v40 = l__CurrentCamera__6.CameraSubject:GetAttribute("RenderFocus") or v40;
        end;
        local v41 = v40 or l__Position__7;
        if v41 then
            table.insert(v39, v41);
        end;
    end;
    local l__CurrentVisibleRegionsMap__8 = p37.CurrentVisibleRegionsMap;
    local v42, v43 = p37:GetVisibleRegions(v39);
    p37.CurrentVisibleRegionsMap = v42;
    local v44 = {};
    for v45, _ in v42 do
        table.insert(v44, v45);
    end;
    p37.CurrentVisibleRegions = v44;
    for v46, _ in v42 do
        if not l__CurrentVisibleRegionsMap__8[v46] then
            p37.RegionVisible:Fire(v46);
        end;
    end;
    for v47, _ in l__CurrentVisibleRegionsMap__8 do
        if not v42[v47] then
            p37.RegionHidden:Fire(v47);
        end;
    end;
    if (v43 or not p37.CurrentRegionsIn) and (not v43 or p37.CurrentRegionsIn) then
        if p37.CurrentRegionsIn then
            local v48 = false;
            for v49, _ in v43 do
                if v48 then
                    break;
                end;
                if p37.CurrentRegionsIn[v49] == nil then
                    v48 = true;
                end;
            end;
            for v50, _ in p37.CurrentRegionsIn do
                if v48 then
                    break;
                end;
                if v43[v50] == nil then
                    v48 = true;
                end;
            end;
            if v48 then
                p37.RegionsChanged:Fire(v43);
            end;
        end;
    else
        p37.RegionsChanged:Fire(v43);
    end;
    p37.CurrentRegionsIn = v43;
end;
function u1.StartUpdating(u51) --[[ Line: 239 ]]
    u51:UpdateVisibleRegions();
    task.spawn(function() --[[ Line: 241 ]]
        -- upvalues: u51 (copy)
        while true do
            task.wait(0.1);
            u51:UpdateVisibleRegions();
        end;
    end);
end;
return u1;
