-- Decompiled from: Start.Client.Classes.MenuManager.MenuSession.SettingsPage
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__TweenService__1 = game:GetService("TweenService");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__ModuleScripts__3 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
require(l__ModuleScripts__3.Packets);
require(l__ModuleScripts__3.Signal);
require(l__ModuleScripts__3.Promise);
local l__Trove__4 = require(l__ModuleScripts__3.Trove);
require(l__ModuleScripts__3.Spring);
local l__UIAssets__5 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local u1 = {};
u1.__index = u1;
local l__Classes__6 = require(script.Parent.Parent.Parent.Parent.ClientRoot).Classes;
local l__InternalSymbols__7 = require(script.Parent.Parent.Parent.Parent.InternalSymbols);
local l__LocalPlayer__8 = game.Players.LocalPlayer;
function u1.new(p2, p3) --[[ Line: 25 ]]
    -- upvalues: u1 (copy), l__InternalSymbols__7 (copy), l__Trove__4 (copy), l__UIAssets__5 (copy)
    local v4 = setmetatable({}, u1);
    v4.menu_session = l__InternalSymbols__7.owner("MenuSession", p3);
    v4.parent_os = p2;
    v4.trove = l__Trove__4.new();
    v4.config = nil;
    v4.page_origin = l__UIAssets__5.Menu.SettingsPage;
    v4.main_page = v4.page_origin.SettingsFrame:Clone();
    v4.saved = false;
    v4.trove:Add(v4.main_page);
    return v4;
end;
function u1.saveChanges(p5) --[[ Line: 42 ]]
    -- upvalues: l__Classes__6 (copy)
    if p5.config and not p5.saved then
        p5.saved = true;
        l__Classes__6._x0a1db40feef2a32b:_xb850ce5141a9c1be();
        l__Classes__6._x0a1db40feef2a32b:_x392b49fd3c63be6e();
    end;
end;
function u1.cleanUp(p6) --[[ Line: 50 ]]
    p6:saveChanges();
    p6.trove:Clean();
end;
function u1.close(p7) --[[ Line: 55 ]]
    -- upvalues: l__TweenService__1 (copy)
    p7:saveChanges();
    local l__main_page__9 = p7.main_page;
    l__main_page__9.Parent = p7.parent_os.RightContainer.MainOS;
    l__main_page__9.Interactable = false;
    l__TweenService__1:Create(l__main_page__9, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 1
    }):Play();
    l__TweenService__1:Create(l__main_page__9, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
        Position = UDim2.fromScale(0, 1)
    }):Play();
end;
function u1.start(p8) --[[ Line: 65 ]]
    -- upvalues: l__TweenService__1 (copy)
    if p8.config then
        p8.saved = false;
        local _ = p8.page_origin;
        local l__main_page__10 = p8.main_page;
        l__main_page__10.Interactable = true;
        l__main_page__10.Parent = p8.parent_os.RightContainer.MainOS;
        l__main_page__10.GroupTransparency = 1;
        l__TweenService__1:Create(l__main_page__10, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            GroupTransparency = 0
        }):Play();
        l__main_page__10.Position = UDim2.fromScale(0, -0.1);
        l__TweenService__1:Create(l__main_page__10, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0, 0)
        }):Play();
        local _ = p8.page_origin;
        local l__main_page__11 = p8.main_page;
        l__TweenService__1:Create(l__main_page__11.Main.ScrollingFrame.GameplayTopbar.TextLabel, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 3, true), {
            Position = UDim2.fromScale(0.54, 0.5)
        }):Play();
        l__TweenService__1:Create(l__main_page__11.Main.ScrollingFrame.KeybindsTopbar.TextLabel, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 3, true), {
            Position = UDim2.fromScale(0.54, 0.5)
        }):Play();
        l__TweenService__1:Create(l__main_page__11.Main.ScrollingFrame.QualityTopbar.TextLabel, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 3, true), {
            Position = UDim2.fromScale(0.54, 0.5)
        }):Play();
    else
        warn("SETTINGS NOT FOUND FOR PLAYER");
    end;
