-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local u1 = l__obtain__1("LabelPrint");
local u2 = l__obtain__1("WorldObjectRecognition");
local u3 = l__obtain__1("GameMechanicsObjectRecognition");
local v4 = l__obtain__1("Signal");
local v5 = l__obtain__1("Remote");
local l__Call__2 = v5.Call;
local u6 = v4();
local u7 = {
    MapInfoChanged = u6
};
local l__Lighting__3 = game:GetService("Lighting");
local u8 = Color3.new(0, 0, 0);
local u9 = Color3.new(0, 0, 0);
local u10 = Color3.new(0, 0, 0);
local u11 = Color3.new(0.4980392156862745, 0.4980392156862745, 0.49019607843137253);
local u12 = Color3.new(0.6980392156862745, 0.6980392156862745, 0.6980392156862745);
local u13 = Color3.new(0.7490196078431373, 0.7490196078431373, 0.7490196078431373);
v5.Add("ResetLighting", function() --[[ Name: ResetLighting, Line 26 ]]
    -- upvalues: l__Lighting__3 (copy), u8 (copy), u9 (copy), u10 (copy), u11 (copy), u12 (copy), u13 (copy)
    l__Lighting__3.Ambient = u8;
    l__Lighting__3.Brightness = 1;
    l__Lighting__3.ColorShift_Bottom = u9;
    l__Lighting__3.ColorShift_Top = u10;
    l__Lighting__3.EnvironmentDiffuseScale = 0;
    l__Lighting__3.EnvironmentSpecularScale = 0;
    l__Lighting__3.GlobalShadows = true;
    l__Lighting__3.OutdoorAmbient = u11;
    l__Lighting__3.ShadowSoftness = 0.5;
    l__Lighting__3.Outlines = true;
    l__Lighting__3.ShadowColor = u12;
    l__Lighting__3.GeographicLatitude = 41.733;
    l__Lighting__3.Name = "Lighting";
    l__Lighting__3.TimeOfDay = "14:00:00";
    l__Lighting__3.ExposureCompensation = 0;
    l__Lighting__3.FogColor = u13;
    l__Lighting__3.FogEnd = 100000;
    l__Lighting__3.FogStart = 0;
    l__Lighting__3:ClearAllChildren();
end);
v5.Add("SetMapInfo", function(p14) --[[ Line: 50 ]]
    -- upvalues: u1 (copy), u2 (copy), u3 (copy), u7 (copy), u6 (copy)
    if p14 == nil then
        u1("MapInfo is nil!");
    else
        u2:ClearCache();
        u3:ClearCache();
        u7.MapInfo = p14;
        u6:Call(p14);
    end;
end);
function u7.Init() --[[ Line: 61 ]]
    -- upvalues: l__Call__2 (copy)
    l__Call__2("GetMapInfo");
end;
return u7;
