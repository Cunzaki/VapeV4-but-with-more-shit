-- Decompiled from: .FTPStorage.UI.Gamemodes.GamemodesController.FrameBase.3.ObjectImage.Image
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__Parent__1 = script.Parent;
local l__Borrar__2 = l__Parent__1:WaitForChild("Borrar");
function Actualizar_status()
    -- upvalues: l__Parent__1 (copy), l__Borrar__2 (copy)
    wait();
    if l__Parent__1.IsLoaded == true then
        l__Borrar__2.Visible = false;
    else
        l__Borrar__2.Visible = true;
    end;
end;
l__Parent__1:GetPropertyChangedSignal("IsLoaded"):connect(function() --[[ Line: 14 ]]
    Actualizar_status();
end);
Actualizar_status();
