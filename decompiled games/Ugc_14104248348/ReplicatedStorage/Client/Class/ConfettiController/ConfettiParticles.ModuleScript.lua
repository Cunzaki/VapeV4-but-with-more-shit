-- Decompiled from: ReplicatedStorage.Client.Class.ConfettiController.ConfettiParticles
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__CurrentCamera__1 = game:GetService("Workspace").CurrentCamera;
local u1 = { script:WaitForChild("CircularConfetti"), script:WaitForChild("SquareConfetti") };
local u2 = {
    Color3.fromRGB(168, 100, 253),
    Color3.fromRGB(41, 205, 255),
    Color3.fromRGB(120, 255, 68),
    Color3.fromRGB(255, 113, 141),
    Color3.fromRGB(253, 255, 106)
};
local u3 = {};
u3.__index = u3;
local u4 = Vector2.new(0, 1);
function u3.setGravity(p5) --[[ Line: 14 ]]
    -- upvalues: u4 (ref)
    u4 = p5;
end;
function u3.createParticle(p6, p7, p8, p9) --[[ Line: 18 ]]
    -- upvalues: u3 (copy), u2 (ref), u1 (copy)
    local v10 = {};
    setmetatable(v10, u3);
    u2 = p9;
    local l__X__2 = p7.X;
    if l__X__2 < 0 then
        l__X__2 = l__X__2 * -1;
    end;
    local v11 = Vector2.new(p7.X, p7.Y + (0 - l__X__2) * 0.75);
    if p9 == nil then
        p9 = u2;
    end;
    v10.EmitterPosition = p6;
    v10.EmitterPower = v11;
    v10.Position = Vector2.new(0, 0);
    v10.Power = v11;
    v10.Color = p9[math.random(#p9)];
    local v12 = u1[math.random(#u1)]:Clone();
    v12.ImageColor3 = v10.Color;
    v12.Parent = p8;
    v12.Rotation = math.random(360);
    v12.Visible = true;
    v12.ZIndex = 20;
    v10.Label = v12;
    v10.DefaultSize = 30;
    v10.Size = 1;
    v10.Side = -1;
    v10.OutOfBounds = false;
    v10.Enabled = false;
    v10.Cycles = 0;
    return v10;
end;
function u3.Update(p13, _) --[[ Line: 50 ]]
    -- upvalues: u2 (ref), u4 (ref), l__CurrentCamera__1 (copy)
    if p13.Enabled and p13.OutOfBounds then
        p13.Label.ImageColor3 = p13.Color;
        p13.Position = Vector2.new(0, 0);
        p13.Power = Vector2.new(p13.EmitterPower.X + math.random(10) - 5, p13.EmitterPower.Y + math.random(10) - 5);
        p13.Cycles = p13.Cycles + 1;
    end;
    if (p13.Enabled or not p13.OutOfBounds) and (p13.Enabled or p13.Cycles ~= 0) then
        p13.Label.Visible = true;
        local l__EmitterPosition__3 = p13.EmitterPosition;
        local l__Position__4 = p13.Position;
        local l__Power__5 = p13.Power;
        local l__Label__6 = p13.Label;
        if l__Label__6 then
            local v14 = Vector2.new(l__Position__4.X - l__Power__5.X, l__Position__4.Y - l__Power__5.Y);
            local v15 = Vector2.new(l__Power__5.X / 1.09 - u4.X, l__Power__5.Y / 1.1 - u4.Y);
            local l__ViewportSize__7 = l__CurrentCamera__1.ViewportSize;
            l__Label__6.Position = UDim2.new(l__EmitterPosition__3.X, v14.X, l__EmitterPosition__3.Y, v14.Y);
            local v16;
            if l__Label__6.AbsolutePosition.X > l__ViewportSize__7.X and u4.X > 0 or (l__Label__6.AbsolutePosition.Y > l__ViewportSize__7.Y and u4.Y > 0 or l__Label__6.AbsolutePosition.X < 0 and u4.X < 0) then
                v16 = true;
            elseif l__Label__6.AbsolutePosition.Y < 0 then
                v16 = u4.Y < 0;
            else
                v16 = false;
            end;
            p13.OutOfBounds = v16;
            p13.Position = v14;
            p13.Power = v15;
            if v15.Y < 0 then
                if p13.Size <= 0 then
                    p13.Side = 1;
                    l__Label__6.ImageColor3 = p13.Color;
                end;
                if p13.Size >= p13.DefaultSize then
                    p13.Side = -1;
                    l__Label__6.ImageColor3 = Color3.new(p13.Color.r * 0.65, p13.Color.g * 0.65, p13.Color.b * 0.65);
                end;
                p13.Size = p13.Size + p13.Side * 2;
                l__Label__6.Size = UDim2.new(0, p13.DefaultSize, 0, p13.Size);
            end;
        end;
    else
        p13.Label.Visible = false;
        p13.OutOfBounds = true;
        p13.Color = u2[math.random(#u2)];
    end;
end;
function u3.Toggle(p17) --[[ Line: 98 ]]
    p17.Enabled = not p17.Enabled;
end;
function u3.SetColors(p18, p19) --[[ Line: 102 ]]
    -- upvalues: u2 (ref)
    u2 = p19;
    p18.Color = u2[math.random(#u2)];
end;
return u3;
