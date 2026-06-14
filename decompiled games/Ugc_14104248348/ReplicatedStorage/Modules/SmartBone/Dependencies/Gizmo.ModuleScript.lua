-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
local l__Terrain__3 = workspace:WaitForChild("Terrain");
local l__Terrain__4 = workspace:WaitForChild("Terrain");
assert(l__Terrain__3, "No terrain object found under workspace");
assert(l__Terrain__4, "No target parent found.");
local u1 = l__Terrain__4:FindFirstChild("AOTGizmoAdornment");
local u2 = l__Terrain__4:FindFirstChild("GizmoAdornment");
if not u1 then
    u1 = Instance.new("WireframeHandleAdornment");
    u1.Adornee = nil;
    u1.ZIndex = 1;
    u1.AlwaysOnTop = false;
    u1.Name = "AOTGizmoAdornment";
    u1.Parent = l__Terrain__4;
end;
if not u2 then
    u2 = Instance.new("WireframeHandleAdornment");
    u2.Adornee = nil;
    u2.ZIndex = 1;
    u2.AlwaysOnTop = false;
    u2.Name = "GizmoAdornment";
    u2.Parent = l__Terrain__4;
end;
local l__Gizmos__5 = script:WaitForChild("Gizmos");
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = {
    AlwaysOnTop = true,
    Transparency = 0,
    Color3 = Color3.fromRGB(13, 105, 172)
};
local u8 = {};
local u9 = false;
local function v11(p10) --[[ Line: 50 ]]
    -- upvalues: l__Terrain__4 (copy), u3 (ref)
    p10.Parent = l__Terrain__4;
    table.insert(u3, p10);
end;
local function u17(p12) --[[ Line: 84 ]]
    -- upvalues: u17 (copy)
    local v13 = {};
    for v14, v16 in pairs(p12) do
        if type(v16) == "table" then
            local v16 = u17(v16);
        end;
        v13[v14] = v16;
    end;
    return v13;
end;
local u23 = {
    Enabled = false,
    ActiveRays = 0,
    ActiveInstances = 0,
    Styles = {
        Color = "Color3",
        Transparency = "Transparency",
        AlwaysOnTop = "AlwaysOnTop"
    },
    AOTWireframeHandle = u1,
    WireframeHandle = u2,
    GetPoolSize = function() --[[ Name: GetPoolSize, Line 498 ]]
        -- upvalues: u8 (copy)
        local v18 = 0;
        for _, v19 in u8 do
            v18 = v18 + #v19;
        end;
        return v18;
    end,
    PushProperty = function(u20, u21) --[[ Name: PushProperty, Line 513 ]]
        -- upvalues: u7 (copy), u1 (ref), u2 (ref)
        u7[u20] = u21;
        if u20 == "AlwaysOnTop" then
        else
            pcall(function() --[[ Line: 520 ]]
                -- upvalues: u1 (ref), u20 (copy), u21 (copy), u2 (ref)
                u1[u20] = u21;
                u2[u20] = u21;
            end);
        end;
    end,
    PopProperty = function(p22) --[[ Name: PopProperty, Line 531 ]]
        -- upvalues: u7 (copy), u1 (ref)
        if u7[p22] then
            return u7[p22];
        else
            return u1[p22];
        end;
    end
};
function u23.SetStyle(p24, p25, p26) --[[ Line: 545 ]]
    -- upvalues: u23 (copy)
    if p24 ~= nil and typeof(p24) == "Color3" then
        u23.PushProperty("Color3", p24);
    end;
    if p25 ~= nil and typeof(p25) == "number" then
        u23.PushProperty("Transparency", p25);
    end;
    if p26 ~= nil and typeof(p26) == "boolean" then
        u23.PushProperty("AlwaysOnTop", p26);
    end;
end;
function u23.DoCleaning() --[[ Line: 561 ]]
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u8 (copy), u23 (copy)
    u1:Clear();
    u2:Clear();
    for _, v27 in u3 do
        local l__ClassName__6 = v27.ClassName;
        if not u8[l__ClassName__6] then
            u8[l__ClassName__6] = {};
        end;
        v27:Remove();
        table.insert(u8[l__ClassName__6], v27);
    end;
    u3 = {};
    u23.ActiveRays = 0;
    u23.ActiveInstances = 0;
end;
function u23.ScheduleCleaning() --[[ Line: 577 ]]
    -- upvalues: u9 (ref), u23 (copy)
    if u9 then
    else
        u9 = true;
        task.delay(0, function() --[[ Line: 584 ]]
            -- upvalues: u23 (ref), u9 (ref)
            u23.DoCleaning();
            u9 = false;
        end);
    end;
