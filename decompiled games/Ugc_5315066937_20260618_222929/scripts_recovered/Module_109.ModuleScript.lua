-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = next;
local u2 = type;
local l__clone__1 = table.clone;
local l__Destroy__2 = game.Destroy;
local l__new__3 = CFrame.new;
local l__new__4 = Vector3.new;
local l__new__5 = Instance.new;
local u3 = l__new__4();
local l__new__6 = Color3.new;
local l__new__7 = ColorSequence.new;
local l__new__8 = ColorSequenceKeypoint.new;
local v4 = _G.obtain("EquipmentCache");
local l__ItemClasses__9 = v4.ItemClasses;
local l__ItemInstances__10 = v4.ItemInstances;
local u5 = {};
local u6 = {};
local u21 = {
    Vector3 = function(p7) --[[ Name: Vector3, Line 79 ]]
        -- upvalues: l__new__4 (copy)
        return l__new__4(p7[1], p7[2], p7[3]);
    end,
    Color3 = function(p8) --[[ Name: Color3, Line 83 ]]
        -- upvalues: l__new__6 (copy)
        return l__new__6(p8[1] / 255, p8[2] / 255, p8[3] / 255);
    end,
    CFrame = function(p9) --[[ Name: CFrame, Line 87 ]]
        -- upvalues: l__new__3 (copy)
        local v10 = #p9;
        if v10 == 3 then
            return l__new__3(p9[1], p9[2], p9[3]);
        end;
        if v10 == 4 then
            return l__new__3(0, 0, 0, p9[1], p9[2], p9[3], p9[4]);
        end;
        if v10 == 7 then
            return l__new__3(p9[1], p9[2], p9[3], p9[4], p9[5], p9[6], p9[7]);
        end;
        if v10 == 12 then
            return l__new__3(p9[1], p9[2], p9[3], p9[4], p9[5], p9[6], p9[7], p9[8], p9[9], p9[10], p9[11], p9[12]);
        end;
    end,
    Enum = function(p11) --[[ Name: Enum, Line 100 ]]
        return p11;
    end,
    Number = function(p12) --[[ Name: Number, Line 104 ]]
        return p12;
    end,
    AssetID = function(p13) --[[ Name: AssetID, Line 108 ]]
        -- upvalues: u2 (copy)
        local v14 = u2(p13);
        if v14 == "number" then
            return "rbxassetid://" .. p13;
        end;
        if v14 == "string" then
            return p13;
        end;
    end,
    ColorSequence = function(p15) --[[ Name: ColorSequence, Line 116 ]]
        -- upvalues: l__new__7 (copy), l__new__6 (copy), l__new__8 (copy)
        local v16 = {};
        local v17 = #p15;
        if v17 == 1 then
            local v18 = p15[1];
            return l__new__7(l__new__6(v18[1] / 255, v18[2] / 255, v18[3] / 255));
        else
            for v19 = 1, v17 do
                local v20 = p15[v19];
                v16[v19] = l__new__8(v20[4] or (v19 - 1) / (v17 - 1), l__new__6(v20[1] / 255, v20[2] / 255, v20[3] / 255));
            end;
            return l__new__7(v16);
        end;
    end
};
local function u38(p22, p23, p24) --[[ Line: 132 ]]
    -- upvalues: u1 (copy), u21 (copy)
    local v25 = {};
    if p23 then
        if p24 then
            for v26, v27 in u1, p22 do
                local v28 = p23[v26] or p24[v26];
                if v28 ~= nil then
                    local v29 = u21[v27];
                    if v29 then
                        v25[v26] = v29(v28);
                    else
                        print("[EquipmentInstantiation] WARNING: No constructor for Type=", v27, "Name=", v26, "Value=", v28);
                        v25[v26] = v28;
                    end;
                end;
            end;
            return v25;
        else
            for v30, v31 in u1, p22 do
                local v32 = p23[v30];
                if v32 ~= nil then
                    local v33 = u21[v31];
                    if v33 then
                        v25[v30] = v33(v32);
                    else
                        print("[EquipmentInstantiation] WARNING: No constructor for Type=", v31, "Name=", v30, "Value=", v32);
                        v25[v30] = v32;
                    end;
                end;
            end;
            return v25;
        end;
    elseif p24 then
        for v34, v35 in u1, p22 do
            local v36 = p24[v34];
            if v36 ~= nil then
                local v37 = u21[v35];
                if v37 then
                    v25[v34] = v37(v36);
                else
                    print("[EquipmentInstantiation] WARNING: No constructor for Type=", v35, "Name=", v34, "Value=", v36);
                    v25[v34] = v36;
                end;
            end;
        end;
        return v25;
    else
        print("[EquipmentInstantiation] bruh where do I get the values stupid head", debug.traceback());
        return v25;
    end;
