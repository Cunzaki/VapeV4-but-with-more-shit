-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = next;
local u2 = type;
local u3 = typeof;
local l__sqrt__1 = math.sqrt;
local l__Dot__2 = Vector3.new().Dot;
local l__obtain__3 = _G.obtain;
local l__GetContext__4 = l__obtain__3("ContextManager").GetContext;
local v4 = l__obtain__3("PlayerManager");
local l__Players__5 = v4.Players;
local l__LocalPlayer__6 = v4.LocalPlayer;
local v5 = l__obtain__3("CharacterManager");
local l__CharacterInfos__7 = v5.CharacterInfos;
local v6 = l__obtain__3("EquipmentManager");
local v7 = l__obtain__3("BotManager");
local l__Bots__8 = v7.Bots;
local l__Call__9 = l__obtain__3("Remote").Call;
local u8 = 4;
local u9 = 0.25;
local u10 = {};
local u11 = false;
local function u20(p12, p13) --[[ Line: 43 ]]
    -- upvalues: l__CharacterInfos__7 (copy), u1 (copy)
    local v14 = l__CharacterInfos__7[p12];
    if v14 then
        for v15, v16 in u1, v14.TransparencyInfo do
            v15.Transparency = 1 - (1 - v16) * (1 - p13);
        end;
        local v17 = p13 ~= 1;
        for v18, v19 in u1, v14.EnabledInfo do
            v18.Enabled = v19 and v17;
        end;
    end;
end;
local u21 = {};
local u22 = {};
local function u44(p23, p24, p25, p26) --[[ Line: 62 ]]
    -- upvalues: u21 (copy), u22 (copy), u10 (copy), l__CharacterInfos__7 (copy), u1 (copy), u2 (copy), l__Call__9 (copy), u3 (copy)
    local v27 = u21[p23];
    if not v27 then
        v27 = {};
        u21[p23] = v27;
    end;
    v27[p24] = p25;
    local v28 = u22[p23];
    if not v28 then
        v28 = {};
        u22[p23] = v28;
    end;
    v28[p24] = p26;
    if p25 then
        if u10[p23] ~= true then
            local v29 = l__CharacterInfos__7[p23];
            if v29 then
                for v30, v31 in u1, v29.TransparencyInfo do
                    v30.Transparency = 1 - (1 - v31) * 0;
                end;
                for v32, v33 in u1, v29.EnabledInfo do
                    v32.Enabled = v33 and false;
                end;
            end;
            u10[p23] = true;
        end;
    else
        local v34 = true;
        for _, v35 in v27 do
            if v35 then
                v34 = false;
                break;
            end;
        end;
        if v34 then
            local v36 = l__CharacterInfos__7[p23];
            if v36 then
                for v37, v38 in u1, v36.TransparencyInfo do
                    v37.Transparency = 1 - (1 - v38) * 1;
                end;
                for v39, v40 in u1, v36.EnabledInfo do
                    v39.Enabled = v40 and true;
                end;
            end;
            if u2(p23) == "table" then
                l__Call__9("SetReplicate", p23.Id, true);
            elseif u3(p23) == "Instance" then
                l__Call__9("SetReplicate", p23, true);
            end;
            u10[p23] = false;
            return;
        end;
    end;
    local v41 = true;
    for _, v42 in u1, v28 do
        if v42 then
            v41 = false;
            break;
        end;
    end;
    local v43 = not v41;
    if u2(p23) == "table" then
        l__Call__9("SetReplicate", p23.Id, v43);
    else
        if u3(p23) == "Instance" then
            l__Call__9("SetReplicate", p23, v43);
        end;
    end;
end;
v6.EquipmentChanged:Add(function(p45) --[[ Line: 105 ]]
    -- upvalues: u20 (copy), u10 (copy)
    u20(p45, u10[p45] and 1 or 0);
end);
local function v49(p46) --[[ Line: 109 ]]
    -- upvalues: u11 (ref), l__Players__5 (copy), l__LocalPlayer__6 (copy), u44 (copy), l__Bots__8 (copy)
    u11 = p46;
    for v47 = 1, #l__Players__5 do
        if l__Players__5[v47] ~= l__LocalPlayer__6 then
            u44(l__Players__5[v47], "User", p46);
        end;
    end;
    for v48 = 1, #l__Bots__8 do
        u44(l__Bots__8[v48], "User", p46);
    end;
end;
local function v51(p50) --[[ Line: 122 ]]
    -- upvalues: u8 (ref)
    u8 = p50;
end;
local function v53(p52) --[[ Line: 126 ]]
    -- upvalues: u9 (ref)
    u9 = p52;
