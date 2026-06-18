-- Decompiled from: Start.Client.Classes.MenuManager.MenuVisuals
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
game:GetService("ContentProvider");
local l__ModuleScripts__3 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
require(l__ModuleScripts__3.Packets);
require(l__ModuleScripts__3.Signal);
local l__Promise__4 = require(l__ModuleScripts__3.Promise);
local l__Trove__5 = require(l__ModuleScripts__3.Trove);
local u1 = {};
u1.__index = u1;
local l__Classes__6 = require(script.Parent.Parent.Parent.ClientRoot).Classes;
local l__LocalPlayer__7 = game.Players.LocalPlayer;
local l__UIAssets__8 = game:GetService("ReplicatedStorage").Assets.UIAssets;
function u1.new() --[[ Line: 23 ]]
    -- upvalues: u1 (copy), l__Trove__5 (copy)
    local v2 = setmetatable({}, u1);
    v2.preloaded = {};
    v2.menu_trove = l__Trove__5.new();
    return v2;
end;
function u1.Init(p3) --[[ Line: 34 ]]
    -- upvalues: l__UIAssets__8 (copy)
    p3.preloaded.MenuLogin = l__UIAssets__8.MenuLogin:Clone();
end;
function u1.bootSequence(u4) --[[ Line: 38 ]]
    -- upvalues: l__Promise__4 (copy), l__Classes__6 (copy), l__TweenService__2 (copy), l__RunService__1 (copy), l__LocalPlayer__7 (copy)
    return l__Promise__4.new(function(u5, _, _) --[[ Line: 39 ]]
        -- upvalues: l__Classes__6 (ref), u4 (copy), l__TweenService__2 (ref), l__Promise__4 (ref), l__RunService__1 (ref), l__LocalPlayer__7 (ref)
        l__Classes__6._xfaee1d1d64cdfe93:_x3f8b63442918abf2(-1);
        l__Classes__6._xbe184fb1376a575d:_x7ab8b42cc5920a78("TAPE_START", true);
        local l__MenuLogin__9 = u4.preloaded.MenuLogin;
        l__MenuLogin__9.Parent = u4.screen;
        l__MenuLogin__9.Visible = true;
        l__MenuLogin__9.StartFlash.Visible = true;
        l__MenuLogin__9.TextArray.Visible = false;
        l__MenuLogin__9.BlackFrame.Visible = false;
        l__MenuLogin__9.OverblackFrame.Visible = false;
        l__MenuLogin__9.WhiteFrame.Visible = false;
        local u6 = Instance.new("ColorCorrectionEffect");
        u6.Saturation = -1;
        u6.Contrast = 2;
        u6.Parent = game:GetService("Lighting");
        local u7 = Instance.new("BlurEffect");
        u7.Size = 10;
        u7.Parent = game:GetService("Lighting");
        local v8 = {};
        local v9 = Instance.new("NumberValue");
        v9.Value = 10;
        v8.value = v9;
        v8.cancel_when_zero = true;
        l__Classes__6._x32ae459de0772e82:_x8ca42af5fe3be726(v8);
        l__TweenService__2:Create(v9, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = 0
        }):Play();
        l__MenuLogin__9.StartFlash.Size = UDim2.fromScale(3, 1.5);
        l__TweenService__2:Create(l__MenuLogin__9.StartFlash, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(1, 1)
        }):Play();
        l__Promise__4.delay(0.2):andThen(function() --[[ Line: 75 ]]
            -- upvalues: u6 (copy), u7 (copy), l__MenuLogin__9 (copy), l__TweenService__2 (ref), l__RunService__1 (ref), l__LocalPlayer__7 (ref), l__Classes__6 (ref), u5 (copy)
            u6:Destroy();
            u7:Destroy();
            l__MenuLogin__9.StartFlash.Visible = false;
            l__MenuLogin__9.OverblackFrame.Visible = false;
            l__MenuLogin__9.WhiteFrame.Visible = false;
            l__MenuLogin__9.TextArray.Visible = true;
            l__MenuLogin__9.BlackFrame.Visible = true;
            l__MenuLogin__9.TextArray.Size = UDim2.fromScale(1, 1);
            l__TweenService__2:Create(l__MenuLogin__9.TextArray, TweenInfo.new(0.8, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(0.45, 0.5)
            }):Play();
            for v10, v11 in {
                "Bootlog",
                "Auth",
                "Root",
                "Trace",
                "Cache",
                "Decalibrated",
                "Synced"
            } do
                local u12 = l__MenuLogin__9.TextArray:FindFirstChild(v11):FindFirstChildWhichIsA("TextLabel");
                u12.Position = UDim2.fromScale(-2, 0);
                task.delay(0.03 * v10, function() --[[ Line: 93 ]]
                    -- upvalues: l__TweenService__2 (ref), u12 (copy)
                    l__TweenService__2:Create(u12, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                        Position = UDim2.fromScale(0, 0)
                    }):Play();
                end);
            end;
            l__MenuLogin__9.TextArray.Seer.TextLabel.TextTransparency = 1;
            l__MenuLogin__9.TextArray.Seer.Frame.BackgroundTransparency = 1;
            task.delay(0.3, function() --[[ Line: 102 ]]
                -- upvalues: l__TweenService__2 (ref), l__MenuLogin__9 (ref)
                l__TweenService__2:Create(l__MenuLogin__9.TextArray.Seer.TextLabel, TweenInfo.new(0.3, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                    TextTransparency = 0
                }):Play();
                l__TweenService__2:Create(l__MenuLogin__9.TextArray.Seer.Frame, TweenInfo.new(0.3, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 0
                }):Play();
            end);
            task.delay(0.7, function() --[[ Line: 108 ]]
                -- upvalues: l__MenuLogin__9 (ref), l__TweenService__2 (ref), l__RunService__1 (ref), l__LocalPlayer__7 (ref), l__Classes__6 (ref), u5 (ref)
                local l__OverblackFrame__10 = l__MenuLogin__9.OverblackFrame;
                l__OverblackFrame__10.Size = UDim2.fromScale(1.3, 1.3);
                l__OverblackFrame__10.ImageLabel.ImageTransparency = 1;
                l__OverblackFrame__10.Timer.TextTransparency = 1;
                l__OverblackFrame__10.OS.TextTransparency = 1;
                l__TweenService__2:Create(l__OverblackFrame__10, TweenInfo.new(1.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(1, 1)
                }):Play();
                l__OverblackFrame__10.Visible = true;
                l__OverblackFrame__10.Welcome.TextTransparency = 1;
                l__OverblackFrame__10.NameText.TextTransparency = 1;
                l__OverblackFrame__10.BackgroundTransparency = 1;
                l__TweenService__2:Create(l__OverblackFrame__10, TweenInfo.new(0.2, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 0
                }):Play();
                task.delay(0.3, function() --[[ Line: 120 ]]
                    -- upvalues: l__RunService__1 (ref), l__TweenService__2 (ref), l__OverblackFrame__10 (copy), l__LocalPlayer__7 (ref), l__Classes__6 (ref), l__MenuLogin__9 (ref), u5 (ref)
                    local function v29(u13, u14, p15) --[[ Line: 121 ]]
                        -- upvalues: l__RunService__1 (ref), l__TweenService__2 (ref), l__OverblackFrame__10 (ref)
                        local v16;
                        if typeof(u13) == "Instance" then
                            v16 = u13:IsA("TextLabel");
                        else
                            v16 = false;
                        end;
                        assert(v16);
                        local u17 = #u14;
                        if u17 == 0 then
                        else
                            u13.Text = "";
                            local v18 = p15 / u17;
                            local u19 = {};
                            for v20 = 1, u17 do
                                table.insert(u19, {
                                    type = "placeholder",
                                    time = (v20 - 1) * v18,
                                    index = v20
                                });
                                table.insert(u19, {
                                    type = "reveal",
                                    time = v20 * v18,
                                    index = v20
                                });
                            end;
                            table.sort(u19, function(p21, p22) --[[ Line: 134 ]]
                                return p21.time < p22.time;
                            end);
                            local u23 = os.clock();
                            local u24 = nil;
                            u24 = l__RunService__1.Heartbeat:Connect(function() --[[ Line: 138 ]]
                                -- upvalues: u23 (copy), u19 (copy), u13 (copy), u14 (copy), u17 (copy), u24 (ref), l__TweenService__2 (ref), l__OverblackFrame__10 (ref)
                                local v25 = os.clock() - u23;
                                while #u19 > 0 and u19[1].time <= v25 do
                                    local v26 = table.remove(u19, 1);
                                    if v26.type == "placeholder" then
                                        u13.Text = u14:sub(1, v26.index - 1) .. "|";
                                    else
                                        u13.Text = u14:sub(1, v26.index);
                                        if v26.index == u17 then
                                            u24:Disconnect();
                                            local v27 = u13:Clone();
                                            v27.BackgroundTransparency = 0;
                                            v27.TextTransparency = 1;
                                            v27.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                                            v27.Parent = u13.Parent;
                                            l__TweenService__2:Create(v27, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                                                BackgroundTransparency = 1
                                            }):Play();
                                            local v28 = TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out);
                                            l__TweenService__2:Create(l__OverblackFrame__10.ImageLabel, v28, {
                                                ImageTransparency = 0.5
                                            }):Play();
                                            l__TweenService__2:Create(l__OverblackFrame__10.Timer, v28, {
                                                TextTransparency = 0
                                            }):Play();
                                            l__TweenService__2:Create(l__OverblackFrame__10.OS, v28, {
                                                TextTransparency = 0
                                            }):Play();
                                            game.Debris:AddItem(v27, 0.55);
                                        end;
                                    end;
                                end;
                            end);
                        end;
                    end;
                    local u30 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
                    l__TweenService__2:Create(l__OverblackFrame__10.Welcome, u30, {
                        TextTransparency = 0
                    }):Play();
                    l__TweenService__2:Create(l__OverblackFrame__10.NameText, u30, {
                        TextTransparency = 0
                    }):Play();
                    local v31 = l__LocalPlayer__7.Name:upper();
                    v29(l__OverblackFrame__10.NameText, v31, 0.4);
                    task.delay(0.3, function() --[[ Line: 176 ]]
                        -- upvalues: l__Classes__6 (ref)
                        l__Classes__6._xbe184fb1376a575d:_x7ab8b42cc5920a78("PHONE_ANSWER", true);
                        l__Classes__6._xfaee1d1d64cdfe93:_x8fcdafeb8ad3312d("menu");
                    end);
                    task.delay(0.8, function() --[[ Line: 181 ]]
                        -- upvalues: l__TweenService__2 (ref), l__OverblackFrame__10 (ref), u30 (copy), l__Classes__6 (ref), l__MenuLogin__9 (ref), u5 (ref)
                        l__TweenService__2:Create(l__OverblackFrame__10.Welcome, u30, {
                            TextTransparency = 1
                        }):Play();
                        l__TweenService__2:Create(l__OverblackFrame__10.NameText, u30, {
                            TextTransparency = 1
                        }):Play();
                        game:GetService("Lighting").ExposureCompensation = 10;
                        l__Classes__6._x255cd8d76027f039:_xee1cb09b95057806(1.5, 10);
                        l__TweenService__2:Create(game:GetService("Lighting"), TweenInfo.new(1.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                            ExposureCompensation = 0
                        }):Play();
                        task.delay(0.15, function() --[[ Line: 190 ]]
                            -- upvalues: l__MenuLogin__9 (ref), l__TweenService__2 (ref), l__Classes__6 (ref), u5 (ref)
                            l__MenuLogin__9.WhiteFrame.Visible = true;
                            l__MenuLogin__9.WhiteFrame.BackgroundTransparency = 0;
                            local v32 = Instance.new("BlurEffect", game:GetService("Lighting"));
                            v32.Size = 30;
                            l__TweenService__2:Create(v32, TweenInfo.new(1.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                                Size = 0
                            }):Play();
                            l__Classes__6._xbe184fb1376a575d:_x7ab8b42cc5920a78("STATIC", true);
                            l__TweenService__2:Create(l__MenuLogin__9.WhiteFrame, TweenInfo.new(0.5), {
                                BackgroundTransparency = 1
                            }):Play();
                            l__MenuLogin__9.OverblackFrame.Visible = false;
                            l__MenuLogin__9.StartFlash.Visible = false;
                            l__MenuLogin__9.BlackFrame.Visible = false;
                            l__MenuLogin__9.TextArray.Visible = false;
                            task.delay(0.5, function() --[[ Line: 206 ]]
                                -- upvalues: l__MenuLogin__9 (ref), u5 (ref)
                                l__MenuLogin__9.Visible = false;
                                u5();
                            end);
                        end);
                    end);
                end);
            end);
        end);
    end);
end;
return u1;
