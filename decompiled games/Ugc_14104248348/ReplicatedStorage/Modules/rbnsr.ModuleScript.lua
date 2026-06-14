-- Decompiled from: ReplicatedStorage.Modules.rbnsr
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
        boolean = 39,
        int = 40,
        float = 41,
        double = 42,
        number = 43,
        bool = 254,
        table = 255
    }
};
local u24 = {};
local u189 = {
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
    boolean = function(p131, p132) --[[ Line: 264 ]]
        if p131 then
            return ({
                [true] = "#",
                [false] = "$"
            })[p132];
        else
            return ({
                ["#"] = true,
                ["$"] = false
            })[p132];
        end;
    end,
    float = function(p133, p134) --[[ Line: 271 ]]
        if p133 then
            return deflate("f", p134);
        else
            return flate("f", p134, 1);
        end;
    end,
    double = function(p135, p136) --[[ Line: 279 ]]
        if p135 then
            return deflate("d", p136);
        else
            return flate("d", p136, 1);
        end;
    end,
    number = function(p137, p138) --[[ Line: 287 ]]
        if p137 then
            return deflate("n", p138);
        else
            return flate("n", p138, 1);
        end;
    end,
    table = function() --[[ Line: 295 ]]
        return "";
    end,
    int = function(p139, p140) --[[ Line: 298 ]]
        if p139 then
            return deflate("i", (math.floor(p140)));
        else
            return flate("i", p140, 1);
        end;
    end,
    int64 = function(p141, p142) --[[ Line: 306 ]]
        if p141 then
            return deflate("i8", (math.floor(p142)));
        else
            return flate("i8", p142, 1);
        end;
    end,
    SurfaceType = function(p143, p144) --[[ Line: 314 ]]
        -- upvalues: u19 (copy)
        if p143 then
            return deflate(nil, p144.Value);
        end;
        local v145 = flate(nil, p144, 1);
        return u19[Enum.SurfaceType][v145];
    end,
    BrickColor = function(p146, p147) --[[ Line: 322 ]]
        if p146 then
            return deflate(nil, (math.floor(p147.Number)));
        end;
        local v148 = flate(nil, p147, 1);
        return BrickColor.new(v148);
    end,
    Material = function(p149, p150) --[[ Line: 330 ]]
        -- upvalues: u19 (copy)
        if p149 then
            return deflate(nil, p150.Value);
        end;
        local v151 = flate(nil, p150, 1);
        return u19[Enum.Material][v151];
    end,
    Faces = function(p152, p153) --[[ Line: 338 ]]
        if p152 then
            local v154 = splitbyte("\0");
            for v155, v156 in ipairs(table.pack(p153.Top, p153.Bottom, p153.Left, p153.Right, p153.Back, p153.Front)) do
                v154[v155] = v156;
            end;
            return formbyte(p153);
        end;
        local v157 = splitbyte(p153);
        local v158 = {};
        for v159, v160 in ipairs(v157) do
            if v159 <= 5 then
                v158[v159] = v160;
            end;
        end;
        return Faces.new(table.unpack(v158));
    end,
    CFrame = function(p161, p162) --[[ Line: 357 ]]
        if p161 then
            return deflate(nil, p162:components());
        end;
        local v163, v164, v165, v166, v167, v168, v169, v170, v171, v172, v173, v174 = flate(nil, p162, 12);
        return CFrame.new(v163, v164, v165, v166, v167, v168, v169, v170, v171, v172, v173, v174);
    end,
    CoordinateFrame = function(p175, p176) --[[ Line: 366 ]]
        if p175 then
            return deflate(nil, p176:components());
        end;
        local v177, v178, v179, v180, v181, v182, v183, v184, v185, v186, v187, v188 = flate(nil, p176, 12);
        return CFrame.new(v177, v178, v179, v180, v181, v182, v183, v184, v185, v186, v187, v188);
    end
};
for v190, v191 in pairs(u23) do
    u24[v190] = {};
    for v192, v193 in pairs(v191) do
        u24[v190][v193] = v192;
    end;
