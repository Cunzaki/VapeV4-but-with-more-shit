-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("Class");
local v2 = l__obtain__1("StateCalculus");
local v3 = v1();
local function u6(p4, p5) --[[ Line: 35 ]]
    -- upvalues: u6 (copy)
    local l__Scale__2 = p4.Scale;
    if l__Scale__2 == 0 then
        return p4.Offset;
    end;
    if not p5 then
        local l__Parent__3 = p4.Parent;
        if l__Parent__3 then
            p5 = u6(l__Parent__3);
        else
            p5 = p4.Pt or (-1 / 0);
        end;
    end;
    return l__Scale__2 * p5 + p4.Offset;
end;
function v3.Play(p7, p8) --[[ Line: 87 ]]
    -- upvalues: u6 (copy)
    local l__SavedScale__4 = p7.SavedScale;
    if l__SavedScale__4 then
        p7.SavedScale = nil;
        if p7.SavedScale then
            p7.SavedScale = l__SavedScale__4;
            return;
        end;
        local l__Scale__5 = p7.Scale;
        local v9;
        if l__Scale__5 == 0 then
            v9 = p7.Offset;
        else
            local v10;
            if p8 then
                v10 = p8;
            else
                local l__Parent__6 = p7.Parent;
                if l__Parent__6 then
                    v10 = u6(l__Parent__6);
                else
                    v10 = p7.Pt or (-1 / 0);
                end;
            end;
            v9 = l__Scale__5 * v10 + p7.Offset;
        end;
        p7.Scale = l__SavedScale__4;
        p7.Offset = v9 - l__SavedScale__4 * p8;
    end;
end;
function v3.Pause(p11, p12) --[[ Line: 95 ]]
    -- upvalues: u6 (copy)
    if not p11.SavedScale then
        local l__Scale__7 = p11.Scale;
        if p11.SavedScale then
            p11.SavedScale = 0;
        else
            local l__Scale__8 = p11.Scale;
            local v13;
            if l__Scale__8 == 0 then
                v13 = p11.Offset;
            else
                local v14;
                if p12 then
                    v14 = p12;
                else
                    local l__Parent__9 = p11.Parent;
                    if l__Parent__9 then
                        v14 = u6(l__Parent__9);
                    else
                        v14 = p11.Pt or (-1 / 0);
                    end;
                end;
                v13 = l__Scale__8 * v14 + p11.Offset;
            end;
            p11.Scale = 0;
            p11.Offset = v13 - 0 * p12;
        end;
        p11.SavedScale = l__Scale__7;
    end;
end;
function v3.SetTime(p15, p16, p17) --[[ Line: 57 ]]
    p15.Offset = p17 - p15.Scale * p16;
end;
function v3.GetScale(p18) --[[ Line: 63 ]]
    return p18.SavedScale or p18.Scale;
end;
function v3.SetScale(p19, p20, p21) --[[ Line: 66 ]]
    -- upvalues: u6 (copy)
    if p19.SavedScale then
        p19.SavedScale = p21;
    else
        local l__Scale__10 = p19.Scale;
        local v22;
        if l__Scale__10 == 0 then
            v22 = p19.Offset;
        else
            local v23;
            if p20 then
                v23 = p20;
            else
                local l__Parent__11 = p19.Parent;
                if l__Parent__11 then
                    v23 = u6(l__Parent__11);
                else
                    v23 = p19.Pt or (-1 / 0);
                end;
            end;
            v22 = l__Scale__10 * v23 + p19.Offset;
        end;
        p19.Scale = p21;
        p19.Offset = v22 - p21 * p20;
    end;
end;
function v3.SetOffset(p24, _, p25) --[[ Line: 82 ]]
    p24.Offset = p25;
end;
v3.Time = u6;
function v3.ParentTime(p26, p27) --[[ Line: 53 ]]
    return (p27 - p26.Offset) / p26.Scale;
end;
v2({ "Scale", "SavedScale", "Offset" }):Simple(v3);
local function u29(p28) --[[ Line: 114 ]]
    -- upvalues: u29 (copy)
    local l__Scale__12 = p28.Scale;
    if l__Scale__12 == 0 then
        return 0;
    else
        local l__Parent__13 = p28.Parent;
        if l__Parent__13 then
            return l__Scale__12 * u29(l__Parent__13);
        else
            return l__Scale__12;
        end;
    end;
end;
v3.GetGlobalScale = u29;
local function u32(p30, p31) --[[ Line: 128 ]]
    -- upvalues: u32 (copy)
    local l__Scale__14 = p30.Scale;
    if l__Scale__14 == 0 then
        return (-1 / 0);
    else
        local l__Parent__15 = p30.Parent;
        if l__Parent__15 then
            return u32(l__Parent__15, (p31 - p30.Offset) / l__Scale__14);
        else
            return p31;
        end;
    end;
end;
v3.GetGlobalTime = u32;
function v3.Constructor(p33, p34, p35, p36) --[[ Line: 143 ]]
    p33.Parent = p34;
    p33.Scale = p35 or 1;
    p33.Offset = p36 or 0;
end;
return v3;
