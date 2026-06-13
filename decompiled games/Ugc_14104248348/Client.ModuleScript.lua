-- Decompiled from: Client
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = table.freeze({
    "Variables",
    "Functions",
    "Core",
    "Remote",
    "UI",
    "Process",
    "Anti"
});
local v2 = _G;
local v3 = game;
local u4 = script;
local u5 = getfenv;
local u6 = setfenv;
local v7 = workspace;
local u8 = getmetatable;
local u9 = setmetatable;
local v10 = loadstring;
local u11 = coroutine;
local u12 = rawequal;
local v13 = typeof;
local v14 = print;
local v15 = math;
local v16 = warn;
local v17 = error;
local u18 = pcall;
local v19 = xpcall;
local v20 = select;
local v21 = rawset;
local v22 = rawget;
local u23 = ipairs;
local v24 = pairs;
local v25 = next;
local v26 = Rect;
local v27 = Axes;
local v28 = os;
local v29 = time;
local v30 = Faces;
local l__unpack__1 = table.unpack;
local v31 = string;
local v32 = Color3;
local v33 = newproxy;
local u34 = tostring;
local v35 = tonumber;
local v36 = Instance;
local v37 = TweenInfo;
local v38 = BrickColor;
local v39 = NumberRange;
local v40 = ColorSequence;
local v41 = NumberSequence;
local v42 = ColorSequenceKeypoint;
local v43 = NumberSequenceKeypoint;
local v44 = PhysicalProperties;
local v45 = Region3int16;
local v46 = Vector3int16;
local u47 = require;
local u48 = table;
local u49 = type;
local l__wait__2 = task.wait;
local v50 = Enum;
local v51 = UDim;
local v52 = UDim2;
local v53 = Vector2;
local v54 = Vector3;
local v55 = Region3;
local v56 = CFrame;
local v57 = Ray;
local l__defer__3 = task.defer;
local l__delay__4 = task.delay;
local u58 = task;
local function u61(p59, p60) --[[ Line: 48 ]]
    return p59 or error(p60 or "assertion failed!", 2);
end;
local u62 = debug;
local v63 = tick;
local u64 = u48.freeze({
    "Workspace",
    "Players",
    "Lighting",
    "ReplicatedStorage",
    "ReplicatedFirst",
    "ScriptContext",
    "JointsService",
    "LogService",
    "Teams",
    "SoundService",
    "StarterGui",
    "StarterPack",
    "StarterPlayer",
    "GroupService",
    "MarketplaceService",
    "HttpService",
    "TestService",
    "RunService",
    "NetworkClient"
});
local u65 = v14;
local function u66(...) --[[ Line: 73 ]]
    -- upvalues: u65 (copy)
    u65(":: Adonis ::", ...);
end;
local u67 = v16;
local function u68(...) --[[ Line: 78 ]]
    -- upvalues: u67 (copy)
    u67(":: Adonis ::", ...);
end;
local u69 = {};
local function u71() --[[ Line: 84 ]]
    -- upvalues: u66 (ref), u69 (copy)
    u66("Dumping client log...");
    for _, v70 in u69 do
        u66(v70);
    end;
end;
local function u72(...) --[[ Line: 91 ]]
    -- upvalues: u48 (ref), u69 (copy)
    u48.insert(u69, u48.concat({ ... }, " "));
end;
local l__Parent__5 = u4.Parent;
local u73 = v3:GetService("RunService"):IsStudio();
v3:GetService("NetworkClient").ChildRemoved:Connect(function(_) --[[ Line: 98 ]]
    -- upvalues: u73 (copy), l__Parent__5 (ref), u66 (ref), u71 (copy)
    if not u73 or l__Parent__5:FindFirstChild("ADONIS_DEBUGMODE_ENABLED") then
        u66("~! PLAYER DISCONNECTED/KICKED! DUMPING ADONIS CLIENT LOG!");
        u71();
    end;
end);
local u74 = {};
local u75 = u5();
u6(1, (u9({}, {
    __metatable = u74
})));
v29();
local l__new__6 = v36.new;
local l__fromExisting__7 = v36.fromExisting;
local u76 = u47;
local u77 = {};
local u78 = {};
local u79 = {};
local u80 = {};
local function u83(p81) --[[ Line: 117 ]]
    -- upvalues: u78 (ref), u12 (ref)
    for _, v82 in u78.Modules do
        if u12(p81, v82) then
            return true;
        end;
    end;
    return false;
