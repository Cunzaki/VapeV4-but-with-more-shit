-- Decompiled from: Teams.RegionCulling.State.BufferedRegionState
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Event__1 = require(script.Parent.Parent:WaitForChild("Event"));
require(script.Parent:WaitForChild("RegionState"));
local u1 = {};
u1.__index = u1;
function u1.new(p2) --[[ Line: 25 ]]
    -- upvalues: l__Event__1 (copy), u1 (copy)
    local v3 = {
        HiddenRegionTimeout = 5,
        WrappedRegionState = p2,
        CurrentVisibleRegionsMap = {},
        CurrentVisibleRegions = {},
        RegionVisible = l__Event__1.new(),
        RegionHidden = l__Event__1.new()
    };
    local u4 = setmetatable(v3, u1);
    local u5 = {};
    p2.RegionVisible:Connect(function(p6) --[[ Line: 38 ]]
        -- upvalues: u5 (copy), u4 (copy)
        local v7 = u5[p6] ~= nil;
        u5[p6] = nil;
        if v7 then
        else
            table.insert(u4.CurrentVisibleRegions, p6);
            u4.CurrentVisibleRegionsMap[p6] = true;
            u4.RegionVisible:Fire(p6);
        end;
    end);
    p2.RegionHidden:Connect(function(u8) --[[ Line: 49 ]]
        -- upvalues: u5 (copy), u4 (copy)
        local u9 = tick();
        u5[u8] = u9;
        task.delay(u4.HiddenRegionTimeout, function() --[[ Line: 53 ]]
            -- upvalues: u5 (ref), u8 (copy), u9 (copy), u4 (ref)
            if u5[u8] ~= u9 then
                return;
            end;
            u5[u8] = nil;
            for v10, v11 in u4.CurrentVisibleRegions do
                if u8 == v11 then
                    table.remove(u4.CurrentVisibleRegions, v10);
                    break;
                end;
            end;
            u4.CurrentVisibleRegionsMap[u8] = false;
            u4.RegionHidden:Fire(u8);
        end);
    end);
    return u4;
end;
function u1.IsInRegion(p12, p13, p14) --[[ Line: 74 ]]
    return p12.WrappedRegionState:IsInRegion(p13, p14);
end;
function u1.GetCurrentVisibleRegions(p15) --[[ Line: 81 ]]
    return p15.CurrentVisibleRegions;
end;
function u1.IsRegionVisible(p16, p17) --[[ Line: 88 ]]
    return p16.CurrentVisibleRegionsMap[p17] == true;
end;
function u1.AddRegionFunction(p18, p19, p20) --[[ Line: 96 ]]
    p18.WrappedRegionState:AddRegionFunction(p19, p20);
end;
function u1.AddRegion(p21, p22, p23, p24) --[[ Line: 104 ]]
    p21.WrappedRegionState:AddRegion(p22, p23, p24);
end;
function u1.ConnectRegions(p25, p26, p27) --[[ Line: 111 ]]
    p25.WrappedRegionState:ConnectRegions(p26, p27);
end;
function u1.SetVisibleWhenOutsideRegions(p28, p29) --[[ Line: 118 ]]
    p28.WrappedRegionState:SetVisibleWhenOutsideRegions(p29);
end;
function u1.StartUpdating(p30) --[[ Line: 125 ]]
    p30.WrappedRegionState:StartUpdating();
end;
return u1;
