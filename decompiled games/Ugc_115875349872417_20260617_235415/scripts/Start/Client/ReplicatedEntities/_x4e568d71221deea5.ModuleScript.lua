-- Decompiled from: Start.Client.ReplicatedEntities._x4e568d71221deea5
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
require(l__ModuleScripts__1.Packets);
require(l__ModuleScripts__1.Signal);
require(l__ModuleScripts__1.Promise);
require(l__ModuleScripts__1.Trove);
require(l__ModuleScripts__1.Spring);
local l__CEnum__2 = require(l__ModuleScripts__1.CEnum);
local l___xc3d339874a04a532__3 = require(script.Parent._xc3d339874a04a532);
local u1 = {};
u1.__index = u1;
setmetatable(u1, l___xc3d339874a04a532__3);
local l__Classes__4 = require(script.Parent.Parent.ClientRoot).Classes;
local _ = game.Players.LocalPlayer;
function u1._xafd29f1684593d0b(p2, p3) --[[ Line: 33 ]]
    -- upvalues: l___xc3d339874a04a532__3 (copy), u1 (copy)
    local v4 = l___xc3d339874a04a532__3._xafd29f1684593d0b(p2);
    setmetatable(v4, u1);
    v4._x5c5feda955a1455f = p3.is_exclusive;
    v4._xcd3abfea14795088 = false;
    v4._x6a6e6f9f95d30be1 = p3.interaction_data;
    v4._xdd2134813b59101c = p3.gameplay_cue_data;
    return v4;
end;
function u1._xab647db879a387cd(p5) --[[ Line: 58 ]]
    warn("REAL stopInteract HAS NOT BEEN SET, EMPTY BASE METHOD WAS CALLED, ", p5._x4755799bd25529a3);
end;
function u1._x64b361650f6af3a5(p6) --[[ Line: 62 ]]
    warn("REAL onInteract HAS NOT BEEN SET, EMPTY BASE METHOD WAS CALLED ", p6._x4755799bd25529a3);
end;
function u1._x9813733c818b6b18(p7) --[[ Line: 66 ]]
    -- upvalues: l__Classes__4 (copy)
    local v8 = tostring(game.GameId);
    local v9 = 46;
    for v10 = 1, #v8 do
        v9 = (v9 * 33 + string.byte(v8, v10)) % 65521;
    end;
    if v9 ~= 272 or p7._xdd2134813b59101c then
        return l__Classes__4._x3103fdab012bc1c0:_xc7aacf563daf767b({
            cue_type = "message",
            text = p7._xdd2134813b59101c.getText()
        });
    end;
end;
function u1._x7babf46272371a25(p11) --[[ Line: 75 ]]
    -- upvalues: l__Classes__4 (copy)
    local v12 = tostring(game.GameId);
    local v13 = 46;
    for v14 = 1, #v12 do
        v13 = (v13 * 33 + string.byte(v12, v14)) % 65521;
    end;
    if v13 == 272 and not p11._xdd2134813b59101c then
    else
        local v15 = l__Classes__4._x56197d0361586748._xb30810caa245627a[p11._xdd2134813b59101c.identity];
        local v16 = tostring(game.GameId);
        local v17 = 46;
        for v18 = 1, #v16 do
            v17 = (v17 * 33 + string.byte(v16, v18)) % 65521;
        end;
        if v17 == 272 and (v15 and v15.cue_cancellation) then
            pcall(v15.cue_cancellation);
        end;
    end;