end;
local function u84(...) --[[ Line: 126 ]]
    -- upvalues: u68 (ref), u48 (ref), u69 (copy), u78 (ref)
    u68("ERROR: ", ...);
    u48.insert(u69, u48.concat({ "ERROR:", ... }, " "));
    if u78 and u78.Remote then
        u78.Remote.Send("LogError", u48.concat({ ... }, " "));
    end;
end;
local function u88(p85, ...) --[[ Line: 135 ]]
    -- upvalues: u18 (copy), u84 (copy), u34 (copy)
    local v86, v87 = u18(p85, ...);
    if not v86 and v87 then
        u84((u34(v87)));
    end;
    return v86, v87;
end;
local function u90(p89, ...) --[[ Line: 146 ]]
    -- upvalues: u11 (ref)
    return u11.resume(u11.create(p89), ...);
end;
local function v92(...) --[[ Line: 150 ]]
    -- upvalues: u11 (ref)
    local v91 = u11.wrap(function(...) --[[ Line: 151 ]]
        -- upvalues: u11 (ref)
        while true do
            u11.yield(...);
        end;
    end);
    v91(...);
    return v91;
end;
local u93 = nil;
local u94 = nil;
local u95 = nil;
local u97 = v92(function(u96) --[[ Line: 163 ]]
    -- upvalues: u49 (copy), u58 (ref), u18 (copy), u94 (ref), u93 (ref), u95 (ref), u79 (ref), u73 (copy), u78 (ref), u48 (ref)
    if u49(u96) == "string" then
        u58.spawn(u18, function() --[[ Line: 166 ]]
            -- upvalues: u94 (ref), u96 (copy), u93 (ref)
            if u94 then
                u94("kick", u96);
            else
                if u93 then
                    u93("BadMemes", u96);
                end;
            end;
        end);
    end;
    u58.spawn(u18, function() --[[ Line: 175 ]]
        -- upvalues: u58 (ref), u18 (ref), u95 (ref), u79 (ref), u96 (copy)
        u58.wait(1);
        u58.spawn(u18, u95, u79.Player, u96);
        u79.Player:Kick(u96);
    end);
    if not u73 then
        u58.spawn(u18, function() --[[ Line: 182 ]]
            -- upvalues: u58 (ref), u18 (ref), u78 (ref), u48 (ref)
            u58.wait(5);
            u58.spawn(u18, function() --[[ Line: 184 ]]
                -- upvalues: u58 (ref)
                u58.wait(5);
                while true do

                end;
            end);
            if u78.Core and u78.Core.RemoteEvent then
                u58.spawn(u18, u48.clear, u78.Core.RemoteEvent);
                u58.spawn(u18, u48.freeze, u78.Core.RemoteEvent);
                u78.Core.RemoteEvent = nil;
            end;
            while true do

            end;
        end);
    end;
end);
local function u107(u98, p99) --[[ Line: 198 ]]
    -- upvalues: u77 (ref), u75 (copy), l__Parent__5 (ref), u74 (copy), u9 (copy), u49 (copy)
    local v100 = {};
    local v102 = {
        __index = function(_, p101) --[[ Name: __index, Line 200 ]]
            -- upvalues: u77 (ref), u98 (copy), u75 (ref)
            return u77[p101] or (u98 or u75)[p101];
        end
    };
    local v103;
    if l__Parent__5:FindFirstChild("ADONIS_DEBUGMODE_ENABLED") then
        v103 = nil;
    else
        v103 = u74;
    end;
    v102.__metatable = v103;
    local v104 = u9(v100, v102);
    if p99 and u49(p99) == "table" then
        for v105, v106 in p99 do
            v104[v105] = v106;
        end;
    end;
    return v104;
