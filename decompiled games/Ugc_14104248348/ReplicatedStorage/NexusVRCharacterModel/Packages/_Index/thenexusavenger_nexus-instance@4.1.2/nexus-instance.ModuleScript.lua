-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_nexus-instance@4.1.2.nexus-instance
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    "__call",
    "__concat",
    "__unm",
    "__add",
    "__sub",
    "__mul",
    "__div",
    "__idiv",
    "__mod",
    "__pow",
    "__tostring",
    "__eq",
    "__lt",
    "__le",
    "__gc",
    "__len",
    "__iter"
};
local l__TypedEvent__1 = require(script:WaitForChild("Event"):WaitForChild("TypedEvent"));
local u2 = {
    TypedEvent = l__TypedEvent__1
};
function u2.ToInstance(u3) --[[ Line: 53 ]]
    -- upvalues: l__TypedEvent__1 (copy), u2 (copy), u1 (copy)
    function u3.new(...) --[[ Line: 56 ]]
        -- upvalues: l__TypedEvent__1 (ref), u3 (copy), u2 (ref), u1 (ref)
        local v4 = l__TypedEvent__1.new();
        local u5 = {};
        local u6 = {};
        local u7 = {};
        local u8 = {};
        local u9 = {};
        local u10 = {};
        local u11 = {};
        local u12 = {};
        local v13 = {
            Changed = v4,
            BaseClass = u3,
            Events = { v4 },
            TransformFunctions = u6,
            PropertyTransformFunctions = u7,
            OnAnyPropertyChangedFunctions = u8,
            OnPropertyChangedFunctions = u9,
            HiddenPropertyChanges = u10,
            HiddenNextPropertyChanges = u11,
            PropertyChangedEvents = u12
        };
        local v26 = {
            __index = function(_, p14) --[[ Name: __index, Line 82 ]]
                -- upvalues: u5 (copy), u2 (ref), u3 (ref)
                local v15 = u5[p14];
                if v15 == nil then
                    local v16 = u2[p14];
                    if v16 == nil then
                        return u3[p14];
                    else
                        return v16;
                    end;
                else
                    return v15;
                end;
            end,
            __newindex = function(p17, p18, p19) --[[ Name: __newindex, Line 98 ]]
                -- upvalues: u6 (copy), u7 (copy), u5 (copy), u8 (copy), u9 (copy), u11 (copy), u10 (copy), u12 (copy)
                for _, v20 in u6 do
                    p19 = v20(p18, p19);
                end;
                if u7[p18] then
                    for _, v21 in u7[p18] do
                        p19 = v21(p19);
                    end;
                end;
                if p17[p18] == p19 then
                else
                    u5[p18] = p19;
                    for _, v22 in u8 do
                        v22(p18, p19);
                    end;
                    local v23 = u9[p18];
                    if v23 then
                        for _, v24 in v23 do
                            v24(p19);
                        end;
                    end;
                    if u11[p18] then
                        u11[p18] = nil;
                    elseif u10[p18] then
                    else
                        p17.Changed:Fire(p18);
                        local v25 = u12[p18];
                        if v25 then
                            v25:Fire();
                        end;
                    end;
                end;
            end
        };
        for _, v27 in u1 do
            v26[v27] = u3[v27];
        end;
        local v28 = setmetatable(v13, v26);
        local l____new__2 = u3.__new;
        if l____new__2 then
            l____new__2(v28, ...);
        end;
        return v28;
    end;
    return u3;
end;
function u2.CreateEvent(p29) --[[ Line: 167 ]]
    -- upvalues: l__TypedEvent__1 (copy)
    local v30 = l__TypedEvent__1.new();
    table.insert(p29.Events, v30);
    return v30;
end;
function u2.AddGenericPropertyTransform(p31, p32) --[[ Line: 176 ]]
    table.insert(p31.TransformFunctions, p32);
end;
function u2.AddPropertyTransform(p33, p34, p35) --[[ Line: 183 ]]
    if not p33.PropertyTransformFunctions[p34] then
        p33.PropertyTransformFunctions[p34] = {};
    end;
    table.insert(p33.PropertyTransformFunctions[p34], p35);
end;
function u2.OnAnyPropertyChanged(p36, p37) --[[ Line: 194 ]]
    table.insert(p36.OnAnyPropertyChangedFunctions, p37);
end;
function u2.OnPropertyChanged(p38, p39, p40) --[[ Line: 202 ]]
    if not p38.OnPropertyChangedFunctions[p39] then
        p38.OnPropertyChangedFunctions[p39] = {};
    end;
    table.insert(p38.OnPropertyChangedFunctions[p39], p40);
end;
function u2.HidePropertyChanges(p41, p42) --[[ Line: 212 ]]
    p41.HiddenPropertyChanges[p42] = true;
end;
function u2.HideNextPropertyChange(p43, p44) --[[ Line: 219 ]]
    p43.HiddenNextPropertyChanges[p44] = true;
end;
function u2.GetPropertyChangedSignal(p45, p46) --[[ Line: 226 ]]
    if not p45.PropertyChangedEvents[p46] then
        p45.PropertyChangedEvents[p46] = p45:CreateEvent();
    end;
    return p45.PropertyChangedEvents[p46];
end;
function u2.Destroy(u47) --[[ Line: 236 ]]
    local l__Destroy__3 = u47.BaseClass.Destroy;
    if l__Destroy__3 then
        l__Destroy__3(u47);
    end;
    task.defer(function() --[[ Line: 244 ]]
        -- upvalues: u47 (copy)
        for _, v48 in u47.Events do
            v48:Destroy();
        end;
        u47.Events = {};
    end);
end;
return u2;
