-- Decompiled from: Start.Client.Classes.MenuManager.MenuSession.ProfilePage
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

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
local l__InternalSymbols__11 = require(script.Parent.Parent.Parent.Parent.InternalSymbols);
local _ = game.Players.LocalPlayer;
function u1.new(p2, p3) --[[ Line: 32 ]]
    -- upvalues: u1 (copy), l__InternalSymbols__11 (copy), l__UIAssets__8 (copy), l__DropdownMenu__9 (copy), l__Trove__4 (copy)
    local v4 = setmetatable({}, u1);
    v4.menu_session = l__InternalSymbols__11.owner("MenuSession", p3);
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
function u1.cleanUp(p5) --[[ Line: 60 ]]
    local l__dropdown_component__12 = p5.dropdown_component;
    if l__dropdown_component__12 then
        l__dropdown_component__12:Destroy();
    end;
end;
function u1.close(p6) --[[ Line: 68 ]]
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
function u1.setupView(p7, p8, p9) --[[ Line: 77 ]]
    -- upvalues: l__Classes__10 (copy), l__TitleData__6 (copy), l__CEnum__5 (copy), l__LevelService__7 (copy)
    local l__ViewingCanvas__14 = p7.main_page.Borders.ViewingCanvas;
    p7.data_in_view = p8;
    p7.customizable = true;
    local l__dropdown_component__15 = p7.dropdown_component;
    local l__userid__16 = p8.userid;
    if l__userid__16 then
        l__userid__16 = tonumber(p8.userid);
    end;
    local function u11() --[[ Line: 88 ]]
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
    task.defer(function() --[[ Line: 109 ]]
        -- upvalues: l__ViewingCanvas__14 (copy), u11 (copy)
        pcall(function() --[[ Line: 110 ]]
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
                preRender = function(p17) --[[ Line: 131 ]]
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
    local l__Title__19 = l__ViewingCanvas__14.IdentityContainer.InfoBox.TitlePlate.Title;
    local v19 = (typeof(p8.equipped_titles) ~= "table" and {} or p8.equipped_titles)["1"] or l__CEnum__5.Titles.Rookie;
    l__TitleData__6.renderFromLabel(l__Title__19, v19);
    local v20 = "¥" .. (l__Classes__10.Util:formatNumber(p8.total_earnings) or "0");
    l__ViewingCanvas__14.IdentityContainer.InfoBox.ValuePlate.Value.Text = v20;
    local v21 = tonumber(p8.total_xp);
    if v21 then
        local v22 = {
            [l__CEnum__5.Titles.Rookie] = 0,
            [l__CEnum__5.Titles.Prospect] = 5,
            [l__CEnum__5.Titles.Freelancer] = 10,
            [l__CEnum__5.Titles.Professional] = 25,
            [l__CEnum__5.Titles.Elite] = 50,
            [l__CEnum__5.Titles.Menace] = 75,
            [l__CEnum__5.Titles.Eminence] = 90,
            [l__CEnum__5.Titles.FLATLINER] = 100
        };
        local v23 = l__LevelService__7.getLevelFromXP(v21);
        local v24 = l__LevelService__7.getProgressPercent(v21);
        l__ViewingCanvas__14.LevelContainer.LevelFrame.LevelText.Text = tostring(v23);
        l__ViewingCanvas__14.LevelContainer.LevelFrame.LevelBar.Fill.Size = UDim2.fromScale(v24, 1);
        local v25 = {};
        for v26, v27 in pairs(v22) do
            table.insert(v25, {
                title = v26,
                req = v27
            });
        end;
        table.sort(v25, function(p28, p29) --[[ Line: 191 ]]
            return p28.req < p29.req;
        end);
        local v30 = nil;
        local v31 = nil;
        for _, v32 in ipairs(v25) do
            if v32.req <= v23 then
                v31 = v32.title;
            elseif not v30 then
                v30 = v32.req;
            end;
        end;
        local v33 = not v30 and "MAX" or v30 - v23;
        l__ViewingCanvas__14.LevelContainer.LevelFrame.HintText.Text = v33 == "MAX" and "FLATLINED." or v33 .. " LV. TO NEXT MILESTONE (" .. v30 .. ")";
        l__ViewingCanvas__14.LevelContainer.LevelFrame.MilestoneTitle.Text = l__CEnum__5.reverse(l__CEnum__5.Titles, v31) or "--";
    end;
    l__ViewingCanvas__14.LevelContainer.WeaponPlate.Killcount.Text = " " .. p8.sig_weapon_kills .. " KILLS ";
    local l__WeaponName__20 = l__ViewingCanvas__14.LevelContainer.WeaponPlate.WeaponName;
    local l__sig_weapon_name__21 = p8.sig_weapon_name;
    if l__sig_weapon_name__21 then
        l__sig_weapon_name__21 = p8.sig_weapon_name:upper();
    end;
    l__WeaponName__20.Text = l__sig_weapon_name__21;
end;
function u1.start(p34) --[[ Line: 223 ]]
    -- upvalues: l__TweenService__1 (copy)
    local _ = p34.page_origin;
    local l__main_page__22 = p34.main_page;
    l__main_page__22.Interactable = true;
    l__main_page__22.Parent = p34.parent_os.RightContainer.MainOS;
    l__main_page__22.GroupTransparency = 1;
    l__TweenService__1:Create(l__main_page__22, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    }):Play();
    l__main_page__22.Position = UDim2.fromScale(0, -0.1);
    l__TweenService__1:Create(l__main_page__22, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(0, 0)
    }):Play();
end;
function u1.Init(u35) --[[ Line: 238 ]]
    -- upvalues: l__Packets__3 (copy), l__Classes__10 (copy), l__TitleData__6 (copy)
    local v36 = l__Packets__3._xb36b470092ff17d7:Fire();
    u35.my_data = v36;
    u35:setupView(v36, true);
    local l__ViewingCanvas__23 = u35.main_page.Borders.ViewingCanvas;
    local l__dropdown_component__24 = u35.dropdown_component;
    if l__dropdown_component__24 then
        l__dropdown_component__24:mount();
        l__dropdown_component__24.onOpenList:Connect(function() --[[ Line: 252 ]]
            -- upvalues: l__Classes__10 (ref)
            l__Classes__10._xbe184fb1376a575d:_x7ab8b42cc5920a78("TAPE_SELECT", true);
        end);
        l__dropdown_component__24.onSelectionFinished:Connect(function(p37) --[[ Line: 256 ]]
            -- upvalues: u35 (copy), l__Packets__3 (ref), l__Classes__10 (ref), l__ViewingCanvas__23 (copy), l__TitleData__6 (ref)
            if u35.customizable then
                local l__meta__25 = p37.meta;
                if l__meta__25 then
                    l__meta__25 = p37.meta.title_cenum;
                end;
                if l__meta__25 then
                    l__Packets__3._x42ceccfc7e7a492b:Fire(l__meta__25);
                    l__Classes__10._xbe184fb1376a575d:_x7ab8b42cc5920a78("TAPE_MOVE", true);
                    pcall(function() --[[ Line: 265 ]]
                        -- upvalues: l__ViewingCanvas__23 (ref), l__TitleData__6 (ref), l__meta__25 (copy)
                        l__TitleData__6.renderFromLabel(l__ViewingCanvas__23.IdentityContainer.InfoBox.TitlePlate.Title, l__meta__25);
                    end);
                end;
            end;
        end);
    end;
end;
return u1;