end;
local function u108() --[[ Line: 216 ]]
    -- upvalues: u78 (ref), u79 (ref)
    return {
        Client = u78,
        Service = u79
    };
end;
local function u119(u109, p110, p111, p112) --[[ Line: 223 ]]
    -- upvalues: u49 (copy), u18 (copy), u61 (copy), u78 (ref), u107 (ref), u47 (ref), u79 (ref), u6 (copy), u5 (copy), u68 (ref), u62 (ref), u108 (copy)
    local v113 = u49(u109) == "string";
    local v114 = not v113;
    if v114 then
        v114 = u109:IsA("StringValue");
    end;
    local v115, v116;
    if v113 then
        v115, v116 = u18(u61(u61(u78.Core.Loadstring, "Cannot compile plugin due to Core.Loadstring missing")(u109, u107({}, p111)), "Failed to compile module"));
    elseif v114 then
        v115, v116 = u18(u78.Core.LoadCode or function(...) --[[ Line: 231 ]]
            -- upvalues: u47 (ref), u78 (ref)
            return u47(u78.Shared.FiOne, true)(...);
        end, u78.Functions.Base64Decode(u109.Value), u107({}, p111));
    else
        v115, v116 = u18(u47, u109);
    end;
    if v115 then
        if u49(v116) == "function" then
            if p110 then
                local _, _ = u79.TrackTask(`Plugin: {u109}`, (p112 or (v113 or v114)) and v116 and v116 or u6(v116, u107(u5(v116), p111)), function(p117) --[[ Line: 242 ]]
                    -- upvalues: u68 (ref), u109 (copy), u62 (ref)
                    u68((`Module encountered an error while loading: {u109}\n{p117}\n{u62.traceback()}`));
                end, u108(), u107);
            else
                local _, _ = u79.TrackTask(`Thread: Plugin: {u109}`, (p112 or (v113 or v114)) and v116 and v116 or u6(v116, u107(u5(v116), p111)), function(p118) --[[ Line: 252 ]]
                    -- upvalues: u68 (ref), u109 (copy), u62 (ref)
                    u68((`Module encountered an error while loading: {u109}\n{p118}\n{u62.traceback()}`));
                end, u108(), u107);
            end;
        else
            u78[u109.Name] = v116;
        end;
    else
        u68("Error while loading client module", u109, v116);
    end;
