-- Decompiled from: StarterGui.PV2Piano.PianoController.SoundFonts
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v1 = {
    {
        Name = "Grand",
        MaxLifetime = 6,
        VolumeModifier = 1,
        Fadeout = 0.25,
        Offset = 0,
        AssetIds = {
            "16081618991",
            "16081624061",
            "16081627264",
            "16081630671",
            "16081633526",
            "16081635990"
        }
    },
    {
        Name = "Upright",
        MaxLifetime = 5.5,
        VolumeModifier = 1,
        Fadeout = 0.25,
        Offset = 0,
        AssetIds = {
            "16081642660",
            "16081646399",
            "16081649273",
            "16081652066",
            "16081655015",
            "16081657838"
        }
    },
    {
        Name = "Rhodes",
        MaxLifetime = 5.5,
        VolumeModifier = 3,
        Fadeout = 0.35,
        Offset = 0,
        AssetIds = {
            "16043114799",
            "16043118055",
            "16043121528",
            "16043124442",
            "16043126686",
            "16272414759"
        }
    }
};
local u2 = {};
function v1.GetIdFromName(p3) --[[ Line: 75 ]]
    -- upvalues: u2 (copy)
    return u2[p3];
end;
for v4, v5 in ipairs(v1) do
    if v5 ~= false then
        local l__Name__1 = v5.Name;
        if v1[l__Name__1] then
            warn("[SoundFonts]: Name overlap found: " .. v4 .. ", " .. v5.Name);
        else
            v1[l__Name__1] = v5;
            u2[l__Name__1] = v4;
            table.freeze(v5.AssetIds);
            table.freeze(v5);
        end;
    end;
end;
table.freeze(u2);
table.freeze(v1);
return v1;
