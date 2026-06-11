-- Decompiled from: .KOTH.Script.Region3Modulo
-- Class: ModuleScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__CubeCollision__1 = require(script.CubeCollision);
return function(p1, p2, p3, u4) --[[ Line: 13 ]]
    -- upvalues: l__CubeCollision__1 (copy)
    local v5 = {};
    local v6 = p3 or CFrame.fromAxisAngle(Vector3.new(0, 1, 0), 0);
    local u7 = p2 - p1;
    local u8 = CFrame.new(p1 + u7 / 2) * v6;
    function v5.PointInRegion3(_, p9) --[[ Line: 24 ]]
        -- upvalues: u8 (copy), u7 (copy)
        local l__p__2 = u8:toObjectSpace(CFrame.new(p9)).p;
        local l__abs__3 = math.abs;
        local v10 = l__abs__3(l__p__2.X);
        local v11 = l__abs__3(l__p__2.Y);
        local v12 = l__abs__3(l__p__2.Z);
        local v13 = Vector3.new(v10, v11, v12);
        local v14 = u7 / 2;
        local l__abs__4 = math.abs;
        local v15 = l__abs__4(v14.X);
        local v16 = l__abs__4(v14.Y);
        local v17 = l__abs__4(v14.Z);
        local v18 = Vector3.new(v15, v16, v17);
        local v19 = v13.X <= v18.X and v13.Y <= v18.Y;
        if v19 then
            local v20 = v13.Z > v18.Z;
            v19 = not v20;
        end;
        return v19;
    end;
    function v5.PartInRegion3(_, p21) --[[ Line: 30 ]]
        -- upvalues: l__CubeCollision__1 (ref), u8 (copy), u7 (copy)
        local v22 = l__CubeCollision__1;
        local l__CFrame__5 = p21.CFrame;
        local l__Size__6 = p21.Size;
        local v23 = u8;
        local v24 = u7;
        local l__abs__7 = math.abs;
        local v25 = l__abs__7(v24.X);
        local v26 = l__abs__7(v24.Y);
        local v27 = l__abs__7(v24.Z);
        return v22(l__CFrame__5, l__Size__6, v23, (Vector3.new(v25, v26, v27)));
    end;
    function v5.BoundsInRegion3(_, p28, p29) --[[ Line: 33 ]]
        -- upvalues: l__CubeCollision__1 (ref), u8 (copy), u7 (copy)
        local v30 = l__CubeCollision__1;
        local v31 = u8;
        local v32 = u7;
        local l__abs__8 = math.abs;
        local v33 = l__abs__8(v32.X);
        local v34 = l__abs__8(v32.Y);
        local v35 = l__abs__8(v32.Z);
        return v30(p28, p29, v31, (Vector3.new(v33, v34, v35)));
    end;
    function v5.FindPartsInRegion3Whitelist(u36, p37, p38) --[[ Line: 36 ]]
        -- upvalues: u4 (copy)
        local u39 = {};
        local u40 = type(p37) == "table" and (p37 or { p37 }) or { p37 };
        local u41 = p38 and (p38 > 0 and p38) or 20;
        local v42 = u4[1];
        local v43 = u4[2];
        local v44 = { v43.X, v43.Y, v43.Z };
        local l__max__9 = math.max;
        local l__min__10 = math.min;
        local v45 = math.max(unpack(v44));
        local v46 = Vector3.new(v45, v45, v45);
        local v47 = v42 - v46 / 2;
        local v48 = v42 + v46 / 2;
        local v49 = l__min__10(v47.X, v48.X);
        local v50 = l__min__10(v47.Y, v48.Y);
        local v51 = l__min__10(v47.Z, v48.Z);
        local v52 = Vector3.new(v49, v50, v51);
        local v53 = l__max__9(v47.X, v48.X);
        local v54 = l__max__9(v47.Y, v48.Y);
        local v55 = l__max__9(v47.Z, v48.Z);
        local v56 = Vector3.new(v53, v54, v55);
        local v57 = Region3.new(v52, v56);
        local v58 = game.Workspace:FindPartsInRegion3WithWhiteList(v57, u40, u41 or 250);
        print(v58);
        local function u71(p59) --[[ Line: 64 ]]
            -- upvalues: u40 (ref), u36 (copy), u39 (copy), u41 (ref), u71 (copy)
            -- block 17
            if type(p59) ~= "table" then
                p59 = p59:GetChildren();
            end;
            local v60, v61, v62;
            v60, v61, v62 = pairs(p59);
            while true do
                local v63, v64, v65;
                v63, v64, v65 = next, u40, nil;
                local v66, v67;
                if type(v63) == "function" then
                    v66, v67 = v63(v64, v65);
                else
                    v66, v67 = next(v63, v65);
                end;
                v65 = v66;
                local v68 = true;
                local v69;
                if not v68 then
                    if v69:IsA("BasePart") and (u36:PartInRegion3(v69) and #u39 < u41) then
                        u39[#u39 + 1] = v69;
                    else
                        u71(v69);
                    end;
                end;
                local v70;
                if type(v60) == "function" then
                    v70, v69 = v60(v61, v62);
                else
                    v70, v69 = next(v60, v62);
                end;
                v62 = v70;
                -- block 1
            end;
        end;
        u71(v58);
        return u39;
    end;
    function v5.IsRegion3Empty(p72, p73) --[[ Line: 83 ]]
        return #p72:FindPartsInRegion3(p73) == 0;
    end;
    return v5;
end;
