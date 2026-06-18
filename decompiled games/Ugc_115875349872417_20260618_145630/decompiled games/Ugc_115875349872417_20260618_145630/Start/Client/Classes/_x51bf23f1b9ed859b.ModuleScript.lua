-- Decompiled from: Start.Client.Classes._x51bf23f1b9ed859b
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__CEnum__3 = require(l__ModuleScripts__2.CEnum);
local l__SkinDefs__4 = require(l__ModuleScripts__2.SkinDefs);
local l__Classes__5 = require(script.Parent.Parent.ClientRoot).Classes;
local l__InternalSymbols__6 = require(script.Parent.Parent.InternalSymbols);
local u1 = {};
u1.__index = u1;
local u2 = {
    model = true,
    animations = true,
    animations_3p = true,
    rig_3p = true,
    effects = true,
    sounds = true,
    params = true,
    offsets = true,
    auxiliary = true
};
local u3 = {
    equip_sound = true,
    shot_sound = true,
    bonus_shot_sound = true,
    lock_in = true,
    lock_off = true,
    shot_hit = true,
    dry_fire = true
};
local function u8(p4) --[[ Line: 38 ]]
    -- upvalues: u8 (copy)
    if typeof(p4) ~= "table" then
        return p4;
    end;
    local v5 = {};
    for v6, v7 in pairs(p4) do
        v5[v6] = u8(v7);
    end;
    return v5;
end;
local function u13(p9, p10) --[[ Line: 50 ]]
    -- upvalues: u13 (copy), u8 (copy)
    if typeof(p10) ~= "table" then
        return p9;
    end;
    for v11, v12 in pairs(p10) do
        if typeof(v12) == "table" and typeof(p9[v11]) == "table" then
            u13(p9[v11], v12);
        else
            p9[v11] = u8(v12);
        end;
    end;
    return p9;
end;
local function u17(p14) --[[ Line: 66 ]]
    -- upvalues: u13 (copy), u2 (copy), u8 (copy)
    local v15 = {};
    if typeof(p14) ~= "table" then
        return v15;
    end;
    if typeof(p14.render) == "table" then
        u13(v15, p14.render);
    end;
    for v16 in pairs(u2) do
        if p14[v16] ~= nil then
            v15[v16] = u8(p14[v16]);
        end;
    end;
    return v15;
end;
local function u22(p18) --[[ Line: 102 ]]
    if typeof(p18) ~= "table" then
        return false;
    end;
    local v19 = 0;
    for v20, v21 in pairs(p18) do
        if typeof(v20) ~= "number" or (v20 < 1 or (v20 % 1 ~= 0 or (typeof(v21) ~= "string" or v21 == ""))) then
            return false;
        end;
        v19 = v19 + 1;
    end;
    return v19 > 0;
end;
local function u27(p23) --[[ Line: 136 ]]
    -- upvalues: u22 (copy), u27 (copy)
    if typeof(p23) == "string" then
        return true;
    end;
    if typeof(p23) ~= "table" then
        return false;
    end;
    if not u22(p23) then
        for _, v24 in pairs(p23) do
            local v25;
            if typeof(v24) == "string" then
                v25 = true;
            elseif typeof(v24) == "string" then
                v25 = string.find(v24, "/") ~= nil;
            else
                v25 = u22(v24);
                if v25 then
                    v25 = #v24 > 1;
                end;
            end;
            if v25 then
                return true;
            end;
            if u27(v24) then
                return true;
            end;
        end;
        return false;
    end;
    if typeof(p23) == "string" then
        return string.find(p23, "/") ~= nil;
    end;
    local v26 = u22(p23);
    if v26 then
        v26 = #p23 > 1;
    end;
    return v26;
end;
local function u33(p28) --[[ Line: 162 ]]
    -- upvalues: u3 (copy), u22 (copy)
    if typeof(p28) ~= "table" then
        return false;
    end;
    for v29, v30 in pairs(p28) do
        local v31;
        if u3[v29] == true then
            v31 = true;
        elseif typeof(v29) == "string" then
            v31 = string.sub(v29, -6) == "_sound";
        else
            v31 = false;
        end;
        if v31 then
            local v32;
            if typeof(v30) == "string" then
                v32 = true;
            elseif typeof(v30) == "string" then
                v32 = string.find(v30, "/") ~= nil;
            else
                v32 = u22(v30);
                if v32 then
                    v32 = #v30 > 1;
                end;
            end;
            if v32 then
                return true;
            end;
        end;
    end;
    return false;
