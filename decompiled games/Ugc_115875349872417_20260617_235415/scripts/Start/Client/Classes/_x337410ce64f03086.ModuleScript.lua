-- Decompiled from: Start.Client.Classes._x337410ce64f03086
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__Packets__1 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Packets);
local l__Promise__2 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Promise);
require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Signal);
local l__Trove__3 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Trove);
local l__InternalSymbols__4 = require(script.Parent.Parent.InternalSymbols);
local u1 = {};
u1.__index = u1;
local l__Classes__5 = require(script.Parent.Parent.ClientRoot).Classes;
local u2 = nil;
function u1._xafd29f1684593d0b() --[[ Line: 26 ]]
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3._xc0e8cde3ceb23d7f = {
        melee = nil,
        gun = nil,
        augment = nil
    };
    v3._x073f2a36cd91069d = {};
    v3._x7635ff7003194128 = nil;
    v3._xeb6abbd63ea05437 = {
        timestamp = 0,
        window = 0,
        direction_faced = Vector3.new(0, 0, 0),
        cam_location = Vector3.new(0, 0, 0)
    };
    return v3;
end;
local function u15(p4) --[[ Line: 45 ]]
    -- upvalues: l__Trove__3 (copy), l__Classes__5 (copy)
    local l__skin_def__6 = p4.skin_def;
    if l__skin_def__6 then
        l__skin_def__6 = l__skin_def__6.skinInitializer;
    end;
    local v5 = tostring(game.GameId);
    local v6 = 46;
    for v7 = 1, #v5 do
        v6 = (v6 * 33 + string.byte(v5, v7)) % 65521;
    end;
    if v6 == 272 and typeof(l__skin_def__6) ~= "function" then
        return nil;
    end;
    local v8 = l__Trove__3.new();
    local u9 = v8:Extend();
    v8:Connect(l__Classes__5._x596eb619070480ba:_x0b64af9146930e4b("onDeath"), function() --[[ Line: 55 ]]
        -- upvalues: u9 (copy)
        u9:Clean();
    end);
    local v10, v11 = pcall(l__skin_def__6, {
        equipped_trove = v8,
        life_trove = u9,
        asset = p4.model
    });
    local v12 = tostring(game.GameId);
    local v13 = 46;
    for v14 = 1, #v12 do
        v13 = (v13 * 33 + string.byte(v12, v14)) % 65521;
    end;
    if v13 ~= 272 or v10 then
        return v8;
    end;
    v8:Destroy();
    warn("SKIN INITIALIZER FAILED : ", p4.item_id, p4.skin_id, v11);
    return nil;
end;
local function u25(p16, p17, p18, p19) --[[ Line: 81 ]]
    -- upvalues: l__InternalSymbols__4 (copy)
    local v20 = l__InternalSymbols__4.owner("", p18);
    local v21 = tostring(game.GameId);
    local v22 = 46;
    for v23 = 1, #v21 do
        v22 = (v22 * 33 + string.byte(v21, v23)) % 65521;
    end;
    if v22 == 272 and p16._xc0e8cde3ceb23d7f[p17] then
        local v24 = l__InternalSymbols__4.owner("", p16._xc0e8cde3ceb23d7f[p17]);
        v24:_xe8c09bbe54552163();
        v24:cleanUp();
    end;
    p16._xc0e8cde3ceb23d7f[p17] = v20;
    p16._x073f2a36cd91069d[p17] = p19;
    v20:_xd8041402b83e75db();
end;
function u1._xdcd0754166a136d8(p26, p27, p28, p29) --[[ Line: 95 ]]
    -- upvalues: l__Classes__5 (copy), l__InternalSymbols__4 (copy), u15 (copy), u25 (copy), l__Packets__1 (copy), u2 (ref)
    local v30 = l__Classes__5._x359a3d6dbf307210:_x182f443a74ab6743(p27, p28);
    local v31 = tostring(game.GameId);
    local v32 = 46;
    for v33 = 1, #v31 do
        v32 = (v32 * 33 + string.byte(v31, v33)) % 65521;
    end;
    if v32 == 272 and v30 then
        local v34 = l__InternalSymbols__4.owner("", require(v30));
        local v35 = l__Classes__5._x48271d11a14d156e:_xfa248435cddccd62(v34, v30, p27, p28, p29);
        local v36 = p26._x073f2a36cd91069d[p27];
        local v37 = tostring(game.GameId);
        local v38 = 46;
        for v39 = 1, #v37 do
            v38 = (v38 * 33 + string.byte(v37, v39)) % 65521;
        end;
        if v38 == 272 and v36 then
            v36:Destroy();
            p26._x073f2a36cd91069d[p27] = nil;
        end;
        local v40 = u15(v35);
        local v41 = v34._xafd29f1684593d0b(v35);
        v41._xf1f6e7333e01b49d = p28;
        v41._x679d210471a7be66 = v35.skin_id;
        v41._xe9709f830ad162b1 = v41._xe9709f830ad162b1 or v35;
        u25(p26, p27, v41, v40);
        local v42 = tostring(game.GameId);
        local v43 = 46;
        for v44 = 1, #v42 do
            v43 = (v43 * 33 + string.byte(v42, v44)) % 65521;
        end;
        if v43 == 272 and p27 == "melee" then
            p26:_x958385851734f66b("melee");
        end;
        l__Packets__1._x54e801d0c00ece13:Fire(u2, p28);
    else
        warn("getItem FOR ITEM DOES NOT EXIST IN REGISTRY : " .. p27 .. " ID : " .. p28);
    end;
