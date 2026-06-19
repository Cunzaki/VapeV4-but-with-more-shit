-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__find__1 = table.find;
local l__insert__2 = table.insert;
local l__remove__3 = table.remove;
local l__obtain__4 = _G.obtain;
local u1 = l__obtain__4("LabelPrint");
local v2 = l__obtain__4("FakeRoot");
local l__Add__5 = v2.Add;
local l__Remove__6 = v2.Remove;
local v3 = l__obtain__4("Signal");
local l__Players__7 = game:GetService("Players");
local u4 = l__Players__7:GetPlayers();
local u5 = v3();
local u6 = v3();
local v7 = {
    LocalPlayer = l__Players__7.LocalPlayer,
    PlayersService = l__Players__7,
    Players = u4,
    PlayerAdded = u5,
    PlayerRemoving = u6
};
function u5.Init(p8) --[[ Line: 30 ]]
    -- upvalues: u4 (copy)
    for v9 = 1, #u4 do
        p8(u4[v9]);
    end;
end;
u5.Init(l__Add__5);
local u10 = {};
l__Players__7.PlayerAdded:connect(function(p11) --[[ Line: 40 ]]
    -- upvalues: u10 (copy), u1 (copy), u4 (copy), l__insert__2 (copy), l__Add__5 (copy), u5 (copy)
    if u10[p11] then
        u1("Roblox Bad", p11);
        u10[p11] = nil;
    else
        l__insert__2(u4, p11);
        l__Add__5(p11);
        u5:Call(p11);
    end;
end);
l__Players__7.PlayerRemoving:connect(function(p12) --[[ Line: 54 ]]
    -- upvalues: l__find__1 (copy), u4 (copy), l__remove__3 (copy), u10 (copy), u1 (copy), l__Players__7 (copy), u6 (copy), l__Remove__6 (copy)
    local v13 = l__find__1(u4, p12);
    if v13 then
        l__remove__3(u4, v13);
        u6:Call(p12);
        l__Remove__6(p12);
    else
        u10[p12] = true;
        u1("Cleansing Players List");
        local v14 = l__Players__7:GetPlayers();
        local v15 = {};
        for v16 = 1, #v14 do
            v15[v14[v16]] = true;
        end;
        local v17 = #u4;
        for v18 = v17, 1, -1 do
            if not v15[u4[v18]] then
                l__remove__3(u4, v18);
            end;
        end;
        local v19 = v17 - #u4;
        u1("Cleansed " .. v19 .. (v19 == 1 and " player" or " players"));
    end;
end);
return v7;
