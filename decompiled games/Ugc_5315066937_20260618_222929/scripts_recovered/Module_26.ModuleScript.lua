-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = type;
local u2 = typeof;
local u3 = pcall;
local u4 = require;
local l__clear__1 = table.clear;
local l__clone__2 = table.clone;
local l__insert__3 = table.insert;
local function u14(p5, p6, p7) --[[ Line: 36 ]]
    -- upvalues: u1 (copy), u14 (copy)
    local v8 = p6 or {};
    local v9 = p7 or {};
    v9[p5] = v8;
    for v12, v13 in next, p5 do
        if u1(v12) == "table" then
            local v12 = v9[v12] or u14(v12, {}, v9);
        end;
        if u1(v13) == "table" then
            local v13 = v9[v13] or u14(v13, {}, v9);
        end;
        v8[v12] = v13;
    end;
    return v8;
end;
local l__IsA__4 = game.IsA;
local l__obtain__5 = _G.obtain;
local u15 = l__obtain__5("LabelPrint");
local u16 = l__obtain__5("L1Copy");
local v17 = l__obtain__5("Class");
local u18 = l__obtain__5("Timers");
local v19 = l__obtain__5("WorldHelpers");
local l__SetState__6 = v19.SetState;
local l__FetchState__7 = v19.FetchState;
local l__MergeState__8 = v19.MergeState;
local l__CalculateImplicits__9 = v19.CalculateImplicits;
local l__GetPartCFrame__10 = v19.GetPartCFrame;
local l__ApplyPropertyList__11 = v19.ApplyPropertyList;
local l__ApplyRelativeCFrames__12 = v19.ApplyRelativeCFrames;
local l__ApplyRelativeTransparencies__13 = v19.ApplyRelativeTransparencies;
local u20 = l__obtain__5("WorldCache");
local v21 = l__obtain__5("BulkMove");
local l__Flush__14 = v21.Flush;
local l__DeferCFrame__15 = v21.DeferCFrame;
local l__new__16 = CFrame.new;
local u22 = Vector3.new();
local l__Cross__17 = u22.Cross;
local l__identity__18 = CFrame.identity;
local l__fromMatrix__19 = CFrame.fromMatrix;
local l__lerp__20 = l__identity__18.lerp;
local l__new__21 = Color3.new;
local v23 = l__obtain__5("LuCAS");
local l__Evaluate__22 = v23.Evaluate;
local u24 = workspace;
local l__new__23 = OverlapParams.new;
local l__GetPartBoundsInBox__24 = u24.GetPartBoundsInBox;
local l__Include__25 = Enum.RaycastFilterType.Include;
local l__new__26 = Instance.new;
local u25 = l__obtain__5("RobloxCamera");
local u26 = {
    LuCAS = v23
};
local u27 = {};
local v28 = v17();
local u29 = {};
function v28.FindParts(p30, p31, p32, _) --[[ Line: 140 ]]
    -- upvalues: l__GetPartBoundsInBox__24 (copy), u24 (copy)
    return l__GetPartBoundsInBox__24(u24, p31, p32, p30.OverlapParams);
end;
function v28.GetPathParts(p33, p34, p35, p36, p37, p38) --[[ Line: 144 ]]
    -- upvalues: l__clear__1 (copy), u29 (copy), l__new__16 (copy), l__GetPartBoundsInBox__24 (copy), u24 (copy), u22 (copy), l__insert__3 (copy)
    l__clear__1(u29);
    local v39 = p34:Min(p35);
    local v40 = p34:Max(p35);
    local v41 = l__GetPartBoundsInBox__24(u24, l__new__16((v39 + v40) / 2), v40 - v39 + 2 * p36, p33.OverlapParams);
    for v42 in v41 do
        u29[v42] = true;
    end;
    local l__ObjectGroups__27 = p33.ObjectGroups;
    for v43, v44 in p33.TimeVaryingIndex do
        if v44.CFrame then
            local v45 = l__ObjectGroups__27[v43];
            if v45 and v45.RelativeCFrames then
                local v46 = p33:GetPartCFrame(v43, p37):PointToObjectSpace(p34);
                local v47 = p33:GetPartCFrame(v43, p38):PointToObjectSpace(p35);
                local l__Center__28 = v45.Center;
                local v48 = v46 - l__Center__28;
                local v49 = v47 - l__Center__28;
                local v50 = v48:Min(v49) - p36;
                if (u22:Min(v48:Max(v49) + p36):Max(v50) - u22).magnitude < v45.Radius then
                    local l__CFrame__29 = v43.CFrame;
                    local v51 = l__CFrame__29 * v46;
                    local v52 = l__CFrame__29 * v47;
                    local v53 = v51:Min(v52);
                    local v54 = v51:Max(v52);
                    local v55 = l__GetPartBoundsInBox__24(u24, l__new__16((v53 + v54) / 2), v54 - v53 + 2 * p36, v45.OverlapParams);
                    for v56 = 1, #v55 do
                        local v57 = v55[v56];
                        if not u29[v57] then
                            l__insert__3(v41, v57);
                        end;
                    end;
                end;
            elseif not u29[v43] then
                local v58 = p34 - p33:GetPartCFrame(v43, p37).p;
                local v59 = p35 - p33:GetPartCFrame(v43, p38).p;
                local v60 = v58:Min(v59) - p36;
                if (u22:Min(v58:Max(v59) + p36):Max(v60) - u22).magnitude < v43.Size.magnitude / 2 then
                    l__insert__3(v41, v43);
                end;
            end;
        end;
    end;
    return v41;
