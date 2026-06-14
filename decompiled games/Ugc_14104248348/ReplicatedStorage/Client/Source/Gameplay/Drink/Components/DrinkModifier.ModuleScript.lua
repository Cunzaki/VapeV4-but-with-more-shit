-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Drink.Components.DrinkModifier
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__UserInputService__3 = game:GetService("UserInputService");
local l__Mince__4 = require(l__ReplicatedStorage__2.Modules.Mince);
require(l__ReplicatedStorage__2.Modules.Backpack);
local u1 = l__Mince__4:Get("Notices");
local u2 = l__Mince__4:Get("SoundHandler");
l__Mince__4:Get("Intoxication");
local u3 = l__Mince__4:Get("Level");
local u4 = l__Mince__4:Get("DrinkHandler");
local u5 = l__Mince__4:Get("SelectInteractor");
local _ = l__Mince__4.Config.Levels;
local u6 = l__Mince__4:Get("PlayerCharacterReplication");
local u7 = l__Mince__4:GetEvent("ApplyDrinkModifier");
local u8 = l__Mince__4.Component({
    Tag = "DrinkModifier",
    CreationParents = { game.Workspace },
    LevelCache = { -1, 1 }
});
function u8.PlayShaking(_) --[[ Line: 30 ]]
    -- upvalues: u4 (copy)
    if u4.GetAnimations() then
    end;
end;
function u8.GetLevelBasedActionTime(_) --[[ Line: 36 ]]
    -- upvalues: u3 (copy), u8 (copy)
    local v9 = 0;
    local v10 = 1;
    local v11 = u3.GetLevel("Bartending");
    local v12 = v11.CurrentLevel or 1;
    if u8.LevelCache[1] == v12 then
        return u8.LevelCache[2];
    end;
    for v13, v14 in v11.ActionSpeed do
        if v13 <= v12 and v9 <= v13 then
            v10 = v14;
            v9 = v13;
        end;
    end;
    u8.LevelCache = { v9, v10 };
    return v10;
end;
function u8.PlayAnimation(p15) --[[ Line: 56 ]]
    -- upvalues: u4 (copy), u6 (copy), u2 (copy)
    local v16 = u4.GetAnimations();
    if v16 then
        if v16.Pour then
            local _ = p15.Config.Animation or "Pour";
            local v17 = v16[p15.Config.Animation];
            local v18 = (p15.Config.ActionTime or 0.5) * u4.GetLevelBasedActionTime();
            v17:Play(0.2, 1, v17.Length / v18);
            local u19 = {};
            local v20 = u6.GetCharacterData();
            local v21 = v20 and v20.HandsetModels;
            if v21 then
                v21 = v20.HandsetModels.LeftHand;
            end;
            if v21 and p15.Config.PourEvents then
                local u22 = p15.Config.Sounds or {};
                local u23 = u2.controller();
                u23.AutoExpire = false;
                u19.PourStart = v17:GetMarkerReachedSignal("PourStart"):Connect(function() --[[ Line: 78 ]]
                    -- upvalues: u23 (copy), u22 (copy)
                    u23:Loop(u22.PourLoop);
                end);
                u19.PourEnd = v17:GetMarkerReachedSignal("PourEnd"):Connect(function() --[[ Line: 82 ]]
                    -- upvalues: u23 (copy), u22 (copy)
                    u23:FadeOut(u22.PourLoop);
                end);
                local u24 = v21:FindFirstChild("Cap");
                if u24 then
                    u19.LidOff = v17:GetMarkerReachedSignal("LidOff"):Connect(function() --[[ Line: 88 ]]
                        -- upvalues: u23 (copy), u22 (copy), u24 (copy)
                        u23:Play(u22.PourInit);
                        u24.Transparency = 1;
                    end);
                    u19.LidOn = v17:GetMarkerReachedSignal("LidOn"):Connect(function() --[[ Line: 92 ]]
                        -- upvalues: u24 (copy)
                        u24.Transparency = 0;
                    end);
                end;
                u19.Ending = v17.Ended:Connect(function() --[[ Line: 97 ]]
                    -- upvalues: u23 (copy), u19 (copy)
                    u23:StopAll();
                    for _, v25 in u19 do
                        v25:Disconnect();
                    end;
                end);
            end;
            return true;
        end;
    end;
end;
function u8.Removing(p26) --[[ Line: 109 ]]
    -- upvalues: u5 (copy)
    u5.CollapseClass(p26);
