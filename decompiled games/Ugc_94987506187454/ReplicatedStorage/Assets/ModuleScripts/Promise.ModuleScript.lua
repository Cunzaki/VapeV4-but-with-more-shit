-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.Promise
-- Class: ModuleScript
-- Place: Ugc (94987506187454)

-- Decompiled with Potassium's decompiler.

local u1 = {
    __mode = "k"
};
local function v7(u2, p3) --[[ Line: 28 ]]
    local v4 = {};
    for _, v5 in ipairs(p3) do
        v4[v5] = v5;
    end;
    return setmetatable(v4, {
        __index = function(_, p6) --[[ Name: __index, Line 36 ]]
            -- upvalues: u2 (copy)
            error(string.format("%s is not in %s!", p6, u2), 2);
        end,
        __newindex = function() --[[ Name: __newindex, Line 39 ]]
            -- upvalues: u2 (copy)
            error(string.format("Creating new members in %s is not allowed!", u2), 2);
        end
    });
end;
local u8 = {
    Kind = v7("Promise.Error.Kind", {
        "ExecutionError",
        "AlreadyCancelled",
        "NotResolvedInTime",
        "TimedOut"
    })
};
u8.__index = u8;
function u8.new(p9, p10) --[[ Line: 64 ]]
    -- upvalues: u8 (ref)
    local v11 = p9 or {};
    local v12 = {
        error = tostring(v11.error) or "[This error has no error text.]",
        trace = v11.trace,
        context = v11.context,
        kind = v11.kind,
        parent = p10,
        createdTick = os.clock(),
        createdTrace = debug.traceback()
    };
    return setmetatable(v12, u8);
end;
function u8.is(p13) --[[ Line: 77 ]]
    if type(p13) == "table" then
        local v14 = getmetatable(p13);
        if type(v14) == "table" then
            local v15;
            if rawget(p13, "error") == nil then
                v15 = false;
            else
                local v16 = rawget(v14, "extend");
                v15 = type(v16) == "function";
            end;
            return v15;
        end;
    end;
    return false;
end;
function u8.isKind(p17, p18) --[[ Line: 89 ]]
    -- upvalues: u8 (ref)
    assert(p18 ~= nil, "Argument #2 to Promise.Error.isKind must not be nil");
    local v19 = u8.is(p17);
    if v19 then
        v19 = p17.kind == p18;
    end;
    return v19;
end;
function u8.extend(p20, p21) --[[ Line: 95 ]]
    -- upvalues: u8 (ref)
    local v22 = p21 or {};
    v22.kind = v22.kind or p20.kind;
    return u8.new(v22, p20);
