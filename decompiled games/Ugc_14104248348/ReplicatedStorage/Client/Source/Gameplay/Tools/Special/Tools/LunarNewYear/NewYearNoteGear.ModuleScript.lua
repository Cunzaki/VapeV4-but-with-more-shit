-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Special.Tools.LunarNewYear.NewYearNoteGear
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
local u1 = l__Mince__2:Get("Notices");
l__Mince__2:Get("Locomotion");
local u2 = l__Mince__2:Get("ToolHandler");
l__Mince__2:Get("SelectInteractor");
local u3 = l__Mince__2:Get("InterfaceHandler");
l__Mince__2:Get("SelectInteractor");
local u4 = l__Mince__2:GetFunction("ChangeNewYearNote");
local u5 = {
    Tags = { "NewYearNoteGear" },
    Animations = {}
};
function u5.Equipped(p6) --[[ Line: 27 ]]
    -- upvalues: l__Mince__2 (copy), u5 (copy)
    if l__Mince__2.Config.Humanoid then
        local l__Tool__3 = p6.Tool;
        u5.ToolActive = true;
        u5.CurrentTool = l__Tool__3;
        u5.UI.Main.Visible = true;
        local l__Animations__4 = l__Tool__3:WaitForChild("Animations");
        u5.Animations = {};
        for _, v7 in l__Animations__4:GetChildren() do
            local v8 = l__Mince__2.Config.Humanoid.Animator:LoadAnimation(v7);
            if v8:GetAttribute("Speed") then
                v8:AdjustSpeed(v8:GetAttribute("Speed"));
            end;
            u5.Animations[v7.Name] = v8;
        end;
    end;
end;
function u5.Unequipped(_) --[[ Line: 50 ]]
    -- upvalues: u5 (copy)
    u5.ToolActive = false;
    u5.HoldingOut = false;
    u5.UI.Main.Visible = false;
    for _, v9 in u5.Animations do
        v9:Stop();
    end;
end;
function u5.Activate(_) --[[ Line: 60 ]]
    -- upvalues: u5 (copy)
    u5.UI.Main.Visible = true;
end;
function u5.SetupUI() --[[ Line: 64 ]]
    -- upvalues: u3 (copy), u5 (copy), u4 (copy), u1 (copy)
    local v10 = u3.NewButton(u5.UI.Main.Creator.OkayButton);
    local v11 = u3.NewButton(u5.UI.Main.Creator.CloseButton);
    v10.Activated:Connect(function() --[[ Line: 68 ]]
        -- upvalues: u5 (ref), u4 (ref), u1 (ref)
        if u5.ButtonDebounce then
        else
            u5.ButtonDebounce = true;
            if u4:Invoke(u5.UI.Main.Creator.Note.MainBody.Text) == true then
                u5.UI.Main.Visible = false;
            else
                u1.Error("Error filtering text!");
            end;
            u5.ButtonDebounce = false;
        end;
    end);
    v11.Activated:Connect(function() --[[ Line: 87 ]]
        -- upvalues: u5 (ref)
        u5.UI.Main.Visible = false;
    end);
end;
function u5.Setup() --[[ Line: 92 ]]
    -- upvalues: u5 (copy), u3 (copy), u2 (copy)
    u5.UI = u3.GetScreenGui("NewYearNoteUI");
    u5.SetupUI();
    u2.Component(u5);
end;
return u5;
