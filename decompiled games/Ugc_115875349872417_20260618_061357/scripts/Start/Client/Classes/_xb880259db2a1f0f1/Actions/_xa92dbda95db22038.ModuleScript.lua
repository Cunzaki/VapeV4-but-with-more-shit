-- Decompiled from: Start.Client.Classes._xb880259db2a1f0f1.Actions._xa92dbda95db22038
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
require(l__ModuleScripts__1.CEnum);
require(l__ModuleScripts__1.Packets);
local l__Trove__2 = require(l__ModuleScripts__1.Trove);
local u1 = {};
u1.__index = u1;
local l__Classes__3 = require(script.Parent.Parent.Parent.Parent.ClientRoot).Classes;
local l__UIAssets__4 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local l__LocalPlayer__5 = game.Players.LocalPlayer;
local _ = game:GetService("ReplicatedStorage").ReadOnly.DuelPresence;
function u1._x90d4581ac99dd483(p2, p3) --[[ Line: 22 ]]
    -- upvalues: u1 (copy), l__Trove__2 (copy), l__UIAssets__4 (copy)
    local v4 = setmetatable({}, u1);
    v4._xbd519c918208ce0e = l__Trove__2.new();
    v4._xfa8d84f0c970ed3d = p2;
    v4._xa440e38faeaed3f4 = l__UIAssets__4.LeaderboardAssets.ReportAction:Clone();
    v4._xfccffbcd5252d2ee = p3;
    v4._xbc6f29b68dbc1c7b = tostring(p3.UserId);
    v4._x84fc2fc37cb660f1 = false;
    v4._xa835168f92c63f11 = true;
    v4._xbd519c918208ce0e:Add(v4._xa440e38faeaed3f4);
    v4:_x8fcdafeb8ad3312d();
    return v4;
end;
function u1._x8fcdafeb8ad3312d(u5) --[[ Line: 41 ]]
    -- upvalues: l__LocalPlayer__5 (copy), l__Classes__3 (copy)
    if tonumber(u5._xbc6f29b68dbc1c7b) == l__LocalPlayer__5.UserId then
    else
        u5._xa440e38faeaed3f4.Parent = u5._xfa8d84f0c970ed3d;
        u5._xbd519c918208ce0e:Connect(u5._xa440e38faeaed3f4.Activated, function() --[[ Line: 44 ]]
            -- upvalues: l__Classes__3 (ref), u5 (copy)
            if l__Classes__3._xd00ac57201023755 then
                if #l__Classes__3._xd00ac57201023755._x5706f358225e50c1 >= 1 then
                elseif u5._x84fc2fc37cb660f1 then
                else
                    l__Classes__3._xd00ac57201023755:_x4782af5368e4c758("ReportBrowser", {
                        target_userid = u5._xbc6f29b68dbc1c7b,
                        action_obj = u5
                    });
                end;
            end;
        end);
    end;
end;
function u1.destroy(p6) --[[ Line: 52 ]]
    p6._xa835168f92c63f11 = false;
    p6._xbd519c918208ce0e:Clean();
end;
return u1;
