-- Decompiled from: DatabaseConnectionStatus
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 12a7ca22-cd63-42d4-a557-a631ea165de3

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("QBox");
local v2 = l__obtain__1("Tween");
local v3 = l__obtain__1("Remote");
local l__Call__2 = v3.Call;
local u4 = v1.Color(15, 150, 67);
local u5 = v1.Color(199, 16, 16);
local u6 = v1.TextBox(nil, "Connected to database");
u6.PosScaleX = 0.16666666666666666;
u6.SizeScaleX = 0.6666666666666666;
u6.SizeOffsetY = 40;
u6.TextAlignment = "Center";
u6.FontSize = 70;
local u8 = v2.New(-40, function(p7) --[[ Line: 18 ]]
    -- upvalues: u6 (copy)
    u6.PosOffsetY = p7;
end);
u8.MaxAcceleration = v2.MaxAcceleration(0, 40, 0, 0, 1);
function u6.Button1Down() --[[ Line: 23 ]]
    -- upvalues: u8 (copy)
    u8:Target(-40);
end;
v3.Add("SetDatabaseDown", function(p9, p10) --[[ Line: 27 ]]
    -- upvalues: u6 (copy), u5 (copy), u8 (copy), u4 (copy)
    if p9 then
        if p10 then
            u6.Text = "Error connecting to database: " .. p10;
        else
            u6.Text = "Not connected to database";
        end;
        u6.BackgroundColor = u5;
        u8:Target(0);
    else
        u6.Text = "Connected to database";
        u6.BackgroundColor = u4;
        u8:Target(-40);
    end;
end);
return function() --[[ Line: 43 ]]
    -- upvalues: l__Call__2 (copy)
    l__Call__2("GetDatabaseDown");
end;
