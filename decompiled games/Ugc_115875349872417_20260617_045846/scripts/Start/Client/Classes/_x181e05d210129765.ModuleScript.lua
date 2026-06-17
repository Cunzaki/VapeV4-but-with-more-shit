-- Decompiled from: Start.Client.Classes._x181e05d210129765
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

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
local l___x7749231778538ccb__8 = require(script.Parent.Parent._x7749231778538ccb);
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
function u1._x83ed94bfb82a8c9f() --[[ Line: 73 ]]
    -- upvalues: u1 (copy)
    local v7 = setmetatable({}, u1);
    v7._xf27c081d7e69cea6 = Instance.new("ScreenGui");
    v7._xf27c081d7e69cea6.ResetOnSpawn = false;
    v7._xf27c081d7e69cea6.Name = "VisualEffects";
    v7._xf27c081d7e69cea6.DisplayOrder = 3;
    v7._xf27c081d7e69cea6.IgnoreGuiInset = true;
    v7._xeca229b8e757f446 = Instance.new("ScreenGui");
    v7._xeca229b8e757f446.ResetOnSpawn = false;
    v7._xeca229b8e757f446.Name = "PhotosensitivityTint";
    v7._xeca229b8e757f446.DisplayOrder = v7._xf27c081d7e69cea6.DisplayOrder + 1;
    v7._xeca229b8e757f446.IgnoreGuiInset = true;
    v7._xabebff7debaebf80 = Instance.new("Frame");
    v7._xabebff7debaebf80.Name = "Tint";
    v7._xabebff7debaebf80.Size = UDim2.fromScale(1, 1);
    v7._xabebff7debaebf80.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    v7._xabebff7debaebf80.BackgroundTransparency = 1;
    v7._xabebff7debaebf80.BorderSizePixel = 0;
    v7._xabebff7debaebf80.Visible = false;
    v7._xabebff7debaebf80.ZIndex = 1000;
    v7._xabebff7debaebf80.Parent = v7._xeca229b8e757f446;
    v7._x9032bcf90810f5bc = false;
    v7._x2abcbaf3101a88e1 = nil;
    v7._x17e3401eeb60fec9 = nil;
    v7._x2ed0ede9312970c7 = "Standard";
    v7._x9cc3ff0e27dc9f58 = {};
    v7._x4c6db007e02bd23c = {};
    v7._xeea1787ee1726109 = {
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
    v7._xa263fcfbcb59f38b = {};
    v7._x85b32f0b9c67055f = {};
    v7._x7ef5282e79536848 = {};
    v7._x9cab91eaa222232c = v7:_xff049722a58939d5();
    return v7;
end;
function u1._x30accd53c498f58e(p8, p9) --[[ Line: 141 ]]
    p8._x9032bcf90810f5bc = p9 == true;
    if p8._x9032bcf90810f5bc then
    else
        if p8._x17e3401eeb60fec9 then
            task.cancel(p8._x17e3401eeb60fec9);
            p8._x17e3401eeb60fec9 = nil;
        end;
        if p8._x2abcbaf3101a88e1 then
            p8._x2abcbaf3101a88e1:Cancel();
            p8._x2abcbaf3101a88e1 = nil;
        end;
        p8._xabebff7debaebf80.BackgroundTransparency = 1;
        p8._xabebff7debaebf80.Visible = false;
    end;
end;
function u1._x4d70b7dadc9e06ab(u10, u11, p12, p13) --[[ Line: 162 ]]
    -- upvalues: l__TweenService__1 (copy)
    if u10._x9032bcf90810f5bc then
        if u10._x17e3401eeb60fec9 then
            task.cancel(u10._x17e3401eeb60fec9);
            u10._x17e3401eeb60fec9 = nil;
        end;
        if u10._x2abcbaf3101a88e1 then
            u10._x2abcbaf3101a88e1:Cancel();
            u10._x2abcbaf3101a88e1 = nil;
        end;
        local v14 = math.abs(p12 or 1) / 4;
        local v15 = math.clamp(v14, 0.28, 0.72);
        local l___xabebff7debaebf80__11 = u10._xabebff7debaebf80;
        l___xabebff7debaebf80__11.Visible = true;
        l___xabebff7debaebf80__11.BackgroundTransparency = math.min(l___xabebff7debaebf80__11.BackgroundTransparency, 1 - v15);
        local function u17() --[[ Line: 181 ]]
            -- upvalues: l__TweenService__1 (ref), l___xabebff7debaebf80__11 (copy), u11 (copy), u10 (copy)
            local u16 = l__TweenService__1:Create(l___xabebff7debaebf80__11, TweenInfo.new(math.max(u11 or 0, 0.85), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            });
            u10._x2abcbaf3101a88e1 = u16;
            u16.Completed:Connect(function() --[[ Line: 185 ]]
                -- upvalues: u10 (ref), u16 (copy), l___xabebff7debaebf80__11 (ref)
                if u10._x2abcbaf3101a88e1 == u16 then
                    u10._x2abcbaf3101a88e1 = nil;
                    l___xabebff7debaebf80__11.Visible = false;
                end;
            end);
            u16:Play();
        end;
        if p13 and p13 > 0 then
            u10._x17e3401eeb60fec9 = task.delay(p13, function() --[[ Line: 196 ]]
                -- upvalues: u10 (copy), u17 (copy)
                u10._x17e3401eeb60fec9 = nil;
                u17();
            end);
        else
            u17();
        end;
    end;
end;
function u1._x163724fe4f12c8e4(p18, p19, p20, p21) --[[ Line: 205 ]]
    -- upvalues: l__TweenService__1 (copy)
    p19.ExposureCompensation = p20;
    p18:_x4d70b7dadc9e06ab(p21.Time, p20);
    return l__TweenService__1:Create(p19, p21, {
        ExposureCompensation = 0
    });
end;
function u1._x7acbd6fcd723edcc(_, _) --[[ Line: 212 ]] end;
function u1._x143e1893e9a92131(_, _, _, _) --[[ Line: 221 ]] end;
function u1._xe69ddc8fce5b636f(_, p22, p23) --[[ Line: 243 ]]
    p22._transition = {
        startTime = p23.start_time,
        startRadius = p22._radius,
        targetRadius = p23.target_radius,
        endTime = p23.end_time
    };
end;
function u1._x9f1aedf93447bcc4(_, p24, p25, p26) --[[ Line: 259 ]]
    p24._radius = p25;
    p24._origin = p26;
    return p24;
end;
function u1._x77d5fc071f0a9058(_, p27) --[[ Line: 265 ]]
    -- upvalues: l__Classes__3 (copy), l__TweenService__1 (copy)
    local v28 = p27:FindFirstChild("Button");
    if v28 then
        l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("CASETTE_PLAY", true, {
            location = l__Classes__3.Util:getLikelyVec3(v28)
        });
        v28.Color = Color3.fromRGB(255, 0, 0);
        l__TweenService__1:Create(v28, TweenInfo.new(0.5), {
            Color = Color3.fromRGB(75, 151, 75)
        }):Play();
    end;
end;
function u1._xe182ade6022b2c32(_, p29, p30) --[[ Line: 273 ]]
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
    local function v38(p34) --[[ Line: 295 ]]
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
    local v56 = l__RunService__2.RenderStepped:Connect(function(p43) --[[ Line: 336 ]]
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
function u1._x04f10495a3010e73(u57, p58) --[[ Line: 420 ]]
    -- upvalues: u6 (copy)
    for _, u59 in p58:GetDescendants() do
        if u59:IsA("ParticleEmitter") then
            local v60 = u59:GetAttribute("EmitDelay");
            if v60 then
                task.delay(v60, function() --[[ Line: 436 ]]
                    -- upvalues: u59 (copy), u6 (ref), u57 (copy)
                    local v61 = u59;
                    local v62 = v61:GetAttribute("EmitCount");
                    if v62 then
                        local v63 = math.max(v62 * u6[u57._x2ed0ede9312970c7] or 1, 1);
                        local v64 = math.floor(v63);
                        if v62 >= 1 then
                            v61:Emit(v64);
                        end;
                    end;
                end);
            else
                local v65 = u59:GetAttribute("EmitCount");
                if v65 then
                    local v66 = math.max(v65 * u6[u57._x2ed0ede9312970c7] or 1, 1);
                    local v67 = math.floor(v66);
                    if v65 >= 1 then
                        u59:Emit(v67);
                    end;
                end;
            end;
        end;
    end;
end;
function u1._x7c391a6b4e99d7a0(p68) --[[ Line: 446 ]]
    -- upvalues: l__UIAssets__4 (copy), l__TweenService__1 (copy), l__Classes__3 (copy)
    local v69 = l__UIAssets__4.SpeedEffect:Clone();
    v69.Parent = p68._xf27c081d7e69cea6;
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
    l__Classes__3._xdca80115d2839102:_x145395062c6646e5(v70);
    l__TweenService__1:Create(v71, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
end;
function u1._xee3cf89a6e695d73(_, p72) --[[ Line: 466 ]]
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
    u73:Add(l__RunService__2.Heartbeat:Connect(function() --[[ Line: 497 ]]
        -- upvalues: u74 (copy), u75 (copy), u77 (copy), u76 (copy)
        local v78 = math.random(180, 255);
        if u74 and u74.Parent ~= nil then
            u74.BackgroundColor3 = Color3.fromRGB(v78, v78, v78);
            u75.Position = UDim2.fromScale(0, u77:NextNumber(0, 1));
            u76.Position = UDim2.fromScale(0, u77:NextNumber(0, 1));
        end;
    end));
    l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("SCREEN_STATIC", true, {
        location = l__Classes__3.Util:getLikelyVec3(p72)
    });
    l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("SCREEN_STATIC2", true, {
        location = l__Classes__3.Util:getLikelyVec3(p72)
    });
    task.delay(0.66, function() --[[ Line: 510 ]]
        -- upvalues: u73 (copy), l__TweenService__1 (ref), l__MainCanvas__27 (copy)
        u73:Clean();
        l__TweenService__1:Create(l__MainCanvas__27, TweenInfo.new(0.66, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            GroupTransparency = 0
        }):Play();
    end);
end;
function u1._xf9ae4728ed161dee(_) --[[ Line: 516 ]]
    -- upvalues: l__UIAssets__4 (copy), l__Classes__3 (copy)
    local v79 = l__UIAssets__4.Black:Clone();
    v79.Parent = game.Players.LocalPlayer.PlayerGui;
    l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("TELEPORT_DRAMATIC", true);
    game.Debris:AddItem(v79, 30);
    return v79;
end;
function u1._xd3d48950a766775d(p80, p81) --[[ Line: 526 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local v82 = l__EffectAssets__5.LaunchpadEffect:Clone();
    v82:PivotTo((CFrame.lookAt(p81.Origin.Position, p81.LaunchGoal.Position)));
    l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("RELEASE", true, {
        Parent = p81.PrimaryPart
    });
    v82.Parent = l__Effects__9;
    p80:_x04f10495a3010e73(v82);
    l__TweenService__1:Create(v82.InvertedSpike, TweenInfo.new(0.07), {
        Size = Vector3.new(5, 30, 5),
        Transparency = 1
    }):Play();
    game.Debris:AddItem(v82, 0.5);
end;
function u1._xc41fb81b6aa12e79(u83, u84, u85) --[[ Line: 541 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), u3 (ref), l__RunService__2 (copy)
    local function v94(u86, u87) --[[ Line: 551 ]]
        -- upvalues: u84 (copy), l__Classes__3 (ref), u83 (copy), u3 (ref), l__RunService__2 (ref), u85 (copy)
        local l__PrimaryPart__28 = u84.PrimaryPart;
        if l__PrimaryPart__28 then
            l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("PULL", true, {
                Parent = l__PrimaryPart__28
            });
            l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("WALL_HIT", true, {
                Parent = l__PrimaryPart__28
            });
            if u83._xa263fcfbcb59f38b[u84] then
                print("CONFLICT FOUND FOR GRAPPLE");
                u3:cleanConnectionsTable(u83._xa263fcfbcb59f38b[u84].connections);
                u83._xa263fcfbcb59f38b[u84] = nil;
            end;
            local u88 = {
                connections = {},
                tether = u86,
                ended = false
            };
            local l__SpringConstraint__29 = u86.SpringConstraint;
            u88.sound = l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("GRAPPLE_REEL", true, {
                Parent = l__PrimaryPart__28
            });
            u86.Position = l__PrimaryPart__28.Position;
            l__SpringConstraint__29.Visible = true;
            local v93 = l__RunService__2.RenderStepped:Connect(function(p89) --[[ Line: 579 ]]
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
            task.delay(4, function() --[[ Line: 605 ]]
                -- upvalues: u88 (copy), u83 (ref), u84 (ref)
                if not u88.ended then
                    u83:_x46c82226b1fac495(u84);
                end;
            end);
            table.insert(u88.connections, v93);
            u83._xa263fcfbcb59f38b[u84] = u88;
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
        warn("ATTACHMENT NOT FOUND FOR CHARACTER : ", u84);
    end;
end;
function u1._x46c82226b1fac495(p98, p99) --[[ Line: 631 ]]
    -- upvalues: u3 (ref), l__Classes__3 (copy)
    if p98._xa263fcfbcb59f38b[p99] then
        local v100 = p98._xa263fcfbcb59f38b[p99];
        if v100.sound then
            v100.sound:Destroy();
        end;
        v100.ended = true;
        if v100.tether then
            v100.tether:Destroy();
        end;
        u3:cleanConnectionsTable(v100.connections);
        l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("GRAPPLE_READY", true, {
            Parent = p99.PrimaryPart
        });
        p98._xa263fcfbcb59f38b[p99] = nil;
    end;
end;
function u1._xfe6795a495be818e(p101, p102, p103) --[[ Line: 651 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), l__Classes__3 (copy), l__RunService__2 (copy)
    local v104 = l__EffectAssets__5:FindFirstChild(p103);
    if v104 then
        local v105 = v104:Clone();
        v105.Parent = l__Effects__9;
        l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("PROJECTILE_WHOOSH", true, {
            Parent = v105
        });
        local u106 = {};
        for _, u107 in v105:GetDescendants() do
            if u107:IsA("ParticleEmitter") then
                local v108 = u107:GetAttribute("EmitDelay");
                if v108 then
                    task.delay(v108, function() --[[ Line: 680 ]]
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
        local function u127(p124, p125) --[[ Line: 727 ]]
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
        p101._x4c6db007e02bd23c[l__removal_id__34] = u128;
        local u129 = 0;
        local u130 = nil;
        u130 = l__RunService__2.RenderStepped:Connect(function(p131) --[[ Line: 765 ]]
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
function u1._x738ec4b2fe4264c5(p134, p135) --[[ Line: 806 ]]
    -- upvalues: l__Promise__6 (copy)
    local u136 = p134._x4c6db007e02bd23c[p135];
    if u136 then
        u136.active = false;
        if u136.conn then
            pcall(function() --[[ Line: 813 ]]
                -- upvalues: u136 (copy)
                u136.conn:Disconnect();
            end);
            u136.conn = nil;
        end;
        if u136.effect and u136.effect.Parent then
            pcall(function() --[[ Line: 818 ]]
                -- upvalues: l__Promise__6 (ref), u136 (copy)
                l__Promise__6.defer(function() --[[ Line: 819 ]]
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
        p134._x4c6db007e02bd23c[p135] = nil;
    end;
end;
function u1._x67a2f8cecc1abb11(p139, p140) --[[ Line: 841 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), u6 (copy), u3 (ref), l__Promise__6 (copy)
    local v141 = l__EffectAssets__5.Shockwave:Clone();
    v141.CFrame = CFrame.lookAt(p140.Position + p140.Normal * 2, p140.Position + p140.Normal * 3);
    v141.Parent = l__Effects__9;
    p139:_x04f10495a3010e73(v141);
    game.Debris:AddItem(v141, 2);
    local v142 = math.max(5 * u6[p139._x2ed0ede9312970c7], 1);
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
        p139:_x04f10495a3010e73(u143);
        task.delay(1.5 * v144, function() --[[ Line: 872 ]]
            -- upvalues: u143 (copy)
            u143.Attachment.Trail.Enabled = false;
        end);
        l__Promise__6.delay(3 * v144):andThen(function() --[[ Line: 876 ]]
            -- upvalues: u143 (copy)
            u143.Anchored = true;
            u143.CanCollide = false;
        end);
        game.Debris:AddItem(u143, 4.5 * v144);
    end;
end;
function u1._x46d905ab09eb3711(p145, p146, p147) --[[ Line: 885 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), u2 (ref), u3 (ref), l__TweenService__1 (copy)
    local v148 = l__EffectAssets__5.Explosion:Clone();
    local v149 = l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("EXPLOSION", true, {
        Parent = v148
    });
    if p147 then
        v149.RollOffMinDistance = 1000;
    end;
    game.Debris:AddItem(v148, 3);
    v148.Position = p146;
    v148.Parent = l__Effects__9;
    p145:_x04f10495a3010e73(v148);
    local v150 = p147 and 500 or 150;
    if u2._xde8b8f659627fa3f then
        local v151 = u3:numLerp(30, 0, l__TweenService__1:GetValue(u3:convNumRange(math.clamp((p146 - u2._xde8b8f659627fa3f.Position).Magnitude, 0, 150), 0, v150, 0, 1), Enum.EasingStyle.Exponential, Enum.EasingDirection.Out));
        l__Classes__3._xdca80115d2839102:_x37e1f658b04f8d69(v151, 4, 4, { "pitch", "yaw", "roll" }, 0.6, true, false, false, false);
    end;
end;
function u1._x2574489847a97732(p152, p153) --[[ Line: 908 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy)
    local u154 = l__EffectAssets__5.PhoenixDirect:Clone();
    game.Debris:AddItem(u154, 3);
    u154.Position = p153;
    u154.Parent = l__Effects__9;
    p152:_x04f10495a3010e73(u154);
    u154.Stars.Enabled = true;
    u154.Stars1.Enabled = true;
    task.delay(1.2, function() --[[ Line: 918 ]]
        -- upvalues: u154 (copy)
        if u154 and u154.Parent ~= nil then
            u154.Stars.Enabled = false;
            u154.Stars1.Enabled = false;
        end;
    end);
end;
function u1._x9f925e06f0b040f2(_, u155) --[[ Line: 925 ]]
    -- upvalues: l__Promise__6 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    u155.Archivable = true;
    for _, v156 in u155:GetDescendants() do
        if v156:IsA("BasePart") then
            v156.Material = Enum.Material.SmoothPlastic;
            v156.Color = Color3.fromRGB(255, 255, 255);
            v156.Anchored = true;
            v156.CanCollide = false;
            v156.CanQuery = false;
            v156.CastShadow = false;
            v156.Transparency = 0.99;
        elseif not (v156:IsA("Model") or (v156:IsA("Accessory") or (v156:IsA("SpecialMesh") or (v156:IsA("MeshPart") or v156:IsA("Humanoid"))))) then
            v156:Destroy();
        end;
    end;
    print("GLOBAL DEATH");
    local u157 = Instance.new("Highlight");
    u157.FillColor = Color3.fromRGB(255, 255, 255);
    u157.OutlineTransparency = 1;
    u157.FillTransparency = 0;
    u157.Enabled = true;
    u157.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    l__Promise__6.defer(function() --[[ Line: 950 ]]
        -- upvalues: u155 (copy), u157 (copy), l__Effects__9 (ref)
        if u155 and u155.Parent then
            u157.Parent = u155;
            u155.Parent = l__Effects__9;
        end;
    end);
    l__TweenService__1:Create(u157, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
        FillTransparency = 1
    }):Play();
    game.Debris:AddItem(u155, 0.2);
end;
function u1._x886f54e68995380b(_, _, _, _) --[[ Line: 962 ]] end;
function u1._x1b49ff029aea5b9b(_, u158, u159, u160, u161) --[[ Line: 965 ]]
    -- upvalues: l__Promise__6 (copy), l__RunService__2 (copy), l__Classes__3 (copy), l__TweenService__1 (copy)
    for _, v162 in u158:GetDescendants() do
        if v162:IsA("BasePart") or v162:IsA("Decal") then
            v162.Transparency = 1;
        end;
    end;
    local u163 = os.clock();
    return l__Promise__6.new(function(u164, _, p165) --[[ Line: 972 ]]
        -- upvalues: u158 (copy), l__RunService__2 (ref), u163 (copy), u159 (copy), l__Classes__3 (ref), u160 (copy), l__TweenService__1 (ref), u161 (copy)
        local u166 = nil;
        local function u169() --[[ Line: 974 ]]
            -- upvalues: u166 (ref), u158 (ref), u164 (copy)
            if u166 then
                u166:Disconnect();
                u166 = nil;
            end;
            for _, v167 in u158:GetDescendants() do
                if v167 and v167:IsA("BasePart") or v167:IsA("Decal") then
                    local v168 = v167:GetAttribute("OriginalTransparency");
                    if v168 then
                        v167.Transparency = v168;
                    end;
                end;
            end;
            u164();
        end;
        u166 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 991 ]]
            -- upvalues: u163 (ref), u159 (ref), l__Classes__3 (ref), u169 (copy), u158 (ref), u160 (ref), l__TweenService__1 (ref), u161 (ref)
            local v170 = os.clock() - u163;
            local v171 = math.min(v170, u159);
            local v172 = l__Classes__3.Util:convNumRange(v171, 0, u159, 0, 1);
            if v172 == 1 then
                u169();
            end;
            for _, v173 in u158:GetDescendants() do
                if v173:IsA("BasePart") or v173:IsA("Decal") then
                    local v174 = v173:GetAttribute("OriginalTransparency");
                    if v174 then
                        local l__Util__38 = l__Classes__3.Util;
                        local v175 = 1;
                        local v176;
                        if u160 then
                            v176 = l__TweenService__1:GetValue(v172, u160, u161) or v172;
                        else
                            v176 = v172;
                        end;
                        v173.Transparency = l__Util__38:numLerp(v175, v174, v176);
                    end;
                end;
            end;
        end);
        p165(function() --[[ Line: 1007 ]]
            -- upvalues: u169 (copy)
            u169();
        end);
    end);
end;
function u1._xa0a5d73b86a4f969(_, p177, p178, p179) --[[ Line: 1015 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), l__Classes__3 (copy)
    if p179 then
        local v180 = l__EffectAssets__5.GlitchAura:Clone();
        local v181 = Instance.new("Weld");
        v181.Parent = v180;
        v181.Part0 = v180;
        v181.Part1 = p177.PrimaryPart;
        v180.Parent = l__Effects__9;
        v180.ParticleEmitter.Enabled = true;
        game.Debris:AddItem(v180, p178);
        l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("SHORT_DASH", true, {
            Parent = p177:FindFirstChild("HumanoidRootPart")
        });
        l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("DASH", true, {
            Parent = p177:FindFirstChild("HumanoidRootPart")
        });
    end;
    local u182 = {};
    for v183 = 1, 2 do
        local v184 = { "Left Leg", "Right Leg" };
        local v185 = l__EffectAssets__5.AfterTrail:Clone();
        table.insert(u182, v185);
        v185.Attachment0 = p177[v184[v183]][({ "LeftFootAttachment", "RightFootAttachment" })[v183]];
        local v186 = Instance.new("Attachment");
        v186.Parent = p177[v184[v183]];
        v186.Position = Vector3.new(0, -0.5, 0);
        game.Debris:AddItem(v186, p178 + 1);
        v185.Attachment1 = v186;
        v185.Parent = p177[v184[v183]];
        game.Debris:AddItem(v185, p178 + 1);
    end;
    for v187 = 1, 2 do
        local v188 = { "Left Arm", "Right Arm" };
        local v189 = l__EffectAssets__5.AfterTrail:Clone();
        table.insert(u182, v189);
        v189.Attachment0 = p177[v188[v187]][({ "LeftGripAttachment", "RightGripAttachment" })[v187]];
        local v190 = Instance.new("Attachment");
        v190.Parent = p177[v188[v187]];
        v190.Position = Vector3.new(0, -0.5, 0);
        game.Debris:AddItem(v190, p178 + 1);
        v189.Attachment1 = v190;
        v189.Parent = p177[v188[v187]];
        game.Debris:AddItem(v189, p178 + 1);
    end;
    local v191 = l__EffectAssets__5.AfterTrail:Clone();
    table.insert(u182, v191);
    v191.Attachment0 = p177.Head.HairAttachment;
    local v192 = Instance.new("Attachment");
    v192.Parent = p177.Head;
    v192.Position = Vector3.new(0, 0.5, 0);
    game.Debris:AddItem(v192, p178 + 1);
    v191.Attachment1 = v192;
    v191.Parent = p177.Head;
    game.Debris:AddItem(v191, p178 + 1);
    task.delay(p178, function() --[[ Line: 1086 ]]
        -- upvalues: u182 (copy)
        for _, v193 in pairs(u182) do
            v193.Enabled = false;
        end;
    end);
end;
function u1._xf557facef9f7e17e(p194, p195) --[[ Line: 1094 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy)
    local v196 = l__EffectAssets__5.SuspendedIndicator:Clone();
    game.Debris:AddItem(v196, 1);
    v196.Position = p195;
    v196.Parent = l__Effects__9;
    p194:_x04f10495a3010e73(v196);
end;
function u1._xf6d6eeea88f469e0(_, p197) --[[ Line: 1102 ]]
    local v198 = Vector3.new(p197.X, 0, p197.Z);
    local l__Magnitude__39 = v198.Magnitude;
    local v199 = l__Magnitude__39 + math.abs(p197.Y);
    if v199 < 0.0001 then
        return Vector3.new(0, 0, 0);
    end;
    local v200 = l__Magnitude__39 / v199;
    local v201 = v200 ^ 2 / (v200 ^ 2 + (1 - v200) ^ 2);
    return ((l__Magnitude__39 > 0 and v198.Unit * (v199 * v201) or Vector3.new(0, 0, 0)) + Vector3.new(0, v199 * (1 - v201) * (p197.Y < 0 and -1 or 1), 0)).Unit;
end;
function u1._x5d70cb7dced04a93(u202) --[[ Line: 1119 ]]
    -- upvalues: l__EffectAssets__5 (copy), u2 (ref), u4 (ref), u5 (ref), u3 (ref), l__RunService__2 (copy)
    local function v205() --[[ Line: 1120 ]]
        -- upvalues: l__EffectAssets__5 (ref), u202 (copy)
        local v203 = l__EffectAssets__5.SlideSparks:Clone();
        v203.Parent = workspace.CurrentCamera;
        u202._x9cc3ff0e27dc9f58.SlideSparks = {
            model = v203,
            emitters = {},
            glow = {},
            connections = {}
        };
        for _, v204 in pairs(v203:GetDescendants()) do
            if v204:IsA("ParticleEmitter") then
                if v204.Name == "Sparks" then
                    table.insert(u202._x9cc3ff0e27dc9f58.SlideSparks.emitters, v204);
                else
                    table.insert(u202._x9cc3ff0e27dc9f58.SlideSparks.glow, v204);
                end;
            end;
        end;
    end;
    local function u219() --[[ Line: 1140 ]]
        -- upvalues: u2 (ref), u4 (ref), u5 (ref), u202 (copy), u3 (ref)
        local v206 = u2._xfd7cc994ccc60ad7.Magnitude > u4.SLIDESPARKS_THRESHOLD;
        local v207 = u5._x2e81009d5ce5fe43 <= u4.SLIDESPARKS_TIME_THRESHOLD;
        local v208 = u2._xfd7cc994ccc60ad7.Magnitude > u4.SLIDESPARKS_MAJOR_THRESHOLD and (u5._x3b8a76d53cd0b01a and u2._x9baf9bb47de1af88) and true or false;
        for _, v209 in pairs(u202._x9cc3ff0e27dc9f58.SlideSparks.glow) do
            v209.Enabled = v208;
        end;
        local function v214(p210) --[[ Line: 1155 ]]
            -- upvalues: u202 (ref)
            for _, v211 in pairs(u202._x9cc3ff0e27dc9f58.SlideSparks.emitters) do
                for v212, v213 in pairs(p210) do
                    v211[v212] = v213;
                end;
            end;
        end;
        local l__SlideSparks__40 = u202._x9cc3ff0e27dc9f58.SlideSparks;
        local l__model__41 = l__SlideSparks__40.model;
        local _ = l__SlideSparks__40.emitters[1];
        local v215 = RaycastParams.new();
        v215.RespectCanCollide = true;
        v215.FilterDescendantsInstances = { workspace.CurrentCamera, u2._x7c0477cd83a7fb82 };
        v215.FilterType = Enum.RaycastFilterType.Exclude;
        local v216 = workspace:Raycast(u2._xde8b8f659627fa3f.Position, u2._xde8b8f659627fa3f.CFrame.UpVector * -3.3, v215);
        if v216 then
            local l__Position__42 = v216.Position;
            l__model__41.CFrame = CFrame.lookAt(l__Position__42 + u2._xfd7cc994ccc60ad7.Unit * u4.SLIDESPARKS_DISTANCE, l__Position__42);
        end;
        if v206 and (u2._x9baf9bb47de1af88 and u5._x3b8a76d53cd0b01a) or v207 and (u2._x9baf9bb47de1af88 and u5._x3b8a76d53cd0b01a) then
            local v217 = {
                Enabled = true,
                Rate = u3:convNumRange(math.clamp(u2._xfd7cc994ccc60ad7.Magnitude, 0, u4.SLIDESPARKS_UPPER_BOUND), 0, u4.SLIDESPARKS_UPPER_BOUND, 0, u4.SLIDESPARKS_RATE)
            };
            local v218;
            if u2._xfd7cc994ccc60ad7.Magnitude > 0.001 then
                v218 = NumberRange.new(u2._xfd7cc994ccc60ad7.Magnitude / u4.SLIDESPARKS_SPEED_DIVISOR);
            else
                v218 = NumberRange.new(0.001);
            end;
            v217.Speed = v218;
            v214(v217);
        else
            v214({
                Rate = 0
            });
        end;
    end;
    if not u202._x9cc3ff0e27dc9f58.SlideSparks then
        v205();
    end;
    table.insert(u202._x9cc3ff0e27dc9f58.SlideSparks.connections, l__RunService__2.RenderStepped:Connect(function() --[[ Line: 1209 ]]
        -- upvalues: u219 (copy)
        u219();
    end));
end;
function u1._x5806c0071ac89edb(p220, p221, p222) --[[ Line: 1214 ]]
    -- upvalues: u3 (ref), l__EffectAssets__5 (copy), l__Effects__9 (copy)
    local v223 = u3:getLikelyVec3(p221);
    local v224 = u3:getLikelyVec3(p222);
    local v225 = l__EffectAssets__5.CastigateFlash:Clone();
    v225.CFrame = CFrame.lookAt(v223, v224);
    v225.Parent = l__Effects__9;
    game.Debris:AddItem(v225, 2);
    p220:_x04f10495a3010e73(v225);
end;
function u1._xce257a006afdcb1d(u226, u227) --[[ Line: 1226 ]]
    -- upvalues: l__UIAssets__4 (copy), l__TweenService__1 (copy), l__RunService__2 (copy), l__Classes__3 (copy)
    local l__Lighting__43 = game:GetService("Lighting");
    local u228 = Instance.new("ColorCorrectionEffect");
    u228.Saturation = -1;
    u228.Parent = l__Lighting__43;
    game.Debris:AddItem(u228, u227);
    local v229 = {};
    local v230 = Instance.new("NumberValue");
    v230.Value = -4;
    v229.value = v230;
    v229.cancel_when_zero = true;
    local u231 = l__UIAssets__4.Destabilized:Clone();
    u231.Parent = u226._xf27c081d7e69cea6;
    game.Debris:AddItem(u231, u227);
    local u232 = os.clock();
    local u233 = Random.new();
    u231.Rotation = ({ -10, 10 })[math.random(1, 2)];
    l__TweenService__1:Create(u231, TweenInfo.new(u227 / 4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        Rotation = 0
    }):Play();
    u231.Size = UDim2.fromScale(0.87, 0.87);
    l__TweenService__1:Create(u231, TweenInfo.new(u227), {
        Size = UDim2.fromScale(0.75, 0.75)
    }):Play();
    local u234 = 0;
    l__TweenService__1:Create(u231.Rotator, TweenInfo.new(u227, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Rotation = 2000
    }):Play();
    local u248 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 1257 ]]
        -- upvalues: u231 (copy), u232 (copy), u227 (copy), l__Classes__3 (ref), l__TweenService__1 (ref), u234 (ref), u233 (copy)
        if u231 and u231.Parent ~= nil then
            local v235 = os.clock() - u232;
            local v236 = math.clamp(v235, 0, u227);
            local v237 = l__Classes__3.Util:convNumRange(v236, 0, u227, 0, 1);
            local v238 = Color3.fromRGB(255, 0, 0):Lerp(Color3.fromRGB(255, 255, 255), l__TweenService__1:GetValue(v237, Enum.EasingStyle.Sine, Enum.EasingDirection.In));
            local v239 = l__TweenService__1:GetValue(l__TweenService__1:GetValue(v237, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), Enum.EasingStyle.Exponential, Enum.EasingDirection.In);
            local v240 = math.floor(v236);
            l__Classes__3._x6a15bbeeb97caae0._x150106ccf5e1fa00.Enabled = false;
            if v240 ~= u234 then
                u234 = v240;
                u231.Timer.Size = UDim2.fromScale(0.18, 0.18);
                l__TweenService__1:Create(u231.Timer, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(0.16, 0.16)
                }):Play();
                local v241 = u231.Timer:Clone();
                v241.Second:Destroy();
                v241.Milisecond:Destroy();
                v241.Name = "pulse";
                v241.Parent = u231;
                v241.Size = UDim2.fromScale(0.16, 0.16);
                v241.UIStroke.Thickness = 10;
                l__TweenService__1:Create(v241.UIStroke, TweenInfo.new(0.5), {
                    Thickness = 0
                }):Play();
                l__TweenService__1:Create(v241, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(1, 1)
                }):Play();
                l__TweenService__1:Create(v241.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
                game.Debris:AddItem(v241, 0.45);
                l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("TICK", true);
            end;
            local v242 = math.fmod(v236, 1);
            u231.Timer.Second.Text = u227 - u234 - 1;
            local l__Milisecond__44 = u231.Timer.Milisecond;
            local v243 = tostring(1 - v242);
            l__Milisecond__44.Text = string.sub(v243, 2, 4);
            for _, v244 in u231:GetDescendants() do
                if v244:IsA("TextLabel") then
                    v244.TextColor3 = v238;
                    v244.TextTransparency = v239;
                elseif v244:IsA("ImageLabel") then
                    v244.ImageColor3 = v238;
                    v244.ImageTransparency = v239;
                elseif v244:IsA("UIStroke") then
                    v244.Color = v238;
                    v244.Transparency = v239;
                end;
            end;
            local l__Cautions__45 = u231.Cautions;
            local l__fromScale__46 = UDim2.fromScale;
            local v245 = l__Classes__3.Util:numLerp(0.1, 0.01, l__TweenService__1:GetValue(v237, Enum.EasingStyle.Quint, Enum.EasingDirection.Out));
            local v246 = 0.8 + u233:NextNumber(-v245, v245);
            local v247 = l__Classes__3.Util:numLerp(0.1, 0.01, l__TweenService__1:GetValue(v237, Enum.EasingStyle.Quint, Enum.EasingDirection.Out));
            l__Cautions__45.Size = l__fromScale__46(v246, 0.8 + u233:NextNumber(-v247, v247));
        end;
    end);
    local u249 = nil;
    local function u251(p250) --[[ Line: 1315 ]]
        -- upvalues: u249 (ref), u228 (copy), u248 (ref), u226 (copy), l__Classes__3 (ref), u231 (copy)
        if u249 then
            task.cancel(u249);
        end;
        if u228 then
            u228:Destroy();
        end;
        if u248 then
            u226:_x163724fe4f12c8e4(game:GetService("Lighting"), 2, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)):Play();
            if not p250 and l__Classes__3._x8399b2bb73e12808._x69155c6c2c2143d0 == "alive" then
                l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("DING_ON", true);
                l__Classes__3._x6a15bbeeb97caae0._x150106ccf5e1fa00.Enabled = true;
            end;
            u248:Disconnect();
            u248 = nil;
        end;
        if u231 then
            u231:Destroy();
        end;
    end;
    u249 = task.delay(u227, function() --[[ Line: 1338 ]]
        -- upvalues: u249 (ref), u251 (copy)
        u249 = nil;
        u251();
    end);
    l__Classes__3._xdca80115d2839102:_x145395062c6646e5(v229);
    l__TweenService__1:Create(v230, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
    return u251;
end;
function u1._xad3a6ea0d9608f02(p252, p253, p254) --[[ Line: 1350 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), u3 (ref)
    local v255 = l__EffectAssets__5.SlashCrescent:Clone();
    game.Debris:AddItem(v255, 1.5);
    v255.Parent = l__Effects__9;
    local v256 = u3:getLikelyVec3(p253);
    local v257 = u3:getLikelyVec3(p254);
    v255.CFrame = CFrame.lookAt(v256, v257);
    p252:_x04f10495a3010e73(v255);
end;
function u1._xfabe666517c3f63c(p258, p259, u260) --[[ Line: 1362 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), l__RunService__2 (copy)
    local u261 = l__EffectAssets__5.SlashCrescent:Clone();
    game.Debris:AddItem(u261, 1.5);
    u261.Parent = l__Effects__9;
    u261.CFrame = CFrame.lookAt((p259.Position + u260.CFrame.Position) / 2, u260.CFrame.Position + Vector3.new(0, -2, 0));
    local u262 = u260.CFrame:toObjectSpace(u261.CFrame);
    local u263 = l__RunService__2.RenderStepped:Connect(function() --[[ Line: 1373 ]]
        -- upvalues: u261 (copy), u260 (copy), u262 (copy)
        u261.CFrame = u260.CFrame:toWorldSpace(u262);
    end);
    task.delay(0.2, function() --[[ Line: 1377 ]]
        -- upvalues: u263 (copy)
        u263:Disconnect();
    end);
    p258:_x04f10495a3010e73(u261);
end;
function u1._xbb97cdf6931fca17(p264) --[[ Line: 1385 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local v265 = l__EffectAssets__5.CastigateFlash:Clone();
    local v266 = l__Classes__3._xdca80115d2839102:_x061224a5e52c670b();
    local l__WorldPosition__47 = l__Classes__3._x8613500a592ecb35:_x743a226b34a5008a("gun")._x7038c762990d3b99.WorldPosition;
    v265.CFrame = CFrame.lookAt(l__WorldPosition__47 + v266 * 2, l__WorldPosition__47 + v266 * 10);
    v265.Parent = l__Effects__9;
    game.Debris:AddItem(v265, 2);
    p264:_x04f10495a3010e73(v265);
    local l__Lighting__48 = game:GetService("Lighting");
    local v267 = Instance.new("ColorCorrectionEffect");
    v267.Contrast = 1;
    v267.Saturation = -1;
    v267.Parent = l__Lighting__48;
    game.Debris:AddItem(v267, 1);
    l__TweenService__1:Create(v267, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Contrast = 0
    }):Play();
    l__TweenService__1:Create(v267, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    p264:_x163724fe4f12c8e4(l__Lighting__48, -1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)):Play();
end;
function u1._x5d7bcba478aaa140(p268, p269) --[[ Line: 1408 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local v270 = l__EffectAssets__5.SiegeFlash:Clone();
    local v271 = l__Classes__3._xdca80115d2839102:_x061224a5e52c670b();
    v270.CFrame = CFrame.lookAt(p269, p269 + v271 * 10);
    v270.Parent = l__Effects__9;
    game.Debris:AddItem(v270, 2);
    local v272 = l__Classes__3.Util:getBasicRaycastParams();
    for _ = 1, 10 do
        local v273 = l__EffectAssets__5.SiegeTracer:Clone();
        v273.Parent = l__Effects__9;
        local v274 = l__Classes__3.Util:randomizeUnitVectorGaussian(v271, 20);
        v273.CFrame = CFrame.lookAt(p269, p269 + v274);
        p268:_x04f10495a3010e73(v273);
        local v275 = workspace:Raycast(p269, v274 * 70, v272);
        if v275 then
            p268:_x5bb526f0ccbf12ab(v275.Position + v275.Normal * 0.1, v275.Position + v275.Normal);
        end;
        game.Debris:AddItem(v273, 2);
    end;
    p268:_x04f10495a3010e73(v270);
    local l__Lighting__49 = game:GetService("Lighting");
    local v276 = Instance.new("ColorCorrectionEffect");
    v276.Contrast = 1;
    v276.Saturation = -1;
    v276.Parent = l__Lighting__49;
    game.Debris:AddItem(v276, 1);
    l__TweenService__1:Create(v276, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Contrast = 0
    }):Play();
    l__TweenService__1:Create(v276, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    p268:_x163724fe4f12c8e4(l__Lighting__49, -1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)):Play();
end;
function u1._x0ecff6e8f0a4fac9(p277, p278, p279) --[[ Line: 1451 ]]
    -- upvalues: u3 (ref), l__EffectAssets__5 (copy), l__Effects__9 (copy), l__Classes__3 (copy)
    local v280 = u3:getLikelyVec3(p278);
    local v281 = u3:getLikelyVec3(p279);
    local v282 = l__EffectAssets__5.SiegeFlashOutsider:Clone();
    v282.CFrame = CFrame.lookAt(v280, v281);
    v282.Parent = l__Effects__9;
    game.Debris:AddItem(v282, 2);
    l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("SIEGE_BONUS_SHOT", true, {
        location = p278
    });
    p277:_x04f10495a3010e73(v282);
end;
function u1._x7ab28b2f765cfbf2(p283, p284, p285) --[[ Line: 1465 ]]
    -- upvalues: u3 (ref), l__EffectAssets__5 (copy), l__Effects__9 (copy), l__Classes__3 (copy)
    local v286 = u3:getLikelyVec3(p284);
    local v287 = u3:getLikelyVec3(p285);
    local v288 = l__EffectAssets__5.PhoenixFlash:Clone();
    v288.CFrame = CFrame.lookAt(v286, v287);
    v288.Parent = l__Effects__9;
    game.Debris:AddItem(v288, 2);
    l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("PHOENIX_SHOT", true, {
        location = p284
    });
    p283:_x04f10495a3010e73(v288);
end;
function u1._x11dda911a925bca1(p289, p290) --[[ Line: 1479 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local v291 = l__EffectAssets__5.PhoenixFlash:Clone();
    local v292 = l__Classes__3._xdca80115d2839102:_x061224a5e52c670b();
    v291.CFrame = CFrame.lookAt(p290 + v292 * 2, p290 + v292 * 10);
    v291.Parent = l__Effects__9;
    game.Debris:AddItem(v291, 2);
    if math.random() <= 0.0001 then
        l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("EAGLE", true);
        local v293 = l__EffectAssets__5.eagle:Clone();
        v293.Parent = p289._xf27c081d7e69cea6;
        game.Debris:AddItem(v293, 4.1);
        l__TweenService__1:Create(v293, TweenInfo.new(4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
    end;
    for _, v294 in pairs(v291:GetDescendants()) do
        if v294:IsA("ParticleEmitter") then
            v294:Emit(v294:GetAttribute("EmitCount"));
        end;
    end;
    local l__Lighting__50 = game:GetService("Lighting");
    local v295 = Instance.new("ColorCorrectionEffect");
    v295.Contrast = 1;
    v295.Saturation = -1;
    v295.Parent = l__Lighting__50;
    game.Debris:AddItem(v295, 1);
    l__TweenService__1:Create(v295, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Contrast = 0
    }):Play();
    l__TweenService__1:Create(v295, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    p289:_x163724fe4f12c8e4(l__Lighting__50, -2.7, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)):Play();
end;
function u1._x7a30dd20a0ca54cb(p296, p297, u298, u299, u300, p301) --[[ Line: 1517 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__TweenService__1 (copy), l__Classes__3 (copy), u3 (ref), l__RunService__2 (copy), l__Effects__9 (copy)
    local u302 = nil;
    local u303, v304;
    if typeof(u299) == "Vector3" or not u299:IsA("Part") then
        u303 = nil;
        v304 = nil;
    else
        u303 = u299;
        u299 = u303.Position;
        v304 = true;
    end;
    local v305 = l__EffectAssets__5.BulletTracer:Clone();
    local u306 = p301 or 0.3;
    local u307 = u300 and 1 or u306;
    game.Debris:AddItem(v305, u307);
    local l__Destination__51 = v305.Destination;
    local l__Gunpoint__52 = v305.Gunpoint;
    local l__Point__53 = l__Gunpoint__52.Point;
    local _ = l__Destination__51.End;
    local l__Beam__54 = l__Point__53.Beam;
    local l__Trail__55 = l__Point__53.Trail;
    local l__Progress__56 = l__Beam__54.Progress;
    l__TweenService__1:Create(l__Progress__56, TweenInfo.new(u307), {
        Value = u307
    }):Play();
    local v308 = RaycastParams.new();
    v308.FilterType = Enum.RaycastFilterType.Include;
    v308.FilterDescendantsInstances = { workspace.Map };
    local l__Unit__57 = (u299 - u298).Unit;
    local l__Magnitude__58 = (u299 - u298).Magnitude;
    local v309 = workspace:Raycast(u298, l__Unit__57 * l__Magnitude__58, v308);
    if v309 and (v309.Instance:IsA("BasePart") and (v309.Instance.Transparency ~= 1 and (v309.Instance.CanCollide == true and (v309.Position - u299).Magnitude > 1))) then
        local l__Position__59 = v309.Position;
        p296:_x34f9c195793f724d(l__Position__59, l__Position__59 + v309.Normal);
        l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("PROJ_BREAK", true, {
            location = l__Position__59
        });
        local v310 = workspace:Raycast(u299, -l__Unit__57 * l__Magnitude__58, v308);
        if v310 then
            local l__Position__60 = v310.Position;
            p296:_x34f9c195793f724d(l__Position__60, l__Position__60 + v310.Normal);
            l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("PROJ_BREAK", true, {
                location = l__Position__60
            });
        end;
    end;
    l__Progress__56.Changed:Connect(function(p311) --[[ Line: 1579 ]]
        -- upvalues: u306 (copy), l__Beam__54 (copy), u3 (ref), u300 (copy), l__Trail__55 (copy), u307 (copy)
        if u306 <= p311 then
            l__Beam__54.Enabled = false;
        end;
        local v312 = u3:convNumRange(p311, 0, u306, -4, 5);
        local v313 = v312 - 2 - 0.01;
        local v314 = v312 + 2 + 0.01;
        local v315 = math.clamp(v313, 0.02, 0.98);
        local v316 = math.clamp(v314, 0.02, 0.98);
        local v317 = (v315 + v316) / 2;
        l__Beam__54.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(v315, 1),
            NumberSequenceKeypoint.new((v315 + v317) * 0.5, 0),
            NumberSequenceKeypoint.new(v317, 0),
            NumberSequenceKeypoint.new((v316 + v317) * 0.5, 0),
            NumberSequenceKeypoint.new(v316, 1),
            NumberSequenceKeypoint.new(1, 1)
        });
        if u300 then
            l__Trail__55.Enabled = true;
            l__Trail__55.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.9, u3:convNumRange(p311, 0, u307, 0.7, 1)), NumberSequenceKeypoint.new(1, 1) });
            local v318 = u3:convNumRange(p311, 0, 1, 0.1, 1);
            l__Trail__55.Width0 = v318;
            l__Trail__55.Width1 = v318;
        end;
    end);
    l__Gunpoint__52.CFrame = CFrame.lookAt(u298, u298 + p297 * 10);
    if v304 then
        u302 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 1622 ]]
            -- upvalues: u303 (ref), u299 (ref), l__Destination__51 (copy), u298 (copy), u302 (ref)
            if u303 then
                if u303.Name == "Head_Hurtbox" then
                    u299 = u303.Position - Vector3.new(0, 0.5, 0);
                else
                    u299 = u303.Position;
                end;
                l__Destination__51.CFrame = CFrame.lookAt(u299, u298);
            else
                u302:Disconnect();
            end;
        end);
    else
        l__Destination__51.CFrame = CFrame.lookAt(u299, u298);
    end;
    task.delay(u306, function() --[[ Line: 1638 ]]
        -- upvalues: u302 (ref)
        if u302 then
            u302:Disconnect();
        end;
    end);
    l__Beam__54.CurveSize0 = 0;
    l__Beam__54.CurveSize1 = 0;
    v305.Parent = l__Effects__9;
end;
function u1._x888d33c3a14b8d1c(p319, p320) --[[ Line: 1650 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local u321 = l__EffectAssets__5.ParryIndicator:Clone();
    local v322 = Instance.new("Weld");
    u321.Position = l__Classes__3.Util:getLikelyVec3(p320);
    v322.Part1 = u321;
    v322.Part0 = p320:FindFirstChild("Torso");
    v322.Parent = u321;
    u321.Parent = l__Effects__9;
    local v323 = Instance.new("Highlight");
    v323.FillTransparency = 1;
    v323.OutlineTransparency = 0;
    v323.OutlineColor = Color3.fromRGB(255, 255, 255);
    v323.DepthMode = Enum.HighlightDepthMode.Occluded;
    v323.Parent = p320;
    local u324 = p320:GetPropertyChangedSignal("Parent"):Once(function() --[[ Line: 1667 ]]
        -- upvalues: u321 (copy)
        if u321 then
            u321:Destroy();
        end;
    end);
    task.delay(1, function() --[[ Line: 1673 ]]
        -- upvalues: u324 (ref)
        if u324 then
            u324:Disconnect();
            u324 = nil;
        end;
    end);
    l__TweenService__1:Create(v323, TweenInfo.new(0.8, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        OutlineTransparency = 1
    }):Play();
    game.Debris:AddItem(u321, 1);
    game.Debris:AddItem(v323, 1);
    p319:_x04f10495a3010e73(u321);
end;
function u1._x04bf66bbcebdcaaf(p325, u326, p327) --[[ Line: 1688 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Promise__6 (copy)
    local v328 = p327 or {};
    local l__RunService__61 = game:GetService("RunService");
    local l__TweenService__62 = game:GetService("TweenService");
    local l__CurrentCamera__63 = workspace.CurrentCamera;
    local u329 = l__EffectAssets__5.BoxHighlight:Clone();
    u329.Parent = p325._xf27c081d7e69cea6;
    local v330 = Color3.new(1, 1, 1);
    local v331 = v328.color or v330;
    u329.BackgroundColor3 = v331;
    local u332 = u329:FindFirstChildOfClass("UIStroke");
    if u332 then
        u332.Color = v331;
    end;
    local u333 = v328.size_offset or 0;
    local l__duration__64 = v328.duration;
    local u334 = v328.requires_los == true;
    if v328.transparency then
        u329.BackgroundTransparency = v328.transparency;
    end;
    local u335 = false;
    local u336 = nil;
    local u337 = nil;
    local u338 = nil;
    local u339 = tick();
    local function u340() --[[ Line: 1721 ]]
        -- upvalues: u335 (ref), u336 (ref), u337 (ref), u338 (ref), u329 (copy)
        if u335 then
        else
            u335 = true;
            if u336 then
                u336:Disconnect();
                u336 = nil;
            end;
            if u337 then
                pcall(function() --[[ Line: 1733 ]]
                    -- upvalues: u337 (ref)
                    u337:Cancel();
                end);
                u337 = nil;
            end;
            if u338 then
                pcall(function() --[[ Line: 1740 ]]
                    -- upvalues: u338 (ref)
                    u338:Cancel();
                end);
                u338 = nil;
            end;
            if u329 then
                u329:Destroy();
            end;
        end;
    end;
    local function u344(p341) --[[ Line: 1751 ]]
        if not p341 then
            return {};
        end;
        if p341:IsA("BasePart") then
            return math.max(p341.Transparency, p341.LocalTransparencyModifier or 0) >= 1 and {} or { p341 };
        end;
        local v342 = {};
        for _, v343 in ipairs(p341:GetDescendants()) do
            if v343:IsA("BasePart") and math.max(v343.Transparency, v343.LocalTransparencyModifier or 0) < 1 then
                v342[#v342 + 1] = v343;
            end;
        end;
        return v342;
    end;
    local function u357(p345) --[[ Line: 1776 ]]
        -- upvalues: l__CurrentCamera__63 (copy)
        local v346 = (1 / 0);
        local v347 = (1 / 0);
        local v348 = (-1 / 0);
        local v349 = (-1 / 0);
        local v350 = false;
        for _, v351 in ipairs(p345) do
            local v352 = v351.Size * 0.5;
            local l__CFrame__65 = v351.CFrame;
            local v353 = {
                Vector3.new(v352.X, v352.Y, v352.Z),
                Vector3.new(v352.X, v352.Y, -v352.Z),
                Vector3.new(v352.X, -v352.Y, v352.Z),
                Vector3.new(v352.X, -v352.Y, -v352.Z),
                Vector3.new(-v352.X, v352.Y, v352.Z),
                Vector3.new(-v352.X, v352.Y, -v352.Z),
                Vector3.new(-v352.X, -v352.Y, v352.Z),
                (Vector3.new(-v352.X, -v352.Y, -v352.Z))
            };
            for _, v354 in ipairs(v353) do
                local v355, v356 = l__CurrentCamera__63:WorldToViewportPoint((l__CFrame__65 * CFrame.new(v354)).Position);
                v346 = math.min(v346, v355.X);
                v347 = math.min(v347, v355.Y);
                v348 = math.max(v348, v355.X);
                v349 = math.max(v349, v355.Y);
                if v356 and v355.Z > 0 then
                    v350 = true;
                end;
            end;
        end;
        if v350 then
            return v346, v347, v348, v349;
        else
            return nil;
        end;
    end;
    local function u361(p358) --[[ Line: 1818 ]]
        -- upvalues: u337 (ref), l__TweenService__62 (copy), u329 (copy), u332 (copy), u338 (ref), u340 (copy)
        if u337 then
        else
            local v359 = math.max(0.001, p358 or 1);
            local v360 = TweenInfo.new(v359, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            u337 = l__TweenService__62:Create(u329, v360, {
                BackgroundTransparency = 1
            });
            u337:Play();
            if u332 then
                u338 = l__TweenService__62:Create(u332, v360, {
                    Transparency = 1
                });
                u338:Play();
            end;
            u337.Completed:Once(u340);
        end;
    end;
    u336 = l__RunService__61.RenderStepped:Connect(function() --[[ Line: 1841 ]]
        -- upvalues: u326 (copy), u340 (copy), l__duration__64 (copy), u339 (copy), u361 (copy), u334 (copy), l__Classes__3 (ref), l__CurrentCamera__63 (copy), u329 (copy), u344 (copy), u357 (copy), u333 (copy)
        if u326 and u326.Parent then
            if l__duration__64 then
                local v362 = tick() - u339;
                if l__duration__64 <= v362 then
                    u340();
                    return;
                end;
                if math.max(0, l__duration__64 - 1) <= v362 then
                    u361(l__duration__64 - v362);
                end;
            end;
            if u334 then
                local v363 = l__Classes__3.Util:getLikelyVec3(u326);
                if not (v363 and l__Classes__3.Util:hasLineOfSight(l__CurrentCamera__63.CFrame.Position, v363)) then
                    u329.Visible = false;
                    return;
                end;
            end;
            local v364 = u344(u326);
            if #v364 == 0 then
                u329.Visible = false;
            else
                local v365, v366, v367, v368 = u357(v364);
                if v365 then
                    local l__ViewportSize__66 = l__CurrentCamera__63.ViewportSize;
                    local v369 = u333 * l__ViewportSize__66.X;
                    local v370 = u333 * l__ViewportSize__66.Y;
                    local v371 = v365 - v369 * 0.5;
                    local v372 = v367 + v369 * 0.5;
                    local v373 = v366 - v370 * 0.5;
                    local v374 = v368 + v370 * 0.5;
                    local v375 = math.max(1, v372 - v371);
                    local v376 = math.max(1, v374 - v373);
                    u329.AnchorPoint = Vector2.new(0, 0);
                    u329.Position = UDim2.new(0, v371, 0, v373);
                    u329.Size = UDim2.new(0, v375, 0, v376);
                    u329.Visible = true;
                else
                    u329.Visible = false;
                end;
            end;
        else
            u340();
        end;
    end);
    local v379 = l__Promise__6.new(function(u377, _, p378) --[[ Line: 1897 ]]
        -- upvalues: u340 (copy)
        if type(p378) == "function" then
            p378(function() --[[ Line: 1899 ]]
                -- upvalues: u340 (ref), u377 (copy)
                u340();
                u377();
            end);
        end;
    end);
    if type(v379.cancel) == "function" then
        local l__cancel__67 = v379.cancel;
        function v379.cancel(...) --[[ Line: 1908 ]]
            -- upvalues: u340 (copy), l__cancel__67 (copy)
            u340();
            return l__cancel__67(...);
        end;
    else
        v379.cancel = u340;
    end;
    return v379;
end;
function u1._x565d6153177a12b9(u380, u381, u382, p383) --[[ Line: 1919 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__Promise__6 (copy), l__RunService__2 (copy), l__TweenService__1 (copy)
    local u384 = l__EffectAssets__5.BrokenIndicator:Clone();
    u384.Position = l__Classes__3.Util:getLikelyVec3(u381);
    local v385 = Instance.new("Weld");
    v385.Part1 = u384;
    v385.Part0 = u381:FindFirstChild("HumanoidRootPart");
    v385.Parent = u384;
    u384.Parent = l__Effects__9;
    u381:GetPropertyChangedSignal("Parent"):Once(function() --[[ Line: 1929 ]]
        -- upvalues: u384 (copy)
        if u384 then
            u384:Destroy();
        end;
    end);
    if p383 then
        for _, v386 in u381:GetChildren() do
            if v386:IsA("Highlight") then
                v386:Destroy();
            end;
        end;
        l__Promise__6.defer(function() --[[ Line: 1942 ]]
            -- upvalues: u381 (copy), l__EffectAssets__5 (ref), u380 (copy), l__RunService__2 (ref), l__Classes__3 (ref), u382 (copy), l__TweenService__1 (ref)
            local u387 = Instance.new("Highlight");
            u387.FillTransparency = 0;
            u387.OutlineTransparency = 1;
            u387.FillColor = Color3.fromRGB(255, 0, 0);
            u387.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
            u387.Parent = u381;
            local u388 = Random.new();
            local u389 = os.clock();
            local u390 = l__EffectAssets__5.Tracer:Clone();
            u390.AnchorPoint = Vector2.new(0.5, 0.5);
            u390.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
            u390.BorderSizePixel = 0;
            u390.Parent = u380._xf27c081d7e69cea6;
            local u391 = nil;
            local l__CurrentCamera__68 = workspace.CurrentCamera;
            u391 = l__RunService__2.RenderStepped:Connect(function() --[[ Line: 1974 ]]
                -- upvalues: u387 (copy), u381 (ref), u391 (ref), u390 (copy), u389 (copy), l__Classes__3 (ref), u382 (ref), l__TweenService__1 (ref), u388 (copy), l__CurrentCamera__68 (copy)
                if u387 and (u381 and u381.Parent == workspace.Entities) then
                    local v392 = os.clock() - u389;
                    local v393 = l__Classes__3.Util:convNumRange(v392, 0, u382, 0, 1);
                    if v393 >= 1 then
                        if u391 then
                            u391:Disconnect();
                        end;
                        if u387 then
                            u387:Destroy();
                        end;
                        if u390 then
                            u390:Destroy();
                        end;
                    else
                        u387.FillTransparency = l__TweenService__1:GetValue(v393, Enum.EasingStyle.Exponential, Enum.EasingDirection.In) + u388:NextNumber(-0.25, 0.25);
                        local v394 = l__Classes__3._xdca80115d2839102:_x2166a83ba03aeba4();
                        local v395 = Vector2.new(v394.X.Offset, v394.Y.Offset);
                        local v396 = l__Classes__3.Util:getLikelyVec3(u381);
                        local v397, v398 = l__CurrentCamera__68:WorldToViewportPoint(v396);
                        local v399;
                        if v398 then
                            v399 = Vector2.new(v397.X, v397.Y);
                        else
                            local v400 = Vector2.new(v397.X - v395.X, v397.Y - v395.Y);
                            if v397.Z < 0 then
                                v400 = -v400;
                            end;
                            if v400.Magnitude == 0 then
                                v400 = Vector2.new(0, -1);
                            end;
                            local l__ViewportSize__69 = l__CurrentCamera__68.ViewportSize;
                            local v401 = math.abs(((v400.X > 0 and (l__ViewportSize__69.X - 1 or 1) or 1) - v395.X) / v400.X);
                            local v402 = math.abs(((v400.Y > 0 and l__ViewportSize__69.Y - 1 or 1) - v395.Y) / v400.Y);
                            v399 = v395 + v400 * math.min(v401, v402);
                        end;
                        local v403 = v399 - v395;
                        local l__Magnitude__70 = v403.Magnitude;
                        local v404 = math.atan2(v403.Y, v403.X);
                        u390.Size = UDim2.new(0, l__Magnitude__70, 0, 1);
                        u390.Position = UDim2.fromOffset((v395.X + v399.X) / 2, (v395.Y + v399.Y) / 2);
                        u390.Rotation = math.deg(v404);
                        u390.BackgroundTransparency = u387.FillTransparency;
                        local _ = (v396 - workspace.CurrentCamera.CFrame.Position).Magnitude;
                    end;
                else
                    if u391 then
                        u391:Disconnect();
                    end;
                    if u387 then
                        u387:Destroy();
                    end;
                    if u390 then
                        u390:Destroy();
                    end;
                end;
            end);
            game.Debris:AddItem(u387, u382);
        end);
    end;
    for _, u405 in u384:GetChildren() do
        if u405:IsA("ParticleEmitter") then
            u405.Enabled = true;
            task.delay(u382, function() --[[ Line: 2041 ]]
                -- upvalues: u405 (copy)
                if u405 then
                    u405.Enabled = false;
                end;
            end);
        end;
    end;
    u380:_x04f10495a3010e73(u384);
    game.Debris:AddItem(u384, u382);
end;
function u1._x93dad7f4849973ba(p406) --[[ Line: 2053 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local l__LookVector__71 = workspace.CurrentCamera.CFrame.LookVector;
    local l__Position__72 = workspace.CurrentCamera.CFrame.Position;
    local v407 = CFrame.lookAt(l__Position__72 + l__LookVector__71 * 10, l__Position__72 + l__LookVector__71 * 20);
    local v408 = l__EffectAssets__5.ClashLocal:Clone();
    game.Debris:AddItem(v408, 1);
    v408.CFrame = v407;
    v408.Parent = l__Effects__9;
    p406:_x04f10495a3010e73(v408);
    local l__Lighting__73 = game:GetService("Lighting");
    local v409 = Instance.new("ColorCorrectionEffect");
    v409.Contrast = 1;
    v409.Saturation = -1;
    v409.Parent = l__Lighting__73;
    game.Debris:AddItem(v409, 1);
    l__TweenService__1:Create(v409, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Contrast = 0
    }):Play();
    l__TweenService__1:Create(v409, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    p406:_x163724fe4f12c8e4(l__Lighting__73, -0.3, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)):Play();
end;
local function u413(p410, p411) --[[ Line: 2075 ]]
    local v412 = {};
    while p411 and p411 ~= p410 do
        table.insert(v412, 1, p411.Name .. "|" .. p411.ClassName);
        p411 = p411.Parent;
    end;
    return table.concat(v412, "/");
end;
function u1._x83d926971fa92a51(_, u414, p415) --[[ Line: 2087 ]]
    -- upvalues: l__Effects__9 (copy), l__Promise__6 (copy), u413 (copy), l__RunService__2 (copy)
    local v416 = p415 or {};
    local v417 = l__Effects__9;
    local v418 = v416.fillColor or Color3.fromRGB(255, 255, 255);
    local v419 = v416.outlineColor or Color3.fromRGB(0, 0, 0);
    local v420 = v416.fillTransparency == nil and 0.5 or (v416.fillTransparency or 0.5);
    local v421 = v416.outlineTransparency == nil and 0 or (v416.outlineTransparency or 0);
    local v422 = v416.depthMode or Enum.HighlightDepthMode.AlwaysOnTop;
    local v423;
    if u414 then
        v423 = u414:IsA("Instance");
    else
        v423 = u414;
    end;
    assert(v423, "cloneForHighlight: target must be an Instance");
    u414.Archivable = true;
    local u424 = u414:Clone();
    u424.Name = u414.Name .. "_HighlightClone";
    u424.Parent = v417;
    for _, u425 in ipairs(u424:GetDescendants()) do
        if u425:IsA("BasePart") and u425.Transparency ~= 1 then
            l__Promise__6.defer(function() --[[ Line: 2108 ]]
                -- upvalues: u425 (copy)
                u425.Anchored = true;
                u425.CanCollide = false;
                u425.CanTouch = false;
                u425.CanQuery = false;
                u425.Transparency = 0.999;
                u425.CastShadow = false;
                u425.CollisionGroup = "Entities";
            end);
        elseif not (u425:IsA("Humanoid") or u425:IsA("SpecialMesh")) then
            u425:Destroy();
        end;
    end;
    if u424:IsA("BasePart") then
        u424.Anchored = true;
        u424.CanCollide = false;
        u424.CanTouch = false;
        u424.CanQuery = false;
        u424.Transparency = 1;
        u424.CastShadow = false;
    end;
    local u426 = {};
    local u427 = {};
    if u414:IsA("Model") or u414:IsA("Folder") then
        for _, v428 in ipairs(u414:GetDescendants()) do
            if v428:IsA("BasePart") then
                u426[u413(u414, v428)] = v428;
            end;
        end;
    end;
    if u424:IsA("Model") or u424:IsA("Folder") then
        for _, v429 in ipairs(u424:GetDescendants()) do
            if v429:IsA("BasePart") then
                u427[u413(u424, v429)] = v429;
            end;
        end;
    elseif u424:IsA("BasePart") then
        u427.root = u424;
    end;
    local u430 = Instance.new("Highlight");
    u430.Name = "CloneHighlight";
    u430.Adornee = u424;
    u430.FillColor = v418;
    u430.OutlineColor = v419;
    u430.FillTransparency = v420;
    u430.OutlineTransparency = v421;
    u430.DepthMode = v422;
    u430.Parent = u424;
    local u431 = true;
    local u432 = nil;
    u432 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 2167 ]]
        -- upvalues: u431 (ref), u414 (copy), u424 (copy), u432 (ref), u430 (copy), u426 (copy), u427 (copy)
        if u431 then
            if u414.Parent and u424.Parent then
                if u414:IsA("BasePart") and u424:IsA("BasePart") then
                    u424.CFrame = u414.CFrame;
                elseif u414:IsA("Model") and u424:IsA("Model") then
                    for v433, v434 in pairs(u426) do
                        local v435 = u427[v433];
                        if v435 and (v434 and v434.Parent) then
                            v435.CFrame = v434.CFrame;
                        end;
                    end;
                else
                    if u414:IsA("PVInstance") and u424:IsA("PVInstance") then
                        u424:PivotTo(u414:GetPivot());
                    end;
                end;
            else
                u431 = false;
                if u432 then
                    u432:Disconnect();
                end;
                if u430 then
                    u430:Destroy();
                end;
                if u424 then
                    u424:Destroy();
                end;
            end;
        end;
    end);
    return u424, u430, function() --[[ Name: cleanup, Line 2198 ]]
        -- upvalues: u431 (ref), u432 (ref), u430 (copy), u424 (copy)
        if u431 then
            u431 = false;
            if u432 then
                u432:Disconnect();
            end;
            if u430 then
                u430:Destroy();
            end;
            if u424 then
                u424:Destroy();
            end;
        end;
    end;
end;
function u1._x8a036b25effb834b(p436) --[[ Line: 2217 ]]
    -- upvalues: l__Classes__3 (copy), l__UIAssets__4 (copy), l__TweenService__1 (copy)
    l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("HUNTED_WARNING", true);
    if p436._xc7c0adbf641fc099 and p436._xc7c0adbf641fc099.Parent ~= nil then
        p436._xc7c0adbf641fc099:Destroy();
    end;
    local v437 = l__UIAssets__4.ReturnWarning:Clone();
    v437.Parent = p436._xf27c081d7e69cea6;
    l__TweenService__1:Create(v437.Left, TweenInfo.new(0.66, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(0, 1)
    }):Play();
    l__TweenService__1:Create(v437.Right, TweenInfo.new(0.66, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(0, 1)
    }):Play();
    p436._xc7c0adbf641fc099 = v437;
    local v438 = l__Classes__3._x6a15bbeeb97caae0:_x82a81ec01445cd97({
        header_text = "▪ [ RETURN TO COMBAT ] ▪",
        subheader_text = "A SNIPER IS ON YOU // PARRY THE BULLET",
        color = Color3.fromRGB(255, 49, 49)
    });
    v437.Destroying:Connect(v438);
    game.Debris:AddItem(v437, 20);
end;
function u1._xe78d720bbc03cd0e(p439) --[[ Line: 2243 ]]
    -- upvalues: l__Classes__3 (copy)
    if p439._xc7c0adbf641fc099 and p439._xc7c0adbf641fc099.Parent ~= nil then
        p439._xc7c0adbf641fc099:Destroy();
    end;
    l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("HUNTED_LOST", true, {
        location = workspace.CurrentCamera.CFrame.Position
    });
end;
function u1._x61d2d67386e4410f(_, p440, p441) --[[ Line: 2251 ]]
    -- upvalues: l__Classes__3 (copy)
    l__Classes__3._x6a15bbeeb97caae0:_x82a81ec01445cd97({
        header_text = "▪ [ TRAINING STOPPED ] ▪",
        life_time = 2.5,
        subheader_text = p440 .. " Your score is " .. tostring(p441) .. ".",
        color = Color3.fromRGB(255, 49, 49)
    });
end;
function u1._x7a14e11b6a9a68ee(_, p442, p443) --[[ Line: 2260 ]]
    -- upvalues: l__TweenService__1 (copy), l__Classes__3 (copy), l__EffectAssets__5 (copy), l__Effects__9 (copy), u3 (ref)
    if p443 then
        local v444 = Instance.new("Highlight");
        v444.FillColor = Color3.fromRGB(255, 255, 255);
        v444.OutlineTransparency = 1;
        v444.FillTransparency = 0;
        v444.Enabled = true;
        v444.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
        v444.Adornee = p443;
        v444.Parent = p443;
        l__TweenService__1:Create(v444, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FillTransparency = 1
        }):Play();
        l__TweenService__1:Create(v444, TweenInfo.new(0.7, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            FillColor = Color3.fromRGB(255, 0, 0)
        }):Play();
        game.Debris:AddItem(v444, 2);
    end;
    local v445 = l__Classes__3.Util:getLikelyVec3(p443);
    local u446 = l__EffectAssets__5.DamageNumber:Clone();
    game.Debris:AddItem(u446, 1.5);
    u446.Position = v445;
    u446.Parent = l__Effects__9;
    u446.BillboardGui.TextLabel.Text = tostring(p442);
    local l__TextLabel__74 = u446.BillboardGui.TextLabel;
    l__TextLabel__74.Size = UDim2.fromScale(2, 2);
    task.delay(0.015, function() --[[ Line: 2298 ]]
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
    l__TweenService__1:Create(u446.BillboardGui.ImageLabel, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = 1
    }):Play();
    l__TextLabel__74.X.Changed:Connect(function() --[[ Line: 2307 ]]
        -- upvalues: u3 (ref), l__TextLabel__74 (copy), u446 (copy)
        local v447 = u3:numLerp(0.2, 1, l__TextLabel__74.X.Value);
        local v448 = u3:numLerp(1, 0.1, l__TextLabel__74.Y.Value);
        u446.BillboardGui.ImageLabel.Size = UDim2.fromScale(v447, v448);
    end);
    l__TweenService__1:Create(u446.BillboardGui.TextLabel, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        TextTransparency = 1
    }):Play();
    l__TweenService__1:Create(u446.BillboardGui.TextLabel.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Transparency = 1
    }):Play();
end;
function u1._x7da84aede02c9ebf(p449, p450, p451) --[[ Line: 2317 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local v452 = l__EffectAssets__5.Clash:Clone();
    game.Debris:AddItem(v452, 1);
    v452.Position = p450;
    v452.Parent = l__Effects__9;
    p449:_x04f10495a3010e73(v452);
    if p451 then
        local l__Lighting__75 = game:GetService("Lighting");
        local v453 = Instance.new("ColorCorrectionEffect");
        v453.Contrast = 1;
        v453.Saturation = -1;
        v453.Parent = l__Lighting__75;
        game.Debris:AddItem(v453, 1);
        l__TweenService__1:Create(v453, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Contrast = 0
        }):Play();
        l__TweenService__1:Create(v453, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        p449:_x163724fe4f12c8e4(l__Lighting__75, -0.3, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)):Play();
    end;
end;
function u1._x5bb526f0ccbf12ab(_, p454, p455) --[[ Line: 2338 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy)
    local v456 = l__EffectAssets__5.GunImpact:Clone();
    game.Debris:AddItem(v456, 5);
    v456.CFrame = CFrame.lookAt(p454, p455);
    v456.Parent = l__Effects__9;
    for _, v457 in v456:GetDescendants() do
        if v457:IsA("ParticleEmitter") then
            v457:Emit(v457:GetAttribute("EmitCount"));
        end;
    end;
end;
function u1._x34f9c195793f724d(_, p458, p459) --[[ Line: 2351 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy)
    local v460 = l__EffectAssets__5.Wallbang:Clone();
    game.Debris:AddItem(v460, 5);
    v460.CFrame = CFrame.lookAt(p458, p459);
    v460.Parent = l__Effects__9;
    for _, v461 in v460:GetDescendants() do
        if v461:IsA("ParticleEmitter") then
            v461:Emit(v461:GetAttribute("EmitCount"));
        end;
    end;
end;
function u1._x74814b3a4d7dc1f9(_, p462) --[[ Line: 2364 ]]
    -- upvalues: l__Classes__3 (copy), l__EffectAssets__5 (copy), l__Effects__9 (copy)
    local l__gunfire_point__76 = l__Classes__3._x8613500a592ecb35._xbd97a009261cb4a7.gun.gunfire_point;
    local l__gunfire_dir__77 = l__Classes__3._x8613500a592ecb35._xbd97a009261cb4a7.gun.gunfire_dir;
    if l__gunfire_point__76 and l__gunfire_dir__77 then
        local v463 = workspace.CurrentCamera.CFrame.Position + (p462 - l__gunfire_point__76).Magnitude / 2 * l__gunfire_dir__77;
        local v464 = l__EffectAssets__5.GunHit:Clone();
        game.Debris:AddItem(v464, 1);
        v464.CFrame = CFrame.lookAt(p462, v463);
        v464.Parent = l__Effects__9;
        for _, v465 in v464:GetDescendants() do
            if v465:IsA("ParticleEmitter") then
                v465:Emit(v465:GetAttribute("EmitCount"));
            end;
        end;
    end;
end;
function u1._x31292eaa6cc813f6(p466, p467) --[[ Line: 2383 ]]
    -- upvalues: l__Classes__3 (copy), l__EffectAssets__5 (copy), l__Effects__9 (copy)
    local v468 = l__Classes__3.Util:getLikelyVec3(p467);
    local v469 = l__EffectAssets__5.GunKill:Clone();
    game.Debris:AddItem(v469, 1);
    v469.Position = v468;
    v469.Parent = l__Effects__9;
    p466:_x04f10495a3010e73(v469);
end;
function u1._xf0923056b6c4ca4a(p470) --[[ Line: 2393 ]]
    -- upvalues: l__Classes__3 (copy)
    local v471 = Instance.new("Frame");
    v471.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    v471.Size = UDim2.fromScale(1, 1);
    v471.BackgroundTransparency = 0;
    v471.Parent = p470._xf27c081d7e69cea6;
    v471.ZIndex = 100;
    game.Debris:AddItem(v471, 0.3);
    p470:_x163724fe4f12c8e4(game:GetService("Lighting"), 100, TweenInfo.new(0.7, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)):Play();
    local v472 = l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("STATIC", true);
    if v472 then
        game.Debris:AddItem(v472, 0.3);
    end;
end;
function u1._x8239642d092b6a2d(p473) --[[ Line: 2410 ]]
    -- upvalues: l__UIAssets__4 (copy), l__Classes__3 (copy), l__TweenService__1 (copy)
    local u474 = l__UIAssets__4.Feed:Clone();
    u474.Parent = p473._xf27c081d7e69cea6;
    game.Debris:AddItem(u474, 0.8);
    task.spawn(function() --[[ Line: 2416 ]]
        -- upvalues: u474 (copy)
        while u474 and u474.Parent ~= nil do
            u474.TextLabel.Visible = not u474.TextLabel.Visible;
            task.wait(0.16);
        end;
    end);
    local l__Lighting__78 = game:GetService("Lighting");
    l__Lighting__78.ExposureCompensation = 4;
    p473:_x4d70b7dadc9e06ab(0.4, 4, 0.8);
    l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("TAPE_START", true);
    local u475 = Instance.new("BlurEffect", l__Lighting__78);
    u475.Size = 30;
    task.delay(0.8, function() --[[ Line: 2432 ]]
        -- upvalues: l__TweenService__1 (ref), l__Lighting__78 (copy), u475 (copy)
        l__TweenService__1:Create(l__Lighting__78, TweenInfo.new(0.4, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            ExposureCompensation = 0
        }):Play();
        l__TweenService__1:Create(u475, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        game.Debris:AddItem(u475, 1);
    end);
end;
function u1._xd1a3fdca8881ce73(p476) --[[ Line: 2439 ]]
    -- upvalues: l__UIAssets__4 (copy), l__Classes__3 (copy), l__TweenService__1 (copy)
    local v477 = l__UIAssets__4.Feed:Clone();
    v477.TextLabel.Text = "× SIGNAL LOST ×";
    v477.TextLabel.Visible = true;
    v477.Parent = p476._xf27c081d7e69cea6;
    game.Debris:AddItem(v477, 0.2);
    local v478 = l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("STATIC", true);
    game.Debris:AddItem(v478, 0.2);
    local u479 = Instance.new("BlurEffect", game:GetService("Lighting"));
    u479.Size = 30;
    task.delay(0.2, function() --[[ Line: 2451 ]]
        -- upvalues: l__TweenService__1 (ref), u479 (copy)
        l__TweenService__1:Create(u479, TweenInfo.new(0.4, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        game.Debris:AddItem(u479, 0.4);
    end);
end;
function u1._xae7b694bd5e96407(p480) --[[ Line: 2458 ]]
    -- upvalues: l__UIAssets__4 (copy), l__TweenService__1 (copy), l__Classes__3 (copy)
    local v481 = Instance.new("Frame");
    v481.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    v481.Size = UDim2.fromScale(1, 1);
    v481.BackgroundTransparency = 0;
    v481.Parent = p480._xf27c081d7e69cea6;
    v481.ZIndex = 100;
    game.Debris:AddItem(v481, 0.09);
    local v482 = l__UIAssets__4.Deathscreen:Clone();
    v482.Parent = p480._xf27c081d7e69cea6;
    for _, v483 in v482.Flatlined:GetChildren() do
        if v483:IsA("ImageLabel") then
            local v484 = Random.new();
            l__TweenService__1:Create(v483, TweenInfo.new(v484:NextNumber(0.5, 1.5), Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                ImageTransparency = 0
            }):Play();
        end;
    end;
    v482.Code.CodeScroll.CanvasPosition = Vector2.new(0, 2000);
    l__TweenService__1:Create(v482.Code.CodeScroll, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
        CanvasPosition = Vector2.new(0, 0)
    }):Play();
    l__Classes__3._x6a15bbeeb97caae0._x150106ccf5e1fa00.Enabled = false;
    return v482;
end;
function u1._x0b7195101449d706(_, u485) --[[ Line: 2484 ]]
    -- upvalues: l__Trove__7 (copy), l__UIAssets__4 (copy), l__RunService__2 (copy), l__Classes__3 (copy)
    local u486 = l__Trove__7.new();
    u486:AttachToInstance(u485);
    local u487 = l__UIAssets__4.EnemyHeader:Clone();
    u486:Add(u487);
    u487.Adornee = u485:FindFirstChild("HumanoidRootPart");
    u487.Parent = u485;
    u486:Connect(l__RunService__2.Heartbeat, function() --[[ Line: 2494 ]]
        -- upvalues: u485 (copy), u486 (copy), l__Classes__3 (ref), u487 (copy)
        if u485 and u485.Parent then
            local l__Position__79 = workspace.CurrentCamera.CFrame.Position;
            local v488 = l__Classes__3.Util:getLikelyVec3(u485);
            if l__Classes__3.Util:hasLineOfSight(l__Position__79, v488) then
                u487.Enabled = true;
            else
                u487.Enabled = false;
            end;
        else
            u486:Clean();
        end;
    end);
end;
function u1._x26d3cf709bd45264(u489) --[[ Line: 2508 ]]
    -- upvalues: l__EffectAssets__5 (copy), u2 (ref), u4 (ref), u3 (ref), l__RunService__2 (copy)
    local function v492() --[[ Line: 2509 ]]
        -- upvalues: l__EffectAssets__5 (ref), u489 (copy)
        local v490 = l__EffectAssets__5.Speedlines:Clone();
        v490.Parent = workspace.CurrentCamera;
        u489._x9cc3ff0e27dc9f58.Speedlines = {
            model = v490,
            emitters = {},
            connections = {}
        };
        for _, v491 in pairs(v490:GetDescendants()) do
            if v491:IsA("ParticleEmitter") then
                table.insert(u489._x9cc3ff0e27dc9f58.Speedlines.emitters, v491);
            end;
        end;
    end;
    local function u508(p493) --[[ Line: 2524 ]]
        -- upvalues: u2 (ref), u4 (ref), u489 (copy), u3 (ref)
        local v494 = u2._xfd7cc994ccc60ad7.Magnitude > u4.SPEEDLINES_THRESHOLD;
        if v494 then
            local l__CurrentCamera__80 = workspace.CurrentCamera;
            local v495 = u2._x9baf9bb47de1af88 and u2._xfd7cc994ccc60ad7.Unit or u489:_xf6d6eeea88f469e0(u2._xfd7cc994ccc60ad7);
            local v496 = not v494 and 0 or u3:convNumRange(math.clamp(u2._xfd7cc994ccc60ad7.Magnitude, u4.SPEEDLINES_THRESHOLD, u4.SPEEDLINES_SPEED_LIMIT), u4.SPEEDLINES_THRESHOLD, u4.SPEEDLINES_SPEED_LIMIT, 0, 1);
            local v497 = not v494 and 0 or u3:numLerp(1, u4.SPEEDLINES_RATE, v496);
            local v498 = not v494 and 1 or u3:numLerp(u4.SPEEDLINES_FIRST_TRANSPARENCY, u4.SPEEDLINES_LAST_TRANSPARENCY, v496);
            local v499 = l__CurrentCamera__80.CFrame.LookVector:Dot(v495);
            local v500 = math.clamp(v499, 0, 1);
            local v501 = 2 - v496;
            local v502 = not v494 and 0.01 or u3:numLerp(u4.SPEEDLINES_FIRST_APPEARANCE * v501, u4.SPEEDLINES_LAST_APPEARANCE * v501, v500);
            local v503;
            if v494 then
                local v504 = u3:numLerp(u4.SPEEDLINES_FIRST_SPEED, u4.SPEEDLINES_LAST_SPEED, v496);
                v503 = NumberRange.new(v504);
            else
                v503 = NumberRange.new(0);
            end;
            local l__model__81 = u489._x9cc3ff0e27dc9f58.Speedlines.model;
            for _, v505 in pairs(u489._x9cc3ff0e27dc9f58.Speedlines.emitters) do
                v505.Enabled = v494 and true or false;
                v505.Speed = v503;
                v505.Rate = v497 > 0 and (math.random(0, v497) or 0) or 0;
                v505.Transparency = v498 == 1 and NumberSequence.new(1) or NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(v502, 1),
                    NumberSequenceKeypoint.new(v502 + 0.05, v498, u4.SPEEDLINES_ENVELOPE),
                    NumberSequenceKeypoint.new(1, 1)
                });
                local v506 = l__CurrentCamera__80.CFrame.Position + v495 * u4.SPEEDLINES_DISTANCE;
                l__model__81.Position = v506;
                l__model__81.CFrame = l__model__81.CFrame:Lerp(CFrame.lookAt(v506, l__CurrentCamera__80.CFrame.Position), 1 * p493);
            end;
        else
            for _, v507 in pairs(u489._x9cc3ff0e27dc9f58.Speedlines.emitters) do
                v507.Transparency = NumberSequence.new(1);
            end;
        end;
    end;
    if not u489._x9cc3ff0e27dc9f58.Speedlines then
        v492();
    end;
    table.insert(u489._x9cc3ff0e27dc9f58.Speedlines.connections, l__RunService__2.RenderStepped:Connect(function(p509) --[[ Line: 2618 ]]
        -- upvalues: u508 (copy)
        u508(p509);
    end));
end;
function u1._x6503cc4a3f5acf80(p510) --[[ Line: 2625 ]]
    -- upvalues: l__UIAssets__4 (copy), l__TweenService__1 (copy)
    local v511 = {
        color_correction = Instance.new("ColorCorrectionEffect", game.Lighting),
        white_vignette = l__UIAssets__4.WhiteVignette:Clone()
    };
    v511.white_vignette.Parent = p510._xf27c081d7e69cea6;
    v511.color_correction.Brightness = 0.1;
    v511.color_correction.Contrast = 0.5;
    for _, v512 in v511 do
        game.Debris:AddItem(v512, 0.25);
    end;
    local v513 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v514 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    l__TweenService__1:Create(v511.white_vignette, v514, {
        ImageTransparency = 1
    }):Play();
    l__TweenService__1:Create(v511.color_correction, v513, {
        Brightness = 0,
        Contrast = 0
    }):Play();
end;
function u1._xbdca308bdc62c3d6(p515, p516, p517, p518, p519) --[[ Line: 2646 ]]
    -- upvalues: u3 (ref), l__EffectAssets__5 (copy), l__Effects__9 (copy), l__Classes__3 (copy), l__TweenService__1 (copy), l__UIAssets__4 (copy)
    if p517 and p518 then
        local v520 = u3:getLikelyVec3(p517);
        local l__Unit__82 = (v520 - u3:getLikelyVec3(p518)).Unit;
        p516 = CFrame.lookAt(v520, v520 + l__Unit__82 * 2);
    end;
    local l__Lighting__83 = game:GetService("Lighting");
    local v521 = p519 and l__EffectAssets__5.defaultParryOutsider:Clone() or l__EffectAssets__5.defaultParry:Clone();
    v521:PivotTo(p516);
    v521.Parent = l__Effects__9;
    game.Debris:AddItem(v521, 3);
    p515:_x04f10495a3010e73(v521);
    if p519 then
    else
        local v522 = {};
        local v523 = Instance.new("NumberValue");
        v523.Value = 5;
        v522.value = v523;
        v522.cancel_when_zero = true;
        l__Classes__3._xdca80115d2839102:_x145395062c6646e5(v522);
        l__TweenService__1:Create(v523, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = 0
        }):Play();
        local v524 = l__UIAssets__4.SpeedEffect:Clone();
        v524.Parent = p515._xf27c081d7e69cea6;
        v524.ImageTransparency = 0;
        game.Debris:AddItem(v524, 1);
        l__TweenService__1:Create(v524, TweenInfo.new(0.3), {
            Size = UDim2.new(2.5, 0, 2.5, 0)
        }):Play();
        local v525 = Instance.new("ColorCorrectionEffect");
        v525.Contrast = 2;
        v525.Parent = l__Lighting__83;
        game.Debris:AddItem(v525, 1);
        l__TweenService__1:Create(v525, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Contrast = 0
        }):Play();
        p515:_x163724fe4f12c8e4(l__Lighting__83, -2, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)):Play();
    end;
end;
function u1._x823d4857c5b845bc(p526) --[[ Line: 2694 ]]
    -- upvalues: l__Classes__3 (copy), l__TweenService__1 (copy), l__UIAssets__4 (copy)
    local v527 = {};
    local v528 = {};
    local v529 = Instance.new("NumberValue");
    v529.Value = 5;
    v528.value = v529;
    v528.cancel_when_zero = true;
    l__Classes__3._xdca80115d2839102:_x145395062c6646e5(v528);
    l__TweenService__1:Create(v529, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
    v527.speed_effect = l__UIAssets__4.SpeedEffect:Clone();
    v527.speed_effect.Parent = p526._xf27c081d7e69cea6;
    for _, v530 in v527 do
        game.Debris:AddItem(v530, 0.25);
    end;
    local v531 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    l__TweenService__1:Create(v527.speed_effect, v531, {
        ImageTransparency = 1,
        Size = UDim2.new(2.5, 0, 2.5, 0)
    }):Play();
end;
function u1._x74968a28a0271ea1(p532) --[[ Line: 2718 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__TweenService__1 (copy), l__Classes__3 (copy)
    local v533 = l__EffectAssets__5.Impact:Clone();
    v533.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
    v533.Parent = p532._xf27c081d7e69cea6;
    l__TweenService__1:Create(v533, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
    game.Debris:AddItem(v533, 1.5);
    l__Classes__3._x6a15bbeeb97caae0:_x82a81ec01445cd97({
        header_text = "▪ [ OVERTIME ] ▪",
        subheader_text = "PLAYABLE AREA WILL SHRINK",
        life_time = 8,
        color = Color3.fromRGB(255, 49, 49)
    });
    l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("GENERIC_POSITIVE", true);
end;
function u1._xbda74c7fd71d2102(p534, p535, p536) --[[ Line: 2735 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local v537 = l__EffectAssets__5.SlamTarget:Clone();
    v537.Position = l__Classes__3.Util:getLikelyVec3(p535);
    v537.Parent = l__Effects__9;
    game.Debris:AddItem(v537, 1.5);
    p534:_x04f10495a3010e73(v537);
    if p536 then
        local v538 = l__EffectAssets__5.Impact:Clone();
        v538.Parent = p534._xf27c081d7e69cea6;
        l__TweenService__1:Create(v538, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        game.Debris:AddItem(v538, 1.5);
    end;
end;
function u1._x3293cc5ad669ad50(p539, p540) --[[ Line: 2751 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__TweenService__1 (copy)
    local v541;
    if p540 then
        v541 = Color3.fromRGB(unpack(p540));
    else
        v541 = Color3.fromRGB(255, 255, 255);
    end;
    local v542 = l__EffectAssets__5.Impact:Clone();
    v542.BackgroundColor3 = v541;
    v542.Parent = p539._xf27c081d7e69cea6;
    l__TweenService__1:Create(v542, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
    game.Debris:AddItem(v542);
end;
function u1._xf152c8e2442b646b(p543, p544, p545) --[[ Line: 2765 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), l__Classes__3 (copy), l__TweenService__1 (copy)
    local v546 = l__EffectAssets__5.GroundSlamEffect:Clone();
    v546:PivotTo(CFrame.new(p544));
    v546.Parent = l__Effects__9;
    game.Debris:AddItem(v546, 1.5);
    p543:_x04f10495a3010e73(v546);
    if p545 then
    else
        local v547 = {};
        local v548 = Instance.new("NumberValue");
        v548.Value = 5;
        v547.value = v548;
        v547.cancel_when_zero = true;
        l__Classes__3._xdca80115d2839102:_x145395062c6646e5(v547);
        l__TweenService__1:Create(v548, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = 0
        }):Play();
    end;
end;
function u1._x66c88daa43686329(_, u549) --[[ Line: 2785 ]]
    -- upvalues: l___x7749231778538ccb__8 (copy), l__Classes__3 (copy), l__EffectAssets__5 (copy), l__Effects__9 (copy), l__TweenService__1 (copy), u3 (ref)
    local v551 = (function() --[[ Name: getDirection, Line 2786 ]]
        -- upvalues: l___x7749231778538ccb__8 (ref), l__Classes__3 (ref)
        local v550 = l___x7749231778538ccb__8._xd644d9e3ba63f27f("", l__Classes__3._x8613500a592ecb35._xbd97a009261cb4a7.melee);
        if v550 then
            if v550._x81f5aee9e5ead7a8 and typeof(v550._x81f5aee9e5ead7a8) == "function" then
                return v550:_x81f5aee9e5ead7a8();
            end;
            warn("MELEE MODULE DOES NOT HAVE getAttackDirection : ", v550);
        else
            warn("hitParticles VISUAL EFFECT FAILED, NO MELEE WEAPON");
        end;
    end)();
    if v551 then
        local v552 = l__EffectAssets__5.HitParticles:Clone();
        local v553 = -v551;
        v552.CFrame = CFrame.lookAt(u549 + v553 * 2, u549 + v553 * 5);
        v552.Parent = l__Effects__9;
        for _, v554 in v552:GetDescendants() do
            if v554:IsA("ParticleEmitter") then
                v554:Emit(v554:GetAttribute("EmitCount"));
            end;
        end;
        local u555 = l__EffectAssets__5.SlashAcross:Clone();
        game.Debris:AddItem(u555, 0.4);
        u555.Center.Position = u549;
        u555.Left.Position = u549;
        u555.Right.Position = u549;
        local u556 = v551 * 30;
        local u557 = -u556;
        u555.SlashParticlesShards.CFrame = CFrame.lookAt(u549, u549 + u557);
        local u558 = { u555.Beam1, u555.Beam2 };
        u555.Beam1.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0));
        u555.Beam2.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0));
        l__TweenService__1:Create(u555.Alpha, TweenInfo.new(0.4), {
            Value = 1
        }):Play();
        u555.Alpha.Changed:Connect(function() --[[ Line: 2836 ]]
            -- upvalues: u555 (copy), u549 (copy), u556 (copy), u557 (copy), u558 (copy), u3 (ref)
            local l__Value__84 = u555.Alpha.Value;
            u555.Right.Position = u549:Lerp(u549 + u556, l__Value__84);
            u555.Left.Position = u549:Lerp(u549 + u557, l__Value__84);
            for _, v559 in u558 do
                local v560 = u3:numLerp(0, 1, l__Value__84);
                local v561 = u3:numLerp(1, 0, l__Value__84);
                v559.Transparency = NumberSequence.new(v560);
                v559.Width0 = v561;
            end;
        end);
        u555.Parent = l__Effects__9;
        game.Debris:AddItem(v552, 1);
    end;
end;
function u1._x94259b93d610c8cb(_, p562) --[[ Line: 2854 ]]
    -- upvalues: l__Classes__3 (copy), l___x7749231778538ccb__8 (copy), l__EffectAssets__5 (copy), l__TweenService__1 (copy), u3 (ref), l__Effects__9 (copy)
    local u563 = l__Classes__3.Util:getLikelyVec3(p562);
    local v565 = (function() --[[ Name: getDirection, Line 2856 ]]
        -- upvalues: l___x7749231778538ccb__8 (ref), l__Classes__3 (ref)
        local v564 = l___x7749231778538ccb__8._xd644d9e3ba63f27f("", l__Classes__3._x8613500a592ecb35._xbd97a009261cb4a7.melee);
        if v564 then
            if v564._x81f5aee9e5ead7a8 and typeof(v564._x81f5aee9e5ead7a8) == "function" then
                return v564:_x81f5aee9e5ead7a8();
            end;
            warn("MELEE MODULE DOES NOT HAVE getAttackDirection : ", v564);
        else
            warn("slashAcross VISUAL EFFECT FAILED, NO MELEE WEAPON");
        end;
    end)();
    if v565 then
        local u566 = l__EffectAssets__5.SlashAcross:Clone();
        game.Debris:AddItem(u566, 0.8);
        u566.Center.Position = u563;
        u566.Left.Position = u563;
        u566.Right.Position = u563;
        local u567 = v565 * 60;
        local u568 = -u567;
        u566.SlashParticlesShards.CFrame = CFrame.lookAt(u563, u563 + u568);
        local u569 = { u566.Beam1, u566.Beam2 };
        l__TweenService__1:Create(u566.Alpha, TweenInfo.new(0.8), {
            Value = 1
        }):Play();
        u566.Alpha.Changed:Connect(function() --[[ Line: 2890 ]]
            -- upvalues: u566 (copy), u563 (copy), u567 (copy), u568 (copy), u569 (copy), u3 (ref)
            local l__Value__85 = u566.Alpha.Value;
            u566.Right.Position = u563:Lerp(u563 + u567, l__Value__85);
            u566.Left.Position = u563:Lerp(u563 + u568, l__Value__85);
            for _, v570 in u569 do
                local v571 = u3:numLerp(0, 1, l__Value__85);
                local v572 = u3:numLerp(1, 0, l__Value__85);
                v570.Transparency = NumberSequence.new(v571);
                v570.Width0 = v572;
            end;
        end);
        for _, v573 in u566:GetDescendants() do
            if v573:IsA("ParticleEmitter") then
                v573:Emit(v573:GetAttribute("EmitCount"));
            end;
        end;
        u566.Parent = l__Effects__9;
        game.Debris:AddItem(u566.SlashParticlesShards, 2);
        u566.SlashParticlesShards.Parent = l__Effects__9;
    end;
end;
function u1._x1e20c998fd94886d(u574, p575) --[[ Line: 2914 ]]
    -- upvalues: l__Classes__3 (copy), l__TweenService__1 (copy)
    local v576 = Instance.new("ColorCorrectionEffect", game.Lighting);
    local u577 = Instance.new("ColorCorrectionEffect", game.Lighting);
    task.delay(0.2, function() --[[ Line: 2919 ]]
        -- upvalues: u574 (copy)
        u574:_x6503cc4a3f5acf80();
    end);
    u574:_x9f925e06f0b040f2(p575);
    v576.Brightness = -2;
    local v578 = {};
    local v579 = Instance.new("NumberValue");
    v579.Value = 10;
    v578.value = v579;
    v578.cancel_when_zero = true;
    l__Classes__3._xdca80115d2839102:_x145395062c6646e5(v578);
    l__Classes__3._xe0e88f94014b801e:_x45821945fb1d741b(0.08);
    game.Debris:AddItem(v576, 0.3);
    game.Debris:AddItem(u577, 1.5);
    l__TweenService__1:Create(v576, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Brightness = 0
    }):Play();
    l__TweenService__1:Create(u577, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Brightness = 0.1,
        Contrast = 0.2
    }):Play();
    l__TweenService__1:Create(v579, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
    u574:_x4d70b7dadc9e06ab(0.5, 2);
    task.delay(0.3, function() --[[ Line: 2946 ]]
        -- upvalues: l__TweenService__1 (ref), u577 (copy)
        l__TweenService__1:Create(u577, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Brightness = 0,
            Contrast = 0
        }):Play();
    end);
end;
function u1._xb599cfadda8f1876(u580, u581, p582) --[[ Line: 2951 ]]
    -- upvalues: l__Classes__3 (copy), l__Promise__6 (copy), l__EffectAssets__5 (copy), l__TweenService__1 (copy), u3 (ref)
    local v583 = tonumber(p582) - workspace:GetServerTimeNow();
    local v584 = math.max(v583, 0);
    local v585 = math.max(v584 - 0.5, 0);
    local l___xe7b27b4f70860c7d__86 = l__Classes__3._xe7b27b4f70860c7d;
    local v586;
    if l___xe7b27b4f70860c7d__86 and typeof(l___xe7b27b4f70860c7d__86._x32e5162398b03925) == "function" then
        v586 = l___xe7b27b4f70860c7d__86:_x32e5162398b03925(u581);
    else
        v586 = u581;
    end;
    local u587 = v586:FindFirstChild("Head") or (v586.PrimaryPart or v586:FindFirstChildWhichIsA("BasePart"));
    local u588 = l__Promise__6.delay(v585);
    u588:andThen(function() --[[ Line: 2957 ]]
        -- upvalues: u587 (copy), l__Classes__3 (ref)
        if u587 then
            l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("SMOOTH_RISER", true, {
                Parent = u587
            });
        end;
    end);
    local u589 = {};
    table.insert(u589, u588);
    local u590 = {};
    local u591 = l__EffectAssets__5.Trail:Clone();
    u591.Parent = u580._xf27c081d7e69cea6;
    game.Debris:AddItem(u591, v584);
    local u592 = l__EffectAssets__5.Cross:Clone();
    u592.Parent = u580._xf27c081d7e69cea6;
    game.Debris:AddItem(u592, v584);
    table.insert(u590, u591);
    table.insert(u590, u592);
    for _, v593 in u592:GetChildren() do
        if v593:IsA("Frame") then
            l__TweenService__1:Create(v593, TweenInfo.new(v584), {
                Size = UDim2.new(0, 1, 10, 0)
            }):Play();
            l__TweenService__1:Create(v593, TweenInfo.new(v584, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
        end;
    end;
    if u587 then
        local u594 = nil;
        local u595 = game:GetService("HttpService"):GenerateGUID();
        local u596 = false;
        u3:bindToRenderStep(u595, Enum.RenderPriority.Last.Value, function() --[[ Line: 2993 ]]
            -- upvalues: u587 (copy), u588 (copy), u3 (ref), u595 (copy), u596 (ref), u591 (copy), u592 (copy), u594 (ref), u580 (copy)
            local l__CurrentCamera__87 = workspace.CurrentCamera;
            if l__CurrentCamera__87 and l__CurrentCamera__87.CFrame then
                if u587 and u587:IsDescendantOf(workspace.Entities) then
                    local l__Position__88 = u587.Position;
                    local v597, v598 = l__CurrentCamera__87:WorldToViewportPoint(l__Position__88);
                    if v598 and v597.Z > 0 then
                        if u3:hasLineOfSight(l__CurrentCamera__87.CFrame.Position, l__Position__88) then
                            u591.Visible = true;
                            u592.Visible = true;
                            local v599 = Vector2.new(v597.X, v597.Y);
                            u592.Position = UDim2.fromOffset(v599.X, v599.Y);
                            if u594 then
                                local v600 = v599 - u594;
                                local v601 = math.max(v600.Magnitude, 0.007 * u580._xf27c081d7e69cea6.AbsoluteSize.X);
                                local v602 = u594 + v600 * 0.5;
                                u591.Size = UDim2.new(0, v601, u591.Size.Y.Scale, u591.Size.Y.Offset);
                                u591.Position = UDim2.fromOffset(v602.X, v602.Y);
                                local v603 = u591;
                                local v604 = math.atan2(v600.Y, v600.X);
                                v603.Rotation = math.deg(v604);
                            end;
                            u594 = v599;
                        else
                            u591.Visible = false;
                            u592.Visible = false;
                            u594 = nil;
                        end;
                    else
                        u591.Visible = false;
                        u592.Visible = false;
                        u594 = nil;
                    end;
                else
                    u588:cancel();
                    u3:unbindFromRenderStep(u595);
                    u596 = true;
                    u591.Visible = false;
                    u592.Visible = false;
                end;
            end;
        end);
        local function u607() --[[ Line: 3044 ]]
            -- upvalues: u590 (copy), u589 (copy), u3 (ref), u595 (copy), u580 (copy), u581 (copy)
            for _, v605 in u590 do
                if v605.Parent ~= nil then
                    v605:Destroy();
                end;
            end;
            for _, v606 in u589 do
                v606:cancel();
            end;
            u3:unbindFromRenderStep(u595);
            u580._x85b32f0b9c67055f[u581] = nil;
        end;
        if u580._x85b32f0b9c67055f[u581] then
            pcall(u580._x85b32f0b9c67055f[u581]);
        end;
        u580._x85b32f0b9c67055f[u581] = u607;
        task.delay(math.min(v584, 10), function() --[[ Line: 3064 ]]
            -- upvalues: u596 (ref), u607 (copy)
            if u596 then
            else
                u607();
            end;
        end);
    end;
end;
function u1._x54a406a54bc043b8(u608, u609, p610) --[[ Line: 3072 ]]
    -- upvalues: l__Classes__3 (copy), l__Promise__6 (copy), l__EffectAssets__5 (copy), l__TweenService__1 (copy), u3 (ref)
    local v611 = tonumber(p610) - workspace:GetServerTimeNow();
    local u612 = math.max(v611, 0);
    local v613 = math.max(u612 - 0.5, 0);
    local l___xe7b27b4f70860c7d__89 = l__Classes__3._xe7b27b4f70860c7d;
    local v614;
    if l___xe7b27b4f70860c7d__89 and typeof(l___xe7b27b4f70860c7d__89._x32e5162398b03925) == "function" then
        v614 = l___xe7b27b4f70860c7d__89:_x32e5162398b03925(u609);
    else
        v614 = u609;
    end;
    local u615 = v614:FindFirstChild("GunPoint", true) or v614.PrimaryPart;
    if u615 then
        local u616 = {};
        local u617 = {};
        local v618 = l__Promise__6.delay(v613);
        v618:andThen(function() --[[ Line: 3081 ]]
            -- upvalues: u615 (copy), l__Classes__3 (ref)
            if u615 then
                l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("SMOOTH_RISER", true, {
                    Parent = u615
                });
            end;
        end);
        table.insert(u616, v618);
        local u619 = l__EffectAssets__5.PhoenixGlare:Clone();
        u619.Parent = u608._xf27c081d7e69cea6;
        game.Debris:AddItem(u619, u612);
        table.insert(u617, u619);
        for v620 = 1, 3 do
            local v621 = l__Promise__6.delay((v620 - 1) * 0.2);
            table.insert(u616, v621);
            v621:andThen(function() --[[ Line: 3097 ]]
                -- upvalues: l__EffectAssets__5 (ref), u608 (copy), l__TweenService__1 (ref), u617 (copy)
                local v622 = l__EffectAssets__5.WaveIn:Clone();
                v622.Parent = u608._xf27c081d7e69cea6;
                game.Debris:AddItem(v622, 0.30000000000000004);
                l__TweenService__1:Create(v622, TweenInfo.new(0.30000000000000004, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    ImageTransparency = 0,
                    Size = UDim2.fromScale(0, 0)
                }):Play();
                table.insert(u617, v622);
            end);
        end;
        local u623 = game:GetService("HttpService"):GenerateGUID();
        local u624 = false;
        local function u627(p625) --[[ Line: 3111 ]]
            -- upvalues: u617 (copy)
            for _, v626 in u617 do
                if v626 and v626.Parent ~= nil then
                    p625(v626);
                end;
            end;
        end;
        local u628 = 0.2;
        local u629 = os.clock();
        local u630 = Random.new();
        u3:bindToRenderStep(u623, Enum.RenderPriority.Last.Value, function(p631) --[[ Line: 3123 ]]
            -- upvalues: u615 (copy), u616 (copy), u3 (ref), u623 (copy), u624 (ref), u627 (copy), u619 (copy), u628 (ref), l__TweenService__1 (ref), u629 (copy), u612 (copy), u630 (copy)
            local l__CurrentCamera__90 = workspace.CurrentCamera;
            if l__CurrentCamera__90 and l__CurrentCamera__90.CFrame then
                if u615 and u615:IsDescendantOf(workspace.Entities) then
                    local v632 = u615:IsA("Attachment") and u615.WorldPosition or u615.Position;
                    local v633, v634 = l__CurrentCamera__90:WorldToViewportPoint(v632);
                    u619.Visible = true;
                    u628 = u628 + p631;
                    if u628 >= 0.2 then
                        u628 = 0;
                        u619.ImageTransparency = 1;
                        l__TweenService__1:Create(u619, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ImageTransparency = 0
                        }):Play();
                    end;
                    local v635 = os.clock() - u629;
                    local v636 = u3:numLerp(0.08, 0, l__TweenService__1:GetValue(u3:convNumRange(math.min(v635, u612), 0, u612, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.In));
                    local v637 = u630:NextNumber(1, 3);
                    u619.Size = UDim2.fromScale(0.08 * v637, v636 * v637);
                    u627(function(p638) --[[ Line: 3163 ]]
                        p638.Visible = true;
                    end);
                    if v634 and v633.Z > 0 then
                        if u3:hasLineOfSight(l__CurrentCamera__90.CFrame.Position, v632) then
                            local u639 = Vector2.new(v633.X, v633.Y);
                            u627(function(p640) --[[ Line: 3182 ]]
                                -- upvalues: u639 (copy)
                                p640.Position = UDim2.fromOffset(u639.X, u639.Y);
                            end);
                        else
                            u627(function(p641) --[[ Line: 3175 ]]
                                p641.Visible = false;
                            end);
                        end;
                    else
                        u627(function(p642) --[[ Line: 3168 ]]
                            p642.Visible = false;
                        end);
                    end;
                else
                    for _, v643 in u616 do
                        v643:cancel();
                    end;
                    u3:unbindFromRenderStep(u623);
                    u624 = true;
                    u627(function(p644) --[[ Line: 3135 ]]
                        p644.Visible = false;
                    end);
                end;
            end;
        end);
        local function u647() --[[ Line: 3187 ]]
            -- upvalues: u617 (copy), u616 (copy), u3 (ref), u623 (copy), u608 (copy), u609 (copy)
            for _, v645 in u617 do
                if v645.Parent ~= nil then
                    v645:Destroy();
                end;
            end;
            for _, v646 in u616 do
                v646:cancel();
            end;
            u3:unbindFromRenderStep(u623);
            u608._x85b32f0b9c67055f[u609] = nil;
        end;
        if u608._x85b32f0b9c67055f[u609] then
            pcall(u608._x85b32f0b9c67055f[u609]);
        end;
        u608._x85b32f0b9c67055f[u609] = u647;
        task.delay(math.min(u612, 10), function() --[[ Line: 3207 ]]
            -- upvalues: u624 (ref), u647 (copy)
            if u624 then
            else
                u647();
            end;
        end);
    end;
end;
function u1._xcd7759a107d54418(u648, u649, p650) --[[ Line: 3213 ]]
    -- upvalues: l__Classes__3 (copy), l__EffectAssets__5 (copy), l__Promise__6 (copy), u3 (ref), l__TweenService__1 (copy)
    local v651 = tonumber(p650) - workspace:GetServerTimeNow();
    local u652 = math.max(v651, 0);
    local v653 = math.max(u652 - 0.5, 0);
    local l___xe7b27b4f70860c7d__91 = l__Classes__3._xe7b27b4f70860c7d;
    local v654;
    if l___xe7b27b4f70860c7d__91 and typeof(l___xe7b27b4f70860c7d__91._x32e5162398b03925) == "function" then
        v654 = l___xe7b27b4f70860c7d__91:_x32e5162398b03925(u649);
    else
        v654 = u649;
    end;
    local u655 = v654:FindFirstChild("Head", true) or v654.PrimaryPart;
    if u655 then
        local u656 = l__EffectAssets__5.SiegeGlare:Clone();
        u656.Parent = u648._xf27c081d7e69cea6;
        game.Debris:AddItem(u656, u652);
        local v657 = l__Promise__6.delay(v653);
        v657:andThen(function() --[[ Line: 3224 ]]
            -- upvalues: u655 (copy), l__Classes__3 (ref)
            if u655 then
                l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("SMOOTH_RISER", true, {
                    Parent = u655
                });
            end;
        end);
        local u658 = game:GetService("HttpService"):GenerateGUID();
        local u659 = false;
        local u660 = l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("SIEGE_DRAW", true, {
            Parent = u655
        });
        local u661 = {};
        local u662 = {};
        table.insert(u662, v657);
        table.insert(u661, u656);
        local u663 = 0.2;
        local u664 = os.clock();
        local u665 = Random.new();
        local function u668(p666) --[[ Line: 3246 ]]
            -- upvalues: u661 (copy)
            for _, v667 in u661 do
                if v667 and v667.Parent ~= nil then
                    p666(v667);
                end;
            end;
        end;
        local u669 = 0;
        u3:bindToRenderStep(u658, Enum.RenderPriority.Last.Value, function(p670) --[[ Line: 3264 ]]
            -- upvalues: u655 (copy), u662 (copy), u3 (ref), u658 (copy), u659 (ref), u668 (copy), u669 (ref), l__EffectAssets__5 (ref), u648 (copy), l__TweenService__1 (ref), u661 (copy), u656 (copy), u663 (ref), u664 (copy), u652 (copy), u665 (copy)
            local l__CurrentCamera__92 = workspace.CurrentCamera;
            if l__CurrentCamera__92 and l__CurrentCamera__92.CFrame then
                if u655 and u655:IsDescendantOf(workspace.Entities) then
                    local u671 = workspace:GetServerTimeNow();
                    local v672 = u655:IsA("Attachment") and u655.WorldPosition or u655.Position;
                    local l__Magnitude__93 = (v672 - workspace.CurrentCamera.CFrame.Position).Magnitude;
                    local v673, v674 = l__CurrentCamera__92:WorldToViewportPoint(v672);
                    local u675 = u3:convNumRange(l__Magnitude__93, 40, 100, 0.2, 0.4);
                    u669 = u669 + p670;
                    local function v682() --[[ Line: 3290 ]]
                        -- upvalues: u3 (ref), l__Magnitude__93 (copy), l__EffectAssets__5 (ref), u648 (ref), u675 (copy), l__TweenService__1 (ref), u671 (copy), u661 (ref)
                        local v676 = u3:convNumRange(l__Magnitude__93, 40, 100, 0.4, 0.2);
                        local v677 = UDim2.fromScale(v676, v676);
                        local v678 = l__EffectAssets__5.Crescent:Clone();
                        v678.Size = v677;
                        v678.Parent = u648._xf27c081d7e69cea6;
                        local v679 = l__EffectAssets__5.Crescent:Clone();
                        v679.Rotation = 180;
                        v679.Size = v677;
                        v679.Parent = u648._xf27c081d7e69cea6;
                        local v680 = TweenInfo.new(u675, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
                        l__TweenService__1:Create(v678, v680, {
                            ImageTransparency = 0,
                            Size = UDim2.fromScale(0, 0)
                        }):Play();
                        l__TweenService__1:Create(v679, v680, {
                            ImageTransparency = 0,
                            Size = UDim2.fromScale(0, 0)
                        }):Play();
                        local v681;
                        if u671 <= u675 then
                            v681 = u671;
                        else
                            v681 = u675;
                        end;
                        game.Debris:AddItem(v678, v681);
                        game.Debris:AddItem(v679, v681);
                        table.insert(u661, v678);
                        table.insert(u661, v679);
                    end;
                    if l__Magnitude__93 < 100 and (u675 <= u669 and not u659) then
                        u669 = 0;
                        v682();
                    end;
                    u656.Visible = true;
                    u663 = u663 + p670;
                    if u663 >= 0.2 then
                        u663 = 0;
                        u656.ImageTransparency = 1;
                        l__TweenService__1:Create(u656, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ImageTransparency = 0
                        }):Play();
                    end;
                    local v683 = os.clock() - u664;
                    local v684 = u3:numLerp(0, 0.04, l__TweenService__1:GetValue(u3:convNumRange(math.min(v683, u652), 0, u652, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.Out));
                    local v685 = u665:NextNumber(1, 3);
                    u656.Size = UDim2.fromScale(v684 * v685, 0.04 * v685);
                    u668(function(p686) --[[ Line: 3347 ]]
                        p686.Visible = true;
                    end);
                    if v674 and v673.Z > 0 then
                        if u3:hasLineOfSight(l__CurrentCamera__92.CFrame.Position, v672) then
                            local u687 = Vector2.new(v673.X, v673.Y);
                            u668(function(p688) --[[ Line: 3366 ]]
                                -- upvalues: u687 (copy)
                                if p688.Parent == nil then
                                else
                                    p688.Position = UDim2.fromOffset(u687.X, u687.Y);
                                end;
                            end);
                        else
                            u668(function(p689) --[[ Line: 3359 ]]
                                p689.Visible = false;
                            end);
                        end;
                    else
                        u668(function(p690) --[[ Line: 3352 ]]
                            p690.Visible = false;
                        end);
                    end;
                else
                    for _, v691 in u662 do
                        v691:cancel();
                    end;
                    u3:unbindFromRenderStep(u658);
                    u659 = true;
                    u668(function(p692) --[[ Line: 3276 ]]
                        p692.Visible = false;
                    end);
                end;
            end;
        end);
        local function u695() --[[ Line: 3372 ]]
            -- upvalues: u661 (copy), u662 (copy), u3 (ref), u658 (copy), u648 (copy), u649 (copy), u660 (copy)
            for _, v693 in u661 do
                if v693.Parent ~= nil then
                    v693:Destroy();
                end;
            end;
            for _, v694 in u662 do
                v694:cancel();
            end;
            u3:unbindFromRenderStep(u658);
            u648._x85b32f0b9c67055f[u649] = nil;
            if u660 and u660.Parent ~= nil then
                u660:Destroy();
            end;
        end;
        if u648._x85b32f0b9c67055f[u649] then
            pcall(u648._x85b32f0b9c67055f[u649]);
        end;
        u648._x85b32f0b9c67055f[u649] = u695;
        task.delay(math.min(u652, 10), function() --[[ Line: 3396 ]]
            -- upvalues: u659 (ref), u695 (copy)
            if u659 then
            else
                u695();
            end;
        end);
    end;
end;
function u1._xd7b956d0fa4be4f7(u696, u697, p698) --[[ Line: 3402 ]]
    -- upvalues: l__Classes__3 (copy), l__EffectAssets__5 (copy), l__Trove__7 (copy), l__TweenService__1 (copy), u3 (ref)
    local u699 = tonumber(p698);
    local v700 = workspace:GetServerTimeNow();
    local v701 = math.max(u699 - v700, 0);
    math.max(v701 - 0.5, 0);
    local l___xe7b27b4f70860c7d__94 = l__Classes__3._xe7b27b4f70860c7d;
    local u702;
    if l___xe7b27b4f70860c7d__94 and typeof(l___xe7b27b4f70860c7d__94._x32e5162398b03925) == "function" then
        u702 = l___xe7b27b4f70860c7d__94:_x32e5162398b03925(u697);
    else
        u702 = u697;
    end;
    local u703 = u702:FindFirstChild("GunPoint", true) or u702.PrimaryPart;
    if u703 then
        local u704 = l__EffectAssets__5.MonarchGlare:Clone();
        u704.Parent = u696._xf27c081d7e69cea6;
        local u705 = l__Trove__7.new();
        local v706 = game:GetService("HttpService"):GenerateGUID();
        local u707 = false;
        os.clock();
        Random.new();
        local u708 = nil;
        u705:Add(u704);
        local u709 = u699 - 0.8;
        l__TweenService__1:Create(u704.StartStar, TweenInfo.new(u709 - v700, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            ImageTransparency = 0,
            Rotation = u704.StartStar.Rotation + 720,
            Size = UDim2.fromScale(0.7, 0.7)
        }):Play();
        local u710 = false;
        local u711 = nil;
        u705:BindToRenderStep(v706, Enum.RenderPriority.Last.Value, function(_) --[[ Line: 3438 ]]
            -- upvalues: u699 (ref), u703 (copy), u707 (ref), u708 (ref), u3 (ref), u709 (copy), u710 (ref), l__TweenService__1 (ref), u704 (copy), u711 (ref), l__Classes__3 (ref), u702 (copy)
            local l__CurrentCamera__95 = workspace.CurrentCamera;
            local v712 = workspace:GetServerTimeNow();
            local v713 = u699 - v712;
            if l__CurrentCamera__95 and l__CurrentCamera__95.CFrame then
                if u703 and u703:IsDescendantOf(workspace.Entities) then
                    local v714 = u703:IsA("Attachment") and u703.WorldPosition or u703.Position;
                    local v715, v716 = l__CurrentCamera__95:WorldToViewportPoint(v714);
                    local v717 = u3:hasLineOfSight(l__CurrentCamera__95.CFrame.Position, v714);
                    if u709 <= v712 and not u710 then
                        u710 = true;
                        l__TweenService__1:Create(u704.Horizontal, TweenInfo.new(v713 * 0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                            Size = UDim2.fromScale(6, 1)
                        }):Play();
                        l__TweenService__1:Create(u704.Vertical, TweenInfo.new(v713 * 0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                            Size = UDim2.fromScale(1, 6)
                        }):Play();
                        l__TweenService__1:Create(u704.Horizontal, TweenInfo.new(v713 * 0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            ImageTransparency = 1
                        }):Play();
                        l__TweenService__1:Create(u704.Vertical, TweenInfo.new(v713 * 0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            ImageTransparency = 1
                        }):Play();
                        u704.Glow.ImageTransparency = 0;
                        l__TweenService__1:Create(u704.Glow, TweenInfo.new(v713 * 0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            ImageTransparency = 1,
                            Size = UDim2.fromScale(0.1, 0.1)
                        }):Play();
                        if v717 then
                            u711 = l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("NIGHT_VISION", true, {
                                Volume = 1,
                                Parent = u702
                            });
                        else
                            u711 = l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("NIGHT_VISION", true, {
                                Volume = 0.05,
                                Parent = u702
                            });
                        end;
                    end;
                    u704.Visible = true;
                    local v718, v719;
                    if u709 <= v712 then
                        local v720 = l__Classes__3.Util:convNumRange(v713, 0, 0.8, 0, 10);
                        v718 = math.random(0, v720);
                        local v721 = l__Classes__3.Util:convNumRange(v713, 0, 0.8, 0, 10);
                        v719 = math.random(0, v721);
                    else
                        v718 = 0;
                        v719 = 0;
                    end;
                    if v716 then
                        if v717 then
                            if u711 then
                                if v717 then
                                    u711.Volume = 1;
                                else
                                    u711.Volume = 0.05;
                                end;
                            end;
                            u704.Position = UDim2.fromOffset(v715.X + v718, v715.Y + v719);
                        else
                            u704.Visible = false;
                        end;
                    else
                        u704.Visible = false;
                    end;
                else
                    u707 = true;
                    u708();
                end;
            end;
        end);
        u708 = function() --[[ Line: 3513 ]]
            -- upvalues: u705 (copy), u696 (copy), u697 (copy)
            u705:Clean();
            u696._x85b32f0b9c67055f[u697] = nil;
        end;
        if u696._x85b32f0b9c67055f[u697] then
            pcall(u696._x85b32f0b9c67055f[u697]);
        end;
        u696._x85b32f0b9c67055f[u697] = u708;
        task.delay(math.min(v701, 10), function() --[[ Line: 3524 ]]
            -- upvalues: u708 (ref)
            u708();
        end);
    end;
end;
function u1._x8a2fac30df13d015(p722, p723, p724, p725) --[[ Line: 3530 ]]
    if p725 == "Phoenix" then
        p722:_x54a406a54bc043b8(p723, p724);
    elseif p725 == "Siege" then
        p722:_xcd7759a107d54418(p723, p724);
    elseif p725 == "Monarch" then
        p722:_xd7b956d0fa4be4f7(p723, p724);
    else
        p722:_xb599cfadda8f1876(p723, p724);
    end;
end;
function u1._xff049722a58939d5(p726) --[[ Line: 3542 ]]
    return {
        brokenIndicator = p726._x565d6153177a12b9,
        bulletTracer = p726._x7a30dd20a0ca54cb,
        buttonPressed = p726._x77d5fc071f0a9058,
        castigateFlash = p726._xbb97cdf6931fca17,
        characterTrail = p726._xa0a5d73b86a4f969,
        chaseDash = p726._x7c391a6b4e99d7a0,
        clash = p726._x7da84aede02c9ebf,
        clashLocal = p726._x93dad7f4849973ba,
        closeHuntedWarning = p726._xe78d720bbc03cd0e,
        damageNumber = p726._x7a14e11b6a9a68ee,
        defaultParry = p726._xbdca308bdc62c3d6,
        globalDeathEffect = p726._x9f925e06f0b040f2,
        grappleEndOutsider = p726._x46c82226b1fac495,
        grappleStartOutsider = p726._xc41fb81b6aa12e79,
        groundSlam = p726._xf152c8e2442b646b,
        gunDrawCue = p726._x8a2fac30df13d015,
        gunHit = p726._x74814b3a4d7dc1f9,
        gunKill = p726._x31292eaa6cc813f6,
        hitParticles = p726._x66c88daa43686329,
        huntedWarning = p726._x8a036b25effb834b,
        impactFrame = p726._xdef95fcd4ad75393,
        impactTaken = p726._x3293cc5ad669ad50,
        killConfirm = p726._x1e20c998fd94886d,
        launchpadEffect = p726._xd3d48950a766775d,
        parryIndicator = p726._x888d33c3a14b8d1c,
        parryTrainStopped = p726._x61d2d67386e4410f,
        phoenixDirect = p726._x2574489847a97732,
        phoenixExplosion = p726._x46d905ab09eb3711,
        phoenixFlash = p726._x11dda911a925bca1,
        phoenixFlashOutsider = p726._x7ab28b2f765cfbf2,
        removeProjectile = p726._x738ec4b2fe4264c5,
        screenStatic = p726._xee3cf89a6e695d73,
        shockwave = p726._x67a2f8cecc1abb11,
        siegeFlashOutsider = p726._x0ecff6e8f0a4fac9,
        simulateProjectile = p726._xfe6795a495be818e,
        slamTarget = p726._xbda74c7fd71d2102,
        slashAcross = p726._x94259b93d610c8cb,
        stopLoadingScreen = p726._x7acbd6fcd723edcc,
        suspendedIndicator = p726._xf557facef9f7e17e,
        swoopAttack = p726._xad3a6ea0d9608f02,
        castigateFlashOutsider = p726._x5806c0071ac89edb,
        monarchFlash = p726._xad3763918b8389b9,
        monarchFlashOutsider = p726._xe37ffef56b69a86f,
        siegeFlash = p726._x5d7bcba478aaa140,
        swoopAttackClient = p726._xfabe666517c3f63c
    };
end;
function u1._x08cf916050468466(p727, p728, ...) --[[ Line: 3592 ]]
    local v729 = p727._x9cab91eaa222232c[p728];
    if v729 then
        return v729(p727, ...);
    end;
    warn("NO REGISTERED VISUAL EFFECT : ", p728);
    return nil;
end;
function u1._xfbdc995dd8bd9380(u730) --[[ Line: 3602 ]]
    -- upvalues: u2 (ref), l__Packets__10 (copy)
    if u2 then
        u2._x6ca41a60efee84c4.dash_started.Event:Connect(function() --[[ Line: 3604 ]]
            -- upvalues: u730 (copy)
            u730:_x823d4857c5b845bc();
            u730:_x6503cc4a3f5acf80();
        end);
    end;
    l__Packets__10._x8c8bc87c3fc21bf3.OnClientEvent:Connect(function(p731, p732) --[[ Line: 3610 ]]
        -- upvalues: u730 (copy)
        debug.profilebegin(p731);
        local v733 = u730._x9cab91eaa222232c[p731];
        if v733 then
            if typeof(p732) == "table" then
                v733(u730, unpack(p732));
            else
                v733(u730, p732);
            end;
        end;
        debug.profileend();
    end);
end;
function u1._xb6a1497b5683f65f(_, u734) --[[ Line: 3626 ]]
    -- upvalues: l__Trove__7 (copy), l__UIAssets__4 (copy), l__RunService__2 (copy), l__Classes__3 (copy)
    local u735 = l__Trove__7.new();
    u735:AttachToInstance(u734);
    local u736 = Instance.new("Highlight");
    local v737 = l__UIAssets__4.FriendlyHeader:Clone();
    u735:Add(v737);
    u735:Add(u736);
    v737.Adornee = u734:FindFirstChild("HumanoidRootPart");
    v737.Parent = u734;
    u736.FillColor = Color3.fromRGB(83, 255, 169);
    u736.OutlineColor = Color3.fromRGB(83, 255, 169);
    u736.OutlineTransparency = 0.4;
    u735:Connect(l__RunService__2.Heartbeat, function() --[[ Line: 3644 ]]
        -- upvalues: u734 (copy), u735 (copy), l__Classes__3 (ref), u736 (copy)
        if u734 and u734.Parent then
            local l__Position__96 = workspace.CurrentCamera.CFrame.Position;
            local v738 = l__Classes__3.Util:getLikelyVec3(u734);
            if l__Classes__3.Util:hasLineOfSight(l__Position__96, v738) then
                u736.FillTransparency = 1;
            else
                u736.FillTransparency = 0.4;
            end;
        else
            u735:Clean();
        end;
    end);
    u736.Parent = u734;
end;
function u1._xad3763918b8389b9(u739, u740) --[[ Line: 3660 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__TweenService__1 (copy), l__RunService__2 (copy)
    local v741 = l__EffectAssets__5.MonarchFlash:Clone();
    local u742 = l__Classes__3._xdca80115d2839102:_x061224a5e52c670b();
    v741.CFrame = CFrame.lookAt(u740 + u742 * 2, u740 + u742 * 10);
    v741.Parent = l__Effects__9;
    game.Debris:AddItem(v741, 4);
    u739:_x04f10495a3010e73(v741);
    local l__Lighting__97 = game:GetService("Lighting");
    local v743 = Instance.new("ColorCorrectionEffect");
    v743.Contrast = 1;
    v743.Saturation = -1;
    v743.Parent = l__Lighting__97;
    game.Debris:AddItem(v743, 1);
    l__TweenService__1:Create(v743, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Contrast = 0
    }):Play();
    l__TweenService__1:Create(v743, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    u739:_x163724fe4f12c8e4(l__Lighting__97, -2.7, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)):Play();
    local l__Bullet__98 = v741.Bullet;
    local v744 = u740 + u742 * 2000;
    local v745 = TweenInfo.new(0.44, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
    l__Bullet__98.CFrame = CFrame.lookAt(u740 + u742 * 2, u740 + -u742 * 2000);
    l__TweenService__1:Create(l__Bullet__98, v745, {
        Size = Vector3.new(1, 1, 3000)
    }):Play();
    l__TweenService__1:Create(l__Bullet__98, v745, {
        Position = v744
    }):Play();
    game.Debris:AddItem(l__Bullet__98, 0.44);
    local u746 = l__EffectAssets__5.MonarchTracer:Clone();
    u746.Start.Position = u740;
    u746.End.Position = u740;
    u746.Parent = l__Effects__9;
    l__TweenService__1:Create(u746.End, v745, {
        Position = v744
    }):Play();
    l__TweenService__1:Create(u746.num, TweenInfo.new(3, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Value = 1
    }):Play();
    l__TweenService__1:Create(u746.Trail, TweenInfo.new(3, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Width0 = 1,
        Width1 = 1
    }):Play();
    u746.num.Changed:Connect(function() --[[ Line: 3709 ]]
        -- upvalues: u746 (copy)
        if u746 and u746.Parent then
            u746.Trail.Transparency = NumberSequence.new(u746.num.Value);
        end;
    end);
    game.Debris:AddItem(u746, 3);
    local l__Twist__99 = v741.Twist;
    local v747 = u740 + u742 * 45;
    local v748 = TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
    local u749 = CFrame.lookAt(u740 + u742 * 2, u740 + -u742 * 2000) * CFrame.Angles(-1.5707963267948966, 0, 0);
    l__Twist__99.CFrame = u749;
    local u750 = Instance.new("Vector3Value");
    u750.Value = u749.Position;
    game.Debris:AddItem(u750, 1.75);
    l__TweenService__1:Create(u750, v748, {
        Value = v747
    }):Play();
    l__TweenService__1:Create(l__Twist__99, v748, {
        Size = Vector3.new(75, 60, 75),
        Transparency = 1
    }):Play();
    local u751 = 0;
    local u752 = nil;
    u752 = l__RunService__2.RenderStepped:Connect(function(p753) --[[ Line: 3740 ]]
        -- upvalues: u751 (ref), l__Twist__99 (copy), u750 (copy), u749 (copy), u752 (ref)
        u751 = u751 + p753;
        local v754 = math.clamp(u751 / 0.75, 0, 1);
        local v755 = (1 - (1 - v754) ^ 2) * -12.566370614359172;
        l__Twist__99.CFrame = CFrame.new(u750.Value) * (u749 - u749.Position) * CFrame.Angles(0, v755, 0);
        if v754 >= 1 then
            u752:Disconnect();
        end;
    end);
    local function u759(p756) --[[ Line: 3767 ]]
        -- upvalues: l__EffectAssets__5 (ref), u740 (copy), u742 (copy), u739 (copy), l__Effects__9 (ref)
        local v757 = l__EffectAssets__5.MonarchWaveSurface:Clone();
        local v758 = u740;
        local l__Unit__100 = u742.Unit;
        local l__Unit__101 = (v758 + l__Unit__100 * (p756 - v758):Dot(l__Unit__100) - p756).Unit;
        v757.CFrame = CFrame.lookAt(p756, p756 + l__Unit__101);
        u739:_x04f10495a3010e73(v757);
        v757.Parent = l__Effects__9;
        game.Debris:AddItem(v757, 4.5);
    end;
    OverlapParams.new();
    task.spawn(function() --[[ Line: 3791 ]]
        -- upvalues: u740 (copy), u742 (copy), l__EffectAssets__5 (ref), u739 (copy), l__Effects__9 (ref), l__Classes__3 (ref), u759 (copy)
        for v760 = 1, 20 do
            local v761 = u740 + u742 * ((v760 - 1) * 50);
            local v762 = l__EffectAssets__5.MonarchShockwave:Clone();
            v762.CFrame = CFrame.lookAt(v761, v761 + u742);
            u739:_x04f10495a3010e73(v762);
            v762.Parent = l__Effects__9;
            game.Debris:AddItem(v762, 3);
            local v763 = workspace:Raycast(v761, Vector3.new(-0, -20, -0), l__Classes__3.Util:getBasicRaycastParams());
            if v763 then
                u759(v763.Position);
            end;
            task.wait(0.033);
        end;
    end);
    local v764 = workspace:Raycast(u740, u742 * 2000, l__Classes__3.Util:getBasicRaycastParams());
    if not v764 then
        return;
    end;
    local v765 = l__EffectAssets__5.MonarchImpact:Clone();
    local l__Position__102 = v764.Position;
    local l__Normal__103 = v764.Normal;
    v765.CFrame = CFrame.lookAt(l__Position__102 + l__Normal__103 * 0.05, l__Position__102 + l__Normal__103 * 1.05);
    local l__Debris__104 = v765.Attachment.Debris;
    local l__Parent__105 = v765.Attachment.Debris.Parent;
    local v766;
    if l__Parent__105 then
        local v767;
        if l__Parent__105:IsA("Attachment") then
            v767 = l__Parent__105.WorldCFrame;
            v766 = v767:VectorToObjectSpace(Vector3.new(0, -50, 0));
            l__Debris__104.Acceleration = v766;
            v765.Parent = l__Effects__9;
            u739:_x04f10495a3010e73(v765);
            game.Debris:AddItem(v765, 5);
            return;
        end;
        if l__Parent__105:IsA("BasePart") then
            v767 = l__Parent__105.CFrame;
            v766 = v767:VectorToObjectSpace(Vector3.new(0, -50, 0));
            l__Debris__104.Acceleration = v766;
            v765.Parent = l__Effects__9;
            u739:_x04f10495a3010e73(v765);
            game.Debris:AddItem(v765, 5);
            return;
        end;
        v766 = Vector3.new(0, -50, 0);
    else
        v766 = Vector3.new(0, -50, 0);
    end;
    l__Debris__104.Acceleration = v766;
    v765.Parent = l__Effects__9;
    u739:_x04f10495a3010e73(v765);
    game.Debris:AddItem(v765, 5);
end;
function u1._xdef95fcd4ad75393(p768, u769) --[[ Line: 3823 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy)
    local u770 = l__EffectAssets__5.ImpactFrame:Clone();
    local function u774() --[[ Line: 3827 ]]
        -- upvalues: u769 (copy), l__Classes__3 (ref)
        local v771;
        if u769:FindFirstChild("Head") then
            v771 = u769.Head.Position;
        else
            v771 = l__Classes__3.Util:getLikelyVec3(u769);
        end;
        local v772, v773 = workspace.CurrentCamera:WorldToViewportPoint(v771);
        if v773 then
            return UDim2.fromOffset(v772.X, v772.Y);
        else
            return l__Classes__3.Util:getBoundaryUDimFromPosition(workspace.CurrentCamera, v771);
        end;
    end;
    local function u776(p775) --[[ Line: 3845 ]]
        -- upvalues: u770 (copy)
        u770.Main.Position = p775;
        u770.Main.First.Rotation = math.random(0, 360);
        u770.Main.Second.Rotation = math.random(0, 360);
        u770.Main.Third.Rotation = math.random(0, 360);
        u770.Background1.Position = p775;
        u770.Background2.Position = p775;
        u770.Shear1.Rotation = math.random(0, 360);
        u770.Shear2.Rotation = math.random(0, 360);
        u770.Shear3.Rotation = math.random(0, 360);
    end;
    u776((u774()));
    u770.Parent = p768._xf27c081d7e69cea6;
    p768:_x4d70b7dadc9e06ab(1.2, 3.5);
    task.delay(0.05, function() --[[ Line: 3868 ]]
        -- upvalues: u770 (copy), u776 (copy), u774 (copy)
        if u770 and u770.Parent then
            u776((u774()));
            u770.Main.Size = UDim2.fromScale(0.25, 0.25);
            u770.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            for _, v777 in u770:GetDescendants() do
                if v777:IsA("ImageLabel") then
                    v777.ImageColor3 = Color3.fromRGB(0, 0, 0);
                end;
            end;
        end;
    end);
    game.Debris:AddItem(u770, 0.1);
end;
function u1._xe37ffef56b69a86f(u778, p779, p780) --[[ Line: 3883 ]]
    -- upvalues: l__Classes__3 (copy), l__EffectAssets__5 (copy), l__Effects__9 (copy), l__TweenService__1 (copy), l__RunService__2 (copy)
    local u781 = l__Classes__3.Util:getLikelyVec3(p779);
    local u782 = l__Classes__3.Util:getLikelyVec3(p780) - u781;
    if u782.Magnitude > 1e-6 then
        u782 = u782.Unit;
    end;
    local v783 = l__EffectAssets__5.MonarchFlash:Clone();
    v783.CFrame = CFrame.lookAt(u781 + u782 * 2, u781 + u782 * 10);
    v783.Parent = l__Effects__9;
    game.Debris:AddItem(v783, 4);
    l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("MONARCH_SHOT", true, {
        location = u781
    });
    u778:_x04f10495a3010e73(v783);
    local l__Bullet__106 = v783.Bullet;
    local v784 = u781 + u782 * 2000;
    local v785 = TweenInfo.new(0.33, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
    l__Bullet__106.CFrame = CFrame.lookAt(u781 + u782 * 2, u781 + -u782 * 2000);
    l__TweenService__1:Create(l__Bullet__106, v785, {
        Size = Vector3.new(1, 1, 3000)
    }):Play();
    l__TweenService__1:Create(l__Bullet__106, v785, {
        Position = v784
    }):Play();
    game.Debris:AddItem(l__Bullet__106, 0.33);
    local l__Position__107 = workspace.CurrentCamera.CFrame.Position;
    local v786 = v784 - u781;
    local v787 = (l__Position__107 - u781):Dot(v786) / v786:Dot(v786);
    local v788 = u781 + v786 * math.clamp(v787, 0, 1);
    local _ = (v788 - u781).Magnitude / 6060.60606060606;
    l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("MONARCH_WHIZZ", true, {
        location = v788
    });
    local l__Twist__108 = v783.Twist;
    local v789 = u781 + u782 * 45;
    local v790 = TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
    local u791 = CFrame.lookAt(u781 + u782 * 2, u781 + -u782 * 2000) * CFrame.Angles(-1.5707963267948966, 0, 0);
    l__Twist__108.CFrame = u791;
    local u792 = Instance.new("Vector3Value");
    u792.Value = u791.Position;
    game.Debris:AddItem(u792, 1.75);
    l__TweenService__1:Create(u792, v790, {
        Value = v789
    }):Play();
    l__TweenService__1:Create(l__Twist__108, v790, {
        Size = Vector3.new(75, 60, 75),
        Transparency = 1
    }):Play();
    local u793 = 0;
    local u794 = nil;
    u794 = l__RunService__2.RenderStepped:Connect(function(p795) --[[ Line: 3964 ]]
        -- upvalues: u793 (ref), l__Twist__108 (copy), u792 (copy), u791 (copy), u794 (ref)
        u793 = u793 + p795;
        local v796 = math.clamp(u793 / 0.75, 0, 1);
        local v797 = (1 - (1 - v796) ^ 2) * -12.566370614359172;
        l__Twist__108.CFrame = CFrame.new(u792.Value) * (u791 - u791.Position) * CFrame.Angles(0, v797, 0);
        if v796 >= 1 then
            u794:Disconnect();
        end;
    end);
    local u798 = l__EffectAssets__5.MonarchTracer:Clone();
    u798.Start.Position = u781;
    u798.End.Position = u781;
    u798.Parent = l__Effects__9;
    l__TweenService__1:Create(u798.End, v785, {
        Position = v784
    }):Play();
    l__TweenService__1:Create(u798.num, TweenInfo.new(3, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Value = 1
    }):Play();
    l__TweenService__1:Create(u798.Trail, TweenInfo.new(3, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Width0 = 1,
        Width1 = 1
    }):Play();
    u798.num.Changed:Connect(function() --[[ Line: 3991 ]]
        -- upvalues: u798 (copy)
        if u798 and u798.Parent then
            u798.Trail.Transparency = NumberSequence.new(u798.num.Value);
        end;
    end);
    game.Debris:AddItem(u798, 3);
    local function u802(p799) --[[ Line: 4010 ]]
        -- upvalues: l__EffectAssets__5 (ref), u781 (copy), u782 (ref), u778 (copy), l__Effects__9 (ref)
        local v800 = l__EffectAssets__5.MonarchWaveSurface:Clone();
        local v801 = u781;
        local l__Unit__109 = u782.Unit;
        local l__Unit__110 = (v801 + l__Unit__109 * (p799 - v801):Dot(l__Unit__109) - p799).Unit;
        v800.CFrame = CFrame.lookAt(p799, p799 + l__Unit__110);
        u778:_x04f10495a3010e73(v800);
        v800.Parent = l__Effects__9;
        game.Debris:AddItem(v800, 4.5);
    end;
    OverlapParams.new();
    task.spawn(function() --[[ Line: 4034 ]]
        -- upvalues: u781 (copy), u782 (ref), l__EffectAssets__5 (ref), u778 (copy), l__Effects__9 (ref), l__Classes__3 (ref), u802 (copy)
        for v803 = 1, 20 do
            local v804 = u781 + u782 * ((v803 - 1) * 100);
            local v805 = l__EffectAssets__5.MonarchShockwave:Clone();
            v805.CFrame = CFrame.lookAt(v804, v804 + u782);
            u778:_x04f10495a3010e73(v805);
            v805.Parent = l__Effects__9;
            game.Debris:AddItem(v805, 3);
            local v806 = workspace:Raycast(v804, Vector3.new(-0, -20, -0), l__Classes__3.Util:getBasicRaycastParams());
            if v806 then
                u802(v806.Position);
            end;
            task.wait(0.0495);
        end;
    end);
    local v807 = workspace:Raycast(u781, u782 * 2000, l__Classes__3.Util:getBasicRaycastParams());
    if not v807 then
        return;
    end;
    local v808 = l__EffectAssets__5.MonarchImpact:Clone();
    local l__Position__111 = v807.Position;
    local l__Normal__112 = v807.Normal;
    v808.CFrame = CFrame.lookAt(l__Position__111 + l__Normal__112 * 0.05, l__Position__111 + l__Normal__112 * 1.05);
    local l__Debris__113 = v808.Attachment.Debris;
    local l__Parent__114 = v808.Attachment.Debris.Parent;
    local v809;
    if l__Parent__114 then
        local v810;
        if l__Parent__114:IsA("Attachment") then
            v810 = l__Parent__114.WorldCFrame;
            v809 = v810:VectorToObjectSpace(Vector3.new(0, -50, 0));
            l__Debris__113.Acceleration = v809;
            v808.Parent = l__Effects__9;
            u778:_x04f10495a3010e73(v808);
            game.Debris:AddItem(v808, 5);
            return;
        end;
        if l__Parent__114:IsA("BasePart") then
            v810 = l__Parent__114.CFrame;
            v809 = v810:VectorToObjectSpace(Vector3.new(0, -50, 0));
            l__Debris__113.Acceleration = v809;
            v808.Parent = l__Effects__9;
            u778:_x04f10495a3010e73(v808);
            game.Debris:AddItem(v808, 5);
            return;
        end;
        v809 = Vector3.new(0, -50, 0);
    else
        v809 = Vector3.new(0, -50, 0);
    end;
    l__Debris__113.Acceleration = v809;
    v808.Parent = l__Effects__9;
    u778:_x04f10495a3010e73(v808);
    game.Debris:AddItem(v808, 5);
end;
function u1._x97b5f496c7cc0958(u811, u812) --[[ Line: 4066 ]]
    -- upvalues: l__Trove__7 (copy), l__UIAssets__4 (copy), l__EffectAssets__5 (copy), l__Classes__3 (copy), l__TweenService__1 (copy), l__Effects__9 (copy)
    local u813 = l__Trove__7.new();
    local l__LocalPlayer__115 = game.Players.LocalPlayer;
    local l__Character__116 = l__LocalPlayer__115.Character;
    local l__PlayerGui__117 = l__LocalPlayer__115.PlayerGui;
    local l__Lighting__118 = game:GetService("Lighting");
    local u814 = l__UIAssets__4.ScopeScreen:Clone();
    u813:Add(u814);
    local u815 = u812 - workspace:GetServerTimeNow();
    local l__Brightness__119 = l__Lighting__118.Brightness;
    l__Lighting__118.Brightness = 6;
    local l__ScopedCC__120 = u814.ScopedCC;
    local l__ScopedCC2__121 = u814.ScopedCC2;
    local l__ScopedCC3__122 = u814.ScopedCC3;
    l__ScopedCC__120.Parent = l__Lighting__118;
    l__ScopedCC2__121.Parent = l__Lighting__118;
    l__ScopedCC3__122.Parent = l__Lighting__118;
    u813:Add(l__ScopedCC__120);
    u813:Add(l__ScopedCC2__121);
    u813:Add(l__ScopedCC3__122);
    local u816 = Color3.fromRGB(255, 0, 0);
    local u817 = {};
    local u818 = {};
    local u819 = 1;
    local u820 = {};
    local function v822(p821) --[[ Line: 4109 ]]
        -- upvalues: u818 (copy), u820 (copy), u817 (copy)
        if u818[p821] or u820[p821] then
        else
            u818[p821] = true;
            u817[#u817 + 1] = p821;
        end;
    end;
    local function u826(p823) --[[ Line: 4118 ]]
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
    local function u830(p827) --[[ Line: 4142 ]]
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
    local function u864(p831, p832) --[[ Line: 4165 ]]
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
    local function u870(p865, p866, p867) --[[ Line: 4233 ]]
        -- upvalues: l__EffectAssets__5 (ref), u816 (copy), u811 (copy), u813 (copy), u820 (copy), u830 (copy)
        local v868 = l__EffectAssets__5.BoxHighlight:Clone();
        v868.BackgroundColor3 = u816;
        v868.Visible = false;
        v868.Parent = u811._xf27c081d7e69cea6;
        u813:Add(v868);
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
    local function u877(p871, p872, p873) --[[ Line: 4256 ]]
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
    local function u883(p878, p879) --[[ Line: 4287 ]]
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
    local function u897(p884, p885, p886, p887) --[[ Line: 4310 ]]
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
        u813:Connect(v898.ChildAdded, v822);
        u813:Connect(v898.ChildRemoved, function(p900) --[[ Line: 4382 ]]
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
    l__TweenService__1:Create(l__ScopedCC3__122, TweenInfo.new(u815 / 3, Enum.EasingStyle.Linear), {
        Size = 0
    }):Play();
    local v902 = TweenInfo.new(u815, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
    local v903 = TweenInfo.new(u815, Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
    local v904 = TweenInfo.new(u815 / 1.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
    l__TweenService__1:Create(u814.Main, v902, {
        Size = UDim2.fromScale(0.66, 0.66),
        Position = UDim2.fromScale(0.5, 0.5)
    }):Play();
    u814.Parent = l__PlayerGui__117;
    l__TweenService__1:Create(u814.Main.Lines.Line2, v904, {
        Position = UDim2.fromScale(0.5, 0.7)
    }):Play();
    l__TweenService__1:Create(u814.Main.Lines.Line3, v903, {
        Position = UDim2.fromScale(0.5, 0.8)
    }):Play();
    l__TweenService__1:Create(u814.Main.Lines.Line4, v904, {
        Position = UDim2.fromScale(0.5, 0.3)
    }):Play();
    l__TweenService__1:Create(u814.Main.Lines.Line5, v903, {
        Position = UDim2.fromScale(0.5, 0.2)
    }):Play();
    l__TweenService__1:Create(u814.Main.Lines.Line1, v904, {
        Position = UDim2.fromScale(0.5, 0.4)
    }):Play();
    l__TweenService__1:Create(u814.Main.Lines.Line6, v904, {
        Position = UDim2.fromScale(0.5, 0.6)
    }):Play();
    local l___x81af12119ee977ea__127 = l__Classes__3._x3019cc5b1f776551._x81af12119ee977ea;
    local u905;
    if l___x81af12119ee977ea__127 then
        u905 = nil;
    else
        u905 = l__Classes__3._x3019cc5b1f776551._x38a4648a006d6ac6;
        l__Classes__3._x3019cc5b1f776551._x38a4648a006d6ac6 = 0.1;
    end;
    for _, v906 in u814:GetDescendants() do
        local v907 = ({
            ImageLabel = "ImageTransparency",
            UIStroke = "Transparency",
            Frame = "BackgroundTransparency"
        })[v906.ClassName];
        if v907 and v906[v907] ~= 1 then
            local v908 = v906[v907];
            v906[v907] = 1;
            l__TweenService__1:Create(v906, TweenInfo.new(u815, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                [v907] = v908
            }):Play();
        end;
    end;
    local l__InvertedSphere__128 = u814.InvertedSphere;
    l__TweenService__1:Create(l__InvertedSphere__128, TweenInfo.new(u815, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = Vector3.new(1000, 1000, 1000)
    }):Play();
    l__TweenService__1:Create(l__InvertedSphere__128, TweenInfo.new(u815, Enum.EasingStyle.Linear), {
        Transparency = 1
    }):Play();
    l__Classes__3._xe0e88f94014b801e._xa2afa8ee69af4cfa = true;
    if l__PlayerGui__117:FindFirstChild("GameplayUI") then
        l__PlayerGui__117.GameplayUI.Enabled = false;
    end;
    l__Classes__3._x6dbba03a0636f7d8:_x282746dbf42c87cb("NIGHT_VISION", true);
    local u909 = workspace:GetServerTimeNow();
    local function u912() --[[ Line: 4451 ]]
        -- upvalues: l__Lighting__118 (copy), l__Brightness__119 (copy), u820 (copy), u813 (copy), l__Classes__3 (ref), l__PlayerGui__117 (copy), l___x81af12119ee977ea__127 (copy), u905 (ref)
        l__Lighting__118.Brightness = l__Brightness__119;
        for v910, v911 in u820 do
            u820[v910] = nil;
            if v911.box_frame then
                v911.box_frame:Destroy();
            end;
        end;
        u813:Clean();
        l__Classes__3._xe0e88f94014b801e._xa2afa8ee69af4cfa = false;
        if l__PlayerGui__117:FindFirstChild("GameplayUI") and (l__Classes__3._x8399b2bb73e12808._x69155c6c2c2143d0 == "alive" and not l__Classes__3.MenuManager.in_menu) then
            l__PlayerGui__117.GameplayUI.Enabled = true;
        end;
        if not l___x81af12119ee977ea__127 then
            l__Classes__3._x3019cc5b1f776551._x81af12119ee977ea = false;
            l__Classes__3._x3019cc5b1f776551._x38a4648a006d6ac6 = u905;
        end;
    end;
    local l__UIGradient__129 = u814.Main.LeftCharge.RightClip.Right.UIGradient;
    u813:BindToRenderStep("scope", Enum.RenderPriority.Camera.Value + 3, function() --[[ Line: 4470 ]]
        -- upvalues: u812 (copy), u912 (copy), u883 (copy), u820 (copy), u897 (copy), u909 (copy), l__Classes__3 (ref), u815 (copy), u815 (copy), l__TweenService__1 (ref), l__UIGradient__129 (copy), u814 (copy), l__InvertedSphere__128 (copy)
        local v913 = workspace:GetServerTimeNow();
        if u812 <= v913 then
            u912();
        else
            local l__CurrentCamera__130 = workspace.CurrentCamera;
            if l__CurrentCamera__130 then
                u883(l__CurrentCamera__130, v913);
                for v914, v915 in u820 do
                    u897(v914, v915, l__CurrentCamera__130, v913);
                end;
            end;
            local v916 = v913 - u909;
            local v917 = l__Classes__3.Util:convNumRange(v916, 0, u815, 0, 1);
            local v918 = l__TweenService__1:GetValue(l__Classes__3.Util:convNumRange(v916, 0, u815, 0, 1), Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
            local v919 = l__Classes__3.Util:numLerp(85, 45, v918);
            if l__CurrentCamera__130 then
                l__CurrentCamera__130.FieldOfView = v919;
            end;
            local v920 = l__Classes__3.Util:numLerp(0, 90, v917);
            l__UIGradient__129.Rotation = v920;
            u814.Main.LeftCharge.Rotation = 180 - v920 / 2;
            if l__CurrentCamera__130 then
                l__InvertedSphere__128.Position = l__CurrentCamera__130.CFrame.Position;
            end;
        end;
    end);
    l__InvertedSphere__128.Parent = l__Effects__9;
    game.Debris:AddItem(l__InvertedSphere__128, u815);
    u813:Add(l__InvertedSphere__128);
    return u912;
end;
function u1._x44bcd6af41218f92(u921) --[[ Line: 4511 ]]
    -- upvalues: u2 (ref), l__Classes__3 (copy), u3 (ref), u4 (ref), l__EffectAssets__5 (copy), u5 (ref)
    u2 = l__Classes__3._x1a4ce4062771e36e;
    u3 = l__Classes__3.Util;
    u4 = u921._xeea1787ee1726109;
    local l__PlayerGui__131 = game.Players.LocalPlayer.PlayerGui;
    u921._xf27c081d7e69cea6.Parent = l__PlayerGui__131;
    u921._xeca229b8e757f446.Parent = l__PlayerGui__131;
    task.defer(function() --[[ Line: 4519 ]]
        -- upvalues: l__EffectAssets__5 (ref), u2 (ref), u5 (ref), u921 (copy)
        game:GetService("ContentProvider"):PreloadAsync({ l__EffectAssets__5.PhoenixFlash });
        if u2 then
            u5 = u2._x0aa5621fbcbe69df;
            u921:_x26d3cf709bd45264();
            u921:_x5d70cb7dced04a93();
        end;
        u921:_xfbdc995dd8bd9380();
    end);
end;
return u1;
