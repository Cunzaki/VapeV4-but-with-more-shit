-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Consumable.Legacy.EqupippedDeprecated.Firework1
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Debris__2 = game:GetService("Debris");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__3:Get("ToolHandler");
l__Mince__3:Get("BindManager");
local u2 = l__Mince__3:Get("Intoxication");
local u3 = l__Mince__3:Get("Locomotion");
local u4 = l__Mince__3:Get("SelectInteractor");
local u5 = l__Mince__3:GetEvent("UseFirework");
local u6 = {
    LoadedAnimations = {}
};
function u6.ActivateTool() --[[ Line: 20 ]]
    -- upvalues: u2 (copy), u6 (copy), u3 (copy)
    if u2.IsPassedOut() then
        return "Pass";
    end;
    if not u6.ToolActive then
        return "Pass";
    end;
    if u6.Tool:GetAttribute("Used") then
        return "Pass";
    end;
    if u6.PendingAction then
        return "Pass";
    end;
    u3.SetEnabled(false);
    u6.PendingAction = true;
    u6.LoadedAnimations.Action:Play();
    return "Sink";
end;
function u6.StartTool(u7) --[[ Line: 34 ]]
    -- upvalues: l__Mince__3 (copy), u6 (copy), u5 (copy), u3 (copy), l__Debris__2 (copy)
    if l__Mince__3.Config.Humanoid then
        u6.Tool = u7;
        u6.ToolActive = true;
        u6.LoadedAnimations = {};
        for _, v8 in u7:WaitForChild("Animations"):GetChildren() do
            u6.LoadedAnimations[v8.Name] = l__Mince__3.Config.Humanoid:LoadAnimation(v8);
        end;
        local u9 = nil;
        u6.LoadedAnimations.Action.Stopped:Connect(function() --[[ Line: 47 ]]
            -- upvalues: u9 (ref), u5 (ref), u3 (ref), u6 (ref)
            if u9 then
                warn(u9);
                u5:Fire(u9);
                u3.SetEnabled(true);
                u6.PendingAction = false;
            end;
        end);
        u6.LoadedAnimations.Action:GetMarkerReachedSignal("Place"):Connect(function() --[[ Line: 54 ]]
            -- upvalues: u7 (copy), u9 (ref), l__Debris__2 (ref)
            local v10 = u7.Handle:Clone();
            v10.Anchored = true;
            v10.Orientation = Vector3.new(0, 0, 0);
            v10.Parent = game.Workspace;
            u9 = u7.Handle.Position;
            u7.Handle.Transparency = 1;
            l__Debris__2:AddItem(v10, 0.8);
        end);
    end;
end;
function u6.EndTool() --[[ Line: 69 ]]
    -- upvalues: u6 (copy), u3 (copy)
    if u6.ToolActive then
        u3.SetEnabled(true);
        u6.PendingAction = false;
        if u6.Tool:FindFirstChild("Handle") then
            u6.Tool.Handle.Transparency = 0;
        end;
        u6.ToolActive = false;
    end;
end;
function u6.Setup() --[[ Line: 80 ]]
    -- upvalues: u1 (copy), u6 (copy), u4 (copy)
    local v11 = u1.TagEquipped({ "Firework1" });
    v11.Equipped:Connect(u6.StartTool);
    v11.Unequipped:Connect(u6.EndTool);
    u4.BindToInteract(500, u6.ActivateTool);
end;
return u6;
