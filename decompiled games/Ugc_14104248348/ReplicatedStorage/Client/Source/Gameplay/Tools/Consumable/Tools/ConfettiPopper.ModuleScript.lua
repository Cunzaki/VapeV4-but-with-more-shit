-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Consumable.Tools.ConfettiPopper
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("ToolHandler");
local u2 = l__Mince__2:GetEvent("ConfettiPopper");
local u4 = {
    Tags = { "ConfettiPopper" },
    Animations = {},
    Activate = function(p3, _) --[[ Name: Activate, Line 15 ]]
        -- upvalues: u2 (copy)
        if not p3.Tool:GetAttribute("Used") then
            u2:Fire();
            return "Sink";
        end;
    end
};
function u4.Setup() --[[ Line: 23 ]]
    -- upvalues: u1 (copy), u4 (copy)
    u1.Component(u4);
end;
return u4;
