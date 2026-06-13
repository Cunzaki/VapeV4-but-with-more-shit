-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.MinigameHandler.Components.Questionnaire
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local _ = workspace.CurrentCamera;
l__LocalPlayer__1:GetMouse();
game:GetService("Debris");
local l__Chat__2 = game:GetService("Chat");
local l__TweenService__3 = game:GetService("TweenService");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("RunService");
local l__Mince__5 = require(l__ReplicatedStorage__4.Modules.Mince);
l__Mince__5:Get("BindManager");
l__Mince__5:Get("SoundHandler");
l__Mince__5:Get("InterfaceHandler");
local u1 = l__Mince__5:Get("SelectInteractor");
local v2 = {
    ButtonPressTween = nil,
    Client = {}
};
local u3 = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true);
function v2.Construct(u4) --[[ Line: 33 ]]
    -- upvalues: l__TweenService__3 (copy), u3 (copy), u1 (copy)
    local l__PrimaryPart__6 = u4.Instance.PrimaryPart;
    u4.LastClick = os.clock();
    u4.ButtonPressTween = l__TweenService__3:Create(l__PrimaryPart__6, u3, {
        Position = l__PrimaryPart__6.Position - Vector3.new(0, 0.065, 0)
    });
    u1.NewInteractionClass({
        HoverName = "Ask Question",
        Name = "Ask Question",
        Model = u4.Instance,
        Target = u4.Instance,
        HitCollider = l__PrimaryPart__6,
        Interact = function(_, p5) --[[ Name: Interact, Line 49 ]]
            -- upvalues: u4 (copy)
            u4.Server:AskQuestion();
            u4.LastClick = os.clock();
            p5();
        end,
        OnHover = function() --[[ Line: 55 ]]
            -- upvalues: u4 (copy)
            return os.clock() - u4.LastClick > 1;
        end
    });
    u4.Button = l__PrimaryPart__6;
end;
function v2.SpectateStart(u6) --[[ Line: 64 ]]
    -- upvalues: l__Chat__2 (copy)
    local v7 = u6:GetStateChangedSignal("Question"):Connect(function() --[[ Line: 68 ]]
        -- upvalues: u6 (copy), l__Chat__2 (ref)
        local l__Question__7 = u6.ReplicatedState.Question;
        u6.ButtonPressTween:Play();
        u6.Button.Press:Play();
        l__Chat__2:Chat(u6.Instance.PrimaryPart, l__Question__7);
    end);
    u6.SpectateMaid:Mark(v7);
end;
return v2;
