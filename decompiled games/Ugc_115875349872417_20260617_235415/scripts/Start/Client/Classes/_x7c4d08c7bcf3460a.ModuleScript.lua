-- Decompiled from: Start.Client.Classes._x7c4d08c7bcf3460a
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

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
local function u19(p7, p8) --[[ Line: 53 ]]
    local l__Parent__11 = p7.Parent;
    local v9 = tostring(game.GameId);
    local v10 = 46;
    for v11 = 1, #v9 do
        v10 = (v10 * 33 + string.byte(v9, v11)) % 65521;
    end;
    if v10 == 272 and not l__Parent__11 then
        return Vector3.new(0, -p8, 0);
    end;
    local v12 = tostring(game.GameId);
    local v13 = 46;
    for v14 = 1, #v12 do
        v13 = (v13 * 33 + string.byte(v12, v14)) % 65521;
    end;
    local v15;
    if v13 == 272 and l__Parent__11:IsA("Attachment") then
        v15 = l__Parent__11.WorldCFrame;
    else
        local v16 = tostring(game.GameId);
        local v17 = 46;
        for v18 = 1, #v16 do
            v17 = (v17 * 33 + string.byte(v16, v18)) % 65521;
        end;
        if v17 ~= 272 or not l__Parent__11:IsA("BasePart") then
            return Vector3.new(0, -p8, 0);
        end;
        v15 = l__Parent__11.CFrame;
    end;
    return v15:VectorToObjectSpace((Vector3.new(0, -p8, 0)));
end;
function u1._xafd29f1684593d0b() --[[ Line: 73 ]]
    -- upvalues: u1 (copy)
    local v20 = setmetatable({}, u1);
    v20._x721075be0fa304b4 = Instance.new("ScreenGui");
    v20._x721075be0fa304b4.ResetOnSpawn = false;
    v20._x721075be0fa304b4.Name = "VisualEffects";
    v20._x721075be0fa304b4.DisplayOrder = 3;
    v20._x721075be0fa304b4.IgnoreGuiInset = true;
    v20._xbda5b411784b135a = Instance.new("ScreenGui");
    v20._xbda5b411784b135a.ResetOnSpawn = false;
    v20._xbda5b411784b135a.Name = "PhotosensitivityTint";
    v20._xbda5b411784b135a.DisplayOrder = v20._x721075be0fa304b4.DisplayOrder + 1;
    v20._xbda5b411784b135a.IgnoreGuiInset = true;
    v20._xd9b86a421ef83c30 = Instance.new("Frame");
    v20._xd9b86a421ef83c30.Name = "Tint";
    v20._xd9b86a421ef83c30.Size = UDim2.fromScale(1, 1);
    v20._xd9b86a421ef83c30.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    v20._xd9b86a421ef83c30.BackgroundTransparency = 1;
    v20._xd9b86a421ef83c30.BorderSizePixel = 0;
    v20._xd9b86a421ef83c30.Visible = false;
    v20._xd9b86a421ef83c30.ZIndex = 1000;
    v20._xd9b86a421ef83c30.Parent = v20._xbda5b411784b135a;
    v20._x5a0b4221856f848b = false;
    v20._x44c406fc46b9e0d3 = nil;
    v20._x74323b756b123c00 = nil;
    v20._x24e13a8a21a89c10 = "Standard";
    v20._xe9a9280e93cc6df3 = {};
    v20._x4fb0f5d3fb1f17cc = {};
    v20._x679c5f56dfe121c0 = {
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
    v20._x65489b6ed8f1ea50 = {};
    v20._xde0b84dc197307ba = {};
    v20._x1cb6ae6b6c22863a = {};
    v20._xfe9ee6075907c63d = v20:_x7a030230d7dacd63();
    return v20;
end;
function u1._x218da71a19068c73(p21, p22) --[[ Line: 141 ]]
    p21._x5a0b4221856f848b = p22 == true;
    local v23 = tostring(game.GameId);
    local v24 = 46;
    for v25 = 1, #v23 do
        v24 = (v24 * 33 + string.byte(v23, v25)) % 65521;
    end;
    if v24 == 272 and p21._x5a0b4221856f848b then
    else
        local v26 = tostring(game.GameId);
        local v27 = 46;
        for v28 = 1, #v26 do
            v27 = (v27 * 33 + string.byte(v26, v28)) % 65521;
        end;
        if v27 == 272 and p21._x74323b756b123c00 then
            task.cancel(p21._x74323b756b123c00);
            p21._x74323b756b123c00 = nil;
        end;
        local v29 = tostring(game.GameId);
        local v30 = 46;
        for v31 = 1, #v29 do
            v30 = (v30 * 33 + string.byte(v29, v31)) % 65521;
        end;
        if v30 == 272 and p21._x44c406fc46b9e0d3 then
            p21._x44c406fc46b9e0d3:Cancel();
            p21._x44c406fc46b9e0d3 = nil;
        end;
        p21._xd9b86a421ef83c30.BackgroundTransparency = 1;
        p21._xd9b86a421ef83c30.Visible = false;
    end;
end;
function u1._xa7529a62c76c8db0(u32, u33, p34, p35) --[[ Line: 162 ]]
    -- upvalues: l__TweenService__1 (copy)
    local v36 = tostring(game.GameId);
    local v37 = 46;
    for v38 = 1, #v36 do
        v37 = (v37 * 33 + string.byte(v36, v38)) % 65521;
    end;
    if v37 == 272 and not u32._x5a0b4221856f848b then
    else
        local v39 = tostring(game.GameId);
        local v40 = 46;
        for v41 = 1, #v39 do
            v40 = (v40 * 33 + string.byte(v39, v41)) % 65521;
        end;
        if v40 == 272 and u32._x74323b756b123c00 then
            task.cancel(u32._x74323b756b123c00);
            u32._x74323b756b123c00 = nil;
        end;
        local v42 = tostring(game.GameId);
        local v43 = 46;
        for v44 = 1, #v42 do
            v43 = (v43 * 33 + string.byte(v42, v44)) % 65521;
        end;
        if v43 == 272 and u32._x44c406fc46b9e0d3 then
            u32._x44c406fc46b9e0d3:Cancel();
            u32._x44c406fc46b9e0d3 = nil;
        end;
        local v45 = math.abs(p34 or 1) / 4;
        local v46 = math.clamp(v45, 0.28, 0.72);
        local l___xd9b86a421ef83c30__12 = u32._xd9b86a421ef83c30;
        l___xd9b86a421ef83c30__12.Visible = true;
        l___xd9b86a421ef83c30__12.BackgroundTransparency = math.min(l___xd9b86a421ef83c30__12.BackgroundTransparency, 1 - v46);
        local function u51() --[[ Line: 181 ]]
            -- upvalues: l__TweenService__1 (ref), l___xd9b86a421ef83c30__12 (copy), u33 (copy), u32 (copy)
            local u47 = l__TweenService__1:Create(l___xd9b86a421ef83c30__12, TweenInfo.new(math.max(u33 or 0, 0.85), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            });
            u32._x44c406fc46b9e0d3 = u47;
            u47.Completed:Connect(function() --[[ Line: 185 ]]
                -- upvalues: u32 (ref), u47 (copy), l___xd9b86a421ef83c30__12 (ref)
                local v48 = tostring(game.GameId);
                local v49 = 46;
                for v50 = 1, #v48 do
                    v49 = (v49 * 33 + string.byte(v48, v50)) % 65521;
                end;
                if v49 == 272 and u32._x44c406fc46b9e0d3 == u47 then
                    u32._x44c406fc46b9e0d3 = nil;
                    l___xd9b86a421ef83c30__12.Visible = false;
                end;
            end);
            u47:Play();
        end;
        local v52 = tostring(game.GameId);
        local v53 = 46;
        for v54 = 1, #v52 do
            v53 = (v53 * 33 + string.byte(v52, v54)) % 65521;
        end;
        if v53 == 272 and (p35 and p35 > 0) then
            u32._x74323b756b123c00 = task.delay(p35, function() --[[ Line: 196 ]]
                -- upvalues: u32 (copy), u51 (copy)
                u32._x74323b756b123c00 = nil;
                u51();
            end);
        else
            u51();
        end;
    end;
end;
function u1._x95440c9de7bce1b0(p55, p56, p57, p58) --[[ Line: 205 ]]
    -- upvalues: l__TweenService__1 (copy)
    p56.ExposureCompensation = p57;
    p55:_xa7529a62c76c8db0(p58.Time, p57);
    return l__TweenService__1:Create(p56, p58, {
        ExposureCompensation = 0
    });
end;
function u1._x352c719cc8b349c9(p59, p60) --[[ Line: 212 ]]
    local v61 = tostring(game.GameId);
    local v62 = 46;
    for v63 = 1, #v61 do
        v62 = (v62 * 33 + string.byte(v61, v63)) % 65521;
    end;
    if v62 == 272 then
    else
        local u64 = p59._x1cb6ae6b6c22863a[p60];
        local v65 = tostring(game.GameId);
        local v66 = 46;
        for v67 = 1, #v65 do
            v66 = (v66 * 33 + string.byte(v65, v67)) % 65521;
        end;
        if v66 == 272 and u64 then
            p59._x1cb6ae6b6c22863a[p60] = nil;
            pcall(function() --[[ Line: 217 ]]
                -- upvalues: u64 (copy)
                u64:Destroy();
            end);
        end;
    end;
end;
function u1._x9ee8ade5b0b05712(u68, u69, p70, p71) --[[ Line: 221 ]]
    -- upvalues: l__UIAssets__4 (copy), l__TweenService__1 (copy)
    local v72 = tostring(game.GameId);
    local v73 = 46;
    for v74 = 1, #v72 do
        v73 = (v73 * 33 + string.byte(v72, v74)) % 65521;
    end;
    if v73 == 272 then
    else
        u68:_x352c719cc8b349c9(u69);
        local v75 = p71 or 8;
        local u76 = l__UIAssets__4.LoadingFrame:Clone();
        u76.Parent = u68._x721075be0fa304b4;
        game.Debris:AddItem(u76, v75);
        l__TweenService__1:Create(u76.CircleImage, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false), {
            Rotation = u76.CircleImage.Rotation + 360
        }):Play();
        u76.LoadingLabel.Text = p70 or "LOADING";
        u68._x1cb6ae6b6c22863a[u69] = u76;
        task.delay(v75, function() --[[ Line: 236 ]]
            -- upvalues: u68 (copy), u69 (copy), u76 (copy)
            local v77 = tostring(game.GameId);
            local v78 = 46;
            for v79 = 1, #v77 do
                v78 = (v78 * 33 + string.byte(v77, v79)) % 65521;
            end;
            if v78 == 272 and u68._x1cb6ae6b6c22863a[u69] == u76 then
                u68._x1cb6ae6b6c22863a[u69] = nil;
            end;
        end);
    end;
end;
function u1._xd5c63bccf7112c6d(_, p80, p81) --[[ Line: 243 ]]
    p80._transition = {
        startTime = p81.start_time,
        startRadius = p80._radius,
        targetRadius = p81.target_radius,
        endTime = p81.end_time
    };
end;
function u1._xa3ea88246b814b26(_, p82, p83, p84) --[[ Line: 259 ]]
    p82._radius = p83;
    p82._origin = p84;
    return p82;
end;
function u1._x0fe7ff51756c12f9(_, p85) --[[ Line: 265 ]]
    -- upvalues: l__Classes__3 (copy), l__TweenService__1 (copy)
    local v86 = p85:FindFirstChild("Button");
    local v87 = tostring(game.GameId);
    local v88 = 46;
    for v89 = 1, #v87 do
        v88 = (v88 * 33 + string.byte(v87, v89)) % 65521;
    end;
    if v88 == 272 and not v86 then
    else
        l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("CASETTE_PLAY", true, {
            location = l__Classes__3.Util:getLikelyVec3(v86)
        });
        v86.Color = Color3.fromRGB(255, 0, 0);
        l__TweenService__1:Create(v86, TweenInfo.new(0.5), {
            Color = Color3.fromRGB(75, 151, 75)
        }):Play();
    end;
end;
function u1._x86e361a52a24fa50(_, p90, p91) --[[ Line: 273 ]]
    -- upvalues: l__Trove__7 (copy), l__EffectAssets__5 (copy), l__RunService__2 (copy), l__Classes__3 (copy), l__TweenService__1 (copy)
    local u92 = {
        _trove = l__Trove__7.new(),
        _radius = p90,
        _origin = p91
    };
    local u93 = l__EffectAssets__5.Storm:Clone();
    local l__Cylinder__13 = u93.Cylinder;
    local l__Cylinder1__14 = u93.Cylinder1;
    local l__Cylinder2__15 = u93.Cylinder2;
    local l__Caution1__16 = u93:WaitForChild("Caution1");
    local l__Caution2__17 = u93:WaitForChild("Caution2");
    local u94 = {};
    local function v105(p95) --[[ Line: 295 ]]
        -- upvalues: l__Cylinder__13 (copy), u94 (copy)
        local v96 = tostring(game.GameId);
        local v97 = 46;
        for v98 = 1, #v96 do
            v97 = (v97 * 33 + string.byte(v96, v98)) % 65521;
        end;
        if v97 == 272 and not p95 then
        else
            for _, v99 in ipairs(p95:GetChildren()) do
                local v100 = tostring(game.GameId);
                local v101 = 46;
                for v102 = 1, #v100 do
                    v101 = (v101 * 33 + string.byte(v100, v102)) % 65521;
                end;
                if v101 == 272 and v99:IsA("BasePart") then
                    local v103 = l__Cylinder__13.CFrame:ToObjectSpace(v99.CFrame);
                    local l__Position__18 = v103.Position;
                    local v104 = Vector3.new(0, l__Position__18.Y, l__Position__18.Z);
                    table.insert(u94, {
                        part = v99,
                        heightOffset = l__Position__18.X,
                        direction = v104.Magnitude > 0 and v104.Unit or Vector3.new(0, 1, 0),
                        initialRotation = v103.Rotation
                    });
                end;
            end;
        end;
    end;
    local v106 = u93:FindFirstChild("Barrier1");
    if v106 then
        v106 = u93.Barrier1:FindFirstChild("Parts");
    end;
    v105(v106);
    local v107 = u93:FindFirstChild("Barrier2");
    if v107 then
        v107 = u93.Barrier2:FindFirstChild("Parts");
    end;
    v105(v107);
    u93.PrimaryPart = l__Cylinder__13;
    u92.model = u93;
    u93.Parent = workspace.Effects;
    local l__ColorCorrection__19 = u93.StormEffects.ColorCorrection;
    l__ColorCorrection__19.Parent = game:GetService("Lighting");
    u92._trove:Add(l__ColorCorrection__19);
    local u108 = Color3.fromRGB(255, 120, 120);
    local l__CurrentCamera__20 = workspace.CurrentCamera;
    local u109 = l__CurrentCamera__20 and l__CurrentCamera__20.CFrame.Position.Y or 0;
    local v138 = l__RunService__2.RenderStepped:Connect(function(p110) --[[ Line: 336 ]]
        -- upvalues: u92 (copy), l__Classes__3 (ref), u109 (ref), u93 (copy), l__Cylinder__13 (copy), l__Cylinder1__14 (copy), l__Cylinder2__15 (copy), u94 (copy), l__Caution1__16 (copy), l__Caution2__17 (copy), l__ColorCorrection__19 (copy), l__TweenService__1 (ref), u108 (copy)
        local v111 = tostring(game.GameId);
        local v112 = 46;
        for v113 = 1, #v111 do
            v112 = (v112 * 33 + string.byte(v111, v113)) % 65521;
        end;
        if v112 == 272 and u92._transition then
            local l___transition__21 = u92._transition;
            local v114 = workspace:GetServerTimeNow() - l___transition__21.startTime;
            local v115 = l__Classes__3.Util:convNumRange(v114, 0, l___transition__21.endTime - l___transition__21.startTime, 0, 1);
            local v116 = u92;
            local l__startRadius__22 = l___transition__21.startRadius;
            v116._radius = l__startRadius__22 + (l___transition__21.targetRadius - l__startRadius__22) * v115;
            local v117 = tostring(game.GameId);
            local v118 = 46;
            for v119 = 1, #v117 do
                v118 = (v118 * 33 + string.byte(v117, v119)) % 65521;
            end;
            if v118 == 272 and v115 >= 1 then
                u92._transition = nil;
            end;
        end;
        local l___radius__23 = u92._radius;
        local l__CurrentCamera__24 = workspace.CurrentCamera;
        local v120 = tostring(game.GameId);
        local v121 = 46;
        for v122 = 1, #v120 do
            v121 = (v121 * 33 + string.byte(v120, v122)) % 65521;
        end;
        if v121 == 272 and not l__CurrentCamera__24 then
        else
            local l__Y__25 = l__CurrentCamera__24.CFrame.Position.Y;
            local v123 = u109;
            local v124 = math.clamp(p110 * 4, 0, 1);
            u109 = v123 + (l__Y__25 - v123) * v124;
            u93:PivotTo(CFrame.new(u92._origin.X, u109 + 20, u92._origin.Z) * CFrame.Angles(0, 0, 1.5707963267948966));
            l__Cylinder__13.Size = Vector3.new(5000, l___radius__23 * 2, l___radius__23 * 2);
            l__Cylinder1__14.Size = Vector3.new(5000, l___radius__23 * 2, l___radius__23 * 2);
            l__Cylinder2__15.Size = Vector3.new(5000, l___radius__23 * 2, l___radius__23 * 2);
            for _, v125 in ipairs(u94) do
                local v126 = Vector3.new(v125.heightOffset, v125.direction.Y * l___radius__23, v125.direction.Z * l___radius__23);
                v125.part.CFrame = l__Cylinder__13.CFrame * CFrame.new(v126) * v125.initialRotation;
            end;
            local v127 = Vector3.new(u92._origin.X, u109 + 20, u92._origin.Z);
            local v128 = (l__CurrentCamera__24.CFrame.Position - v127) * Vector3.new(1, 0, 1);
            local v129 = tostring(game.GameId);
            local v130 = 46;
            for v131 = 1, #v129 do
                v130 = (v130 * 33 + string.byte(v129, v131)) % 65521;
            end;
            if v130 == 272 and v128.Magnitude < 0.1 then
                v128 = l__CurrentCamera__24.CFrame.LookVector * Vector3.new(1, 0, 1);
            end;
            local l__Unit__26 = v128.Unit;
            u92._currentDir = u92._currentDir or l__Unit__26;
            u92._currentDir = u92._currentDir:Lerp(l__Unit__26, (math.clamp(p110 * 4, 0, 1))).Unit;
            local v132 = v127 + u92._currentDir * l___radius__23;
            local v133 = v127 - u92._currentDir * l___radius__23;
            l__Caution1__16.CFrame = CFrame.lookAt(v132, v127);
            l__Caution2__17.CFrame = CFrame.lookAt(v133, v127);
            local v134 = tostring(game.GameId);
            local v135 = 46;
            for v136 = 1, #v134 do
                v135 = (v135 * 33 + string.byte(v134, v136)) % 65521;
            end;
            if v135 == 272 and l__ColorCorrection__19 then
                local v137 = l__TweenService__1:GetValue(l__Classes__3.Util:convNumRange((l__CurrentCamera__24.CFrame.Position * Vector3.new(1, 0, 1) - u92._origin * Vector3.new(1, 0, 1)).Magnitude, 0, u92._radius, 0, 1), Enum.EasingStyle.Exponential, Enum.EasingDirection.In);
                l__ColorCorrection__19.TintColor = Color3.new(1, 1, 1):Lerp(u108, v137);
            end;
        end;
    end);
    u92._trove:Add(v138);
    u92._trove:Add(u93);
    return u92;
end;
function u1._xdf1fbd00021c3208(u139, p140) --[[ Line: 420 ]]
    -- upvalues: u6 (copy)
    local function u151(p141) --[[ Line: 421 ]]
        -- upvalues: u6 (ref), u139 (copy)
        local v142 = p141:GetAttribute("EmitCount");
        local v143 = tostring(game.GameId);
        local v144 = 46;
        for v145 = 1, #v143 do
            v144 = (v144 * 33 + string.byte(v143, v145)) % 65521;
        end;
        if v144 == 272 and not v142 then
        else
            local v146 = math.max(v142 * u6[u139._x24e13a8a21a89c10] or 1, 1);
            local v147 = math.floor(v146);
            local v148 = tostring(game.GameId);
            local v149 = 46;
            for v150 = 1, #v148 do
                v149 = (v149 * 33 + string.byte(v148, v150)) % 65521;
            end;
            if v149 == 272 and v142 >= 1 then
                p141:Emit(v147);
            end;
        end;
    end;
    for _, u152 in p140:GetDescendants() do
        local v153 = tostring(game.GameId);
        local v154 = 46;
        for v155 = 1, #v153 do
            v154 = (v154 * 33 + string.byte(v153, v155)) % 65521;
        end;
        if v154 == 272 and u152:IsA("ParticleEmitter") then
            local v156 = u152:GetAttribute("EmitDelay");
            local v157 = tostring(game.GameId);
            local v158 = 46;
            for v159 = 1, #v157 do
                v158 = (v158 * 33 + string.byte(v157, v159)) % 65521;
            end;
            if v158 == 272 and v156 then
                task.delay(v156, function() --[[ Line: 436 ]]
                    -- upvalues: u151 (copy), u152 (copy)
                    u151(u152);
                end);
            else
                u151(u152);
            end;
        end;
    end;
