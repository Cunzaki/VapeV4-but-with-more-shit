-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Consumable.Legacy.IncorrectNewTool.Petition
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
local u3 = l__Mince__2:GetEvent("ChangePetition");
l__Mince__2:GetEvent("SignPetition");
local u4 = l__Mince__2:GetEvent("HoldPetition");
local u5 = {
    InteractBind = 500,
    Tags = { "PetitionClipboard" },
    Animations = {}
};
function u5.Equipped(p6) --[[ Line: 30 ]]
    -- upvalues: l__Mince__2 (copy), u5 (copy), u4 (copy)
    if l__Mince__2.Config.Humanoid then
        local l__Tool__3 = p6.Tool;
        u5.ToolActive = true;
        u5.CurrentTool = l__Tool__3;
        u5.UI.Main.Visible = true;
        u4:Fire(false);
        local l__Animations__4 = l__Tool__3:WaitForChild("Animations");
        u5.Animations = {};
        for _, v7 in l__Animations__4:GetChildren() do
            local v8 = l__Mince__2.Config.Humanoid.Animator:LoadAnimation(v7);
            if v8:GetAttribute("Speed") then
                v8:AdjustSpeed(v8:GetAttribute("Speed"));
            end;
            u5.Animations[v7.Name] = v8;
        end;
        u5.Animations.Idle:Play();
    end;
end;
function u5.Unequipped(_) --[[ Line: 56 ]]
    -- upvalues: u5 (copy)
    u5.ToolActive = false;
    u5.HoldingOut = false;
    u5.UI.Main.Visible = false;
    for _, v9 in u5.Animations do
        v9:Stop();
    end;
end;
function u5.Activate(_) --[[ Line: 66 ]]
    -- upvalues: l__Mince__2 (copy), u5 (copy), u4 (copy)
    if not l__Mince__2.Config.HumanoidRootPart or u5.ButtonDebounce then
        return "Pass";
    end;
    if not (u5.ToolActive and u5.Animations.Idle) then
        return "Pass";
    end;
    (u5.HoldingOut and u5.Animations.HoldingOut or u5.Animations.Idle):Stop();
    u5.HoldingOut = not u5.HoldingOut;
    (u5.HoldingOut and u5.Animations.HoldingOut or u5.Animations.Idle):Play();
    u5.UI.Main.Visible = not u5.UI.Main.Visible;
    u4:Fire(u5.HoldingOut);
    return "Sink";
end;
function u5.SetupUI() --[[ Line: 83 ]]
    -- upvalues: u2 (copy), u5 (copy), u3 (copy)
    u2.NewButton(u5.UI.Main.TextBox.OkayButton).Activated:Connect(function() --[[ Line: 86 ]]
        -- upvalues: u5 (ref), u3 (ref)
        if u5.ButtonDebounce then
        else
            u5.ButtonDebounce = true;
            local l__Text__5 = u5.UI.Main.TextBox.TextBox.Text;
            u5.Animations.Write:Play();
            u3:Fire(l__Text__5);
            u5.Animations.Write.Ended:Wait();
            u5.ButtonDebounce = false;
        end;
    end);
end;
function u5.Setup() --[[ Line: 101 ]]
    -- upvalues: u5 (copy), u2 (copy), u1 (copy)
    u5.UI = u2.GetScreenGui("PetitionUI");
    u5.SetupUI();
    u1.Component(u5);
end;
return u5;
