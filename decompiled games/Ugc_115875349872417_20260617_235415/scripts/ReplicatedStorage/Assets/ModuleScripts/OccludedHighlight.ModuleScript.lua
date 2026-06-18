-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.OccludedHighlight
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__Workspace__2 = game:GetService("Workspace");
local u1 = Color3.fromRGB(255, 255, 255);
local u2 = Color3.fromRGB(255, 255, 255);
local u3 = {};
u3.__index = u3;
local function u7(p4) --[[ Line: 16 ]]
    if p4:IsA("BasePart") then
        local l__Size__3 = p4.Size;
        return { p4.Position, p4.Position + Vector3.new(0, l__Size__3.Y / 2, 0), p4.Position - Vector3.new(0, l__Size__3.Y / 2, 0) };
    end;
    if not p4:IsA("Model") then
        return {};
    end;
    local v5, v6 = p4:GetBoundingBox();
    return { v5.Position, v5.Position + Vector3.new(0, v6.Y / 2, 0), v5.Position - Vector3.new(0, v6.Y / 2, 0) };
end;
function u3.new(p8, p9) --[[ Line: 35 ]]
    -- upvalues: u1 (copy), u2 (copy), u3 (copy)
    local v10 = p8:IsA("Model") or p8:IsA("BasePart");
    assert(v10, "Adornee must be Model or BasePart");
    local v11 = p9 or {};
    local v12 = Instance.new("Highlight");
    v12.Adornee = p8;
    v12.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    v12.FillColor = v11.FillColor or u1;
    v12.FillTransparency = v11.FillTransparency or 0.5;
    v12.OutlineColor = v11.OutlineColor or u2;
    v12.OutlineTransparency = v11.OutlineTransparency or 0;
    v12.Enabled = false;
    v12.Parent = p8;
    local v13 = setmetatable({
        _elapsed = 0,
        _adornee = p8,
        _highlight = v12,
        _interval = v11.CheckInterval or 0.05
    }, u3);
    v13:_start();
    return v13;
end;
function u3._isOccluded(p14) --[[ Line: 60 ]]
    -- upvalues: l__Workspace__2 (copy), u7 (copy)
    local l__CurrentCamera__4 = l__Workspace__2.CurrentCamera;
    if not l__CurrentCamera__4 then
        return false;
    end;
    local l__Position__5 = l__CurrentCamera__4.CFrame.Position;
    local v15 = RaycastParams.new();
    v15.FilterType = Enum.RaycastFilterType.Include;
    v15.FilterDescendantsInstances = { workspace.Map };
    for _, v16 in ipairs((u7(p14._adornee))) do
        if not l__Workspace__2:Raycast(l__Position__5, v16 - l__Position__5, v15) then
            return false;
        end;
    end;
    return true;
end;
function u3._start(u17) --[[ Line: 81 ]]
    -- upvalues: l__RunService__1 (copy)
    u17._conn = l__RunService__1.RenderStepped:Connect(function(p18) --[[ Line: 82 ]]
        -- upvalues: u17 (copy)
        if u17._adornee.Parent then
            local v19 = u17;
            v19._elapsed = v19._elapsed + p18;
            if u17._elapsed < u17._interval then
            else
                u17._elapsed = 0;
                u17._highlight.Enabled = u17:_isOccluded();
            end;
        else
            u17:destroy();
        end;
    end);
end;
function u3.destroy(p20) --[[ Line: 98 ]]
    if p20._conn then
        p20._conn:Disconnect();
    end;
    if p20._highlight then
        p20._highlight:Destroy();
    end;
end;
return u3;
