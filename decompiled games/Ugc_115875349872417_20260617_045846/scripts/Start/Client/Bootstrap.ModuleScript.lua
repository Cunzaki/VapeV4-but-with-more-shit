-- Decompiled from: Start.Client.Bootstrap
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__ContentProvider__1 = game:GetService("ContentProvider");
local l__Lighting__2 = game:GetService("Lighting");
local l__Players__3 = game:GetService("Players");
local l__ReplicatedFirst__4 = game:GetService("ReplicatedFirst");
local l__ReplicatedStorage__5 = game:GetService("ReplicatedStorage");
local l__RunService__6 = game:GetService("RunService");
local l__StarterGui__7 = game:GetService("StarterGui");
local l__TeleportService__8 = game:GetService("TeleportService");
local l__TweenService__9 = game:GetService("TweenService");
local l__UserInputService__10 = game:GetService("UserInputService");
local l__Parent__11 = script.Parent.Parent;
l__Parent__11.Parent.Parent = nil;
local l__LocalPlayer__12 = l__Players__3.LocalPlayer;
local l__PlayerGui__13 = l__LocalPlayer__12:WaitForChild("PlayerGui");
local u1 = nil;
local v2 = l__TeleportService__8:GetArrivingTeleportGui();
if v2 then
    l__ReplicatedFirst__4:RemoveDefaultLoadingScreen();
    v2.Parent = l__PlayerGui__13;
end;
local v3 = l__PlayerGui__13:FindFirstChild("TeleportScreen") ~= nil;
local v4 = l__ReplicatedFirst__4:FindFirstChild("IS_MATCH_PLACE");
if v4 then
    v4 = v4.Value == true;
end;
if not (v3 or v4) then
    u1 = l__Parent__11:WaitForChild("LoadingScreen");
    u1.MainLoading.Visible = false;
    u1.Black.Visible = true;
    u1.Enabled = true;
    u1.Parent = l__PlayerGui__13;
