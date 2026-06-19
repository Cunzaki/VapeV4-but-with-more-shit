-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = typeof;
local u2 = unpack;
local u3 = select;
local l__exp__1 = math.exp;
local l__sqrt__2 = math.sqrt;
local l__cos__3 = math.cos;
local l__sin__4 = math.sin;
local l__obtain__5 = _G.obtain;
local v4 = l__obtain__5("LuCAS-Base");
local l__DefEvaluate__6 = v4.DefEvaluate;
local l__DefDerivative__7 = v4.DefDerivative;
local v5 = l__obtain__5("LuCAS-Rule");
local l__DefRule__8 = v5.DefRule;
local l__RuleCopy__9 = v5.RuleCopy;
local v6 = l__obtain__5("LuCAS-Constructor");
local l__Head__10 = v6.Head;
local l__DefaultConstructor__11 = v6.DefaultConstructor;
local l__DefConstructor__12 = v6.DefConstructor;
local l__Vector__13 = v6.Constructors.Vector;
local l__components__14 = CFrame.new().components;
local function u26(p7, p8, p9, p10, p11, p12, p13, p14, p15) --[[ Line: 29 ]]
    local v16 = 1 + p7 + p11 + p15;
    local v17 = 1 + p7 - p11 - p15;
    local v18 = 1 - p7 + p11 - p15;
    local v19 = 1 - p7 - p11 + p15;
    local v20 = math.max(v16, v17, v18, v19);
    local v21 = nil;
    local v22 = nil;
    local v23 = nil;
    local v24 = nil;
    if v20 == v16 then
        v17 = p14 - p12;
        v18 = p9 - p13;
        v19 = p10 - p8;
        v21 = v16;
    elseif v20 == v17 then
        v21 = p14 - p12;
        v18 = p10 + p8;
        v19 = p13 + p9;
    elseif v20 == v18 then
        v21 = p9 - p13;
        v17 = p10 + p8;
        v19 = p14 + p12;
    elseif v20 == v19 then
        v21 = p10 - p8;
        v17 = p13 + p9;
        v18 = p14 + p12;
    else
        v19 = v24;
        v18 = v23;
        v17 = v22;
    end;
    local v25 = 1 / math.sqrt(v21 * v21 + v17 * v17 + v18 * v18 + v19 * v19);
    return v25 * v21, v25 * v17, v25 * v18, v25 * v19;
