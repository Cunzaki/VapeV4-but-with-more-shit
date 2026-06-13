-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.DrinkRecipes
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Maid__2 = require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Dropdown__4 = require(l__ReplicatedStorage__1.Modules.Dropdown);
local u1 = l__Mince__3:Get("DrinkHandler");
local u2 = l__Mince__3:Get("InterfaceHandler");
local u3 = {
    RecipeOptions = {
        "Small Glass",
        "Fancy Glass",
        "Vine Glass",
        "Glass",
        "Mug"
    },
    ConvertRecipesName = {
        ["Small Glass"] = "SmallGlass",
        ["Fancy Glass"] = "FancyGlass",
        ["Vine Glass"] = "VineGlass"
    },
    RecipesMaid = l__Maid__2.new()
};
local u4 = {};
u4.__index = u4;
function u4.new(...) --[[ Line: 28 ]]
    -- upvalues: u4 (copy)
    local v5 = setmetatable({}, u4);
    v5:Init(...);
    return v5;
end;
function u4.Init(p6, p7, p8) --[[ Line: 34 ]]
    p6.Recipe = p8;
    p6.SubRecipe = p7;
    p6:CreateGui();
end;
function u4.CreateGui(p9) --[[ Line: 41 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u1 (copy), l__Mince__3 (copy), u3 (copy)
    p9.GUI = l__ReplicatedStorage__1.Assets.Interface.DrinkRecipeItem:Clone();
    p9.GUI.DrinkName.Text = p9.SubRecipe.Name or "SubRecipe.Name";
    local v10 = u1.GetOrderForModifiers({ p9.Recipe.Recipes }, {
        RawModifiers = p9.SubRecipe.RawModifiers
    });
    local v11 = v10 or p9.SubRecipe.RawModifiers;
    local v12 = #v11;
    for v13, v20 in v11 do
        local u15 = l__Mince__3.Config.Modifiers[v20];
        local v16 = `There is no Modifier by the name of '{v20}'!`;
        assert(u15, v16);
        local v17 = l__ReplicatedStorage__1.Assets.Interface.Square:Clone();
        local v18, v19 = pcall(function() --[[ Line: 58 ]]
            -- upvalues: u1 (ref), u15 (copy)
            return u1.GetModifierViewport(u15, true);
        end);
        if v18 and v19 then
            v19.Parent = v17;
        else
            v17.Missing.Visible = true;
            local l__DrinkName__5 = v17.Missing.DrinkName;
            if u15 then
                local v20 = u15.HoverName or v20;
            end;
            l__DrinkName__5.Text = v20;
        end;
        v17.Parent = p9.GUI.Modifiers;
        if v10 then
            v17.LayoutOrder = v13;
            v17.Direct.Visible = v13 ~= v12;
        else
            v17.LayoutOrder = u15.Order or 0;
        end;
    end;
    p9.GUI.LayoutOrder = #p9.SubRecipe.RawModifiers;
    p9.GUI.Parent = u3.Scroll;
    u3.RecipesMaid:Add(p9.GUI);
end;
function u3.LoadRecipesFor(p21) --[[ Line: 88 ]]
    -- upvalues: l__Mince__3 (copy), u3 (copy), u4 (copy)
    local v22 = l__Mince__3.Config.Recipes[p21];
    local v23 = `DrinkRecipes---> Attempted to load recipes for '{p21}'`;
    assert(v22, v23);
    assert(v22.Recipes, "The recipe must have sub recipes!!!!!!");
    u3.RecipesMaid:Clean();
    for _, v24 in v22.Recipes do
        u4.new(v24, v22);
    end;
end;
function u3.SetupGui() --[[ Line: 100 ]]
    -- upvalues: u3 (copy), l__Dropdown__4 (copy), u2 (copy)
    u3.RecipeDropdown = l__Dropdown__4.SetupDropbox(u3.MainFrame.DropdownBox, u3.RecipeOptions);
    function u3.RecipeDropdown.Switched() --[[ Line: 102 ]]
        -- upvalues: u3 (ref)
        u3.LoadRecipesFor(u3.ConvertRecipesName[u3.RecipeDropdown.SelectedText] or u3.RecipeDropdown.SelectedText);
    end;
    u2.NewButton(u3.MainFrame.CloseButton).Activated:Connect(u3.Interface.Close);
    u2.AutoSizeScrollingFrame(u3.Scroll);
end;
function u3.Setup() --[[ Line: 114 ]]
    -- upvalues: u3 (copy), u2 (copy)
    u3.Interface = u2.Get("DrinkRecipes");
    u3.MainFrame = u3.Interface.TweenFrame;
    u3.Scroll = u3.MainFrame.Scroll;
    u3.SetupGui();
    u3.LoadRecipesFor("SmallGlass");
end;
return u3;
