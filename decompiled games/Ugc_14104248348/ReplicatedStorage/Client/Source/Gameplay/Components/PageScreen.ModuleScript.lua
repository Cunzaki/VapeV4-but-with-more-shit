-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.PageScreen
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
l__Mince__2:Get("BindManager");
l__Mince__2:Get("SoundHandler");
l__Mince__2:Get("InterfaceHandler");
l__Mince__2:Get("SelectInteractor");
local v1 = l__Mince__2.Component({
    Tag = "PageScreen"
});
function v1.Switch(u2) --[[ Line: 15 ]]
    u2.UIPageLayout:Next();
    if u2.IsActive then
        u2.HeadingThread = task.delay(u2.PageSwitchDelay or 5, function() --[[ Line: 20 ]]
            -- upvalues: u2 (copy)
            if u2.Dead == true then
            else
                u2:Switch();
            end;
        end);
    end;
end;
function v1.Construct(p3) --[[ Line: 26 ]]
    p3.IsActive = true;
    p3.SurfaceGui = p3.Instance:WaitForChild("SurfaceGui");
    p3.UIPageLayout = p3.SurfaceGui:WaitForChild("UIPageLayout");
    p3:Switch();
end;
function v1.Removing(p4) --[[ Line: 34 ]]
    p4.Dead = true;
    task.cancel(p4.HeadingThread);
end;
return v1;
