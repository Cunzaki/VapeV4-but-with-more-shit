-- Decompiled from: ReplicatedStorage.Modules.Mince.rbnsr
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    _IDENTITY = "rbnsr",
    _AUTHOR = "Whim#2127",
    _VERSION = "v0.1",
    _DESCRIPTION = "A Full Roblox DataType Serializer.",
    _LICENSE = "  MIT LICENSE\n    Copyright (c) 2022 Theron Akubuiro\n    Permission is hereby granted, free of charge, to any person obtaining a\n    copy of this software and associated documentation files (the\n    \"Software\"), to deal in the Software without restriction, including\n    without limitation the rights to use, copy, modify, merge, publish,\n    distribute, sublicense, and/or sell copies of the Software, and to\n    permit persons to whom the Software is furnished to do so, subject to\n    the following conditions:\n    The above copyright notice and this permission notice shall be included\n    in all copies or substantial portions of the Software.\n    THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS\n    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF\n    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.\n    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY\n    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,\n    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE\n    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n\t",
    Serialize = function(_) --[[ Name: Serialize, Line 26 ]] end,
    Deserialize = function(_) --[[ Name: Deserialize, Line 27 ]] end
};
function splitbyte(p2)
    local v3 = string.byte(p2);
    local v4 = 128;
    local v5 = {
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false
    };
    for v6 = 1, 8 do
        if v4 <= v3 then
            v3 = v3 - v4;
            v5[v6] = true;
        end;
        v4 = v4 / 2;
    end;
    return v5;
end;
function formbyte(...)
    local v7 = 0;
    for v8 = 1, 8 do
        if select(v8, ...) then
            v7 = v7 + 2 ^ (8 - v8);
        end;
    end;
    return string.char(v7);
