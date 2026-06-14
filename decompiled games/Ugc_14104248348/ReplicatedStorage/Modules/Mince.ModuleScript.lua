-- Decompiled from: ReplicatedStorage.Modules.Mince
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__Identity__2 = require(script.Identity);
local u1 = {
    _VERSION = "optap0.2",
    _DESCRIPTION = "Basic, superceed of weave. Compatability version for on tap",
    _LICENSE = "cc-0",
    Started = false,
    Initialized = false,
    SetupMethodIndex = "Setup",
    PostMethodIndex = "GameStart",
    DoPcalling = true,
    _AUTHORS = { "whim@awesomexforlife", "inty@intykat" },
    Signal = require(script.Signal),
    Identity = l__Identity__2,
    SetupMethods = {},
    PostMethods = {},
    Config = {},
    Modules = {},
    ReadyPlayerStatus = {},
    SignalNames = { "UponStart", "UponInitComplete", "ModuleAdded" },
    VerboseMethods = {
        [print] = "Print",
        [warn] = "Warn",
        [error] = "Error"
    }
};
function u1.Start(_) --[[ Line: 81 ]]
    -- upvalues: u1 (copy), l__Identity__2 (copy)
    if u1.__AsyncStarted then
        error("Modules have already began to load.");
    end;
    u1.__AsyncStarted = true;
    u1:Print((`{l__Identity__2} has started.`));
    os.clock();
    local v2 = #u1.SetupMethods;
    local u3 = os.clock();
    local u4 = {};
    local u5 = 0;
    for _, u6 in u1.SetupMethods do
        if u6[1].__IsAsyncSetup then
            v2 = v2 - 1;
        end;
        task.defer(function() --[[ Line: 100 ]]
            -- upvalues: u4 (copy), u6 (copy), u1 (ref), u3 (copy), u5 (ref)
            u4[u6] = false;
            u6[1][u1.SetupMethodIndex](u6[1]);
            local v7 = os.clock() - u3;
            u4[u6] = v7;
            local v8 = "";
            if u6[1].__IsAsyncSetup then
                v8 = "(Async)";
            else
                u5 = u5 + 1;
            end;
            if u4[u6] > 1.5 then
                u1:Warn((`'{u6[2]}' {v8} Intialized after {v7}s.`));
            end;
        end);
    end;
    repeat
        task.wait();
    until u5 == v2 or os.clock() - u3 > 15;
    for _, u9 in u1.PostMethods do
        task.defer(function() --[[ Line: 126 ]]
            -- upvalues: u9 (copy), u1 (ref)
            u9[1][u1.PostMethodIndex](u9[1]);
        end);
    end;
    local v10 = os.clock() - u3;
    if v10 > 15 then
        u1:Warn((`Did not wait for all modules to initilize because it took more than {15}seconds.`));
        u1:Warn("Important to note that __IsAsyncSetup can be used to ignore this script , but instead task.spawn() any contents that are async! As this is the intended way with mince!");
        local v11 = "";
        for _, v12 in u1.SetupMethods do
            if not u4[v12] then
                v11 = v11 .. `{v12[2]}{v12[1].__IsAsyncSetup and "(Async)" or ""}, `;
            end;
        end;
        u1:Warn((`Currently intilializing scripts: {v11:sub(1, -3)}.`));
        u1:Warn("Try checking theese scripts for any uninetional yeilding.");
    end;
    if u5 == v2 then
        u1:Print((`Took {v10}(s) to setup all ({v2}) modules.`));
    else
        u1:Warn((`Took {v10}(s) to setup {u5} / {v2} modules.`));
    end;
    for v13, v14 in u4 do
        if v14 and v14 > 1.5 then
            u1:Warn((`'{v13[2]}' Took a while to setup! It took a total of {v14}(s).`));
        end;
    end;
    u1:Print((`{l__Identity__2} has completed.`));
    u1:SetIdentityStatus(true);
    u1.Started = true;
    u1.UponStart:Fire();
