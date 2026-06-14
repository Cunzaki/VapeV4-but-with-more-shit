-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Aqaurium.AquaticBoard
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Database__3 = require(l__ReplicatedStorage__1.Assets.Library.Database);
local u1 = l__Mince__2:Get("InterfaceHandler");
local u2 = l__Mince__2.Component({
    Tag = "AquaticBoard"
});
function u2.PreviewCreature(_, p3) --[[ Line: 19 ]]
    -- upvalues: u2 (copy)
    local v4 = {
        Family = "FamilyLabel",
        Diet = "DietLabel",
        Size = "SizeLabel",
        Depths = "DepthsLabel"
    };
    for v5, v6 in {
        FishName = "Name",
        FishScienceName = "ScientificName"
    } do
        u2.Interface.TweenFrame[v5].Text = p3[v6] or `{v5}.{v6}`;
    end;
    for v7, v8 in v4 do
        u2.Interface.TweenFrame[v8].Text = `<b>{v7}:</b> {p3[v7] or `{p3.Name or "CreatureInfo.Name"}.{v7}`}`;
    end;
    u2.Interface.TweenFrame.Bottom.Descriptor.Text = p3.Facts[math.random(1, #p3.Facts)];
    u2.Interface.TweenFrame.View.Icon.Image = p3.Icon.ImageID;
    u2.Interface.Open();
end;
function u2.CreatePage(u9, u10) --[[ Line: 47 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u1 (copy)
    u9.Position = u9.Position + 1;
    if u9.Position > 6 then
        u9.Position = 1;
        u9:CreateGroup();
    end;
    local v11 = {
        GUI = l__ReplicatedStorage__1.Assets.Interface.AquaticBoard.FishInfo:Clone()
    };
    local v12 = (u10.Icon.ImageID or ""):gsub("%D", "");
    local v13 = tonumber(v12);
    v11.GUI.FishName.Text = u10.Name;
    v11.GUI.FishButton.Image = `rbxthumb://type=Asset&id={v13}&w=150&h=150`;
    v11.GUI.Parent = u9.ThisGroup;
    u1.ScaleTextPercentage(v11.GUI.FishName, 0.2);
    u1.NewButton(v11.GUI.FishButton).Activated:Connect(function() --[[ Line: 66 ]]
        -- upvalues: u9 (copy), u10 (copy)
        u9:PreviewCreature(u10);
    end);
end;
function u2.CreateGroup(p14) --[[ Line: 72 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy)
    local v15 = l__ReplicatedStorage__1.Assets.Interface.AquaticBoard.Scroll:Clone();
    v15.Parent = p14.SurfaceGui.Container.PageContainer;
    p14.ThisGroup = v15;
end;
function u2.SetupPages(p16) --[[ Line: 80 ]]
    -- upvalues: l__Database__3 (copy)
    for _, v17 in l__Database__3 do
        if v17.Info then
            p16:CreatePage(v17.Info);
        end;
    end;
end;
function u2.Destroyed(p18) --[[ Line: 88 ]]
    for _, v19 in p18.Pages do
        v19.GUI:Destroy();
    end;
    p18.Pages = nil;
end;
function u2.Construct(u20) --[[ Line: 96 ]]
    -- upvalues: u1 (copy)
    u20.SurfaceGui = u20.Instance:WaitForChild("Board").SurfaceGui;
    u20.Position = 0;
    u20.Pages = {};
    u20.Groups = {};
    u20:CreateGroup();
    u20:SetupPages();
    u1.NewButton(u20.SurfaceGui.Container.Left).Activated:Connect(function() --[[ Line: 106 ]]
        -- upvalues: u20 (copy)
        u20.SurfaceGui.Container.PageContainer.UIPageLayout:Previous();
    end);
    u1.NewButton(u20.SurfaceGui.Container.Right).Activated:Connect(function() --[[ Line: 110 ]]
        -- upvalues: u20 (copy)
        u20.SurfaceGui.Container.PageContainer.UIPageLayout:Next();
    end);
end;
function u2.Setup(_) --[[ Line: 116 ]]
    -- upvalues: u2 (copy), u1 (copy)
    u2.Interface = u1.Get("FishPreview");
    u1.NewButton(u2.Interface.TweenFrame.CloseButton).Activated:Connect(function() --[[ Line: 119 ]]
        -- upvalues: u2 (ref)
        u2.Interface.Close();
    end);
end;
return u2;
