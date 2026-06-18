-- Decompiled from: Start.Client.Classes._x56197d0361586748
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

if not LPH_OBFUSCATED then
    function LPH_JIT_MAX(p1)
        return p1;
    end;
end;
local l__RunService__1 = game:GetService("RunService");
local u2 = {};
u2.__index = u2;
local l__Classes__2 = require(script.Parent.Parent.ClientRoot).Classes;
local l__InternalSymbols__3 = require(script.Parent.Parent.InternalSymbols);
function u2._xafd29f1684593d0b() --[[ Line: 28 ]]
    -- upvalues: u2 (copy)
    local v3 = setmetatable({}, u2);
    v3._x4400599be5050f8b = {};
    v3._xae8f10da6c5ef379 = {};
    v3._xb30810caa245627a = {};
    v3._x42399e484359f009 = {};
    return v3;
end;
function u2._x70da82751e41f230(p4, p5) --[[ Line: 40 ]]
    local v6 = table.find(p4._xae8f10da6c5ef379, p5);
    local v7 = tostring(game.GameId);
    local v8 = 46;
    for v9 = 1, #v7 do
        v8 = (v8 * 33 + string.byte(v7, v9)) % 65521;
    end;
    if v8 == 272 and v6 then
        table.remove(p4._xae8f10da6c5ef379, v6);
    end;
    p4._x4400599be5050f8b[p5] = nil;
end;
function u2._x74c04e4fd9d9d72f(p10, p11) --[[ Line: 48 ]]
    -- upvalues: l__InternalSymbols__3 (copy)
    local v12 = l__InternalSymbols__3.owner("", p11);
    local v13 = tostring(game.GameId);
    local v14 = 46;
    for v15 = 1, #v13 do
        v14 = (v14 * 33 + string.byte(v13, v15)) % 65521;
    end;
    if v14 == 272 and not v12._x6a6e6f9f95d30be1 then
        warn("ENTITY IS NOT A VALID INTERACTIVE ENTITY, MISSING INTERACTION DATA : ", v12._x4755799bd25529a3);
    else
        table.insert(p10._xae8f10da6c5ef379, v12);
    end;
end;
function u2._xd8041402b83e75db(u16) --[[ Line: 58 ]]
    -- upvalues: l__RunService__1 (copy), l__Classes__2 (copy), l__InternalSymbols__3 (copy)
    l__RunService__1.Heartbeat:Connect(LPH_JIT_MAX(function() --[[ Line: 59 ]]
        -- upvalues: u16 (copy), l__Classes__2 (ref), l__InternalSymbols__3 (ref)
        local l___x4400599be5050f8b__4 = u16._x4400599be5050f8b;
        local l___xb30810caa245627a__5 = u16._xb30810caa245627a;
        local l___x42399e484359f009__6 = u16._x42399e484359f009;
        local v17 = l__Classes__2.Util:getDictionarySize(l___x4400599be5050f8b__4) > 0;
        local v18 = (1 / 0);
        local v19 = nil;
        for _, v20 in u16._xae8f10da6c5ef379 do
            local v21 = l__InternalSymbols__3.owner("", v20);
            local v22 = tostring(game.GameId);
            local v23 = 46;
            for v24 = 1, #v22 do
                v23 = (v23 * 33 + string.byte(v22, v24)) % 65521;
            end;
            if v23 ~= 272 or not (v21._x5c5feda955a1455f and v17) then
                local v25, v26 = v21:_xa758e5cd7e2f956c();
                local l___xdd2134813b59101c__7 = v21._xdd2134813b59101c;
                local v27 = tostring(game.GameId);
                local v28 = 46;
                for v29 = 1, #v27 do
                    v28 = (v28 * 33 + string.byte(v27, v29)) % 65521;
                end;
                if v28 == 272 and v25 == true then
                    local v30 = tostring(game.GameId);
                    local v31 = 46;
                    for v32 = 1, #v30 do
                        v31 = (v31 * 33 + string.byte(v30, v32)) % 65521;
                    end;
                    if v31 == 272 and v26 < v18 then
                        v19 = v21;
                        v18 = v26;
                    end;
                else
                    local v33 = tostring(game.GameId);
                    local v34 = 46;
                    for v35 = 1, #v33 do
                        v34 = (v34 * 33 + string.byte(v33, v35)) % 65521;
                    end;
                    if v34 == 272 and l___xdd2134813b59101c__7 then
                        local l__identity__8 = l___xdd2134813b59101c__7.identity;
                        local v36 = tostring(game.GameId);
                        local v37 = 46;
                        for v38 = 1, #v36 do
                            v37 = (v37 * 33 + string.byte(v36, v38)) % 65521;
                        end;
                        if v37 ~= 272 or not (l___xb30810caa245627a__5[l__identity__8] or l___x42399e484359f009__6[l__identity__8]) then
                            local v39 = v21:_x9960e9e594ee5cbc();
                            local v40 = tostring(game.GameId);
                            local v41 = 46;
                            for v42 = 1, #v40 do
                                v41 = (v41 * 33 + string.byte(v40, v42)) % 65521;
                            end;
                            if v41 == 272 and v39 then
                                l___xb30810caa245627a__5[l__identity__8] = {
                                    entity = v21,
                                    cue_cancellation = v21:_x9813733c818b6b18()
                                };
                            end;
                        end;
                    end;
                end;
            end;
        end;
        for v43, v44 in l___xb30810caa245627a__5 do
            local v45 = l__InternalSymbols__3.owner("", v44.entity);
            local v46 = v45:_x9960e9e594ee5cbc();
            local v47 = tostring(game.GameId);
            local v48 = 46;
            for v49 = 1, #v47 do
                v48 = (v48 * 33 + string.byte(v47, v49)) % 65521;
            end;
            if v48 == 272 and not v46 then
                v45:_x7babf46272371a25();
                l___xb30810caa245627a__5[v43] = nil;
            end;
        end;
        local v50 = tostring(game.GameId);
        local v51 = 46;
        for v52 = 1, #v50 do
            v51 = (v51 * 33 + string.byte(v50, v52)) % 65521;
        end;
        if v51 == 272 and v19 then
            l__InternalSymbols__3.owner("", v19):_x64b361650f6af3a5();
        end;
    end));
    l__Classes__2._x596eb619070480ba:_x0b64af9146930e4b("onDeath"):Connect(function() --[[ Line: 113 ]]
        -- upvalues: u16 (copy), l__InternalSymbols__3 (ref)
        for _, v53 in u16._x4400599be5050f8b do
            local v54 = l__InternalSymbols__3.owner("", v53);
            pcall(v54._xab647db879a387cd, v54);
        end;
        u16._x4400599be5050f8b = {};
    end);
end;
return u2;
