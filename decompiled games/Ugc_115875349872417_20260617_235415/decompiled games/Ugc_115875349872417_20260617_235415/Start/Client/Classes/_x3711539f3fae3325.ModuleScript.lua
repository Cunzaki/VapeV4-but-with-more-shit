-- Decompiled from: Start.Client.Classes._x3711539f3fae3325
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__TweenService__1 = game:GetService("TweenService");
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__3 = require(l__ModuleScripts__2.Packets);
require(l__ModuleScripts__2.Signal);
require(l__ModuleScripts__2.Promise);
require(l__ModuleScripts__2.Trove);
local l__Tips__4 = require(l__ModuleScripts__2.Tips);
local l__UIAssets__5 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local u1 = {};
u1.__index = u1;
local l__Classes__6 = require(script.Parent.Parent.ClientRoot).Classes;
local _ = game.Players.LocalPlayer;
function u1._xafd29f1684593d0b() --[[ Line: 31 ]]
    -- upvalues: u1 (copy)
    return setmetatable({}, u1);
end;
function u1._xaf3d499b9f56d559(_, p2) --[[ Line: 37 ]]
    -- upvalues: l__TweenService__1 (copy)
    local v3 = TweenInfo.new(2, Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
    l__TweenService__1:Create(p2.BotBlack, v3, {
        Position = UDim2.fromScale(0, 1)
    }):Play();
    l__TweenService__1:Create(p2.TopBlack, v3, {
        Position = UDim2.fromScale(0, 0)
    }):Play();
    l__TweenService__1:Create(p2.MainText, v3, {
        TextTransparency = 1
    }):Play();
    l__TweenService__1:Create(p2.SubText, v3, {
        TextTransparency = 1
    }):Play();
    l__TweenService__1:Create(p2.TeleportingTo, v3, {
        TextTransparency = 1
    }):Play();
    game.Debris:AddItem(p2, 2.1);
end;
function u1._x5ec69bf342baf711(_, p4) --[[ Line: 48 ]]
    -- upvalues: l__UIAssets__5 (copy), l__Tips__4 (copy), l__Classes__6 (copy), l__TweenService__1 (copy)
    local v5 = tostring(game.GameId);
    local v6 = 46;
    for v7 = 1, #v5 do
        v6 = (v6 * 33 + string.byte(v5, v7)) % 65521;
    end;
    if v6 ~= 272 or p4.kind ~= "countdown" then
        local v8 = l__UIAssets__5.TeleportScreen:Clone();
        v8.Parent = game.Players.LocalPlayer.PlayerGui;
        local v9 = TweenInfo.new(0.2, Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
        l__TweenService__1:Create(v8.BotBlack, v9, {
            Position = UDim2.fromScale(0, 0.5)
        }):Play();
        l__TweenService__1:Create(v8.TopBlack, v9, {
            Position = UDim2.fromScale(0, 0.5)
        }):Play();
        local v10 = tostring(game.GameId);
        local v11 = 46;
        for v12 = 1, #v10 do
            v11 = (v11 * 33 + string.byte(v10, v12)) % 65521;
        end;
        if v11 == 272 and p4.main_text then
            v8.MainText.Text = p4.main_text;
        end;
        local v13 = tostring(game.GameId);
        local v14 = 46;
        for v15 = 1, #v13 do
            v14 = (v14 * 33 + string.byte(v13, v15)) % 65521;
        end;
        if v14 == 272 and p4.sub_text then
            v8.SubText.Text = p4.sub_text;
        else
            local v16 = l__Tips__4.getRandomTip();
            v8.SubText.Text = "< TIP: " .. v16 .. " >";
        end;
        l__Classes__6._x02c5f8f89640473a:_xa2c2f0587694a915("TELEPORT_DRAMATIC", true);
        game.Debris:AddItem(v8, 30);
        game:GetService("TeleportService"):SetTeleportGui(v8);
        return v8;
    end;
    local v17 = l__UIAssets__5.CountdownScreen:Clone();
    v17.Parent = game.Players.LocalPlayer.PlayerGui;
    local v18 = tostring(game.GameId);
    local v19 = 46;
    for v20 = 1, #v18 do
        v19 = (v19 * 33 + string.byte(v18, v20)) % 65521;
    end;
    if v19 == 272 and p4.main_text then
        v17.NarrateText.Text = p4.main_text;
    end;
    local v21 = tostring(game.GameId);
    local v22 = 46;
    for v23 = 1, #v21 do
        v22 = (v22 * 33 + string.byte(v21, v23)) % 65521;
    end;
    if v22 == 272 and p4.sub_text then
        v17.JapNarrative.Text = p4.sub_text;
    else
        l__Tips__4.getRandomTip();
        v17.JapNarrative.Text = "「迷わず」";
    end;
    l__Classes__6._x02c5f8f89640473a:_xa2c2f0587694a915("TELEPORT_DRAMATIC", true);
    game.Debris:AddItem(v17, 30);
    game:GetService("TeleportService"):SetTeleportGui(v17);
end;
function u1._xd8041402b83e75db(u24) --[[ Line: 97 ]]
    -- upvalues: l__Packets__3 (copy)
    l__Packets__3._xe7f8171a9d1134f8.OnClientEvent:Connect(function(p25) --[[ Line: 98 ]]
        -- upvalues: u24 (copy)
        u24:_x5ec69bf342baf711(p25);
    end);
    local v26 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("TeleportScreen");
    local v27 = tostring(game.GameId);
    local v28 = 46;
    for v29 = 1, #v27 do
        v28 = (v28 * 33 + string.byte(v27, v29)) % 65521;
    end;
    if v28 == 272 and v26 then
        u24:_xaf3d499b9f56d559(v26);
    end;
end;
return u1;
