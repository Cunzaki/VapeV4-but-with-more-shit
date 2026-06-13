-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.AOp
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Queue__4 = require(l__ReplicatedStorage__1.Modules.Queue);
local u1 = l__Mince__3:Get("InterfaceHandler");
local u2 = {
    BeginDelay = 0.5,
    Tween = TweenInfo.new(0.5, Enum.EasingStyle.Quint),
    OpQueue = l__Queue__4.new()
};
function u2.Do(u3, ...) --[[ Line: 18 ]]
    -- upvalues: u2 (copy)
    local u4 = { ... };
    local v5 = task.delay(u2.BeginDelay, function() --[[ Line: 20 ]]
        -- upvalues: u2 (ref)
        u2.StartPause();
    end);
    local v6, v7 = pcall(function() --[[ Line: 23 ]]
        -- upvalues: u3 (copy), u4 (copy)
        return u3(table.unpack(u4));
    end);
    if coroutine.status(v5) == "suspended" then
        task.cancel(v5);
    end;
    u2.EndPause();
    return v6, v7;
end;
function u2.StartPause() --[[ Line: 35 ]]
    -- upvalues: u2 (copy)
    u2.Tweens.Start:Play();
    u2.Interface.AsyncLoading.Active = true;
end;
function u2.EndPause() --[[ Line: 40 ]]
    -- upvalues: u2 (copy)
    u2.Tweens.End:Play();
    u2.Interface.AsyncLoading.Active = false;
end;
function u2.Setup() --[[ Line: 45 ]]
    -- upvalues: u2 (copy), u1 (copy), l__TweenService__2 (copy)
    u2.Interface = u1.GetScreenGui("MainPriority");
    u2.Interface.AsyncLoading.Visible = true;
    u2.Interface.AsyncLoading.Active = false;
    u2.Tweens = {
        Start = l__TweenService__2:Create(u2.Interface.AsyncLoading, u2.Tween, {
            GroupTransparency = 0.4
        }),
        End = l__TweenService__2:Create(u2.Interface.AsyncLoading, u2.Tween, {
            GroupTransparency = 1
        })
    };
end;
return u2;
