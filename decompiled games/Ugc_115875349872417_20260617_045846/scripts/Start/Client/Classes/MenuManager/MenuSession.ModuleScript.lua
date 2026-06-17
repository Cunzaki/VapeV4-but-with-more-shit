-- Decompiled from: Start.Client.Classes.MenuManager.MenuSession
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__Players__4 = game:GetService("Players");
local l__ModuleScripts__5 = l__ReplicatedStorage__3.Assets.ModuleScripts;
local l__Packets__6 = require(l__ModuleScripts__5.Packets);
local l__Signal__7 = require(l__ModuleScripts__5.Signal);
local l__Promise__8 = require(l__ModuleScripts__5.Promise);
local l__Trove__9 = require(l__ModuleScripts__5.Trove);
local l__QueueDef__10 = require(l__ModuleScripts__5.QueueDef);
local l__CEnum__11 = require(l__ModuleScripts__5.CEnum);
local l__UIAssets__12 = l__ReplicatedStorage__3.Assets.UIAssets;
local u1 = {};
u1.__index = u1;
local l__Classes__13 = require(script.Parent.Parent.Parent.ClientRoot).Classes;
local l___x7749231778538ccb__14 = require(script.Parent.Parent.Parent._x7749231778538ccb);
local l__LocalPlayer__15 = l__Players__4.LocalPlayer;
local l__Lobbies__16 = l__ReplicatedStorage__3.ReadOnly.Lobbies;
local u2 = {
    lobby_page = true,
    loadout_page = true,
    showcase_page = true
};
local u3 = {
    empty_page = {
        sidebar_mode = "HIDDEN"
    },
    gamemodes_page = {
        sidebar_mode = "HIDDEN",
        darken = true
    },
    shop_page = {
        sidebar_mode = "HIDDEN",
        darken = true
    },
    profile_page = {
        sidebar_mode = "THIRD"
    },
    deploy_page = {
        sidebar_mode = "THIRD"
    },
    loadout_page = {
        sidebar_mode = "HIDDEN",
        darken = true
    },
    lobby_page = {
        sidebar_mode = "HIDDEN",
        darken = true
    },
    showcase_page = {
        sidebar_mode = "HIDDEN"
    },
    settings_page = {
        sidebar_mode = "THIRD"
    },
    serverlist_page = {
        sidebar_mode = "THIRD"
    },
    claim_page = {
        sidebar_mode = "THIRD"
    },
    contracts_page = {
        sidebar_mode = "THIRD"
    }
};
local u4 = nil;
local u5 = false;
local u6 = l__Signal__7.new();
function u1.initPolicyInfo() --[[ Line: 79 ]]
    -- upvalues: u5 (ref), l__Packets__6 (copy), u4 (ref), u6 (copy)
    if u5 then
    else
        u5 = true;
        task.spawn(function() --[[ Line: 85 ]]
            -- upvalues: l__Packets__6 (ref), u4 (ref), u6 (ref)
            local v7, v8 = pcall(function() --[[ Line: 86 ]]
                -- upvalues: l__Packets__6 (ref)
                return l__Packets__6._x0c8d775997f65b04:Fire();
            end);
            if v7 then
                local v9;
                if typeof(v8) == "table" then
                    v9 = v8.ArePaidRandomItemsRestricted == true;
                else
                    v9 = false;
                end;
                u4 = v9;
            else
                warn("[MenuSession] Failed to fetch policy info:", v8);
                u4 = true;
            end;
            u6:Fire(u4);
        end);
    end;
end;
function u1.getPaidRandomItemsRestricted(_) --[[ Line: 102 ]]
    -- upvalues: u1 (copy), u4 (ref)
    u1.initPolicyInfo();
    return u4;
end;
function u1.waitForPaidRandomItemsRestricted(_) --[[ Line: 107 ]]
    -- upvalues: u1 (copy), u4 (ref), u6 (copy)
    u1.initPolicyInfo();
    while u4 == nil do
        u6:Wait();
    end;
    return u4 == true;
