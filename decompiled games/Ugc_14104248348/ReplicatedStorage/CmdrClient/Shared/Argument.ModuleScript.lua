-- Decompiled from: ReplicatedStorage.CmdrClient.Shared.Argument
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Util__1 = require(script.Parent.Util);
local function u3(p1) --[[ Line: 3 ]]
    for _, v2 in ipairs({
        "%.",
        "%?",
        "%*",
        "%*%*"
    }) do
        p1 = p1:gsub("\\" .. v2, v2:gsub("%%", ""));
    end;
    return p1;
end;
local u4 = {};
u4.__index = u4;
function u4.new(p5, p6, p7) --[[ Line: 15 ]]
    -- upvalues: l__Util__1 (copy), u4 (copy)
    local v8 = {
        Type = nil,
        Prefix = "",
        TextSegmentInProgress = "",
        RawSegmentsAreAutocomplete = false,
        Command = p5,
        Name = p6.Name,
        Object = p6
    };
    local v9;
    if p6.Default == nil then
        v9 = p6.Optional ~= true;
    else
        v9 = false;
    end;
    v8.Required = v9;
    v8.Executor = p5.Executor;
    v8.RawValue = p7;
    v8.RawSegments = {};
    v8.TransformedValues = {};
    if type(p6.Type) == "table" then
        v8.Type = p6.Type;
    else
        local v10, v11, v12 = l__Util__1.ParsePrefixedUnionType(p5.Cmdr.Registry:GetTypeName(p6.Type), p7);
        v8.Type = p5.Dispatcher.Registry:GetType(v10);
        v8.RawValue = v11;
        v8.Prefix = v12;
        if v8.Type == nil then
            error(string.format("%s has an unregistered type %q", v8.Name or "<none>", v10 or "<none>"));
        end;
    end;
    setmetatable(v8, u4);
    v8:Transform();
    return v8;
end;
function u4.GetDefaultAutocomplete(p13) --[[ Line: 55 ]]
    if not p13.Type.Autocomplete then
        return {};
    end;
    local v14 = p13:TransformSegment("");
    local v15, v16 = p13.Type.Autocomplete(v14);
    return v15, v16 or {};
end;
function u4.Transform(p17) --[[ Line: 69 ]]
    -- upvalues: u3 (copy), l__Util__1 (copy)
    if #p17.TransformedValues == 0 then
        local l__RawValue__2 = p17.RawValue;
        if l__RawValue__2 == "." and p17.Type.Default then
            l__RawValue__2 = p17.Type.Default(p17.Executor) or "";
            p17.RawSegmentsAreAutocomplete = true;
        end;
        if l__RawValue__2 == "?" and p17.Type.Autocomplete then
            local v18, v19 = p17:GetDefaultAutocomplete();
            if not v19.IsPartial and #v18 > 0 then
                l__RawValue__2 = v18[math.random(1, #v18)];
                p17.RawSegmentsAreAutocomplete = true;
            end;
        end;
        if p17.Type.Listable and #p17.RawValue > 0 then
            local v20 = l__RawValue__2:match("^%?(%d+)$");
            if v20 then
                local v21 = tonumber(v20);
                if v21 and v21 > 0 then
                    local v22 = {};
                    local v23, v24 = p17:GetDefaultAutocomplete();
                    if not v24.IsPartial and #v23 > 0 then
                        for _ = 1, math.min(v21, #v23) do
                            table.insert(v22, table.remove(v23, math.random(1, #v23)));
                        end;
                        l__RawValue__2 = table.concat(v22, ",");
                        p17.RawSegmentsAreAutocomplete = true;
                    end;
                end;
            elseif l__RawValue__2 == "*" or l__RawValue__2 == "**" then
                local v25, v26 = p17:GetDefaultAutocomplete();
                if not v26.IsPartial and #v25 > 0 then
                    if l__RawValue__2 == "**" and p17.Type.Default then
                        local v27 = p17.Type.Default(p17.Executor) or "";
                        for v28, v29 in ipairs(v25) do
                            if v29 == v27 then
                                table.remove(v25, v28);
                            end;
                        end;
                    end;
                    l__RawValue__2 = table.concat(v25, ",");
                    p17.RawSegmentsAreAutocomplete = true;
                end;
            end;
            local v30 = u3(l__RawValue__2);
            local v31 = l__Util__1.SplitStringSimple(v30, ",");
            local v32 = #v31 == 0 and { "" } or v31;
            if v30:sub(#v30, #v30) == "," then
                v32[#v32 + 1] = "";
            end;
            for v33, v34 in ipairs(v32) do
                p17.RawSegments[v33] = v34;
                p17.TransformedValues[v33] = { p17:TransformSegment(v34) };
            end;
            p17.TextSegmentInProgress = v32[#v32];
        else
            local v35 = u3(l__RawValue__2);
            p17.RawSegments[1] = u3(v35);
            p17.TransformedValues[1] = { p17:TransformSegment(v35) };
            p17.TextSegmentInProgress = p17.RawValue;
        end;
    end;
end;
function u4.TransformSegment(p36, p37) --[[ Line: 158 ]]
    if p36.Type.Transform then
        return p36.Type.Transform(p37, p36.Executor);
    else
        return p37;
    end;
end;
function u4.GetTransformedValue(p38, p39) --[[ Line: 167 ]]
    return unpack(p38.TransformedValues[p39]);
end;
function u4.Validate(p40, p41) --[[ Line: 172 ]]
    if p40.RawValue == nil or #p40.RawValue == 0 and p40.Required == false then
        return true;
    end;
    if p40.Required and (p40.RawSegments[1] == nil or #p40.RawSegments[1] == 0) then
        return false, "This argument is required.";
    end;
    if not (p40.Type.Validate or p40.Type.ValidateOnce) then
        return true;
    end;
    for v42 = 1, #p40.TransformedValues do
        if p40.Type.Validate then
            local v43, v44 = p40.Type.Validate(p40:GetTransformedValue(v42));
            if not v43 then
                return v43, v44 or "Invalid value";
            end;
        end;
        if p41 and p40.Type.ValidateOnce then
            local v45, v46 = p40.Type.ValidateOnce(p40:GetTransformedValue(v42));
            if not v45 then
                return v45, v46;
            end;
        end;
    end;
    return true;
end;
function u4.GetAutocomplete(p47) --[[ Line: 207 ]]
    return not p47.Type.Autocomplete and {} or p47.Type.Autocomplete(p47:GetTransformedValue(#p47.TransformedValues));
end;
function u4.ParseValue(p48, p49) --[[ Line: 215 ]]
    if p48.Type.Parse then
        return p48.Type.Parse(p48:GetTransformedValue(p49));
    else
        return p48:GetTransformedValue(p49);
    end;
end;
function u4.GetValue(p50) --[[ Line: 224 ]]
    if #p50.RawValue == 0 and (not p50.Required and p50.Object.Default ~= nil) then
        return p50.Object.Default;
    end;
    if not p50.Type.Listable then
        return p50:ParseValue(1);
    end;
    local v51 = {};
    for v52 = 1, #p50.TransformedValues do
        local v53 = p50:ParseValue(v52);
        if type(v53) ~= "table" then
            error(("Listable types must return a table from Parse (%s)"):format(p50.Type.Name));
        end;
        for _, v54 in pairs(v53) do
            v51[v54] = true;
        end;
    end;
    local v55 = {};
    for v56 in pairs(v51) do
        v55[#v55 + 1] = v56;
    end;
    return v55;
end;
return u4;
