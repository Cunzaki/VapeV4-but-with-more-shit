-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.PianoInitializer
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v1 = {
    __IsAsyncSetup = true
};
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local u2 = require(l__ReplicatedStorage__1.Modules.Mince):Get("InterfaceHandler");
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
function v1.Setup() --[[ Line: 21 ]]
    -- upvalues: u4 (ref), u2 (copy), u3 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref)
    u4 = u2.GetScreenGui("PV2Piano");
    u3 = require(u4:WaitForChild("PianoController"));
    u5 = u4:WaitForChild("PianoGui");
    u6 = u4:WaitForChild("MobilePianoGui");
    u7 = u4:WaitForChild("SoundFontGui");
    u8 = u4:WaitForChild("PromptGui");
    u9 = u4:WaitForChild("SettingsGui");
    local l__GuiModule__2 = require(u5:WaitForChild("GuiModule"));
    local l__GuiModule__3 = require(u6:WaitForChild("GuiModule"));
    local l__GuiModule__4 = require(u7:WaitForChild("GuiModule"));
    local l__GuiModule__5 = require(u8:WaitForChild("GuiModule"));
    local l__GuiModule__6 = require(u9:WaitForChild("GuiModule"));
    u3:Init();
    l__GuiModule__2:Init();
    l__GuiModule__3:Init();
    l__GuiModule__4:Init();
    l__GuiModule__5:Init();
    l__GuiModule__6:Init();
    task.spawn(function() --[[ Line: 43 ]]
        -- upvalues: u3 (ref)
        u3:Start();
    end);
    task.spawn(function() --[[ Line: 47 ]]
        -- upvalues: l__GuiModule__2 (copy)
        l__GuiModule__2:Start();
    end);
    task.spawn(function() --[[ Line: 50 ]]
        -- upvalues: l__GuiModule__3 (copy)
        l__GuiModule__3:Start();
    end);
    task.spawn(function() --[[ Line: 53 ]]
        -- upvalues: l__GuiModule__4 (copy)
        l__GuiModule__4:Start();
    end);
    task.spawn(function() --[[ Line: 56 ]]
        -- upvalues: l__GuiModule__5 (copy)
        l__GuiModule__5:Start();
    end);
    task.spawn(function() --[[ Line: 59 ]]
        -- upvalues: l__GuiModule__6 (copy)
        l__GuiModule__6:Start();
    end);
    u3.Activated:ConnectOnce(function() --[[ Line: 63 ]]
        -- upvalues: l__GuiModule__5 (copy)
        if not game:GetService("UserInputService").KeyboardEnabled then
            l__GuiModule__5:ToggleEnabled(true);
        end;
    end);
end;
return v1;
