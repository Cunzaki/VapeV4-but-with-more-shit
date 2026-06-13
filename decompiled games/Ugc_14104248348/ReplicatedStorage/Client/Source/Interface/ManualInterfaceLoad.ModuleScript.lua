-- Decompiled from: ReplicatedStorage.Client.Source.Interface.ManualInterfaceLoad
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__StarterGui__2 = game:GetService("StarterGui");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__LocalPlayer__4 = l__Players__1.LocalPlayer;
local l__ManualLoad__5 = l__ReplicatedStorage__3:WaitForChild("Assets"):WaitForChild("ManualLoad");
local u4 = {
    IterateForever = function(_, p1, p2) --[[ Name: IterateForever, Line 12 ]]
        for _, v3 in p1:GetChildren() do
            task.spawn(p2, v3);
        end;
        p1.ChildAdded:Connect(p2);
    end
};
function u4.Init(_) --[[ Line: 19 ]]
    -- upvalues: u4 (copy), l__ManualLoad__5 (copy), l__StarterGui__2 (copy), l__LocalPlayer__4 (copy)
    local u5 = nil;
    u4:IterateForever(l__ManualLoad__5, function(p6) --[[ Line: 21 ]]
        -- upvalues: l__StarterGui__2 (ref), u5 (ref), l__LocalPlayer__4 (ref)
        if p6:IsA("ScreenGui") then
            p6.Parent = l__StarterGui__2;
            p6:Clone().Parent = u5 or l__LocalPlayer__4:WaitForChild("PlayerGui");
        end;
    end);
    u5 = l__LocalPlayer__4:WaitForChild("PlayerGui");
end;
task.spawn(function() --[[ Line: 36 ]]
    -- upvalues: u4 (copy)
    u4:Init();
end);
return {};
