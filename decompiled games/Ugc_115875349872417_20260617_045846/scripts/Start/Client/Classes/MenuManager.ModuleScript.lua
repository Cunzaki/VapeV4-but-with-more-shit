-- Decompiled from: Start.Client.Classes.MenuManager
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
local l__ModuleScripts__3 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__4 = require(l__ModuleScripts__3.Packets);
local l__Promise__5 = require(l__ModuleScripts__3.Promise);
local u1 = {};
u1.__index = u1;
local l__Classes__6 = require(script.Parent.Parent.ClientRoot).Classes;
local l__LocalPlayer__7 = game.Players.LocalPlayer;
local u2 = {
    PUBLIC_LOBBY = {
        nav_buttons = {
            "GAMEMODES",
            "SHOP",
            "ARSENAL",
            "PROFILE"
        },
        misc_buttons = { "SERVERLIST", "SETTINGS", "CONTRACTS" }
    },
    FFA = {
        nav_buttons = {
            "GAMEMODES",
            "SHOP",
            "ARSENAL",
            "PROFILE"
        },
        misc_buttons = {
            "RETURN",
            "SERVERLIST",
            "SETTINGS",
            "CONTRACTS"
        }
    }
};
function u1.new() --[[ Line: 47 ]]
    -- upvalues: u1 (copy), l__LocalPlayer__7 (copy)
    local v3 = setmetatable({}, u1);
    v3.screen = Instance.new("ScreenGui");
    v3.screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    v3.screen.Name = "MenuManager";
    v3.screen.ResetOnSpawn = false;
    v3.screen.DisplayOrder = 2;
    v3.screen.IgnoreGuiInset = true;
    v3.screen.Enabled = true;
    v3.current_session = nil;
    v3.next_menu_request_at = 0;
    v3.visuals = require(script.MenuVisuals).new();
    v3.visuals.screen = v3.screen;
    v3.visuals:Init();
    local v4 = Instance.new("ScreenGui");
    v4.IgnoreGuiInset = true;
    v4.Name = "TooltipScreen";
    v4.ResetOnSpawn = false;
    v4.DisplayOrder = 500;
    v4.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    v4.Enabled = true;
    v4.Parent = l__LocalPlayer__7.PlayerGui;
    v3.tooltip_con = nil;
    v3.tooltip_visible = false;
    v3.tooltip_frame = game:GetService("ReplicatedStorage").Assets.UIAssets.Tooltip:Clone();
    v3.tooltip_frame.Visible = false;
    v3.tooltip_frame.Active = false;
    v3.tooltip_frame.Parent = v4;
    return v3;
end;
function u1.close(p5) --[[ Line: 84 ]]
    if p5.tooltip_con then
        p5.tooltip_con:Disconnect();
        p5.tooltip_con = nil;
    end;
    if p5.current_session then
        p5.current_session:cleanUp();
        p5.current_session = nil;
    end;
    p5.in_menu = false;
end;
function u1._canRequestMenu(p6) --[[ Line: 98 ]]
    local v7 = os.clock();
    if v7 < p6.next_menu_request_at then
        return false;
    end;
    p6.next_menu_request_at = v7 + 0.75;
    return true;
end;
function u1.processTooltip(p8) --[[ Line: 108 ]]
    -- upvalues: l__TweenService__2 (copy)
    if p8.current_tooltip then
        if p8.current_tooltip:GetAttribute("Tooltip") then
            if p8.current_tooltip:GetAttribute("Readable") then
                local l__tooltip_frame__8 = p8.tooltip_frame;
                local v9 = p8.current_tooltip:GetAttribute("Tooltip");
                if not p8.tooltip_visible then
                    p8.tooltip_frame.Visible = true;
                    p8.tooltip_visible = true;
                    l__tooltip_frame__8.BackgroundTransparency = 1;
                    l__tooltip_frame__8.Seer.TextTransparency = 1;
                    l__tooltip_frame__8.Seer.BackgroundTransparency = 1;
                    l__tooltip_frame__8.TooltipText.TextTransparency = 1;
                    l__tooltip_frame__8.UIStroke.Transparency = 1;
                    local v10 = TweenInfo.new(0.15);
                    l__TweenService__2:Create(l__tooltip_frame__8, v10, {
                        BackgroundTransparency = 0
                    }):Play();
                    l__TweenService__2:Create(l__tooltip_frame__8.Seer, v10, {
                        TextTransparency = 0
                    }):Play();
                    l__TweenService__2:Create(l__tooltip_frame__8.Seer, v10, {
                        BackgroundTransparency = 0
                    }):Play();
                    l__TweenService__2:Create(l__tooltip_frame__8.TooltipText, v10, {
                        TextTransparency = 0
                    }):Play();
                    l__TweenService__2:Create(l__tooltip_frame__8.UIStroke, v10, {
                        Transparency = 0.67
                    }):Play();
                end;
                l__tooltip_frame__8.TooltipText.Text = "\"" .. v9 .. "\"";
                local v11 = game:GetService("UserInputService"):GetMouseLocation();
                local l__CurrentCamera__9 = workspace.CurrentCamera;
                local l__X__10 = l__CurrentCamera__9.ViewportSize.X;
                local l__Y__11 = l__CurrentCamera__9.ViewportSize.Y;
                local l__AbsoluteSize__12 = l__tooltip_frame__8.AbsoluteSize;
                l__tooltip_frame__8.AnchorPoint = Vector2.new(l__X__10 < v11.X + l__AbsoluteSize__12.X and 1 or 0, l__Y__11 < v11.Y + l__AbsoluteSize__12.Y and 0 or 1);
                l__tooltip_frame__8.Position = UDim2.fromOffset(v11.X, v11.Y);
            else
                p8.tooltip_visible = false;
                if p8.tooltip_frame then
                    p8.tooltip_frame.Visible = false;
                end;
            end;
        else
            p8.tooltip_visible = false;
            if p8.tooltip_frame then
                p8.tooltip_frame.Visible = false;
            end;
        end;
    else
        p8.tooltip_visible = false;
        if p8.tooltip_frame then
            p8.tooltip_frame.Visible = false;
        end;
    end;
