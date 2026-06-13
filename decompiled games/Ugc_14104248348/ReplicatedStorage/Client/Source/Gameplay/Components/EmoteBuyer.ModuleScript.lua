-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.EmoteBuyer
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Numerics__4 = require(l__ReplicatedStorage__1.Modules.Numerics);
l__Mince__3:Get("BindManager");
l__Mince__3:Get("NotifPrompt");
l__Mince__3:Get("SoundHandler");
local u1 = l__Mince__3:Get("ConfirmPrompt");
local u2 = l__Mince__3:Get("TriggerHandler");
local u3 = l__Mince__3:Get("SelectInteractor");
local u4 = l__Mince__3:GetEvent("InteractEmoteBuyer");
local v5 = l__Mince__3.Component({
    Tag = "EmoteBuyer"
});
function v5.StartAnimationLoop(u6) --[[ Line: 22 ]]
    if u6.AnimationLoopActive then
        u6.AskAnimationLoopToExit = false;
    else
        if not u6.AnimationsLoaded then
            u6:LoadAnimations();
        end;
        local u7 = u6.Config.Speed or (u6.EmoteFolder:GetAttribute("Speed") or 1);
        u6.AskAnimationLoopToExit = false;
        u6.AnimationLoopActive = true;
        task.spawn(function() --[[ Line: 36 ]]
            -- upvalues: u6 (copy), u7 (copy)
            local v8, v9 = pcall(function() --[[ Line: 37 ]]
                -- upvalues: u6 (ref), u7 (ref)
                while not u6.AskAnimationLoopToExit do
                    task.wait();
                    u6.Animations.Idle:Play();
                    u6.Animations.Start:Play(u6.Config.FadeTime);
                    u6.Animations.Start:AdjustSpeed(u7);
                    u6.Animations.Start.Stopped:Wait();
                    task.wait(2);
                    u6.Animations.End:Play();
                    u6.Animations.Idle:Stop();
                    u6.Animations.End.Stopped:Wait();
                    task.wait(0.5);
                end;
                u6.AskAnimationLoopToExit = false;
                u6.AnimationLoopActive = false;
            end);
            if not v8 then
                warn(v9);
            end;
        end);
    end;
end;
function v5.StopAnimationLoop(p10) --[[ Line: 63 ]]
    if p10.AnimationsLoaded then
        p10.Animations.Idle:Stop();
    end;
    if p10.AnimationLoopActive then
        p10.AskAnimationLoopToExit = true;
    end;
end;
function v5.LoadAnimations(p11) --[[ Line: 72 ]]
    for _, v12 in p11.EmoteFolder:GetChildren() do
        if v12:IsA("Animation") then
            local v13 = p11.Humanoid:LoadAnimation(v12);
            p11.Animations[v12.Name] = v13;
        end;
    end;
    p11.AnimationsLoaded = true;
end;
function v5.Construct(u14) --[[ Line: 83 ]]
    -- upvalues: l__Mince__3 (copy), l__RunService__2 (copy), l__ReplicatedStorage__1 (copy), l__Numerics__4 (copy), u2 (copy), u1 (copy), u4 (copy), u3 (copy)
    assert(u14.Emote, "An emote is required for an EmoteBuyer!");
    local v15 = nil;
    for _, v16 in l__Mince__3.Config.Emotes do
        if v16.Animation == u14.Emote then
            v15 = v16;
            break;
        end;
    end;
    u14.AnimationLoopActive = false;
    u14.Config = v15 or {
        Name = "Emote"
    };
    u14.AnimationsLoaded = false;
    u14.Animations = {};
    u14.SurfaceGui = u14.Instance:WaitForChild("SurfaceGui");
    u14.Character = u14.Instance:WaitForChild("Character");
    if l__RunService__2:IsStudio() then
        assert(v15, "Could not load emote Config");
        local v17 = l__ReplicatedStorage__1.Assets.Emotes:FindFirstChild(u14.Emote);
        assert(v17, "STUDIO ONLY :: no emote found inside the emote folder by the name of ..." .. u14.Emote);
    end;
    u14.Humanoid = u14.Character:WaitForChild("Humanoid");
    u14.EmoteFolder = l__ReplicatedStorage__1.Assets.Emotes:WaitForChild(u14.Emote);
    u14.InteractionClass = {
        HitCollider = u14.Instance:WaitForChild("Collider"),
        Target = u14.Character
    };
    if u14.Price then
        u14.SurfaceGui.Container.CoinLabel.Text = l__Numerics__4.WithCommas(u14.Price);
        u14.InteractionClass.HoverName = `Get '{u14.Config.Name}' for {l__Numerics__4.WithCommas(u14.Price)} {u14.CurrencyType or "Coins"}!`;
    else
        u14.SurfaceGui.Container.CoinLabel.Text = "Free";
        u14.InteractionClass.HoverName = `Get '{u14.Config.Name}' for FREE!`;
    end;
    u14.Trigger = u2.GetTrigger("Store");
    u14.Trigger.Entered:Connect(function() --[[ Line: 130 ]]
        -- upvalues: u14 (copy)
        u14:StartAnimationLoop();
    end);
    u14.Trigger.Leaved:Connect(function() --[[ Line: 134 ]]
        -- upvalues: u14 (copy)
        u14:StopAnimationLoop();
    end);
    function u14.InteractionClass.Interact(_, u18) --[[ Line: 138 ]]
        -- upvalues: u14 (copy), u1 (ref), l__Numerics__4 (ref), u4 (ref)
        if u14.Price then
            u1.Display(`Would you like to buy '{u14.Config.Name}' for {l__Numerics__4.WithCommas(u14.Price)} {u14.CurrencyType or "Coins"}`, function() --[[ Line: 140 ]]
                -- upvalues: u4 (ref), u14 (ref), u18 (copy)
                u4:Fire(u14.Instance, "BuyItem");
                u18();
            end, u18);
        else
            u4:Fire(u14.Instance, "BuyItem");
            u18();
        end;
    end;
    u3.NewInteractionClass(u14.InteractionClass);
end;
return v5;
