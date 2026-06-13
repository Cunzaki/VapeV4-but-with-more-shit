-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Drink.DrinkHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__RunService__3 = game:GetService("RunService");
local l__LocalPlayer__4 = game:GetService("Players").LocalPlayer;
local l__Mince__5 = require(l__ReplicatedStorage__2.Modules.Mince);
local l__Unify__6 = require(l__ReplicatedStorage__2.Modules.Unify);
local l__Utility__7 = require(l__ReplicatedStorage__2.Modules.Utility);
local l__Backpack__8 = require(l__ReplicatedStorage__2.Modules.Backpack);
local u1 = l__Mince__5:Get("Level");
l__Mince__5:Get("ToolHandler");
local u2 = l__Mince__5:Get("SoundHandler");
local u3 = l__Mince__5:Get("InterfaceHandler");
local u4 = {};
local u5 = {
    Config = {
        MaxGarnishes = 3
    },
    Extras = {},
    ForbiddenModifierNames = {
        "Uses",
        "Special",
        "CanDrink",
        "ALCLevel",
        "FrostLevel",
        "PlaceGroup",
        "AssociatedPlayer",
        "Garnishes",
        "Recipe"
    },
    LevelCache = { -1, 1 },
    LoadedAnimations = {},
    ModifierViewports = {}
};
function BlendColors(p6)
    if #p6 == 0 then
    else
        local v7 = { "R", "B", "G" };
        local v8 = {};
        local v9 = 0;
        for _, v10 in p6 do
            if v10.R ~= 1 or (v10.B ~= 1 or v10.G ~= 1) then
                for _, v11 in v7 do
                    v8[v11] = v8[v11] or 0;
                    v8[v11] = v8[v11] + v10[v11];
                    v9 = v9 + 1;
                end;
            end;
        end;
        if v9 ~= 0 then
            for _, v12 in v7 do
                v8[v12] = v8[v12] / v9;
            end;
            return Color3.new(v8.R, v8.G, v8.B);
        end;
        if #p6 > 0 then
            return p6[1];
        end;
    end;
end;
function u5.GetLevelBasedActionTime() --[[ Line: 63 ]]
    -- upvalues: u1 (copy), u5 (copy)
    local v13 = 0;
    local v14 = 1;
    local v15 = u1.GetLevel("Bartending");
    local v16 = v15.CurrentLevel or 1;
    if u5.LevelCache[1] == v16 then
        return u5.LevelCache[2];
    end;
    for v17, v18 in v15.ActionSpeed do
        if v17 <= v16 and v13 <= v17 then
            v14 = v18;
            v13 = v17;
        end;
    end;
    u5.LevelCache = { v13, v14 };
    return v14;
end;
function u5.PlaceModelIntoViewport(p19) --[[ Line: 83 ]]
    local v20 = p19:Clone();
    for _, v21 in v20:GetChildren() do
        if v21:IsA("BasePart") and v21.Transparency == 1 then
            v21:Destroy();
        end;
    end;
    local v22 = v20:GetAttribute("Rot") or 0;
    local v23 = Instance.new("ViewportFrame");
    v23.Ambient = Color3.new(1, 1, 1);
    v23.LightColor = Color3.new(1, 1, 1);
    v23.AnchorPoint = Vector2.one * 0.5;
    v23.Size = UDim2.fromScale(1, 1);
    v23.Position = UDim2.fromScale(0.5, 0.5);
    v23.BackgroundTransparency = 1;
    v23.BackgroundColor3 = v20:FindFirstChildWhichIsA("BasePart").Color;
    v23.Name = v20.Name;
    v20.Parent = v23;
    v20:PivotTo(CFrame.new());
    v20:GetPivot();
    local v24, v25 = v20:GetBoundingBox();
    local v26 = { v25.X, v25.Y, v25.Z };
    table.sort(v26, function(p27, p28) --[[ Line: 106 ]]
        return p28 < p27;
    end);
    local v29 = v24:ToWorldSpace(CFrame.new(v26[1] * 4, 0, 0));
    local v30 = Instance.new("Camera", v23);
    v30.FieldOfView = 20;
    v30.CFrame = CFrame.new(v29.Position, v24.Position) * CFrame.Angles(0, 0, 0);
    v23.CurrentCamera = v30;
    v20:PivotTo(v20:GetPivot() * CFrame.Angles(0, math.rad(v22), 0));
    return v23;