end;
local u39 = {
    Trail = {
        Color = "ColorSequence",
        FaceCamera = "Boolean",
        LightEmission = "Number",
        LightInfluence = "Number",
        Texture = "AssetID",
        TextureLength = "Number",
        TextureMode = "Enum",
        Transparency = "Number",
        Lifetime = "Number",
        MaxLength = "Number",
        MinLength = "Number",
        WidthScale = "Number"
    },
    Attachment = {
        CFrame = "CFrame"
    },
    WedgePart = {
        TopSurface = "Enum",
        BottomSurface = "Enum",
        Size = "Vector3"
    },
    Part = {
        Transparency = "Number"
    },
    Weld = {
        C0 = "CFrame",
        C1 = "CFrame"
    },
    FileMesh = {
        MeshId = "AssetID",
        TextureId = "AssetID",
        Scale = "Vector3",
        Offset = "Vector3"
    }
};
u5[0] = function(p40, p41) --[[ Line: 232 ]]
    -- upvalues: l__ItemClasses__9 (copy), l__new__5 (copy), u38 (copy), u39 (copy), u1 (copy)
    local v42 = l__ItemClasses__9[p41.Class];
    local v43 = p41.Data or {};
    local v44 = v42.Data or {};
    local l__HRP__11 = p40.HRP;
    local v45 = {
        Character = p40.Character,
        HRP = l__HRP__11,
        Head = p40.Head,
        HeadMesh = p40.HeadMesh,
        Torso = p40.Torso,
        RightArm = p40.RightArm,
        LeftArm = p40.LeftArm,
        RightLeg = p40.RightLeg,
        LeftLeg = p40.LeftLeg,
        TransparencyInfo = p40.TransparencyInfo,
        EnabledInfo = p40.EnabledInfo,
        ItemContainer = l__new__5("Model", p40.ItemContainerParent)
    };
    local l__TrailAttachment__12 = v43.TrailAttachment;
    local l__TrailAttachment__13 = v44.TrailAttachment;
    local v46 = l__new__5("Attachment", l__HRP__11);
    for v47, v48 in u1, u38(u39.Attachment, l__TrailAttachment__12, l__TrailAttachment__13) do
        v46[v47] = v48;
    end;
    v45.TrailAttachment = v46;
    local l__UnderFeetAttachment__14 = v43.UnderFeetAttachment;
    local l__UnderFeetAttachment__15 = v44.UnderFeetAttachment;
    local v49 = l__new__5("Attachment", l__HRP__11);
    for v50, v51 in u1, u38(u39.Attachment, l__UnderFeetAttachment__14, l__UnderFeetAttachment__15) do
        v49[v50] = v51;
    end;
    v45.UnderFeetAttachment = v49;
    return v45;
end;
u6[0] = function(_, p52) --[[ Line: 258 ]]
    -- upvalues: l__Destroy__2 (copy)
    if p52.TrailAttachment then
        l__Destroy__2(p52.TrailAttachment);
    end;
    if p52.UnderFeetAttachment then
        l__Destroy__2(p52.UnderFeetAttachment);
    end;
    if p52.ItemContainer then
        l__Destroy__2(p52.ItemContainer);
    end;