end;
function u1.Init(u9) --[[ Line: 94 ]]
    -- upvalues: l__Classes__6 (copy), l__TweenService__1 (copy), l__UserInputService__2 (copy), l__LocalPlayer__8 (copy)
    local v10 = l__Classes__6._x0a1db40feef2a32b:_x2c5470dc192b8f08();
    if v10 then
        u9.config = v10;
        local l__page_origin__12 = u9.page_origin;
        local l__main_page__13 = u9.main_page;
        local l__gameplay__14 = v10.gameplay;
        if l__gameplay__14.photosensitivity_enabled == nil then
            l__gameplay__14.photosensitivity_enabled = false;
        end;
        local function v16(u11) --[[ Line: 108 ]]
            -- upvalues: l__page_origin__12 (copy), l__main_page__13 (copy), l__Classes__6 (ref), l__TweenService__1 (ref)
            local v12 = l__page_origin__12.BoolSetting:Clone();
            local l__value__15 = u11.value;
            v12.Parent = l__main_page__13.Main.ScrollingFrame:FindFirstChild(u11.setting_tab).SettingsList;
            v12.SettingName.Text = u11.setting_name;
            if u11.tooltip_text then
                v12.Inspect.Visible = true;
                l__Classes__6.MenuManager:createTooltip(v12.Inspect, u11.tooltip_text);
            else
                v12.Inspect.Visible = false;
            end;
            local l__Value__16 = v12.Value;
            local function u15(p13) --[[ Line: 124 ]]
                -- upvalues: l__value__15 (ref), l__TweenService__1 (ref), l__Value__16 (copy), l__Classes__6 (ref)
                local v14;
                if l__value__15 then
                    v14 = Color3.fromRGB(255, 255, 255);
                else
                    v14 = Color3.fromRGB(0, 0, 0);
                end;
                l__TweenService__1:Create(l__Value__16, TweenInfo.new(0.2), {
                    BackgroundColor3 = v14
                }):Play();
                if not p13 then
                    l__Classes__6._xbe184fb1376a575d:_x7ab8b42cc5920a78("TAPE_MOVE", true);
                end;
            end;
            l__Value__16.Button.MouseButton1Click:Connect(function() --[[ Line: 134 ]]
                -- upvalues: l__value__15 (ref), u15 (copy), u11 (copy)
                l__value__15 = not l__value__15;
                u15(false);
                u11.onInteract(l__value__15);
            end);
            u15(true);
        end;
        local function v23(u17) --[[ Line: 143 ]]
            -- upvalues: l__page_origin__12 (copy), l__main_page__13 (copy), l__Classes__6 (ref), l__TweenService__1 (ref)
            local v18 = l__page_origin__12.InputSetting:Clone();
            local l__value__17 = u17.value;
            v18.Parent = l__main_page__13.Main.ScrollingFrame:FindFirstChild(u17.setting_tab).SettingsList;
            v18.SettingName.Text = u17.setting_name;
            if u17.tooltip_text then
                v18.Inspect.Visible = true;
                l__Classes__6.MenuManager:createTooltip(v18.Inspect, u17.tooltip_text);
            else
                v18.Inspect.Visible = false;
            end;
            local l__Value__18 = v18.Value;
            l__Value__18.PlaceholderText = l__value__17;
            local function u20(p19) --[[ Line: 160 ]]
                -- upvalues: l__Classes__6 (ref), l__value__17 (ref), l__Value__18 (copy), l__TweenService__1 (ref)
                l__Classes__6._xbe184fb1376a575d:_x7ab8b42cc5920a78("TAPE_MOVE", true);
                l__value__17 = p19;
                l__Value__18.PlaceholderText = p19;
                l__Value__18.Text = tostring(p19);
                l__Value__18.UIStroke.Color = Color3.fromRGB(0, 255, 0);
                l__TweenService__1:Create(l__Value__18.UIStroke, TweenInfo.new(1), {
                    Color = Color3.fromRGB(255, 255, 255)
                }):Play();
            end;
            local function u21() --[[ Line: 169 ]]
                -- upvalues: l__Value__18 (copy), l__value__17 (ref), l__TweenService__1 (ref)
                l__Value__18.Text = l__value__17;
                l__Value__18.UIStroke.Color = Color3.fromRGB(255, 0, 0);
                l__TweenService__1:Create(l__Value__18.UIStroke, TweenInfo.new(1), {
                    Color = Color3.fromRGB(255, 255, 255)
                }):Play();
            end;
            l__Value__18.FocusLost:Connect(function() --[[ Line: 175 ]]
                -- upvalues: u17 (copy), l__Value__18 (copy), u20 (copy), u21 (copy)
                local v22 = u17.parseInput(l__Value__18.Text);
                if v22 then
                    u20(v22);
                else
                    u21();
                end;
            end);
        end;
        local function v34(u24) --[[ Line: 185 ]]
            -- upvalues: l__page_origin__12 (copy), l__Classes__6 (ref), l__main_page__13 (copy), l__TweenService__1 (ref), u9 (copy), l__UserInputService__2 (ref)
            local v25 = l__page_origin__12.BindSetting:Clone();
            local u26 = l__Classes__6._x3e046bec2684f59c:_xfeef7f7b762e94d9(Enum.KeyCode[u24.value]);
            v25.Parent = l__main_page__13.Main.ScrollingFrame:FindFirstChild(u24.setting_tab).SettingsList;
            v25.SettingName.Text = u24.setting_name;
            if u24.tooltip_text then
                v25.Inspect.Visible = true;
                l__Classes__6.MenuManager:createTooltip(v25.Inspect, u24.tooltip_text);
            else
                v25.Inspect.Visible = false;
            end;
            local l__Value__19 = v25.Value;
            l__Value__19.Text = u26;
            local function u28(p27) --[[ Line: 202 ]]
                -- upvalues: l__Classes__6 (ref), l__Value__19 (copy), u26 (ref), l__TweenService__1 (ref)
                l__Classes__6._xbe184fb1376a575d:_x7ab8b42cc5920a78("TAPE_MOVE", true);
                l__Value__19.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                l__Value__19.TextColor3 = Color3.fromRGB(0, 0, 0);
                u26 = p27;
                l__Value__19.Text = p27;
                l__Value__19.UIStroke.Color = Color3.fromRGB(0, 255, 0);
                l__TweenService__1:Create(l__Value__19.UIStroke, TweenInfo.new(1), {
                    Color = Color3.fromRGB(255, 255, 255)
                }):Play();
            end;
            local function u29() --[[ Line: 212 ]]
                -- upvalues: l__Value__19 (copy), u26 (ref), l__TweenService__1 (ref)
                l__Value__19.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                l__Value__19.TextColor3 = Color3.fromRGB(0, 0, 0);
                l__Value__19.Text = u26;
                l__Value__19.UIStroke.Color = Color3.fromRGB(255, 0, 0);
                l__TweenService__1:Create(l__Value__19.UIStroke, TweenInfo.new(1), {
                    Color = Color3.fromRGB(255, 255, 255)
                }):Play();
            end;
            local u30 = nil;
            local function u33() --[[ Line: 231 ]]
                -- upvalues: u30 (ref), u9 (ref), l__Value__19 (copy), l__UserInputService__2 (ref), u24 (copy), u28 (copy), u29 (copy), u26 (ref)
                if not u30 then
                    u9.parent_os.Interactable = false;
                    l__Value__19.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
                    l__Value__19.TextColor3 = Color3.fromRGB(255, 255, 255);
                    l__Value__19.Text = "_";
                    u30 = l__UserInputService__2.InputBegan:Connect(function(p31, _) --[[ Line: 238 ]]
                        -- upvalues: u24 (ref), u28 (ref), u29 (ref), u30 (ref), u9 (ref), l__Value__19 (ref), u26 (ref)
                        if p31.UserInputType == Enum.UserInputType.MouseMovement then
                        else
                            local v32 = u24.parseKeycode(p31);
                            if v32 then
                                u28(v32);
                            else
                                u29();
                            end;
                            if u30 then
                                u9.parent_os.Interactable = true;
                                l__Value__19.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                                l__Value__19.TextColor3 = Color3.fromRGB(0, 0, 0);
                                l__Value__19.Text = u26;
                                u30:Disconnect();
                                u30 = nil;
                            end;
                        end;
                    end);
                    u9.trove:Add(u30);
                end;
            end;
            l__Value__19.MouseButton1Click:Connect(function() --[[ Line: 254 ]]
                -- upvalues: u33 (copy)
                u33();
            end);
        end;
        local function v43(u35) --[[ Line: 264 ]]
            -- upvalues: l__page_origin__12 (copy), l__main_page__13 (copy), l__Classes__6 (ref)
            local v36 = l__page_origin__12.SwitchSetting:Clone();
            local l__options__20 = u35.options;
            local u37 = 1;
            local v38 = table.find(u35.options, u35.current_value);
            if v38 then
                u37 = v38;
            else
                warn("NO SUCH VALUE AVAILABLE FOR CURRENT OPTIONS :", l__options__20, "VALUE :", u35.current_value, (typeof(u35.current_value)));
            end;
            v36.Parent = l__main_page__13.Main.ScrollingFrame:FindFirstChild(u35.setting_tab).SettingsList;
            v36.SettingName.Text = u35.setting_name;
            if u35.tooltip_text then
                v36.Inspect.Visible = true;
                l__Classes__6.MenuManager:createTooltip(v36.Inspect, u35.tooltip_text);
            else
                v36.Inspect.Visible = false;
            end;
            local l__Value__21 = v36.Value;
            local l__CurrentState__22 = v36.Value.CurrentState;
            local function u41(p39) --[[ Line: 289 ]]
                -- upvalues: l__options__20 (copy), u37 (ref), l__CurrentState__22 (copy), l__Value__21 (copy), l__Classes__6 (ref), u35 (copy)
                local v40 = l__options__20[u37];
                l__CurrentState__22.Text = v40;
                if u37 == 1 then
                    l__Value__21.LeftButton.ImageTransparency = 0.5;
                else
                    l__Value__21.LeftButton.ImageTransparency = 0;
                end;
                if u37 == #l__options__20 then
                    l__Value__21.RightButton.ImageTransparency = 0.5;
                else
                    l__Value__21.RightButton.ImageTransparency = 0;
                end;
                if not p39 then
                    l__Classes__6._xbe184fb1376a575d:_x7ab8b42cc5920a78("TAPE_MOVE", true);
                end;
                u35.onInteract(v40, u37);
            end;
            l__Value__21.LeftButton.MouseButton1Click:Connect(function() --[[ Line: 311 ]]
                -- upvalues: u37 (ref), l__options__20 (copy), u41 (copy)
                u37 = math.clamp(u37 - 1, 1, #l__options__20);
                u41();
            end);
            l__Value__21.RightButton.MouseButton1Click:Connect(function() --[[ Line: 316 ]]
                -- upvalues: u37 (ref), l__options__20 (copy), u41 (copy)
                u37 = math.clamp(u37 + 1, 1, #l__options__20);
                u41();
            end);
            local v42 = l__options__20[u37];
            l__CurrentState__22.Text = v42;
            if u37 == 1 then
                l__Value__21.LeftButton.ImageTransparency = 0.5;
            else
                l__Value__21.LeftButton.ImageTransparency = 0;
            end;
            if u37 == #l__options__20 then
                l__Value__21.RightButton.ImageTransparency = 0.5;
            else
                l__Value__21.RightButton.ImageTransparency = 0;
            end;
            u35.onInteract(v42, u37);
        end;
        v43({
            setting_tab = "GameplayBody",
            setting_name = "WALLRUN INPUT :",
            tooltip_text = "Change mode of wallrun activation to hold/release or toggled.",
            options = { "Toggle", "Hold" },
            current_value = l__gameplay__14.wallrun_input,
            onInteract = function(p44) --[[ Name: onInteract, Line 330 ]]
                -- upvalues: u9 (copy)
                u9.config.gameplay.wallrun_input = p44;
            end
        });
        v43({
            setting_tab = "QualityBody",
            setting_name = "EFFECT QUALITY :",
            options = { "Potato", "Reduced", "Standard" },
            current_value = l__gameplay__14.effect_quality,
            onInteract = function(p45) --[[ Name: onInteract, Line 340 ]]
                -- upvalues: u9 (copy)
                u9.config.gameplay.effect_quality = p45;
            end
        });
        v16({
            setting_tab = "QualityBody",
            setting_name = "PHOTOSENSITIVE MODE :",
            tooltip_text = "Darkens bright flashes. Continue to play with caution if you are sensitive to flashing lights.",
            value = l__gameplay__14.photosensitivity_enabled,
            onInteract = function(p46) --[[ Name: onInteract, Line 350 ]]
                -- upvalues: l__Classes__6 (ref), u9 (copy)
                l__Classes__6._x255cd8d76027f039:_x94162666f637b130(p46);
                u9.config.gameplay.photosensitivity_enabled = p46;
            end
        });
        v43({
            setting_tab = "GameplayBody",
            setting_name = "REQUEST MODE :",
            tooltip_text = "Control who is allowed to send you a duel/lobby request.",
            options = { "All", "Friends Only", "Disabled" },
            current_value = l__gameplay__14.duel_request_mode,
            onInteract = function(p47) --[[ Name: onInteract, Line 362 ]]
                -- upvalues: u9 (copy)
                u9.config.gameplay.duel_request_mode = p47;
            end
        });
        v43({
            setting_tab = "GameplayBody",
            setting_name = "CONTRACT NOTIFS :",
            tooltip_text = "Control when you get notifications about your Contracts.",
            options = { "All", "Only Completion", "Disabled" },
            current_value = l__gameplay__14.contract_notifs,
            onInteract = function(p48) --[[ Name: onInteract, Line 373 ]]
                -- upvalues: u9 (copy)
                u9.config.gameplay.contract_notifs = p48;
            end
        });
        v16({
            setting_tab = "QualityBody",
            setting_name = "SHADOWS :",
            value = l__gameplay__14.shadows_enabled,
            onInteract = function(p49) --[[ Name: onInteract, Line 382 ]]
                -- upvalues: u9 (copy)
                u9.config.gameplay.shadows_enabled = p49;
            end
        });
        v16({
            setting_tab = "GameplayBody",
            setting_name = "STRAFE ASSIST :",
            tooltip_text = "Holding W lets you automatically strafe into your camera direction. Disable for GoldSrc strafing.",
            value = l__gameplay__14.strafe_assist,
            onInteract = function(p50) --[[ Name: onInteract, Line 392 ]]
                -- upvalues: u9 (copy)
                u9.config.gameplay.strafe_assist = p50;
            end
        });
        v16({
            setting_tab = "GameplayBody",
            setting_name = "DYNAMIC MUSIC :",
            tooltip_text = "Combat music is dampened and kicks in when in combat. Disable to always make it play normally.",
            value = l__gameplay__14.dynamic_music,
            onInteract = function(p51) --[[ Name: onInteract, Line 402 ]]
                -- upvalues: u9 (copy)
                u9.config.gameplay.dynamic_music = p51;
            end
        });
        v16({
            setting_tab = "GameplayBody",
            setting_name = "MUTE MUSIC :",
            value = l__gameplay__14.mute_music,
            onInteract = function(p52) --[[ Name: onInteract, Line 411 ]]
                -- upvalues: l__Classes__6 (ref), u9 (copy)
                l__Classes__6._xfaee1d1d64cdfe93._x9d953ef0950533a5 = p52;
                u9.config.gameplay.mute_music = p52;
            end
        });
        v23({
            setting_tab = "GameplayBody",
            setting_name = "(70-100) FOV :",
            tooltip_text = "FOV above 90 may have viewmodel visual artifacts.",
            value = l__gameplay__14.fov,
            parseInput = function(p53) --[[ Name: parseInput, Line 422 ]]
                -- upvalues: u9 (copy)
                local v54 = tonumber(p53);
                if typeof(v54) == "number" then
                    local v55 = math.clamp(p53, 70, 100);
                    u9.config.gameplay.fov = v55;
                    return v55;
                end;
            end
        });
        local l__keybinds__23 = u9.config.keybinds;
        for _, u56 in {
            "melee",
            "parry",
            "gun",
            "augment",
            "interact",
            "empty",
            "dash",
            "slide",
            "jump"
        } do
            if u56 == "empty" then
                l__page_origin__12.Empty:Clone().Parent = l__main_page__13.Main.ScrollingFrame:FindFirstChild("KeybindsBody").SettingsList;
            else
                local v57 = u56 == "augment" and "Your movement augment. (Grappler)" or nil;
                v34({
                    setting_tab = "KeybindsBody",
                    setting_name = u56:upper() .. " :",
                    value = l__keybinds__23[u56],
                    tooltip_text = v57,
                    parseKeycode = function(p58) --[[ Name: parseKeycode, Line 460 ]]
                        -- upvalues: l__Classes__6 (ref), u56 (copy), l__keybinds__23 (copy), l__main_page__13 (copy), l__TweenService__1 (ref)
                        local v59 = l__Classes__6._x3e046bec2684f59c:_xa9cc6ab994677574(p58);
                        if l__Classes__6._x3e046bec2684f59c:_xe8233003806bed87(u56:upper(), v59) then
                            l__keybinds__23[u56] = v59.Name;
                            return l__Classes__6._x3e046bec2684f59c:_xfeef7f7b762e94d9(v59);
                        end;
                        local l__Conflicts__24 = l__main_page__13.Main.ScrollingFrame:FindFirstChild("KeybindsBody").Conflicts;
                        l__Conflicts__24.TextTransparency = 0;
                        l__TweenService__1:Create(l__Conflicts__24, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                            TextTransparency = 1
                        }):Play();
                    end
                });
            end;
        end;
        local function v73(u60, u61) --[[ Line: 478 ]]
            -- upvalues: l__TweenService__1 (ref), l__Classes__6 (ref)
            local v62 = u60:FindFirstChildWhichIsA("TextButton");
            local u63 = false;
            local function u68(p64) --[[ Line: 482 ]]
                -- upvalues: u63 (ref), l__TweenService__1 (ref), u60 (copy), l__Classes__6 (ref), u61 (copy)
                u63 = true;
                l__TweenService__1:Create(u60.CircleFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Rotation = 45
                }):Play();
                if not p64 then
                    l__Classes__6._xbe184fb1376a575d:_x7ab8b42cc5920a78("TAPE_SELECT", true);
                end;
                local v65 = 0;
                for _, v66 in u61.SettingsList:GetChildren() do
                    if v66:IsA("Frame") then
                        local v67 = v65 + 5;
                        if v66.Name == "Empty" then
                            v65 = v67 + 20;
                        else
                            v65 = v67 + 30;
                        end;
                    end;
                end;
                l__TweenService__1:Create(u61, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    Size = UDim2.new(1, 0, 0, v65)
                }):Play();
            end;
            local function u70(p69) --[[ Line: 503 ]]
                -- upvalues: u63 (ref), l__TweenService__1 (ref), u60 (copy), l__Classes__6 (ref), u61 (copy)
                u63 = false;
                l__TweenService__1:Create(u60.CircleFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Rotation = 0
                }):Play();
                if not p69 then
                    l__Classes__6._xbe184fb1376a575d:_x7ab8b42cc5920a78("TAPE_SELECT", true);
                end;
                l__TweenService__1:Create(u61, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    Size = UDim2.new(1, 0, 0, 0)
                }):Play();
            end;
            local function v72(p71) --[[ Line: 512 ]]
                -- upvalues: u63 (ref), u70 (copy), u68 (copy)
                if u63 then
                    u70(p71);
                else
                    u68(p71);
                end;
            end;
            u70(true);
            v62.MouseButton1Click:Connect(v72);
        end;
        local l__GameplayTopbar__25 = l__main_page__13.Main.ScrollingFrame.GameplayTopbar;
        local l__GameplayBody__26 = l__main_page__13.Main.ScrollingFrame.GameplayBody;
        local l__KeybindsTopbar__27 = l__main_page__13.Main.ScrollingFrame.KeybindsTopbar;
        local l__KeybindsBody__28 = l__main_page__13.Main.ScrollingFrame.KeybindsBody;
        local l__QualityTopbar__29 = l__main_page__13.Main.ScrollingFrame.QualityTopbar;
        local l__QualityBody__30 = l__main_page__13.Main.ScrollingFrame.QualityBody;
        v73(l__GameplayTopbar__25, l__GameplayBody__26);
        v73(l__KeybindsTopbar__27, l__KeybindsBody__28);
        v73(l__QualityTopbar__29, l__QualityBody__30);
        local u74 = nil;
        u74 = game:GetService("Players").PlayerRemoving:Connect(function(p75) --[[ Line: 539 ]]
            -- upvalues: l__LocalPlayer__8 (ref), u9 (copy), u74 (ref)
            if p75 == l__LocalPlayer__8 then
                u9:saveChanges();
                u74:Disconnect();
                u74 = nil;
            end;
        end);
        u9.trove:Add(u74);
    end;
end;
return u1;
