-- Decompiled from: Start.Client.Classes.MenuManager.MenuSession.ProfilePage
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__TweenService__1 = game:GetService("TweenService");
game:GetService("UserInputService");
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__3 = require(l__ModuleScripts__2.Packets);
require(l__ModuleScripts__2.Signal);
require(l__ModuleScripts__2.Promise);
local l__Trove__4 = require(l__ModuleScripts__2.Trove);
require(l__ModuleScripts__2.Spring);
local l__CEnum__5 = require(l__ModuleScripts__2.CEnum);
local l__TitleData__6 = require(l__ModuleScripts__2.TitleData);
local l__LevelService__7 = require(l__ModuleScripts__2.LevelService);
local l__UIAssets__8 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local u1 = {};
u1.__index = u1;
local l__DropdownMenu__9 = require(script.Parent.Parent.Components.DropdownMenu);
local l__Classes__10 = require(script.Parent.Parent.Parent.Parent.ClientRoot).Classes;
local l___x7749231778538ccb__11 = require(script.Parent.Parent.Parent.Parent._x7749231778538ccb);
local _ = game.Players.LocalPlayer;
function u1.new(p2, p3) --[[ Line: 30 ]]
    -- upvalues: u1 (copy), l___x7749231778538ccb__11 (copy), l__UIAssets__8 (copy), l__DropdownMenu__9 (copy), l__Trove__4 (copy)
    local v4 = setmetatable({}, u1);
    v4.menu_session = l___x7749231778538ccb__11._xd644d9e3ba63f27f("MenuSession", p3);
    v4.parent_os = p2;
    v4.page_origin = l__UIAssets__8.Menu.ProfilePage;
    v4.main_page = v4.page_origin.ProfileFrame:Clone();
    v4.my_data = nil;
    v4.data_in_view = nil;
    v4.dropdown_component = l__DropdownMenu__9.new(v4.main_page.Borders.ViewingCanvas.IdentityContainer.InfoBox.TitlePlate.ChangeTitleButton, v4.parent_os.FloatLayer, v4.main_page.Borders.ViewingCanvas.IdentityContainer.InfoBox.TitlePlate.Target, {
        can_search = true,
        main_text = "Search Title ..."
    });
    v4.trove = l__Trove__4.new();
    v4.customizable = false;
    return v4;
end;
function u1.cleanUp(p5) --[[ Line: 58 ]]
    local l__dropdown_component__12 = p5.dropdown_component;
    if l__dropdown_component__12 then
        l__dropdown_component__12:Destroy();
    end;
end;
function u1.close(p6) --[[ Line: 66 ]]
    -- upvalues: l__TweenService__1 (copy)
    local l__main_page__13 = p6.main_page;
    l__main_page__13.Parent = p6.parent_os.RightContainer.MainOS;
    l__main_page__13.Interactable = false;
    l__TweenService__1:Create(l__main_page__13, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 1
    }):Play();
    l__TweenService__1:Create(l__main_page__13, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
        Position = UDim2.fromScale(0, 1)
    }):Play();
