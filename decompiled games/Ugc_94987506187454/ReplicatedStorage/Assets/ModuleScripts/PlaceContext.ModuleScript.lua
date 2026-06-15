-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.PlaceContext
-- Class: ModuleScript
-- Place: Ugc (94987506187454)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__CEnum__2 = require(script.Parent.CEnum);
local u1 = {
    EffectiveModes = {
        PUBLIC_LOBBY = "PUBLIC_LOBBY",
        FFA = "FFA",
        PRIVATE_FFA = "PRIVATE_FFA",
        MATCH = "MATCH"
    }
};
local u2 = script;
local u3 = nil;
local u4 = false;
local function u7() --[[ Line: 34 ]]
    -- upvalues: l__RunService__1 (copy), u4 (ref), u2 (copy)
    if l__RunService__1:IsServer() then
        if u4 then
        else
            u4 = true;
            local l__PrivateServerId__3 = game.PrivateServerId;
            local l__PrivateServerOwnerId__4 = game.PrivateServerOwnerId;
            local v5;
            if l__PrivateServerId__3 == "" then
                v5 = false;
            else
                v5 = l__PrivateServerOwnerId__4 == 0;
            end;
            local v6;
            if l__PrivateServerId__3 == "" then
                v6 = false;
            else
                v6 = l__PrivateServerOwnerId__4 ~= 0;
            end;
            u2:SetAttribute("PlaceContext_IsPublicServer", l__PrivateServerId__3 == "");
            u2:SetAttribute("PlaceContext_IsVipServer", v6);
            u2:SetAttribute("PlaceContext_IsReservedServer", v5);
            u2:SetAttribute("PlaceContext_PrivateServerOwnerId", l__PrivateServerOwnerId__4);
            u2:SetAttribute("PlaceContext_IsReady", true);
        end;
    end;
end;
local function u10() --[[ Line: 59 ]]
    -- upvalues: l__RunService__1 (copy), u2 (copy)
    if not l__RunService__1:IsServer() then
        if u2:GetAttribute("PlaceContext_IsReady") == true then
            return u2:GetAttribute("PlaceContext_IsPublicServer") == true, u2:GetAttribute("PlaceContext_IsVipServer") == true, u2:GetAttribute("PlaceContext_IsReservedServer") == true;
        end;
        warn("[PlaceContext] Server context attributes are not ready on client. Using public-server fallback.");
        return true, false, false;
    end;
    local l__PrivateServerId__5 = game.PrivateServerId;
    local l__PrivateServerOwnerId__6 = game.PrivateServerOwnerId;
    local v8;
    if l__PrivateServerId__5 == "" then
        v8 = false;
    else
        v8 = l__PrivateServerOwnerId__6 == 0;
    end;
    local v9;
    if l__PrivateServerId__5 == "" then
        v9 = false;
    else
        v9 = l__PrivateServerOwnerId__6 ~= 0;
    end;
    return l__PrivateServerId__5 == "", v9, v8;
