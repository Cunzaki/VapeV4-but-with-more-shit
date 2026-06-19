-- Decompiled from: RobloxCamera
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("QBox");
local l__IsMouseFree__2 = v1.IsMouseFree;
local l__RawFreeMouse__3 = v1.RawFreeMouse;
local v2 = l__obtain__1("Command");
local v3 = l__obtain__1("CharacterManager");
local l__LocalPlayer__4 = game:GetService("Players").LocalPlayer;
local u4 = l__obtain__1("RobloxCamera");
v2.Add("fixcam", {}, function() --[[ Line: 14 ]]
    -- upvalues: u4 (copy)
    u4.CameraType = 5;
    u4.CameraType = 6;
end);
v3.CharacterAdded:Add(function(p5, _) --[[ Line: 19 ]]
    -- upvalues: l__LocalPlayer__4 (copy), u4 (copy), l__IsMouseFree__2 (copy), l__RawFreeMouse__3 (copy)
    if p5 == l__LocalPlayer__4 then
        u4.CameraType = 6;
        if not l__IsMouseFree__2() then
            l__RawFreeMouse__3(false);
        end;
    end;
end);
return true;
