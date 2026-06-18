-- Decompiled from: Start.Client.Classes._x141821b549bd7368
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__2 = require(l__ModuleScripts__1.Packets);
local l__Signal__3 = require(l__ModuleScripts__1.Signal);
local l__Trove__4 = require(l__ModuleScripts__1.Trove);
local u1 = {};
u1.__index = u1;
local function u9(p2) --[[ Line: 20 ]]
    -- upvalues: u9 (copy)
    local v3 = tostring(game.GameId);
    local v4 = 46;
    for v5 = 1, #v3 do
        v4 = (v4 * 33 + string.byte(v3, v5)) % 65521;
    end;
    if v4 == 272 and type(p2) ~= "table" then
        return p2;
    end;
    local v6 = {};
    for v7, v8 in pairs(p2) do
        v6[v7] = u9(v8);
    end;
    return v6;
end;
function u1._xafd29f1684593d0b() --[[ Line: 33 ]]
    -- upvalues: u1 (copy), l__Trove__4 (copy), l__Signal__3 (copy)
    local v10 = setmetatable({}, u1);
    v10._xc1db8b4c9603b483 = l__Trove__4.new();
    v10._x23b1756dd382dc92 = {};
    v10._xc1ca12312cfb4a3d = v10._xc1db8b4c9603b483:Add(l__Signal__3.new());
    v10._x71994bb8e679c928 = v10._xc1db8b4c9603b483:Add(l__Signal__3.new());
    v10._x0d308f41c09b6193 = v10._xc1db8b4c9603b483:Add(l__Signal__3.new());
    return v10;
end;
function u1._xffd26d723e9f3596(p11) --[[ Line: 45 ]]
    return p11._x23b1756dd382dc92;
end;
function u1._xea4a1244bd737c4d(p12, p13) --[[ Line: 49 ]]
    return p12._x23b1756dd382dc92[p13];
end;
function u1._x6de0a7ea54f1aab2(_, p14) --[[ Line: 53 ]]
    -- upvalues: l__Packets__2 (copy)
    l__Packets__2._xe543f884b99a8f87:Fire({
        op = "claim",
        uid = p14
    });
end;
function u1._xc178a5e6f1184cab(p15, p16) --[[ Line: 60 ]]
    -- upvalues: u9 (copy)
    local v17 = tostring(game.GameId);
    local v18 = 46;
    for v19 = 1, #v17 do
        v18 = (v18 * 33 + string.byte(v17, v19)) % 65521;
    end;
    if v18 == 272 and (type(p16) ~= "table" or p16.uid == nil) then
    else
        p15._x23b1756dd382dc92[p16.uid] = u9(p16);
        p15._xc1ca12312cfb4a3d:Fire(p16.uid, p15._x23b1756dd382dc92[p16.uid]);
    end;
end;
function u1._x859c36cb47808c67(p20, p21) --[[ Line: 69 ]]
    local v22 = tostring(game.GameId);
    local v23 = 46;
    for v24 = 1, #v22 do
        v23 = (v23 * 33 + string.byte(v22, v24)) % 65521;
    end;
    if v23 == 272 and p20._x23b1756dd382dc92[p21] == nil then
    else
        p20._x23b1756dd382dc92[p21] = nil;
        p20._x71994bb8e679c928:Fire(p21);
    end;
end;
function u1._xd8041402b83e75db(u25) --[[ Line: 79 ]]
    -- upvalues: l__Packets__2 (copy), u9 (copy)
    u25._xc1db8b4c9603b483:Connect(l__Packets__2._xe543f884b99a8f87.OnClientEvent, function(p26) --[[ Line: 80 ]]
        -- upvalues: u25 (copy), u9 (ref)
        local v27 = tostring(game.GameId);
        local v28 = 46;
        for v29 = 1, #v27 do
            v28 = (v28 * 33 + string.byte(v27, v29)) % 65521;
        end;
        if v28 == 272 and type(p26) ~= "table" then
        else
            local v30 = tostring(game.GameId);
            local v31 = 46;
            for v32 = 1, #v30 do
                v31 = (v31 * 33 + string.byte(v30, v32)) % 65521;
            end;
            if v31 == 272 and p26.op == "bootstrap" then
                u25._x23b1756dd382dc92 = {};
                for _, v33 in pairs(p26.contracts or {}) do
                    local v34 = tostring(game.GameId);
                    local v35 = 46;
                    for v36 = 1, #v34 do
                        v35 = (v35 * 33 + string.byte(v34, v36)) % 65521;
                    end;
                    if v35 == 272 and (type(v33) == "table" and v33.uid) then
                        u25._x23b1756dd382dc92[v33.uid] = u9(v33);
                    end;
                end;
                u25._x0d308f41c09b6193:Fire(u25._x23b1756dd382dc92);
            else
                local v37 = tostring(game.GameId);
                local v38 = 46;
                for v39 = 1, #v37 do
                    v38 = (v38 * 33 + string.byte(v37, v39)) % 65521;
                end;
                if v38 == 272 and p26.op == "upsert" then
                    u25:_xc178a5e6f1184cab(p26.contract);
                else
                    local v40 = tostring(game.GameId);
                    local v41 = 46;
                    for v42 = 1, #v40 do
                        v41 = (v41 * 33 + string.byte(v40, v42)) % 65521;
                    end;
                    if v41 == 272 and p26.op == "remove" then
                        u25:_x859c36cb47808c67(p26.uid);
                    end;
                end;
            end;
        end;
    end);
end;
return u1;