end;
function u8.getErrorChain(p23) --[[ Line: 103 ]]
    local v24 = { p23 };
    while v24[#v24].parent do
        table.insert(v24, v24[#v24].parent);
    end;
    return v24;
end;
function u8.__tostring(p25) --[[ Line: 113 ]]
    local v26 = { string.format("-- Promise.Error(%s) --", p25.kind or "?") };
    for _, v27 in ipairs(p25:getErrorChain()) do
        table.insert(v26, table.concat({ v27.trace or v27.error, v27.context }, "\n"));
    end;
    return table.concat(v26, "\n");
end;
local function u28(...) --[[ Line: 137 ]]
    return select("#", ...), { ... };
end;
local function u30(p29, ...) --[[ Line: 144 ]]
    return p29, select("#", ...), { ... };
end;
local function u36(u31, p32, ...) --[[ Line: 171 ]]
    -- upvalues: u30 (copy), u8 (ref)
    local v33 = u30;
    local v34 = xpcall;
    assert(u31 ~= nil, "traceback is nil");
    return v33(v34(p32, function(p35) --[[ Line: 151 ]]
        -- upvalues: u8 (ref), u31 (copy)
        if type(p35) == "table" then
            return p35;
        else
            return u8.new({
                error = p35,
                kind = u8.Kind.ExecutionError,
                trace = debug.traceback(tostring(p35), 2),
                context = "Promise created at:\n\n" .. u31
            });
        end;
    end, ...));
end;
local u37 = {
    Error = u8,
    Status = v7("Promise.Status", {
        "Started",
        "Resolved",
        "Rejected",
        "Cancelled"
    }),
    _getTime = os.clock,
    _timeEvent = game:GetService("RunService").Heartbeat,
    _unhandledRejectionCallbacks = {},
    prototype = {}
};
u37.__index = u37.prototype;
function u37._new(p38, u39, p40) --[[ Line: 230 ]]
    -- upvalues: u37 (copy), u1 (copy), u36 (copy)
    if p40 ~= nil and not u37.is(p40) then
        error("Argument #2 to Promise.new must be a promise or nil", 2);
    end;
    local u41 = {
        _thread = nil,
        _values = nil,
        _valuesLength = -1,
        _unhandledRejection = true,
        _cancellationHook = nil,
        _source = p38,
        _status = u37.Status.Started,
        _queuedResolve = {},
        _queuedReject = {},
        _queuedFinally = {},
        _parent = p40,
        _consumers = setmetatable({}, u1)
    };
    if p40 and p40._status == u37.Status.Started then
        p40._consumers[u41] = true;
    end;
    setmetatable(u41, u37);
    local function u42(...) --[[ Line: 278 ]]
        -- upvalues: u41 (copy)
        u41:_resolve(...);
    end;
    local function u43(...) --[[ Line: 282 ]]
        -- upvalues: u41 (copy)
        u41:_reject(...);
    end;
    local function u45(p44) --[[ Line: 286 ]]
        -- upvalues: u41 (copy), u37 (ref)
        if p44 then
            if u41._status == u37.Status.Cancelled then
                p44();
            else
                u41._cancellationHook = p44;
            end;
        end;
        return u41._status == u37.Status.Cancelled;
    end;
    u41._thread = coroutine.create(function() --[[ Line: 298 ]]
        -- upvalues: u36 (ref), u41 (copy), u39 (copy), u42 (copy), u43 (copy), u45 (copy)
        local v46, _, v47 = u36(u41._source, u39, u42, u43, u45);
        if not v46 then
            u43(v47[1]);
        end;
    end);
    task.spawn(u41._thread);
    return u41;
end;
function u37.new(p48) --[[ Line: 349 ]]
    -- upvalues: u37 (copy)
    return u37._new(debug.traceback(nil, 2), p48);
end;
function u37.__tostring(p49) --[[ Line: 353 ]]
    return string.format("Promise(%s)", p49._status);
end;
function u37.defer(u50) --[[ Line: 375 ]]
    -- upvalues: u37 (copy), u36 (copy)
    local u51 = debug.traceback(nil, 2);
    return u37._new(u51, function(u52, u53, u54) --[[ Line: 378 ]]
        -- upvalues: u37 (ref), u36 (ref), u51 (copy), u50 (copy)
        local u55 = nil;
        u55 = u37._timeEvent:Connect(function() --[[ Line: 380 ]]
            -- upvalues: u55 (ref), u36 (ref), u51 (ref), u50 (ref), u52 (copy), u53 (copy), u54 (copy)
            u55:Disconnect();
            local v56, _, v57 = u36(u51, u50, u52, u53, u54);
            if not v56 then
                u53(v57[1]);
            end;
        end);
    end);
end;
u37.async = u37.defer;
function u37.resolve(...) --[[ Line: 418 ]]
    -- upvalues: u28 (copy), u37 (copy)
    local u58, u59 = u28(...);
    return u37._new(debug.traceback(nil, 2), function(p60) --[[ Line: 420 ]]
        -- upvalues: u59 (copy), u58 (copy)
        p60(unpack(u59, 1, u58));
    end);
end;
function u37.reject(...) --[[ Line: 435 ]]
    -- upvalues: u28 (copy), u37 (copy)
    local u61, u62 = u28(...);
    return u37._new(debug.traceback(nil, 2), function(_, p63) --[[ Line: 437 ]]
        -- upvalues: u62 (copy), u61 (copy)
        p63(unpack(u62, 1, u61));
    end);
end;
function u37._try(p64, u65, ...) --[[ Line: 446 ]]
    -- upvalues: u28 (copy), u37 (copy)
    local u66, u67 = u28(...);
    return u37._new(p64, function(p68) --[[ Line: 449 ]]
        -- upvalues: u65 (copy), u67 (copy), u66 (copy)
        p68(u65(unpack(u67, 1, u66)));
    end);
end;
function u37.try(p69, ...) --[[ Line: 477 ]]
    -- upvalues: u37 (copy)
    return u37._try(debug.traceback(nil, 2), p69, ...);
end;
function u37._all(p70, u71, u72) --[[ Line: 486 ]]
    -- upvalues: u37 (copy)
    if type(u71) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.all"), 3);
    end;
    for v73, v74 in pairs(u71) do
        if not u37.is(v74) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.all", (tostring(v73))), 3);
        end;
    end;
    if #u71 == 0 or u72 == 0 then
        return u37.resolve({});
    else
        return u37._new(p70, function(u75, u76, p77) --[[ Line: 504 ]]
            -- upvalues: u72 (copy), u71 (copy)
            local u78 = {};
            local u79 = {};
            local u80 = 0;
            local u81 = 0;
            local u82 = false;
            local function u85(p83, ...) --[[ Line: 522 ]]
                -- upvalues: u82 (ref), u80 (ref), u72 (ref), u78 (copy), u71 (ref), u75 (copy), u79 (copy)
                if u82 then
                else
                    u80 = u80 + 1;
                    if u72 == nil then
                        u78[p83] = ...;
                    else
                        u78[u80] = ...;
                    end;
                    if u80 >= (u72 or #u71) then
                        u82 = true;
                        u75(u78);
                        for _, v84 in ipairs(u79) do
                            v84:cancel();
                        end;
                    end;
                end;
            end;
            p77(function() --[[ Name: cancel, Line 515 ]]
                -- upvalues: u79 (copy)
                for _, v86 in ipairs(u79) do
                    v86:cancel();
                end;
            end);
            local u87 = u82;
            for u88, v89 in ipairs(u71) do
                u79[u88] = v89:andThen(function(...) --[[ Line: 547 ]]
                    -- upvalues: u85 (copy), u88 (copy)
                    u85(u88, ...);
                end, function(...) --[[ Line: 549 ]]
                    -- upvalues: u81 (ref), u72 (ref), u71 (ref), u79 (copy), u87 (ref), u76 (copy)
                    u81 = u81 + 1;
                    if u72 == nil or #u71 - u81 < u72 then
                        for _, v90 in ipairs(u79) do
                            v90:cancel();
                        end;
                        u87 = true;
                        u76(...);
                    end;
                end);
            end;
            if u87 then
                for _, v91 in ipairs(u79) do
                    v91:cancel();
                end;
            end;
        end);
    end;
end;
function u37.all(p92) --[[ Line: 591 ]]
    -- upvalues: u37 (copy)
    return u37._all(debug.traceback(nil, 2), p92);
end;
function u37.fold(p93, u94, p95) --[[ Line: 620 ]]
    -- upvalues: u37 (copy)
    local v96 = type(p93) == "table";
    assert(v96, "Bad argument #1 to Promise.fold: must be a table");
    local v97;
    if type(u94) == "function" then
        v97 = true;
    elseif type(u94) == "table" then
        local v98 = getmetatable(u94);
        if v98 then
            local v99 = rawget(v98, "__call");
            v97 = type(v99) == "function";
        else
            v97 = false;
        end;
    else
        v97 = false;
    end;
    assert(v97, "Bad argument #2 to Promise.fold: must be a function");
    local u100 = u37.resolve(p95);
    return u37.each(p93, function(u101, u102) --[[ Line: 625 ]]
        -- upvalues: u100 (ref), u94 (copy)
        u100 = u100:andThen(function(p103) --[[ Line: 626 ]]
            -- upvalues: u94 (ref), u101 (copy), u102 (copy)
            return u94(p103, u101, u102);
        end);
    end):andThen(function() --[[ Line: 629 ]]
        -- upvalues: u100 (ref)
        return u100;
    end);
end;
function u37.some(p104, p105) --[[ Line: 653 ]]
    -- upvalues: u37 (copy)
    local v106 = type(p105) == "number";
    assert(v106, "Bad argument #2 to Promise.some: must be a number");
    return u37._all(debug.traceback(nil, 2), p104, p105);
end;
function u37.any(p107) --[[ Line: 677 ]]
    -- upvalues: u37 (copy)
    return u37._all(debug.traceback(nil, 2), p107, 1):andThen(function(p108) --[[ Line: 678 ]]
        return p108[1];
    end);
end;
function u37.allSettled(u109) --[[ Line: 699 ]]
    -- upvalues: u37 (copy)
    if type(u109) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.allSettled"), 2);
    end;
    for v110, v111 in pairs(u109) do
        if not u37.is(v111) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.allSettled", (tostring(v110))), 2);
        end;
    end;
    if #u109 == 0 then
        return u37.resolve({});
    else
        return u37._new(debug.traceback(nil, 2), function(u112, _, p113) --[[ Line: 717 ]]
            -- upvalues: u109 (copy)
            local u114 = {};
            local u115 = {};
            local u116 = 0;
            local function u118(p117, ...) --[[ Line: 727 ]]
                -- upvalues: u116 (ref), u114 (copy), u109 (ref), u112 (copy)
                u116 = u116 + 1;
                u114[p117] = ...;
                if u116 >= #u109 then
                    u112(u114);
                end;
            end;
            p113(function() --[[ Line: 737 ]]
                -- upvalues: u115 (copy)
                for _, v119 in ipairs(u115) do
                    v119:cancel();
                end;
            end);
            for u120, v121 in ipairs(u109) do
                u115[u120] = v121:finally(function(...) --[[ Line: 746 ]]
                    -- upvalues: u118 (copy), u120 (copy)
                    u118(u120, ...);
                end);
            end;
        end);
    end;
end;
function u37.race(u122) --[[ Line: 777 ]]
    -- upvalues: u37 (copy)
    local v123 = type(u122) == "table";
    assert(v123, string.format("Please pass a list of promises to %s", "Promise.race"));
    for v124, v125 in pairs(u122) do
        local v126 = u37.is(v125);
        local l__format__1 = string.format;
        local v127 = tostring(v124);
        assert(v126, l__format__1("Non-promise value passed into %s at index %s", "Promise.race", v127));
    end;
    return u37._new(debug.traceback(nil, 2), function(u128, u129, p130) --[[ Line: 784 ]]
        -- upvalues: u122 (copy)
        local u131 = {};
        local u132 = false;
        if p130(function(...) --[[ Line: 795 ]]
            -- upvalues: u131 (copy), u132 (ref), u129 (copy)
            for _, v133 in ipairs(u131) do
                v133:cancel();
            end;
            u132 = true;
            return u129(...);
        end) then
        else
            local u134 = u132;
            for v135, v136 in ipairs(u122) do
                u131[v135] = v136:andThen(function(...) --[[ Line: 795 ]]
                    -- upvalues: u131 (copy), u134 (ref), u128 (copy)
                    for _, v137 in ipairs(u131) do
                        v137:cancel();
                    end;
                    u134 = true;
                    return u128(...);
                end, function(...) --[[ Line: 795 ]]
                    -- upvalues: u131 (copy), u134 (ref), u129 (copy)
                    for _, v138 in ipairs(u131) do
                        v138:cancel();
                    end;
                    u134 = true;
                    return u129(...);
                end);
            end;
            if u134 then
                for _, v139 in ipairs(u131) do
                    v139:cancel();
                end;
            end;
        end;
    end);
end;
function u37.each(u140, u141) --[[ Line: 872 ]]
    -- upvalues: u37 (copy), u8 (ref)
    local v142 = type(u140) == "table";
    assert(v142, string.format("Please pass a list of promises to %s", "Promise.each"));
    local v143;
    if type(u141) == "function" then
        v143 = true;
    elseif type(u141) == "table" then
        local v144 = getmetatable(u141);
        if v144 then
            local v145 = rawget(v144, "__call");
            v143 = type(v145) == "function";
        else
            v143 = false;
        end;
    else
        v143 = false;
    end;
    assert(v143, string.format("Please pass a handler function to %s!", "Promise.each"));
    return u37._new(debug.traceback(nil, 2), function(p146, p147, p148) --[[ Line: 876 ]]
        -- upvalues: u140 (copy), u37 (ref), u8 (ref), u141 (copy)
        local v149 = {};
        local u150 = {};
        local u151 = false;
        p148(function() --[[ Line: 888 ]]
            -- upvalues: u151 (ref), u150 (copy)
            u151 = true;
            for _, v152 in ipairs(u150) do
                v152:cancel();
            end;
        end);
        local v153 = u151;
        local v154 = {};
        for v155, v156 in ipairs(u140) do
            if u37.is(v156) then
                if v156:getStatus() == u37.Status.Cancelled then
                    for _, v157 in ipairs(u150) do
                        v157:cancel();
                    end;
                    return p147(u8.new({
                        error = "Promise is cancelled",
                        kind = u8.Kind.AlreadyCancelled,
                        context = string.format("The Promise that was part of the array at index %d passed into Promise.each was already cancelled when Promise.each began.\n\nThat Promise was created at:\n\n%s", v155, v156._source)
                    }));
                end;
                if v156:getStatus() == u37.Status.Rejected then
                    for _, v158 in ipairs(u150) do
                        v158:cancel();
                    end;
                    return p147(select(2, v156:await()));
                end;
                local v159 = v156:andThen(function(...) --[[ Line: 921 ]]
                    return ...;
                end);
                table.insert(u150, v159);
                v154[v155] = v159;
            else
                v154[v155] = v156;
            end;
        end;
        for v160, v163 in ipairs(v154) do
            if u37.is(v163) then
                local v162, v163 = v163:await();
                if not v162 then
                    for _, v164 in ipairs(u150) do
                        v164:cancel();
                    end;
                    return p147(v163);
                end;
            end;
            if v153 then
                return;
            end;
            local v165 = u37.resolve(u141(v163, v160));
            table.insert(u150, v165);
            local v166, v167 = v165:await();
            if not v166 then
                for _, v168 in ipairs(u150) do
                    v168:cancel();
                end;
                return p147(v167);
            end;
            v149[v160] = v167;
        end;
        p146(v149);
    end);
end;
function u37.is(p169) --[[ Line: 971 ]]
    -- upvalues: u37 (copy)
    if type(p169) ~= "table" then
        return false;
    end;
    local v170 = getmetatable(p169);
    if v170 == u37 then
        return true;
    end;
    if v170 ~= nil then
        if type(v170) == "table" then
            local v171 = rawget(v170, "__index");
            if type(v171) == "table" then
                local v172 = rawget(v170, "__index");
                local v173 = rawget(v172, "andThen");
                local v174;
                if type(v173) == "function" then
                    v174 = true;
                else
                    local v175 = type(v173) == "table" and getmetatable(v173);
                    if v175 then
                        local v176 = rawget(v175, "__call");
                        v174 = type(v176) == "function";
                    else
                        v174 = false;
                    end;
                end;
                if v174 then
                    return true;
                end;
            end;
        end;
        return false;
    end;
    local l__andThen__2 = p169.andThen;
    if type(l__andThen__2) == "function" then
        return true;
    end;
    local v177 = type(l__andThen__2) == "table" and getmetatable(l__andThen__2);
    if v177 then
        local v178 = rawget(v177, "__call");
        if type(v178) == "function" then
            return true;
        end;
    end;
    return false;
end;
function u37.promisify(u179) --[[ Line: 1020 ]]
    -- upvalues: u37 (copy)
    return function(...) --[[ Line: 1021 ]]
        -- upvalues: u37 (ref), u179 (copy)
        return u37._try(debug.traceback(nil, 2), u179, ...);
    end;
end;
local u180 = nil;
local u181 = nil;
function u37.delay(p182) --[[ Line: 1051 ]]
    -- upvalues: u37 (copy), u181 (ref), u180 (ref)
    local v183 = type(p182) == "number";
    assert(v183, "Bad argument #1 to Promise.delay, must be a number.");
    local u184 = (p182 < 0.016666666666666666 or p182 == (1 / 0)) and 0.016666666666666666 or p182;
    return u37._new(debug.traceback(nil, 2), function(p185, _, p186) --[[ Line: 1059 ]]
        -- upvalues: u37 (ref), u184 (ref), u181 (ref), u180 (ref)
        local v187 = u37._getTime();
        local v188 = v187 + u184;
        local u189 = {
            resolve = p185,
            startTime = v187,
            endTime = v188
        };
        if u181 == nil then
            u180 = u189;
            u181 = u37._timeEvent:Connect(function() --[[ Line: 1071 ]]
                -- upvalues: u37 (ref), u180 (ref), u181 (ref)
                local v190 = u37._getTime();
                while u180 ~= nil and u180.endTime < v190 do
                    local v191 = u180;
                    u180 = v191.next;
                    if u180 == nil then
                        u181:Disconnect();
                        u181 = nil;
                    else
                        u180.previous = nil;
                    end;
                    v191.resolve(u37._getTime() - v191.startTime);
                end;
            end);
        elseif u180.endTime < v188 then
            local v192 = u180;
            local l__next__3 = v192.next;
            while l__next__3 ~= nil and l__next__3.endTime < v188 do
                local l__next__4 = l__next__3.next;
                v192 = l__next__3;
                l__next__3 = l__next__4;
            end;
            v192.next = u189;
            u189.previous = v192;
            if l__next__3 ~= nil then
                u189.next = l__next__3;
                l__next__3.previous = u189;
            end;
        else
            u189.next = u180;
            u180.previous = u189;
            u180 = u189;
        end;
        p186(function() --[[ Line: 1116 ]]
            -- upvalues: u189 (copy), u180 (ref), u181 (ref)
            local l__next__5 = u189.next;
            if u180 == u189 then
                if l__next__5 == nil then
                    u181:Disconnect();
                    u181 = nil;
                else
                    l__next__5.previous = nil;
                end;
                u180 = l__next__5;
            else
                local l__previous__6 = u189.previous;
                l__previous__6.next = l__next__5;
                if l__next__5 ~= nil then
                    l__next__5.previous = l__previous__6;
                end;
            end;
        end);
    end);
end;
function u37.prototype.timeout(p193, u194, u195) --[[ Line: 1180 ]]
    -- upvalues: u37 (copy), u8 (ref)
    local u196 = debug.traceback(nil, 2);
    return u37.race({ u37.delay(u194):andThen(function() --[[ Line: 1184 ]]
            -- upvalues: u37 (ref), u195 (copy), u8 (ref), u194 (copy), u196 (copy)
            return u37.reject(u195 == nil and u8.new({
                error = "Timed out",
                kind = u8.Kind.TimedOut,
                context = string.format("Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s", u194, u196)
            }) or u195);
        end), p193 });
end;
function u37.prototype.getStatus(p197) --[[ Line: 1204 ]]
    return p197._status;
end;
function u37.prototype._andThen(u198, u199, u200, u201) --[[ Line: 1213 ]]
    -- upvalues: u37 (copy), u36 (copy)
    u198._unhandledRejection = false;
    if u198._status ~= u37.Status.Cancelled then
        return u37._new(u199, function(u202, u203, p204) --[[ Line: 1225 ]]
            -- upvalues: u200 (copy), u199 (copy), u36 (ref), u201 (copy), u198 (copy), u37 (ref)
            local u205;
            if u200 then
                local u206 = u199;
                local u207 = u200;
                u205 = function(...) --[[ Line: 180 ]]
                    -- upvalues: u36 (ref), u206 (copy), u207 (copy), u202 (copy), u203 (copy)
                    local v208, v209, v210 = u36(u206, u207, ...);
                    if v208 then
                        u202(unpack(v210, 1, v209));
                    else
                        u203(v210[1]);
                    end;
                end;
            else
                u205 = u202;
            end;
            if u201 then
                local u211 = u199;
                local u212 = u201;
                u203 = function(...) --[[ Line: 180 ]]
                    -- upvalues: u36 (ref), u211 (copy), u212 (copy), u202 (copy), u203 (copy)
                    local v213, v214, v215 = u36(u211, u212, ...);
                    if v213 then
                        u202(unpack(v215, 1, v214));
                    else
                        u203(v215[1]);
                    end;
                end;
            end;
            if u198._status == u37.Status.Started then
                table.insert(u198._queuedResolve, u205);
                table.insert(u198._queuedReject, u203);
                p204(function() --[[ Line: 1244 ]]
                    -- upvalues: u198 (ref), u37 (ref), u205 (ref), u203 (ref)
                    if u198._status == u37.Status.Started then
                        table.remove(u198._queuedResolve, table.find(u198._queuedResolve, u205));
                        table.remove(u198._queuedReject, table.find(u198._queuedReject, u203));
                    end;
                end);
            elseif u198._status == u37.Status.Resolved then
                u205(unpack(u198._values, 1, u198._valuesLength));
            elseif u198._status == u37.Status.Rejected then
                u203(unpack(u198._values, 1, u198._valuesLength));
            end;
        end, u198);
    end;
    local v216 = u37.new(function() --[[ Line: 1218 ]] end);
    v216:cancel();
    return v216;
end;
function u37.prototype.andThen(p217, p218, p219) --[[ Line: 1283 ]]
    local v220;
    if p218 == nil or type(p218) == "function" then
        v220 = true;
    elseif type(p218) == "table" then
        local v221 = getmetatable(p218);
        if v221 then
            local v222 = rawget(v221, "__call");
            v220 = type(v222) == "function";
        else
            v220 = false;
        end;
    else
        v220 = false;
    end;
    assert(v220, string.format("Please pass a handler function to %s!", "Promise:andThen"));
    local v223;
    if p219 == nil or type(p219) == "function" then
        v223 = true;
    elseif type(p219) == "table" then
        local v224 = getmetatable(p219);
        if v224 then
            local v225 = rawget(v224, "__call");
            v223 = type(v225) == "function";
        else
            v223 = false;
        end;
    else
        v223 = false;
    end;
    assert(v223, string.format("Please pass a handler function to %s!", "Promise:andThen"));
    return p217:_andThen(debug.traceback(nil, 2), p218, p219);
end;
function u37.prototype.catch(p226, p227) --[[ Line: 1310 ]]
    local v228;
    if p227 == nil or type(p227) == "function" then
        v228 = true;
    elseif type(p227) == "table" then
        local v229 = getmetatable(p227);
        if v229 then
            local v230 = rawget(v229, "__call");
            v228 = type(v230) == "function";
        else
            v228 = false;
        end;
    else
        v228 = false;
    end;
    assert(v228, string.format("Please pass a handler function to %s!", "Promise:catch"));
    return p226:_andThen(debug.traceback(nil, 2), nil, p227);
end;
function u37.prototype.tap(p231, u232) --[[ Line: 1331 ]]
    -- upvalues: u37 (copy), u28 (copy)
    local v233;
    if type(u232) == "function" then
        v233 = true;
    elseif type(u232) == "table" then
        local v234 = getmetatable(u232);
        if v234 then
            local v235 = rawget(v234, "__call");
            v233 = type(v235) == "function";
        else
            v233 = false;
        end;
    else
        v233 = false;
    end;
    assert(v233, string.format("Please pass a handler function to %s!", "Promise:tap"));
    return p231:_andThen(debug.traceback(nil, 2), function(...) --[[ Line: 1333 ]]
        -- upvalues: u232 (copy), u37 (ref), u28 (ref)
        local v236 = u232(...);
        if not u37.is(v236) then
            return ...;
        end;
        local u237, u238 = u28(...);
        return v236:andThen(function() --[[ Line: 1338 ]]
            -- upvalues: u238 (copy), u237 (copy)
            return unpack(u238, 1, u237);
        end);
    end);
end;
function u37.prototype.andThenCall(p239, u240, ...) --[[ Line: 1366 ]]
    -- upvalues: u28 (copy)
    local v241;
    if type(u240) == "function" then
        v241 = true;
    elseif type(u240) == "table" then
        local v242 = getmetatable(u240);
        if v242 then
            local v243 = rawget(v242, "__call");
            v241 = type(v243) == "function";
        else
            v241 = false;
        end;
    else
        v241 = false;
    end;
    assert(v241, string.format("Please pass a handler function to %s!", "Promise:andThenCall"));
    local u244, u245 = u28(...);
    return p239:_andThen(debug.traceback(nil, 2), function() --[[ Line: 1369 ]]
        -- upvalues: u240 (copy), u245 (copy), u244 (copy)
        return u240(unpack(u245, 1, u244));
    end);
end;
function u37.prototype.andThenReturn(p246, ...) --[[ Line: 1396 ]]
    -- upvalues: u28 (copy)
    local u247, u248 = u28(...);
    return p246:_andThen(debug.traceback(nil, 2), function() --[[ Line: 1398 ]]
        -- upvalues: u248 (copy), u247 (copy)
        return unpack(u248, 1, u247);
    end);
end;
function u37.prototype.cancel(p249) --[[ Line: 1414 ]]
    -- upvalues: u37 (copy)
    if p249._status == u37.Status.Started then
        p249._status = u37.Status.Cancelled;
        if p249._cancellationHook then
            p249._cancellationHook();
        end;
        coroutine.close(p249._thread);
        if p249._parent then
            p249._parent:_consumerCancelled(p249);
        end;
        for v250 in pairs(p249._consumers) do
            v250:cancel();
        end;
        p249:_finalize();
    end;
end;
function u37.prototype.Destroy(p251) --[[ Line: 1438 ]]
    -- upvalues: u37 (copy)
    if p251._status == u37.Status.Started then
        p251._status = u37.Status.Cancelled;
        if p251._cancellationHook then
            p251._cancellationHook();
        end;
        coroutine.close(p251._thread);
        if p251._parent then
            p251._parent:_consumerCancelled(p251);
        end;
        for v252 in pairs(p251._consumers) do
            v252:cancel();
        end;
        p251:_finalize();
    end;
end;
function u37.prototype._consumerCancelled(p253, p254) --[[ Line: 1466 ]]
    -- upvalues: u37 (copy)
    if p253._status == u37.Status.Started then
        p253._consumers[p254] = nil;
        if next(p253._consumers) == nil then
            p253:cancel();
        end;
    end;
end;
function u37.prototype._finally(u255, p256, u257) --[[ Line: 1482 ]]
    -- upvalues: u37 (copy)
    u255._unhandledRejection = false;
    return u37._new(p256, function(u258, u259, p260) --[[ Line: 1485 ]]
        -- upvalues: u255 (copy), u257 (copy), u37 (ref)
        local u261 = nil;
        p260(function() --[[ Line: 1488 ]]
            -- upvalues: u255 (ref), u261 (ref)
            u255:_consumerCancelled(u255);
            if u261 then
                u261:cancel();
            end;
        end);
        local v264 = u257 and function(...) --[[ Line: 1501 ]]
            -- upvalues: u257 (ref), u37 (ref), u261 (ref), u258 (copy), u255 (ref), u259 (copy)
            local v262 = u257(...);
            if u37.is(v262) then
                u261 = v262;
                v262:finally(function(p263) --[[ Line: 1508 ]]
                    -- upvalues: u37 (ref), u258 (ref), u255 (ref)
                    if p263 ~= u37.Status.Rejected then
                        u258(u255);
                    end;
                end):catch(function(...) --[[ Line: 1513 ]]
                    -- upvalues: u259 (ref)
                    u259(...);
                end);
            else
                u258(u255);
            end;
        end or u258;
        if u255._status == u37.Status.Started then
            table.insert(u255._queuedFinally, v264);
        else
            v264(u255._status);
        end;
    end);
end;
function u37.prototype.finally(p265, p266) --[[ Line: 1583 ]]
    local v267;
    if p266 == nil or type(p266) == "function" then
        v267 = true;
    elseif type(p266) == "table" then
        local v268 = getmetatable(p266);
        if v268 then
            local v269 = rawget(v268, "__call");
            v267 = type(v269) == "function";
        else
            v267 = false;
        end;
    else
        v267 = false;
    end;
    assert(v267, string.format("Please pass a handler function to %s!", "Promise:finally"));
    return p265:_finally(debug.traceback(nil, 2), p266);
end;
function u37.prototype.finallyCall(p270, u271, ...) --[[ Line: 1597 ]]
    -- upvalues: u28 (copy)
    local v272;
    if type(u271) == "function" then
        v272 = true;
    elseif type(u271) == "table" then
        local v273 = getmetatable(u271);
        if v273 then
            local v274 = rawget(v273, "__call");
            v272 = type(v274) == "function";
        else
            v272 = false;
        end;
    else
        v272 = false;
    end;
    assert(v272, string.format("Please pass a handler function to %s!", "Promise:finallyCall"));
    local u275, u276 = u28(...);
    return p270:_finally(debug.traceback(nil, 2), function() --[[ Line: 1600 ]]
        -- upvalues: u271 (copy), u276 (copy), u275 (copy)
        return u271(unpack(u276, 1, u275));
    end);
end;
function u37.prototype.finallyReturn(p277, ...) --[[ Line: 1623 ]]
    -- upvalues: u28 (copy)
    local u278, u279 = u28(...);
    return p277:_finally(debug.traceback(nil, 2), function() --[[ Line: 1625 ]]
        -- upvalues: u279 (copy), u278 (copy)
        return unpack(u279, 1, u278);
    end);
end;
function u37.prototype.awaitStatus(p280) --[[ Line: 1637 ]]
    -- upvalues: u37 (copy)
    p280._unhandledRejection = false;
    if p280._status == u37.Status.Started then
        local u281 = coroutine.running();
        p280:finally(function() --[[ Line: 1644 ]]
            -- upvalues: u281 (copy)
            task.spawn(u281);
        end):catch(function() --[[ Line: 1650 ]] end);
        coroutine.yield();
    end;
    if p280._status == u37.Status.Resolved then
        return p280._status, unpack(p280._values, 1, p280._valuesLength);
    elseif p280._status == u37.Status.Rejected then
        return p280._status, unpack(p280._values, 1, p280._valuesLength);
    else
        return p280._status;
    end;
end;
local function u283(p282, ...) --[[ Line: 1665 ]]
    -- upvalues: u37 (copy)
    return p282 == u37.Status.Resolved, ...;
end;
function u37.prototype.await(p284) --[[ Line: 1690 ]]
    -- upvalues: u283 (copy)
    return u283(p284:awaitStatus());
end;
local function u286(p285, ...) --[[ Line: 1694 ]]
    -- upvalues: u37 (copy)
    if p285 ~= u37.Status.Resolved then
        error(... == nil and "Expected Promise rejected with no value." or ..., 3);
    end;
    return ...;
end;
function u37.prototype.expect(p287) --[[ Line: 1727 ]]
    -- upvalues: u286 (copy)
    return u286(p287:awaitStatus());
end;
u37.prototype.awaitValue = u37.prototype.expect;
function u37.prototype._unwrap(p288) --[[ Line: 1741 ]]
    -- upvalues: u37 (copy)
    if p288._status == u37.Status.Started then
        error("Promise has not resolved or rejected.", 2);
    end;
    return p288._status == u37.Status.Resolved, unpack(p288._values, 1, p288._valuesLength);
end;
function u37.prototype._resolve(u289, ...) --[[ Line: 1751 ]]
    -- upvalues: u37 (copy), u8 (ref), u28 (copy)
    if u289._status == u37.Status.Started then
        if u37.is((...)) then
            if select("#", ...) > 1 then
                local v290 = string.format("When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s", u289._source);
                warn(v290);
            end;
            local u291 = ...;
            local v293 = u291:andThen(function(...) --[[ Line: 1772 ]]
                -- upvalues: u289 (copy)
                u289:_resolve(...);
            end, function(...) --[[ Line: 1774 ]]
                -- upvalues: u291 (copy), u8 (ref), u289 (copy)
                local v292 = u291._values[1];
                if u291._error then
                    v292 = u8.new({
                        context = "[No stack trace available as this Promise originated from an older version of the Promise library (< v2)]",
                        error = u291._error,
                        kind = u8.Kind.ExecutionError
                    });
                end;
                if u8.isKind(v292, u8.Kind.ExecutionError) then
                    return u289:_reject(v292:extend({
                        error = "This Promise was chained to a Promise that errored.",
                        trace = "",
                        context = string.format("The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n", u289._source)
                    }));
                end;
                u289:_reject(...);
            end);
            if v293._status == u37.Status.Cancelled then
                u289:cancel();
            else
                if v293._status == u37.Status.Started then
                    u289._parent = v293;
                    v293._consumers[u289] = true;
                end;
            end;
        else
            u289._status = u37.Status.Resolved;
            local v294, v295 = u28(...);
            u289._valuesLength = v294;
            u289._values = v295;
            for _, v296 in ipairs(u289._queuedResolve) do
                coroutine.wrap(v296)(...);
            end;
            u289:_finalize();
        end;
    else
        if u37.is((...)) then
            (...):_consumerCancelled(u289);
        end;
    end;
end;
function u37.prototype._reject(u297, ...) --[[ Line: 1822 ]]
    -- upvalues: u37 (copy), u28 (copy)
    if u297._status == u37.Status.Started then
        u297._status = u37.Status.Rejected;
        local v298, v299 = u28(...);
        u297._valuesLength = v298;
        u297._values = v299;
        if next(u297._queuedReject) == nil then
            local u300 = tostring((...));
            coroutine.wrap(function() --[[ Line: 1844 ]]
                -- upvalues: u37 (ref), u297 (copy), u300 (copy)
                u37._timeEvent:Wait();
                if u297._unhandledRejection then
                    local v301 = string.format("Unhandled Promise rejection:\n\n%s\n\n%s", u300, u297._source);
                    for _, v302 in ipairs(u37._unhandledRejectionCallbacks) do
                        task.spawn(v302, u297, unpack(u297._values, 1, u297._valuesLength));
                    end;
                    if u37.TEST then
                    else
                        warn(v301);
                    end;
                end;
            end)();
        else
            for _, v303 in ipairs(u297._queuedReject) do
                coroutine.wrap(v303)(...);
            end;
        end;
        u297:_finalize();
    end;
end;
function u37.prototype._finalize(p304) --[[ Line: 1876 ]]
    -- upvalues: u37 (copy)
    for _, v305 in ipairs(p304._queuedFinally) do
        coroutine.wrap(v305)(p304._status);
    end;
    p304._queuedFinally = nil;
    p304._queuedReject = nil;
    p304._queuedResolve = nil;
    if not u37.TEST then
        p304._parent = nil;
        p304._consumers = nil;
    end;
    task.defer(coroutine.close, p304._thread);
end;
function u37.prototype.now(p306, p307) --[[ Line: 1913 ]]
    -- upvalues: u37 (copy), u8 (ref)
    local v308 = debug.traceback(nil, 2);
    if p306._status == u37.Status.Resolved then
        return p306:_andThen(v308, function(...) --[[ Line: 1916 ]]
            return ...;
        end);
    end;
    local l__reject__7 = u37.reject;
    if p307 == nil then
        p307 = u8.new({
            error = "This Promise was not resolved in time for :now()",
            kind = u8.Kind.NotResolvedInTime,
            context = ":now() was called at:\n\n" .. v308
        }) or p307;
    end;
    return l__reject__7(p307);
end;
function u37.retry(u309, u310, ...) --[[ Line: 1958 ]]
    -- upvalues: u37 (copy)
    local v311;
    if type(u309) == "function" then
        v311 = true;
    elseif type(u309) == "table" then
        local v312 = getmetatable(u309);
        if v312 then
            local v313 = rawget(v312, "__call");
            v311 = type(v313) == "function";
        else
            v311 = false;
        end;
    else
        v311 = false;
    end;
    assert(v311, "Parameter #1 to Promise.retry must be a function");
    local v314 = type(u310) == "number";
    assert(v314, "Parameter #2 to Promise.retry must be a number");
    local u315 = { ... };
    local u316 = select("#", ...);
    return u37.resolve(u309(...)):catch(function(...) --[[ Line: 1964 ]]
        -- upvalues: u310 (copy), u37 (ref), u309 (copy), u315 (copy), u316 (copy)
        if u310 > 0 then
            return u37.retry(u309, u310 - 1, unpack(u315, 1, u316));
        else
            return u37.reject(...);
        end;
    end);
end;
function u37.retryWithDelay(u317, u318, u319, ...) --[[ Line: 1986 ]]
    -- upvalues: u37 (copy)
    local v320;
    if type(u317) == "function" then
        v320 = true;
    elseif type(u317) == "table" then
        local v321 = getmetatable(u317);
        if v321 then
            local v322 = rawget(v321, "__call");
            v320 = type(v322) == "function";
        else
            v320 = false;
        end;
    else
        v320 = false;
    end;
    assert(v320, "Parameter #1 to Promise.retry must be a function");
    local v323 = type(u318) == "number";
    assert(v323, "Parameter #2 (times) to Promise.retry must be a number");
    local v324 = type(u319) == "number";
    assert(v324, "Parameter #3 (seconds) to Promise.retry must be a number");
    local u325 = { ... };
    local u326 = select("#", ...);
    return u37.resolve(u317(...)):catch(function(...) --[[ Line: 1993 ]]
        -- upvalues: u318 (copy), u37 (ref), u319 (copy), u317 (copy), u325 (copy), u326 (copy)
        if u318 <= 0 then
            return u37.reject(...);
        end;
        u37.delay(u319):await();
        return u37.retryWithDelay(u317, u318 - 1, u319, unpack(u325, 1, u326));
    end);
end;
function u37.fromEvent(u327, p328) --[[ Line: 2028 ]]
    -- upvalues: u37 (copy)
    local u329 = p328 or function() --[[ Line: 2029 ]]
        return true;
    end;
    return u37._new(debug.traceback(nil, 2), function(u330, _, p331) --[[ Line: 2033 ]]
        -- upvalues: u327 (copy), u329 (ref)
        local u332 = nil;
        local u333 = false;
        local function v334() --[[ Line: 2037 ]]
            -- upvalues: u332 (ref)
            u332:Disconnect();
            u332 = nil;
        end;
        u332 = u327:Connect(function(...) --[[ Line: 2046 ]]
            -- upvalues: u329 (ref), u330 (copy), u332 (ref), u333 (ref)
            local v335 = u329(...);
            if v335 == true then
                u330(...);
                if u332 then
                    u332:Disconnect();
                    u332 = nil;
                else
                    u333 = true;
                end;
            else
                if type(v335) ~= "boolean" then
                    error("Promise.fromEvent predicate should always return a boolean");
                end;
            end;
        end);
        if u333 and u332 then
            return v334();
        end;
        p331(v334);
    end);
end;
function u37.onUnhandledRejection(u336) --[[ Line: 2080 ]]
    -- upvalues: u37 (copy)
    table.insert(u37._unhandledRejectionCallbacks, u336);
    return function() --[[ Line: 2083 ]]
        -- upvalues: u37 (ref), u336 (copy)
        local v337 = table.find(u37._unhandledRejectionCallbacks, u336);
        if v337 then
            table.remove(u37._unhandledRejectionCallbacks, v337);
        end;
    end;
end;
return u37;
