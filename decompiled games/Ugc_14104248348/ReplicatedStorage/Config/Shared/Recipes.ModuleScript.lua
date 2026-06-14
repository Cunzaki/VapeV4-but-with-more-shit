-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Modifiers__1 = require(script.Parent.Modifiers);
local u1 = {
    ExtenderTypeChecking = {
        IgnoreEquippedBlocked = "boolean",
        ForceIgnoreNormalRecipes = "boolean",
        WhenToDoCustomValidate = { "Before", "After" }
    }
};
local u2 = {};
u2.__index = u2;
function u2.new(p3) --[[ Line: 13 ]]
    -- upvalues: u2 (copy)
    assert(p3, "Prototyping is need forsure!");
    local v4 = setmetatable(p3, u2);
    v4:Init();
    return v4;
end;
function u2.Init(p5) --[[ Line: 20 ]]
    -- upvalues: u1 (copy)
    if not p5.RecipeMatches then
        error("An FATAL problem with a recipe extender has occured! It\'s missing the [RecipeMatches] Index.");
    end;
    for v6, v7 in u1.ExtenderTypeChecking do
        if p5[v6] then
            u1.TypeCheckValue({ v7 }, p5[v6]);
        end;
    end;
    if p5.GenericModifierMatches then
        for v8, v9 in p5.GenericModifierMatches do
            if typeof(v9) == "table" then
                p5.GenericModifierMatches[v8] = {};
                for v10, v11 in v9 do
                    p5.GenericModifierMatches[v8][v11] = v10;
                end;
            end;
        end;
    end;
    if p5.GenericRecipe then
        p5.GenericRecipeOrders = {};
        for v12, v13 in p5.GenericRecipe do
            p5.GenericRecipeOrders[v12] = {};
            for v14, v15 in v13 do
                p5.GenericRecipeOrders[v12][v14] = { v15, v14 };
            end;
        end;
    end;
    p5.RecipeMatches = u1.CreateFinder(p5.RecipeMatches);
end;
function u2.GetGenericMatchWithModifiers(p16, p17) --[[ Line: 56 ]]
    for _, v18 in p16.GenericRecipeOrders do
        if #v18 == #p17 then
            local v19 = table.clone(v18);
            local v20 = true;
            for v21, v22 in p17 do
                local v23 = false;
                for _, v24 in v18 do
                    local v25 = p16.GenericModifierMatches[v24];
                    local v26;
                    if v25 then
                        if typeof(v25) == "function" then
                            v26 = v25(v22);
                        elseif typeof(v25) == "table" then
                            v26 = v25[v22.Name];
                        else
                            v26 = nil;
                        end;
                    else
                        warn((`This is not a valid registered generic modifier {v24}`));
                        v26 = false;
                    end;
                    if v26 then
                        table.remove(v19, v21);
                        v23 = true;
                        break;
                    end;
                end;
                if not v23 then
                    v20 = false;
                end;
            end;
            if v20 then
                return v18;
            end;
        end;
    end;
end;
function u2.GetModifiers(_, p27) --[[ Line: 103 ]]
    -- upvalues: l__Modifiers__1 (copy)
    local v28 = {};
    for v29, _ in p27:GetAttributes() do
        if l__Modifiers__1[v29] then
            table.insert(v28, l__Modifiers__1[v29]);
        end;
    end;
    return v28;
end;
function u2.HasModifier(_, p30, p31) --[[ Line: 116 ]]
    -- upvalues: l__Modifiers__1 (copy)
    local v32 = l__Modifiers__1[p31];
    local v33 = `'{p31}' is not a valid modifier name!`;
    assert(v32, v33);
    return p30:GetAttribute(p31);
end;
function u1.CreateFinder(p34) --[[ Line: 121 ]]
    local v35 = {};
    for _, v36 in ipairs(p34) do
        v35[v36] = true;
    end;
    return v35;