end;
function v28.GetPartCFrame(p61, p62, p63) --[[ Line: 191 ]]
    -- upvalues: l__lerp__20 (copy), l__GetPartCFrame__10 (copy)
    local l__Cache0__30 = p61.Cache0;
    local v64 = l__Cache0__30.CFrames[p62];
    if v64 then
        local l__Cache1__31 = p61.Cache1;
        local v65 = l__Cache0__30.TimeOverrides[p62] or l__Cache0__30.Time;
        local v66 = l__Cache1__31.Time - v65;
        if v66 < 0.0001 then
            return v64;
        else
            return l__lerp__20(v64, l__Cache1__31.CFrames[p62], (p63 - v65) / v66);
        end;
    else
        local v67 = p61.ObjectGroupBasePart[p62];
        if v67 then
            return p61:GetPartCFrame(v67, p63) * p61.ObjectGroups[v67].RelativeCFrames[p62];
        else
            return l__GetPartCFrame__10(p62);
        end;
    end;
end;
function v28.GetPartImplicitVelocity(p68, p69, _) --[[ Line: 213 ]]
    -- upvalues: u22 (copy)
    local l__Cache0__32 = p68.Cache0;
    local v70 = l__Cache0__32.CFrames[p69];
    if not v70 then
        return u22;
    end;
    local l__Cache1__33 = p68.Cache1;
    return (l__Cache1__33.CFrames[p69].p - v70.p) / (l__Cache1__33.Time - (l__Cache0__32.TimeOverrides[p69] or l__Cache0__32.Time));
end;
function v28.GetPartExplicitVelocity(_, _, _) --[[ Line: 224 ]]
    error("NYI");
end;
function v28.GetPartImplicitAcceleration(p71, p72, p73) --[[ Line: 228 ]]
    -- upvalues: l__clear__1 (copy), u27 (copy), l__Evaluate__22 (copy), u22 (copy)
    local v74 = p71.TimeVaryingIndex[p72];
    if v74 and v74.ImplicitAcceleration then
        l__clear__1(u27);
        u27.t = p73;
        return l__Evaluate__22(p71.StateIndex[p72].ImplicitAcceleration, u27);
    else
        local v75 = p71.StateIndex[p72];
        if v75 then
            return v75.ImplicitAcceleration;
        else
            return u22;
        end;
    end;
end;
function v28.GetPartExplicitAcceleration(_, _, _) --[[ Line: 242 ]]
    error("NYI");
end;
local function u83(p76, p77, p78) --[[ Line: 246 ]]
    -- upvalues: l__lerp__20 (copy), l__fromMatrix__19 (copy)
    local l__Cache0__34 = p76.Cache0;
    local v79 = l__Cache0__34.CFrames[p77];
    if v79 then
        local l__Cache1__35 = p76.Cache1;
        local v80 = l__Cache1__35.CFrames[p77];
        local v81 = l__Cache0__34.TimeOverrides[p77] or l__Cache0__34.Time;
        local v82 = l__Cache1__35.Time - v81;
        return l__lerp__20(v79, v80, (p78 - v81) / v82), l__fromMatrix__19((v80.p - v79.p) / v82, (v80.XVector - v79.XVector) / v82, (v80.YVector - v79.YVector) / v82, (v80.ZVector - v79.ZVector) / v82);
    end;
end;
local function u92(p84, p85, p86) --[[ Line: 260 ]]
    -- upvalues: u83 (copy), u92 (copy)
    local v87, v88 = u83(p84, p85, p86);
    local v89 = p84.ObjectGroupBasePart[p85];
    if v89 then
        local v90, v91 = u92(p84, v89, p86);
        if v88 then
            return v90 * v87, v91 * (v88 + v87.p);
        else
            return v90, v91;
        end;
    else
        return v87, v88;
    end;
end;
function v28.GetPartVelocityAtPointImplicit(p93, p94, p95, p96) --[[ Line: 283 ]]
    -- upvalues: u83 (copy), u92 (copy), u22 (copy)
    local v97, v98 = u83(p93, p94, p96);
    local v99 = p93.ObjectGroupBasePart[p94];
    local v100, v101;
    if v99 then
        v100, v101 = u92(p93, v99, p96);
        if v98 then
            v100 = v100 * v97;
            v101 = v101 * (v98 + v97.p);
        end;
    else
        v101 = v98;
        v100 = v97;
    end;
    if v100 then
        return v101 * v100:PointToObjectSpace(p95);
    else
        return u22;
    end;