end;
local u194 = {};
local u195 = {};
local function u201(p196, p197) --[[ Line: 471 ]]
    local v198 = string.packsize("I2");
    local v199 = string.unpack("I2", p196:sub(p197, p197 + v198));
    local v200 = p196:sub(p197 + v198, p197 + v198 + v199 - 1);
    return p197 + v198 + v199, v200;
end;
for v202 = 1, 91 do
    u194[v202 - 1] = string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,./:;<=>?@[]^_`{|}~\"", v202, v202);
    u195[string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,./:;<=>?@[]^_`{|}~\"", v202, v202)] = v202 - 1;
end;
local l__char__3 = string.char;
local u203 = type;
local _ = select;
local l__sub__4 = string.sub;
local l__concat__5 = table.concat;
local u204 = {};
local u205 = {};
local u226 = {
    encode = function(p206) --[[ Name: encodeBase91, Line 527 ]]
        -- upvalues: u194 (copy)
        local v207 = 0;
        local v208 = 0;
        local v209 = {};
        local v210 = 1;
        for v211 = 1, #p206 do
            local v212 = string.byte(p206, v211);
            local v213 = bit32.lshift(v212, v207);
            v208 = bit32.bor(v208, v213);
            v207 = v207 + 8;
            if v207 > 13 then
                local v214 = bit32.band(v208, 8191);
                if v214 > 88 then
                    v208 = bit32.rshift(v208, 13);
                    v207 = v207 - 13;
                else
                    v214 = bit32.band(v208, 16383);
                    v208 = bit32.rshift(v208, 14);
                    v207 = v207 - 14;
                end;
                v209[v210] = u194[v214 % 91] .. u194[math.floor(v214 / 91)];
                v210 = v210 + 1;
            end;
        end;
        if v207 > 0 then
            v209[v210] = u194[v208 % 91];
            if v207 > 7 or v208 > 90 then
                v209[v210 + 1] = u194[math.floor(v208 / 91)];
            end;
        end;
        return table.concat(v209);
    end,
    decode = function(p215) --[[ Name: decodeBase91, Line 562 ]]
        -- upvalues: u195 (copy)
        local v216 = 1;
        local v217 = -1;
        local v218 = 0;
        local v219 = 0;
        local v220 = {};
        for v221 = 1, #p215 do
            if u195[string.sub(p215, v221, v221)] then
                if v217 == -1 then
                    v217 = u195[string.sub(p215, v221, v221)];
                else
                    local v222 = v217 + u195[string.sub(p215, v221, v221)] * 91;
                    local v223 = bit32.lshift(v222, v218);
                    v219 = bit32.bor(v219, v223);
                    if bit32.band(v222, 8191) > 88 then
                        v218 = v218 + 13;
                    else
                        v218 = v218 + 14;
                    end;
                    while v218 > 7 do
                        v220[v216] = string.char(v219 % 256);
                        v216 = v216 + 1;
                        v219 = bit32.rshift(v219, 8);
                        v218 = v218 - 8;
                    end;
                    v217 = -1;
                end;
            end;
        end;
        if v217 ~= -1 then
            local v224 = bit32.lshift(v217, v218);
            local v225 = bit32.bor(v219, v224) % 256;
            v220[v216] = string.char(v225);
        end;
        return table.concat(v220);
    end
};
for v227 = 0, 255 do
    local v228 = l__char__3(v227);
    local v229 = l__char__3(v227, 0);
    u204[v228] = v229;
    u205[v229] = v228;