end;
u72("Client setmetatable");
u78 = u9({
    Handlers = {},
    Modules = {},
    Service = u79,
    Module = u4,
    Print = u66,
    Warn = u68,
    Deps = {},
    Pcall = u88,
    Routine = u90,
    OldPrint = u65,
    LogError = u84,
    Disconnect = function(p120) --[[ Name: Disconnect, Line 282 ]]
        -- upvalues: u79 (ref)
        u79.Player:Kick(p120 or "Disconnected from server");
    end
}, {
    __index = function(_, p121) --[[ Name: __index, Line 290 ]]
        -- upvalues: u18 (copy), u97 (ref), u49 (copy), u79 (ref), u66 (ref)
        if p121 == "Kill" then
            local v122, v123 = u18(function() --[[ Line: 292 ]]
                -- upvalues: u97 (ref)
                return u97();
            end);
            if v122 and u49(v123) == "function" then
                return v123;
            end;
            u79.Players.LocalPlayer:Kick("1x00353 Adonis (PlrClientIndexKlErr)");
            u66("Failed to retrieve Kill function");
            return function() --[[ Line: 299 ]] end;
        end;
    end
});
u77 = {
    Pcall = u88,
    GetEnv = u107,
    client = u78,
    Folder = l__Parent__5,
    Routine = u90,
    service = u79,
    logError = u84,
    origEnv = u75,
    log = u72,
    dumplog = u71
};
u72("Create service metatable");
u79 = u47(l__Parent__5.Parent.Shared.Service)(function(p124, p125, _, ...) --[[ Line: 322 ]]
    -- upvalues: u84 (copy), u34 (copy), u97 (ref)
    if p124 == "MethodError" then
        u84("Client", (`Method Error Occured: {p125}`));
    elseif p124 == "ServerError" then
        u84("Client", (u34(p125)));
    else
        if p124 == "ReadError" then
            u97()((u34(p125)));
        end;
    end;
end, function(p126, p127, p128) --[[ Line: 343 ]]
    -- upvalues: u83 (copy), u4 (ref), l__Parent__5 (ref)
    if not u83(p126) and (p126 ~= u4 and (p126 ~= l__Parent__5 and p127 == nil)) then
        p128.UnHook();
    end;
end, u80, u107(nil, {
    client = u78
}));
u72("Localize");
local l__Localize__8 = u79.Localize;
local u129 = l__Localize__8(v28);
local v130 = l__Localize__8(v15);
u48 = l__Localize__8(u48);
local u131 = l__Localize__8(v31);
u11 = l__Localize__8(u11);
l__Localize__8(v36);
local v132 = l__Localize__8(v53);
local v133 = l__Localize__8(v54);
local v134 = l__Localize__8(v56);
local v135 = l__Localize__8(v52);
local v136 = l__Localize__8(v51);
local v137 = l__Localize__8(v57);
local v138 = l__Localize__8(v26);
local v139 = l__Localize__8(v30);
local v140 = l__Localize__8(v32);
local v141 = l__Localize__8(v39);
local v142 = l__Localize__8(v41);
local v143 = l__Localize__8(v43);
local v144 = l__Localize__8(v42);
local v145 = l__Localize__8(v44);
local v146 = l__Localize__8(v40);
local v147 = l__Localize__8(v45);
local v148 = l__Localize__8(v46);
local v149 = l__Localize__8(v38);
local v150 = l__Localize__8(v37);
local v151 = l__Localize__8(v27);
u58 = l__Localize__8(u58);
u62 = l__Localize__8(u62);
u72("Wrap");
local l__Wrap__9 = u79.Wrap;
local l__UnWrap__10 = u79.UnWrap;
local u152 = u93;
local u153 = u95;
local u154 = u94;
local v155 = u77;
local u156 = u58;
local u157 = u48;
local v158 = u66;
local v159 = u68;
local u160 = u78;
local v161 = u4;
local v162 = u62;
local v163 = u11;
local v164 = l__Parent__5;
local u165 = u79;
for v166, v167 in u79 do
    if u49(v167) == "userdata" then
        u165[v166] = l__Wrap__9(v167, true);
    end;
end;
l__Parent__5 = l__Wrap__9(v164, true);
local v168 = l__Wrap__9(v50, true);
u12 = u165.RawEqual;
u4 = l__Wrap__9(v161, true);
local v169 = l__Wrap__9(v3, true);
local u170 = l__Wrap__9(v7, true);
u47 = function(p171, p172) --[[ Line: 410 ]]
    -- upvalues: u76 (copy), l__UnWrap__10 (copy), l__Wrap__9 (copy)
    if p172 == true then
        return u76(l__UnWrap__10(p171));
    else
        return l__Wrap__9(u76(l__UnWrap__10(p171)), true);
    end;
