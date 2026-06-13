-- Decompiled from: ReplicatedFirst.Runtime.Source.LoadingUI
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = nil;
local u2 = nil;
local u3 = nil;
local l__ReplicatedFirst__1 = game:GetService("ReplicatedFirst");
local l__TeleportService__2 = game:GetService("TeleportService");
local l__LightRunner__3 = _G.LightRunner;
local u4 = {
    Tween = TweenInfo.new(0.1),
    Background = TweenInfo.new(200, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
};
function u4.UpdateLoadingBarProgress(_, p5) --[[ Line: 11 ]]
    -- upvalues: u3 (ref), u4 (copy)
    u3:Create(u4.ScreenGui.Bar.Fill, u4.Tween, {
        Size = UDim2.fromScale(p5, 1)
    }):Play();
end;
function u4.UpdateLoadingUIToMatchTask(_, p6) --[[ Line: 17 ]]
    -- upvalues: u4 (copy)
    u4.ScreenGui.Bar.LoadText.Text = p6.Descriptor;
end;
function u4.Start(_) --[[ Line: 21 ]]
    -- upvalues: l__ReplicatedFirst__1 (copy), u2 (ref), u4 (copy), l__TeleportService__2 (copy), u1 (ref), u3 (ref)
    l__ReplicatedFirst__1:RemoveDefaultLoadingScreen();
    u2.Loaded:Connect(function() --[[ Line: 23 ]]
        -- upvalues: u4 (ref)
        u4:End();
    end);
    u4.TeleportUI = script.Loading:Clone();
    u4.TeleportUI.Bar.LoadText.Text = "Teleporting";
    l__TeleportService__2:SetTeleportGui(u4.TeleportUI);
    u4.ScreenGui = script.Loading:Clone();
    u4.ScreenGui.Parent = u1:Get("PlayerGui");
    u4.ScreenGui.Background.Position = UDim2.fromScale(-20, -20);
    u4.ScreenGui.Background.Size = UDim2.fromScale(21, 21);
    u3:Create(u4.ScreenGui.Background, u4.Background, {
        Position = UDim2.fromScale(0, 0)
    }):Play();
    u2.ProgressChanged:Connect(function(p7) --[[ Line: 41 ]]
        -- upvalues: u4 (ref)
        u4:UpdateLoadingBarProgress(p7);
    end);
    u2.TaskChanged:Connect(function(p8) --[[ Line: 45 ]]
        -- upvalues: u4 (ref)
        u4:UpdateLoadingUIToMatchTask(p8);
    end);
    u2:Start();
end;
function u4.End(_) --[[ Line: 52 ]]
    -- upvalues: u4 (copy)
    u4.ScreenGui:Destroy();
end;
function u4.WhenLoaded(_) --[[ Line: 56 ]]
    -- upvalues: u1 (ref), l__LightRunner__3 (copy), u2 (ref), u3 (ref), u4 (copy)
    u1 = l__LightRunner__3:Get("Runner");
    u2 = l__LightRunner__3:Get("LoadingManager");
    u3 = u1:Get("TweenService");
    u4:Start();
end;
return u4;