end;
function u1.setupView(p7, p8, p9) --[[ Line: 75 ]]
    -- upvalues: l__Classes__10 (copy), l__TitleData__6 (copy), l__CEnum__5 (copy), l__LevelService__7 (copy)
    local l__ViewingCanvas__14 = p7.main_page.Borders.ViewingCanvas;
    p7.data_in_view = p8;
    p7.customizable = true;
    local l__dropdown_component__15 = p7.dropdown_component;
    local l__userid__16 = p8.userid;
    if l__userid__16 then
        l__userid__16 = tonumber(p8.userid);
    end;
    local function u11() --[[ Line: 86 ]]
        -- upvalues: l__userid__16 (copy), l__Classes__10 (ref)
        if not l__userid__16 then
            return "rbxassetid://18973637794";
        end;
        local v10 = l__Classes__10.Util:getPublicDataOfUserId(l__userid__16, "player_icon");
        if v10 then
            return v10;
        end;
        local l__HeadShot__17 = Enum.ThumbnailType.HeadShot;
        local l__Size420x420__18 = Enum.ThumbnailSize.Size420x420;
        return game:GetService("Players"):GetUserThumbnailAsync(l__userid__16, l__HeadShot__17, l__Size420x420__18) or "rbxassetid://18973637794";
    end;
    task.defer(function() --[[ Line: 107 ]]
        -- upvalues: l__ViewingCanvas__14 (copy), u11 (copy)
        pcall(function() --[[ Line: 108 ]]
            -- upvalues: l__ViewingCanvas__14 (ref), u11 (ref)
            l__ViewingCanvas__14.IdentityContainer.PlayerPortrait.PlayerPortrait.Image = u11();
        end);
    end);
    l__dropdown_component__15:clearOptions();
    local v12 = l__TitleData__6.getTitleData();
    local v13 = p8.owned_titles or {};
    for u14, v15 in v12 do
        local v16 = v13[tostring(u14)];
        if v15.hidden ~= true or v16 then
            local v18 = {
                relative_order = u14,
                text = v15.getText(),
                tooltip = v15.tooltip,
                preRender = function(p17) --[[ Line: 129 ]]
                    -- upvalues: l__TitleData__6 (ref), u14 (copy)
                    if p17:IsA("TextLabel") then
                        l__TitleData__6.renderFromLabel(p17, u14);
                    end;
                end
            };
            if v16 then
                if p9 and v16.seen == false then
                    v18.appear_new = true;
                end;
            elseif v15.show_when_unowned then
                v18.appear_locked = true;
            else
                v18.appear_classified = true;
            end;
            if p9 and v16 then
                v18.meta = {
                    title_cenum = u14
                };
            end;
            l__dropdown_component__15:addOption(v18);
        end;
    end;
    l__ViewingCanvas__14.IdentityContainer.InfoBox.NamePlate.NameLabel.Text = p8.name;
    l__TitleData__6.renderFromLabel(l__ViewingCanvas__14.IdentityContainer.InfoBox.TitlePlate.Title, p8.equipped_titles[1] or l__CEnum__5.Titles.Rookie);
    local v19 = "¥" .. (l__Classes__10.Util:formatNumber(p8.total_earnings) or "0");
    l__ViewingCanvas__14.IdentityContainer.InfoBox.ValuePlate.Value.Text = v19;
    local v20 = tonumber(p8.total_xp);
    if v20 then
        local v21 = {
            [l__CEnum__5.Titles.Rookie] = 0,
            [l__CEnum__5.Titles.Prospect] = 5,
            [l__CEnum__5.Titles.Freelancer] = 10,
            [l__CEnum__5.Titles.Professional] = 25,
            [l__CEnum__5.Titles.Elite] = 50,
            [l__CEnum__5.Titles.Menace] = 75,
            [l__CEnum__5.Titles.Eminence] = 90,
            [l__CEnum__5.Titles.FLATLINER] = 100
        };
        local v22 = l__LevelService__7.getLevelFromXP(v20);
        local v23 = l__LevelService__7.getProgressPercent(v20);
        l__ViewingCanvas__14.LevelContainer.LevelFrame.LevelText.Text = tostring(v22);
        l__ViewingCanvas__14.LevelContainer.LevelFrame.LevelBar.Fill.Size = UDim2.fromScale(v23, 1);
        local v24 = {};
        for v25, v26 in pairs(v21) do
            table.insert(v24, {
                title = v25,
                req = v26
            });
        end;
        table.sort(v24, function(p27, p28) --[[ Line: 188 ]]
            return p27.req < p28.req;
        end);
        local v29 = nil;
        local v30 = nil;
        for _, v31 in ipairs(v24) do
            if v31.req <= v22 then
                v30 = v31.title;
            elseif not v29 then
                v29 = v31.req;
            end;
        end;
        local v32 = not v29 and "MAX" or v29 - v22;
        l__ViewingCanvas__14.LevelContainer.LevelFrame.HintText.Text = v32 == "MAX" and "FLATLINED." or v32 .. " LV. TO NEXT MILESTONE (" .. v29 .. ")";
        l__ViewingCanvas__14.LevelContainer.LevelFrame.MilestoneTitle.Text = l__CEnum__5.reverse(l__CEnum__5.Titles, v30) or "--";
    end;
    l__ViewingCanvas__14.LevelContainer.WeaponPlate.Killcount.Text = " " .. p8.sig_weapon_kills .. " KILLS ";
    local l__WeaponName__19 = l__ViewingCanvas__14.LevelContainer.WeaponPlate.WeaponName;
    local l__sig_weapon_name__20 = p8.sig_weapon_name;
    if l__sig_weapon_name__20 then
        l__sig_weapon_name__20 = p8.sig_weapon_name:upper();
    end;
    l__WeaponName__19.Text = l__sig_weapon_name__20;
end;
function u1.start(p33) --[[ Line: 220 ]]
    -- upvalues: l__TweenService__1 (copy)
    local _ = p33.page_origin;
    local l__main_page__21 = p33.main_page;
    l__main_page__21.Interactable = true;
    l__main_page__21.Parent = p33.parent_os.RightContainer.MainOS;
    l__main_page__21.GroupTransparency = 1;
    l__TweenService__1:Create(l__main_page__21, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    }):Play();
    l__main_page__21.Position = UDim2.fromScale(0, -0.1);
    l__TweenService__1:Create(l__main_page__21, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(0, 0)
    }):Play();
end;
function u1.Init(u34) --[[ Line: 235 ]]
    -- upvalues: l__Packets__3 (copy), l__Classes__10 (copy), l__TitleData__6 (copy)
    local v35 = l__Packets__3._xef0b2277203c2e18:Fire();
    u34.my_data = v35;
    u34:setupView(v35, true);
    local l__ViewingCanvas__22 = u34.main_page.Borders.ViewingCanvas;
    local l__dropdown_component__23 = u34.dropdown_component;
    if l__dropdown_component__23 then
        l__dropdown_component__23:mount();
        l__dropdown_component__23.onOpenList:Connect(function() --[[ Line: 249 ]]
            -- upvalues: l__Classes__10 (ref)
            l__Classes__10._x6dbba03a0636f7d8:_x282746dbf42c87cb("TAPE_SELECT", true);
        end);
        l__dropdown_component__23.onSelectionFinished:Connect(function(p36) --[[ Line: 253 ]]
            -- upvalues: u34 (copy), l__Packets__3 (ref), l__Classes__10 (ref), l__ViewingCanvas__22 (copy), l__TitleData__6 (ref)
            if u34.customizable then
                local l__meta__24 = p36.meta;
                if l__meta__24 then
                    l__meta__24 = p36.meta.title_cenum;
                end;
                if l__meta__24 then
                    l__Packets__3._xcc00a7b482c2657e:Fire(l__meta__24);
                    l__Classes__10._x6dbba03a0636f7d8:_x282746dbf42c87cb("TAPE_MOVE", true);
                    pcall(function() --[[ Line: 262 ]]
                        -- upvalues: l__ViewingCanvas__22 (ref), l__TitleData__6 (ref), l__meta__24 (copy)
                        l__TitleData__6.renderFromLabel(l__ViewingCanvas__22.IdentityContainer.InfoBox.TitlePlate.Title, l__meta__24);
                    end);
                end;
            end;
        end);
    end;
end;
return u1;