end;
v5.CharacterAdded:Add(function(p54, _) --[[ Line: 130 ]]
    -- upvalues: l__LocalPlayer__6 (copy), u44 (copy), u11 (ref)
    if p54 == l__LocalPlayer__6 then
        u44(p54, "User", true);
    else
        u44(p54, "User", u11);
    end;
end);
v4.PlayerRemoving:Add(function(p55) --[[ Line: 138 ]]
    -- upvalues: u21 (copy), u22 (copy)
    u21[p55] = nil;
    u22[p55] = nil;
end);
v7.BotRemoving:Add(function(p56) --[[ Line: 143 ]]
    -- upvalues: u21 (copy), u22 (copy)
    u21[p56] = nil;
    u22[p56] = nil;
end);
local function u83(p57, p58, p59) --[[ Line: 148 ]]
    -- upvalues: u10 (copy), l__GetContext__4 (copy), u9 (ref), l__Dot__2 (copy), l__sqrt__1 (copy), u8 (ref), l__CharacterInfos__7 (copy), u1 (copy), u20 (copy)
    if not u10[p57] then
        local v60 = l__GetContext__4(p57);
        if v60 and v60.Context then
            local v61, v62 = v60.Context:GetPVScaled();
            if v61 and v62 then
                local v63 = v61 - p58;
                local v64 = u9 * (p59 - v62);
                local v65 = l__Dot__2(v63, v63);
                local v66 = l__Dot__2(v64, v64);
                local v67 = l__sqrt__1(v65);
                local v68 = u8;
                if v65 > 0 and v66 > 0 then
                    local v69 = l__sqrt__1(v66);
                    local v70 = l__Dot__2(v63, v64) / (v67 * v69);
                    local v71 = u8 + v69;
                    v68 = v69 * v70 + l__sqrt__1(v71 * v71 + v66 * (v70 * v70 - 1));
                end;
                local v72 = v67 / v68;
                if v72 < 1 then
                    local v73 = l__CharacterInfos__7[p57];
                    if v73 then
                        for v74, v75 in u1, v73.TransparencyInfo do
                            v74.Transparency = 1 - (1 - v75) * 0.010000000000000009;
                        end;
                        for v76, v77 in u1, v73.EnabledInfo do
                            v76.Enabled = v77 and true;
                        end;
                    end;
                else
                    if v72 < 2 then
                        u20(p57, (2 - v72) * 0.99);
                        return;
                    end;
                    local v78 = l__CharacterInfos__7[p57];
                    if v78 then
                        for v79, v80 in u1, v78.TransparencyInfo do
                            v79.Transparency = 1 - (1 - v80) * 1;
                        end;
                        for v81, v82 in u1, v78.EnabledInfo do
                            v81.Enabled = v82 and true;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
return {
    GetHiding = function(p84) --[[ Name: GetHiding, Line 56 ]]
        -- upvalues: u10 (copy)
        return u10[p84];
    end,
    SetHiding = u44,
    SetHidingAll = v49,
    UpdateView = function(p85, p86) --[[ Name: UpdateView, Line 178 ]]
        -- upvalues: u8 (ref), l__Bots__8 (copy), u83 (copy), l__Players__5 (copy)
        if u8 and p86 then
            local v87, v88 = p86.Context:GetPVScaled();
            if v87 and v88 then
                for v89 = 1, #l__Bots__8 do
                    if l__Bots__8[v89] ~= p85 then
                        u83(l__Bots__8[v89], v87, v88);
                    end;
                end;
                for v90 = 1, #l__Players__5 do
                    if l__Players__5[v90] ~= p85 then
                        u83(l__Players__5[v90], v87, v88);
                    end;
                end;
            end;
        end;
    end,
    UpdateViewPlayer = function(p91, p92) --[[ Name: UpdateViewPlayer, Line 198 ]]
        -- upvalues: u8 (ref), u83 (copy)
        if u8 and p92 then
            local v93, v94 = p92.Context:GetPVScaled();
            if v93 and v94 then
                u83(p91, v93, v94);
            end;
        end;
    end,
    SetHideDistance = v51,
    SetSpeedCoeff = v53,
    GetHideDistance = function() --[[ Name: GetHideDistance, Line 209 ]]
        -- upvalues: u8 (ref)
        return u8;
    end,
    GetSpeedCoeff = function() --[[ Name: GetSpeedCoeff, Line 209 ]]
        -- upvalues: u9 (ref)
        return u9;
    end,
    PlayersVisible = function() --[[ Name: PlayersVisible, Line 209 ]]
        -- upvalues: u11 (ref)
        return not u11;
    end
};