end;
u5[3] = function(p53, p54) --[[ Line: 273 ]]
    -- upvalues: l__ItemClasses__9 (copy), l__new__5 (copy), u21 (copy), u38 (copy), u39 (copy), u1 (copy), l__clone__1 (copy), u3 (copy)
    local v55 = l__ItemClasses__9[p54.Class];
    local v56 = p54.Data or {};
    local v57 = v55.Data or {};
    local v58 = l__new__5("Part", p53.HRP);
    local v59 = l__new__5("Weld", v58);
    local l__CFrame__16 = v57.CFrame;
    if l__CFrame__16 then
        v59.C0 = u21.CFrame(l__CFrame__16);
    end;
    v59.Part0 = p53.HRP;
    v59.Part1 = v58;
    local l__Mesh__17 = v56.Mesh;
    local l__Mesh__18 = v57.Mesh;
    local v60 = l__new__5("FileMesh", v58);
    for v61, v62 in u1, u38(u39.FileMesh, l__Mesh__17, l__Mesh__18) do
        v60[v61] = v62;
    end;
    local l__TransparencyInfo__19 = p53.TransparencyInfo;
    local v63 = l__clone__1(l__TransparencyInfo__19);
    for v64, _ in u1, l__TransparencyInfo__19 do
        l__TransparencyInfo__19[v64] = 1;
    end;
    local l__Scale__20 = p53.HeadMesh.Scale;
    p53.HeadMesh.Scale = u3;
    l__TransparencyInfo__19[p53.Head] = v63[p53.Head];
    local l__EnabledInfo__21 = p53.EnabledInfo;
    local v65 = l__clone__1(l__EnabledInfo__21);
    for v66, _ in u1, l__EnabledInfo__21 do
        l__EnabledInfo__21[v66] = false;
    end;
    return {
        MeshPart = v58,
        OriginalTransparencyInfo = v63,
        OriginalEnabledInfo = v65,
        OriginalHeadMeshScale = l__Scale__20
    };
end;
u6[3] = function(p67, p68) --[[ Line: 303 ]]
    -- upvalues: l__Destroy__2 (copy), u1 (copy)
    if p68.MeshPart then
        l__Destroy__2(p68.MeshPart);
    end;
    p67.HeadMesh.Scale = p68.OriginalHeadMeshScale;
    local l__TransparencyInfo__22 = p67.TransparencyInfo;
    for v69, v70 in u1, p68.OriginalTransparencyInfo do
        l__TransparencyInfo__22[v69] = v70;
    end;
    local l__EnabledInfo__23 = p67.EnabledInfo;
    for v71, v72 in u1, p68.OriginalEnabledInfo do
        l__EnabledInfo__23[v71] = v72;
    end;
end;
u5[5] = function(p73, p74) --[[ Line: 321 ]]
    -- upvalues: l__ItemClasses__9 (copy), l__new__5 (copy), u38 (copy), u39 (copy), u1 (copy)
    local v75 = l__ItemClasses__9[p74.Class];
    local v76 = p74.Data or {};
    local v77 = v75.Data or {};
    local l__HRP__24 = p73.HRP;
    local l__Attachment0__25 = v76.Attachment0;
    local l__Attachment0__26 = v77.Attachment0;
    local v78 = l__new__5("Attachment", l__HRP__24);
    for v79, v80 in u1, u38(u39.Attachment, l__Attachment0__25, l__Attachment0__26) do
        v78[v79] = v80;
    end;
    local l__Attachment1__27 = v76.Attachment1;
    local l__Attachment1__28 = v77.Attachment1;
    local v81 = l__new__5("Attachment", l__HRP__24);
    for v82, v83 in u1, u38(u39.Attachment, l__Attachment1__27, l__Attachment1__28) do
        v81[v82] = v83;
    end;
    local l__ItemContainer__29 = p73.ItemContainer;
    local l__Trail__30 = v76.Trail;
    local l__Trail__31 = v77.Trail;
    local v84 = l__new__5("Trail", l__ItemContainer__29);
    for v85, v86 in u1, u38(u39.Trail, l__Trail__30, l__Trail__31) do
        v84[v85] = v86;
    end;
    v84.Attachment0 = v78;
    v84.Attachment1 = v81;
    return {
        Trail = v84,
        Attachment0 = v78,
        Attachment1 = v81
    };
end;
u6[5] = function(_, p87) --[[ Line: 340 ]]
    -- upvalues: l__Destroy__2 (copy)
    if p87.Trail then
        l__Destroy__2(p87.Trail);
    end;
    if p87.Attachment0 then
        l__Destroy__2(p87.Attachment0);
    end;
    if p87.Attachment1 then
        l__Destroy__2(p87.Attachment1);
    end;
