-- Decompiled from: Start.Client.Classes.MenuManager.MenuSession.ClaimPage
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
local l__UserInputService__3 = game:GetService("UserInputService");
local l__ModuleScripts__4 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
require(l__ModuleScripts__4.Packets);
require(l__ModuleScripts__4.Signal);
local l__Promise__5 = require(l__ModuleScripts__4.Promise);
local l__Trove__6 = require(l__ModuleScripts__4.Trove);
require(l__ModuleScripts__4.Spring);
local l__UIAssets__7 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local u1 = {};
u1.__index = u1;
local l__Classes__8 = require(script.Parent.Parent.Parent.Parent.ClientRoot).Classes;
local l__InternalSymbols__9 = require(script.Parent.Parent.Parent.Parent.InternalSymbols);
local _ = game.Players.LocalPlayer;
function u1.new(p2, p3) --[[ Line: 25 ]]
    -- upvalues: u1 (copy), l__InternalSymbols__9 (copy), l__Trove__6 (copy)
    local v4 = setmetatable({}, u1);
    v4.menu_session = l__InternalSymbols__9.owner("MenuSession", p3);
    v4.parent_os = p2;
    v4.trove = l__Trove__6.new();
    v4.finished = false;
    return v4;
end;
function u1.close(u5) --[[ Line: 37 ]]
    -- upvalues: l__TweenService__2 (copy)
    if u5.main_page then
        l__TweenService__2:Create(u5.main_page, TweenInfo.new(0.5), {
            GroupTransparency = 1
        }):Play();
    end;
    task.delay(0.5, function() --[[ Line: 42 ]]
        -- upvalues: u5 (copy)
        u5.trove:Clean();
    end);
end;
function u1.cleanUp(p6) --[[ Line: 47 ]]
    p6:close();
