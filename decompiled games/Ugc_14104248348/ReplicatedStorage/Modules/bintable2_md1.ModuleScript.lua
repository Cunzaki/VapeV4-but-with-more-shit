-- Decompiled from: ReplicatedStorage.Modules.bintable2_md1
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__StreamTools__1 = script.StreamTools;
local l__StringStream__2 = require(l__StreamTools__1.StringStream);
require(l__StreamTools__1.ULEB128Stream);
local l__PrefixSizeBlockStream__3 = require(l__StreamTools__1.PrefixSizeBlockStream);
local l__DictionaryLookupStream__4 = require(l__StreamTools__1.DictionaryLookupStream);
local l__EncodeDecodeTypes__5 = require(script.EncodeDecodeTypes);
local u1 = {
    Types = l__DictionaryLookupStream__4.Create({
        "Deep",
        "Array",
        "UnknownIndex",
        "Union",
        "number",
        "boolean",
        "string",
        "dint",
        "dfloat",
        "duint",
        "dufloat",
        "float",
        "int"
    }),
    DefaultDict = (function() --[[ Line: 12 ]]
        -- upvalues: l__DictionaryLookupStream__4 (copy)
        return {
            Deep = {},
            ValueType = {},
            PrefixList = l__DictionaryLookupStream__4.Create({
                {
                    End = true
                },
                {
                    Index = true
                }
            })
        };
    end)(),
    Base = {}
};
local u42 = {
    EncodeTablePortion = function(_, p2, p3, p4, _) --[[ Name: EncodeTablePortion, Line 46 ]]
        -- upvalues: l__DictionaryLookupStream__4 (copy), l__EncodeDecodeTypes__5 (copy)
        for v5, v6 in p3 do
            local v7 = p4.ValueType[v5];
            l__DictionaryLookupStream__4.Write(p2, p4.PrefixList, v5);
            if v7 == "Union" then
                l__DictionaryLookupStream__4.Write(p2, p4.Deep[v5], v6);
            else
                l__EncodeDecodeTypes__5:EncodeStream(p2, v7, v6);
            end;
        end;
    end,
    DecodeTablePortion = function(p8, p9, p10) --[[ Name: DecodeTablePortion, Line 60 ]]
        -- upvalues: l__StringStream__2 (copy), l__DictionaryLookupStream__4 (copy), u1 (copy), l__EncodeDecodeTypes__5 (copy), l__PrefixSizeBlockStream__3 (copy)
        local v11 = p10.Settings or p8.GlobalSettings;
        local l__ValueType__6 = p10.ValueType;
        local l__PrefixList__7 = p10.PrefixList;
        local l__Deep__8 = p10.Deep;
        local v12 = {};
        while not l__StringStream__2.EOF(p9) do
            local v13 = l__DictionaryLookupStream__4.Read(p9, l__PrefixList__7);
            local v14 = l__ValueType__6[v13];
            if type(v13) == "table" then
                if v13.End then
                    return v12;
                end;
                if v13.Index then
                    v13 = l__EncodeDecodeTypes__5:DecodeStream(p9, (l__DictionaryLookupStream__4.Read(p9, u1.Types)));
                    v14 = l__DictionaryLookupStream__4.Read(p9, u1.Types);
                    if v14 == "UnknownIndex" then
                        local v15 = l__PrefixSizeBlockStream__3.Read(p9);
                        local v16 = l__StringStream__2.fromString(nil, v15);
                        v12[v13] = v11.UnknownIndexSchema:DecodeTablePortion(v16, v11.UnknownIndexSchema.Dict);
                    end;
                end;
            end;
            if v14 == "Deep" then
                local v17 = l__PrefixSizeBlockStream__3.Read(p9);
                v12[v13] = p8:DecodeTablePortion(l__StringStream__2.fromString(nil, v17), l__Deep__8[v13]);
            elseif v14 == "Array" then
                local v18 = l__Deep__8[v13];
                local v19 = l__PrefixSizeBlockStream__3.Read(p9);
                local v20 = l__StringStream__2.fromString(nil, v19);
                v20.Name = "DebugArrayDepth";
                local v21 = {};
                while not l__StringStream__2.EOF(v20) do
                    if type(v18.Type) == "table" then
                        if v18.SubType == "Union" then
                            table.insert(v21, l__DictionaryLookupStream__4.Read(v20, v18.Type));
                        else
                            local v22 = p8:DecodeTablePortion(v20, v18.Type);
                            table.insert(v21, v22);
                        end;
                    else
                        local v23 = l__EncodeDecodeTypes__5:DecodeStream(v20, l__Deep__8[v13].Type);
                        table.insert(v21, v23);
                    end;
                end;
                v12[v13] = v21;
            elseif v14 ~= "UnknownIndex" then
                if v14 == "Union" then
                    v12[v13] = l__DictionaryLookupStream__4.Read(p9, l__Deep__8[v13]);
                else
                    v12[v13] = l__EncodeDecodeTypes__5:DecodeStream(p9, v14);
                end;
            end;
        end;
        return v12;
    end,
    Encode = function(p24, p25) --[[ Name: Encode, Line 128 ]]
        -- upvalues: l__StringStream__2 (copy), u1 (copy)
        local v26 = l__StringStream__2.new(u1.Base);
        p24:EncodeTablePortion(v26, p25, p24.Dict);
        return v26.Buffer;
    end,
    Decode = function(p27, p28) --[[ Name: Decode, Line 134 ]]
        -- upvalues: l__StringStream__2 (copy), u1 (copy)
        return p27:DecodeTablePortion(l__StringStream__2.fromString(u1.Base, p28), p27.Dict);
    end,
    SetGlobalSettings = function(p29, p30) --[[ Name: SetGlobalSettings, Line 139 ]]
        p29.GlobalSettings = p30.Settings;
    end,
    HandleArrayDef = function(p31, p32) --[[ Name: HandleArrayDef, Line 143 ]]
        -- upvalues: l__DictionaryLookupStream__4 (copy)
        if type(p32) == "string" then
            return {
                Array = true,
                Type = p32
            };
        end;
        if type(p32) == "table" then
            return p32["\0Union"] and {
                Array = true,
                SubType = "Union",
                Type = l__DictionaryLookupStream__4.Create(p32["\0Union"])
            } or {
                Array = true,
                Type = p31:HandleTableDefs(p32)
            };
        end;
    end,
    HandleTableDefs = function(p33, p34) --[[ Name: HandleTableDefs, Line 165 ]]
        -- upvalues: l__DictionaryLookupStream__4 (copy)
        local v35 = {};
        table.insert(v35, {
            End = true
        });
        table.insert(v35, {
            Index = true
        });
        local v36 = {
            Deep = {},
            ValueType = {}
        };
        for _, v37 in p34 do
            local v38 = type(v37) == "table";
            assert(v38, "TableDef must be a table Are you using TableBin.Index()?");
            if v37.Settings then
                v36.Settings = v37.Settings;
            else
                local v39 = v37[1];
                local v40 = v37[2];
                table.insert(v35, v39);
                if type(v40) == "table" then
                    if v40["\0Union"] then
                        v36.Deep[v39] = l__DictionaryLookupStream__4.Create(v40["\0Union"]);
                    elseif v40["\0Array"] then
                        v36.Deep[v39] = p33:HandleArrayDef(v40.Value);
                    else
                        v36.Deep[v39] = p33:HandleTableDefs(v40);
                    end;
                end;
                if type(v40) == "table" then
                    if v40["\0Union"] then
                        v36.ValueType[v39] = "Union";
                    elseif v40["\0Array"] then
                        v36.ValueType[v39] = "Array";
                    else
                        v36.ValueType[v39] = "Deep";
                    end;
                else
                    v36.ValueType[v39] = v40;
                end;
            end;
        end;
        v36.PrefixList = l__DictionaryLookupStream__4.Create(v35);
        return v36;
    end,
    Build = function(p41) --[[ Name: Build, Line 216 ]]
        p41.Dict = p41:HandleTableDefs(p41.StaticSchema);
    end
};
function u1.Union(p43) --[[ Line: 220 ]]
    local v44 = type(p43) == "table";
    assert(v44, "Union must be an array of types!");
    return {
        ["\0Union"] = p43
    };
