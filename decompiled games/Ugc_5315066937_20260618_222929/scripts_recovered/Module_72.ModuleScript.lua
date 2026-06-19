-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = unpack;
local l__obtain__1 = _G.obtain;
local v2 = l__obtain__1("Class");
local u3 = l__obtain__1("EventQueueGroup");
local u4 = l__obtain__1("EventQueueIndexer");
local l__GetControlState__2 = l__obtain__1("GameControl").GetControlState;
local l__new__3 = Vector3.new;
local l__new__4 = CFrame.new;
local l__Angles__5 = CFrame.Angles;
local v5 = l__new__3();
l__new__4();
local l__lerp__6 = v5.lerp;
local function u15(p6, p7, p8, p9, p10, p11) --[[ Line: 19 ]]
    -- upvalues: l__lerp__6 (copy)
    if p10 < 0 then
        return l__lerp__6(p6, p7, p10), p8;
    end;
    if p10 >= 1 then
        return l__lerp__6(p6, p7, p10), p9;
    end;
    local v12 = 1 - p10;
    local v13 = 3 * p6 + p11 * p8;
    local v14 = 3 * p7 - p11 * p9;
    return p6 * (v12 * v12 * v12) + v13 * (p10 * v12 * v12) + v14 * (p10 * p10 * v12) + p7 * (p10 * p10 * p10), (-3 * v12 * v12 * p6 + v12 * (1 - 3 * p10) * v13 + p10 * (2 - 3 * p10) * v14 + 3 * p10 * p10 * p7) / p11;
end;
local v16 = v2();
function v16.GetPV(p17) --[[ Line: 34 ]]
    -- upvalues: u15 (copy)
    local v18 = p17.Timer:Time();
    local l__Queued__7 = p17.EventQueues.Output.Queued;
    local v19 = l__Queued__7:Before();
    local v20 = l__Queued__7:After();
    if v19 and v20 then
        local v21 = v19[1];
        local v22 = v20[1] - v21;
        return u15(v19[4], v20[4], v19[5], v20[5], (v18 - v21) / v22, v22);
    end;
    if v19 then
        local v23 = v18 - v19[1];
        local v24 = v19[4];
        local v25 = v19[5];
        local v26 = v19[6];
        return v24 + v23 * (v25 + v23 / 2 * v26), v25 + v23 * v26, v23;
    end;
end;
function v16.GetPVScaled(p27) --[[ Line: 52 ]]
    -- upvalues: u15 (copy)
    local l__Timer__8 = p27.Timer;
    local v28 = l__Timer__8:GetGlobalScale();
    local v29 = l__Timer__8:Time();
    local l__Queued__9 = p27.EventQueues.Output.Queued;
    local v30 = l__Queued__9:Before();
    local v31 = l__Queued__9:After();
    if v30 and v31 then
        local v32 = v30[1];
        local v33 = v31[1] - v32;
        local v34, v35 = u15(v30[4], v31[4], v30[5], v31[5], (v29 - v32) / v33, v33);
        return v34, v35 * v28;
    end;
    if v30 then
        local v36 = v29 - v30[1];
        local v37 = v30[4];
        local v38 = v30[5];
        local v39 = v30[6];
        return v37 + v36 * (v38 + v36 / 2 * v39), (v38 + v36 * v39) * v28;
    end;
end;
function v16.GetGravity(p40) --[[ Line: 71 ]]
    return p40.EventQueues.Gravity.Queued:Before()[2];
end;
function v16.GetAngles(p41) --[[ Line: 74 ]]
    -- upvalues: l__lerp__6 (copy)
    local v42 = p41.Timer:Time();
    local l__Queued__10 = p41.EventQueues.Output.Queued;
    local v43 = l__Queued__10:Before();
    local v44 = l__Queued__10:After();
    if v43 and v44 then
        local v45 = v43[1];
        return l__lerp__6(v43[3], v44[3], (v42 - v45) / (v44[1] - v45));
    end;
    if v43 then
        return v43[3];
    end;
end;
function v16.GetCFrame(p46) --[[ Line: 85 ]]
    -- upvalues: l__lerp__6 (copy), l__Angles__5 (copy), u15 (copy)
    local v47 = p46.Timer:Time();
    local l__Queued__11 = p46.EventQueues.Output.Queued;
    local v48 = l__Queued__11:Before();
    local v49 = l__Queued__11:After();
    if v48 and v49 then
        local v50 = v48[1];
        local v51 = v49[1] - v50;
        local v52 = (v47 - v50) / v51;
        local v53 = v48[4];
        local v54 = v48[5];
        local v55 = v49[4];
        local v56 = v49[5];
        local v57 = l__lerp__6(v48[3], v49[3], v52);
        return l__Angles__5(0, v57.y, 0) * l__Angles__5(v57.x, 0, 0) + u15(v53, v55, v54, v56, v52, v51);
    end;
    if v48 then
        local v58 = v47 - v48[1];
        local v59 = v48[4];
        local v60 = v48[5];
        local v61 = v48[6];
        local v62 = v48[3];
        return l__Angles__5(0, v62.y, 0) * l__Angles__5(v62.x, 0, 0) + (v59 + v58 * (v60 + v58 / 2 * v61));
    end;
end;
function v16.GetInput(p63) --[[ Line: 104 ]]
    -- upvalues: u1 (copy)
    local v64 = p63.EventQueues.Input.Queued:Before();
    if v64 then
        return u1(v64);
    end;
end;
function v16.GetOutput(p65) --[[ Line: 110 ]]
    -- upvalues: u1 (copy)
    local v66 = p65.EventQueues.Output.Queued:Before();
    if v66 then
        return u1(v66);
    end;
end;
function v16.GetControlState(p67, p68) --[[ Line: 116 ]]
    -- upvalues: l__GetControlState__2 (copy)
    local v69 = p67.EventQueues.Input.Queued:Before();
    if v69 then
        return l__GetControlState__2(v69[2], p68);
    else
        return l__GetControlState__2(0, p68);
    end;
end;
local l__lerp__12 = Vector2.zero.lerp;
function v16.GetMousePos(p70, p71) --[[ Line: 126 ]]
    -- upvalues: l__lerp__12 (copy)
    local l__Queued__13 = p70.EventQueues.Input.Queued;
    local v72 = l__Queued__13:Before();
    local v73 = l__Queued__13:After();
    if v72 and v73 then
        local v74 = v72[1];
        return l__lerp__12(v72[3], v73[3], (p71 - v74) / (v73[1] - v74));
    end;
    if v72 then
        return v72[3];
    end;
end;
function v16.Constructor(p75, p76, p77) --[[ Line: 137 ]]
    -- upvalues: u4 (copy), u3 (copy)
    p75.Type = "Offline";
    p75.Timer = p76;
    p75.Timelines = p77;
    local v78 = u4();
    p75.EventQueues = u3(p77, v78);
    p75.Indexer = v78;
end;
return v16;