end;
function u1.connectPolicyInfoUpdated(_, p10) --[[ Line: 116 ]]
    -- upvalues: u1 (copy), u4 (ref), u6 (copy)
    u1.initPolicyInfo();
    if u4 ~= nil then
        task.defer(p10, u4);
    end;
    return u6:Connect(p10);
end;
function u1.new(p11, p12) --[[ Line: 125 ]]
    -- upvalues: u1 (copy), l__Trove__9 (copy), l__UIAssets__12 (copy), l__Packets__6 (copy), l__Signal__7 (copy), l__CEnum__11 (copy), l___x7749231778538ccb__14 (copy)
    local u13 = setmetatable({}, u1);
    u13.trove = l__Trove__9.new();
    u13._intialized = false;
    u13.queued_operations = {};
    u13.screen = p11;
    u13.os_ui = l__UIAssets__12.Menu.MercOS:Clone();
    u13.next_deploy_request_at = 0;
    local v14;
    if p12 then
        v14 = p12.tracker_data;
    else
        v14 = p12;
    end;
    u13.tracker_data = v14;
    u13.spectator_camera = nil;
    u13.item_profile_data = nil;
    l__Packets__6._xfbbac22bb38ae8fe:Fire();
    u13.onItemProfileUpdated = u13.trove:Construct(l__Signal__7);
    u13.trove:Connect(l__Packets__6._xfbbac22bb38ae8fe.OnClientEvent, function(p15) --[[ Line: 141 ]]
        -- upvalues: u13 (copy)
        u13.item_profile_data = p15;
        u13.onItemProfileUpdated:Fire(p15);
    end);
    u13.inst_by_page = {};
    local v16 = {
        SETTINGS = {
            page_association = "settings_page",
            base_inst = l__UIAssets__12.Menu.MiscTrayButtons.SettingsFrame,
            onPressed = function() --[[ Name: onPressed, Line 229 ]]
                -- upvalues: u13 (copy)
                if u13.current_page == "settings_page" then
                    if u13.pagelocked then
                    else
                        u13:openPage("empty_page");
                        u13:setSidebarMode("HIDDEN");
                    end;
                else
                    u13:openPage("settings_page");
                end;
            end
        },
        SERVERLIST = {
            page_association = "serverlist_page",
            base_inst = l__UIAssets__12.Menu.MiscTrayButtons.ServerFrame,
            onPressed = function() --[[ Name: onPressed, Line 243 ]]
                -- upvalues: u13 (copy)
                if u13.current_page == "serverlist_page" then
                    if u13.pagelocked then
                    else
                        u13:openPage("empty_page");
                        u13:setSidebarMode("HIDDEN");
                    end;
                else
                    u13:openPage("serverlist_page");
                end;
            end
        },
        CONTRACTS = {
            page_association = "contracts_page",
            base_inst = l__UIAssets__12.Menu.MiscTrayButtons.ContractsFrame,
            onPressed = function() --[[ Name: onPressed, Line 257 ]]
                -- upvalues: u13 (copy)
                if u13.current_page == "contracts_page" then
                    if u13.pagelocked then
                    else
                        u13:openPage("empty_page");
                        u13:setSidebarMode("HIDDEN");
                    end;
                else
                    u13:openPage("contracts_page");
                end;
            end
        },
        RETURN = {
            base_inst = l__UIAssets__12.Menu.MiscTrayButtons.ReturnFrame,
            onPressed = function() --[[ Name: onPressed, Line 270 ]]
                -- upvalues: l__Packets__6 (ref), l__CEnum__11 (ref)
                l__Packets__6._xd107c8ee5ed343a1:Fire({
                    place_id = l__CEnum__11.PlaceIds.MAIN_PLACE
                });
            end
        }
    };
    u13.queue_cart = {};
    u13:_setupMidframe();
    u13.sidebar_mode = "HIDDEN";
    u13.pages = {
        lobby_page = require(script.LobbyPage).new(u13.os_ui, u13),
        claim_page = require(script.ClaimPage).new(u13.os_ui, u13),
        empty_page = require(script.PageTemplate).new(u13.os_ui, u13),
        serverlist_page = require(script.ServerlistPage).new(u13.os_ui, u13),
        gamemodes_page = require(script.GamemodesPage).new(u13.os_ui, u13),
        shop_page = require(script.ShopPage).new(u13.os_ui, u13),
        settings_page = require(script.SettingsPage).new(u13.os_ui, u13),
        profile_page = require(script.ProfilePage).new(u13.os_ui, u13),
        deploy_page = require(script.DeployPage).new(u13.os_ui, u13),
        loadout_page = require(script.LoadoutPage).new(u13.os_ui, u13),
        showcase_page = require(script.ShowcasePage).new(u13.os_ui, u13),
        contracts_page = require(script.ContractsPage).new(u13.os_ui, u13)
    };
    u13.nav_buttons = {};
    u13.misc_buttons = {};
    local v17 = {
        NOT_FOUND = {
            index_name = "not_found",
            init = function() --[[ Name: init, Line 151 ]] end
        },
        GAMEMODES = {
            nav_icon = "TAB",
            page_association = "gamemodes_page",
            onPressed = function() --[[ Name: onPressed, Line 158 ]]
                -- upvalues: u13 (copy)
                if u13.current_page == "gamemodes_page" then
                    if u13.pagelocked then
                    else
                        u13:openPage("empty_page");
                        u13:setSidebarMode("HIDDEN");
                    end;
                else
                    u13:openPage("gamemodes_page");
                end;
            end
        },
        SHOP = {
            nav_icon = "TAB",
            page_association = "shop_page",
            onPressed = function() --[[ Name: onPressed, Line 172 ]]
                -- upvalues: u13 (copy)
                if u13.current_page == "shop_page" then
                    if u13.pagelocked then
                    else
                        u13:openPage("empty_page");
                        u13:setSidebarMode("HIDDEN");
                    end;
                else
                    u13:openPage("shop_page");
                end;
            end
        },
        PROFILE = {
            page_association = "profile_page",
            onPressed = function() --[[ Name: onPressed, Line 185 ]]
                -- upvalues: u13 (copy)
                if u13.current_page == "profile_page" then
                    if u13.pagelocked then
                    else
                        u13:openPage("empty_page");
                        u13:setSidebarMode("HIDDEN");
                    end;
                else
                    u13:openPage("profile_page");
                end;
            end
        },
        DEPLOY = {
            page_association = "deploy_page",
            onPressed = function() --[[ Name: onPressed, Line 198 ]]
                -- upvalues: u13 (copy)
                if u13.current_page == "deploy_page" then
                    if u13.pagelocked then
                    else
                        u13:openPage("empty_page");
                        u13:setSidebarMode("HIDDEN");
                    end;
                else
                    u13:openPage("deploy_page");
                end;
            end
        },
        ARSENAL = {
            nav_icon = "TAB",
            page_association = "loadout_page",
            onPressed = function() --[[ Name: onPressed, Line 212 ]]
                -- upvalues: u13 (copy)
                if u13.current_page == "loadout_page" then
                    if u13.pagelocked then
                    else
                        u13:openPage("empty_page");
                        u13:setSidebarMode("HIDDEN");
                    end;
                else
                    u13:openPage("loadout_page");
                end;
            end
        }
    };
    for _, v18 in p12.nav_buttons do
        local v19 = v17[v18];
        if v19 then
            local v20 = {};
            v20.name = v20;
            local l__os_ui__17 = u13.os_ui;
            local v21 = l__UIAssets__12.Menu.NavFrame:Clone();
            v21.BodyFrame.MainTextLabel.Text = v18;
            v21.Parent = l__os_ui__17.LeftContainer.Main.ButtonCanvas.ButtonList;
            if v19.nav_icon == "TAB" then
                v21.BodyFrame.ImageLabel.Rotation = 0;
                v21.BodyFrame.ImageLabel.Image = "rbxassetid://104117401760297";
            end;
            v20.inst = v21;
            v20.data = v19;
            if v19.onInit then
                v19.onInit();
            end;
            table.insert(u13.nav_buttons, v20);
        else
            warn("NO SUCH NAV BUTTON DATA FOR ", v18);
        end;
    end;
    for _, v22 in p12.misc_buttons do
        local v23 = v16[v22];
        if v23 then
            local v24 = {};
            v24.name = v24.name;
            local l__os_ui__18 = u13.os_ui;
            local v25 = v23.base_inst:Clone();
            v25.Parent = l__os_ui__18.LeftContainer.MiscTray;
            v24.inst = v25;
            v24.data = v23;
            if v23.onInit then
                v23.onInit();
            end;
            table.insert(u13.misc_buttons, v24);
        else
            warn("NO SUCH NAV BUTTON DATA FOR ", v22);
        end;
    end;
    u13.current_page = nil;
    u13.pagelocked = false;
    u13.darkened = false;
    for v26, v27 in pairs(u13.pages) do
        local u28 = l___x7749231778538ccb__14._xd644d9e3ba63f27f("MenuPage", v27);
        local v29, v30 = pcall(function() --[[ Line: 357 ]]
            -- upvalues: u28 (ref)
            u28:Init();
        end);
        if not v29 then
            warn("FAILED TO INITIALIZE PAGE : ", v26, v30);
        end;
    end;
    u13.signals = {
        pageChanged = l__Signal__7.new()
    };
    u13.trove:Add(u13.os_ui);
    for _, v31 in u13.signals do
        u13.trove:Add(v31);
    end;
    u13.target_scroll_speed = 50;
    u13._intialized = true;
    for _, v32 in u13.queued_operations do
        print("CALLING QUEUED OP");
        local v33, _ = pcall(v32);
        if not v33 then
            warn("QUEUED CALLBACK ERROR:", v32);
        end;
    end;
    return u13;
