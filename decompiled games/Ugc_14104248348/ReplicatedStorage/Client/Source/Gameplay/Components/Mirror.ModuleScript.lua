-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Mirror
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__PlayerGui__3 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
require(script.Portal);
local l__Reflect__5 = require(script.Reflect);
local l__ViewportWindow__6 = require(script.ViewportWindow);
local u1 = l__Mince__4:Get("EnterBox");
local u2 = l__Mince__4:Get("TriggerHandler");
l__Mince__4:Get("InterfaceHandler");
local u3 = l__Mince__4:Get("PlayerCharacterReplication");
local l__CurrentCamera__7 = workspace.CurrentCamera;
local u4 = l__Mince__4.Component({
    Tag = "Mirror"
});
function u4.LoadExternalCharacter(p5, p6) --[[ Line: 24 ]]
    -- upvalues: u3 (copy)
    if p5.ExternalCharacters[p6] then
    else
        local v7 = u3.GetCharacterClone(p6);
        if v7 then
            local v8 = v7:Clone();
            v8.Parent = p5.ViewportWindow.ViewportFrame.WorldModel;
            local u9 = {};
            local l__Animator__8 = p6.Humanoid.Animator;
            local l__Animator__9 = v8.Humanoid.Animator;
            local function u13(u10) --[[ Line: 42 ]]
                -- upvalues: l__Animator__9 (copy)
                local u11 = l__Animator__9:LoadAnimation(u10.Animation);
                u10:GetPropertyChangedSignal("Speed"):Connect(function(_) --[[ Line: 52 ]]
                    -- upvalues: u11 (copy), u10 (copy)
                    u11:AdjustSpeed(u10.Speed);
                end);
                u10:GetPropertyChangedSignal("IsPlaying"):Connect(function(p12) --[[ Line: 44 ]]
                    -- upvalues: u11 (copy)
                    if p12 then
                        u11:Play();
                    else
                        u11:Stop();
                    end;
                end);
                if u10.IsPlaying then
                    u11:Play();
                else
                    u11:Stop();
                end;
                u11.TimePosition = u10.TimePosition;
                u11:AdjustWeight(u10.WeightTarget);
                u11:AdjustSpeed(u10.Speed);
                u10.Destroying:Connect(function() --[[ Line: 65 ]]
                    -- upvalues: u11 (copy)
                    u11:Destroy();
                end);
            end;
            task.wait();
            task.wait();
            pcall(function() --[[ Line: 73 ]]
                -- upvalues: l__Animator__8 (copy), u13 (copy)
                for _, v14 in l__Animator__8:GetPlayingAnimationTracks() do
                    u13(v14);
                end;
            end);
            u9.AnimPlayed = l__Animator__8.AnimationPlayed:Connect(function(p15) --[[ Line: 79 ]]
                -- upvalues: u13 (copy)
                u13(p15);
            end);
            v8.Destroying:Connect(function() --[[ Line: 83 ]]
                -- upvalues: u9 (copy)
                for _, v16 in u9 do
                    v16:Disconnect();
                end;
            end);
            p5.ExternalCharacters[p6] = v8;
        else
            warn("Failed to load CharacterClone -->", p6.Name);
        end;
    end;
end;
function u4.DeloadExternalCharacter(p17, p18) --[[ Line: 93 ]]
    if p17.ExternalCharacters[p18] then
        p17.ExternalCharacters[p18]:Destroy();
        p17.ExternalCharacters[p18] = nil;
    end;
end;
function u4.Update(p19, p20) --[[ Line: 102 ]]
    -- upvalues: l__Reflect__5 (copy)
    if p19.ViewportWindow then
        for v21, v22 in p19.ExternalCharacters do
            v22:PivotTo(l__Reflect__5(v21:GetPivot(), p19.SurfaceCFrame));
        end;
        p19.ViewportWindow:RenderFrame();
        p19.EnterBox.Update(p20);
    end;
