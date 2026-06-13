-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.Internal
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);
return function(u1) --[[ Line: 3 ]]
    local u2 = {
        _started = false,
        _cycleTick = 0,
        _globalRefreshRequested = false,
        _localRefreshActive = false,
        _widgets = {},
        _widgetCount = 0,
        _stackIndex = 1,
        _rootInstance = nil
    };
    u2._rootWidget = {
        ID = "R",
        type = "Root",
        ZIndex = 0,
        Instance = u2._rootInstance
    };
    u2._lastWidget = u2._rootWidget;
    u2._rootConfig = {};
    u2._config = u2._rootConfig;
    u2._IDStack = { "R" };
    u2._usedIDs = {};
    u2._pushedId = nil;
    u2._nextWidgetId = nil;
    u2._states = {};
    u2._postCycleCallbacks = {};
    u2._connectedFunctions = {};
    u2._cycleCoroutine = coroutine.create(function() --[[ Line: 49 ]]
        -- upvalues: u2 (copy)
        while true do
            for _, v3 in u2._connectedFunctions do
                local v4, v5 = pcall(v3);
                if not v4 then
                    u2._stackIndex = 1;
                    coroutine.yield(false, v5);
                end;
                if u2._stackIndex ~= 1 then
                    u2._stackIndex = 1;
                    error("Callback has too few calls to Iris.End()", 0);
                end;
            end;
            coroutine.yield(true);
        end;
    end);
    local v6 = {};
    v6.__index = v6;
    function v6.get(p7) --[[ Line: 80 ]]
        return p7.value;
    end;
    function v6.set(p8, p9) --[[ Line: 84 ]]
        -- upvalues: u2 (copy)
        if p9 == p8.value then
            return p8.value;
        end;
        p8.value = p9;
        for _, v10 in p8.ConnectedWidgets do
            u2._widgets[v10.type].UpdateState(v10);
        end;
        for _, v11 in p8.ConnectedFunctions do
            v11(p9);
        end;
        return p8.value;
    end;
    function v6.onChange(p12, p13) --[[ Line: 99 ]]
        table.insert(p12.ConnectedFunctions, p13);
    end;
    u2.StateClass = v6;
    function u2._cycle() --[[ Line: 111 ]]
        -- upvalues: u1 (copy), u2 (copy)
        if u1.Disabled then
        else
            u2._rootWidget.lastCycleTick = u2._cycleTick;
            if u2._rootInstance == nil or u2._rootInstance.Parent == nil then
                u1.ForceRefresh();
            end;
            for _, v14 in u2._lastVDOM do
                if v14.lastCycleTick ~= u2._cycleTick then
                    u2._DiscardWidget(v14);
                end;
            end;
            u2._lastVDOM = u2._VDOM;
            u2._VDOM = u2._generateEmptyVDOM();
            task.spawn(function() --[[ Line: 135 ]]
                -- upvalues: u2 (ref)
                for _, v15 in u2._postCycleCallbacks do
                    v15();
                end;
            end);
            if u2._globalRefreshRequested then
                u2._generateSelectionImageObject();
                u2._globalRefreshRequested = false;
                for _, v16 in u2._lastVDOM do
                    u2._DiscardWidget(v16);
                end;
                u2._generateRootInstance();
                u2._lastVDOM = u2._generateEmptyVDOM();
            end;
            local v17 = u2;
            v17._cycleTick = v17._cycleTick + 1;
            u2._widgetCount = 0;
            table.clear(u2._usedIDs);
            if u2.parentInstance:IsA("GuiBase2d") and math.min(u2.parentInstance.AbsoluteSize.X, u2.parentInstance.AbsoluteSize.Y) < 100 then
                error("Iris Parent Instance is too small");
            end;
            if (u2.parentInstance:IsA("GuiBase2d") or u2.parentInstance:IsA("CoreGui") or (u2.parentInstance:IsA("PluginGui") or u2.parentInstance:IsA("PlayerGui"))) == false then
                error("Iris Parent Instance cant contain GUI");
            end;
            if game:GetService("RunService"):IsStudio() then
                for _, v18 in u2._connectedFunctions do
                    v18();
                end;
            else
                local v19 = coroutine.status(u2._cycleCoroutine);
                if v19 == "suspended" then
                    local _, v20, v21 = coroutine.resume(u2._cycleCoroutine);
                    if v20 == false then
                        error(v21, 0);
                    end;
                else
                    if v19 == "running" then
                        error("Iris cycleCoroutine took to long to yield. Connected functions should not yield.");
                        return;
                    end;
                    error("unrecoverable state");
                end;
            end;
        end;
    end;
    function u2._NoOp() --[[ Line: 206 ]] end;
    function u2.WidgetConstructor(p22, p23) --[[ Line: 210 ]]
        -- upvalues: u2 (copy), u1 (copy)
        local v24 = {
            All = {
                Required = {
                    "Generate",
                    "Discard",
                    "Update",
                    "Args",
                    "Events",
                    "hasChildren",
                    "hasState"
                },
                Optional = {}
            },
            IfState = {
                Required = { "GenerateState", "UpdateState" },
                Optional = {}
            },
            IfChildren = {
                Required = { "ChildAdded" },
                Optional = { "ChildDiscarded" }
            }
        };
        local v25 = {};
        for _, v26 in v24.All.Required do
            local v27 = p23[v26] ~= nil;
            local v28 = `field {v26} is missing from widget {p22}, it is required for all widgets`;
            assert(v27, v28);
            v25[v26] = p23[v26];
        end;
        for _, v29 in v24.All.Optional do
            if p23[v29] == nil then
                v25[v29] = u2._NoOp;
            else
                v25[v29] = p23[v29];
            end;
        end;
        if p23.hasState then
            for _, v30 in v24.IfState.Required do
                local v31 = p23[v30] ~= nil;
                local v32 = `field {v30} is missing from widget {p22}, it is required for all widgets with state`;
                assert(v31, v32);
                v25[v30] = p23[v30];
            end;
            for _, v33 in v24.IfState.Optional do
                if p23[v33] == nil then
                    v25[v33] = u2._NoOp;
                else
                    v25[v33] = p23[v33];
                end;
            end;
        end;
        if p23.hasChildren then
            for _, v34 in v24.IfChildren.Required do
                local v35 = p23[v34] ~= nil;
                local v36 = `field {v34} is missing from widget {p22}, it is required for all widgets with children`;
                assert(v35, v36);
                v25[v34] = p23[v34];
            end;
            for _, v37 in v24.IfChildren.Optional do
                if p23[v37] == nil then
                    v25[v37] = u2._NoOp;
                else
                    v25[v37] = p23[v37];
                end;
            end;
        end;
        u2._widgets[p22] = v25;
        u1.Args[p22] = v25.Args;
        local v38 = {};
        for v39, v40 in v25.Args do
            v38[v40] = v39;
        end;
        v25.ArgNames = v38;
        for u41, _ in v25.Events do
            if u1.Events[u41] == nil then
                u1.Events[u41] = function() --[[ Line: 301 ]]
                    -- upvalues: u2 (ref), u41 (copy)
                    return u2._EventCall(u2._lastWidget, u41);
                end;
            end;
        end;
    end;
    function u2._Insert(p42, p43, p44) --[[ Line: 308 ]]
        -- upvalues: u2 (copy)
        local v45 = nil;
        local v46 = u2._getID(3);
        local v47 = u2._widgets[p42];
        local v48 = u2;
        v48._widgetCount = v48._widgetCount + 1;
        if u2._VDOM[v46] then
            return u2._ContinueWidget(v46, p42);
        end;
        local v49 = {};
        if p43 ~= nil then
            for v50, v51 in type(p43) ~= "table" and { p43 } or p43 do
                v49[v47.ArgNames[v50]] = v51;
            end;
        end;
        table.freeze(v49);
        if u2._lastVDOM[v46] and p42 == u2._lastVDOM[v46].type then
            if u2._localRefreshActive then
                u2._DiscardWidget(u2._lastVDOM[v46]);
            else
                v45 = u2._lastVDOM[v46];
            end;
        end;
        if v45 == nil then
            v45 = u2._GenNewWidget(p42, v49, p44, v46);
        end;
        if u2._deepCompare(v45.providedArguments, v49) == false then
            v45.arguments = u2._deepCopy(v49);
            v45.providedArguments = v49;
            v47.Update(v45);
        end;
        v45.lastCycleTick = u2._cycleTick;
        if v47.hasChildren then
            local v52 = u2;
            v52._stackIndex = v52._stackIndex + 1;
            u2._IDStack[u2._stackIndex] = v45.ID;
        end;
        u2._VDOM[v46] = v45;
        u2._lastWidget = v45;
        return v45;
    end;
    function u2._GenNewWidget(p53, p54, p55, p56) --[[ Line: 375 ]]
        -- upvalues: u2 (copy)
        local v57 = u2._IDStack[u2._stackIndex];
        local v58 = u2._widgets[p53];
        local u59 = {};
        setmetatable(u59, u59);
        u59.ID = p56;
        u59.type = p53;
        u59.parentWidget = u2._VDOM[v57];
        u59.trackedEvents = {};
        u59.ZIndex = u59.parentWidget.ZIndex + u2._widgetCount * 64 + u2._config.ZIndexOffset;
        u59.Instance = v58.Generate(u59);
        local l__Instance__1 = u59.Instance;
        local v60;
        if u2._config.Parent then
            v60 = u2._config.Parent;
        else
            v60 = u2._widgets[u59.parentWidget.type].ChildAdded(u59.parentWidget, u59);
        end;
        l__Instance__1.Parent = v60;
        u59.providedArguments = p54;
        u59.arguments = u2._deepCopy(p54);
        v58.Update(u59);
        local v61;
        if v58.hasState then
            if p55 then
                for v62, v63 in p55 do
                    if type(v63) ~= "table" or getmetatable(v63) ~= u2.StateClass then
                        p55[v62] = u2._widgetState(u59, v62, v63);
                    end;
                end;
                u59.state = p55;
                for _, v64 in p55 do
                    v64.ConnectedWidgets[u59.ID] = u59;
                end;
            else
                u59.state = {};
            end;
            v58.GenerateState(u59);
            v58.UpdateState(u59);
            u59.stateMT = {};
            setmetatable(u59.state, u59.stateMT);
            u59.__index = u59.state;
            v61 = u59.stateMT;
        else
            v61 = u59;
        end;
        function v61.__index(_, u65) --[[ Line: 432 ]]
            -- upvalues: u2 (ref), u59 (copy)
            return function() --[[ Line: 433 ]]
                -- upvalues: u2 (ref), u59 (ref), u65 (copy)
                return u2._EventCall(u59, u65);
            end;
        end;
        return u59;
    end;
    function u2._ContinueWidget(p66, p67) --[[ Line: 440 ]]
        -- upvalues: u2 (copy)
        local v68 = u2._widgets[p67];
        local v69 = u2._VDOM[p66];
        if v68.hasChildren then
            local v70 = u2;
            v70._stackIndex = v70._stackIndex + 1;
            u2._IDStack[u2._stackIndex] = v69.ID;
        end;
        u2._lastWidget = v69;
        return v69;
    end;
    function u2._DiscardWidget(p71) --[[ Line: 454 ]]
        -- upvalues: u2 (copy)
        local l__parentWidget__2 = p71.parentWidget;
        if l__parentWidget__2 then
            u2._widgets[l__parentWidget__2.type].ChildDiscarded(l__parentWidget__2, p71);
        end;
        u2._widgets[p71.type].Discard(p71);
    end;
    function u2._widgetState(p72, p73, p74) --[[ Line: 465 ]]
        -- upvalues: u2 (copy)
        local v75 = p72.ID .. p73;
        if u2._states[v75] then
            u2._states[v75].ConnectedWidgets[p72.ID] = p72;
            return u2._states[v75];
        end;
        u2._states[v75] = {
            value = p74,
            ConnectedWidgets = {
                [p72.ID] = p72
            },
            ConnectedFunctions = {}
        };
        setmetatable(u2._states[v75], u2.StateClass);
        return u2._states[v75];
    end;
    function u2._EventCall(p76, p77) --[[ Line: 481 ]]
        -- upvalues: u2 (copy)
        local v78 = u2._widgets[p76.type].Events[p77];
        local v79 = v78 ~= nil;
        local v80 = `widget {p76.type} has no event of name {p77}`;
        assert(v79, v80);
        if p76.trackedEvents[p77] == nil then
            v78.Init(p76);
            p76.trackedEvents[p77] = true;
        end;
        return v78.Get(p76);
    end;
    function u2._GetParentWidget() --[[ Line: 493 ]]
        -- upvalues: u2 (copy)
        return u2._VDOM[u2._IDStack[u2._stackIndex]];
    end;
    function u2._generateEmptyVDOM() --[[ Line: 499 ]]
        -- upvalues: u2 (copy)
        return {
            R = u2._rootWidget
        };
    end;
    function u2._generateRootInstance() --[[ Line: 505 ]]
        -- upvalues: u2 (copy)
        u2._rootInstance = u2._widgets.Root.Generate(u2._widgets.Root);
        u2._rootInstance.Parent = u2.parentInstance;
        u2._rootWidget.Instance = u2._rootInstance;
    end;
    function u2._generateSelectionImageObject() --[[ Line: 512 ]]
        -- upvalues: u2 (copy)
        if u2.SelectionImageObject then
            u2.SelectionImageObject:Destroy();
        end;
        local v81 = Instance.new("Frame");
        v81.Position = UDim2.fromOffset(-1, -1);
        v81.Size = UDim2.new(1, 2, 1, 2);
        v81.BackgroundColor3 = u2._config.SelectionImageObjectColor;
        v81.BackgroundTransparency = u2._config.SelectionImageObjectTransparency;
        v81.BorderSizePixel = 0;
        local v82 = Instance.new("UIStroke");
        v82.Thickness = 1;
        v82.Color = u2._config.SelectionImageObjectBorderColor;
        v82.Transparency = u2._config.SelectionImageObjectBorderTransparency;
        v82.LineJoinMode = Enum.LineJoinMode.Round;
        v82.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        v82.Parent = v81;
        local v83 = Instance.new("UICorner");
        v83.CornerRadius = UDim.new(0, 2);
        v83.Parent = v81;
        u2.SelectionImageObject = v81;
    end;
    function u2._getID(p84) --[[ Line: 543 ]]
        -- upvalues: u2 (copy)
        if u2._nextWidgetId then
            local l___nextWidgetId__3 = u2._nextWidgetId;
            u2._nextWidgetId = nil;
            return l___nextWidgetId__3;
        end;
        local v85 = 1 + (p84 or 1);
        local v86 = debug.info(v85, "l");
        local v87 = "";
        while v86 ~= -1 and v86 ~= nil do
            v87 = v87 .. "+" .. v86;
            v85 = v85 + 1;
            v86 = debug.info(v85, "l");
        end;
        if u2._usedIDs[v87] then
            local l___usedIDs__4 = u2._usedIDs;
            l___usedIDs__4[v87] = l___usedIDs__4[v87] + 1;
        else
            u2._usedIDs[v87] = 1;
        end;
        local v88;
        if u2._pushedId then
            v88 = u2._pushedId;
        else
            v88 = u2._usedIDs[v87];
        end;
        return v87 .. ":" .. v88;
    end;
    function u2._deepCompare(p89, p90) --[[ Line: 570 ]]
        -- upvalues: u2 (copy)
        for v91, v92 in p89 do
            local v93 = p90[v91];
            if type(v92) == "table" then
                if not v93 or type(v93) ~= "table" then
                    return false;
                end;
                if u2._deepCompare(v92, v93) == false then
                    return false;
                end;
            elseif type(v92) ~= type(v93) or v92 ~= v93 then
                return false;
            end;
        end;
        return true;
    end;
    function u2._deepCopy(p94) --[[ Line: 592 ]]
        -- upvalues: u2 (copy)
        local v95 = {};
        for v96, v98 in pairs(p94) do
            if type(v98) == "table" then
                local v98 = u2._deepCopy(v98);
            end;
            v95[v96] = v98;
        end;
        return v95;
    end;
    u2._lastVDOM = u2._generateEmptyVDOM();
    u2._VDOM = u2._generateEmptyVDOM();
    u1.Internal = u2;
    u1._config = u2._config;
    return u2;
end;