end;
local function u40(p34, p35) --[[ Line: 213 ]]
    -- upvalues: l__CEnum__3 (copy)
    local v36 = {};
    local v37 = {};
    if typeof(p35) == "table" and typeof(p35.asset_folder) == "string" then
        local l__asset_folder__7 = p35.asset_folder;
        if typeof(l__asset_folder__7) == "string" and l__asset_folder__7 ~= "" then
            if v37[l__asset_folder__7] then
                return v36;
            end;
            v37[l__asset_folder__7] = true;
            table.insert(v36, l__asset_folder__7);
        end;
        return v36;
    end;
    local v38 = l__CEnum__3.reverse(l__CEnum__3.Skins, p34);
    if typeof(v38) == "string" and (v38 ~= "" and not v37[v38]) then
        v37[v38] = true;
        table.insert(v36, v38);
    end;
    if typeof(p35) == "table" then
        local l__name__8 = p35.name;
        if typeof(l__name__8) == "string" and (l__name__8 ~= "" and not v37[l__name__8]) then
            v37[l__name__8] = true;
            table.insert(v36, l__name__8);
        end;
    end;
    local v39 = tostring(p34);
    if typeof(v39) == "string" and v39 ~= "" then
        if v37[v39] then
            return v36;
        end;
        v37[v39] = true;
        table.insert(v36, v39);
    end;
    return v36;
end;
local function u45(p41, p42) --[[ Line: 241 ]]
    if not p41 then
        return nil;
    end;
    for _, v43 in p42 do
        local v44 = p41:FindFirstChild(v43);
        if v44 and v44:IsA("Folder") then
            return v44;
        end;
    end;
    return nil;
end;
local function u62(p46, p47, p48, p49) --[[ Line: 256 ]]
    -- upvalues: l__Players__1 (copy), u40 (copy), u45 (copy)
    local l__LocalPlayer__9 = l__Players__1.LocalPlayer;
    local v50 = os.clock() + 2;
    local v51;
    if l__LocalPlayer__9 then
        v51 = l__LocalPlayer__9:FindFirstChildOfClass("PlayerGui");
    else
        v51 = l__LocalPlayer__9;
    end;
    local v52;
    if v51 or not (l__LocalPlayer__9 and p49) then
        v52 = v51;
    else
        if l__LocalPlayer__9 then
            v52 = l__LocalPlayer__9:FindFirstChild("PlayerGui");
            if not v52 then
                local v53 = v50 - os.clock();
                if v53 <= 0 then
                    v52 = nil;
                else
                    v52 = l__LocalPlayer__9:WaitForChild("PlayerGui", v53);
                end;
            end;
        else
            v52 = nil;
        end;
        if v52 then
            if not v52:IsA("PlayerGui") then
                v52 = v51;
            end;
        else
            v52 = v51;
        end;
    end;
    if not v52 then
        return nil;
    end;
    local v54;
    if p49 then
        if v52 then
            v54 = v52:FindFirstChild("SkinAssets");
            if not v54 then
                local v55 = v50 - os.clock();
                if v55 <= 0 then
                    v54 = nil;
                else
                    v54 = v52:WaitForChild("SkinAssets", v55);
                end;
            end;
        else
            v54 = nil;
        end;
    else
        v54 = v52:FindFirstChild("SkinAssets");
    end;
    local v56;
    if p49 then
        if v54 then
            v56 = v54:FindFirstChild("Skins");
            if not v56 then
                local v57 = v50 - os.clock();
                if v57 <= 0 then
                    v56 = nil;
                else
                    v56 = v54:WaitForChild("Skins", v57);
                end;
            end;
        else
            v56 = nil;
        end;
    elseif v54 then
        v56 = v54:FindFirstChild("Skins");
    else
        v56 = v54;
    end;
    local v58;
    if p49 then
        if v56 then
            v58 = v56:FindFirstChild(p46);
            if not v58 then
                local v59 = v50 - os.clock();
                if v59 <= 0 then
                    v58 = nil;
                else
                    v58 = v56:WaitForChild(p46, v59);
                end;
            end;
        else
            v58 = nil;
        end;
    elseif v56 then
        v58 = v56:FindFirstChild(p46);
    else
        v58 = v56;
    end;
    local v60 = u40(p47, p48);
    local v61 = u45(v58, v60);
    while p49 and (not v61 and os.clock() < v50) do
        task.wait(0.05);
        v61 = u45(v58, v60);
    end;
    return v61 or nil;
end;
local function u65(p63, p64) --[[ Line: 295 ]]
    -- upvalues: l__SkinDefs__4 (copy)
    return l__SkinDefs__4.resolveReference(p63, p64);
