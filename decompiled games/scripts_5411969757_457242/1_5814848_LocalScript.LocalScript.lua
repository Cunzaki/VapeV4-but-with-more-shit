-- Decompiled with Potassium's decompiler.

script.Parent:WaitForChild("Players");
local l__Topbar__1 = script.Parent:WaitForChild("Topbar");
l__Topbar__1:GetPropertyChangedSignal("Text"):connect(function() --[[ Line: 18 ]]
    -- upvalues: l__Topbar__1 (copy)
    if l__Topbar__1.Text == "" then
        l__Topbar__1.Visible = false;
    else
        l__Topbar__1.Visible = true;
    end;
end);
if l__Topbar__1.Text == "" then
    l__Topbar__1.Visible = false;
else
    l__Topbar__1.Visible = true;
end;