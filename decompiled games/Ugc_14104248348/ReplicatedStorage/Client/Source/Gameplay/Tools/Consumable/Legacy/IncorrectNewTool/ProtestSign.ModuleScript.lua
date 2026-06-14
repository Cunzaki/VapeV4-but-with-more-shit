-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Consumable.Legacy.IncorrectNewTool.ProtestSign
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
local u3 = l__Mince__2:GetEvent("ChangeProtestSign");
local u4 = {
    Tags = { "SignGear" },
    Animations = {}
};
function u4.Equipped(p5) --[[ Line: 27 ]]
    -- upvalues: l__Mince__2 (copy), u4 (copy)
    if l__Mince__2.Config.Humanoid then
        local l__Tool__3 = p5.Tool;
        u4.ToolActive = true;
        u4.CurrentTool = l__Tool__3;
        u4.UI.Main.Visible = true;
        local l__Animations__4 = l__Tool__3:WaitForChild("Animations");
        u4.Animations = {};
        for _, v6 in l__Animations__4:GetChildren() do
            local v7 = l__Mince__2.Config.Humanoid.Animator:LoadAnimation(v6);
            if v7:GetAttribute("Speed") then
                v7:AdjustSpeed(v7:GetAttribute("Speed"));
            end;
            u4.Animations[v6.Name] = v7;
        end;
    end;
end;
function u4.Unequipped(_) --[[ Line: 51 ]]
    -- upvalues: u4 (copy)
    u4.ToolActive = false;
    u4.HoldingOut = false;
    u4.UI.Main.Visible = false;
    for _, v8 in u4.Animations do
        v8:Stop();
    end;
end;
function u4.SetupUI() --[[ Line: 61 ]]
    -- upvalues: u2 (copy), u4 (copy), u3 (copy)
    u2.NewButton(u4.UI.Main.TextBox.OkayButton).Activated:Connect(function() --[[ Line: 64 ]]
        -- upvalues: u4 (ref), u3 (ref)
        if u4.ButtonDebounce then
        else
            u4.ButtonDebounce = true;
            u3:Fire(u4.UI.Main.TextBox.TextBox.Text);
            u4.ButtonDebounce = false;
        end;
    end);
end;
function u4.Setup() --[[ Line: 79 ]]
    -- upvalues: u4 (copy), u2 (copy), u1 (copy)
    u4.UI = u2.GetScreenGui("SignUI");
    u4.SetupUI();
    u1.Component(u4);
end;
return u4;
