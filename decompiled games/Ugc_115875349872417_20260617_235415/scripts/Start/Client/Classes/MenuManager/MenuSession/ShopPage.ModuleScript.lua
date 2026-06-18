-- Decompiled from: Start.Client.Classes.MenuManager.MenuSession.ShopPage
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Trove__3 = require(l__ModuleScripts__2.Trove);
local l__UIAssets__4 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local u1 = {};
u1.__index = u1;
local l__Classes__5 = require(script.Parent.Parent.Parent.Parent.ClientRoot).Classes;
local l__InternalSymbols__6 = require(script.Parent.Parent.Parent.Parent.InternalSymbols);
local u2 = {
    Deals = {
        button_name = "DealsButton",
        module = script.DealsTab
    },
    Cosmetics = {
        button_name = "CosmeticsButton",
        module = script.CosmeticsTab
    }
};
function u1.new(p3, p4) --[[ Line: 30 ]]
    -- upvalues: u1 (copy), l__InternalSymbols__6 (copy), l__Trove__3 (copy), l__UIAssets__4 (copy), u2 (copy)
    local v5 = setmetatable({}, u1);
    v5.menu_session = l__InternalSymbols__6.owner("MenuSession", p4);
    v5.parent_os = p3;
    v5.trove = l__Trove__3.new();
    v5.page_origin = l__UIAssets__4.Menu.ShopPage;
    v5.main_page = v5.page_origin.ShopFrame:Clone();
    v5.queue_containers = {};
    v5.trove:Add(v5.main_page);
    v5.tabs = {};
    v5.current_tab_name = nil;
    for v6, v7 in u2 do
        local u8 = l__InternalSymbols__6.owner("ShopTabClass", require(v7.module)).new(v5.main_page, v5.menu_session);
        local v9 = v5.main_page:FindFirstChild(v7.button_name, true);
        v5.trove:Add(function() --[[ Line: 51 ]]
            -- upvalues: u8 (copy)
            u8:destroy();
        end);
        v5.tabs[v6] = {
            obj = u8,
            button = v9
        };
    end;
    return v5;
end;
function u1.cleanUp(p10) --[[ Line: 63 ]]
    p10.trove:Clean();
end;
function u1.close(p11) --[[ Line: 67 ]]
    -- upvalues: l__TweenService__1 (copy)
    local l__main_page__7 = p11.main_page;
    l__main_page__7.Interactable = false;
    task.delay(0.2, function() --[[ Line: 71 ]]
        -- upvalues: l__main_page__7 (copy)
        if l__main_page__7 and (l__main_page__7.Parent and l__main_page__7.Interactable == false) then
            l__main_page__7.Visible = false;
        end;
    end);
    l__TweenService__1:Create(l__main_page__7, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 1
    }):Play();
end;
function u1.openTab(p12, p13) --[[ Line: 80 ]]
    -- upvalues: l__TweenService__1 (copy)
    if p12.current_tab_name then
        p12.tabs[p12.current_tab_name].obj:close();
        l__TweenService__1:Create(p12.tabs[p12.current_tab_name].button.SelectedGlow, TweenInfo.new(0.3), {
            BackgroundTransparency = 1
        }):Play();
    end;
    p12.tabs[p13].obj:open();
    p12.current_tab_name = p13;
    l__TweenService__1:Create(p12.tabs[p13].button.SelectedGlow, TweenInfo.new(0.3), {
        BackgroundTransparency = 0
    }):Play();
end;
function u1.start(p14, p15) --[[ Line: 93 ]]
    -- upvalues: l__TweenService__1 (copy)
    local l__main_page__8 = p14.main_page;
    l__main_page__8.Interactable = true;
    l__main_page__8.Visible = true;
    l__main_page__8.Parent = p14.parent_os;
    l__main_page__8.GroupTransparency = 1;
    l__TweenService__1:Create(l__main_page__8, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    }):Play();
    l__main_page__8.Position = UDim2.fromScale(0, -0.1);
    l__TweenService__1:Create(l__main_page__8, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(0, 0)
    }):Play();
    if p15 then
        p14:openTab(p15);
    end;
end;
function u1.Init(u16) --[[ Line: 112 ]]
    -- upvalues: u2 (copy), l__Classes__5 (copy)
    local l__main_page__9 = u16.main_page;
    u16.trove:Connect(l__main_page__9.OutButton.Activated, function() --[[ Line: 115 ]]
        -- upvalues: u16 (copy)
        u16.menu_session:openPage("empty_page");
    end);
    u16:openTab("Cosmetics");
    for u17, _ in u16.tabs do
        local v18 = u2[u17];
        local v19 = l__main_page__9:FindFirstChild(v18.button_name, true);
        if v19 then
            u16.trove:Connect(v19.Activated, function() --[[ Line: 125 ]]
                -- upvalues: l__Classes__5 (ref), u16 (copy), u17 (copy)
                l__Classes__5._x02c5f8f89640473a:_xa2c2f0587694a915("BACK2", true);
                u16:openTab(u17);
            end);
        else
            warn("NO SUCH BUTTON EXISTS AS :", v18.button_name);
        end;
    end;
end;
return u1;
