-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

require(script.Types);
local u1 = {};
local u2 = require(script.Internal)(u1);
u1.Disabled = false;
u1.Args = {};
u1.Events = {};
function u1.HasInit() --[[ Line: 12 ]]
    -- upvalues: u2 (copy)
    return u2._started;
end;
function u1.Init(p3, u4) --[[ Line: 16 ]]
    -- upvalues: u2 (copy), u1 (copy)
    if p3 == nil then
        p3 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
    end;
    if u4 == nil then
        u4 = game:GetService("RunService").Heartbeat;
    end;
    u2.parentInstance = p3;
    assert(u2._started == false, "Iris.Init can only be called once.");
    u2._started = true;
    u2._generateRootInstance();
    u2._generateSelectionImageObject();
    task.spawn(function() --[[ Line: 33 ]]
        -- upvalues: u4 (ref), u2 (ref)
        if typeof(u4) == "function" then
            while true do
                u4();
                u2._cycle();
            end;
        else
            if u4 ~= nil then
                u4:Connect(function() --[[ Line: 40 ]]
                    -- upvalues: u2 (ref)
                    u2._cycle();
                end);
            end;
        end;
    end);
    return u1;
end;
function u1.Connect(_, p5) --[[ Line: 49 ]]
    -- upvalues: u2 (copy)
    if u2._started == false then
        warn("Iris:Connect() was called before calling Iris.Init(), the connected function will never run");
    end;
    table.insert(u2._connectedFunctions, p5);
end;
function u1.Append(p6) --[[ Line: 56 ]]
    -- upvalues: u2 (copy)
    local v7 = u2._GetParentWidget();
    local v8;
    if u2._config.Parent then
        v8 = u2._config.Parent;
    else
        v8 = u2._widgets[v7.type].ChildAdded(v7, {
            type = "userInstance"
        });
    end;
    p6.Parent = v8;
end;
function u1.End() --[[ Line: 67 ]]
    -- upvalues: u2 (copy)
    if u2._stackIndex == 1 then
        error("Callback has too many calls to Iris.End()", 2);
    end;
    u2._IDStack[u2._stackIndex] = nil;
    local v9 = u2;
    v9._stackIndex = v9._stackIndex - 1;
end;
function u1.ForceRefresh() --[[ Line: 81 ]]
    -- upvalues: u2 (copy)
    u2._globalRefreshRequested = true;
end;
function u1.UpdateGlobalConfig(p10) --[[ Line: 85 ]]
    -- upvalues: u2 (copy), u1 (copy)
    for v11, v12 in p10 do
        u2._rootConfig[v11] = v12;
    end;
    u1.ForceRefresh();
end;
function u1.PushConfig(p13) --[[ Line: 92 ]]
    -- upvalues: u1 (copy), u2 (copy)
    local v14 = u1.State(-1);
    if v14.value == -1 then
        v14:set(p13);
    elseif u2._deepCompare(v14:get(), p13) == false then
        u2._localRefreshActive = true;
        v14:set(p13);
    end;
    u2._config = setmetatable(p13, {
        __index = u2._config
    });
end;
function u1.PopConfig() --[[ Line: 110 ]]
    -- upvalues: u2 (copy)
    u2._localRefreshActive = false;
    u2._config = getmetatable(u2._config).__index;
end;
u1.TemplateConfig = require(script.config);
u1.UpdateGlobalConfig(u1.TemplateConfig.colorDark);
u1.UpdateGlobalConfig(u1.TemplateConfig.sizeDefault);
u1.UpdateGlobalConfig(u1.TemplateConfig.utilityDefault);
u2._globalRefreshRequested = false;
function u1.PushId(p15) --[[ Line: 127 ]]
    -- upvalues: u2 (copy)
    local v16 = typeof(p15) == "string";
    assert(v16, "Iris expected Iris.PushId id to PushId to be a string.");
    u2._pushedId = tostring(p15);
end;
function u1.PopId() --[[ Line: 133 ]]
    -- upvalues: u2 (copy)
    u2._pushedId = nil;
end;
function u1.SetNextWidgetID(p17) --[[ Line: 137 ]]
    -- upvalues: u2 (copy)
    u2._nextWidgetId = p17;
end;
function u1.State(p18) --[[ Line: 147 ]]
    -- upvalues: u2 (copy)
    local v19 = u2._getID(2);
    if u2._states[v19] then
        return u2._states[v19];
    end;
    u2._states[v19] = {
        value = p18,
        ConnectedWidgets = {},
        ConnectedFunctions = {}
    };
    setmetatable(u2._states[v19], u2.StateClass);
    return u2._states[v19];
end;
function u1.WeakState(p20) --[[ Line: 161 ]]
    -- upvalues: u2 (copy)
    local v21 = u2._getID(2);
    if u2._states[v21] then
        if #u2._states[v21].ConnectedWidgets ~= 0 then
            return u2._states[v21];
        end;
        u2._states[v21] = nil;
    end;
    u2._states[v21] = {
        value = p20,
        ConnectedWidgets = {},
        ConnectedFunctions = {}
    };
    setmetatable(u2._states[v21], u2.StateClass);
    return u2._states[v21];
end;
function u1.ComputedState(p22, u23) --[[ Line: 179 ]]
    -- upvalues: u2 (copy)
    local u24 = u2._getID(2);
    if u2._states[u24] then
        return u2._states[u24];
    end;
    u2._states[u24] = {
        value = u23(p22.value),
        ConnectedWidgets = {},
        ConnectedFunctions = {}
    };
    p22:onChange(function(p25) --[[ Line: 190 ]]
        -- upvalues: u2 (ref), u24 (copy), u23 (copy)
        u2._states[u24]:set(u23(p25));
    end);
    setmetatable(u2._states[u24], u2.StateClass);
    return u2._states[u24];
end;
u1.ShowDemoWindow = require(script.demoWindow)(u1);
require(script.widgets)(u2);
require(script.API)(u1);
return u1;
