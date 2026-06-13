-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Interaction
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
l__Mince__3:Get("SoundHandler");
local u1 = l__Mince__3:Get("Select");
local u2 = l__Mince__3:GetEvent("Interaction");
local u3 = {
    Tag = "Interaction"
};
function bcall(p4, p5, ...)
    if p4[p5] and typeof(p4[p5]) == "function" then
        p4[p5](...);
    end;
end;
function u3.SetupInteraction(u6) --[[ Line: 24 ]]
    -- upvalues: u2 (copy), u1 (copy)
    local u7 = u6:GetAttributes();
    u7.Name = u7.Name or "Default";
    u7.Item = u6;
    u7.Instance = u6;
    u7.Events = {};
    function u7.Request(...) --[[ Line: 31 ]]
        -- upvalues: u2 (ref), u6 (copy)
        u2:Fire(u6, ...);
    end;
    local v8 = script.Interactors:FindFirstChild(u7.Name or "Default");
    local l__Config__4 = u6:WaitForChild("Config", 3);
    if v8 and v8:IsA("ModuleScript") then
        if l__Config__4 then
            local u9 = require(v8);
            u7.Config = l__Config__4:GetAttributes();
            bcall(u9, "Created", u7);
            bcall(u9, "ConfigChanged", u7, u7.Config);
            l__Config__4.AttributeChanged:Connect(function(p10) --[[ Line: 53 ]]
                -- upvalues: u7 (ref), l__Config__4 (copy), u9 (copy)
                u7.Config[p10] = l__Config__4:GetAttribute(p10);
                bcall(u9, "ConfigChanged", u7, p10);
            end);
            task.defer(function() --[[ Line: 60 ]]
                -- upvalues: u7 (ref), u9 (copy)
                for v11, _ in u7.Config do
                    bcall(u9, "ConfigChanged", u7, v11);
                end;
            end);
            u6.Destroying:Connect(function() --[[ Line: 66 ]]
                -- upvalues: u9 (copy), u7 (ref)
                bcall(u9, "Destroying", u7);
                for _, v12 in u7.Events do
                    v12:Disconnect();
                end;
                u7 = nil;
            end);
            if u7.Config.HasSelection then
                local v13 = l__Config__4:FindFirstChild("Selector");
                local v14 = l__Config__4:FindFirstChild("Target");
                function u7.LockSelection() --[[ Line: 79 ]]
                    -- upvalues: u1 (ref)
                    local l__CurrentInteraction__5 = u1.CurrentInteraction;
                    if l__CurrentInteraction__5 then
                        l__CurrentInteraction__5.Lock();
                    end;
                end;
                function u7.ExitSelection() --[[ Line: 87 ]]
                    -- upvalues: u1 (ref)
                    local l__CurrentInteraction__6 = u1.CurrentInteraction;
                    if l__CurrentInteraction__6 then
                        l__CurrentInteraction__6.Exit();
                    end;
                end;
                local v15;
                if v14 then
                    v15 = v14.Value or u6;
                else
                    v15 = u6;
                end;
                u7.Target = v15;
                if v13 then
                    u6 = v13.Value or u6;
                end;
                u7.Selector = u6;
                local u16 = {
                    HoldDuration = 0,
                    Name = u7.Name,
                    SelectItem = u7.Target,
                    Selector = u7.Selector
                };
                local u17 = Instance.new("ProximityPrompt");
                u17:SetAttribute("Type", "__Select");
                u17.Style = Enum.ProximityPromptStyle.Custom;
                u17.Parent = u7.Target;
                if u7.Config.RequiresLineOfSight ~= nil then
                    u17.RequiresLineOfSight = u7.Config.RequiresLineOfSight;
                end;
                if u7.Config.MaxDistance ~= nil then
                    u17.MaxActivationDistance = u7.Config.MaxDistance;
                end;
                u17.KeyboardKeyCode = Enum.KeyCode.World0;
                u17.PromptShown:Connect(function() --[[ Line: 123 ]]
                    -- upvalues: u1 (ref), u16 (copy)
                    u1.CreateInteraction(u16);
                end);
                u17.PromptHidden:Connect(function() --[[ Line: 127 ]]
                    -- upvalues: u1 (ref), u16 (copy)
                    u1.EndInteraction(u16);
                end);
                u7.Interacted = u1.UponInteraction(u16);
                function u7.DisableSelection() --[[ Line: 134 ]]
                    -- upvalues: u17 (copy), u7 (ref)
                    u17.Enabled = false;
                    u7.ExitSelection();
                end;
                u7.Interacted:Connect(function(p18) --[[ Line: 140 ]]
                    -- upvalues: u9 (copy), u7 (ref)
                    bcall(u9, "Selected", u7, p18);
                end);
            end;
        else
            warn((`Interactions.Interactors.{u7.Name} Interaction needs a Config<Instance> parented to instance of interaction.`));
            warn(u6:GetFullName());
            warn(u7);
        end;
    else
        warn(("Interaction.Interactors.%s modulscript required."):format(u7.Name));
    end;
end;
function u3.Setup() --[[ Line: 147 ]]
    -- upvalues: l__CollectionService__2 (copy), u3 (copy)
    for _, v19 in l__CollectionService__2:GetTagged(u3.Tag) do
        task.defer(u3.SetupInteraction, v19);
    end;
    l__CollectionService__2:GetInstanceAddedSignal(u3.Tag):Connect(function(p20) --[[ Line: 153 ]]
        -- upvalues: u3 (ref)
        u3.SetupInteraction(p20);
    end);
end;
return u3;
