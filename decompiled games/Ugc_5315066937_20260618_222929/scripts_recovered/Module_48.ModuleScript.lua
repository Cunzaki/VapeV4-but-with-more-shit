-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = next;
local u2 = pcall;
local _ = table.clear;
local l__insert__1 = table.insert;
local l__IsA__2 = game.IsA;
local l__obtain__3 = _G.obtain;
local u3 = l__obtain__3("LabelPrint");
local u4 = l__obtain__3("rsearch");
local u5 = l__obtain__3("L1Copy");
local l__DeferCFrame__4 = l__obtain__3("BulkMove").DeferCFrame;
local v6 = l__obtain__3("Region");
local l__BoundingSphere__5 = v6.BoundingSphere;
local l__AddCFrameHalfSize__6 = v6.AddCFrameHalfSize;
local u7 = l__obtain__3("GetPartCFrame");
local l__new__7 = Vector3.new;
local u8 = l__new__7();
local l__identity__8 = CFrame.identity;
local l__Inverse__9 = l__identity__8.Inverse;
local v9 = l__obtain__3("LuCAS");
local l__CFrame__10 = v9.CFrame;
local l__CFrameVectorPart__11 = v9.CFrameVectorPart;
local l__CFrameQuaternionPart__12 = v9.CFrameQuaternionPart;
local l__Compile__13 = v9.Compile;
local l__Evaluate__14 = v9.Evaluate;
local l__Derivative__15 = v9.Derivative;
local l__new__16 = OverlapParams.new;
local l__Include__17 = Enum.RaycastFilterType.Include;
local u10 = {
    BasePart = {
        Size = "Vector3",
        CFrame = "CFrame",
        Velocity = "Vector3",
        CanCollide = "boolean",
        RotVelocity = "Vector3",
        Transparency = "number",
        Color = "Vector3"
    },
    SelectionBox = {
        Color3 = "Vector3",
        Transparency = "number"
    }
};
local u11 = {};
for _, v12 in u10 do
    u5(v12, u11);
end;
local u15 = {
    BasePart = function(p13) --[[ Name: BasePart, Line 64 ]]
        -- upvalues: l__IsA__2 (copy)
        return l__IsA__2(p13, "BasePart");
    end,
    SelectionBox = function(p14) --[[ Name: SelectionBox, Line 67 ]]
        -- upvalues: l__IsA__2 (copy)
        return l__IsA__2(p14, "SelectionBox");
    end
};
local function u17(p16) --[[ Line: 71 ]]
    -- upvalues: l__IsA__2 (copy)
    return l__IsA__2(p16, "FaceInstance");
end;
local u18 = {
    Size = true,
    CFrame = true,
    Color3 = true,
    Velocity = true,
    CanCollide = true,
    RotVelocity = true,
    Transparency = true,
    ImplicitVelocity = true,
    ImplicitRotVelocity = true,
    ImplicitAcceleration = true
};
local function u28(p19, p20, p21) --[[ Line: 120 ]]
    -- upvalues: u18 (copy), u2 (copy), l__Evaluate__14 (copy), u1 (copy)
    local l__StateIndex__18 = p19.StateIndex;
    local l__TimeVaryingIndex__19 = p19.TimeVaryingIndex;
    local v22 = l__StateIndex__18[p20];
    local v23 = {};
    for v24, v25 in p21 do
        if u18[v24] then
            if type(v25) == "table" and v25.IsTimeVarying then
                v23[v24] = true;
            else
                local v26, v27 = u2(l__Evaluate__14, v25);
                if v26 then
                    if v27 ~= v25 then
                        v22[v24] = v27;
                    end;
                else
                    v23[v24] = true;
                end;
            end;
        end;
    end;
    if u1(v23) then
        l__TimeVaryingIndex__19[p20] = v23;
    else
        l__TimeVaryingIndex__19[p20] = nil;
    end;
