-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.ShopBuyer
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Numerics__3 = require(l__ReplicatedStorage__1.Modules.Numerics);
l__Mince__2:Get("BindManager");
local u1 = l__Mince__2:Get("NotifPrompt");
l__Mince__2:Get("SoundHandler");
local u2 = l__Mince__2:Get("ConfirmPrompt");
l__Mince__2:Get("InterfaceHandler");
local u3 = l__Mince__2:Get("SelectInteractor");
local u4 = l__Mince__2:GetEvent("InteractBuyer");
local v5 = l__Mince__2.Component({
    Tag = "ShopBuyer"
});
function v5.Construct(p6) --[[ Line: 22 ]]
    -- upvalues: l__Numerics__3 (copy), u1 (copy), u2 (copy), u4 (copy), u3 (copy)
    p6.SurfaceGui = p6.Instance:WaitForChild("SurfaceGui");
    if p6.Price then
        p6.SurfaceGui.Container.CoinLabel.Text = l__Numerics__3.WithCommas(p6.Price);
        p6.HoverName = `Get '{p6.DisplayName}' for {l__Numerics__3.WithCommas(p6.Price)} {p6.CurrencyType or "Coins"}!`;
    else
        p6.SurfaceGui.Container.CoinLabel.Text = "Free";
        p6.HoverName = `Get '{p6.DisplayName}' for FREE!`;
    end;
    p6.HitCollider = p6.Instance:WaitForChild("Collider");
    p6.Target = p6.Instance:WaitForChild("Target");
    function p6.Interact(u7, u8) --[[ Line: 35 ]]
        -- upvalues: u1 (ref), u2 (ref), l__Numerics__3 (ref), u4 (ref)
        if u7.CustomWarning then
            local u9 = coroutine.running();
            u1.Display(u7.CustomWarning, function() --[[ Line: 38 ]]
                -- upvalues: u9 (copy)
                task.spawn(u9);
            end);
            coroutine.yield();
        end;
        if u7.CompatabilityWarning then
            local u10 = coroutine.running();
            u1.Display(`This item CANNOT be used on theese platform(s): {u7.CompatabilityWarning}.`, function() --[[ Line: 46 ]]
                -- upvalues: u10 (copy)
                task.spawn(u10);
            end);
            coroutine.yield();
        end;
        if u7["1TimeUseWarning"] then
            local u11 = coroutine.running();
            u1.Display("This item is a consumable (deletes after equip). If you die the item is not recoverable. It may have multiple uses once equipped.", function() --[[ Line: 54 ]]
                -- upvalues: u11 (copy)
                task.spawn(u11);
            end);
            coroutine.yield();
        end;
        if u7.Price then
            u2.Display(`Would you like to buy '{u7.DisplayName}' for {l__Numerics__3.WithCommas(u7.Price)} {u7.CurrencyType or "Coins"}`, function() --[[ Line: 62 ]]
                -- upvalues: u4 (ref), u7 (copy), u8 (copy)
                u4:Fire(u7.Instance, "BuyItem");
                u8();
            end, u8);
        else
            u4:Fire(u7.Instance, "BuyItem");
            u8();
        end;
    end;
    u3.NewInteractionClass(p6);
end;
return v5;