end;
function v28.GetPartVelocityAtPointExplicit(p102, p103, p104, p105) --[[ Line: 290 ]]
    -- upvalues: u22 (copy), u2 (copy), l__clear__1 (copy), u27 (copy), l__Evaluate__22 (copy), l__Cross__17 (copy)
    local v106 = p102.StateIndex[p103];
    if v106 then
        local l__Velocity__36 = v106.Velocity;
        local l__RotVelocity__37 = v106.RotVelocity;
        if l__RotVelocity__37 == u22 then
            if u2(l__Velocity__36) == "Vector3" then
                return l__Velocity__36;
            end;
            l__clear__1(u27);
            u27.t = p105;
            return l__Evaluate__22(l__Velocity__36, u27);
        else
            l__clear__1(u27);
            u27.t = p105;
            local v107 = l__Evaluate__22(l__RotVelocity__37, u27);
            local v108 = p102:GetPartCFrame(p103, p105);
            if u2(l__Velocity__36) == "Vector3" then
                return l__Velocity__36 + l__Cross__17(v107, p104 - v108.p);
            else
                return l__Evaluate__22(l__Velocity__36, u27) + l__Cross__17(v107, p104 - v108.p);
            end;
        end;
    else
        local v109 = p102.ObjectGroupBasePart[p103];
        if v109 then
            return p102:GetPartVelocityAtPointExplicit(v109, p104, p105);
        else
            local l__Velocity__38 = p103.Velocity;
            local l__RotVelocity__39 = p103.RotVelocity;
            if l__RotVelocity__39 == u22 then
                return l__Velocity__38;
            else
                return l__Velocity__38 + l__Cross__17(l__RotVelocity__39, p104 - p103.Position);
            end;
        end;
    end;
end;
function v28.ClearCache(p110) --[[ Line: 344 ]]
    p110.Cache1:Clear();
end;
function v28.SwapCaches(p111) --[[ Line: 347 ]]
    local l__Cache1__40 = p111.Cache1;
    local l__Cache0__41 = p111.Cache0;
    p111.Cache0 = l__Cache1__40;
    p111.Cache1 = l__Cache0__41;
end;
function v28.UpdatePartCollision(p112, p113, p114) --[[ Line: 351 ]]
    -- upvalues: l__clear__1 (copy), u27 (copy), l__DeferCFrame__15 (copy), l__ApplyRelativeCFrames__12 (copy), l__Flush__14 (copy), l__Evaluate__22 (copy), l__ApplyPropertyList__11 (copy)
    l__clear__1(u27);
    u27.t = p114;
    local v115 = p112.StateIndex[p113];
    local v116 = p112.TimeVaryingIndex[p113];
    local v117;
    if v116 and v116.CFrame then
        v117 = p112.Cache0.CFrames[p113];
    else
        v117 = v115.CFrame;
    end;
    l__DeferCFrame__15(p113, v117);
    local v118 = p112.ObjectGroups[p113];
    local v119;
    if v118 then
        v119 = v118.RelativeCFrames;
    else
        v119 = v118;
    end;
    if v119 then
        l__ApplyRelativeCFrames__12(v117, v119);
    end;
    l__Flush__14(true);
    if v116 and v116.CanCollide then
        local v120 = l__Evaluate__22(v115.CanCollide, u27);
        if v118 then
            v118 = v118.CanCollideList;
        end;
        if v118 then
            l__ApplyPropertyList__11("CanCollide", v120, v118);
        end;
    end;
end;
function v28.PrepareButtonTarget(p121, p122, p123) --[[ Line: 379 ]]
    -- upvalues: u83 (copy), u92 (copy), l__DeferCFrame__15 (copy), l__ApplyRelativeCFrames__12 (copy), l__Flush__14 (copy)
    local v124 = p121.ObjectGroups[p122];
    if v124 then
        v124 = v124.RelativeCFrames;
    end;
    local v125 = nil;
    if v124 then
        local v126, v127 = u83(p121, p122, p123);
        local v128 = p121.ObjectGroupBasePart[p122];
        local v129;
        if v128 then
            v129, v125 = u92(p121, v128, p123);
            if v127 then
                v129 = v129 * v126;
                v125 = v125 * (v127 + v126.p);
            end;
        else
            v125 = v127;
            v129 = v126;
        end;
        if v129 then
            l__DeferCFrame__15(p122, v129);
            l__ApplyRelativeCFrames__12(v129, v124);
        end;
    elseif p122:IsA("BasePart") then
        l__DeferCFrame__15(p122, p121:GetPartCFrame(p122, p123));
    end;
    l__Flush__14(true);
    if v125 then
        p122.Velocity = v125.p;
    else
        if p122:IsA("BasePart") then
            p122.Velocity = p121:GetPartImplicitVelocity(p122, p123);
        end;
    end;