end;
function deflate(p9, ...)
    return string.pack(string.rep(p9 or "f", #{ ... }), ...);
end;
function flate(p10, p11, p12)
    return string.unpack(string.rep(p10 or "f", p12), p11);
end;
function getNativeSize(p13)
    return #string.pack(p13 or "f", 1);
end;
local function v18(p14, p15) --[[ Line: 68 ]]
    local v16 = {};
    for _, v17 in ipairs(p15:GetEnumItems()) do
        v16[v17.Value] = v17;
    end;
    p14[p15] = v16;
end;
local u19 = {};
local function u21(p20, ...) --[[ Line: 31 ]]
    -- upvalues: u1 (copy)
    warn("[" .. u1._IDENTITY .. " " .. u1._VERSION .. "]" .. p20 .. ":", ...);
end;
for _, v22 in ipairs(Enum:GetEnums()) do
    v18(u19, v22);
end;
local u23 = {
    ValueHeader = {
        __Pattern = "I1",
        Invalid = 0,
        StaticIndexStaticValue = 1,
        StaticIndexObjectValue = 2,
        ObjectIndexStaticValue = 3,
        ObjectIndexObjectValue = 4
    },
    DataType = {
        __Pattern = "I1",
        Invalid = 0,
        Axes = 1,
        BrickColor = 2,
        CatalogSearchParams = 3,
        CFrame = 4,
        Color3 = 5,
        ColorSequence = 6,
        ColorSequenceKeypoint = 7,
        DateTime = 8,
        DockWidgetPluginGuiInfo = 9,
        Enum = 10,
        EnumItem = 11,
        Enums = 12,
        Faces = 13,
        FloatCurveKey = 14,
        Instance = 15,
        NumberRange = 16,
        NumberSequence = 17,
        NumberSequenceKeypoint = 18,
        OverlapParams = 19,
        PathWaypoint = 20,
        PhysicalProperties = 21,
        Random = 22,
        Ray = 23,
        RaycastParams = 24,
        RaycastResult = 25,
        RBXScriptConnection = 26,
        RBXScriptSignal = 27,
        Rect = 28,
        Region3 = 29,
        Region3int16 = 30,
        TweenInfo = 31,
        UDim = 32,
        UDim2 = 33,
        Vector2 = 34,
        Vector2int16 = 35,
        Vector3 = 36,
        Vector3int16 = 37,
        string = 38,
        bool = 39,
        int = 40,
        float = 41,
        double = 42,
        number = 43,
        table = 255
    }
};
local u24 = {};
local u187 = {
    ColorSequence = function(p25, p26) --[[ Line: 84 ]]
        if p25 then
            string.packsize("f I1 I1 I1");
            local v27 = "";
            for _, v28 in ipairs(p26.Keypoints) do
                local l__Value__1 = v28.Value;
                local v29 = math.floor(l__Value__1.R * 255);
                local v30 = math.floor(l__Value__1.G * 255);
                local v31 = math.floor(l__Value__1.B * 255);
                v27 = v27 .. string.pack("f I1 I1 I1", v28.Time, v29, v30, v31);
            end;
            return v27;
        else
            local v32 = string.packsize("f I1 I1 I1");
            local v33 = {};
            for v34 = 1, #p26, v32 do
                local v35 = p26:sub(v34, v34 + v32);
                local v36, v37, v38, v39 = string.unpack("f I1 I1 I1", v35);
                table.insert(v33, ColorSequenceKeypoint.new(v36, Color3.new(v37 / 255, v38 / 255, v39 / 255)));
            end;
            return ColorSequence.new(v33);
        end;
    end,
    ColorSequenceKeypoint = function(p40, p41) --[[ Line: 107 ]]
        if not p40 then
            local v42, v43, v44, v45 = string.unpack("f I1 I1 I1", p41);
            return ColorSequenceKeypoint.new(v42, Color3.new(v43 / 255, v44 / 255, v45 / 255));
        end;
        local l__Value__2 = p41.Value;
        local v46 = math.floor(l__Value__2.R * 255);
        local v47 = math.floor(l__Value__2.G * 255);
        local v48 = math.floor(l__Value__2.B * 255);
        return string.pack("f I1 I1 I1", p41.Time, v46, v47, v48);
    end,
    NumberSequence = function(p49, p50) --[[ Line: 117 ]]
        if p49 then
            local _ = getNativeSize(nil) * 3;
            local v51 = "";
            for _, v52 in ipairs(p50.Keypoints) do
                v51 = v51 .. deflate(nil, v52.Time, v52.Value, v52.Envelope);
            end;
            return v51;
        else
            local v53 = getNativeSize(nil) * 3;
            local v54 = {};
            for v55 = 1, #p50, v53 do
                local v56 = p50:sub(v55, v55 + v53);
                local v57, v58, v59 = flate(nil, v56, 3);
                table.insert(v54, NumberSequenceKeypoint.new(v57, v58, v59));
            end;
            return NumberSequence.new(v54);
        end;
    end,
    NumberSequenceKeypoint = function(p60, p61) --[[ Line: 141 ]]
        if p60 then
            return deflate(nil, p61.Time, p61.Value, p61.Envelope);
        end;
        local v62, v63, v64 = flate(nil, p61, 3);
        return NumberSequenceKeypoint.new(v62, v63, v64);
    end,
    Rect = function(p65, p66) --[[ Line: 149 ]]
        if p65 then
            return deflate(nil, p66.Min.X, p66.Min.Y, p66.Max.X, p66.Max.Y);
        end;
        local v67, v68, v69, v70 = flate(nil, p66, 4);
        return Rect.new(v67, v68, v69, v70);
    end,
    Ray = function(p71, p72) --[[ Line: 157 ]]
        if p71 then
            return deflate(nil, p72.Orgin.X, p72.Orgin.Y, p72.Orgin.Z, p72.Direction.X, p72.Direction.Y, p72.Direction.Z);
        end;
        local v73, v74, v75, v76, v77, v78 = flate(nil, p72, 6);
        return Ray.new((Vector3.new(v73, v74, v75, v76, v77, v78)));
    end,
    PhysicalProperties = function(p79, p80) --[[ Line: 165 ]]
        if p79 then
            return deflate(nil, p80.Density, p80.Friction, p80.Elasticity, p80.FrictionWeight, p80.ElasticityWeight);
        end;
        local v81, v82, v83, v84, v85 = flate(nil, p80, 5);
        return PhysicalProperties.new(v81, v82, v83, v84, v85);
    end,
    NumberRange = function(p86, p87) --[[ Line: 174 ]]
        if p86 then
            return deflate(nil, p87.Min, p87.Max);
        end;
        local v88, v89 = flate(nil, p87, 2);
        return NumberRange.new(v88, v89);
    end,
    UDim = function(p90, p91) --[[ Line: 182 ]]
        if p90 then
            return deflate(nil, p91.Scale, p91.Offset);
        end;
        local v92, v93 = flate(nil, p91, 2);
        return UDim2.new(v92, v93);
    end,
    Color3 = function(p94, p95) --[[ Line: 190 ]]
        if not p94 then
            local v96, v97, v98 = flate("I1", p95, 3);
            return Color3.new(v96 / 255, v97 / 255, v98 / 255);
        end;
        local v99 = math.round(p95.R * 255);
        local v100 = math.round(p95.G * 255);
        local v101 = math.round(p95.B * 255);
        return deflate("I1", v99, v100, v101);
    end,
    UDim2 = function(p102, p103) --[[ Line: 200 ]]
        if p102 then
            return deflate(nil, p103.X.Scale, p103.X.Offset, p103.Y.Scale, p103.Y.Offset);
        end;
        local v104, v105, v106, v107 = flate(nil, p103, 4);
        return UDim2.new(v104, v105, v106, v107);
    end,
    Vector3 = function(p108, p109) --[[ Line: 208 ]]
        if not p108 then
            local v110, v111, v112 = flate(nil, p109, 3);
            return Vector3.new(v110, v111, v112);
        end;
        if p109 then
            return deflate(nil, p109.X, p109.Y, p109.Z);
        end;
    end,
    Vector3int16 = function(p113, p114) --[[ Line: 218 ]]
        if not p113 then
            local v115, v116, v117 = flate("i2", p114, 3);
            return Vector3.new(v115, v116, v117);
        end;
        if p114 then
            return deflate("i2", p114.X, p114.Y, p114.Z);
        end;
    end,
    Vector2 = function(p118, p119) --[[ Line: 228 ]]
        if not p118 then
            local v120, v121 = flate(nil, p119, 2);
            return Vector2.new(v120, v121);
        end;
        if p119 then
            return deflate(nil, p119.X, p119.Y);
        end;
    end,
    Vector2int16 = function(p122, p123) --[[ Line: 238 ]]
        if not p122 then
            local v124, v125 = flate("i2", p123, 2);
            return Vector2.new(v124, v125);
        end;
        if p123 then
            return deflate("i2", p123.X, p123.Y);
        end;
    end,
    Content = function(_, p126) --[[ Line: 248 ]]
        return p126;
    end,
    ProtectedString = function(_, p127) --[[ Line: 251 ]]
        return p127;
    end,
    string = function(_, p128) --[[ Line: 254 ]]
        return p128;
    end,
    bool = function(p129, p130) --[[ Line: 257 ]]
        if p129 then
            return ({
                [true] = "#",
                [false] = "$"
            })[p130];
        else
            return ({
                ["#"] = true,
                ["$"] = false
            })[p130];
        end;
    end,
    float = function(p131, p132) --[[ Line: 264 ]]
        if p131 then
            return deflate("f", p132);
        else
            return flate("f", p132, 1);
        end;
    end,
    double = function(p133, p134) --[[ Line: 272 ]]
        if p133 then
            return deflate("d", p134);
        else
            return flate("d", p134, 1);
        end;
    end,
    number = function(p135, p136) --[[ Line: 280 ]]
        if p135 then
            return deflate("n", p136);
        else
            return flate("n", p136, 1);
        end;
    end,
    table = function() --[[ Line: 288 ]]
        return "";
    end,
    int = function(p137, p138) --[[ Line: 291 ]]
        if p137 then
            return deflate("i", (math.floor(p138)));
        else
            return flate("i", p138, 1);
        end;
    end,
    int64 = function(p139, p140) --[[ Line: 299 ]]
        if p139 then
            return deflate("i8", (math.floor(p140)));
        else
            return flate("i8", p140, 1);
        end;
    end,
    SurfaceType = function(p141, p142) --[[ Line: 307 ]]
        -- upvalues: u19 (copy)
        if p141 then
            return deflate(nil, p142.Value);
        end;
        local v143 = flate(nil, p142, 1);
        return u19[Enum.SurfaceType][v143];
    end,
    BrickColor = function(p144, p145) --[[ Line: 315 ]]
        if p144 then
            return deflate(nil, (math.floor(p145.Number)));
        end;
        local v146 = flate(nil, p145, 1);
        return BrickColor.new(v146);
    end,
    Material = function(p147, p148) --[[ Line: 323 ]]
        -- upvalues: u19 (copy)
        if p147 then
            return deflate(nil, p148.Value);
        end;
        local v149 = flate(nil, p148, 1);
        return u19[Enum.Material][v149];
    end,
    Faces = function(p150, p151) --[[ Line: 331 ]]
        if p150 then
            local v152 = splitbyte("\0");
            for v153, v154 in ipairs(table.pack(p151.Top, p151.Bottom, p151.Left, p151.Right, p151.Back, p151.Front)) do
                v152[v153] = v154;
            end;
            return formbyte(p151);
        end;
        local v155 = splitbyte(p151);
        local v156 = {};
        for v157, v158 in ipairs(v155) do
            if v157 <= 5 then
                v156[v157] = v158;
            end;
        end;
        return Faces.new(table.unpack(v156));
    end,
    CFrame = function(p159, p160) --[[ Line: 350 ]]
        if p159 then
            return deflate(nil, p160:components());
        end;
        local v161, v162, v163, v164, v165, v166, v167, v168, v169, v170, v171, v172 = flate(nil, p160, 12);
        return CFrame.new(v161, v162, v163, v164, v165, v166, v167, v168, v169, v170, v171, v172);
    end,
    CoordinateFrame = function(p173, p174) --[[ Line: 359 ]]
        if p173 then
            return deflate(nil, p174:components());
        end;
        local v175, v176, v177, v178, v179, v180, v181, v182, v183, v184, v185, v186 = flate(nil, p174, 12);
        return CFrame.new(v175, v176, v177, v178, v179, v180, v181, v182, v183, v184, v185, v186);
    end
};
for v188, v189 in pairs(u23) do
    u24[v188] = {};
    for v190, v191 in pairs(v189) do
        u24[v188][v191] = v190;
    end;
end;
local u192 = {};
local u193 = {};
local function u199(p194, p195) --[[ Line: 463 ]]
    local v196 = string.packsize("I2");
    local v197 = string.unpack("I2", p194:sub(p195, p195 + v196));
    local v198 = p194:sub(p195 + v196, p195 + v196 + v197 - 1);
    return p195 + v196 + v197, v198;
end;
for v200 = 1, 91 do
    u192[v200 - 1] = string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,./:;<=>?@[]^_`{|}~\"", v200, v200);
    u193[string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,./:;<=>?@[]^_`{|}~\"", v200, v200)] = v200 - 1;
