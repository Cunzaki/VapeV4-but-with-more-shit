-- Decompiled with Potassium's decompiler.

local l__Signal__1 = require(script.Parent.Signal);
local u1 = {};
u1.__index = u1;
function u1.new(p2, p3, p4) --[[ Line: 9 ]]
    -- upvalues: u1 (copy), l__Signal__1 (copy)
    local v5 = setmetatable({}, u1);
    v5.candidate_folder = p2;
    v5.onRegionEnter = l__Signal__1.new();
    v5.onRegionExit = l__Signal__1.new();
    v5.is_active = true;
    v5.tracked_entities = {};
    v5.processed_regions = {};
    v5.previous_positions = {};
    v5.interval = p4 or 0.1;
    v5:updateRegions(p3);
    v5:startScheduler();
    return v5;
end;
function u1.updateRegions(p6, p7) --[[ Line: 30 ]]
    table.clear(p6.processed_regions);
    for _, v8 in ipairs(p7) do
        if v8:IsA("BasePart") then
            local l__processed_regions__2 = p6.processed_regions;
            local v9 = {
                inverse_cf = v8.CFrame:Inverse(),
                half_size = v8.Size / 2,
                name = v8.Name
            };
            table.insert(l__processed_regions__2, v9);
        end;
    end;
end;
function u1.startScheduler(u10) --[[ Line: 43 ]]
    task.spawn(function() --[[ Line: 44 ]]
        -- upvalues: u10 (copy)
        while u10.is_active do
            local v11 = os.clock();
            u10:runCheck();
            local v12 = os.clock() - v11;
            task.wait((math.max(u10.interval - v12, 0)));
        end;
    end);
