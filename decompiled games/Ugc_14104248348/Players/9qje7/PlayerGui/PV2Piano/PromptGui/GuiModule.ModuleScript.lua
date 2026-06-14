-- Decompiled from: Players.9qje7.PlayerGui.PV2Piano.PromptGui.GuiModule
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = nil;
local u2 = nil;
local u3 = TweenInfo.new(0.4, Enum.EasingStyle.Quint);
local v4 = {
    _tweenTimestamp = nil
};
local l__Parent__1 = script.Parent;
v4.PromptGui = {
    Gui = l__Parent__1,
    MainFrame = l__Parent__1.MainFrame,
    MobileButton = l__Parent__1.MainFrame.MobileButton,
    MobileConfirm = l__Parent__1.MainFrame.MobileButton.ConfirmFrame,
    DesktopButton = l__Parent__1.MainFrame.DesktopButton,
    DesktopConfirm = l__Parent__1.MainFrame.DesktopButton.ConfirmFrame
};
function v4.ToggleEnabled(u5, p6, p7) --[[ Line: 36 ]]
    -- upvalues: u2 (ref), u3 (copy)
    if p7 or (type(p6) ~= "boolean" or p6 ~= u5.Enabled) then
        if p6 == nil then
            p6 = not u5.Enabled;
        end;
        u5.Enabled = p6;
        local u8 = os.clock();
        u5._tweenTimestamp = u8;
        if p7 then
            u5.PromptGui.MainFrame.Position = u5.Enabled and UDim2.new(0.5, 0, 0.6, 0) or UDim2.new(0.5, 0, 1.5, 0);
        end;
        if u5.Enabled then
            u5.PromptGui.Gui.Enabled = u5.Enabled;
            u2:Play(u5.PromptGui.MainFrame, u3, {
                Position = UDim2.new(0.5, 0, 0.6, 0)
            });
        else
            u2:Play(u5.PromptGui.MainFrame, u3, {
                Position = UDim2.new(0.5, 0, 1.5, 0)
            });
            task.delay(0.4, function() --[[ Line: 49 ]]
                -- upvalues: u5 (copy), u8 (copy)
                if u5._tweenTimestamp == u8 then
                    u5.PromptGui.Gui.Enabled = u5.Enabled;
                    u5.PromptGui.DesktopConfirm.Visible = false;
                    u5.PromptGui.MobileConfirm.Visible = false;
                end;
            end);
        end;
    end;
end;
function v4.Init(p9) --[[ Line: 61 ]]
    -- upvalues: u1 (ref), u2 (ref)
    u1 = script.Parent.Parent:WaitForChild("PianoController");
    u2 = require(u1.Tween);
    u1 = require(u1);
    p9.PromptGui.MainFrame.Position = UDim2.new(0.5, 0, 1.5, 0);
    p9:ToggleEnabled(false, true);
end;
function v4.Start(u10) --[[ Line: 70 ]]
    -- upvalues: u1 (ref)
    u10.PromptGui.DesktopButton.Activated:Connect(function() --[[ Line: 71 ]]
        -- upvalues: u10 (copy), u1 (ref)
        if u10.PromptGui.DesktopConfirm.Visible then
            u1:ChangeDevice("Desktop");
            u10:ToggleEnabled(false);
        else
            u10.PromptGui.DesktopConfirm.Visible = true;
            u10.PromptGui.MobileConfirm.Visible = false;
        end;
    end);
    u10.PromptGui.MobileButton.Activated:Connect(function() --[[ Line: 80 ]]
        -- upvalues: u10 (copy), u1 (ref)
        if u10.PromptGui.MobileConfirm.Visible then
            u1:ChangeDevice("Mobile");
            u10:ToggleEnabled(false);
        else
            u10.PromptGui.MobileConfirm.Visible = true;
            u10.PromptGui.DesktopConfirm.Visible = false;
        end;
    end);
end;
return v4;
