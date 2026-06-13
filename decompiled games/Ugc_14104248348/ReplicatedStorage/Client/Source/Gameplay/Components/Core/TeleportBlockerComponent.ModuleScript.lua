-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Core.TeleportBlockerComponent
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local l__LocalPlayer__2 = game:GetService("Players").LocalPlayer;
local l__Maid__3 = require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__4:Get("Effects");
local u2 = l__Mince__4:Get("WorldCulling");
local u3 = l__Mince__4:Get("MarketHandler");
local u4 = l__Mince__4.Component({
    Tag = "TeleportBlocker",
    PassIndexLookup = {
        Bar = "DrinkMaker"
    }
});
function u4.Teleport(_, p5) --[[ Line: 25 ]]
    -- upvalues: l__LocalPlayer__2 (copy), u2 (copy), u1 (copy)
    local l__Character__5 = l__LocalPlayer__2.Character;
    local l__Character__6 = l__LocalPlayer__2.Character;
    if l__Character__6 then
        l__Character__6 = l__LocalPlayer__2.Character:FindFirstChild("Humanoid");
    end;
    if l__Character__6 then
        u2.SetRenderFocus(p5);
        task.spawn(u1.PlayBlackout, 0.6);
        task.wait(0.5);
        if l__Character__6.SeatPart then
            l__Character__6.Sit = false;
            local v6 = l__Character__6.SeatPart:FindFirstChild("SeatWeld");
            if v6 then
                v6:Destroy();
            end;
        end;
        l__Character__5:PivotTo(CFrame.new(p5 + Vector3.new(0, 1, 0) * l__Character__6.HipHeight));
        u2.SetRenderFocus(nil);
    end;
end;
function u4.Construct(u7) --[[ Line: 45 ]]
    -- upvalues: l__Maid__3 (copy), u4 (copy), l__Mince__4 (copy), l__LocalPlayer__2 (copy), u3 (copy)
    assert(u7.Name, "A name is required for a blocker!");
    u7.Maid = l__Maid__3.new();
    u7.IsUnlocked = false;
    u7.Collider = u7.Instance:WaitForChild("Collider");
    u7.Outside = u7.Instance:WaitForChild("Outside");
    local u8 = {};
    for _, v9 in string.split(u7.Name, ",") do
        local v10 = u4.PassIndexLookup[v9] or (v9 or (u7.Name or "Name"));
        local v11 = l__Mince__4.Config.Products.Passes[v10];
        local v12 = `Could not determine the gamepassID of the '{u7.Name}' blocker with the GamepassIndex of '{v10}'!`;
        assert(v11, v12);
        table.insert(u8, v11);
    end;
    u7.Maid:Add(u7.Collider.Touched:Connect(function(p13) --[[ Line: 62 ]]
        -- upvalues: u7 (copy), l__LocalPlayer__2 (ref), u8 (copy), u3 (ref)
        if u7.IsUnlocked then
        else
            if u7.Collider.CanCollide and (l__LocalPlayer__2.Character and (p13.Parent and p13.Parent == l__LocalPlayer__2.Character)) then
                for _, v14 in u8 do
                    if not u3.GetStatus(v14) then
                        u7:Teleport(u7.Outside.Position);
                        return;
                    end;
                end;
            end;
        end;
    end));
    for _, v15 in u8 do
        u3.ProcessStatus(v15, function() --[[ Line: 80 ]]
            -- upvalues: u7 (copy)
            if u7.IsUnlocked then
            else
                u7.IsUnlocked = true;
                u7.Collider.CanCollide = false;
                u7.Collider.CanTouch = false;
                u7.Collider.CanQuery = false;
            end;
        end);
    end;
end;
function u4.Removing(p16) --[[ Line: 91 ]]
    p16.Maid:Destroy();
end;
return u4;
