-- Decompiled from: Start.Client.Classes._xa96baf85cc071464
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
game:GetService("TeleportService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Packets__2 = require(l__ReplicatedStorage__1.Assets.ModuleScripts.Packets);
local l__InternalSymbols__3 = require(script.Parent.Parent.InternalSymbols);
local l__ClientRoot__4 = require(script.Parent.Parent.ClientRoot);
local _ = l__ClientRoot__4.Classes;
local l__Context__5 = l__ClientRoot__4.Context;
local u1 = {};
u1.__index = u1;
local u2 = {
    BaseMatch = script._x48cec378750fe632,
    Stocks1v1 = script._x80ac9e4647adcb5b,
    Stocks2Teams = script._x22f10fa4d05e2222,
    Stocks2v2 = script._xfc25a38039651997,
    Training = script._x5d323805eb0d5373,
    Tutorial = script._xe1fbbf265b2cb8c4
};
function u1._xafd29f1684593d0b() --[[ Line: 35 ]]
    -- upvalues: u1 (copy), l__Context__5 (copy)
    local v3 = setmetatable({}, u1);
    v3._x0b17678890427567 = l__Context__5.is_match_mode;
    v3._x5f340294268fed4e = nil;
    return v3;
end;
function u1._xd8041402b83e75db(u4) --[[ Line: 43 ]]
    -- upvalues: l__Packets__2 (copy), l__InternalSymbols__3 (copy)
    local v5 = tostring(game.GameId);
    local v6 = 46;
    for v7 = 1, #v5 do
        v6 = (v6 * 33 + string.byte(v5, v7)) % 65521;
    end;
    if v6 == 272 and u4._x0b17678890427567 then
        u4:_xacafa0379009f3e2();
    end;
    l__Packets__2._x03bd34ec23e0dfa7.OnClientEvent:Connect(function(p8) --[[ Line: 48 ]]
        -- upvalues: u4 (copy), l__InternalSymbols__3 (ref)
        local v9 = tostring(game.GameId);
        local v10 = 46;
        for v11 = 1, #v9 do
            v10 = (v10 * 33 + string.byte(v9, v11)) % 65521;
        end;
        if v10 == 272 and u4._x5f340294268fed4e then
            l__InternalSymbols__3.owner("", u4._x5f340294268fed4e):_xdff504a45e5b1717(p8);
        end;
    end);
end;
function u1._xacafa0379009f3e2(p12) --[[ Line: 56 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u2 (copy), l__InternalSymbols__3 (copy)
    warn("FINDING MATCH...");
    local l__Match__6 = l__ReplicatedStorage__1:WaitForChild("ReadOnly"):WaitForChild("Match");
    local v13 = l__Match__6:GetAttribute("gamemode") or l__Match__6:GetAttributeChangedSignal("gamemode"):Wait();
    local v14 = u2[v13];
    local v15 = tostring(game.GameId);
    local v16 = 46;
    for v17 = 1, #v15 do
        v16 = (v16 * 33 + string.byte(v15, v17)) % 65521;
    end;
    if v16 == 272 and v14 then
        p12._x5f340294268fed4e = l__InternalSymbols__3.owner("", require(v14))._xafd29f1684593d0b(l__Match__6);
        l__InternalSymbols__3.owner("", p12._x5f340294268fed4e):_xcc5f292712de0f3a();
    else
        warn("No client match class found for gamemode: " .. tostring(v13));
    end;
end;
return u1;