end;
local u261 = {
    compress = function(p230) --[[ Name: compress, Line 640 ]]
        -- upvalues: u203 (copy), l__sub__4 (copy), u204 (copy), l__char__3 (copy), l__concat__5 (copy)
        if u203(p230) == "string" then
            local v231 = #p230;
            if v231 <= 1 then
                return "u" .. p230;
            else
                local v232 = "";
                local v233 = {};
                local v234 = 1;
                local v235 = { "c" };
                local v236 = 2;
                local v237 = 1;
                local v238 = 0;
                for v239 = 1, v231 do
                    local v240 = l__sub__4(p230, v239, v239);
                    local v241 = v232 .. v240;
                    if u204[v241] or v233[v241] then
                        v232 = v241;
                    else
                        local v242 = u204[v232] or v233[v232];
                        if not v242 then
                            return nil, "algorithm error, could not fetch word";
                        end;
                        v235[v236] = v242;
                        v237 = v237 + #v242;
                        v236 = v236 + 1;
                        if v231 <= v237 then
                            return "u" .. p230;
                        end;
                        if v238 >= 256 then
                            v238 = 0;
                            v234 = v234 + 1;
                            if v234 >= 256 then
                                v234 = 1;
                                v233 = {};
                            end;
                        end;
                        v233[v241] = l__char__3(v238, v234);
                        v238 = v238 + 1;
                        v232 = v240;
                    end;
                end;
                v235[v236] = u204[v232] or v233[v232];
                local v243 = v237 + #v235[v236];
                local _ = v236 + 1;
                if v231 <= v243 then
                    return "u" .. p230;
                else
                    return l__concat__5(v235);
                end;
            end;
        else
            return nil, "string expected, got " .. u203(p230);
        end;
    end,
    decompress = function(p244) --[[ Name: decompress, Line 698 ]]
        -- upvalues: u203 (copy), l__sub__4 (copy), u205 (copy), l__char__3 (copy), l__concat__5 (copy)
        if u203(p244) ~= "string" then
            return nil, "string expected, got " .. u203(p244);
        end;
        if #p244 < 1 then
            return nil, "invalid input - not a compressed string";
        end;
        local v245 = l__sub__4(p244, 1, 1);
        if v245 == "u" then
            return l__sub__4(p244, 2);
        end;
        if v245 ~= "c" then
            return nil, "invalid input - not a compressed string";
        end;
        local v246 = l__sub__4(p244, 2);
        local v247 = #v246;
        if v247 < 2 then
            return nil, "invalid input - not a compressed string";
        end;
        local v248 = {};
        local v249 = {};
        local v250 = 1;
        local v251 = l__sub__4(v246, 1, 2);
        v249[v250] = u205[v251] or v248[v251];
        local v252 = v250 + 1;
        local v253 = 0;
        local v254 = 1;
        for v255 = 3, v247, 2 do
            local v256 = l__sub__4(v246, v255, v255 + 1);
            local v257 = u205[v251] or v248[v251];
            if not v257 then
                return nil, "could not find last from dict. Invalid input?";
            end;
            local v258 = u205[v256] or v248[v256];
            if v258 then
                v249[v252] = v258;
                v252 = v252 + 1;
                local v259 = v257 .. l__sub__4(v258, 1, 1);
                if v253 >= 256 then
                    v253 = 0;
                    v254 = v254 + 1;
                    if v254 >= 256 then
                        v254 = 1;
                        v248 = {};
                    end;
                end;
                v248[l__char__3(v253, v254)] = v259;
                v253 = v253 + 1;
            else
                local v260 = v257 .. l__sub__4(v257, 1, 1);
                v249[v252] = v260;
                v252 = v252 + 1;
                if v253 >= 256 then
                    v253 = 0;
                    v254 = v254 + 1;
                    if v254 >= 256 then
                        v254 = 1;
                        v248 = {};
                    end;
                end;
                v248[l__char__3(v253, v254)] = v260;
                v253 = v253 + 1;
            end;
            v251 = v256;
        end;
        return l__concat__5(v249);
    end
};
local function u308(p262) --[[ Line: 782 ]]
    -- upvalues: u189 (copy), u308 (copy), u23 (copy), u21 (copy)
    local v263 = "";
    for v264, v265 in pairs(p262) do
        local v266 = typeof(v264);
        local v267 = typeof(v265);
        local v268 = u189[typeof(v264)];
        local v269;
        if v268 then
            v269 = v268(true, v264);
            if v269 == nil then
                v269 = nil;
            end;
        else
            v269 = nil;
        end;
        local v270 = u189[typeof(v265)];
        local v271;
        if v270 then
            v271 = v270(true, v265);
            if v271 == nil then
                v271 = nil;
            end;
        else
            v271 = nil;
        end;
        if v267 == "table" then
            if v266 == "table" then
                local v272 = u308(v264);
                local v273 = u308(v265);
                local l__ValueHeader__6 = u23.ValueHeader;
                local v274;
                if l__ValueHeader__6 and l__ValueHeader__6.ObjectIndexObjectValue then
                    v274 = string.pack(l__ValueHeader__6.__Pattern, l__ValueHeader__6.ObjectIndexObjectValue);
                else
                    warn("ValueHeader", ":", "ObjectIndexObjectValue");
                    u21("[Binary]", "Could not describe", "ValueHeader", "ObjectIndexObjectValue");
                    v274 = 0;
                end;
                local l__Value2__7 = u23.Value2;
                local v275;
                if l__Value2__7 and l__Value2__7[v272] then
                    v275 = string.pack(l__Value2__7.__Pattern, l__Value2__7[v272]);
                else
                    local v276 = tostring(v272);
                    local v277 = #v276;
                    if v277 > 65535 then
                        u21("[Binary]", "Value2 Cannot Encode DataValues more than 65,535 Bytes.");
                        v275 = nil;
                    else
                        v275 = string.pack("I2", v277) .. v276 or 0;
                    end;
                end;
                local l__Value2__8 = u23.Value2;
                local v278;
                if l__Value2__8 and l__Value2__8[v273] then
                    v278 = string.pack(l__Value2__8.__Pattern, l__Value2__8[v273]);
                else
                    local v279 = tostring(v273);
                    local v280 = #v279;
                    if v280 > 65535 then
                        u21("[Binary]", "Value2 Cannot Encode DataValues more than 65,535 Bytes.");
                        v278 = nil;
                    else
                        v278 = string.pack("I2", v280) .. v279 or 0;
                    end;
                end;
                v263 = v263 .. v274 .. v275 .. v278;
            else
                local v281 = u308(v265);
                local l__ValueHeader__9 = u23.ValueHeader;
                local v282;
                if l__ValueHeader__9 and l__ValueHeader__9.StaticIndexObjectValue then
                    v282 = string.pack(l__ValueHeader__9.__Pattern, l__ValueHeader__9.StaticIndexObjectValue);
                else
                    warn("ValueHeader", ":", "StaticIndexObjectValue");
                    u21("[Binary]", "Could not describe", "ValueHeader", "StaticIndexObjectValue");
                    v282 = 0;
                end;
                local l__DataType__10 = u23.DataType;
                local v283;
                if l__DataType__10 and l__DataType__10[v266] then
                    v283 = string.pack(l__DataType__10.__Pattern, l__DataType__10[v266]);
                else
                    warn("DataType", ":", v266);
                    u21("[Binary]", "Could not describe", "DataType", v266);
                    v283 = 0;
                end;
                local l__Value2__11 = u23.Value2;
                local v284;
                if l__Value2__11 and l__Value2__11[v269] then
                    v284 = string.pack(l__Value2__11.__Pattern, l__Value2__11[v269]);
                else
                    local v285 = tostring(v269);
                    local v286 = #v285;
                    if v286 > 65535 then
                        u21("[Binary]", "Value2 Cannot Encode DataValues more than 65,535 Bytes.");
                        v284 = nil;
                    else
                        v284 = string.pack("I2", v286) .. v285 or 0;
                    end;
                end;
                local l__Value2__12 = u23.Value2;
                local v287;
                if l__Value2__12 and l__Value2__12[v281] then
                    v287 = string.pack(l__Value2__12.__Pattern, l__Value2__12[v281]);
                else
                    local v288 = tostring(v281);
                    local v289 = #v288;
                    if v289 > 65535 then
                        u21("[Binary]", "Value2 Cannot Encode DataValues more than 65,535 Bytes.");
                        v287 = nil;
                    else
                        v287 = string.pack("I2", v289) .. v288 or 0;
                    end;
                end;
                v263 = v263 .. v282 .. v283 .. v284 .. v287;
            end;
        elseif v269 == nil or v271 == nil then
            u21("[Encode]", (`Failure to encode values, doesnt match a siganture.  {v269}-{v271} `));
        elseif v266 == "table" then
            local v290 = u308(v264);
            local l__ValueHeader__13 = u23.ValueHeader;
            local v291;
            if l__ValueHeader__13 and l__ValueHeader__13.ObjectIndexStaticValue then
                v291 = string.pack(l__ValueHeader__13.__Pattern, l__ValueHeader__13.ObjectIndexStaticValue);
            else
                warn("ValueHeader", ":", "ObjectIndexStaticValue");
                u21("[Binary]", "Could not describe", "ValueHeader", "ObjectIndexStaticValue");
                v291 = 0;
            end;
            local l__Value2__14 = u23.Value2;
            local v292;
            if l__Value2__14 and l__Value2__14[v290] then
                v292 = string.pack(l__Value2__14.__Pattern, l__Value2__14[v290]);
            else
                local v293 = tostring(v290);
                local v294 = #v293;
                if v294 > 65535 then
                    u21("[Binary]", "Value2 Cannot Encode DataValues more than 65,535 Bytes.");
                    v292 = nil;
                else
                    v292 = string.pack("I2", v294) .. v293 or 0;
                end;
            end;
            local l__DataType__15 = u23.DataType;
            local v295;
            if l__DataType__15 and l__DataType__15[v267] then
                v295 = string.pack(l__DataType__15.__Pattern, l__DataType__15[v267]);
            else
                warn("DataType", ":", v267);
                u21("[Binary]", "Could not describe", "DataType", v267);
                v295 = 0;
            end;
            local l__Value2__16 = u23.Value2;
            local v296;
            if l__Value2__16 and l__Value2__16[v271] then
                v296 = string.pack(l__Value2__16.__Pattern, l__Value2__16[v271]);
            else
                local v297 = tostring(v271);
                local v298 = #v297;
                if v298 > 65535 then
                    u21("[Binary]", "Value2 Cannot Encode DataValues more than 65,535 Bytes.");
                    v296 = nil;
                else
                    v296 = string.pack("I2", v298) .. v297 or 0;
                end;
            end;
            v263 = v263 .. v291 .. v292 .. v295 .. v296;
        else
            local l__ValueHeader__17 = u23.ValueHeader;
            local v299;
            if l__ValueHeader__17 and l__ValueHeader__17.StaticIndexStaticValue then
                v299 = string.pack(l__ValueHeader__17.__Pattern, l__ValueHeader__17.StaticIndexStaticValue);
            else
                warn("ValueHeader", ":", "StaticIndexStaticValue");
                u21("[Binary]", "Could not describe", "ValueHeader", "StaticIndexStaticValue");
                v299 = 0;
            end;
            local l__DataType__18 = u23.DataType;
            local v300;
            if l__DataType__18 and l__DataType__18[v266] then
                v300 = string.pack(l__DataType__18.__Pattern, l__DataType__18[v266]);
            else
                warn("DataType", ":", v266);
                u21("[Binary]", "Could not describe", "DataType", v266);
                v300 = 0;
            end;
            local l__Value2__19 = u23.Value2;
            local v301;
            if l__Value2__19 and l__Value2__19[v269] then
                v301 = string.pack(l__Value2__19.__Pattern, l__Value2__19[v269]);
            else
                local v302 = tostring(v269);
                local v303 = #v302;
                if v303 > 65535 then
                    u21("[Binary]", "Value2 Cannot Encode DataValues more than 65,535 Bytes.");
                    v301 = nil;
                else
                    v301 = string.pack("I2", v303) .. v302 or 0;
                end;
            end;
            local l__DataType__20 = u23.DataType;
            local v304;
            if l__DataType__20 and l__DataType__20[v267] then
                v304 = string.pack(l__DataType__20.__Pattern, l__DataType__20[v267]);
            else
                warn("DataType", ":", v267);
                u21("[Binary]", "Could not describe", "DataType", v267);
                v304 = 0;
            end;
            local l__Value2__21 = u23.Value2;
            local v305;
            if l__Value2__21 and l__Value2__21[v271] then
                v305 = string.pack(l__Value2__21.__Pattern, l__Value2__21[v271]);
            else
                local v306 = tostring(v271);
                local v307 = #v306;
                if v307 > 65535 then
                    u21("[Binary]", "Value2 Cannot Encode DataValues more than 65,535 Bytes.");
                    v305 = nil;
                else
                    v305 = string.pack("I2", v307) .. v306 or 0;
                end;
            end;
            v263 = v263 .. v299 .. v300 .. v301 .. v304 .. v305;
        end;
    end;
    return v263;
