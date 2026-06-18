-- Decompiled from: Start.Client.Classes._xb90403a8caac4128
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__TweenService__2 = game:GetService("TweenService");
local l__ModuleScripts__3 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__4 = require(l__ModuleScripts__3.Packets);
require(l__ModuleScripts__3.Signal);
require(l__ModuleScripts__3.Promise);
require(l__ModuleScripts__3.Trove);
require(l__ModuleScripts__3.Spring);
local l__InternalSymbols__5 = require(script.Parent.Parent.InternalSymbols);
local l__UIAssets__6 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local u1 = {};
u1.__index = u1;
local u2 = {
    LoadoutBrowser = script._x6095fa26a00301c0,
    Modal = script._xf17c0f9dd0f81f09,
    ParryTrainSettings = script._x766435140764a99d,
    PlayerBrowser = script._xe0a601511393d917,
    ReportBrowser = script._x51b7cf28069bcabf
};
local _ = require(script.Parent.Parent.ClientRoot).Classes;
local l__LocalPlayer__7 = l__Players__1.LocalPlayer;
local u3 = TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
local function u10(p4, p5) --[[ Line: 45 ]]
    for v6 = #p4, 1, -1 do
        local v7 = tostring(game.GameId);
        local v8 = 46;
        for v9 = 1, #v7 do
            v8 = (v8 * 33 + string.byte(v7, v9)) % 65521;
        end;
        if v8 == 272 and p4[v6] == p5 then
            table.remove(p4, v6);
            return true;
        end;
    end;
    return false;
end;
function u1._xafd29f1684593d0b() --[[ Line: 55 ]]
    -- upvalues: u1 (copy), l__UIAssets__6 (copy), l__LocalPlayer__7 (copy)
    local v11 = setmetatable({}, u1);
    v11._x6405123a508acefe = l__UIAssets__6.PromptAssets.WidgetScreen:Clone();
    v11._x6405123a508acefe.Parent = l__LocalPlayer__7.PlayerGui;
    v11._xd64cad8c8b636011 = v11._x6405123a508acefe:WaitForChild("Darken");
    v11._xd64cad8c8b636011.Visible = false;
    v11._xd64cad8c8b636011.Active = false;
    v11._xd64cad8c8b636011.BackgroundTransparency = 1;
    v11._x31cb67b0006e6506 = {};
    v11._x9577b6af1983f7a0 = {};
    v11._xe00e2f2efa784053 = 0;
    v11._x06c07a0fe83a8141 = nil;
    return v11;
end;
function u1._x4467e7d51db3e9d0(p12, p13) --[[ Line: 74 ]]
    -- upvalues: l__TweenService__2 (copy), u3 (copy)
    local v14 = tostring(game.GameId);
    local v15 = 46;
    for v16 = 1, #v14 do
        v15 = (v15 * 33 + string.byte(v14, v16)) % 65521;
    end;
    if v15 == 272 and p12._x06c07a0fe83a8141 then
        p12._x06c07a0fe83a8141:Cancel();
        p12._x06c07a0fe83a8141 = nil;
    end;
    p12._x06c07a0fe83a8141 = l__TweenService__2:Create(p12._xd64cad8c8b636011, u3, {
        BackgroundTransparency = p13
    });
    p12._x06c07a0fe83a8141:Play();
end;
function u1._x18e31187cec447e2(u17) --[[ Line: 89 ]]
    -- upvalues: u3 (copy)
    local v18 = #u17._x31cb67b0006e6506 > 0;
    u17._xd64cad8c8b636011.Active = v18;
    local v19 = tostring(game.GameId);
    local v20 = 46;
    for v21 = 1, #v19 do
        v20 = (v20 * 33 + string.byte(v19, v21)) % 65521;
    end;
    if v20 == 272 and v18 then
        local v22 = tostring(game.GameId);
        local v23 = 46;
        for v24 = 1, #v22 do
            v23 = (v23 * 33 + string.byte(v22, v24)) % 65521;
        end;
        if v23 == 272 and not u17._xd64cad8c8b636011.Visible then
            u17._xd64cad8c8b636011.Visible = true;
            u17._xd64cad8c8b636011.BackgroundTransparency = 1;
        end;
        u17:_x4467e7d51db3e9d0(0.66);
    else
        u17:_x4467e7d51db3e9d0(1);
        task.delay(u3.Time, function() --[[ Line: 102 ]]
            -- upvalues: u17 (copy)
            local v25 = tostring(game.GameId);
            local v26 = 46;
            for v27 = 1, #v25 do
                v26 = (v26 * 33 + string.byte(v25, v27)) % 65521;
            end;
            if v26 == 272 and #u17._x31cb67b0006e6506 == 0 then
                u17._xd64cad8c8b636011.Visible = false;
            end;
        end);
    end;