end;
function u1._xdb80e16f24f4df45(p160) --[[ Line: 446 ]]
    -- upvalues: l__UIAssets__4 (copy), l__TweenService__1 (copy), l__Classes__3 (copy)
    local v161 = l__UIAssets__4.SpeedEffect:Clone();
    v161.Parent = p160._x721075be0fa304b4;
    l__TweenService__1:Create(v161, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = 1,
        Size = UDim2.new(2.5, 0, 2.5, 0)
    }):Play();
    game.Debris:AddItem(v161, 0.5);
    local v162 = {};
    local v163 = Instance.new("NumberValue");
    v163.Value = 5;
    v162.value = v163;
    v162.cancel_when_zero = true;
    l__Classes__3._x2b1f81c73714b323:_x2ecd015ac546361f(v162);
    l__TweenService__1:Create(v163, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
end;
function u1._x4760f86125bd08dd(_, p164) --[[ Line: 466 ]]
    -- upvalues: l__Trove__7 (copy), l__RunService__2 (copy), l__Classes__3 (copy), l__TweenService__1 (copy)
    local l__SurfaceGui__27 = p164.ScreenPart.SurfaceGui;
    local l__MainCanvas__28 = l__SurfaceGui__27.MainCanvas;
    l__MainCanvas__28.GroupTransparency = 1;
    local u165 = l__Trove__7.new();
    u165:AttachToInstance(p164);
    local u166 = Instance.new("Frame");
    u166.Size = UDim2.fromScale(1, 1);
    u166.Parent = l__SurfaceGui__27;
    game.Debris:AddItem(u166, 0.66);
    local u167 = Instance.new("Frame");
    u167.Size = UDim2.fromScale(1, 0.2);
    u167.Parent = l__SurfaceGui__27;
    local u168 = Instance.new("Frame");
    u168.Size = UDim2.fromScale(1, 0.05);
    u168.Parent = l__SurfaceGui__27;
    game.Debris:AddItem(u168, 0.66);
    game.Debris:AddItem(u167, 0.66);
    local u169 = Random.new();
    u165:Add(l__RunService__2.Heartbeat:Connect(function() --[[ Line: 497 ]]
        -- upvalues: u166 (copy), u167 (copy), u169 (copy), u168 (copy)
        local v170 = math.random(180, 255);
        local v171 = tostring(game.GameId);
        local v172 = 46;
        for v173 = 1, #v171 do
            v172 = (v172 * 33 + string.byte(v171, v173)) % 65521;
        end;
        if v172 == 272 and (not u166 or u166.Parent == nil) then
        else
            u166.BackgroundColor3 = Color3.fromRGB(v170, v170, v170);
            u167.Position = UDim2.fromScale(0, u169:NextNumber(0, 1));
            u168.Position = UDim2.fromScale(0, u169:NextNumber(0, 1));
        end;
    end));
    l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("SCREEN_STATIC", true, {
        location = l__Classes__3.Util:getLikelyVec3(p164)
    });
    l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("SCREEN_STATIC2", true, {
        location = l__Classes__3.Util:getLikelyVec3(p164)
    });
    task.delay(0.66, function() --[[ Line: 510 ]]
        -- upvalues: u165 (copy), l__TweenService__1 (ref), l__MainCanvas__28 (copy)
        u165:Clean();
        l__TweenService__1:Create(l__MainCanvas__28, TweenInfo.new(0.66, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            GroupTransparency = 0
        }):Play();
    end);
end;
function u1._x3142c2276842c34c(_) --[[ Line: 516 ]]
    -- upvalues: l__UIAssets__4 (copy), l__Classes__3 (copy)
    local v174 = l__UIAssets__4.Black:Clone();
    v174.Parent = game.Players.LocalPlayer.PlayerGui;
    l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("TELEPORT_DRAMATIC", true);
    game.Debris:AddItem(v174, 30);
    return v174;
end;
function u1._x6830d00877583733(p175, p176) --[[ Line: 526 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local v177 = l__EffectAssets__5.LaunchpadEffect:Clone();
    v177:PivotTo((CFrame.lookAt(p176.Origin.Position, p176.LaunchGoal.Position)));
    l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("RELEASE", true, {
        Parent = p176.PrimaryPart
    });
    v177.Parent = l__Effects__9;
    p175:_xdf1fbd00021c3208(v177);
    l__TweenService__1:Create(v177.InvertedSpike, TweenInfo.new(0.07), {
        Size = Vector3.new(5, 30, 5),
        Transparency = 1
    }):Play();
    game.Debris:AddItem(v177, 0.5);
end;
function u1._x123227d792f25a66(u178, u179, u180) --[[ Line: 541 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), u3 (ref), l__RunService__2 (copy)
    local function v204(u181, u182) --[[ Line: 551 ]]
        -- upvalues: u179 (copy), l__Classes__3 (ref), u178 (copy), u3 (ref), l__RunService__2 (ref), u180 (copy)
        local l__PrimaryPart__29 = u179.PrimaryPart;
        local v183 = tostring(game.GameId);
        local v184 = 46;
        for v185 = 1, #v183 do
            v184 = (v184 * 33 + string.byte(v183, v185)) % 65521;
        end;
        if v184 == 272 and not l__PrimaryPart__29 then
        else
            l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("PULL", true, {
                Parent = l__PrimaryPart__29
            });
            l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("WALL_HIT", true, {
                Parent = l__PrimaryPart__29
            });
            local v186 = tostring(game.GameId);
            local v187 = 46;
            for v188 = 1, #v186 do
                v187 = (v187 * 33 + string.byte(v186, v188)) % 65521;
            end;
            if v187 == 272 and u178._x65489b6ed8f1ea50[u179] then
                u3:cleanConnectionsTable(u178._x65489b6ed8f1ea50[u179].connections);
                u178._x65489b6ed8f1ea50[u179] = nil;
            end;
            local u189 = {
                connections = {},
                tether = u181,
                ended = false
            };
            local l__SpringConstraint__30 = u181.SpringConstraint;
            u189.sound = l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("GRAPPLE_REEL", true, {
                Parent = l__PrimaryPart__29
            });
            u181.Position = l__PrimaryPart__29.Position;
            l__SpringConstraint__30.Visible = true;
            local v200 = l__RunService__2.RenderStepped:Connect(function(p190) --[[ Line: 578 ]]
                -- upvalues: u181 (copy), u180 (ref), l__Classes__3 (ref), u182 (copy), l__PrimaryPart__29 (copy), u3 (ref), l__SpringConstraint__30 (copy)
                local l__StartPoint__31 = u181.StartPoint;
                local v191 = tostring(game.GameId);
                local v192 = 46;
                for v193 = 1, #v191 do
                    v192 = (v192 * 33 + string.byte(v191, v193)) % 65521;
                end;
                local v194;
                if v192 == 272 and typeof(u180) == "Vector3" then
                    v194 = u180;
                else
                    v194 = l__Classes__3.Util:getLikelyVec3(u180);
                end;
                l__StartPoint__31.Position = u182.WorldPosition;
                local l__Position__32 = l__PrimaryPart__29.Position;
                local v195 = u181.Position - l__Position__32;
                local l__Unit__33 = (v194 - l__Position__32).Unit;
                local v196 = v195.Magnitude + 250 * p190;
                local l__Magnitude__34 = (v194 - u181.Position).Magnitude;
                l__SpringConstraint__30.Radius = u3:numLerp(0, 2, (u3:convNumRange(l__Magnitude__34, 0, 130, 0, 1)));
                local v197 = tostring(game.GameId);
                local v198 = 46;
                for v199 = 1, #v197 do
                    v198 = (v198 * 33 + string.byte(v197, v199)) % 65521;
                end;
                if v198 == 272 and l__Magnitude__34 <= v196 then
                    u181.Position = v194;
                else
                    u181.Position = l__Position__32 + l__Unit__33 * v196;
                end;
            end);
            task.delay(4, function() --[[ Line: 604 ]]
                -- upvalues: u189 (copy), u178 (ref), u179 (ref)
                local v201 = tostring(game.GameId);
                local v202 = 46;
                for v203 = 1, #v201 do
                    v202 = (v202 * 33 + string.byte(v201, v203)) % 65521;
                end;
                if v202 == 272 and not u189.ended then
                    u178:_x211e0be423d1fc2b(u179);
                end;
            end);
            table.insert(u189.connections, v200);
            u178._x65489b6ed8f1ea50[u179] = u189;
        end;
    end;
    local v205 = u179 and u179:FindFirstChild("Left Arm");
    if v205 then
        v205 = u179["Left Arm"]:FindFirstChild("LeftGripAttachment");
    end;
    local v206 = tostring(game.GameId);
    local v207 = 46;
    local v208 = nil;
    for v209 = 1, #v206 do
        v207 = (v207 * 33 + string.byte(v206, v209)) % 65521;
    end;
    if v207 == 272 and v205 then
        v208 = v205:FindFirstChild("Tether");
    end;
    local v210 = tostring(game.GameId);
    local v211 = 46;
    for v212 = 1, #v210 do
        v211 = (v211 * 33 + string.byte(v210, v212)) % 65521;
    end;
    if v211 == 272 and (v205 and v208) then
        v204(v208, v205);
    else
        local v213 = tostring(game.GameId);
        local v214 = 46;
        for v215 = 1, #v213 do
            v214 = (v214 * 33 + string.byte(v213, v215)) % 65521;
        end;
        if v214 == 272 and v205 then
            local v216 = l__EffectAssets__5.Tether:Clone();
            v216.Parent = v205;
            v216.Archivable = false;
            v204(v216, v205);
        else
            warn("ATTACHMENT NOT FOUND FOR CHARACTER");
        end;
    end;
end;
function u1._x211e0be423d1fc2b(p217, p218) --[[ Line: 630 ]]
    -- upvalues: u3 (ref), l__Classes__3 (copy)
    local v219 = tostring(game.GameId);
    local v220 = 46;
    for v221 = 1, #v219 do
        v220 = (v220 * 33 + string.byte(v219, v221)) % 65521;
    end;
    if v220 == 272 and not p217._x65489b6ed8f1ea50[p218] then
    else
        local v222 = p217._x65489b6ed8f1ea50[p218];
        local v223 = tostring(game.GameId);
        local v224 = 46;
        for v225 = 1, #v223 do
            v224 = (v224 * 33 + string.byte(v223, v225)) % 65521;
        end;
        if v224 == 272 and v222.sound then
            v222.sound:Destroy();
        end;
        v222.ended = true;
        local v226 = tostring(game.GameId);
        local v227 = 46;
        for v228 = 1, #v226 do
            v227 = (v227 * 33 + string.byte(v226, v228)) % 65521;
        end;
        if v227 == 272 and v222.tether then
            v222.tether:Destroy();
        end;
        u3:cleanConnectionsTable(v222.connections);
        l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("GRAPPLE_READY", true, {
            Parent = p218.PrimaryPart
        });
        p217._x65489b6ed8f1ea50[p218] = nil;
    end;
end;
function u1._xe3c41edf1ca0ddcb(p229, p230, p231) --[[ Line: 650 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), l__Classes__3 (copy), l__RunService__2 (copy)
    local v232 = l__EffectAssets__5:FindFirstChild(p231);
    local v233 = tostring(game.GameId);
    local v234 = 46;
    for v235 = 1, #v233 do
        v234 = (v234 * 33 + string.byte(v233, v235)) % 65521;
    end;
    if v234 == 272 and not v232 then
        warn("NO SUCH PROJECTILE :", p231);
    else
        local v236 = v232:Clone();
        v236.Parent = l__Effects__9;
        l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("PROJECTILE_WHOOSH", true, {
            Parent = v236
        });
        local u237 = {};
        for _, u238 in v236:GetDescendants() do
            local v239 = tostring(game.GameId);
            local v240 = 46;
            for v241 = 1, #v239 do
                v240 = (v240 * 33 + string.byte(v239, v241)) % 65521;
            end;
            if v240 == 272 and u238:IsA("ParticleEmitter") then
                local v242 = u238:GetAttribute("EmitDelay");
                local v243 = tostring(game.GameId);
                local v244 = 46;
                for v245 = 1, #v243 do
                    v244 = (v244 * 33 + string.byte(v243, v245)) % 65521;
                end;
                if v244 == 272 and v242 then
                    task.delay(v242, function() --[[ Line: 679 ]]
                        -- upvalues: u238 (copy), u237 (copy)
                        local v246 = u238;
                        local v247 = v246:GetAttribute("EmitCount");
                        local v248 = tostring(game.GameId);
                        local v249 = 46;
                        for v250 = 1, #v248 do
                            v249 = (v249 * 33 + string.byte(v248, v250)) % 65521;
                        end;
                        if v249 == 272 and (v247 and v247 > 0) then
                            v246:Emit(v247);
                            table.insert(u237, v246);
                        end;
                    end);
                else
                    local v251 = u238:GetAttribute("EmitCount");
                    local v252 = tostring(game.GameId);
                    local v253 = 46;
                    for v254 = 1, #v252 do
                        v253 = (v253 * 33 + string.byte(v252, v254)) % 65521;
                    end;
                    if v253 == 272 and (v251 and v251 > 0) then
                        u238:Emit(v251);
                        table.insert(u237, u238);
                    end;
                end;
            end;
        end;
        local l__removal_id__35 = p230.removal_id;
        local l__origin__36 = p230.origin;
        local v255 = p230.direction or Vector3.new(0, 0, 0);
        local v256 = p230.speed or 0;
        local u257 = p230.acceleration or Vector3.new(0, 0, 0);
        local u258 = p230.acceleration_delay or 0;
        local l__velocity__37 = p230.velocity;
        local v259 = tostring(game.GameId);
        local v260 = 46;
        for v261 = 1, #v259 do
            v260 = (v260 * 33 + string.byte(v259, v261)) % 65521;
        end;
        if v260 == 272 and not l__velocity__37 then
            local v262 = tostring(game.GameId);
            local v263 = 46;
            for v264 = 1, #v262 do
                v263 = (v263 * 33 + string.byte(v262, v264)) % 65521;
            end;
            if v263 == 272 and v255.Magnitude > 0 then
                l__velocity__37 = v255.Unit * v256;
            else
                l__velocity__37 = Vector3.new(0, 0, 0);
            end;
        end;
        local v265 = workspace:GetServerTimeNow();
        local u266 = p230.shot_timestamp or v265;
        local v267 = math.clamp(v265 - u266, 0, 0.15);
        local v268 = math.max(0, v267 - u258);
        local v269 = l__origin__36 + l__velocity__37 * v267 + 0.5 * u257 * (v268 * v268);
        local v270 = l__velocity__37 + u257 * v268;
        local v271 = u258 <= v267 and u257 and u257 or Vector3.new(0, 0, 0);
        local function u287(p272, p273) --[[ Line: 726 ]]
            local v274 = tostring(game.GameId);
            local v275 = 46;
            for v276 = 1, #v274 do
                v275 = (v275 * 33 + string.byte(v274, v276)) % 65521;
            end;
            if v275 == 272 and not p272 then
            else
                local v277 = tostring(game.GameId);
                local v278 = 46;
                for v279 = 1, #v277 do
                    v278 = (v278 * 33 + string.byte(v277, v279)) % 65521;
                end;
                if v278 == 272 and p272:IsA("BasePart") then
                    p272.CFrame = CFrame.new(p273);
                else
                    local v280 = p272:FindFirstChildWhichIsA("BasePart");
                    local v281 = tostring(game.GameId);
                    local v282 = 46;
                    for v283 = 1, #v281 do
                        v282 = (v282 * 33 + string.byte(v281, v283)) % 65521;
                    end;
                    if v282 == 272 and v280 then
                        v280.CFrame = CFrame.new(p273);
                    else
                        local v284 = tostring(game.GameId);
                        local v285 = 46;
                        for v286 = 1, #v284 do
                            v285 = (v285 * 33 + string.byte(v284, v286)) % 65521;
                        end;
                        if v285 == 272 and (p272.SetPrimaryPartCFrame and p272.PrimaryPart) then
                            p272:SetPrimaryPartCFrame(CFrame.new(p273));
                        end;
                    end;
                end;
            end;
        end;
        u287(v236, v269);
        local u288 = {
            conn = nil,
            distance = 0,
            active = true,
            effect = v236,
            position = v269,
            velocity = v270,
            acceleration = v271,
            emitters = u237
        };
        p229._x4fb0f5d3fb1f17cc[l__removal_id__35] = u288;
        local u289 = 0;
        local u290 = nil;
        u290 = l__RunService__2.RenderStepped:Connect(function(p291) --[[ Line: 764 ]]
            -- upvalues: u288 (copy), u290 (ref), u266 (copy), u258 (copy), u257 (copy), u289 (ref), u287 (copy)
            local v292 = tostring(game.GameId);
            local v293 = 46;
            for v294 = 1, #v292 do
                v293 = (v293 * 33 + string.byte(v292, v294)) % 65521;
            end;
            if v293 == 272 and not u288.active then
                u290:Disconnect();
            else
                local v295 = workspace:GetServerTimeNow() - u266;
                local v296 = math.max(v295, 0);
                local v297 = tostring(game.GameId);
                local v298 = 46;
                for v299 = 1, #v297 do
                    v298 = (v298 * 33 + string.byte(v297, v299)) % 65521;
                end;
                if v298 == 272 and u258 <= v296 then
                    u288.acceleration = u257;
                end;
                u289 = u289 + p291;
                while u289 >= 0.016666666666666666 do
                    local l__position__38 = u288.position;
                    local v300 = l__position__38 + u288.velocity * 0.016666666666666666 + 0.5 * u288.acceleration * 0.0002777777777777778;
                    u288.position = v300;
                    u288.velocity = u288.velocity + u288.acceleration * 0.016666666666666666;
                    u288.distance = u288.distance + (v300 - l__position__38).Magnitude;
                    u289 = u289 - 0.016666666666666666;
                end;
                local v301 = tostring(game.GameId);
                local v302 = 46;
                for v303 = 1, #v301 do
                    v302 = (v302 * 33 + string.byte(v301, v303)) % 65521;
                end;
                if v302 == 272 and (u288.effect and u288.effect.Parent) then
                    u287(u288.effect, u288.position);
                end;
            end;
        end);
        u288.conn = u290;
    end;
end;
function u1._xff2c02af3c3070e1(p304, p305) --[[ Line: 805 ]]
    -- upvalues: l__Promise__6 (copy)
    local u306 = p304._x4fb0f5d3fb1f17cc[p305];
    local v307 = tostring(game.GameId);
    local v308 = 46;
    for v309 = 1, #v307 do
        v308 = (v308 * 33 + string.byte(v307, v309)) % 65521;
    end;
    if v308 == 272 and not u306 then
    else
        u306.active = false;
        local v310 = tostring(game.GameId);
        local v311 = 46;
        for v312 = 1, #v310 do
            v311 = (v311 * 33 + string.byte(v310, v312)) % 65521;
        end;
        if v311 == 272 and u306.conn then
            pcall(function() --[[ Line: 812 ]]
                -- upvalues: u306 (copy)
                u306.conn:Disconnect();
            end);
            u306.conn = nil;
        end;
        local v313 = tostring(game.GameId);
        local v314 = 46;
        for v315 = 1, #v313 do
            v314 = (v314 * 33 + string.byte(v313, v315)) % 65521;
        end;
        if v314 == 272 and (u306.effect and u306.effect.Parent) then
            pcall(function() --[[ Line: 817 ]]
                -- upvalues: l__Promise__6 (ref), u306 (copy)
                l__Promise__6.defer(function() --[[ Line: 818 ]]
                    -- upvalues: u306 (ref)
                    for _, v316 in u306.emitters do
                        v316:Destroy();
                    end;
                end);
                for _, v317 in u306.effect:GetDescendants() do
                    local v318 = tostring(game.GameId);
                    local v319 = 46;
                    for v320 = 1, #v318 do
                        v319 = (v319 * 33 + string.byte(v318, v320)) % 65521;
                    end;
                    if v319 == 272 and v317:IsA("ParticleEmitter") then
                        v317.Enabled = false;
                    end;
                    local v321 = tostring(game.GameId);
                    local v322 = 46;
                    for v323 = 1, #v321 do
                        v322 = (v322 * 33 + string.byte(v321, v323)) % 65521;
                    end;
                    if v322 == 272 and v317:IsA("Sound") then
                        v317:Destroy();
                    end;
                end;
                game.Debris:AddItem(u306.effect, 3);
            end);
        end;
        p304._x4fb0f5d3fb1f17cc[p305] = nil;
    end;
end;
function u1._x8ff1bd005ba55d27(p324, p325) --[[ Line: 840 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), u6 (copy), u3 (ref), l__Promise__6 (copy)
    local v326 = l__EffectAssets__5.Shockwave:Clone();
    v326.CFrame = CFrame.lookAt(p325.Position + p325.Normal * 2, p325.Position + p325.Normal * 3);
    v326.Parent = l__Effects__9;
    p324:_xdf1fbd00021c3208(v326);
    game.Debris:AddItem(v326, 2);
    local v327 = math.max(5 * u6[p324._x24e13a8a21a89c10], 1);
    for _ = 1, math.floor(v327) do
        local u328 = l__EffectAssets__5.DebrisPart:Clone();
        u328.Position = u3:getRandomPosInPart(v326);
        local l__Unit__39 = (u3:randomizeDirection(p325.Normal, 75) + Vector3.new(0, 0.5, 0)).Unit;
        u328.AssemblyAngularVelocity = l__Unit__39;
        u328.AssemblyLinearVelocity = l__Unit__39 * math.random(75, 150);
        u328.Parent = l__Effects__9;
        local v329 = math.random();
        u328.Attachment2.Inner.Lifetime = NumberRange.new(1.5 * v329);
        u328.Attachment2.MainFlare.Lifetime = NumberRange.new(1.5 * v329);
        p324:_xdf1fbd00021c3208(u328);
        task.delay(1.5 * v329, function() --[[ Line: 871 ]]
            -- upvalues: u328 (copy)
            u328.Attachment.Trail.Enabled = false;
        end);
        l__Promise__6.delay(3 * v329):andThen(function() --[[ Line: 875 ]]
            -- upvalues: u328 (copy)
            u328.Anchored = true;
            u328.CanCollide = false;
        end);
        game.Debris:AddItem(u328, 4.5 * v329);
    end;
end;
function u1._xa8e3c9ea0e0366a7(p330, p331, p332) --[[ Line: 884 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), u2 (ref), u3 (ref), l__TweenService__1 (copy)
    local v333 = l__EffectAssets__5.Explosion:Clone();
    local v334 = l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("EXPLOSION", true, {
        Parent = v333
    });
    local v335 = tostring(game.GameId);
    local v336 = 46;
    for v337 = 1, #v335 do
        v336 = (v336 * 33 + string.byte(v335, v337)) % 65521;
    end;
    if v336 == 272 and p332 then
        v334.RollOffMinDistance = 1000;
    end;
    game.Debris:AddItem(v333, 3);
    v333.Position = p331;
    v333.Parent = l__Effects__9;
    p330:_xdf1fbd00021c3208(v333);
    local v338 = tostring(game.GameId);
    local v339 = 46;
    local v340 = p332 and 500 or 150;
    for v341 = 1, #v338 do
        v339 = (v339 * 33 + string.byte(v338, v341)) % 65521;
    end;
    if v339 == 272 and not u2._x80657f8b6fb2b73e then
    else
        local v342 = u3:numLerp(30, 0, l__TweenService__1:GetValue(u3:convNumRange(math.clamp((p331 - u2._x80657f8b6fb2b73e.Position).Magnitude, 0, 150), 0, v340, 0, 1), Enum.EasingStyle.Exponential, Enum.EasingDirection.Out));
        l__Classes__3._x2b1f81c73714b323:_x06defdf12fcc7217(v342, 4, 4, { "pitch", "yaw", "roll" }, 0.6, true, false, false, false);
    end;
end;
function u1._x0c3ebb80d9cab2e8(p343, p344) --[[ Line: 907 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy)
    local u345 = l__EffectAssets__5.PhoenixDirect:Clone();
    game.Debris:AddItem(u345, 3);
    u345.Position = p344;
    u345.Parent = l__Effects__9;
    p343:_xdf1fbd00021c3208(u345);
    u345.Stars.Enabled = true;
    u345.Stars1.Enabled = true;
    task.delay(1.2, function() --[[ Line: 917 ]]
        -- upvalues: u345 (copy)
        local v346 = tostring(game.GameId);
        local v347 = 46;
        for v348 = 1, #v346 do
            v347 = (v347 * 33 + string.byte(v346, v348)) % 65521;
        end;
        if v347 == 272 and (not u345 or u345.Parent == nil) then
        else
            u345.Stars.Enabled = false;
            u345.Stars1.Enabled = false;
        end;
    end);
end;
function u1._x6b288b3c65a4a685(_, u349) --[[ Line: 924 ]]
    -- upvalues: l__Promise__6 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local v350 = tostring(game.GameId);
    local v351 = 46;
    for v352 = 1, #v350 do
        v351 = (v351 * 33 + string.byte(v350, v352)) % 65521;
    end;
    if v351 == 272 then
    else
        u349.Archivable = true;
        for _, v353 in u349:GetDescendants() do
            local v354 = tostring(game.GameId);
            local v355 = 46;
            for v356 = 1, #v354 do
                v355 = (v355 * 33 + string.byte(v354, v356)) % 65521;
            end;
            if v355 == 272 and v353:IsA("BasePart") then
                v353.Material = Enum.Material.SmoothPlastic;
                v353.Color = Color3.fromRGB(255, 255, 255);
                v353.Anchored = true;
                v353.CanCollide = false;
                v353.CanQuery = false;
                v353.CastShadow = false;
                v353.Transparency = 0.99;
            else
                local v357 = tostring(game.GameId);
                local v358 = 46;
                for v359 = 1, #v357 do
                    v358 = (v358 * 33 + string.byte(v357, v359)) % 65521;
                end;
                if v358 == 272 and not (v353:IsA("Model") or (v353:IsA("Accessory") or (v353:IsA("SpecialMesh") or (v353:IsA("MeshPart") or v353:IsA("Humanoid"))))) then
                    v353:Destroy();
                end;
            end;
        end;
        local u360 = Instance.new("Highlight");
        u360.FillColor = Color3.fromRGB(255, 255, 255);
        u360.OutlineTransparency = 1;
        u360.FillTransparency = 0;
        u360.Enabled = true;
        u360.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
        l__Promise__6.defer(function() --[[ Line: 948 ]]
            -- upvalues: u349 (copy), u360 (copy), l__Effects__9 (ref)
            local v361 = tostring(game.GameId);
            local v362 = 46;
            for v363 = 1, #v361 do
                v362 = (v362 * 33 + string.byte(v361, v363)) % 65521;
            end;
            if v362 == 272 and u349 then
                u360.Parent = u349;
                u349.Parent = l__Effects__9;
            end;
        end);
        l__TweenService__1:Create(u360, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
            FillTransparency = 1
        }):Play();
        game.Debris:AddItem(u349, 0.2);
    end;
end;
function u1._x74e7341ca71d602e(_, _, _, _) --[[ Line: 960 ]] end;
function u1._x7dacadb2d128543a(_, u364, u365, u366, u367) --[[ Line: 963 ]]
    -- upvalues: l__Promise__6 (copy), l__RunService__2 (copy), l__Classes__3 (copy), l__TweenService__1 (copy)
    for _, v368 in u364:GetDescendants() do
        local v369 = tostring(game.GameId);
        local v370 = 46;
        for v371 = 1, #v369 do
            v370 = (v370 * 33 + string.byte(v369, v371)) % 65521;
        end;
        if v370 == 272 and (v368:IsA("BasePart") or v368:IsA("Decal")) then
            v368.Transparency = 1;
        end;
    end;
    local u372 = os.clock();
    return l__Promise__6.new(function(u373, _, p374) --[[ Line: 970 ]]
        -- upvalues: u364 (copy), l__RunService__2 (ref), u372 (copy), u365 (copy), l__Classes__3 (ref), u366 (copy), l__TweenService__1 (ref), u367 (copy)
        local u375 = nil;
        local function u387() --[[ Line: 972 ]]
            -- upvalues: u375 (ref), u364 (ref), u373 (copy)
            local v376 = tostring(game.GameId);
            local v377 = 46;
            for v378 = 1, #v376 do
                v377 = (v377 * 33 + string.byte(v376, v378)) % 65521;
            end;
            if v377 == 272 and u375 then
                u375:Disconnect();
                u375 = nil;
            end;
            for _, v379 in u364:GetDescendants() do
                local v380 = tostring(game.GameId);
                local v381 = 46;
                for v382 = 1, #v380 do
                    v381 = (v381 * 33 + string.byte(v380, v382)) % 65521;
                end;
                if v381 == 272 and (v379 and v379:IsA("BasePart") or v379:IsA("Decal")) then
                    local v383 = v379:GetAttribute("OriginalTransparency");
                    local v384 = tostring(game.GameId);
                    local v385 = 46;
                    for v386 = 1, #v384 do
                        v385 = (v385 * 33 + string.byte(v384, v386)) % 65521;
                    end;
                    if v385 ~= 272 or v383 then
                        v379.Transparency = v383;
                    end;
                end;
            end;
            u373();
        end;
        u375 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 989 ]]
            -- upvalues: u372 (ref), u365 (ref), l__Classes__3 (ref), u387 (copy), u364 (ref), u366 (ref), l__TweenService__1 (ref), u367 (ref)
            local v388 = os.clock() - u372;
            local v389 = math.min(v388, u365);
            local v390 = l__Classes__3.Util:convNumRange(v389, 0, u365, 0, 1);
            local v391 = tostring(game.GameId);
            local v392 = 46;
            for v393 = 1, #v391 do
                v392 = (v392 * 33 + string.byte(v391, v393)) % 65521;
            end;
            if v392 == 272 and v390 == 1 then
                u387();
            end;
            for _, v394 in u364:GetDescendants() do
                local v395 = tostring(game.GameId);
                local v396 = 46;
                for v397 = 1, #v395 do
                    v396 = (v396 * 33 + string.byte(v395, v397)) % 65521;
                end;
                if v396 == 272 and (v394:IsA("BasePart") or v394:IsA("Decal")) then
                    local v398 = v394:GetAttribute("OriginalTransparency");
                    local v399 = tostring(game.GameId);
                    local v400 = 46;
                    for v401 = 1, #v399 do
                        v400 = (v400 * 33 + string.byte(v399, v401)) % 65521;
                    end;
                    if v400 ~= 272 or v398 then
                        local l__Util__40 = l__Classes__3.Util;
                        local v402 = 1;
                        local v403;
                        if u366 then
                            v403 = l__TweenService__1:GetValue(v390, u366, u367) or v390;
                        else
                            v403 = v390;
                        end;
                        v394.Transparency = l__Util__40:numLerp(v402, v398, v403);
                    end;
                end;
            end;
        end);
        p374(function() --[[ Line: 1005 ]]
            -- upvalues: u387 (copy)
            u387();
        end);
    end);
end;
function u1._x61633d1e9c470b93(_, p404, p405, p406) --[[ Line: 1013 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), l__Classes__3 (copy)
    local v407 = tostring(game.GameId);
    local v408 = 46;
    for v409 = 1, #v407 do
        v408 = (v408 * 33 + string.byte(v407, v409)) % 65521;
    end;
    if v408 == 272 and p406 then
        local v410 = l__EffectAssets__5.GlitchAura:Clone();
        local v411 = Instance.new("Weld");
        v411.Parent = v410;
        v411.Part0 = v410;
        v411.Part1 = p404.PrimaryPart;
        v410.Parent = l__Effects__9;
        v410.ParticleEmitter.Enabled = true;
        game.Debris:AddItem(v410, p405);
        l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("SHORT_DASH", true, {
            Parent = p404:FindFirstChild("HumanoidRootPart")
        });
        l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("DASH", true, {
            Parent = p404:FindFirstChild("HumanoidRootPart")
        });
    end;
    local u412 = {};
    for v413 = 1, 2 do
        local v414 = { "Left Leg", "Right Leg" };
        local v415 = l__EffectAssets__5.AfterTrail:Clone();
        table.insert(u412, v415);
        v415.Attachment0 = p404[v414[v413]][({ "LeftFootAttachment", "RightFootAttachment" })[v413]];
        local v416 = Instance.new("Attachment");
        v416.Parent = p404[v414[v413]];
        v416.Position = Vector3.new(0, -0.5, 0);
        game.Debris:AddItem(v416, p405 + 1);
        v415.Attachment1 = v416;
        v415.Parent = p404[v414[v413]];
        game.Debris:AddItem(v415, p405 + 1);
    end;
    for v417 = 1, 2 do
        local v418 = { "Left Arm", "Right Arm" };
        local v419 = l__EffectAssets__5.AfterTrail:Clone();
        table.insert(u412, v419);
        v419.Attachment0 = p404[v418[v417]][({ "LeftGripAttachment", "RightGripAttachment" })[v417]];
        local v420 = Instance.new("Attachment");
        v420.Parent = p404[v418[v417]];
        v420.Position = Vector3.new(0, -0.5, 0);
        game.Debris:AddItem(v420, p405 + 1);
        v419.Attachment1 = v420;
        v419.Parent = p404[v418[v417]];
        game.Debris:AddItem(v419, p405 + 1);
    end;
    local v421 = l__EffectAssets__5.AfterTrail:Clone();
    table.insert(u412, v421);
    v421.Attachment0 = p404.Head.HairAttachment;
    local v422 = Instance.new("Attachment");
    v422.Parent = p404.Head;
    v422.Position = Vector3.new(0, 0.5, 0);
    game.Debris:AddItem(v422, p405 + 1);
    v421.Attachment1 = v422;
    v421.Parent = p404.Head;
    game.Debris:AddItem(v421, p405 + 1);
    task.delay(p405, function() --[[ Line: 1084 ]]
        -- upvalues: u412 (copy)
        for _, v423 in pairs(u412) do
            v423.Enabled = false;
        end;
    end);
end;
function u1._xaec7cf54d1c78008(p424, p425) --[[ Line: 1092 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy)
    local v426 = l__EffectAssets__5.SuspendedIndicator:Clone();
    game.Debris:AddItem(v426, 1);
    v426.Position = p425;
    v426.Parent = l__Effects__9;
    p424:_xdf1fbd00021c3208(v426);
end;
function u1._x9539bc5b7e1e5fa5(_, p427) --[[ Line: 1100 ]]
    local v428 = Vector3.new(p427.X, 0, p427.Z);
    local l__Magnitude__41 = v428.Magnitude;
    local v429 = l__Magnitude__41 + math.abs(p427.Y);
    local v430 = tostring(game.GameId);
    local v431 = 46;
    for v432 = 1, #v430 do
        v431 = (v431 * 33 + string.byte(v430, v432)) % 65521;
    end;
    if v431 == 272 and v429 < 0.0001 then
        return Vector3.new(0, 0, 0);
    end;
    local v433 = l__Magnitude__41 / v429;
    local v434 = v433 ^ 2 / (v433 ^ 2 + (1 - v433) ^ 2);
    return ((l__Magnitude__41 > 0 and v428.Unit * (v429 * v434) or Vector3.new(0, 0, 0)) + Vector3.new(0, v429 * (1 - v434) * (p427.Y < 0 and -1 or 1), 0)).Unit;
end;
function u1._x09376bac80aa1359(u435) --[[ Line: 1117 ]]
    -- upvalues: l__EffectAssets__5 (copy), u2 (ref), u4 (ref), u5 (ref), u3 (ref), l__RunService__2 (copy)
    local function v444() --[[ Line: 1118 ]]
        -- upvalues: l__EffectAssets__5 (ref), u435 (copy)
        local v436 = l__EffectAssets__5.SlideSparks:Clone();
        v436.Parent = workspace.CurrentCamera;
        u435._xe9a9280e93cc6df3.SlideSparks = {
            model = v436,
            emitters = {},
            glow = {},
            connections = {}
        };
        for _, v437 in pairs(v436:GetDescendants()) do
            local v438 = tostring(game.GameId);
            local v439 = 46;
            for v440 = 1, #v438 do
                v439 = (v439 * 33 + string.byte(v438, v440)) % 65521;
            end;
            if v439 == 272 and v437:IsA("ParticleEmitter") then
                local v441 = tostring(game.GameId);
                local v442 = 46;
                for v443 = 1, #v441 do
                    v442 = (v442 * 33 + string.byte(v441, v443)) % 65521;
                end;
                if v442 == 272 and v437.Name == "Sparks" then
                    table.insert(u435._xe9a9280e93cc6df3.SlideSparks.emitters, v437);
                else
                    table.insert(u435._xe9a9280e93cc6df3.SlideSparks.glow, v437);
                end;
            end;
        end;
    end;
    local function u470() --[[ Line: 1138 ]]
        -- upvalues: u2 (ref), u4 (ref), u5 (ref), u435 (copy), u3 (ref)
        local v445 = u2._xed86f944048d8fdc.Magnitude > u4.SLIDESPARKS_THRESHOLD;
        local v446 = u5._x0ebe84ab0bc72e88 <= u4.SLIDESPARKS_TIME_THRESHOLD;
        local v447 = tostring(game.GameId);
        local v448 = 46;
        for v449 = 1, #v447 do
            v448 = (v448 * 33 + string.byte(v447, v449)) % 65521;
        end;
        local v450 = v448 == 272 and (u2._xed86f944048d8fdc.Magnitude > u4.SLIDESPARKS_MAJOR_THRESHOLD and (u5._x3d199abdbf08457d and u2._x0143b9fae93717ec)) and true or false;
        for _, v451 in pairs(u435._xe9a9280e93cc6df3.SlideSparks.glow) do
            v451.Enabled = v450;
        end;
        local function v456(p452) --[[ Line: 1153 ]]
            -- upvalues: u435 (ref)
            for _, v453 in pairs(u435._xe9a9280e93cc6df3.SlideSparks.emitters) do
                for v454, v455 in pairs(p452) do
                    v453[v454] = v455;
                end;
            end;
        end;
        local l__SlideSparks__42 = u435._xe9a9280e93cc6df3.SlideSparks;
        local l__model__43 = l__SlideSparks__42.model;
        local _ = l__SlideSparks__42.emitters[1];
        local v457 = RaycastParams.new();
        v457.RespectCanCollide = true;
        v457.FilterDescendantsInstances = { workspace.CurrentCamera, u2._x539c98577c3cf168 };
        v457.FilterType = Enum.RaycastFilterType.Exclude;
        local v458 = workspace:Raycast(u2._x80657f8b6fb2b73e.Position, u2._x80657f8b6fb2b73e.CFrame.UpVector * -3.3, v457);
        local v459 = tostring(game.GameId);
        local v460 = 46;
        for v461 = 1, #v459 do
            v460 = (v460 * 33 + string.byte(v459, v461)) % 65521;
        end;
        if v460 == 272 and v458 then
            local l__Position__44 = v458.Position;
            l__model__43.CFrame = CFrame.lookAt(l__Position__44 + u2._xed86f944048d8fdc.Unit * u4.SLIDESPARKS_DISTANCE, l__Position__44);
        end;
        local v462 = tostring(game.GameId);
        local v463 = 46;
        for v464 = 1, #v462 do
            v463 = (v463 * 33 + string.byte(v462, v464)) % 65521;
        end;
        if v463 == 272 and (v445 and (u2._x0143b9fae93717ec and u5._x3d199abdbf08457d) or v446 and (u2._x0143b9fae93717ec and u5._x3d199abdbf08457d)) then
            local v465 = {
                Enabled = true,
                Rate = u3:convNumRange(math.clamp(u2._xed86f944048d8fdc.Magnitude, 0, u4.SLIDESPARKS_UPPER_BOUND), 0, u4.SLIDESPARKS_UPPER_BOUND, 0, u4.SLIDESPARKS_RATE)
            };
            local v466 = tostring(game.GameId);
            local v467 = 46;
            for v468 = 1, #v466 do
                v467 = (v467 * 33 + string.byte(v466, v468)) % 65521;
            end;
            local v469;
            if v467 == 272 and u2._xed86f944048d8fdc.Magnitude > 0.001 then
                v469 = NumberRange.new(u2._xed86f944048d8fdc.Magnitude / u4.SLIDESPARKS_SPEED_DIVISOR);
            else
                v469 = NumberRange.new(0.001);
            end;
            v465.Speed = v469;
            v456(v465);
        else
            v456({
                Rate = 0
            });
        end;
    end;
    local v471 = tostring(game.GameId);
    local v472 = 46;
    for v473 = 1, #v471 do
        v472 = (v472 * 33 + string.byte(v471, v473)) % 65521;
    end;
    if v472 == 272 and not u435._xe9a9280e93cc6df3.SlideSparks then
        v444();
    end;
    table.insert(u435._xe9a9280e93cc6df3.SlideSparks.connections, l__RunService__2.RenderStepped:Connect(function() --[[ Line: 1207 ]]
        -- upvalues: u470 (copy)
        u470();
    end));
end;
function u1._xc1323980128a2746(p474, p475, p476) --[[ Line: 1212 ]]
    -- upvalues: u3 (ref), l__EffectAssets__5 (copy), l__Effects__9 (copy)
    local v477 = u3:getLikelyVec3(p475);
    local v478 = u3:getLikelyVec3(p476);
    local v479 = l__EffectAssets__5.CastigateFlash:Clone();
    v479.CFrame = CFrame.lookAt(v477, v478);
    v479.Parent = l__Effects__9;
    game.Debris:AddItem(v479, 2);
    p474:_xdf1fbd00021c3208(v479);
end;
function u1._x4bf8be97f08f8659(u480, u481) --[[ Line: 1224 ]]
    -- upvalues: l__UIAssets__4 (copy), l__TweenService__1 (copy), l__RunService__2 (copy), l__Classes__3 (copy)
    local l__Lighting__45 = game:GetService("Lighting");
    local u482 = Instance.new("ColorCorrectionEffect");
    u482.Saturation = -1;
    u482.Parent = l__Lighting__45;
    game.Debris:AddItem(u482, u481);
    local v483 = {};
    local v484 = Instance.new("NumberValue");
    v484.Value = -4;
    v483.value = v484;
    v483.cancel_when_zero = true;
    local u485 = l__UIAssets__4.Destabilized:Clone();
    u485.Parent = u480._x721075be0fa304b4;
    game.Debris:AddItem(u485, u481);
    local u486 = os.clock();
    local u487 = Random.new();
    u485.Rotation = ({ -10, 10 })[math.random(1, 2)];
    l__TweenService__1:Create(u485, TweenInfo.new(u481 / 4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        Rotation = 0
    }):Play();
    u485.Size = UDim2.fromScale(0.87, 0.87);
    l__TweenService__1:Create(u485, TweenInfo.new(u481), {
        Size = UDim2.fromScale(0.75, 0.75)
    }):Play();
    local u488 = 0;
    l__TweenService__1:Create(u485.Rotator, TweenInfo.new(u481, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Rotation = 2000
    }):Play();
    local u517 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 1255 ]]
        -- upvalues: u485 (copy), u486 (copy), u481 (copy), l__Classes__3 (ref), l__TweenService__1 (ref), u488 (ref), u487 (copy)
        local v489 = tostring(game.GameId);
        local v490 = 46;
        for v491 = 1, #v489 do
            v490 = (v490 * 33 + string.byte(v489, v491)) % 65521;
        end;
        if v490 == 272 and (not u485 or u485.Parent == nil) then
        else
            local v492 = os.clock() - u486;
            local v493 = math.clamp(v492, 0, u481);
            local v494 = l__Classes__3.Util:convNumRange(v493, 0, u481, 0, 1);
            local v495 = Color3.fromRGB(255, 0, 0):Lerp(Color3.fromRGB(255, 255, 255), l__TweenService__1:GetValue(v494, Enum.EasingStyle.Sine, Enum.EasingDirection.In));
            local v496 = l__TweenService__1:GetValue(l__TweenService__1:GetValue(v494, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), Enum.EasingStyle.Exponential, Enum.EasingDirection.In);
            local v497 = math.floor(v493);
            l__Classes__3._x3103fdab012bc1c0._x0b50f415660624d5.Enabled = false;
            local v498 = tostring(game.GameId);
            local v499 = 46;
            for v500 = 1, #v498 do
                v499 = (v499 * 33 + string.byte(v498, v500)) % 65521;
            end;
            if v499 == 272 and v497 ~= u488 then
                u488 = v497;
                u485.Timer.Size = UDim2.fromScale(0.18, 0.18);
                l__TweenService__1:Create(u485.Timer, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(0.16, 0.16)
                }):Play();
                local v501 = u485.Timer:Clone();
                v501.Second:Destroy();
                v501.Milisecond:Destroy();
                v501.Name = "pulse";
                v501.Parent = u485;
                v501.Size = UDim2.fromScale(0.16, 0.16);
                v501.UIStroke.Thickness = 10;
                l__TweenService__1:Create(v501.UIStroke, TweenInfo.new(0.5), {
                    Thickness = 0
                }):Play();
                l__TweenService__1:Create(v501, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(1, 1)
                }):Play();
                l__TweenService__1:Create(v501.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
                game.Debris:AddItem(v501, 0.45);
                l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("TICK", true);
            end;
            local v502 = math.fmod(v493, 1);
            u485.Timer.Second.Text = u481 - u488 - 1;
            local l__Milisecond__46 = u485.Timer.Milisecond;
            local v503 = tostring(1 - v502);
            l__Milisecond__46.Text = string.sub(v503, 2, 4);
            for _, v504 in u485:GetDescendants() do
                local v505 = tostring(game.GameId);
                local v506 = 46;
                for v507 = 1, #v505 do
                    v506 = (v506 * 33 + string.byte(v505, v507)) % 65521;
                end;
                if v506 == 272 and v504:IsA("TextLabel") then
                    v504.TextColor3 = v495;
                    v504.TextTransparency = v496;
                else
                    local v508 = tostring(game.GameId);
                    local v509 = 46;
                    for v510 = 1, #v508 do
                        v509 = (v509 * 33 + string.byte(v508, v510)) % 65521;
                    end;
                    if v509 == 272 and v504:IsA("ImageLabel") then
                        v504.ImageColor3 = v495;
                        v504.ImageTransparency = v496;
                    else
                        local v511 = tostring(game.GameId);
                        local v512 = 46;
                        for v513 = 1, #v511 do
                            v512 = (v512 * 33 + string.byte(v511, v513)) % 65521;
                        end;
                        if v512 == 272 and v504:IsA("UIStroke") then
                            v504.Color = v495;
                            v504.Transparency = v496;
                        end;
                    end;
                end;
            end;
            local l__Cautions__47 = u485.Cautions;
            local l__fromScale__48 = UDim2.fromScale;
            local v514 = l__Classes__3.Util:numLerp(0.1, 0.01, l__TweenService__1:GetValue(v494, Enum.EasingStyle.Quint, Enum.EasingDirection.Out));
            local v515 = 0.8 + u487:NextNumber(-v514, v514);
            local v516 = l__Classes__3.Util:numLerp(0.1, 0.01, l__TweenService__1:GetValue(v494, Enum.EasingStyle.Quint, Enum.EasingDirection.Out));
            l__Cautions__47.Size = l__fromScale__48(v515, 0.8 + u487:NextNumber(-v516, v516));
        end;
    end);
    local u518 = nil;
    local function u538(p519) --[[ Line: 1313 ]]
        -- upvalues: u518 (ref), u482 (copy), u517 (ref), u480 (copy), l__Classes__3 (ref), u485 (copy)
        local v520 = tostring(game.GameId);
        local v521 = 46;
        for v522 = 1, #v520 do
            v521 = (v521 * 33 + string.byte(v520, v522)) % 65521;
        end;
        if v521 == 272 and u518 then
            task.cancel(u518);
        end;
        local v523 = tostring(game.GameId);
        local v524 = 46;
        for v525 = 1, #v523 do
            v524 = (v524 * 33 + string.byte(v523, v525)) % 65521;
        end;
        if v524 == 272 and u482 then
            u482:Destroy();
        end;
        local v526 = tostring(game.GameId);
        local v527 = 46;
        for v528 = 1, #v526 do
            v527 = (v527 * 33 + string.byte(v526, v528)) % 65521;
        end;
        if v527 == 272 and u517 then
            u480:_x95440c9de7bce1b0(game:GetService("Lighting"), 2, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)):Play();
            local v529 = tostring(game.GameId);
            local v530 = 46;
            for v531 = 1, #v529 do
                v530 = (v530 * 33 + string.byte(v529, v531)) % 65521;
            end;
            if v530 == 272 and not p519 then
                local v532 = tostring(game.GameId);
                local v533 = 46;
                for v534 = 1, #v532 do
                    v533 = (v533 * 33 + string.byte(v532, v534)) % 65521;
                end;
                if v533 == 272 and l__Classes__3._x596eb619070480ba._x885b2725a1933f2e == "alive" then
                    l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("DING_ON", true);
                    l__Classes__3._x3103fdab012bc1c0._x0b50f415660624d5.Enabled = true;
                end;
            end;
            u517:Disconnect();
            u517 = nil;
        end;
        local v535 = tostring(game.GameId);
        local v536 = 46;
        for v537 = 1, #v535 do
            v536 = (v536 * 33 + string.byte(v535, v537)) % 65521;
        end;
        if v536 == 272 and u485 then
            u485:Destroy();
        end;
    end;
    u518 = task.delay(u481, function() --[[ Line: 1336 ]]
        -- upvalues: u518 (ref), u538 (copy)
        u518 = nil;
        u538();
    end);
    l__Classes__3._x2b1f81c73714b323:_x2ecd015ac546361f(v483);
    l__TweenService__1:Create(v484, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
    return u538;
end;
function u1._x65e5a55153673c0b(p539, p540, p541) --[[ Line: 1348 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), u3 (ref)
    local v542 = l__EffectAssets__5.SlashCrescent:Clone();
    game.Debris:AddItem(v542, 1.5);
    v542.Parent = l__Effects__9;
    local v543 = u3:getLikelyVec3(p540);
    local v544 = u3:getLikelyVec3(p541);
    v542.CFrame = CFrame.lookAt(v543, v544);
    p539:_xdf1fbd00021c3208(v542);
end;
function u1._x0d8a8edf20547eae(p545, p546, u547) --[[ Line: 1360 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), l__RunService__2 (copy)
    local u548 = l__EffectAssets__5.SlashCrescent:Clone();
    game.Debris:AddItem(u548, 1.5);
    u548.Parent = l__Effects__9;
    u548.CFrame = CFrame.lookAt((p546.Position + u547.CFrame.Position) / 2, u547.CFrame.Position + Vector3.new(0, -2, 0));
    local u549 = u547.CFrame:toObjectSpace(u548.CFrame);
    local u550 = l__RunService__2.RenderStepped:Connect(function() --[[ Line: 1371 ]]
        -- upvalues: u548 (copy), u547 (copy), u549 (copy)
        u548.CFrame = u547.CFrame:toWorldSpace(u549);
    end);
    task.delay(0.2, function() --[[ Line: 1375 ]]
        -- upvalues: u550 (copy)
        u550:Disconnect();
    end);
    p545:_xdf1fbd00021c3208(u548);
end;
function u1._x3687c02e4602f369(p551) --[[ Line: 1383 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local v552 = l__EffectAssets__5.CastigateFlash:Clone();
    local v553 = l__Classes__3._x2b1f81c73714b323:_xe472bf37dc82e1d3();
    local l__WorldPosition__49 = l__Classes__3._x337410ce64f03086:_x3efa7d2770a422ee("gun")._xf8bc85aed8d72492.WorldPosition;
    v552.CFrame = CFrame.lookAt(l__WorldPosition__49 + v553 * 2, l__WorldPosition__49 + v553 * 10);
    v552.Parent = l__Effects__9;
    game.Debris:AddItem(v552, 2);
    p551:_xdf1fbd00021c3208(v552);
    local l__Lighting__50 = game:GetService("Lighting");
    local v554 = Instance.new("ColorCorrectionEffect");
    v554.Contrast = 1;
    v554.Saturation = -1;
    v554.Parent = l__Lighting__50;
    game.Debris:AddItem(v554, 1);
    l__TweenService__1:Create(v554, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Contrast = 0
    }):Play();
    l__TweenService__1:Create(v554, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    p551:_x95440c9de7bce1b0(l__Lighting__50, -1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)):Play();
end;
function u1._x75f49dedc3ff795c(p555, p556) --[[ Line: 1406 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local v557 = l__EffectAssets__5.SiegeFlash:Clone();
    local v558 = l__Classes__3._x2b1f81c73714b323:_xe472bf37dc82e1d3();
    v557.CFrame = CFrame.lookAt(p556, p556 + v558 * 10);
    v557.Parent = l__Effects__9;
    game.Debris:AddItem(v557, 2);
    local v559 = l__Classes__3.Util:getBasicRaycastParams();
    for _ = 1, 10 do
        local v560 = l__EffectAssets__5.SiegeTracer:Clone();
        v560.Parent = l__Effects__9;
        local v561 = l__Classes__3.Util:randomizeUnitVectorGaussian(v558, 20);
        v560.CFrame = CFrame.lookAt(p556, p556 + v561);
        p555:_xdf1fbd00021c3208(v560);
        local v562 = workspace:Raycast(p556, v561 * 70, v559);
        local v563 = tostring(game.GameId);
        local v564 = 46;
        for v565 = 1, #v563 do
            v564 = (v564 * 33 + string.byte(v563, v565)) % 65521;
        end;
        if v564 == 272 and v562 then
            p555:_xc4d94a025a223fb7(v562.Position + v562.Normal * 0.1, v562.Position + v562.Normal);
        end;
        game.Debris:AddItem(v560, 2);
    end;
    p555:_xdf1fbd00021c3208(v557);
    local l__Lighting__51 = game:GetService("Lighting");
    local v566 = Instance.new("ColorCorrectionEffect");
    v566.Contrast = 1;
    v566.Saturation = -1;
    v566.Parent = l__Lighting__51;
    game.Debris:AddItem(v566, 1);
    l__TweenService__1:Create(v566, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Contrast = 0
    }):Play();
    l__TweenService__1:Create(v566, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    p555:_x95440c9de7bce1b0(l__Lighting__51, -1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)):Play();
end;
function u1._xbf05d4945d5b371c(p567, p568, p569) --[[ Line: 1449 ]]
    -- upvalues: u3 (ref), l__EffectAssets__5 (copy), l__Effects__9 (copy), l__Classes__3 (copy)
    local v570 = u3:getLikelyVec3(p568);
    local v571 = u3:getLikelyVec3(p569);
    local v572 = l__EffectAssets__5.SiegeFlashOutsider:Clone();
    v572.CFrame = CFrame.lookAt(v570, v571);
    v572.Parent = l__Effects__9;
    game.Debris:AddItem(v572, 2);
    l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("SIEGE_BONUS_SHOT", true, {
        location = p568
    });
    p567:_xdf1fbd00021c3208(v572);
end;
function u1._x01aa4a2b9badb827(p573, p574, p575) --[[ Line: 1463 ]]
    -- upvalues: u3 (ref), l__EffectAssets__5 (copy), l__Effects__9 (copy), l__Classes__3 (copy)
    local v576 = u3:getLikelyVec3(p574);
    local v577 = u3:getLikelyVec3(p575);
    local v578 = l__EffectAssets__5.PhoenixFlash:Clone();
    v578.CFrame = CFrame.lookAt(v576, v577);
    v578.Parent = l__Effects__9;
    game.Debris:AddItem(v578, 2);
    l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("PHOENIX_SHOT", true, {
        location = p574
    });
    p573:_xdf1fbd00021c3208(v578);
end;
function u1._x1bc019475f47e826(p579, p580) --[[ Line: 1477 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local v581 = l__EffectAssets__5.PhoenixFlash:Clone();
    local v582 = l__Classes__3._x2b1f81c73714b323:_xe472bf37dc82e1d3();
    v581.CFrame = CFrame.lookAt(p580 + v582 * 2, p580 + v582 * 10);
    v581.Parent = l__Effects__9;
    game.Debris:AddItem(v581, 2);
    local v583 = math.random();
    local v584 = tostring(game.GameId);
    local v585 = 46;
    for v586 = 1, #v584 do
        v585 = (v585 * 33 + string.byte(v584, v586)) % 65521;
    end;
    if v585 == 272 and v583 <= 0.0001 then
        l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("EAGLE", true);
        local v587 = l__EffectAssets__5.eagle:Clone();
        v587.Parent = p579._x721075be0fa304b4;
        game.Debris:AddItem(v587, 4.1);
        l__TweenService__1:Create(v587, TweenInfo.new(4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
    end;
    for _, v588 in pairs(v581:GetDescendants()) do
        local v589 = tostring(game.GameId);
        local v590 = 46;
        for v591 = 1, #v589 do
            v590 = (v590 * 33 + string.byte(v589, v591)) % 65521;
        end;
        if v590 == 272 and v588:IsA("ParticleEmitter") then
            v588:Emit(v588:GetAttribute("EmitCount"));
        end;
    end;
    local l__Lighting__52 = game:GetService("Lighting");
    local v592 = Instance.new("ColorCorrectionEffect");
    v592.Contrast = 1;
    v592.Saturation = -1;
    v592.Parent = l__Lighting__52;
    game.Debris:AddItem(v592, 1);
    l__TweenService__1:Create(v592, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Contrast = 0
    }):Play();
    l__TweenService__1:Create(v592, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    p579:_x95440c9de7bce1b0(l__Lighting__52, -2.7, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)):Play();
end;
function u1._xff77218ad0f885e7(p593, p594, u595, u596, u597, p598) --[[ Line: 1515 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__TweenService__1 (copy), l__Classes__3 (copy), u3 (ref), l__RunService__2 (copy), l__Effects__9 (copy)
    local v599 = tostring(game.GameId);
    local v600 = 46;
    local u601 = nil;
    local v602 = nil;
    local v603 = nil;
    for v604 = 1, #v599 do
        v600 = (v600 * 33 + string.byte(v599, v604)) % 65521;
    end;
    local u605;
    if v600 == 272 and (typeof(u596) ~= "Vector3" and u596:IsA("Part")) then
        u605 = u596.Position;
        v603 = true;
    else
        u605 = u596;
        u596 = v602;
    end;
    local v606 = l__EffectAssets__5.BulletTracer:Clone();
    local u607 = p598 or 0.3;
    local u608 = u597 and 1 or u607;
    game.Debris:AddItem(v606, u608);
    local l__Destination__53 = v606.Destination;
    local l__Gunpoint__54 = v606.Gunpoint;
    local l__Point__55 = l__Gunpoint__54.Point;
    local _ = l__Destination__53.End;
    local l__Beam__56 = l__Point__55.Beam;
    local l__Trail__57 = l__Point__55.Trail;
    local l__Progress__58 = l__Beam__56.Progress;
    l__TweenService__1:Create(l__Progress__58, TweenInfo.new(u608), {
        Value = u608
    }):Play();
    local v609 = RaycastParams.new();
    v609.FilterType = Enum.RaycastFilterType.Include;
    v609.FilterDescendantsInstances = { workspace.Map };
    local l__Unit__59 = (u605 - u595).Unit;
    local l__Magnitude__60 = (u605 - u595).Magnitude;
    local v610 = workspace:Raycast(u595, l__Unit__59 * l__Magnitude__60, v609);
    local v611 = tostring(game.GameId);
    local v612 = 46;
    for v613 = 1, #v611 do
        v612 = (v612 * 33 + string.byte(v611, v613)) % 65521;
    end;
    if v612 == 272 and (v610 and (v610.Instance:IsA("BasePart") and (v610.Instance.Transparency ~= 1 and v610.Instance.CanCollide == true))) then
        local l__Magnitude__61 = (v610.Position - u605).Magnitude;
        local v614 = tostring(game.GameId);
        local v615 = 46;
        for v616 = 1, #v614 do
            v615 = (v615 * 33 + string.byte(v614, v616)) % 65521;
        end;
        if v615 == 272 and l__Magnitude__61 > 1 then
            local l__Position__62 = v610.Position;
            p593:_xe38e234dff908baa(l__Position__62, l__Position__62 + v610.Normal);
            l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("PROJ_BREAK", true, {
                location = l__Position__62
            });
            local v617 = workspace:Raycast(u605, -l__Unit__59 * l__Magnitude__60, v609);
            local v618 = tostring(game.GameId);
            local v619 = 46;
            for v620 = 1, #v618 do
                v619 = (v619 * 33 + string.byte(v618, v620)) % 65521;
            end;
            if v619 == 272 and v617 then
                local l__Position__63 = v617.Position;
                p593:_xe38e234dff908baa(l__Position__63, l__Position__63 + v617.Normal);
                l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("PROJ_BREAK", true, {
                    location = l__Position__63
                });
            end;
        end;
    end;
    l__Progress__58.Changed:Connect(function(p621) --[[ Line: 1577 ]]
        -- upvalues: u607 (copy), l__Beam__56 (copy), u3 (ref), u597 (copy), l__Trail__57 (copy), u608 (copy)
        local v622 = tostring(game.GameId);
        local v623 = 46;
        for v624 = 1, #v622 do
            v623 = (v623 * 33 + string.byte(v622, v624)) % 65521;
        end;
        if v623 == 272 and u607 <= p621 then
            l__Beam__56.Enabled = false;
        end;
        local v625 = u3:convNumRange(p621, 0, u607, -4, 5);
        local v626 = v625 - 2 - 0.01;
        local v627 = v625 + 2 + 0.01;
        local v628 = math.clamp(v626, 0.02, 0.98);
        local v629 = math.clamp(v627, 0.02, 0.98);
        local v630 = (v628 + v629) / 2;
        l__Beam__56.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(v628, 1),
            NumberSequenceKeypoint.new((v628 + v630) * 0.5, 0),
            NumberSequenceKeypoint.new(v630, 0),
            NumberSequenceKeypoint.new((v629 + v630) * 0.5, 0),
            NumberSequenceKeypoint.new(v629, 1),
            NumberSequenceKeypoint.new(1, 1)
        });
        local v631 = tostring(game.GameId);
        local v632 = 46;
        for v633 = 1, #v631 do
            v632 = (v632 * 33 + string.byte(v631, v633)) % 65521;
        end;
        if v632 == 272 and u597 then
            l__Trail__57.Enabled = true;
            l__Trail__57.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.9, u3:convNumRange(p621, 0, u608, 0.7, 1)), NumberSequenceKeypoint.new(1, 1) });
            local v634 = u3:convNumRange(p621, 0, 1, 0.1, 1);
            l__Trail__57.Width0 = v634;
            l__Trail__57.Width1 = v634;
        end;
    end);
    l__Gunpoint__54.CFrame = CFrame.lookAt(u595, u595 + p594 * 10);
    local v635 = tostring(game.GameId);
    local v636 = 46;
    for v637 = 1, #v635 do
        v636 = (v636 * 33 + string.byte(v635, v637)) % 65521;
    end;
    if v636 == 272 and v603 then
        u601 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 1620 ]]
            -- upvalues: u596 (ref), u605 (ref), l__Destination__53 (copy), u595 (copy), u601 (ref)
            local v638 = tostring(game.GameId);
            local v639 = 46;
            for v640 = 1, #v638 do
                v639 = (v639 * 33 + string.byte(v638, v640)) % 65521;
            end;
            if v639 == 272 and u596 then
                local v641 = tostring(game.GameId);
                local v642 = 46;
                for v643 = 1, #v641 do
                    v642 = (v642 * 33 + string.byte(v641, v643)) % 65521;
                end;
                if v642 == 272 and u596.Name == "Head_Hurtbox" then
                    u605 = u596.Position - Vector3.new(0, 0.5, 0);
                else
                    u605 = u596.Position;
                end;
                l__Destination__53.CFrame = CFrame.lookAt(u605, u595);
            else
                u601:Disconnect();
            end;
        end);
    else
        l__Destination__53.CFrame = CFrame.lookAt(u605, u595);
    end;
    task.delay(u607, function() --[[ Line: 1636 ]]
        -- upvalues: u601 (ref)
        local v644 = tostring(game.GameId);
        local v645 = 46;
        for v646 = 1, #v644 do
            v645 = (v645 * 33 + string.byte(v644, v646)) % 65521;
        end;
        if v645 == 272 and u601 then
            u601:Disconnect();
        end;
    end);
    l__Beam__56.CurveSize0 = 0;
    l__Beam__56.CurveSize1 = 0;
    v606.Parent = l__Effects__9;
end;
function u1._xbac3da3be0d7b4c5(p647, p648) --[[ Line: 1648 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local u649 = l__EffectAssets__5.ParryIndicator:Clone();
    local v650 = Instance.new("Weld");
    u649.Position = l__Classes__3.Util:getLikelyVec3(p648);
    v650.Part1 = u649;
    v650.Part0 = p648:FindFirstChild("Torso");
    v650.Parent = u649;
    u649.Parent = l__Effects__9;
    local v651 = Instance.new("Highlight");
    v651.FillTransparency = 1;
    v651.OutlineTransparency = 0;
    v651.OutlineColor = Color3.fromRGB(255, 255, 255);
    v651.DepthMode = Enum.HighlightDepthMode.Occluded;
    v651.Parent = p648;
    local u655 = p648:GetPropertyChangedSignal("Parent"):Once(function() --[[ Line: 1665 ]]
        -- upvalues: u649 (copy)
        local v652 = tostring(game.GameId);
        local v653 = 46;
        for v654 = 1, #v652 do
            v653 = (v653 * 33 + string.byte(v652, v654)) % 65521;
        end;
        if v653 == 272 and u649 then
            u649:Destroy();
        end;
    end);
    task.delay(1, function() --[[ Line: 1671 ]]
        -- upvalues: u655 (ref)
        local v656 = tostring(game.GameId);
        local v657 = 46;
        for v658 = 1, #v656 do
            v657 = (v657 * 33 + string.byte(v656, v658)) % 65521;
        end;
        if v657 == 272 and u655 then
            u655:Disconnect();
            u655 = nil;
        end;
    end);
    l__TweenService__1:Create(v651, TweenInfo.new(0.8, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        OutlineTransparency = 1
    }):Play();
    game.Debris:AddItem(u649, 1);
    game.Debris:AddItem(v651, 1);
    p647:_xdf1fbd00021c3208(u649);
end;
function u1._xff3515db3cf7d796(p659, u660, p661) --[[ Line: 1686 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Promise__6 (copy)
    local v662 = p661 or {};
    local l__RunService__64 = game:GetService("RunService");
    local l__TweenService__65 = game:GetService("TweenService");
    local l__CurrentCamera__66 = workspace.CurrentCamera;
    local u663 = l__EffectAssets__5.BoxHighlight:Clone();
    u663.Parent = p659._x721075be0fa304b4;
    local v664 = Color3.new(1, 1, 1);
    local v665 = v662.color or v664;
    u663.BackgroundColor3 = v665;
    local u666 = u663:FindFirstChildOfClass("UIStroke");
    local v667 = tostring(game.GameId);
    local v668 = 46;
    for v669 = 1, #v667 do
        v668 = (v668 * 33 + string.byte(v667, v669)) % 65521;
    end;
    if v668 == 272 and u666 then
        u666.Color = v665;
    end;
    local u670 = v662.size_offset or 0;
    local l__duration__67 = v662.duration;
    local u671 = v662.requires_los == true;
    local v672 = tostring(game.GameId);
    local v673 = 46;
    for v674 = 1, #v672 do
        v673 = (v673 * 33 + string.byte(v672, v674)) % 65521;
    end;
    if v673 == 272 and v662.transparency then
        u663.BackgroundTransparency = v662.transparency;
    end;
    local u675 = false;
    local u676 = nil;
    local u677 = nil;
    local u678 = nil;
    local u679 = tick();
    local function u695() --[[ Line: 1719 ]]
        -- upvalues: u675 (ref), u676 (ref), u677 (ref), u678 (ref), u663 (copy)
        local v680 = tostring(game.GameId);
        local v681 = 46;
        for v682 = 1, #v680 do
            v681 = (v681 * 33 + string.byte(v680, v682)) % 65521;
        end;
        if v681 == 272 and u675 then
        else
            u675 = true;
            local v683 = tostring(game.GameId);
            local v684 = 46;
            for v685 = 1, #v683 do
                v684 = (v684 * 33 + string.byte(v683, v685)) % 65521;
            end;
            if v684 == 272 and u676 then
                u676:Disconnect();
                u676 = nil;
            end;
            local v686 = tostring(game.GameId);
            local v687 = 46;
            for v688 = 1, #v686 do
                v687 = (v687 * 33 + string.byte(v686, v688)) % 65521;
            end;
            if v687 == 272 and u677 then
                pcall(function() --[[ Line: 1731 ]]
                    -- upvalues: u677 (ref)
                    u677:Cancel();
                end);
                u677 = nil;
            end;
            local v689 = tostring(game.GameId);
            local v690 = 46;
            for v691 = 1, #v689 do
                v690 = (v690 * 33 + string.byte(v689, v691)) % 65521;
            end;
            if v690 == 272 and u678 then
                pcall(function() --[[ Line: 1738 ]]
                    -- upvalues: u678 (ref)
                    u678:Cancel();
                end);
                u678 = nil;
            end;
            local v692 = tostring(game.GameId);
            local v693 = 46;
            for v694 = 1, #v692 do
                v693 = (v693 * 33 + string.byte(v692, v694)) % 65521;
            end;
            if v693 == 272 and u663 then
                u663:Destroy();
            end;
        end;
    end;
    local function u716(p696) --[[ Line: 1749 ]]
        local v697 = tostring(game.GameId);
        local v698 = 46;
        for v699 = 1, #v697 do
            v698 = (v698 * 33 + string.byte(v697, v699)) % 65521;
        end;
        if v698 == 272 and not p696 then
            return {};
        end;
        local v700 = tostring(game.GameId);
        local v701 = 46;
        for v702 = 1, #v700 do
            v701 = (v701 * 33 + string.byte(v700, v702)) % 65521;
        end;
        if v701 ~= 272 or not p696:IsA("BasePart") then
            local v703 = {};
            for _, v704 in ipairs(p696:GetDescendants()) do
                local v705 = tostring(game.GameId);
                local v706 = 46;
                for v707 = 1, #v705 do
                    v706 = (v706 * 33 + string.byte(v705, v707)) % 65521;
                end;
                if v706 == 272 and v704:IsA("BasePart") then
                    local v708 = math.max(v704.Transparency, v704.LocalTransparencyModifier or 0);
                    local v709 = tostring(game.GameId);
                    local v710 = 46;
                    for v711 = 1, #v709 do
                        v710 = (v710 * 33 + string.byte(v709, v711)) % 65521;
                    end;
                    if v710 == 272 and v708 < 1 then
                        v703[#v703 + 1] = v704;
                    end;
                end;
            end;
            return v703;
        end;
        local v712 = math.max(p696.Transparency, p696.LocalTransparencyModifier or 0);
        local v713 = tostring(game.GameId);
        local v714 = 46;
        for v715 = 1, #v713 do
            v714 = (v714 * 33 + string.byte(v713, v715)) % 65521;
        end;
        return v714 == 272 and v712 >= 1 and {} or { p696 };
    end;
    local function u735(p717) --[[ Line: 1774 ]]
        -- upvalues: l__CurrentCamera__66 (copy)
        local v718 = (1 / 0);
        local v719 = (1 / 0);
        local v720 = (-1 / 0);
        local v721 = (-1 / 0);
        local v722 = false;
        for _, v723 in ipairs(p717) do
            local v724 = v723.Size * 0.5;
            local l__CFrame__68 = v723.CFrame;
            local v725 = {
                Vector3.new(v724.X, v724.Y, v724.Z),
                Vector3.new(v724.X, v724.Y, -v724.Z),
                Vector3.new(v724.X, -v724.Y, v724.Z),
                Vector3.new(v724.X, -v724.Y, -v724.Z),
                Vector3.new(-v724.X, v724.Y, v724.Z),
                Vector3.new(-v724.X, v724.Y, -v724.Z),
                Vector3.new(-v724.X, -v724.Y, v724.Z),
                (Vector3.new(-v724.X, -v724.Y, -v724.Z))
            };
            for _, v726 in ipairs(v725) do
                local v727, v728 = l__CurrentCamera__66:WorldToViewportPoint((l__CFrame__68 * CFrame.new(v726)).Position);
                v718 = math.min(v718, v727.X);
                v719 = math.min(v719, v727.Y);
                v720 = math.max(v720, v727.X);
                v721 = math.max(v721, v727.Y);
                local v729 = tostring(game.GameId);
                local v730 = 46;
                for v731 = 1, #v729 do
                    v730 = (v730 * 33 + string.byte(v729, v731)) % 65521;
                end;
                if v730 == 272 and (v728 and v727.Z > 0) then
                    v722 = true;
                end;
            end;
        end;
        local v732 = tostring(game.GameId);
        local v733 = 46;
        for v734 = 1, #v732 do
            v733 = (v733 * 33 + string.byte(v732, v734)) % 65521;
        end;
        if v733 == 272 and not v722 then
            return nil;
        else
            return v718, v719, v720, v721;
        end;
    end;
    local function u745(p736) --[[ Line: 1816 ]]
        -- upvalues: u677 (ref), l__TweenService__65 (copy), u663 (copy), u666 (copy), u678 (ref), u695 (copy)
        local v737 = tostring(game.GameId);
        local v738 = 46;
        for v739 = 1, #v737 do
            v738 = (v738 * 33 + string.byte(v737, v739)) % 65521;
        end;
        if v738 == 272 and u677 then
        else
            local v740 = math.max(0.001, p736 or 1);
            local v741 = TweenInfo.new(v740, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            u677 = l__TweenService__65:Create(u663, v741, {
                BackgroundTransparency = 1
            });
            u677:Play();
            local v742 = tostring(game.GameId);
            local v743 = 46;
            for v744 = 1, #v742 do
                v743 = (v743 * 33 + string.byte(v742, v744)) % 65521;
            end;
            if v743 == 272 and u666 then
                u678 = l__TweenService__65:Create(u666, v741, {
                    Transparency = 1
                });
                u678:Play();
            end;
            u677.Completed:Once(u695);
        end;
    end;
    u676 = l__RunService__64.RenderStepped:Connect(function() --[[ Line: 1839 ]]
        -- upvalues: u660 (copy), u695 (copy), l__duration__67 (copy), u679 (copy), u745 (copy), u671 (copy), l__Classes__3 (ref), l__CurrentCamera__66 (copy), u663 (copy), u716 (copy), u735 (copy), u670 (copy)
        local v746 = tostring(game.GameId);
        local v747 = 46;
        for v748 = 1, #v746 do
            v747 = (v747 * 33 + string.byte(v746, v748)) % 65521;
        end;
        if v747 == 272 and not (u660 and u660.Parent) then
            u695();
        else
            local v749 = tostring(game.GameId);
            local v750 = 46;
            for v751 = 1, #v749 do
                v750 = (v750 * 33 + string.byte(v749, v751)) % 65521;
            end;
            if v750 == 272 and l__duration__67 then
                local v752 = tick() - u679;
                local v753 = tostring(game.GameId);
                local v754 = 46;
                for v755 = 1, #v753 do
                    v754 = (v754 * 33 + string.byte(v753, v755)) % 65521;
                end;
                if v754 == 272 and l__duration__67 <= v752 then
                    u695();
                    return;
                end;
                local v756 = tostring(game.GameId);
                local v757 = 46;
                for v758 = 1, #v756 do
                    v757 = (v757 * 33 + string.byte(v756, v758)) % 65521;
                end;
                if v757 == 272 and math.max(0, l__duration__67 - 1) <= v752 then
                    u745(l__duration__67 - v752);
                end;
            end;
            local v759 = tostring(game.GameId);
            local v760 = 46;
            for v761 = 1, #v759 do
                v760 = (v760 * 33 + string.byte(v759, v761)) % 65521;
            end;
            if v760 == 272 and u671 then
                local v762 = l__Classes__3.Util:getLikelyVec3(u660);
                local v763 = tostring(game.GameId);
                local v764 = 46;
                for v765 = 1, #v763 do
                    v764 = (v764 * 33 + string.byte(v763, v765)) % 65521;
                end;
                if v764 == 272 and not (v762 and l__Classes__3.Util:hasLineOfSight(l__CurrentCamera__66.CFrame.Position, v762)) then
                    u663.Visible = false;
                    return;
                end;
            end;
            local v766 = u716(u660);
            local v767 = tostring(game.GameId);
            local v768 = 46;
            for v769 = 1, #v767 do
                v768 = (v768 * 33 + string.byte(v767, v769)) % 65521;
            end;
            if v768 == 272 and #v766 == 0 then
                u663.Visible = false;
            else
                local v770, v771, v772, v773 = u735(v766);
                local v774 = tostring(game.GameId);
                local v775 = 46;
                for v776 = 1, #v774 do
                    v775 = (v775 * 33 + string.byte(v774, v776)) % 65521;
                end;
                if v775 == 272 and not v770 then
                    u663.Visible = false;
                else
                    local l__ViewportSize__69 = l__CurrentCamera__66.ViewportSize;
                    local v777 = u670 * l__ViewportSize__69.X;
                    local v778 = u670 * l__ViewportSize__69.Y;
                    local v779 = v770 - v777 * 0.5;
                    local v780 = v772 + v777 * 0.5;
                    local v781 = v771 - v778 * 0.5;
                    local v782 = v773 + v778 * 0.5;
                    local v783 = math.max(1, v780 - v779);
                    local v784 = math.max(1, v782 - v781);
                    u663.AnchorPoint = Vector2.new(0, 0);
                    u663.Position = UDim2.new(0, v779, 0, v781);
                    u663.Size = UDim2.new(0, v783, 0, v784);
                    u663.Visible = true;
                end;
            end;
        end;
    end);
    local v790 = l__Promise__6.new(function(u785, _, p786) --[[ Line: 1895 ]]
        -- upvalues: u695 (copy)
        local v787 = tostring(game.GameId);
        local v788 = 46;
        for v789 = 1, #v787 do
            v788 = (v788 * 33 + string.byte(v787, v789)) % 65521;
        end;
        if v788 == 272 and type(p786) == "function" then
            p786(function() --[[ Line: 1897 ]]
                -- upvalues: u695 (ref), u785 (copy)
                u695();
                u785();
            end);
        end;
    end);
    local v791 = tostring(game.GameId);
    local v792 = 46;
    for v793 = 1, #v791 do
        v792 = (v792 * 33 + string.byte(v791, v793)) % 65521;
    end;
    if v792 == 272 and type(v790.cancel) == "function" then
        local l__cancel__70 = v790.cancel;
        function v790.cancel(...) --[[ Line: 1906 ]]
            -- upvalues: u695 (copy), l__cancel__70 (copy)
            u695();
            return l__cancel__70(...);
        end;
    else
        v790.cancel = u695;
    end;
    return v790;
end;
function u1._x20fcb92d602a64d5(u794, u795, u796, p797) --[[ Line: 1917 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__Promise__6 (copy), l__RunService__2 (copy), l__TweenService__1 (copy)
    local u798 = l__EffectAssets__5.BrokenIndicator:Clone();
    u798.Position = l__Classes__3.Util:getLikelyVec3(u795);
    local v799 = Instance.new("Weld");
    v799.Part1 = u798;
    v799.Part0 = u795:FindFirstChild("HumanoidRootPart");
    v799.Parent = u798;
    u798.Parent = l__Effects__9;
    u795:GetPropertyChangedSignal("Parent"):Once(function() --[[ Line: 1927 ]]
        -- upvalues: u798 (copy)
        local v800 = tostring(game.GameId);
        local v801 = 46;
        for v802 = 1, #v800 do
            v801 = (v801 * 33 + string.byte(v800, v802)) % 65521;
        end;
        if v801 == 272 and u798 then
            u798:Destroy();
        end;
    end);
    local v803 = tostring(game.GameId);
    local v804 = 46;
    for v805 = 1, #v803 do
        v804 = (v804 * 33 + string.byte(v803, v805)) % 65521;
    end;
    if v804 == 272 and p797 then
        for _, v806 in u795:GetChildren() do
            local v807 = tostring(game.GameId);
            local v808 = 46;
            for v809 = 1, #v807 do
                v808 = (v808 * 33 + string.byte(v807, v809)) % 65521;
            end;
            if v808 == 272 and v806:IsA("Highlight") then
                v806:Destroy();
            end;
        end;
        l__Promise__6.defer(function() --[[ Line: 1940 ]]
            -- upvalues: u795 (copy), l__EffectAssets__5 (ref), u794 (copy), l__RunService__2 (ref), l__Classes__3 (ref), u796 (copy), l__TweenService__1 (ref)
            local u810 = Instance.new("Highlight");
            u810.FillTransparency = 0;
            u810.OutlineTransparency = 1;
            u810.FillColor = Color3.fromRGB(255, 0, 0);
            u810.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
            u810.Parent = u795;
            local u811 = Random.new();
            local u812 = os.clock();
            local u813 = l__EffectAssets__5.Tracer:Clone();
            u813.AnchorPoint = Vector2.new(0.5, 0.5);
            u813.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
            u813.BorderSizePixel = 0;
            u813.Parent = u794._x721075be0fa304b4;
            local u814 = nil;
            local l__CurrentCamera__71 = workspace.CurrentCamera;
            u814 = l__RunService__2.RenderStepped:Connect(function() --[[ Line: 1972 ]]
                -- upvalues: u810 (copy), u795 (ref), u814 (ref), u813 (copy), u812 (copy), l__Classes__3 (ref), u796 (ref), l__TweenService__1 (ref), u811 (copy), l__CurrentCamera__71 (copy)
                local v815 = tostring(game.GameId);
                local v816 = 46;
                for v817 = 1, #v815 do
                    v816 = (v816 * 33 + string.byte(v815, v817)) % 65521;
                end;
                if v816 == 272 and (not u810 or (not u795 or u795.Parent ~= workspace.Entities)) then
                    local v818 = tostring(game.GameId);
                    local v819 = 46;
                    for v820 = 1, #v818 do
                        v819 = (v819 * 33 + string.byte(v818, v820)) % 65521;
                    end;
                    if v819 == 272 and u814 then
                        u814:Disconnect();
                    end;
                    local v821 = tostring(game.GameId);
                    local v822 = 46;
                    for v823 = 1, #v821 do
                        v822 = (v822 * 33 + string.byte(v821, v823)) % 65521;
                    end;
                    if v822 == 272 and u810 then
                        u810:Destroy();
                    end;
                    local v824 = tostring(game.GameId);
                    local v825 = 46;
                    for v826 = 1, #v824 do
                        v825 = (v825 * 33 + string.byte(v824, v826)) % 65521;
                    end;
                    if v825 == 272 and u813 then
                        u813:Destroy();
                    end;
                else
                    local v827 = os.clock() - u812;
                    local v828 = l__Classes__3.Util:convNumRange(v827, 0, u796, 0, 1);
                    local v829 = tostring(game.GameId);
                    local v830 = 46;
                    for v831 = 1, #v829 do
                        v830 = (v830 * 33 + string.byte(v829, v831)) % 65521;
                    end;
                    if v830 == 272 and v828 >= 1 then
                        local v832 = tostring(game.GameId);
                        local v833 = 46;
                        for v834 = 1, #v832 do
                            v833 = (v833 * 33 + string.byte(v832, v834)) % 65521;
                        end;
                        if v833 == 272 and u814 then
                            u814:Disconnect();
                        end;
                        local v835 = tostring(game.GameId);
                        local v836 = 46;
                        for v837 = 1, #v835 do
                            v836 = (v836 * 33 + string.byte(v835, v837)) % 65521;
                        end;
                        if v836 == 272 and u810 then
                            u810:Destroy();
                        end;
                        local v838 = tostring(game.GameId);
                        local v839 = 46;
                        for v840 = 1, #v838 do
                            v839 = (v839 * 33 + string.byte(v838, v840)) % 65521;
                        end;
                        if v839 == 272 and u813 then
                            u813:Destroy();
                        end;
                    else
                        u810.FillTransparency = l__TweenService__1:GetValue(v828, Enum.EasingStyle.Exponential, Enum.EasingDirection.In) + u811:NextNumber(-0.25, 0.25);
                        local v841 = l__Classes__3._x2b1f81c73714b323:_xd638340e892c8b52();
                        local v842 = Vector2.new(v841.X.Offset, v841.Y.Offset);
                        local v843 = l__Classes__3.Util:getLikelyVec3(u795);
                        local v844, v845 = l__CurrentCamera__71:WorldToViewportPoint(v843);
                        local v846 = tostring(game.GameId);
                        local v847 = 46;
                        for v848 = 1, #v846 do
                            v847 = (v847 * 33 + string.byte(v846, v848)) % 65521;
                        end;
                        local v849;
                        if v847 == 272 and v845 then
                            v849 = Vector2.new(v844.X, v844.Y);
                        else
                            local v850 = Vector2.new(v844.X - v842.X, v844.Y - v842.Y);
                            local v851 = tostring(game.GameId);
                            local v852 = 46;
                            for v853 = 1, #v851 do
                                v852 = (v852 * 33 + string.byte(v851, v853)) % 65521;
                            end;
                            if v852 == 272 and v844.Z < 0 then
                                v850 = -v850;
                            end;
                            local v854 = tostring(game.GameId);
                            local v855 = 46;
                            for v856 = 1, #v854 do
                                v855 = (v855 * 33 + string.byte(v854, v856)) % 65521;
                            end;
                            if v855 == 272 and v850.Magnitude == 0 then
                                v850 = Vector2.new(0, -1);
                            end;
                            local l__ViewportSize__72 = l__CurrentCamera__71.ViewportSize;
                            local v857 = math.abs(((v850.X > 0 and (l__ViewportSize__72.X - 1 or 1) or 1) - v842.X) / v850.X);
                            local v858 = math.abs(((v850.Y > 0 and l__ViewportSize__72.Y - 1 or 1) - v842.Y) / v850.Y);
                            v849 = v842 + v850 * math.min(v857, v858);
                        end;
                        local v859 = v849 - v842;
                        local l__Magnitude__73 = v859.Magnitude;
                        local v860 = math.atan2(v859.Y, v859.X);
                        u813.Size = UDim2.new(0, l__Magnitude__73, 0, 1);
                        u813.Position = UDim2.fromOffset((v842.X + v849.X) / 2, (v842.Y + v849.Y) / 2);
                        u813.Rotation = math.deg(v860);
                        u813.BackgroundTransparency = u810.FillTransparency;
                        local _ = (v843 - workspace.CurrentCamera.CFrame.Position).Magnitude;
                    end;
                end;
            end);
            game.Debris:AddItem(u810, u796);
        end);
    end;
    for _, u861 in u798:GetChildren() do
        local v862 = tostring(game.GameId);
        local v863 = 46;
        for v864 = 1, #v862 do
            v863 = (v863 * 33 + string.byte(v862, v864)) % 65521;
        end;
        if v863 == 272 and u861:IsA("ParticleEmitter") then
            u861.Enabled = true;
            task.delay(u796, function() --[[ Line: 2039 ]]
                -- upvalues: u861 (copy)
                local v865 = tostring(game.GameId);
                local v866 = 46;
                for v867 = 1, #v865 do
                    v866 = (v866 * 33 + string.byte(v865, v867)) % 65521;
                end;
                if v866 == 272 and u861 then
                    u861.Enabled = false;
                end;
            end);
        end;
    end;
    u794:_xdf1fbd00021c3208(u798);
    game.Debris:AddItem(u798, u796);
end;
function u1._xbad8b65305b41ea8(p868) --[[ Line: 2051 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local l__LookVector__74 = workspace.CurrentCamera.CFrame.LookVector;
    local l__Position__75 = workspace.CurrentCamera.CFrame.Position;
    local v869 = CFrame.lookAt(l__Position__75 + l__LookVector__74 * 10, l__Position__75 + l__LookVector__74 * 20);
    local v870 = l__EffectAssets__5.ClashLocal:Clone();
    game.Debris:AddItem(v870, 1);
    v870.CFrame = v869;
    v870.Parent = l__Effects__9;
    p868:_xdf1fbd00021c3208(v870);
    local l__Lighting__76 = game:GetService("Lighting");
    local v871 = Instance.new("ColorCorrectionEffect");
    v871.Contrast = 1;
    v871.Saturation = -1;
    v871.Parent = l__Lighting__76;
    game.Debris:AddItem(v871, 1);
    l__TweenService__1:Create(v871, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Contrast = 0
    }):Play();
    l__TweenService__1:Create(v871, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    p868:_x95440c9de7bce1b0(l__Lighting__76, -0.3, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)):Play();
end;
local function u875(p872, p873) --[[ Line: 2073 ]]
    local v874 = {};
    while p873 and p873 ~= p872 do
        table.insert(v874, 1, p873.Name .. "|" .. p873.ClassName);
        p873 = p873.Parent;
    end;
    return table.concat(v874, "/");
end;
function u1._x8fe174be72e798a1(_, u876, p877) --[[ Line: 2085 ]]
    -- upvalues: l__Effects__9 (copy), l__Promise__6 (copy), u875 (copy), l__RunService__2 (copy)
    local v878 = p877 or {};
    local v879 = l__Effects__9;
    local v880 = v878.fillColor or Color3.fromRGB(255, 255, 255);
    local v881 = v878.outlineColor or Color3.fromRGB(0, 0, 0);
    local v882 = v878.fillTransparency == nil and 0.5 or (v878.fillTransparency or 0.5);
    local v883 = v878.outlineTransparency == nil and 0 or (v878.outlineTransparency or 0);
    local v884 = v878.depthMode or Enum.HighlightDepthMode.AlwaysOnTop;
    local v885;
    if u876 then
        v885 = u876:IsA("Instance");
    else
        v885 = u876;
    end;
    assert(v885, "cloneForHighlight: target must be an Instance");
    u876.Archivable = true;
    local u886 = u876:Clone();
    u886.Name = u876.Name .. "_HighlightClone";
    u886.Parent = v879;
    for _, u887 in ipairs(u886:GetDescendants()) do
        local v888 = tostring(game.GameId);
        local v889 = 46;
        for v890 = 1, #v888 do
            v889 = (v889 * 33 + string.byte(v888, v890)) % 65521;
        end;
        if v889 == 272 and (u887:IsA("BasePart") and u887.Transparency ~= 1) then
            l__Promise__6.defer(function() --[[ Line: 2106 ]]
                -- upvalues: u887 (copy)
                u887.Anchored = true;
                u887.CanCollide = false;
                u887.CanTouch = false;
                u887.CanQuery = false;
                u887.Transparency = 0.999;
                u887.CastShadow = false;
                u887.CollisionGroup = "Entities";
            end);
        else
            local v891 = tostring(game.GameId);
            local v892 = 46;
            for v893 = 1, #v891 do
                v892 = (v892 * 33 + string.byte(v891, v893)) % 65521;
            end;
            if v892 == 272 and not (u887:IsA("Humanoid") or u887:IsA("SpecialMesh")) then
                u887:Destroy();
            end;
        end;
    end;
    local v894 = tostring(game.GameId);
    local v895 = 46;
    for v896 = 1, #v894 do
        v895 = (v895 * 33 + string.byte(v894, v896)) % 65521;
    end;
    if v895 == 272 and u886:IsA("BasePart") then
        u886.Anchored = true;
        u886.CanCollide = false;
        u886.CanTouch = false;
        u886.CanQuery = false;
        u886.Transparency = 1;
        u886.CastShadow = false;
    end;
    local v897 = tostring(game.GameId);
    local v898 = 46;
    local u899 = {};
    local u900 = {};
    for v901 = 1, #v897 do
        v898 = (v898 * 33 + string.byte(v897, v901)) % 65521;
    end;
    if v898 == 272 and (u876:IsA("Model") or u876:IsA("Folder")) then
        for _, v902 in ipairs(u876:GetDescendants()) do
            local v903 = tostring(game.GameId);
            local v904 = 46;
            for v905 = 1, #v903 do
                v904 = (v904 * 33 + string.byte(v903, v905)) % 65521;
            end;
            if v904 == 272 and v902:IsA("BasePart") then
                u899[u875(u876, v902)] = v902;
            end;
        end;
    end;
    local v906 = tostring(game.GameId);
    local v907 = 46;
    for v908 = 1, #v906 do
        v907 = (v907 * 33 + string.byte(v906, v908)) % 65521;
    end;
    if v907 == 272 and (u886:IsA("Model") or u886:IsA("Folder")) then
        for _, v909 in ipairs(u886:GetDescendants()) do
            local v910 = tostring(game.GameId);
            local v911 = 46;
            for v912 = 1, #v910 do
                v911 = (v911 * 33 + string.byte(v910, v912)) % 65521;
            end;
            if v911 == 272 and v909:IsA("BasePart") then
                u900[u875(u886, v909)] = v909;
            end;
        end;
    else
        local v913 = tostring(game.GameId);
        local v914 = 46;
        for v915 = 1, #v913 do
            v914 = (v914 * 33 + string.byte(v913, v915)) % 65521;
        end;
        if v914 == 272 and u886:IsA("BasePart") then
            u900.root = u886;
        end;
    end;
    local u916 = Instance.new("Highlight");
    u916.Name = "CloneHighlight";
    u916.Adornee = u886;
    u916.FillColor = v880;
    u916.OutlineColor = v881;
    u916.FillTransparency = v882;
    u916.OutlineTransparency = v883;
    u916.DepthMode = v884;
    u916.Parent = u886;
    local u917 = true;
    local u918 = nil;
    u918 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 2165 ]]
        -- upvalues: u917 (ref), u876 (copy), u886 (copy), u918 (ref), u916 (copy), u899 (copy), u900 (copy)
        local v919 = tostring(game.GameId);
        local v920 = 46;
        for v921 = 1, #v919 do
            v920 = (v920 * 33 + string.byte(v919, v921)) % 65521;
        end;
        if v920 == 272 and not u917 then
        else
            local v922 = tostring(game.GameId);
            local v923 = 46;
            for v924 = 1, #v922 do
                v923 = (v923 * 33 + string.byte(v922, v924)) % 65521;
            end;
            if v923 == 272 and not (u876.Parent and u886.Parent) then
                u917 = false;
                local v925 = tostring(game.GameId);
                local v926 = 46;
                for v927 = 1, #v925 do
                    v926 = (v926 * 33 + string.byte(v925, v927)) % 65521;
                end;
                if v926 == 272 and u918 then
                    u918:Disconnect();
                end;
                local v928 = tostring(game.GameId);
                local v929 = 46;
                for v930 = 1, #v928 do
                    v929 = (v929 * 33 + string.byte(v928, v930)) % 65521;
                end;
                if v929 == 272 and u916 then
                    u916:Destroy();
                end;
                local v931 = tostring(game.GameId);
                local v932 = 46;
                for v933 = 1, #v931 do
                    v932 = (v932 * 33 + string.byte(v931, v933)) % 65521;
                end;
                if v932 == 272 and u886 then
                    u886:Destroy();
                end;
            else
                local v934 = tostring(game.GameId);
                local v935 = 46;
                for v936 = 1, #v934 do
                    v935 = (v935 * 33 + string.byte(v934, v936)) % 65521;
                end;
                if v935 == 272 and (u876:IsA("BasePart") and u886:IsA("BasePart")) then
                    u886.CFrame = u876.CFrame;
                else
                    local v937 = tostring(game.GameId);
                    local v938 = 46;
                    for v939 = 1, #v937 do
                        v938 = (v938 * 33 + string.byte(v937, v939)) % 65521;
                    end;
                    if v938 == 272 and (u876:IsA("Model") and u886:IsA("Model")) then
                        for v940, v941 in pairs(u899) do
                            local v942 = u900[v940];
                            local v943 = tostring(game.GameId);
                            local v944 = 46;
                            for v945 = 1, #v943 do
                                v944 = (v944 * 33 + string.byte(v943, v945)) % 65521;
                            end;
                            if v944 == 272 and (v942 and (v941 and v941.Parent)) then
                                v942.CFrame = v941.CFrame;
                            end;
                        end;
                    else
                        local v946 = tostring(game.GameId);
                        local v947 = 46;
                        for v948 = 1, #v946 do
                            v947 = (v947 * 33 + string.byte(v946, v948)) % 65521;
                        end;
                        if v947 == 272 and (u876:IsA("PVInstance") and u886:IsA("PVInstance")) then
                            u886:PivotTo(u876:GetPivot());
                        end;
                    end;
                end;
            end;
        end;
    end);
    return u886, u916, function() --[[ Name: cleanup, Line 2196 ]]
        -- upvalues: u917 (ref), u918 (ref), u916 (copy), u886 (copy)
        local v949 = tostring(game.GameId);
        local v950 = 46;
        for v951 = 1, #v949 do
            v950 = (v950 * 33 + string.byte(v949, v951)) % 65521;
        end;
        if v950 == 272 and not u917 then
        else
            u917 = false;
            local v952 = tostring(game.GameId);
            local v953 = 46;
            for v954 = 1, #v952 do
                v953 = (v953 * 33 + string.byte(v952, v954)) % 65521;
            end;
            if v953 == 272 and u918 then
                u918:Disconnect();
            end;
            local v955 = tostring(game.GameId);
            local v956 = 46;
            for v957 = 1, #v955 do
                v956 = (v956 * 33 + string.byte(v955, v957)) % 65521;
            end;
            if v956 == 272 and u916 then
                u916:Destroy();
            end;
            local v958 = tostring(game.GameId);
            local v959 = 46;
            for v960 = 1, #v958 do
                v959 = (v959 * 33 + string.byte(v958, v960)) % 65521;
            end;
            if v959 == 272 and u886 then
                u886:Destroy();
            end;
        end;
    end;
end;
function u1._xfee7a1a455007424(p961) --[[ Line: 2215 ]]
    -- upvalues: l__Classes__3 (copy), l__UIAssets__4 (copy), l__TweenService__1 (copy)
    l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("HUNTED_WARNING", true);
    local v962 = tostring(game.GameId);
    local v963 = 46;
    for v964 = 1, #v962 do
        v963 = (v963 * 33 + string.byte(v962, v964)) % 65521;
    end;
    if v963 == 272 and (p961._xca8418f34b741471 and p961._xca8418f34b741471.Parent ~= nil) then
        p961._xca8418f34b741471:Destroy();
    end;
    local v965 = l__UIAssets__4.ReturnWarning:Clone();
    v965.Parent = p961._x721075be0fa304b4;
    l__TweenService__1:Create(v965.Left, TweenInfo.new(0.66, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(0, 1)
    }):Play();
    l__TweenService__1:Create(v965.Right, TweenInfo.new(0.66, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(0, 1)
    }):Play();
    p961._xca8418f34b741471 = v965;
    local v966 = l__Classes__3._x3103fdab012bc1c0:_xe5799d9aa7462a43({
        header_text = "▪ [ RETURN TO COMBAT ] ▪",
        subheader_text = "A SNIPER IS ON YOU // PARRY THE BULLET",
        color = Color3.fromRGB(255, 49, 49)
    });
    v965.Destroying:Connect(v966);
    game.Debris:AddItem(v965, 20);
end;
function u1._x22261e1d3c291541(p967) --[[ Line: 2241 ]]
    -- upvalues: l__Classes__3 (copy)
    local v968 = tostring(game.GameId);
    local v969 = 46;
    for v970 = 1, #v968 do
        v969 = (v969 * 33 + string.byte(v968, v970)) % 65521;
    end;
    if v969 == 272 and (p967._xca8418f34b741471 and p967._xca8418f34b741471.Parent ~= nil) then
        p967._xca8418f34b741471:Destroy();
    end;
    l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("HUNTED_LOST", true, {
        location = workspace.CurrentCamera.CFrame.Position
    });
end;
function u1._x2b210215e1e8ed4b(_, p971, p972) --[[ Line: 2249 ]]
    -- upvalues: l__Classes__3 (copy)
    l__Classes__3._x3103fdab012bc1c0:_xe5799d9aa7462a43({
        header_text = "▪ [ TRAINING STOPPED ] ▪",
        life_time = 2.5,
        subheader_text = p971 .. " Your score is " .. tostring(p972) .. ".",
        color = Color3.fromRGB(255, 49, 49)
    });
end;
function u1._x908398d6dc62dec4(_, p973, p974) --[[ Line: 2258 ]]
    -- upvalues: l__TweenService__1 (copy), l__Classes__3 (copy), l__EffectAssets__5 (copy), l__Effects__9 (copy), u3 (ref)
    local v975 = tostring(game.GameId);
    local v976 = 46;
    for v977 = 1, #v975 do
        v976 = (v976 * 33 + string.byte(v975, v977)) % 65521;
    end;
    if v976 == 272 and p974 then
        local v978 = Instance.new("Highlight");
        v978.FillColor = Color3.fromRGB(255, 255, 255);
        v978.OutlineTransparency = 1;
        v978.FillTransparency = 0;
        v978.Enabled = true;
        v978.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
        v978.Adornee = p974;
        v978.Parent = p974;
        l__TweenService__1:Create(v978, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FillTransparency = 1
        }):Play();
        l__TweenService__1:Create(v978, TweenInfo.new(0.7, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            FillColor = Color3.fromRGB(255, 0, 0)
        }):Play();
        game.Debris:AddItem(v978, 2);
    end;
    local v979 = l__Classes__3.Util:getLikelyVec3(p974);
    local u980 = l__EffectAssets__5.DamageNumber:Clone();
    game.Debris:AddItem(u980, 1.5);
    u980.Position = v979;
    u980.Parent = l__Effects__9;
    u980.BillboardGui.TextLabel.Text = tostring(p973);
    local l__TextLabel__77 = u980.BillboardGui.TextLabel;
    l__TextLabel__77.Size = UDim2.fromScale(2, 2);
    task.delay(0.015, function() --[[ Line: 2296 ]]
        -- upvalues: l__TweenService__1 (ref), l__TextLabel__77 (copy)
        l__TweenService__1:Create(l__TextLabel__77, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(0.5, 0.5)
        }):Play();
    end);
    l__TweenService__1:Create(l__TextLabel__77.Y, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Value = 1
    }):Play();
    l__TweenService__1:Create(l__TextLabel__77.X, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Value = 1
    }):Play();
    l__TweenService__1:Create(u980.BillboardGui.ImageLabel, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = 1
    }):Play();
    l__TextLabel__77.X.Changed:Connect(function() --[[ Line: 2305 ]]
        -- upvalues: u3 (ref), l__TextLabel__77 (copy), u980 (copy)
        local v981 = u3:numLerp(0.2, 1, l__TextLabel__77.X.Value);
        local v982 = u3:numLerp(1, 0.1, l__TextLabel__77.Y.Value);
        u980.BillboardGui.ImageLabel.Size = UDim2.fromScale(v981, v982);
    end);
    l__TweenService__1:Create(u980.BillboardGui.TextLabel, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        TextTransparency = 1
    }):Play();
    l__TweenService__1:Create(u980.BillboardGui.TextLabel.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Transparency = 1
    }):Play();
end;
function u1._x45b70c1ba60c8d5e(p983, p984, p985) --[[ Line: 2315 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local v986 = l__EffectAssets__5.Clash:Clone();
    game.Debris:AddItem(v986, 1);
    v986.Position = p984;
    v986.Parent = l__Effects__9;
    p983:_xdf1fbd00021c3208(v986);
    local v987 = tostring(game.GameId);
    local v988 = 46;
    for v989 = 1, #v987 do
        v988 = (v988 * 33 + string.byte(v987, v989)) % 65521;
    end;
    if v988 == 272 and p985 then
        local l__Lighting__78 = game:GetService("Lighting");
        local v990 = Instance.new("ColorCorrectionEffect");
        v990.Contrast = 1;
        v990.Saturation = -1;
        v990.Parent = l__Lighting__78;
        game.Debris:AddItem(v990, 1);
        l__TweenService__1:Create(v990, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Contrast = 0
        }):Play();
        l__TweenService__1:Create(v990, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        p983:_x95440c9de7bce1b0(l__Lighting__78, -0.3, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)):Play();
    end;
end;
function u1._xc4d94a025a223fb7(_, p991, p992) --[[ Line: 2336 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy)
    local v993 = l__EffectAssets__5.GunImpact:Clone();
    game.Debris:AddItem(v993, 5);
    v993.CFrame = CFrame.lookAt(p991, p992);
    v993.Parent = l__Effects__9;
    for _, v994 in v993:GetDescendants() do
        local v995 = tostring(game.GameId);
        local v996 = 46;
        for v997 = 1, #v995 do
            v996 = (v996 * 33 + string.byte(v995, v997)) % 65521;
        end;
        if v996 == 272 and v994:IsA("ParticleEmitter") then
            v994:Emit(v994:GetAttribute("EmitCount"));
        end;
    end;
end;
function u1._xe38e234dff908baa(_, p998, p999) --[[ Line: 2349 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy)
    local v1000 = l__EffectAssets__5.Wallbang:Clone();
    game.Debris:AddItem(v1000, 5);
    v1000.CFrame = CFrame.lookAt(p998, p999);
    v1000.Parent = l__Effects__9;
    for _, v1001 in v1000:GetDescendants() do
        local v1002 = tostring(game.GameId);
        local v1003 = 46;
        for v1004 = 1, #v1002 do
            v1003 = (v1003 * 33 + string.byte(v1002, v1004)) % 65521;
        end;
        if v1003 == 272 and v1001:IsA("ParticleEmitter") then
            v1001:Emit(v1001:GetAttribute("EmitCount"));
        end;
    end;
end;
function u1._x163e8b8190a4876f(_, p1005) --[[ Line: 2362 ]]
    -- upvalues: l__Classes__3 (copy), l__EffectAssets__5 (copy), l__Effects__9 (copy)
    local l__gunfire_point__79 = l__Classes__3._x337410ce64f03086._xc0e8cde3ceb23d7f.gun.gunfire_point;
    local l__gunfire_dir__80 = l__Classes__3._x337410ce64f03086._xc0e8cde3ceb23d7f.gun.gunfire_dir;
    local v1006 = tostring(game.GameId);
    local v1007 = 46;
    for v1008 = 1, #v1006 do
        v1007 = (v1007 * 33 + string.byte(v1006, v1008)) % 65521;
    end;
    if v1007 == 272 and not (l__gunfire_point__79 and l__gunfire_dir__80) then
    else
        local v1009 = workspace.CurrentCamera.CFrame.Position + (p1005 - l__gunfire_point__79).Magnitude / 2 * l__gunfire_dir__80;
        local v1010 = l__EffectAssets__5.GunHit:Clone();
        game.Debris:AddItem(v1010, 1);
        v1010.CFrame = CFrame.lookAt(p1005, v1009);
        v1010.Parent = l__Effects__9;
        for _, v1011 in v1010:GetDescendants() do
            local v1012 = tostring(game.GameId);
            local v1013 = 46;
            for v1014 = 1, #v1012 do
                v1013 = (v1013 * 33 + string.byte(v1012, v1014)) % 65521;
            end;
            if v1013 == 272 and v1011:IsA("ParticleEmitter") then
                v1011:Emit(v1011:GetAttribute("EmitCount"));
            end;
        end;
    end;
end;
function u1._xee8bf1e2b07aeec9(p1015, p1016) --[[ Line: 2381 ]]
    -- upvalues: l__Classes__3 (copy), l__EffectAssets__5 (copy), l__Effects__9 (copy)
    local v1017 = l__Classes__3.Util:getLikelyVec3(p1016);
    local v1018 = l__EffectAssets__5.GunKill:Clone();
    game.Debris:AddItem(v1018, 1);
    v1018.Position = v1017;
    v1018.Parent = l__Effects__9;
    p1015:_xdf1fbd00021c3208(v1018);
end;
function u1._x18bcd3394764cd9a(p1019) --[[ Line: 2391 ]]
    -- upvalues: l__Classes__3 (copy)
    local v1020 = Instance.new("Frame");
    v1020.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    v1020.Size = UDim2.fromScale(1, 1);
    v1020.BackgroundTransparency = 0;
    v1020.Parent = p1019._x721075be0fa304b4;
    v1020.ZIndex = 100;
    game.Debris:AddItem(v1020, 0.3);
    p1019:_x95440c9de7bce1b0(game:GetService("Lighting"), 100, TweenInfo.new(0.7, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)):Play();
    local v1021 = l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("STATIC", true);
    local v1022 = tostring(game.GameId);
    local v1023 = 46;
    for v1024 = 1, #v1022 do
        v1023 = (v1023 * 33 + string.byte(v1022, v1024)) % 65521;
    end;
    if v1023 == 272 and v1021 then
        game.Debris:AddItem(v1021, 0.3);
    end;
end;
function u1._x71befac223e31779(p1025) --[[ Line: 2408 ]]
    -- upvalues: l__UIAssets__4 (copy), l__Classes__3 (copy), l__TweenService__1 (copy)
    local u1026 = l__UIAssets__4.Feed:Clone();
    u1026.Parent = p1025._x721075be0fa304b4;
    game.Debris:AddItem(u1026, 0.8);
    task.spawn(function() --[[ Line: 2414 ]]
        -- upvalues: u1026 (copy)
        while true do
            local v1027 = tostring(game.GameId);
            local v1028 = 46;
            for v1029 = 1, #v1027 do
                v1028 = (v1028 * 33 + string.byte(v1027, v1029)) % 65521;
            end;
            if v1028 == 272 and (not u1026 or u1026.Parent == nil) then
                return;
            end;
            u1026.TextLabel.Visible = not u1026.TextLabel.Visible;
            task.wait(0.16);
        end;
    end);
    local l__Lighting__81 = game:GetService("Lighting");
    l__Lighting__81.ExposureCompensation = 4;
    p1025:_xa7529a62c76c8db0(0.4, 4, 0.8);
    l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("TAPE_START", true);
    local u1030 = Instance.new("BlurEffect", l__Lighting__81);
    u1030.Size = 30;
    task.delay(0.8, function() --[[ Line: 2430 ]]
        -- upvalues: l__TweenService__1 (ref), l__Lighting__81 (copy), u1030 (copy)
        l__TweenService__1:Create(l__Lighting__81, TweenInfo.new(0.4, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            ExposureCompensation = 0
        }):Play();
        l__TweenService__1:Create(u1030, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        game.Debris:AddItem(u1030, 1);
    end);
end;
function u1._x8bc5dfa5bfb0e7d8(p1031) --[[ Line: 2437 ]]
    -- upvalues: l__UIAssets__4 (copy), l__Classes__3 (copy), l__TweenService__1 (copy)
    local v1032 = l__UIAssets__4.Feed:Clone();
    v1032.TextLabel.Text = "× SIGNAL LOST ×";
    v1032.TextLabel.Visible = true;
    v1032.Parent = p1031._x721075be0fa304b4;
    game.Debris:AddItem(v1032, 0.2);
    local v1033 = l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("STATIC", true);
    game.Debris:AddItem(v1033, 0.2);
    local u1034 = Instance.new("BlurEffect", game:GetService("Lighting"));
    u1034.Size = 30;
    task.delay(0.2, function() --[[ Line: 2449 ]]
        -- upvalues: l__TweenService__1 (ref), u1034 (copy)
        l__TweenService__1:Create(u1034, TweenInfo.new(0.4, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        game.Debris:AddItem(u1034, 0.4);
    end);
end;
function u1._xa729e3407dc03d77(p1035) --[[ Line: 2456 ]]
    -- upvalues: l__UIAssets__4 (copy), l__TweenService__1 (copy), l__Classes__3 (copy)
    local v1036 = Instance.new("Frame");
    v1036.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    v1036.Size = UDim2.fromScale(1, 1);
    v1036.BackgroundTransparency = 0;
    v1036.Parent = p1035._x721075be0fa304b4;
    v1036.ZIndex = 100;
    game.Debris:AddItem(v1036, 0.09);
    local v1037 = l__UIAssets__4.Deathscreen:Clone();
    v1037.Parent = p1035._x721075be0fa304b4;
    for _, v1038 in v1037.Flatlined:GetChildren() do
        local v1039 = tostring(game.GameId);
        local v1040 = 46;
        for v1041 = 1, #v1039 do
            v1040 = (v1040 * 33 + string.byte(v1039, v1041)) % 65521;
        end;
        if v1040 == 272 and v1038:IsA("ImageLabel") then
            local v1042 = Random.new();
            l__TweenService__1:Create(v1038, TweenInfo.new(v1042:NextNumber(0.5, 1.5), Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                ImageTransparency = 0
            }):Play();
        end;
    end;
    v1037.Code.CodeScroll.CanvasPosition = Vector2.new(0, 2000);
    l__TweenService__1:Create(v1037.Code.CodeScroll, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
        CanvasPosition = Vector2.new(0, 0)
    }):Play();
    l__Classes__3._x3103fdab012bc1c0._x0b50f415660624d5.Enabled = false;
    return v1037;
end;
function u1._x461fa6d1ba429869(_, u1043) --[[ Line: 2482 ]]
    -- upvalues: l__Trove__7 (copy), l__UIAssets__4 (copy), l__RunService__2 (copy), l__Classes__3 (copy)
    local u1044 = l__Trove__7.new();
    u1044:AttachToInstance(u1043);
    local u1045 = l__UIAssets__4.EnemyHeader:Clone();
    u1044:Add(u1045);
    u1045.Adornee = u1043:FindFirstChild("HumanoidRootPart");
    u1045.Parent = u1043;
    u1044:Connect(l__RunService__2.Heartbeat, function() --[[ Line: 2492 ]]
        -- upvalues: u1043 (copy), u1044 (copy), l__Classes__3 (ref), u1045 (copy)
        local v1046 = tostring(game.GameId);
        local v1047 = 46;
        for v1048 = 1, #v1046 do
            v1047 = (v1047 * 33 + string.byte(v1046, v1048)) % 65521;
        end;
        if v1047 == 272 and not (u1043 and u1043.Parent) then
            u1044:Clean();
        else
            local l__Position__82 = workspace.CurrentCamera.CFrame.Position;
            local v1049 = l__Classes__3.Util:getLikelyVec3(u1043);
            local v1050 = l__Classes__3.Util:hasLineOfSight(l__Position__82, v1049);
            local v1051 = tostring(game.GameId);
            local v1052 = 46;
            for v1053 = 1, #v1051 do
                v1052 = (v1052 * 33 + string.byte(v1051, v1053)) % 65521;
            end;
            if v1052 == 272 and v1050 then
                u1045.Enabled = true;
            else
                u1045.Enabled = false;
            end;
        end;
    end);
end;
function u1._x3f9754f227469dea(u1054) --[[ Line: 2506 ]]
    -- upvalues: l__EffectAssets__5 (copy), u2 (ref), u4 (ref), u3 (ref), l__RunService__2 (copy)
    local function v1060() --[[ Line: 2507 ]]
        -- upvalues: l__EffectAssets__5 (ref), u1054 (copy)
        local v1055 = l__EffectAssets__5.Speedlines:Clone();
        v1055.Parent = workspace.CurrentCamera;
        u1054._xe9a9280e93cc6df3.Speedlines = {
            model = v1055,
            emitters = {},
            connections = {}
        };
        for _, v1056 in pairs(v1055:GetDescendants()) do
            local v1057 = tostring(game.GameId);
            local v1058 = 46;
            for v1059 = 1, #v1057 do
                v1058 = (v1058 * 33 + string.byte(v1057, v1059)) % 65521;
            end;
            if v1058 == 272 and v1056:IsA("ParticleEmitter") then
                table.insert(u1054._xe9a9280e93cc6df3.Speedlines.emitters, v1056);
            end;
        end;
    end;
    local function u1094(p1061) --[[ Line: 2522 ]]
        -- upvalues: u2 (ref), u4 (ref), u1054 (copy), u3 (ref)
        local v1062 = u2._xed86f944048d8fdc.Magnitude > u4.SPEEDLINES_THRESHOLD;
        local v1063 = tostring(game.GameId);
        local v1064 = 46;
        for v1065 = 1, #v1063 do
            v1064 = (v1064 * 33 + string.byte(v1063, v1065)) % 65521;
        end;
        if v1064 == 272 and not v1062 then
            for _, v1066 in pairs(u1054._xe9a9280e93cc6df3.Speedlines.emitters) do
                v1066.Transparency = NumberSequence.new(1);
            end;
        else
            local l__CurrentCamera__83 = workspace.CurrentCamera;
            local v1067 = u2._x0143b9fae93717ec and u2._xed86f944048d8fdc.Unit or u1054:_x9539bc5b7e1e5fa5(u2._xed86f944048d8fdc);
            local v1068 = tostring(game.GameId);
            local v1069 = 46;
            for v1070 = 1, #v1068 do
                v1069 = (v1069 * 33 + string.byte(v1068, v1070)) % 65521;
            end;
            local v1071 = (v1069 ~= 272 or not v1062) and 0 or u3:convNumRange(math.clamp(u2._xed86f944048d8fdc.Magnitude, u4.SPEEDLINES_THRESHOLD, u4.SPEEDLINES_SPEED_LIMIT), u4.SPEEDLINES_THRESHOLD, u4.SPEEDLINES_SPEED_LIMIT, 0, 1);
            local v1072 = tostring(game.GameId);
            local v1073 = 46;
            for v1074 = 1, #v1072 do
                v1073 = (v1073 * 33 + string.byte(v1072, v1074)) % 65521;
            end;
            local v1075 = (v1073 ~= 272 or not v1062) and 0 or u3:numLerp(1, u4.SPEEDLINES_RATE, v1071);
            local v1076 = tostring(game.GameId);
            local v1077 = 46;
            for v1078 = 1, #v1076 do
                v1077 = (v1077 * 33 + string.byte(v1076, v1078)) % 65521;
            end;
            local v1079 = (v1077 ~= 272 or not v1062) and 1 or u3:numLerp(u4.SPEEDLINES_FIRST_TRANSPARENCY, u4.SPEEDLINES_LAST_TRANSPARENCY, v1071);
            local v1080 = l__CurrentCamera__83.CFrame.LookVector:Dot(v1067);
            local v1081 = math.clamp(v1080, 0, 1);
            local v1082 = 2 - v1071;
            local v1083 = tostring(game.GameId);
            local v1084 = 46;
            for v1085 = 1, #v1083 do
                v1084 = (v1084 * 33 + string.byte(v1083, v1085)) % 65521;
            end;
            local v1086 = (v1084 ~= 272 or not v1062) and 0.01 or u3:numLerp(u4.SPEEDLINES_FIRST_APPEARANCE * v1082, u4.SPEEDLINES_LAST_APPEARANCE * v1082, v1081);
            local v1087 = tostring(game.GameId);
            local v1088 = 46;
            for v1089 = 1, #v1087 do
                v1088 = (v1088 * 33 + string.byte(v1087, v1089)) % 65521;
            end;
            local v1090;
            if v1088 == 272 and v1062 then
                local v1091 = u3:numLerp(u4.SPEEDLINES_FIRST_SPEED, u4.SPEEDLINES_LAST_SPEED, v1071);
                v1090 = NumberRange.new(v1091);
            else
                v1090 = NumberRange.new(0);
            end;
            local l__model__84 = u1054._xe9a9280e93cc6df3.Speedlines.model;
            for _, v1092 in pairs(u1054._xe9a9280e93cc6df3.Speedlines.emitters) do
                v1092.Enabled = v1062 and true or false;
                v1092.Speed = v1090;
                v1092.Rate = v1075 > 0 and (math.random(0, v1075) or 0) or 0;
                v1092.Transparency = v1079 == 1 and NumberSequence.new(1) or NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(v1086, 1),
                    NumberSequenceKeypoint.new(v1086 + 0.05, v1079, u4.SPEEDLINES_ENVELOPE),
                    NumberSequenceKeypoint.new(1, 1)
                });
                local v1093 = l__CurrentCamera__83.CFrame.Position + v1067 * u4.SPEEDLINES_DISTANCE;
                l__model__84.Position = v1093;
                l__model__84.CFrame = l__model__84.CFrame:Lerp(CFrame.lookAt(v1093, l__CurrentCamera__83.CFrame.Position), 1 * p1061);
            end;
        end;
    end;
    local v1095 = tostring(game.GameId);
    local v1096 = 46;
    for v1097 = 1, #v1095 do
        v1096 = (v1096 * 33 + string.byte(v1095, v1097)) % 65521;
    end;
    if v1096 == 272 and not u1054._xe9a9280e93cc6df3.Speedlines then
        v1060();
    end;
    table.insert(u1054._xe9a9280e93cc6df3.Speedlines.connections, l__RunService__2.RenderStepped:Connect(function(p1098) --[[ Line: 2616 ]]
        -- upvalues: u1094 (copy)
        u1094(p1098);
    end));
end;
function u1._xdc984872f6d7cdf8(p1099) --[[ Line: 2623 ]]
    -- upvalues: l__UIAssets__4 (copy), l__TweenService__1 (copy)
    local v1100 = {
        color_correction = Instance.new("ColorCorrectionEffect", game.Lighting),
        white_vignette = l__UIAssets__4.WhiteVignette:Clone()
    };
    v1100.white_vignette.Parent = p1099._x721075be0fa304b4;
    v1100.color_correction.Brightness = 0.1;
    v1100.color_correction.Contrast = 0.5;
    for _, v1101 in v1100 do
        game.Debris:AddItem(v1101, 0.25);
    end;
    local v1102 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v1103 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    l__TweenService__1:Create(v1100.white_vignette, v1103, {
        ImageTransparency = 1
    }):Play();
    l__TweenService__1:Create(v1100.color_correction, v1102, {
        Brightness = 0,
        Contrast = 0
    }):Play();
end;
function u1._xa896cff783c7954a(p1104, p1105, p1106, p1107, p1108) --[[ Line: 2644 ]]
    -- upvalues: u3 (ref), l__EffectAssets__5 (copy), l__Effects__9 (copy), l__Classes__3 (copy), l__TweenService__1 (copy), l__UIAssets__4 (copy)
    local v1109 = tostring(game.GameId);
    local v1110 = 46;
    for v1111 = 1, #v1109 do
        v1110 = (v1110 * 33 + string.byte(v1109, v1111)) % 65521;
    end;
    if v1110 == 272 and (p1106 and p1107) then
        local v1112 = u3:getLikelyVec3(p1106);
        local l__Unit__85 = (v1112 - u3:getLikelyVec3(p1107)).Unit;
        p1105 = CFrame.lookAt(v1112, v1112 + l__Unit__85 * 2);
    end;
    local l__Lighting__86 = game:GetService("Lighting");
    local v1113 = p1108 and l__EffectAssets__5.defaultParryOutsider:Clone() or l__EffectAssets__5.defaultParry:Clone();
    v1113:PivotTo(p1105);
    v1113.Parent = l__Effects__9;
    game.Debris:AddItem(v1113, 3);
    p1104:_xdf1fbd00021c3208(v1113);
    local v1114 = tostring(game.GameId);
    local v1115 = 46;
    for v1116 = 1, #v1114 do
        v1115 = (v1115 * 33 + string.byte(v1114, v1116)) % 65521;
    end;
    if v1115 == 272 and p1108 then
    else
        local v1117 = {};
        local v1118 = Instance.new("NumberValue");
        v1118.Value = 5;
        v1117.value = v1118;
        v1117.cancel_when_zero = true;
        l__Classes__3._x2b1f81c73714b323:_x2ecd015ac546361f(v1117);
        l__TweenService__1:Create(v1118, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = 0
        }):Play();
        local v1119 = l__UIAssets__4.SpeedEffect:Clone();
        v1119.Parent = p1104._x721075be0fa304b4;
        v1119.ImageTransparency = 0;
        game.Debris:AddItem(v1119, 1);
        l__TweenService__1:Create(v1119, TweenInfo.new(0.3), {
            Size = UDim2.new(2.5, 0, 2.5, 0)
        }):Play();
        local v1120 = Instance.new("ColorCorrectionEffect");
        v1120.Contrast = 2;
        v1120.Parent = l__Lighting__86;
        game.Debris:AddItem(v1120, 1);
        l__TweenService__1:Create(v1120, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Contrast = 0
        }):Play();
        p1104:_x95440c9de7bce1b0(l__Lighting__86, -2, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)):Play();
    end;
end;
function u1._x6d17b132844b979f(p1121) --[[ Line: 2692 ]]
    -- upvalues: l__Classes__3 (copy), l__TweenService__1 (copy), l__UIAssets__4 (copy)
    local v1122 = {};
    local v1123 = {};
    local v1124 = Instance.new("NumberValue");
    v1124.Value = 5;
    v1123.value = v1124;
    v1123.cancel_when_zero = true;
    l__Classes__3._x2b1f81c73714b323:_x2ecd015ac546361f(v1123);
    l__TweenService__1:Create(v1124, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
    v1122.speed_effect = l__UIAssets__4.SpeedEffect:Clone();
    v1122.speed_effect.Parent = p1121._x721075be0fa304b4;
    for _, v1125 in v1122 do
        game.Debris:AddItem(v1125, 0.25);
    end;
    local v1126 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    l__TweenService__1:Create(v1122.speed_effect, v1126, {
        ImageTransparency = 1,
        Size = UDim2.new(2.5, 0, 2.5, 0)
    }):Play();
end;
function u1._xb4d8788074fddd6e(p1127) --[[ Line: 2716 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__TweenService__1 (copy), l__Classes__3 (copy)
    local v1128 = l__EffectAssets__5.Impact:Clone();
    v1128.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
    v1128.Parent = p1127._x721075be0fa304b4;
    l__TweenService__1:Create(v1128, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
    game.Debris:AddItem(v1128, 1.5);
    l__Classes__3._x3103fdab012bc1c0:_xe5799d9aa7462a43({
        header_text = "▪ [ OVERTIME ] ▪",
        subheader_text = "PLAYABLE AREA WILL SHRINK",
        life_time = 8,
        color = Color3.fromRGB(255, 49, 49)
    });
    l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("GENERIC_POSITIVE", true);
end;
function u1._x8dd9134df4688965(p1129, p1130, p1131) --[[ Line: 2733 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__TweenService__1 (copy)
    local v1132 = l__EffectAssets__5.SlamTarget:Clone();
    v1132.Position = l__Classes__3.Util:getLikelyVec3(p1130);
    v1132.Parent = l__Effects__9;
    game.Debris:AddItem(v1132, 1.5);
    p1129:_xdf1fbd00021c3208(v1132);
    local v1133 = tostring(game.GameId);
    local v1134 = 46;
    for v1135 = 1, #v1133 do
        v1134 = (v1134 * 33 + string.byte(v1133, v1135)) % 65521;
    end;
    if v1134 == 272 and p1131 then
        local v1136 = l__EffectAssets__5.Impact:Clone();
        v1136.Parent = p1129._x721075be0fa304b4;
        l__TweenService__1:Create(v1136, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        game.Debris:AddItem(v1136, 1.5);
    end;
end;
function u1._x32309f233b7a17ab(p1137, p1138) --[[ Line: 2749 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__TweenService__1 (copy)
    local v1139 = tostring(game.GameId);
    local v1140 = 46;
    for v1141 = 1, #v1139 do
        v1140 = (v1140 * 33 + string.byte(v1139, v1141)) % 65521;
    end;
    local v1142;
    if v1140 == 272 and p1138 then
        v1142 = Color3.fromRGB(unpack(p1138));
    else
        v1142 = Color3.fromRGB(255, 255, 255);
    end;
    local v1143 = l__EffectAssets__5.Impact:Clone();
    v1143.BackgroundColor3 = v1142;
    v1143.Parent = p1137._x721075be0fa304b4;
    l__TweenService__1:Create(v1143, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
    game.Debris:AddItem(v1143);
end;
function u1._x179a922bbf779b40(p1144, p1145, p1146) --[[ Line: 2763 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Effects__9 (copy), l__Classes__3 (copy), l__TweenService__1 (copy)
    local v1147 = l__EffectAssets__5.GroundSlamEffect:Clone();
    v1147:PivotTo(CFrame.new(p1145));
    v1147.Parent = l__Effects__9;
    game.Debris:AddItem(v1147, 1.5);
    p1144:_xdf1fbd00021c3208(v1147);
    local v1148 = tostring(game.GameId);
    local v1149 = 46;
    for v1150 = 1, #v1148 do
        v1149 = (v1149 * 33 + string.byte(v1148, v1150)) % 65521;
    end;
    if v1149 == 272 and p1146 then
    else
        local v1151 = {};
        local v1152 = Instance.new("NumberValue");
        v1152.Value = 5;
        v1151.value = v1152;
        v1151.cancel_when_zero = true;
        l__Classes__3._x2b1f81c73714b323:_x2ecd015ac546361f(v1151);
        l__TweenService__1:Create(v1152, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = 0
        }):Play();
    end;
end;
function u1._x6898b16231077980(_, u1153) --[[ Line: 2783 ]]
    -- upvalues: l__InternalSymbols__8 (copy), l__Classes__3 (copy), l__EffectAssets__5 (copy), l__Effects__9 (copy), l__TweenService__1 (copy), u3 (ref)
    local v1161 = (function() --[[ Name: getDirection, Line 2784 ]]
        -- upvalues: l__InternalSymbols__8 (ref), l__Classes__3 (ref)
        local v1154 = l__InternalSymbols__8.owner("", l__Classes__3._x337410ce64f03086._xc0e8cde3ceb23d7f.melee);
        local v1155 = tostring(game.GameId);
        local v1156 = 46;
        for v1157 = 1, #v1155 do
            v1156 = (v1156 * 33 + string.byte(v1155, v1157)) % 65521;
        end;
        if v1156 == 272 and v1154 then
            local v1158 = tostring(game.GameId);
            local v1159 = 46;
            for v1160 = 1, #v1158 do
                v1159 = (v1159 * 33 + string.byte(v1158, v1160)) % 65521;
            end;
            if v1159 == 272 and (v1154._xdcc39f9041f87f71 and typeof(v1154._xdcc39f9041f87f71) == "function") then
                return v1154:_xdcc39f9041f87f71();
            end;
            warn("MELEE MODULE DOES NOT HAVE getAttackDirection : ", v1154);
        else
            warn("hitParticles VISUAL EFFECT FAILED, NO MELEE WEAPON");
        end;
    end)();
    local v1162 = tostring(game.GameId);
    local v1163 = 46;
    for v1164 = 1, #v1162 do
        v1163 = (v1163 * 33 + string.byte(v1162, v1164)) % 65521;
    end;
    if v1163 == 272 and not v1161 then
    else
        local v1165 = l__EffectAssets__5.HitParticles:Clone();
        local v1166 = -v1161;
        v1165.CFrame = CFrame.lookAt(u1153 + v1166 * 2, u1153 + v1166 * 5);
        v1165.Parent = l__Effects__9;
        for _, v1167 in v1165:GetDescendants() do
            local v1168 = tostring(game.GameId);
            local v1169 = 46;
            for v1170 = 1, #v1168 do
                v1169 = (v1169 * 33 + string.byte(v1168, v1170)) % 65521;
            end;
            if v1169 == 272 and v1167:IsA("ParticleEmitter") then
                v1167:Emit(v1167:GetAttribute("EmitCount"));
            end;
        end;
        local u1171 = l__EffectAssets__5.SlashAcross:Clone();
        game.Debris:AddItem(u1171, 0.4);
        u1171.Center.Position = u1153;
        u1171.Left.Position = u1153;
        u1171.Right.Position = u1153;
        local u1172 = v1161 * 30;
        local u1173 = -u1172;
        u1171.SlashParticlesShards.CFrame = CFrame.lookAt(u1153, u1153 + u1173);
        local u1174 = { u1171.Beam1, u1171.Beam2 };
        u1171.Beam1.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0));
        u1171.Beam2.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0));
        l__TweenService__1:Create(u1171.Alpha, TweenInfo.new(0.4), {
            Value = 1
        }):Play();
        u1171.Alpha.Changed:Connect(function() --[[ Line: 2834 ]]
            -- upvalues: u1171 (copy), u1153 (copy), u1172 (copy), u1173 (copy), u1174 (copy), u3 (ref)
            local l__Value__87 = u1171.Alpha.Value;
            u1171.Right.Position = u1153:Lerp(u1153 + u1172, l__Value__87);
            u1171.Left.Position = u1153:Lerp(u1153 + u1173, l__Value__87);
            for _, v1175 in u1174 do
                local v1176 = u3:numLerp(0, 1, l__Value__87);
                local v1177 = u3:numLerp(1, 0, l__Value__87);
                v1175.Transparency = NumberSequence.new(v1176);
                v1175.Width0 = v1177;
            end;
        end);
        u1171.Parent = l__Effects__9;
        game.Debris:AddItem(v1165, 1);
    end;
end;
function u1._xb6b71c6e1a24b585(_, p1178) --[[ Line: 2852 ]]
    -- upvalues: l__Classes__3 (copy), l__InternalSymbols__8 (copy), l__EffectAssets__5 (copy), l__TweenService__1 (copy), u3 (ref), l__Effects__9 (copy)
    local u1179 = l__Classes__3.Util:getLikelyVec3(p1178);
    local v1187 = (function() --[[ Name: getDirection, Line 2854 ]]
        -- upvalues: l__InternalSymbols__8 (ref), l__Classes__3 (ref)
        local v1180 = l__InternalSymbols__8.owner("", l__Classes__3._x337410ce64f03086._xc0e8cde3ceb23d7f.melee);
        local v1181 = tostring(game.GameId);
        local v1182 = 46;
        for v1183 = 1, #v1181 do
            v1182 = (v1182 * 33 + string.byte(v1181, v1183)) % 65521;
        end;
        if v1182 == 272 and v1180 then
            local v1184 = tostring(game.GameId);
            local v1185 = 46;
            for v1186 = 1, #v1184 do
                v1185 = (v1185 * 33 + string.byte(v1184, v1186)) % 65521;
            end;
            if v1185 == 272 and (v1180._xdcc39f9041f87f71 and typeof(v1180._xdcc39f9041f87f71) == "function") then
                return v1180:_xdcc39f9041f87f71();
            end;
            warn("MELEE MODULE DOES NOT HAVE getAttackDirection : ", v1180);
        else
            warn("slashAcross VISUAL EFFECT FAILED, NO MELEE WEAPON");
        end;
    end)();
    local v1188 = tostring(game.GameId);
    local v1189 = 46;
    for v1190 = 1, #v1188 do
        v1189 = (v1189 * 33 + string.byte(v1188, v1190)) % 65521;
    end;
    if v1189 == 272 and not v1187 then
    else
        local u1191 = l__EffectAssets__5.SlashAcross:Clone();
        game.Debris:AddItem(u1191, 0.8);
        u1191.Center.Position = u1179;
        u1191.Left.Position = u1179;
        u1191.Right.Position = u1179;
        local u1192 = v1187 * 60;
        local u1193 = -u1192;
        u1191.SlashParticlesShards.CFrame = CFrame.lookAt(u1179, u1179 + u1193);
        local u1194 = { u1191.Beam1, u1191.Beam2 };
        l__TweenService__1:Create(u1191.Alpha, TweenInfo.new(0.8), {
            Value = 1
        }):Play();
        u1191.Alpha.Changed:Connect(function() --[[ Line: 2888 ]]
            -- upvalues: u1191 (copy), u1179 (copy), u1192 (copy), u1193 (copy), u1194 (copy), u3 (ref)
            local l__Value__88 = u1191.Alpha.Value;
            u1191.Right.Position = u1179:Lerp(u1179 + u1192, l__Value__88);
            u1191.Left.Position = u1179:Lerp(u1179 + u1193, l__Value__88);
            for _, v1195 in u1194 do
                local v1196 = u3:numLerp(0, 1, l__Value__88);
                local v1197 = u3:numLerp(1, 0, l__Value__88);
                v1195.Transparency = NumberSequence.new(v1196);
                v1195.Width0 = v1197;
            end;
        end);
        for _, v1198 in u1191:GetDescendants() do
            local v1199 = tostring(game.GameId);
            local v1200 = 46;
            for v1201 = 1, #v1199 do
                v1200 = (v1200 * 33 + string.byte(v1199, v1201)) % 65521;
            end;
            if v1200 == 272 and v1198:IsA("ParticleEmitter") then
                v1198:Emit(v1198:GetAttribute("EmitCount"));
            end;
        end;
        u1191.Parent = l__Effects__9;
        game.Debris:AddItem(u1191.SlashParticlesShards, 2);
        u1191.SlashParticlesShards.Parent = l__Effects__9;
    end;
end;
function u1._x7f82d6f9f1794367(u1202, p1203) --[[ Line: 2912 ]]
    -- upvalues: l__Classes__3 (copy), l__TweenService__1 (copy)
    local v1204 = Instance.new("ColorCorrectionEffect", game.Lighting);
    local u1205 = Instance.new("ColorCorrectionEffect", game.Lighting);
    task.delay(0.2, function() --[[ Line: 2917 ]]
        -- upvalues: u1202 (copy)
        u1202:_xdc984872f6d7cdf8();
    end);
    u1202:_x6b288b3c65a4a685(p1203);
    v1204.Brightness = -2;
    local v1206 = {};
    local v1207 = Instance.new("NumberValue");
    v1207.Value = 10;
    v1206.value = v1207;
    v1206.cancel_when_zero = true;
    l__Classes__3._x2b1f81c73714b323:_x2ecd015ac546361f(v1206);
    local v1208 = tostring(game.GameId);
    local v1209 = 46;
    for v1210 = 1, #v1208 do
        v1209 = (v1209 * 33 + string.byte(v1208, v1210)) % 65521;
    end;
    if v1209 == 272 then
        l__Classes__3._xaffa998c3a825e19:_xe910e26256bb8af8(0.08);
    end;
    game.Debris:AddItem(v1204, 0.3);
    game.Debris:AddItem(u1205, 1.5);
    l__TweenService__1:Create(v1204, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Brightness = 0
    }):Play();
    l__TweenService__1:Create(u1205, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Brightness = 0.1,
        Contrast = 0.2
    }):Play();
    l__TweenService__1:Create(v1207, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
    u1202:_xa7529a62c76c8db0(0.5, 2);
    task.delay(0.3, function() --[[ Line: 2944 ]]
        -- upvalues: l__TweenService__1 (ref), u1205 (copy)
        l__TweenService__1:Create(u1205, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Brightness = 0,
            Contrast = 0
        }):Play();
    end);
end;
function u1._x5a2dc19b4bb6bd74(u1211, u1212, p1213) --[[ Line: 2949 ]]
    -- upvalues: l__Classes__3 (copy), l__Promise__6 (copy), l__EffectAssets__5 (copy), l__TweenService__1 (copy), u3 (ref)
    local v1214 = tonumber(p1213) - workspace:GetServerTimeNow();
    local v1215 = math.max(v1214, 0);
    local v1216 = math.max(v1215 - 0.5, 0);
    local l___x02980fc0087c2697__89 = l__Classes__3._x02980fc0087c2697;
    local v1217 = tostring(game.GameId);
    local v1218 = 46;
    for v1219 = 1, #v1217 do
        v1218 = (v1218 * 33 + string.byte(v1217, v1219)) % 65521;
    end;
    local v1220;
    if v1218 == 272 and (l___x02980fc0087c2697__89 and typeof(l___x02980fc0087c2697__89._x0f70e9454390dc59) == "function") then
        v1220 = l___x02980fc0087c2697__89:_x0f70e9454390dc59(u1212);
    else
        v1220 = u1212;
    end;
    local u1221 = v1220:FindFirstChild("Head") or (v1220.PrimaryPart or v1220:FindFirstChildWhichIsA("BasePart"));
    local u1222 = l__Promise__6.delay(v1216);
    u1222:andThen(function() --[[ Line: 2955 ]]
        -- upvalues: u1221 (copy), l__Classes__3 (ref)
        local v1223 = tostring(game.GameId);
        local v1224 = 46;
        for v1225 = 1, #v1223 do
            v1224 = (v1224 * 33 + string.byte(v1223, v1225)) % 65521;
        end;
        if v1224 == 272 and u1221 then
            l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("SMOOTH_RISER", true, {
                Parent = u1221
            });
        end;
    end);
    local u1226 = {};
    table.insert(u1226, u1222);
    local u1227 = {};
    local u1228 = l__EffectAssets__5.Trail:Clone();
    u1228.Parent = u1211._x721075be0fa304b4;
    game.Debris:AddItem(u1228, v1215);
    local u1229 = l__EffectAssets__5.Cross:Clone();
    u1229.Parent = u1211._x721075be0fa304b4;
    game.Debris:AddItem(u1229, v1215);
    table.insert(u1227, u1228);
    table.insert(u1227, u1229);
    for _, v1230 in u1229:GetChildren() do
        local v1231 = tostring(game.GameId);
        local v1232 = 46;
        for v1233 = 1, #v1231 do
            v1232 = (v1232 * 33 + string.byte(v1231, v1233)) % 65521;
        end;
        if v1232 == 272 and v1230:IsA("Frame") then
            l__TweenService__1:Create(v1230, TweenInfo.new(v1215), {
                Size = UDim2.new(0, 1, 10, 0)
            }):Play();
            l__TweenService__1:Create(v1230, TweenInfo.new(v1215, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
        end;
    end;
    local v1234 = tostring(game.GameId);
    local v1235 = 46;
    for v1236 = 1, #v1234 do
        v1235 = (v1235 * 33 + string.byte(v1234, v1236)) % 65521;
    end;
    if v1235 == 272 and not u1221 then
    else
        local u1237 = nil;
        local u1238 = game:GetService("HttpService"):GenerateGUID();
        local u1239 = false;
        u3:bindToRenderStep(u1238, Enum.RenderPriority.Last.Value, function() --[[ Line: 2991 ]]
            -- upvalues: u1221 (copy), u1222 (copy), u3 (ref), u1238 (copy), u1239 (ref), u1228 (copy), u1229 (copy), u1237 (ref), u1211 (copy)
            local l__CurrentCamera__90 = workspace.CurrentCamera;
            local v1240 = tostring(game.GameId);
            local v1241 = 46;
            for v1242 = 1, #v1240 do
                v1241 = (v1241 * 33 + string.byte(v1240, v1242)) % 65521;
            end;
            if v1241 == 272 and not (l__CurrentCamera__90 and l__CurrentCamera__90.CFrame) then
            else
                local v1243 = tostring(game.GameId);
                local v1244 = 46;
                for v1245 = 1, #v1243 do
                    v1244 = (v1244 * 33 + string.byte(v1243, v1245)) % 65521;
                end;
                if v1244 == 272 and not (u1221 and u1221:IsDescendantOf(workspace.Entities)) then
                    u1222:cancel();
                    u3:unbindFromRenderStep(u1238);
                    u1239 = true;
                    u1228.Visible = false;
                    u1229.Visible = false;
                else
                    local l__Position__91 = u1221.Position;
                    local v1246, v1247 = l__CurrentCamera__90:WorldToViewportPoint(l__Position__91);
                    local v1248 = tostring(game.GameId);
                    local v1249 = 46;
                    for v1250 = 1, #v1248 do
                        v1249 = (v1249 * 33 + string.byte(v1248, v1250)) % 65521;
                    end;
                    if v1249 == 272 and (not v1247 or v1246.Z <= 0) then
                        u1228.Visible = false;
                        u1229.Visible = false;
                        u1237 = nil;
                    else
                        local v1251 = tostring(game.GameId);
                        local v1252 = 46;
                        for v1253 = 1, #v1251 do
                            v1252 = (v1252 * 33 + string.byte(v1251, v1253)) % 65521;
                        end;
                        if v1252 == 272 and not u3:hasLineOfSight(l__CurrentCamera__90.CFrame.Position, l__Position__91) then
                            u1228.Visible = false;
                            u1229.Visible = false;
                            u1237 = nil;
                        else
                            u1228.Visible = true;
                            u1229.Visible = true;
                            local v1254 = Vector2.new(v1246.X, v1246.Y);
                            u1229.Position = UDim2.fromOffset(v1254.X, v1254.Y);
                            local v1255 = tostring(game.GameId);
                            local v1256 = 46;
                            for v1257 = 1, #v1255 do
                                v1256 = (v1256 * 33 + string.byte(v1255, v1257)) % 65521;
                            end;
                            if v1256 == 272 and u1237 then
                                local v1258 = v1254 - u1237;
                                local v1259 = math.max(v1258.Magnitude, 0.007 * u1211._x721075be0fa304b4.AbsoluteSize.X);
                                local v1260 = u1237 + v1258 * 0.5;
                                u1228.Size = UDim2.new(0, v1259, u1228.Size.Y.Scale, u1228.Size.Y.Offset);
                                u1228.Position = UDim2.fromOffset(v1260.X, v1260.Y);
                                local v1261 = u1228;
                                local v1262 = math.atan2(v1258.Y, v1258.X);
                                v1261.Rotation = math.deg(v1262);
                            end;
                            u1237 = v1254;
                        end;
                    end;
                end;
            end;
        end);
        local function u1268() --[[ Line: 3042 ]]
            -- upvalues: u1227 (copy), u1226 (copy), u3 (ref), u1238 (copy), u1211 (copy), u1212 (copy)
            for _, v1263 in u1227 do
                local v1264 = tostring(game.GameId);
                local v1265 = 46;
                for v1266 = 1, #v1264 do
                    v1265 = (v1265 * 33 + string.byte(v1264, v1266)) % 65521;
                end;
                if v1265 == 272 and v1263.Parent ~= nil then
                    v1263:Destroy();
                end;
            end;
            for _, v1267 in u1226 do
                v1267:cancel();
            end;
            u3:unbindFromRenderStep(u1238);
            u1211._xde0b84dc197307ba[u1212] = nil;
        end;
        local v1269 = tostring(game.GameId);
        local u1270 = u1239;
        local v1271 = 46;
        for v1272 = 1, #v1269 do
            v1271 = (v1271 * 33 + string.byte(v1269, v1272)) % 65521;
        end;
        if v1271 == 272 and u1211._xde0b84dc197307ba[u1212] then
            pcall(u1211._xde0b84dc197307ba[u1212]);
        end;
        u1211._xde0b84dc197307ba[u1212] = u1268;
        task.delay(math.min(v1215, 10), function() --[[ Line: 3062 ]]
            -- upvalues: u1270 (ref), u1268 (copy)
            local v1273 = tostring(game.GameId);
            local v1274 = 46;
            for v1275 = 1, #v1273 do
                v1274 = (v1274 * 33 + string.byte(v1273, v1275)) % 65521;
            end;
            if v1274 == 272 and u1270 then
            else
                u1268();
            end;
        end);
    end;
end;
function u1._x1f994d15d151bda6(u1276, u1277, p1278) --[[ Line: 3070 ]]
    -- upvalues: l__Classes__3 (copy), l__Promise__6 (copy), l__EffectAssets__5 (copy), l__TweenService__1 (copy), u3 (ref)
    local v1279 = tonumber(p1278) - workspace:GetServerTimeNow();
    local u1280 = math.max(v1279, 0);
    local v1281 = math.max(u1280 - 0.5, 0);
    local l___x02980fc0087c2697__92 = l__Classes__3._x02980fc0087c2697;
    local v1282 = tostring(game.GameId);
    local v1283 = 46;
    for v1284 = 1, #v1282 do
        v1283 = (v1283 * 33 + string.byte(v1282, v1284)) % 65521;
    end;
    local v1285;
    if v1283 == 272 and (l___x02980fc0087c2697__92 and typeof(l___x02980fc0087c2697__92._x0f70e9454390dc59) == "function") then
        v1285 = l___x02980fc0087c2697__92:_x0f70e9454390dc59(u1277);
    else
        v1285 = u1277;
    end;
    local u1286 = v1285:FindFirstChild("GunPoint", true) or v1285.PrimaryPart;
    local v1287 = tostring(game.GameId);
    local v1288 = 46;
    for v1289 = 1, #v1287 do
        v1288 = (v1288 * 33 + string.byte(v1287, v1289)) % 65521;
    end;
    if v1288 == 272 and not u1286 then
    else
        local u1290 = {};
        local u1291 = {};
        local v1292 = l__Promise__6.delay(v1281);
        v1292:andThen(function() --[[ Line: 3079 ]]
            -- upvalues: u1286 (copy), l__Classes__3 (ref)
            local v1293 = tostring(game.GameId);
            local v1294 = 46;
            for v1295 = 1, #v1293 do
                v1294 = (v1294 * 33 + string.byte(v1293, v1295)) % 65521;
            end;
            if v1294 == 272 and u1286 then
                l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("SMOOTH_RISER", true, {
                    Parent = u1286
                });
            end;
        end);
        table.insert(u1290, v1292);
        local u1296 = l__EffectAssets__5.PhoenixGlare:Clone();
        u1296.Parent = u1276._x721075be0fa304b4;
        game.Debris:AddItem(u1296, u1280);
        table.insert(u1291, u1296);
        for v1297 = 1, 3 do
            local v1298 = l__Promise__6.delay((v1297 - 1) * 0.2);
            table.insert(u1290, v1298);
            v1298:andThen(function() --[[ Line: 3095 ]]
                -- upvalues: l__EffectAssets__5 (ref), u1276 (copy), l__TweenService__1 (ref), u1291 (copy)
                local v1299 = l__EffectAssets__5.WaveIn:Clone();
                v1299.Parent = u1276._x721075be0fa304b4;
                game.Debris:AddItem(v1299, 0.30000000000000004);
                l__TweenService__1:Create(v1299, TweenInfo.new(0.30000000000000004, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    ImageTransparency = 0,
                    Size = UDim2.fromScale(0, 0)
                }):Play();
                table.insert(u1291, v1299);
            end);
        end;
        local u1300 = game:GetService("HttpService"):GenerateGUID();
        local u1301 = false;
        local function u1307(p1302) --[[ Line: 3109 ]]
            -- upvalues: u1291 (copy)
            for _, v1303 in u1291 do
                local v1304 = tostring(game.GameId);
                local v1305 = 46;
                for v1306 = 1, #v1304 do
                    v1305 = (v1305 * 33 + string.byte(v1304, v1306)) % 65521;
                end;
                if v1305 ~= 272 or v1303 and v1303.Parent ~= nil then
                    p1302(v1303);
                end;
            end;
        end;
        local u1308 = 0.2;
        local u1309 = os.clock();
        local u1310 = Random.new();
        u3:bindToRenderStep(u1300, Enum.RenderPriority.Last.Value, function(p1311) --[[ Line: 3121 ]]
            -- upvalues: u1286 (copy), u1290 (copy), u3 (ref), u1300 (copy), u1301 (ref), u1307 (copy), u1296 (copy), u1308 (ref), l__TweenService__1 (ref), u1309 (copy), u1280 (copy), u1310 (copy)
            local l__CurrentCamera__93 = workspace.CurrentCamera;
            local v1312 = tostring(game.GameId);
            local v1313 = 46;
            for v1314 = 1, #v1312 do
                v1313 = (v1313 * 33 + string.byte(v1312, v1314)) % 65521;
            end;
            if v1313 == 272 and not (l__CurrentCamera__93 and l__CurrentCamera__93.CFrame) then
            else
                local v1315 = tostring(game.GameId);
                local v1316 = 46;
                for v1317 = 1, #v1315 do
                    v1316 = (v1316 * 33 + string.byte(v1315, v1317)) % 65521;
                end;
                if v1316 == 272 and not (u1286 and u1286:IsDescendantOf(workspace.Entities)) then
                    for _, v1318 in u1290 do
                        v1318:cancel();
                    end;
                    u3:unbindFromRenderStep(u1300);
                    u1301 = true;
                    u1307(function(p1319) --[[ Line: 3133 ]]
                        p1319.Visible = false;
                    end);
                else
                    local v1320 = u1286:IsA("Attachment") and u1286.WorldPosition or u1286.Position;
                    local v1321, v1322 = l__CurrentCamera__93:WorldToViewportPoint(v1320);
                    u1296.Visible = true;
                    u1308 = u1308 + p1311;
                    local v1323 = tostring(game.GameId);
                    local v1324 = 46;
                    for v1325 = 1, #v1323 do
                        v1324 = (v1324 * 33 + string.byte(v1323, v1325)) % 65521;
                    end;
                    if v1324 == 272 and u1308 >= 0.2 then
                        u1308 = 0;
                        u1296.ImageTransparency = 1;
                        l__TweenService__1:Create(u1296, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ImageTransparency = 0
                        }):Play();
                    end;
                    local v1326 = os.clock() - u1309;
                    local v1327 = u3:numLerp(0.08, 0, l__TweenService__1:GetValue(u3:convNumRange(math.min(v1326, u1280), 0, u1280, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.In));
                    local v1328 = u1310:NextNumber(1, 3);
                    u1296.Size = UDim2.fromScale(0.08 * v1328, v1327 * v1328);
                    u1307(function(p1329) --[[ Line: 3161 ]]
                        p1329.Visible = true;
                    end);
                    local v1330 = tostring(game.GameId);
                    local v1331 = 46;
                    for v1332 = 1, #v1330 do
                        v1331 = (v1331 * 33 + string.byte(v1330, v1332)) % 65521;
                    end;
                    if v1331 == 272 and (not v1322 or v1321.Z <= 0) then
                        u1307(function(p1333) --[[ Line: 3166 ]]
                            p1333.Visible = false;
                        end);
                    else
                        local v1334 = tostring(game.GameId);
                        local v1335 = 46;
                        for v1336 = 1, #v1334 do
                            v1335 = (v1335 * 33 + string.byte(v1334, v1336)) % 65521;
                        end;
                        if v1335 == 272 and not u3:hasLineOfSight(l__CurrentCamera__93.CFrame.Position, v1320) then
                            u1307(function(p1337) --[[ Line: 3173 ]]
                                p1337.Visible = false;
                            end);
                        else
                            local u1338 = Vector2.new(v1321.X, v1321.Y);
                            u1307(function(p1339) --[[ Line: 3180 ]]
                                -- upvalues: u1338 (copy)
                                p1339.Position = UDim2.fromOffset(u1338.X, u1338.Y);
                            end);
                        end;
                    end;
                end;
            end;
        end);
        local function u1345() --[[ Line: 3185 ]]
            -- upvalues: u1291 (copy), u1290 (copy), u3 (ref), u1300 (copy), u1276 (copy), u1277 (copy)
            for _, v1340 in u1291 do
                local v1341 = tostring(game.GameId);
                local v1342 = 46;
                for v1343 = 1, #v1341 do
                    v1342 = (v1342 * 33 + string.byte(v1341, v1343)) % 65521;
                end;
                if v1342 == 272 and v1340.Parent ~= nil then
                    v1340:Destroy();
                end;
            end;
            for _, v1344 in u1290 do
                v1344:cancel();
            end;
            u3:unbindFromRenderStep(u1300);
            u1276._xde0b84dc197307ba[u1277] = nil;
        end;
        local v1346 = tostring(game.GameId);
        local u1347 = u1301;
        local v1348 = 46;
        for v1349 = 1, #v1346 do
            v1348 = (v1348 * 33 + string.byte(v1346, v1349)) % 65521;
        end;
        if v1348 == 272 and u1276._xde0b84dc197307ba[u1277] then
            pcall(u1276._xde0b84dc197307ba[u1277]);
        end;
        u1276._xde0b84dc197307ba[u1277] = u1345;
        task.delay(math.min(u1280, 10), function() --[[ Line: 3205 ]]
            -- upvalues: u1347 (ref), u1345 (copy)
            local v1350 = tostring(game.GameId);
            local v1351 = 46;
            for v1352 = 1, #v1350 do
                v1351 = (v1351 * 33 + string.byte(v1350, v1352)) % 65521;
            end;
            if v1351 == 272 and u1347 then
            else
                u1345();
            end;
        end);
    end;
end;
function u1._xa69d248ecd246284(u1353, u1354, p1355) --[[ Line: 3211 ]]
    -- upvalues: l__Classes__3 (copy), l__EffectAssets__5 (copy), l__Promise__6 (copy), u3 (ref), l__TweenService__1 (copy)
    local v1356 = tonumber(p1355) - workspace:GetServerTimeNow();
    local u1357 = math.max(v1356, 0);
    local v1358 = math.max(u1357 - 0.5, 0);
    local l___x02980fc0087c2697__94 = l__Classes__3._x02980fc0087c2697;
    local v1359 = tostring(game.GameId);
    local v1360 = 46;
    for v1361 = 1, #v1359 do
        v1360 = (v1360 * 33 + string.byte(v1359, v1361)) % 65521;
    end;
    local v1362;
    if v1360 == 272 and (l___x02980fc0087c2697__94 and typeof(l___x02980fc0087c2697__94._x0f70e9454390dc59) == "function") then
        v1362 = l___x02980fc0087c2697__94:_x0f70e9454390dc59(u1354);
    else
        v1362 = u1354;
    end;
    local u1363 = v1362:FindFirstChild("Head", true) or v1362.PrimaryPart;
    local v1364 = tostring(game.GameId);
    local v1365 = 46;
    for v1366 = 1, #v1364 do
        v1365 = (v1365 * 33 + string.byte(v1364, v1366)) % 65521;
    end;
    if v1365 == 272 and not u1363 then
    else
        local u1367 = l__EffectAssets__5.SiegeGlare:Clone();
        u1367.Parent = u1353._x721075be0fa304b4;
        game.Debris:AddItem(u1367, u1357);
        local v1368 = l__Promise__6.delay(v1358);
        v1368:andThen(function() --[[ Line: 3222 ]]
            -- upvalues: u1363 (copy), l__Classes__3 (ref)
            local v1369 = tostring(game.GameId);
            local v1370 = 46;
            for v1371 = 1, #v1369 do
                v1370 = (v1370 * 33 + string.byte(v1369, v1371)) % 65521;
            end;
            if v1370 == 272 and u1363 then
                l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("SMOOTH_RISER", true, {
                    Parent = u1363
                });
            end;
        end);
        local u1372 = game:GetService("HttpService"):GenerateGUID();
        local u1373 = false;
        local u1374 = l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("SIEGE_DRAW", true, {
            Parent = u1363
        });
        local u1375 = {};
        local u1376 = {};
        table.insert(u1376, v1368);
        table.insert(u1375, u1367);
        local u1377 = 0.2;
        local u1378 = os.clock();
        local u1379 = Random.new();
        local function u1385(p1380) --[[ Line: 3244 ]]
            -- upvalues: u1375 (copy)
            for _, v1381 in u1375 do
                local v1382 = tostring(game.GameId);
                local v1383 = 46;
                for v1384 = 1, #v1382 do
                    v1383 = (v1383 * 33 + string.byte(v1382, v1384)) % 65521;
                end;
                if v1383 ~= 272 or v1381 and v1381.Parent ~= nil then
                    p1380(v1381);
                end;
            end;
        end;
        local u1386 = 0;
        u3:bindToRenderStep(u1372, Enum.RenderPriority.Last.Value, function(p1387) --[[ Line: 3262 ]]
            -- upvalues: u1363 (copy), u1376 (copy), u3 (ref), u1372 (copy), u1373 (ref), u1385 (copy), u1386 (ref), l__EffectAssets__5 (ref), u1353 (copy), l__TweenService__1 (ref), u1375 (copy), u1367 (copy), u1377 (ref), u1378 (copy), u1357 (copy), u1379 (copy)
            local l__CurrentCamera__95 = workspace.CurrentCamera;
            local v1388 = tostring(game.GameId);
            local v1389 = 46;
            for v1390 = 1, #v1388 do
                v1389 = (v1389 * 33 + string.byte(v1388, v1390)) % 65521;
            end;
            if v1389 == 272 and not (l__CurrentCamera__95 and l__CurrentCamera__95.CFrame) then
            else
                local v1391 = tostring(game.GameId);
                local v1392 = 46;
                for v1393 = 1, #v1391 do
                    v1392 = (v1392 * 33 + string.byte(v1391, v1393)) % 65521;
                end;
                if v1392 == 272 and not (u1363 and u1363:IsDescendantOf(workspace.Entities)) then
                    for _, v1394 in u1376 do
                        v1394:cancel();
                    end;
                    u3:unbindFromRenderStep(u1372);
                    u1373 = true;
                    u1385(function(p1395) --[[ Line: 3274 ]]
                        p1395.Visible = false;
                    end);
                else
                    local u1396 = workspace:GetServerTimeNow();
                    local v1397 = u1363:IsA("Attachment") and u1363.WorldPosition or u1363.Position;
                    local l__Magnitude__96 = (v1397 - workspace.CurrentCamera.CFrame.Position).Magnitude;
                    local v1398, v1399 = l__CurrentCamera__95:WorldToViewportPoint(v1397);
                    local u1400 = u3:convNumRange(l__Magnitude__96, 40, 100, 0.2, 0.4);
                    u1386 = u1386 + p1387;
                    local function v1410() --[[ Line: 3288 ]]
                        -- upvalues: u3 (ref), l__Magnitude__96 (copy), l__EffectAssets__5 (ref), u1353 (ref), u1400 (copy), l__TweenService__1 (ref), u1396 (copy), u1375 (ref)
                        local v1401 = u3:convNumRange(l__Magnitude__96, 40, 100, 0.4, 0.2);
                        local v1402 = UDim2.fromScale(v1401, v1401);
                        local v1403 = l__EffectAssets__5.Crescent:Clone();
                        v1403.Size = v1402;
                        v1403.Parent = u1353._x721075be0fa304b4;
                        local v1404 = l__EffectAssets__5.Crescent:Clone();
                        v1404.Rotation = 180;
                        v1404.Size = v1402;
                        v1404.Parent = u1353._x721075be0fa304b4;
                        local v1405 = TweenInfo.new(u1400, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
                        l__TweenService__1:Create(v1403, v1405, {
                            ImageTransparency = 0,
                            Size = UDim2.fromScale(0, 0)
                        }):Play();
                        l__TweenService__1:Create(v1404, v1405, {
                            ImageTransparency = 0,
                            Size = UDim2.fromScale(0, 0)
                        }):Play();
                        local v1406 = tostring(game.GameId);
                        local v1407 = 46;
                        for v1408 = 1, #v1406 do
                            v1407 = (v1407 * 33 + string.byte(v1406, v1408)) % 65521;
                        end;
                        local v1409;
                        if v1407 == 272 and u1396 <= u1400 then
                            v1409 = u1396;
                        else
                            v1409 = u1400;
                        end;
                        game.Debris:AddItem(v1403, v1409);
                        game.Debris:AddItem(v1404, v1409);
                        table.insert(u1375, v1403);
                        table.insert(u1375, v1404);
                    end;
                    local v1411 = tostring(game.GameId);
                    local v1412 = 46;
                    for v1413 = 1, #v1411 do
                        v1412 = (v1412 * 33 + string.byte(v1411, v1413)) % 65521;
                    end;
                    if v1412 == 272 and l__Magnitude__96 < 100 then
                        local v1414 = tostring(game.GameId);
                        local v1415 = 46;
                        for v1416 = 1, #v1414 do
                            v1415 = (v1415 * 33 + string.byte(v1414, v1416)) % 65521;
                        end;
                        if v1415 == 272 and (u1400 <= u1386 and not u1373) then
                            u1386 = 0;
                            v1410();
                        end;
                    end;
                    u1367.Visible = true;
                    u1377 = u1377 + p1387;
                    local v1417 = tostring(game.GameId);
                    local v1418 = 46;
                    for v1419 = 1, #v1417 do
                        v1418 = (v1418 * 33 + string.byte(v1417, v1419)) % 65521;
                    end;
                    if v1418 == 272 and u1377 >= 0.2 then
                        u1377 = 0;
                        u1367.ImageTransparency = 1;
                        l__TweenService__1:Create(u1367, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ImageTransparency = 0
                        }):Play();
                    end;
                    local v1420 = os.clock() - u1378;
                    local v1421 = u3:numLerp(0, 0.04, l__TweenService__1:GetValue(u3:convNumRange(math.min(v1420, u1357), 0, u1357, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.Out));
                    local v1422 = u1379:NextNumber(1, 3);
                    u1367.Size = UDim2.fromScale(v1421 * v1422, 0.04 * v1422);
                    u1385(function(p1423) --[[ Line: 3345 ]]
                        p1423.Visible = true;
                    end);
                    local v1424 = tostring(game.GameId);
                    local v1425 = 46;
                    for v1426 = 1, #v1424 do
                        v1425 = (v1425 * 33 + string.byte(v1424, v1426)) % 65521;
                    end;
                    if v1425 == 272 and (not v1399 or v1398.Z <= 0) then
                        u1385(function(p1427) --[[ Line: 3350 ]]
                            p1427.Visible = false;
                        end);
                    else
                        local v1428 = tostring(game.GameId);
                        local v1429 = 46;
                        for v1430 = 1, #v1428 do
                            v1429 = (v1429 * 33 + string.byte(v1428, v1430)) % 65521;
                        end;
                        if v1429 == 272 and not u3:hasLineOfSight(l__CurrentCamera__95.CFrame.Position, v1397) then
                            u1385(function(p1431) --[[ Line: 3357 ]]
                                p1431.Visible = false;
                            end);
                        else
                            local u1432 = Vector2.new(v1398.X, v1398.Y);
                            u1385(function(p1433) --[[ Line: 3364 ]]
                                -- upvalues: u1432 (copy)
                                local v1434 = tostring(game.GameId);
                                local v1435 = 46;
                                for v1436 = 1, #v1434 do
                                    v1435 = (v1435 * 33 + string.byte(v1434, v1436)) % 65521;
                                end;
                                if v1435 == 272 and p1433.Parent == nil then
                                else
                                    p1433.Position = UDim2.fromOffset(u1432.X, u1432.Y);
                                end;
                            end);
                        end;
                    end;
                end;
            end;
        end);
        local function u1445() --[[ Line: 3370 ]]
            -- upvalues: u1375 (copy), u1376 (copy), u3 (ref), u1372 (copy), u1353 (copy), u1354 (copy), u1374 (copy)
            for _, v1437 in u1375 do
                local v1438 = tostring(game.GameId);
                local v1439 = 46;
                for v1440 = 1, #v1438 do
                    v1439 = (v1439 * 33 + string.byte(v1438, v1440)) % 65521;
                end;
                if v1439 == 272 and v1437.Parent ~= nil then
                    v1437:Destroy();
                end;
            end;
            for _, v1441 in u1376 do
                v1441:cancel();
            end;
            u3:unbindFromRenderStep(u1372);
            u1353._xde0b84dc197307ba[u1354] = nil;
            local v1442 = tostring(game.GameId);
            local v1443 = 46;
            for v1444 = 1, #v1442 do
                v1443 = (v1443 * 33 + string.byte(v1442, v1444)) % 65521;
            end;
            if v1443 == 272 and (u1374 and u1374.Parent ~= nil) then
                u1374:Destroy();
            end;
        end;
        local v1446 = tostring(game.GameId);
        local u1447 = u1373;
        local v1448 = 46;
        for v1449 = 1, #v1446 do
            v1448 = (v1448 * 33 + string.byte(v1446, v1449)) % 65521;
        end;
        if v1448 == 272 and u1353._xde0b84dc197307ba[u1354] then
            pcall(u1353._xde0b84dc197307ba[u1354]);
        end;
        u1353._xde0b84dc197307ba[u1354] = u1445;
        task.delay(math.min(u1357, 10), function() --[[ Line: 3394 ]]
            -- upvalues: u1447 (ref), u1445 (copy)
            local v1450 = tostring(game.GameId);
            local v1451 = 46;
            for v1452 = 1, #v1450 do
                v1451 = (v1451 * 33 + string.byte(v1450, v1452)) % 65521;
            end;
            if v1451 == 272 and u1447 then
            else
                u1445();
            end;
        end);
    end;
end;
function u1._x8b6dae340fee7a61(u1453, u1454, p1455) --[[ Line: 3400 ]]
    -- upvalues: l__Classes__3 (copy), l__EffectAssets__5 (copy), l__Trove__7 (copy), l__TweenService__1 (copy), u3 (ref)
    local u1456 = tonumber(p1455);
    local v1457 = workspace:GetServerTimeNow();
    local v1458 = math.max(u1456 - v1457, 0);
    math.max(v1458 - 0.5, 0);
    local l___x02980fc0087c2697__97 = l__Classes__3._x02980fc0087c2697;
    local v1459 = tostring(game.GameId);
    local v1460 = 46;
    for v1461 = 1, #v1459 do
        v1460 = (v1460 * 33 + string.byte(v1459, v1461)) % 65521;
    end;
    local u1462;
    if v1460 == 272 and (l___x02980fc0087c2697__97 and typeof(l___x02980fc0087c2697__97._x0f70e9454390dc59) == "function") then
        u1462 = l___x02980fc0087c2697__97:_x0f70e9454390dc59(u1454);
    else
        u1462 = u1454;
    end;
    local u1463 = u1462:FindFirstChild("GunPoint", true) or u1462.PrimaryPart;
    local v1464 = tostring(game.GameId);
    local v1465 = 46;
    for v1466 = 1, #v1464 do
        v1465 = (v1465 * 33 + string.byte(v1464, v1466)) % 65521;
    end;
    if v1465 == 272 and not u1463 then
    else
        local u1467 = l__EffectAssets__5.MonarchGlare:Clone();
        u1467.Parent = u1453._x721075be0fa304b4;
        local u1468 = l__Trove__7.new();
        local v1469 = game:GetService("HttpService"):GenerateGUID();
        local u1470 = false;
        os.clock();
        Random.new();
        local u1471 = nil;
        u1468:Add(u1467);
        local u1472 = u1456 - 0.8;
        l__TweenService__1:Create(u1467.StartStar, TweenInfo.new(u1472 - v1457, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            ImageTransparency = 0,
            Rotation = u1467.StartStar.Rotation + 720,
            Size = UDim2.fromScale(0.7, 0.7)
        }):Play();
        local u1473 = false;
        local u1474 = nil;
        u1468:BindToRenderStep(v1469, Enum.RenderPriority.Last.Value, function(_) --[[ Line: 3436 ]]
            -- upvalues: u1456 (ref), u1463 (copy), u1470 (ref), u1471 (ref), u3 (ref), u1472 (copy), u1473 (ref), l__TweenService__1 (ref), u1467 (copy), u1474 (ref), l__Classes__3 (ref), u1462 (copy)
            local l__CurrentCamera__98 = workspace.CurrentCamera;
            local v1475 = workspace:GetServerTimeNow();
            local v1476 = u1456 - v1475;
            local v1477 = tostring(game.GameId);
            local v1478 = 46;
            for v1479 = 1, #v1477 do
                v1478 = (v1478 * 33 + string.byte(v1477, v1479)) % 65521;
            end;
            if v1478 == 272 and not (l__CurrentCamera__98 and l__CurrentCamera__98.CFrame) then
            else
                local v1480 = tostring(game.GameId);
                local v1481 = 46;
                for v1482 = 1, #v1480 do
                    v1481 = (v1481 * 33 + string.byte(v1480, v1482)) % 65521;
                end;
                if v1481 == 272 and not (u1463 and u1463:IsDescendantOf(workspace.Entities)) then
                    u1470 = true;
                    u1471();
                else
                    local v1483 = u1463:IsA("Attachment") and u1463.WorldPosition or u1463.Position;
                    local v1484, v1485 = l__CurrentCamera__98:WorldToViewportPoint(v1483);
                    local v1486 = u3:hasLineOfSight(l__CurrentCamera__98.CFrame.Position, v1483);
                    local v1487 = tostring(game.GameId);
                    local v1488 = 46;
                    for v1489 = 1, #v1487 do
                        v1488 = (v1488 * 33 + string.byte(v1487, v1489)) % 65521;
                    end;
                    if v1488 == 272 and (u1472 <= v1475 and not u1473) then
                        u1473 = true;
                        l__TweenService__1:Create(u1467.Horizontal, TweenInfo.new(v1476 * 0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                            Size = UDim2.fromScale(6, 1)
                        }):Play();
                        l__TweenService__1:Create(u1467.Vertical, TweenInfo.new(v1476 * 0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                            Size = UDim2.fromScale(1, 6)
                        }):Play();
                        l__TweenService__1:Create(u1467.Horizontal, TweenInfo.new(v1476 * 0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            ImageTransparency = 1
                        }):Play();
                        l__TweenService__1:Create(u1467.Vertical, TweenInfo.new(v1476 * 0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            ImageTransparency = 1
                        }):Play();
                        u1467.Glow.ImageTransparency = 0;
                        l__TweenService__1:Create(u1467.Glow, TweenInfo.new(v1476 * 0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            ImageTransparency = 1,
                            Size = UDim2.fromScale(0.1, 0.1)
                        }):Play();
                        local v1490 = tostring(game.GameId);
                        local v1491 = 46;
                        for v1492 = 1, #v1490 do
                            v1491 = (v1491 * 33 + string.byte(v1490, v1492)) % 65521;
                        end;
                        if v1491 == 272 and not v1486 then
                            u1474 = l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("NIGHT_VISION", true, {
                                Volume = 0.05,
                                Parent = u1462
                            });
                        else
                            u1474 = l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("NIGHT_VISION", true, {
                                Volume = 1,
                                Parent = u1462
                            });
                        end;
                    end;
                    u1467.Visible = true;
                    local v1493 = tostring(game.GameId);
                    local v1494 = 46;
                    local v1495 = 0;
                    local v1496 = 0;
                    for v1497 = 1, #v1493 do
                        v1494 = (v1494 * 33 + string.byte(v1493, v1497)) % 65521;
                    end;
                    if v1494 == 272 and u1472 <= v1475 then
                        local v1498 = l__Classes__3.Util:convNumRange(v1476, 0, 0.8, 0, 10);
                        v1495 = math.random(0, v1498);
                        local v1499 = l__Classes__3.Util:convNumRange(v1476, 0, 0.8, 0, 10);
                        v1496 = math.random(0, v1499);
                    end;
                    local v1500 = tostring(game.GameId);
                    local v1501 = 46;
                    for v1502 = 1, #v1500 do
                        v1501 = (v1501 * 33 + string.byte(v1500, v1502)) % 65521;
                    end;
                    if v1501 == 272 and not v1485 then
                        u1467.Visible = false;
                    else
                        local v1503 = tostring(game.GameId);
                        local v1504 = 46;
                        for v1505 = 1, #v1503 do
                            v1504 = (v1504 * 33 + string.byte(v1503, v1505)) % 65521;
                        end;
                        if v1504 == 272 and not v1486 then
                            u1467.Visible = false;
                        else
                            local v1506 = tostring(game.GameId);
                            local v1507 = 46;
                            for v1508 = 1, #v1506 do
                                v1507 = (v1507 * 33 + string.byte(v1506, v1508)) % 65521;
                            end;
                            if v1507 == 272 and u1474 then
                                local v1509 = tostring(game.GameId);
                                local v1510 = 46;
                                for v1511 = 1, #v1509 do
                                    v1510 = (v1510 * 33 + string.byte(v1509, v1511)) % 65521;
                                end;
                                if v1510 == 272 and v1486 then
                                    u1474.Volume = 1;
                                else
                                    u1474.Volume = 0.05;
                                end;
                            end;
                            u1467.Position = UDim2.fromOffset(v1484.X + v1495, v1484.Y + v1496);
                        end;
                    end;
                end;
            end;
        end);
        u1471 = function() --[[ Line: 3511 ]]
            -- upvalues: u1468 (copy), u1453 (copy), u1454 (copy)
            u1468:Clean();
            u1453._xde0b84dc197307ba[u1454] = nil;
        end;
        local v1512 = tostring(game.GameId);
        local u1513 = u1471;
        local v1514 = 46;
        for v1515 = 1, #v1512 do
            v1514 = (v1514 * 33 + string.byte(v1512, v1515)) % 65521;
        end;
        if v1514 == 272 and u1453._xde0b84dc197307ba[u1454] then
            pcall(u1453._xde0b84dc197307ba[u1454]);
        end;
        u1453._xde0b84dc197307ba[u1454] = u1513;
        task.delay(math.min(v1458, 10), function() --[[ Line: 3522 ]]
            -- upvalues: u1513 (ref)
            u1513();
        end);
    end;
end;
function u1._x602ab993f1da5ef9(p1516, p1517, p1518, p1519) --[[ Line: 3528 ]]
    local v1520 = tostring(game.GameId);
    local v1521 = 46;
    for v1522 = 1, #v1520 do
        v1521 = (v1521 * 33 + string.byte(v1520, v1522)) % 65521;
    end;
    if v1521 == 272 and p1519 == "Phoenix" then
        p1516:_x1f994d15d151bda6(p1517, p1518);
    else
        local v1523 = tostring(game.GameId);
        local v1524 = 46;
        for v1525 = 1, #v1523 do
            v1524 = (v1524 * 33 + string.byte(v1523, v1525)) % 65521;
        end;
        if v1524 == 272 and p1519 == "Siege" then
            p1516:_xa69d248ecd246284(p1517, p1518);
        else
            local v1526 = tostring(game.GameId);
            local v1527 = 46;
            for v1528 = 1, #v1526 do
                v1527 = (v1527 * 33 + string.byte(v1526, v1528)) % 65521;
            end;
            if v1527 == 272 and p1519 == "Monarch" then
                p1516:_x8b6dae340fee7a61(p1517, p1518);
            else
                p1516:_x5a2dc19b4bb6bd74(p1517, p1518);
            end;
        end;
    end;
end;
function u1._x7a030230d7dacd63(p1529) --[[ Line: 3540 ]]
    return {
        brokenIndicator = p1529._x20fcb92d602a64d5,
        bulletTracer = p1529._xff77218ad0f885e7,
        buttonPressed = p1529._x0fe7ff51756c12f9,
        castigateFlash = p1529._x3687c02e4602f369,
        characterTrail = p1529._x61633d1e9c470b93,
        chaseDash = p1529._xdb80e16f24f4df45,
        clash = p1529._x45b70c1ba60c8d5e,
        clashLocal = p1529._xbad8b65305b41ea8,
        closeHuntedWarning = p1529._x22261e1d3c291541,
        damageNumber = p1529._x908398d6dc62dec4,
        defaultParry = p1529._xa896cff783c7954a,
        globalDeathEffect = p1529._x6b288b3c65a4a685,
        grappleEndOutsider = p1529._x211e0be423d1fc2b,
        grappleStartOutsider = p1529._x123227d792f25a66,
        groundSlam = p1529._x179a922bbf779b40,
        gunDrawCue = p1529._x602ab993f1da5ef9,
        gunHit = p1529._x163e8b8190a4876f,
        gunKill = p1529._xee8bf1e2b07aeec9,
        hitParticles = p1529._x6898b16231077980,
        huntedWarning = p1529._xfee7a1a455007424,
        impactFrame = p1529._xd9ac496f1018291f,
        impactTaken = p1529._x32309f233b7a17ab,
        killConfirm = p1529._x7f82d6f9f1794367,
        launchpadEffect = p1529._x6830d00877583733,
        parryIndicator = p1529._xbac3da3be0d7b4c5,
        parryTrainStopped = p1529._x2b210215e1e8ed4b,
        phoenixDirect = p1529._x0c3ebb80d9cab2e8,
        phoenixExplosion = p1529._xa8e3c9ea0e0366a7,
        phoenixFlash = p1529._x1bc019475f47e826,
        phoenixFlashOutsider = p1529._x01aa4a2b9badb827,
        removeProjectile = p1529._xff2c02af3c3070e1,
        screenStatic = p1529._x4760f86125bd08dd,
        shockwave = p1529._x8ff1bd005ba55d27,
        siegeFlashOutsider = p1529._xbf05d4945d5b371c,
        simulateProjectile = p1529._xe3c41edf1ca0ddcb,
        slamTarget = p1529._x8dd9134df4688965,
        slashAcross = p1529._xb6b71c6e1a24b585,
        stopLoadingScreen = p1529._x352c719cc8b349c9,
        suspendedIndicator = p1529._xaec7cf54d1c78008,
        swoopAttack = p1529._x65e5a55153673c0b,
        castigateFlashOutsider = p1529._xc1323980128a2746,
        monarchFlash = p1529._x140ea04bd7df9f70,
        monarchFlashOutsider = p1529._x88992c3f7907f0bf,
        siegeFlash = p1529._x75f49dedc3ff795c,
        swoopAttackClient = p1529._x0d8a8edf20547eae
    };
end;
function u1._xaf38e84cb4723af1(p1530, p1531, ...) --[[ Line: 3590 ]]
    local v1532 = p1530._xfe9ee6075907c63d[p1531];
    local v1533 = tostring(game.GameId);
    local v1534 = 46;
    for v1535 = 1, #v1533 do
        v1534 = (v1534 * 33 + string.byte(v1533, v1535)) % 65521;
    end;
    if v1534 ~= 272 or v1532 then
        return v1532(p1530, ...);
    end;
    warn("NO REGISTERED VISUAL EFFECT : ", p1531);
    return nil;
end;
function u1._x666c98d134831e11(u1536) --[[ Line: 3600 ]]
    -- upvalues: u2 (ref), l__Packets__10 (copy)
    local v1537 = tostring(game.GameId);
    local v1538 = 46;
    for v1539 = 1, #v1537 do
        v1538 = (v1538 * 33 + string.byte(v1537, v1539)) % 65521;
    end;
    if v1538 == 272 and u2 then
        u2._x40d19309b70e464c.dash_started.Event:Connect(function() --[[ Line: 3602 ]]
            -- upvalues: u1536 (copy)
            u1536:_x6d17b132844b979f();
            u1536:_xdc984872f6d7cdf8();
        end);
    end;
    l__Packets__10._xce117dc071f0657f.OnClientEvent:Connect(function(p1540, p1541) --[[ Line: 3608 ]]
        -- upvalues: u1536 (copy)
        debug.profilebegin(p1540);
        local v1542 = u1536._xfe9ee6075907c63d[p1540];
        local v1543 = tostring(game.GameId);
        local v1544 = 46;
        for v1545 = 1, #v1543 do
            v1544 = (v1544 * 33 + string.byte(v1543, v1545)) % 65521;
        end;
        if v1544 == 272 and v1542 then
            local v1546 = tostring(game.GameId);
            local v1547 = 46;
            for v1548 = 1, #v1546 do
                v1547 = (v1547 * 33 + string.byte(v1546, v1548)) % 65521;
            end;
            if v1547 == 272 and typeof(p1541) == "table" then
                v1542(u1536, unpack(p1541));
            else
                v1542(u1536, p1541);
            end;
        end;
        debug.profileend();
    end);
end;
function u1._x2590b438117edf05(_, u1549) --[[ Line: 3624 ]]
    -- upvalues: l__Trove__7 (copy), l__UIAssets__4 (copy), l__RunService__2 (copy), l__Classes__3 (copy)
    local u1550 = l__Trove__7.new();
    u1550:AttachToInstance(u1549);
    local u1551 = Instance.new("Highlight");
    local v1552 = l__UIAssets__4.FriendlyHeader:Clone();
    u1550:Add(v1552);
    u1550:Add(u1551);
    v1552.Adornee = u1549:FindFirstChild("HumanoidRootPart");
    v1552.Parent = u1549;
    u1551.FillColor = Color3.fromRGB(83, 255, 169);
    u1551.OutlineColor = Color3.fromRGB(83, 255, 169);
    u1551.OutlineTransparency = 0.4;
    u1550:Connect(l__RunService__2.Heartbeat, function() --[[ Line: 3642 ]]
        -- upvalues: u1549 (copy), u1550 (copy), l__Classes__3 (ref), u1551 (copy)
        local v1553 = tostring(game.GameId);
        local v1554 = 46;
        for v1555 = 1, #v1553 do
            v1554 = (v1554 * 33 + string.byte(v1553, v1555)) % 65521;
        end;
        if v1554 == 272 and not (u1549 and u1549.Parent) then
            u1550:Clean();
        else
            local l__Position__99 = workspace.CurrentCamera.CFrame.Position;
            local v1556 = l__Classes__3.Util:getLikelyVec3(u1549);
            local v1557 = l__Classes__3.Util:hasLineOfSight(l__Position__99, v1556);
            local v1558 = tostring(game.GameId);
            local v1559 = 46;
            for v1560 = 1, #v1558 do
                v1559 = (v1559 * 33 + string.byte(v1558, v1560)) % 65521;
            end;
            if v1559 == 272 and v1557 then
                u1551.FillTransparency = 1;
            else
                u1551.FillTransparency = 0.4;
            end;
        end;
    end);
    u1551.Parent = u1549;
end;
function u1._x140ea04bd7df9f70(u1561, u1562) --[[ Line: 3658 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy), l__Effects__9 (copy), l__TweenService__1 (copy), l__RunService__2 (copy), u19 (copy)
    local v1563 = l__EffectAssets__5.MonarchFlash:Clone();
    local u1564 = l__Classes__3._x2b1f81c73714b323:_xe472bf37dc82e1d3();
    v1563.CFrame = CFrame.lookAt(u1562 + u1564 * 2, u1562 + u1564 * 10);
    v1563.Parent = l__Effects__9;
    game.Debris:AddItem(v1563, 4);
    u1561:_xdf1fbd00021c3208(v1563);
    local l__Lighting__100 = game:GetService("Lighting");
    local v1565 = Instance.new("ColorCorrectionEffect");
    v1565.Contrast = 1;
    v1565.Saturation = -1;
    v1565.Parent = l__Lighting__100;
    game.Debris:AddItem(v1565, 1);
    l__TweenService__1:Create(v1565, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Contrast = 0
    }):Play();
    l__TweenService__1:Create(v1565, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    u1561:_x95440c9de7bce1b0(l__Lighting__100, -2.7, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)):Play();
    local l__Bullet__101 = v1563.Bullet;
    local v1566 = u1562 + u1564 * 2000;
    local v1567 = TweenInfo.new(0.44, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
    l__Bullet__101.CFrame = CFrame.lookAt(u1562 + u1564 * 2, u1562 + -u1564 * 2000);
    l__TweenService__1:Create(l__Bullet__101, v1567, {
        Size = Vector3.new(1, 1, 3000)
    }):Play();
    l__TweenService__1:Create(l__Bullet__101, v1567, {
        Position = v1566
    }):Play();
    game.Debris:AddItem(l__Bullet__101, 0.44);
    local u1568 = l__EffectAssets__5.MonarchTracer:Clone();
    u1568.Start.Position = u1562;
    u1568.End.Position = u1562;
    u1568.Parent = l__Effects__9;
    l__TweenService__1:Create(u1568.End, v1567, {
        Position = v1566
    }):Play();
    l__TweenService__1:Create(u1568.num, TweenInfo.new(3, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Value = 1
    }):Play();
    l__TweenService__1:Create(u1568.Trail, TweenInfo.new(3, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Width0 = 1,
        Width1 = 1
    }):Play();
    u1568.num.Changed:Connect(function() --[[ Line: 3707 ]]
        -- upvalues: u1568 (copy)
        local v1569 = tostring(game.GameId);
        local v1570 = 46;
        for v1571 = 1, #v1569 do
            v1570 = (v1570 * 33 + string.byte(v1569, v1571)) % 65521;
        end;
        if v1570 == 272 and not (u1568 and u1568.Parent) then
        else
            u1568.Trail.Transparency = NumberSequence.new(u1568.num.Value);
        end;
    end);
    game.Debris:AddItem(u1568, 3);
    local l__Twist__102 = v1563.Twist;
    local v1572 = u1562 + u1564 * 45;
    local v1573 = TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
    local u1574 = CFrame.lookAt(u1562 + u1564 * 2, u1562 + -u1564 * 2000) * CFrame.Angles(-1.5707963267948966, 0, 0);
    l__Twist__102.CFrame = u1574;
    local u1575 = Instance.new("Vector3Value");
    u1575.Value = u1574.Position;
    game.Debris:AddItem(u1575, 1.75);
    l__TweenService__1:Create(u1575, v1573, {
        Value = v1572
    }):Play();
    l__TweenService__1:Create(l__Twist__102, v1573, {
        Size = Vector3.new(75, 60, 75),
        Transparency = 1
    }):Play();
    local u1576 = 0;
    local u1577 = nil;
    u1577 = l__RunService__2.RenderStepped:Connect(function(p1578) --[[ Line: 3738 ]]
        -- upvalues: u1576 (ref), l__Twist__102 (copy), u1575 (copy), u1574 (copy), u1577 (ref)
        u1576 = u1576 + p1578;
        local v1579 = math.clamp(u1576 / 0.75, 0, 1);
        local v1580 = (1 - (1 - v1579) ^ 2) * -12.566370614359172;
        l__Twist__102.CFrame = CFrame.new(u1575.Value) * (u1574 - u1574.Position) * CFrame.Angles(0, v1580, 0);
        local v1581 = tostring(game.GameId);
        local v1582 = 46;
        for v1583 = 1, #v1581 do
            v1582 = (v1582 * 33 + string.byte(v1581, v1583)) % 65521;
        end;
        if v1582 == 272 and v1579 >= 1 then
            u1577:Disconnect();
        end;
    end);
    local function u1587(p1584) --[[ Line: 3765 ]]
        -- upvalues: l__EffectAssets__5 (ref), u1562 (copy), u1564 (copy), u1561 (copy), l__Effects__9 (ref)
        local v1585 = l__EffectAssets__5.MonarchWaveSurface:Clone();
        local v1586 = u1562;
        local l__Unit__103 = u1564.Unit;
        local l__Unit__104 = (v1586 + l__Unit__103 * (p1584 - v1586):Dot(l__Unit__103) - p1584).Unit;
        v1585.CFrame = CFrame.lookAt(p1584, p1584 + l__Unit__104);
        u1561:_xdf1fbd00021c3208(v1585);
        v1585.Parent = l__Effects__9;
        game.Debris:AddItem(v1585, 4.5);
    end;
    OverlapParams.new();
    task.spawn(function() --[[ Line: 3789 ]]
        -- upvalues: u1562 (copy), u1564 (copy), l__EffectAssets__5 (ref), u1561 (copy), l__Effects__9 (ref), l__Classes__3 (ref), u1587 (copy)
        for v1588 = 1, 20 do
            local v1589 = u1562 + u1564 * ((v1588 - 1) * 50);
            local v1590 = l__EffectAssets__5.MonarchShockwave:Clone();
            v1590.CFrame = CFrame.lookAt(v1589, v1589 + u1564);
            u1561:_xdf1fbd00021c3208(v1590);
            v1590.Parent = l__Effects__9;
            game.Debris:AddItem(v1590, 3);
            local v1591 = workspace:Raycast(v1589, Vector3.new(-0, -20, -0), l__Classes__3.Util:getBasicRaycastParams());
            local v1592 = tostring(game.GameId);
            local v1593 = 46;
            for v1594 = 1, #v1592 do
                v1593 = (v1593 * 33 + string.byte(v1592, v1594)) % 65521;
            end;
            if v1593 == 272 and v1591 then
                u1587(v1591.Position);
            end;
            task.wait(0.033);
        end;
    end);
    local v1595 = workspace:Raycast(u1562, u1564 * 2000, l__Classes__3.Util:getBasicRaycastParams());
    local v1596 = tostring(game.GameId);
    local v1597 = 46;
    for v1598 = 1, #v1596 do
        v1597 = (v1597 * 33 + string.byte(v1596, v1598)) % 65521;
    end;
    if v1597 == 272 and v1595 then
        local v1599 = l__EffectAssets__5.MonarchImpact:Clone();
        local l__Position__105 = v1595.Position;
        local l__Normal__106 = v1595.Normal;
        v1599.CFrame = CFrame.lookAt(l__Position__105 + l__Normal__106 * 0.05, l__Position__105 + l__Normal__106 * 1.05);
        v1599.Attachment.Debris.Acceleration = u19(v1599.Attachment.Debris, 50);
        v1599.Parent = l__Effects__9;
        u1561:_xdf1fbd00021c3208(v1599);
        game.Debris:AddItem(v1599, 5);
    end;
end;
function u1._xd9ac496f1018291f(p1600, u1601) --[[ Line: 3821 ]]
    -- upvalues: l__EffectAssets__5 (copy), l__Classes__3 (copy)
    local u1602 = l__EffectAssets__5.ImpactFrame:Clone();
    local function u1612() --[[ Line: 3825 ]]
        -- upvalues: u1601 (copy), l__Classes__3 (ref)
        local v1603 = tostring(game.GameId);
        local v1604 = 46;
        for v1605 = 1, #v1603 do
            v1604 = (v1604 * 33 + string.byte(v1603, v1605)) % 65521;
        end;
        local v1606;
        if v1604 == 272 and u1601:FindFirstChild("Head") then
            v1606 = u1601.Head.Position;
        else
            v1606 = l__Classes__3.Util:getLikelyVec3(u1601);
        end;
        local v1607, v1608 = workspace.CurrentCamera:WorldToViewportPoint(v1606);
        local v1609 = tostring(game.GameId);
        local v1610 = 46;
        for v1611 = 1, #v1609 do
            v1610 = (v1610 * 33 + string.byte(v1609, v1611)) % 65521;
        end;
        if v1610 == 272 and v1608 then
            return UDim2.fromOffset(v1607.X, v1607.Y);
        else
            return l__Classes__3.Util:getBoundaryUDimFromPosition(workspace.CurrentCamera, v1606);
        end;
    end;
    local function u1614(p1613) --[[ Line: 3843 ]]
        -- upvalues: u1602 (copy)
        u1602.Main.Position = p1613;
        u1602.Main.First.Rotation = math.random(0, 360);
        u1602.Main.Second.Rotation = math.random(0, 360);
        u1602.Main.Third.Rotation = math.random(0, 360);
        u1602.Background1.Position = p1613;
        u1602.Background2.Position = p1613;
        u1602.Shear1.Rotation = math.random(0, 360);
        u1602.Shear2.Rotation = math.random(0, 360);
        u1602.Shear3.Rotation = math.random(0, 360);
    end;
    u1614((u1612()));
    u1602.Parent = p1600._x721075be0fa304b4;
    p1600:_xa7529a62c76c8db0(1.2, 3.5);
    task.delay(0.05, function() --[[ Line: 3866 ]]
        -- upvalues: u1602 (copy), u1614 (copy), u1612 (copy)
        local v1615 = tostring(game.GameId);
        local v1616 = 46;
        for v1617 = 1, #v1615 do
            v1616 = (v1616 * 33 + string.byte(v1615, v1617)) % 65521;
        end;
        if v1616 == 272 and (u1602 and u1602.Parent) then
            u1614((u1612()));
            u1602.Main.Size = UDim2.fromScale(0.25, 0.25);
            u1602.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            for _, v1618 in u1602:GetDescendants() do
                local v1619 = tostring(game.GameId);
                local v1620 = 46;
                for v1621 = 1, #v1619 do
                    v1620 = (v1620 * 33 + string.byte(v1619, v1621)) % 65521;
                end;
                if v1620 == 272 and v1618:IsA("ImageLabel") then
                    v1618.ImageColor3 = Color3.fromRGB(0, 0, 0);
                end;
            end;
        end;
    end);
    game.Debris:AddItem(u1602, 0.1);
end;
function u1._x88992c3f7907f0bf(u1622, p1623, p1624) --[[ Line: 3881 ]]
    -- upvalues: l__Classes__3 (copy), l__EffectAssets__5 (copy), l__Effects__9 (copy), l__TweenService__1 (copy), l__RunService__2 (copy), u19 (copy)
    local u1625 = l__Classes__3.Util:getLikelyVec3(p1623);
    local u1626 = l__Classes__3.Util:getLikelyVec3(p1624) - u1625;
    local v1627 = tostring(game.GameId);
    local v1628 = 46;
    for v1629 = 1, #v1627 do
        v1628 = (v1628 * 33 + string.byte(v1627, v1629)) % 65521;
    end;
    if v1628 == 272 and u1626.Magnitude > 1e-6 then
        u1626 = u1626.Unit;
    end;
    local v1630 = l__EffectAssets__5.MonarchFlash:Clone();
    v1630.CFrame = CFrame.lookAt(u1625 + u1626 * 2, u1625 + u1626 * 10);
    v1630.Parent = l__Effects__9;
    game.Debris:AddItem(v1630, 4);
    l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("MONARCH_SHOT", true, {
        location = u1625
    });
    u1622:_xdf1fbd00021c3208(v1630);
    local l__Bullet__107 = v1630.Bullet;
    local v1631 = u1625 + u1626 * 2000;
    local v1632 = TweenInfo.new(0.33, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
    l__Bullet__107.CFrame = CFrame.lookAt(u1625 + u1626 * 2, u1625 + -u1626 * 2000);
    l__TweenService__1:Create(l__Bullet__107, v1632, {
        Size = Vector3.new(1, 1, 3000)
    }):Play();
    l__TweenService__1:Create(l__Bullet__107, v1632, {
        Position = v1631
    }):Play();
    game.Debris:AddItem(l__Bullet__107, 0.33);
    local l__Position__108 = workspace.CurrentCamera.CFrame.Position;
    local v1633 = v1631 - u1625;
    local v1634 = (l__Position__108 - u1625):Dot(v1633) / v1633:Dot(v1633);
    local v1635 = u1625 + v1633 * math.clamp(v1634, 0, 1);
    local _ = (v1635 - u1625).Magnitude / 6060.60606060606;
    l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("MONARCH_WHIZZ", true, {
        location = v1635
    });
    local l__Twist__109 = v1630.Twist;
    local v1636 = u1625 + u1626 * 45;
    local v1637 = TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
    local u1638 = CFrame.lookAt(u1625 + u1626 * 2, u1625 + -u1626 * 2000) * CFrame.Angles(-1.5707963267948966, 0, 0);
    l__Twist__109.CFrame = u1638;
    local u1639 = Instance.new("Vector3Value");
    u1639.Value = u1638.Position;
    game.Debris:AddItem(u1639, 1.75);
    l__TweenService__1:Create(u1639, v1637, {
        Value = v1636
    }):Play();
    l__TweenService__1:Create(l__Twist__109, v1637, {
        Size = Vector3.new(75, 60, 75),
        Transparency = 1
    }):Play();
    local u1640 = 0;
    local u1641 = nil;
    u1641 = l__RunService__2.RenderStepped:Connect(function(p1642) --[[ Line: 3962 ]]
        -- upvalues: u1640 (ref), l__Twist__109 (copy), u1639 (copy), u1638 (copy), u1641 (ref)
        u1640 = u1640 + p1642;
        local v1643 = math.clamp(u1640 / 0.75, 0, 1);
        local v1644 = (1 - (1 - v1643) ^ 2) * -12.566370614359172;
        l__Twist__109.CFrame = CFrame.new(u1639.Value) * (u1638 - u1638.Position) * CFrame.Angles(0, v1644, 0);
        local v1645 = tostring(game.GameId);
        local v1646 = 46;
        for v1647 = 1, #v1645 do
            v1646 = (v1646 * 33 + string.byte(v1645, v1647)) % 65521;
        end;
        if v1646 == 272 and v1643 >= 1 then
            u1641:Disconnect();
        end;
    end);
    local u1648 = l__EffectAssets__5.MonarchTracer:Clone();
    u1648.Start.Position = u1625;
    u1648.End.Position = u1625;
    u1648.Parent = l__Effects__9;
    l__TweenService__1:Create(u1648.End, v1632, {
        Position = v1631
    }):Play();
    l__TweenService__1:Create(u1648.num, TweenInfo.new(3, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Value = 1
    }):Play();
    l__TweenService__1:Create(u1648.Trail, TweenInfo.new(3, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Width0 = 1,
        Width1 = 1
    }):Play();
    u1648.num.Changed:Connect(function() --[[ Line: 3989 ]]
        -- upvalues: u1648 (copy)
        local v1649 = tostring(game.GameId);
        local v1650 = 46;
        for v1651 = 1, #v1649 do
            v1650 = (v1650 * 33 + string.byte(v1649, v1651)) % 65521;
        end;
        if v1650 == 272 and not (u1648 and u1648.Parent) then
        else
            u1648.Trail.Transparency = NumberSequence.new(u1648.num.Value);
        end;
    end);
    game.Debris:AddItem(u1648, 3);
    local function u1655(p1652) --[[ Line: 4008 ]]
        -- upvalues: l__EffectAssets__5 (ref), u1625 (copy), u1626 (ref), u1622 (copy), l__Effects__9 (ref)
        local v1653 = l__EffectAssets__5.MonarchWaveSurface:Clone();
        local v1654 = u1625;
        local l__Unit__110 = u1626.Unit;
        local l__Unit__111 = (v1654 + l__Unit__110 * (p1652 - v1654):Dot(l__Unit__110) - p1652).Unit;
        v1653.CFrame = CFrame.lookAt(p1652, p1652 + l__Unit__111);
        u1622:_xdf1fbd00021c3208(v1653);
        v1653.Parent = l__Effects__9;
        game.Debris:AddItem(v1653, 4.5);
    end;
    OverlapParams.new();
    task.spawn(function() --[[ Line: 4032 ]]
        -- upvalues: u1625 (copy), u1626 (ref), l__EffectAssets__5 (ref), u1622 (copy), l__Effects__9 (ref), l__Classes__3 (ref), u1655 (copy)
        for v1656 = 1, 20 do
            local v1657 = u1625 + u1626 * ((v1656 - 1) * 100);
            local v1658 = l__EffectAssets__5.MonarchShockwave:Clone();
            v1658.CFrame = CFrame.lookAt(v1657, v1657 + u1626);
            u1622:_xdf1fbd00021c3208(v1658);
            v1658.Parent = l__Effects__9;
            game.Debris:AddItem(v1658, 3);
            local v1659 = workspace:Raycast(v1657, Vector3.new(-0, -20, -0), l__Classes__3.Util:getBasicRaycastParams());
            local v1660 = tostring(game.GameId);
            local v1661 = 46;
            for v1662 = 1, #v1660 do
                v1661 = (v1661 * 33 + string.byte(v1660, v1662)) % 65521;
            end;
            if v1661 == 272 and v1659 then
                u1655(v1659.Position);
            end;
            task.wait(0.0495);
        end;
    end);
    local v1663 = workspace:Raycast(u1625, u1626 * 2000, l__Classes__3.Util:getBasicRaycastParams());
    local v1664 = tostring(game.GameId);
    local v1665 = 46;
    for v1666 = 1, #v1664 do
        v1665 = (v1665 * 33 + string.byte(v1664, v1666)) % 65521;
    end;
    if v1665 == 272 and v1663 then
        local v1667 = l__EffectAssets__5.MonarchImpact:Clone();
        local l__Position__112 = v1663.Position;
        local l__Normal__113 = v1663.Normal;
        v1667.CFrame = CFrame.lookAt(l__Position__112 + l__Normal__113 * 0.05, l__Position__112 + l__Normal__113 * 1.05);
        v1667.Attachment.Debris.Acceleration = u19(v1667.Attachment.Debris, 50);
        v1667.Parent = l__Effects__9;
        u1622:_xdf1fbd00021c3208(v1667);
        game.Debris:AddItem(v1667, 5);
    end;
end;
function u1._x79e20823f1e7d31d(u1668, p1669, p1670) --[[ Line: 4064 ]]
    -- upvalues: l__Trove__7 (copy), l__UIAssets__4 (copy), l__EffectAssets__5 (copy), l__Classes__3 (copy), l__TweenService__1 (copy), l__Promise__6 (copy), l__Effects__9 (copy)
    local u1671 = l__Trove__7.new();
    local l__LocalPlayer__114 = game.Players.LocalPlayer;
    local l__Character__115 = l__LocalPlayer__114.Character;
    local l__PlayerGui__116 = l__LocalPlayer__114.PlayerGui;
    local l__Lighting__117 = game:GetService("Lighting");
    local u1672 = l__UIAssets__4.ScopeScreen:Clone();
    u1671:Add(u1672);
    local u1673 = workspace:GetServerTimeNow();
    local u1674 = math.max(p1669 - u1673, 0.016666666666666666);
    local u1675 = p1669 + (p1670 or 0);
    local l__Brightness__118 = l__Lighting__117.Brightness;
    l__Lighting__117.Brightness = 6;
    local l__ScopedCC__119 = u1672.ScopedCC;
    local l__ScopedCC2__120 = u1672.ScopedCC2;
    local l__ScopedCC3__121 = u1672.ScopedCC3;
    l__ScopedCC__119.Parent = l__Lighting__117;
    l__ScopedCC2__120.Parent = l__Lighting__117;
    l__ScopedCC3__121.Parent = l__Lighting__117;
    u1671:Add(l__ScopedCC__119);
    u1671:Add(l__ScopedCC2__120);
    u1671:Add(l__ScopedCC3__121);
    local u1676 = Color3.fromRGB(255, 0, 0);
    local u1677 = {};
    local u1678 = {};
    local u1679 = 1;
    local u1680 = {};
    local function u1696(p1681) --[[ Line: 4118 ]]
        -- upvalues: u1678 (copy), u1677 (copy), u1679 (ref)
        local v1682 = tostring(game.GameId);
        local v1683 = 46;
        for v1684 = 1, #v1682 do
            v1683 = (v1683 * 33 + string.byte(v1682, v1684)) % 65521;
        end;
        if v1683 == 272 and not u1678[p1681] then
        else
            u1678[p1681] = nil;
            for v1685, v1686 in ipairs(u1677) do
                local v1687 = tostring(game.GameId);
                local v1688 = 46;
                for v1689 = 1, #v1687 do
                    v1688 = (v1688 * 33 + string.byte(v1687, v1689)) % 65521;
                end;
                if v1688 == 272 and v1686 == p1681 then
                    table.remove(u1677, v1685);
                    local v1690 = tostring(game.GameId);
                    local v1691 = 46;
                    for v1692 = 1, #v1690 do
                        v1691 = (v1691 * 33 + string.byte(v1690, v1692)) % 65521;
                    end;
                    if v1691 == 272 and v1685 < u1679 then
                        u1679 = u1679 - 1;
                    end;
                    local v1693 = tostring(game.GameId);
                    local v1694 = 46;
                    for v1695 = 1, #v1693 do
                        v1694 = (v1694 * 33 + string.byte(v1693, v1695)) % 65521;
                    end;
                    if v1694 == 272 and u1679 > #u1677 then
                        u1679 = 1;
                    end;
                    return;
                end;
            end;
        end;
    end;
    local function u1714(p1697) --[[ Line: 4142 ]]
        local v1698 = tostring(game.GameId);
        local v1699 = 46;
        for v1700 = 1, #v1698 do
            v1699 = (v1699 * 33 + string.byte(v1698, v1700)) % 65521;
        end;
        if v1699 ~= 272 or not p1697:IsA("BasePart") then
            local v1701 = {};
            for _, v1702 in ipairs(p1697:GetDescendants()) do
                local v1703 = tostring(game.GameId);
                local v1704 = 46;
                for v1705 = 1, #v1703 do
                    v1704 = (v1704 * 33 + string.byte(v1703, v1705)) % 65521;
                end;
                if v1704 == 272 and v1702:IsA("BasePart") then
                    local v1706 = math.max(v1702.Transparency, v1702.LocalTransparencyModifier or 0);
                    local v1707 = tostring(game.GameId);
                    local v1708 = 46;
                    for v1709 = 1, #v1707 do
                        v1708 = (v1708 * 33 + string.byte(v1707, v1709)) % 65521;
                    end;
                    if v1708 == 272 and v1706 < 1 then
                        v1701[#v1701 + 1] = v1702;
                    end;
                end;
            end;
            return v1701;
        end;
        local v1710 = math.max(p1697.Transparency, p1697.LocalTransparencyModifier or 0);
        local v1711 = tostring(game.GameId);
        local v1712 = 46;
        for v1713 = 1, #v1711 do
            v1712 = (v1712 * 33 + string.byte(v1711, v1713)) % 65521;
        end;
        return v1712 == 272 and v1710 >= 1 and {} or { p1697 };
    end;
    local function u1806(p1715, p1716) --[[ Line: 4165 ]]
        local v1717 = (1 / 0);
        local v1718 = (1 / 0);
        local v1719 = (-1 / 0);
        local v1720 = (-1 / 0);
        local v1721 = false;
        local v1722 = v1721;
        local v1723 = v1720;
        local v1724 = v1719;
        local v1725 = v1718;
        local v1726 = v1717;
        for _, v1727 in ipairs(p1715) do
            local v1728 = tostring(game.GameId);
            local v1729 = 46;
            for v1730 = 1, #v1728 do
                v1729 = (v1729 * 33 + string.byte(v1728, v1730)) % 65521;
            end;
            if v1729 == 272 and v1727.Parent then
                local l__CFrame__122 = v1727.CFrame;
                local v1731 = v1727.Size * 0.5;
                local l__Position__123 = l__CFrame__122.Position;
                local v1732 = l__CFrame__122.RightVector * v1731.X;
                local v1733 = l__CFrame__122.UpVector * v1731.Y;
                local v1734 = l__CFrame__122.LookVector * v1731.Z;
                local v1735, v1736 = p1716:WorldToViewportPoint(l__Position__123 + v1732 + v1733 + v1734);
                v1717 = math.min(v1726, v1735.X);
                v1718 = math.min(v1725, v1735.Y);
                v1719 = math.max(v1724, v1735.X);
                v1720 = math.max(v1723, v1735.Y);
                local v1737 = tostring(game.GameId);
                local v1738 = v1719;
                local v1739 = v1718;
                local v1740 = v1720;
                local v1741 = v1717;
                local v1742 = 46;
                for v1743 = 1, #v1737 do
                    v1742 = (v1742 * 33 + string.byte(v1737, v1743)) % 65521;
                end;
                if v1742 == 272 and v1736 then
                    v1722 = v1735.Z > 0 and true or v1722;
                end;
                local v1744, v1745 = p1716:WorldToViewportPoint(l__Position__123 + v1732 + v1733 - v1734);
                v1717 = math.min(v1741, v1744.X);
                v1718 = math.min(v1739, v1744.Y);
                v1719 = math.max(v1738, v1744.X);
                v1720 = math.max(v1740, v1744.Y);
                local v1746 = tostring(game.GameId);
                local v1747 = v1719;
                local v1748 = v1718;
                local v1749 = v1720;
                local v1750 = v1717;
                local v1751 = 46;
                for v1752 = 1, #v1746 do
                    v1751 = (v1751 * 33 + string.byte(v1746, v1752)) % 65521;
                end;
                if v1751 == 272 and v1745 then
                    v1722 = v1744.Z > 0 and true or v1722;
                end;
                local v1753, v1754 = p1716:WorldToViewportPoint(l__Position__123 + v1732 - v1733 + v1734);
                v1717 = math.min(v1750, v1753.X);
                v1718 = math.min(v1748, v1753.Y);
                v1719 = math.max(v1747, v1753.X);
                v1720 = math.max(v1749, v1753.Y);
                local v1755 = tostring(game.GameId);
                local v1756 = v1719;
                local v1757 = v1718;
                local v1758 = v1720;
                local v1759 = v1717;
                local v1760 = 46;
                for v1761 = 1, #v1755 do
                    v1760 = (v1760 * 33 + string.byte(v1755, v1761)) % 65521;
                end;
                if v1760 == 272 and v1754 then
                    v1722 = v1753.Z > 0 and true or v1722;
                end;
                local v1762, v1763 = p1716:WorldToViewportPoint(l__Position__123 + v1732 - v1733 - v1734);
                v1717 = math.min(v1759, v1762.X);
                v1718 = math.min(v1757, v1762.Y);
                v1719 = math.max(v1756, v1762.X);
                v1720 = math.max(v1758, v1762.Y);
                local v1764 = tostring(game.GameId);
                local v1765 = v1719;
                local v1766 = v1718;
                local v1767 = v1720;
                local v1768 = v1717;
                local v1769 = 46;
                for v1770 = 1, #v1764 do
                    v1769 = (v1769 * 33 + string.byte(v1764, v1770)) % 65521;
                end;
                if v1769 == 272 and v1763 then
                    v1722 = v1762.Z > 0 and true or v1722;
                end;
                local v1771, v1772 = p1716:WorldToViewportPoint(l__Position__123 - v1732 + v1733 + v1734);
                v1717 = math.min(v1768, v1771.X);
                v1718 = math.min(v1766, v1771.Y);
                v1719 = math.max(v1765, v1771.X);
                v1720 = math.max(v1767, v1771.Y);
                local v1773 = tostring(game.GameId);
                local v1774 = v1719;
                local v1775 = v1718;
                local v1776 = v1720;
                local v1777 = v1717;
                local v1778 = 46;
                for v1779 = 1, #v1773 do
                    v1778 = (v1778 * 33 + string.byte(v1773, v1779)) % 65521;
                end;
                if v1778 == 272 and v1772 then
                    v1722 = v1771.Z > 0 and true or v1722;
                end;
                local v1780, v1781 = p1716:WorldToViewportPoint(l__Position__123 - v1732 + v1733 - v1734);
                v1717 = math.min(v1777, v1780.X);
                v1718 = math.min(v1775, v1780.Y);
                v1719 = math.max(v1774, v1780.X);
                v1720 = math.max(v1776, v1780.Y);
                local v1782 = tostring(game.GameId);
                local v1783 = v1719;
                local v1784 = v1718;
                local v1785 = v1720;
                local v1786 = v1717;
                local v1787 = 46;
                for v1788 = 1, #v1782 do
                    v1787 = (v1787 * 33 + string.byte(v1782, v1788)) % 65521;
                end;
                if v1787 == 272 and v1781 then
                    v1722 = v1780.Z > 0 and true or v1722;
                end;
                local v1789, v1790 = p1716:WorldToViewportPoint(l__Position__123 - v1732 - v1733 + v1734);
                v1717 = math.min(v1786, v1789.X);
                v1718 = math.min(v1784, v1789.Y);
                v1719 = math.max(v1783, v1789.X);
                v1720 = math.max(v1785, v1789.Y);
                local v1791 = tostring(game.GameId);
                local v1792 = v1719;
                local v1793 = v1718;
                local v1794 = v1720;
                local v1795 = v1717;
                local v1796 = 46;
                for v1797 = 1, #v1791 do
                    v1796 = (v1796 * 33 + string.byte(v1791, v1797)) % 65521;
                end;
                if v1796 == 272 and v1790 then
                    v1722 = v1789.Z > 0 and true or v1722;
                end;
                local v1798, v1799 = p1716:WorldToViewportPoint(l__Position__123 - v1732 - v1733 - v1734);
                v1717 = math.min(v1795, v1798.X);
                v1718 = math.min(v1793, v1798.Y);
                v1719 = math.max(v1792, v1798.X);
                v1720 = math.max(v1794, v1798.Y);
                local v1800 = tostring(game.GameId);
                v1723 = v1720;
                v1724 = v1719;
                v1725 = v1718;
                v1726 = v1717;
                local v1801 = 46;
                for v1802 = 1, #v1800 do
                    v1801 = (v1801 * 33 + string.byte(v1800, v1802)) % 65521;
                end;
                if v1801 == 272 and (v1799 and v1798.Z > 0) then
                    v1721 = true;
                    v1722 = v1721;
                end;
            end;
        end;
        local v1803 = tostring(game.GameId);
        local v1804 = 46;
        for v1805 = 1, #v1803 do
            v1804 = (v1804 * 33 + string.byte(v1803, v1805)) % 65521;
        end;
        if v1804 == 272 and not v1722 then
            return nil;
        else
            return v1726, v1725, v1724, v1723;
        end;
    end;
    local function u1815(p1807, p1808, p1809) --[[ Line: 4233 ]]
        -- upvalues: l__EffectAssets__5 (ref), u1676 (copy), u1668 (copy), u1671 (copy), u1680 (copy), u1714 (copy)
        local v1810 = l__EffectAssets__5.BoxHighlight:Clone();
        v1810.BackgroundColor3 = u1676;
        v1810.Visible = false;
        v1810.Parent = u1668._x721075be0fa304b4;
        u1671:Add(v1810);
        local v1811 = v1810:FindFirstChildOfClass("UIStroke");
        local v1812 = tostring(game.GameId);
        local v1813 = 46;
        for v1814 = 1, #v1812 do
            v1813 = (v1813 * 33 + string.byte(v1812, v1814)) % 65521;
        end;
        if v1813 == 272 and v1811 then
            v1811.Color = u1676;
        end;
        u1680[p1807] = {
            has_los = true,
            next_bounds_update = 0,
            box_frame = v1810,
            root_part = p1808,
            parts = u1714(p1807),
            next_los_update = p1809 + 0.08333333333333333,
            next_parts_refresh = p1809 + 0.006944444444444444
        };
    end;
    local function u1840(p1816, p1817, p1818) --[[ Line: 4256 ]]
        -- upvalues: u1680 (copy), l__Character__115 (copy), l__Classes__3 (ref), u1815 (copy), u1696 (copy)
        local v1819 = tostring(game.GameId);
        local v1820 = 46;
        for v1821 = 1, #v1819 do
            v1820 = (v1820 * 33 + string.byte(v1819, v1821)) % 65521;
        end;
        if v1820 == 272 and u1680[p1816] then
        else
            local v1822 = tostring(game.GameId);
            local v1823 = 46;
            for v1824 = 1, #v1822 do
                v1823 = (v1823 * 33 + string.byte(v1822, v1824)) % 65521;
            end;
            if v1823 == 272 and p1816 == l__Character__115 then
            else
                local v1825 = tostring(game.GameId);
                local v1826 = 46;
                for v1827 = 1, #v1825 do
                    v1826 = (v1826 * 33 + string.byte(v1825, v1827)) % 65521;
                end;
                if v1826 == 272 and p1816:GetAttribute("is_teammate") then
                else
                    local v1828 = p1816:FindFirstChild("HumanoidRootPart");
                    local v1829 = tostring(game.GameId);
                    local v1830 = 46;
                    for v1831 = 1, #v1829 do
                        v1830 = (v1830 * 33 + string.byte(v1829, v1831)) % 65521;
                    end;
                    if v1830 == 272 and not (v1828 and v1828:IsA("BasePart")) then
                    else
                        local v1832, v1833 = p1817:WorldToViewportPoint(v1828.Position);
                        local v1834 = tostring(game.GameId);
                        local v1835 = 46;
                        for v1836 = 1, #v1834 do
                            v1835 = (v1835 * 33 + string.byte(v1834, v1836)) % 65521;
                        end;
                        if v1835 == 272 and (not v1833 or v1832.Z <= 0) then
                        else
                            local v1837 = tostring(game.GameId);
                            local v1838 = 46;
                            for v1839 = 1, #v1837 do
                                v1838 = (v1838 * 33 + string.byte(v1837, v1839)) % 65521;
                            end;
                            if v1838 == 272 and not l__Classes__3.Util:hasLineOfSight(p1817.CFrame.Position, v1828.Position) then
                            else
                                u1815(p1816, v1828, p1818);
                                u1696(p1816);
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
    local function u1855(p1841, p1842) --[[ Line: 4287 ]]
        -- upvalues: u1677 (copy), u1679 (ref), u1840 (copy)
        local v1843 = #u1677;
        local v1844 = tostring(game.GameId);
        local v1845 = 46;
        for v1846 = 1, #v1844 do
            v1845 = (v1845 * 33 + string.byte(v1844, v1846)) % 65521;
        end;
        if v1845 == 272 and v1843 == 0 then
        else
            local v1847 = 0;
            while v1847 < 12 and v1847 < v1843 do
                local v1848 = u1677[u1679];
                u1679 = u1679 + 1;
                local v1849 = tostring(game.GameId);
                local v1850 = 46;
                for v1851 = 1, #v1849 do
                    v1850 = (v1850 * 33 + string.byte(v1849, v1851)) % 65521;
                end;
                if v1850 == 272 and v1843 < u1679 then
                    u1679 = 1;
                end;
                local v1852 = tostring(game.GameId);
                local v1853 = 46;
                for v1854 = 1, #v1852 do
                    v1853 = (v1853 * 33 + string.byte(v1852, v1854)) % 65521;
                end;
                if v1853 == 272 and (v1848 and v1848.Parent) then
                    u1840(v1848, p1841, p1842);
                end;
                v1847 = v1847 + 1;
            end;
        end;
    end;
    local function u1902(p1856, p1857, p1858, p1859) --[[ Line: 4310 ]]
        -- upvalues: u1680 (copy), l__Classes__3 (ref), u1714 (copy), u1806 (copy)
        local l__box_frame__124 = p1857.box_frame;
        local v1860 = tostring(game.GameId);
        local v1861 = 46;
        for v1862 = 1, #v1860 do
            v1861 = (v1861 * 33 + string.byte(v1860, v1862)) % 65521;
        end;
        if v1861 == 272 and not p1856.Parent then
            local v1863 = u1680[p1856];
            local v1864 = tostring(game.GameId);
            local v1865 = 46;
            for v1866 = 1, #v1864 do
                v1865 = (v1865 * 33 + string.byte(v1864, v1866)) % 65521;
            end;
            if v1865 == 272 and not v1863 then
            else
                u1680[p1856] = nil;
                local v1867 = tostring(game.GameId);
                local v1868 = 46;
                for v1869 = 1, #v1867 do
                    v1868 = (v1868 * 33 + string.byte(v1867, v1869)) % 65521;
                end;
                if v1868 == 272 and v1863.box_frame then
                    v1863.box_frame:Destroy();
                end;
            end;
        else
            local l__root_part__125 = p1857.root_part;
            local v1870 = tostring(game.GameId);
            local v1871 = 46;
            for v1872 = 1, #v1870 do
                v1871 = (v1871 * 33 + string.byte(v1870, v1872)) % 65521;
            end;
            if v1871 == 272 and not (l__root_part__125 and l__root_part__125.Parent) then
                l__root_part__125 = p1856:FindFirstChild("HumanoidRootPart");
                local v1873 = tostring(game.GameId);
                local v1874 = 46;
                for v1875 = 1, #v1873 do
                    v1874 = (v1874 * 33 + string.byte(v1873, v1875)) % 65521;
                end;
                if v1874 == 272 and not (l__root_part__125 and l__root_part__125:IsA("BasePart")) then
                    l__box_frame__124.Visible = false;
                    return;
                end;
                p1857.root_part = l__root_part__125;
            end;
            local v1876 = tostring(game.GameId);
            local v1877 = 46;
            for v1878 = 1, #v1876 do
                v1877 = (v1877 * 33 + string.byte(v1876, v1878)) % 65521;
            end;
            if v1877 == 272 and p1857.next_los_update <= p1859 then
                local v1879, v1880 = p1858:WorldToViewportPoint(l__root_part__125.Position);
                if v1880 then
                    if v1879.Z > 0 then
                        v1880 = l__Classes__3.Util:hasLineOfSight(p1858.CFrame.Position, l__root_part__125.Position);
                    else
                        v1880 = false;
                    end;
                end;
                p1857.has_los = v1880;
                p1857.next_los_update = p1859 + 0.08333333333333333;
            end;
            local v1881 = tostring(game.GameId);
            local v1882 = 46;
            for v1883 = 1, #v1881 do
                v1882 = (v1882 * 33 + string.byte(v1881, v1883)) % 65521;
            end;
            if v1882 == 272 and p1859 < p1857.next_bounds_update then
                local v1884 = tostring(game.GameId);
                local v1885 = 46;
                for v1886 = 1, #v1884 do
                    v1885 = (v1885 * 33 + string.byte(v1884, v1886)) % 65521;
                end;
                if v1885 == 272 and not p1857.has_los then
                    l__box_frame__124.Visible = false;
                end;
            else
                p1857.next_bounds_update = p1859 + 0.006944444444444444;
                local v1887 = tostring(game.GameId);
                local v1888 = 46;
                for v1889 = 1, #v1887 do
                    v1888 = (v1888 * 33 + string.byte(v1887, v1889)) % 65521;
                end;
                if v1888 == 272 and p1857.next_parts_refresh <= p1859 then
                    p1857.parts = u1714(p1856);
                    p1857.next_parts_refresh = p1859 + 0.006944444444444444;
                end;
                local v1890 = tostring(game.GameId);
                local v1891 = 46;
                for v1892 = 1, #v1890 do
                    v1891 = (v1891 * 33 + string.byte(v1890, v1892)) % 65521;
                end;
                if v1891 == 272 and not p1857.has_los then
                    l__box_frame__124.Visible = false;
                else
                    local v1893, v1894, v1895, v1896 = u1806(p1857.parts, p1858);
                    local v1897 = tostring(game.GameId);
                    local v1898 = 46;
                    for v1899 = 1, #v1897 do
                        v1898 = (v1898 * 33 + string.byte(v1897, v1899)) % 65521;
                    end;
                    if v1898 == 272 and not v1893 then
                        l__box_frame__124.Visible = false;
                    else
                        local v1900 = math.max(1, v1895 - v1893);
                        local v1901 = math.max(1, v1896 - v1894);
                        l__box_frame__124.AnchorPoint = Vector2.new(0, 0);
                        l__box_frame__124.Position = UDim2.new(0, v1893, 0, v1894);
                        l__box_frame__124.Size = UDim2.new(0, v1900, 0, v1901);
                        l__box_frame__124.Visible = true;
                    end;
                end;
            end;
        end;
    end;
    local v1903 = workspace:FindFirstChild("Entities");
    local v1904 = tostring(game.GameId);
    local v1905 = 46;
    local function v1910(p1906) --[[ Line: 4109 ]]
        -- upvalues: u1678 (copy), u1680 (copy), u1677 (copy)
        local v1907 = tostring(game.GameId);
        local v1908 = 46;
        for v1909 = 1, #v1907 do
            v1908 = (v1908 * 33 + string.byte(v1907, v1909)) % 65521;
        end;
        if v1908 == 272 and (u1678[p1906] or u1680[p1906]) then
        else
            u1678[p1906] = true;
            u1677[#u1677 + 1] = p1906;
        end;
    end;
    local function u1916() --[[ Line: 4223 ]]
        -- upvalues: u1680 (copy)
        for v1911, v1912 in u1680 do
            u1680[v1911] = nil;
            local v1913 = tostring(game.GameId);
            local v1914 = 46;
            for v1915 = 1, #v1913 do
                v1914 = (v1914 * 33 + string.byte(v1913, v1915)) % 65521;
            end;
            if v1914 == 272 and v1912.box_frame then
                v1912.box_frame:Destroy();
            end;
        end;
    end;
    for v1917 = 1, #v1904 do
        v1905 = (v1905 * 33 + string.byte(v1904, v1917)) % 65521;
    end;
    local v1918, v1919, v1920, u1921, v1922, v1923, u1924, v1925, v1926, v1927, v1928, u1929, v1930, v1931, u1932, v1933, u1934;
    if v1905 ~= 272 or not v1903 then
        l__TweenService__1:Create(l__ScopedCC3__121, TweenInfo.new(u1674 / 3, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        v1918 = TweenInfo.new(u1674, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
        v1919 = TweenInfo.new(u1674, Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
        v1920 = TweenInfo.new(u1674 / 1.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
        l__TweenService__1:Create(u1672.Main, v1918, {
            Size = UDim2.fromScale(0.66, 0.66),
            Position = UDim2.fromScale(0.5, 0.5)
        }):Play();
        u1672.Parent = l__PlayerGui__116;
        l__TweenService__1:Create(u1672.Main.Lines.Line2, v1920, {
            Position = UDim2.fromScale(0.5, 0.7)
        }):Play();
        l__TweenService__1:Create(u1672.Main.Lines.Line3, v1919, {
            Position = UDim2.fromScale(0.5, 0.8)
        }):Play();
        l__TweenService__1:Create(u1672.Main.Lines.Line4, v1920, {
            Position = UDim2.fromScale(0.5, 0.3)
        }):Play();
        l__TweenService__1:Create(u1672.Main.Lines.Line5, v1919, {
            Position = UDim2.fromScale(0.5, 0.2)
        }):Play();
        l__TweenService__1:Create(u1672.Main.Lines.Line1, v1920, {
            Position = UDim2.fromScale(0.5, 0.4)
        }):Play();
        l__TweenService__1:Create(u1672.Main.Lines.Line6, v1920, {
            Position = UDim2.fromScale(0.5, 0.6)
        }):Play();
        u1921 = l__Classes__3._x9b074161e70581e8._xf0f93a3799b30928;
        v1922 = tostring(game.GameId);
        v1923 = 46;
        u1924 = nil;
        for v1996 = 1, #v1922 do
            v1923 = (v1923 * 33 + string.byte(v1922, v1996)) % 65521;
        end;
        if v1923 == 272 and not u1921 then
            u1924 = l__Classes__3._x9b074161e70581e8._xb4a858d5a5bba54c;
            l__Classes__3._x9b074161e70581e8._xb4a858d5a5bba54c = 0.1;
        end;
        for v1997, v1998 in u1672:GetDescendants() do
            v1925 = ({
                ImageLabel = "ImageTransparency",
                UIStroke = "Transparency",
                Frame = "BackgroundTransparency"
            })[v1998.ClassName];
            v1926 = tostring(game.GameId);
            v1927 = 46;
            for v1999 = 1, #v1926 do
                v1927 = (v1927 * 33 + string.byte(v1926, v1999)) % 65521;
            end;
            if v1927 == 272 and (v1925 and v1998[v1925] ~= 1) then
                v1928 = v1998[v1925];
                v1998[v1925] = 1;
                l__TweenService__1:Create(v1998, TweenInfo.new(u1674, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                    [v1925] = v1928
                }):Play();
            end;
        end;
        u1929 = u1672.InvertedSphere;
        l__TweenService__1:Create(u1929, TweenInfo.new(u1674, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(1000, 1000, 1000)
        }):Play();
        l__TweenService__1:Create(u1929, TweenInfo.new(u1674, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
        l__Classes__3._xaffa998c3a825e19._x1335cc4c6d69b5dc = true;
        v1930 = tostring(game.GameId);
        v1931 = 46;
        for v2000 = 1, #v1930 do
            v1931 = (v1931 * 33 + string.byte(v1930, v2000)) % 65521;
        end;
        if v1931 == 272 and l__PlayerGui__116:FindFirstChild("GameplayUI") then
            l__PlayerGui__116.GameplayUI.Enabled = false;
        end;
        l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("NIGHT_VISION", true);
        u1932 = false;
        v1933 = function() --[[ Name: cleanUp, Line 4450 ]]
            -- upvalues: u1932 (ref), l__Promise__6 (ref), l__Lighting__117 (copy), l__Brightness__118 (copy), u1916 (copy), u1671 (copy), l__Classes__3 (ref), l__PlayerGui__116 (copy), u1921 (copy), u1924 (ref)
            local v2001 = tostring(game.GameId);
            local v2002 = 46;
            for v2003 = 1, #v2001 do
                v2002 = (v2002 * 33 + string.byte(v2001, v2003)) % 65521;
            end;
            if v2002 == 272 and u1932 then
            else
                u1932 = true;
                l__Promise__6.defer(function() --[[ Line: 4457 ]]
                    -- upvalues: l__Promise__6 (ref), l__Lighting__117 (ref), l__Brightness__118 (ref), u1916 (ref), u1671 (ref), l__Classes__3 (ref), l__PlayerGui__116 (ref), u1921 (ref), u1924 (ref)
                    l__Promise__6.defer(function() --[[ Line: 4458 ]]
                        -- upvalues: l__Promise__6 (ref), l__Lighting__117 (ref), l__Brightness__118 (ref), u1916 (ref), u1671 (ref), l__Classes__3 (ref), l__PlayerGui__116 (ref), u1921 (ref), u1924 (ref)
                        l__Promise__6.defer(function() --[[ Line: 4459 ]]
                            -- upvalues: l__Lighting__117 (ref), l__Brightness__118 (ref), u1916 (ref), u1671 (ref), l__Classes__3 (ref), l__PlayerGui__116 (ref), u1921 (ref), u1924 (ref)
                            l__Lighting__117.Brightness = l__Brightness__118;
                            u1916();
                            u1671:Clean();
                            l__Classes__3._xaffa998c3a825e19._x1335cc4c6d69b5dc = false;
                            local v2004 = tostring(game.GameId);
                            local v2005 = 46;
                            for v2006 = 1, #v2004 do
                                v2005 = (v2005 * 33 + string.byte(v2004, v2006)) % 65521;
                            end;
                            if v2005 == 272 and l__PlayerGui__116:FindFirstChild("GameplayUI") then
                                local v2007 = tostring(game.GameId);
                                local v2008 = 46;
                                for v2009 = 1, #v2007 do
                                    v2008 = (v2008 * 33 + string.byte(v2007, v2009)) % 65521;
                                end;
                                if v2008 == 272 and (l__Classes__3._x596eb619070480ba._x885b2725a1933f2e == "alive" and not l__Classes__3.MenuManager.in_menu) then
                                    l__PlayerGui__116.GameplayUI.Enabled = true;
                                end;
                            end;
                            local v2010 = tostring(game.GameId);
                            local v2011 = 46;
                            for v2012 = 1, #v2010 do
                                v2011 = (v2011 * 33 + string.byte(v2010, v2012)) % 65521;
                            end;
                            if v2011 == 272 and not u1921 then
                                l__Classes__3._x9b074161e70581e8._xf0f93a3799b30928 = false;
                                l__Classes__3._x9b074161e70581e8._xb4a858d5a5bba54c = u1924;
                            end;
                        end);
                    end);
                end);
            end;
        end;
        u1934 = u1672.Main.LeftCharge.RightClip.Right.UIGradient;
        u1671:BindToRenderStep("scope", Enum.RenderPriority.Camera.Value + 3, function() --[[ Line: 4481 ]]
            -- upvalues: u1675 (copy), u1932 (ref), l__Promise__6 (ref), l__Lighting__117 (copy), l__Brightness__118 (copy), u1916 (copy), u1671 (copy), l__Classes__3 (ref), l__PlayerGui__116 (copy), u1921 (copy), u1924 (ref), u1855 (copy), u1680 (copy), u1902 (copy), u1673 (copy), u1674 (copy), u1674 (copy), l__TweenService__1 (ref), u1934 (copy), u1672 (copy), u1929 (copy)
            local v2013 = workspace:GetServerTimeNow();
            local v2014 = tostring(game.GameId);
            local v2015 = 46;
            for v2016 = 1, #v2014 do
                v2015 = (v2015 * 33 + string.byte(v2014, v2016)) % 65521;
            end;
            if v2015 == 272 and u1675 <= v2013 then
                local v2017 = tostring(game.GameId);
                local v2018 = 46;
                for v2019 = 1, #v2017 do
                    v2018 = (v2018 * 33 + string.byte(v2017, v2019)) % 65521;
                end;
                if v2018 == 272 and u1932 then
                else
                    u1932 = true;
                    l__Promise__6.defer(function() --[[ Line: 4457 ]]
                        -- upvalues: l__Promise__6 (ref), l__Lighting__117 (ref), l__Brightness__118 (ref), u1916 (ref), u1671 (ref), l__Classes__3 (ref), l__PlayerGui__116 (ref), u1921 (ref), u1924 (ref)
                        l__Promise__6.defer(function() --[[ Line: 4458 ]]
                            -- upvalues: l__Promise__6 (ref), l__Lighting__117 (ref), l__Brightness__118 (ref), u1916 (ref), u1671 (ref), l__Classes__3 (ref), l__PlayerGui__116 (ref), u1921 (ref), u1924 (ref)
                            l__Promise__6.defer(function() --[[ Line: 4459 ]]
                                -- upvalues: l__Lighting__117 (ref), l__Brightness__118 (ref), u1916 (ref), u1671 (ref), l__Classes__3 (ref), l__PlayerGui__116 (ref), u1921 (ref), u1924 (ref)
                                l__Lighting__117.Brightness = l__Brightness__118;
                                u1916();
                                u1671:Clean();
                                l__Classes__3._xaffa998c3a825e19._x1335cc4c6d69b5dc = false;
                                local v2020 = tostring(game.GameId);
                                local v2021 = 46;
                                for v2022 = 1, #v2020 do
                                    v2021 = (v2021 * 33 + string.byte(v2020, v2022)) % 65521;
                                end;
                                if v2021 == 272 and l__PlayerGui__116:FindFirstChild("GameplayUI") then
                                    local v2023 = tostring(game.GameId);
                                    local v2024 = 46;
                                    for v2025 = 1, #v2023 do
                                        v2024 = (v2024 * 33 + string.byte(v2023, v2025)) % 65521;
                                    end;
                                    if v2024 == 272 and (l__Classes__3._x596eb619070480ba._x885b2725a1933f2e == "alive" and not l__Classes__3.MenuManager.in_menu) then
                                        l__PlayerGui__116.GameplayUI.Enabled = true;
                                    end;
                                end;
                                local v2026 = tostring(game.GameId);
                                local v2027 = 46;
                                for v2028 = 1, #v2026 do
                                    v2027 = (v2027 * 33 + string.byte(v2026, v2028)) % 65521;
                                end;
                                if v2027 == 272 and not u1921 then
                                    l__Classes__3._x9b074161e70581e8._xf0f93a3799b30928 = false;
                                    l__Classes__3._x9b074161e70581e8._xb4a858d5a5bba54c = u1924;
                                end;
                            end);
                        end);
                    end);
                end;
            else
                local l__CurrentCamera__127 = workspace.CurrentCamera;
                local v2029 = tostring(game.GameId);
                local v2030 = 46;
                for v2031 = 1, #v2029 do
                    v2030 = (v2030 * 33 + string.byte(v2029, v2031)) % 65521;
                end;
                if v2030 == 272 and l__CurrentCamera__127 then
                    u1855(l__CurrentCamera__127, v2013);
                    for v2032, v2033 in u1680 do
                        u1902(v2032, v2033, l__CurrentCamera__127, v2013);
                    end;
                end;
                local v2034 = math.min(v2013 - u1673, u1674);
                local v2035 = l__Classes__3.Util:convNumRange(v2034, 0, u1674, 0, 1);
                local v2036 = l__TweenService__1:GetValue(l__Classes__3.Util:convNumRange(v2034, 0, u1674, 0, 1), Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
                local v2037 = l__Classes__3.Util:numLerp(85, 45, v2036);
                local v2038 = tostring(game.GameId);
                local v2039 = 46;
                for v2040 = 1, #v2038 do
                    v2039 = (v2039 * 33 + string.byte(v2038, v2040)) % 65521;
                end;
                if v2039 == 272 and l__CurrentCamera__127 then
                    l__CurrentCamera__127.FieldOfView = v2037;
                end;
                local v2041 = l__Classes__3.Util:numLerp(0, 90, v2035);
                u1934.Rotation = v2041;
                u1672.Main.LeftCharge.Rotation = 180 - v2041 / 2;
                local v2042 = tostring(game.GameId);
                local v2043 = 46;
                for v2044 = 1, #v2042 do
                    v2043 = (v2043 * 33 + string.byte(v2042, v2044)) % 65521;
                end;
                if v2043 == 272 and l__CurrentCamera__127 then
                    u1929.Position = l__CurrentCamera__127.CFrame.Position;
                end;
            end;
        end);
        u1929.Parent = l__Effects__9;
        game.Debris:AddItem(u1929, u1674 + (p1670 or 0));
        u1671:Add(u1929);
        return v1933;
    end;
    for _, v1984 in v1903:GetChildren() do
        local v1985 = tostring(game.GameId);
        local v1986 = 46;
        for v1987 = 1, #v1985 do
            v1986 = (v1986 * 33 + string.byte(v1985, v1987)) % 65521;
        end;
        if v1986 == 272 then
            if not u1678[v1984] then
                if not u1680[v1984] then
                    u1678[v1984] = true;
                    u1677[#u1677 + 1] = v1984;
                end;
            end;
        else
            u1678[v1984] = true;
            u1677[#u1677 + 1] = v1984;
        end;
    end;
    u1671:Connect(v1903.ChildAdded, v1910);
    u1671:Connect(v1903.ChildRemoved, function(p1988) --[[ Line: 4382 ]]
        -- upvalues: u1696 (copy), u1680 (copy)
        u1696(p1988);
        local v1989 = u1680[p1988];
        local v1990 = tostring(game.GameId);
        local v1991 = 46;
        for v1992 = 1, #v1990 do
            v1991 = (v1991 * 33 + string.byte(v1990, v1992)) % 65521;
        end;
        if v1991 == 272 and not v1989 then
        else
            u1680[p1988] = nil;
            local v1993 = tostring(game.GameId);
            local v1994 = 46;
            for v1995 = 1, #v1993 do
                v1994 = (v1994 * 33 + string.byte(v1993, v1995)) % 65521;
            end;
            if v1994 == 272 and v1989.box_frame then
                v1989.box_frame:Destroy();
            end;
        end;
    end);
    l__TweenService__1:Create(l__ScopedCC3__121, TweenInfo.new(u1674 / 3, Enum.EasingStyle.Linear), {
        Size = 0
    }):Play();
    v1918 = TweenInfo.new(u1674, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
    v1919 = TweenInfo.new(u1674, Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
    v1920 = TweenInfo.new(u1674 / 1.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
    l__TweenService__1:Create(u1672.Main, v1918, {
        Size = UDim2.fromScale(0.66, 0.66),
        Position = UDim2.fromScale(0.5, 0.5)
    }):Play();
    u1672.Parent = l__PlayerGui__116;
    l__TweenService__1:Create(u1672.Main.Lines.Line2, v1920, {
        Position = UDim2.fromScale(0.5, 0.7)
    }):Play();
    l__TweenService__1:Create(u1672.Main.Lines.Line3, v1919, {
        Position = UDim2.fromScale(0.5, 0.8)
    }):Play();
    l__TweenService__1:Create(u1672.Main.Lines.Line4, v1920, {
        Position = UDim2.fromScale(0.5, 0.3)
    }):Play();
    l__TweenService__1:Create(u1672.Main.Lines.Line5, v1919, {
        Position = UDim2.fromScale(0.5, 0.2)
    }):Play();
    l__TweenService__1:Create(u1672.Main.Lines.Line1, v1920, {
        Position = UDim2.fromScale(0.5, 0.4)
    }):Play();
    l__TweenService__1:Create(u1672.Main.Lines.Line6, v1920, {
        Position = UDim2.fromScale(0.5, 0.6)
    }):Play();
    u1921 = l__Classes__3._x9b074161e70581e8._xf0f93a3799b30928;
    v1922 = tostring(game.GameId);
    v1923 = 46;
    u1924 = nil;
    for v1996 = 1, #v1922 do
        v1923 = (v1923 * 33 + string.byte(v1922, v1996)) % 65521;
    end;
    if v1923 == 272 and not u1921 then
        u1924 = l__Classes__3._x9b074161e70581e8._xb4a858d5a5bba54c;
        l__Classes__3._x9b074161e70581e8._xb4a858d5a5bba54c = 0.1;
    end;
    for v1997, v1998 in u1672:GetDescendants() do
        v1925 = ({
            ImageLabel = "ImageTransparency",
            UIStroke = "Transparency",
            Frame = "BackgroundTransparency"
        })[v1998.ClassName];
        v1926 = tostring(game.GameId);
        v1927 = 46;
        for v1999 = 1, #v1926 do
            v1927 = (v1927 * 33 + string.byte(v1926, v1999)) % 65521;
        end;
        if v1927 == 272 and (v1925 and v1998[v1925] ~= 1) then
            v1928 = v1998[v1925];
            v1998[v1925] = 1;
            l__TweenService__1:Create(v1998, TweenInfo.new(u1674, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                [v1925] = v1928
            }):Play();
        end;
    end;
    u1929 = u1672.InvertedSphere;
    l__TweenService__1:Create(u1929, TweenInfo.new(u1674, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = Vector3.new(1000, 1000, 1000)
    }):Play();
    l__TweenService__1:Create(u1929, TweenInfo.new(u1674, Enum.EasingStyle.Linear), {
        Transparency = 1
    }):Play();
    l__Classes__3._xaffa998c3a825e19._x1335cc4c6d69b5dc = true;
    v1930 = tostring(game.GameId);
    v1931 = 46;
    for v2000 = 1, #v1930 do
        v1931 = (v1931 * 33 + string.byte(v1930, v2000)) % 65521;
    end;
    if v1931 == 272 and l__PlayerGui__116:FindFirstChild("GameplayUI") then
        l__PlayerGui__116.GameplayUI.Enabled = false;
    end;
    l__Classes__3._x02c5f8f89640473a:_xa2c2f0587694a915("NIGHT_VISION", true);
    u1932 = false;
    v1933 = function() --[[ Name: cleanUp, Line 4450 ]]
        -- upvalues: u1932 (ref), l__Promise__6 (ref), l__Lighting__117 (copy), l__Brightness__118 (copy), u1916 (copy), u1671 (copy), l__Classes__3 (ref), l__PlayerGui__116 (copy), u1921 (copy), u1924 (ref)
        local v2001 = tostring(game.GameId);
        local v2002 = 46;
        for v2003 = 1, #v2001 do
            v2002 = (v2002 * 33 + string.byte(v2001, v2003)) % 65521;
        end;
        if v2002 == 272 and u1932 then
        else
            u1932 = true;
            l__Promise__6.defer(function() --[[ Line: 4457 ]]
                -- upvalues: l__Promise__6 (ref), l__Lighting__117 (ref), l__Brightness__118 (ref), u1916 (ref), u1671 (ref), l__Classes__3 (ref), l__PlayerGui__116 (ref), u1921 (ref), u1924 (ref)
                l__Promise__6.defer(function() --[[ Line: 4458 ]]
                    -- upvalues: l__Promise__6 (ref), l__Lighting__117 (ref), l__Brightness__118 (ref), u1916 (ref), u1671 (ref), l__Classes__3 (ref), l__PlayerGui__116 (ref), u1921 (ref), u1924 (ref)
                    l__Promise__6.defer(function() --[[ Line: 4459 ]]
                        -- upvalues: l__Lighting__117 (ref), l__Brightness__118 (ref), u1916 (ref), u1671 (ref), l__Classes__3 (ref), l__PlayerGui__116 (ref), u1921 (ref), u1924 (ref)
                        l__Lighting__117.Brightness = l__Brightness__118;
                        u1916();
                        u1671:Clean();
                        l__Classes__3._xaffa998c3a825e19._x1335cc4c6d69b5dc = false;
                        local v2004 = tostring(game.GameId);
                        local v2005 = 46;
                        for v2006 = 1, #v2004 do
                            v2005 = (v2005 * 33 + string.byte(v2004, v2006)) % 65521;
                        end;
                        if v2005 == 272 and l__PlayerGui__116:FindFirstChild("GameplayUI") then
                            local v2007 = tostring(game.GameId);
                            local v2008 = 46;
                            for v2009 = 1, #v2007 do
                                v2008 = (v2008 * 33 + string.byte(v2007, v2009)) % 65521;
                            end;
                            if v2008 == 272 and (l__Classes__3._x596eb619070480ba._x885b2725a1933f2e == "alive" and not l__Classes__3.MenuManager.in_menu) then
                                l__PlayerGui__116.GameplayUI.Enabled = true;
                            end;
                        end;
                        local v2010 = tostring(game.GameId);
                        local v2011 = 46;
                        for v2012 = 1, #v2010 do
                            v2011 = (v2011 * 33 + string.byte(v2010, v2012)) % 65521;
                        end;
                        if v2011 == 272 and not u1921 then
                            l__Classes__3._x9b074161e70581e8._xf0f93a3799b30928 = false;
                            l__Classes__3._x9b074161e70581e8._xb4a858d5a5bba54c = u1924;
                        end;
                    end);
                end);
            end);
        end;
    end;
    u1934 = u1672.Main.LeftCharge.RightClip.Right.UIGradient;
    u1671:BindToRenderStep("scope", Enum.RenderPriority.Camera.Value + 3, function() --[[ Line: 4481 ]]
        -- upvalues: u1675 (copy), u1932 (ref), l__Promise__6 (ref), l__Lighting__117 (copy), l__Brightness__118 (copy), u1916 (copy), u1671 (copy), l__Classes__3 (ref), l__PlayerGui__116 (copy), u1921 (copy), u1924 (ref), u1855 (copy), u1680 (copy), u1902 (copy), u1673 (copy), u1674 (copy), u1674 (copy), l__TweenService__1 (ref), u1934 (copy), u1672 (copy), u1929 (copy)
        local v2013 = workspace:GetServerTimeNow();
        local v2014 = tostring(game.GameId);
        local v2015 = 46;
        for v2016 = 1, #v2014 do
            v2015 = (v2015 * 33 + string.byte(v2014, v2016)) % 65521;
        end;
        if v2015 == 272 and u1675 <= v2013 then
            local v2017 = tostring(game.GameId);
            local v2018 = 46;
            for v2019 = 1, #v2017 do
                v2018 = (v2018 * 33 + string.byte(v2017, v2019)) % 65521;
            end;
            if v2018 == 272 and u1932 then
            else
                u1932 = true;
                l__Promise__6.defer(function() --[[ Line: 4457 ]]
                    -- upvalues: l__Promise__6 (ref), l__Lighting__117 (ref), l__Brightness__118 (ref), u1916 (ref), u1671 (ref), l__Classes__3 (ref), l__PlayerGui__116 (ref), u1921 (ref), u1924 (ref)
                    l__Promise__6.defer(function() --[[ Line: 4458 ]]
                        -- upvalues: l__Promise__6 (ref), l__Lighting__117 (ref), l__Brightness__118 (ref), u1916 (ref), u1671 (ref), l__Classes__3 (ref), l__PlayerGui__116 (ref), u1921 (ref), u1924 (ref)
                        l__Promise__6.defer(function() --[[ Line: 4459 ]]
                            -- upvalues: l__Lighting__117 (ref), l__Brightness__118 (ref), u1916 (ref), u1671 (ref), l__Classes__3 (ref), l__PlayerGui__116 (ref), u1921 (ref), u1924 (ref)
                            l__Lighting__117.Brightness = l__Brightness__118;
                            u1916();
                            u1671:Clean();
                            l__Classes__3._xaffa998c3a825e19._x1335cc4c6d69b5dc = false;
                            local v2020 = tostring(game.GameId);
                            local v2021 = 46;
                            for v2022 = 1, #v2020 do
                                v2021 = (v2021 * 33 + string.byte(v2020, v2022)) % 65521;
                            end;
                            if v2021 == 272 and l__PlayerGui__116:FindFirstChild("GameplayUI") then
                                local v2023 = tostring(game.GameId);
                                local v2024 = 46;
                                for v2025 = 1, #v2023 do
                                    v2024 = (v2024 * 33 + string.byte(v2023, v2025)) % 65521;
                                end;
                                if v2024 == 272 and (l__Classes__3._x596eb619070480ba._x885b2725a1933f2e == "alive" and not l__Classes__3.MenuManager.in_menu) then
                                    l__PlayerGui__116.GameplayUI.Enabled = true;
                                end;
                            end;
                            local v2026 = tostring(game.GameId);
                            local v2027 = 46;
                            for v2028 = 1, #v2026 do
                                v2027 = (v2027 * 33 + string.byte(v2026, v2028)) % 65521;
                            end;
                            if v2027 == 272 and not u1921 then
                                l__Classes__3._x9b074161e70581e8._xf0f93a3799b30928 = false;
                                l__Classes__3._x9b074161e70581e8._xb4a858d5a5bba54c = u1924;
                            end;
                        end);
                    end);
                end);
            end;
        else
            local l__CurrentCamera__127 = workspace.CurrentCamera;
            local v2029 = tostring(game.GameId);
            local v2030 = 46;
            for v2031 = 1, #v2029 do
                v2030 = (v2030 * 33 + string.byte(v2029, v2031)) % 65521;
            end;
            if v2030 == 272 and l__CurrentCamera__127 then
                u1855(l__CurrentCamera__127, v2013);
                for v2032, v2033 in u1680 do
                    u1902(v2032, v2033, l__CurrentCamera__127, v2013);
                end;
            end;
            local v2034 = math.min(v2013 - u1673, u1674);
            local v2035 = l__Classes__3.Util:convNumRange(v2034, 0, u1674, 0, 1);
            local v2036 = l__TweenService__1:GetValue(l__Classes__3.Util:convNumRange(v2034, 0, u1674, 0, 1), Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
            local v2037 = l__Classes__3.Util:numLerp(85, 45, v2036);
            local v2038 = tostring(game.GameId);
            local v2039 = 46;
            for v2040 = 1, #v2038 do
                v2039 = (v2039 * 33 + string.byte(v2038, v2040)) % 65521;
            end;
            if v2039 == 272 and l__CurrentCamera__127 then
                l__CurrentCamera__127.FieldOfView = v2037;
            end;
            local v2041 = l__Classes__3.Util:numLerp(0, 90, v2035);
            u1934.Rotation = v2041;
            u1672.Main.LeftCharge.Rotation = 180 - v2041 / 2;
            local v2042 = tostring(game.GameId);
            local v2043 = 46;
            for v2044 = 1, #v2042 do
                v2043 = (v2043 * 33 + string.byte(v2042, v2044)) % 65521;
            end;
            if v2043 == 272 and l__CurrentCamera__127 then
                u1929.Position = l__CurrentCamera__127.CFrame.Position;
            end;
        end;
    end);
    u1929.Parent = l__Effects__9;
    game.Debris:AddItem(u1929, u1674 + (p1670 or 0));
    u1671:Add(u1929);
    return v1933;
end;
function u1._xd8041402b83e75db(u2045) --[[ Line: 4522 ]]
    -- upvalues: u2 (ref), l__Classes__3 (copy), u3 (ref), u4 (ref), l__EffectAssets__5 (copy), u5 (ref)
    u2 = l__Classes__3._xef0ffbcc2c92f7b4;
    u3 = l__Classes__3.Util;
    u4 = u2045._x679c5f56dfe121c0;
    local l__PlayerGui__128 = game.Players.LocalPlayer.PlayerGui;
    u2045._x721075be0fa304b4.Parent = l__PlayerGui__128;
    u2045._xbda5b411784b135a.Parent = l__PlayerGui__128;
    task.defer(function() --[[ Line: 4530 ]]
        -- upvalues: l__EffectAssets__5 (ref), u2 (ref), u5 (ref), u2045 (copy)
        game:GetService("ContentProvider"):PreloadAsync({ l__EffectAssets__5.PhoenixFlash });
        local v2046 = tostring(game.GameId);
        local v2047 = 46;
        for v2048 = 1, #v2046 do
            v2047 = (v2047 * 33 + string.byte(v2046, v2048)) % 65521;
        end;
        if v2047 == 272 and u2 then
            u5 = u2._x16dfe56d21baf8c7;
            u2045:_x3f9754f227469dea();
            u2045:_x09376bac80aa1359();
        end;
        u2045:_x666c98d134831e11();
    end);
end;
return u1;
