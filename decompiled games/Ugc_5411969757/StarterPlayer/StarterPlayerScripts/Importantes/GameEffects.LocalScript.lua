-- Decompiled from: StarterPlayer.StarterPlayerScripts.Importantes.GameEffects
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local v2 = setmetatable({}, {
    __index = function(_, p1) --[[ Name: __index, Line 1 ]]
        return game:GetService(p1);
    end
});
local l__LocalPlayer__1 = v2.Players.LocalPlayer;
local u3 = l__LocalPlayer__1:GetMouse();
local l__ReplicatedStorage__2 = v2.ReplicatedStorage;
local v4 = Instance.new("BindableEvent");
v4.Name = "ButtonCircleEffectConnect";
v4.Parent = l__ReplicatedStorage__2;
local u5 = Instance.new("BindableEvent");
u5.Name = "SoundEffect";
u5.Parent = l__ReplicatedStorage__2;
local v6 = Instance.new("BindableEvent");
v6.Name = "MouseoverEffect";
v6.Parent = l__ReplicatedStorage__2;
local l__ImagenDecoracion__3 = script:WaitForChild("ImagenDecoracion");
local l__MouseoverUI__4 = script:WaitForChild("MouseoverUI");
local l__InfoLabel__5 = l__MouseoverUI__4:WaitForChild("InfoLabel");
local _ = v2.TweenService;
local l__TextService__6 = v2.TextService;
l__MouseoverUI__4.Parent = l__LocalPlayer__1:WaitForChild("PlayerGui", 300);
local function u8(p7) --[[ Line: 29 ]]
    if p7 == nil then
        return nil;
    end;
    local l__TweenService__7 = game:GetService("TweenService");
    l__TweenService__7:Create(p7, TweenInfo.new(1.5), {
        Size = UDim2.new(18, 0, 18, 0)
    }):Play();
    l__TweenService__7:Create(p7, TweenInfo.new(1.5), {
        ImageTransparency = 1
    }):Play();
    game:GetService("Debris"):AddItem(p7, 3);
end;
local function u13(p9, _, p10) --[[ Line: 50 ]]
    -- upvalues: l__InfoLabel__5 (copy), l__MouseoverUI__4 (copy), l__TextService__6 (copy), u3 (copy)
    if p9 == nil then
        return nil;
    end;
    l__InfoLabel__5.Visible = p9;
    if p9 == true then
        local v11 = l__TextService__6:GetTextSize(p10, l__MouseoverUI__4.AbsoluteSize.Y * 0.025, Enum.Font.SourceSans, Vector2.new(99999, 99999));
        local l__X__8 = v11.X;
        local l__Y__9 = v11.Y;
        local _ = l__InfoLabel__5.AbsolutePosition;
        l__InfoLabel__5.Size = UDim2.new(0, l__X__8, 0, l__Y__9);
        l__InfoLabel__5.Text = p10;
        local v12 = l__MouseoverUI__4.AbsoluteSize.X - l__InfoLabel__5.AbsoluteSize.X / 2;
        if u3.X <= l__X__8 / 2 then
            l__InfoLabel__5.Position = UDim2.new(0, 5 + l__X__8 / 2, 0, u3.Y - 15);
            return;
        end;
        if u3.X >= v12 - 5 then
            l__InfoLabel__5.Position = UDim2.new(0, v12 - 5, 0, u3.Y - 15);
            return;
        end;
        l__InfoLabel__5.Position = UDim2.new(0, u3.X, 0, u3.Y - 15);
    end;
end;
local function u17(p14, u15, u16) --[[ Line: 75 ]]
    -- upvalues: u13 (copy), l__InfoLabel__5 (copy)
    p14.MouseEnter:connect(function() --[[ Line: 76 ]]
        -- upvalues: u13 (ref), u15 (copy), u16 (copy)
        u13(true, u15, u16);
    end);
    p14.MouseMoved:connect(function() --[[ Line: 79 ]]
        -- upvalues: u13 (ref), u15 (copy), u16 (copy)
        u13(true, u15, u16);
    end);
    p14.MouseLeave:connect(function() --[[ Line: 82 ]]
        -- upvalues: l__InfoLabel__5 (ref)
        l__InfoLabel__5.Visible = false;
    end);
end;
v6.Event:connect(function(p18, p19, p20, p21) --[[ Line: 87 ]]
    -- upvalues: u17 (copy)
    if p18:lower() == "connect" then
        if p19 == nil then
            return nil;
        end;
        u17(p19, p20, p21);
    end;
end);
u5.Event:connect(function(p22) --[[ Line: 97 ]]
    local v23 = script:FindFirstChild((tostring(p22)));
    if v23 ~= nil and v23:IsA("Sound") then
        v23:Play();
    end;
end);
v4.Event:connect(function(u24, p25) --[[ Line: 106 ]]
    -- upvalues: l__ImagenDecoracion__3 (copy), u8 (copy), u5 (copy)
    if u24 ~= nil and (u24:IsA("TextButton") or u24:IsA("ImageButton")) then
        local u26 = p25 == nil and u24 and u24 or p25;
        u24.MouseButton1Down:connect(function(p27, p28) --[[ Line: 112 ]]
            -- upvalues: u24 (copy), l__ImagenDecoracion__3 (ref), u26 (copy), u8 (ref), u5 (ref)
            local v29 = p27 - u24.AbsolutePosition.X;
            local v30 = p28 - 35 - u24.AbsolutePosition.Y;
            local l__AbsoluteSize__10 = u24.AbsoluteSize;
            local v31 = math.abs(v29) / l__AbsoluteSize__10.X;
            local v32 = math.abs(v30) / l__AbsoluteSize__10.Y;
            local v33 = l__ImagenDecoracion__3:clone();
            v33.Position = UDim2.new(v31, 0, v32, 0);
            v33.Parent = u26;
            u8(v33);
            u5:Fire("ClickSound");
        end);
    end;
end);