end;
function u8.Construct(p27) --[[ Line: 113 ]]
    -- upvalues: l__Mince__4 (copy), u4 (copy), l__CollectionService__1 (copy), u8 (copy), u1 (copy), u6 (copy), l__UserInputService__3 (copy), u7 (copy), u5 (copy)
    local l__Name__5 = p27.Name;
    local v28 = `Requires a modifier name. :{p27.Instance:GetFullName()} `;
    assert(l__Name__5, v28);
    p27.Config = l__Mince__4.Config.Modifiers[p27.Name];
    local l__Config__6 = p27.Config;
    local v29 = "DrinkModifier config unable to be loaded. ->" .. p27.Name .. `<LC->{p27.Instance:GetFullName()}`;
    assert(l__Config__6, v29);
    if p27.Instance:IsA("BasePart") then
        p27.HitCollider = p27.Instance;
    else
        p27.HitCollider = p27.Instance:WaitForChild("Collider");
    end;
    p27.Target = p27.Instance;
    p27.HoverName = p27.Config.HoverName;
    function p27.OnHover(p30) --[[ Line: 129 ]]
        -- upvalues: u4 (ref), l__CollectionService__1 (ref)
        local v31, v32 = u4.GetEquippedDrinkTool();
        if not v32 then
            return;
        end;
        if not l__CollectionService__1:HasTag(v31, "Drink") then
            return;
        end;
        if not u4.IsValidOption(v31, v32, p30.Config) then
            return;
        end;
        if v31:GetAttribute(p30.Name) then
            return;
        end;
        if p30.Config.Garnish then
            if p30.Config.RequiresModifiers then
                local v33 = true;
                for _, v34 in p30.Config.RequiresModifiers do
                    if not v31:GetAttribute(v34) then
                        v33 = false;
                        break;
                    end;
                end;
                if not v33 then
                    warn("doesnt have all the required modifiers to garnish!");
                    return;
                end;
            end;
            local v35 = v31:FindFirstChild(p30.Name);
            if v35 and v35.Transparency == 0 then
                return;
            end;
            if not p30.Config.BypassLimits and (v31:GetAttribute("Garnishes") or 0) >= u4.Config.MaxGarnishes then
                return;
            end;
        end;
        return true;
    end;
    function p27.Interact(p36, p37) --[[ Line: 168 ]]
        -- upvalues: u8 (ref), u4 (ref), l__CollectionService__1 (ref), u1 (ref), u6 (ref), l__UserInputService__3 (ref), u7 (ref)
        local v38 = (p36.Config.ActionTime or 0.5) * u8:GetLevelBasedActionTime();
        local v39, v40 = u4.GetEquippedDrinkTool();
        if not (v40 and u4:GetHumanoid()) then
            return p37();
        end;
        if not l__CollectionService__1:HasTag(v39, "Drink") then
            return p37();
        end;
        local v41 = u4.IsValidOption(v39, v40, p36.Config);
        if not v41 then
            return p37();
        end;
        if v39:GetAttribute(p36.Name) then
            return p37();
        end;
        if v41.RequiresShaker and not u4.GetTaggedTool("Special", "Shaker") then
            u1.Error("This item requires a shaker!.");
            return p37();
        end;
        if p36.Config.Handset then
            u6.SetHandset(p36.Config.Handset);
        end;
        if p36.Config.Animation and not l__UserInputService__3.VREnabled then
            u8.PlayAnimation(p36);
        end;
        u4.DoProcessingText(p36.Config.Action, v38, p36.Config.AltSound or "InteractProcess");
        task.wait(0.05);
        if v41.RequiresShaker then
            local v42 = u4.GetTaggedTool("Special", "Shaker");
            local v43 = u4.GetAnimations();
            if v42 and v43 then
                u6.SetHandset(nil);
                u4:GetHumanoid():EquipTool(v42);
                v43.Shake:Play();
                u4.DoProcessingText("Shaking", 3, "ShakingSound");
                v43.Shake:Stop();
                u4:GetHumanoid():EquipTool(v39);
                task.wait();
                task.wait();
            end;
        end;
        warn("apply drink modifier->", p36.Instance);
        u7:Fire(p36.Instance);
        if p36.Config.Handset and not v41.RequiresShaker then
            task.wait(0.5);
            u6.SetHandset(nil);
        end;
        p37();
    end;
    u5.NewInteractionClass(p27);
end;
function u8.Setup() --[[ Line: 237 ]] end;
return u8;