end;
function u1._x9960e9e594ee5cbc(u19) --[[ Line: 84 ]]
    -- upvalues: l__CEnum__2 (copy), l__Classes__4 (copy)
    local v20 = tostring(game.GameId);
    local v21 = 46;
    for v22 = 1, #v20 do
        v21 = (v21 * 33 + string.byte(v20, v22)) % 65521;
    end;
    if v21 == 272 and not u19._x6a6e6f9f95d30be1.reference_part then
        return false;
    else
        local v23 = tostring(game.GameId);
        local v24 = 46;
        for v25 = 1, #v23 do
            v24 = (v24 * 33 + string.byte(v23, v25)) % 65521;
        end;
        if v24 == 272 and not u19._xdd2134813b59101c then
            return false;
        else
            local v26 = tostring(game.GameId);
            local v27 = 46;
            for v28 = 1, #v26 do
                v27 = (v27 * 33 + string.byte(v26, v28)) % 65521;
            end;
            if v27 == 272 and u19._x6a6e6f9f95d30be1.type == l__CEnum__2.InteractTypes.proximityAuto then
                return false;
            else
                local v29 = tostring(game.GameId);
                local v30 = 46;
                for v31 = 1, #v29 do
                    v30 = (v30 * 33 + string.byte(v29, v31)) % 65521;
                end;
                if v30 == 272 and not u19._xcd3abfea14795088 then
                    return false;
                else
                    local v32 = tostring(game.GameId);
                    local v33 = 46;
                    for v34 = 1, #v32 do
                        v33 = (v33 * 33 + string.byte(v32, v34)) % 65521;
                    end;
                    if v33 == 272 and u19._x2021efd2ee6b8613 ~= "alive" then
                        return false;
                    else
                        local v41, v42 = pcall(function() --[[ Name: getInteractResult, Line 91 ]]
                            -- upvalues: u19 (copy), l__Classes__4 (ref)
                            local v35 = tostring(game.GameId);
                            local v36 = 46;
                            for v37 = 1, #v35 do
                                v36 = (v36 * 33 + string.byte(v35, v37)) % 65521;
                            end;
                            if v36 == 272 and not u19._xcd3abfea14795088 then
                                return false;
                            end;
                            local l__Position__5 = l__Classes__4._xef0ffbcc2c92f7b4._x80657f8b6fb2b73e.Position;
                            local l__Magnitude__6 = (l__Position__5 - u19._x6a6e6f9f95d30be1.reference_part:GetClosestPointOnSurface(l__Position__5)).Magnitude;
                            local l__radius__7 = u19._x6a6e6f9f95d30be1.radius;
                            local v38 = tostring(game.GameId);
                            local v39 = 46;
                            for v40 = 1, #v38 do
                                v39 = (v39 * 33 + string.byte(v38, v40)) % 65521;
                            end;
                            return (v39 ~= 272 or l__radius__7 >= l__Magnitude__6) and true or false;
                        end);
                        local v43 = tostring(game.GameId);
                        local v44 = 46;
                        for v45 = 1, #v43 do
                            v44 = (v44 * 33 + string.byte(v43, v45)) % 65521;
                        end;
                        if v44 == 272 and v41 then
                            return v42;
                        else
                            return false;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