end;
function u1.start(u7, u8) --[[ Line: 51 ]]
    -- upvalues: l__UIAssets__7 (copy), l__TweenService__2 (copy), l__Promise__5 (copy), l__RunService__1 (copy), l__Classes__8 (copy), l__UserInputService__3 (copy)
    local l__ClaimPage__10 = l__UIAssets__7.Menu.ClaimPage;
    local u9 = l__UIAssets__7.Menu.ClaimPage.ClaimFrame:Clone();
    u7.main_page = u9;
    u9.Parent = u7.parent_os.RightContainer.MainOS;
    u7.trove:Add(u9);
    l__TweenService__2:Create(u9.Shadow, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.4
    }):Play();
    local u13 = l__Promise__5.new(function(u10, _, p11) --[[ Line: 91 ]]
        -- upvalues: u9 (copy), l__TweenService__2 (ref), l__Promise__5 (ref)
        u9.Main.Position = UDim2.fromScale(0.485, 0.62);
        l__TweenService__2:Create(u9.Main.ClaimDeco.Bot, TweenInfo.new(1), {
            BackgroundTransparency = 0.5
        }):Play();
        l__TweenService__2:Create(u9.Main.ClaimDeco.Top, TweenInfo.new(1), {
            BackgroundTransparency = 0.5
        }):Play();
        l__TweenService__2:Create(u9.Main.ClaimDeco.Bot, TweenInfo.new(1), {
            BackgroundTransparency = 0.5
        }):Play();
        l__TweenService__2:Create(u9.Main.Flavor, TweenInfo.new(1), {
            TextTransparency = 0
        }):Play();
        l__TweenService__2:Create(u9.Main.Report, TweenInfo.new(1), {
            TextTransparency = 0
        }):Play();
        l__TweenService__2:Create(u9.Main.ClaimDeco, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(1, 0.5)
        }):Play();
        local u12 = l__Promise__5.delay(0.8);
        u12:finally(function() --[[ Line: 104 ]]
            -- upvalues: u10 (copy)
            u10();
        end);
        p11(function() --[[ Line: 108 ]]
            -- upvalues: u12 (copy)
            u12:cancel();
        end);
    end);
    local u52 = u13:finally(function() --[[ Line: 113 ]]
        -- upvalues: l__Promise__5 (ref), l__TweenService__2 (ref), u9 (copy), u8 (copy), l__RunService__1 (ref), l__Classes__8 (ref), u7 (copy), l__ClaimPage__10 (copy)
        return l__Promise__5.new(function(u14, _, p15) --[[ Line: 114 ]]
            -- upvalues: l__TweenService__2 (ref), u9 (ref), u8 (ref), l__RunService__1 (ref), l__Classes__8 (ref), u7 (ref), l__Promise__5 (ref), l__ClaimPage__10 (ref)
            l__TweenService__2:Create(u9.Main.Payout.TotalCount, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                TextTransparency = 0
            }):Play();
            local l__ClaimList__11 = u9.Main.ClaimCanvas.ClaimList;
            local u16 = 1;
            local u17 = 0;
            local u18 = u16 * 0.8;
            local u19 = {};
            local v20 = u8.entry_earnings >= 100000;
            local u21 = 0;
            local u22 = 0;
            local l__TotalCount__12 = u9.Main.Payout.TotalCount;
            local u23 = 0;
            local u24 = l__RunService__1.Heartbeat:Connect(function() --[[ Line: 130 ]]
                -- upvalues: u22 (ref), l__Classes__8 (ref), u21 (ref), l__TotalCount__12 (copy)
                u22 = l__Classes__8.Util:numLerp(u22, u21 + 1, 0.1);
                l__TotalCount__12.Text = "¥" .. l__Classes__8.Util:formatNumber((math.floor(u22)));
            end);
            u7.trove:Add(u24);
            local function u40(u25, u26) --[[ Line: 137 ]]
                -- upvalues: l__Promise__5 (ref), l__ClaimPage__10 (ref), l__ClaimList__11 (copy), u23 (ref), l__Classes__8 (ref), u9 (ref), u21 (ref), l__TotalCount__12 (copy), l__TweenService__2 (ref), u7 (ref), u17 (ref), u18 (ref), u8 (ref), u19 (copy), u16 (ref)
                if u25.reason == "kill" then
                    return l__Promise__5.new(function(u27, _, _) --[[ Line: 139 ]]
                        -- upvalues: l__ClaimPage__10 (ref), u26 (copy), l__ClaimList__11 (ref), u25 (copy), u23 (ref), l__Classes__8 (ref), u9 (ref), u21 (ref), l__TotalCount__12 (ref), l__TweenService__2 (ref), u7 (ref), u17 (ref), u18 (ref), u8 (ref), l__Promise__5 (ref), u19 (ref), u16 (ref)
                        local v28 = l__ClaimPage__10.KillEntry:Clone();
                        v28.Size = UDim2.fromScale(1, 0);
                        v28.LayoutOrder = u26;
                        v28.Parent = l__ClaimList__11;
                        local l__victim_name__13 = u25.victim_name;
                        if l__victim_name__13 then
                            v28.Background.RightText.Text = l__victim_name__13;
                        else
                            v28.Background.RightText.Text = "N/A";
                        end;
                        local l__victim_portrait__14 = u25.victim_portrait;
                        if l__victim_portrait__14 then
                            v28.Background.MidImage.Image = l__victim_portrait__14;
                        else
                            v28.Background.MidImage.Image = "rbxassetid://76907812288385";
                        end;
                        u23 = u23 + 1;
                        if u23 > 1 then
                            v28.Background.MidText.Text = "[KILLED " .. u23 .. "x]";
                        end;
                        if u25.yen_reward then
                            local v29 = l__Classes__8.Util:formatNumber(u25.yen_reward);
                            v28.Background.LeftText.Text = "¥" .. v29;
                            local l__Recent__15 = u9.Main.Payout.Holder.Recent;
                            u21 = u21 + u25.yen_reward;
                            l__TotalCount__12.TextTransparency = 1;
                            l__TweenService__2:Create(l__TotalCount__12, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                                TextTransparency = 0
                            }):Play();
                            l__Recent__15.Text = "+¥" .. v29;
                            l__Recent__15.Position = UDim2.fromScale(0, 0.3);
                            l__Recent__15.TextTransparency = 0.3;
                            l__TweenService__2:Create(l__Recent__15, TweenInfo.new(2), {
                                TextTransparency = 1
                            }):Play();
                            l__TweenService__2:Create(l__Recent__15, TweenInfo.new(0.8, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                                Position = UDim2.new(0, 0.15)
                            }):Play();
                        else
                            v28.Background.LeftText.Text = "?";
                        end;
                        u7.menu_session:modifyCodeScroll(500, 0.4);
                        l__TweenService__2:Create(v28, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                            Size = UDim2.fromScale(1, 0.2)
                        }):Play();
                        local v30 = l__Classes__8.Util:convNumRange(u17, 0, 0.9, 0.2, 1);
                        local v31 = l__Classes__8.Util:convNumRange(u17, 0, 0.9, 0.5, 0);
                        local l__FlashGradient__16 = u9.Main.ClaimDeco.FlashGradient;
                        local v32 = l__Classes__8.Util:convNumRange(u17, 0, 0.9, 0, 1);
                        local v33 = Color3.fromRGB(255, 255, 255):Lerp(Color3.fromRGB(255, 0, 0), v32);
                        l__FlashGradient__16.Size = UDim2.fromScale(1, v30);
                        l__FlashGradient__16.BackgroundColor3 = v33;
                        l__FlashGradient__16.BackgroundTransparency = v31;
                        l__TweenService__2:Create(l__FlashGradient__16, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                            Size = UDim2.fromScale(1, 0)
                        }):Play();
                        l__TweenService__2:Create(l__FlashGradient__16, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                            BackgroundTransparency = 1
                        }):Play();
                        if u18 ~= 0.1 then
                            local v34 = l__Classes__8._x02c5f8f89640473a:_xa2c2f0587694a915("GENERIC_LONG", true);
                            local v35 = #u8.entries;
                            local l__Volume__17 = v34.Volume;
                            local v36 = l__Classes__8.Util:convNumRange(u26, 1, math.max(25, v35), 0, 1);
                            v34.Volume = l__Classes__8.Util:numLerp(l__Volume__17, 0, v36);
                            Instance.new("PitchShiftSoundEffect", v34).Octave = u17 + 1;
                            if u17 + 0.1 < 1 then
                                u17 = u17 + 0.1;
                            end;
                        end;
                        local v37 = l__Promise__5.delay(u18);
                        table.insert(u19, v37);
                        v37:finally(function() --[[ Line: 223 ]]
                            -- upvalues: u27 (copy)
                            u27();
                        end);
                        if u18 ~= 0.1 then
                            u16 = (u16 - 0.1) * 0.85 + 0.1;
                            u18 = u16 * 0.8;
                        end;
                    end);
                end;
                if u25.reason == "death" then
                    return l__Promise__5.new(function(p38, _, _) --[[ Line: 238 ]]
                        -- upvalues: l__ClaimPage__10 (ref), u26 (copy), l__ClaimList__11 (ref), l__TweenService__2 (ref), u23 (ref)
                        local v39 = l__ClaimPage__10.DeathEntry:Clone();
                        v39.Size = UDim2.fromScale(1, 0);
                        v39.LayoutOrder = u26;
                        v39.Parent = l__ClaimList__11;
                        l__TweenService__2:Create(v39, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                            Size = UDim2.fromScale(1, 0.075)
                        }):Play();
                        p38();
                        u23 = 0;
                    end);
                end;
            end;
            local v45 = (function(p41, p42) --[[ Name: computeFullParseTime, Line 253 ]]
                local l__initial_time_alpha__18 = p42.initial_time_alpha;
                local l__decay_rate__19 = p42.decay_rate;
                local l__min_time_alpha__20 = p42.min_time_alpha;
                local v43 = 0;
                for _, v44 in pairs(p41) do
                    if v44.reason == "kill" then
                        v43 = v43 + 0.8 * l__initial_time_alpha__18;
                        l__initial_time_alpha__18 = l__min_time_alpha__20 + (l__initial_time_alpha__18 - l__min_time_alpha__20) * l__decay_rate__19;
                    end;
                end;
                return v43;
            end)(u8.entries, {
                decay_rate = 0.85,
                min_time_alpha = 0.1,
                initial_time_alpha = u16
            });
            local u46;
            if v20 then
                u46 = l__Promise__5.delay(v45 - 0.7):andThen(function() --[[ Line: 279 ]]
                    -- upvalues: l__Classes__8 (ref)
                    l__Classes__8._x02c5f8f89640473a:_xa2c2f0587694a915("DNB_BUILDUP", true);
                end);
            else
                u46 = nil;
            end;
            local u48 = l__Promise__5.delay(v45):finally(function() --[[ Line: 284 ]]
                -- upvalues: u18 (ref), u19 (copy), l__Classes__8 (ref), u24 (ref), u14 (copy)
                u18 = 0.1;
                for _, v47 in u19 do
                    v47:cancel();
                end;
                table.clear(u19);
                l__Classes__8._x02c5f8f89640473a:_xa2c2f0587694a915("RELEASE2", true);
                u24:Disconnect();
                u24 = nil;
                u14();
            end);
            p15(function() --[[ Line: 296 ]]
                -- upvalues: u48 (copy), u46 (ref)
                u48:cancel();
                if u46 then
                    u46:cancel();
                end;
            end);
            task.spawn(function() --[[ Line: 303 ]]
                -- upvalues: u8 (ref), u40 (copy), l__ClaimList__11 (copy)
                for v49, v50 in u8.entries do
                    local v51 = u40(v50, v49);
                    if v51 then
                        v51:await();
                    end;
                end;
                task.delay(0.5, function() --[[ Line: 311 ]]
                    -- upvalues: u8 (ref), l__ClaimList__11 (ref)
                    if #u8.entries > 5 then
                        l__ClaimList__11.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top;
                        l__ClaimList__11.ScrollingEnabled = true;
                        l__ClaimList__11.CanvasPosition = Vector2.new(0, 1000000000);
                    end;
                end);
            end);
        end);
    end);
    local u57 = u52:finally(function() --[[ Line: 322 ]]
        -- upvalues: l__Promise__5 (ref), l__TweenService__2 (ref), u9 (copy), l__Classes__8 (ref), u8 (copy), u7 (copy)
        return l__Promise__5.new(function(u53, _, p54) --[[ Line: 323 ]]
            -- upvalues: l__TweenService__2 (ref), u9 (ref), l__Classes__8 (ref), u8 (ref), u7 (ref), l__Promise__5 (ref)
            l__TweenService__2:Create(u9.Main.Transfer, TweenInfo.new(0.1), {
                TextTransparency = 0
            }):Play();
            local l__TotalCount__21 = u9.Main.Payout.TotalCount;
            l__TotalCount__21.Text = "¥" .. l__Classes__8.Util:formatNumber(u8.entry_earnings);
            l__TotalCount__21.BackgroundTransparency = 0;
            l__TweenService__2:Create(l__TotalCount__21, TweenInfo.new(2), {
                BackgroundTransparency = 1
            }):Play();
            u9.Main.Skip.Visible = false;
            if not u7.finished then
                u7.finished = true;
                local l__YenCount__22 = u7.parent_os.CurrencyLayer.YenFrame.YenCount;
                l__YenCount__22.Text = "¥" .. l__Classes__8.Util:formatNumber(l__Classes__8._x596eb619070480ba:_x99c2a19f9a3f5eff("yen").Value);
                l__YenCount__22.Flash.BackgroundTransparency = 0;
                l__TweenService__2:Create(l__YenCount__22.Flash, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.In), {
                    BackgroundTransparency = 1
                }):Play();
            end;
            local l__Statistics__23 = u9.Main.Statistics;
            local u55 = u8.show_statistics == true;
            l__Statistics__23.Visible = u55;
            if u55 then
                l__Statistics__23.StatMain.Line1.KDTotal.Text = tostring(u8.kd_ratio);
                l__Statistics__23.StatMain.Line1.KillstreakTotal.Text = tostring(u8.highest_killstreak);
                l__Statistics__23.StatMain.Line2.AccTotal.Text = tostring(u8.shot_accuracy_percentage) .. "%";
                l__Statistics__23.StatMain.Line2.ParryTotal.Text = tostring(u8.parry_shot_percentage) .. "%";
            end;
            local u56 = l__Promise__5.delay(1.35);
            u56:finally(function() --[[ Line: 355 ]]
                -- upvalues: l__TweenService__2 (ref), u9 (ref), u55 (copy), l__Statistics__23 (copy), u53 (copy)
                l__TweenService__2:Create(u9.Main, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    Position = UDim2.fromScale(0.485, 0.57)
                }):Play();
                if u55 then
                    l__TweenService__2:Create(l__Statistics__23, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                        GroupTransparency = 0
                    }):Play();
                end;
                u53();
            end);
            p54(function() --[[ Line: 364 ]]
                -- upvalues: u56 (copy)
                u56:cancel();
            end);
        end);
    end);
    local u58 = false;
    local v60 = l__UserInputService__3.InputBegan:Connect(function(p59, _) --[[ Line: 378 ]]
        -- upvalues: u58 (ref), u13 (copy), u52 (copy), u57 (copy), u9 (copy), l__TweenService__2 (ref)
        if p59.UserInputType == Enum.UserInputType.MouseButton1 then
            if u58 then
                u13:cancel();
                u52:cancel();
                u57:cancel();
                return;
            end;
            u58 = true;
            if u9 and u9:FindFirstChild("Main") then
                u9.Main.Skip.TextTransparency = 0;
                task.delay(1, function() --[[ Line: 389 ]]
                    -- upvalues: u9 (ref), u58 (ref), l__TweenService__2 (ref)
                    if u9 and u9:FindFirstChild("Main") then
                        u58 = false;
                        l__TweenService__2:Create(u9.Main.Skip, TweenInfo.new(1), {
                            TextTransparency = 1
                        }):Play();
                    end;
                end);
            end;
        end;
    end);
    u7.trove:Add(v60);
end;
function u1.Init(_) --[[ Line: 404 ]] end;
return u1;
