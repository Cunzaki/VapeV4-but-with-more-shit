-- Decompiled from: Start.Client.Classes._x75b54504f6fa30d7
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

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
function u1._x83ed94bfb82a8c9f() --[[ Line: 31 ]]
    -- upvalues: u1 (copy)
    return setmetatable({}, u1);
end;
function u1._xab2d5f6427728f13(_, p2) --[[ Line: 37 ]]
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
function u1._x7f3cc288991ed736(_, p4) --[[ Line: 48 ]]
    -- upvalues: l__UIAssets__5 (copy), l__Tips__4 (copy), l__Classes__6 (copy), l__TweenService__1 (copy)
    if p4.kind ~= "countdown" then
        local v5 = l__UIAssets__5.TeleportScreen:Clone();
        v5.Parent = game.Players.LocalPlayer.PlayerGui;
        local v6 = TweenInfo.new(0.2, Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
        l__TweenService__1:Create(v5.BotBlack, v6, {
            Position = UDim2.fromScale(0, 0.5)
        }):Play();
        l__TweenService__1:Create(v5.TopBlack, v6, {
            Position = UDim2.fromScale(0, 0.5)
        }):Play();
        if p4.main_text then
            v5.MainText.Text = p4.main_text;
        end;
        if p4.sub_text then
            v5.SubText.Text = p4.sub_text;
        else
            local v7 = l__Tips__4.getRandomTip();
            v5.SubText.Text = "< TIP: " .. v7 .. " >";
        end;
        l__Classes__6._x6dbba03a0636f7d8:_x282746dbf42c87cb("TELEPORT_DRAMATIC", true);
        game.Debris:AddItem(v5, 30);
        game:GetService("TeleportService"):SetTeleportGui(v5);
        return v5;
    end;
    local v8 = l__UIAssets__5.CountdownScreen:Clone();
    v8.Parent = game.Players.LocalPlayer.PlayerGui;
    if p4.main_text then
        v8.NarrateText.Text = p4.main_text;
    end;
    if p4.sub_text then
        v8.JapNarrative.Text = p4.sub_text;
    else
        l__Tips__4.getRandomTip();
        v8.JapNarrative.Text = "「迷わず」";
    end;
    l__Classes__6._x6dbba03a0636f7d8:_x282746dbf42c87cb("TELEPORT_DRAMATIC", true);
    game.Debris:AddItem(v8, 30);
    game:GetService("TeleportService"):SetTeleportGui(v8);
end;
function u1._x44bcd6af41218f92(u9) --[[ Line: 97 ]]
    -- upvalues: l__Packets__3 (copy)
    l__Packets__3._xec7b9f860192098d.OnClientEvent:Connect(function(p10) --[[ Line: 98 ]]
        -- upvalues: u9 (copy)
        u9:_x7f3cc288991ed736(p10);
    end);
    local v11 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("TeleportScreen");
    if v11 then
        u9:_xab2d5f6427728f13(v11);
    end;
end;
return u1;
