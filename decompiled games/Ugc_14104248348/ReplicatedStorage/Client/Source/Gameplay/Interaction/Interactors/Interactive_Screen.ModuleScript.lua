-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Interaction.Interactors.Interactive_Screen
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local _ = game:GetService("Players").LocalPlayer;
local u1 = require(l__ReplicatedStorage__1.Modules.Mince):Get("SelectInteractor");
return {
    Created = function(u2) --[[ Name: Created, Line 11 ]]
        -- upvalues: u1 (copy)
        local v4 = {
            HoverName = "Change Channel",
            HitCollider = u2.Item:WaitForChild("Power"),
            Interact = function(_, p3) --[[ Name: Interact, Line 18 ]]
                -- upvalues: u2 (copy)
                u2.Request("SwitchChannel");
                p3();
            end
        };
        if not u2.Config.Intialized then
            u2.Request("SwitchChannel");
        end;
        u1.NewInteractionClass(v4);
    end
};
