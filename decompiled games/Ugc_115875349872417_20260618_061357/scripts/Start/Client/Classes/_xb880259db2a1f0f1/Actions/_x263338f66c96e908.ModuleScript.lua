-- Decompiled from: Start.Client.Classes._xb880259db2a1f0f1.Actions._x263338f66c96e908
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__2 = require(l__ModuleScripts__1.Packets);
local l__Trove__3 = require(l__ModuleScripts__1.Trove);
local u1 = {};
u1.__index = u1;
local l__ClientRoot__4 = require(script.Parent.Parent.Parent.Parent.ClientRoot);
local l__Classes__5 = l__ClientRoot__4.Classes;
local l__Context__6 = l__ClientRoot__4.Context;
local l__UIAssets__7 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local l__LocalPlayer__8 = game.Players.LocalPlayer;
local l__DuelPresence__9 = game:GetService("ReplicatedStorage").ReadOnly.DuelPresence;
function u1._x90d4581ac99dd483(p2, p3) --[[ Line: 22 ]]
    -- upvalues: u1 (copy), l__Trove__3 (copy), l__UIAssets__7 (copy)
    local v4 = setmetatable({}, u1);
    v4._xbd519c918208ce0e = l__Trove__3.new();
    v4._x692e0d9d4ea795ae = p2;
    v4._x8bf141dbc3166dec = l__UIAssets__7.LeaderboardAssets.DuelAction:Clone();
    v4._x8bf141dbc3166dec.Parent = p2;
    v4._x7332546c4ea36da3 = p3;
    v4._x7c919eac5dbc3d49 = tostring(p3.UserId);
    v4._x1ab0a9d00e12ed38 = false;
    v4._xb7339043de1553be = false;
    v4._xfa4781e50a4eff6c = true;
    v4._xbd519c918208ce0e:Add(v4._x8bf141dbc3166dec);
    v4:_x8fcdafeb8ad3312d();
    return v4;
end;
function u1._x930014b4208c13f9(p5) --[[ Line: 44 ]]
    -- upvalues: l__Context__6 (copy), l__LocalPlayer__8 (copy)
    if p5._xfa4781e50a4eff6c then
        local v6 = true;
        if p5._x48b77362996ec54b and (p5._x48b77362996ec54b:GetAttribute("state") ~= "BUSY" and not (l__Context__6.is_match_mode or p5._x1ab0a9d00e12ed38)) then
            if l__LocalPlayer__8 == p5._x7332546c4ea36da3 then
                v6 = false;
            end;
        else
            v6 = false;
        end;
        p5._xb7339043de1553be = v6;
        p5._x8bf141dbc3166dec.ImageTransparency = v6 and 0 or 0.5;
        p5._x8bf141dbc3166dec.Active = v6;
        p5._x8bf141dbc3166dec.AutoButtonColor = v6;
        p5._x8bf141dbc3166dec.Visible = l__LocalPlayer__8 ~= p5._x7332546c4ea36da3;
    end;
end;
function u1._x8fcdafeb8ad3312d(u7) --[[ Line: 70 ]]
    -- upvalues: l__DuelPresence__9 (copy), l__Classes__5 (copy), l__Packets__2 (copy)
    task.spawn(function() --[[ Line: 72 ]]
        -- upvalues: u7 (copy), l__DuelPresence__9 (ref)
        if u7._xfa4781e50a4eff6c then
            u7._x48b77362996ec54b = l__DuelPresence__9:WaitForChild(u7._x7c919eac5dbc3d49, 10);
            if u7._x48b77362996ec54b then
                u7._xbd519c918208ce0e:Connect(u7._x48b77362996ec54b:GetAttributeChangedSignal("state"), function() --[[ Line: 80 ]]
                    -- upvalues: u7 (ref)
                    u7:_x930014b4208c13f9();
                end);
            end;
            u7:_x930014b4208c13f9();
        end;
    end);
    u7._xbd519c918208ce0e:Connect(u7._x8bf141dbc3166dec.Activated, function() --[[ Line: 90 ]]
        -- upvalues: u7 (copy), l__Classes__5 (ref), l__Packets__2 (ref)
        if u7._xb7339043de1553be then
            u7._x1ab0a9d00e12ed38 = true;
            u7:_x930014b4208c13f9();
            task.delay(30, function() --[[ Line: 97 ]]
                -- upvalues: u7 (ref)
                if u7._xfa4781e50a4eff6c then
                    u7._x1ab0a9d00e12ed38 = false;
                    u7:_x930014b4208c13f9();
                end;
            end);
            l__Classes__5._xbe184fb1376a575d:_x7ab8b42cc5920a78("TAPE_MOVE", true);
            l__Packets__2._xd1b838f7b98a592f:Fire(u7._x7c919eac5dbc3d49);
        end;
    end);
end;
function u1.destroy(p8) --[[ Line: 108 ]]
    p8._xfa4781e50a4eff6c = false;
    p8._xbd519c918208ce0e:Clean();
end;
return u1;
