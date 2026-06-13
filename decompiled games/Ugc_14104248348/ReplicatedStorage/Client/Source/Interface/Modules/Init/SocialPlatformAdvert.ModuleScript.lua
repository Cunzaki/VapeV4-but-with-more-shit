-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.Init.SocialPlatformAdvert
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("InterfaceHandler");
local u2 = l__Mince__2:GetFunction("GetExternalSocialLink");
local u3 = {};
function u3.Start(_) --[[ Line: 12 ]]
    -- upvalues: u2 (copy), u3 (copy)
    local v4, v5 = u2:Invoke();
    if v4 then
        u3.Interface.TweenFrame.SocialLink.Text = v4;
        warn("opening..?");
        u3.Interface.Stack(true);
        if u3.Interface.IsActive then
            u3.Interface.Closed:Wait();
        end;
    else
        warn((`Failed SocialPlatformAdvert:{v5}`));
    end;
end;
function u3.SetupButtons(_) --[[ Line: 29 ]]
    -- upvalues: u1 (copy), u3 (copy)
    u1.NewButton(u3.Interface.TweenFrame.CloseButton).Activated:Connect(function() --[[ Line: 30 ]]
        -- upvalues: u3 (ref)
        u3.Interface.Close();
    end);
end;
function u3.Setup(_) --[[ Line: 35 ]]
    -- upvalues: u3 (copy), u1 (copy)
    u3.Interface = u1.Get("MainPriority", "SocialPlatform");
    u3:SetupButtons();
end;
return u3;
