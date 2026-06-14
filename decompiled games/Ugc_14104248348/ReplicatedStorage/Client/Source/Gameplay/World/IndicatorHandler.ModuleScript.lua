-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.IndicatorHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__CollectionService__2 = game:GetService("CollectionService");
local u1 = {
    Bounce = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
    Indicators = {},
    IndicatorByPart = {}
};
function u1.GetIndicatorClass(p2) --[[ Line: 13 ]]
    -- upvalues: u1 (copy)
    if not (u1.Indicators[p2] or u1.IndicatorByPart[p2]) then
        warn((`Waiting for '{p2}' until it existss....`));
    end;
    local v3;
    repeat
        task.wait();
        v3 = u1.Indicators[p2] or u1.IndicatorByPart[p2];
    until v3;
    return v3;
end;
function u1.CreateIndicator(p4) --[[ Line: 25 ]]
    -- upvalues: l__TweenService__1 (copy), u1 (copy)
    local l__BillboardGui__3 = p4:WaitForChild("BillboardGui");
    local v5 = p4:GetAttributes();
    v5.Tweens = {};
    v5.Tweens.BounceTween = l__TweenService__1:Create(l__BillboardGui__3, u1.Bounce, {
        StudsOffsetWorldSpace = l__BillboardGui__3.StudsOffsetWorldSpace + Vector3.new(0, 2, 0)
    }):Play();
    p4.Transparency = 1;
    p4.CanCollide = false;
    function v5.SetEnabled(_, p6) --[[ Line: 37 ]]
        -- upvalues: l__BillboardGui__3 (copy)
        l__BillboardGui__3.Enabled = p6;
    end;
    u1.IndicatorByPart[p4] = v5;
    u1.Indicators[v5.Name or "Default"] = v5;
    return v5;
end;
function u1.SetupComponent(p7, u8) --[[ Line: 48 ]]
    -- upvalues: l__CollectionService__2 (copy)
    local function v10(p9) --[[ Line: 49 ]]
        -- upvalues: u8 (copy)
        u8(p9);
    end;
    for _, v11 in l__CollectionService__2:GetTagged(p7) do
        u8(v11);
    end;
    l__CollectionService__2:GetInstanceAddedSignal(p7):Connect(v10);
end;
function u1.KnitStart(_) --[[ Line: 59 ]]
    -- upvalues: u1 (copy)
    u1.SetupComponent("Indicator", function(p12) --[[ Line: 61 ]]
        -- upvalues: u1 (ref)
        u1.CreateIndicator(p12);
    end);
end;
return u1;