function u1._xa758e5cd7e2f956c(u46) --[[ Line: 118 ]]
    -- upvalues: l__CEnum__2 (copy), l__Classes__4 (copy)
    local v47 = tostring(game.GameId);
    local v48 = 46;
    for v49 = 1, #v47 do
        v48 = (v48 * 33 + string.byte(v47, v49)) % 65521;
    end;
    if v48 == 272 and not u46._x6a6e6f9f95d30be1.reference_part then
        return false;
    else
        local v50 = tostring(game.GameId);
        local v51 = 46;
        for v52 = 1, #v50 do
            v51 = (v51 * 33 + string.byte(v50, v52)) % 65521;
        end;
        if v51 == 272 and not u46._xcd3abfea14795088 then
            return false;
        else
            local v53 = tostring(game.GameId);
            local v54 = 46;
            for v55 = 1, #v53 do
                v54 = (v54 * 33 + string.byte(v53, v55)) % 65521;
            end;
            if v54 == 272 and u46._x2021efd2ee6b8613 ~= "alive" then
                return false;
            else
                local v74, v75, v76 = pcall(function() --[[ Name: getInteractResult, Line 123 ]]
                    -- upvalues: u46 (copy), l__CEnum__2 (ref), l__Classes__4 (ref)
                    local v56 = tostring(game.GameId);
                    local v57 = 46;
                    for v58 = 1, #v56 do
                        v57 = (v57 * 33 + string.byte(v56, v58)) % 65521;
                    end;
                    if v57 == 272 and not u46._xcd3abfea14795088 then
                        return false;
                    end;
                    local v59 = tostring(game.GameId);
                    local v60 = 46;
                    for v61 = 1, #v59 do
                        v60 = (v60 * 33 + string.byte(v59, v61)) % 65521;
                    end;
                    if v60 == 272 and u46._x6a6e6f9f95d30be1.type == l__CEnum__2.InteractTypes.proximityAuto then
                        local l__Position__8 = l__Classes__4._xef0ffbcc2c92f7b4._x80657f8b6fb2b73e.Position;
                        local l__Magnitude__9 = (l__Position__8 - u46._x6a6e6f9f95d30be1.reference_part:GetClosestPointOnSurface(l__Position__8)).Magnitude;
                        local l__radius__10 = u46._x6a6e6f9f95d30be1.radius;
                        local v62 = tostring(game.GameId);
                        local v63 = 46;
                        for v64 = 1, #v62 do
                            v63 = (v63 * 33 + string.byte(v62, v64)) % 65521;
                        end;
                        if v63 == 272 and l__Magnitude__9 <= l__radius__10 then
                            return true, l__Magnitude__9;
                        end;
                    else
                        local v65 = tostring(game.GameId);
                        local v66 = 46;
                        for v67 = 1, #v65 do
                            v66 = (v66 * 33 + string.byte(v65, v67)) % 65521;
                        end;
                        if v66 == 272 and u46._x6a6e6f9f95d30be1.type == l__CEnum__2.InteractTypes.proximityInput then
                            local l__Position__11 = l__Classes__4._xef0ffbcc2c92f7b4._x80657f8b6fb2b73e.Position;
                            local l__Magnitude__12 = (l__Position__11 - u46._x6a6e6f9f95d30be1.reference_part:GetClosestPointOnSurface(l__Position__11)).Magnitude;
                            local l__radius__13 = u46._x6a6e6f9f95d30be1.radius;
                            local v68 = tostring(game.GameId);
                            local v69 = 46;
                            for v70 = 1, #v68 do
                                v69 = (v69 * 33 + string.byte(v68, v70)) % 65521;
                            end;
                            if v69 == 272 and l__radius__13 < l__Magnitude__12 then
                                return false;
                            else
                                local v71 = tostring(game.GameId);
                                local v72 = 46;
                                for v73 = 1, #v71 do
                                    v72 = (v72 * 33 + string.byte(v71, v73)) % 65521;
                                end;
                                if v72 == 272 and l__Classes__4._xd2c44c643b0c3fb4:_xdf0c107e49196810("INTERACT").Held then
                                    return true, l__Magnitude__12;
                                else
                                    return false, l__Magnitude__12;
                                end;
                            end;
                        end;
                    end;
                    return false;
                end);
                local v77 = tostring(game.GameId);
                local v78 = 46;
                for v79 = 1, #v77 do
                    v78 = (v78 * 33 + string.byte(v77, v79)) % 65521;
                end;
                if v78 == 272 and v74 then
                    return v75, v76;
                else
                    return false;
                end;
            end;
        end;
    end;
end;
function u1.cleanUp(u80) --[[ Line: 169 ]]
    u80._x2021efd2ee6b8613 = "dead";
    pcall(function() --[[ Line: 171 ]]
        -- upvalues: u80 (copy)
        u80._x8c9d61d42d259b94:Clean();
    end);
end;
function u1._xd8041402b83e75db(p81) --[[ Line: 177 ]]
    -- upvalues: l__Classes__4 (copy)
    l__Classes__4._x56197d0361586748:_x74c04e4fd9d9d72f(p81);
    p81._xcd3abfea14795088 = true;
    p81._x2021efd2ee6b8613 = "alive";
end;
return u1;
