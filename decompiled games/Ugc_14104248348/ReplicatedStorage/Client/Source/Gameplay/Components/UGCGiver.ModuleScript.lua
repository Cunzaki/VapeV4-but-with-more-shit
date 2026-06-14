-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.UGCGiver
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Numerics__3 = require(l__ReplicatedStorage__1.Modules.Numerics);
l__Mince__2:Get("BindManager");
l__Mince__2:Get("SoundHandler");
l__Mince__2:Get("InterfaceHandler");
l__Mince__2:Get("SelectInteractor");
local u1 = l__Mince__2:GetEvent("InteractUGC");
local u2 = l__Mince__2.Component({
    Tag = "UGCGiver",
    Translations = {
        Holiday = l__Mince__2.Config.HolidayConfigure.EVENT_CURRENCY_NAME
    }
});
function u2.Construct(u3) --[[ Line: 21 ]]
    -- upvalues: l__Numerics__3 (copy), u2 (copy), u1 (copy)
    local v4 = Instance.new("ProximityPrompt");
    v4:SetAttribute("Type", "Radial");
    v4:SetAttribute("SizeMultipler", 2);
    v4.ObjectText = "Trash Item";
    v4.MaxActivationDistance = 8;
    v4.Style = Enum.ProximityPromptStyle.Custom;
    v4.Parent = u3.Instance;
    v4.RequiresLineOfSight = false;
    if u3.Price then
        v4.ObjectText = `Buy UGC Item for {l__Numerics__3.TruncateNumber(u3.Price, 1)} {u2.Translations[u3.CurrencyType or ""] or (u3.CurrencyType or "Coins")}`;
    else
        v4.ObjectText = "Get FREE UGC Item!";
    end;
    v4.TriggerEnded:Connect(function() --[[ Line: 37 ]]
        -- upvalues: u1 (ref), u3 (copy)
        u1:Fire(u3.Instance, "ChargeUGC");
    end);
end;
return u2;