end;
function u4.Start(u23) --[[ Line: 113 ]]
    -- upvalues: l__RunService__2 (copy)
    u23.Running = true;
    u23:Stop();
    if u23.UpdateEvent then
        u23.UpdateEvent:Disconnect();
    end;
    u23.UpdateEvent = l__RunService__2.RenderStepped:Connect(function(p24) --[[ Line: 121 ]]
        -- upvalues: u23 (copy)
        u23:Update(p24);
    end);
    for _, v25 in u23.EnterBox.CurrentCharactersInBox do
        u23:LoadExternalCharacter(v25);
    end;
    task.defer(u23.EnterBox.ForceUpdate);
end;
function u4.Stop(u26) --[[ Line: 132 ]]
    u26.Running = false;
    local l__UpdateEvent__10 = u26.UpdateEvent;
    task.delay(1, function() --[[ Line: 137 ]]
        -- upvalues: l__UpdateEvent__10 (copy), u26 (copy)
        if l__UpdateEvent__10 then
            l__UpdateEvent__10:Disconnect();
            if u26.UpdateEvent == l__UpdateEvent__10 then
                u26.UpdateEvent = nil;
            end;
        end;
    end);
    for _, _ in u26.ExternalCharacters do

    end;
end;
function u4.Construct(u27) --[[ Line: 153 ]]
    -- upvalues: l__ViewportWindow__6 (copy), l__PlayerGui__3 (copy), u2 (copy), u1 (copy), l__ReplicatedStorage__1 (copy), l__Reflect__5 (copy)
    assert(u27.Name, "This Mirror does not have a world!");
    u27.ExternalCharacters = {};
    u27.ViewportWindow = l__ViewportWindow__6.fromPart(u27.Instance, Enum.NormalId.Front, l__PlayerGui__3);
    u27.Trigger = u2.GetTrigger(u27.Name);
    u27.EnterBox = u1.new(u27.Trigger.Parts[1]);
    u27.World = l__ReplicatedStorage__1.Assets.Worlds:WaitForChild(u27.Name):Clone();
    u27.World.Parent = u27.ViewportWindow.ViewportFrame.WorldModel;
    u27.SurfaceCFrame = u27.ViewportWindow:GetSurfaceInfo();
    for _, v28 in u27.World:GetDescendants() do
        if v28:IsA("BasePart") then
            v28.CFrame = l__Reflect__5(v28.CFrame, u27.SurfaceCFrame);
        end;
    end;
    u27.EnterBox.Added:Connect(function(p29) --[[ Line: 171 ]]
        -- upvalues: u27 (copy)
        u27.ViewportWindow:UpdateLighting();
        u27:LoadExternalCharacter(p29);
    end);
    u27.EnterBox.Removed:Connect(function(p30) --[[ Line: 178 ]]
        -- upvalues: u27 (copy)
        u27:DeloadExternalCharacter(p30);
    end);
    u27.Trigger.Entered:Connect(function() --[[ Line: 182 ]]
        -- upvalues: u27 (copy)
        u27:Start();
    end);
    u27.Trigger.Exited:Connect(function() --[[ Line: 186 ]]
        -- upvalues: u27 (copy)
        u27:Stop();
    end);
end;
function u4.Setup() --[[ Line: 191 ]]
    -- upvalues: l__PlayerGui__3 (copy), u4 (copy), l__CurrentCamera__7 (ref)
    local v31 = Instance.new("Folder", l__PlayerGui__3);
    v31.Name = "MirrorFolder";
    u4.Folder = v31;
    workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function(_) --[[ Line: 197 ]]
        -- upvalues: l__CurrentCamera__7 (ref), u4 (ref)
        l__CurrentCamera__7 = workspace.CurrentCamera;
        for _, v32 in u4:GetAll() do
            v32.Viewport.CurrentCamera = l__CurrentCamera__7;
        end;
    end);
end;
return u4;