end;
function u1.Settings(p45) --[[ Line: 227 ]]
    local v46 = type(p45) == "table";
    assert(v46, "Settings must be an table!");
    return {
        Settings = p45
    };
end;
function u1.ArrayIndex(p47, p48) --[[ Line: 234 ]]
    -- upvalues: l__EncodeDecodeTypes__5 (copy)
    local v49 = type(p47) ~= "table";
    assert(v49, "A table index cannot be a table!");
    if type(p48) ~= "table" then
        local v50 = l__EncodeDecodeTypes__5:ValidType(p48);
        local v51 = `'{p48}' is not a valid type!`;
        assert(v50, v51);
    end;
    return {
        p47,
        {
            ["\0Array"] = true,
            Value = p48
        }
    };
end;
function u1.Array(p52) --[[ Line: 247 ]]
    local v53 = type(p52) ~= "table";
    assert(v53, "A table index cannot be a table!");
    return {
        ["\0Array"] = true,
        Value = p52
    };
end;
function u1.Index(p54, p55) --[[ Line: 255 ]]
    -- upvalues: l__EncodeDecodeTypes__5 (copy)
    local v56 = type(p54) ~= "table";
    assert(v56, "A table index cannot be a table!");
    if type(p55) ~= "table" then
        local v57 = l__EncodeDecodeTypes__5:ValidType(p55);
        local v58 = `'{p55}' is not a valid type!`;
        assert(v57, v58);
    end;
    return { p54, p55 };
end;
function u1.newSchema(p59) --[[ Line: 264 ]]
    -- upvalues: u42 (copy)
    local v60 = setmetatable({
        StaticSchema = p59,
        GlobalSettings = {}
    }, {
        __index = u42
    });
    v60:Build();
    return v60;
end;
return u1;
