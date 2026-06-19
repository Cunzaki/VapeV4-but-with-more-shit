-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local v1 = _G.obtain("Signal");
local u2 = v1();
local v3 = v1();
local u4 = false;
local u5 = {};
local function v7(p6) --[[ Line: 14 ]]
    -- upvalues: u5 (ref)
    return u5[p6.UserId];
end;
local function v12(p8) --[[ Line: 26 ]]
    -- upvalues: u5 (ref), u2 (copy)
    local v9;
    if p8 then
        local v10 = {};
        for v11 = 1, #p8 do
            v10[p8[v11]] = true;
        end;
        v9 = v10 or {};
    else
        v9 = {};
    end;
    u5 = v9;
    u2:Call();
end;
local u13 = {};
return {
    KEY_MUTED = "Muted",
    KEY_DISABLE_GLOBAL_MUTE = "UnmodChat",
    GetMuted = function(p14) --[[ Name: GetMuted, Line 55 ]]
        -- upvalues: u4 (ref), u13 (ref), u5 (ref)
        return not u4 and u13[p14.UserId] or u5[p14.UserId];
    end,
    SetCache = function(p15) --[[ Name: SetCache, Line 34 ]]
        -- upvalues: u13 (ref), u2 (copy)
        local v16 = {};
        for v17 = 1, #p15 do
            v16[p15[v17]] = true;
        end;
        u13 = v16;
        u2:Call();
    end,
    UpdateCache = function(p18, p19) --[[ Name: UpdateCache, Line 38 ]]
        -- upvalues: u13 (ref), u2 (copy)
        u13[p18.UserId] = p19;
        u2:Call();
    end,
    GetGlobalMuted = function(p20) --[[ Name: GetGlobalMuted, Line 42 ]]
        -- upvalues: u13 (ref)
        return u13[p20.UserId];
    end,
    GetPersonalMuted = v7,
    LoadIsMutedCache = v12,
    MuteListChangedSignal = u2,
    ShowChatModerationSignal = v3,
    GetGlobalChatModerationDisabled = function() --[[ Name: GetGlobalChatModerationDisabled, Line 51 ]]
        -- upvalues: u4 (ref)
        return u4;
    end,
    SetGlobalChatModerationDisabled = function(p21) --[[ Name: SetGlobalChatModerationDisabled, Line 46 ]]
        -- upvalues: u4 (ref), u2 (copy)
        u4 = p21;
        u2:Call();
    end
};