end;
local function u69(p66, p67) --[[ Line: 308 ]]
    -- upvalues: u22 (copy), u65 (copy)
    if typeof(p66) == "string" and not string.find(p66, "/") then
        if p67 then
            p67 = p67:FindFirstChild("Sounds");
        end;
        if not (p67 and p67:IsA("Folder")) then
            p67 = nil;
        end;
        if p67 then
            p67 = p67:FindFirstChild(p66);
        end;
        return p67;
    else
        local v68;
        if typeof(p66) == "string" then
            v68 = string.find(p66, "/") ~= nil;
        else
            v68 = u22(p66);
            if v68 then
                v68 = #p66 > 1;
            end;
        end;
        if v68 then
            return u65(p66, p67);
        else
            return nil;
        end;
    end;
end;
local function u82(p70, p71, p72) --[[ Line: 334 ]]
    -- upvalues: u22 (copy), u69 (copy), u8 (copy), u82 (copy)
    if typeof(p70) ~= "table" then
        return p70;
    end;
    local v73 = {};
    for v74, v77 in pairs(p70) do
        local v76;
        if typeof(p72) == "table" then
            v76 = p72[v74] or nil;
        else
            v76 = nil;
        end;
        local v77;
        if u22(v77) then
            local v78 = u69(v77, p71);
            if v78 and (v78:IsA("Sound") or v78:IsA("SoundGroup")) then
                v77 = v78;
            else
                local v79;
                if typeof(v77) == "string" then
                    v79 = string.find(v77, "/") ~= nil;
                else
                    v79 = u22(v77);
                    if v79 then
                        v79 = #v77 > 1;
                    end;
                end;
                if v79 then
                    v77 = u8(v76);
                end;
            end;
            v73[v74] = v77;
        elseif typeof(v77) == "table" then
            v73[v74] = u82(v77, p71, v76);
        else
            local v80 = u69(v77, p71);
            if v80 and (v80:IsA("Sound") or v80:IsA("SoundGroup")) then
                v77 = v80;
            else
                local v81;
                if typeof(v77) == "string" then
                    v81 = string.find(v77, "/") ~= nil;
                else
                    v81 = u22(v77);
                    if v81 then
                        v81 = #v77 > 1;
                    end;
                end;
                if v81 then
                    v77 = u8(v76);
                end;
            end;
            v73[v74] = v77;
        end;
    end;
    return v73;
end;
local function u94(p83, p84, p85) --[[ Line: 356 ]]
    -- upvalues: u8 (copy), u3 (copy), u69 (copy), u22 (copy)
    if typeof(p83) ~= "table" then
        return p83;
    end;
    local v86 = u8(p83);
    for v87, v92 in pairs(p83) do
        local v89;
        if u3[v87] == true then
            v89 = true;
        elseif typeof(v87) == "string" then
            v89 = string.sub(v87, -6) == "_sound";
        else
            v89 = false;
        end;
        if v89 then
            local v90;
            if typeof(p85) == "table" then
                v90 = p85[v87] or nil;
            else
                v90 = nil;
            end;
            local v91 = u69(v92, p84);
            local v92;
            if v91 and (v91:IsA("Sound") or v91:IsA("SoundGroup")) then
                v92 = v91;
            else
                local v93;
                if typeof(v92) == "string" then
                    v93 = string.find(v92, "/") ~= nil;
                else
                    v93 = u22(v92);
                    if v93 then
                        v93 = #v92 > 1;
                    end;
                end;
                if v93 then
                    v92 = u8(v90);
                end;
            end;
            v86[v87] = v92;
        end;
    end;
    return v86;
end;
function u1._x90d4581ac99dd483() --[[ Line: 372 ]]
    -- upvalues: u1 (copy)
    return setmetatable({}, u1);
