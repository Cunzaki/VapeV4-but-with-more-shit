-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Drink.Components.DrinkGiver
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("VRService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("Notices");
local u2 = l__Mince__2:Get("DrinkHandler");
local u3 = l__Mince__2:Get("SelectInteractor");
l__Mince__2:Get("Level");
local u4 = l__Mince__2:GetEvent("GiveDrink");
local _ = l__Mince__2.Config.Levels;
local u5 = l__Mince__2.Component({
    Tag = "DrinkGiver",
    CreationParents = { game.Workspace },
    LevelCache = { -1, 1 }
});
function u5.PlayAnimation(_, p6) --[[ Line: 22 ]]
    -- upvalues: u2 (copy)
    if p6 then
        local v7 = u2.GetAnimations();
        if v7 then
            if v7.Grab then
                local l__Grab__3 = v7.Grab;
                l__Grab__3:Play(0.2, 1, l__Grab__3.Length / p6);
                return true;
            end;
        end;
    end;
end;
function u5.Removing(p8) --[[ Line: 35 ]]
    -- upvalues: u3 (copy)
    u3.CollapseClass(p8);
end;
function u5.Construct(p9) --[[ Line: 39 ]]
    -- upvalues: l__Mince__2 (copy), u2 (copy), u1 (copy), u5 (copy), u4 (copy), u3 (copy)
    if not game:IsLoaded() then
        game.Loaded:Wait();
    end;
    assert(p9.Name, "Missing drinkgiver name.");
    p9.Recipe = l__Mince__2.Config.Recipes[p9.Name];
    local l__Recipe__4 = p9.Recipe;
    local v10 = `This is an invalid NAME! '{p9.Name}'.`;
    assert(l__Recipe__4, v10);
    if p9.Instance:IsA("BasePart") then
        p9.HitCollider = p9.Instance;
    elseif p9.Instance:IsA("Model") then
        p9.HitCollider = p9.Instance:WaitForChild("Collider");
    else
        error((`The DrinkGiver '{p9.Name}' is invalid! A DrinkGiver must be a "BasePart" or "Model"`));
    end;
    p9.Action = p9.Action or `Grabbing {p9.Recipe.Name or p9.Name}`;
    p9.Target = p9.Instance;
    p9.HoverName = p9.Recipe.Name;
    function p9.Interact(p11, p12, p13) --[[ Line: 57 ]]
        -- upvalues: u2 (ref), u1 (ref), u5 (ref), u4 (ref)
        local v14 = (p11.Recipe.ActionTime or 0.5) * u2.GetLevelBasedActionTime();
        if u2.GetCountOfRecipe(p11.Recipe) >= p11.Recipe.MaxItem then
            u1.Error((`You already have the maximum amount of items ({p11.Recipe.MaxItem}).`));
            return p12();
        end;
        if not p11.Recipe.Action then
            warn("MIRGRATION WARNING! -> DrinkGiver Attribute are no longer used!");
        end;
        local v15 = p13 == Enum.UserCFrame.LeftHand and true or p13 == Enum.UserCFrame.RightHand;
        if not v15 then
            u5.PlayAnimation(p11, v14);
            u2.DoProcessingText(p11.Recipe.Action, v14, p11.Recipe.AltSound or "InteractProcess", true);
        end;
        u4:Fire(p11.Instance, v15 and p13 and p13 or nil);
        p12();
    end;
    u3.NewInteractionClass(p9);
end;
function u5.Setup() --[[ Line: 89 ]] end;
return u5;
