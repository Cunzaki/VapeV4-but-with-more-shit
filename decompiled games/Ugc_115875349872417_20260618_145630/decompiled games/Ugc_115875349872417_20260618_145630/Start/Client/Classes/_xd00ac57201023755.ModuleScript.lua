-- Decompiled from: Start.Client.Classes._xd00ac57201023755
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

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
    LoadoutBrowser = script._xa1667b77aaf323dd,
    Modal = script._xe617a3ca4bb6be01,
    ParryTrainSettings = script._x87601fd06a63378c,
    PlayerBrowser = script._xa691588fa8b5bea6,
    ReportBrowser = script._x213b24fa29fa6c0b
};
local _ = require(script.Parent.Parent.ClientRoot).Classes;
local l__LocalPlayer__7 = l__Players__1.LocalPlayer;
local u3 = TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
local function u7(p4, p5) --[[ Line: 36 ]]
    for v6 = #p4, 1, -1 do
        if p4[v6] == p5 then
            table.remove(p4, v6);
            return true;
        end;
    end;
    return false;
end;
function u1._x90d4581ac99dd483() --[[ Line: 46 ]]
    -- upvalues: u1 (copy), l__UIAssets__6 (copy), l__LocalPlayer__7 (copy)
    local v8 = setmetatable({}, u1);
    v8._x87b0e898befc5558 = l__UIAssets__6.PromptAssets.WidgetScreen:Clone();
    v8._x87b0e898befc5558.Parent = l__LocalPlayer__7.PlayerGui;
    v8._x4eda9443fecd0892 = v8._x87b0e898befc5558:WaitForChild("Darken");
    v8._x4eda9443fecd0892.Visible = false;
    v8._x4eda9443fecd0892.Active = false;
    v8._x4eda9443fecd0892.BackgroundTransparency = 1;
    v8._x5706f358225e50c1 = {};
    v8._x1a0497b2a06b8e4c = {};
    v8._x1be0f353674fa8d9 = 0;
    v8._x4730713b263a1c86 = nil;
    return v8;
end;
function u1._x6ecba90ce92139c1(p9, p10) --[[ Line: 65 ]]
    -- upvalues: l__TweenService__2 (copy), u3 (copy)
    if p9._x4730713b263a1c86 then
        p9._x4730713b263a1c86:Cancel();
        p9._x4730713b263a1c86 = nil;
    end;
    p9._x4730713b263a1c86 = l__TweenService__2:Create(p9._x4eda9443fecd0892, u3, {
        BackgroundTransparency = p10
    });
    p9._x4730713b263a1c86:Play();
end;
function u1._xf791a701e690d848(u11) --[[ Line: 80 ]]
    -- upvalues: u3 (copy)
    local v12 = #u11._x5706f358225e50c1 > 0;
    u11._x4eda9443fecd0892.Active = v12;
    if v12 then
        if not u11._x4eda9443fecd0892.Visible then
            u11._x4eda9443fecd0892.Visible = true;
            u11._x4eda9443fecd0892.BackgroundTransparency = 1;
        end;
        u11:_x6ecba90ce92139c1(0.66);
    else
        u11:_x6ecba90ce92139c1(1);
        task.delay(u3.Time, function() --[[ Line: 93 ]]
            -- upvalues: u11 (copy)
            if #u11._x5706f358225e50c1 == 0 then
                u11._x4eda9443fecd0892.Visible = false;
            end;
        end;
    end;
end;
function u1._x2922e2f540d250bc(_, p13, u14) --[[ Line: 101 ]]
    local function u18(p15, p16) --[[ Line: 102 ]]
        -- upvalues: u14 (copy), u18 (copy)
        if p15:IsA("GuiObject") then
            p15.ZIndex = u14 + p16;
        end;
        for _, v17 in ipairs(p15:GetChildren()) do
            if typeof(v17) == "GuiObject" then
                u18(v17, p16 + v17.ZIndex);
            end;
        end;
    end;
    u18(p13, 0);
end;
function u1._x0d48acb3f3dd6405(p19, p20) --[[ Line: 115 ]]
    p19._x1be0f353674fa8d9 = p19._x1be0f353674fa8d9 + 1;
    p19:_x2922e2f540d250bc(p20, 10 + p19._x1be0f353674fa8d9 * 20);
    p19._x4eda9443fecd0892.ZIndex = 1;
end;
function u1._xfc1afbbddaa0c81a(_, p21, p22) --[[ Line: 122 ]]
    -- upvalues: l__Packets__4 (copy)
    l__Packets__4._x161153098656f9c2:Fire({
        id = p21,
        meta = p22
    });
end;
function u1._x717b235cf53e7a9e(p23, p24) --[[ Line: 129 ]]
    if p24 then
        for _, v25 in ipairs(p23._x5706f358225e50c1) do
            if v25 == p24 then
                return;
            end;
        end;
        table.insert(p23._x5706f358225e50c1, p24);
        p23:_xf791a701e690d848();
    end;
end;
function u1._xb9ce364823fab333(p26, p27) --[[ Line: 140 ]]
    -- upvalues: u7 (copy)
    if p27 then
        if u7(p26._x5706f358225e50c1, p27) then
            p26:_xf791a701e690d848();
        end;
    end;
end;
function u1._x820a3bab3caea4a3(p28, p29) --[[ Line: 149 ]]
    p28._x1a0497b2a06b8e4c[p29] = nil;
end;
function u1._x4782af5368e4c758(p30, p31, p32) --[[ Line: 153 ]]
    -- upvalues: u2 (copy), l__InternalSymbols__5 (copy)
    local v33 = u2[p31];
    if v33 then
        local v34 = l__InternalSymbols__5.owner("", require(v33))._x90d4581ac99dd483(p30, p32);
        if p32 and p32.prompt_id then
            p30._x1a0497b2a06b8e4c[p32.prompt_id] = v34;
        end;
        return v34;
    end;
    warn("UNKNOWN PROMPT KIND:", p31);
end;
function u1._xe53615d96cf36a6b(u35) --[[ Line: 172 ]]
    -- upvalues: l__Packets__4 (copy), l__InternalSymbols__5 (copy)
    l__Packets__4._x161153098656f9c2.OnClientEvent:Connect(function(p36) --[[ Line: 173 ]]
        -- upvalues: l__InternalSymbols__5 (ref), u35 (copy)
        local l__kind__8 = p36.kind;
        if l__kind__8 == "Close" then
            local v37 = l__InternalSymbols__5.owner("", u35._x1a0497b2a06b8e4c[p36.prompt_id]);
            if v37 then
                v37:close();
            end;
        else
            u35:_x4782af5368e4c758(l__kind__8, p36.params);
        end;
    end;
end;
return u1;