end;
function v28.BuildPartCache(p130, p131, p132) --[[ Line: 400 ]]
    -- upvalues: l__clear__1 (copy), u27 (copy), l__Evaluate__22 (copy)
    local l__Cache0__42 = p130.Cache0;
    local l__Cache1__43 = p130.Cache1;
    local v133 = p130.TimeVaryingIndex[p131];
    if v133 and v133.CFrame then
        l__clear__1(u27);
        u27.t = p132;
        local l__CFrame__44 = p130.StateIndex[p131].CFrame;
        l__Cache0__42.CFrames[p131] = l__Evaluate__22(l__CFrame__44, u27);
        l__Cache0__42.TimeOverrides[p131] = p132;
        u27.t = l__Cache1__43.Time;
        l__Cache1__43.CFrames[p131] = l__Evaluate__22(l__CFrame__44, u27);
    else
        l__Cache0__42.CFrames[p131] = nil;
        l__Cache0__42.TimeOverrides[p131] = nil;
        l__Cache1__43.CFrames[p131] = nil;
        l__Cache1__43.TimeOverrides[p131] = nil;
    end;
end;
function v28.UpdateStaticCollision(p134) --[[ Line: 420 ]]
    -- upvalues: u2 (copy), l__DeferCFrame__15 (copy), l__ApplyRelativeCFrames__12 (copy), u1 (copy), l__ApplyPropertyList__11 (copy), l__Flush__14 (copy)
    local l__ObjectGroups__45 = p134.ObjectGroups;
    for v135, v136 in p134.StateIndex do
        local l__CFrame__46 = v136.CFrame;
        local v137 = l__ObjectGroups__45[v135];
        if u2(l__CFrame__46) == "CFrame" and v135.CFrame ~= l__CFrame__46 then
            l__DeferCFrame__15(v135, l__CFrame__46);
            local v138;
            if v137 then
                v138 = v137.RelativeCFrames;
            else
                v138 = v137;
            end;
            if v138 then
                l__ApplyRelativeCFrames__12(l__CFrame__46, v138);
            end;
        end;
        local l__CanCollide__47 = v136.CanCollide;
        if u1(l__CanCollide__47) == "boolean" and v135.CanCollide ~= l__CanCollide__47 then
            if v137 then
                v137 = v137.CanCollideList;
            end;
            if v137 then
                l__ApplyPropertyList__11("CanCollide", l__CanCollide__47, v137);
            else
                v135.CanCollide = l__CanCollide__47;
            end;
        end;
    end;
    l__Flush__14(true);
end;
function v28.UpdateDynamicCollision(p139, p140) --[[ Line: 448 ]]
    -- upvalues: l__DeferCFrame__15 (copy), l__ApplyRelativeCFrames__12 (copy), l__Flush__14 (copy), l__clear__1 (copy), u27 (copy), l__Evaluate__22 (copy), l__ApplyPropertyList__11 (copy)
    local l__ObjectGroups__48 = p139.ObjectGroups;
    for v141, v142 in p140.CFrames do
        l__DeferCFrame__15(v141, v142);
        local v143 = l__ObjectGroups__48[v141];
        if v143 then
            v143 = v143.RelativeCFrames;
        end;
        if v143 then
            l__ApplyRelativeCFrames__12(v142, v143);
        end;
    end;
    l__Flush__14(true);
    l__clear__1(u27);
    u27.t = p140.Time;
    local l__StateIndex__49 = p139.StateIndex;
    for v144, v145 in p139.TimeVaryingIndex do
        if v145.CanCollide then
            local v146 = l__Evaluate__22(l__StateIndex__49[v144].CanCollide, u27);
            local v147 = l__ObjectGroups__48[v144];
            if v147 then
                v147 = v147.CanCollideList;
            end;
            if v147 then
                l__ApplyPropertyList__11("CanCollide", v146, v147);
            else
                v144.CanCollide = v146;
            end;
        end;
    end;
end;
function v28.BuildCache(p148, p149, p150) --[[ Line: 480 ]]
    -- upvalues: l__clear__1 (copy), u27 (copy), l__Evaluate__22 (copy)
    local l__CFrames__50 = p149.CFrames;
    p149.Time = p150;
    l__clear__1(u27);
    u27.t = p150;
    local l__StateIndex__51 = p148.StateIndex;
    for v151, v152 in p148.TimeVaryingIndex do
        if v152.CFrame then
            l__CFrames__50[v151] = l__Evaluate__22(l__StateIndex__51[v151].CFrame, u27);
        end;
    end;
end;
function v28.PrepareInterpolationTarget(p153, p154) --[[ Line: 493 ]]
    p153:SwapCaches();
    p153:ClearCache();
    p153:UpdateStaticCollision();
    p153:UpdateDynamicCollision(p153.Cache0);
    p153:BuildCache(p153.Cache1, p154);
