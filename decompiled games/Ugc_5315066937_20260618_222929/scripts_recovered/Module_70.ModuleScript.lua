-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__clear__1 = table.clear;
local l__clone__2 = table.clone;
local l__obtain__3 = _G.obtain;
local u1 = l__obtain__3("L1Copy");
local v2 = l__obtain__3("CustomEnums");
local l__EVENT_RUN_PREPARE__4 = v2.EVENT_RUN_PREPARE;
local l__EVENT_RUN_START__5 = v2.EVENT_RUN_START;
local l__EVENT_RUN_FINISH__6 = v2.EVENT_RUN_FINISH;
local _ = v2.EVENT_RUN_CLEAR;
local l__EVENT_RUN_FLAG__7 = v2.EVENT_RUN_FLAG;
local v3 = l__obtain__3("Class")();
local u4 = {
    Start = {
        Enter = {
            [false] = l__EVENT_RUN_PREPARE__4
        },
        VState = {
            [true] = l__EVENT_RUN_START__5,
            [false] = l__EVENT_RUN_PREPARE__4
        },
        Leave = {
            [false] = l__EVENT_RUN_START__5
        }
    },
    Finish = {
        Enter = {
            [true] = l__EVENT_RUN_FINISH__6,
            [false] = l__EVENT_RUN_FINISH__6
        }
    },
    Anticheat = {
        Enter = {
            [true] = l__EVENT_RUN_FLAG__7,
            [false] = l__EVENT_RUN_FLAG__7
        }
    }
};
function v3.SetVState(p5, p6, p7, p8) --[[ Line: 63 ]]
    -- upvalues: u4 (copy)
    p5.VState = p6;
    for _, v9 in p5.InZones do
        local l__Type__8 = v9.Type;
        local l__Mode__9 = v9.Mode;
        local v10;
        if l__Type__8 and l__Mode__9 then
            local l__VState__10 = u4[l__Type__8].VState;
            if l__VState__10 then
                assert((p6 and true or false) == p6, "VState must be boolean");
                v10 = l__VState__10[p6];
                if not v10 then
                    v10 = nil;
                    l__Mode__9 = nil;
                end;
            else
                v10 = nil;
                l__Mode__9 = nil;
            end;
        else
            v10 = nil;
            l__Mode__9 = nil;
        end;
        if v10 and l__Mode__9 then
            p8:WrapRunEvent(p7, v10, l__Mode__9);
        end;
    end;
end;
function v3.Enter(p11, p12, p13, p14, p15, p16) --[[ Line: 74 ]]
    -- upvalues: u4 (copy)
    p11.InZones[p12] = {
        Type = p13,
        Mode = p14
    };
    local l__VState__11 = p11.VState;
    local v17;
    if p13 and p14 then
        local l__Enter__12 = u4[p13].Enter;
        if l__Enter__12 then
            assert((l__VState__11 and true or false) == l__VState__11, "VState must be boolean");
            v17 = l__Enter__12[l__VState__11];
            if not v17 then
                v17 = nil;
                p14 = nil;
            end;
        else
            v17 = nil;
            p14 = nil;
        end;
    else
        v17 = nil;
        p14 = nil;
    end;
    if v17 and p14 then
        p16:WrapRunEvent(p15, v17, p14);
    end;
end;
function v3.Leave(p18, p19, p20, p21, p22, p23) --[[ Line: 82 ]]
    -- upvalues: u4 (copy)
    p18.InZones[p19] = nil;
    local l__VState__13 = p18.VState;
    local v24;
    if p20 and p21 then
        local l__Leave__14 = u4[p20].Leave;
        if l__Leave__14 then
            assert((l__VState__13 and true or false) == l__VState__13, "VState must be boolean");
            v24 = l__Leave__14[l__VState__13];
            if not v24 then
                v24 = nil;
                p21 = nil;
            end;
        else
            v24 = nil;
            p21 = nil;
        end;
    else
        v24 = nil;
        p21 = nil;
    end;
    if v24 and p21 then
        p23:WrapRunEvent(p22, v24, p21);
    end;
end;
function v3.Clear(p25) --[[ Line: 90 ]]
    -- upvalues: l__clear__1 (copy)
    l__clear__1(p25.InZones);
end;
function v3.GetState(p26) --[[ Line: 94 ]]
    -- upvalues: l__clone__2 (copy)
    return {
        VState = p26.VState,
        InZones = l__clone__2(p26.InZones)
    };
end;
function v3.SetState(p27, p28) --[[ Line: 100 ]]
    p27.VState = p28.VState;
    p27.InZones = p28.InZones;
end;
function v3.CopyState(p29, p30) --[[ Line: 104 ]]
    -- upvalues: l__clear__1 (copy), u1 (copy)
    p29.VState = p30.VState;
    l__clear__1(p29.InZones);
    p29.InZones = u1(p30.InZones, p29.InZones);
end;
function v3.Constructor(p31) --[[ Line: 111 ]]
    p31.VState = false;
    p31.InZones = {};
end;
return v3;
