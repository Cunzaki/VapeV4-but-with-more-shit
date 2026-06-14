-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Drink.Components.CookiePanPickUp
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local _ = game:GetService("Players").LocalPlayer;
local l__TweenService__2 = game:GetService("TweenService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__3:GetEvent("PickupDrink");
local u2 = l__Mince__3:GetEvent("UseMachine");
l__Mince__3:Get("Notices");
l__Mince__3:Get("SoundHandler");
local u3 = l__Mince__3:Get("DrinkHandler");
l__Mince__3:Get("TipJar");
local u4 = l__Mince__3:Get("SelectInteractor");
l__Mince__3:Get("PlacementHandler");
local l__Recipes__4 = l__Mince__3.Config.Recipes;
local l__CookiePan__5 = l__Mince__3.Config.Machines.CookiePan;
local u5 = TweenInfo.new(0.5);
local v6 = l__Mince__3.Component({
    Tag = "PickupCookiePan"
});
function v6.Removing(p7) --[[ Line: 28 ]]
    -- upvalues: u4 (copy)
    for _, v8 in p7.Events do
        v8:Disconnect();
    end;
    for _, v9 in p7.Sounds do
        v9:Destroy();
    end;
    u4.CollapseClass(p7);
end;
function v6.Construct(u10) --[[ Line: 34 ]]
    -- upvalues: u3 (copy), l__CookiePan__5 (copy), l__Recipes__4 (copy), u2 (copy), l__TweenService__2 (copy), u5 (copy), u1 (copy), u4 (copy)
    u10.HitCollider = u10.Instance:FindFirstChild("Collider") or u10.Instance:WaitForChild("Handle");
    u10.DefaultName = u10.Instance.Name;
    u10.HoverName = u10.DefaultName;
    u10.Target = u10.Instance;
    u10.Sounds = {};
    u10.Events = {};
    for _, v11 in u10.Instance:GetChildren() do
        if v11:IsA("BasePart") and v11 ~= u10.HitCollider then
            v11.CanQuery = false;
        end;
    end;
    function u10.OnHover(p12) --[[ Line: 50 ]]
        -- upvalues: u3 (ref), l__CookiePan__5 (ref)
        local v13 = u3.GetEquippedTool();
        local v14 = p12.Instance:GetAttribute("DoughState");
        local v15 = p12.Instance:GetAttribute("Baked");
        if v13 then
            if v15 then
                if v13:GetAttribute("DrinkID") ~= "CookieCutter" then
                    return false;
                end;
                p12.HoverName = `Cut {p12.DefaultName} with the {v13.Name}`;
                return true;
            end;
            if not l__CookiePan__5.AllowedUses[v13:GetAttribute("DrinkID")] or v13:GetAttribute("Baked") then
                return false;
            end;
            local v16 = ({
                Dough = 2,
                Sprinkles = 1
            })[v13:GetAttribute("DrinkID")];
            if (not v14 or v14 <= 1) and (not v16 or v16 <= 1) then
                return false;
            end;
            if not v16 then
                return false;
            end;
            p12.HoverName = `Place {v13.Name} on {p12.DefaultName}`;
        elseif v14 == 1 then
            p12.HoverName = "Knead dough";
        else
            p12.HoverName = p12.DefaultName;
        end;
        return true;
    end;
    function u10.Interact(p17, p18) --[[ Line: 95 ]]
        -- upvalues: u3 (ref), l__Recipes__4 (ref), u2 (ref), l__CookiePan__5 (ref), l__TweenService__2 (ref), u5 (ref), u1 (ref)
        local v19 = p17.Instance:GetAttribute("DoughState");
        local v20 = u3.GetEquippedTool();
        if v20 and v20:GetAttribute("DrinkID") == "CookieCutter" then
            u3.DoProcessingText(l__Recipes__4[v20:GetAttribute("RecipeName")].Action, l__Recipes__4[v20:GetAttribute("RecipeName")].ActionTime, l__Recipes__4[v20:GetAttribute("RecipeName")].AltSound or "InteractProcess", true);
            u2:Fire(p17.Instance);
            p18();
        else
            if v20 and l__CookiePan__5.AllowedUses[v20:GetAttribute("DrinkID")] or v19 and v19 == 1 then
                if v19 == 1 then
                    local v21 = l__TweenService__2:Create(p17.Instance.Dough, u5, {
                        Transparency = 1,
                        Size = p17.Instance.Handle.Size
                    });
                    for _, v22 in p17.Instance.Filling:GetDescendants() do
                        if v22:IsA("BasePart") then
                            l__TweenService__2:Create(v22, u5, {
                                Transparency = 0
                            }):Play();
                        end;
                    end;
                    v21:Play();
                    v21.Completed:Wait();
                end;
                u2:Fire(p17.Instance);
            else
                u1:Fire(p17.Instance);
            end;
            p18();
        end;
    end;
    u10.Instance:GetPropertyChangedSignal("Name"):Connect(function() --[[ Line: 148 ]]
        -- upvalues: u10 (copy)
        u10.DefaultName = u10.Instance.Name;
    end);
    u4.NewInteractionClass(u10);
end;
return v6;