end;
function u23.AddDebrisInSeconds(p28, p29) --[[ Line: 596 ]]
    -- upvalues: u5 (copy)
    local v30 = u5;
    local v31 = {
        "Seconds",
        p28,
        os.clock(),
        p29
    };
    table.insert(v30, v31);
end;
function u23.AddDebrisInFrames(p32, p33) --[[ Line: 605 ]]
    -- upvalues: u5 (copy)
    table.insert(u5, {
        "Frames",
        p32,
        0,
        p33
    });
end;
function u23.TweenProperties(p34, p35, p36) --[[ Line: 616 ]]
    -- upvalues: u17 (copy), u6 (copy)
    local u37 = {
        Time = 0,
        p_Properties = p34,
        Properties = u17(p34),
        Goal = p35,
        TweenInfo = p36
    };
    u6[u37] = true;
    return function() --[[ Line: 630 ]]
        -- upvalues: u6 (ref), u37 (copy)
        u6[u37] = nil;
    end;
end;
function u23.Init() --[[ Line: 637 ]]
    -- upvalues: l__RunService__1 (copy), u6 (copy), l__TweenService__2 (copy), u5 (copy), u4 (copy)
    l__RunService__1.RenderStepped:Connect(function(p38) --[[ Line: 638 ]]
        -- upvalues: u6 (ref), l__TweenService__2 (ref), u5 (ref), u4 (ref)
        for v39 in u6 do
            v39.Time = v39.Time + p38;
            local v40 = v39.Time / v39.TweenInfo.Time;
            local v41 = v40 > 1 and 1 or v40;
            for v42, v43 in v39.Properties do
                if v39.Goal[v42] then
                    local v44 = l__TweenService__2:GetValue(v41, v39.TweenInfo.EasingStyle, v39.TweenInfo.EasingDirection);
                    local v45 = v39.Goal[v42];
                    local v46;
                    if type(v43) == "number" then
                        v46 = v43 + (v45 - v43) * v44;
                    else
                        v46 = v43:Lerp(v45, v44);
                    end;
                    v39.p_Properties[v42] = v46;
                end;
            end;
            if v41 == 1 then
                u6[v39] = nil;
            end;
        end;
        for v47 = #u5, 1, -1 do
            local v48 = u5[v47];
            local v49 = v48[1];
            local v50 = v48[2];
            local v51 = v48[3];
            local v52 = v48[4];
            if v49 == "Seconds" then
                if v50 < os.clock() - v51 then
                    table.remove(u5, v47);
                else
                    v52();
                end;
            elseif v50 < v51 then
                table.remove(u5, v47);
            else
                v48[2] = v48[2] + 1;
                v52();
            end;
        end;
        for v53 = #u4, 1, -1 do
            local v54 = u4[v53];
            local v55 = v54[2];
            if v55.Enabled then
                if v55.Destroy then
                    table.remove(u4, v53);
                end;
                v54[1]:Update(v55);
            end;
        end;
    end);
end;
function u23.SetEnabled(p56) --[[ Line: 719 ]]
    -- upvalues: u23 (copy)
    u23.Enabled = p56;
    if p56 == false then
        u23.DoCleaning();
    end;
end;
function u23.RemoveAdornments() --[[ Line: 730 ]]
    -- upvalues: l__Terrain__4 (copy)
    if l__Terrain__4:FindFirstChild("AOTGizmoAdornment") then
        l__Terrain__4:FindFirstChild("AOTGizmoAdornment"):Destroy();
    end;
    if l__Terrain__4:FindFirstChild("GizmoAdornment") then
        l__Terrain__4:FindFirstChild("GizmoAdornment"):Destroy();
    end;
end;
local function v58(p57) --[[ Line: 66 ]]
    -- upvalues: u8 (copy)
    if u8[p57] then
        return table.remove(u8[p57]) or Instance.new(p57);
    else
        return Instance.new(p57);
    end;
end;
local function v60(p59) --[[ Line: 55 ]]
    -- upvalues: u8 (copy)
    local l__ClassName__7 = p59.ClassName;
    if not u8[l__ClassName__7] then
        u8[l__ClassName__7] = {};
    end;
    p59:Remove();
    table.insert(u8[l__ClassName__7], p59);
end;
local function v63(p61, p62) --[[ Line: 46 ]]
    -- upvalues: u4 (copy)
    table.insert(u4, { p61, p62 });
end;
for _, v64 in l__Gizmos__5:GetChildren() do
    u23[v64.Name] = require(v64).Init(u23, u7, v58, v60, v63, v11);
end;
return u23;