end;
local function u33(p29) --[[ Line: 283 ]]
    -- upvalues: l__Derivative__15 (copy), l__Compile__13 (copy), l__CFrameVectorPart__11 (copy), l__CFrameQuaternionPart__12 (copy)
    local v30 = {};
    if p29.CFrame then
        if not p29.ImplicitVelocity then
            v30.ImplicitVelocity = true;
            p29.ImplicitVelocity = l__Derivative__15(l__Compile__13(l__CFrameVectorPart__11(p29.CFrame)), "t");
            if type(p29.ImplicitVelocity) == "table" then
                p29.ImplicitVelocity.IsTimeVarying = true;
            end;
        end;
        if not p29.ImplicitRotVelocity then
            local v31 = l__Compile__13(l__CFrameQuaternionPart__12(p29.CFrame));
            v30.ImplicitRotVelocity = true;
            p29.ImplicitRotVelocity = {
                "QuaternionVectorPart",
                {
                    "QMulScalar",
                    {
                        "QMul",
                        l__Derivative__15(v31, "t"),
                        { "QInv", v31 }
                    },
                    2
                }
            };
            p29.ImplicitRotVelocity.IsTimeVarying = true;
        end;
    end;
    if not p29.ImplicitAcceleration and p29.ImplicitVelocity then
        v30.ImplicitAcceleration = true;
        local v32;
        if v30.ImplicitVelocity then
            v32 = p29.ImplicitVelocity;
        else
            v30.ImplicitVelocity = true;
            v32 = l__Compile__13(p29.ImplicitVelocity);
            p29.ImplicitVelocity = v32;
        end;
        p29.ImplicitAcceleration = l__Derivative__15(v32, "t");
        if type(p29.ImplicitAcceleration) == "table" then
            p29.ImplicitAcceleration.IsTimeVarying = true;
        end;
    end;
    return p29, v30;
end;
local function u44(p34, p35) --[[ Line: 321 ]]
    -- upvalues: u11 (copy), l__CFrame__10 (copy), l__CFrameVectorPart__11 (copy), l__CFrameQuaternionPart__12 (copy), u33 (copy), l__Compile__13 (copy)
    if not p35 then
        return p34;
    end;
    if p34 == p35 then
        return p34;
    end;
    local v36 = {};
    for v37, v38 in p35 do
        if u11[v37] then
            v36[v37] = v38;
        end;
    end;
    if not v36.CFrame and (p35.Position or p35.Orientation) then
        v36.CFrame = l__CFrame__10(p35.Position or l__CFrameVectorPart__11(p34.CFrame), p35.Orientation or l__CFrameQuaternionPart__12(p34.CFrame));
    end;
    local v39, v40 = u33(v36);
    if p34 then
        for v41, v42 in p34 do
            local v43 = v39[v41];
            if v43 == nil then
                v39[v41] = v42;
            elseif not v40[v41] then
                v40[v41] = true;
                v39[v41] = l__Compile__13(v43);
            end;
        end;
    end;
    return v39;
