-- Decompiled from: Start.Client.Classes._xddeb4dd489515b18
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
game:GetService("TeleportService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Packets__2 = require(l__ReplicatedStorage__1.Assets.ModuleScripts.Packets);
local l___x7749231778538ccb__3 = require(script.Parent.Parent._x7749231778538ccb);
local l__ClientRoot__4 = require(script.Parent.Parent.ClientRoot);
local _ = l__ClientRoot__4.Classes;
local l__Context__5 = l__ClientRoot__4.Context;
local u1 = {};
u1.__index = u1;
local u2 = {
    BaseMatch = script._x2540ae668ff74d62,
    Stocks1v1 = script._xd7ca953f179fbbd3,
    Stocks2Teams = script._xe03e666255624aec,
    Stocks2v2 = script._xd40665d896b4c7b0,
    Training = script._xa83f44b48944ceef,
    Tutorial = script._xd43200ad948e4620
};
function u1._x83ed94bfb82a8c9f() --[[ Line: 35 ]]
    -- upvalues: u1 (copy), l__Context__5 (copy)
    local v3 = setmetatable({}, u1);
    v3._x0822391eeeb254e9 = l__Context__5.is_match_mode;
    v3._x4852b50d8a214859 = nil;
    return v3;
end;
function u1._x44bcd6af41218f92(u4) --[[ Line: 43 ]]
    -- upvalues: l__Packets__2 (copy), l___x7749231778538ccb__3 (copy)
    if u4._x0822391eeeb254e9 then
        u4:_xa26708a8f0834165();
    end;
    l__Packets__2._x7b59efeaacc66e16.OnClientEvent:Connect(function(p5) --[[ Line: 48 ]]
        -- upvalues: u4 (copy), l___x7749231778538ccb__3 (ref)
        if u4._x4852b50d8a214859 then
            l___x7749231778538ccb__3._xd644d9e3ba63f27f("", u4._x4852b50d8a214859):_xd4333817fe7b9cc8(p5);
        end;
    end);
end;
function u1._xa26708a8f0834165(p6) --[[ Line: 56 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u2 (copy), l___x7749231778538ccb__3 (copy)
    warn("FINDING MATCH...");
    local l__Match__6 = l__ReplicatedStorage__1:WaitForChild("ReadOnly"):WaitForChild("Match");
    local v7 = l__Match__6:GetAttribute("gamemode") or l__Match__6:GetAttributeChangedSignal("gamemode"):Wait();
    local v8 = u2[v7];
    if v8 then
        p6._x4852b50d8a214859 = l___x7749231778538ccb__3._xd644d9e3ba63f27f("", require(v8))._x83ed94bfb82a8c9f(l__Match__6);
        l___x7749231778538ccb__3._xd644d9e3ba63f27f("", p6._x4852b50d8a214859):_xba28441e0836bc41();
        print("STARTED MATCH MODULE :", v8);
    else
        warn("No client match class found for gamemode: " .. tostring(v7));
    end;
end;
return u1;