end;
function u1.cleanUp(p34) --[[ Line: 387 ]]
    -- upvalues: l___x7749231778538ccb__14 (copy)
    p34._destroyed = true;
    p34.trove:Clean();
    if p34.spectator_camera then
        l___x7749231778538ccb__14._xd644d9e3ba63f27f("SpectatorCamera", p34.spectator_camera):cleanUp();
    end;
    for _, v35 in p34.pages do
        l___x7749231778538ccb__14._xd644d9e3ba63f27f("MenuPage", v35):cleanUp();
    end;
end;
function u1.setupCodeScroll(u36) --[[ Line: 399 ]]
    -- upvalues: l__RunService__1 (copy)
    local l__CodeScroll__19 = u36.os_ui.RightContainer.MainOS.CodeScroll;
    local l__target_scroll_speed__20 = u36.target_scroll_speed;
    local _ = u36.target_scroll_speed;
    local u37 = 0;
    u36.trove:Add(l__RunService__1.RenderStepped:Connect(function(p38) --[[ Line: 407 ]]
        -- upvalues: l__CodeScroll__19 (copy), l__target_scroll_speed__20 (ref), u36 (copy), u37 (ref)
        local l__Y__21 = l__CodeScroll__19.UIListLayout.AbsoluteContentSize.Y;
        l__CodeScroll__19.CanvasSize = UDim2.new(0, 0, l__Y__21, 0);
        local v39 = l__Y__21 / 2;
        l__target_scroll_speed__20 = l__target_scroll_speed__20 + math.clamp(u36.target_scroll_speed - l__target_scroll_speed__20, -1000 * p38, 1000 * p38);
        u37 = u37 + l__target_scroll_speed__20 * p38;
        u37 = u37 % v39;
        l__CodeScroll__19.CanvasPosition = Vector2.new(0, u37);
    end));
