-- Decompiled from: ReplicatedStorage.Modules.Scheduler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__RunService__1 = game:GetService("RunService");
local u2 = l__RunService__1:IsServer() and l__RunService__1.Heartbeat or l__RunService__1.RenderStepped;
function v1.new(p3) --[[ Line: 6 ]]
    -- upvalues: u2 (copy)
    local u4 = {
        Rate = 0.041666666666666664,
        BaseRate = 0.041666666666666664,
        Size = 10,
        Position = 0,
        Time = 0,
        TargetPeriod = 2,
        UpdateUponChanges = true,
        AutoAdjustRate = true,
        __IsRemoving = false,
        List = p3,
        ListSize = #p3,
        LastListSize = p3,
        ProcessFnList = {},
        RemovalStack = {}
    };
    function u4.SetList(p5, p6) --[[ Line: 28 ]]
        -- upvalues: u4 (ref)
        u4.List = p5;
        u4.ListSize = #p5;
        if p6 then
            u4.Time = 0;
            u4.Position = 0;
        end;
    end;
    function u4.SetRate(p7) --[[ Line: 37 ]]
        -- upvalues: u4 (ref)
        u4.BaseRate = p7;
        u4.Rate = p7;
    end;
    function u4.AutoSchedule(p8) --[[ Line: 42 ]]
        -- upvalues: u4 (ref)
        if u4.AutoAdjustRate then
            u4.ListSize = #u4.List;
            local v9 = p8 / u4.ListSize;
            if u4.ListSize == 0 then
                v9 = p8;
            end;
            u4.Rate = math.max(v9, u4.BaseRate);
        end;
        local v10 = u4;
        local v11 = math.round(u4.ListSize * u4.Rate * (p8 or 1));
        v10.Size = math.max(1, v11);
    end;
    function u4.SetTargetPeroid(p12) --[[ Line: 53 ]]
        -- upvalues: u4 (ref)
        u4.TargetPeriod = p12;
        u4.AutoSchedule(p12);
    end;
    u4.Update = u2:Connect(function(p13) --[[ Line: 58 ]]
        -- upvalues: u4 (ref)
        local v14 = u4;
        v14.Time = v14.Time + p13;
        if u4.Time > u4.Rate then
            u4.Time = 0;
            local v15 = 0;
            local v16 = #u4.List;
            if v16 == 0 then
                return;
            end;
            u4.ListSize = v16;
            if u4.ListSize ~= u4.LastListSize and u4.UpdateUponChanges then
                u4.AutoSchedule(u4.TargetPeriod);
            end;
            local l__RemovalStack__2 = u4.RemovalStack;
            while true do
                v15 = v15 + 1;
                local v17 = u4;
                v17.Position = v17.Position + 1;
                if v16 < u4.Position then
                    u4.Position = 1;
                end;
                local v18 = u4.List[u4.Position];
                for _, v19 in u4.ProcessFnList do
                    v19(v18, u4.Position, function(p20) --[[ Line: 85 ]]
                        -- upvalues: l__RemovalStack__2 (copy), u4 (ref)
                        table.insert(l__RemovalStack__2, {
                            Position = u4.Position,
                            UponRemovalFn = p20
                        });
                    end);
                end;
                if math.min(u4.Size, u4.ListSize) <= v15 then
                    u4.__IsRemoving = true;
                    for v21 = #l__RemovalStack__2, 1, -1 do
                        local v22 = l__RemovalStack__2[v21];
                        table.remove(u4.List, v22.Position);
                        if v22.UponRemovalFn then
                            v22.UponRemovalFn();
                        end;
                    end;
                    u4.RemovalStack = {};
                    u4.__IsRemoving = false;
                    u4.LastListSize = v16;
                    return;
                end;
            end;
        end;
    end);
    function u4.AddManualRemoval(u23) --[[ Line: 111 ]]
        -- upvalues: u4 (ref)
        task.spawn(function() --[[ Line: 112 ]]
            -- upvalues: u4 (ref), u23 (copy)
            local u24 = os.clock();
            repeat
                task.wait();
            until not u4.__IsRemoving;
            local v25 = table.find(u4.List, u23);
            if v25 then
                u4.Time = u4.Rate;
                table.insert(u4.RemovalStack, {
                    Position = v25,
                    UponRemovalFn = function() --[[ Name: UponRemovalFn, Line 121 ]]
                        -- upvalues: u24 (copy)
                        warn("Manual removal time:", u24 - os.clock());
                    end
                });
            end;
        end);
    end;
    function u4.Add(p26) --[[ Line: 129 ]]
        -- upvalues: u4 (ref)
        table.insert(u4.ProcessFnList, p26);
    end;
    function u4.Destroy() --[[ Line: 133 ]]
        -- upvalues: u4 (ref)
        u4.Update:Disconnect();
        task.wait();
        u4 = nil;
    end;
    u4.AutoSchedule(u4.TargetPeriod);
    return u4;
end;
return v1;
