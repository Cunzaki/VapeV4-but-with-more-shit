-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Special.Tools.LunarNewYear.WrittenNewYearNoteGear
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("MarketplaceService");
game:GetService("CollectionService");
game:GetService("TweenService");
local _ = game:GetService("Players").LocalPlayer;
game.Players.LocalPlayer:GetMouse();
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
l__Mince__2:Get("Notices");
l__Mince__2:Get("Locomotion");
local u1 = l__Mince__2:Get("ToolHandler");
l__Mince__2:Get("SelectInteractor");
local u2 = l__Mince__2:Get("InterfaceHandler");
l__Mince__2:Get("SelectInteractor");
local u3 = {
    Tags = { "WrittenNewYearNoteGear" },
    Animations = {}
};
function u3.Equipped(p4) --[[ Line: 25 ]]
    -- upvalues: l__Mince__2 (copy), u3 (copy)
    if l__Mince__2.Config.Humanoid then
        local l__Tool__3 = p4.Tool;
        u3.ToolActive = true;
        u3.CurrentTool = l__Tool__3;
        u3.UI.Main.Visible = true;
        u3.UI.Main.Creator.Note.MainBody.Text = l__Tool__3:GetAttribute("Text");
    end;
end;
function u3.Unequipped(_) --[[ Line: 36 ]]
    -- upvalues: u3 (copy)
    u3.ToolActive = false;
    u3.HoldingOut = false;
    u3.UI.Main.Visible = false;
end;
function u3.Setup() --[[ Line: 42 ]]
    -- upvalues: u3 (copy), u2 (copy), u1 (copy)
    u3.UI = u2.GetScreenGui("ReadNewYearNoteUI");
    u1.Component(u3);
end;
return u3;
