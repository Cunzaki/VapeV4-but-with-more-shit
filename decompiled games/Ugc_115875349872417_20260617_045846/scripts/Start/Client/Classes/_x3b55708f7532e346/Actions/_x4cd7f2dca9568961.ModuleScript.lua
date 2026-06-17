-- Decompiled from: Start.Client.Classes._x3b55708f7532e346.Actions._x4cd7f2dca9568961
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

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
function u1._x83ed94bfb82a8c9f(p2, p3) --[[ Line: 31 ]]
    -- upvalues: u1 (copy), l__Trove__3 (copy), l__UIAssets__7 (copy)
    local v4 = setmetatable({}, u1);
    v4._xc74e01ec7295b965 = l__Trove__3.new();
    v4._xa324ec378e71ca08 = p2;
    v4._x2cd33458be0bcb21 = l__UIAssets__7.LeaderboardAssets.DuelAction:Clone();
    v4._x2cd33458be0bcb21.Parent = p2;
    v4._x991983d355b2395f = p3;
    v4._x6310e7fccfb93def = tostring(p3.UserId);
    v4._x2779e9deac0fc68b = false;
    v4._x6c1050ae07115c10 = false;
    v4._x4b21186fbb12c080 = true;
    v4._xc74e01ec7295b965:Add(v4._x2cd33458be0bcb21);
    v4:_xba28441e0836bc41();
    return v4;
end;
function u1._x553b64f4e1131a0f(p5) --[[ Line: 53 ]]
    -- upvalues: l__Context__6 (copy), l__LocalPlayer__8 (copy)
    if p5._x4b21186fbb12c080 then
        local v6 = true;
        if p5._x55694e31a2663501 and (p5._x55694e31a2663501:GetAttribute("state") ~= "BUSY" and not (l__Context__6.is_match_mode or p5._x2779e9deac0fc68b)) then
            if l__LocalPlayer__8 == p5._x991983d355b2395f then
                v6 = false;
            end;
        else
            v6 = false;
        end;
        p5._x6c1050ae07115c10 = v6;
        p5._x2cd33458be0bcb21.ImageTransparency = v6 and 0 or 0.5;
        p5._x2cd33458be0bcb21.Active = v6;
        p5._x2cd33458be0bcb21.AutoButtonColor = v6;
        p5._x2cd33458be0bcb21.Visible = l__LocalPlayer__8 ~= p5._x991983d355b2395f;
    end;
end;
function u1._xba28441e0836bc41(u7) --[[ Line: 79 ]]
    -- upvalues: l__DuelPresence__9 (copy), l__Classes__5 (copy), l__Packets__2 (copy)
    task.spawn(function() --[[ Line: 81 ]]
        -- upvalues: u7 (copy), l__DuelPresence__9 (ref)
        if u7._x4b21186fbb12c080 then
            u7._x55694e31a2663501 = l__DuelPresence__9:WaitForChild(u7._x6310e7fccfb93def, 10);
            if u7._x55694e31a2663501 then
                u7._xc74e01ec7295b965:Connect(u7._x55694e31a2663501:GetAttributeChangedSignal("state"), function() --[[ Line: 89 ]]
                    -- upvalues: u7 (ref)
                    u7:_x553b64f4e1131a0f();
                end);
            end;
            u7:_x553b64f4e1131a0f();
        end;
    end);
    u7._xc74e01ec7295b965:Connect(u7._x2cd33458be0bcb21.Activated, function() --[[ Line: 99 ]]
        -- upvalues: u7 (copy), l__Classes__5 (ref), l__Packets__2 (ref)
        if u7._x6c1050ae07115c10 then
            u7._x2779e9deac0fc68b = true;
            u7:_x553b64f4e1131a0f();
            task.delay(30, function() --[[ Line: 106 ]]
                -- upvalues: u7 (ref)
                if u7._x4b21186fbb12c080 then
                    u7._x2779e9deac0fc68b = false;
                    u7:_x553b64f4e1131a0f();
                end;
            end);
            l__Classes__5._x6dbba03a0636f7d8:_x282746dbf42c87cb("TAPE_MOVE", true);
            print("Sent.");
            l__Packets__2._x1761e6dc6421b5f7:Fire(u7._x6310e7fccfb93def);
        end;
    end);
end;
function u1.destroy(p8) --[[ Line: 118 ]]
    p8._x4b21186fbb12c080 = false;
    p8._xc74e01ec7295b965:Clean();
end;
return u1;
