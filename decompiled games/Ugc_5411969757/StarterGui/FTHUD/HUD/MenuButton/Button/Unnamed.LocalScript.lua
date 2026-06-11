-- Decompiled from: StarterGui.FTHUD.HUD.MenuButton.Button.
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__Decoracion__1 = script.Parent:WaitForChild("Decoracion");
local l__Parent__2 = script.Parent;
l__Parent__2.MouseEnter:connect(function() --[[ Line: 4 ]]
    -- upvalues: l__Decoracion__1 (copy)
    l__Decoracion__1.Visible = true;
end);
l__Parent__2.MouseLeave:connect(function() --[[ Line: 8 ]]
    -- upvalues: l__Decoracion__1 (copy)
    l__Decoracion__1.Visible = false;
end);
l__Parent__2.MouseMoved:connect(function() --[[ Line: 12 ]]
    -- upvalues: l__Decoracion__1 (copy)
    l__Decoracion__1.Visible = true;
end);
