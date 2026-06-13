-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.State.Settings
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__TypedEvent__1 = require(script.Parent.Parent:WaitForChild("Packages"):WaitForChild("NexusInstance")).TypedEvent;
local u1 = {};
u1.__index = u1;
local u2 = nil;
function u1.new() --[[ Line: 25 ]]
    -- upvalues: u1 (copy)
    return setmetatable({
        Defaults = {},
        Overrides = {},
        SettingsChangeEvents = {},
        SettingsCache = {}
    }, u1);
end;
function u1.GetInstance() --[[ Line: 37 ]]
    -- upvalues: u2 (ref), u1 (copy)
    if not u2 then
        u2 = u1.new();
    end;
    return u2;
end;
function u1.GetSetting(p3, p4) --[[ Line: 47 ]]
    if p3.SettingsCache[p4] ~= nil then
        return p3.SettingsCache[p4];
    end;
    local l__Defaults__2 = p3.Defaults;
    local l__Overrides__3 = p3.Overrides;
    local v5 = string.split(p4, ".");
    for v6 = 1, #v5 - 1 do
        l__Defaults__2 = l__Defaults__2[v5[v6]] or {};
        l__Overrides__3 = l__Overrides__3[v5[v6]] or {};
    end;
    local v7 = l__Overrides__3[v5[#v5]];
    if v7 == nil then
        v7 = l__Defaults__2[v5[#v5]];
    end;
    p3.SettingsCache[p4] = v7;
    return v7;
end;
function u1.SetSetting(p8, p9, p10) --[[ Line: 73 ]]
    local l__Overrides__4 = p8.Overrides;
    local v11 = string.split(p9, ".");
    for v12 = 1, #v11 - 1 do
        if not l__Overrides__4[v11[v12]] then
            l__Overrides__4[v11[v12]] = {};
        end;
        l__Overrides__4 = l__Overrides__4[v11[v12]];
    end;
    l__Overrides__4[v11[#v11]] = p10;
    p8.SettingsCache[p9] = p10;
    local v13 = p8.SettingsChangeEvents[string.lower(p9)];
    if v13 then
        v13:Fire();
    end;
end;
function u1.SetDefaults(p14, p15) --[[ Line: 96 ]]
    p14.Defaults = p15;
    p14.SettingsCache = {};
    for _, v16 in p14.SettingsChangeEvents do
        v16:Fire();
    end;
end;
function u1.SetOverrides(p17, p18) --[[ Line: 110 ]]
    p17.Overrides = p18;
    p17.SettingsCache = {};
    for _, v19 in p17.SettingsChangeEvents do
        v19:Fire();
    end;
end;
function u1.GetSettingsChangedSignal(p20, p21) --[[ Line: 124 ]]
    -- upvalues: l__TypedEvent__1 (copy)
    local v22 = string.lower(p21);
    if not p20.SettingsChangeEvents[v22] then
        p20.SettingsChangeEvents[v22] = l__TypedEvent__1.new();
    end;
    return p20.SettingsChangeEvents[v22];
end;
function u1.Destroy(p23) --[[ Line: 139 ]]
    for _, v24 in p23.SettingsChangeEvents do
        v24:Destroy();
    end;
    p23.SettingsChangeEvents = {};
end;
return u1;