end;
function u5.PlaceModelIntoViewportLong(p31, p32) --[[ Line: 121 ]]
    local v33 = p31:Clone();
    for _, v34 in v33:GetChildren() do
        if v34:IsA("BasePart") and v34.Transparency == 1 then
            v34:Destroy();
        end;
    end;
    local v35 = p32 or (v33:GetAttribute("Rot") or -90);
    local v36 = Instance.new("ViewportFrame");
    v36.Ambient = Color3.new(1, 1, 1);
    v36.LightColor = Color3.new(1, 1, 1);
    v36.AnchorPoint = Vector2.one * 0.5;
    v36.Size = UDim2.fromScale(1, 1);
    v36.Position = UDim2.fromScale(0.5, 0.5);
    v36.BackgroundTransparency = 1;
    v36.BackgroundColor3 = v33:FindFirstChildWhichIsA("BasePart").Color;
    v36.Name = v33.Name;
    v33.Parent = v36;
    v33:PivotTo(CFrame.new());
    v33:GetPivot();
    local v37, v38 = v33:GetBoundingBox();
    local v39 = { v38.X, v38.Y, v38.Z };
    table.sort(v39, function(p40, p41) --[[ Line: 144 ]]
        return p41 < p40;
    end);
    local v42 = v37:ToWorldSpace(CFrame.new(v39[1] * 3, 0, 0));
    local v43 = Instance.new("Camera", v36);
    v43.FieldOfView = 20;
    v43.CFrame = CFrame.new(v42.Position, v37.Position) * CFrame.Angles(0, 0, 0.7853981633974483);
    v36.CurrentCamera = v43;
    v33:PivotTo(v33:GetPivot() * CFrame.Angles(0, math.rad(v35), 0));
    return v36;
end;
function u5.GetModifierViewport(p44, p45) --[[ Line: 159 ]]
    -- upvalues: u5 (copy), l__ReplicatedStorage__2 (copy), l__RunService__3 (copy)
    assert(p44.Handset, "Handset is required for viewport");
    if u5.ModifierViewports[p44] then
        return u5.ModifierViewports[p44]:Clone();
    end;
    local v46 = l__ReplicatedStorage__2.Assets.Handset:FindFirstChild(p44.Handset);
    if not v46 then
        if l__RunService__3:IsStudio() and not p45 then
            warn((`Important! You request the viewport for the modifier '{p44}' but the handset doesnt exist! Please check this (STUDIO ONLY)`));
        end;
        return;
    end;
    local v47 = nil;
    for _, v48 in v46:GetChildren() do
        if v48:IsA("Model") and v48:GetAttribute("UseViewport") then
            v47 = v48;
            break;
        end;
    end;
    if not v47 then
        if not l__RunService__3:IsStudio() or p45 then
            return;
        end;
        warn("Important note! (STUDIO ONLY) a viewport should expilicitly say which model it should use for a viewport by setting the attribute to UseViewport!");
        warn("I know your reading this, so whoever put this modifier in here should actually go back and add a UseViewport Bool attribute");
        warn("Broken one ->", p44.Name, p44);
        v47 = v46:FindFirstChild("LeftHand");
        if not v47 then
            return;
        end;
        warn("However this has been able to fix itself by setting it to lefthand! ");
    end;
    u5.ModifierViewports[p44] = u5.PlaceModelIntoViewportLong(v47, p44.Rotation);
    return u5.ModifierViewports[p44]:Clone();