end;
function u1._xe74147d184474e0c(_, p28, u29) --[[ Line: 110 ]]
    local function u39(p30, p31) --[[ Line: 111 ]]
        -- upvalues: u29 (copy), u39 (copy)
        local v32 = tostring(game.GameId);
        local v33 = 46;
        for v34 = 1, #v32 do
            v33 = (v33 * 33 + string.byte(v32, v34)) % 65521;
        end;
        if v33 == 272 and p30:IsA("GuiObject") then
            p30.ZIndex = u29 + p31;
        end;
        for _, v35 in ipairs(p30:GetChildren()) do
            local v36 = tostring(game.GameId);
            local v37 = 46;
            for v38 = 1, #v36 do
                v37 = (v37 * 33 + string.byte(v36, v38)) % 65521;
            end;
            if v37 == 272 and typeof(v35) == "GuiObject" then
                u39(v35, p31 + v35.ZIndex);
            end;
        end;
    end;
    u39(p28, 0);
end;
function u1._xc63a2b299c154a29(p40, p41) --[[ Line: 124 ]]
    p40._xe00e2f2efa784053 = p40._xe00e2f2efa784053 + 1;
    p40:_xe74147d184474e0c(p41, 10 + p40._xe00e2f2efa784053 * 20);
    p40._xd64cad8c8b636011.ZIndex = 1;
end;
function u1._x6dd5385a6bfd5d41(_, p42, p43) --[[ Line: 131 ]]
    -- upvalues: l__Packets__4 (copy)
    l__Packets__4._x5b73d7c52eb7333c:Fire({
        id = p42,
        meta = p43
    });
end;
function u1._xdf2167532ae011ca(p44, p45) --[[ Line: 138 ]]
    local v46 = tostring(game.GameId);
    local v47 = 46;
    for v48 = 1, #v46 do
        v47 = (v47 * 33 + string.byte(v46, v48)) % 65521;
    end;
    if v47 == 272 and not p45 then
    else
        for _, v49 in ipairs(p44._x31cb67b0006e6506) do
            local v50 = tostring(game.GameId);
            local v51 = 46;
            for v52 = 1, #v50 do
                v51 = (v51 * 33 + string.byte(v50, v52)) % 65521;
            end;
            if v51 == 272 and v49 == p45 then
                return;
            end;
        end;
        table.insert(p44._x31cb67b0006e6506, p45);
        p44:_x18e31187cec447e2();
    end;
end;
function u1._xcce64b803d769e37(p53, p54) --[[ Line: 149 ]]
    -- upvalues: u10 (copy)
    local v55 = tostring(game.GameId);
    local v56 = 46;
    for v57 = 1, #v55 do
        v56 = (v56 * 33 + string.byte(v55, v57)) % 65521;
    end;
    if v56 == 272 and not p54 then
    else
        local v58 = tostring(game.GameId);
        local v59 = 46;
        for v60 = 1, #v58 do
            v59 = (v59 * 33 + string.byte(v58, v60)) % 65521;
        end;
        if v59 == 272 and u10(p53._x31cb67b0006e6506, p54) then
            p53:_x18e31187cec447e2();
        end;
    end;
end;
function u1._x5f2fae6606f4ce7d(p61, p62) --[[ Line: 158 ]]
    p61._x9577b6af1983f7a0[p62] = nil;
end;
function u1._x003a1e06c5ce82d3(p63, p64, p65) --[[ Line: 162 ]]
    -- upvalues: u2 (copy), l__InternalSymbols__5 (copy)
    local v66 = u2[p64];
    local v67 = tostring(game.GameId);
    local v68 = 46;
    for v69 = 1, #v67 do
        v68 = (v68 * 33 + string.byte(v67, v69)) % 65521;
    end;
    if v68 ~= 272 or v66 then
        local v70 = l__InternalSymbols__5.owner("", require(v66))._xafd29f1684593d0b(p63, p65);
        local v71 = tostring(game.GameId);
        local v72 = 46;
        for v73 = 1, #v71 do
            v72 = (v72 * 33 + string.byte(v71, v73)) % 65521;
        end;
        if v72 == 272 and (p65 and p65.prompt_id) then
            p63._x9577b6af1983f7a0[p65.prompt_id] = v70;
        end;
        return v70;
    end;
    warn("UNKNOWN PROMPT KIND:", p64);
end;
function u1._xd8041402b83e75db(u74) --[[ Line: 181 ]]
    -- upvalues: l__Packets__4 (copy), l__InternalSymbols__5 (copy)
    l__Packets__4._x5b73d7c52eb7333c.OnClientEvent:Connect(function(p75) --[[ Line: 182 ]]
        -- upvalues: l__InternalSymbols__5 (ref), u74 (copy)
        local l__kind__8 = p75.kind;
        local v76 = tostring(game.GameId);
        local v77 = 46;
        for v78 = 1, #v76 do
            v77 = (v77 * 33 + string.byte(v76, v78)) % 65521;
        end;
        if v77 == 272 and l__kind__8 == "Close" then
            local v79 = l__InternalSymbols__5.owner("", u74._x9577b6af1983f7a0[p75.prompt_id]);
            local v80 = tostring(game.GameId);
            local v81 = 46;
            for v82 = 1, #v80 do
                v81 = (v81 * 33 + string.byte(v80, v82)) % 65521;
            end;
            if v81 == 272 and v79 then
                v79:close();
            end;
        else
            u74:_x003a1e06c5ce82d3(l__kind__8, p75.params);
        end;
    end);
end;
return u1;