end;
local l__ModuleScripts__14 = l__ReplicatedStorage__5:WaitForChild("Assets"):WaitForChild("ModuleScripts");
local l__ClientRoot__15 = require(script.Parent.ClientRoot);
local l__Packets__16 = require(l__ModuleScripts__14.Packets);
local l__PlaceContext__17 = require(l__ModuleScripts__14.PlaceContext);
local l__Trove__18 = require(l__ModuleScripts__14.Trove);
local u5 = false;
local u6 = false;
local u7 = false;
local function u46() --[[ Line: 75 ]]
    -- upvalues: l__Trove__18 (copy), u1 (ref), l__ReplicatedStorage__5 (copy), l__ContentProvider__1 (copy), l__Parent__11 (copy), u7 (ref), l__TweenService__9 (copy), l__Lighting__2 (copy), l__ClientRoot__15 (copy), l__RunService__6 (copy), l__UserInputService__10 (copy)
    local u8 = l__Trove__18.new();
    local l__eulogy__19 = u1:WaitForChild("eulogy");
    local l__MainLoading__20 = u1:WaitForChild("MainLoading");
    l__MainLoading__20.Visible = true;
    task.wait(1);
    local v9 = workspace:GetDescendants();
    local v10 = l__ReplicatedStorage__5:GetDescendants();
    local u11 = table.move(v9, 1, #v9, #v10 + 1, v10);
    l__ContentProvider__1:PreloadAsync({ l__Parent__11 });
    l__eulogy__19:Play();
    local u12 = 0;
    local u13 = #u11;
    local u14 = 0;
    local u15 = false;
    local u16 = {};
    local u17 = 0;
    local u18 = false;
    local function u26(p19) --[[ Line: 104 ]]
        -- upvalues: u15 (ref), l__MainLoading__20 (copy), u17 (ref), u7 (ref), u1 (ref), l__TweenService__9 (ref)
        if u15 then
        else
            local l__Loading1__21 = l__MainLoading__20.Container.Loading1;
            local u20 = math.floor(30 * p19);
            if u17 < u20 then
                u17 = u20;
                local v21 = u20 / 30;
                local v22 = 1.05 * (1 - v21) + 1 * v21;
                l__MainLoading__20.Visible = false;
                task.delay(0.06, function() --[[ Line: 125 ]]
                    -- upvalues: u15 (ref), u7 (ref), l__MainLoading__20 (ref), u1 (ref), u20 (copy)
                    if u15 or not u7 then
                    else
                        l__MainLoading__20.Visible = true;
                        local l__BLIP__22 = u1.BLIP;
                        local l__PitchShiftSoundEffect__23 = l__BLIP__22.PitchShiftSoundEffect;
                        local v23 = u20 / 30;
                        l__PitchShiftSoundEffect__23.Octave = 1 * (1 - v23) + 2 * v23;
                        l__BLIP__22:Play();
                    end;
                end);
                l__TweenService__9:Create(l__MainLoading__20, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Size = UDim2.fromScale(v22, v22)
                }):Play();
            end;
            local v24 = 30 - u20;
            local v25 = "  ► CURRENT PROGRESS... [";
            for _ = 1, u20 do
                v25 = v25 .. "■";
            end;
            for _ = 1, v24 do
                v25 = v25 .. "・";
            end;
            l__Loading1__21.Text = v25 .. "]";
        end;
    end;
    u26(0);
    task.defer(function() --[[ Line: 156 ]]
        -- upvalues: l__TweenService__9 (ref), u1 (ref), l__ContentProvider__1 (ref), u11 (copy), u16 (copy), u12 (ref), u14 (ref), u13 (copy)
        l__TweenService__9:Create(u1.Frame, TweenInfo.new(3), {
            BackgroundTransparency = 1
        }):Play();
        l__ContentProvider__1:PreloadAsync(u11, function(p27, p28) --[[ Line: 158 ]]
            -- upvalues: u16 (ref), u12 (ref), u14 (ref), u13 (ref)
            if p28 == Enum.AssetFetchStatus.Success and not u16[p27] then
                u16[p27] = true;
                u12 = u12 + 1;
                u14 = u12 / u13;
            end;
        end);
        u14 = 1;
    end);
    local u29 = os.clock();
    local l__ArtProgress__24 = l__MainLoading__20.ArtProgress;
    l__TweenService__9:Create(l__ArtProgress__24, TweenInfo.new(20, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
        Value = 1
    }):Play();
    local l__LastStretch__25 = l__MainLoading__20.LastStretch;
    l__TweenService__9:Create(l__LastStretch__25, TweenInfo.new(20, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Value = 0.6
    }):Play();
    local function u32() --[[ Line: 185 ]]
        -- upvalues: u15 (ref), l__Lighting__2 (ref), u1 (ref), l__TweenService__9 (ref), l__eulogy__19 (copy), l__MainLoading__20 (copy), l__ClientRoot__15 (ref), u8 (copy)
        if u15 then
        else
            l__Lighting__2.ExposureCompensation = 5;
            u15 = true;
            local l__SlashFrame__26 = u1.SlashFrame;
            l__SlashFrame__26.Sound:Play();
            l__TweenService__9:Create(l__eulogy__19, TweenInfo.new(0.6), {
                Volume = 0
            }):Play();
            l__TweenService__9:Create(l__SlashFrame__26, TweenInfo.new(0.5), {
                Position = UDim2.fromScale(-1, 0.5)
            }):Play();
            l__TweenService__9:Create(l__SlashFrame__26, TweenInfo.new(1.33, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut), {
                Size = UDim2.new(1, 0, 0, 0)
            }):Play();
            l__TweenService__9:Create(l__MainLoading__20.Container, TweenInfo.new(0.45, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.45, 0.5)
            }):Play();
            l__TweenService__9:Create(l__MainLoading__20.Deco, TweenInfo.new(0.45, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.55, 0.5)
            }):Play();
            l__MainLoading__20.Position = UDim2.fromScale(0.47, 0.5);
            l__TweenService__9:Create(l__MainLoading__20, TweenInfo.new(1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.5, 0.5)
            }):Play();
            task.delay(0.4, function() --[[ Line: 219 ]]
                -- upvalues: l__MainLoading__20 (ref)
                l__MainLoading__20.Container.seer.BackgroundTransparency = 0;
                l__MainLoading__20.Container.seer.TextTransparency = 0;
                task.delay(0.08, function() --[[ Line: 222 ]]
                    -- upvalues: l__MainLoading__20 (ref)
                    l__MainLoading__20.Container.seer.BackgroundTransparency = 1;
                end);
            end);
            for v30 = 1, 4 do
                local v31 = l__SlashFrame__26.ImageLabel:Clone();
                v31.Position = UDim2.fromScale(2, 0.495);
                v31.Size = UDim2.fromScale(1, 0.3 - v30 * 0.06);
                l__TweenService__9:Create(v31, TweenInfo.new(0.37), {
                    Position = UDim2.fromScale(-1, 0.495)
                }):Play();
                v31.Parent = u1;
                task.wait(0.25);
            end;
            l__TweenService__9:Create(u1.whiteflash, TweenInfo.new(0.66, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                Size = UDim2.fromScale(1, 1)
            }):Play();
            task.delay(0.7, function() --[[ Line: 243 ]]
                -- upvalues: l__ClientRoot__15 (ref), l__MainLoading__20 (ref), u1 (ref), l__TweenService__9 (ref), l__Lighting__2 (ref), u8 (ref)
                l__ClientRoot__15.Classes._x3019cc5b1f776551:_xba28441e0836bc41("menu");
                l__MainLoading__20.Visible = false;
                u1.Scanlines.Visible = false;
                u1.Black.Visible = false;
                l__TweenService__9:Create(u1.whiteflash, TweenInfo.new(0.33), {
                    BackgroundTransparency = 1
                }):Play();
                task.delay(0.4, function() --[[ Line: 249 ]]
                    -- upvalues: u1 (ref)
                    u1.Enabled = false;
                end);
                l__TweenService__9:Create(l__Lighting__2, TweenInfo.new(1), {
                    ExposureCompensation = 0
                }):Play();
                task.delay(3, function() --[[ Line: 253 ]]
                    -- upvalues: u8 (ref)
                    u8:Clean();
                end);
            end);
        end;
    end;
    local u33 = 0;
    u8:Connect(l__RunService__6.Heartbeat, function(p34) --[[ Line: 261 ]]
        -- upvalues: u29 (copy), u15 (ref), l__MainLoading__20 (copy), u33 (ref), u18 (ref), u32 (copy), u14 (ref), u1 (ref), l__ArtProgress__24 (copy), l__LastStretch__25 (copy), u26 (copy)
        local v35 = os.clock() - u29;
        local v36 = math.floor(v35);
        if not u15 then
            local l__env1__27 = l__MainLoading__20.Container.env1;
            local v37 = math.floor(v36);
            local v38 = math.max(0, v37);
            local v39 = math.floor(v38 / 3600);
            local v40 = math.floor(v38 % 3600 / 60);
            l__env1__27.Text = "[SYS] (" .. string.format("%02d:%02d:%02d", v39, v40, v38 % 60) .. ") ELAPSED";
        end;
        u33 = u33 + p34;
        if v36 >= 20 and (u18 and not u15) then
            u32();
        end;
        if v36 >= 8 and not u18 then
            u18 = true;
            l__MainLoading__20.Container.Loading.BackgroundTransparency = 0;
            task.delay(0.1, function() --[[ Line: 275 ]]
                -- upvalues: l__MainLoading__20 (ref)
                l__MainLoading__20.Container.Loading.BackgroundTransparency = 1;
            end);
            l__MainLoading__20.Container.Loading.Text = "▼ LOADING ASSETS, PRESS ANY KEY TO [SKIP] ☆";
        end;
        if u14 == 1 and not u18 then
            u18 = true;
            l__MainLoading__20.Container.Loading.BackgroundTransparency = 0;
            task.delay(0.1, function() --[[ Line: 285 ]]
                -- upvalues: l__MainLoading__20 (ref)
                l__MainLoading__20.Container.Loading.BackgroundTransparency = 1;
            end);
            l__MainLoading__20.Container.Loading.Text = "▼ LOADING ASSETS, PRESS ANY KEY TO [SKIP] ☆";
        end;
        if u33 < 0.1 then
        else
            u33 = 0;
            if u1:FindFirstChild("MainLoading") then
                local v41 = {
                    u14,
                    l__ArtProgress__24.Value,
                    l__LastStretch__25.Value,
                    1
                };
                local v42 = 0;
                for _, v43 in v41 do
                    v42 = v42 + math.clamp(v43, 0, 1);
                end;
                u26(v42 / #v41);
            end;
        end;
    end);
    local v44 = {
        "Stray too far and yout\'ll be shot. All parryable, except the 4th.",
        "Slowness is failure.",
        "Redirect your momentum, don\'t kill it.",
        "Continously jumping (Bhopping) retains momentum.",
        "Nearly everything is parryable.",
        "Guns fire at fixed timings. Be precise.",
        "A glint signals they drew their gun. Be ready to parry.",
        "When two slashes collide, you clash. Faster person wins.",
        "Taking a hit with your gun drawn cancels it. Draw wisely.",
        "Swordplay, Gunplay, Movement. Master all three.",
        "Take breaks. Nobody masters this in a day.",
        "Ammo is earned. Not given. Your gun is a trump card.",
        "Everybody is learning as you are. Kill your fears.",
        "Losing teaches what winning can\'t.",
        "The parry timing doesn\'t forgive hesitation.",
        "Everyone has a style. Find yours."
    };
    l__MainLoading__20.Container.env2.Text = "[TIP] " .. v44[math.random(1, #v44)];
    u8:Connect(l__UserInputService__10.InputBegan, function(_, p45) --[[ Line: 329 ]]
        -- upvalues: u18 (ref), u32 (copy)
        if p45 then
        else
            if u18 then
                u32();
            end;
        end;
    end);
    u8:Add(u1);
end;
l__Packets__16._xd280acb67659621a.OnClientEvent:Connect(function() --[[ Line: 355 ]]
    -- upvalues: u6 (ref), u7 (ref), u5 (ref), l__ClientRoot__15 (copy), l__Packets__16 (copy), u1 (ref), u46 (copy)
    if u6 then
    else
        u6 = true;
        if not u7 and u5 then
            if not u6 then
                return;
            end;
            u7 = true;
            l__ClientRoot__15.Init();
            l__Packets__16._xfc69375ed1634248:Fire();
            if u1 then
                task.spawn(u46);
            end;
        end;
    end;
end);
task.spawn(function() --[[ Name: tryDisableReset, Line 52 ]]
    -- upvalues: l__StarterGui__7 (copy)
    local v47 = false;
    while not v47 do
        v47 = pcall(function() --[[ Line: 55 ]]
            -- upvalues: l__StarterGui__7 (ref)
            l__StarterGui__7:SetCore("ResetButtonCallback", false);
        end);
        if not v47 then
            task.wait(0.5);
        end;
    end;
end);
local v48 = l__PlaceContext__17.get().effective_place_type == "MATCH_PLACE";
local v49 = l__PlayerGui__13:FindFirstChild("TeleportScreen") ~= nil;
if (v49 or v48) and u1 then
    u1.Parent = l__Parent__11;
    u1 = nil;
elseif not (v49 or (v48 or u1)) then
    u1 = l__Parent__11:WaitForChild("LoadingScreen");
    u1.MainLoading.Visible = false;
    u1.Black.Visible = true;
    u1.Enabled = true;
    u1.Parent = l__PlayerGui__13;
end;
u5 = true;
if not u7 and (u5 and u6) then
    u7 = true;
    l__ClientRoot__15.Init();
    l__Packets__16._xfc69375ed1634248:Fire();
    if u1 then
        task.spawn(u46);
    end;
end;
task.delay(10, function() --[[ Line: 384 ]]
    -- upvalues: u7 (ref), u1 (ref)
    if u7 or not u1 then
    else
        u1.MainLoading.Visible = true;
        u1.MainLoading.Container.Loading.Text = "WAITING FOR SERVER...";
    end;
end);
task.delay(90, function() --[[ Line: 393 ]]
    -- upvalues: u7 (ref), l__LocalPlayer__12 (copy)
    if not u7 then
        l__LocalPlayer__12:Kick("The server took too long to initialize. Please rejoin.");
    end;
end);
return true;
