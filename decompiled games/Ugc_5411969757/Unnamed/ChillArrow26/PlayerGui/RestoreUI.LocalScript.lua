-- Decompiled from: .ChillArrow26.PlayerGui.RestoreUI
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__ContextActionService__2 = game:GetService("ContextActionService");
for _, v1 in pairs({
    "Wolfram_Sprint",
    "Wolfram_Crouch",
    "Wolfram_GunFire",
    "Wolfram_GunReload",
    "Wolfram_Charge",
    "Wolfram_Salute"
}) do
    l__ContextActionService__2:UnbindAction(v1);
end;
l__LocalPlayer__1:GetMouse().Icon = "";
game:GetService("UserInputService").MouseIconEnabled = true;
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false);
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true);
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, true);
game:GetService("ContextActionService"):UnbindAction("Reload");
wait();
local l__CurrentCamera__3 = workspace.CurrentCamera;
for _, v2 in pairs(l__CurrentCamera__3:GetDescendants()) do
    if v2.Name:find("Blur") or v2.Name:find("Color") then
        v2:Destroy();
        l__CurrentCamera__3.FieldOfView = 70;
        l__CurrentCamera__3.CameraType = Enum.CameraType.Custom;
    end;
    l__CurrentCamera__3.FieldOfView = 70;
    l__CurrentCamera__3.CameraType = Enum.CameraType.Custom;
end;