end;
function u1.runCheck(p13) --[[ Line: 56 ]]
    local v14 = p13.candidate_folder:GetChildren();
    local l__processed_regions__3 = p13.processed_regions;
    local function v17(p15) --[[ Line: 61 ]]
        if typeof(p15) == "Vector3" then
            return p15;
        elseif typeof(p15) == "CFrame" then
            return p15.Position;
        elseif p15:IsA("Attachment") then
            return p15.WorldPosition;
        elseif p15:IsA("Model") then
            local v16 = p15.PrimaryPart or p15:FindFirstChild("Head");
            return v16 and v16.Position or p15:GetPivot().Position;
        elseif p15:IsA("BasePart") then
            return p15.Position;
        else
            return nil;
        end;
    end;
    local v18 = {};
    local function v53(p19, p20, p21) --[[ Line: 78 ]]
        local v22 = p21.inverse_cf * p19;
        local v23 = p21.inverse_cf * p20;
        local l__half_size__4 = p21.half_size;
        local v24 = v23.X - v22.X;
        local v25 = v23.Y - v22.Y;
        local v26 = v23.Z - v22.Z;
        local v34 = 0;
        local v33 = 1;
        local l__X__5 = v22.X;
        local l__X__6 = l__half_size__4.X;
        local v35, v36, v37;
        if math.abs(v24) < 1e-8 then
            if l__X__6 < math.abs(l__X__5) then
                local v38;
                local v33, v34, v35, v36, v37, v38;
                local v39 = 0;
                while true do
                    if v39 == 0 then
                        v39 = -1;
                        v35 = v33;
                        v36 = v34;
                        v37 = false;
                        v39 = 1;
                        continue;
                    elseif v39 == 1 then
                        v39 = -1;
                        if not v37 then
                            return false;
                        end;
                        local l__Y__7 = v22.Y;
                        local l__Y__8 = l__half_size__4.Y;
                        if math.abs(v25) < 1e-8 then
                            if l__Y__8 >= math.abs(l__Y__7) then
                                goto l2;
                            end;
                            v38 = false;
                        else
                            local v40 = 1 / v25;
                            local v41 = (-l__Y__8 - l__Y__7) * v40;
                            local v42 = (l__Y__8 - l__Y__7) * v40;
                            if v42 >= v41 then
                                local v43 = v41;
                                v41 = v42;
                                v42 = v43;
                            end;
                            v34 = math.max(v36, v42);
                            v33 = math.min(v35, v41);
                            if v33 >= v34 then
                                v35 = v33;
                                v36 = v34;
                                v38 = true;
                                v39 = 2;
                                continue;
                            end;
                            v35 = v33;
                            v36 = v34;
                            v38 = false;
                        end;
                        v39 = 2;
                        continue;
                    elseif v39 == 2 then
                        v39 = -1;
                        if not v38 then
                            return false;
                        end;
                        local l__Z__9 = v22.Z;
                        local l__Z__10 = l__half_size__4.Z;
                        local v44;
                        if math.abs(v26) < 1e-8 then
                            if l__Z__10 < math.abs(l__Z__9) then
                                v44 = false;
                                if v44 then
                                    return v36 <= v35;
                                else
                                    return false;
                                end;
                            end;
                        else
                            local v45 = 1 / v26;
                            local v46 = (-l__Z__10 - l__Z__9) * v45;
                            local v47 = (l__Z__10 - l__Z__9) * v45;
                            if v47 >= v46 then
                                local v48 = v46;
                                v46 = v47;
                                v47 = v48;
                            end;
                            v34 = math.max(v36, v47);
                            v33 = math.min(v35, v46);
                            if v33 < v34 then
                                v35 = v33;
                                v36 = v34;
                                v44 = false;
                                goto l0;
                            end;
                            v35 = v33;
                            v36 = v34;
                        end;
                        v44 = true;
                        goto l0;
                    else
                        break;
                    end;
                end;
            end;
            v35 = v33;
            v36 = v34;
        else
            local v49 = 1 / v24;
            local v50 = (-l__X__6 - l__X__5) * v49;
            local v51 = (l__X__6 - l__X__5) * v49;
            if v51 >= v50 then
                local v52 = v50;
                v50 = v51;
                v51 = v52;
            end;
            v34 = math.max(v34, v51);
            v33 = math.min(v33, v50);
            if v33 < v34 then
                v35 = v33;
                v36 = v34;
                v37 = false;
                goto l3;
            end;
            v35 = v33;
            v36 = v34;
        end;
        v37 = true;
        goto l3;
    end;
    for _, v54 in ipairs(v14) do
        local v55 = v17(v54);
        if v55 then
            local v56 = p13.previous_positions[v54] or v55;
            local v57 = nil;
            local v58 = false;
            for _, v59 in ipairs(l__processed_regions__3) do
                local v60 = v59.inverse_cf * v55;
                if math.abs(v60.X) <= v59.half_size.X and (math.abs(v60.Y) <= v59.half_size.Y and math.abs(v60.Z) <= v59.half_size.Z) then
                    v57 = v59;
                    v58 = true;
                    break;
                end;
            end;
            local v61 = false;
            if not v58 and (not p13.tracked_entities[v54] and v56 ~= v55) then
                for _, v62 in ipairs(l__processed_regions__3) do
                    if v53(v56, v55, v62) then
                        v57 = v62;
                        v61 = true;
                        break;
                    end;
                end;
            end;
            p13.previous_positions[v54] = v55;
            if v58 then
                v18[v54] = true;
                if not p13.tracked_entities[v54] then
                    p13.onRegionEnter:Fire(v54, v57.name);
                end;
            elseif v61 then
                p13.onRegionEnter:Fire(v54, v57.name);
                p13.onRegionExit:Fire(v54, "Swept");
            end;
        end;
    end;
    for v63, _ in pairs(p13.tracked_entities) do
        if not v18[v63] then
            local v64 = not v63:IsDescendantOf(p13.candidate_folder);
            p13.onRegionExit:Fire(v63, v64 and "Destroyed" or "Left");
            if v64 then
                p13.previous_positions[v63] = nil;
            end;
        end;
    end;
    p13.tracked_entities = v18;
end;
function u1.Destroy(p65) --[[ Line: 171 ]]
    p65.is_active = false;
    p65.onRegionEnter:Destroy();
    p65.onRegionExit:Destroy();
    p65.tracked_entities = nil;
    p65.processed_regions = nil;
    p65.previous_positions = nil;
end;
return u1;