end;
function u1.modifyCodeScroll(u40, u41, u42) --[[ Line: 421 ]]
    -- upvalues: l__Promise__8 (copy), l__RunService__1 (copy), l__Classes__13 (copy)
    local v52 = l__Promise__8.new(function(u43, _, p44) --[[ Line: 422 ]]
        -- upvalues: l__RunService__1 (ref), l__Classes__13 (ref), u42 (copy), u41 (copy), u40 (copy)
        local u45 = os.clock();
        local u46 = nil;
        u46 = l__RunService__1.Heartbeat:Connect(function() --[[ Line: 425 ]]
            -- upvalues: u45 (copy), l__Classes__13 (ref), u42 (ref), u41 (ref), u46 (ref), u43 (copy), u40 (ref), l__RunService__1 (ref)
            local v47 = os.clock() - u45;
            local v48 = l__Classes__13.Util:convNumRange(v47, 0, u42, 1, 0);
            local v49 = u41 * v48;
            if v48 == 0 then
                u46:Disconnect();
                u46 = nil;
                u43();
            end;
            local v50 = u40;
            v50.target_scroll_speed = v50.target_scroll_speed + v49;
            l__RunService__1.PostSimulation:Wait();
            local v51 = u40;
            v51.target_scroll_speed = v51.target_scroll_speed - v49;
        end);
        p44(function() --[[ Line: 441 ]]
            -- upvalues: u46 (ref)
            if u46 then
                u46:Disconnect();
                u46 = nil;
            end;
        end);
    end);
    u40.trove:AddPromise(v52);
    return v52;
