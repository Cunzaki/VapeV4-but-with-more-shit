-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Legacy.ToolEquippedDeprecated.DemonMic
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("ToolHandler");
l__Mince__2:Get("NotifPrompt");
local u2 = l__Mince__2:GetEvent("SyncState");
local u3 = {};
function u3.StartTool(p4) --[[ Line: 12 ]]
    -- upvalues: l__Mince__2 (copy), u3 (copy), u2 (copy)
    if l__Mince__2.Config.Humanoid then
        u3.ToolActive = true;
        u3.CurrentTool = p4;
        u2:Fire("DemonMic", true);
    end;
end;
function u3.EndTool() --[[ Line: 20 ]]
    -- upvalues: u3 (copy), u2 (copy)
    u3.ToolActive = false;
    u2:Fire("DemonMic", false);
end;
function u3.Setup() --[[ Line: 26 ]]
    -- upvalues: u1 (copy), u3 (copy)
    local v5 = u1.TagEquipped({ "DemonMic" });
    v5.Equipped:Connect(u3.StartTool);
    v5.Unequipped:Connect(u3.EndTool);
end;
return u3;