end;
function u1.TypeCheckValue(p37, ...) --[[ Line: 131 ]]
    local v38 = { ... };
    if #v38 ~= #p37 then
        error("Greater or lesser amount of required paramaters.");
    end;
    for v39 = 1, #p37 do
        if typeof(p37[v39]) == "table" then
            local v40 = "";
            local v41 = false;
            for v42, v43 in p37[v39] do
                v41 = v43 == v38[v39] and true or v41;
                v40 = v40 .. tostring(v43);
                if v42 ~= #p37[1] then
                    v40 = v40 .. ", ";
                end;
            end;
            if not v41 then
                error((`Expected Value(s) {v40} for ({p37.ValidatingArr and p37.ValidatingArr[v39] or (p37.Validating or "paramater")})[{v39}] instead got '{v38[v39]}'.`));
            end;
        else
            local v44 = v38[v39];
            local v45 = typeof(v44);
            if v45 == "Instance" then
                v45 = v44.ClassName;
            end;
            if v45 == "table" and v44.__type then
                v45 = v44.__type;
            end;
            local v46 = v45 == p37[v39];
            if typeof(v38[v39]) ~= p37[v39] and not v46 then
                error((`Expected '{p37[v39]}' as ({p37.ValidatingArr and p37.ValidatingArr[v39] or (p37.Validating or "paramater")})[{v39}] instead got '{v45}'.`));
            end;
        end;
    end;
    return ...;
end;
function u1.Deepcopy(p47) --[[ Line: 188 ]]
    -- upvalues: u1 (copy)
    if type(p47) ~= "table" then
        return p47;
    end;
    local v48 = {};
    for v49, v50 in next, p47 do
        v48[u1.Deepcopy(v49)] = u1.Deepcopy(v50);
    end;
    local l__Deepcopy__2 = u1.Deepcopy;
    local v51 = getmetatable(p47);
    setmetatable(v48, l__Deepcopy__2(v51));
    return v48;
end;
function u1.Merge(p52, p53) --[[ Line: 203 ]]
    -- upvalues: u1 (copy)
    for v54, v55 in pairs(p53) do
        if type(v55) == "table" then
            if type(p52[v54] or false) == "table" then
                u1.Merge(p52[v54] or {}, p53[v54] or {});
            else
                p52[v54] = v55;
            end;
        else
            p52[v54] = v55;
        end;
    end;
    return p52;
end;
function u1.Construct() --[[ Line: 223 ]]
    -- upvalues: u1 (copy), u2 (copy)
    local v56 = {};
    for _, v57 in script:GetChildren() do
        if v57:IsA("ModuleScript") then
            for v58, v59 in require(v57) do
                if v56[v58] then
                    for v60, v61 in v59 do
                        v56[v58][v60] = v61;
                    end;
                else
                    v56[v58] = v59;
                end;
            end;
        end;
    end;
    for v62, v63 in v56 do
        v63.RecipeName = v62;
        v63.Action = v63.Action or `Grabbing {v63.Name}`;
        v63.ActionTime = v63.ActionTime or 0.5;
        if v63.Recipes then
            for _, v64 in v63.Recipes do
                if v64.Modifiers then
                    v64.RawModifiers = u1.Deepcopy(v64.Modifiers);
                    v64.Modifiers = u1.CreateFinder(v64.RawModifiers);
                end;
            end;
        end;
    end;
    for v65, v66 in v56 do
        if v66.Copies then
            local v67 = v56[v66.Copies];
            if v67 then
                local v68 = u1.Deepcopy(v67.Recipes);
                for v69 = #v68, 1, -1 do
                    if v66.CopyFunction and v66.CopyFunction(v68[v69]) then
                        table.remove(v68, v69);
                    end;
                end;
                v66.Recipes = v68;
            else
                warn((`{v65} tried to copy '{v66.Copies}' but it did not exist!`));
            end;
        end;
    end;
    for _, v70 in script.Extenders:GetChildren() do
        local u71 = u2.new(require(v70));
        u71.Name = v70.Name or "RecipeExtender";
        if not u71.Disabled then
            local function v73(p72) --[[ Line: 287 ]]
                -- upvalues: u71 (copy)
                p72.Extenders = p72.Extenders or {};
                table.insert(p72.Extenders, u71);
                if u71.CustomValidate then
                    if p72.ValidatingExtender then
                        error((`Failed to create receipe extenders because there are multiple extenders on the same recipe which use :CustomValidate(). Broke at '{ExtenderModule.Name}'`));
                    end;
                    p72.ValidatingExtender = u71;
                end;
            end;
            for v74, v75 in v56 do
                v75.Name = v75.Name or `Recipe.Name[{v74}]`;
                if u71.RecipeMatches[v74] then
                    v73(v75);
                end;
            end;
        end;
    end;
    return v56;
end;
return u1.Construct();