end;
function u1.requestDeploy(p53) --[[ Line: 453 ]]
    -- upvalues: l__Packets__6 (copy)
    if p53.pagelocked then
    else
        local v54 = os.clock();
        if v54 < p53.next_deploy_request_at then
        else
            p53.next_deploy_request_at = v54 + 0.75;
            l__Packets__6._x01d1e6369b1ddabb:Fire();
        end;
    end;
end;
function u1.initializeInput(u55) --[[ Line: 467 ]]
    -- upvalues: l__TweenService__2 (copy), l__Classes__13 (copy)
    for _, v56 in u55.nav_buttons do
        local l__inst__22 = v56.inst;
        l__inst__22.NavButton.Activated:Connect(v56.data.onPressed);
        l__inst__22.NavButton.MouseEnter:Connect(function() --[[ Line: 473 ]]
            -- upvalues: l__TweenService__2 (ref), l__inst__22 (copy)
            l__TweenService__2:Create(l__inst__22.BodyFrame.ImageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.77, 0.5)
            }):Play();
        end);
        l__inst__22.NavButton.MouseLeave:Connect(function() --[[ Line: 476 ]]
            -- upvalues: l__TweenService__2 (ref), l__inst__22 (copy)
            l__TweenService__2:Create(l__inst__22.BodyFrame.ImageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.75, 0.5)
            }):Play();
        end);
    end;
    for _, v57 in u55.misc_buttons do
        v57.inst:FindFirstChildWhichIsA("ImageButton").Activated:Connect(v57.data.onPressed);
    end;
    local u58 = {};
    u55.os_ui.HideButton.Activated:Connect(function() --[[ Line: 491 ]]
        -- upvalues: l__Classes__13 (ref), u58 (copy), u55 (copy)
        l__Classes__13._x6dbba03a0636f7d8:_x282746dbf42c87cb("BACK2", true);
        if #u58 == 0 then
            for _, v59 in u55.os_ui:GetChildren() do
                if v59.Visible and (v59 ~= u55.os_ui.HideButton and v59 ~= u55.os_ui.Vignette) then
                    v59.Visible = false;
                    table.insert(u58, v59);
                end;
            end;
        else
            for _, v60 in u58 do
                v60.Visible = true;
            end;
            table.clear(u58);
        end;
    end);
