-- Decompiled from: ReplicatedStorage.CmdrClient.Shared.Util
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__TextService__1 = game:GetService("TextService");
local u1 = {
    Job = 1,
    MaxWork = 50
};
function u1.Work() --[[ Line: 7 ]]
    -- upvalues: u1 (copy)
    local v2 = u1;
    v2.Job = v2.Job + 1;
    if u1.Job > u1.MaxWork then
        u1.Job = 0;
        task.wait();
    end;
end;
function u1.MakeDictionary(p3) --[[ Line: 16 ]]
    -- upvalues: u1 (copy)
    local v4 = {};
    for v5 = 1, #p3 do
        u1.Work();
        v4[p3[v5]] = true;
    end;
    return v4;
end;
function u1.DictionaryKeys(p6) --[[ Line: 27 ]]
    -- upvalues: u1 (copy)
    local v7 = {};
    for v8 in pairs(p6) do
        u1.Work();
        table.insert(v7, v8);
    end;
    return v7;
end;
local function u12(p9) --[[ Line: 38 ]]
    -- upvalues: u1 (copy)
    local v10 = {};
    for v11 = 1, #p9 do
        u1.Work();
        v10[v11] = p9[v11].Name;
    end;
    return v10, p9;
end;
function u1.MakeFuzzyFinder(p13) --[[ Line: 52 ]]
    -- upvalues: u12 (copy), u1 (copy)
    local u14 = nil;
    local u15 = {};
    if typeof(p13) == "Enum" then
        p13 = p13:GetEnumItems();
    end;
    if typeof(p13) == "Instance" then
        u14, u15 = u12(p13:GetChildren());
    elseif typeof(p13) == "table" then
        if typeof(p13[1]) == "Instance" or (typeof(p13[1]) == "EnumItem" or typeof(p13[1]) == "table" and typeof(p13[1].Name) == "string") then
            u14, u15 = u12(p13);
        elseif type(p13[1]) == "string" then
            u14 = p13;
        elseif p13[1] == nil then
            u14 = {};
        else
            error("MakeFuzzyFinder only accepts tables of instances or strings.");
        end;
    else
        error("MakeFuzzyFinder only accepts a table, Enum, or Instance.");
    end;
    return function(p16, p17) --[[ Line: 80 ]]
        -- upvalues: u14 (ref), u1 (ref), u15 (ref)
        local v18 = {};
        for v19, v20 in pairs(u14) do
            u1.Work();
            local v21;
            if u15 then
                v21 = u15[v19] or v20;
            else
                v21 = v20;
            end;
            if v20:lower() == p16:lower() then
                if p17 then
                    return v21;
                end;
                table.insert(v18, 1, v21);
            elseif v20:lower():sub(1, #p16) == p16:lower() then
                v18[#v18 + 1] = v21;
            end;
        end;
        if p17 then
            return v18[1];
        else
            return v18;
        end;
    end;
end;
function u1.GetNames(p22) --[[ Line: 108 ]]
    -- upvalues: u1 (copy)
    local v23 = {};
    for v24 = 1, #p22 do
        u1.Work();
        v23[v24] = p22[v24].Name or tostring(p22[v24]);
    end;
    return v23;
end;
function u1.SplitStringSimple(p25, p26) --[[ Line: 119 ]]
    -- upvalues: u1 (copy)
    local v27 = {};
    local v28 = 1;
    for v29 in string.gmatch(p25, "([^" .. (p26 == nil and "%s" or p26) .. "]+)") do
        u1.Work();
        v27[v28] = v29;
        v28 = v28 + 1;
    end;
    return v27;
end;
local function u31(p30) --[[ Line: 132 ]]
    return utf8.char((tonumber(p30, 16)));
end;
function u1.ParseEscapeSequences(p32) --[[ Line: 137 ]]
    -- upvalues: u31 (copy)
    return p32:gsub("\\(.)", {
        t = "\t",
        n = "\n"
    }):gsub("\\u(%x%x%x%x)", u31):gsub("\\x(%x%x)", u31);
end;
function u1.EncodeEscapedOperator(p33, p34) --[[ Line: 146 ]]
    local v35 = p34:sub(1, 1);
    local v36 = p34:gsub(".", "%%%1");
    return p33:gsub("(" .. ("%" .. v35) .. "+)(" .. v36 .. ")", function(p37, p38) --[[ Line: 151 ]]
        return (p37:sub(1, #p37 - 1) .. p38):gsub(".", function(p39) --[[ Line: 152 ]]
            return "\\u" .. string.format("%04x", string.byte(p39), 16);
        end);
    end);
end;
local u40 = { "&&", "||", ";" };
function u1.EncodeEscapedOperators(p41) --[[ Line: 159 ]]
    -- upvalues: u40 (copy), u1 (copy)
    for _, v42 in ipairs(u40) do
        u1.Work();
        p41 = u1.EncodeEscapedOperator(p41, v42);
    end;
    return p41;
end;
function u1.SplitString(p43, p44) --[[ Line: 187 ]]
    -- upvalues: u1 (copy)
    local v45 = nil;
    local v46 = nil;
    local v47 = {};
    local v48 = p44 or (1 / 0);
    for v49 in p43:gsub("\\\\", "___!CMDR_ESCAPE!___"):gsub("\\\"", "___!CMDR_QUOTE!___"):gsub("\\\'", "___!CMDR_SQUOTE!___"):gsub("\\\n", "___!CMDR_NL!___"):gmatch("[^ ]+") do
        u1.Work();
        local v50 = u1.ParseEscapeSequences(v49);
        local v51 = v50:match("^([\'\"])");
        local v52 = v50:match("([\'\"])$");
        local v53 = v50:match("(\\*)[\'\"]$");
        if v51 and not (v45 or v52) then
            v45 = v51;
            v46 = v50;
        elseif v46 and (v52 == v45 and #v53 % 2 == 0) then
            v50 = v46 .. " " .. v50;
            v46 = nil;
            v45 = nil;
        elseif v46 then
            v46 = v46 .. " " .. v50;
        end;
        if not v46 then
            v47[#v47 + (v48 < #v47 and 0 or 1)] = v50:gsub("^([\'\"])", ""):gsub("([\'\"])$", ""):gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n");
        end;
    end;
    if v46 then
        v47[#v47 + (v48 < #v47 and 0 or 1)] = v46:gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n");
    end;
    return v47;
end;
function u1.MashExcessArguments(p54, p55) --[[ Line: 219 ]]
    -- upvalues: u1 (copy)
    local v56 = {};
    for v57 = 1, #p54 do
        u1.Work();
        if p55 < v57 then
            v56[p55] = ("%s %s"):format(v56[p55] or "", p54[v57]);
        else
            v56[v57] = p54[v57];
        end;
    end;
    return v56;
end;
function u1.TrimString(p58) --[[ Line: 232 ]]
    return p58:match("^%s*(.-)%s*$");
end;
function u1.GetTextSize(p59, p60, p61) --[[ Line: 237 ]]
    -- upvalues: l__TextService__1 (copy)
    return l__TextService__1:GetTextSize(p59, p60.TextSize, p60.Font, p61 or Vector2.new(p60.AbsoluteSize.X, 0));
end;
function u1.MakeEnumType(u62, p63) --[[ Line: 242 ]]
    -- upvalues: u1 (copy)
    local u64 = u1.MakeFuzzyFinder(p63);
    return {
        Validate = function(p65) --[[ Name: Validate, Line 245 ]]
            -- upvalues: u64 (copy), u62 (copy)
            return u64(p65, true) ~= nil, ("Value %q is not a valid %s."):format(p65, u62);
        end,
        Autocomplete = function(p66) --[[ Name: Autocomplete, Line 248 ]]
            -- upvalues: u64 (copy), u1 (ref)
            local v67 = u64(p66);
            if type(v67[1]) ~= "string" then
                v67 = u1.GetNames(v67) or v67;
            end;
            return v67;
        end,
        Parse = function(p68) --[[ Name: Parse, Line 252 ]]
            -- upvalues: u64 (copy)
            return u64(p68, true);
        end
    };
end;
function u1.ParsePrefixedUnionType(p69, p70) --[[ Line: 259 ]]
    -- upvalues: u1 (copy)
    local v71 = u1.SplitStringSimple(p69);
    local v72 = {};
    for v73 = 1, #v71, 2 do
        v72[#v72 + 1] = {
            prefix = v71[v73 - 1] or "",
            type = v71[v73]
        };
    end;
    table.sort(v72, function(p74, p75) --[[ Line: 273 ]]
        return #p74.prefix > #p75.prefix;
    end);
    for v76 = 1, #v72 do
        u1.Work();
        local v77 = v72[v76];
        if p70:sub(1, #v77.prefix) == v77.prefix then
            return v77.type, p70:sub(#v77.prefix + 1), v77.prefix;
        end;
    end;
end;
function u1.MakeListableType(u78, p79) --[[ Line: 288 ]]
    local v80 = {
        Listable = true,
        Transform = u78.Transform,
        Validate = u78.Validate,
        Autocomplete = u78.Autocomplete,
        Default = u78.Default,
        Parse = function(...) --[[ Name: Parse, Line 295 ]]
            -- upvalues: u78 (copy)
            return { u78.Parse(...) };
        end
    };
    if p79 then
        for v81, v82 in pairs(p79) do
            v80[v81] = v82;
        end;
    end;
    return v80;
end;
function u1.RunCommandString(p83, p84) --[[ Line: 317 ]]
    -- upvalues: u1 (copy)
    local v85 = u1.ParseEscapeSequences(p84);
    local v86 = u1.EncodeEscapedOperators(v85):split("&&");
    local v87 = "";
    for v88, v89 in ipairs(v86) do
        u1.Work();
        local v90 = v87:gsub("%$", "\\x24");
        local v91 = "||";
        if v87:find("%s") then
            v90 = ("%q"):format(v90) or v90;
        end;
        local v92 = v89:gsub(v91, v90);
        local v93 = u1.RunEmbeddedCommands(p83, v92);
        v87 = tostring(p83:EvaluateAndRun(v93));
        if v88 == #v86 then
            return v87;
        end;
    end;
end;
function u1.RunEmbeddedCommands(p94, p95) --[[ Line: 344 ]]
    -- upvalues: u1 (copy)
    local v96 = p95:gsub("\\%$", "___!CMDR_DOLLAR!___");
    local v97 = {};
    for v98 in v96:gmatch("$(%b{})") do
        u1.Work();
        local v99 = v98:sub(2, #v98 - 1);
        local v100;
        if v99:match("^{.+}$") then
            v99 = v99:sub(2, #v99 - 1);
            v100 = false;
        else
            v100 = true;
        end;
        v97[v98] = u1.RunCommandString(p94, v99);
        if v100 and (v97[v98]:find("%s") or v97[v98] == "") then
            v97[v98] = string.format("%q", v97[v98]);
        end;
    end;
    return v96:gsub("$(%b{})", v97):gsub("___!CMDR_DOLLAR!___", "$");
end;
function u1.SubstituteArgs(p101, p102) --[[ Line: 372 ]]
    -- upvalues: u1 (copy)
    local v103 = p101:gsub("\\%$", "___!CMDR_DOLLAR!___");
    if type(p102) == "table" then
        for v104 = 1, #p102 do
            u1.Work();
            local v105 = tostring(v104);
            p102[v105] = p102[v104];
            if p102[v105]:find("%s") then
                p102[v105] = string.format("%q", p102[v105]);
            end;
        end;
    end;
    return v103:gsub("($%d+)%b{}", "%1"):gsub("$(%w+)", p102):gsub("___!CMDR_DOLLAR!___", "$");
end;
function u1.MakeAliasCommand(p106, p107) --[[ Line: 389 ]]
    -- upvalues: u1 (copy)
    local v108, v109 = unpack(p106:split("|"));
    local u110 = u1.EncodeEscapedOperators(p107);
    local v111 = {};
    local v112 = {};
    for v113 in u110:gmatch("$(%d+)") do
        u1.Work();
        if v111[v113] == nil then
            v111[v113] = true;
            local v114 = u110:match("$" .. v113 .. "(%b{})");
            local v115, v116, v117;
            if v114 then
                local v118 = v114:sub(2, #v114 - 1);
                v115, v116, v117 = unpack(v118:split("|"));
            else
                v115 = nil;
                v116 = nil;
                v117 = nil;
            end;
            table.insert(v112, {
                Type = v115 or "string",
                Name = v116 or "Argument " .. v113,
                Description = v117 or ""
            });
        end;
    end;
    return {
        Group = "UserAlias",
        Name = v108,
        Aliases = {},
        Description = "<Alias> " .. (v109 or u110),
        Args = v112,
        Run = function(p119) --[[ Name: Run, Line 427 ]]
            -- upvalues: u1 (ref), u110 (ref)
            return u1.RunCommandString(p119.Dispatcher, u1.SubstituteArgs(u110, p119.RawArguments));
        end
    };
end;
function u1.MakeSequenceType(p120) --[[ Line: 434 ]]
    -- upvalues: u1 (copy)
    local u121 = p120 or {};
    assert(u121.Parse ~= nil and true or u121.Constructor ~= nil, "MakeSequenceType: Must provide one of: Constructor, Parse");
    u121.TransformEach = u121.TransformEach or function(...) --[[ Line: 439 ]]
        return ...;
    end;
    u121.ValidateEach = u121.ValidateEach or function() --[[ Line: 443 ]]
        return true;
    end;
    return {
        Prefixes = u121.Prefixes,
        Transform = function(p122) --[[ Name: Transform, Line 450 ]]
            -- upvalues: u1 (ref), u121 (ref)
            return u1.Map(u1.SplitPrioritizedDelimeter(p122, { ",", "%s" }), function(p123) --[[ Line: 451 ]]
                -- upvalues: u121 (ref)
                return u121.TransformEach(p123);
            end);
        end,
        Validate = function(p124) --[[ Name: Validate, Line 456 ]]
            -- upvalues: u121 (ref), u1 (ref)
            if u121.Length and #p124 > u121.Length then
                return false, ("Maximum of %d values allowed in sequence"):format(u121.Length);
            end;
            for v125 = 1, u121.Length or #p124 do
                u1.Work();
                local v126, v127 = u121.ValidateEach(p124[v125], v125);
                if not v126 then
                    return false, v127;
                end;
            end;
            return true;
        end,
        Parse = u121.Parse or function(p128) --[[ Line: 472 ]]
            -- upvalues: u121 (ref)
            return u121.Constructor(unpack(p128));
        end
    };
end;
function u1.SplitPrioritizedDelimeter(p129, p130) --[[ Line: 480 ]]
    -- upvalues: u1 (copy)
    for v131, v132 in ipairs(p130) do
        u1.Work();
        if p129:find(v132) or v131 == #p130 then
            return u1.SplitStringSimple(p129, v132);
        end;
    end;
end;
function u1.Map(p133, p134) --[[ Line: 489 ]]
    -- upvalues: u1 (copy)
    local v135 = {};
    for v136, v137 in ipairs(p133) do
        u1.Work();
        v135[v136] = p134(v137, v136);
    end;
    return v135;
end;
function u1.Each(p138, ...) --[[ Line: 500 ]]
    -- upvalues: u1 (copy)
    local v139 = {};
    for v140, v141 in ipairs({ ... }) do
        u1.Work();
        v139[v140] = p138(v141);
    end;
    return unpack(v139);
end;
function u1.EmulateTabstops(p142, p143) --[[ Line: 509 ]]
    -- upvalues: u1 (copy)
    local v144 = "";
    for v145 = 1, #p142 do
        u1.Work();
        local v146 = p142:sub(v145, v145);
        if v146 == "\t" then
            v146 = string.rep(" ", p143 - #v144 % p143) or v146;
        end;
        v144 = v144 .. v146;
    end;
    return v144;
end;
function u1.Mutex() --[[ Line: 519 ]]
    local u147 = {};
    local u148 = false;
    return function() --[[ Line: 523 ]]
        -- upvalues: u148 (ref), u147 (copy)
        if u148 then
            table.insert(u147, coroutine.running());
            coroutine.yield();
        else
            u148 = true;
        end;
        return function() --[[ Line: 531 ]]
            -- upvalues: u147 (ref), u148 (ref)
            if #u147 > 0 then
                coroutine.resume(table.remove(u147, 1));
            else
                u148 = false;
            end;
        end;
    end;
end;
return u1;