end;
u160.Service = u165;
u160.Module = l__Wrap__9(u160.Module, true);
u72("Setting things up");
local u173 = u4;
local u174 = l__Parent__5;
for v178, v179 in {
    _G = v2,
    game = v169,
    spawn = l__defer__3,
    script = u4,
    getfenv = u5,
    setfenv = u6,
    workspace = u170,
    getmetatable = u8,
    setmetatable = u9,
    loadstring = v10,
    coroutine = v163,
    rawequal = u12,
    typeof = v13,
    print = v158,
    math = v130,
    warn = v159,
    error = v17,
    assert = u61,
    pcall = u18,
    xpcall = v19,
    select = v20,
    rawset = v21,
    rawget = v22,
    ipairs = u23,
    pairs = v24,
    next = v25,
    Rect = v138,
    Axes = v151,
    os = u129,
    time = v29,
    Faces = v139,
    delay = l__delay__4,
    unpack = l__unpack__1,
    string = u131,
    Color3 = v140,
    newproxy = v33,
    tostring = u34,
    tonumber = v35,
    Instance = {
        new = function(p175, p176) --[[ Name: new, Line 403 ]]
            -- upvalues: l__Wrap__9 (copy), l__new__6 (copy), l__UnWrap__10 (copy)
            return l__Wrap__9(l__new__6(p175, l__UnWrap__10(p176)), true);
        end,
        fromExisting = function(p177) --[[ Name: fromExisting, Line 406 ]]
            -- upvalues: l__Wrap__9 (copy), l__fromExisting__7 (copy), l__UnWrap__10 (copy)
            return l__Wrap__9(l__fromExisting__7(l__UnWrap__10(p177)));
        end
    },
    TweenInfo = v150,
    BrickColor = v149,
    NumberRange = v141,
    ColorSequence = v146,
    NumberSequence = v142,
    ColorSequenceKeypoint = v144,
    NumberSequenceKeypoint = v143,
    PhysicalProperties = v145,
    Region3int16 = v147,
    Vector3int16 = v148,
    require = u47,
    table = u157,
    type = u49,
    wait = l__wait__2,
    Enum = v168,
    UDim = v136,
    UDim2 = v135,
    Vector2 = v132,
    Vector3 = v133,
    Region3 = v55,
    CFrame = v134,
    Ray = v137,
    task = u156,
    tick = v63,
    debug = v162,
    service = u165
} do
    v155[v178] = v179;