end;
u5[7] = function(p88, p89) --[[ Line: 354 ]]
    -- upvalues: l__ItemClasses__9 (copy), l__new__5 (copy), u38 (copy), u39 (copy), u1 (copy)
    local v90 = l__ItemClasses__9[p89.Class];
    local v91 = p89.Data or {};
    local v92 = v90.Data or {};
    local _ = p88.Character;
    local v93 = nil;
    local v94, v95;
    if v92.Mode == 1 then
        local l__ItemContainer__32 = p88.ItemContainer;
        local l__Handle__33 = v91.Handle;
        local l__Handle__34 = v92.Handle;
        v94 = l__new__5("WedgePart", l__ItemContainer__32);
        for v96, v97 in u1, u38(u39.WedgePart, l__Handle__33, l__Handle__34) do
            v94[v96] = v97;
        end;
        local l__Weld__35 = v91.Weld;
        local l__Weld__36 = v92.Weld;
        v95 = l__new__5("Weld", v94);
        for v98, v99 in u1, u38(u39.Weld, l__Weld__35, l__Weld__36) do
            v95[v98] = v99;
        end;
    else
        v94 = l__new__5("Part", p88.ItemContainer);
        local l__Mesh__37 = v91.Mesh;
        local l__Mesh__38 = v92.Mesh;
        v93 = l__new__5("FileMesh", v94);
        for v100, v101 in u1, u38(u39.FileMesh, l__Mesh__37, l__Mesh__38) do
            v93[v100] = v101;
        end;
        local l__Weld__39 = v91.Weld;
        local l__Weld__40 = v92.Weld;
        v95 = l__new__5("Weld", v94);
        for v102, v103 in u1, u38(u39.Weld, l__Weld__39, l__Weld__40) do
            v95[v102] = v103;
        end;
    end;
    v95.C0 = p88.UnderFeetAttachment.CFrame;
    v95.Part0 = p88.HRP;
    v95.Part1 = v94;
    return {
        Handle = v94,
        Weld = v95,
        Mesh = v93
    };
end;
u6[7] = function(_, p104) --[[ Line: 378 ]]
    -- upvalues: l__Destroy__2 (copy)
    if p104.Mesh then
        l__Destroy__2(p104.Mesh);
    end;
    if p104.Weld then
        l__Destroy__2(p104.Weld);
    end;
    if p104.Handle then
        l__Destroy__2(p104.Handle);
    end;
end;
return {
    RunEquipList = function(p105, p106, p107) --[[ Name: RunEquipList, Line 27 ]]
        -- upvalues: l__ItemInstances__10 (copy), l__ItemClasses__9 (copy), u5 (copy)
        for v108 = 1, #p107 do
            local v109 = p107[v108];
            local v110 = l__ItemInstances__10[v109];
            if v110 then
                local l__Class__41 = v110.Class;
                local v111 = l__ItemClasses__9[l__Class__41];
                if v111 then
                    local l__Type__42 = v111.Type;
                    local v112 = u5[l__Type__42];
                    if v112 then
                        p105[v109] = v112(l__Type__42 == 0 and p106 and p106 or p105[v110.EquippedTo], v110);
                    else
                        print("[EquipmentInstantiation] RunEquipList no EquipFunction TypeID=", l__Type__42);
                    end;
                else
                    print("[EquipmentInstantiation] RunEquipList no Class ID=", l__Class__41);
                end;
            else
                print("[EquipmentInstantiation] RunEquipList no Instance ID=", v109);
            end;
        end;
    end,
    UndoEquipList = function(p113, p114) --[[ Name: UndoEquipList, Line 53 ]]
        -- upvalues: l__ItemInstances__10 (copy), l__ItemClasses__9 (copy), u6 (copy)
        for v115 = 1, #p114 do
            local v116 = p114[v115];
            local v117 = l__ItemInstances__10[v116];
            if v117 then
                local l__Class__43 = v117.Class;
                local v118 = l__ItemClasses__9[l__Class__43];
                if v118 then
                    local l__Type__44 = v118.Type;
                    local v119 = u6[l__Type__44];
                    if v119 then
                        v119(p113[v117.EquippedTo], p113[v116]);
                    else
                        print("[EquipmentInstantiation] UndoEquipList no UnequipFunction TypeID=", l__Type__44);
                    end;
                else
                    print("[EquipmentInstantiation] UndoEquipList no Class ID=", l__Class__43);
                end;
            else
                print("[EquipmentInstantiation] UndoEquipList no Instance ID=", v116);
            end;
        end;
    end
};
