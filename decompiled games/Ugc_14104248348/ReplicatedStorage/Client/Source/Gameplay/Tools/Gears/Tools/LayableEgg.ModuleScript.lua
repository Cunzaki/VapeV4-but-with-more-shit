-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Tools.LayableEgg
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("Players");
game:GetService("Debris");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("ToolHandler");
l__Mince__2:Get("PlayerCharacterReplication");
local u2 = l__Mince__2:Get("Locomotion");
local u3 = l__Mince__2:GetEvent("LayEgg");
local u4 = {
    Tags = { "LayableEgg" },
    Animations = {}
};
function u4.Setup() --[[ Line: 20 ]]
    -- upvalues: u1 (copy), u4 (copy)
    u1.Component(u4);
end;
function u4.Activate(u5) --[[ Line: 24 ]]
    -- upvalues: u2 (copy), u3 (copy)
    if not (u2.IsMoving() or u5.Active) then
        u5.Active = true;
        local u6 = u5.Animations[u5:GetNextActionName()];
        u6.Looped = false;
        u6:Play();
        task.delay(u6.Length / 2.5, function() --[[ Line: 33 ]]
            -- upvalues: u5 (copy), u3 (ref)
            if u5.Active then
                u3:Fire();
            end;
        end);
        task.delay(u6.Length, function() --[[ Line: 39 ]]
            -- upvalues: u5 (copy)
            u5.Active = false;
        end);
        if u5.LastCapture then
            u5.LastCapture:Disconnect();
        end;
        u5.LastCapture = u2.Capture():Connect(function() --[[ Line: 44 ]]
            -- upvalues: u5 (copy), u6 (copy)
            if u5.Active then
                u6:Stop();
                u5.Active = false;
            end;
        end);
        u5.EquipMaid:Add(u5.LastCapture);
        return "Sink";
    end;
end;
function u4.GetNextActionName(p7) --[[ Line: 56 ]]
    p7.CursorPosition = p7.CursorPosition + 1;
    if p7.CursorPosition == 1 then
        return "Action";
    end;
    if p7.Animations[`Action{p7.CursorPosition}`] then
        return `Action{p7.CursorPosition}`;
    end;
    p7.CursorPosition = 1;
    return "Action";
end;
function u4.Equipped(p8) --[[ Line: 72 ]]
    -- upvalues: l__Mince__2 (copy)
    if l__Mince__2.Config.Humanoid then
        p8.CursorPosition = 0;
        p8.Animations = {};
        p8.AnimationFolder = p8.Tool:FindFirstChild("Animations");
        for _, v9 in p8.AnimationFolder:GetChildren() do
            p8.Animations[v9.Name] = l__Mince__2.Config.Humanoid:LoadAnimation(v9);
        end;
    end;
end;
function u4.Unequipped(p10) --[[ Line: 82 ]]
    for _, v11 in p10.Animations do
        v11:Stop();
    end;
end;
return u4;