end;
local l__char__3 = string.char;
local u201 = type;
local _ = select;
local l__sub__4 = string.sub;
local l__concat__5 = table.concat;
local u202 = {};
local u203 = {};
local u224 = {
    encode = function(p204) --[[ Name: encodeBase91, Line 518 ]]
        -- upvalues: u192 (copy)
        local v205 = 0;
        local v206 = 0;
        local v207 = {};
        local v208 = 1;
        for v209 = 1, #p204 do
            local v210 = string.byte(p204, v209);
            local v211 = bit32.lshift(v210, v205);
            v206 = bit32.bor(v206, v211);
            v205 = v205 + 8;
            if v205 > 13 then
                local v212 = bit32.band(v206, 8191);
                if v212 > 88 then
                    v206 = bit32.rshift(v206, 13);
                    v205 = v205 - 13;
                else
                    v212 = bit32.band(v206, 16383);
                    v206 = bit32.rshift(v206, 14);
                    v205 = v205 - 14;
                end;
                v207[v208] = u192[v212 % 91] .. u192[math.floor(v212 / 91)];
                v208 = v208 + 1;
            end;
        end;
        if v205 > 0 then
            v207[v208] = u192[v206 % 91];
            if v205 > 7 or v206 > 90 then
                v207[v208 + 1] = u192[math.floor(v206 / 91)];
            end;
        end;
        return table.concat(v207);
    end,
    decode = function(p213) --[[ Name: decodeBase91, Line 553 ]]
        -- upvalues: u193 (copy)
        local v214 = 1;
        local v215 = -1;
        local v216 = 0;
        local v217 = 0;
        local v218 = {};
        for v219 = 1, #p213 do
            if u193[string.sub(p213, v219, v219)] then
                if v215 == -1 then
                    v215 = u193[string.sub(p213, v219, v219)];
                else
                    local v220 = v215 + u193[string.sub(p213, v219, v219)] * 91;
                    local v221 = bit32.lshift(v220, v216);
                    v217 = bit32.bor(v217, v221);
                    if bit32.band(v220, 8191) > 88 then
                        v216 = v216 + 13;
                    else
                        v216 = v216 + 14;
                    end;
                    while v216 > 7 do
                        v218[v214] = string.char(v217 % 256);
                        v214 = v214 + 1;
                        v217 = bit32.rshift(v217, 8);
                        v216 = v216 - 8;
                    end;
                    v215 = -1;
                end;
            end;
        end;
        if v215 ~= -1 then
            local v222 = bit32.lshift(v215, v216);
            local v223 = bit32.bor(v217, v222) % 256;
            v218[v214] = string.char(v223);
        end;
        return table.concat(v218);
    end
};
for v225 = 0, 255 do
    local v226 = l__char__3(v225);
    local v227 = l__char__3(v225, 0);
    u202[v226] = v227;
    u203[v227] = v226;