end;
function v28.UpdateStaticVisible(p155) --[[ Line: 501 ]]
    -- upvalues: u2 (copy), l__DeferCFrame__15 (copy), l__ApplyRelativeCFrames__12 (copy), u1 (copy), l__ApplyRelativeTransparencies__13 (copy), l__new__21 (copy), l__IsA__4 (copy), l__ApplyPropertyList__11 (copy), l__Flush__14 (copy)
    local l__ObjectGroups__52 = p155.ObjectGroups;
    for v156, v157 in p155.StateIndex do
        local v158 = l__ObjectGroups__52[v156];
        local l__CFrame__53 = v157.CFrame;
        if u2(l__CFrame__53) == "CFrame" and v156.CFrame ~= l__CFrame__53 then
            l__DeferCFrame__15(v156, l__CFrame__53);
            local v159;
            if v158 then
                v159 = v158.RelativeCFrames;
            else
                v159 = v158;
            end;
            if v159 then
                l__ApplyRelativeCFrames__12(l__CFrame__53, v159);
            end;
        end;
        local l__Transparency__54 = v157.Transparency;
        if u1(l__Transparency__54) == "number" and v156.Transparency ~= l__Transparency__54 then
            local v160;
            if v158 then
                v160 = v158.RelativeTransparencies;
            else
                v160 = v158;
            end;
            if v160 then
                l__ApplyRelativeTransparencies__13(l__Transparency__54, v160);
            else
                v156.Transparency = l__Transparency__54;
            end;
        end;
        local l__Color3__55 = v157.Color3;
        if u2(l__Color3__55) == "Vector3" then
            local v161 = l__new__21(l__Color3__55.x, l__Color3__55.y, l__Color3__55.z);
            local v162 = l__IsA__4(v156, "BasePart") and "Color" or "Color3";
            if v156[v162] ~= v161 then
                v156[v162] = v161;
                local v163;
                if v158 then
                    v163 = v158.Color3List;
                else
                    v163 = v158;
                end;
                if v163 then
                    l__ApplyPropertyList__11(v162, v161, v163);
                end;
            end;
        end;
        local l__CanCollide__56 = v157.CanCollide;
        if u1(l__CanCollide__56) == "boolean" and v156.CanCollide ~= l__CanCollide__56 then
            if v158 then
                v158 = v158.CanCollideList;
            end;
            if v158 then
                l__ApplyPropertyList__11("CanCollide", l__CanCollide__56, v158);
            else
                v156.CanCollide = l__CanCollide__56;
            end;
        end;
    end;
    l__Flush__14(true);
end;
function v28.UpdateNearDomainBB(_, _, _) --[[ Line: 554 ]] end;
function v28.UpdateBB(_, _) --[[ Line: 559 ]] end;
function v28.UpdateDynamicVisible(p164, p165, _) --[[ Line: 565 ]]
    -- upvalues: l__clear__1 (copy), u27 (copy), l__DeferCFrame__15 (copy), l__ApplyRelativeCFrames__12 (copy), l__Evaluate__22 (copy), l__ApplyRelativeTransparencies__13 (copy), l__new__21 (copy), l__IsA__4 (copy), l__ApplyPropertyList__11 (copy), l__Flush__14 (copy)
    local v166 = p164.Timer:Time(p165);
    l__clear__1(u27);
    u27.t = v166;
    local l__StateIndex__57 = p164.StateIndex;
    local l__ObjectGroups__58 = p164.ObjectGroups;
    for v167, v168 in p164.TimeVaryingIndex do
        local v169 = l__StateIndex__57[v167];
        local v170 = l__ObjectGroups__58[v167];
        if v168.CFrame then
            local v171 = p164:GetPartCFrame(v167, v166);
            l__DeferCFrame__15(v167, v171);
            local v172;
            if v170 then
                v172 = v170.RelativeCFrames;
            else
                v172 = v170;
            end;
            if v172 then
                l__ApplyRelativeCFrames__12(v171, v172);
            end;
        end;
        if v168.Transparency then
            local v173 = l__Evaluate__22(v169.Transparency, u27);
            local v174;
            if v170 then
                v174 = v170.RelativeTransparencies;
            else
                v174 = v170;
            end;
            if v174 then
                l__ApplyRelativeTransparencies__13(v173, v174);
            else
                v167.Transparency = v173;
            end;
        end;
        if v168.Color3 then
            local v175 = l__Evaluate__22(v169.Color3, u27);
            local v176 = l__new__21(v175.x, v175.y, v175.z);
            local v177 = l__IsA__4(v167, "BasePart") and "Color" or "Color3";
            v167[v177] = v176;
            local v178;
            if v170 then
                v178 = v170.Color3List;
            else
                v178 = v170;
            end;
            if v178 then
                l__ApplyPropertyList__11(v177, v176, v178);
            end;
        end;
        if v168.CanCollide then
            local v179 = l__Evaluate__22(v169.CanCollide, u27);
            if v170 then
                v170 = v170.CanCollideList;
            end;
            if v170 then
                l__ApplyPropertyList__11("CanCollide", v179, v170);
            else
                v167.CanCollide = v179;
            end;
        end;
    end;
    l__Flush__14(true);
