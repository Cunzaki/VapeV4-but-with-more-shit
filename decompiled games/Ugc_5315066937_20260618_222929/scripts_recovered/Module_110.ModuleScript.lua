-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__insert__1 = table.insert;
local l__UserInputService__2 = game:GetService("UserInputService");
local u1 = {};
local u2 = {
    [Enum.UserInputState.Begin] = true,
    [Enum.UserInputState.End] = false
};
local function u6(p3, p4, ...) --[[ Line: 35 ]]
    local v5 = p3.Bindables[p3.Binds[p4]];
    if v5 then
        return v5(...);
    end;
end;
local u13 = {
    [Enum.UserInputType.Keyboard] = function(p7) --[[ Line: 43 ]]
        -- upvalues: u2 (copy)
        return "Keyboard", p7.KeyCode.Name, u2[p7.UserInputState];
    end,
    [Enum.UserInputType.MouseButton1] = function(p8) --[[ Line: 46 ]]
        -- upvalues: u2 (copy)
        return "MouseButton1", u2[p8.UserInputState];
    end,
    [Enum.UserInputType.MouseButton2] = function(p9) --[[ Line: 49 ]]
        -- upvalues: u2 (copy)
        return "MouseButton2", u2[p9.UserInputState];
    end,
    [Enum.UserInputType.MouseButton3] = function(p10) --[[ Line: 52 ]]
        -- upvalues: u2 (copy)
        return "MouseButton3", u2[p10.UserInputState];
    end,
    [Enum.UserInputType.MouseMovement] = function(p11) --[[ Line: 55 ]]
        local l__Position__3 = p11.Position;
        local l__Delta__4 = p11.Delta;
        return "MouseMovement", l__Position__3.x, l__Position__3.y, l__Delta__4.x, l__Delta__4.y;
    end,
    [Enum.UserInputType.MouseWheel] = function(p12) --[[ Line: 60 ]]
        return "MouseWheel", p12.Position.z;
    end
};
local function u17(p14, p15, ...) --[[ Line: 65 ]]
    -- upvalues: u1 (copy), u6 (copy)
    for v16 = 1, #u1 do
        if u6(u1[v16], p15, ...) then
            if p14 then
                break;
            end;
        elseif p15 == "Keyboard" and (u6(u1[v16], ...) and p14) then
            break;
        end;
    end;
end;
local function u20(p18) --[[ Line: 76 ]]
    -- upvalues: u13 (copy), u17 (copy), u2 (copy)
    local v19 = u13[p18.UserInputType];
    if v19 then
        u17(u2[p18.UserInputState] ~= false, v19(p18));
    end;
end;
local function u24(p21, p22, p23) --[[ Line: 85 ]]
    p21.Binds[p23] = p22;
end;
local function u29(p25, p26) --[[ Line: 89 ]]
    for v27, v28 in p25.Binds do
        if v28 == p26 then
            return v27;
        end;
    end;
end;
local function u32(p30, p31) --[[ Line: 97 ]]
    return p30.Binds[p31];
end;
local function u37(p33, p34, p35, p36) --[[ Line: 101 ]]
    p33.Bindables[p34] = p35;
    if p36 then
        p33.Binds[p36] = p34;
    end;
end;
return {
    Init = function() --[[ Name: Init, Line 120 ]]
        -- upvalues: l__UserInputService__2 (copy), u20 (copy)
        l__UserInputService__2.InputBegan:connect(u20);
        l__UserInputService__2.InputEnded:connect(u20);
        l__UserInputService__2.InputChanged:connect(u20);
    end,
    New = function(_, p38) --[[ Name: New, Line 108 ]]
        -- upvalues: u24 (copy), u29 (copy), u32 (copy), u37 (copy), u1 (copy), l__insert__1 (copy)
        local v39 = {
            Priority = p38,
            Binds = {},
            Bindables = {},
            SetBind = u24,
            GetBindKeyFromName = u29,
            GetBindNameFromBindKey = u32,
            RegisterBindable = u37
        };
        local l__Priority__5 = v39.Priority;
        local v40 = #u1 + 1;
        for v41 = 1, #u1 do
            if l__Priority__5 < u1[v41].Priority then
                v40 = v41;
                break;
            end;
        end;
        l__insert__1(u1, v40, v39);
        return v39;
    end
};