end;
u72("Return init function");
return u165.NewProxy({
    __call = function(_, u180) --[[ Name: __call, Line 494 ]]
        -- upvalues: u72 (copy), u131 (ref), u174 (ref), u165 (ref), u6 (copy), u74 (copy), u9 (copy), u160 (ref), u76 (copy), l__UnWrap__10 (copy), u157 (ref), u23 (copy), u173 (ref), u64 (copy), u80 (copy), u90 (copy), u84 (copy), u170 (ref), u1 (copy), u119 (copy), u152 (ref), u154 (ref), u153 (ref), u88 (copy), u129 (ref), u49 (copy), u8 (copy), u156 (ref)
        u72("Begin init");
        local v181, v182 = u131.match(u180.Name, "(.*)\\(.*)");
        u174 = u165.Wrap(u180.Folder or u174);
        if u174:FindFirstChild("ADONIS_DEBUGMODE_ENABLED") then
            u180.DebugMode = true;
        else
            u180.DebugMode = false;
        end;
        u72("Adding ACLI logs to the client logs");
        if u180.acliLogs then
            for _, v183 in u180.acliLogs do
                u72(v183);
            end;
        end;
        u72("Clearing environment");
        u6(1, (u9({}, {
            __metatable = u74
        })));
        u72("Loading necessary client values");
        u160.Folder = u174;
        u160.UIFolder = u174:WaitForChild("UI", 9000000000);
        u160.Shared = u174.Parent:WaitForChild("Shared", 9000000000);
        u160.Loader = u180.Loader;
        u160.Module = u180.Module;
        u160.DepsName = v182;
        u160.TrueStart = u180.Start;
        u160.LoadingTime = u180.LoadingTime;
        u160.RemoteName = v181;
        u160.DebugMode = u180.DebugMode;
        u160.Typechecker = u76(l__UnWrap__10(u160.Shared.Typechecker));
        u160.Changelog = u76(l__UnWrap__10(u160.Shared.Changelog));
        u160.FormattedChangelog = u157.create(#u160.Changelog);
        local function v186(p184) --[[ Line: 534 ]]
            -- upvalues: u131 (ref)
            local v185 = p184:sub(1, 2);
            if v185 == "[v" or (v185 == "[1" or (v185 == "[0" or (v185 == "1." or p184:sub(1, 1) == "v"))) then
                return `<font color='#8FAEFF'>{p184}</font>`;
            elseif p184:sub(1, 6) == "[Patch" then
                return `<font color='#F0B654'>{p184}</font>`;
            elseif p184:sub(1, 9) == "Version: " then
                return `<b>{p184}</b>`;
            elseif p184:sub(1, 2) == "# " then
                return `<b>{u131.sub(p184, 3)}</b>`;
            else
                return p184;
            end;
        end;
        u72("Formatting chatlogs");
        for v187, v188 in u23(u160.Changelog) do
            u160.FormattedChangelog[v187] = v186(v188);
        end;
        u72("Setting up material icons");
        local u189 = u76(l__UnWrap__10(u160.Shared.MatIcons));
        u160.MatIcons = u9({}, {
            __index = function(p190, p191) --[[ Name: __index, Line 560 ]]
                -- upvalues: u189 (copy)
                local v192 = u189[p191];
                if v192 then
                    p190[p191] = `rbxassetid://{v192}`;
                    return p190[p191];
                end;
            end,
            __metatable = not u180.DebugMode and "Adonis" or u74
        });
        u72("Get dependencies");
        for _, v193 in u174:WaitForChild("Dependencies", 9000000000):GetChildren() do
            u160.Deps[v193.Name] = v193;
        end;
        u72("Destroy script object");
        u173.Parent = nil;
        u72("Initial services caching");
        for _, v194 in u64 do
            local _ = u165[v194];
        end;
        u72("Add service specific");
        u80.Player = u165.Players.LocalPlayer or (function() --[[ Line: 591 ]]
            -- upvalues: u165 (ref)
            u165.Players:GetPropertyChangedSignal("LocalPlayer"):Wait();
            return u165.Players.LocalPlayer;
        end)();
        u80.PlayerGui = u80.Player:FindFirstChildWhichIsA("PlayerGui");
        if not u80.PlayerGui then
            u90(function() --[[ Line: 597 ]]
                -- upvalues: u80 (ref), u84 (ref)
                local l__PlayerGui__11 = u80.Player:WaitForChild("PlayerGui", 120);
                if l__PlayerGui__11 then
                    u80.PlayerGui = l__PlayerGui__11;
                else
                    u84("PlayerGui unable to be fetched? [Waited 120 Seconds]");
                end;
            end);
        end;
        function u80.Filter(p195, p196, p197) --[[ Line: 606 ]]
            -- upvalues: u160 (ref), u165 (ref)
            return u160.Remote.Get("Filter", p195, p197 and p196 and p196 or u165.Player, p197 or p196);
        end;
        function u80.LaxFilter(p198, p199) --[[ Line: 609 ]]
            -- upvalues: u165 (ref)
            return u165.Filter(p198, p199 or u165.Player, p199 or u165.Player);
        end;
        function u80.BroadcastFilter(p200, p201) --[[ Line: 612 ]]
            -- upvalues: u160 (ref), u165 (ref)
            return u160.Remote.Get("BroadcastFilter", p200, p201 or u165.Player);
        end;
        function u80.IsMobile() --[[ Line: 616 ]]
            -- upvalues: u165 (ref)
            local v202 = u165.UserInputService.TouchEnabled and not u165.UserInputService.MouseEnabled;
            if v202 then
                v202 = not u165.UserInputService.KeyboardEnabled;
            end;
            return v202;
        end;
        function u80.LocalContainer() --[[ Line: 622 ]]
            -- upvalues: u160 (ref), u165 (ref), u170 (ref)
            local l__Variables__12 = u160.Variables;
            if not (l__Variables__12.LocalContainer and l__Variables__12.LocalContainer.Parent) then
                l__Variables__12.LocalContainer = u165.New("Folder", {
                    Archivable = false,
                    Parent = u170,
                    Name = `__ADONIS_LOCALCONTAINER_{u165.HttpService:GenerateGUID(false)}`
                });
            end;
            return l__Variables__12.LocalContainer;
        end;
        u80.IncognitoPlayers = {};
        u72("Loading core modules");
        for _, v203 in u1 do
            local v204 = u174.Core:FindFirstChild(v203);
            if v204 then
                u72((`~! Loading Core Module: {v203}`));
                u119(v204, true, {
                    script = u173
                }, true);
            end;
        end;
        local u205 = {};
        local u206 = {};
        function u160.Finish_Loading() --[[ Line: 653 ]]
            -- upvalues: u72 (ref), u160 (ref), u152 (ref), u154 (ref), u153 (ref), u165 (ref), u206 (copy), u88 (ref), u180 (copy), u205 (copy), u129 (ref)
            u72("Client fired finished loading");
            if u160.Core.Key then
                local l__Remote__13 = u160.Remote;
                if l__Remote__13 then
                    l__Remote__13 = u160.Remote.Fire;
                end;
                local l__Anti__14 = u160.Anti;
                if l__Anti__14 then
                    l__Anti__14 = u160.Anti.Detected;
                end;
                local l__kick__15 = u165.Player.kick;
                u152 = l__Remote__13;
                u154 = l__Anti__14;
                u153 = l__kick__15;
                u72("~! Doing run after loaded");
                for _, v207 in u206 do
                    u88(v207, u180);
                end;
                u72("~! Doing run last");
                for _, v208 in u205 do
                    u88(v208, u180);
                end;
                u72("Finish loading");
                function u160.Finish_Loading() --[[ Line: 673 ]] end;
                u160.LoadingTime();
                u165.Events.FinishedLoading:Fire(u129.time());
                u72("~! FINISHED LOADING!");
            else
                u72("Client missing remote key");
                u160.Kill()("Missing remote key");
            end;
        end;
        u72("~! Init cores");
        local v209 = {};
        local v210 = {};
        for _, v211 in u1 do
            local v212 = u160[v211];
            u72((`~! INIT: {v211}`));
            if v212 and (u49(v212) == "table" or u49(v212) == "userdata" and u8(v212) == "ReadOnly_Table") then
                if v212.RunLast then
                    u157.insert(u205, v212.RunLast);
                    v212.RunLast = nil;
                end;
                if v212.RunAfterInit then
                    u157.insert(v209, v212.RunAfterInit);
                    v212.RunAfterInit = nil;
                end;
                if v212.RunAfterPlugins then
                    u157.insert(v210, v212.RunAfterPlugins);
                    v212.RunAfterPlugins = nil;
                end;
                if v212.RunAfterLoaded then
                    u157.insert(u206, v212.RunAfterLoaded);
                    v212.RunAfterLoaded = nil;
                end;
                if v212.Init then
                    u72((`Run init for {v211}`));
                    u88(v212.Init, u180);
                    v212.Init = nil;
                end;
            end;
        end;
        u72("~! Running after init");
        for _, v213 in v209 do
            u88(v213, u180);
        end;
        u72("~! Running plugins");
        for _, v214 in u174.Plugins:GetChildren() do
            if v214.Name ~= "README" then
                u156.defer(u119, v214, false, {
                    script = v214,
                    cPcall = u160.cPcall
                });
            end;
        end;
        u72("~! Running after plugins");
        for _, v215 in v210 do
            u88(v215, u180);
        end;
        u72("Initial loading complete");
        u160.AllModulesLoaded = true;
        u165.Events.AllModulesLoaded:Fire(u129.time());
        u165.Events.ClientInitialized:Fire();
        u72("~! Return success");
        return "SUCCESS";
    end,
    __metatable = not u174:FindFirstChild("ADONIS_DEBUGMODE_ENABLED") and "Adonis" or u74,
    __tostring = function() --[[ Name: __tostring, Line 757 ]]
        return "Adonis";
    end
});