end;
function v28.ActivateButton(p180, p181, p182) --[[ Line: 619 ]]
    -- upvalues: u3 (copy), l__SetState__6 (copy), u15 (copy)
    local v183 = p180.ById[p181];
    if v183 then
        local l__ActivateIndex__59 = p180.ActivateIndex;
        for v184 = 1, #v183 do
            local v185 = v183[v184];
            p180:PrepareButtonTarget(v185, p182);
            local v186, v187 = u3(l__ActivateIndex__59[v185][p181], p182);
            if v186 then
                l__SetState__6(p180, v185, v187, p182);
            else
                u15("Error calling function for " .. p180.ReverseIndex[v185]:GetFullName() .. ":", v187);
            end;
        end;
    end;
    return v183 ~= nil;
end;
function v28.GetState(p188) --[[ Line: 640 ]]
    -- upvalues: l__clone__2 (copy), u14 (copy)
    return {
        Timer = p188.Timer:GetState(),
        Cache0 = p188.Cache0:GetState(),
        Cache1 = p188.Cache1:GetState(),
        StateIndex = l__clone__2(p188.StateIndex),
        TimeVaryingIndex = l__clone__2(p188.TimeVaryingIndex),
        InteractiveContext = u14(p188.InteractiveContext)
    };
end;
function v28.SetState(p189, p190) --[[ Line: 650 ]]
    -- upvalues: l__clone__2 (copy), l__clear__1 (copy), u14 (copy)
    p189.Timer:SetState(p190.Timer);
    p189.Cache0:SetState(p190.Cache0);
    p189.Cache1:SetState(p190.Cache1);
    p189.StateIndex = l__clone__2(p190.StateIndex);
    p189.TimeVaryingIndex = l__clone__2(p190.TimeVaryingIndex);
    l__clear__1(p189.InteractiveContext);
    u14(p190.InteractiveContext, p189.InteractiveContext);
end;
function v28.CopyState(p191, p192) --[[ Line: 659 ]]
    -- upvalues: l__clear__1 (copy), u16 (copy), u14 (copy)
    if p191.ReferenceWorld == p192.ReferenceWorld then
        p191.Cache0:CopyState(p192.Cache0);
        p191.Cache1:CopyState(p192.Cache1);
        l__clear__1(p191.TimeVaryingIndex);
        p191.TimeVaryingIndex = u16(p192.TimeVaryingIndex, p191.TimeVaryingIndex);
        l__clear__1(p191.StateIndex);
        p191.StateIndex = u16(p192.StateIndex, p191.StateIndex);
    else
        local l__CloneToOriginal__60 = p192.CloneToOriginal;
        local l__OriginalToClone__61 = p191.OriginalToClone;
        p191.Cache0:CopyStateRemap(p192.Cache0, l__CloneToOriginal__60, l__OriginalToClone__61);
        p191.Cache1:CopyStateRemap(p192.Cache1, l__CloneToOriginal__60, l__OriginalToClone__61);
        local l__StateIndex__62 = p191.StateIndex;
        l__clear__1(l__StateIndex__62);
        for v193, v194 in p192.StateIndex do
            local v195 = l__OriginalToClone__61[l__CloneToOriginal__60[v193]];
            assert(v195 ~= nil, "nil");
            l__StateIndex__62[v195] = v194;
        end;
        local l__TimeVaryingIndex__63 = p191.TimeVaryingIndex;
        l__clear__1(l__TimeVaryingIndex__63);
        for v196, v197 in p192.TimeVaryingIndex do
            local v198 = l__OriginalToClone__61[l__CloneToOriginal__60[v196]];
            assert(v198 ~= nil, "nil");
            l__TimeVaryingIndex__63[v198] = v197;
        end;
    end;
    l__clear__1(p191.InteractiveContext);
    u14(p192.InteractiveContext, p191.InteractiveContext);
end;
function v28.SetReference(p199, p200) --[[ Line: 690 ]]
    -- upvalues: l__clear__1 (copy), u14 (copy)
    p199.ReferenceWorld = p200;
    p199.ID = p200.ID;
    p199.ById = p200.ById;
    p199.Storage = p200.Storage;
    p199.RobloxModel = p200.RobloxModel;
    p199.OverlapParams = p200.OverlapParams;
    p199.ObjectGroups = p200.ObjectGroups;
    p199.ObjectGroupBasePart = p200.ObjectGroupBasePart;
    p199.ReverseIndex = p200.ReverseIndex;
    p199.InteractiveIndex = p200.InteractiveIndex;
    l__clear__1(p199.InteractiveContext);
    u14(p200.InteractiveContext, p199.InteractiveContext);
    p199.CloneToOriginal = p200.CloneToOriginal;
    p199.OriginalToClone = p200.OriginalToClone;