end;
function u1.initializeVisuals(u61) --[[ Line: 511 ]]
    -- upvalues: l__Classes__13 (copy), l___x7749231778538ccb__14 (copy)
    local l__YenCount__23 = u61.os_ui.CurrencyLayer.YenFrame.YenCount;
    local u62 = l__Classes__13._x8399b2bb73e12808:_xe7f02e22353709c3("yen");
    if u62 then
        if u61.tracker_data then
            l__YenCount__23.Text = "¥" .. l__Classes__13.Util:formatNumber(u62.Value - u61.tracker_data.entry_earnings);
        else
            l__YenCount__23.Text = "¥" .. l__Classes__13.Util:formatNumber(u62.Value);
        end;
    else
        warn("FAILED TO GET YEN VALUE INSTANCE");
        l__YenCount__23.Text = "N / A";
    end;
    u61.trove:Connect(u62.Changed, function() --[[ Line: 532 ]]
        -- upvalues: l__Classes__13 (ref), u62 (copy), l__YenCount__23 (copy)
        l__YenCount__23.Text = "¥" .. l__Classes__13.Util:formatNumber(u62.Value);
    end);
    local l__CrimCount__24 = u61.os_ui.CurrencyLayer.CrimFrame.CountContainer.CrimCount;
    local u63 = l__Classes__13._x8399b2bb73e12808:_xe7f02e22353709c3("crimson");
    if u63 then
        u61.trove:Connect(u63.Changed, function() --[[ Line: 548 ]]
            -- upvalues: l__Classes__13 (ref), u63 (copy), l__CrimCount__24 (copy)
            l__CrimCount__24.Text = l__Classes__13.Util:formatNumber(u63.Value);
        end);
        l__CrimCount__24.Text = l__Classes__13.Util:formatNumber(u63.Value);
        u61.trove:Connect(u61.os_ui.CurrencyLayer.CrimFrame.AddButton.Activated, function() --[[ Line: 556 ]]
            -- upvalues: u61 (copy), l___x7749231778538ccb__14 (ref)
            if u61.current_page == "shop_page" then
                l___x7749231778538ccb__14._xd644d9e3ba63f27f("ShopPage", u61.pages.shop_page):openTab("Deals");
            else
                u61:openPage("shop_page", "Deals");
            end;
        end);
        u61.trove:Connect(l__CrimCount__24.Activated, function() --[[ Line: 564 ]]
            -- upvalues: u61 (copy), l___x7749231778538ccb__14 (ref)
            if u61.current_page == "shop_page" then
                l___x7749231778538ccb__14._xd644d9e3ba63f27f("ShopPage", u61.pages.shop_page):openTab("Deals");
            else
                u61:openPage("shop_page", "Deals");
            end;
        end);
    else
        warn("FAILED TO GET YEN VALUE INSTANCE");
        l__CrimCount__24.Text = "N / A";
    end;
end;
function u1.setSidebarMode(p64, p65) --[[ Line: 576 ]]
    -- upvalues: l__TweenService__2 (copy)
    local l__RightContainer__25 = p64.os_ui.RightContainer;
    if p65 == "HIDDEN" then
        p64.sidebar_mode = "HIDDEN";
        l__TweenService__2:Create(l__RightContainer__25, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(1.33, 0.5),
            Size = UDim2.fromScale(0.5, 1)
        }):Play();
    elseif p65 == "THIRD" then
        p64.sidebar_mode = "THIRD";
        l__TweenService__2:Create(l__RightContainer__25, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(1, 0.5),
            Size = UDim2.fromScale(0.5, 1)
        }):Play();
    else
        if p65 == "HALF" then
            p64.sidebar_mode = "HALF";
            l__TweenService__2:Create(l__RightContainer__25, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(1, 0.5),
                Size = UDim2.fromScale(0.66, 1)
            }):Play();
        end;
    end;
