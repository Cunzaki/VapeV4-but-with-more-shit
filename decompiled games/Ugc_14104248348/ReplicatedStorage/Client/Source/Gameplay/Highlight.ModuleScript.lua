-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Highlight
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
game:GetService("Debris");
local u3 = {
    Location = script.Instances,
    Humanoid = {},
    Prototype = {
        Position = 0,
        AdorneeAll = true,
        ClearLast = true,
        DoesFlash = true,
        HasOutline = true,
        Color = Color3.new(0.670588, 0.545098, 0.0509804),
        OutlineColor = Color3.new(1, 1, 1),
        PulseTween = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true)
    },
    getBaseHumanoid = function() --[[ Name: getBaseHumanoid, Line 31 ]]
        local v1 = Instance.new("Humanoid");
        v1.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        v1.PlatformStand = true;
        for _, v2 in Enum.HumanoidStateType:GetEnumItems() do
            v1:SetStateEnabled(v2, false);
        end;
        return v1;
    end
};
function u3.Prototype.HighlightModel(p4, p5) --[[ Line: 41 ]]
    -- upvalues: u3 (copy)
    local v6 = p5:GetAttribute("__TransparentHighlight");
    if v6 == nil then
        v6 = false;
        for _, v7 in p5:GetDescendants() do
            if v7:IsA("BasePart") and 1 - (1 - v7.Transparency) * (1 - v7.LocalTransparencyModifier) > 0 then
                v6 = true;
                break;
            end;
        end;
        local v8 = p5:FindFirstChildOfClass("Animator", true);
        if p5:FindFirstChildOfClass("Humanoid", true) or v8 then
            v6 = false;
        end;
        p5:SetAttribute("__TransparentHighlight", v6);
    end;
    if v6 and not p4.HumanoidActive[p5] then
        local v9 = nil;
        for _, v10 in ipairs(p4.Humanoids) do
            if v10.Ready then
                v9 = v10.Humanoid;
                v10.Model = p5;
                v10.Ready = false;
                break;
            end;
        end;
        if not v9 then
            v9 = u3.getBaseHumanoid();
            table.insert(p4.Humanoids, {
                Ready = false,
                Humanoid = v9
            });
        end;
        p4.HumanoidActive[p5] = v9;
        v9.Parent = p5;
    end;
end;
function u3.Prototype.__CreateHighlight(p11) --[[ Line: 89 ]]
    -- upvalues: u3 (copy), l__TweenService__1 (copy)
    local v12 = Instance.new("Highlight");
    v12.OutlineColor = p11.OutlineColor;
    v12.OutlineTransparency = p11.HasOutline and 0.5 or 1;
    v12.FillColor = p11.Color;
    v12.FillTransparency = 1;
    v12.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    v12.Parent = u3.Location;
    if p11.DoesFlash then
        l__TweenService__1:Create(v12, p11.PulseTween, {
            FillTransparency = 0.5
        }):Play();
        return v12;
    else
        v12.FillTransparency = 0.5;
        return v12;
    end;
end;
function u3.Prototype.GetNext(u13) --[[ Line: 111 ]]
    debug.profilebegin("Highlight :: GetNext");
    u13.Position = u13.Position + 1;
    u13.Items[u13.Position] = u13.Items[u13.Position] or u13:__CreateHighlight();
    local function u17(u14, p15) --[[ Line: 117 ]]
        -- upvalues: u13 (copy), u17 (ref)
        if p15 and p15.Parent ~= nil then
            u14.Parent = p15;
        end;
        u14.Destroying:Connect(function() --[[ Line: 119 ]]
            -- upvalues: u13 (ref), u14 (copy), u17 (ref)
            local v16 = u13.Indicated[u14];
            u17(u13:__CreateHighlight(), v16);
        end);
    end;
    local v18 = u13.Items[u13.Position];
    u17(v18);
    debug.profileend();
    return v18;
end;
function u3.Prototype.Refresh(p19) --[[ Line: 132 ]]
    for _, v20 in p19.Items do
        v20.OutlineColor = p19.OutlineColor;
        v20.OutlineTransparency = p19.HasOutline and 0.5 or 1;
        v20.FillColor = p19.Color;
    end;
end;
function u3.Prototype.Set(p21, p22) --[[ Line: 140 ]]
    -- upvalues: u3 (copy)
    debug.profilebegin("Highlight :: Set");
    if typeof(p22) == "table" then
        if next(p22) then
            for _, v23 in p22 do
                p21:Set(v23);
            end;
        end;
        return debug.profileend();
    end;
    if not p22 then
        return debug.profileend();
    end;
    if p21.Indicated[p22] then
        return debug.profileend();
    end;
    local v24 = p21:GetNext();
    if p21.AdorneeAll or p22:IsA("BasePart") then
        if p21.ClearLast then
            p21:Clear();
        end;
        v24.Parent = u3.Location;
        v24.Adornee = p22;
    else
        if not p22:IsA("Model") then
            warn((`Impossible highlight instance type:{typeof(p22) == "Instance" and p22.ClassName or typeof(p22)}`));
            return debug.profileend();
        end;
        if p21.ClearLast then
            p21:Clear();
        end;
        v24.Parent = p22;
        v24.Adornee = nil;
    end;
    if p22:IsA("Model") then
        p21:HighlightModel(p22);
    end;
    p21.Indicated[p22] = v24;
    p21.Indicated[v24] = p22;
    debug.profileend();
end;
function u3.Prototype.Clear(u25) --[[ Line: 181 ]]
    -- upvalues: u3 (copy)
    debug.profilebegin("Highlight :: Clear");
    u25.Position = 0;
    u25.Indicated = {};
    if u25.__lastHumanoidParenting and coroutine.status(u25.__lastHumanoidParenting) == "suspended" then
        task.cancel(u25.__lastHumanoidParenting);
        u25.__lastHumanoidParenting = nil;
    end;
    u25.__lastHumanoidParenting = task.delay(25, function() --[[ Line: 192 ]]
        -- upvalues: u25 (copy)
        for _, v26 in u25.Humanoids do
            v26.Humanoid.Parent = nil;
            v26.Ready = true;
        end;
        u25.HumanoidActive = {};
    end);
    for _, v27 in u25.Items do
        v27.Adornee = nil;
        v27.Parent = u3.Location;
    end;
    debug.profileend();
end;
function u3.Prototype.Expire(u28, p29) --[[ Line: 208 ]]
    local u30 = os.clock();
    u28.ExpiringHeader = u30;
    task.delay(p29, function() --[[ Line: 211 ]]
        -- upvalues: u28 (copy), u30 (copy)
        if u28.ExpiringHeader == u30 then
            u28:Clear();
        end;
    end);
end;
function u3.newSet(p31) --[[ Line: 218 ]]
    -- upvalues: u3 (copy)
    local v32 = setmetatable(p31 or {}, {
        __index = u3.Prototype
    });
    v32.Items = {};
    v32.Indicated = {};
    v32.Humanoids = {};
    v32.HumanoidActive = {};
    return v32;
end;
return u3;