end;
function u1.Get(_, u15) --[[ Line: 175 ]]
    -- upvalues: u1 (copy)
    if u1.Modules[u15] then
        return u1.Modules[u15];
    end;
    if not u1.InitComplete then
        local u16 = {};
        local u17 = {
            __Mince = {}
        };
        local u18 = {
            InitComplete = u1.UponInitComplete:Connect(function() --[[ Line: 187 ]]
                -- upvalues: u17 (copy), u15 (copy)
                if not u17.__Mince.Aquired then
                    error((`The module '{u15}' does not exist and a reference from the table will not be made.,`));
                end;
            end)
        };
        u18.ModuleAdded = u1.ModuleAdded:Connect(function(p19, p20) --[[ Line: 193 ]]
            -- upvalues: u15 (copy), u16 (ref), u17 (copy), u18 (copy)
            if p19 == u15 then
                u16 = p20;
                u17.__Mince.Aquired = true;
                u17.__Mince.Table = p20;
                for _, v21 in u18 do
                    v21:Disconnect();
                end;
            end;
        end);
        return setmetatable(u17, {
            __index = function(_, p22) --[[ Name: __index, Line 207 ]]
                -- upvalues: u16 (ref)
                return u16[p22];
            end,
            __newindex = function(_, p23, p24) --[[ Name: __newindex, Line 210 ]]
                -- upvalues: u16 (ref)
                u16[p23] = p24;
            end
        });
    end;
    error((`All modules have been required '{u15}' does not exist.`));
end;
function u1.LoadModules(_, p25) --[[ Line: 216 ]]
    -- upvalues: u1 (copy)
    if u1.__AsyncStarted then
        error("Modules have already began to load.");
    end;
    u1:__IterateRules(p25, function(p26) --[[ Line: 219 ]]
        -- upvalues: u1 (ref)
        local v27, v28 = u1:__SafeRequire(p26);
        if u1.Modules[v28] then
            warn((`There's another module by the name of '{v28}'! It has been overwritten.`));
        end;
        if v27[u1.SetupMethodIndex] then
            table.insert(u1.SetupMethods, { v27, v28 });
        end;
        if v27[u1.PostMethodIndex] then
            table.insert(u1.PostMethods, { v27, v28 });
        end;
        u1.Modules[v28] = v27;
        u1.ModuleAdded:FireImmediate(v28, v27);
    end);
end;
function u1.LoadConfig(_, p29) --[[ Line: 237 ]]
    -- upvalues: u1 (copy)
    u1:__IterateRules(p29, function(p30) --[[ Line: 238 ]]
        -- upvalues: u1 (ref)
        local v31, v32 = u1:__SafeRequire(p30);
        u1.Config[v32] = v31;
    end);
end;
function u1.WaitUntilHandshake(_, p33) --[[ Line: 246 ]]
    -- upvalues: u1 (copy)
    u1:__WaitInstAttrTrueChange(p33, "_ReplicatedHandshakeStatus");
end;
function u1.GetHandshake(_, p34) --[[ Line: 250 ]]
    return p34:GetAttribute("_ReplicatedHandshakeStatus");
end;
function u1.SetIdentityStatus(_, p35) --[[ Line: 254 ]]
    -- upvalues: u1 (copy), l__Identity__2 (copy)
    u1.StatusConfiguration:SetAttribute(l__Identity__2, p35);
end;
function u1.WhenStart(_, p36) --[[ Line: 258 ]]
    -- upvalues: u1 (copy)
    if u1.Started then
        p36();
    else
        u1.UponStart:Once(p36);
    end;
end;
function u1.WaitUntilSetup(_, p37) --[[ Line: 265 ]]
    -- upvalues: u1 (copy)
    u1:__WaitInstAttrTrueChange(u1.StatusConfiguration, p37);
