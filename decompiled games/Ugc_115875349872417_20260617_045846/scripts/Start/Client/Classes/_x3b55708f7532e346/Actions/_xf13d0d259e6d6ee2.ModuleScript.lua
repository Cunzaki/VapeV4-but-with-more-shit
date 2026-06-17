-- Decompiled from: Start.Client.Classes._x3b55708f7532e346.Actions._xf13d0d259e6d6ee2
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

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
function u1._x83ed94bfb82a8c9f(p2, p3) --[[ Line: 31 ]]
    -- upvalues: u1 (copy), l__Trove__2 (copy), l__UIAssets__4 (copy)
    local v4 = setmetatable({}, u1);
    v4._xc74e01ec7295b965 = l__Trove__2.new();
    v4._x1e963419a123c0ae = p2;
    v4._x4f3a053cf9020144 = l__UIAssets__4.LeaderboardAssets.ReportAction:Clone();
    v4._x2a614856b60e0d5a = p3;
    v4._x94abd5cc7e40557e = tostring(p3.UserId);
    v4._x52cf698c2b51df63 = false;
    v4._xe750dbec08038245 = true;
    v4._xc74e01ec7295b965:Add(v4._x4f3a053cf9020144);
    v4:_xba28441e0836bc41();
    return v4;
end;
function u1._xba28441e0836bc41(u5) --[[ Line: 50 ]]
    -- upvalues: l__LocalPlayer__5 (copy), l__Classes__3 (copy)
    if tonumber(u5._x94abd5cc7e40557e) == l__LocalPlayer__5.UserId then
    else
        u5._x4f3a053cf9020144.Parent = u5._x1e963419a123c0ae;
        u5._xc74e01ec7295b965:Connect(u5._x4f3a053cf9020144.Activated, function() --[[ Line: 53 ]]
            -- upvalues: l__Classes__3 (ref), u5 (copy)
            if l__Classes__3._xe4b708070c7cd741 then
                if #l__Classes__3._xe4b708070c7cd741._x78b57187de62bd29 >= 1 then
                elseif u5._x52cf698c2b51df63 then
                else
                    l__Classes__3._xe4b708070c7cd741:_x85ec8b5d5b90212b("ReportBrowser", {
                        target_userid = u5._x94abd5cc7e40557e,
                        action_obj = u5
                    });
                end;
            end;
        end);
    end;
end;
function u1.destroy(p6) --[[ Line: 61 ]]
    p6._xe750dbec08038245 = false;
    p6._xc74e01ec7295b965:Clean();
end;
return u1;
