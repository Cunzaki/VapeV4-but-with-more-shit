-- Decompiled from: ReplicatedStorage.Modules.octo-tree
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local function u6(p1, p2, p3) --[[ Line: 20 ]]
    local v4 = p3 / 2;
    local v5;
    if p1.X >= p2.X - v4 and (p1.X <= p2.X + v4 and (p1.Y >= p2.Y - v4 and (p1.Y <= p2.Y + v4 and p1.Z >= p2.Z - v4))) then
        v5 = p1.Z <= p2.Z + v4;
    else
        v5 = false;
    end;
    return v5;
end;
local function u10(p7) --[[ Line: 40 ]]
    -- upvalues: u10 (copy)
    local v8 = 0;
    if p7.Nodes then
        return #p7.Nodes;
    end;
    for _, v9 in ipairs(p7.Regions) do
        v8 = v8 + u10(v9);
    end;
    return v8;
end;
local function u19(p11, p12, p13) --[[ Line: 52 ]]
    local l__Size__1 = p11.Size;
    local v14 = math.round(p12.X / l__Size__1) * l__Size__1;
    local v15 = math.round(p12.Y / l__Size__1) * l__Size__1;
    local v16 = math.round(p12.Z / l__Size__1) * l__Size__1;
    local v17 = Vector3.new(v14, v15, v16);
    local v18 = p11.Regions[v17];
    if not v18 and p13 then
        v18 = {
            Level = 1,
            Regions = {},
            Size = l__Size__1,
            Radius = math.sqrt(l__Size__1 * l__Size__1 + l__Size__1 * l__Size__1 + l__Size__1 * l__Size__1),
            Center = v17
        };
        table.freeze(v18);
        p11.Regions[v17] = v18;
    end;
    return v18;
end;
local function u39(p20, u21, u22) --[[ Line: 70 ]]
    -- upvalues: u19 (copy)
    local u23 = {};
    local function u26(p24) --[[ Line: 72 ]]
        -- upvalues: u21 (copy), u22 (copy), u23 (copy), u26 (copy)
        for _, v25 in ipairs(p24) do
            if (u21 - v25.Center).Magnitude < u22 + v25.Radius then
                if v25.Nodes then
                    table.insert(u23, v25);
                else
                    u26(v25.Regions);
                end;
            end;
        end;
    end;
    local v27 = {};
    local l__Size__2 = p20.Size;
    local v28 = math.ceil(u22 / l__Size__2);
    if u22 < p20.Size then
        for v29 = 0, 26 do
            local v30 = v29 % 3 - 1;
            local v31 = math.floor(v29 / 9) - 1;
            local v32 = math.floor(v29 / 3) % 3 - 1;
            local v33 = u19(p20, u21 + Vector3.new(v30 * u22, v31 * u22, v32 * u22), false);
            if v33 and not v27[v33] then
                v27[v33] = true;
                u26(v33.Regions);
            end;
        end;
        return u23;
    elseif v28 <= 3 then
        for v34 = -v28, v28 do
            for v35 = -v28, v28 do
                for v36 = -v28, v28 do
                    local v37 = u19(p20, u21 + Vector3.new(v34 * l__Size__2, v35 * l__Size__2, v36 * l__Size__2), false);
                    if v37 and not v27[v37] then
                        v27[v37] = true;
                        u26(v37.Regions);
                    end;
                end;
            end;
        end;
        return u23;
    else
        for _, v38 in p20.Regions do
            if (u21 - v38.Center).Magnitude < u22 + v38.Radius then
                u26(v38.Regions);
            end;
        end;
        return u23;
    end;
end;
local u40 = {};
u40.__index = u40;
function u40.new(p41) --[[ Line: 135 ]]
    -- upvalues: u40 (copy)
    local v42 = setmetatable({}, u40);
    v42.Size = p41 or 512;
    v42.Regions = {};
    return v42;
end;
function u40.ClearAllNodes(p43) --[[ Line: 142 ]]
    table.clear(p43.Regions);
