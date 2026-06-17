-- Decompiled from: Start.Client.Classes._xe4b708070c7cd741
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__TweenService__2 = game:GetService("TweenService");
local l__ModuleScripts__3 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__4 = require(l__ModuleScripts__3.Packets);
require(l__ModuleScripts__3.Signal);
require(l__ModuleScripts__3.Promise);
require(l__ModuleScripts__3.Trove);
require(l__ModuleScripts__3.Spring);
local l___x7749231778538ccb__5 = require(script.Parent.Parent._x7749231778538ccb);
local l__UIAssets__6 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local u1 = {};
u1.__index = u1;
local u2 = {
    LoadoutBrowser = script._x98bb27760047b864,
    Modal = script._x5c94a319ed7835fe,
    ParryTrainSettings = script._x51772e11ec12ccf6,
    PlayerBrowser = script._x1b34480841a38904,
    ReportBrowser = script._x7ac6e4da6ce2ef8a
};
local _ = require(script.Parent.Parent.ClientRoot).Classes;
local l__LocalPlayer__7 = l__Players__1.LocalPlayer;
local u3 = TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
local function u7(p4, p5) --[[ Line: 45 ]]
    for v6 = #p4, 1, -1 do
        if p4[v6] == p5 then
            table.remove(p4, v6);
            return true;
        end;
    end;
    return false;
end;
function u1._x83ed94bfb82a8c9f() --[[ Line: 55 ]]
    -- upvalues: u1 (copy), l__UIAssets__6 (copy), l__LocalPlayer__7 (copy)
    local v8 = setmetatable({}, u1);
    v8._xdeee7f9fbd8052c6 = l__UIAssets__6.PromptAssets.WidgetScreen:Clone();
    v8._xdeee7f9fbd8052c6.Parent = l__LocalPlayer__7.PlayerGui;
    v8._xd3ed6ca56f415cd4 = v8._xdeee7f9fbd8052c6:WaitForChild("Darken");
    v8._xd3ed6ca56f415cd4.Visible = false;
    v8._xd3ed6ca56f415cd4.Active = false;
    v8._xd3ed6ca56f415cd4.BackgroundTransparency = 1;
    v8._x78b57187de62bd29 = {};
    v8._x3e71c466ec301cd7 = {};
    v8._x5636cc357221b0b6 = 0;
    v8._x125663dfd6a65e29 = nil;
    return v8;
end;
function u1._x7e2036e48899914c(p9, p10) --[[ Line: 74 ]]
    -- upvalues: l__TweenService__2 (copy), u3 (copy)
    if p9._x125663dfd6a65e29 then
        p9._x125663dfd6a65e29:Cancel();
        p9._x125663dfd6a65e29 = nil;
    end;
    p9._x125663dfd6a65e29 = l__TweenService__2:Create(p9._xd3ed6ca56f415cd4, u3, {
        BackgroundTransparency = p10
    });
    p9._x125663dfd6a65e29:Play();
end;
function u1._xe500001ce0f95588(u11) --[[ Line: 89 ]]
    -- upvalues: u3 (copy)
    local v12 = #u11._x78b57187de62bd29 > 0;
    u11._xd3ed6ca56f415cd4.Active = v12;
    if v12 then
        if not u11._xd3ed6ca56f415cd4.Visible then
            u11._xd3ed6ca56f415cd4.Visible = true;
            u11._xd3ed6ca56f415cd4.BackgroundTransparency = 1;
        end;
        u11:_x7e2036e48899914c(0.66);
    else
        u11:_x7e2036e48899914c(1);
        task.delay(u3.Time, function() --[[ Line: 102 ]]
            -- upvalues: u11 (copy)
            if #u11._x78b57187de62bd29 == 0 then
                u11._xd3ed6ca56f415cd4.Visible = false;
            end;
        end);
    end;
end;
function u1._xfc241268a8ee7500(_, p13, u14) --[[ Line: 110 ]]
    local function u18(p15, p16) --[[ Line: 111 ]]
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
function u1._x5681d85bb0699cc0(p19, p20) --[[ Line: 124 ]]
    p19._x5636cc357221b0b6 = p19._x5636cc357221b0b6 + 1;
    p19:_xfc241268a8ee7500(p20, 10 + p19._x5636cc357221b0b6 * 20);
    p19._xd3ed6ca56f415cd4.ZIndex = 1;
end;
function u1._xa987be96d40269cb(_, p21, p22) --[[ Line: 131 ]]
    -- upvalues: l__Packets__4 (copy)
    l__Packets__4._x03d52885f4243bb6:Fire({
        id = p21,
        meta = p22
    });
end;
function u1._xef90eabba3eccf70(p23, p24) --[[ Line: 138 ]]
    if p24 then
        for _, v25 in ipairs(p23._x78b57187de62bd29) do
            if v25 == p24 then
                return;
            end;
        end;
        table.insert(p23._x78b57187de62bd29, p24);
        p23:_xe500001ce0f95588();
    end;
end;
function u1._x4242595e874201ec(p26, p27) --[[ Line: 149 ]]
    -- upvalues: u7 (copy)
    if p27 then
        if u7(p26._x78b57187de62bd29, p27) then
            p26:_xe500001ce0f95588();
        end;
    end;
end;
function u1._x30d55b013e9f62e7(p28, p29) --[[ Line: 158 ]]
    p28._x3e71c466ec301cd7[p29] = nil;
end;
function u1._x85ec8b5d5b90212b(p30, p31, p32) --[[ Line: 162 ]]
    -- upvalues: u2 (copy), l___x7749231778538ccb__5 (copy)
    local v33 = u2[p31];
    if v33 then
        local v34 = l___x7749231778538ccb__5._xd644d9e3ba63f27f("", require(v33))._x83ed94bfb82a8c9f(p30, p32);
        if p32 and p32.prompt_id then
            p30._x3e71c466ec301cd7[p32.prompt_id] = v34;
        end;
        return v34;
    end;
    warn("UNKNOWN PROMPT KIND:", p31);
end;
function u1._x44bcd6af41218f92(u35) --[[ Line: 181 ]]
    -- upvalues: l__Packets__4 (copy), l___x7749231778538ccb__5 (copy)
    l__Packets__4._x03d52885f4243bb6.OnClientEvent:Connect(function(p36) --[[ Line: 182 ]]
        -- upvalues: l___x7749231778538ccb__5 (ref), u35 (copy)
        local l__kind__8 = p36.kind;
        if l__kind__8 == "Close" then
            local v37 = l___x7749231778538ccb__5._xd644d9e3ba63f27f("", u35._x3e71c466ec301cd7[p36.prompt_id]);
            if v37 then
                v37:close();
            end;
        else
            u35:_x85ec8b5d5b90212b(l__kind__8, p36.params);
        end;
    end);
end;
return u1;
