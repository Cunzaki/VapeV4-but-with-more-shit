-- Decompiled from: Start.Client.Classes._x545ff694ddcc66c8
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
game:GetService("TeleportService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Packets__2 = require(l__ReplicatedStorage__1.Assets.ModuleScripts.Packets);
local l__InternalSymbols__3 = require(script.Parent.Parent.InternalSymbols);
local l__ClientRoot__4 = require(script.Parent.Parent.ClientRoot);
local _ = l__ClientRoot__4.Classes;
local l__Context__5 = l__ClientRoot__4.Context;
local u1 = {};
u1.__index = u1;
local u2 = {
    BaseMatch = script._xae752d9bd83472ca,
    Stocks1v1 = script._x5b1d7fdb840c79d0,
    Stocks2Teams = script._xd19e553f65e52e22,
    Stocks2v2 = script._xe677a818bb8cc610,
    Training = script._x6663f0b96b1986b2,
    Tutorial = script._xbbe38da43bbc7f90
};
function u1._x90d4581ac99dd483() --[[ Line: 26 ]]
    -- upvalues: u1 (copy), l__Context__5 (copy)
    local v3 = setmetatable({}, u1);
    v3._x52b3d9fd81166d6c = l__Context__5.is_match_mode;
    v3._x54ffdfaa6954a8fc = nil;
    return v3;
end;
function u1._xe53615d96cf36a6b(u4) --[[ Line: 34 ]]
    -- upvalues: l__Packets__2 (copy), l__InternalSymbols__3 (copy)
    if u4._x52b3d9fd81166d6c then
        u4:_x1c4cc50d228cb419();
    end;
    l__Packets__2._x90aa1001178059e0.OnClientEvent:Connect(function(p5) --[[ Line: 39 ]]
        -- upvalues: u4 (copy), l__InternalSymbols__3 (ref)
        if u4._x54ffdfaa6954a8fc then
            l__InternalSymbols__3.owner("", u4._x54ffdfaa6954a8fc):_x3509d0fb2952a6b3(p5);
        end;
    end);
end;
function u1._x1c4cc50d228cb419(p6) --[[ Line: 47 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u2 (copy), l__InternalSymbols__3 (copy)
    warn("FINDING MATCH...");
    local l__Match__6 = l__ReplicatedStorage__1:WaitForChild("ReadOnly"):WaitForChild("Match");
    local v7 = l__Match__6:GetAttribute("gamemode") or l__Match__6:GetAttributeChangedSignal("gamemode"):Wait();
    local v8 = u2[v7];
    if v8 then
        p6._x54ffdfaa6954a8fc = l__InternalSymbols__3.owner("", require(v8))._x90d4581ac99dd483(l__Match__6);
        l__InternalSymbols__3.owner("", p6._x54ffdfaa6954a8fc):_x8fcdafeb8ad3312d();
    else
        warn("No client match class found for gamemode: " .. tostring(v7));
    end;
end;
return u1;
