-- Decompiled from: StarterGui.FTHUD.Notifys.Server_notificaciones.Controlador.Big_framebase.BackgroundChange
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__UIListLayout__1 = script.Parent:WaitForChild("Contain"):WaitForChild("UIListLayout");
local l__Fondo__2 = script.Parent:WaitForChild("Fondo");
l__UIListLayout__1:GetPropertyChangedSignal("AbsoluteContentSize"):connect(function() --[[ Line: 9 ]]
    -- upvalues: l__Fondo__2 (copy), l__UIListLayout__1 (copy)
    l__Fondo__2.Size = UDim2.new(0, l__UIListLayout__1.AbsoluteContentSize.X + 14, 1, 0);
end);
l__Fondo__2.Size = UDim2.new(0, l__UIListLayout__1.AbsoluteContentSize.X + 14, 1, 0);
