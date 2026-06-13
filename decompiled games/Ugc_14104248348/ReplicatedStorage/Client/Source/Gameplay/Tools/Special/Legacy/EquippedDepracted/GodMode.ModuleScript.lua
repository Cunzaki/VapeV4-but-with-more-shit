-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Special.Legacy.EquippedDepracted.GodMode
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("ToolHandler");
local u2 = {
    LoadedAnimations = {}
};
function u2.StartTool(p3) --[[ Line: 11 ]]
    -- upvalues: l__Mince__2 (copy), u2 (copy)
    if l__Mince__2.Config.Humanoid then
        u2.ToolActive = true;
        u2.LoadedAnimations = {};
        for _, v4 in p3:WaitForChild("Animations"):GetChildren() do
            u2.LoadedAnimations[v4.Name] = l__Mince__2.Config.Humanoid:LoadAnimation(v4);
        end;
        u2.LoadedAnimations.Start:Play();
        u2.LoadedAnimations.Idle:Play();
    end;
end;
function u2.EndTool() --[[ Line: 27 ]]
    -- upvalues: u2 (copy)
    if u2.ToolActive then
        u2.ToolActive = false;
        if u2.LoadedAnimations then
            u2.LoadedAnimations.Idle:Stop();
            u2.LoadedAnimations.End:Play();
        end;
    end;
end;
function u2.Setup() --[[ Line: 37 ]]
    -- upvalues: u1 (copy), u2 (copy)
    local v5 = u1.TagEquipped({ "GodMode" });
    v5.Equipped:Connect(u2.StartTool);
    v5.Unequipped:Connect(u2.EndTool);
end;
return u2;