end;
local u259 = {
    compress = function(p228) --[[ Name: compress, Line 630 ]]
        -- upvalues: u201 (copy), l__sub__4 (copy), u202 (copy), l__char__3 (copy), l__concat__5 (copy)
        if u201(p228) == "string" then
            local v229 = #p228;
            if v229 <= 1 then
                return "u" .. p228;
            else
                local v230 = "";
                local v231 = {};
                local v232 = 1;
                local v233 = { "c" };
                local v234 = 2;
                local v235 = 1;
                local v236 = 0;
                for v237 = 1, v229 do
                    local v238 = l__sub__4(p228, v237, v237);
                    local v239 = v230 .. v238;
                    if u202[v239] or v231[v239] then
                        v230 = v239;
                    else
                        local v240 = u202[v230] or v231[v230];
                        if not v240 then
                            return nil, "algorithm error, could not fetch word";
                        end;
                        v233[v234] = v240;
                        v235 = v235 + #v240;
                        v234 = v234 + 1;
                        if v229 <= v235 then
                            return "u" .. p228;
                        end;
                        if v236 >= 256 then
                            v236 = 0;
                            v232 = v232 + 1;
                            if v232 >= 256 then
                                v232 = 1;
                                v231 = {};
                            end;
                        end;
                        v231[v239] = l__char__3(v236, v232);
                        v236 = v236 + 1;
                        v230 = v238;
                    end;
                end;
                v233[v234] = u202[v230] or v231[v230];
                local v241 = v235 + #v233[v234];
                local _ = v234 + 1;
                if v229 <= v241 then
                    return "u" .. p228;
                else
                    return l__concat__5(v233);
                end;
            end;
        else
            return nil, "string expected, got " .. u201(p228);
        end;
    end,
    decompress = function(p242) --[[ Name: decompress, Line 688 ]]
        -- upvalues: u201 (copy), l__sub__4 (copy), u203 (copy), l__char__3 (copy), l__concat__5 (copy)
        if u201(p242) ~= "string" then
            return nil, "string expected, got " .. u201(p242);
        end;
        if #p242 < 1 then
            return nil, "invalid input - not a compressed string";
        end;
        local v243 = l__sub__4(p242, 1, 1);
        if v243 == "u" then
            return l__sub__4(p242, 2);
        end;
        if v243 ~= "c" then
            return nil, "invalid input - not a compressed string";
        end;
        local v244 = l__sub__4(p242, 2);
        local v245 = #v244;
        if v245 < 2 then
            return nil, "invalid input - not a compressed string";
        end;
        local v246 = {};
        local v247 = {};
        local v248 = 1;
        local v249 = l__sub__4(v244, 1, 2);
        v247[v248] = u203[v249] or v246[v249];
        local v250 = v248 + 1;
        local v251 = 0;
        local v252 = 1;
        for v253 = 3, v245, 2 do
            local v254 = l__sub__4(v244, v253, v253 + 1);
            local v255 = u203[v249] or v246[v249];
            if not v255 then
                return nil, "could not find last from dict. Invalid input?";
            end;
            local v256 = u203[v254] or v246[v254];
            if v256 then
                v247[v250] = v256;
                v250 = v250 + 1;
                local v257 = v255 .. l__sub__4(v256, 1, 1);
                if v251 >= 256 then
                    v251 = 0;
                    v252 = v252 + 1;
                    if v252 >= 256 then
                        v252 = 1;
                        v246 = {};
                    end;
                end;
                v246[l__char__3(v251, v252)] = v257;
                v251 = v251 + 1;
            else
                local v258 = v255 .. l__sub__4(v255, 1, 1);
                v247[v250] = v258;
                v250 = v250 + 1;
                if v251 >= 256 then
                    v251 = 0;
                    v252 = v252 + 1;
                    if v252 >= 256 then
                        v252 = 1;
                        v246 = {};
                    end;
                end;
                v246[l__char__3(v251, v252)] = v258;
                v251 = v251 + 1;
            end;
            v249 = v254;
        end;
        return l__concat__5(v247);
    end
};
local function u306(p260) --[[ Line: 772 ]]
    -- upvalues: u187 (copy), u306 (copy), u23 (copy), u21 (copy)
    local v261 = "";
    for v262, v263 in pairs(p260) do
        local v264 = typeof(v262);
        local v265 = typeof(v263);
        local v266 = u187[typeof(v262)];
        local v267;
        if v266 then
            v267 = v266(true, v262);
            if v267 == nil then
                v267 = nil;
            end;
        else
            v267 = nil;
        end;
        local v268 = u187[typeof(v263)];
        local v269;
        if v268 then
            v269 = v268(true, v263);
            if v269 == nil then
                v269 = nil;
            end;
        else
            v269 = nil;
        end;
        if v265 == "table" then
            if v264 == "table" then
                local v270 = u306(v262);
                local v271 = u306(v263);
                local l__ValueHeader__6 = u23.ValueHeader;
                local v272;
                if l__ValueHeader__6 and l__ValueHeader__6.ObjectIndexObjectValue then
                    v272 = string.pack(l__ValueHeader__6.__Pattern, l__ValueHeader__6.ObjectIndexObjectValue);
                else
                    u21("[Binary]", "Could not describe", "ValueHeader", "ObjectIndexObjectValue");
                    v272 = 0;
                end;
                local l__Value2__7 = u23.Value2;
                local v273;
                if l__Value2__7 and l__Value2__7[v270] then
                    v273 = string.pack(l__Value2__7.__Pattern, l__Value2__7[v270]);
                else
                    local v274 = tostring(v270);
                    local v275 = #v274;
                    if v275 > 65535 then
                        u21("[Binary]", "Value2 Cannot Encode DataValues more than 65,535 Bytes.");
                        v273 = nil;
                    else
                        v273 = string.pack("I2", v275) .. v274 or 0;
                    end;
                end;
                local l__Value2__8 = u23.Value2;
                local v276;
                if l__Value2__8 and l__Value2__8[v271] then
                    v276 = string.pack(l__Value2__8.__Pattern, l__Value2__8[v271]);
                else
                    local v277 = tostring(v271);
                    local v278 = #v277;
                    if v278 > 65535 then
                        u21("[Binary]", "Value2 Cannot Encode DataValues more than 65,535 Bytes.");
                        v276 = nil;
                    else
                        v276 = string.pack("I2", v278) .. v277 or 0;
                    end;
                end;
                v261 = v261 .. v272 .. v273 .. v276;
            else
                local v279 = u306(v263);
                local l__ValueHeader__9 = u23.ValueHeader;
                local v280;
                if l__ValueHeader__9 and l__ValueHeader__9.StaticIndexObjectValue then
                    v280 = string.pack(l__ValueHeader__9.__Pattern, l__ValueHeader__9.StaticIndexObjectValue);
                else
                    u21("[Binary]", "Could not describe", "ValueHeader", "StaticIndexObjectValue");
                    v280 = 0;
                end;
                local l__DataType__10 = u23.DataType;
                local v281;
                if l__DataType__10 and l__DataType__10[v264] then
                    v281 = string.pack(l__DataType__10.__Pattern, l__DataType__10[v264]);
                else
                    u21("[Binary]", "Could not describe", "DataType", v264);
                    v281 = 0;
                end;
                local l__Value2__11 = u23.Value2;
                local v282;
                if l__Value2__11 and l__Value2__11[v267] then
                    v282 = string.pack(l__Value2__11.__Pattern, l__Value2__11[v267]);
                else
                    local v283 = tostring(v267);
                    local v284 = #v283;
                    if v284 > 65535 then
                        u21("[Binary]", "Value2 Cannot Encode DataValues more than 65,535 Bytes.");
                        v282 = nil;
                    else
                        v282 = string.pack("I2", v284) .. v283 or 0;
                    end;
                end;
                local l__Value2__12 = u23.Value2;
                local v285;
                if l__Value2__12 and l__Value2__12[v279] then
                    v285 = string.pack(l__Value2__12.__Pattern, l__Value2__12[v279]);
                else
                    local v286 = tostring(v279);
                    local v287 = #v286;
                    if v287 > 65535 then
                        u21("[Binary]", "Value2 Cannot Encode DataValues more than 65,535 Bytes.");
                        v285 = nil;
                    else
                        v285 = string.pack("I2", v287) .. v286 or 0;
                    end;
                end;
                v261 = v261 .. v280 .. v281 .. v282 .. v285;
            end;
        elseif v267 == nil or v269 == nil then
            u21("[Encode]", "Failure to encode values, doesnt match a siganture.");
        elseif v264 == "table" then
            local v288 = u306(v262);
            local l__ValueHeader__13 = u23.ValueHeader;
            local v289;
            if l__ValueHeader__13 and l__ValueHeader__13.ObjectIndexStaticValue then
                v289 = string.pack(l__ValueHeader__13.__Pattern, l__ValueHeader__13.ObjectIndexStaticValue);
            else
                u21("[Binary]", "Could not describe", "ValueHeader", "ObjectIndexStaticValue");
                v289 = 0;
            end;
            local l__Value2__14 = u23.Value2;
            local v290;
            if l__Value2__14 and l__Value2__14[v288] then
                v290 = string.pack(l__Value2__14.__Pattern, l__Value2__14[v288]);
            else
                local v291 = tostring(v288);
                local v292 = #v291;
                if v292 > 65535 then
                    u21("[Binary]", "Value2 Cannot Encode DataValues more than 65,535 Bytes.");
                    v290 = nil;
                else
                    v290 = string.pack("I2", v292) .. v291 or 0;
                end;
            end;
            local l__DataType__15 = u23.DataType;
            local v293;
            if l__DataType__15 and l__DataType__15[v265] then
                v293 = string.pack(l__DataType__15.__Pattern, l__DataType__15[v265]);
            else
                u21("[Binary]", "Could not describe", "DataType", v265);
                v293 = 0;
            end;
            local l__Value2__16 = u23.Value2;
            local v294;
            if l__Value2__16 and l__Value2__16[v269] then
                v294 = string.pack(l__Value2__16.__Pattern, l__Value2__16[v269]);
            else
                local v295 = tostring(v269);
                local v296 = #v295;
                if v296 > 65535 then
                    u21("[Binary]", "Value2 Cannot Encode DataValues more than 65,535 Bytes.");
                    v294 = nil;
                else
                    v294 = string.pack("I2", v296) .. v295 or 0;
                end;
            end;
            v261 = v261 .. v289 .. v290 .. v293 .. v294;
        else
            local l__ValueHeader__17 = u23.ValueHeader;
            local v297;
            if l__ValueHeader__17 and l__ValueHeader__17.StaticIndexStaticValue then
                v297 = string.pack(l__ValueHeader__17.__Pattern, l__ValueHeader__17.StaticIndexStaticValue);
            else
                u21("[Binary]", "Could not describe", "ValueHeader", "StaticIndexStaticValue");
                v297 = 0;
            end;
            local l__DataType__18 = u23.DataType;
            local v298;
            if l__DataType__18 and l__DataType__18[v264] then
                v298 = string.pack(l__DataType__18.__Pattern, l__DataType__18[v264]);
            else
                u21("[Binary]", "Could not describe", "DataType", v264);
                v298 = 0;
            end;
            local l__Value2__19 = u23.Value2;
            local v299;
            if l__Value2__19 and l__Value2__19[v267] then
                v299 = string.pack(l__Value2__19.__Pattern, l__Value2__19[v267]);
            else
                local v300 = tostring(v267);
                local v301 = #v300;
                if v301 > 65535 then
                    u21("[Binary]", "Value2 Cannot Encode DataValues more than 65,535 Bytes.");
                    v299 = nil;
                else
                    v299 = string.pack("I2", v301) .. v300 or 0;
                end;
            end;
            local l__DataType__20 = u23.DataType;
            local v302;
            if l__DataType__20 and l__DataType__20[v265] then
                v302 = string.pack(l__DataType__20.__Pattern, l__DataType__20[v265]);
            else
                u21("[Binary]", "Could not describe", "DataType", v265);
                v302 = 0;
            end;
            local l__Value2__21 = u23.Value2;
            local v303;
            if l__Value2__21 and l__Value2__21[v269] then
                v303 = string.pack(l__Value2__21.__Pattern, l__Value2__21[v269]);
            else
                local v304 = tostring(v269);
                local v305 = #v304;
                if v305 > 65535 then
                    u21("[Binary]", "Value2 Cannot Encode DataValues more than 65,535 Bytes.");
                    v303 = nil;
                else
                    v303 = string.pack("I2", v305) .. v304 or 0;
                end;
            end;
            v261 = v261 .. v297 .. v298 .. v299 .. v302 .. v303;
        end;
    end;
    return v261;
