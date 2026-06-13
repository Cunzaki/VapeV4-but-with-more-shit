-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.Priority.CoinController
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local _ = l__Players__1.LocalPlayer;
local l__Mince__4 = require(l__ReplicatedStorage__3.Modules.Mince);
local l__Timer__5 = require(l__ReplicatedStorage__3.Modules.Timer);
local l__Numerics__6 = require(l__ReplicatedStorage__3.Modules.Numerics);
local u1 = l__Mince__4:Get("BindManager");
local u2 = l__Mince__4:Get("UserProfile");
local u3 = l__Mince__4:Get("SoundHandler");
local u4 = l__Mince__4:Get("TriggerHandler");
local u5 = l__Mince__4:Get("InterfaceHandler");
function lerp(p6, p7, p8)
    return p6 * (1 - p8) + p7 * p8;
end;
local u9 = {
    ShowForTime = 120,
    __IsAsyncSetup = true,
    CoinSourceNames = { "Coins" },
    CoinSources = {},
    TweenGoUp = TweenInfo.new(1, Enum.EasingStyle.Quad),
    CoinFadeTween = TweenInfo.new(0.2, Enum.EasingStyle.Quint)
};
local u10 = {};
u10.__index = u10;
function u9.newCoinSource(p11) --[[ Line: 36 ]]
    -- upvalues: u10 (copy), u9 (copy)
    local v12 = setmetatable({}, u10);
    v12:Init(p11);
    table.insert(u9.CoinSources, v12);
    return v12;
end;
function u10.Init(u13, p14) --[[ Line: 44 ]]
    -- upvalues: u9 (copy), l__Timer__5 (copy), u2 (copy), l__Numerics__6 (copy), u4 (copy), l__TweenService__2 (copy)
    assert(p14, "Index is required for a \'CoinSource\'");
    u13.GUI = u9.MainPriority:FindFirstChild(p14);
    local l__GUI__7 = u13.GUI;
    local v15 = `Could not find the corresponding GUI for '{p14}'`;
    assert(l__GUI__7, v15);
    u13.Locked = false;
    u13.IsTweening = false;
    u13.Timer = l__Timer__5.new();
    u2.Upon(p14, function(p16) --[[ Line: 53 ]]
        -- upvalues: u13 (copy)
        u13:LoadCoin(p16);
    end);
    u13.Timer.Tick:Connect(function(p17) --[[ Line: 57 ]]
        -- upvalues: u13 (copy), l__Numerics__6 (ref)
        local l__CoinLabel__8 = u13.GUI.Container.CoinLabel;
        local l__WithCommas__9 = l__Numerics__6.WithCommas;
        local v18 = lerp(u13.LastCoin, u13.ThisCoin, p17);
        l__CoinLabel__8.Text = l__WithCommas__9((math.round(v18)));
    end);
    u13:LoadOut();
    u13.Trigger = u4.GetTrigger("Store");
    u13.Trigger.Entered:Connect(function() --[[ Line: 68 ]]
        -- upvalues: u9 (ref), u13 (copy), l__TweenService__2 (ref)
        if u9.ForceLocked then
        else
            u13.Locked = true;
            u13.GUI.GroupTransparency = 1;
            if u13.DelayRoutine and coroutine.status(u13.DelayRoutine) == "suspended" then
                task.cancel(u13.DelayRoutine);
                u13.DelayRoutine = nil;
            end;
            l__TweenService__2:Create(u13.GUI, u9.CoinFadeTween, {
                GroupTransparency = 0
            }):Play();
        end;
    end);
    u13.Trigger.Leaved:Connect(function() --[[ Line: 83 ]]
        -- upvalues: u9 (ref), u13 (copy), l__TweenService__2 (ref)
        if u9.ForceLocked then
        else
            u13.Locked = false;
            l__TweenService__2:Create(u13.GUI, u9.CoinFadeTween, {
                GroupTransparency = 1
            }):Play();
        end;
    end);
end;
function u10.LoadOut(u19) --[[ Line: 93 ]]
    -- upvalues: u9 (copy), l__TweenService__2 (copy)
    if u19.DelayRoutine and coroutine.status(u19.DelayRoutine) == "suspended" then
        task.cancel(u19.DelayRoutine);
        u19.DelayRoutine = nil;
    end;
    if u19.Locked then
    else
        u19.DelayRoutine = task.delay(u9.ShowForTime, function() --[[ Line: 100 ]]
            -- upvalues: l__TweenService__2 (ref), u19 (copy), u9 (ref)
            l__TweenService__2:Create(u19.GUI, u9.CoinFadeTween, {
                GroupTransparency = 1
            }):Play();
            u19.IsTweening = false;
        end);
    end;
end;
function u10.LoadCoin(p20, p21) --[[ Line: 108 ]]
    -- upvalues: u3 (copy), u9 (copy), l__TweenService__2 (copy)
    local v22 = math.floor(p21);
    if p20.LastCoin == v22 then
    else
        if p20.LastCoin and v22 - p20.LastCoin > 1 then
            u3.PlaySound("GainMoney");
        end;
        p20.LastCoin = p20.LastCoin or v22;
        p20.ThisCoin = v22;
        p20.Timer:Tween(u9.TweenGoUp);
        if p20.IsTweening then
            if p20.DelayRoutine and coroutine.status(p20.DelayRoutine) == "suspended" then
                p20.IsTweening = true;
                p20.GUI.GroupTransparency = 0;
                task.cancel(p20.DelayRoutine);
            else
                p20.IsTweening = false;
            end;
        elseif p20.Locked then
            p20.GUI.GroupTransparency = 0;
        else
            p20.IsTweening = true;
            p20.GUI.GroupTransparency = 1;
            l__TweenService__2:Create(p20.GUI, u9.CoinFadeTween, {
                GroupTransparency = 0
            }):Play();
        end;
        p20.GUI.Container.CoinLabel.Text = v22;
        p20:LoadOut();
        p20.LastCoin = v22;
    end;
end;
function u9.ModeChanging(p23) --[[ Line: 153 ]]
    -- upvalues: u9 (copy)
    u9.MainPriority.Coins.Add.Visible = p23 ~= "Mobile";
end;
function u9.SetForceEnabled(p24) --[[ Line: 157 ]]
    -- upvalues: u9 (copy), l__TweenService__2 (copy)
    u9.ForceLocked = p24;
    if p24 then
        for _, v25 in u9.CoinSources do
            v25.GUI.GroupTransparency = 0;
            v25.Locked = true;
        end;
    else
        for _, v26 in u9.CoinSources do
            l__TweenService__2:Create(v26.GUI, u9.CoinFadeTween, {
                GroupTransparency = 1
            }):Play();
            v26.Locked = false;
        end;
    end;
end;
function u9.Setup() --[[ Line: 175 ]]
    -- upvalues: l__Mince__4 (copy), u9 (copy), u5 (copy), u1 (copy)
    if l__Mince__4.Config.HolidayConfigure.EVENT_CURRENCY_ENABLED then
        table.insert(u9.CoinSourceNames, "Holiday");
    end;
    if l__Mince__4.Config.HolidayConfigure.EVENT_KEYS_ENABLED then
        table.insert(u9.CoinSourceNames, "GatchaKeys");
    end;
    u9.MainPriority = u5.GetScreenGui("MainPriority");
    for _, v27 in u9.CoinSourceNames do
        u9.newCoinSource(v27);
    end;
    u1.WhenModeChanges(u9.ModeChanging);
end;
return u9;