end;
function u40.GetAllNodes(p44) --[[ Line: 146 ]]
    local u45 = {};
    local function u48(p46) --[[ Line: 148 ]]
        -- upvalues: u45 (copy), u48 (copy)
        for _, v47 in p46 do
            local l__Nodes__3 = v47.Nodes;
            if l__Nodes__3 then
                table.move(l__Nodes__3, 1, #l__Nodes__3, #u45 + 1, u45);
            else
                u48(v47.Regions);
            end;
        end;
    end;
    u48(p44.Regions);
    return u45;
end;
function u40.ForEachNode(u49) --[[ Line: 162 ]]
    local function u53(p50) --[[ Line: 163 ]]
        -- upvalues: u49 (copy), u53 (copy)
        for _, v51 in p50 or u49.Regions do
            local l__Nodes__4 = v51.Nodes;
            if l__Nodes__4 then
                for _, v52 in l__Nodes__4 do
                    coroutine.yield(v52);
                end;
            else
                u53(v51.Regions);
            end;
        end;
    end;
    return coroutine.wrap(u53);
end;
function u40.FindFirstNode(p54, p55) --[[ Line: 178 ]]
    for v56 in p54:ForEachNode() do
        if v56.Object == p55 then
            return v56;
        end;
    end;
    return nil;
end;
function u40.CountNodes(p57) --[[ Line: 187 ]]
    return #p57:GetAllNodes();
end;
function u40.CreateNode(p58, p59, p60) --[[ Line: 191 ]]
    local v61 = p58:_getRegion(4, p59);
    local v62 = {
        Region = v61,
        Position = p59,
        Object = p60
    };
    table.insert(v61.Nodes, v62);
    return v62;
end;
function u40.RemoveNode(_, p63) --[[ Line: 202 ]]
    -- upvalues: u10 (copy)
    if p63.Region then
        local l__Nodes__5 = p63.Region.Nodes;
        local v64 = table.find(l__Nodes__5, p63);
        if v64 then
            local v65 = #l__Nodes__5;
            l__Nodes__5[v64] = l__Nodes__5[v65];
            l__Nodes__5[v65] = nil;
        end;
        if #l__Nodes__5 == 0 then
            local l__Region__6 = p63.Region;
            while l__Region__6 do
                local l__Parent__7 = l__Region__6.Parent;
                if l__Parent__7 and u10(l__Region__6) == 0 then
                    local v66 = table.find(l__Parent__7.Regions, l__Region__6);
                    if v66 then
                        local l__Regions__8 = l__Parent__7.Regions;
                        local v67 = #l__Regions__8;
                        l__Regions__8[v66] = l__Regions__8[v67];
                        l__Regions__8[v67] = nil;
                        l__Region__6 = l__Parent__7;
                    else
                        l__Region__6 = l__Parent__7;
                    end;
                else
                    l__Region__6 = l__Parent__7;
                end;
            end;
        end;
        p63.Region = nil;
    end;
end;
function u40.ChangeNodePosition(p68, p69, p70) --[[ Line: 231 ]]
    p69.Position = p70;
    local v71 = p68:_getRegion(4, p70);
    if v71 == p69.Region then
    else
        p68:RemoveNode(p69);
        p69.Region = v71;
        table.insert(v71.Nodes, p69);
    end;
end;
function u40.SearchRadius(p72, p73, p74) --[[ Line: 242 ]]
    -- upvalues: u39 (copy)
    local v75 = u39(p72, p73, p74);
    local v76 = {};
    for _, v77 in ipairs(v75) do
        for _, v78 in ipairs(v77.Nodes) do
            if (v78.Position - p73).Magnitude < p74 then
                table.insert(v76, v78);
            end;
        end;
    end;
    return v76;
end;
function u40.ForEachInRadius(p79, u80, u81) --[[ Line: 255 ]]
    -- upvalues: u39 (copy)
    local u82 = u39(p79, u80, u81);
    return coroutine.wrap(function() --[[ Line: 257 ]]
        -- upvalues: u82 (copy), u80 (copy), u81 (copy)
        for _, v83 in ipairs(u82) do
            for _, v84 in ipairs(v83.Nodes) do
                if (v84.Position - u80).Magnitude < u81 then
                    coroutine.yield(v84);
                end;
            end;
        end;
    end);
end;
function u40.GetNearest(p85, u86, p87, p88) --[[ Line: 268 ]]
    local v89 = p85:SearchRadius(u86, p87, p88);
    table.sort(v89, function(p90, p91) --[[ Line: 270 ]]
        -- upvalues: u86 (copy)
        return (p90.Position - u86).Magnitude < (p91.Position - u86).Magnitude;
    end);
    if p88 == nil or p88 >= #v89 then
        return v89;
    else
        return table.move(v89, 1, p88, 1, table.create(p88));
    end;
end;
function u40._getRegion(u92, u93, u94) --[[ Line: 281 ]]
    -- upvalues: u6 (copy), u19 (copy)
    local function u108(p95, p96, p97) --[[ Line: 282 ]]
        -- upvalues: u6 (ref), u94 (copy), u92 (copy), u93 (copy), u108 (copy)
        local v98 = nil;
        for _, v99 in p96 do
            if u6(u94, v99.Center, v99.Size) then
                v98 = v99;
                break;
            end;
        end;
        if not v98 then
            local v100 = u92.Size / 2 ^ (p97 - 1);
            local v101;
            if p95 then
                v101 = p95.Center;
            else
                local v102 = math.round(u94.X / v100) * v100;
                local v103 = math.round(u94.Y / v100) * v100;
                local v104 = math.round(u94.Z / v100) * v100;
                v101 = Vector3.new(v102, v103, v104);
            end;
            if p95 then
                local v105;
                if u94.X > v101.X then
                    v105 = v100 / 2;
                else
                    v105 = -v100 / 2;
                end;
                local v106;
                if u94.Y > v101.Y then
                    v106 = v100 / 2;
                else
                    v106 = -v100 / 2;
                end;
                local v107;
                if u94.Z > v101.Z then
                    v107 = v100 / 2;
                else
                    v107 = -v100 / 2;
                end;
                v101 = v101 + Vector3.new(v105, v106, v107);
            end;
            v98 = {
                Regions = {},
                Level = p97,
                Size = v100,
                Radius = math.sqrt(v100 * v100 + v100 * v100 + v100 * v100),
                Center = v101,
                Parent = p95,
                Nodes = p97 == 4 and {} or nil
            };
            table.freeze(v98);
            table.insert(p96, v98);
        end;
        if p97 == u93 then
            return v98;
        else
            return u108(v98, v98.Regions, p97 + 1);
        end;
    end;
    local v109 = u19(u92, u94, true);
    return u108(v109, v109.Regions, 2);
end;
return u40;