end;
l__DefEvaluate__6("Quaternion", "Quaternion", function(p27, p28, p29, p30) --[[ Line: 54 ]]
    return (type(p27) ~= "table" or #p27 ~= 4) and {
        p27,
        p28,
        p29,
        p30
    } or p27;
end, "Independent");
local u31 = l__DefaultConstructor__11("Quaternion");
local u32 = nil;
u32 = l__DefConstructor__12("Quaternion", function(p33, p34, p35, p36) --[[ Line: 65 ]]
    -- upvalues: u1 (copy), u26 (copy), u3 (copy), l__components__14 (copy), l__Head__10 (copy), u2 (copy), u32 (ref), u31 (copy)
    local v37 = u1(p33);
    if v37 == "CFrame" then
        p33, p34, p35, p36 = u26(u3(4, l__components__14(p33)));
    elseif v37 == "table" then
        local v38 = l__Head__10(p33);
        if v38 == "CFrame" then
            return p33[3];
        end;
        if v38 == "Quaternion" then
            p33, p34, p35, p36 = u2(p33, 2, 5);
        elseif not v38 then
            local v39 = p33[1];
            if v39 == "CFrame" then
                return u32(p33[3]);
            end;
            if v39 == "Quaternion" then
                p33, p34, p35, p36 = u2(p33, 2, 5);
            end;
        end;
    end;
    return u31(p33, p34, p35, p36);
end);
local l__new__15 = Vector3.new;
l__DefEvaluate__6("QuaternionVectorPart", "Vector3", function(p40) --[[ Line: 93 ]]
    -- upvalues: l__new__15 (copy)
    return l__new__15(p40[2], p40[3], p40[4]);
end, "Independent");
l__DefEvaluate__6("CFrameVectorPart", "Vector3", function(p41, _) --[[ Line: 99 ]]
    return p41;
end, "Independent");
local u42 = l__DefaultConstructor__11("CFrameVectorPart");
l__DefConstructor__12("CFrameVectorPart", function(p43) --[[ Line: 106 ]]
    -- upvalues: u1 (copy), l__Vector__13 (copy), l__Head__10 (copy), u42 (copy)
    local v44 = u1(p43);
    if v44 == "CFrame" then
        return l__Vector__13(p43);
    end;
    if v44 == "table" then
        local v45 = l__Head__10(p43);
        if v45 == "CFrame" then
            return p43[2];
        end;
        if not v45 and p43[1] == "CFrame" then
            return l__Vector__13(p43[2]);
        end;
    end;
    return u42(p43);
end);
l__DefEvaluate__6("CFrameQuaternionPart", "Quaternion", function(_, p46) --[[ Line: 128 ]]
    return p46;
end, "Independent");
local u47 = l__DefaultConstructor__11("CFrameQuaternionPart");
l__DefConstructor__12("CFrameQuaternionPart", function(p48) --[[ Line: 135 ]]
    -- upvalues: u1 (copy), u32 (ref), l__Head__10 (copy), u47 (copy)
    local v49 = u1(p48);
    if v49 == "CFrame" then
        return u32(p48);
    end;
    if v49 == "table" then
        local v50 = l__Head__10(p48);
        if v50 == "CFrame" then
            return p48[3];
        end;
        if not v50 and p48[1] == "CFrame" then
            return u32(p48[3]);
        end;
    end;
    return u47(p48);
end);
l__DefConstructor__12("AxisAngle", function(p51, p52, p53) --[[ Line: 165 ]]
    -- upvalues: u1 (copy), u31 (copy)
    local v54 = u1(p51);
    if v54 == "CFrame" then
        local _, _, _, v55, v56, v57, v58, v59, v60, v61, v62, v63 = p51:components();
        local v64 = v62 - v60;
        local v65 = v57 - v61;
        local v66 = v58 - v56;
        local v67 = v55 + v59 + v63 - 1;
        local v68 = math.sqrt(v64 * v64 + v65 * v65 + v66 * v66);
        local v69 = Vector3.new(v64, v65, v66) / v68 * math.atan2(v68, v67);
        p51 = v69.x;
        p52 = v69.y;
        p53 = v69.z;
    elseif v54 == "Vector3" then
        local l__x__16 = p51.x;
        p52 = p51.y;
        p53 = p51.z;
        p51 = l__x__16;
    else
        local _ = v54 == "table";
    end;
    return u31(0, p51, p52, p53);
end);
l__DefRule__8("Mul", "Quaternion", "Quaternion-Quaternion", "QMul");
l__DefEvaluate__6("QMulScalar", "Quaternion", function(p70, p71) --[[ Line: 213 ]]
    return {
        p70[1] * p71,
        p70[2] * p71,
        p70[3] * p71,
        p70[4] * p71
    };
end);
l__DefDerivative__7("QMulScalar", "Custom", function(p72, p73) --[[ Line: 218 ]]
    return {
        "QAdd",
        { "QMulScalar", p72[1], p73[2] },
        { "QMulScalar", p73[1], p72[2] }
    };
end);
l__DefRule__8("Mul", "Quaternion", "Quaternion-Scalar", "QMulScalar");
l__DefRule__8("Mul", "Quaternion", "Scalar-Quaternion", function(p74, p75) --[[ Line: 224 ]]
    return p75 * p74;
end);
l__RuleCopy__9("Mul", "Quaternion-Scalar", "Quaternion-number");
l__RuleCopy__9("Mul", "Scalar-Quaternion", "number-Quaternion");
local l__new__17 = CFrame.new;
l__DefEvaluate__6("CFrame", "CFrame", function(p76, p77) --[[ Line: 233 ]]
    -- upvalues: l__new__17 (copy)
    return l__new__17(p76.x, p76.y, p76.z, p77[2], p77[3], p77[4], p77[1]);
end, "Independent");
local u78 = l__DefaultConstructor__11("CFrame");
local l__Vector__18 = v6.Constructors.Vector;
l__DefConstructor__12("CFrame", function(p79, p80) --[[ Line: 241 ]]
    -- upvalues: u1 (copy), u78 (copy), l__Vector__18 (copy), u31 (copy), u26 (copy), u3 (copy), l__components__14 (copy)
    if u1(p79) == "CFrame" then
        return u78(l__Vector__18(p79.p), u31(u26(u3(4, l__components__14(p79)))));
    else
        return u78(p79, p80);
    end;
end);
local u81 = l__DefaultConstructor__11("QMul");
local u82 = l__DefaultConstructor__11("QMulVec");
l__DefRule__8("Mul", "CFrame", "CFrame-Quaternion", function(p83, p84) --[[ Line: 252 ]]
    -- upvalues: u78 (copy), u81 (copy)
    return u78(p83[2], u81(p83[3], p84));
end);
l__DefRule__8("Mul", "CFrame", "Quaternion-CFrame", function(p85, p86) --[[ Line: 256 ]]
    -- upvalues: u78 (copy), u82 (copy), u81 (copy)
    return u78(u82(p85, p86[2]), u81(p85, p86[3]));
end);
l__DefRule__8("Mul", "CFrame", "CFrame-CFrame", function(p87, p88) --[[ Line: 259 ]]
    -- upvalues: u78 (copy), u82 (copy), u81 (copy)
    local v89 = p87[2];
    local v90 = p88[2];
    local v91 = p87[3];
    local v92 = p88[3];
    return u78(v89 + u82(v91, v90), u81(v91, v92));
end);
l__DefEvaluate__6("QAdd", "Quaternion", function(p93, p94) --[[ Line: 266 ]]
    return {
        p93[1] + p94[1],
        p93[2] + p94[2],
        p93[3] + p94[3],
        p93[4] + p94[4]
    };
end, "Independent");
l__DefEvaluate__6("QMul", "Quaternion", function(p95, p96) --[[ Line: 273 ]]
    local v97 = p95[1];
    local v98 = p95[2];
    local v99 = p95[3];
    local v100 = p95[4];
    local v101 = p96[1];
    local v102 = p96[2];
    local v103 = p96[3];
    local v104 = p96[4];
    return {
        v97 * v101 - v98 * v102 - v99 * v103 - v100 * v104,
        v97 * v102 + v98 * v101 + v99 * v104 - v100 * v103,
        v97 * v103 - v98 * v104 + v99 * v101 + v100 * v102,
        v97 * v104 + v98 * v103 - v99 * v102 + v100 * v101
    };
end);
l__DefDerivative__7("QMul", "Custom", function(p105, p106) --[[ Line: 285 ]]
    return {
        "QAdd",
        { "QMul", p106[1], p105[2] },
        { "QMul", p105[1], p106[2] }
    };
end);
l__DefEvaluate__6("QMulVec", "Vector", function(p107, p108) --[[ Line: 291 ]]
    -- upvalues: l__new__15 (copy)
    local l__x__19 = p108.x;
    local l__y__20 = p108.y;
    local l__z__21 = p108.z;
    local v109 = p107[1];
    local v110 = p107[2];
    local v111 = p107[3];
    local v112 = p107[4];
    local v113 = -l__x__19 * v110 - l__y__20 * v111 - l__z__21 * v112;
    local v114 = l__x__19 * v109 + l__z__21 * v111 - l__y__20 * v112;
    local v115 = l__y__20 * v109 - l__z__21 * v110 + l__x__19 * v112;
    local v116 = l__z__21 * v109 + l__y__20 * v110 - l__x__19 * v111;
    return l__new__15(v114 * v109 - v113 * v110 + v116 * v111 - v115 * v112, v115 * v109 - v116 * v110 - v113 * v111 + v114 * v112, v116 * v109 + v115 * v110 - v114 * v111 - v113 * v112);
end);
l__DefDerivative__7("QMulVec", "Custom", function(p117, p118) --[[ Line: 307 ]]
    return {
        "VAdd",
        { "QMulVec", p117[1], p118[2] },
        { "QMulVec", p118[1], p117[2] }
    };
end);
l__DefRule__8("Mul", "Vector", "Quaternion-Vector", "QMulVec");
l__DefEvaluate__6("QExp", "Quaternion", function(p119) --[[ Line: 314 ]]
    -- upvalues: l__exp__1 (copy), l__sqrt__2 (copy), l__sin__4 (copy), l__cos__3 (copy)
    local v120 = l__exp__1(p119[1]);
    local v121 = p119[2];
    local v122 = p119[3];
    local v123 = p119[4];
    local v124 = v121 * v121 + v122 * v122 + v123 * v123;
    if v124 <= 1e-8 then
        return {
            v120,
            v120 * v121,
            v120 * v122,
            v120 * v123
        };
    end;
    local v125 = l__sqrt__2(v124);
    local v126 = v120 * l__sin__4(v125) / v125;
    return {
        v120 * l__cos__3(v125),
        v121 * v126,
        v122 * v126,
        v123 * v126
    };
end);
l__DefDerivative__7("QExp", "Custom", function(p127, p128) --[[ Line: 328 ]]
    return {
        "QMul",
        { "QExp", p127[1] },
        p128[1]
    };
end);
l__DefEvaluate__6("QNeg", "Quaternion", function(p129) --[[ Line: 334 ]]
    return {
        -p129[1],
        -p129[2],
        -p129[3],
        -p129[4]
    };
end, "Independent");
l__DefRule__8("Unm", "Quaternion", "Quaternion", "QNeg");
l__DefEvaluate__6("QInv", "Quaternion", function(p130) --[[ Line: 342 ]]
    local v131 = -p130[1];
    local v132 = p130[2];
    local v133 = p130[3];
    local v134 = p130[4];
    local v135 = -(v131 * v131 + v132 * v132 + v133 * v133 + v134 * v134);
    return {
        v131 / v135,
        v132 / v135,
        v133 / v135,
        v134 / v135
    };
end);
l__DefDerivative__7("QInv", "Custom", function(p136, p137) --[[ Line: 349 ]]
    local v138 = { "QInv", p136[1] };
    return {
        "QNeg",
        {
            "QMul",
            { "QMul", v138, p137[1] },
            v138
        }
    };
end);
return true;