end;
function u1._x5e63d412d07a8493(_, p95, p96, p97, p98, p99) --[[ Line: 378 ]]
    -- upvalues: l__InternalSymbols__6 (copy), l__SkinDefs__4 (copy), u8 (copy), u13 (copy), u17 (copy), u27 (copy), u33 (copy), u62 (copy), u40 (copy), u82 (copy), u94 (copy)
    local v100 = l__InternalSymbols__6.owner("", p95);
    local v101 = l__SkinDefs__4.getEquippedOrDefault(p98, p99);
    local v102 = l__SkinDefs__4.getSkin(p98, v101);
    local v103 = {};
    if typeof(p99) == "number" and (p99 ~= l__SkinDefs__4.DEFAULT_SKIN_ID and v101 == l__SkinDefs__4.DEFAULT_SKIN_ID) then
        warn("INVALID SKIN ID FOR ITEM, USING DEFAULT : ", p98, p99);
    end;
    local v104 = v100 and typeof(v100._xc091da12abbfb546) == "function" and (v100._xc091da12abbfb546(p96) or {}) or v103;
    local v105 = u8(v104);
    u13(v105, (u17(v102)));
    local v106 = l__SkinDefs__4.getSkinFolder(p98, v101, v102);
    local v107 = true;
    local v108;
    if typeof(v102) == "table" then
        if v102.model == nil then
            local l__render__10 = v102.render;
            if typeof(l__render__10) == "table" then
                v108 = l__render__10.model;
            else
                v108 = nil;
            end;
        else
            v108 = v102.model;
        end;
    else
        v108 = nil;
    end;
    if v108 == nil then
        local v109;
        if typeof(v102) == "table" then
            if v102.animations == nil then
                local l__render__11 = v102.render;
                if typeof(l__render__11) == "table" then
                    v109 = l__render__11.animations;
                else
                    v109 = nil;
                end;
            else
                v109 = v102.animations;
            end;
        else
            v109 = nil;
        end;
        v107 = v109 ~= nil;
    end;
    local v110;
    if v101 == l__SkinDefs__4.DEFAULT_SKIN_ID then
        v110 = false;
    else
        v110 = true;
        local v111;
        if typeof(v102) == "table" then
            if v102.model == nil then
                local l__render__12 = v102.render;
                if typeof(l__render__12) == "table" then
                    v111 = l__render__12.model;
                else
                    v111 = nil;
                end;
            else
                v111 = v102.model;
            end;
        else
            v111 = nil;
        end;
        if v111 == nil then
            local v112;
            if typeof(v102) == "table" then
                if v102.animations == nil then
                    local l__render__13 = v102.render;
                    if typeof(l__render__13) == "table" then
                        v112 = l__render__13.animations;
                    else
                        v112 = nil;
                    end;
                else
                    v112 = v102.animations;
                end;
            else
                v112 = nil;
            end;
            v110 = v112 ~= nil;
        end;
        if not v110 then
            local v113 = u27;
            local v114;
            if typeof(v102) == "table" then
                if v102.sounds == nil then
                    local l__render__14 = v102.render;
                    if typeof(l__render__14) == "table" then
                        v114 = l__render__14.sounds;
                    else
                        v114 = nil;
                    end;
                else
                    v114 = v102.sounds;
                end;
            else
                v114 = nil;
            end;
            v110 = v113(v114);
            if not v110 then
                local v115 = u33;
                local v116;
                if typeof(v102) == "table" then
                    if v102.params == nil then
                        local l__render__15 = v102.render;
                        if typeof(l__render__15) == "table" then
                            v116 = l__render__15.params;
                        else
                            v116 = nil;
                        end;
                    else
                        v116 = v102.params;
                    end;
                else
                    v116 = nil;
                end;
                v110 = v115(v116);
            end;
        end;
    end;
    local v117 = u62(p98, v101, v102, v110);
    if v101 ~= l__SkinDefs__4.DEFAULT_SKIN_ID and (v107 and not v117) then
        warn("PRIVATE SKIN ASSET MIRROR MISSING : ", p98, v101, table.concat(u40(v101, v102), ", "));
    end;
    local v118 = v117 or v106;
    local l__animations__16 = v105.animations;
    local v119 = l__SkinDefs__4.resolveReference(v105.model, v117);
    local v120 = l__SkinDefs__4.resolveReference(v105.model, v106);
    if v117 then
        local v121;
        if typeof(v102) == "table" then
            if v102.model == nil then
                local l__render__17 = v102.render;
                if typeof(l__render__17) == "table" then
                    v121 = l__render__17.model;
                else
                    v121 = nil;
                end;
            else
                v121 = v102.model;
            end;
        else
            v121 = nil;
        end;
        if v121 ~= nil and not v119 then
            warn("PRIVATE SKIN MODEL MIRROR MISSING : ", p98, v101, v105.model, v117:GetFullName());
        end;
    end;
    local v122 = v119 or (v120 or l__SkinDefs__4.resolveReference(v104.model, nil));
    local v123 = l__SkinDefs__4.resolveReference(l__animations__16, v117);
    local v124 = l__SkinDefs__4.resolveReference(l__animations__16, v106);
    if v117 then
        local v125;
        if typeof(v102) == "table" then
            if v102.animations == nil then
                local l__render__18 = v102.render;
                if typeof(l__render__18) == "table" then
                    v125 = l__render__18.animations;
                else
                    v125 = nil;
                end;
            else
                v125 = v102.animations;
            end;
        else
            v125 = nil;
        end;
        if v125 ~= nil and not v123 then
            warn("PRIVATE SKIN ANIMATION MIRROR MISSING : ", p98, v101, l__animations__16, v117:GetFullName());
        end;
    end;
    local v126 = v123 or (v124 or l__SkinDefs__4.resolveReference(v104.animations, nil));
    local v127 = nil;
    if v126 then
        l__animations__16 = v126;
    elseif typeof(l__animations__16) ~= "string" then
        l__animations__16 = v126;
    end;
    local v128 = l__animations__16 or p98;
    if typeof(v102) == "table" and v102.animations_3p ~= nil then
        v127 = l__SkinDefs__4.resolveAnimations3P(p98, v101);
        if not v127 then
            warn("COULD NOT RESOLVE animations_3p FOR SKIN : ", p98, v101, v102.animations_3p);
        end;
    end;
    v105.item_type = p97;
    v105.item_id = p98;
    v105.skin_id = v101;
    v105.skin_def = v102;
    v105.asset_folder = v118;
    v105.private_asset_folder = v117;
    v105.public_asset_folder = v106;
    v105.model_source = v122;
    v105.animations = v128;
    v105.animations_3p = v127;
    v105.params = v105.params or {};
    v105.offsets = v105.offsets or {};
    v105.sounds = v105.sounds or {};
    v105.effects = v105.effects or {};
    v105.sounds = u82(v105.sounds, v117, v104.sounds);
    v105.params = u94(v105.params, v117, v104.params);
    if v122 then
        v105.model = v122:Clone();
    end;
    if typeof(v105.auxiliary) == "table" then
        local v129 = {};
        for v130, v131 in pairs(v105.auxiliary) do
            local v132 = l__SkinDefs__4.resolveReference(v131, v106);
            if v132 then
                v129[v130] = v132:Clone();
            end;
        end;
        v105.auxiliary_models = v129;
    end;
    local l__gunpoint_path__19 = v105.params.gunpoint_path;
    if not v105.params.gunpoint and (v105.model and l__gunpoint_path__19) then
        v105.params.gunpoint = l__SkinDefs__4.findByPath(v105.model, l__gunpoint_path__19);
    end;
    v105.params.animation_source = v105.animations;
    v105.params.animations_3p = v105.animations_3p;
    v105.params.effects = v105.effects;
    v105.params.sounds = v105.sounds;
    v105.params.render_context = v105;
    return v105;