end;
function u1.setDarken(p66, p67) --[[ Line: 591 ]]
    -- upvalues: l__TweenService__2 (copy)
    local l__Darken__26 = p66.os_ui.Darken;
    if p67 then
        l__TweenService__2:Create(l__Darken__26, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0.05
        }):Play();
    else
        l__TweenService__2:Create(l__Darken__26, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
    end;
end;
function u1._localPlayerIsInLobby(p68) --[[ Line: 601 ]]
    -- upvalues: l__LocalPlayer__15 (copy), l__Lobbies__16 (copy)
    local l__pages__27 = p68.pages;
    if l__pages__27 then
        l__pages__27 = p68.pages.lobby_page;
    end;
    if l__pages__27 and l__pages__27.in_lobby == true then
        return true;
    end;
    local v69 = tostring(l__LocalPlayer__15.UserId);
    for _, v70 in l__Lobbies__16:GetChildren() do
        if v70:IsA("Folder") then
            local v71 = v70:FindFirstChild(v69);
            if v71 and v71:IsA("Folder") then
                return true;
            end;
        end;
    end;
    return false;
end;
function u1._canOpenPage(p72, p73) --[[ Line: 622 ]]
    -- upvalues: u2 (copy)
    return not p72:_localPlayerIsInLobby() and true or u2[p73] == true;
end;
function u1.openPage(u74, u75, ...) --[[ Line: 630 ]]
    -- upvalues: l__Classes__13 (copy), l__TweenService__2 (copy), u3 (copy), l___x7749231778538ccb__14 (copy)
    if u74._destroyed then
        return false;
    end;
    if not u74._intialized then
        local u76 = { ... };
        local u77 = select("#", ...);
        table.insert(u74.queued_operations, function() --[[ Line: 638 ]]
            -- upvalues: u74 (copy), u75 (copy), u76 (copy), u77 (copy)
            u74:openPage(u75, unpack(u76, 1, u77));
        end);
        return false;
    end;
    if u74.pagelocked then
        print("PAGE CURRENTLY LOCKED, WON\'T OPEN : ", u75);
        return false;
    end;
    if not u74.pages[u75] then
        warn("NO SUCH PAGE : ", u75);
        return false;
    end;
    if not u74:_canOpenPage(u75) then
        return false;
    end;
    if u74.current_page ~= u75 then
        l__Classes__13._x6dbba03a0636f7d8:_x282746dbf42c87cb("UI_CLICK", true);
        l__Classes__13._x6dbba03a0636f7d8:_x282746dbf42c87cb("BACK1", true);
    end;
    for _, v78 in u74.nav_buttons do
        local l__inst__28 = v78.inst;
        if v78.data.page_association == u75 then
            l__TweenService__2:Create(l__inst__28.BodyFrame.SelectionAccent, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Size = UDim2.new(0.5, 0, 1, 2)
            }):Play();
        else
            l__TweenService__2:Create(l__inst__28.BodyFrame.SelectionAccent, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 0, 1, 2)
            }):Play();
        end;
    end;
    local v79 = u3[u75];
    if v79 then
        local l__sidebar_mode__29 = v79.sidebar_mode;
        if v79.darken then
            u74:setDarken(true);
        else
            u74:setDarken(false);
        end;
        u74:setSidebarMode(l__sidebar_mode__29);
    else
        warn("[MenuSession] MISSING PAGE DATA FOR :", u75);
    end;
    u74.signals.pageChanged:Fire(u75);
    local v80 = l___x7749231778538ccb__14._xd644d9e3ba63f27f("MenuPage", u74.pages[u75]);
    local v81 = v80:start(...);
    local l__current_page__30 = u74.current_page;
    u74.current_page = u75;
    if l__current_page__30 and l__current_page__30 ~= u75 then
        local v82 = l___x7749231778538ccb__14._xd644d9e3ba63f27f("MenuPage", u74.pages[l__current_page__30]);
        if v82 then
            v82:close();
        else
            warn("INVALID CURRENT PAGE, COULD NOT CLOSE : ", l__current_page__30);
        end;
    end;
    return true, v80, v81;