end;
function v28.DifferentiateState(_, _, p201) --[[ Line: 707 ]]
    assert(p201 ~= nil, "DifferentiateState Instructions cannot be nil");
end;
function v28.IntegrateState(_, _) --[[ Line: 711 ]] end;
local function u209(p202, p203, p204) --[[ Line: 715 ]]
    -- upvalues: l__ApplyRelativeTransparencies__13 (copy), l__ApplyPropertyList__11 (copy), l__IsA__4 (copy), l__FetchState__7 (copy)
    local v205;
    if p204 then
        v205 = p204.RelativeTransparencies;
    else
        v205 = p204;
    end;
    if v205 then
        l__ApplyRelativeTransparencies__13(p203.Transparency, v205);
    else
        p202.Transparency = p203.Transparency;
    end;
    if p204 then
        p204 = p204.CanCollideList;
    end;
    if p204 then
        l__ApplyPropertyList__11("CanCollide", p203.CanCollide, p204);
    elseif l__IsA__4(p202, "BasePart") then
        p202.CanCollide = p203.CanCollide;
    end;
    local v206 = p202:Clone();
    local v207, v208 = l__FetchState__7(v206);
    if v205 then
        local l__RelativeTransparencies__64 = v208.RelativeTransparencies;
        l__RelativeTransparencies__64[v206] = v205[p202];
        l__ApplyRelativeTransparencies__13(1, v205);
        l__ApplyRelativeTransparencies__13(1, l__RelativeTransparencies__64);
    else
        p202.Transparency = 1;
        v206.Transparency = 1;
    end;
    if p204 then
        l__ApplyPropertyList__11("CanCollide", false, p204);
    elseif l__IsA__4(p202, "BasePart") then
        p202.CanCollide = false;
    end;
    v207.Color3 = p203.Color3;
    return v206, v207, v208;
end;
function v28.InitClone(p210, p211) --[[ Line: 750 ]]
    -- upvalues: l__new__26 (copy), u25 (copy), l__new__23 (copy), l__Include__25 (copy), l__clear__1 (copy), u209 (copy), l__IsA__4 (copy), l__CalculateImplicits__9 (copy), l__insert__3 (copy), u3 (copy), u4 (copy), u15 (copy), u26 (copy), l__MergeState__8 (copy)
    p210.ID = p211.MapChangeID;
    p210.RobloxModel = p211.RobloxModel;
    p210.ReferenceWorld = p210;
    local v212 = l__new__26("Model", u25);
    p210.Storage = v212;
    local v213 = l__new__23();
    v213.FilterDescendantsInstances = { p211.RobloxModel, v212 };
    v213.FilterType = l__Include__25;
    p210.OverlapParams = v213;
    local l__ById__65 = p210.ById;
    local l__StateIndex__66 = p210.StateIndex;
    local l__ObjectGroups__67 = p210.ObjectGroups;
    local l__ObjectGroupBasePart__68 = p210.ObjectGroupBasePart;
    local l__ReverseIndex__69 = p210.ReverseIndex;
    local l__InteractiveIndex__70 = p210.InteractiveIndex;
    local l__CloneToOriginal__71 = p210.CloneToOriginal;
    local l__OriginalToClone__72 = p210.OriginalToClone;
    l__clear__1(l__ById__65);
    l__clear__1(l__StateIndex__66);
    l__clear__1(l__ObjectGroups__67);
    l__clear__1(l__ObjectGroupBasePart__68);
    l__clear__1(l__ReverseIndex__69);
    l__clear__1(l__InteractiveIndex__70);
    l__clear__1(l__CloneToOriginal__71);
    l__clear__1(l__OriginalToClone__72);
    local l__WorldInfo__73 = p211.WorldInfo;
    if l__WorldInfo__73 then
        if l__WorldInfo__73.Interactive then
            for v214, v215 in l__WorldInfo__73.Interactive do
                local v216 = v215[1];
                local v217 = l__ById__65[v216];
                if v216 and not v217 then
                    v217 = {};
                    l__ById__65[v216] = v217;
                end;
                local l__Parent__74 = v214.Parent;
                local v218 = l__OriginalToClone__72[l__Parent__74];
                if not v218 then
                    local v219, v220;
                    v218, v219, v220 = u209(l__Parent__74, v215[2], v215[3]);
                    v218.Parent = v212;
                    if l__IsA__4(l__Parent__74, "BasePart") then
                        v218.CanQuery = true;
                    end;
                    l__CloneToOriginal__71[v218] = l__Parent__74;
                    l__OriginalToClone__72[l__Parent__74] = v218;
                    l__StateIndex__66[v218] = l__CalculateImplicits__9(v219);
                    l__ObjectGroups__67[v218] = v220;
                    l__InteractiveIndex__70[v218] = {};
                    if v220 and v220.RelativeCFrames then
                        for v221 in v220.RelativeCFrames do
                            v221.CanQuery = true;
                            l__ObjectGroupBasePart__68[v221] = v218;
                        end;
                    end;
                    l__ReverseIndex__69[v218] = v214;
                end;
                l__insert__3(v217, v218);
                local v222, v223 = u3(u4, v214);
                if v222 then
                    l__InteractiveIndex__70[v218][v216] = v223;
                else
                    u15("Error loading ModuleScript " .. v214:GetFullName() .. ":", v223);
                end;
            end;
        end;
        if l__WorldInfo__73.Analytic then
            for v224, v225 in l__WorldInfo__73.Analytic do
                local l__Parent__75 = v224.Parent;
                local v226 = l__OriginalToClone__72[l__Parent__75];
                local v227;
                if v226 then
                    v227 = l__StateIndex__66[v226];
                else
                    local v228;
                    v226, v227, v228 = u209(l__Parent__75, v225[1], v225[2]);
                    v226.Parent = v212;
                    if l__IsA__4(l__Parent__75, "BasePart") then
                        v226.CanQuery = true;
                    end;
                    l__CloneToOriginal__71[v226] = l__Parent__75;
                    l__OriginalToClone__72[l__Parent__75] = v226;
                    l__ObjectGroups__67[v226] = v228;
                    if v228 and v228.RelativeCFrames then
                        for v229 in v228.RelativeCFrames do
                            v229.CanQuery = true;
                            l__ObjectGroupBasePart__68[v229] = v226;
                        end;
                    end;
                end;
                local v230, v231 = u3(u4, v224);
                if v230 then
                    local v232, v233 = u3(v231, u26, v226);
                    if v232 then
                        v227 = l__MergeState__8(v227, v233);
                    else
                        u15("Error calling function for " .. v224:GetFullName() .. ":", v233);
                    end;
                else
                    u15("Error loading Object " .. v224:GetFullName() .. ":", v231);
                end;
                local v234 = l__StateIndex__66[v226];
                if v234 then
                    v227 = l__MergeState__8(v234, v227);
                end;
                l__StateIndex__66[v226] = v227;
            end;
        end;
    end;
