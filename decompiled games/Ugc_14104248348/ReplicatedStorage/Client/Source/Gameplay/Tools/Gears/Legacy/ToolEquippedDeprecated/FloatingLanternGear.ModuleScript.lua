-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Legacy.ToolEquippedDeprecated.FloatingLanternGear
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local l__TweenService__2 = game:GetService("TweenService");
local l__CollectionService__3 = game:GetService("CollectionService");
game:GetService("Players");
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
l__Mince__4:Get("BindManager");
local u1 = l__Mince__4:Get("Notices");
local u2 = l__Mince__4:Get("ConfirmPrompt");
local u3 = l__Mince__4:Get("ToolHandler");
local u4 = l__Mince__4:Get("SelectInteractor");
local u5 = l__Mince__4:GetEvent("LetLantern");
local u6 = l__Mince__4.Component({
    Tag = "FloatingLanternTool"
});
function u6.Activate(u7) --[[ Line: 23 ]]
    -- upvalues: l__Mince__4 (copy), l__CollectionService__3 (copy), u1 (copy), u2 (copy), u5 (copy)
    if l__Mince__4.Config.Humanoid and not u7.Active then
        u7.Active = true;
        local u8 = l__CollectionService__3:GetTagged("BeachPart")[1];
        if not u8 then
            return u1.CreateNotice("You must let this lantern go at the shoreline!", nil, 5);
        end;
        local u9 = OverlapParams.new();
        u9.FilterDescendantsInstances = l__Mince__4.Config.Humanoid.Parent:GetChildren();
        u9.FilterType = Enum.RaycastFilterType.Include;
        if #workspace:GetPartsInPart(u8, u9) == 0 then
            return u1.CreateNotice("You must let this lantern go at the shoreline!", nil, 5);
        end;
        u2.Display("Would you like to let your lantern go here?", function() --[[ Line: 36 ]]
            -- upvalues: u8 (copy), u9 (copy), u5 (ref), u7 (copy)
            if #workspace:GetPartsInPart(u8, u9) == 0 then
            else
                u5:Fire(u7.Instance.Handle);
            end;
        end);
    end;
end;
function u6.Equipped(p10) --[[ Line: 42 ]]
    p10:SetAttribute("IsEquipped", true);
end;
function u6.Unequipped(p11) --[[ Line: 46 ]]
    p11:SetAttribute("IsEquipped", false);
end;
function u6.Construct(u12) --[[ Line: 50 ]]
    -- upvalues: u4 (copy)
    local _ = u12.Instance;
    u4.BindToInteract(150, function() --[[ Line: 53 ]]
        -- upvalues: u12 (copy)
        if not (u12.Instance and u12.Instance:GetAttribute("IsEquipped")) then
            return "Pass";
        end;
        u12:Activate();
        task.wait(0.2);
        u12.Active = false;
        return "Sink";
    end);
end;
function u6.Setup() --[[ Line: 62 ]]
    -- upvalues: u3 (copy), u6 (copy)
    local v13 = u3.TagEquipped({ "FloatingLanternTool" });
    v13.Equipped:Connect(u6.Equipped);
    v13.Unequipped:Connect(u6.Unequipped);
end;
u5.Event:Connect(function(p14) --[[ Line: 68 ]]
    -- upvalues: l__TweenService__2 (copy)
    l__TweenService__2:Create(p14, TweenInfo.new(40), {
        Position = p14.Position + Vector3.new(0, 100, 0)
    }):Play();
end);
return u6;
