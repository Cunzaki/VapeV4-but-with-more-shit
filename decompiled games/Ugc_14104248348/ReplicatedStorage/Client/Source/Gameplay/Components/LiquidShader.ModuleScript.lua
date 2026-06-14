-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.LiquidShader
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__AssetService__2 = game:GetService("AssetService");
game:GetService("RunService");
local _ = game:GetService("Players").LocalPlayer;
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__3:Get("InterfaceHandler");
local u2 = l__Mince__3.Component({
    Tag = "LiquidShader",
    Range = 3,
    Resolution = 16
});
local u3 = {};
function u3.new(p4, p5, p6, p7, p8) --[[ Line: 21 ]]
    -- upvalues: u3 (copy)
    local v9 = {
        position = 0,
        velocity = 0,
        mass = p4 or 1,
        damping = p5 or 0.8,
        stiffness = p6 or 0.2,
        maxDistance = p7 or 1,
        maxVelocity = p8 or 5
    };
    setmetatable(v9, {
        __index = u3
    });
    return v9;
end;
function u3.push(p10, p11) --[[ Line: 37 ]]
    p10.velocity = p10.velocity + p11 / p10.mass;
end;
function u3.update(p12, p13) --[[ Line: 42 ]]
    local v14 = p13 or 1;
    p12.velocity = p12.velocity + (-p12.velocity * p12.damping + -p12.position * p12.stiffness) / p12.mass * v14;
    local v15 = -p12.maxVelocity;
    local v16 = math.min(p12.maxVelocity, p12.velocity);
    p12.velocity = math.max(v15, v16);
    p12.position = p12.position + p12.velocity * v14;
    local v17 = -p12.maxDistance;
    local v18 = math.min(p12.maxDistance, p12.position);
    p12.position = math.max(v17, v18);
    p12.velocity = p12.velocity * 0.99;
end;
function u2.IsPointInPolygon(p19, p20, p21) --[[ Line: 64 ]]
    local v22 = #p19;
    local v23 = false;
    for v24 = 1, #p19 do
        local l__X__4 = p19[v24].X;
        local l__Y__5 = p19[v24].Y;
        local l__X__6 = p19[v22].X;
        local l__Y__7 = p19[v22].Y;
        local v25;
        if p21 < l__Y__5 == (p21 < l__Y__7) then
            v25 = false;
        else
            v25 = p20 < (l__X__6 - l__X__4) * (p21 - l__Y__5) / (l__Y__7 - l__Y__5) + l__X__4;
        end;
        if v25 then
            v23 = not v23;
        end;
        v22 = v24;
    end;
    return v23;
end;
function u2.UpdatePosition(p26) --[[ Line: 83 ]]
    -- upvalues: u2 (copy)
    local v27 = Color3.new(1, 1, 1);
    local l__Size__8 = p26.EditableImage.Size;
    local l__X__9 = l__Size__8.X;
    local l__Y__10 = l__Size__8.Y;
    local v28 = p26.Alpha * (l__Y__10 * p26.Sway);
    local v29 = p26.Height * l__Size__8.Y;
    p26.Instance:SetAttribute("Partial", v28);
    local v30 = Vector2.new(l__X__9 * 0, v29);
    local v31 = Vector2.new(l__X__9 * 0.25, v29 + v28);
    local v32 = Vector2.new(l__X__9 * 0.5, v29);
    local v33 = Vector2.new(l__X__9 * 0.75, v29 - v28);
    local v34 = Vector2.new(l__X__9 * 1, v29);
    local v35 = {
        Vector2.new(l__X__9 * 0, l__Y__10),
        v30,
        v31,
        v32,
        v33,
        v34,
        (Vector2.new(l__X__9 * 1, l__Y__10))
    };
    p26.EditableImage:DrawRectangle(Vector2.zero, p26.EditableImage.Size, Color3.new(0, 255, 0), 1, Enum.ImageCombineType.Overwrite);
    for v36 = 0, l__X__9 - 1 do
        for v37 = 0, l__Y__10 - 1 do
            if u2.IsPointInPolygon(v35, (v36 + p26.Delta * l__X__9) % l__X__9, v37) then
                p26.EditableImage:DrawRectangle(Vector2.new(v36, v37), Vector2.one, v27, 0);
            end;
        end;
    end;
    if p26.EditableImagePreview then
        p26.EditableImagePreview:DrawImage(Vector2.zero, p26.EditableImage, Enum.ImageCombineType.Overwrite);
    end;
end;
function u2.Update(p38, p39) --[[ Line: 123 ]]
    -- upvalues: u2 (copy)
    if p38.Instance:IsDescendantOf(game.Workspace) then
        if p38.LastPosition then
            local v40 = p38.LastPosition:Dot(p38.Instance.Position);
            if p38.LastDot then
                local v41 = math.abs(v40 - p38.LastDot) / p38.TurningEffector;
                p38.Velocity = p38.Velocity + v41 * p39;
            end;
            p38.LastDot = v40;
        end;
        p38.Velocity = p38.Velocity * (1 - math.min(0.9, p38.Friction * p39));
        p38.Delta = p38.Delta + p38.Velocity * p39;
        p38.Spring:push(p38.Instance.AssemblyLinearVelocity.X * p38.VelocityInfluence);
        p38.Spring:update(p39);
        p38.Delta = p38.Delta % 1;
        p38.Alpha = math.clamp(p38.Spring.position, -1, 1);
        if p38.Alpha ~= p38.Alpha then
            p38.Alpha = 0;
        end;
        p38.Instance:SetAttribute("Velocity", p38.Velocity);
        p38.Instance:SetAttribute("Alpha", p38.Alpha);
        p38.Instance:SetAttribute("Delta", p38.Delta);
        p38.LastPosition = p38.Instance.Position;
        u2.UpdatePosition(p38);
    end;
end;
function u2.Destroyed(p42) --[[ Line: 158 ]]
    p42.EditableImagePreview:Destroy();
    p42.Dead = nil;
end;
function u2.Construct(u43) --[[ Line: 165 ]]
    -- upvalues: u1 (copy), u3 (copy), l__AssetService__2 (copy), u2 (copy)
    u1.GetScreenGui("Shaders");
    u43.TimeElapsed = 0;
    u43.Delta = 0;
    u43.Alpha = 0;
    u43.Height = 0.5;
    u43.Sway = 0.5;
    u43.VelocityInfluence = 0.05;
    u43.Spring = u3.new(0.02, 0.05, 4);
    u43.Velocity = 0;
    u43.Friction = 8;
    u43.TurningEffector = 6;
    local v44 = l__AssetService__2:CreateEditableImage({
        Size = Vector2.one * u2.Resolution
    });
    local v45 = Content.fromObject(v44);
    u43.Instance.TextureContent = v45;
    u43.EditableImage = v44;
    u43.UpdateThread = task.spawn(function() --[[ Line: 190 ]]
        -- upvalues: u43 (copy), u2 (ref)
        while not u43.Dead do
            local _, _ = pcall(u2.Update, u43, task.wait());
            if not u43 or u43.Dead then
                coroutine.yield();
            end;
        end;
    end);
end;
function u2.Setup() --[[ Line: 198 ]] end;
return u2;