end;
local function u346(p309) --[[ Line: 835 ]]
    -- upvalues: u24 (copy), u23 (copy), u21 (copy), u201 (copy), u346 (copy), u189 (copy)
    local v310 = 0;
    local v311 = false;
    local v312 = {};
    while v310 < #p309 do
        local v313 = v310 + 1;
        local v314 = string.byte(p309:sub(v313, v313));
        local v315 = u24.ValueHeader[v314] or "Invalid" or "Invalid";
        local l__ValueHeader__22 = u23.ValueHeader;
        local v316;
        if l__ValueHeader__22 then
            v316 = string.packsize(l__ValueHeader__22.__Pattern);
        else
            u21("[Binary]", "Cannot get sizeof ", "ValueHeader");
            v316 = nil;
        end;
        v310 = v313 + v316;
        if v315 == "ObjectIndexObjectValue" then
            local v317, v318 = u201(p309, v310);
            local v319, v320 = u201(p309, v317);
            v310 = v319 - 1;
            v312[u346(v318)] = u346(v320);
            v311 = true;
        end;
        if v315 == "ObjectIndexStaticValue" then
            local v321, v322 = u201(p309, v310);
            local v323 = string.byte(p309:sub(v321, v321));
            local v324, v325 = u201(p309, v321 + 1);
            v310 = v324 - 1;
            local v326 = u346(v322);
            local v327 = u189[u24.DataType[v323] or "Invalid"];
            local v328;
            if v327 then
                v328 = v327(false, v325);
                if v328 == nil then
                    v328 = nil;
                end;
            else
                v328 = nil;
            end;
            v312[v326] = v328;
            v311 = true;
        end;
        if v315 == "StaticIndexObjectValue" then
            local v329 = string.byte(p309:sub(v310, v310));
            local v330, v331 = u201(p309, v310 + 1);
            local v332, v333 = u201(p309, v330);
            v310 = v332 - 1;
            local v334 = u189[u24.DataType[v329] or "Invalid"];
            local v335;
            if v334 then
                v335 = v334(false, v331);
                if v335 == nil then
                    v335 = nil;
                end;
            else
                v335 = nil;
            end;
            v312[v335] = u346(v333);
            v311 = true;
        end;
        if v315 == "StaticIndexStaticValue" then
            local v336 = string.byte(p309:sub(v310, v310));
            local v337, v338 = u201(p309, v310 + 1);
            local v339 = string.byte(p309:sub(v337, v337));
            local v340, v341 = u201(p309, v337 + 1);
            v310 = v340 - 1;
            local v342 = u189[u24.DataType[v336] or "Invalid"];
            local v343;
            if v342 then
                v343 = v342(false, v338);
                if v343 == nil then
                    v343 = nil;
                end;
            else
                v343 = nil;
            end;
            local v344 = u189[u24.DataType[v339] or "Invalid"];
            local v345;
            if v344 then
                v345 = v344(false, v341);
                if v345 == nil then
                    v345 = nil;
                end;
            else
                v345 = nil;
            end;
            v312[v343] = v345;
            v311 = true;
        end;
        if not v311 or v315 == "Invalid" then
            u21("[Binary]", "Failed while decoding : could not determine a valid ValueHeader [", v315, "]");
            return v312;
        end;
    end;
    return v312;
end;
function u1.Serialize(u347) --[[ Line: 920 ]]
    -- upvalues: u308 (copy), u21 (copy), u226 (copy), u261 (copy)
    local v348, v349 = pcall(function() --[[ Line: 921 ]]
        -- upvalues: u308 (ref), u347 (copy)
        return u308(u347);
    end);
    if v348 then
        return u226.encode(u261.compress(v349));
    end;
    u21("[LuaError]", v349);
    return "";
end;
function u1.Deserialize(p350) --[[ Line: 931 ]]
    -- upvalues: u261 (copy), u226 (copy), u346 (copy), u21 (copy)
    local u351 = u261.decompress(u226.decode(p350));
    local v352, v353 = pcall(function() --[[ Line: 933 ]]
        -- upvalues: u346 (ref), u351 (copy)
        return u346(u351);
    end);
    if v352 then
        return v353;
    end;
    u21("[LuaError]", v353);
    return {};
end;
u21("Initilization complete! Created " .. "by " .. u1._AUTHOR);
return u1;