end;
function u5.CreateSmallDrinkColorViewport(p49) --[[ Line: 195 ]]
    -- upvalues: l__ReplicatedStorage__2 (copy), u5 (copy)
    local v50 = l__ReplicatedStorage__2.Assets.Tools.SmallGlass:Clone();
    local v51 = v50:FindFirstChild("Drink");
    v51.Color = p49;
    v51.Transparency = 0.5;
    for _, v52 in v50:GetTags() do
        v50:RemoveTag(v52);
    end;
    local v53 = u5.PlaceModelIntoViewport(v50);
    v53.BackgroundColor3 = p49;
    return v53;
end;
function u5.CreateSmallDrinkModifiersViewport(p54) --[[ Line: 208 ]]
    -- upvalues: l__ReplicatedStorage__2 (copy), u5 (copy)
    local v55 = l__ReplicatedStorage__2.Assets.Tools.SmallGlass:Clone();
    local v56 = v55:FindFirstChild("Drink");
    v56.Color = u5.CalculateDrinkColor(p54 or {});
    v56.Transparency = 0.5;
    return u5.PlaceModelIntoViewport(v55);
end;
function u5.CalculateDrinkColor(p57) --[[ Line: 219 ]]
    -- upvalues: l__Mince__5 (copy)
    local v58 = {};
    for _, v59 in p57 do
        local v60 = l__Mince__5.Config.Modifiers[v59];
        if v60.Color then
            table.insert(v58, v60.Color);
        end;
    end;
    return BlendColors(v58) or Color3.new(1, 1, 1);
end;
function u5.DoProcessingText(p61, p62, p63) --[[ Line: 233 ]]
    -- upvalues: u5 (copy), u2 (copy)
    local v64 = p62 or 1;
    u5.Container.Visible = true;
    u5.Container.Descriptor.Text = p61 or "ProcessingText[Action]";
    local v65 = u2.GetSound(p63 or "PourSound");
    if not p63 then
        v65.Volume = 0;
    end;
    v65.Looped = true;
    v65:Play();
    local v66 = 0;
    repeat
        v66 = v66 + task.wait();
        local v67 = math.clamp(v66 / v64, 0.05, 1);
        u5.Container.Bar.Fill.Size = UDim2.fromScale(v67, 1);
    until v64 < v66;
    v65.Looped = false;
    v65:Stop();
    u5.Container.Visible = false;
end;
function u5.GetOrderForModifiers(p68, p69) --[[ Line: 259 ]]
    -- upvalues: l__Utility__7 (copy)
    local l__RawModifiers__9 = p69.RawModifiers;
    local v70 = {};
    local v71 = {};
    while true do
        if #v70 >= #l__RawModifiers__9 then
            return v71;
        end;
        local v72 = false;
        for _, v73 in l__Utility__7.dipairs(table.unpack(p68)) do
            local v74;
            if v73.RawModifiers then
                v74 = {};
                for v79, v80 in ipairs(v73.RawModifiers) do
                    if not l__Utility__7.Contains(v70, v80) then
                        table.insert(v74, v80);
                    end;
                end;
                if #v74 == 1 and l__Utility__7.Contains(l__RawModifiers__9, v74[1]) then
                    table.insert(v71, v74[1]);
                    table.insert(v70, v74[1]);
                    v72 = true;
                    break;
                end;
            elseif v73.Modifiers then
                local v77 = {};
                for v78, _ in v73.Modifiers do
                    table.insert(v77, v78);
                end;
                v73.RawModifiers = v77;
                v74 = {};
                for v79, v80 in ipairs(v73.RawModifiers) do
                    if not l__Utility__7.Contains(v70, v80) then
                        table.insert(v74, v80);
                    end;
                end;
                if #v74 == 1 and l__Utility__7.Contains(l__RawModifiers__9, v74[1]) then
                    table.insert(v71, v74[1]);
                    table.insert(v70, v74[1]);
                    v72 = true;
                    break;
                end;
            end;
        end;
        if not v72 then
            return nil;
        end;
    end;
end;
function u5.IsADirectMatch(p81, p82) --[[ Line: 309 ]]
    -- upvalues: l__Utility__7 (copy), u4 (copy), u5 (copy)
    local v83 = l__Utility__7.CreateFuzzyFinder(p81);
    for _, v84 in l__Utility__7.dipairs(p82.Recipes, u4 or (u5.Extras[p82.RecipeName] or {})) do
        if l__Utility__7.TableEq(v84.Modifiers, v83) then
            return true;
        end;
    end;
    return false;
