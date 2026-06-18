-- Decompiled from: Start.Client.Classes._x255cd8d76027f039
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__RunService__2 = game:GetService("RunService");
local u1 = {};
u1.__index = u1;
local l__Classes__3 = require(script.Parent.Parent.ClientRoot).Classes;
local l__UIAssets__4 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local l__EffectAssets__5 = game:GetService("ReplicatedStorage").Assets.EffectAssets;
require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Easer);
local l__Promise__6 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Promise);
local l__Trove__7 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Trove);
local l__InternalSymbols__8 = require(script.Parent.Parent.InternalSymbols);
local l__Effects__9 = game.Workspace:WaitForChild("Effects");
local l__Packets__10 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Packets);
require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Tips);
require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.OccludedHighlight);
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = {
    Standard = 1,
    Reduced = 0.5,
    Potato = 0.2
};
function u1._x90d4581ac99dd483() --[[ Line: 64 ]]
    -- upvalues: u1 (copy)
    local v7 = setmetatable({}, u1);
    v7._x364033b796543937 = Instance.new("ScreenGui");
    v7._x364033b796543937.ResetOnSpawn = false;
    v7._x364033b796543937.Name = "VisualEffects";
    v7._x364033b796543937.DisplayOrder = 3;
    v7._x364033b796543937.IgnoreGuiInset = true;
    v7._x4c1ab1d6adc1729b = Instance.new("ScreenGui");
    v7._x4c1ab1d6adc1729b.ResetOnSpawn = false;
    v7._x4c1ab1d6adc1729b.Name = "PhotosensitivityTint";
    v7._x4c1ab1d6adc1729b.DisplayOrder = v7._x364033b796543937.DisplayOrder + 1;
    v7._x4c1ab1d6adc1729b.IgnoreGuiInset = true;
    v7._x600edea1e5cfd641 = Instance.new("Frame");
    v7._x600edea1e5cfd641.Name = "Tint";
    v7._x600edea1e5cfd641.Size = UDim2.fromScale(1, 1);
    v7._x600edea1e5cfd641.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    v7._x600edea1e5cfd641.BackgroundTransparency = 1;
    v7._x600edea1e5cfd641.BorderSizePixel = 0;
    v7._x600edea1e5cfd641.Visible = false;
    v7._x600edea1e5cfd641.ZIndex = 1000;
    v7._x600edea1e5cfd641.Parent = v7._x4c1ab1d6adc1729b;
    v7._x241b04b2af1f0a0a = false;
    v7._xd8d9f64f6bfd9c14 = nil;
    v7._x7976f5a12b0e7b0a = nil;
    v7._x6b731715d23e3286 = "Standard";
    v7._x6ea573c6f5fbebd9 = {};
    v7._x3158c52d2a4cd31d = {};
    v7._x77e7400375b356fa = {
        SPEEDLINES_DISTANCE = 1,
        SPEEDLINES_SPEED_LIMIT = 150,
        SPEEDLINES_THRESHOLD = 75,
        SPEEDLINES_FIRST_APPEARANCE = 0.01,
        SPEEDLINES_LAST_APPEARANCE = 0.04,
        SPEEDLINES_FIRST_TRANSPARENCY = 0.93,
        SPEEDLINES_LAST_TRANSPARENCY = 0.9,
        SPEEDLINES_FIRST_SPEED = 5,
        SPEEDLINES_LAST_SPEED = 10,
        SPEEDLINES_RATE = 30,
        SPEEDLINES_ENVELOPE = 0.05,
        SLIDESPARKS_THRESHOLD = 58,
        SLIDESPARKS_TIME_THRESHOLD = 0.03,
        SLIDESPARKS_DISTANCE = 1,
        SLIDESPARKS_RATE = 50,
        SLIDESPARKS_SPEED_DIVISOR = 2,
        SLIDESPARKS_UPPER_BOUND = 100,
        SLIDESPARKS_MAJOR_THRESHOLD = 80
    };
    v7._xfb3999269f7f8d03 = {};
    v7._x610ae198723d5ccb = {};
    v7._x29a95f1809898f9c = {};
    v7._xa00325f15f14e1a6 = v7:_x6aaa5c90417fdf75();
    return v7;
end;
function u1._x94162666f637b130(p8, p9) --[[ Line: 132 ]]
    p8._x241b04b2af1f0a0a = p9 == true;
    if p8._x241b04b2af1f0a0a then
    else
        if p8._x7976f5a12b0e7b0a then
            task.cancel(p8._x7976f5a12b0e7b0a);
            p8._x7976f5a12b0e7b0a = nil;
        end;
        if p8._xd8d9f64f6bfd9c14 then
            p8._xd8d9f64f6bfd9c14:Cancel();
            p8._xd8d9f64f6bfd9c14 = nil;
        end;
        p8._x600edea1e5cfd641.BackgroundTransparency = 1;
        p8._x600edea1e5cfd641.Visible = false;
    end;
end;
function u1._xee1cb09b95057806(u10, u11, p12, p13) --[[ Line: 153 ]]
    -- upvalues: l__TweenService__1 (copy)
    if u10._x241b04b2af1f0a0a then
        if u10._x7976f5a12b0e7b0a then
            task.cancel(u10._x7976f5a12b0e7b0a);
            u10._x7976f5a12b0e7b0a = nil;
        end;
        if u10._xd8d9f64f6bfd9c14 then
            u10._xd8d9f64f6bfd9c14:Cancel();
            u10._xd8d9f64f6bfd9c14 = nil;
        end;
        local v14 = math.abs(p12 or 1) / 4;
        local v15 = math.clamp(v14, 0.28, 0.72);
        local l___x600edea1e5cfd641__11 = u10._x600edea1e5cfd641;
        l___x600edea1e5cfd641__11.Visible = true;
        l___x600edea1e5cfd641__11.BackgroundTransparency = math.min(l___x600edea1e5cfd641__11.BackgroundTransparency, 1 - v15);
        local function u17() --[[ Line: 172 ]]
            -- upvalues: l__TweenService__1 (ref), l___x600edea1e5cfd641__11 (copy), u11 (copy), u10 (copy)
            local u16 = l__TweenService__1:Create(l___x600edea1e5cfd641__11, TweenInfo.new(math.max(u11 or 0, 0.85), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            });
            u10._xd8d9f64f6bfd9c14 = u16;
            u16.Completed:Connect(function() --[[ Line: 176 ]]
                -- upvalues: u10 (ref), u16 (copy), l___x600edea1e5cfd641__11 (ref)
                if u10._xd8d9f64f6bfd9c14 == u16 then
                    u10._xd8d9f64f6bfd9c14 = nil;
                    l___x600edea1e5cfd641__11.Visible = false;
                end;
            end);
            u16:Play();
        end;
        if p13 and p13 > 0 then
            u10._x7976f5a12b0e7b0a = task.delay(p13, function() --[[ Line: 187 ]]
                -- upvalues: u10 (copy), u17 (copy)
                u10._x7976f5a12b0e7b0a = nil;
                u17();
            end);
        else
            u17();
        end;
    end;
end;
function u1._xa9c1340b12fdb645(p18, p19, p20, p21) --[[ Line: 196 ]]
    -- upvalues: l__TweenService__1 (copy)
    p19.ExposureCompensation = p20;
    p18:_xee1cb09b95057806(p21.Time, p20);
    return l__TweenService__1:Create(p19, p21, {
        ExposureCompensation = 0
    });
end;
function u1._x0488dfa06291b26c(_, _) --[[ Line: 203 ]] end;
function u1._x83688a227f391674(_, _, _, _) --[[ Line: 212 ]] end;
function u1._xa1057baf13c81a4b(_, p22, p23) --[[ Line: 234 ]]
    p22._transition = {
        startTime = p23.start_time,
        startRadius = p22._radius,
        targetRadius = p23.target_radius,
        endTime = p23.end_time
    };
end;
function u1._x72ad52e02f6f7631(_, p24, p25, p26) --[[ Line: 250 ]]
    p24._radius = p25;
    p24._origin = p26;
    return p24;
end;
function u1._xbf5c080c5484db75(_, p27) --[[ Line: 256 ]]
    -- upvalues: l__Classes__3 (copy), l__TweenService__1 (copy)
    local v28 = p27:FindFirstChild("Button");
    if v28 then
        l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("CASETTE_PLAY", true, {
            location = l__Classes__3.Util:getLikelyVec3(v28)
        });
        v28.Color = Color3.fromRGB(255, 0, 0);
        l__TweenService__1:Create(v28, TweenInfo.new(0.5), {
            Color = Color3.fromRGB(75, 151, 75)
        }):Play();
    end;
end;
function u1._x45dc0621c8a09e7f(_, p29, p30) --[[ Line: 264 ]]
    -- upvalues: l__Trove__7 (copy), l__EffectAssets__5 (copy), l__RunService__2 (copy), l__Classes__3 (copy), l__TweenService__1 (copy)
    local u31 = {
        _trove = l__Trove__7.new(),
        _radius = p29,
        _origin = p30
    };
    local u32 = l__EffectAssets__5.Storm:Clone();
    local l__Cylinder__12 = u32.Cylinder;
    local l__Cylinder1__13 = u32.Cylinder1;
    local l__Cylinder2__14 = u32.Cylinder2;
    local l__Caution1__15 = u32:WaitForChild("Caution1");
    local l__Caution2__16 = u32:WaitForChild("Caution2");
    local u33 = {};
    local function v38(p34) --[[ Line: 286 ]]
        -- upvalues: l__Cylinder__12 (copy), u33 (copy)
        if p34 then
            for _, v35 in ipairs(p34:GetChildren()) do
                if v35:IsA("BasePart") then
                    local v36 = l__Cylinder__12.CFrame:ToObjectSpace(v35.CFrame);
                    local l__Position__17 = v36.Position;
                    local v37 = Vector3.new(0, l__Position__17.Y, l__Position__17.Z);
                    table.insert(u33, {
                        part = v35,
                        heightOffset = l__Position__17.X,
                        direction = v37.Magnitude > 0 and v37.Unit or Vector3.new(0, 1, 0),
                        initialRotation = v36.Rotation
                    });
                end;
            end;
        end;
    end;
    local v39 = u32:FindFirstChild("Barrier1");
    if v39 then
        v39 = u32.Barrier1:FindFirstChild("Parts");
    end;
    v38(v39);
    local v40 = u32:FindFirstChild("Barrier2");
    if v40 then
        v40 = u32.Barrier2:FindFirstChild("Parts");
    end;
    v38(v40);
    u32.PrimaryPart = l__Cylinder__12;
    u31.model = u32;
    u32.Parent = workspace.Effects;
    local l__ColorCorrection__18 = u32.StormEffects.ColorCorrection;
    l__ColorCorrection__18.Parent = game:GetService("Lighting");
    u31._trove:Add(l__ColorCorrection__18);
    local u41 = Color3.fromRGB(255, 120, 120);
    local l__CurrentCamera__19 = workspace.CurrentCamera;
    local u42 = l__CurrentCamera__19 and l__CurrentCamera__19.CFrame.Position.Y or 0;
    local v56 = l__RunService__2.RenderStepped:Connect(function(p43) --[[ Line: 327 ]]
        -- upvalues: u31 (copy), l__Classes__3 (ref), u42 (ref), u32 (copy), l__Cylinder__12 (copy), l__Cylinder1__13 (copy), l__Cylinder2__14 (copy), u33 (copy), l__Caution1__15 (copy), l__Caution2__16 (copy), l__ColorCorrection__18 (copy), l__TweenService__1 (ref), u41 (copy)
        if u31._transition then
            local l___transition__20 = u31._transition;
            local v44 = workspace:GetServerTimeNow() - l___transition__20.startTime;
            local v45 = l__Classes__3.Util:convNumRange(v44, 0, l___transition__20.endTime - l___transition__20.startTime, 0, 1);
            local v46 = u31;
            local l__startRadius__21 = l___transition__20.startRadius;
            v46._radius = l__startRadius__21 + (l___transition__20.targetRadius - l__startRadius__21) * v45;
            if v45 >= 1 then
                u31._transition = nil;
            end;
        end;
        local l___radius__22 = u31._radius;
        local l__CurrentCamera__23 = workspace.CurrentCamera;
        if l__CurrentCamera__23 then
            local l__Y__24 = l__CurrentCamera__23.CFrame.Position.Y;
            local v47 = u42;
            local v48 = math.clamp(p43 * 4, 0, 1);
            u42 = v47 + (l__Y__24 - v47) * v48;
            u32:PivotTo(CFrame.new(u31._origin.X, u42 + 20, u31._origin.Z) * CFrame.Angles(0, 0, 1.5707963267948966));
            l__Cylinder__12.Size = Vector3.new(5000, l___radius__22 * 2, l___radius__22 * 2);
            l__Cylinder1__13.Size = Vector3.new(5000, l___radius__22 * 2, l___radius__22 * 2);
            l__Cylinder2__14.Size = Vector3.new(5000, l___radius__22 * 2, l___radius__22 * 2);
            for _, v49 in ipairs(u33) do
                local v50 = Vector3.new(v49.heightOffset, v49.direction.Y * l___radius__22, v49.direction.Z * l___radius__22);
                v49.part.CFrame = l__Cylinder__12.CFrame * CFrame.new(v50) * v49.initialRotation;
            end;
            local v51 = Vector3.new(u31._origin.X, u42 + 20, u31._origin.Z);
            local v52 = (l__CurrentCamera__23.CFrame.Position - v51) * Vector3.new(1, 0, 1);
            if v52.Magnitude < 0.1 then
                v52 = l__CurrentCamera__23.CFrame.LookVector * Vector3.new(1, 0, 1);
            end;
            local l__Unit__25 = v52.Unit;
            u31._currentDir = u31._currentDir or l__Unit__25;
            u31._currentDir = u31._currentDir:Lerp(l__Unit__25, (math.clamp(p43 * 4, 0, 1))).Unit;
            local v53 = v51 + u31._currentDir * l___radius__22;
            local v54 = v51 - u31._currentDir * l___radius__22;
            l__Caution1__15.CFrame = CFrame.lookAt(v53, v51);
            l__Caution2__16.CFrame = CFrame.lookAt(v54, v51);
            if l__ColorCorrection__18 then
                local v55 = l__TweenService__1:GetValue(l__Classes__3.Util:convNumRange((l__CurrentCamera__23.CFrame.Position * Vector3.new(1, 0, 1) - u31._origin * Vector3.new(1, 0, 1)).Magnitude, 0, u31._radius, 0, 1), Enum.EasingStyle.Exponential, Enum.EasingDirection.In);
                l__ColorCorrection__18.TintColor = Color3.new(1, 1, 1):Lerp(u41, v55);
            end;
        end;
    end);
    u31._trove:Add(v56);
    u31._trove:Add(u32);
    return u31;
end;
function u1._x862a15c890e93186(u57, p58) --[[ Line: 411 ]]
    -- upvalues: u6 (copy)
    for _, u59 in p58:GetDescendants() do
        if u59:IsA("ParticleEmitter") then
            local v60 = u59:GetAttribute("EmitDelay");
            if v60 then
                task.delay(v60, function() --[[ Line: 427 ]]
                    -- upvalues: u59 (copy), u6 (ref), u57 (copy)
                    local v61 = u59;
                    local v62 = v61:GetAttribute("EmitCount");
                    if v62 then
                        local v63 = math.max(v62 * u6[u57._x6b731715d23e3286] or 1, 1);
                        local v64 = math.floor(v63);
                        if v62 >= 1 then
                            v61:Emit(v64);
                        end;
                    end;
                end);
            else
                local v65 = u59:GetAttribute("EmitCount");
                if v65 then
                    local v66 = math.max(v65 * u6[u57._x6b731715d23e3286] or 1, 1);
                    local v67 = math.floor(v66);
                    if v65 >= 1 then
                        u59:Emit(v67);
                    end;
                end;
            end;
        end;
    end;