end;
local function u24() --[[ Line: 87 ]]
    -- upvalues: u7 (copy), l__CEnum__2 (copy), u10 (copy), u1 (copy), l__RunService__1 (copy)
    u7();
    local l__PlaceId__7 = game.PlaceId;
    local v11 = l__CEnum__2.reverse(l__CEnum__2.PlaceIds, l__PlaceId__7) or "UNKNOWN";
    local v12 = l__PlaceId__7 == l__CEnum__2.PlaceIds.MAIN_PLACE;
    local v13 = l__PlaceId__7 == l__CEnum__2.PlaceIds.FFA_PLACE;
    local v14 = l__PlaceId__7 == l__CEnum__2.PlaceIds.MATCH_PLACE;
    local v15 = l__PlaceId__7 == l__CEnum__2.PlaceIds.MAIN_PLACE;
    local v16, v17, v18 = u10();
    local v19;
    if v14 then
        v19 = u1.EffectiveModes.MATCH;
    elseif v12 and v17 then
        v19 = u1.EffectiveModes.PRIVATE_FFA;
    elseif v13 then
        v19 = u1.EffectiveModes.FFA;
    elseif v15 then
        v19 = u1.EffectiveModes.PUBLIC_LOBBY;
    else
        v19 = u1.EffectiveModes.FFA;
    end;
    if l__RunService__1:IsServer() and v19 == u1.EffectiveModes.PRIVATE_FFA then
        task.spawn(function() --[[ Line: 116 ]]
            game:GetService("StarterPlayer").StarterPlayerScripts:WaitForChild("PlayerModule"):Destroy();
        end);
    end;
    local v20 = v19 == u1.EffectiveModes.FFA and true or v19 == u1.EffectiveModes.PRIVATE_FFA;
    local v21 = v19 == u1.EffectiveModes.MATCH;
    local v22 = v19 == u1.EffectiveModes.PUBLIC_LOBBY;
    local v23 = v19 == u1.EffectiveModes.PRIVATE_FFA and "FFA_PLACE" or (v19 == u1.EffectiveModes.PUBLIC_LOBBY and "MAIN_PLACE" or (v19 == u1.EffectiveModes.MATCH and "MATCH_PLACE" or (v19 == u1.EffectiveModes.FFA and "FFA_PLACE" or v11)));
    return {
        place_id = l__PlaceId__7,
        raw_place_type = v11,
        effective_place_type = v23,
        serverlist_type = v23,
        is_main_place = v12,
        is_ffa_place = v13,
        is_match_place = v14,
        is_matchmaking_place = v15,
        is_public_server = v16,
        is_vip_server = v17,
        is_reserved_server = v18,
        effective_mode = v19,
        is_public_lobby = v22,
        is_ffa_mode = v20,
        is_match_mode = v21,
        is_gameplay_mode = v20 or v21,
        commands_enabled = not v22 or v17,
        should_auto_deploy_lobby_character = v22,
        should_install_player_module_override = v19 == u1.EffectiveModes.PRIVATE_FFA
    };
end;
function u1.get(p25) --[[ Line: 168 ]]
    -- upvalues: u3 (ref), u24 (copy)
    if p25 or not u3 then
        u3 = u24();
    end;
    return u3;
end;
function u1.isReady() --[[ Line: 176 ]]
    -- upvalues: l__RunService__1 (copy), u2 (copy)
    return l__RunService__1:IsServer() or u2:GetAttribute("PlaceContext_IsReady") == true;
end;
function u1.waitUntilReady(p26) --[[ Line: 180 ]]
    -- upvalues: u1 (copy), u2 (copy), u3 (ref), u24 (copy)
    if u1.isReady() then
        return true;
    end;
    local v27 = os.clock() + (p26 or 5);
    local u28 = false;
    local u29 = coroutine.running();
    local u30 = nil;
    u30 = u2:GetAttributeChangedSignal("PlaceContext_IsReady"):Connect(function() --[[ Line: 191 ]]
        -- upvalues: u2 (ref), u28 (ref), u30 (ref), u29 (copy)
        if u2:GetAttribute("PlaceContext_IsReady") == true then
            u28 = true;
            if u30 then
                u30:Disconnect();
                u30 = nil;
            end;
            task.spawn(u29);
        end;
    end);
    local v31 = u30;
    while not u28 and os.clock() < v27 do
        local l__wait__8 = task.wait;
        local v32 = v27 - os.clock();
        local v33 = math.max(v32, 0);
        l__wait__8((math.min(0.05, v33)));
        u28 = u1.isReady();
    end;
    if v31 then
        v31:Disconnect();
    end;
    if u28 then
        u3 = u24();
    end;
    return u28;
end;
function u1.clearCache() --[[ Line: 220 ]]
    -- upvalues: u3 (ref)
    u3 = nil;
end;
function u1.onChanged(u34) --[[ Line: 224 ]]
    -- upvalues: u2 (copy), u3 (ref), u24 (copy)
    return u2:GetAttributeChangedSignal("PlaceContext_IsReady"):Connect(function() --[[ Line: 225 ]]
        -- upvalues: u3 (ref), u24 (ref), u34 (copy)
        u3 = u24();
        u34(u3);
    end);
end;
u7();
return u1;