end;
function v28.InitReuse(p235, p236, p237, p238) --[[ Line: 872 ]]
    -- upvalues: u18 (copy)
    p235:SetReference(p236);
    local v239 = u18(p237);
    if p237 then
        v239:SetTime(p237:Time(), p238);
    end;
    p235.Timer = v239;
    p235:Reset(p238);
end;
function v28.SetTime(p240, p241, p242) --[[ Line: 884 ]]
    if p241 then
        p240.Timer:SetTime(p241, p242);
    end;
    p240:BuildCache(p240.Cache1, p242);
    p240.Cache0:CopyState(p240.Cache1);
    p240:UpdateStaticCollision();
    p240:UpdateDynamicCollision(p240.Cache1);
end;
function v28.Reset(p243, p244) --[[ Line: 894 ]]
    -- upvalues: l__SetState__6 (copy), l__clear__1 (copy), u3 (copy), u26 (copy), u15 (copy)
    p243:CopyState(p243.ReferenceWorld);
    for v245, v246 in p243.StateIndex do
        l__SetState__6(p243, v245, v246, p244);
    end;
    local l__ActivateIndex__76 = p243.ActivateIndex;
    local l__InteractiveContext__77 = p243.InteractiveContext;
    l__clear__1(l__InteractiveContext__77);
    for v247, v248 in p243.InteractiveIndex do
        l__ActivateIndex__76[v247] = {};
        for v249, v250 in v248 do
            local v251, v252 = u3(v250, u26, v247, l__InteractiveContext__77);
            if v251 then
                l__ActivateIndex__76[v247][v249] = v252;
            else
                local v253 = p243.ReverseIndex[v247];
                local v254;
                if v253 then
                    v254 = v253:GetFullName();
                else
                    v254 = "[ReverseIndex nil Object=" .. v247:GetFullName() .. "]";
                end;
                u15("Error calling function for " .. v254 .. ":", v252);
            end;
        end;
    end;
end;
function v28.Remove(p255) --[[ Line: 928 ]]
    if p255.Storage then
        p255.Storage:Destroy();
    end;
    if p255.Tracker then
        p255.Tracker:Remove();
    end;
end;
function v28.Constructor(p256) --[[ Line: 938 ]]
    -- upvalues: u18 (copy), u20 (copy)
    p256.Timer = u18();
    p256.Cache0 = u20();
    p256.Cache1 = u20();
    p256.ById = {};
    p256.StateIndex = {};
    p256.ReverseIndex = {};
    p256.InteractiveIndex = {};
    p256.InteractiveContext = {};
    p256.ActivateIndex = {};
    p256.TimeVaryingIndex = {};
    p256.CloneToOriginal = {};
    p256.OriginalToClone = {};
    p256.ObjectGroups = {};
    p256.ObjectGroupBasePart = {};
end;
return v28;