end;
function u1._xdceb06c3913d4a80(p68) --[[ Line: 437 ]]
    -- upvalues: l__UIAssets__4 (copy), l__TweenService__1 (copy), l__Classes__3 (copy)
    local v69 = l__UIAssets__4.SpeedEffect:Clone();
    v69.Parent = p68._x364033b796543937;
    l__TweenService__1:Create(v69, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = 1,
        Size = UDim2.new(2.5, 0, 2.5, 0)
    }):Play();
    game.Debris:AddItem(v69, 0.5);
    local v70 = {};
    local v71 = Instance.new("NumberValue");
    v71.Value = 5;
    v70.value = v71;
    v70.cancel_when_zero = true;
    l__Classes__3._x32ae459de0772e82:_x8ca42af5fe3be726(v70);
    l__TweenService__1:Create(v71, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
end;
function u1._x29cf541f4575469f(_, p72) --[[ Line: 457 ]]
    -- upvalues: l__Trove__7 (copy), l__RunService__2 (copy), l__Classes__3 (copy), l__TweenService__1 (copy)
    local l__SurfaceGui__26 = p72.ScreenPart.SurfaceGui;
    local l__MainCanvas__27 = l__SurfaceGui__26.MainCanvas;
    l__MainCanvas__27.GroupTransparency = 1;
    local u73 = l__Trove__7.new();
    u73:AttachToInstance(p72);
    local u74 = Instance.new("Frame");
    u74.Size = UDim2.fromScale(1, 1);
    u74.Parent = l__SurfaceGui__26;
    game.Debris:AddItem(u74, 0.66);
    local u75 = Instance.new("Frame");
    u75.Size = UDim2.fromScale(1, 0.2);
    u75.Parent = l__SurfaceGui__26;
    local u76 = Instance.new("Frame");
    u76.Size = UDim2.fromScale(1, 0.05);
    u76.Parent = l__SurfaceGui__26;
    game.Debris:AddItem(u76, 0.66);
    game.Debris:AddItem(u75, 0.66);
    local u77 = Random.new();
    u73:Add(l__RunService__2.Heartbeat:Connect(function() --[[ Line: 488 ]]
        -- upvalues: u74 (copy), u75 (copy), u77 (copy), u76 (copy)
        local v78 = math.random(180, 255);
        if u74 and u74.Parent ~= nil then
            u74.BackgroundColor3 = Color3.fromRGB(v78, v78, v78);
            u75.Position = UDim2.fromScale(0, u77:NextNumber(0, 1));
            u76.Position = UDim2.fromScale(0, u77:NextNumber(0, 1));
        end;
    end));
    l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("SCREEN_STATIC", true, {
        location = l__Classes__3.Util:getLikelyVec3(p72)
    });
    l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("SCREEN_STATIC2", true, {
        location = l__Classes__3.Util:getLikelyVec3(p72)
    });
    task.delay(0.66, function() --[[ Line: 501 ]]
        -- upvalues: u73 (copy), l__TweenService__1 (ref), l__MainCanvas__27 (copy)
        u73:Clean();
        l__TweenService__1:Create(l__MainCanvas__27, TweenInfo.new(0.66, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            GroupTransparency = 0
        }):Play();
    end);
end;
function u1._x6e49b2c7a914a2a1(_) --[[ Line: 507 ]]
    -- upvalues: l__UIAssets__4 (copy), l__Classes__3 (copy)
    local v79 = l__UIAssets__4.Black:Clone();
    v79.Parent = game.Players.LocalPlayer.PlayerGui;
    l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("TELEPORT_DRAMATIC", true);
    game.Debris:AddItem(v79, 30);
    return v79;
end;
function u1._x4447e49e11da5640(p80, p81) --[[ Line: 517 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local v82 = l__EffectAssets__5.LaunchpadEffect:Clone();
    v82:PivotTo((CFrame.lookAt(p81.Origin.Position, p81.LaunchGoal.Position)));
    l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("RELEASE", true, {
        Parent = p81.PrimaryPart
    });
    v82.Parent = l__Effects__9;
    p80:_x862a15c890e93186(v82);
    l__TweenService__1:Create(v82.InvertedSpike, TweenInfo.new(0.07), {
        Size = Vector3.new(5, 30, 5),
        Transparency = 1
    }):Play();
    game.Debris:AddItem(v82, 0.5);
end;
function u1._x655d09098fc3e186(u83, u84, u85) --[[ Line: 532 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), u3 (ref), l__RunService__2 (copy)
    local function v94(u86, u87) --[[ Line: 542 ]]
        -- upvalues: u84 (copy), l__Classes__3 (ref), u83 (copy), u3 (ref), l__RunService__2 (ref), u85 (copy)
        local l__PrimaryPart__28 = u84.PrimaryPart;
        if l__PrimaryPart__28 then
            l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("PULL", true, {
                Parent = l__PrimaryPart__28
            });
            l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("WALL_HIT", true, {
                Parent = l__PrimaryPart__28
            });
            if u83._xfb3999269f7f8d03[u84] then
                u3:cleanConnectionsTable(u83._xfb3999269f7f8d03[u84].connections);
                u83._xfb3999269f7f8d03[u84] = nil;
            end;
            local u88 = {
                connections = {},
                tether = u86,
                ended = false
            };
            local l__SpringConstraint__29 = u86.SpringConstraint;
            u88.sound = l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("GRAPPLE_REEL", true, {
                Parent = l__PrimaryPart__28
            });
            u86.Position = l__PrimaryPart__28.Position;
            l__SpringConstraint__29.Visible = true;
            local v93 = l__RunService__2.RenderStepped:Connect(function(p89) --[[ Line: 569 ]]
                -- upvalues: u86 (copy), u85 (ref), l__Classes__3 (ref), u87 (copy), l__PrimaryPart__28 (copy), u3 (ref), l__SpringConstraint__29 (copy)
                local l__StartPoint__30 = u86.StartPoint;
                local v90;
                if typeof(u85) == "Vector3" then
                    v90 = u85;
                else
                    v90 = l__Classes__3.Util:getLikelyVec3(u85);
                end;
                l__StartPoint__30.Position = u87.WorldPosition;
                local l__Position__31 = l__PrimaryPart__28.Position;
                local v91 = u86.Position - l__Position__31;
                local l__Unit__32 = (v90 - l__Position__31).Unit;
                local v92 = v91.Magnitude + 250 * p89;
                local l__Magnitude__33 = (v90 - u86.Position).Magnitude;
                l__SpringConstraint__29.Radius = u3:numLerp(0, 2, (u3:convNumRange(l__Magnitude__33, 0, 130, 0, 1)));
                if l__Magnitude__33 <= v92 then
                    u86.Position = v90;
                else
                    u86.Position = l__Position__31 + l__Unit__32 * v92;
                end;
            end);
            task.delay(4, function() --[[ Line: 595 ]]
                -- upvalues: u88 (copy), u83 (ref), u84 (ref)
                if not u88.ended then
                    u83:_x51f75ff0cfae6e7b(u84);
                end;
            end);
            table.insert(u88.connections, v93);
            u83._xfb3999269f7f8d03[u84] = u88;
        end;
    end;
    local v95 = u84 and u84:FindFirstChild("Left Arm");
    if v95 then
        v95 = u84["Left Arm"]:FindFirstChild("LeftGripAttachment");
    end;
    local v96;
    if v95 then
        v96 = v95:FindFirstChild("Tether");
    else
        v96 = nil;
    end;
    if v95 and v96 then
        v94(v96, v95);
    elseif v95 then
        local v97 = l__EffectAssets__5.Tether:Clone();
        v97.Parent = v95;
        v97.Archivable = false;
        v94(v97, v95);
    else
        warn("ATTACHMENT NOT FOUND FOR CHARACTER");
    end;
end;
function u1._x51f75ff0cfae6e7b(p98, p99) --[[ Line: 621 ]]
    -- upvalues: u3 (ref), l__Classes__3 (copy)
    if p98._xfb3999269f7f8d03[p99] then
        local v100 = p98._xfb3999269f7f8d03[p99];
        if v100.sound then
            v100.sound:Destroy();
        end;
        v100.ended = true;
        if v100.tether then
            v100.tether:Destroy();
        end;
        u3:cleanConnectionsTable(v100.connections);
        l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("GRAPPLE_READY", true, {
            Parent = p99.PrimaryPart
        });
        p98._xfb3999269f7f8d03[p99] = nil;
    end;
end;
function u1._x270711b70822b296(p101, p102, p103) --[[ Line: 641 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), l__Classes__3 (copy), l__RunService__2 (copy)
    local v104 = l__EffectAssets__5:FindFirstChild(p103);
    if v104 then
        local v105 = v104:Clone();
        v105.Parent = l__Effects__9;
        l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("PROJECTILE_WHOOSH", true, {
            Parent = v105
        });
        local u106 = {};
        for _, u107 in v105:GetDescendants() do
            if u107:IsA("ParticleEmitter") then
                local v108 = u107:GetAttribute("EmitDelay");
                if v108 then
                    task.delay(v108, function() --[[ Line: 670 ]]
                        -- upvalues: u107 (copy), u106 (copy)
                        local v109 = u107;
                        local v110 = v109:GetAttribute("EmitCount");
                        if v110 and v110 > 0 then
                            v109:Emit(v110);
                            table.insert(u106, v109);
                        end;
                    end);
                else
                    local v111 = u107:GetAttribute("EmitCount");
                    if v111 and v111 > 0 then
                        u107:Emit(v111);
                        table.insert(u106, u107);
                    end;
                end;
            end;
        end;
        local l__removal_id__34 = p102.removal_id;
        local l__origin__35 = p102.origin;
        local v112 = p102.direction or Vector3.new(0, 0, 0);
        local v113 = p102.speed or 0;
        local u114 = p102.acceleration or Vector3.new(0, 0, 0);
        local u115 = p102.acceleration_delay or 0;
        local v116 = p102.velocity or (v112.Magnitude <= 0 and Vector3.new(0, 0, 0) or v112.Unit * v113);
        local v117 = workspace:GetServerTimeNow();
        local u118 = p102.shot_timestamp or v117;
        local v119 = math.clamp(v117 - u118, 0, 0.15);
        local v120 = math.max(0, v119 - u115);
        local v121 = l__origin__35 + v116 * v119 + 0.5 * u114 * (v120 * v120);
        local v122 = v116 + u114 * v120;
        local v123 = u115 <= v119 and u114 and u114 or Vector3.new(0, 0, 0);
        local function u127(p124, p125) --[[ Line: 717 ]]
            if p124 then
                if p124:IsA("BasePart") then
                    p124.CFrame = CFrame.new(p125);
                else
                    local v126 = p124:FindFirstChildWhichIsA("BasePart");
                    if v126 then
                        v126.CFrame = CFrame.new(p125);
                    elseif p124.SetPrimaryPartCFrame and p124.PrimaryPart then
                        p124:SetPrimaryPartCFrame(CFrame.new(p125));
                    end;
                end;
            end;
        end;
        u127(v105, v121);
        local u128 = {
            conn = nil,
            distance = 0,
            active = true,
            effect = v105,
            position = v121,
            velocity = v122,
            acceleration = v123,
            emitters = u106
        };
        p101._x3158c52d2a4cd31d[l__removal_id__34] = u128;
        local u129 = 0;
        local u130 = nil;
        u130 = l__RunService__2.RenderStepped:Connect(function(p131) --[[ Line: 755 ]]
            -- upvalues: u128 (copy), u130 (ref), u118 (copy), u115 (copy), u114 (copy), u129 (ref), u127 (copy)
            if u128.active then
                local v132 = workspace:GetServerTimeNow() - u118;
                if u115 <= math.max(v132, 0) then
                    u128.acceleration = u114;
                end;
                u129 = u129 + p131;
                while u129 >= 0.016666666666666666 do
                    local l__position__36 = u128.position;
                    local v133 = l__position__36 + u128.velocity * 0.016666666666666666 + 0.5 * u128.acceleration * 0.0002777777777777778;
                    u128.position = v133;
                    u128.velocity = u128.velocity + u128.acceleration * 0.016666666666666666;
                    u128.distance = u128.distance + (v133 - l__position__36).Magnitude;
                    u129 = u129 - 0.016666666666666666;
                end;
                if u128.effect and u128.effect.Parent then
                    u127(u128.effect, u128.position);
                end;
            else
                u130:Disconnect();
            end;
        end);
        u128.conn = u130;
    else
        warn("NO SUCH PROJECTILE :", p103);
    end;
end;
function u1._xea63ed5fc7ef59ca(p134, p135) --[[ Line: 796 ]]
    -- upvalues: l__Promise__6 (copy)
    local u136 = p134._x3158c52d2a4cd31d[p135];
    if u136 then
        u136.active = false;
        if u136.conn then
            pcall(function() --[[ Line: 803 ]]
                -- upvalues: u136 (copy)
                u136.conn:Disconnect();
            end);
            u136.conn = nil;
        end;
        if u136.effect and u136.effect.Parent then
            pcall(function() --[[ Line: 808 ]]
                -- upvalues: l__Promise__6 (ref), u136 (copy)
                l__Promise__6.defer(function() --[[ Line: 809 ]]
                    -- upvalues: u136 (ref)
                    for _, v137 in u136.emitters do
                        v137:Destroy();
                    end;
                end);
                for _, v138 in u136.effect:GetDescendants() do
                    if v138:IsA("ParticleEmitter") then
                        v138.Enabled = false;
                    end;
                    if v138:IsA("Sound") then
                        v138:Destroy();
                    end;
                end;
                game.Debris:AddItem(u136.effect, 3);
            end);
        end;
        p134._x3158c52d2a4cd31d[p135] = nil;
    end;
end;
function u1._x7978d78c2405e137(p139, p140) --[[ Line: 831 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), u6 (copy), u3 (ref), l__Promise__6 (copy)
    local v141 = l__EffectAssets__5.Shockwave:Clone();
    v141.CFrame = CFrame.lookAt(p140.Position + p140.Normal * 2, p140.Position + p140.Normal * 3);
    v141.Parent = l__Effects__9;
    p139:_x862a15c890e93186(v141);
    game.Debris:AddItem(v141, 2);
    local v142 = math.max(5 * u6[p139._x6b731715d23e3286], 1);
    for _ = 1, math.floor(v142) do
        local u143 = l__EffectAssets__5.DebrisPart:Clone();
        u143.Position = u3:getRandomPosInPart(v141);
        local l__Unit__37 = (u3:randomizeDirection(p140.Normal, 75) + Vector3.new(0, 0.5, 0)).Unit;
        u143.AssemblyAngularVelocity = l__Unit__37;
        u143.AssemblyLinearVelocity = l__Unit__37 * math.random(75, 150);
        u143.Parent = l__Effects__9;
        local v144 = math.random();
        u143.Attachment2.Inner.Lifetime = NumberRange.new(1.5 * v144);
        u143.Attachment2.MainFlare.Lifetime = NumberRange.new(1.5 * v144);
        p139:_x862a15c890e93186(u143);
        task.delay(1.5 * v144, function() --[[ Line: 862 ]]
            -- upvalues: u143 (copy)
            u143.Attachment.Trail.Enabled = false;
        end);
        l__Promise__6.delay(3 * v144):andThen(function() --[[ Line: 866 ]]
            -- upvalues: u143 (copy)
            u143.Anchored = true;
            u143.CanCollide = false;
        end);
        game.Debris:AddItem(u143, 4.5 * v144);
    end;
end;
function u1._xfa3ad4a50639cee8(p145, p146, p147) --[[ Line: 875 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), u2 (ref), u3 (ref), l__TweenService__1 (copy)
    local v148 = l__EffectAssets__5.Explosion:Clone();
    local v149 = l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("EXPLOSION", true, {
        Parent = v148
    });
    if p147 then
        v149.RollOffMinDistance = 1000;
    end;
    game.Debris:AddItem(v148, 3);
    v148.Position = p146;
    v148.Parent = l__Effects__9;
    p145:_x862a15c890e93186(v148);
    local v150 = p147 and 500 or 150;
    if u2._x1cdffaf9f62b92e9 then
        local v151 = u3:numLerp(30, 0, l__TweenService__1:GetValue(u3:convNumRange(math.clamp((p146 - u2._x1cdffaf9f62b92e9.Position).Magnitude, 0, 150), 0, v150, 0, 1), Enum.EasingStyle.Exponential, Enum.EasingDirection.Out));
        l__Classes__3._x32ae459de0772e82:_x8ee1ac854964ea1a(v151, 4, 4, { "pitch", "yaw", "roll" }, 0.6, true, false, false, false);
    end;
end;
function u1._x3441e71244ea63e1(p152, p153) --[[ Line: 898 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy)
    local u154 = l__EffectAssets__5.PhoenixDirect:Clone();
    game.Debris:AddItem(u154, 3);
    u154.Position = p153;
    u154.Parent = l__Effects__9;
    p152:_x862a15c890e93186(u154);
    u154.Stars.Enabled = true;
    u154.Stars1.Enabled = true;
    task.delay(1.2, function() --[[ Line: 908 ]]
        -- upvalues: u154 (copy)
        if u154 and u154.Parent ~= nil then
            u154.Stars.Enabled = false;
            u154.Stars1.Enabled = false;
        end;
    end);
end;
function u1._x17bdbf488c82304b(_, _) --[[ Line: 915 ]] end;
function u1._xf69875c443eff0e7(_, _, _, _) --[[ Line: 951 ]] end;
function u1._x580b9e6898f88c71(_, u155, u156, u157, u158) --[[ Line: 954 ]]
    -- upvalues: l__Promise__6 (copy), l__RunService__2 (copy), l__Classes__3 (copy), l__TweenService__1 (copy)
    for _, v159 in u155:GetDescendants() do
        if v159:IsA("BasePart") or v159:IsA("Decal") then
            v159.Transparency = 1;
        end;
    end;
    local u160 = os.clock();
    return l__Promise__6.new(function(u161, _, p162) --[[ Line: 961 ]]
        -- upvalues: u155 (copy), l__RunService__2 (ref), u160 (copy), u156 (copy), l__Classes__3 (ref), u157 (copy), l__TweenService__1 (ref), u158 (copy)
        local u163 = nil;
        local function u166() --[[ Line: 963 ]]
            -- upvalues: u163 (ref), u155 (ref), u161 (copy)
            if u163 then
                u163:Disconnect();
                u163 = nil;
            end;
            for _, v164 in u155:GetDescendants() do
                if v164 and v164:IsA("BasePart") or v164:IsA("Decal") then
                    local v165 = v164:GetAttribute("OriginalTransparency");
                    if v165 then
                        v164.Transparency = v165;
                    end;
                end;
            end;
            u161();
        end;
        u163 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 980 ]]
            -- upvalues: u160 (ref), u156 (ref), l__Classes__3 (ref), u166 (copy), u155 (ref), u157 (ref), l__TweenService__1 (ref), u158 (ref)
            local v167 = os.clock() - u160;
            local v168 = math.min(v167, u156);
            local v169 = l__Classes__3.Util:convNumRange(v168, 0, u156, 0, 1);
            if v169 == 1 then
                u166();
            end;
            for _, v170 in u155:GetDescendants() do
                if v170:IsA("BasePart") or v170:IsA("Decal") then
                    local v171 = v170:GetAttribute("OriginalTransparency");
                    if v171 then
                        local l__Util__38 = l__Classes__3.Util;
                        local v172 = 1;
                        local v173;
                        if u157 then
                            v173 = l__TweenService__1:GetValue(v169, u157, u158) or v169;
                        else
                            v173 = v169;
                        end;
                        v170.Transparency = l__Util__38:numLerp(v172, v171, v173);
                    end;
                end;
            end;
        end);
        p162(function() --[[ Line: 996 ]]
            -- upvalues: u166 (copy)
            u166();
        end);
    end);
end;
function u1._xfe87be3956daa8a1(_, p174, p175, p176) --[[ Line: 1004 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), l__Classes__3 (copy)
    if p176 then
        local v177 = l__EffectAssets__5.GlitchAura:Clone();
        local v178 = Instance.new("Weld");
        v178.Parent = v177;
        v178.Part0 = v177;
        v178.Part1 = p174.PrimaryPart;
        v177.Parent = l__Effects__9;
        v177.ParticleEmitter.Enabled = true;
        game.Debris:AddItem(v177, p175);
        l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("SHORT_DASH", true, {
            Parent = p174:FindFirstChild("HumanoidRootPart")
        });
        l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("DASH", true, {
            Parent = p174:FindFirstChild("HumanoidRootPart")
        });
    end;
    local u179 = {};
    for v180 = 1, 2 do
        local v181 = { "Left Leg", "Right Leg" };
        local v182 = l__EffectAssets__5.AfterTrail:Clone();
        table.insert(u179, v182);
        v182.Attachment0 = p174[v181[v180]][({ "LeftFootAttachment", "RightFootAttachment" })[v180]];
        local v183 = Instance.new("Attachment");
        v183.Parent = p174[v181[v180]];
        v183.Position = Vector3.new(0, -0.5, 0);
        game.Debris:AddItem(v183, p175 + 1);
        v182.Attachment1 = v183;
        v182.Parent = p174[v181[v180]];
        game.Debris:AddItem(v182, p175 + 1);
    end;
    for v184 = 1, 2 do
        local v185 = { "Left Arm", "Right Arm" };
        local v186 = l__EffectAssets__5.AfterTrail:Clone();
        table.insert(u179, v186);
        v186.Attachment0 = p174[v185[v184]][({ "LeftGripAttachment", "RightGripAttachment" })[v184]];
        local v187 = Instance.new("Attachment");
        v187.Parent = p174[v185[v184]];
        v187.Position = Vector3.new(0, -0.5, 0);
        game.Debris:AddItem(v187, p175 + 1);
        v186.Attachment1 = v187;
        v186.Parent = p174[v185[v184]];
        game.Debris:AddItem(v186, p175 + 1);
    end;
    local v188 = l__EffectAssets__5.AfterTrail:Clone();
    table.insert(u179, v188);
    v188.Attachment0 = p174.Head.HairAttachment;
    local v189 = Instance.new("Attachment");
    v189.Parent = p174.Head;
    v189.Position = Vector3.new(0, 0.5, 0);
    game.Debris:AddItem(v189, p175 + 1);
    v188.Attachment1 = v189;
    v188.Parent = p174.Head;
    game.Debris:AddItem(v188, p175 + 1);
    task.delay(p175, function() --[[ Line: 1075 ]]
        -- upvalues: u179 (copy)
        for _, v190 in pairs(u179) do
            v190.Enabled = false;
        end;
    end);
end;
function u1._xd003c8b3e80e7c75(p191, p192) --[[ Line: 1083 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy)
    local v193 = l__EffectAssets__5.SuspendedIndicator:Clone();
    game.Debris:AddItem(v193, 1);
    v193.Position = p192;
    v193.Parent = l__Effects__9;
    p191:_x862a15c890e93186(v193);
end;
function u1._x44e4f4fb454e44ea(_, p194) --[[ Line: 1091 ]]
    local v195 = Vector3.new(p194.X, 0, p194.Z);
    local l__Magnitude__39 = v195.Magnitude;
    local v196 = l__Magnitude__39 + math.abs(p194.Y);
    if v196 < 0.0001 then
        return Vector3.new(0, 0, 0);
    end;
    local v197 = l__Magnitude__39 / v196;
    local v198 = v197 ^ 2 / (v197 ^ 2 + (1 - v197) ^ 2);
    return ((l__Magnitude__39 > 0 and v195.Unit * (v196 * v198) or Vector3.new(0, 0, 0)) + Vector3.new(0, v196 * (1 - v198) * (p194.Y < 0 and -1 or 1), 0)).Unit;
end;
function u1._x8d2a80ae7c42542d(u199) --[[ Line: 1108 ]]
    -- upvalues: l__EffectAssets__5 (copy), u2 (ref), u4 (ref), u5 (ref), u3 (ref), l__RunService__2 (copy)
    local function v202() --[[ Line: 1109 ]]
        -- upvalues: l__EffectAssets__5 (ref), u199 (copy)
        local v200 = l__EffectAssets__5.SlideSparks:Clone();
        v200.Parent = workspace.CurrentCamera;
        u199._x6ea573c6f5fbebd9.SlideSparks = {
            model = v200,
            emitters = {},
            glow = {},
            connections = {}
        };
        for _, v201 in pairs(v200:GetDescendants()) do
            if v201:IsA("ParticleEmitter") then
                if v201.Name == "Sparks" then
                    table.insert(u199._x6ea573c6f5fbebd9.SlideSparks.emitters, v201);
                else
                    table.insert(u199._x6ea573c6f5fbebd9.SlideSparks.glow, v201);
                end;
            end;
        end;
    end;
    local function u216() --[[ Line: 1129 ]]
        -- upvalues: u2 (ref), u4 (ref), u5 (ref), u199 (copy), u3 (ref)
        local v203 = u2._x1d287c838240a901.Magnitude > u4.SLIDESPARKS_THRESHOLD;
        local v204 = u5._x21f23a003071dfea <= u4.SLIDESPARKS_TIME_THRESHOLD;
        local v205 = u2._x1d287c838240a901.Magnitude > u4.SLIDESPARKS_MAJOR_THRESHOLD and (u5._xa822f9aecc59b964 and u2._x8500fad561a4bbc9) and true or false;
        for _, v206 in pairs(u199._x6ea573c6f5fbebd9.SlideSparks.glow) do
            v206.Enabled = v205;
        end;
        local function v211(p207) --[[ Line: 1144 ]]
            -- upvalues: u199 (ref)
            for _, v208 in pairs(u199._x6ea573c6f5fbebd9.SlideSparks.emitters) do
                for v209, v210 in pairs(p207) do
                    v208[v209] = v210;
                end;
            end;
        end;
        local l__SlideSparks__40 = u199._x6ea573c6f5fbebd9.SlideSparks;
        local l__model__41 = l__SlideSparks__40.model;
        local _ = l__SlideSparks__40.emitters[1];
        local v212 = RaycastParams.new();
        v212.RespectCanCollide = true;
        v212.FilterDescendantsInstances = { workspace.CurrentCamera, u2._xbcaafe2ed14862c8 };
        v212.FilterType = Enum.RaycastFilterType.Exclude;
        local v213 = workspace:Raycast(u2._x1cdffaf9f62b92e9.Position, u2._x1cdffaf9f62b92e9.CFrame.UpVector * -3.3, v212);
        if v213 then
            local l__Position__42 = v213.Position;
            l__model__41.CFrame = CFrame.lookAt(l__Position__42 + u2._x1d287c838240a901.Unit * u4.SLIDESPARKS_DISTANCE, l__Position__42);
        end;
        if v203 and (u2._x8500fad561a4bbc9 and u5._xa822f9aecc59b964) or v204 and (u2._x8500fad561a4bbc9 and u5._xa822f9aecc59b964) then
            local v214 = {
                Enabled = true,
                Rate = u3:convNumRange(math.clamp(u2._x1d287c838240a901.Magnitude, 0, u4.SLIDESPARKS_UPPER_BOUND), 0, u4.SLIDESPARKS_UPPER_BOUND, 0, u4.SLIDESPARKS_RATE)
            };
            local v215;
            if u2._x1d287c838240a901.Magnitude > 0.001 then
                v215 = NumberRange.new(u2._x1d287c838240a901.Magnitude / u4.SLIDESPARKS_SPEED_DIVISOR);
            else
                v215 = NumberRange.new(0.001);
            end;
            v214.Speed = v215;
            v211(v214);
        else
            v211({
                Rate = 0
            });
        end;
    end;
    if not u199._x6ea573c6f5fbebd9.SlideSparks then
        v202();
    end;
    table.insert(u199._x6ea573c6f5fbebd9.SlideSparks.connections, l__RunService__2.RenderStepped:Connect(function() --[[ Line: 1198 ]]
        -- upvalues: u216 (copy)
        u216();
    end));
end;
function u1._x077bd41c32ddbe8a(p217, p218, p219) --[[ Line: 1203 ]]
    -- upvalues: u3 (ref), l__EffectAssets__5 (copy), l__Effects__9 (copy)
    local v220 = u3:getLikelyVec3(p218);
    local v221 = u3:getLikelyVec3(p219);
    local v222 = l__EffectAssets__5.CastigateFlash:Clone();
    v222.CFrame = CFrame.lookAt(v220, v221);
    v222.Parent = l__Effects__9;
    game.Debris:AddItem(v222, 2);
    p217:_x862a15c890e93186(v222);
end;
function u1._xb31d1abafc606df8(u223, u224) --[[ Line: 1215 ]]
    -- upvalues: l__UIAssets__4 (copy), l__TweenService__1 (copy), l__RunService__2 (copy), l__Classes__3 (copy)
    local l__Lighting__43 = game:GetService("Lighting");
    local u225 = Instance.new("ColorCorrectionEffect");
    u225.Saturation = -1;
    u225.Parent = l__Lighting__43;
    game.Debris:AddItem(u225, u224);
    local v226 = {};
    local v227 = Instance.new("NumberValue");
    v227.Value = -4;
    v226.value = v227;
    v226.cancel_when_zero = true;
    local u228 = l__UIAssets__4.Destabilized:Clone();
    u228.Parent = u223._x364033b796543937;
    game.Debris:AddItem(u228, u224);
    local u229 = os.clock();
    local u230 = Random.new();
    u228.Rotation = ({ -10, 10 })[math.random(1, 2)];
    l__TweenService__1:Create(u228, TweenInfo.new(u224 / 4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        Rotation = 0
    }):Play();
    u228.Size = UDim2.fromScale(0.87, 0.87);
    l__TweenService__1:Create(u228, TweenInfo.new(u224), {
        Size = UDim2.fromScale(0.75, 0.75)
    }):Play();
    local u231 = 0;
    l__TweenService__1:Create(u228.Rotator, TweenInfo.new(u224, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Rotation = 2000
    }):Play();
    local u245 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 1246 ]]
        -- upvalues: u228 (copy), u229 (copy), u224 (copy), l__Classes__3 (ref), l__TweenService__1 (ref), u231 (ref), u230 (copy)
        if u228 and u228.Parent ~= nil then
            local v232 = os.clock() - u229;
            local v233 = math.clamp(v232, 0, u224);
            local v234 = l__Classes__3.Util:convNumRange(v233, 0, u224, 0, 1);
            local v235 = Color3.fromRGB(255, 0, 0):Lerp(Color3.fromRGB(255, 255, 255), l__TweenService__1:GetValue(v234, Enum.EasingStyle.Sine, Enum.EasingDirection.In));
            local v236 = l__TweenService__1:GetValue(l__TweenService__1:GetValue(v234, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), Enum.EasingStyle.Exponential, Enum.EasingDirection.In);
            local v237 = math.floor(v233);
            l__Classes__3._xafc4950d7b094088._xef1fb561476b0a5b.Enabled = false;
            if v237 ~= u231 then
                u231 = v237;
                u228.Timer.Size = UDim2.fromScale(0.18, 0.18);
                l__TweenService__1:Create(u228.Timer, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(0.16, 0.16)
                }):Play();
                local v238 = u228.Timer:Clone();
                v238.Second:Destroy();
                v238.Milisecond:Destroy();
                v238.Name = "pulse";
                v238.Parent = u228;
                v238.Size = UDim2.fromScale(0.16, 0.16);
                v238.UIStroke.Thickness = 10;
                l__TweenService__1:Create(v238.UIStroke, TweenInfo.new(0.5), {
                    Thickness = 0
                }):Play();
                l__TweenService__1:Create(v238, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(1, 1)
                }):Play();
                l__TweenService__1:Create(v238.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
                game.Debris:AddItem(v238, 0.45);
                l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("TICK", true);
            end;
            local v239 = math.fmod(v233, 1);
            u228.Timer.Second.Text = u224 - u231 - 1;
            local l__Milisecond__44 = u228.Timer.Milisecond;
            local v240 = tostring(1 - v239);
            l__Milisecond__44.Text = string.sub(v240, 2, 4);
            for _, v241 in u228:GetDescendants() do
                if v241:IsA("TextLabel") then
                    v241.TextColor3 = v235;
                    v241.TextTransparency = v236;
                elseif v241:IsA("ImageLabel") then
                    v241.ImageColor3 = v235;
                    v241.ImageTransparency = v236;
                elseif v241:IsA("UIStroke") then
                    v241.Color = v235;
                    v241.Transparency = v236;
                end;
            end;
            local l__Cautions__45 = u228.Cautions;
            local l__fromScale__46 = UDim2.fromScale;
            local v242 = l__Classes__3.Util:numLerp(0.1, 0.01, l__TweenService__1:GetValue(v234, Enum.EasingStyle.Quint, Enum.EasingDirection.Out));
            local v243 = 0.8 + u230:NextNumber(-v242, v242);
            local v244 = l__Classes__3.Util:numLerp(0.1, 0.01, l__TweenService__1:GetValue(v234, Enum.EasingStyle.Quint, Enum.EasingDirection.Out));
            l__Cautions__45.Size = l__fromScale__46(v243, 0.8 + u230:NextNumber(-v244, v244));
        end;
    end);
    local u246 = nil;
    local function u248(p247) --[[ Line: 1304 ]]
        -- upvalues: u246 (ref), u225 (copy), u245 (ref), u223 (copy), l__Classes__3 (ref), u228 (copy)
        if u246 then
            task.cancel(u246);
        end;
        if u225 then
            u225:Destroy();
        end;
        if u245 then
            u223:_xa9c1340b12fdb645(game:GetService("Lighting"), 2, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)):Play();
            if not p247 and l__Classes__3._x7430d6d194f43373._x3668b6edfe3dbbd4 == "alive" then
                l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("DING_ON", true);
                l__Classes__3._xafc4950d7b094088._xef1fb561476b0a5b.Enabled = true;
            end;
            u245:Disconnect();
            u245 = nil;
        end;
        if u228 then
            u228:Destroy();
        end;
    end;
    u246 = task.delay(u224, function() --[[ Line: 1327 ]]
        -- upvalues: u246 (ref), u248 (copy)
        u246 = nil;
        u248();
    end);
    l__Classes__3._x32ae459de0772e82:_x8ca42af5fe3be726(v226);
    l__TweenService__1:Create(v227, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
    return u248;
end;
function u1._xc145144798438460(p249, p250, p251) --[[ Line: 1339 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), u3 (ref)
    local v252 = l__EffectAssets__5.SlashCrescent:Clone();
    game.Debris:AddItem(v252, 1.5);
    v252.Parent = l__Effects__9;
    local v253 = u3:getLikelyVec3(p250);
    local v254 = u3:getLikelyVec3(p251);
    v252.CFrame = CFrame.lookAt(v253, v254);
    p249:_x862a15c890e93186(v252);
end;
function u1._x3abef6c05325499d(p255, p256, u257) --[[ Line: 1351 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), l__RunService__2 (copy)
    local u258 = l__EffectAssets__5.SlashCrescent:Clone();
    game.Debris:AddItem(u258, 1.5);
    u258.Parent = l__Effects__9;
    u258.CFrame = CFrame.lookAt((p256.Position + u257.CFrame.Position) / 2, u257.CFrame.Position + Vector3.new(0, -2, 0));
    local u259 = u257.CFrame:toObjectSpace(u258.CFrame);
    local u260 = l__RunService__2.RenderStepped:Connect(function() --[[ Line: 1362 ]]
        -- upvalues: u258 (copy), u257 (copy), u259 (copy)
        u258.CFrame = u257.CFrame:toWorldSpace(u259);
    end);
    task.delay(0.2, function() --[[ Line: 1366 ]]
        -- upvalues: u260 (copy)
        u260:Disconnect();
    end);
    p255:_x862a15c890e93186(u258);
end;
function u1._x4ddc16cc204a876f(p261) --[[ Line: 1374 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local v262 = l__EffectAssets__5.CastigateFlash:Clone();
    local v263 = l__Classes__3._x32ae459de0772e82:_x76b38494ff05a56c();
    local l__WorldPosition__47 = l__Classes__3._xd1706540247308ea:_x372c01be8a28bc70("gun")._x8f8f3c55f1e79ebe.WorldPosition;
    v262.CFrame = CFrame.lookAt(l__WorldPosition__47 + v263 * 2, l__WorldPosition__47 + v263 * 10);
    v262.Parent = l__Effects__9;
    game.Debris:AddItem(v262, 2);
    p261:_x862a15c890e93186(v262);
    local l__Lighting__48 = game:GetService("Lighting");
    local v264 = Instance.new("ColorCorrectionEffect");
    v264.Contrast = 1;
    v264.Saturation = -1;
    v264.Parent = l__Lighting__48;
    game.Debris:AddItem(v264, 1);
    l__TweenService__1:Create(v264, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Contrast = 0
    }):Play();
    l__TweenService__1:Create(v264, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    p261:_xa9c1340b12fdb645(l__Lighting__48, -1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)):Play();
end;
function u1._x6e49a06ff980d9b4(p265, p266) --[[ Line: 1397 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local v267 = l__EffectAssets__5.SiegeFlash:Clone();
    local v268 = l__Classes__3._x32ae459de0772e82:_x76b38494ff05a56c();
    v267.CFrame = CFrame.lookAt(p266, p266 + v268 * 10);
    v267.Parent = l__Effects__9;
    game.Debris:AddItem(v267, 2);
    local v269 = l__Classes__3.Util:getBasicRaycastParams();
    for _ = 1, 10 do
        local v270 = l__EffectAssets__5.SiegeTracer:Clone();
        v270.Parent = l__Effects__9;
        local v271 = l__Classes__3.Util:randomizeUnitVectorGaussian(v268, 20);
        v270.CFrame = CFrame.lookAt(p266, p266 + v271);
        p265:_x862a15c890e93186(v270);
        local v272 = workspace:Raycast(p266, v271 * 70, v269);
        if v272 then
            p265:_x9917b899e6060d83(v272.Position + v272.Normal * 0.1, v272.Position + v272.Normal);
        end;
        game.Debris:AddItem(v270, 2);
    end;
    p265:_x862a15c890e93186(v267);
    local l__Lighting__49 = game:GetService("Lighting");
    local v273 = Instance.new("ColorCorrectionEffect");
    v273.Contrast = 1;
    v273.Saturation = -1;
    v273.Parent = l__Lighting__49;
    game.Debris:AddItem(v273, 1);
    l__TweenService__1:Create(v273, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Contrast = 0
    }):Play();
    l__TweenService__1:Create(v273, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    p265:_xa9c1340b12fdb645(l__Lighting__49, -1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)):Play();
end;
function u1._xeca24645762b90d0(p274, p275, p276) --[[ Line: 1440 ]]
    -- upvalues: u3 (ref), l__EffectAssets__5 (copy), l__Effects__9 (copy), l__Classes__3 (copy)
    local v277 = u3:getLikelyVec3(p275);
    local v278 = u3:getLikelyVec3(p276);
    local v279 = l__EffectAssets__5.SiegeFlashOutsider:Clone();
    v279.CFrame = CFrame.lookAt(v277, v278);
    v279.Parent = l__Effects__9;
    game.Debris:AddItem(v279, 2);
    l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("SIEGE_BONUS_SHOT", true, {
        location = p275
    });
    p274:_x862a15c890e93186(v279);
end;
function u1._x43601a85ab5a2777(p280, p281, p282) --[[ Line: 1454 ]]
    -- upvalues: u3 (ref), l__EffectAssets__5 (copy), l__Effects__9 (copy), l__Classes__3 (copy)
    local v283 = u3:getLikelyVec3(p281);
    local v284 = u3:getLikelyVec3(p282);
    local v285 = l__EffectAssets__5.PhoenixFlash:Clone();
    v285.CFrame = CFrame.lookAt(v283, v284);
    v285.Parent = l__Effects__9;
    game.Debris:AddItem(v285, 2);
    l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("PHOENIX_SHOT", true, {
        location = p281
    });
    p280:_x862a15c890e93186(v285);
end;
function u1._xde2202b7e01dda21(p286, p287) --[[ Line: 1468 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local v288 = l__EffectAssets__5.PhoenixFlash:Clone();
    local v289 = l__Classes__3._x32ae459de0772e82:_x76b38494ff05a56c();
    v288.CFrame = CFrame.lookAt(p287 + v289 * 2, p287 + v289 * 10);
    v288.Parent = l__Effects__9;
    game.Debris:AddItem(v288, 2);
    if math.random() <= 0.0001 then
        l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("EAGLE", true);
        local v290 = l__EffectAssets__5.eagle:Clone();
        v290.Parent = p286._x364033b796543937;
        game.Debris:AddItem(v290, 4.1);
        l__TweenService__1:Create(v290, TweenInfo.new(4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
    end;
    for _, v291 in pairs(v288:GetDescendants()) do
        if v291:IsA("ParticleEmitter") then
            v291:Emit(v291:GetAttribute("EmitCount"));
        end;
    end;
    local l__Lighting__50 = game:GetService("Lighting");
    local v292 = Instance.new("ColorCorrectionEffect");
    v292.Contrast = 1;
    v292.Saturation = -1;
    v292.Parent = l__Lighting__50;
    game.Debris:AddItem(v292, 1);
    l__TweenService__1:Create(v292, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Contrast = 0
    }):Play();
    l__TweenService__1:Create(v292, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    p286:_xa9c1340b12fdb645(l__Lighting__50, -2.7, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)):Play();
end;
function u1._x15cfa3355252d8ab(p293, p294, u295, u296, u297, p298) --[[ Line: 1506 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__TweenService__1 (copy), l__Classes__3 (copy), u3 (ref), l__RunService__2 (copy), l__Effects__9 (copy)
    local u299 = nil;
    local v300, u301;
    if typeof(u296) == "Vector3" or not u296:IsA("Part") then
        v300 = nil;
        u301 = nil;
    else
        u301 = u296;
        u296 = u301.Position;
        v300 = true;
    end;
    local v302 = l__EffectAssets__5.BulletTracer:Clone();
    local u303 = p298 or 0.3;
    local u304 = u297 and 1 or u303;
    game.Debris:AddItem(v302, u304);
    local l__Destination__51 = v302.Destination;
    local l__Gunpoint__52 = v302.Gunpoint;
    local l__Point__53 = l__Gunpoint__52.Point;
    local _ = l__Destination__51.End;
    local l__Beam__54 = l__Point__53.Beam;
    local l__Trail__55 = l__Point__53.Trail;
    local l__Progress__56 = l__Beam__54.Progress;
    l__TweenService__1:Create(l__Progress__56, TweenInfo.new(u304), {
        Value = u304
    }):Play();
    local v305 = RaycastParams.new();
    v305.FilterType = Enum.RaycastFilterType.Include;
    v305.FilterDescendantsInstances = { workspace.Map };
    local l__Unit__57 = (u296 - u295).Unit;
    local l__Magnitude__58 = (u296 - u295).Magnitude;
    local v306 = workspace:Raycast(u295, l__Unit__57 * l__Magnitude__58, v305);
    if v306 and (v306.Instance:IsA("BasePart") and (v306.Instance.Transparency ~= 1 and (v306.Instance.CanCollide == true and (v306.Position - u296).Magnitude > 1))) then
        local l__Position__59 = v306.Position;
        p293:_x8e400b65a64810ee(l__Position__59, l__Position__59 + v306.Normal);
        l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("PROJ_BREAK", true, {
            location = l__Position__59
        });
        local v307 = workspace:Raycast(u296, -l__Unit__57 * l__Magnitude__58, v305);
        if v307 then
            local l__Position__60 = v307.Position;
            p293:_x8e400b65a64810ee(l__Position__60, l__Position__60 + v307.Normal);
            l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("PROJ_BREAK", true, {
                location = l__Position__60
            });
        end;
    end;
    l__Progress__56.Changed:Connect(function(p308) --[[ Line: 1568 ]]
        -- upvalues: u303 (copy), l__Beam__54 (copy), u3 (ref), u297 (copy), l__Trail__55 (copy), u304 (copy)
        if u303 <= p308 then
            l__Beam__54.Enabled = false;
        end;
        local v309 = u3:convNumRange(p308, 0, u303, -4, 5);
        local v310 = v309 - 2 - 0.01;
        local v311 = v309 + 2 + 0.01;
        local v312 = math.clamp(v310, 0.02, 0.98);
        local v313 = math.clamp(v311, 0.02, 0.98);
        local v314 = (v312 + v313) / 2;
        l__Beam__54.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(v312, 1),
            NumberSequenceKeypoint.new((v312 + v314) * 0.5, 0),
            NumberSequenceKeypoint.new(v314, 0),
            NumberSequenceKeypoint.new((v313 + v314) * 0.5, 0),
            NumberSequenceKeypoint.new(v313, 1),
            NumberSequenceKeypoint.new(1, 1)
        });
        if u297 then
            l__Trail__55.Enabled = true;
            l__Trail__55.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.9, u3:convNumRange(p308, 0, u304, 0.7, 1)), NumberSequenceKeypoint.new(1, 1) });
            local v315 = u3:convNumRange(p308, 0, 1, 0.1, 1);
            l__Trail__55.Width0 = v315;
            l__Trail__55.Width1 = v315;
        end;
    end);
    l__Gunpoint__52.CFrame = CFrame.lookAt(u295, u295 + p294 * 10);
    if v300 then
        u299 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 1611 ]]
            -- upvalues: u301 (ref), u296 (ref), l__Destination__51 (copy), u295 (copy), u299 (ref)
            if u301 then
                if u301.Name == "Head_Hurtbox" then
                    u296 = u301.Position - Vector3.new(0, 0.5, 0);
                else
                    u296 = u301.Position;
                end;
                l__Destination__51.CFrame = CFrame.lookAt(u296, u295);
            else
                u299:Disconnect();
            end;
        end);
    else
        l__Destination__51.CFrame = CFrame.lookAt(u296, u295);
    end;
    task.delay(u303, function() --[[ Line: 1627 ]]
        -- upvalues: u299 (ref)
        if u299 then
            u299:Disconnect();
        end;
    end);
    l__Beam__54.CurveSize0 = 0;
    l__Beam__54.CurveSize1 = 0;
    v302.Parent = l__Effects__9;
end;
function u1._x6ce5a388afc73444(p316, p317) --[[ Line: 1639 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local u318 = l__EffectAssets__5.ParryIndicator:Clone();
    local v319 = Instance.new("Weld");
    u318.Position = l__Classes__3.Util:getLikelyVec3(p317);
    v319.Part1 = u318;
    v319.Part0 = p317:FindFirstChild("Torso");
    v319.Parent = u318;
    u318.Parent = l__Effects__9;
    local v320 = Instance.new("Highlight");
    v320.FillTransparency = 1;
    v320.OutlineTransparency = 0;
    v320.OutlineColor = Color3.fromRGB(255, 255, 255);
    v320.DepthMode = Enum.HighlightDepthMode.Occluded;
    v320.Parent = p317;
    local u321 = p317:GetPropertyChangedSignal("Parent"):Once(function() --[[ Line: 1656 ]]
        -- upvalues: u318 (copy)
        if u318 then
            u318:Destroy();
        end;
    end);
    task.delay(1, function() --[[ Line: 1662 ]]
        -- upvalues: u321 (ref)
        if u321 then
            u321:Disconnect();
            u321 = nil;
        end;
    end);
    l__TweenService__1:Create(v320, TweenInfo.new(0.8, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        OutlineTransparency = 1
    }):Play();
    game.Debris:AddItem(u318, 1);
    game.Debris:AddItem(v320, 1);
    p316:_x862a15c890e93186(u318);
end;
function u1._xdb90ba944144b6c9(p322, u323, p324) --[[ Line: 1677 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Promise__6 (copy)
    local v325 = p324 or {};
    local l__RunService__61 = game:GetService("RunService");
    local l__TweenService__62 = game:GetService("TweenService");
    local l__CurrentCamera__63 = workspace.CurrentCamera;
    local u326 = l__EffectAssets__5.BoxHighlight:Clone();
    u326.Parent = p322._x364033b796543937;
    local v327 = Color3.new(1, 1, 1);
    local v328 = v325.color or v327;
    u326.BackgroundColor3 = v328;
    local u329 = u326:FindFirstChildOfClass("UIStroke");
    if u329 then
        u329.Color = v328;
    end;
    local u330 = v325.size_offset or 0;
    local l__duration__64 = v325.duration;
    local u331 = v325.requires_los == true;
    if v325.transparency then
        u326.BackgroundTransparency = v325.transparency;
    end;
    local u332 = false;
    local u333 = nil;
    local u334 = nil;
    local u335 = nil;
    local u336 = tick();
    local function u337() --[[ Line: 1710 ]]
        -- upvalues: u332 (ref), u333 (ref), u334 (ref), u335 (ref), u326 (copy)
        if u332 then
        else
            u332 = true;
            if u333 then
                u333:Disconnect();
                u333 = nil;
            end;
            if u334 then
                pcall(function() --[[ Line: 1722 ]]
                    -- upvalues: u334 (ref)
                    u334:Cancel();
                end);
                u334 = nil;
            end;
            if u335 then
                pcall(function() --[[ Line: 1729 ]]
                    -- upvalues: u335 (ref)
                    u335:Cancel();
                end);
                u335 = nil;
            end;
            if u326 then
                u326:Destroy();
            end;
        end;
    end;
    local function u341(p338) --[[ Line: 1740 ]]
        if not p338 then
            return {};
        end;
        if p338:IsA("BasePart") then
            return math.max(p338.Transparency, p338.LocalTransparencyModifier or 0) >= 1 and {} or { p338 };
        end;
        local v339 = {};
        for _, v340 in ipairs(p338:GetDescendants()) do
            if v340:IsA("BasePart") and math.max(v340.Transparency, v340.LocalTransparencyModifier or 0) < 1 then
                v339[#v339 + 1] = v340;
            end;
        end;
        return v339;
    end;
    local function u354(p342) --[[ Line: 1765 ]]
        -- upvalues: l__CurrentCamera__63 (copy)
        local v343 = (1 / 0);
        local v344 = (1 / 0);
        local v345 = (-1 / 0);
        local v346 = (-1 / 0);
        local v347 = false;
        for _, v348 in ipairs(p342) do
            local v349 = v348.Size * 0.5;
            local l__CFrame__65 = v348.CFrame;
            local v350 = {
                Vector3.new(v349.X, v349.Y, v349.Z),
                Vector3.new(v349.X, v349.Y, -v349.Z),
                Vector3.new(v349.X, -v349.Y, v349.Z),
                Vector3.new(v349.X, -v349.Y, -v349.Z),
                Vector3.new(-v349.X, v349.Y, v349.Z),
                Vector3.new(-v349.X, v349.Y, -v349.Z),
                Vector3.new(-v349.X, -v349.Y, v349.Z),
                (Vector3.new(-v349.X, -v349.Y, -v349.Z))
            };
            for _, v351 in ipairs(v350) do
                local v352, v353 = l__CurrentCamera__63:WorldToViewportPoint((l__CFrame__65 * CFrame.new(v351)).Position);
                v343 = math.min(v343, v352.X);
                v344 = math.min(v344, v352.Y);
                v345 = math.max(v345, v352.X);
                v346 = math.max(v346, v352.Y);
                if v353 and v352.Z > 0 then
                    v347 = true;
                end;
            end;
        end;
        if v347 then
            return v343, v344, v345, v346;
        else
            return nil;
        end;
    end;
    local function u358(p355) --[[ Line: 1807 ]]
        -- upvalues: u334 (ref), l__TweenService__62 (copy), u326 (copy), u329 (copy), u335 (ref), u337 (copy)
        if u334 then
        else
            local v356 = math.max(0.001, p355 or 1);
            local v357 = TweenInfo.new(v356, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            u334 = l__TweenService__62:Create(u326, v357, {
                BackgroundTransparency = 1
            });
            u334:Play();
            if u329 then
                u335 = l__TweenService__62:Create(u329, v357, {
                    Transparency = 1
                });
                u335:Play();
            end;
            u334.Completed:Once(u337);
        end;
    end;
    u333 = l__RunService__61.RenderStepped:Connect(function() --[[ Line: 1830 ]]
        -- upvalues: u323 (copy), u337 (copy), l__duration__64 (copy), u336 (copy), u358 (copy), u331 (copy), l__Classes__3 (ref), l__CurrentCamera__63 (copy), u326 (copy), u341 (copy), u354 (copy), u330 (copy)
        if u323 and u323.Parent then
            if l__duration__64 then
                local v359 = tick() - u336;
                if l__duration__64 <= v359 then
                    u337();
                    return;
                end;
                if math.max(0, l__duration__64 - 1) <= v359 then
                    u358(l__duration__64 - v359);
                end;
            end;
            if u331 then
                local v360 = l__Classes__3.Util:getLikelyVec3(u323);
                if not (v360 and l__Classes__3.Util:hasLineOfSight(l__CurrentCamera__63.CFrame.Position, v360)) then
                    u326.Visible = false;
                    return;
                end;
            end;
            local v361 = u341(u323);
            if #v361 == 0 then
                u326.Visible = false;
            else
                local v362, v363, v364, v365 = u354(v361);
                if v362 then
                    local l__ViewportSize__66 = l__CurrentCamera__63.ViewportSize;
                    local v366 = u330 * l__ViewportSize__66.X;
                    local v367 = u330 * l__ViewportSize__66.Y;
                    local v368 = v362 - v366 * 0.5;
                    local v369 = v364 + v366 * 0.5;
                    local v370 = v363 - v367 * 0.5;
                    local v371 = v365 + v367 * 0.5;
                    local v372 = math.max(1, v369 - v368);
                    local v373 = math.max(1, v371 - v370);
                    u326.AnchorPoint = Vector2.new(0, 0);
                    u326.Position = UDim2.new(0, v368, 0, v370);
                    u326.Size = UDim2.new(0, v372, 0, v373);
                    u326.Visible = true;
                else
                    u326.Visible = false;
                end;
            end;
        else
            u337();
        end;
    end);
    local v376 = l__Promise__6.new(function(u374, _, p375) --[[ Line: 1886 ]]
        -- upvalues: u337 (copy)
        if type(p375) == "function" then
            p375(function() --[[ Line: 1888 ]]
                -- upvalues: u337 (ref), u374 (copy)
                u337();
                u374();
            end);
        end;
    end);
    if type(v376.cancel) == "function" then
        local l__cancel__67 = v376.cancel;
        function v376.cancel(...) --[[ Line: 1897 ]]
            -- upvalues: u337 (copy), l__cancel__67 (copy)
            u337();
            return l__cancel__67(...);
        end;
    else
        v376.cancel = u337;
    end;
    return v376;
end;
function u1._xefb3cdf58d8aad85(u377, u378, u379, p380) --[[ Line: 1908 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__Promise__6 (copy), l__RunService__2 (copy), l__TweenService__1 (copy)
    local u381 = l__EffectAssets__5.BrokenIndicator:Clone();
    u381.Position = l__Classes__3.Util:getLikelyVec3(u378);
    local v382 = Instance.new("Weld");
    v382.Part1 = u381;
    v382.Part0 = u378:FindFirstChild("HumanoidRootPart");
    v382.Parent = u381;
    u381.Parent = l__Effects__9;
    u378:GetPropertyChangedSignal("Parent"):Once(function() --[[ Line: 1918 ]]
        -- upvalues: u381 (copy)
        if u381 then
            u381:Destroy();
        end;
    end);
    if p380 then
        for _, v383 in u378:GetChildren() do
            if v383:IsA("Highlight") then
                v383:Destroy();
            end;
        end;
        l__Promise__6.defer(function() --[[ Line: 1931 ]]
            -- upvalues: u378 (copy), l__EffectAssets__5 (ref), u377 (copy), l__RunService__2 (ref), l__Classes__3 (ref), u379 (copy), l__TweenService__1 (ref)
            local u384 = Instance.new("Highlight");
            u384.FillTransparency = 0;
            u384.OutlineTransparency = 1;
            u384.FillColor = Color3.fromRGB(255, 0, 0);
            u384.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
            u384.Parent = u378;
            local u385 = Random.new();
            local u386 = os.clock();
            local u387 = l__EffectAssets__5.Tracer:Clone();
            u387.AnchorPoint = Vector2.new(0.5, 0.5);
            u387.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
            u387.BorderSizePixel = 0;
            u387.Parent = u377._x364033b796543937;
            local u388 = nil;
            local l__CurrentCamera__68 = workspace.CurrentCamera;
            u388 = l__RunService__2.RenderStepped:Connect(function() --[[ Line: 1963 ]]
                -- upvalues: u384 (copy), u378 (ref), u388 (ref), u387 (copy), u386 (copy), l__Classes__3 (ref), u379 (ref), l__TweenService__1 (ref), u385 (copy), l__CurrentCamera__68 (copy)
                if u384 and (u378 and u378.Parent == workspace.Entities) then
                    local v389 = os.clock() - u386;
                    local v390 = l__Classes__3.Util:convNumRange(v389, 0, u379, 0, 1);
                    if v390 >= 1 then
                        if u388 then
                            u388:Disconnect();
                        end;
                        if u384 then
                            u384:Destroy();
                        end;
                        if u387 then
                            u387:Destroy();
                        end;
                    else
                        u384.FillTransparency = l__TweenService__1:GetValue(v390, Enum.EasingStyle.Exponential, Enum.EasingDirection.In) + u385:NextNumber(-0.25, 0.25);
                        local v391 = l__Classes__3._x32ae459de0772e82:_x4a566e19c4041715();
                        local v392 = Vector2.new(v391.X.Offset, v391.Y.Offset);
                        local v393 = l__Classes__3.Util:getLikelyVec3(u378);
                        local v394, v395 = l__CurrentCamera__68:WorldToViewportPoint(v393);
                        local v396;
                        if v395 then
                            v396 = Vector2.new(v394.X, v394.Y);
                        else
                            local v397 = Vector2.new(v394.X - v392.X, v394.Y - v392.Y);
                            if v394.Z < 0 then
                                v397 = -v397;
                            end;
                            if v397.Magnitude == 0 then
                                v397 = Vector2.new(0, -1);
                            end;
                            local l__ViewportSize__69 = l__CurrentCamera__68.ViewportSize;
                            local v398 = math.abs(((v397.X > 0 and (l__ViewportSize__69.X - 1 or 1) or 1) - v392.X) / v397.X);
                            local v399 = math.abs(((v397.Y > 0 and l__ViewportSize__69.Y - 1 or 1) - v392.Y) / v397.Y);
                            v396 = v392 + v397 * math.min(v398, v399);
                        end;
                        local v400 = v396 - v392;
                        local l__Magnitude__70 = v400.Magnitude;
                        local v401 = math.atan2(v400.Y, v400.X);
                        u387.Size = UDim2.new(0, l__Magnitude__70, 0, 1);
                        u387.Position = UDim2.fromOffset((v392.X + v396.X) / 2, (v392.Y + v396.Y) / 2);
                        u387.Rotation = math.deg(v401);
                        u387.BackgroundTransparency = u384.FillTransparency;
                        local _ = (v393 - workspace.CurrentCamera.CFrame.Position).Magnitude;
                    end;
                else
                    if u388 then
                        u388:Disconnect();
                    end;
                    if u384 then
                        u384:Destroy();
                    end;
                    if u387 then
                        u387:Destroy();
                    end;
                end;
            end);
            game.Debris:AddItem(u384, u379);
        end);
    end;
    for _, u402 in u381:GetChildren() do
        if u402:IsA("ParticleEmitter") then
            u402.Enabled = true;
            task.delay(u379, function() --[[ Line: 2030 ]]
                -- upvalues: u402 (copy)
                if u402 then
                    u402.Enabled = false;
                end;
            end);
        end;
    end;
    u377:_x862a15c890e93186(u381);
    game.Debris:AddItem(u381, u379);
end;
function u1._xc2317b9cc3ec4049(p403) --[[ Line: 2042 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local l__LookVector__71 = workspace.CurrentCamera.CFrame.LookVector;
    local l__Position__72 = workspace.CurrentCamera.CFrame.Position;
    local v404 = CFrame.lookAt(l__Position__72 + l__LookVector__71 * 10, l__Position__72 + l__LookVector__71 * 20);
    local v405 = l__EffectAssets__5.ClashLocal:Clone();
    game.Debris:AddItem(v405, 1);
    v405.CFrame = v404;
    v405.Parent = l__Effects__9;
    p403:_x862a15c890e93186(v405);
    local l__Lighting__73 = game:GetService("Lighting");
    local v406 = Instance.new("ColorCorrectionEffect");
    v406.Contrast = 1;
    v406.Saturation = -1;
    v406.Parent = l__Lighting__73;
    game.Debris:AddItem(v406, 1);
    l__TweenService__1:Create(v406, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Contrast = 0
    }):Play();
    l__TweenService__1:Create(v406, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    p403:_xa9c1340b12fdb645(l__Lighting__73, -0.3, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)):Play();
end;
local function u410(p407, p408) --[[ Line: 2064 ]]
    local v409 = {};
    while p408 and p408 ~= p407 do
        table.insert(v409, 1, p408.Name .. "|" .. p408.ClassName);
        p408 = p408.Parent;
    end;
    return table.concat(v409, "/");
end;
function u1._x15bff58383b08c9f(_, u411, p412) --[[ Line: 2076 ]]
    -- upvalues: l__Effects__9 (copy), l__Promise__6 (copy), u410 (copy), l__RunService__2 (copy)
    local v413 = p412 or {};
    local v414 = l__Effects__9;
    local v415 = v413.fillColor or Color3.fromRGB(255, 255, 255);
    local v416 = v413.outlineColor or Color3.fromRGB(0, 0, 0);
    local v417 = v413.fillTransparency == nil and 0.5 or (v413.fillTransparency or 0.5);
    local v418 = v413.outlineTransparency == nil and 0 or (v413.outlineTransparency or 0);
    local v419 = v413.depthMode or Enum.HighlightDepthMode.AlwaysOnTop;
    local v420;
    if u411 then
        v420 = u411:IsA("Instance");
    else
        v420 = u411;
    end;
    assert(v420, "cloneForHighlight: target must be an Instance");
    u411.Archivable = true;
    local u421 = u411:Clone();
    u421.Name = u411.Name .. "_HighlightClone";
    u421.Parent = v414;
    for _, u422 in ipairs(u421:GetDescendants()) do
        if u422:IsA("BasePart") and u422.Transparency ~= 1 then
            l__Promise__6.defer(function() --[[ Line: 2097 ]]
                -- upvalues: u422 (copy)
                u422.Anchored = true;
                u422.CanCollide = false;
                u422.CanTouch = false;
                u422.CanQuery = false;
                u422.Transparency = 0.999;
                u422.CastShadow = false;
                u422.CollisionGroup = "Entities";
            end);
        elseif not (u422:IsA("Humanoid") or u422:IsA("SpecialMesh")) then
            u422:Destroy();
        end;
    end;
    if u421:IsA("BasePart") then
        u421.Anchored = true;
        u421.CanCollide = false;
        u421.CanTouch = false;
        u421.CanQuery = false;
        u421.Transparency = 1;
        u421.CastShadow = false;
    end;
    local u423 = {};
    local u424 = {};
    if u411:IsA("Model") or u411:IsA("Folder") then
        for _, v425 in ipairs(u411:GetDescendants()) do
            if v425:IsA("BasePart") then
                u423[u410(u411, v425)] = v425;
            end;
        end;
    end;
    if u421:IsA("Model") or u421:IsA("Folder") then
        for _, v426 in ipairs(u421:GetDescendants()) do
            if v426:IsA("BasePart") then
                u424[u410(u421, v426)] = v426;
            end;
        end;
    elseif u421:IsA("BasePart") then
        u424.root = u421;
    end;
    local u427 = Instance.new("Highlight");
    u427.Name = "CloneHighlight";
    u427.Adornee = u421;
    u427.FillColor = v415;
    u427.OutlineColor = v416;
    u427.FillTransparency = v417;
    u427.OutlineTransparency = v418;
    u427.DepthMode = v419;
    u427.Parent = u421;
    local u428 = true;
    local u429 = nil;
    u429 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 2156 ]]
        -- upvalues: u428 (ref), u411 (copy), u421 (copy), u429 (ref), u427 (copy), u423 (copy), u424 (copy)
        if u428 then
            if u411.Parent and u421.Parent then
                if u411:IsA("BasePart") and u421:IsA("BasePart") then
                    u421.CFrame = u411.CFrame;
                elseif u411:IsA("Model") and u421:IsA("Model") then
                    for v430, v431 in pairs(u423) do
                        local v432 = u424[v430];
                        if v432 and (v431 and v431.Parent) then
                            v432.CFrame = v431.CFrame;
                        end;
                    end;
                else
                    if u411:IsA("PVInstance") and u421:IsA("PVInstance") then
                        u421:PivotTo(u411:GetPivot());
                    end;
                end;
            else
                u428 = false;
                if u429 then
                    u429:Disconnect();
                end;
                if u427 then
                    u427:Destroy();
                end;
                if u421 then
                    u421:Destroy();
                end;
            end;
        end;
    end);
    return u421, u427, function() --[[ Name: cleanup, Line 2187 ]]
        -- upvalues: u428 (ref), u429 (ref), u427 (copy), u421 (copy)
        if u428 then
            u428 = false;
            if u429 then
                u429:Disconnect();
            end;
            if u427 then
                u427:Destroy();
            end;
            if u421 then
                u421:Destroy();
            end;
        end;
    end;
end;
function u1._xa448c637f5a4a31f(p433) --[[ Line: 2206 ]]
    -- upvalues: l__Classes__3 (copy), l__UIAssets__4 (copy), l__TweenService__1 (copy)
    l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("HUNTED_WARNING", true);
    if p433._xe6e7c40c2a38ff4a and p433._xe6e7c40c2a38ff4a.Parent ~= nil then
        p433._xe6e7c40c2a38ff4a:Destroy();
    end;
    local v434 = l__UIAssets__4.ReturnWarning:Clone();
    v434.Parent = p433._x364033b796543937;
    l__TweenService__1:Create(v434.Left, TweenInfo.new(0.66, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(0, 1)
    }):Play();
    l__TweenService__1:Create(v434.Right, TweenInfo.new(0.66, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(0, 1)
    }):Play();
    p433._xe6e7c40c2a38ff4a = v434;
    local v435 = l__Classes__3._xafc4950d7b094088:_x70830fd0300678f5({
        header_text = "▪ [ RETURN TO COMBAT ] ▪",
        subheader_text = "A SNIPER IS ON YOU // PARRY THE BULLET",
        color = Color3.fromRGB(255, 49, 49)
    });
    v434.Destroying:Connect(v435);
    game.Debris:AddItem(v434, 20);
end;
function u1._x13f7ca069228beb8(p436) --[[ Line: 2232 ]]
    -- upvalues: l__Classes__3 (copy)
    if p436._xe6e7c40c2a38ff4a and p436._xe6e7c40c2a38ff4a.Parent ~= nil then
        p436._xe6e7c40c2a38ff4a:Destroy();
    end;
    l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("HUNTED_LOST", true, {
        location = workspace.CurrentCamera.CFrame.Position
    });
end;
function u1._x86ce1dbbe7203fe8(_, p437, p438) --[[ Line: 2240 ]]
    -- upvalues: l__Classes__3 (copy)
    l__Classes__3._xafc4950d7b094088:_x70830fd0300678f5({
        header_text = "▪ [ TRAINING STOPPED ] ▪",
        life_time = 2.5,
        subheader_text = p437 .. " Your score is " .. tostring(p438) .. ".",
        color = Color3.fromRGB(255, 49, 49)
    });
end;
function u1._x4ba74f83f303bd5b(_, p439, p440) --[[ Line: 2249 ]]
    -- upvalues: l__TweenService__1 (copy), l__Classes__3 (copy), l__EffectAssets__5 (copy), l__Effects__9 (copy), u3 (ref)
    if p440 then
        local v441 = Instance.new("Highlight");
        v441.FillColor = Color3.fromRGB(255, 255, 255);
        v441.OutlineTransparency = 1;
        v441.FillTransparency = 0;
        v441.Enabled = true;
        v441.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
        v441.Adornee = p440;
        v441.Parent = p440;
        l__TweenService__1:Create(v441, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FillTransparency = 1
        }):Play();
        l__TweenService__1:Create(v441, TweenInfo.new(0.7, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            FillColor = Color3.fromRGB(255, 0, 0)
        }):Play();
        game.Debris:AddItem(v441, 2);
    end;
    local v442 = l__Classes__3.Util:getLikelyVec3(p440);
    local u443 = l__EffectAssets__5.DamageNumber:Clone();
    game.Debris:AddItem(u443, 1.5);
    u443.Position = v442;
    u443.Parent = l__Effects__9;
    u443.BillboardGui.TextLabel.Text = tostring(p439);
    local l__TextLabel__74 = u443.BillboardGui.TextLabel;
    l__TextLabel__74.Size = UDim2.fromScale(2, 2);
    task.delay(0.015, function() --[[ Line: 2287 ]]
        -- upvalues: l__TweenService__1 (ref), l__TextLabel__74 (copy)
        l__TweenService__1:Create(l__TextLabel__74, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(0.5, 0.5)
        }):Play();
    end);
    l__TweenService__1:Create(l__TextLabel__74.Y, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Value = 1
    }):Play();
    l__TweenService__1:Create(l__TextLabel__74.X, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Value = 1
    }):Play();
    l__TweenService__1:Create(u443.BillboardGui.ImageLabel, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = 1
    }):Play();
    l__TextLabel__74.X.Changed:Connect(function() --[[ Line: 2296 ]]
        -- upvalues: u3 (ref), l__TextLabel__74 (copy), u443 (copy)
        local v444 = u3:numLerp(0.2, 1, l__TextLabel__74.X.Value);
        local v445 = u3:numLerp(1, 0.1, l__TextLabel__74.Y.Value);
        u443.BillboardGui.ImageLabel.Size = UDim2.fromScale(v444, v445);
    end);
    l__TweenService__1:Create(u443.BillboardGui.TextLabel, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        TextTransparency = 1
    }):Play();
    l__TweenService__1:Create(u443.BillboardGui.TextLabel.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Transparency = 1
    }):Play();
end;
function u1._x3fa2085d4aec1321(p446, p447, p448) --[[ Line: 2306 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local v449 = l__EffectAssets__5.Clash:Clone();
    game.Debris:AddItem(v449, 1);
    v449.Position = p447;
    v449.Parent = l__Effects__9;
    p446:_x862a15c890e93186(v449);
    if p448 then
        local l__Lighting__75 = game:GetService("Lighting");
        local v450 = Instance.new("ColorCorrectionEffect");
        v450.Contrast = 1;
        v450.Saturation = -1;
        v450.Parent = l__Lighting__75;
        game.Debris:AddItem(v450, 1);
        l__TweenService__1:Create(v450, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Contrast = 0
        }):Play();
        l__TweenService__1:Create(v450, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        p446:_xa9c1340b12fdb645(l__Lighting__75, -0.3, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)):Play();
    end;
end;
function u1._x9917b899e6060d83(_, p451, p452) --[[ Line: 2327 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy)
    local v453 = l__EffectAssets__5.GunImpact:Clone();
    game.Debris:AddItem(v453, 5);
    v453.CFrame = CFrame.lookAt(p451, p452);
    v453.Parent = l__Effects__9;
    for _, v454 in v453:GetDescendants() do
        if v454:IsA("ParticleEmitter") then
            v454:Emit(v454:GetAttribute("EmitCount"));
        end;
    end;
end;
function u1._x8e400b65a64810ee(_, p455, p456) --[[ Line: 2340 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy)
    local v457 = l__EffectAssets__5.Wallbang:Clone();
    game.Debris:AddItem(v457, 5);
    v457.CFrame = CFrame.lookAt(p455, p456);
    v457.Parent = l__Effects__9;
    for _, v458 in v457:GetDescendants() do
        if v458:IsA("ParticleEmitter") then
            v458:Emit(v458:GetAttribute("EmitCount"));
        end;
    end;
end;
function u1._x03800d3d1d966657(_, p459) --[[ Line: 2353 ]]
    -- upvalues: l__Classes__3 (copy), l__EffectAssets__5 (copy), l__Effects__9 (copy)
    local l__gunfire_point__76 = l__Classes__3._xd1706540247308ea._xcfefdf98297dd62e.gun.gunfire_point;
    local l__gunfire_dir__77 = l__Classes__3._xd1706540247308ea._xcfefdf98297dd62e.gun.gunfire_dir;
    if l__gunfire_point__76 and l__gunfire_dir__77 then
        local v460 = workspace.CurrentCamera.CFrame.Position + (p459 - l__gunfire_point__76).Magnitude / 2 * l__gunfire_dir__77;
        local v461 = l__EffectAssets__5.GunHit:Clone();
        game.Debris:AddItem(v461, 1);
        v461.CFrame = CFrame.lookAt(p459, v460);
        v461.Parent = l__Effects__9;
        for _, v462 in v461:GetDescendants() do
            if v462:IsA("ParticleEmitter") then
                v462:Emit(v462:GetAttribute("EmitCount"));
            end;
        end;
    end;
end;
function u1._xe7fa9488c44c59d6(p463, p464) --[[ Line: 2372 ]]
    -- upvalues: l__Classes__3 (copy), l__EffectAssets__5 (copy), l__Effects__9 (copy)
    local v465 = l__Classes__3.Util:getLikelyVec3(p464);
    local v466 = l__EffectAssets__5.GunKill:Clone();
    game.Debris:AddItem(v466, 1);
    v466.Position = v465;
    v466.Parent = l__Effects__9;
    p463:_x862a15c890e93186(v466);
end;
function u1._x67f094c26bedf245(p467) --[[ Line: 2382 ]]
    -- upvalues: l__Classes__3 (copy)
    local v468 = Instance.new("Frame");
    v468.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    v468.Size = UDim2.fromScale(1, 1);
    v468.BackgroundTransparency = 0;
    v468.Parent = p467._x364033b796543937;
    v468.ZIndex = 100;
    game.Debris:AddItem(v468, 0.3);
    p467:_xa9c1340b12fdb645(game:GetService("Lighting"), 100, TweenInfo.new(0.7, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)):Play();
    local v469 = l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("STATIC", true);
    if v469 then
        game.Debris:AddItem(v469, 0.3);
    end;
end;
function u1._x52122b574720a201(p470) --[[ Line: 2399 ]]
    -- upvalues: l__UIAssets__4 (copy), l__Classes__3 (copy), l__TweenService__1 (copy)
    local u471 = l__UIAssets__4.Feed:Clone();
    u471.Parent = p470._x364033b796543937;
    game.Debris:AddItem(u471, 0.8);
    task.spawn(function() --[[ Line: 2405 ]]
        -- upvalues: u471 (copy)
        while u471 and u471.Parent ~= nil do
            u471.TextLabel.Visible = not u471.TextLabel.Visible;
            task.wait(0.16);
        end;
    end);
    local l__Lighting__78 = game:GetService("Lighting");
    l__Lighting__78.ExposureCompensation = 4;
    p470:_xee1cb09b95057806(0.4, 4, 0.8);
    l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("TAPE_START", true);
    local u472 = Instance.new("BlurEffect", l__Lighting__78);
    u472.Size = 30;
    task.delay(0.8, function() --[[ Line: 2421 ]]
        -- upvalues: l__TweenService__1 (ref), l__Lighting__78 (copy), u472 (copy)
        l__TweenService__1:Create(l__Lighting__78, TweenInfo.new(0.4, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            ExposureCompensation = 0
        }):Play();
        l__TweenService__1:Create(u472, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        game.Debris:AddItem(u472, 1);
    end);
end;
function u1._xc899070684394b2b(p473) --[[ Line: 2428 ]]
    -- upvalues: l__UIAssets__4 (copy), l__Classes__3 (copy), l__TweenService__1 (copy)
    local v474 = l__UIAssets__4.Feed:Clone();
    v474.TextLabel.Text = "× SIGNAL LOST ×";
    v474.TextLabel.Visible = true;
    v474.Parent = p473._x364033b796543937;
    game.Debris:AddItem(v474, 0.2);
    local v475 = l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("STATIC", true);
    game.Debris:AddItem(v475, 0.2);
    local u476 = Instance.new("BlurEffect", game:GetService("Lighting"));
    u476.Size = 30;
    task.delay(0.2, function() --[[ Line: 2440 ]]
        -- upvalues: l__TweenService__1 (ref), u476 (copy)
        l__TweenService__1:Create(u476, TweenInfo.new(0.4, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        game.Debris:AddItem(u476, 0.4);
    end);
end;
function u1._x035085183a54275c(p477) --[[ Line: 2447 ]]
    -- upvalues: l__UIAssets__4 (copy), l__TweenService__1 (copy), l__Classes__3 (copy)
    local v478 = Instance.new("Frame");
    v478.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    v478.Size = UDim2.fromScale(1, 1);
    v478.BackgroundTransparency = 0;
    v478.Parent = p477._x364033b796543937;
    v478.ZIndex = 100;
    game.Debris:AddItem(v478, 0.09);
    local v479 = l__UIAssets__4.Deathscreen:Clone();
    v479.Parent = p477._x364033b796543937;
    for _, v480 in v479.Flatlined:GetChildren() do
        if v480:IsA("ImageLabel") then
            local v481 = Random.new();
            l__TweenService__1:Create(v480, TweenInfo.new(v481:NextNumber(0.5, 1.5), Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                ImageTransparency = 0
            }):Play();
        end;
    end;
    v479.Code.CodeScroll.CanvasPosition = Vector2.new(0, 2000);
    l__TweenService__1:Create(v479.Code.CodeScroll, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
        CanvasPosition = Vector2.new(0, 0)
    }):Play();
    l__Classes__3._xafc4950d7b094088._xef1fb561476b0a5b.Enabled = false;
    return v479;
end;
function u1._x3e8ad1990fd4b734(_, u482) --[[ Line: 2473 ]]
    -- upvalues: l__Trove__7 (copy), l__UIAssets__4 (copy), l__RunService__2 (copy), l__Classes__3 (copy)
    local u483 = l__Trove__7.new();
    u483:AttachToInstance(u482);
    local u484 = l__UIAssets__4.EnemyHeader:Clone();
    u483:Add(u484);
    u484.Adornee = u482:FindFirstChild("HumanoidRootPart");
    u484.Parent = u482;
    u483:Connect(l__RunService__2.Heartbeat, function() --[[ Line: 2483 ]]
        -- upvalues: u482 (copy), u483 (copy), l__Classes__3 (ref), u484 (copy)
        if u482 and u482.Parent then
            local l__Position__79 = workspace.CurrentCamera.CFrame.Position;
            local v485 = l__Classes__3.Util:getLikelyVec3(u482);
            if l__Classes__3.Util:hasLineOfSight(l__Position__79, v485) then
                u484.Enabled = true;
            else
                u484.Enabled = false;
            end;
        else
            u483:Clean();
        end;
    end);
end;
function u1._xfd5b32895b6d7862(u486) --[[ Line: 2497 ]]
    -- upvalues: l__EffectAssets__5 (copy), u2 (ref), u4 (ref), u3 (ref), l__RunService__2 (copy)
    local function v489() --[[ Line: 2498 ]]
        -- upvalues: l__EffectAssets__5 (ref), u486 (copy)
        local v487 = l__EffectAssets__5.Speedlines:Clone();
        v487.Parent = workspace.CurrentCamera;
        u486._x6ea573c6f5fbebd9.Speedlines = {
            model = v487,
            emitters = {},
            connections = {}
        };
        for _, v488 in pairs(v487:GetDescendants()) do
            if v488:IsA("ParticleEmitter") then
                table.insert(u486._x6ea573c6f5fbebd9.Speedlines.emitters, v488);
            end;
        end;
    end;
    local function u505(p490) --[[ Line: 2513 ]]
        -- upvalues: u2 (ref), u4 (ref), u486 (copy), u3 (ref)
        local v491 = u2._x1d287c838240a901.Magnitude > u4.SPEEDLINES_THRESHOLD;
        if v491 then
            local l__CurrentCamera__80 = workspace.CurrentCamera;
            local v492 = u2._x8500fad561a4bbc9 and u2._x1d287c838240a901.Unit or u486:_x44e4f4fb454e44ea(u2._x1d287c838240a901);
            local v493 = not v491 and 0 or u3:convNumRange(math.clamp(u2._x1d287c838240a901.Magnitude, u4.SPEEDLINES_THRESHOLD, u4.SPEEDLINES_SPEED_LIMIT), u4.SPEEDLINES_THRESHOLD, u4.SPEEDLINES_SPEED_LIMIT, 0, 1);
            local v494 = not v491 and 0 or u3:numLerp(1, u4.SPEEDLINES_RATE, v493);
            local v495 = not v491 and 1 or u3:numLerp(u4.SPEEDLINES_FIRST_TRANSPARENCY, u4.SPEEDLINES_LAST_TRANSPARENCY, v493);
            local v496 = l__CurrentCamera__80.CFrame.LookVector:Dot(v492);
            local v497 = math.clamp(v496, 0, 1);
            local v498 = 2 - v493;
            local v499 = not v491 and 0.01 or u3:numLerp(u4.SPEEDLINES_FIRST_APPEARANCE * v498, u4.SPEEDLINES_LAST_APPEARANCE * v498, v497);
            local v500;
            if v491 then
                local v501 = u3:numLerp(u4.SPEEDLINES_FIRST_SPEED, u4.SPEEDLINES_LAST_SPEED, v493);
                v500 = NumberRange.new(v501);
            else
                v500 = NumberRange.new(0);
            end;
            local l__model__81 = u486._x6ea573c6f5fbebd9.Speedlines.model;
            for _, v502 in pairs(u486._x6ea573c6f5fbebd9.Speedlines.emitters) do
                v502.Enabled = v491 and true or false;
                v502.Speed = v500;
                v502.Rate = v494 > 0 and (math.random(0, v494) or 0) or 0;
                v502.Transparency = v495 == 1 and NumberSequence.new(1) or NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(v499, 1),
                    NumberSequenceKeypoint.new(v499 + 0.05, v495, u4.SPEEDLINES_ENVELOPE),
                    NumberSequenceKeypoint.new(1, 1)
                });
                local v503 = l__CurrentCamera__80.CFrame.Position + v492 * u4.SPEEDLINES_DISTANCE;
                l__model__81.Position = v503;
                l__model__81.CFrame = l__model__81.CFrame:Lerp(CFrame.lookAt(v503, l__CurrentCamera__80.CFrame.Position), 1 * p490);
            end;
        else
            for _, v504 in pairs(u486._x6ea573c6f5fbebd9.Speedlines.emitters) do
                v504.Transparency = NumberSequence.new(1);
            end;
        end;
    end;
    if not u486._x6ea573c6f5fbebd9.Speedlines then
        v489();
    end;
    table.insert(u486._x6ea573c6f5fbebd9.Speedlines.connections, l__RunService__2.RenderStepped:Connect(function(p506) --[[ Line: 2607 ]]
        -- upvalues: u505 (copy)
        u505(p506);
    end));
end;
function u1._x028f87d83a86bda2(p507) --[[ Line: 2614 ]]
    -- upvalues: l__UIAssets__4 (copy), l__TweenService__1 (copy)
    local v508 = {
        color_correction = Instance.new("ColorCorrectionEffect", game.Lighting),
        white_vignette = l__UIAssets__4.WhiteVignette:Clone()
    };
    v508.white_vignette.Parent = p507._x364033b796543937;
    v508.color_correction.Brightness = 0.1;
    v508.color_correction.Contrast = 0.5;
    for _, v509 in v508 do
        game.Debris:AddItem(v509, 0.25);
    end;
    local v510 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v511 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    l__TweenService__1:Create(v508.white_vignette, v511, {
        ImageTransparency = 1
    }):Play();
    l__TweenService__1:Create(v508.color_correction, v510, {
        Brightness = 0,
        Contrast = 0
    }):Play();
end;
function u1._x509a174918a07407(p512, p513, p514, p515, p516) --[[ Line: 2635 ]]
    -- upvalues: u3 (ref), l__EffectAssets__5 (copy), l__Effects__9 (copy), l__Classes__3 (copy), l__TweenService__1 (copy), l__UIAssets__4 (copy)
    if p514 and p515 then
        local v517 = u3:getLikelyVec3(p514);
        local l__Unit__82 = (v517 - u3:getLikelyVec3(p515)).Unit;
        p513 = CFrame.lookAt(v517, v517 + l__Unit__82 * 2);
    end;
    local l__Lighting__83 = game:GetService("Lighting");
    local v518 = p516 and l__EffectAssets__5.defaultParryOutsider:Clone() or l__EffectAssets__5.defaultParry:Clone();
    v518:PivotTo(p513);
    v518.Parent = l__Effects__9;
    game.Debris:AddItem(v518, 3);
    p512:_x862a15c890e93186(v518);
    if p516 then
    else
        local v519 = {};
        local v520 = Instance.new("NumberValue");
        v520.Value = 5;
        v519.value = v520;
        v519.cancel_when_zero = true;
        l__Classes__3._x32ae459de0772e82:_x8ca42af5fe3be726(v519);
        l__TweenService__1:Create(v520, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = 0
        }):Play();
        local v521 = l__UIAssets__4.SpeedEffect:Clone();
        v521.Parent = p512._x364033b796543937;
        v521.ImageTransparency = 0;
        game.Debris:AddItem(v521, 1);
        l__TweenService__1:Create(v521, TweenInfo.new(0.3), {
            Size = UDim2.new(2.5, 0, 2.5, 0)
        }):Play();
        local v522 = Instance.new("ColorCorrectionEffect");
        v522.Contrast = 2;
        v522.Parent = l__Lighting__83;
        game.Debris:AddItem(v522, 1);
        l__TweenService__1:Create(v522, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Contrast = 0
        }):Play();
        p512:_xa9c1340b12fdb645(l__Lighting__83, -2, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)):Play();
    end;
end;
function u1._x6c7a692ba8bec2c9(p523) --[[ Line: 2683 ]]
    -- upvalues: l__Classes__3 (copy), l__TweenService__1 (copy), l__UIAssets__4 (copy)
    local v524 = {};
    local v525 = {};
    local v526 = Instance.new("NumberValue");
    v526.Value = 5;
    v525.value = v526;
    v525.cancel_when_zero = true;
    l__Classes__3._x32ae459de0772e82:_x8ca42af5fe3be726(v525);
    l__TweenService__1:Create(v526, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
    v524.speed_effect = l__UIAssets__4.SpeedEffect:Clone();
    v524.speed_effect.Parent = p523._x364033b796543937;
    for _, v527 in v524 do
        game.Debris:AddItem(v527, 0.25);
    end;
    local v528 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    l__TweenService__1:Create(v524.speed_effect, v528, {
        ImageTransparency = 1,
        Size = UDim2.new(2.5, 0, 2.5, 0)
    }):Play();
end;
function u1._x8b36c05a0442e26f(p529) --[[ Line: 2707 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__TweenService__1 (copy), l__Classes__3 (copy)
    local v530 = l__EffectAssets__5.Impact:Clone();
    v530.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
    v530.Parent = p529._x364033b796543937;
    l__TweenService__1:Create(v530, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
    game.Debris:AddItem(v530, 1.5);
    l__Classes__3._xafc4950d7b094088:_x70830fd0300678f5({
        header_text = "▪ [ OVERTIME ] ▪",
        subheader_text = "PLAYABLE AREA WILL SHRINK",
        life_time = 8,
        color = Color3.fromRGB(255, 49, 49)
    });
    l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("GENERIC_POSITIVE", true);
end;
function u1._x570186a4468fb004(p531, p532, p533) --[[ Line: 2724 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local v534 = l__EffectAssets__5.SlamTarget:Clone();
    v534.Position = l__Classes__3.Util:getLikelyVec3(p532);
    v534.Parent = l__Effects__9;
    game.Debris:AddItem(v534, 1.5);
    p531:_x862a15c890e93186(v534);
    if p533 then
        local v535 = l__EffectAssets__5.Impact:Clone();
        v535.Parent = p531._x364033b796543937;
        l__TweenService__1:Create(v535, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        game.Debris:AddItem(v535, 1.5);
    end;
end;
function u1._x80d249ebbfe99eaf(p536, p537) --[[ Line: 2740 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__TweenService__1 (copy)
    local v538;
    if p537 then
        v538 = Color3.fromRGB(unpack(p537));
    else
        v538 = Color3.fromRGB(255, 255, 255);
    end;
    local v539 = l__EffectAssets__5.Impact:Clone();
    v539.BackgroundColor3 = v538;
    v539.Parent = p536._x364033b796543937;
    l__TweenService__1:Create(v539, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
    game.Debris:AddItem(v539);
end;
function u1._x8e4edde212869bee(p540, p541, p542) --[[ Line: 2754 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), l__Classes__3 (copy), l__TweenService__1 (copy)
    local v543 = l__EffectAssets__5.GroundSlamEffect:Clone();
    v543:PivotTo(CFrame.new(p541));
    v543.Parent = l__Effects__9;
    game.Debris:AddItem(v543, 1.5);
    p540:_x862a15c890e93186(v543);
    if p542 then
    else
        local v544 = {};
        local v545 = Instance.new("NumberValue");
        v545.Value = 5;
        v544.value = v545;
        v544.cancel_when_zero = true;
        l__Classes__3._x32ae459de0772e82:_x8ca42af5fe3be726(v544);
        l__TweenService__1:Create(v545, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = 0
        }):Play();
    end;
end;
function u1._x5593abca8c0fb4cd(_, u546) --[[ Line: 2774 ]]
    -- upvalues: l__InternalSymbols__8 (copy), l__Classes__3 (copy), l__EffectAssets__5 (copy), l__Effects__9 (copy), l__TweenService__1 (copy), u3 (ref)
    local v548 = (function() --[[ Name: getDirection, Line 2775 ]]
        -- upvalues: l__InternalSymbols__8 (ref), l__Classes__3 (ref)
        local v547 = l__InternalSymbols__8.owner("", l__Classes__3._xd1706540247308ea._xcfefdf98297dd62e.melee);
        if v547 then
            if v547._x0cda07b8bd2ab5ec and typeof(v547._x0cda07b8bd2ab5ec) == "function" then
                return v547:_x0cda07b8bd2ab5ec();
            end;
            warn("MELEE MODULE DOES NOT HAVE getAttackDirection : ", v547);
        else
            warn("hitParticles VISUAL EFFECT FAILED, NO MELEE WEAPON");
        end;
    end)();
    if v548 then
        local v549 = l__EffectAssets__5.HitParticles:Clone();
        local v550 = -v548;
        v549.CFrame = CFrame.lookAt(u546 + v550 * 2, u546 + v550 * 5);
        v549.Parent = l__Effects__9;
        for _, v551 in v549:GetDescendants() do
            if v551:IsA("ParticleEmitter") then
                v551:Emit(v551:GetAttribute("EmitCount"));
            end;
        end;
        local u552 = l__EffectAssets__5.SlashAcross:Clone();
        game.Debris:AddItem(u552, 0.4);
        u552.Center.Position = u546;
        u552.Left.Position = u546;
        u552.Right.Position = u546;
        local u553 = v548 * 30;
        local u554 = -u553;
        u552.SlashParticlesShards.CFrame = CFrame.lookAt(u546, u546 + u554);
        local u555 = { u552.Beam1, u552.Beam2 };
        u552.Beam1.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0));
        u552.Beam2.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0));
        l__TweenService__1:Create(u552.Alpha, TweenInfo.new(0.4), {
            Value = 1
        }):Play();
        u552.Alpha.Changed:Connect(function() --[[ Line: 2825 ]]
            -- upvalues: u552 (copy), u546 (copy), u553 (copy), u554 (copy), u555 (copy), u3 (ref)
            local l__Value__84 = u552.Alpha.Value;
            u552.Right.Position = u546:Lerp(u546 + u553, l__Value__84);
            u552.Left.Position = u546:Lerp(u546 + u554, l__Value__84);
            for _, v556 in u555 do
                local v557 = u3:numLerp(0, 1, l__Value__84);
                local v558 = u3:numLerp(1, 0, l__Value__84);
                v556.Transparency = NumberSequence.new(v557);
                v556.Width0 = v558;
            end;
        end);
        u552.Parent = l__Effects__9;
        game.Debris:AddItem(v549, 1);
    end;
end;
function u1._xdd698b0d963498de(_, p559) --[[ Line: 2843 ]]
    -- upvalues: l__Classes__3 (copy), l__InternalSymbols__8 (copy), l__EffectAssets__5 (copy), l__TweenService__1 (copy), u3 (ref), l__Effects__9 (copy)
    local u560 = l__Classes__3.Util:getLikelyVec3(p559);
    local v562 = (function() --[[ Name: getDirection, Line 2845 ]]
        -- upvalues: l__InternalSymbols__8 (ref), l__Classes__3 (ref)
        local v561 = l__InternalSymbols__8.owner("", l__Classes__3._xd1706540247308ea._xcfefdf98297dd62e.melee);
        if v561 then
            if v561._x0cda07b8bd2ab5ec and typeof(v561._x0cda07b8bd2ab5ec) == "function" then
                return v561:_x0cda07b8bd2ab5ec();
            end;
            warn("MELEE MODULE DOES NOT HAVE getAttackDirection : ", v561);
        else
            warn("slashAcross VISUAL EFFECT FAILED, NO MELEE WEAPON");
        end;
    end)();
    if v562 then
        local u563 = l__EffectAssets__5.SlashAcross:Clone();
        game.Debris:AddItem(u563, 0.8);
        u563.Center.Position = u560;
        u563.Left.Position = u560;
        u563.Right.Position = u560;
        local u564 = v562 * 60;
        local u565 = -u564;
        u563.SlashParticlesShards.CFrame = CFrame.lookAt(u560, u560 + u565);
        local u566 = { u563.Beam1, u563.Beam2 };
        l__TweenService__1:Create(u563.Alpha, TweenInfo.new(0.8), {
            Value = 1
        }):Play();
        u563.Alpha.Changed:Connect(function() --[[ Line: 2879 ]]
            -- upvalues: u563 (copy), u560 (copy), u564 (copy), u565 (copy), u566 (copy), u3 (ref)
            local l__Value__85 = u563.Alpha.Value;
            u563.Right.Position = u560:Lerp(u560 + u564, l__Value__85);
            u563.Left.Position = u560:Lerp(u560 + u565, l__Value__85);
            for _, v567 in u566 do
                local v568 = u3:numLerp(0, 1, l__Value__85);
                local v569 = u3:numLerp(1, 0, l__Value__85);
                v567.Transparency = NumberSequence.new(v568);
                v567.Width0 = v569;
            end;
        end);
        for _, v570 in u563:GetDescendants() do
            if v570:IsA("ParticleEmitter") then
                v570:Emit(v570:GetAttribute("EmitCount"));
            end;
        end;
        u563.Parent = l__Effects__9;
        game.Debris:AddItem(u563.SlashParticlesShards, 2);
        u563.SlashParticlesShards.Parent = l__Effects__9;
    end;
end;
function u1._xb53ef17a1dc6b032(u571, p572) --[[ Line: 2903 ]]
    -- upvalues: l__Classes__3 (copy), l__TweenService__1 (copy)
    local v573 = Instance.new("ColorCorrectionEffect", game.Lighting);
    local u574 = Instance.new("ColorCorrectionEffect", game.Lighting);
    task.delay(0.2, function() --[[ Line: 2908 ]]
        -- upvalues: u571 (copy)
        u571:_x028f87d83a86bda2();
    end);
    u571:_x17bdbf488c82304b(p572);
    v573.Brightness = -2;
    local v575 = {};
    local v576 = Instance.new("NumberValue");
    v576.Value = 10;
    v575.value = v576;
    v575.cancel_when_zero = true;
    l__Classes__3._x32ae459de0772e82:_x8ca42af5fe3be726(v575);
    l__Classes__3._x910f31e87b3c7281:_xc30d268a636e435e(0.08);
    game.Debris:AddItem(v573, 0.3);
    game.Debris:AddItem(u574, 1.5);
    l__TweenService__1:Create(v573, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Brightness = 0
    }):Play();
    l__TweenService__1:Create(u574, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Brightness = 0.1,
        Contrast = 0.2
    }):Play();
    l__TweenService__1:Create(v576, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
    u571:_xee1cb09b95057806(0.5, 2);
    task.delay(0.3, function() --[[ Line: 2935 ]]
        -- upvalues: l__TweenService__1 (ref), u574 (copy)
        l__TweenService__1:Create(u574, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Brightness = 0,
            Contrast = 0
        }):Play();
    end);
end;
function u1._xbd6e9093debec189(u577, u578, p579) --[[ Line: 2940 ]]
    -- upvalues: l__Classes__3 (copy), l__Promise__6 (copy), l__EffectAssets__5 (copy), l__TweenService__1 (copy), u3 (ref)
    local v580 = tonumber(p579) - workspace:GetServerTimeNow();
    local v581 = math.max(v580, 0);
    local v582 = math.max(v581 - 0.5, 0);
    local l___xa582dff88acd1962__86 = l__Classes__3._xa582dff88acd1962;
    local v583;
    if l___xa582dff88acd1962__86 and typeof(l___xa582dff88acd1962__86._x1e7ec68c15abf5de) == "function" then
        v583 = l___xa582dff88acd1962__86:_x1e7ec68c15abf5de(u578);
    else
        v583 = u578;
    end;
    local u584 = v583:FindFirstChild("Head") or (v583.PrimaryPart or v583:FindFirstChildWhichIsA("BasePart"));
    local u585 = l__Promise__6.delay(v582);
    u585:andThen(function() --[[ Line: 2946 ]]
        -- upvalues: u584 (copy), l__Classes__3 (ref)
        if u584 then
            l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("SMOOTH_RISER", true, {
                Parent = u584
            });
        end;
    end);
    local u586 = {};
    table.insert(u586, u585);
    local u587 = {};
    local u588 = l__EffectAssets__5.Trail:Clone();
    u588.Parent = u577._x364033b796543937;
    game.Debris:AddItem(u588, v581);
    local u589 = l__EffectAssets__5.Cross:Clone();
    u589.Parent = u577._x364033b796543937;
    game.Debris:AddItem(u589, v581);
    table.insert(u587, u588);
    table.insert(u587, u589);
    for _, v590 in u589:GetChildren() do
        if v590:IsA("Frame") then
            l__TweenService__1:Create(v590, TweenInfo.new(v581), {
                Size = UDim2.new(0, 1, 10, 0)
            }):Play();
            l__TweenService__1:Create(v590, TweenInfo.new(v581, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
        end;
    end;
    if u584 then
        local u591 = nil;
        local u592 = game:GetService("HttpService"):GenerateGUID();
        local u593 = false;
        u3:bindToRenderStep(u592, Enum.RenderPriority.Last.Value, function() --[[ Line: 2982 ]]
            -- upvalues: u584 (copy), u585 (copy), u3 (ref), u592 (copy), u593 (ref), u588 (copy), u589 (copy), u591 (ref), u577 (copy)
            local l__CurrentCamera__87 = workspace.CurrentCamera;
            if l__CurrentCamera__87 and l__CurrentCamera__87.CFrame then
                if u584 and u584:IsDescendantOf(workspace.Entities) then
                    local l__Position__88 = u584.Position;
                    local v594, v595 = l__CurrentCamera__87:WorldToViewportPoint(l__Position__88);
                    if v595 and v594.Z > 0 then
                        if u3:hasLineOfSight(l__CurrentCamera__87.CFrame.Position, l__Position__88) then
                            u588.Visible = true;
                            u589.Visible = true;
                            local v596 = Vector2.new(v594.X, v594.Y);
                            u589.Position = UDim2.fromOffset(v596.X, v596.Y);
                            if u591 then
                                local v597 = v596 - u591;
                                local v598 = math.max(v597.Magnitude, 0.007 * u577._x364033b796543937.AbsoluteSize.X);
                                local v599 = u591 + v597 * 0.5;
                                u588.Size = UDim2.new(0, v598, u588.Size.Y.Scale, u588.Size.Y.Offset);
                                u588.Position = UDim2.fromOffset(v599.X, v599.Y);
                                local v600 = u588;
                                local v601 = math.atan2(v597.Y, v597.X);
                                v600.Rotation = math.deg(v601);
                            end;
                            u591 = v596;
                        else
                            u588.Visible = false;
                            u589.Visible = false;
                            u591 = nil;
                        end;
                    else
                        u588.Visible = false;
                        u589.Visible = false;
                        u591 = nil;
                    end;
                else
                    u585:cancel();
                    u3:unbindFromRenderStep(u592);
                    u593 = true;
                    u588.Visible = false;
                    u589.Visible = false;
                end;
            end;
        end);
        local function u604() --[[ Line: 3033 ]]
            -- upvalues: u587 (copy), u586 (copy), u3 (ref), u592 (copy), u577 (copy), u578 (copy)
            for _, v602 in u587 do
                if v602.Parent ~= nil then
                    v602:Destroy();
                end;
            end;
            for _, v603 in u586 do
                v603:cancel();
            end;
            u3:unbindFromRenderStep(u592);
            u577._x610ae198723d5ccb[u578] = nil;
        end;
        if u577._x610ae198723d5ccb[u578] then
            pcall(u577._x610ae198723d5ccb[u578]);
        end;
        u577._x610ae198723d5ccb[u578] = u604;
        task.delay(math.min(v581, 10), function() --[[ Line: 3053 ]]
            -- upvalues: u593 (ref), u604 (copy)
            if u593 then
            else
                u604();
            end;
        end);
    end;
end;
function u1._x4a57aa91d1e8ae4e(u605, u606, p607) --[[ Line: 3061 ]]
    -- upvalues: l__Classes__3 (copy), l__Promise__6 (copy), l__EffectAssets__5 (copy), l__TweenService__1 (copy), u3 (ref)
    local v608 = tonumber(p607) - workspace:GetServerTimeNow();
    local u609 = math.max(v608, 0);
    local v610 = math.max(u609 - 0.5, 0);
    local l___xa582dff88acd1962__89 = l__Classes__3._xa582dff88acd1962;
    local v611;
    if l___xa582dff88acd1962__89 and typeof(l___xa582dff88acd1962__89._x1e7ec68c15abf5de) == "function" then
        v611 = l___xa582dff88acd1962__89:_x1e7ec68c15abf5de(u606);
    else
        v611 = u606;
    end;
    local u612 = v611:FindFirstChild("GunPoint", true) or v611.PrimaryPart;
    if u612 then
        local u613 = {};
        local u614 = {};
        local v615 = l__Promise__6.delay(v610);
        v615:andThen(function() --[[ Line: 3070 ]]
            -- upvalues: u612 (copy), l__Classes__3 (ref)
            if u612 then
                l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("SMOOTH_RISER", true, {
                    Parent = u612
                });
            end;
        end);
        table.insert(u613, v615);
        local u616 = l__EffectAssets__5.PhoenixGlare:Clone();
        u616.Parent = u605._x364033b796543937;
        game.Debris:AddItem(u616, u609);
        table.insert(u614, u616);
        for v617 = 1, 3 do
            local v618 = l__Promise__6.delay((v617 - 1) * 0.2);
            table.insert(u613, v618);
            v618:andThen(function() --[[ Line: 3086 ]]
                -- upvalues: l__EffectAssets__5 (ref), u605 (copy), l__TweenService__1 (ref), u614 (copy)
                local v619 = l__EffectAssets__5.WaveIn:Clone();
                v619.Parent = u605._x364033b796543937;
                game.Debris:AddItem(v619, 0.30000000000000004);
                l__TweenService__1:Create(v619, TweenInfo.new(0.30000000000000004, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    ImageTransparency = 0,
                    Size = UDim2.fromScale(0, 0)
                }):Play();
                table.insert(u614, v619);
            end);
        end;
        local u620 = game:GetService("HttpService"):GenerateGUID();
        local u621 = false;
        local function u624(p622) --[[ Line: 3100 ]]
            -- upvalues: u614 (copy)
            for _, v623 in u614 do
                if v623 and v623.Parent ~= nil then
                    p622(v623);
                end;
            end;
        end;
        local u625 = 0.2;
        local u626 = os.clock();
        local u627 = Random.new();
        u3:bindToRenderStep(u620, Enum.RenderPriority.Last.Value, function(p628) --[[ Line: 3112 ]]
            -- upvalues: u612 (copy), u613 (copy), u3 (ref), u620 (copy), u621 (ref), u624 (copy), u616 (copy), u625 (ref), l__TweenService__1 (ref), u626 (copy), u609 (copy), u627 (copy)
            local l__CurrentCamera__90 = workspace.CurrentCamera;
            if l__CurrentCamera__90 and l__CurrentCamera__90.CFrame then
                if u612 and u612:IsDescendantOf(workspace.Entities) then
                    local v629 = u612:IsA("Attachment") and u612.WorldPosition or u612.Position;
                    local v630, v631 = l__CurrentCamera__90:WorldToViewportPoint(v629);
                    u616.Visible = true;
                    u625 = u625 + p628;
                    if u625 >= 0.2 then
                        u625 = 0;
                        u616.ImageTransparency = 1;
                        l__TweenService__1:Create(u616, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ImageTransparency = 0
                        }):Play();
                    end;
                    local v632 = os.clock() - u626;
                    local v633 = u3:numLerp(0.08, 0, l__TweenService__1:GetValue(u3:convNumRange(math.min(v632, u609), 0, u609, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.In));
                    local v634 = u627:NextNumber(1, 3);
                    u616.Size = UDim2.fromScale(0.08 * v634, v633 * v634);
                    u624(function(p635) --[[ Line: 3152 ]]
                        p635.Visible = true;
                    end);
                    if v631 and v630.Z > 0 then
                        if u3:hasLineOfSight(l__CurrentCamera__90.CFrame.Position, v629) then
                            local u636 = Vector2.new(v630.X, v630.Y);
                            u624(function(p637) --[[ Line: 3171 ]]
                                -- upvalues: u636 (copy)
                                p637.Position = UDim2.fromOffset(u636.X, u636.Y);
                            end);
                        else
                            u624(function(p638) --[[ Line: 3164 ]]
                                p638.Visible = false;
                            end);
                        end;
                    else
                        u624(function(p639) --[[ Line: 3157 ]]
                            p639.Visible = false;
                        end);
                    end;
                else
                    for _, v640 in u613 do
                        v640:cancel();
                    end;
                    u3:unbindFromRenderStep(u620);
                    u621 = true;
                    u624(function(p641) --[[ Line: 3124 ]]
                        p641.Visible = false;
                    end);
                end;
            end;
        end);
        local function u644() --[[ Line: 3176 ]]
            -- upvalues: u614 (copy), u613 (copy), u3 (ref), u620 (copy), u605 (copy), u606 (copy)
            for _, v642 in u614 do
                if v642.Parent ~= nil then
                    v642:Destroy();
                end;
            end;
            for _, v643 in u613 do
                v643:cancel();
            end;
            u3:unbindFromRenderStep(u620);
            u605._x610ae198723d5ccb[u606] = nil;
        end;
        if u605._x610ae198723d5ccb[u606] then
            pcall(u605._x610ae198723d5ccb[u606]);
        end;
        u605._x610ae198723d5ccb[u606] = u644;
        task.delay(math.min(u609, 10), function() --[[ Line: 3196 ]]
            -- upvalues: u621 (ref), u644 (copy)
            if u621 then
            else
                u644();
            end;
        end);
    end;
end;
function u1._xa51c90ef63ddc38d(u645, u646, p647) --[[ Line: 3202 ]]
    -- upvalues: l__Classes__3 (copy), l__EffectAssets__5 (copy), l__Promise__6 (copy), u3 (ref), l__TweenService__1 (copy)
    local v648 = tonumber(p647) - workspace:GetServerTimeNow();
    local u649 = math.max(v648, 0);
    local v650 = math.max(u649 - 0.5, 0);
    local l___xa582dff88acd1962__91 = l__Classes__3._xa582dff88acd1962;
    local v651;
    if l___xa582dff88acd1962__91 and typeof(l___xa582dff88acd1962__91._x1e7ec68c15abf5de) == "function" then
        v651 = l___xa582dff88acd1962__91:_x1e7ec68c15abf5de(u646);
    else
        v651 = u646;
    end;
    local u652 = v651:FindFirstChild("Head", true) or v651.PrimaryPart;
    if u652 then
        local u653 = l__EffectAssets__5.SiegeGlare:Clone();
        u653.Parent = u645._x364033b796543937;
        game.Debris:AddItem(u653, u649);
        local v654 = l__Promise__6.delay(v650);
        v654:andThen(function() --[[ Line: 3213 ]]
            -- upvalues: u652 (copy), l__Classes__3 (ref)
            if u652 then
                l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("SMOOTH_RISER", true, {
                    Parent = u652
                });
            end;
        end);
        local u655 = game:GetService("HttpService"):GenerateGUID();
        local u656 = false;
        local u657 = l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("SIEGE_DRAW", true, {
            Parent = u652
        });
        local u658 = {};
        local u659 = {};
        table.insert(u659, v654);
        table.insert(u658, u653);
        local u660 = 0.2;
        local u661 = os.clock();
        local u662 = Random.new();
        local function u665(p663) --[[ Line: 3235 ]]
            -- upvalues: u658 (copy)
            for _, v664 in u658 do
                if v664 and v664.Parent ~= nil then
                    p663(v664);
                end;
            end;
        end;
        local u666 = 0;
        u3:bindToRenderStep(u655, Enum.RenderPriority.Last.Value, function(p667) --[[ Line: 3253 ]]
            -- upvalues: u652 (copy), u659 (copy), u3 (ref), u655 (copy), u656 (ref), u665 (copy), u666 (ref), l__EffectAssets__5 (ref), u645 (copy), l__TweenService__1 (ref), u658 (copy), u653 (copy), u660 (ref), u661 (copy), u649 (copy), u662 (copy)
            local l__CurrentCamera__92 = workspace.CurrentCamera;
            if l__CurrentCamera__92 and l__CurrentCamera__92.CFrame then
                if u652 and u652:IsDescendantOf(workspace.Entities) then
                    local u668 = workspace:GetServerTimeNow();
                    local v669 = u652:IsA("Attachment") and u652.WorldPosition or u652.Position;
                    local l__Magnitude__93 = (v669 - workspace.CurrentCamera.CFrame.Position).Magnitude;
                    local v670, v671 = l__CurrentCamera__92:WorldToViewportPoint(v669);
                    local u672 = u3:convNumRange(l__Magnitude__93, 40, 100, 0.2, 0.4);
                    u666 = u666 + p667;
                    local function v679() --[[ Line: 3279 ]]
                        -- upvalues: u3 (ref), l__Magnitude__93 (copy), l__EffectAssets__5 (ref), u645 (ref), u672 (copy), l__TweenService__1 (ref), u668 (copy), u658 (ref)
                        local v673 = u3:convNumRange(l__Magnitude__93, 40, 100, 0.4, 0.2);
                        local v674 = UDim2.fromScale(v673, v673);
                        local v675 = l__EffectAssets__5.Crescent:Clone();
                        v675.Size = v674;
                        v675.Parent = u645._x364033b796543937;
                        local v676 = l__EffectAssets__5.Crescent:Clone();
                        v676.Rotation = 180;
                        v676.Size = v674;
                        v676.Parent = u645._x364033b796543937;
                        local v677 = TweenInfo.new(u672, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
                        l__TweenService__1:Create(v675, v677, {
                            ImageTransparency = 0,
                            Size = UDim2.fromScale(0, 0)
                        }):Play();
                        l__TweenService__1:Create(v676, v677, {
                            ImageTransparency = 0,
                            Size = UDim2.fromScale(0, 0)
                        }):Play();
                        local v678;
                        if u668 <= u672 then
                            v678 = u668;
                        else
                            v678 = u672;
                        end;
                        game.Debris:AddItem(v675, v678);
                        game.Debris:AddItem(v676, v678);
                        table.insert(u658, v675);
                        table.insert(u658, v676);
                    end;
                    if l__Magnitude__93 < 100 and (u672 <= u666 and not u656) then
                        u666 = 0;
                        v679();
                    end;
                    u653.Visible = true;
                    u660 = u660 + p667;
                    if u660 >= 0.2 then
                        u660 = 0;
                        u653.ImageTransparency = 1;
                        l__TweenService__1:Create(u653, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ImageTransparency = 0
                        }):Play();
                    end;
                    local v680 = os.clock() - u661;
                    local v681 = u3:numLerp(0, 0.04, l__TweenService__1:GetValue(u3:convNumRange(math.min(v680, u649), 0, u649, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.Out));
                    local v682 = u662:NextNumber(1, 3);
                    u653.Size = UDim2.fromScale(v681 * v682, 0.04 * v682);
                    u665(function(p683) --[[ Line: 3336 ]]
                        p683.Visible = true;
                    end);
                    if v671 and v670.Z > 0 then
                        if u3:hasLineOfSight(l__CurrentCamera__92.CFrame.Position, v669) then
                            local u684 = Vector2.new(v670.X, v670.Y);
                            u665(function(p685) --[[ Line: 3355 ]]
                                -- upvalues: u684 (copy)
                                if p685.Parent == nil then
                                else
                                    p685.Position = UDim2.fromOffset(u684.X, u684.Y);
                                end;
                            end);
                        else
                            u665(function(p686) --[[ Line: 3348 ]]
                                p686.Visible = false;
                            end);
                        end;
                    else
                        u665(function(p687) --[[ Line: 3341 ]]
                            p687.Visible = false;
                        end);
                    end;
                else
                    for _, v688 in u659 do
                        v688:cancel();
                    end;
                    u3:unbindFromRenderStep(u655);
                    u656 = true;
                    u665(function(p689) --[[ Line: 3265 ]]
                        p689.Visible = false;
                    end);
                end;
            end;
        end);
        local function u692() --[[ Line: 3361 ]]
            -- upvalues: u658 (copy), u659 (copy), u3 (ref), u655 (copy), u645 (copy), u646 (copy), u657 (copy)
            for _, v690 in u658 do
                if v690.Parent ~= nil then
                    v690:Destroy();
                end;
            end;
            for _, v691 in u659 do
                v691:cancel();
            end;
            u3:unbindFromRenderStep(u655);
            u645._x610ae198723d5ccb[u646] = nil;
            if u657 and u657.Parent ~= nil then
                u657:Destroy();
            end;
        end;
        if u645._x610ae198723d5ccb[u646] then
            pcall(u645._x610ae198723d5ccb[u646]);
        end;
        u645._x610ae198723d5ccb[u646] = u692;
        task.delay(math.min(u649, 10), function() --[[ Line: 3385 ]]
            -- upvalues: u656 (ref), u692 (copy)
            if u656 then
            else
                u692();
            end;
        end);
    end;
end;
function u1._xa2d9d79edf6d5dc0(u693, u694, p695) --[[ Line: 3391 ]]
    -- upvalues: l__Classes__3 (copy), l__EffectAssets__5 (copy), l__Trove__7 (copy), l__TweenService__1 (copy), u3 (ref)
    local u696 = tonumber(p695);
    local v697 = workspace:GetServerTimeNow();
    local v698 = math.max(u696 - v697, 0);
    math.max(v698 - 0.5, 0);
    local l___xa582dff88acd1962__94 = l__Classes__3._xa582dff88acd1962;
    local u699;
    if l___xa582dff88acd1962__94 and typeof(l___xa582dff88acd1962__94._x1e7ec68c15abf5de) == "function" then
        u699 = l___xa582dff88acd1962__94:_x1e7ec68c15abf5de(u694);
    else
        u699 = u694;
    end;
    local u700 = u699:FindFirstChild("GunPoint", true) or u699.PrimaryPart;
    if u700 then
        local u701 = l__EffectAssets__5.MonarchGlare:Clone();
        u701.Parent = u693._x364033b796543937;
        local u702 = l__Trove__7.new();
        local v703 = game:GetService("HttpService"):GenerateGUID();
        local u704 = false;
        os.clock();
        Random.new();
        local u705 = nil;
        u702:Add(u701);
        local u706 = u696 - 0.8;
        l__TweenService__1:Create(u701.StartStar, TweenInfo.new(u706 - v697, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            ImageTransparency = 0,
            Rotation = u701.StartStar.Rotation + 720,
            Size = UDim2.fromScale(0.7, 0.7)
        }):Play();
        local u707 = false;
        local u708 = nil;
        u702:BindToRenderStep(v703, Enum.RenderPriority.Last.Value, function(_) --[[ Line: 3427 ]]
            -- upvalues: u696 (ref), u700 (copy), u704 (ref), u705 (ref), u3 (ref), u706 (copy), u707 (ref), l__TweenService__1 (ref), u701 (copy), u708 (ref), l__Classes__3 (ref), u699 (copy)
            local l__CurrentCamera__95 = workspace.CurrentCamera;
            local v709 = workspace:GetServerTimeNow();
            local v710 = u696 - v709;
            if l__CurrentCamera__95 and l__CurrentCamera__95.CFrame then
                if u700 and u700:IsDescendantOf(workspace.Entities) then
                    local v711 = u700:IsA("Attachment") and u700.WorldPosition or u700.Position;
                    local v712, v713 = l__CurrentCamera__95:WorldToViewportPoint(v711);
                    local v714 = u3:hasLineOfSight(l__CurrentCamera__95.CFrame.Position, v711);
                    if u706 <= v709 and not u707 then
                        u707 = true;
                        l__TweenService__1:Create(u701.Horizontal, TweenInfo.new(v710 * 0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                            Size = UDim2.fromScale(6, 1)
                        }):Play();
                        l__TweenService__1:Create(u701.Vertical, TweenInfo.new(v710 * 0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                            Size = UDim2.fromScale(1, 6)
                        }):Play();
                        l__TweenService__1:Create(u701.Horizontal, TweenInfo.new(v710 * 0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            ImageTransparency = 1
                        }):Play();
                        l__TweenService__1:Create(u701.Vertical, TweenInfo.new(v710 * 0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            ImageTransparency = 1
                        }):Play();
                        u701.Glow.ImageTransparency = 0;
                        l__TweenService__1:Create(u701.Glow, TweenInfo.new(v710 * 0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            ImageTransparency = 1,
                            Size = UDim2.fromScale(0.1, 0.1)
                        }):Play();
                        if v714 then
                            u708 = l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("NIGHT_VISION", true, {
                                Volume = 1,
                                Parent = u699
                            });
                        else
                            u708 = l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("NIGHT_VISION", true, {
                                Volume = 0.05,
                                Parent = u699
                            });
                        end;
                    end;
                    u701.Visible = true;
                    local v715, v716;
                    if u706 <= v709 then
                        local v717 = l__Classes__3.Util:convNumRange(v710, 0, 0.8, 0, 10);
                        v715 = math.random(0, v717);
                        local v718 = l__Classes__3.Util:convNumRange(v710, 0, 0.8, 0, 10);
                        v716 = math.random(0, v718);
                    else
                        v715 = 0;
                        v716 = 0;
                    end;
                    if v713 then
                        if v714 then
                            if u708 then
                                if v714 then
                                    u708.Volume = 1;
                                else
                                    u708.Volume = 0.05;
                                end;
                            end;
                            u701.Position = UDim2.fromOffset(v712.X + v715, v712.Y + v716);
                        else
                            u701.Visible = false;
                        end;
                    else
                        u701.Visible = false;
                    end;
                else
                    u704 = true;
                    u705();
                end;
            end;
        end);
        u705 = function() --[[ Line: 3502 ]]
            -- upvalues: u702 (copy), u693 (copy), u694 (copy)
            u702:Clean();
            u693._x610ae198723d5ccb[u694] = nil;
        end;
        if u693._x610ae198723d5ccb[u694] then
            pcall(u693._x610ae198723d5ccb[u694]);
        end;
        u693._x610ae198723d5ccb[u694] = u705;
        task.delay(math.min(v698, 10), function() --[[ Line: 3513 ]]
            -- upvalues: u705 (ref)
            u705();
        end);
    end;
end;
function u1._xdcfdfda74c9a90e1(p719, p720, p721, p722) --[[ Line: 3519 ]]
    if p722 == "Phoenix" then
        p719:_x4a57aa91d1e8ae4e(p720, p721);
    elseif p722 == "Siege" then
        p719:_xa51c90ef63ddc38d(p720, p721);
    elseif p722 == "Monarch" then
        p719:_xa2d9d79edf6d5dc0(p720, p721);
    else
        p719:_xbd6e9093debec189(p720, p721);
    end;
end;
function u1._x6aaa5c90417fdf75(p723) --[[ Line: 3531 ]]
    return {
        brokenIndicator = p723._xefb3cdf58d8aad85,
        bulletTracer = p723._x15cfa3355252d8ab,
        buttonPressed = p723._xbf5c080c5484db75,
        castigateFlash = p723._x4ddc16cc204a876f,
        characterTrail = p723._xfe87be3956daa8a1,
        chaseDash = p723._xdceb06c3913d4a80,
        clash = p723._x3fa2085d4aec1321,
        clashLocal = p723._xc2317b9cc3ec4049,
        closeHuntedWarning = p723._x13f7ca069228beb8,
        damageNumber = p723._x4ba74f83f303bd5b,
        defaultParry = p723._x509a174918a07407,
        globalDeathEffect = p723._x17bdbf488c82304b,
        grappleEndOutsider = p723._x51f75ff0cfae6e7b,
        grappleStartOutsider = p723._x655d09098fc3e186,
        groundSlam = p723._x8e4edde212869bee,
        gunDrawCue = p723._xdcfdfda74c9a90e1,
        gunHit = p723._x03800d3d1d966657,
        gunKill = p723._xe7fa9488c44c59d6,
        hitParticles = p723._x5593abca8c0fb4cd,
        huntedWarning = p723._xa448c637f5a4a31f,
        impactFrame = p723._xbe8f9db5918a5820,
        impactTaken = p723._x80d249ebbfe99eaf,
        killConfirm = p723._xb53ef17a1dc6b032,
        launchpadEffect = p723._x4447e49e11da5640,
        parryIndicator = p723._x6ce5a388afc73444,
        parryTrainStopped = p723._x86ce1dbbe7203fe8,
        phoenixDirect = p723._x3441e71244ea63e1,
        phoenixExplosion = p723._xfa3ad4a50639cee8,
        phoenixFlash = p723._xde2202b7e01dda21,
        phoenixFlashOutsider = p723._x43601a85ab5a2777,
        removeProjectile = p723._xea63ed5fc7ef59ca,
        screenStatic = p723._x29cf541f4575469f,
        shockwave = p723._x7978d78c2405e137,
        siegeFlashOutsider = p723._xeca24645762b90d0,
        simulateProjectile = p723._x270711b70822b296,
        slamTarget = p723._x570186a4468fb004,
        slashAcross = p723._xdd698b0d963498de,
        stopLoadingScreen = p723._x0488dfa06291b26c,
        suspendedIndicator = p723._xd003c8b3e80e7c75,
        swoopAttack = p723._xc145144798438460,
        castigateFlashOutsider = p723._x077bd41c32ddbe8a,
        monarchFlash = p723._x23dd10a5fc4f2b5e,
        monarchFlashOutsider = p723._x599d069c40a19013,
        siegeFlash = p723._x6e49a06ff980d9b4,
        swoopAttackClient = p723._x3abef6c05325499d
    };
end;
function u1._x30a139d5b0b34114(p724, p725, ...) --[[ Line: 3581 ]]
    local v726 = p724._xa00325f15f14e1a6[p725];
    if v726 then
        return v726(p724, ...);
    end;
    warn("NO REGISTERED VISUAL EFFECT : ", p725);
    return nil;
end;
function u1._xf5cd0a1b6d5598ce(u727) --[[ Line: 3591 ]]
    -- upvalues: u2 (ref), l__Packets__10 (copy)
    if u2 then
        u2._x5178379199a428dc.dash_started.Event:Connect(function() --[[ Line: 3593 ]]
            -- upvalues: u727 (copy)
            u727:_x6c7a692ba8bec2c9();
            u727:_x028f87d83a86bda2();
        end);
    end;
    l__Packets__10._x9af13bc53d02488c.OnClientEvent:Connect(function(p728, p729) --[[ Line: 3599 ]]
        -- upvalues: u727 (copy)
        debug.profilebegin(p728);
        local v730 = u727._xa00325f15f14e1a6[p728];
        if v730 then
            if typeof(p729) == "table" then
                v730(u727, unpack(p729));
            else
                v730(u727, p729);
            end;
        end;
        debug.profileend();
    end);
end;
function u1._xc6b46e8bdcd2100c(_, u731) --[[ Line: 3615 ]]
    -- upvalues: l__Trove__7 (copy), l__UIAssets__4 (copy), l__RunService__2 (copy), l__Classes__3 (copy)
    local u732 = l__Trove__7.new();
    u732:AttachToInstance(u731);
    local u733 = Instance.new("Highlight");
    local v734 = l__UIAssets__4.FriendlyHeader:Clone();
    u732:Add(v734);
    u732:Add(u733);
    v734.Adornee = u731:FindFirstChild("HumanoidRootPart");
    v734.Parent = u731;
    u733.FillColor = Color3.fromRGB(83, 255, 169);
    u733.OutlineColor = Color3.fromRGB(83, 255, 169);
    u733.OutlineTransparency = 0.4;
    u732:Connect(l__RunService__2.Heartbeat, function() --[[ Line: 3633 ]]
        -- upvalues: u731 (copy), u732 (copy), l__Classes__3 (ref), u733 (copy)
        if u731 and u731.Parent then
            local l__Position__96 = workspace.CurrentCamera.CFrame.Position;
            local v735 = l__Classes__3.Util:getLikelyVec3(u731);
            if l__Classes__3.Util:hasLineOfSight(l__Position__96, v735) then
                u733.FillTransparency = 1;
            else
                u733.FillTransparency = 0.4;
            end;
        else
            u732:Clean();
        end;
    end);
    u733.Parent = u731;
end;
function u1._x23dd10a5fc4f2b5e(u736, u737) --[[ Line: 3649 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__TweenService__1 (copy), l__RunService__2 (copy)
    local v738 = l__EffectAssets__5.MonarchFlash:Clone();
    local u739 = l__Classes__3._x32ae459de0772e82:_x76b38494ff05a56c();
    v738.CFrame = CFrame.lookAt(u737 + u739 * 2, u737 + u739 * 10);
    v738.Parent = l__Effects__9;
    game.Debris:AddItem(v738, 4);
    u736:_x862a15c890e93186(v738);
    local l__Lighting__97 = game:GetService("Lighting");
    local v740 = Instance.new("ColorCorrectionEffect");
    v740.Contrast = 1;
    v740.Saturation = -1;
    v740.Parent = l__Lighting__97;
    game.Debris:AddItem(v740, 1);
    l__TweenService__1:Create(v740, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Contrast = 0
    }):Play();
    l__TweenService__1:Create(v740, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    u736:_xa9c1340b12fdb645(l__Lighting__97, -2.7, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)):Play();
    local l__Bullet__98 = v738.Bullet;
    local v741 = u737 + u739 * 2000;
    local v742 = TweenInfo.new(0.44, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
    l__Bullet__98.CFrame = CFrame.lookAt(u737 + u739 * 2, u737 + -u739 * 2000);
    l__TweenService__1:Create(l__Bullet__98, v742, {
        Size = Vector3.new(1, 1, 3000)
    }):Play();
    l__TweenService__1:Create(l__Bullet__98, v742, {
        Position = v741
    }):Play();
    game.Debris:AddItem(l__Bullet__98, 0.44);
    local u743 = l__EffectAssets__5.MonarchTracer:Clone();
    u743.Start.Position = u737;
    u743.End.Position = u737;
    u743.Parent = l__Effects__9;
    l__TweenService__1:Create(u743.End, v742, {
        Position = v741
    }):Play();
    l__TweenService__1:Create(u743.num, TweenInfo.new(3, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Value = 1
    }):Play();
    l__TweenService__1:Create(u743.Trail, TweenInfo.new(3, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Width0 = 1,
        Width1 = 1
    }):Play();
    u743.num.Changed:Connect(function() --[[ Line: 3698 ]]
        -- upvalues: u743 (copy)
        if u743 and u743.Parent then
            u743.Trail.Transparency = NumberSequence.new(u743.num.Value);
        end;
    end);
    game.Debris:AddItem(u743, 3);
    local l__Twist__99 = v738.Twist;
    local v744 = u737 + u739 * 45;
    local v745 = TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
    local u746 = CFrame.lookAt(u737 + u739 * 2, u737 + -u739 * 2000) * CFrame.Angles(-1.5707963267948966, 0, 0);
    l__Twist__99.CFrame = u746;
    local u747 = Instance.new("Vector3Value");
    u747.Value = u746.Position;
    game.Debris:AddItem(u747, 1.75);
    l__TweenService__1:Create(u747, v745, {
        Value = v744
    }):Play();
    l__TweenService__1:Create(l__Twist__99, v745, {
        Size = Vector3.new(75, 60, 75),
        Transparency = 1
    }):Play();
    local u748 = 0;
    local u749 = nil;
    u749 = l__RunService__2.RenderStepped:Connect(function(p750) --[[ Line: 3729 ]]
        -- upvalues: u748 (ref), l__Twist__99 (copy), u747 (copy), u746 (copy), u749 (ref)
        u748 = u748 + p750;
        local v751 = math.clamp(u748 / 0.75, 0, 1);
        local v752 = (1 - (1 - v751) ^ 2) * -12.566370614359172;
        l__Twist__99.CFrame = CFrame.new(u747.Value) * (u746 - u746.Position) * CFrame.Angles(0, v752, 0);
        if v751 >= 1 then
            u749:Disconnect();
        end;
    end);
    local function u756(p753) --[[ Line: 3756 ]]
        -- upvalues: l__EffectAssets__5 (ref), u737 (copy), u739 (copy), u736 (copy), l__Effects__9 (ref)
        local v754 = l__EffectAssets__5.MonarchWaveSurface:Clone();
        local v755 = u737;
        local l__Unit__100 = u739.Unit;
        local l__Unit__101 = (v755 + l__Unit__100 * (p753 - v755):Dot(l__Unit__100) - p753).Unit;
        v754.CFrame = CFrame.lookAt(p753, p753 + l__Unit__101);
        u736:_x862a15c890e93186(v754);
        v754.Parent = l__Effects__9;
        game.Debris:AddItem(v754, 4.5);
    end;
    OverlapParams.new();
    task.spawn(function() --[[ Line: 3780 ]]
        -- upvalues: u737 (copy), u739 (copy), l__EffectAssets__5 (ref), u736 (copy), l__Effects__9 (ref), l__Classes__3 (ref), u756 (copy)
        for v757 = 1, 20 do
            local v758 = u737 + u739 * ((v757 - 1) * 50);
            local v759 = l__EffectAssets__5.MonarchShockwave:Clone();
            v759.CFrame = CFrame.lookAt(v758, v758 + u739);
            u736:_x862a15c890e93186(v759);
            v759.Parent = l__Effects__9;
            game.Debris:AddItem(v759, 3);
            local v760 = workspace:Raycast(v758, Vector3.new(-0, -20, -0), l__Classes__3.Util:getBasicRaycastParams());
            if v760 then
                u756(v760.Position);
            end;
            task.wait(0.033);
        end;
    end);
    local v761 = workspace:Raycast(u737, u739 * 2000, l__Classes__3.Util:getBasicRaycastParams());
    if not v761 then
        return;
    end;
    local v762 = l__EffectAssets__5.MonarchImpact:Clone();
    local l__Position__102 = v761.Position;
    local l__Normal__103 = v761.Normal;
    v762.CFrame = CFrame.lookAt(l__Position__102 + l__Normal__103 * 0.05, l__Position__102 + l__Normal__103 * 1.05);
    local l__Debris__104 = v762.Attachment.Debris;
    local l__Parent__105 = v762.Attachment.Debris.Parent;
    local v763;
    if l__Parent__105 then
        local v764;
        if l__Parent__105:IsA("Attachment") then
            v764 = l__Parent__105.WorldCFrame;
            v763 = v764:VectorToObjectSpace(Vector3.new(0, -50, 0));
            l__Debris__104.Acceleration = v763;
            v762.Parent = l__Effects__9;
            u736:_x862a15c890e93186(v762);
            game.Debris:AddItem(v762, 5);
            return;
        end;
        if l__Parent__105:IsA("BasePart") then
            v764 = l__Parent__105.CFrame;
            v763 = v764:VectorToObjectSpace(Vector3.new(0, -50, 0));
            l__Debris__104.Acceleration = v763;
            v762.Parent = l__Effects__9;
            u736:_x862a15c890e93186(v762);
            game.Debris:AddItem(v762, 5);
            return;
        end;
        v763 = Vector3.new(0, -50, 0);
    else
        v763 = Vector3.new(0, -50, 0);
    end;
    l__Debris__104.Acceleration = v763;
    v762.Parent = l__Effects__9;
    u736:_x862a15c890e93186(v762);
    game.Debris:AddItem(v762, 5);
end;
function u1._xbe8f9db5918a5820(p765, u766) --[[ Line: 3812 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy)
    local u767 = l__EffectAssets__5.ImpactFrame:Clone();
    local function u771() --[[ Line: 3816 ]]
        -- upvalues: u766 (copy), l__Classes__3 (ref)
        local v768;
        if u766:FindFirstChild("Head") then
            v768 = u766.Head.Position;
        else
            v768 = l__Classes__3.Util:getLikelyVec3(u766);
        end;
        local v769, v770 = workspace.CurrentCamera:WorldToViewportPoint(v768);
        if v770 then
            return UDim2.fromOffset(v769.X, v769.Y);
        else
            return l__Classes__3.Util:getBoundaryUDimFromPosition(workspace.CurrentCamera, v768);
        end;
    end;
    local function u773(p772) --[[ Line: 3834 ]]
        -- upvalues: u767 (copy)
        u767.Main.Position = p772;
        u767.Main.First.Rotation = math.random(0, 360);
        u767.Main.Second.Rotation = math.random(0, 360);
        u767.Main.Third.Rotation = math.random(0, 360);
        u767.Background1.Position = p772;
        u767.Background2.Position = p772;
        u767.Shear1.Rotation = math.random(0, 360);
        u767.Shear2.Rotation = math.random(0, 360);
        u767.Shear3.Rotation = math.random(0, 360);
    end;
    u773((u771()));
    u767.Parent = p765._x364033b796543937;
    p765:_xee1cb09b95057806(1.2, 3.5);
    task.delay(0.05, function() --[[ Line: 3857 ]]
        -- upvalues: u767 (copy), u773 (copy), u771 (copy)
        if u767 and u767.Parent then
            u773((u771()));
            u767.Main.Size = UDim2.fromScale(0.25, 0.25);
            u767.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            for _, v774 in u767:GetDescendants() do
                if v774:IsA("ImageLabel") then
                    v774.ImageColor3 = Color3.fromRGB(0, 0, 0);
                end;
            end;
        end;
    end);
    game.Debris:AddItem(u767, 0.1);
end;
function u1._x599d069c40a19013(u775, p776, p777) --[[ Line: 3872 ]]
    -- upvalues: l__Classes__3 (copy), l__EffectAssets__5 (copy), l__Effects__9 (copy), l__TweenService__1 (copy), l__RunService__2 (copy)
    local u778 = l__Classes__3.Util:getLikelyVec3(p776);
    local u779 = l__Classes__3.Util:getLikelyVec3(p777) - u778;
    if u779.Magnitude > 1e-6 then
        u779 = u779.Unit;
    end;
    local v780 = l__EffectAssets__5.MonarchFlash:Clone();
    v780.CFrame = CFrame.lookAt(u778 + u779 * 2, u778 + u779 * 10);
    v780.Parent = l__Effects__9;
    game.Debris:AddItem(v780, 4);
    l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("MONARCH_SHOT", true, {
        location = u778
    });
    u775:_x862a15c890e93186(v780);
    local l__Bullet__106 = v780.Bullet;
    local v781 = u778 + u779 * 2000;
    local v782 = TweenInfo.new(0.33, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
    l__Bullet__106.CFrame = CFrame.lookAt(u778 + u779 * 2, u778 + -u779 * 2000);
    l__TweenService__1:Create(l__Bullet__106, v782, {
        Size = Vector3.new(1, 1, 3000)
    }):Play();
    l__TweenService__1:Create(l__Bullet__106, v782, {
        Position = v781
    }):Play();
    game.Debris:AddItem(l__Bullet__106, 0.33);
    local l__Position__107 = workspace.CurrentCamera.CFrame.Position;
    local v783 = v781 - u778;
    local v784 = (l__Position__107 - u778):Dot(v783) / v783:Dot(v783);
    local v785 = u778 + v783 * math.clamp(v784, 0, 1);
    local _ = (v785 - u778).Magnitude / 6060.60606060606;
    l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("MONARCH_WHIZZ", true, {
        location = v785
    });
    local l__Twist__108 = v780.Twist;
    local v786 = u778 + u779 * 45;
    local v787 = TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
    local u788 = CFrame.lookAt(u778 + u779 * 2, u778 + -u779 * 2000) * CFrame.Angles(-1.5707963267948966, 0, 0);
    l__Twist__108.CFrame = u788;
    local u789 = Instance.new("Vector3Value");
    u789.Value = u788.Position;
    game.Debris:AddItem(u789, 1.75);
    l__TweenService__1:Create(u789, v787, {
        Value = v786
    }):Play();
    l__TweenService__1:Create(l__Twist__108, v787, {
        Size = Vector3.new(75, 60, 75),
        Transparency = 1
    }):Play();
    local u790 = 0;
    local u791 = nil;
    u791 = l__RunService__2.RenderStepped:Connect(function(p792) --[[ Line: 3953 ]]
        -- upvalues: u790 (ref), l__Twist__108 (copy), u789 (copy), u788 (copy), u791 (ref)
        u790 = u790 + p792;
        local v793 = math.clamp(u790 / 0.75, 0, 1);
        local v794 = (1 - (1 - v793) ^ 2) * -12.566370614359172;
        l__Twist__108.CFrame = CFrame.new(u789.Value) * (u788 - u788.Position) * CFrame.Angles(0, v794, 0);
        if v793 >= 1 then
            u791:Disconnect();
        end;
    end);
    local u795 = l__EffectAssets__5.MonarchTracer:Clone();
    u795.Start.Position = u778;
    u795.End.Position = u778;
    u795.Parent = l__Effects__9;
    l__TweenService__1:Create(u795.End, v782, {
        Position = v781
    }):Play();
    l__TweenService__1:Create(u795.num, TweenInfo.new(3, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Value = 1
    }):Play();
    l__TweenService__1:Create(u795.Trail, TweenInfo.new(3, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Width0 = 1,
        Width1 = 1
    }):Play();
    u795.num.Changed:Connect(function() --[[ Line: 3980 ]]
        -- upvalues: u795 (copy)
        if u795 and u795.Parent then
            u795.Trail.Transparency = NumberSequence.new(u795.num.Value);
        end;
    end);
    game.Debris:AddItem(u795, 3);
    local function u799(p796) --[[ Line: 3999 ]]
        -- upvalues: l__EffectAssets__5 (ref), u778 (copy), u779 (ref), u775 (copy), l__Effects__9 (ref)
        local v797 = l__EffectAssets__5.MonarchWaveSurface:Clone();
        local v798 = u778;
        local l__Unit__109 = u779.Unit;
        local l__Unit__110 = (v798 + l__Unit__109 * (p796 - v798):Dot(l__Unit__109) - p796).Unit;
        v797.CFrame = CFrame.lookAt(p796, p796 + l__Unit__110);
        u775:_x862a15c890e93186(v797);
        v797.Parent = l__Effects__9;
        game.Debris:AddItem(v797, 4.5);
    end;
    OverlapParams.new();
    task.spawn(function() --[[ Line: 4023 ]]
        -- upvalues: u778 (copy), u779 (ref), l__EffectAssets__5 (ref), u775 (copy), l__Effects__9 (ref), l__Classes__3 (ref), u799 (copy)
        for v800 = 1, 20 do
            local v801 = u778 + u779 * ((v800 - 1) * 100);
            local v802 = l__EffectAssets__5.MonarchShockwave:Clone();
            v802.CFrame = CFrame.lookAt(v801, v801 + u779);
            u775:_x862a15c890e93186(v802);
            v802.Parent = l__Effects__9;
            game.Debris:AddItem(v802, 3);
            local v803 = workspace:Raycast(v801, Vector3.new(-0, -20, -0), l__Classes__3.Util:getBasicRaycastParams());
            if v803 then
                u799(v803.Position);
            end;
            task.wait(0.0495);
        end;
    end);
    local v804 = workspace:Raycast(u778, u779 * 2000, l__Classes__3.Util:getBasicRaycastParams());
    if not v804 then
        return;
    end;
    local v805 = l__EffectAssets__5.MonarchImpact:Clone();
    local l__Position__111 = v804.Position;
    local l__Normal__112 = v804.Normal;
    v805.CFrame = CFrame.lookAt(l__Position__111 + l__Normal__112 * 0.05, l__Position__111 + l__Normal__112 * 1.05);
    local l__Debris__113 = v805.Attachment.Debris;
    local l__Parent__114 = v805.Attachment.Debris.Parent;
    local v806;
    if l__Parent__114 then
        local v807;
        if l__Parent__114:IsA("Attachment") then
            v807 = l__Parent__114.WorldCFrame;
            v806 = v807:VectorToObjectSpace(Vector3.new(0, -50, 0));
            l__Debris__113.Acceleration = v806;
            v805.Parent = l__Effects__9;
            u775:_x862a15c890e93186(v805);
            game.Debris:AddItem(v805, 5);
            return;
        end;
        if l__Parent__114:IsA("BasePart") then
            v807 = l__Parent__114.CFrame;
            v806 = v807:VectorToObjectSpace(Vector3.new(0, -50, 0));
            l__Debris__113.Acceleration = v806;
            v805.Parent = l__Effects__9;
            u775:_x862a15c890e93186(v805);
            game.Debris:AddItem(v805, 5);
            return;
        end;
        v806 = Vector3.new(0, -50, 0);
    else
        v806 = Vector3.new(0, -50, 0);
    end;
    l__Debris__113.Acceleration = v806;
    v805.Parent = l__Effects__9;
    u775:_x862a15c890e93186(v805);
    game.Debris:AddItem(v805, 5);
end;
function u1._x70c1945e7032f1be(u808, p809, p810) --[[ Line: 4055 ]]
    -- upvalues: l__Trove__7 (copy), l__UIAssets__4 (copy), l__EffectAssets__5 (copy), l__Classes__3 (copy), l__TweenService__1 (copy), l__Promise__6 (copy), l__Effects__9 (copy)
    local u811 = l__Trove__7.new();
    local l__LocalPlayer__115 = game.Players.LocalPlayer;
    local l__Character__116 = l__LocalPlayer__115.Character;
    local l__PlayerGui__117 = l__LocalPlayer__115.PlayerGui;
    local l__Lighting__118 = game:GetService("Lighting");
    local u812 = l__UIAssets__4.ScopeScreen:Clone();
    u811:Add(u812);
    local u813 = workspace:GetServerTimeNow();
    local u814 = math.max(p809 - u813, 0.016666666666666666);
    local u815 = p809 + (p810 or 0);
    local l__Brightness__119 = l__Lighting__118.Brightness;
    l__Lighting__118.Brightness = 6;
    local l__ScopedCC__120 = u812.ScopedCC;
    local l__ScopedCC2__121 = u812.ScopedCC2;
    local l__ScopedCC3__122 = u812.ScopedCC3;
    l__ScopedCC__120.Parent = l__Lighting__118;
    l__ScopedCC2__121.Parent = l__Lighting__118;
    l__ScopedCC3__122.Parent = l__Lighting__118;
    u811:Add(l__ScopedCC__120);
    u811:Add(l__ScopedCC2__121);
    u811:Add(l__ScopedCC3__122);
    local u816 = Color3.fromRGB(255, 0, 0);
    local u817 = {};
    local u818 = {};
    local u819 = 1;
    local u820 = {};
    local function v822(p821) --[[ Line: 4100 ]]
        -- upvalues: u818 (copy), u820 (copy), u817 (copy)
        if u818[p821] or u820[p821] then
        else
            u818[p821] = true;
            u817[#u817 + 1] = p821;
        end;
    end;
    local function u826(p823) --[[ Line: 4109 ]]
        -- upvalues: u818 (copy), u817 (copy), u819 (ref)
        if u818[p823] then
            u818[p823] = nil;
            for v824, v825 in ipairs(u817) do
                if v825 == p823 then
                    table.remove(u817, v824);
                    if v824 < u819 then
                        u819 = u819 - 1;
                    end;
                    if u819 > #u817 then
                        u819 = 1;
                    end;
                    return;
                end;
            end;
        end;
    end;
    local function u830(p827) --[[ Line: 4133 ]]
        if p827:IsA("BasePart") then
            return math.max(p827.Transparency, p827.LocalTransparencyModifier or 0) >= 1 and {} or { p827 };
        end;
        local v828 = {};
        for _, v829 in ipairs(p827:GetDescendants()) do
            if v829:IsA("BasePart") and math.max(v829.Transparency, v829.LocalTransparencyModifier or 0) < 1 then
                v828[#v828 + 1] = v829;
            end;
        end;
        return v828;
    end;
    local function u864(p831, p832) --[[ Line: 4156 ]]
        local v833 = (1 / 0);
        local v834 = (1 / 0);
        local v835 = (-1 / 0);
        local v836 = (-1 / 0);
        local v837 = false;
        local v838 = v837;
        local v839 = v836;
        local v840 = v835;
        local v841 = v834;
        local v842 = v833;
        for _, v843 in ipairs(p831) do
            if v843.Parent then
                local l__CFrame__123 = v843.CFrame;
                local v844 = v843.Size * 0.5;
                local l__Position__124 = l__CFrame__123.Position;
                local v845 = l__CFrame__123.RightVector * v844.X;
                local v846 = l__CFrame__123.UpVector * v844.Y;
                local v847 = l__CFrame__123.LookVector * v844.Z;
                local v848, v849 = p832:WorldToViewportPoint(l__Position__124 + v845 + v846 + v847);
                v833 = math.min(v842, v848.X);
                v834 = math.min(v841, v848.Y);
                v835 = math.max(v840, v848.X);
                v836 = math.max(v839, v848.Y);
                if v849 then
                    v838 = v848.Z > 0 and true or v838;
                end;
                local v850, v851 = p832:WorldToViewportPoint(l__Position__124 + v845 + v846 - v847);
                v833 = math.min(v833, v850.X);
                v834 = math.min(v834, v850.Y);
                v835 = math.max(v835, v850.X);
                v836 = math.max(v836, v850.Y);
                if v851 then
                    v838 = v850.Z > 0 and true or v838;
                end;
                local v852, v853 = p832:WorldToViewportPoint(l__Position__124 + v845 - v846 + v847);
                v833 = math.min(v833, v852.X);
                v834 = math.min(v834, v852.Y);
                v835 = math.max(v835, v852.X);
                v836 = math.max(v836, v852.Y);
                if v853 then
                    v838 = v852.Z > 0 and true or v838;
                end;
                local v854, v855 = p832:WorldToViewportPoint(l__Position__124 + v845 - v846 - v847);
                v833 = math.min(v833, v854.X);
                v834 = math.min(v834, v854.Y);
                v835 = math.max(v835, v854.X);
                v836 = math.max(v836, v854.Y);
                if v855 then
                    v838 = v854.Z > 0 and true or v838;
                end;
                local v856, v857 = p832:WorldToViewportPoint(l__Position__124 - v845 + v846 + v847);
                v833 = math.min(v833, v856.X);
                v834 = math.min(v834, v856.Y);
                v835 = math.max(v835, v856.X);
                v836 = math.max(v836, v856.Y);
                if v857 then
                    v838 = v856.Z > 0 and true or v838;
                end;
                local v858, v859 = p832:WorldToViewportPoint(l__Position__124 - v845 + v846 - v847);
                v833 = math.min(v833, v858.X);
                v834 = math.min(v834, v858.Y);
                v835 = math.max(v835, v858.X);
                v836 = math.max(v836, v858.Y);
                if v859 then
                    v838 = v858.Z > 0 and true or v838;
                end;
                local v860, v861 = p832:WorldToViewportPoint(l__Position__124 - v845 - v846 + v847);
                v833 = math.min(v833, v860.X);
                v834 = math.min(v834, v860.Y);
                v835 = math.max(v835, v860.X);
                v836 = math.max(v836, v860.Y);
                if v861 then
                    v838 = v860.Z > 0 and true or v838;
                end;
                local v862, v863 = p832:WorldToViewportPoint(l__Position__124 - v845 - v846 - v847);
                v833 = math.min(v833, v862.X);
                v834 = math.min(v834, v862.Y);
                v835 = math.max(v835, v862.X);
                v836 = math.max(v836, v862.Y);
                if v863 and v862.Z > 0 then
                    v837 = true;
                    v838 = v837;
                    v839 = v836;
                    v840 = v835;
                    v841 = v834;
                    v842 = v833;
                else
                    v839 = v836;
                    v840 = v835;
                    v841 = v834;
                    v842 = v833;
                end;
            end;
        end;
        if v838 then
            return v842, v841, v840, v839;
        else
            return nil;
        end;
    end;
    local function u870(p865, p866, p867) --[[ Line: 4224 ]]
        -- upvalues: l__EffectAssets__5 (ref), u816 (copy), u808 (copy), u811 (copy), u820 (copy), u830 (copy)
        local v868 = l__EffectAssets__5.BoxHighlight:Clone();
        v868.BackgroundColor3 = u816;
        v868.Visible = false;
        v868.Parent = u808._x364033b796543937;
        u811:Add(v868);
        local v869 = v868:FindFirstChildOfClass("UIStroke");
        if v869 then
            v869.Color = u816;
        end;
        u820[p865] = {
            has_los = true,
            next_bounds_update = 0,
            box_frame = v868,
            root_part = p866,
            parts = u830(p865),
            next_los_update = p867 + 0.08333333333333333,
            next_parts_refresh = p867 + 0.006944444444444444
        };
    end;
    local function u877(p871, p872, p873) --[[ Line: 4247 ]]
        -- upvalues: u820 (copy), l__Character__116 (copy), l__Classes__3 (ref), u870 (copy), u826 (copy)
        if u820[p871] then
        elseif p871 == l__Character__116 then
        elseif p871:GetAttribute("is_teammate") then
        else
            local v874 = p871:FindFirstChild("HumanoidRootPart");
            if v874 and v874:IsA("BasePart") then
                local v875, v876 = p872:WorldToViewportPoint(v874.Position);
                if v876 and v875.Z > 0 then
                    if l__Classes__3.Util:hasLineOfSight(p872.CFrame.Position, v874.Position) then
                        u870(p871, v874, p873);
                        u826(p871);
                    end;
                end;
            end;
        end;
    end;
    local function u883(p878, p879) --[[ Line: 4278 ]]
        -- upvalues: u817 (copy), u819 (ref), u877 (copy)
        local v880 = #u817;
        if v880 == 0 then
        else
            local v881 = 0;
            while v881 < 12 and v881 < v880 do
                local v882 = u817[u819];
                u819 = u819 + 1;
                if v880 < u819 then
                    u819 = 1;
                end;
                if v882 and v882.Parent then
                    u877(v882, p878, p879);
                end;
                v881 = v881 + 1;
            end;
        end;
    end;
    local function u897(p884, p885, p886, p887) --[[ Line: 4301 ]]
        -- upvalues: u820 (copy), l__Classes__3 (ref), u830 (copy), u864 (copy)
        local l__box_frame__125 = p885.box_frame;
        if p884.Parent then
            local l__root_part__126 = p885.root_part;
            if not (l__root_part__126 and l__root_part__126.Parent) then
                l__root_part__126 = p884:FindFirstChild("HumanoidRootPart");
                if not (l__root_part__126 and l__root_part__126:IsA("BasePart")) then
                    l__box_frame__125.Visible = false;
                    return;
                end;
                p885.root_part = l__root_part__126;
            end;
            if p885.next_los_update <= p887 then
                local v888, v889 = p886:WorldToViewportPoint(l__root_part__126.Position);
                if v889 then
                    if v888.Z > 0 then
                        v889 = l__Classes__3.Util:hasLineOfSight(p886.CFrame.Position, l__root_part__126.Position);
                    else
                        v889 = false;
                    end;
                end;
                p885.has_los = v889;
                p885.next_los_update = p887 + 0.08333333333333333;
            end;
            if p887 < p885.next_bounds_update then
                if not p885.has_los then
                    l__box_frame__125.Visible = false;
                end;
            else
                p885.next_bounds_update = p887 + 0.006944444444444444;
                if p885.next_parts_refresh <= p887 then
                    p885.parts = u830(p884);
                    p885.next_parts_refresh = p887 + 0.006944444444444444;
                end;
                if p885.has_los then
                    local v890, v891, v892, v893 = u864(p885.parts, p886);
                    if v890 then
                        local v894 = math.max(1, v892 - v890);
                        local v895 = math.max(1, v893 - v891);
                        l__box_frame__125.AnchorPoint = Vector2.new(0, 0);
                        l__box_frame__125.Position = UDim2.new(0, v890, 0, v891);
                        l__box_frame__125.Size = UDim2.new(0, v894, 0, v895);
                        l__box_frame__125.Visible = true;
                    else
                        l__box_frame__125.Visible = false;
                    end;
                else
                    l__box_frame__125.Visible = false;
                end;
            end;
        else
            local v896 = u820[p884];
            if v896 then
                u820[p884] = nil;
                if v896.box_frame then
                    v896.box_frame:Destroy();
                end;
            end;
        end;
    end;
    local v898 = workspace:FindFirstChild("Entities");
    if v898 then
        for _, v899 in v898:GetChildren() do
            if not u818[v899] then
                if not u820[v899] then
                    u818[v899] = true;
                    u817[#u817 + 1] = v899;
                end;
            end;
        end;
        u811:Connect(v898.ChildAdded, v822);
        u811:Connect(v898.ChildRemoved, function(p900) --[[ Line: 4373 ]]
            -- upvalues: u826 (copy), u820 (copy)
            u826(p900);
            local v901 = u820[p900];
            if v901 then
                u820[p900] = nil;
                if v901.box_frame then
                    v901.box_frame:Destroy();
                end;
            end;
        end);
    end;
    l__TweenService__1:Create(l__ScopedCC3__122, TweenInfo.new(u814 / 3, Enum.EasingStyle.Linear), {
        Size = 0
    }):Play();
    local v902 = TweenInfo.new(u814, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
    local v903 = TweenInfo.new(u814, Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
    local v904 = TweenInfo.new(u814 / 1.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
    l__TweenService__1:Create(u812.Main, v902, {
        Size = UDim2.fromScale(0.66, 0.66),
        Position = UDim2.fromScale(0.5, 0.5)
    }):Play();
    u812.Parent = l__PlayerGui__117;
    l__TweenService__1:Create(u812.Main.Lines.Line2, v904, {
        Position = UDim2.fromScale(0.5, 0.7)
    }):Play();
    l__TweenService__1:Create(u812.Main.Lines.Line3, v903, {
        Position = UDim2.fromScale(0.5, 0.8)
    }):Play();
    l__TweenService__1:Create(u812.Main.Lines.Line4, v904, {
        Position = UDim2.fromScale(0.5, 0.3)
    }):Play();
    l__TweenService__1:Create(u812.Main.Lines.Line5, v903, {
        Position = UDim2.fromScale(0.5, 0.2)
    }):Play();
    l__TweenService__1:Create(u812.Main.Lines.Line1, v904, {
        Position = UDim2.fromScale(0.5, 0.4)
    }):Play();
    l__TweenService__1:Create(u812.Main.Lines.Line6, v904, {
        Position = UDim2.fromScale(0.5, 0.6)
    }):Play();
    local l___x9d953ef0950533a5__127 = l__Classes__3._xfaee1d1d64cdfe93._x9d953ef0950533a5;
    local u905;
    if l___x9d953ef0950533a5__127 then
        u905 = nil;
    else
        u905 = l__Classes__3._xfaee1d1d64cdfe93._x9374c60b0eb68ccd;
        l__Classes__3._xfaee1d1d64cdfe93._x9374c60b0eb68ccd = 0.1;
    end;
    for _, v906 in u812:GetDescendants() do
        local v907 = ({
            ImageLabel = "ImageTransparency",
            UIStroke = "Transparency",
            Frame = "BackgroundTransparency"
        })[v906.ClassName];
        if v907 and v906[v907] ~= 1 then
            local v908 = v906[v907];
            v906[v907] = 1;
            l__TweenService__1:Create(v906, TweenInfo.new(u814, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                [v907] = v908
            }):Play();
        end;
    end;
    local l__InvertedSphere__128 = u812.InvertedSphere;
    l__TweenService__1:Create(l__InvertedSphere__128, TweenInfo.new(u814, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = Vector3.new(1000, 1000, 1000)
    }):Play();
    l__TweenService__1:Create(l__InvertedSphere__128, TweenInfo.new(u814, Enum.EasingStyle.Linear), {
        Transparency = 1
    }):Play();
    l__Classes__3._x910f31e87b3c7281._x18b5705689fe6582 = true;
    if l__PlayerGui__117:FindFirstChild("GameplayUI") then
        l__PlayerGui__117.GameplayUI.Enabled = false;
    end;
    l__Classes__3._xbe184fb1376a575d:_x7ab8b42cc5920a78("NIGHT_VISION", true);
    local u909 = false;
    local function v912() --[[ Line: 4441 ]]
        -- upvalues: u909 (ref), l__Promise__6 (ref), l__Lighting__118 (copy), l__Brightness__119 (copy), u820 (copy), u811 (copy), l__Classes__3 (ref), l__PlayerGui__117 (copy), l___x9d953ef0950533a5__127 (copy), u905 (ref)
        if u909 then
        else
            u909 = true;
            l__Promise__6.defer(function() --[[ Line: 4448 ]]
                -- upvalues: l__Promise__6 (ref), l__Lighting__118 (ref), l__Brightness__119 (ref), u820 (ref), u811 (ref), l__Classes__3 (ref), l__PlayerGui__117 (ref), l___x9d953ef0950533a5__127 (ref), u905 (ref)
                l__Promise__6.defer(function() --[[ Line: 4449 ]]
                    -- upvalues: l__Promise__6 (ref), l__Lighting__118 (ref), l__Brightness__119 (ref), u820 (ref), u811 (ref), l__Classes__3 (ref), l__PlayerGui__117 (ref), l___x9d953ef0950533a5__127 (ref), u905 (ref)
                    l__Promise__6.defer(function() --[[ Line: 4450 ]]
                        -- upvalues: l__Lighting__118 (ref), l__Brightness__119 (ref), u820 (ref), u811 (ref), l__Classes__3 (ref), l__PlayerGui__117 (ref), l___x9d953ef0950533a5__127 (ref), u905 (ref)
                        l__Lighting__118.Brightness = l__Brightness__119;
                        for v910, v911 in u820 do
                            u820[v910] = nil;
                            if v911.box_frame then
                                v911.box_frame:Destroy();
                            end;
                        end;
                        u811:Clean();
                        l__Classes__3._x910f31e87b3c7281._x18b5705689fe6582 = false;
                        if l__PlayerGui__117:FindFirstChild("GameplayUI") and (l__Classes__3._x7430d6d194f43373._x3668b6edfe3dbbd4 == "alive" and not l__Classes__3.MenuManager.in_menu) then
                            l__PlayerGui__117.GameplayUI.Enabled = true;
                        end;
                        if not l___x9d953ef0950533a5__127 then
                            l__Classes__3._xfaee1d1d64cdfe93._x9d953ef0950533a5 = false;
                            l__Classes__3._xfaee1d1d64cdfe93._x9374c60b0eb68ccd = u905;
                        end;
                    end);
                end);
            end);
        end;
    end;
    local l__UIGradient__129 = u812.Main.LeftCharge.RightClip.Right.UIGradient;
    u811:BindToRenderStep("scope", Enum.RenderPriority.Camera.Value + 3, function() --[[ Line: 4472 ]]
        -- upvalues: u815 (copy), u909 (ref), l__Promise__6 (ref), l__Lighting__118 (copy), l__Brightness__119 (copy), u820 (copy), u811 (copy), l__Classes__3 (ref), l__PlayerGui__117 (copy), l___x9d953ef0950533a5__127 (copy), u905 (ref), u883 (copy), u897 (copy), u813 (copy), u814 (copy), u814 (copy), l__TweenService__1 (ref), l__UIGradient__129 (copy), u812 (copy), l__InvertedSphere__128 (copy)
        local v913 = workspace:GetServerTimeNow();
        if u815 <= v913 then
            if u909 then
            else
                u909 = true;
                l__Promise__6.defer(function() --[[ Line: 4448 ]]
                    -- upvalues: l__Promise__6 (ref), l__Lighting__118 (ref), l__Brightness__119 (ref), u820 (ref), u811 (ref), l__Classes__3 (ref), l__PlayerGui__117 (ref), l___x9d953ef0950533a5__127 (ref), u905 (ref)
                    l__Promise__6.defer(function() --[[ Line: 4449 ]]
                        -- upvalues: l__Promise__6 (ref), l__Lighting__118 (ref), l__Brightness__119 (ref), u820 (ref), u811 (ref), l__Classes__3 (ref), l__PlayerGui__117 (ref), l___x9d953ef0950533a5__127 (ref), u905 (ref)
                        l__Promise__6.defer(function() --[[ Line: 4450 ]]
                            -- upvalues: l__Lighting__118 (ref), l__Brightness__119 (ref), u820 (ref), u811 (ref), l__Classes__3 (ref), l__PlayerGui__117 (ref), l___x9d953ef0950533a5__127 (ref), u905 (ref)
                            l__Lighting__118.Brightness = l__Brightness__119;
                            for v914, v915 in u820 do
                                u820[v914] = nil;
                                if v915.box_frame then
                                    v915.box_frame:Destroy();
                                end;
                            end;
                            u811:Clean();
                            l__Classes__3._x910f31e87b3c7281._x18b5705689fe6582 = false;
                            if l__PlayerGui__117:FindFirstChild("GameplayUI") and (l__Classes__3._x7430d6d194f43373._x3668b6edfe3dbbd4 == "alive" and not l__Classes__3.MenuManager.in_menu) then
                                l__PlayerGui__117.GameplayUI.Enabled = true;
                            end;
                            if not l___x9d953ef0950533a5__127 then
                                l__Classes__3._xfaee1d1d64cdfe93._x9d953ef0950533a5 = false;
                                l__Classes__3._xfaee1d1d64cdfe93._x9374c60b0eb68ccd = u905;
                            end;
                        end);
                    end);
                end);
            end;
        else
            local l__CurrentCamera__130 = workspace.CurrentCamera;
            if l__CurrentCamera__130 then
                u883(l__CurrentCamera__130, v913);
                for v916, v917 in u820 do
                    u897(v916, v917, l__CurrentCamera__130, v913);
                end;
            end;
            local v918 = math.min(v913 - u813, u814);
            local v919 = l__Classes__3.Util:convNumRange(v918, 0, u814, 0, 1);
            local v920 = l__TweenService__1:GetValue(l__Classes__3.Util:convNumRange(v918, 0, u814, 0, 1), Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
            local v921 = l__Classes__3.Util:numLerp(85, 45, v920);
            if l__CurrentCamera__130 then
                l__CurrentCamera__130.FieldOfView = v921;
            end;
            local v922 = l__Classes__3.Util:numLerp(0, 90, v919);
            l__UIGradient__129.Rotation = v922;
            u812.Main.LeftCharge.Rotation = 180 - v922 / 2;
            if l__CurrentCamera__130 then
                l__InvertedSphere__128.Position = l__CurrentCamera__130.CFrame.Position;
            end;
        end;
    end);
    l__InvertedSphere__128.Parent = l__Effects__9;
    game.Debris:AddItem(l__InvertedSphere__128, u814 + (p810 or 0));
    u811:Add(l__InvertedSphere__128);
    return v912;
end;
function u1._xe53615d96cf36a6b(u923) --[[ Line: 4513 ]]
    -- upvalues: u2 (ref), l__Classes__3 (copy), u3 (ref), u4 (ref), l__EffectAssets__5 (copy), u5 (ref)
    u2 = l__Classes__3._x7058397dabccd000;
    u3 = l__Classes__3.Util;
    u4 = u923._x77e7400375b356fa;
    local l__PlayerGui__131 = game.Players.LocalPlayer.PlayerGui;
    u923._x364033b796543937.Parent = l__PlayerGui__131;
    u923._x4c1ab1d6adc1729b.Parent = l__PlayerGui__131;
    task.defer(function() --[[ Line: 4521 ]]
        -- upvalues: l__EffectAssets__5 (ref), u2 (ref), u5 (ref), u923 (copy)
        game:GetService("ContentProvider"):PreloadAsync({ l__EffectAssets__5.PhoenixFlash });
        if u2 then
            u5 = u2._x77aafe36a385b603;
            u923:_xfd5b32895b6d7862();
            u923:_x8d2a80ae7c42542d();
        end;
        u923:_xf5cd0a1b6d5598ce();
    end);
end;
return u1;