end;
local function u344(p307) --[[ Line: 825 ]]
    -- upvalues: u24 (copy), u23 (copy), u21 (copy), u199 (copy), u344 (copy), u187 (copy)
    local v308 = 0;
    local v309 = false;
    local v310 = {};
    while v308 < #p307 do
        local v311 = v308 + 1;
        local v312 = string.byte(p307:sub(v311, v311));
        local v313 = u24.ValueHeader[v312] or "Invalid" or "Invalid";
        local l__ValueHeader__22 = u23.ValueHeader;
        local v314;
        if l__ValueHeader__22 then
            v314 = string.packsize(l__ValueHeader__22.__Pattern);
        else
            u21("[Binary]", "Cannot get sizeof ", "ValueHeader");
            v314 = nil;
        end;
        v308 = v311 + v314;
        if v313 == "ObjectIndexObjectValue" then
            local v315, v316 = u199(p307, v308);
            local v317, v318 = u199(p307, v315);
            v308 = v317 - 1;
            v310[u344(v316)] = u344(v318);
            v309 = true;
        end;
        if v313 == "ObjectIndexStaticValue" then
            local v319, v320 = u199(p307, v308);
            local v321 = string.byte(p307:sub(v319, v319));
            local v322, v323 = u199(p307, v319 + 1);
            v308 = v322 - 1;
            local v324 = u344(v320);
            local v325 = u187[u24.DataType[v321] or "Invalid"];
            local v326;
            if v325 then
                v326 = v325(false, v323);
                if v326 == nil then
                    v326 = nil;
                end;
            else
                v326 = nil;
            end;
            v310[v324] = v326;
            v309 = true;
        end;
        if v313 == "StaticIndexObjectValue" then
            local v327 = string.byte(p307:sub(v308, v308));
            local v328, v329 = u199(p307, v308 + 1);
            local v330, v331 = u199(p307, v328);
            v308 = v330 - 1;
            local v332 = u187[u24.DataType[v327] or "Invalid"];
            local v333;
            if v332 then
                v333 = v332(false, v329);
                if v333 == nil then
                    v333 = nil;
                end;
            else
                v333 = nil;
            end;
            v310[v333] = u344(v331);
            v309 = true;
        end;
        if v313 == "StaticIndexStaticValue" then
            local v334 = string.byte(p307:sub(v308, v308));
            local v335, v336 = u199(p307, v308 + 1);
            local v337 = string.byte(p307:sub(v335, v335));
            local v338, v339 = u199(p307, v335 + 1);
            v308 = v338 - 1;
            local v340 = u187[u24.DataType[v334] or "Invalid"];
            local v341;
            if v340 then
                v341 = v340(false, v336);
                if v341 == nil then
                    v341 = nil;
                end;
            else
                v341 = nil;
            end;
            local v342 = u187[u24.DataType[v337] or "Invalid"];
            local v343;
            if v342 then
                v343 = v342(false, v339);
                if v343 == nil then
                    v343 = nil;
                end;
            else
                v343 = nil;
            end;
            v310[v341] = v343;
            v309 = true;
        end;
        if not v309 or v313 == "Invalid" then
            u21("[Binary]", "Failed while decoding : could not determine a valid ValueHeader [", v313, "]");
            return v310;
        end;
    end;
    return v310;
end;
function u1.Serialize(u345) --[[ Line: 910 ]]
    -- upvalues: u306 (copy), u224 (copy), u259 (copy)
    local v346, v347 = pcall(function() --[[ Line: 911 ]]
        -- upvalues: u306 (ref), u345 (copy)
        return u306(u345);
    end);
    if v346 then
        return u224.encode(u259.compress(v347));
    end;
    error(v347);
    return "";
end;
function u1.Deserialize(p348) --[[ Line: 922 ]]
    -- upvalues: u259 (copy), u224 (copy), u344 (copy)
    local u349 = u259.decompress(u224.decode(p348));
    local v350, v351 = pcall(function() --[[ Line: 924 ]]
        -- upvalues: u344 (ref), u349 (copy)
        return u344(u349);
    end);
    if v350 then
        return v351;
    end;
    error(v351);
    return {};
end;
return u1;