end;
function u1.__SafeRequire(_, u38) --[[ Line: 269 ]]
    -- upvalues: u1 (copy)
    local l__Name__3 = u38.Name;
    local v39;
    if u1.DoPcalling then
        local v40;
        v40, v39 = pcall(function() --[[ Line: 274 ]]
            -- upvalues: u38 (copy)
            return require(u38);
        end);
        if not v40 then
            warn(":====: :====: :====: :====:");
            warn("ERROR! ERROR! ERROR! ERROR!");
            warn(":====: :====: :====: :====:");
            warn((`Require Failure '{u38:GetFullName()}'! It occured an error!`));
            warn("It will not be created! Instead it will return an empty table, FIX ASAP May break other things!");
            warn(v39);
            warn(":====: :====: :====: :====:");
            v39 = {};
        end;
    else
        v39 = require(u38);
    end;
    if typeof(v39) == "table" then
        return v39, v39.Name or l__Name__3;
    end;
    error("Mounted modules must return a table!");
    return v39, l__Name__3;
end;
function u1.__IterateRules(_, p41, p42) --[[ Line: 302 ]]
    for _, v43 in p41:GetDescendants() do
        if v43:IsA("ModuleScript") and not (v43.Parent:IsA("ModuleScript") or v43.Parent:IsA("Configuration")) then
            p42(v43);
        end;
    end;
end;
function u1.__WaitInstAttrTrueChange(_, p44, p45) --[[ Line: 310 ]]
    if p44:GetAttribute(p45) then
    else
        local u46 = coroutine.running();
        local u47 = nil;
        u47 = p44:GetAttributeChangedSignal(p45):Connect(function() --[[ Line: 314 ]]
            -- upvalues: u47 (ref), u46 (copy)
            u47:Disconnect();
            task.defer(u46);
        end);
        coroutine.yield();
    end;
end;
function u1.MountAddonModule(_, u48) --[[ Line: 323 ]]
    -- upvalues: u1 (copy), l__Identity__2 (copy)
    local v49, v50 = pcall(function() --[[ Line: 324 ]]
        -- upvalues: u48 (copy)
        return require(u48);
    end);
    if v49 then
        local v51 = v50[u1.Identity];
        if v51 then
            for v52, v53 in v51 do
                u1[v52] = v53;
            end;
        end;
        if v50.Identity then
            v50.Identity(l__Identity__2);
        end;
    else
        u1.Warn((`Failure to load addon '{u48.Name}'.`));
    end;
end;
function u1.SetupMince(_) --[[ Line: 344 ]]
    -- upvalues: u1 (copy), l__Identity__2 (copy), l__Players__1 (copy)
    script:WaitForChild("Repl");
    script:WaitForChild("Addons");
    u1.StatusConfiguration = script.Repl:WaitForChild("Status");
    u1.HandshakeRemote = script.Repl:WaitForChild("Handshake");
    _G.MinceRef = u1;
    for _, v54 in u1.SignalNames do
        u1[v54] = u1.Signal.new();
    end;
    for u55, v56 in u1.VerboseMethods do
        u1[v56] = function(_, p57) --[[ Line: 354 ]]
            -- upvalues: u55 (copy)
            u55("[Mince]:" .. p57);
        end;
    end;
    u1:__IterateRules(script.Addons, function(p58) --[[ Line: 364 ]]
        -- upvalues: u1 (ref)
        u1:MountAddonModule(p58);
    end);
    if l__Identity__2 == "Client" then
        task.defer(function() --[[ Line: 369 ]]
            -- upvalues: u1 (ref), l__Identity__2 (ref)
            u1:WaitUntilSetup("Server");
            u1:WaitUntilSetup(l__Identity__2);
            u1.HandshakeRemote:FireServer();
        end);
    else
        u1.HandshakeRemote.OnServerEvent:Connect(function(p59) --[[ Line: 377 ]]
            -- upvalues: l__Players__1 (ref)
            if p59:IsDescendantOf(l__Players__1) then
                p59:SetAttribute("_ReplicatedHandshakeStatus", true);
            end;
        end);
    end;
end;
u1:SetupMince();
return u1;
