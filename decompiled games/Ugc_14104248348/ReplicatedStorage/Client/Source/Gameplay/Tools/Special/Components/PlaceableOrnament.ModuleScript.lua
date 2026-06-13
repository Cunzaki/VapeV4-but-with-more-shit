-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Special.Components.PlaceableOrnament
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local l__Players__2 = game:GetService("Players");
game:GetService("Debris");
local l__TweenService__3 = game:GetService("TweenService");
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.SpringVector3);
local u1 = l__Mince__4:Get("ToolHandler");
local u2 = l__Mince__4:Get("SelectInteractor");
l__Mince__4:Get("NotifPrompt");
local u3 = l__Mince__4:Get("ConfirmPrompt");
local u4 = l__Mince__4:Get("Notices");
local u5 = l__Mince__4:GetEvent("ReportOrnament");
local u6 = l__Mince__4:GetFunction("PlaceOrnament");
l__Players__2.LocalPlayer:GetMouse();
local u7 = {
    MaxSpots = 300,
    MinPrice = 10,
    MaxPrice = 30000,
    OrnamentSpawns = {},
    Tags = { "PlaceableOrnament" },
    Animations = {}
};
local v8 = l__Mince__4.Component({
    Tag = "PlacedOrnament"
});
function u7.SetupOrnamentSpawn(u9) --[[ Line: 37 ]]
    -- upvalues: u3 (copy), u7 (copy), u2 (copy), l__TweenService__3 (copy)
    local v11 = {
        HoverName = "Place Ornament",
        HitCollider = u9,
        Interact = function(_, p10) --[[ Name: Interact, Line 43 ]]
            -- upvalues: u3 (ref), u7 (ref), u9 (copy)
            u3.Display(`Would you like to place your ornament here for {u7.CalcPrice()} coins?`, function() --[[ Line: 44 ]]
                -- upvalues: u7 (ref), u9 (ref)
                u7.TryPlaceOrnament(u9);
            end);
            p10();
        end,
        OnHover = function(_) --[[ Name: OnHover, Line 51 ]]
            -- upvalues: u9 (copy)
            return not u9:GetAttribute("Taken");
        end
    };
    v11.Interactor = u2.NewInteractionClass(v11);
    v11.Tween = l__TweenService__3:Create(u9, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
        Transparency = 0
    });
    return v11;
end;
function u7.CalcPrice() --[[ Line: 64 ]]
    -- upvalues: u7 (copy)
    local v12 = 0;
    for _, v13 in u7.Spots:GetChildren() do
        if not v13:GetAttribute("Taken") then
            v12 = v12 + 1;
        end;
    end;
    return math.floor(u7.MinPrice * ((u7.MaxPrice / u7.MinPrice) ^ (1 / (u7.MaxSpots - 1))) ^ (u7.MaxSpots - v12));
end;
function u7.TryPlaceOrnament(p14) --[[ Line: 80 ]]
    -- upvalues: u6 (copy), u7 (copy), u4 (copy)
    local v15 = u6:Invoke(u7.CurrentTool, p14);
    if typeof(v15) == "string" then
        u4.Error(v15);
    else
        u4.CreateNotice("Ornament Saved!");
    end;
end;
function u7.Setup() --[[ Line: 91 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u7 (copy), u1 (copy)
    local l__OrnamentSpawns__5 = l__ReplicatedStorage__1.Assets.Misc:WaitForChild("OrnamentSpawns");
    for _, v16 in l__OrnamentSpawns__5:GetChildren() do
        u7.OrnamentSpawns[v16] = u7.SetupOrnamentSpawn(v16);
    end;
    u7.Spots = l__OrnamentSpawns__5;
    u1.Component(u7);
end;
function u7.Equipped(p17) --[[ Line: 102 ]]
    -- upvalues: u7 (copy)
    u7.Spots.Parent = game.Workspace;
    u7.CurrentTool = p17.Tool;
    for _, v18 in u7.OrnamentSpawns do
        if v18.HitCollider:GetAttribute("Taken") then
            if v18.Tween then
                v18.Tween:Destroy();
            end;
            v18.HitCollider.Transparency = 1;
        else
            v18.Tween:Play();
        end;
    end;
end;
function u7.Unequipped(_) --[[ Line: 118 ]]
    -- upvalues: u7 (copy)
    u7.Spots.Parent = game.ReplicatedStorage.Assets.Misc;
    u7.CurrentTool = nil;
    for _, v19 in u7.OrnamentSpawns do
        if v19.Tween then
            v19.Tween:Pause();
        end;
    end;
end;
function v8.Construct(p20) --[[ Line: 129 ]]
    -- upvalues: u3 (copy), u5 (copy), u2 (copy)
    local l__Instance__6 = p20.Instance;
    local v22 = {
        HoverName = `{l__Instance__6:GetAttribute("PlayerName") or ""}'s Ornament`,
        HitCollider = l__Instance__6:WaitForChild("Danglybit"),
        Target = l__Instance__6,
        Interact = function(_, p21) --[[ Name: Interact, Line 138 ]]
            -- upvalues: u3 (ref), u5 (ref), l__Instance__6 (copy)
            u3.Display("Are you sure you want to report this ornament? False reports are bannable!", function() --[[ Line: 139 ]]
                -- upvalues: u5 (ref), l__Instance__6 (ref)
                u5:Fire(l__Instance__6);
            end);
            p21();
        end
    };
    u2.NewInteractionClass(v22);
end;
return u7;