end;
function u1.createTooltip(u12, u13, u14, u15) --[[ Line: 157 ]]
    -- upvalues: l__Promise__5 (copy)
    return l__Promise__5.new(function(u16, _, p17) --[[ Line: 158 ]]
        -- upvalues: u13 (copy), u14 (copy), l__Promise__5 (ref), u15 (copy), u12 (copy)
        u13:SetAttribute("Tooltip", u14);
        local u18 = l__Promise__5.resolve();
        local u19, u20;
        if u15 and u15 > 0 then
            u13:SetAttribute("Readable", false);
            u19 = u13.MouseEnter:Connect(function() --[[ Line: 165 ]]
                -- upvalues: u18 (ref), u13 (ref), l__Promise__5 (ref), u15 (ref), u12 (ref)
                u18:cancel();
                u13:SetAttribute("Readable", false);
                u18 = l__Promise__5.delay(u15);
                u18:andThen(function() --[[ Line: 170 ]]
                    -- upvalues: u12 (ref), u13 (ref)
                    u12.current_tooltip = u13;
                    u13:SetAttribute("Readable", true);
                end);
            end);
            u20 = u13.MouseLeave:Connect(function() --[[ Line: 175 ]]
                -- upvalues: u18 (ref), u13 (ref), u12 (ref)
                u18:cancel();
                u13:SetAttribute("Readable", false);
                if u12.current_tooltip == u13 then
                    u12.current_tooltip = nil;
                end;
            end);
        else
            u13:SetAttribute("Readable", true);
            u19 = u13.MouseEnter:Connect(function() --[[ Line: 185 ]]
                -- upvalues: u12 (ref), u13 (ref)
                u12.current_tooltip = u13;
            end);
            u20 = u13.MouseLeave:Connect(function() --[[ Line: 188 ]]
                -- upvalues: u12 (ref), u13 (ref)
                if u12.current_tooltip == u13 then
                    u12.current_tooltip = nil;
                end;
            end);
        end;
        u13.Destroying:Once(function() --[[ Line: 199 ]]
            -- upvalues: u16 (copy), u19 (ref), u20 (ref), u18 (ref)
            u16();
            if u19 then
                u19:Disconnect();
            end;
            if u20 then
                u20:Disconnect();
            end;
            u18:cancel();
        end);
        p17(function() --[[ Line: 203 ]]
            -- upvalues: u19 (ref), u20 (ref), u18 (ref)
            if u19 then
                u19:Disconnect();
            end;
            if u20 then
                u20:Disconnect();
            end;
            u18:cancel();
        end);
    end);
end;
function u1.enterMenu(u21, p22, p23, p24) --[[ Line: 209 ]]
    -- upvalues: l__Classes__6 (copy), l__LocalPlayer__7 (copy), u2 (copy), l__RunService__1 (copy)
    if l__Classes__6._x8399b2bb73e12808 then
        l__Classes__6._x8399b2bb73e12808:_xfe8f1e78d32e7ce0(p24 == "FFA");
    end;
    if l__Classes__6._xf1ad98d2d70b7408 then
        l__Classes__6._xf1ad98d2d70b7408:_x9a7b8c3e8ffd27b6("menu", true);
    end;
    u21.in_menu = true;
    local v25 = l__LocalPlayer__7.PlayerGui:FindFirstChild("GameplayUI");
    if v25 then
        v25.Enabled = false;
    end;
    if u21.current_session then
        u21.current_session:cleanUp();
        u21.current_session = nil;
    end;
    local l__MenuSession__13 = require(script.MenuSession);
    local v26;
    if p24 == "PUBLIC_LOBBY" then
        local l__PUBLIC_LOBBY__14 = u2.PUBLIC_LOBBY;
        v26 = {
            nav_buttons = table.clone(l__PUBLIC_LOBBY__14.nav_buttons),
            misc_buttons = table.clone(l__PUBLIC_LOBBY__14.misc_buttons),
            tracker_data = p23
        };
    else
        local l__FFA__15 = u2.FFA;
        v26 = {
            nav_buttons = table.clone(l__FFA__15.nav_buttons),
            misc_buttons = table.clone(l__FFA__15.misc_buttons),
            tracker_data = p23
        };
    end;
    local v27 = l__MenuSession__13.new(u21.screen, v26);
    u21.current_session = v27;
    v27:start(p22);
    if u21.tooltip_con then
        warn("CONFLICTING CONNECTION FOR TOOLTIP");
        u21.tooltip_con:Disconnect();
        u21.tooltip_con = nil;
    end;
    u21.tooltip_con = l__RunService__1.RenderStepped:Connect(function(_) --[[ Line: 245 ]]
        -- upvalues: u21 (copy)
        u21:processTooltip();
    end);
    l__Classes__6._xb6e091f68afb5ee8:_xba28441e0836bc41(p22);
    v27.trove:Add(function() --[[ Line: 250 ]]
        -- upvalues: l__Classes__6 (ref)
        l__Classes__6._xb6e091f68afb5ee8:cleanUp();
    end);
