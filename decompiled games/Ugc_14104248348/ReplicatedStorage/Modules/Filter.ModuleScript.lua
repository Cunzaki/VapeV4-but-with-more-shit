-- Decompiled from: ReplicatedStorage.Modules.Filter
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u3 = {
    Throw = error,
    Warn = warn,
    GetTypeOf = function(p1) --[[ Name: GetTypeOf, Line 15 ]]
        local v2 = typeof(p1);
        if v2 == "table" then
            return p1.__type or v2;
        else
            return v2;
        end;
    end
};
function u3.DoCompare(p4, p5) --[[ Line: 23 ]]
    -- upvalues: u3 (copy)
    return p5 == u3.GetTypeOf(p4);
end;
function u3.Type(u6) --[[ Line: 27 ]]
    return {
        __type = "typeof",
        Value = u6,
        __tostring = function() --[[ Name: __tostring, Line 31 ]]
            -- upvalues: u6 (copy)
            return u6;
        end
    };
end;
function u3.NewFilter(...) --[[ Line: 36 ]]
    -- upvalues: u3 (copy)
    local u7 = {};
    local u8 = { ... };
    return {
        AddRule = function(p9) --[[ Name: AddRule, Line 40 ]]
            -- upvalues: u7 (copy)
            if typeof(p9) == "function" then
                table.insert(u7, p9);
            end;
        end,
        FilterFunction = function(...) --[[ Name: FilterFunction, Line 45 ]]
            -- upvalues: u8 (copy), u3 (ref), u7 (copy)
            local v10 = { ... };
            local v11 = nil;
            if #u8 == #v10 then
                for v12 = 1, #u8 do
                    local v13 = u8[v12];
                    local v14 = v10[v12];
                    local v15 = u3.GetTypeOf(v14);
                    local v16 = u3.GetTypeOf(v13);
                    for _, v17 in ipairs(u7) do
                        if v17(v14) == false then
                            v11 = string.format("Filter rule function returned false at position[%i]", v12);
                            break;
                        end;
                    end;
                    if v16 == "typeof" then
                        if v13.Value ~= v15 then
                            v11 = string.format("Filter type mistmatch at position[%i] of %s. Value : %s ,", v12, v13.Value, v14);
                        end;
                    elseif v16 == "table" then
                        local v18 = false;
                        for _, v19 in ipairs(v13) do
                            u3.NewFilter(v19).FilterFunction(v14);
                            if u3.NewFilter(v19).FilterFunction(v14) then
                                v18 = true;
                            end;
                        end;
                        if not v18 then
                            v11 = string.format("No filter type match in matchtable at position[%i]", v12);
                        end;
                    elseif v16 == "function" then
                        if not v13(v14) then
                            v11 = string.format("Filter function returned false at position[%i]", v12);
                        end;
                    elseif v13 ~= v14 then
                        v11 = string.format("Filter value mistmatch at position[%i], must match %s", v12, (tostring(v14)));
                    end;
                end;
            else
                v11 = string.format("Typearray(%i) length mismtach param(%i)", #u8, #v10);
            end;
            if v11 == nil then
                return true;
            else
                return false, v11;
            end;
        end
    };
end;
function u3.Unpack() --[[ Line: 105 ]]
    -- upvalues: u3 (copy)
    return u3.Type, u3.NewFilter;
end;
return u3;