end;
return {
    GetPartCFrame = u7,
    FetchState = function(p45) --[[ Name: FetchState, Line 150 ]]
        -- upvalues: u10 (copy), u15 (copy), u7 (copy), l__new__7 (copy), u4 (copy), u1 (copy), l__Inverse__9 (copy), l__BoundingSphere__5 (copy), u8 (copy), l__AddCFrameHalfSize__6 (copy), l__identity__8 (copy), l__insert__1 (copy), l__new__16 (copy), l__Include__17 (copy), u5 (copy), u17 (copy), u3 (copy)
        local v46 = {};
        local v47 = {};
        local v48 = false;
        for v49, v50 in u10 do
            local v51 = u15[v49];
            if v51 and v51(p45) then
                v48 = true;
                for v52, _ in v50 do
                    if v52 == "CFrame" then
                        v46.CFrame = u7(p45);
                    else
                        v46[v52] = p45[v52];
                    end;
                end;
                if v49 == "SelectionBox" then
                    local l__Color3__20 = p45.Color3;
                    v46.Color3 = l__new__7(l__Color3__20.r, l__Color3__20.g, l__Color3__20.b);
                    local v53 = u4(p45, v51);
                    if #v53 > 0 then
                        v47.Color3List = v53;
                        local v54 = {};
                        for v55 = 1, #v53 do
                            local v56 = v53[v55];
                            if v56.Transparency ~= 1 then
                                v54[v56] = v56.Transparency;
                            end;
                        end;
                        if u1(v54) then
                            v46.Transparency = 0;
                            if p45.Transparency ~= 1 then
                                v54[p45] = p45.Transparency;
                            end;
                            v47.RelativeTransparencies = v54;
                        elseif p45.Transparency == 1 then
                            for v57 = 1, #v53 do
                                v54[v53[v57]] = 0;
                            end;
                            v54[p45] = 0;
                            v47.RelativeTransparencies = v54;
                        end;
                    end;
                elseif v49 == "BasePart" then
                    local l__Color__21 = p45.Color;
                    v46.Color3 = l__new__7(l__Color__21.r, l__Color__21.g, l__Color__21.b);
                    v46.Color = nil;
                    local v58 = {};
                    local v59 = u4(p45, v51);
                    if #v59 > 0 then
                        local v60 = l__Inverse__9(v46.CFrame);
                        local v61, v62 = l__BoundingSphere__5(u8);
                        l__AddCFrameHalfSize__6(v61, l__identity__8, p45.Size / 2);
                        local v63 = {};
                        local v64 = {};
                        local v65 = {};
                        for v66 = 1, #v59 do
                            local v67 = v59[v66];
                            local v68 = v60 * u7(v67);
                            l__AddCFrameHalfSize__6(v61, v68, v67.Size / 2);
                            v63[v67] = v68;
                            if v67.Transparency ~= 1 then
                                v58[v67] = v67.Transparency;
                            end;
                            if v67.CanCollide then
                                l__insert__1(v65, v67);
                            end;
                            if v67.Color == l__Color__21 then
                                l__insert__1(v64, v67);
                            end;
                        end;
                        local v69, v70 = v62();
                        v47.Center = v69;
                        v47.Radius = v70;
                        v47.RelativeCFrames = v63;
                        local v71 = l__new__16();
                        v71.FilterDescendantsInstances = { p45 };
                        v71.FilterType = l__Include__17;
                        v47.OverlapParams = v71;
                        if #v65 == 0 then
                            if not p45.CanCollide then
                                v46.CanCollide = false;
                                u5(v59, v65);
                                l__insert__1(v65, p45);
                                v47.CanCollideList = v65;
                            end;
                        else
                            v46.CanCollide = true;
                            if p45.CanCollide then
                                l__insert__1(v65, p45);
                            end;
                            v47.CanCollideList = v65;
                        end;
                        v47.Color3List = v64;
                    end;
                    local v72 = u4(p45, u17);
                    for v73 = 1, #v72 do
                        local v74 = v72[v73];
                        if v74.Transparency ~= 1 then
                            v58[v74] = v74.Transparency;
                        end;
                    end;
                    if u1(v58) then
                        v46.Transparency = 0;
                        if p45.Transparency ~= 1 then
                            v58[p45] = p45.Transparency;
                        end;
                        v47.RelativeTransparencies = v58;
                    elseif p45.Transparency == 1 and #v59 + #v72 > 0 then
                        for v75 = 1, #v59 do
                            v58[v59[v75]] = 0;
                        end;
                        for v76 = 1, #v72 do
                            v58[v72[v76]] = 0;
                        end;
                        v58[p45] = 0;
                        v47.RelativeTransparencies = v58;
                    end;
                end;
            end;
        end;
        if not v48 then
            u3("State was not fetched for object=", p45, "of type=", p45.ClassName);
        end;
        if u1(v47) == nil then
            v47 = nil;
        end;
        return v46, v47;
    end,
    MergeState = u44,
    SetState = function(p77, p78, p79, p80) --[[ Name: SetState, Line 360 ]]
        -- upvalues: u44 (copy), u28 (copy), l__IsA__2 (copy)
        local l__StateIndex__22 = p77.StateIndex;
        local v81 = u44(l__StateIndex__22[p78], p79);
        l__StateIndex__22[p78] = v81;
        u28(p77, p78, v81);
        if l__IsA__2(p78, "BasePart") then
            p77:BuildPartCache(p78, p80);
            p77:UpdatePartCollision(p78, p80);
        end;
    end,
    CalculateImplicits = u33,
    UpdateTimeVaryingIndex = u28,
    ApplyRelativeCFrames = function(p82, p83) --[[ Name: ApplyRelativeCFrames, Line 104 ]]
        -- upvalues: l__DeferCFrame__4 (copy)
        for v84, v85 in p83 do
            l__DeferCFrame__4(v84, p82 * v85);
        end;
    end,
    ApplyRelativeTransparencies = function(p86, p87) --[[ Name: ApplyRelativeTransparencies, Line 109 ]]
        for v88, v89 in p87 do
            v88.Transparency = 1 - (1 - p86) * (1 - v89);
        end;
    end,
    ApplyPropertyList = function(p90, p91, p92) --[[ Name: ApplyPropertyList, Line 114 ]]
        for v93 = 1, #p92 do
            p92[v93][p90] = p91;
        end;
    end
};