end;
function u5.FindRecipeMatch(p85, p86) --[[ Line: 319 ]]
    -- upvalues: l__Utility__7 (copy), u4 (copy), u5 (copy)
    local v87 = l__Utility__7.CreateFuzzyFinder(p85);
    for _, v88 in l__Utility__7.dipairs(p86.Recipes, u4 or (u5.Extras[p86.RecipeName] or {})) do
        local v89 = true;
        for v90, _ in v87 do
            if not v88.Modifiers[v90] then
                v89 = false;
            end;
        end;
        if v89 then
            return true, v88;
        end;
    end;
    return false;
end;
function u5.IsValidOption(p91, u92, u93) --[[ Line: 333 ]]
    -- upvalues: l__Mince__5 (copy), l__Utility__7 (copy), u5 (copy), l__Unify__6 (copy)
    if not u92.CannotBeUsed then
        if u93.Garnish and u93.Garnish[u92.RecipeName] then
            return {};
        end;
        local l__Extender__10 = u92.Extender;
        if l__Extender__10 then
            l__Extender__10 = u92.Extender.IgnoreEquippedBlocked;
        end;
        local v94 = {};
        local u95 = {};
        local u96 = {};
        for v97, _ in p91:GetAttributes() do
            if l__Mince__5.Config.Modifiers[v97] then
                v94[v97] = true;
                u95[v97] = true;
                table.insert(u96, l__Mince__5.Config.Modifiers[v97]);
            end;
        end;
        u95[u93.Name] = true;
        if not l__Extender__10 and v94[u93.Name] then
            return false;
        end;
        local function v101() --[[ Line: 361 ]]
            -- upvalues: u92 (copy), u96 (copy), u93 (copy), u95 (copy)
            local v98, v99 = pcall(function() --[[ Line: 362 ]]
                -- upvalues: u92 (ref), u96 (ref), u93 (ref)
                return u92.ValidatingExtender:CustomValidate(u96, u93);
            end);
            if v98 then
                if v99 then
                    local v100 = typeof(v99) == "table";
                    assert(v100, "CustomValidate must return a sub recipe! {Name= \'Tool Name\', ALC=0, ETC...}");
                    assert(v99.Name, "SubRecipe.Name is required!");
                    v99.Modifiers = u95;
                    return v99;
                end;
            else
                warn((`Validation failed for recipe '{u92.RecipeName}' because an error occured!`));
                warn(v99);
            end;
        end;
        local v102 = u92.ValidatingExtender and (u92.ValidatingExtender.CustomValidate and u92.ValidatingExtender.WhenToDoCustomValidate == "Before") and v101();
        if v102 then
            return v102;
        end;
        for _, v103 in l__Utility__7.dipairs(u92.Recipes, u5.Extras[u92.RecipeName] or {}) do
            if (not v103.ID or (not v103.ExpireOn or l__Unify__6.GetServerTimeUntil(v103.ExpireOn) >= 0)) and v103.Modifiers[u93.Name] then
                local v104 = true;
                for v105, _ in v94 do
                    if not v103.Modifiers[v105] then
                        v104 = false;
                    end;
                end;
                if v104 and l__Utility__7.TableEq(u95, v103.Modifiers) then
                    return v103;
                end;
            end;
        end;
        return u92.ValidatingExtender and (u92.ValidatingExtender.CustomValidate and (u92.ValidatingExtender.WhenToDoCustomValidate == "After" and v101())) or false;
    end;
end;
function u5.GetCountOfRecipe(u106) --[[ Line: 418 ]]
    -- upvalues: l__Backpack__8 (copy)
    local u107 = 0;
    l__Backpack__8.IterateBackpackItems(function(p108) --[[ Line: 420 ]]
        -- upvalues: u106 (copy), u107 (ref)
        if p108.Tool:GetAttribute("Recipe") == u106.RecipeName then
            u107 = u107 + 1;
        end;
    end);
    return u107;
