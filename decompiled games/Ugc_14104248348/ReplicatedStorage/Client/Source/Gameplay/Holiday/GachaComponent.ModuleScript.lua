-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.GachaComponent
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__TweenService__1 = game:GetService("TweenService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__UserInputService__3 = game:GetService("UserInputService");
local l__PolicyService__4 = game:GetService("PolicyService");
local l__Mince__5 = require(l__ReplicatedStorage__2.Modules.Mince);
l__Mince__5:Get("Emote");
local u1 = l__Mince__5:Get("Locomotion");
local u2 = l__Mince__5:Get("NotifPrompt");
local v3 = l__Mince__5:Get("BindManager");
local u4 = l__Mince__5:Get("OpeningHandler");
local u5 = v3.Get("Interact");
local u6 = l__Mince__5:Get("ConfirmPrompt");
local u7 = l__Mince__5:GetFunction("LootboxRequest");
local v8 = l__Mince__5.Component({
    Tag = "Gacha"
});
local u9 = l__PolicyService__4:GetPolicyInfoForPlayerAsync(game.Players.LocalPlayer);
local _ = {
    Common = { Color3.new(0.309804, 1, 0.298039), Color3.new(0.756863, 1, 0.666667) },
    Rare = { Color3.new(0.133333, 0.294118, 1), Color3.new(0.627451, 0.85098, 1) },
    Epic = { Color3.new(0.517647, 0.27451, 1), Color3.new(0.752941, 0.627451, 1) },
    Legendary = { Color3.new(0.898039, 1, 0.388235), Color3.new(0.956863, 1, 0.662745) }
};
function v8.Start(p10) --[[ Line: 34 ]]
    -- upvalues: u1 (copy), l__ReplicatedStorage__2 (copy), l__TweenService__1 (copy)
    if p10.InMachine then
    else
        p10.InMachine = true;
        p10.ProximityPrompt.Enabled = false;
        if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character:PivotTo(p10.Instance.Part.Player.WorldCFrame);
            u1.SetWalkDecimal(0);
            local v11 = l__ReplicatedStorage__2.Assets.Minigame.GachaBall:Clone();
            v11.Parent = p10.Instance;
            v11:PivotTo(p10.Instance.Part.GachaBallSpawn.WorldCFrame);
            p10.BallAnimation = v11.AnimationController:LoadAnimation(v11.BallRoll);
            p10.Ball = v11;
            local l__CurrentCamera__6 = game.Workspace.CurrentCamera;
            l__CurrentCamera__6.CameraType = Enum.CameraType.Scriptable;
            local v12 = l__TweenService__1:Create(l__CurrentCamera__6, TweenInfo.new(1), {
                CFrame = p10.Instance.Part.Camera.WorldCFrame
            });
            v12:Play();
            v12.Completed:Wait();
            p10.CanSpin = true;
            p10.ButtonAnim:Play();
        end;
    end;
end;
function v8.Roll(p13) --[[ Line: 60 ]]
    -- upvalues: l__TweenService__1 (copy), u7 (copy), u4 (copy), u1 (copy)
    if p13.CanSpin then
        p13.CanSpin = false;
        p13.ButtonAnim:Pause();
        p13.Instance.Button.Transparency = 1;
        l__TweenService__1:Create(p13.Instance.Circle, TweenInfo.new(1), {
            Orientation = p13.Instance.Circle.Orientation + Vector3.new(355, 0, 0)
        }):Play();
        task.wait(1);
        p13.BallAnimation:Play();
        task.wait(p13.BallAnimation.Length);
        p13.Ball:Destroy();
        local v14, v15 = pcall(function() --[[ Line: 73 ]]
            -- upvalues: u7 (ref)
            return u7:Invoke("LNW2025");
        end);
        if v14 and v15 then
            u4.StartCapsuleOpening({
                IVID = v15
            });
        end;
        wait(2);
        p13.ProximityPrompt.Enabled = true;
        p13.InMachine = false;
        game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
        u1.SetWalkDecimal(1);
    end;
end;
function v8.Construct(u16) --[[ Line: 91 ]]
    -- upvalues: u9 (copy), l__TweenService__1 (copy), l__Mince__5 (copy), u2 (copy), u6 (copy), u5 (copy), l__UserInputService__3 (copy)
    local l__Part__7 = u16.Instance.Part;
    local v17 = Instance.new("ProximityPrompt");
    v17:SetAttribute("Type", "Radial");
    v17.ObjectText = "Play (500 tickets)";
    v17.MaxActivationDistance = 3.5;
    v17.Style = Enum.ProximityPromptStyle.Custom;
    v17.Parent = l__Part__7.Attachment;
    v17.RequiresLineOfSight = true;
    if u9.ArePaidRandomItemsRestricted then
        v17.ObjectText = "Paid Random Items are restricted in your Country/Region!";
    else
        u16.ProximityPrompt = v17;
        u16.ButtonAnim = l__TweenService__1:Create(u16.Instance.Button, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
            Transparency = 0.5
        });
        v17.Triggered:Connect(function() --[[ Line: 110 ]]
            -- upvalues: l__Mince__5 (ref), u2 (ref), u6 (ref), u16 (copy)
            if l__Mince__5.Config.LocalProfile.Holiday < 500 then
                u2.Display("You don\'t have enough to use this brokie!");
            else
                u6.Display("Would you like to play gacha for 500 tickets?", function() --[[ Line: 116 ]]
                    -- upvalues: u16 (ref)
                    u16:Start();
                end);
            end;
        end);
        u5.OnAction:Connect(function(_) --[[ Line: 121 ]]
            -- upvalues: u16 (copy)
            if u16.InMachine then
                if game.Players.LocalPlayer:GetMouse().Target == u16.Instance.Button then
                    u16:Roll();
                end;
            end;
        end);
        l__UserInputService__3.TouchTapInWorld:Connect(function(_, p18) --[[ Line: 130 ]]
            -- upvalues: u16 (copy)
            if p18 then
            else
                if game.Players.LocalPlayer:GetMouse().Target == u16.Instance.Button then
                    u16:Roll();
                end;
            end;
        end);
    end;
end;
return v8;
