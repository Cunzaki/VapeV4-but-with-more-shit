-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Special.Tools.LunarNewYear.IntyLNYStickerGlass
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("Players");
local l__AssetService__2 = game:GetService("AssetService");
game:GetService("TweenService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.Signal);
l__Mince__3:Get("ToolHandler");
local u1 = l__Mince__3:Get("LNYIntyAnimator");
local u2 = l__Mince__3.Component({
    Tag = "IntyLNYStickerGlassz",
    CreationParents = { game.Workspace },
    Canvases = {
        Empty = true,
        Full = true,
        Finished = true
    }
});
function u2.Removing(p3) --[[ Line: 24 ]]
    -- upvalues: u1 (copy)
    u1:Discard();
    p3.StateChangeConnection:Disconnect();
end;
function u2.SetupSurfaceAppearances(p4) --[[ Line: 29 ]]
    -- upvalues: u2 (copy), l__AssetService__2 (copy), u1 (copy)
    p4.Appearances = {};
    for v5, _ in u2.Canvases do
        p4.Appearances[v5] = l__AssetService__2:CreateSurfaceAppearanceAsync({
            ColorMap = Content.fromObject(u1.Canvases[v5])
        });
        p4.Appearances[v5].AlphaMode = Enum.AlphaMode.Transparency;
        p4.Appearances[v5].Parent = script;
    end;
    p4.HasSurfaceAppearances = true;
end;
function u2.StateChanged(p6, p7) --[[ Line: 44 ]]
    p6.State = p7;
    if p6.ActiveAppearance then
        p6.ActiveAppearance.Parent = script;
    end;
    p6.ActiveAppearance = p6.Appearances[p6.State];
    p6.ActiveAppearance.Parent = p6.CupMesh;
end;
function u2.UpdateState(u8, p9) --[[ Line: 55 ]]
    local l__Instance__4 = u8.Instance;
    local l__Drink__5 = l__Instance__4:WaitForChild("Drink");
    local v10 = l__Instance__4:GetAttribute("CanDrink");
    if u8.Thread and p9 then
        task.cancel(u8.Thread);
        u8.Thread = nil;
    elseif u8.Thread and not p9 then
        return u8:StateChanged("Finished");
    end;
    if v10 or u8.State ~= "Full" then
        if v10 then
            u8:StateChanged("Full");
        else
            if u8.State ~= "Finished" then
                if l__Drink__5:GetAttribute("DizzyUntil") and workspace:GetServerTimeNow() < l__Drink__5:GetAttribute("DizzyUntil") then
                    u8:StateChanged("Finished");
                    u8.Thread = task.delay(l__Drink__5:GetAttribute("DizzyUntil") - workspace:GetServerTimeNow(), function() --[[ Line: 84 ]]
                        -- upvalues: u8 (copy)
                        u8:StateChanged("Empty");
                        u8.Thread = nil;
                    end);
                    return;
                end;
                u8:StateChanged("Empty");
            end;
        end;
    else
        u8:StateChanged("Finished");
        l__Drink__5:SetAttribute("DizzyUntil", workspace:GetServerTimeNow() + 18);
        u8.Thread = task.delay(18, function() --[[ Line: 73 ]]
            -- upvalues: u8 (copy)
            u8:StateChanged("Empty");
            u8.Thread = nil;
        end);
    end;
end;
function u2.Construct(u11) --[[ Line: 96 ]]
    -- upvalues: u1 (copy)
    repeat
        task.wait();
    until u1.Loaded;
    local l__Instance__6 = u11.Instance;
    local l__Handle__7 = l__Instance__6:WaitForChild("Handle");
    l__Handle__7.Transparency = 0;
    u11.CupMesh = l__Handle__7;
    u1:Use();
    if not u11.HasSurfaceAppearances then
        u11:SetupSurfaceAppearances();
    end;
    u11.StateChangeConnection = l__Instance__6:GetAttributeChangedSignal("CanDrink"):Connect(function() --[[ Line: 112 ]]
        -- upvalues: u11 (copy)
        u11:UpdateState(true);
    end);
    u11:UpdateState();
end;
return u2;
