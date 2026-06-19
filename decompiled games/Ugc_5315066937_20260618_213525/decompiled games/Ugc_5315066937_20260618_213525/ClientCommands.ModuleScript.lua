-- Decompiled from: ClientCommands
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 12a7ca22-cd63-42d4-a557-a631ea165de3

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local u1 = l__obtain__1("QBox");
local v2 = l__obtain__1("Command");
v2.Add("guis", { "Boolean" }, function(p3) --[[ Line: 7 ]]
    -- upvalues: u1 (copy)
    u1.RobloxBase.Enabled = p3;
end);
v2.Add("guis", {}, function() --[[ Line: 10 ]]
    -- upvalues: u1 (copy)
    u1.RobloxBase.Enabled = not u1.RobloxBase.Enabled;
end);
v2.Add("bind", { "BindInput", "GuiControl" }, function(_, _) --[[ Line: 14 ]]
    return "This command has been superseded by the \'/binds\' gui.";
end);
v2.Add("bind", { "BindInput", "GameControl" }, function(_, _) --[[ Line: 17 ]]
    return "This command has been superseded by the \'/binds\' gui.";
end);
v2.Add("bind", { "BindInput", "HotkeyControl" }, function(_, _) --[[ Line: 20 ]]
    return "This command has been superseded by the \'/binds\' gui.";
end);
v2.Add("unbind", { "BindInput" }, function(_) --[[ Line: 24 ]]
    return "This command has been superseded by the \'/binds\' gui.";
end);
return true;