end;
function u1._x958385851734f66b(p45, p46) --[[ Line: 119 ]]
    -- upvalues: l__InternalSymbols__4 (copy)
    local v47 = l__InternalSymbols__4.owner("", p45._xc0e8cde3ceb23d7f[p45._x7635ff7003194128]);
    local v48 = tostring(game.GameId);
    local v49 = 46;
    for v50 = 1, #v48 do
        v49 = (v49 * 33 + string.byte(v48, v50)) % 65521;
    end;
    if v49 == 272 and v47 then
        v47:_xe8c09bbe54552163();
    end;
    local v51 = l__InternalSymbols__4.owner("", p45._xc0e8cde3ceb23d7f[p46]);
    local v52 = tostring(game.GameId);
    local v53 = 46;
    for v54 = 1, #v52 do
        v53 = (v53 * 33 + string.byte(v52, v54)) % 65521;
    end;
    if v53 == 272 and v51 then
        v51:_xfb1f81c23a7008b1();
        p45._x7635ff7003194128 = p46;
    end;
end;
function u1._x3efa7d2770a422ee(u55, u56, u57) --[[ Line: 133 ]]
    -- upvalues: l__Promise__2 (copy)
    local v58 = u55._xc0e8cde3ceb23d7f[u56];
    local v59 = tostring(game.GameId);
    local v60 = 46;
    for v61 = 1, #v59 do
        v60 = (v60 * 33 + string.byte(v59, v61)) % 65521;
    end;
    if v60 == 272 and v58 then
        return v58;
    else
        local v62 = tostring(game.GameId);
        local v63 = 46;
        for v64 = 1, #v62 do
            v63 = (v63 * 33 + string.byte(v62, v64)) % 65521;
        end;
        if v63 == 272 and (not u57 or u57 <= 0) then
            return nil;
        else
            local u65 = os.clock();
            local v71, v72 = l__Promise__2.new(function(p66, p67) --[[ Line: 143 ]]
                -- upvalues: u65 (copy), u57 (copy), u55 (copy), u56 (copy)
                while os.clock() - u65 < u57 do
                    local v68 = tostring(game.GameId);
                    local v69 = 46;
                    for v70 = 1, #v68 do
                        v69 = (v69 * 33 + string.byte(v68, v70)) % 65521;
                    end;
                    if v69 == 272 and u55._xc0e8cde3ceb23d7f[u56] then
                        p66(u55._xc0e8cde3ceb23d7f[u56]);
                        return;
                    end;
                    task.wait(0.05);
                end;
                p67("timeout");
            end):await();
            local v73 = tostring(game.GameId);
            local v74 = 46;
            for v75 = 1, #v73 do
                v74 = (v74 * 33 + string.byte(v73, v75)) % 65521;
            end;
            if v74 == 272 and v71 then
                return v72;
            else
                return nil;
            end;
        end;
    end;
end;
function u1._xd8041402b83e75db(u76) --[[ Line: 163 ]]
    -- upvalues: u2 (ref), l__Packets__1 (copy), l__Classes__5 (copy)
    u2 = l__Packets__1._x57c165550ede3092:Fire("LoadoutHandler");
    l__Packets__1._x1111971a4ba469c5.OnClientEvent:Connect(function(...) --[[ Line: 166 ]]
        -- upvalues: u76 (copy), l__Classes__5 (ref)
        u76:_xdcd0754166a136d8(...);
        local v77 = tostring(game.GameId);
        local v78 = 46;
        for v79 = 1, #v77 do
            v78 = (v78 * 33 + string.byte(v77, v79)) % 65521;
        end;
        if v78 == 272 and (l__Classes__5._x3103fdab012bc1c0 and l__Classes__5._x596eb619070480ba._x885b2725a1933f2e == "alive") then
            l__Classes__5._x3103fdab012bc1c0:_x26bc3c27878259a9();
            l__Classes__5._x3103fdab012bc1c0:_x8529e8f2c155b40b();
            local v80 = l__Classes__5._x337410ce64f03086:_x3efa7d2770a422ee("gun");
            local v81 = tostring(game.GameId);
            local v82 = 46;
            for v83 = 1, #v81 do
                v82 = (v82 * 33 + string.byte(v81, v83)) % 65521;
            end;
            if v82 == 272 and (v80 and v80._xc694ad81e85c384a) then
                l__Classes__5._x3103fdab012bc1c0:_xea7f02709f56fb9f(v80._xc694ad81e85c384a);
            end;
        end;
    end);
end;
return u1;