end;
function u1._setupMidframe(p83) --[[ Line: 701 ]]
    local l__MidContainer__31 = p83.os_ui.MidContainer;
    local v84 = require(script.MidframeRenderer).new(l__MidContainer__31, p83);
    p83.midframe_renderer = v84;
    p83.trove:Add(v84._trove);
end;
function u1.finalizeQueueCart(p85, p86) --[[ Line: 709 ]]
    p85.queue_cart = p86;
    if p85.midframe_renderer then
        p85.midframe_renderer:_updateGamemodeLabel();
    end;
end;
function u1.setPagelocked(p87, p88) --[[ Line: 717 ]]
    p87.pagelocked = p88;
end;
function u1.setNotifyVisible(p89, p90, p91) --[[ Line: 721 ]]
    for _, v92 in p89.nav_buttons do
        if v92.data.page_association == p90 then
            local v93 = v92.inst:FindFirstChild("Notif");
            if v93 then
                v93.Visible = p91;
            end;
            return;
        end;
    end;
    for _, v94 in p89.misc_buttons do
        if v94.data.page_association == p90 then
            local v95 = v94.inst:FindFirstChild("Notif");
            if v95 then
                v95.Visible = p91;
            end;
            return;
        end;
    end;
    warn("[MenuSession] No nav/misc button found for page:", p90);
end;
function u1.start(u96, p97) --[[ Line: 746 ]]
    -- upvalues: l__Classes__13 (copy), l__QueueDef__10 (copy)
    local v98;
    if p97 then
        v98 = l__Classes__13.MenuManager.visuals:bootSequence();
    else
        v98 = nil;
    end;
    u96:setSidebarMode("HIDDEN");
    u96:initializeVisuals();
    u96.os_ui.Parent = u96.screen;
    u96.os_ui.Visible = false;
    if l__Classes__13._x9a86d5566d6a5327 then
        l__Classes__13._x9a86d5566d6a5327:_xa55dce7423ae74c2(u96.os_ui.RightContainer.MainOS.NotificationList, true);
    end;
    if l__Classes__13._x6a15bbeeb97caae0 then
        l__Classes__13._x6a15bbeeb97caae0:_xf98f587c3f464384();
    end;
    if u96.midframe_renderer and u96.midframe_renderer._client then
        u96.trove:Connect(u96.midframe_renderer._client.partyChanged, function() --[[ Line: 770 ]]
            -- upvalues: u96 (copy), l__QueueDef__10 (ref)
            local v99 = #u96.midframe_renderer._client:getPartyState().members;
            for v100 = #u96.queue_cart, 1, -1 do
                if l__QueueDef__10.getDef(u96.queue_cart[v100]).required_slot_size < v99 then
                    table.remove(u96.queue_cart, v100);
                end;
            end;
            u96.midframe_renderer:_updateGamemodeLabel();
        end);
    end;
    if v98 then
        task.delay(1, function() --[[ Line: 812 ]]
            -- upvalues: u96 (copy)
            if u96._destroyed then
            else
                u96:initializeInput();
                if u96.tracker_data and #u96.tracker_data.entries > 0 then
                    local l__lobby_page__32 = u96.pages.lobby_page;
                    if not (l__lobby_page__32 and l__lobby_page__32.in_lobby) then
                        u96:openPage("claim_page", u96.tracker_data);
                    end;
                end;
                u96.os_ui.Visible = true;
                u96:setupCodeScroll();
                u96:modifyCodeScroll(2500, 3);
            end;
        end);
    elseif u96._destroyed then
    else
        u96:initializeInput();
        if u96.tracker_data and #u96.tracker_data.entries > 0 then
            local l__lobby_page__33 = u96.pages.lobby_page;
            if not (l__lobby_page__33 and l__lobby_page__33.in_lobby) then
                u96:openPage("claim_page", u96.tracker_data);
            end;
        end;
        u96.os_ui.Visible = true;
        u96:setupCodeScroll();
        u96:modifyCodeScroll(2500, 3);
    end;
end;
return u1;
