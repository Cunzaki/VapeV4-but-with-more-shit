-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Core.BlockerComponent
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local l__LocalPlayer__2 = game:GetService("Players").LocalPlayer;
local l__Maid__3 = require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__4:Get("MarketHandler");
local u2 = l__Mince__4.Component({
    Tag = "Blocker",
    PassIndexLookup = {
        Bar = "DrinkMaker"
    }
});
function u2.Construct(u3) --[[ Line: 21 ]]
    -- upvalues: l__Maid__3 (copy), u2 (copy), l__Mince__4 (copy), l__LocalPlayer__2 (copy), u1 (copy)
    assert(u3.Name, "A name is required for a blocker!");
    u3.Maid = l__Maid__3.new();
    u3.IsUnlocked = false;
    local u4 = {};
    for _, v5 in string.split(u3.Name, ",") do
        local v6 = u2.PassIndexLookup[v5] or (v5 or (u3.Name or "Name"));
        local v7 = l__Mince__4.Config.Products.Passes[v6];
        local v8 = `Could not determine the gamepassID of the '{u3.Name}' blocker with the GamepassIndex of '{v6}'!`;
        assert(v7, v8);
        table.insert(u4, v7);
    end;
    u3.Maid:Add(u3.Instance.Touched:Connect(function(p9) --[[ Line: 35 ]]
        -- upvalues: u3 (copy), l__LocalPlayer__2 (ref), u4 (copy), u1 (ref)
        if u3.IsUnlocked then
        else
            if u3.Instance.CanCollide and (l__LocalPlayer__2.Character and (p9.Parent and p9.Parent == l__LocalPlayer__2.Character)) then
                for _, v10 in u4 do
                    if not u1.GetStatus(v10) then
                        u1.StartGamepassPurchase(v10);
                        return;
                    end;
                end;
            end;
        end;
    end));
    u3.Maid:Add(u3.Instance:GetPropertyChangedSignal("CanCollide"):Connect(function() --[[ Line: 50 ]]
        -- upvalues: u3 (copy)
        if u3.IsUnlocked and u3.Instance.CanCollide then
            u3.Instance.CanCollide = false;
        end;
    end));
    for _, v11 in u4 do
        u1.ProcessStatus(v11, function() --[[ Line: 58 ]]
            -- upvalues: u3 (copy)
            if u3.IsUnlocked then
            else
                u3.IsUnlocked = true;
                u3.Instance.CanCollide = false;
                u3.Instance.CanTouch = false;
                u3.Instance.CanQuery = false;
            end;
        end);
    end;
end;
function u2.Removing(p12) --[[ Line: 69 ]]
    p12.Maid:Destroy();
end;
return u2;
