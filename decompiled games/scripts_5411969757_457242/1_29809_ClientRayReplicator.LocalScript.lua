-- Decompiled with Potassium's decompiler.

local l__Name__1 = script.Name;
script.Name = "ClientRayReplicator";
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local u1 = pcall;
local u2 = unpack;
local l__OBJECT__3 = script:WaitForChild("OBJECT");
repeat
    wait();
until l__OBJECT__3.Value ~= nil;
local l__Value__4 = l__OBJECT__3.Value;
l__OBJECT__3:Destroy();
local u3;
repeat
    wait();
    u3 = game:GetService("ReplicatedStorage"):FindFirstChild(l__Name__1);
until u3 ~= nil;
local function u5(...) --[[ Line: 19 ]]
    -- upvalues: u3 (ref), l__ReplicatedStorage__2 (copy), u1 (copy), u2 (copy)
    local u4 = { ... };
    u3.Parent = l__ReplicatedStorage__2;
    if u1(function() --[[ Line: 22 ]]
        -- upvalues: u3 (ref), u4 (copy), u2 (ref)
        u3:FireServer(u2(u4));
    end) == true then
        u3.Parent = nil;
    else
        while true do

        end;
    end;
end;
wait(1);
l__Value__4.AncestryChanged:connect(function(_, p6) --[[ Line: 29 ]]
    -- upvalues: u5 (copy)
    if p6 == nil then
        u5(nil, "local_report", "usb");
    end;
end);
l__Value__4:GetPropertyChangedSignal("Disabled"):connect(function() --[[ Line: 35 ]]
    while true do

    end;
end);