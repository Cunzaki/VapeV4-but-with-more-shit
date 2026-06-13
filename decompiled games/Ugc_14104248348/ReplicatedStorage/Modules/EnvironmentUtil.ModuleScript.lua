-- Decompiled from: ReplicatedStorage.Modules.EnvironmentUtil
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    Ambient = true,
    Brightness = true,
    ColorShift_Bottom = true,
    ColorShift_Top = true,
    EnvironmentDiffuseScale = true,
    EnvironmentSpecularScale = true,
    GlobalShadows = true,
    OutdoorAmbient = true,
    ShadowSoftness = true,
    ClockTime = true,
    GeographicLatitude = true,
    ExposureCompensation = true
};
local u2 = {
    Atmosphere = true,
    Sky = true,
    BloomEffect = true,
    DepthOfFieldEffect = true,
    ColorCorrectionEffect = true,
    SunRaysEffect = true,
    BlurEffect = true
};
local u3 = {
    WaterColor = true,
    WaterReflectance = true,
    WaterTransparency = true,
    WaterWaveSize = true,
    WaterWaveSpeed = true
};
local u4 = {
    Clouds = true
};
local u5 = {
    Sky = {
        SkyboxOrientation = true,
        MoonTextureId = true,
        SkyboxBk = true,
        SkyboxDn = true,
        SkyboxFt = true,
        SkyboxLf = true,
        SkyboxRt = true,
        SkyboxUp = true,
        SunTextureId = true
    }
};
local u6 = {
    Atmosphere = {
        Color = true,
        Decay = true,
        Density = true,
        Glare = true,
        Haze = true,
        Offset = true
    },
    BloomEffect = {
        Enabled = true,
        Intensity = true,
        Size = true,
        Threshold = true
    },
    BlurEffect = {
        Enabled = true,
        Size = true
    },
    ColorCorrectionEffect = {
        Brightness = true,
        Contrast = true,
        Enabled = true,
        Saturation = true,
        TintColor = true
    },
    DepthOfFieldEffect = {
        Enabled = true,
        FarIntensity = true,
        FocusDistance = true,
        InFocusRadius = true,
        NearIntensity = true
    },
    Sky = {
        CelestialBodiesShown = true,
        MoonAngularSize = true,
        StarCount = true,
        SunAngularSize = true
    },
    SunRaysEffect = {
        Enabled = true,
        Intensity = true,
        Spread = true
    }
};
local u7 = {
    Asphalt = true,
    Basalt = true,
    Brick = true,
    Cobblestone = true,
    Concrete = true,
    CrackedLava = true,
    Glacier = true,
    Grass = true,
    Ground = true,
    Ice = true,
    LeafyGrass = true,
    Limestone = true,
    Mud = true,
    Pavement = true,
    Rock = true,
    Salt = true,
    Sand = true,
    Sandstone = true,
    Slate = true,
    Snow = true,
    WoodPlanks = true
};
local l__Lighting__1 = game:GetService("Lighting");
local l__Workspace__2 = game:GetService("Workspace");
local l__TweenService__3 = game:GetService("TweenService");
local l__Terrain__4 = l__Workspace__2.Terrain;
return {
    GenerateEnvironment = function(p8) --[[ Name: GenerateEnvironment, Line 136 ]]
        -- upvalues: u1 (copy), l__Lighting__1 (copy), u2 (copy), u3 (copy), l__Terrain__4 (copy), u4 (copy), u7 (copy)
        local v9 = Instance.new("Folder");
        v9.Name = (p8 and p8 .. "_" or "") .. "Environment";
        local v10 = Instance.new("Configuration", v9);
        v10.Name = "Lighting";
        for v11 in pairs(u1) do
            v10:SetAttribute(v11, l__Lighting__1[v11]);
        end;
        for _, v12 in pairs(l__Lighting__1:GetChildren()) do
            if u2[v12.ClassName] then
                v12:Clone().Parent = v10;
            end;
        end;
        local v13 = Instance.new("Configuration", v9);
        v13.Name = "Terrain";
        for v14 in pairs(u3) do
            v13:SetAttribute(v14, l__Terrain__4[v14]);
        end;
        for _, v15 in pairs(l__Terrain__4:GetChildren()) do
            if u4[v15.ClassName] then
                v15:Clone().Parent = v13;
            end;
        end;
        local v16 = Instance.new("Configuration", v9);
        v16.Name = "TerrainColors";
        for v17 in pairs(u7) do
            v16:SetAttribute(v17, l__Terrain__4:GetMaterialColor(v17));
        end;
        return v9;
    end,
    SwitchEnvironment = function(p18, p19) --[[ Name: SwitchEnvironment, Line 181 ]]
        -- upvalues: l__Lighting__1 (copy), u2 (copy), u6 (copy), u5 (copy), u3 (copy), l__Terrain__4 (copy), u4 (copy), l__TweenService__3 (copy)
        local v20 = TweenInfo.new(p19 or 1, Enum.EasingStyle.Linear);
        if not p18 then
            error("No EnvironmentFolder provided");
        end;
        local v21 = {
            [l__Lighting__1] = {}
        };
        local v22 = {
            TimeOfDay = true,
            Brightness = true
        };
        ({}).Name = true;
        local v23 = p18:FindFirstChild("Lighting");
        if v23 then
            for v24, v25 in pairs(v23:GetAttributes()) do
                if v24 ~= "GlobalShadows" then
                    if v22[v24] then
                        l__Lighting__1[v24] = v25;
                    else
                        v21[l__Lighting__1][v24] = v25;
                    end;
                end;
            end;
        else
            warn("Environment is missing lighting config");
        end;
        for _, v26 in pairs(l__Lighting__1:GetChildren()) do
            if not v26:GetAttribute("IgnoreEnvironment") and (u2[v26.ClassName] and not v23:FindFirstChild(v26.Name)) then
                warn((`DESTROYING {v26.name} BECAUSE NON IN {p18.Name}`));
                v26:Destroy();
            end;
        end;
        local v27 = {};
        for _, v28 in pairs(v23:GetChildren()) do
            if u2[v28.ClassName] then
                local v29 = l__Lighting__1:FindFirstChild(v28.Name);
                if v29 then
                    v29:SetAttribute("EnvGenerated", true);
                    v27[v28] = v29;
                else
                    local v30 = v28:Clone();
                    v30:SetAttribute("EnvGenerated", true);
                    v30.Parent = l__Lighting__1;
                end;
            end;
        end;
        for v31, v32 in v27 do
            local v33 = u6[v31.ClassName];
            local v34 = u5[v31.ClassName];
            if v33 then
                v21[v32] = {};
                for v35 in v33 do
                    v21[v32][v35] = v31[v35];
                end;
            end;
            if v34 then
                for v36 in v34 do
                    v32[v36] = v31[v36];
                end;
            end;
        end;
        local v37 = p18:FindFirstChild("Terrain");
        if v37 then
            for v38, v39 in pairs(v37:GetAttributes()) do
                if u3[v38] then
                    l__Terrain__4[v38] = v39;
                end;
            end;
        else
            warn("Environment is missing terrain config");
        end;
        for _, v40 in pairs(l__Terrain__4:GetChildren()) do
            if not v40:GetAttribute("IgnoreEnvironment") and u4[v40.ClassName] then
                v40:Destroy();
            end;
        end;
        for _, v41 in pairs(v37:GetChildren()) do
            if u4[v41.ClassName] then
                v41:Clone().Parent = l__Terrain__4;
            end;
        end;
        local v42 = p18:FindFirstChild("TerrainColors");
        if v42 then
            for v43, v44 in pairs(v42:GetAttributes()) do
                l__Terrain__4:SetMaterialColor(v43, v44);
            end;
        else
            warn("Environment is missing terrain colors config");
        end;
        local v45 = {};
        for v46, v47 in v21 do
            local v48 = l__TweenService__3:Create(v46, v20, v47);
            table.insert(v45, v48);
        end;
        for _, v49 in v45 do
            v49:Play();
        end;
    end,
    LoadEnvironment = function(p50) --[[ Name: LoadEnvironment, Line 322 ]]
        -- upvalues: l__Lighting__1 (copy), u2 (copy), l__Terrain__4 (copy), u4 (copy)
        if not p50 then
            error("No EnvironmentFolder provided");
        end;
        local v51 = p50:FindFirstChild("Lighting");
        if v51 then
            for v52, v53 in pairs(v51:GetAttributes()) do
                if v52 ~= "GlobalShadows" then
                    l__Lighting__1[v52] = v53;
                end;
            end;
            local v54 = v51:GetAttribute("TimeOfDay");
            if v54 then
                l__Lighting__1.TimeOfDay = v54;
            end;
        else
            warn("Environment is missing lighting config");
        end;
        for _, v55 in pairs(l__Lighting__1:GetChildren()) do
            if not v55:GetAttribute("IgnoreEnvironment") and u2[v55.ClassName] then
                v55:Destroy();
            end;
        end;
        for _, v56 in pairs(v51:GetChildren()) do
            if u2[v56.ClassName] then
                local v57 = v56:Clone();
                v57:SetAttribute("EnvGenerated", true);
                v57.Parent = l__Lighting__1;
            end;
        end;
        local v58 = p50:FindFirstChild("Terrain");
        if v58 then
            for v59, v60 in pairs(v58:GetAttributes()) do
                l__Terrain__4[v59] = v60;
            end;
        else
            warn("Environment is missing terrain config");
        end;
        for _, v61 in pairs(l__Terrain__4:GetChildren()) do
            if not v61:GetAttribute("IgnoreEnvironment") and u4[v61.ClassName] then
                v61:Destroy();
            end;
        end;
        for _, v62 in pairs(v58:GetChildren()) do
            if u4[v62.ClassName] then
                v62:Clone().Parent = l__Terrain__4;
            end;
        end;
        local v63 = p50:FindFirstChild("TerrainColors");
        if v63 then
            for v64, v65 in pairs(v63:GetAttributes()) do
                l__Terrain__4:SetMaterialColor(v64, v65);
            end;
        else
            warn("Environment is missing terrain colors config");
        end;
    end
};
