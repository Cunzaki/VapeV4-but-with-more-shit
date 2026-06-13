-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Special-Event-World.WitchesHut
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("ContextActionService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("TweenService");
game:GetService("Players");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local v1 = l__Mince__2:GetEvent("Couldron");
local u2 = v1:Extend("AddIngredient");
local u3 = l__Mince__2:GetFunction("GetPotion");
local u4 = v1:Extend("FlushCouldron");
local u5 = l__Mince__2:Get("Notices");
local u6 = l__Mince__2:Get("ConfirmPrompt");
local u7 = l__Mince__2:Get("SelectInteractor");
local u8 = l__Mince__2:Get("InterfaceHandler");
local u9 = l__Mince__2:Get("OpeningHandler");
local u10 = l__Mince__2:Get("SoundHandler");
local v11 = l__Mince__2.Component({
    Tag = "Couldron"
});
local v12 = l__Mince__2.Component({
    Tag = "WitchesBook"
});
function v11.Construct(p13) --[[ Line: 29 ]]
    -- upvalues: l__Mince__2 (copy), u6 (copy), u4 (copy), u3 (copy), u5 (copy), u9 (copy), u2 (copy), u7 (copy)
    local v14 = {
        HoverName = "Use",
        Name = "Use",
        Model = p13.Instance,
        Target = p13.Instance,
        HitCollider = p13.Instance.Part
    };
    local l__Part__3 = p13.Instance.Part;
    function v14.Interact(_, p15) --[[ Line: 40 ]]
        -- upvalues: l__Mince__2 (ref), u6 (ref), u4 (ref), l__Part__3 (copy), u3 (ref), u5 (ref), u9 (ref), u2 (ref)
        warn("Inteact being called?");
        local l__Humanoid__4 = l__Mince__2.Config.Humanoid;
        if l__Humanoid__4 then
            local u16 = l__Humanoid__4.Parent:FindFirstChildOfClass("Tool");
            if not u16 then
                u6.Display("Are you sure you want to flush the couldron?", function() --[[ Line: 47 ]]
                    -- upvalues: u4 (ref), l__Part__3 (ref)
                    u4:Fire();
                    l__Part__3.Flush:Play();
                end);
                task.wait(1);
                return p15();
            end;
            if u16:HasTag("PotionBottle") then
                warn("invoking.?!");
                local v17 = u3:Invoke();
                if not v17 then
                    u5.Error("There is nothing in the couldron!");
                    return p15();
                end;
                print(v17);
                local v18 = l__Mince__2.Config.Inventory[string.split(v17, ".")[1]][string.split(v17, ".")[2]];
                print(v18);
                u9.DoItemGain({
                    ItemName = v18.Name,
                    IVID = v18.IVID,
                    Colors = { Color3.new(0.0901961, 0.0509804, 0.0980392), Color3.new(0.101961, 0.00784314, 0.113725) }
                });
                return p15();
            end;
            if not u16:HasTag("CanBePotioned") then
                u5.Error("This item cannot be put in!");
                return p15();
            end;
            u6.Display("Are you sure you want to put this in the couldron? It will be removed from your inventory!", function() --[[ Line: 78 ]]
                -- upvalues: u2 (ref), u16 (copy), l__Part__3 (ref)
                u2:Fire(u16.Name);
                l__Part__3.Splash:Play();
                u16:Destroy();
            end);
            task.wait(1);
            p15();
        end;
    end;
    u7.NewInteractionClass(v14);
end;
function v12.NavigateToPage(p19, p20) --[[ Line: 92 ]]
    -- upvalues: l__Mince__2 (copy), u10 (copy)
    local l__WitchBookPages__5 = l__Mince__2.Config.WitchBookPages;
    local l__TweenFrame__6 = p19.Interface.TweenFrame;
    local v21 = #l__WitchBookPages__5 < p20 and 1 or (p20 < 1 and (#l__WitchBookPages__5 or p20) or p20);
    p19.CurrentPage = v21;
    l__TweenFrame__6.Page.Image = l__WitchBookPages__5[v21];
    u10.PlaySound("page_turn");
    l__TweenFrame__6.PositionIndicator.Text = `{v21}/{#l__WitchBookPages__5}`;
end;
function v12.Construct(u22) --[[ Line: 105 ]]
    -- upvalues: u8 (copy), u7 (copy)
    local u23 = u8.Get("WitchBook");
    u22.Interface = u23;
    local l__TweenFrame__7 = u23.TweenFrame;
    u8.NewButton(l__TweenFrame__7.PositionIndicator.Left).Activated:Connect(function() --[[ Line: 113 ]]
        -- upvalues: u22 (copy)
        u22:NavigateToPage(u22.CurrentPage - 1);
    end);
    u8.NewButton(l__TweenFrame__7.PositionIndicator.Right).Activated:Connect(function() --[[ Line: 117 ]]
        -- upvalues: u22 (copy)
        u22:NavigateToPage(u22.CurrentPage + 1);
    end);
    u8.NewButton(l__TweenFrame__7.Bottom.Right).Activated:Connect(function() --[[ Line: 121 ]]
        -- upvalues: u23 (copy)
        u23:Close();
    end);
    u7.NewInteractionClass({
        HoverName = "Read",
        Name = "Read",
        Model = u22.Instance,
        Target = u22.Instance,
        HitCollider = u22.Instance.Table,
        Interact = function(_, p24) --[[ Name: Interact, Line 133 ]]
            -- upvalues: u22 (copy), u23 (copy)
            u22:NavigateToPage(1);
            u23:Open();
            p24();
        end
    });
end;
return v12;
