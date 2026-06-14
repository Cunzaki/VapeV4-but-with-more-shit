-- Decompiled from: ReplicatedStorage.Modules.AdvancedSpatialHash
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    _IDENTITY = "SpatialHash",
    _AUTHOR = "@wh1m.",
    _VERSION = "v0.4",
    _DESCRIPTION = "Spatial Hashing, with difference checking. To prevent querying every frame.",
    Axis = Vector3.new(1, 0, 1),
    Round = math.round
};
local l__Heartbeat__1 = game:GetService("RunService").Heartbeat;
function u1.ShallowArrayCompare(p2, p3) --[[ Line: 21 ]]
    if #p2 ~= #p3 then
        return false;
    end;
    for v4, v5 in p2 do
        if p3[v4] ~= v5 then
            return false;
        end;
    end;
    return true;
end;
function u1.GridID(p6) --[[ Line: 29 ]]
    local v7 = "";
    for _ = 1, p6 or 8 do
        v7 = v7 .. string.format("%x", math.random(0, 255));
    end;
    return v7;
end;
function u1.MapPositionToGridID(p8) --[[ Line: 38 ]]
    return string.format("%x", p8.X) .. string.format("%x", p8.Y) .. string.format("%x", p8.Z);
end;
function u1.MapPosition(p9, p10) --[[ Line: 44 ]]
    -- upvalues: u1 (copy)
    local v11 = u1.Round(p10.X / p9.Size) * p9.Size;
    local v12 = u1.Round(p10.Z / p9.Size) * p9.Size;
    return Vector3.new(v11 / p9.Size, v12 / p9.Size);
end;
function u1.IterateLoaded(p13, p14) --[[ Line: 51 ]]
    if p13.CurrentLoaded then
        for _, v15 in ipairs(p13.CurrentLoaded) do
            p14(v15);
        end;
    end;
end;
function u1.StreamFromPosition(p16, p17, p18, p19, p20) --[[ Line: 59 ]]
    local v21 = p16.GetMapID(p17);
    local v22, _ = p16.CheckObjectMapsDiffernce(p16.CurrentObjectMaps);
    p16.CurrentLoaded = p16.CurrentLoaded or {};
    if v21 ~= p16.LastMapID or v22 then
        local v23, v24 = p16.GetObjectMapsInRadius(p17, p18);
        for _, v25 in ipairs(p16.CurrentLoaded) do
            if not v23[v25] then
                p20(v25);
            end;
        end;
        for _, v26 in ipairs(v23) do
            if not p16.CurrentLoaded[v26] then
                p19(v26);
            end;
        end;
        p16.CurrentObjectMaps = v24;
        p16.CurrentLoaded = v23;
        p16.LastMapID = v21;
    end;