end;
function u1._x1f236f974a4eb38e(_, p133, p134, p135) --[[ Line: 482 ]]
    if p133 then
        p133 = p133.sounds;
    end;
    if typeof(p133) == "table" then
        return p133[p134] or (p133[p135] or (p135 or p134));
    else
        return p135 or p134;
    end;
end;
function u1._xc782ad79ba49be57(p136, p137, p138, p139, p140, p141, p142) --[[ Line: 491 ]]
    -- upvalues: l__InternalSymbols__6 (copy)
    local v143 = l__InternalSymbols__6.owner("", p138);
    local v144 = p136:_x1f236f974a4eb38e(p137, p139, p142);
    if typeof(v144) ~= "Instance" then
        return v143:_x7ab8b42cc5920a78(v144, p140, p141);
    end;
    if v144:IsA("Sound") or v144:IsA("SoundGroup") then
        return v143:_x6187b85bcb2f6e63(v144.Name, v144, p140, p141);
    end;
    warn("INVALID SKIN SOUND INSTANCE : ", v144);
    return nil;
end;
function u1._x02e515397157a035(_, p145, p146, p147) --[[ Line: 506 ]]
    if p145 then
        p145 = p145.effects;
    end;
    if typeof(p145) == "table" then
        return p145[p146] or (p145[p147] or (p147 or p146));
    else
        return p147 or p146;
    end;
end;
function u1._x1e643afd7367aa17(p148, p149, p150, ...) --[[ Line: 515 ]]
    -- upvalues: l__Classes__5 (copy)
    local v151 = p148:_x02e515397157a035(p149, p150, p150);
    if typeof(v151) == "function" then
        return v151(l__Classes__5._x255cd8d76027f039, ...);
    else
        return l__Classes__5._x255cd8d76027f039:_x30a139d5b0b34114(v151, ...);
    end;
end;
function u1._xe53615d96cf36a6b(_) --[[ Line: 524 ]] end;
return u1;