end;
function u1.mountMenu(u28, p29) --[[ Line: 255 ]]
    -- upvalues: l__Classes__6 (copy), l__LocalPlayer__7 (copy), u2 (copy), l__RunService__1 (copy)
    if l__Classes__6._xf1ad98d2d70b7408 then
        l__Classes__6._xf1ad98d2d70b7408:_x9a7b8c3e8ffd27b6("menu", true);
    end;
    u28.in_menu = true;
    local v30 = l__LocalPlayer__7.PlayerGui:FindFirstChild("GameplayUI");
    if v30 then
        v30.Enabled = false;
    end;
    if u28.current_session then
        u28.current_session:cleanUp();
        u28.current_session = nil;
    end;
    local v31;
    if p29 == "PUBLIC_LOBBY" then
        local l__PUBLIC_LOBBY__16 = u2.PUBLIC_LOBBY;
        v31 = {
            tracker_data = nil,
            nav_buttons = table.clone(l__PUBLIC_LOBBY__16.nav_buttons),
            misc_buttons = table.clone(l__PUBLIC_LOBBY__16.misc_buttons)
        };
    else
        local l__FFA__17 = u2.FFA;
        v31 = {
            tracker_data = nil,
            nav_buttons = table.clone(l__FFA__17.nav_buttons),
            misc_buttons = table.clone(l__FFA__17.misc_buttons)
        };
    end;
    local v32 = require(script.MenuSession).new(u28.screen, v31);
    u28.current_session = v32;
    v32:start(false);
    if u28.tooltip_con then
        warn("CONFLICTING CONNECTION FOR TOOLTIP");
        u28.tooltip_con:Disconnect();
        u28.tooltip_con = nil;
    end;
    u28.tooltip_con = l__RunService__1.RenderStepped:Connect(function(_) --[[ Line: 290 ]]
        -- upvalues: u28 (copy)
        u28:processTooltip();
    end);
end;
function u1.listenForEvents(u33) --[[ Line: 296 ]]
    -- upvalues: l__Classes__6 (copy), l__Packets__4 (copy)
    if l__Classes__6._xf1ad98d2d70b7408 then
        l__Classes__6._xf1ad98d2d70b7408:_x93fd21adac562b5e("MENU_OPEN").Pressed:Connect(function() --[[ Line: 298 ]]
            -- upvalues: u33 (copy), l__Packets__4 (ref), l__Classes__6 (ref)
            if u33.in_menu then
            elseif u33:_canRequestMenu() then
                if l__Packets__4._xe19bd04b1425e9fa:Fire() == false and l__Classes__6._x6a15bbeeb97caae0 then
                    l__Classes__6._x6a15bbeeb97caae0._x169361cbea19e64b.attempt_connect:Fire();
                end;
            end;
        end);
    end;
    l__Packets__4._xebecb58ecfa71a67.OnClientEvent:Connect(function(p34, p35, p36) --[[ Line: 313 ]]
        -- upvalues: u33 (copy), l__Classes__6 (ref)
        if p36 == "PUBLIC_LOBBY" then
            u33:mountMenu(p36);
        else
            u33:enterMenu(p34, p35, p36);
        end;
        if l__Classes__6._x9a86d5566d6a5327 then
            l__Classes__6._x9a86d5566d6a5327:_xad7fa18a5a354dc6();
        end;
    end);
end;
function u1.Init(p37) --[[ Line: 325 ]]
    -- upvalues: l__LocalPlayer__7 (copy)
    require(script.MenuSession).initPolicyInfo();
    p37:listenForEvents();
    p37.screen.Parent = l__LocalPlayer__7.PlayerGui;
end;
u1._x83ed94bfb82a8c9f = u1.new;
u1._x44bcd6af41218f92 = u1.Init;
return u1;