end;
function u1.NewMap(p27, p28) --[[ Line: 88 ]]
    -- upvalues: u1 (copy), l__Heartbeat__1 (copy)
    local u29 = {
        AsyncOperations = 0,
        AllowedWorkCycles = (1 / 0),
        AutoScheduleUponInsert = true,
        Object = {},
        Location = {},
        Schedules = p28,
        TotalObjects = {},
        Schedule = {
            ScheduleBaseRate = 0.041666666666666664,
            ScheduleRate = 0.041666666666666664,
            ScheduleSize = 10,
            SchedulePosition = 0,
            ScheduleTime = 0,
            ScheduleTargetTime = 4,
            TimeSenseLastCompleted = os.clock()
        },
        Size = p27,
        ObjectMapsIDMemory = {},
        LastComparedObjectMaps = {},
        Iterate = u1.IterateLoaded,
        StreamFromPosition = u1.StreamFromPosition
    };
    function u29.WorkAsync() --[[ Line: 123 ]]
        -- upvalues: u29 (ref)
        local v30 = u29;
        v30.AsyncOperations = v30.AsyncOperations + 1;
        if u29.AsyncOperations > u29.AllowedWorkCycles then
            u29.AsyncOperations = 0;
            task.wait();
        end;
    end;
    function u29.CheckObjectMapsDiffernce(p31) --[[ Line: 131 ]]
        -- upvalues: u29 (ref), u1 (ref)
        if not p31 then
            return true;
        end;
        if not u29.LastComparedObjectMaps or u1.ShallowArrayCompare(u29.LastComparedObjectMaps, p31) then
            for _, v32 in p31 do
                if (u29.ObjectMapsIDMemory[v32] or v32.ID) ~= v32.ID then
                    u29.ObjectMapsIDMemory[v32] = v32.ID;
                    return true;
                end;
                u29.ObjectMapsIDMemory[v32] = v32.ID;
            end;
            return false;
        end;
        u29.LastComparedObjectMaps = p31;
        u29.ObjectMapsIDMemory = {};
        return true;
    end;
    function u29.AutoSchedule() --[[ Line: 150 ]]
        -- upvalues: u29 (ref)
        u29.Schedule.ScheduleSize = #u29.TotalObjects * u29.Schedule.ScheduleRate;
    end;
    function u29.Update(p33) --[[ Line: 154 ]]
        -- upvalues: u29 (ref), u1 (ref)
        local l__Schedule__2 = u29.Schedule;
        l__Schedule__2.ScheduleTime = l__Schedule__2.ScheduleTime + p33;
        if u29.Schedule.ScheduleTime > u29.Schedule.ScheduleRate * u29.Schedule.ScheduleTargetTime then
            u29.Schedule.ScheduleTime = 0;
            local v34 = #u29.TotalObjects;
            if v34 == 0 then
                return;
            end;
            local v35 = 0;
            while true do
                local v36 = os.clock() - u29.Schedule.TimeSenseLastCompleted;
                v35 = v35 + 1;
                local l__Schedule__3 = u29.Schedule;
                l__Schedule__3.SchedulePosition = l__Schedule__3.SchedulePosition + 1;
                if v34 < u29.Schedule.SchedulePosition then
                    u29.Schedule.SchedulePosition = 1;
                    u29.Schedule.TimeSenseLastCompleted = os.clock();
                    u29.Schedule.ScheduleRate = u29.Schedule.ScheduleBaseRate;
                    u29.LastCompletionTime = v36;
                end;
                local v37 = u29.Schedule.ScheduleTargetTime * (u29.Schedule.SchedulePosition / v34);
                local v38 = os.clock();
                local v39 = u29.TotalObjects[u29.Schedule.SchedulePosition];
                local v40 = v39:GetAttribute("__LastSize");
                local v41 = v39:GetAttribute("__LastPosition");
                if v40 ~= v39.Size then
                    u1.UpdateBasePart(u29, v39);
                end;
                if v41 ~= v39.Position then
                    u1.UpdateBasePart(u29, v39);
                end;
                local v42 = os.clock() - v38;
                if v37 < v36 then
                    local l__Schedule__4 = u29.Schedule;
                    l__Schedule__4.ScheduleRate = l__Schedule__4.ScheduleRate - v42;
                else
                    local l__Schedule__5 = u29.Schedule;
                    l__Schedule__5.ScheduleRate = l__Schedule__5.ScheduleRate + v42;
                end;
                if math.min(u29.Schedule.ScheduleSize, v34) <= v35 then
                    return;
                end;
            end;
        end;
    end;
    function u29.Insert(p43, p44) --[[ Line: 207 ]]
        -- upvalues: u29 (ref), u1 (ref)
        local v45 = u29.Object[p43];
        if not v45 then
            u29.Object[p43] = {};
            v45 = u29.Object[p43];
        end;
        v45.ID = u1.GridID();
        table.insert(u29.Location[p44], p43);
        table.insert(v45, p44);
    end;
    function u29.Remove(p46, p47) --[[ Line: 222 ]]
        -- upvalues: u29 (ref), u1 (ref)
        local v48 = u29.Object[p46];
        if v48 then
            v48.ID = u1.GridID();
            table.remove(v48, table.find(v48, p47));
            if #v48 == 0 then
                u29.Object[p46] = nil;
            end;
        end;
    end;
    function u29.GetPartsInPart(p49) --[[ Line: 235 ]]
        -- upvalues: u1 (ref), u29 (ref)
        local l__Size__6 = p49.Size;
        local v50 = p49.Position - l__Size__6 / 2;
        local v51 = p49.Position + l__Size__6 / 2;
        local v52 = u1.MapPosition(u29, v50);
        local v53 = u1.MapPosition(u29, v51);
        local v54 = {};
        for v55 = v52.X, v53.X do
            for v56 = v52.Y, v53.Y do
                local v57 = Vector3.new(v55, v56);
                local v58 = u29.Object[v57];
                u29.WorkAsync();
                if v58 then
                    for _, v59 in v58 do
                        table.insert(v54, v59);
                    end;
                end;
            end;
        end;
        return v54;
    end;
    function u29.GetPartsInRadius(p60, p61, p62) --[[ Line: 264 ]]
        -- upvalues: u1 (ref), u29 (ref)
        local v63 = u1.MapPosition(u29, p60);
        local v64 = p61 + 0.5;
        local v65 = (v64 * 2 - 1) / 2;
        local v66 = {};
        for v67 = v63.X - v65, v63.X + v65 do
            for v68 = v63.Y - v65, v63.Y + v65 do
                local v69 = Vector3.new(v67, v68);
                local l__Magnitude__7 = (v63 - v69).Magnitude;
                local v70 = u29.Object[v69];
                u29.WorkAsync();
                if v70 and l__Magnitude__7 < v64 or p62 then
                    for _, v71 in ipairs(v70) do
                        if not v66[v71] then
                            v66[v71] = true;
                            table.insert(v66, v71);
                        end;
                    end;
                end;
            end;
        end;
        return v66;
    end;
    function u29.GetObjectMapsInRadius(p72, p73, p74) --[[ Line: 294 ]]
        -- upvalues: u1 (ref), u29 (ref)
        local v75 = u1.MapPosition(u29, p72);
        local v76 = p73 + 0.5;
        local v77 = (v76 * 2 - 1) / 2;
        local v78 = {};
        local v79 = {};
        for v80 = v75.X - v77, v75.X + v77 do
            for v81 = v75.Y - v77, v75.Y + v77 do
                local v82 = Vector3.new(v80, v81);
                local l__Magnitude__8 = (v75 - v82).Magnitude;
                local v83 = u29.Object[v82];
                u29.WorkAsync();
                if v83 and l__Magnitude__8 < v76 or p74 then
                    table.insert(v78, v83);
                    for _, v84 in ipairs(v83) do
                        if not v79[v84] then
                            v79[v84] = true;
                            table.insert(v79, v84);
                        end;
                    end;
                end;
            end;
        end;
        return v79, v78;
    end;
    function u29.GetMapPosition(p85) --[[ Line: 328 ]]
        -- upvalues: u1 (ref), u29 (ref)
        return u1.MapPosition(u29, p85);
    end;
    function u29.GetMapID(p86) --[[ Line: 332 ]]
        -- upvalues: u1 (ref), u29 (ref)
        local v87 = u1.MapPosition(u29, p86);
        local v88 = u29.Object[v87];
        return v88 and v88.ID or u1.MapPositionToGridID(v87);
    end;
    function u29.GetPartsAtPosition(p89) --[[ Line: 338 ]]
        -- upvalues: u1 (ref), u29 (ref)
        local v90 = u1.MapPosition(u29, p89);
        return u29.Object[v90] or {};
    end;
    function u29.Add(p91) --[[ Line: 343 ]]
        -- upvalues: u1 (ref), u29 (ref)
        u1.InsertBasePart(u29, p91);
    end;
    function u29.Destroy() --[[ Line: 347 ]]
        -- upvalues: u29 (ref)
        u29.__HeartbeatConnection:Disconnect();
        u29 = nil;
    end;
    if u29.Schedules or u29.Schedules == nil then
        u29.Schedules = true;
        u29.__HeartbeatConnection = l__Heartbeat__1:Connect(u29.Update);
    end;
    return u29;
