-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Special-Event-World.MizuPoster
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__TeleportService__3 = game:GetService("TeleportService");
local l__Players__4 = game:GetService("Players");
local l__Mince__5 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__5:Get("Notices");
local u2 = l__Mince__5:Get("ConfirmPrompt");
local u3 = l__Mince__5:Get("SelectInteractor");
local v4 = l__Mince__5.Component({
    Tag = "MizuPoster"
});
function v4.Construct(p5) --[[ Line: 20 ]]
    -- upvalues: l__UserInputService__2 (copy), u1 (copy), u2 (copy), l__TeleportService__3 (copy), l__Players__4 (copy), u3 (copy)
    p5.HoverName = "Play \'MIZU: Aquamarine\'!";
    p5.HitCollider = p5.Instance;
    function p5.Interact(_, p6) --[[ Line: 24 ]]
        -- upvalues: l__UserInputService__2 (ref), u1 (ref), u2 (ref), l__TeleportService__3 (ref), l__Players__4 (ref)
        if l__UserInputService__2.TouchEnabled or l__UserInputService__2.VREnabled then
            u1.Error("The game is not supported for your device!");
        else
            local u7 = coroutine.running();
            u2.Display("Are you sure you want to play \'MIZU: Aquamarine\'? You will be leaving \'[Drinks]On Tap 17+\'!", function() --[[ Line: 33 ]]
                -- upvalues: l__TeleportService__3 (ref), l__Players__4 (ref)
                l__TeleportService__3:Teleport(12852766145, l__Players__4.LocalPlayer);
            end, function() --[[ Line: 35 ]]
                -- upvalues: u7 (copy)
                task.spawn(u7);
            end);
            coroutine.yield();
            p6();
        end;
    end;
    u3.NewInteractionClass(p5);
end;
function v4.Removing(p8) --[[ Line: 47 ]]
    -- upvalues: u3 (copy)
    u3.CollapseClass(p8);
end;
return v4;