end;
function u5.GetTaggedTool(u109, u110) --[[ Line: 429 ]]
    -- upvalues: l__Backpack__8 (copy), l__CollectionService__1 (copy)
    local u111 = nil;
    l__Backpack__8.IterateBackpackItems(function(p112) --[[ Line: 431 ]]
        -- upvalues: l__CollectionService__1 (ref), u109 (copy), u110 (copy), u111 (ref)
        if l__CollectionService__1:HasTag(p112.Tool, u109) and p112.Tool:GetAttribute("Recipe") == u110 then
            u111 = p112.Tool;
        end;
    end);
    return u111;
end;
function u5.GetEquippedDrinkTool() --[[ Line: 441 ]]
    -- upvalues: l__Backpack__8 (copy), l__Mince__5 (copy)
    local v113 = l__Backpack__8.GetEquipped();
    local v114;
    if v113 then
        v114 = l__Mince__5.Config.Recipes[v113:GetAttribute("Recipe") or v113.Name];
    else
        v114 = v113;
    end;
    return v113, v114;
end;
function u5.GetEquippedTool() --[[ Line: 448 ]]
    -- upvalues: l__Backpack__8 (copy)
    return l__Backpack__8.GetEquipped();
end;
function u5.CallRecipeExtenderMethod(_, _) --[[ Line: 452 ]] end;
function u5.SetupDrinkRelatedConfigs() --[[ Line: 456 ]]
    -- upvalues: l__Mince__5 (copy), l__Utility__7 (copy)
    for v115, v116 in l__Mince__5.Config.Machines do
        v116.MachineName = v115;
        if v116.AllowedUses then
            v116.AllowedUses = l__Utility__7.CreateFuzzyFinder(v116.AllowedUses);
        end;
        if v116.Modifier and not l__Mince__5.Config.Modifiers[v116.Modifier] then
            l__Mince__5.Config.Modifiers[v116.Modifier] = {};
        end;
    end;
end;
function u5.GetAnimations() --[[ Line: 475 ]]
    -- upvalues: u5 (copy)
    return u5.LoadedAnimations;
end;
function u5.GetHumanoid(_) --[[ Line: 479 ]]
    -- upvalues: u5 (copy)
    return u5.Humanoid;
end;
function u5.NewCharacter(p117) --[[ Line: 483 ]]
    -- upvalues: u5 (copy), l__ReplicatedStorage__2 (copy)
    local l__Humanoid__11 = p117:WaitForChild("Humanoid");
    u5.Humanoid = l__Humanoid__11;
    local v118 = l__ReplicatedStorage__2.Assets.DrinkAnimation:Clone();
    v118.Parent = p117;
    task.wait();
    task.wait();
    u5.LoadedAnimations = {};
    for _, v119 in v118:GetChildren() do
        u5.LoadedAnimations[v119.Name] = l__Humanoid__11:LoadAnimation(v119);
    end;
    l__Humanoid__11.Died:Connect(function() --[[ Line: 497 ]]
        -- upvalues: u5 (ref)
        u5.LoadedAnimations = nil;
    end);
end;
function u5.SetupUI() --[[ Line: 503 ]]
    -- upvalues: u5 (copy), u3 (copy)
    u5.MainPriority = u3.GetScreenGui("MainPriority");
    u5.Progress = u3.GetScreenGui("Progress");
    u5.Container = u5.Progress.Container;
    u5.Inspect = u5.MainPriority.Inspect;
    u5.Container.Visible = false;
    u5.Inspect.Visible = false;
end;
function u5.Setup() --[[ Line: 513 ]]
    -- upvalues: u5 (copy), l__LocalPlayer__4 (copy)
    u5.SetupUI();
    l__LocalPlayer__4.CharacterAdded:Connect(u5.NewCharacter);
    if l__LocalPlayer__4.Character then
        task.defer(u5.NewCharacter, l__LocalPlayer__4.Character);
    end;
end;
u5.SetupDrinkRelatedConfigs();
return u5;