end;
function u1.UpdateBasePart(p92, p93) --[[ Line: 361 ]]
    -- upvalues: u1 (copy)
    local v94 = p92.Location[p93];
    if v94 then
        for _, v95 in v94 do
            p92.Remove(v95, p93);
        end;
    end;
    p92.Location[p93] = {};
    local v96 = p92.Size / 2;
    local v97 = p93.Size * u1.Axis;
    local l__Orientation__9 = p93.Orientation;
    local v98;
    if l__Orientation__9.X % 90 == 0 and l__Orientation__9.Y % 90 == 0 then
        v98 = l__Orientation__9.Z % 90 == 0;
    else
        v98 = false;
    end;
    if v98 then
        local v99 = p93.Position - v97 / 2;
        local v100 = p93.Position + v97 / 2;
        local v101 = u1.MapPosition(p92, v99);
        local v102 = u1.MapPosition(p92, v100);
        local v103 = {};
        for v104 = v101.X, v102.X do
            for v105 = v101.Y, v102.Y do
                local v106 = Vector3.new(v104, v105);
                p92.WorkAsync();
                if not v103[v106] then
                    v103[v106] = true;
                    p92.Insert(v106, p93);
                end;
            end;
        end;
    else
        local v107 = -(v97 / 2);
        local v108 = v97 / 2;
        local v109 = {};
        for v110 = v107.X, v108.X, v96 do
            for v111 = v107.Z, v108.Z, v96 do
                local l__Position__10 = p93.CFrame:ToWorldSpace(CFrame.new(v110, 0, v111)).Position;
                local v112 = u1.MapPosition(p92, l__Position__10);
                p92.WorkAsync();
                if not v109[v112] then
                    v109[v112] = true;
                    p92.Insert(v112, p93);
                end;
            end;
        end;
    end;
end;
function u1.InsertBasePart(u113, u114) --[[ Line: 425 ]]
    -- upvalues: u1 (copy)
    if u113.Schedules then
        u114:SetAttribute("__LastPosition", u114.Position);
        u114:SetAttribute("__LastSize", u114.Size);
    else
        u114:GetPropertyChangedSignal("Position"):Connect(function() --[[ Line: 431 ]]
            -- upvalues: u1 (ref), u113 (copy), u114 (copy)
            u1.UpdateBasePart(u113, u114);
        end);
        u114:GetPropertyChangedSignal("Size"):Connect(function() --[[ Line: 434 ]]
            -- upvalues: u1 (ref), u113 (copy), u114 (copy)
            u1.UpdateBasePart(u113, u114);
        end);
    end;
    u114.Destroying:Connect(function() --[[ Line: 439 ]]
        -- upvalues: u113 (copy), u114 (copy)
        local v115 = u113.Location[u114];
        if v115 then
            for _, v116 in v115 do
                u113.Remove(v116, u114);
            end;
        end;
        table.remove(u113.TotalObjects, table.find(u113.TotalObjects, u114));
        u113.Location[u114] = nil;
        if u113.AutoScheduleUponInsert and u113.Schedules then
            u113.AutoSchedule();
        end;
    end);
    u1.UpdateBasePart(u113, u114);
    table.insert(u113.TotalObjects, u114);
    if u113.AutoScheduleUponInsert and u113.Schedules then
        u113.AutoSchedule();
    end;
end;
return u1;
