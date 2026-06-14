-- Decompiled from: ReplicatedStorage.CmdrClient.Shared.Registry
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__Util__2 = require(script.Parent.Util);
local u16 = {
    Cmdr = nil,
    TypeMethods = l__Util__2.MakeDictionary({
        "Transform",
        "Validate",
        "Autocomplete",
        "Parse",
        "DisplayName",
        "Listable",
        "ValidateOnce",
        "Prefixes",
        "Default"
    }),
    CommandMethods = l__Util__2.MakeDictionary({
        "Name",
        "Aliases",
        "AutoExec",
        "Description",
        "Args",
        "Run",
        "ClientRun",
        "Data",
        "Group"
    }),
    CommandArgProps = l__Util__2.MakeDictionary({
        "Name",
        "Type",
        "Description",
        "Optional",
        "Default"
    }),
    Types = {},
    TypeAliases = {},
    Commands = {},
    CommandsArray = {},
    Hooks = {
        BeforeRun = {},
        AfterRun = {}
    },
    Stores = setmetatable({}, {
        __index = function(p1, p2) --[[ Name: __index, Line 20 ]]
            p1[p2] = {};
            return p1[p2];
        end
    }),
    AutoExecBuffer = {},
    RegisterType = function(p3, p4, p5) --[[ Name: RegisterType, Line 30 ]]
        if not p4 or not typeof(p4) == "string" then
            error("Invalid type name provided: nil");
        end;
        if not p4:find("^[%d%l]%w*$") then
            error(("Invalid type name provided: \"%s\", type names must be alphanumeric and start with a lower-case letter or a digit."):format(p4));
        end;
        for v6 in pairs(p5) do
            if p3.TypeMethods[v6] == nil then
                error("Unknown key/method in type \"" .. p4 .. "\": " .. v6);
            end;
        end;
        if p3.Types[p4] ~= nil then
            error(("Type \"%s\" has already been registered."):format(p4));
        end;
        p5.Name = p4;
        p5.DisplayName = p5.DisplayName or p4;
        p3.Types[p4] = p5;
        if p5.Prefixes then
            p3:RegisterTypePrefix(p4, p5.Prefixes);
        end;
    end,
    RegisterTypePrefix = function(p7, p8, p9) --[[ Name: RegisterTypePrefix, Line 59 ]]
        if not p7.TypeAliases[p8] then
            p7.TypeAliases[p8] = p8;
        end;
        p7.TypeAliases[p8] = ("%s %s"):format(p7.TypeAliases[p8], p9);
    end,
    RegisterTypeAlias = function(p10, p11, p12) --[[ Name: RegisterTypeAlias, Line 67 ]]
        assert(p10.TypeAliases[p11] == nil, ("Type alias %s already exists!"):format(p12));
        p10.TypeAliases[p11] = p12;
    end,
    RegisterTypesIn = function(p13, p14) --[[ Name: RegisterTypesIn, Line 73 ]]
        for _, v15 in pairs(p14:GetChildren()) do
            if v15:IsA("ModuleScript") then
                v15.Parent = p13.Cmdr.ReplicatedRoot.Types;
                require(v15)(p13);
            else
                p13:RegisterTypesIn(v15);
            end;
        end;
    end
};
u16.RegisterHooksIn = u16.RegisterTypesIn;
function u16.RegisterCommandObject(p17, p18, _) --[[ Line: 90 ]]
    -- upvalues: l__RunService__1 (copy)
    for v19 in pairs(p18) do
        if p17.CommandMethods[v19] == nil then
            error("Unknown key/method in command " .. (p18.Name or "unknown command") .. ": " .. v19);
        end;
    end;
    if p18.Args then
        for v20, v21 in ipairs(p18.Args) do
            if type(v21) == "table" then
                for v22 in pairs(v21) do
                    if p17.CommandArgProps[v22] == nil then
                        error(("Unknown propery in command \"%s\" argument #%d: %s"):format(p18.Name or "unknown", v20, v22));
                    end;
                end;
            end;
        end;
    end;
    if p18.AutoExec and l__RunService__1:IsClient() then
        table.insert(p17.AutoExecBuffer, p18.AutoExec);
        p17:FlushAutoExecBufferDeferred();
    end;
    local v23 = p17.Commands[p18.Name:lower()];
    if v23 and v23.Aliases then
        for _, v24 in pairs(v23.Aliases) do
            p17.Commands[v24:lower()] = nil;
        end;
    elseif not v23 then
        p17.CommandsArray[#p17.CommandsArray + 1] = p18;
    end;
    p17.Commands[p18.Name:lower()] = p18;
    if p18.Aliases then
        for _, v25 in pairs(p18.Aliases) do
            p17.Commands[v25:lower()] = p18;
        end;
    end;
end;
function u16.RegisterCommand(p26, p27, p28, p29) --[[ Line: 135 ]]
    local v30 = require(p27);
    if p28 then
        v30.Run = require(p28);
    end;
    if p29 and not p29(v30) then
    else
        p26:RegisterCommandObject(v30);
        p27.Parent = p26.Cmdr.ReplicatedRoot.Commands;
    end;
end;
function u16.RegisterCommandsIn(p31, p32, p33) --[[ Line: 152 ]]
    local v34 = {};
    local v35 = {};
    for _, v36 in pairs(p32:GetChildren()) do
        if v36:IsA("ModuleScript") then
            if v36.Name:find("Server") then
                v34[v36] = true;
            else
                local v37 = p32:FindFirstChild(v36.Name .. "Server");
                if v37 then
                    v35[v37] = true;
                end;
                p31:RegisterCommand(v36, v37, p33);
            end;
        else
            p31:RegisterCommandsIn(v36, p33);
        end;
    end;
    for v38 in pairs(v34) do
        if not v35[v38] then
            warn("Command script " .. v38.Name .. " was skipped because it has \'Server\' in its name, and has no equivalent shared script.");
        end;
    end;
end;
function u16.RegisterDefaultCommands(p39, u40) --[[ Line: 182 ]]
    -- upvalues: l__Util__2 (copy)
    local v41 = type(u40) == "table";
    if v41 then
        u40 = l__Util__2.MakeDictionary(u40);
    end;
    p39:RegisterCommandsIn(p39.Cmdr.DefaultCommandsFolder, v41 and function(p42) --[[ Line: 189 ]]
        -- upvalues: u40 (ref)
        return u40[p42.Group] or false;
    end or u40);
end;
function u16.GetCommand(p43, p44) --[[ Line: 195 ]]
    return p43.Commands[(p44 or ""):lower()];
end;
function u16.GetCommands(p45) --[[ Line: 201 ]]
    return p45.CommandsArray;
end;
function u16.GetCommandNames(p46) --[[ Line: 206 ]]
    local v47 = {};
    for _, v48 in pairs(p46.CommandsArray) do
        v47[#v47 + 1] = v48.Name;
    end;
    return v47;
end;
u16.GetCommandsAsStrings = u16.GetCommandNames;
function u16.GetTypeNames(p49) --[[ Line: 219 ]]
    local v50 = {};
    for v51 in pairs(p49.Types) do
        v50[#v50 + 1] = v51;
    end;
    return v50;
end;
function u16.GetType(p52, p53) --[[ Line: 231 ]]
    return p52.Types[p53];
end;
function u16.GetTypeName(p54, p55) --[[ Line: 236 ]]
    return p54.TypeAliases[p55] or p55;
end;
function u16.RegisterHook(p56, p57, p58, p59) --[[ Line: 241 ]]
    if not p56.Hooks[p57] then
        error(("Invalid hook name: %q"):format(p57), 2);
    end;
    table.insert(p56.Hooks[p57], {
        callback = p58,
        priority = p59 or 0
    });
    table.sort(p56.Hooks[p57], function(p60, p61) --[[ Line: 247 ]]
        return p60.priority < p61.priority;
    end);
end;
u16.AddHook = u16.RegisterHook;
function u16.GetStore(p62, p63) --[[ Line: 255 ]]
    return p62.Stores[p63];
end;
function u16.FlushAutoExecBufferDeferred(u64) --[[ Line: 260 ]]
    -- upvalues: l__RunService__1 (copy)
    if u64.AutoExecFlushConnection then
    else
        u64.AutoExecFlushConnection = l__RunService__1.Heartbeat:Connect(function() --[[ Line: 265 ]]
            -- upvalues: u64 (copy)
            u64.AutoExecFlushConnection:Disconnect();
            u64.AutoExecFlushConnection = nil;
            u64:FlushAutoExecBuffer();
        end);
    end;
end;
function u16.FlushAutoExecBuffer(p65) --[[ Line: 273 ]]
    for _, v66 in ipairs(p65.AutoExecBuffer) do
        for _, v67 in ipairs(v66) do
            p65.Cmdr.Dispatcher:EvaluateAndRun(v67);
        end;
    end;
    p65.AutoExecBuffer = {};
end;
return function(p68) --[[ Line: 283 ]]
    -- upvalues: u16 (copy)
    u16.Cmdr = p68;
    return u16;
end;
