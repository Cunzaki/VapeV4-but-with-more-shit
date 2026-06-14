-- Decompiled from: ReplicatedStorage.Client.Source.Interface.InterfaceExample
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Dropdown__3 = require(l__ReplicatedStorage__1.Modules.Dropdown);
local u1 = l__Mince__2:Get("InterfaceHandler");
local u2 = {};
function u2.DropdownExample(_) --[[ Line: 15 ]]
    -- upvalues: u1 (copy), u2 (copy), l__Dropdown__3 (copy)
    u2.BreadDropdown = l__Dropdown__3.SetupDropbox(u1.Interface.ScreenGui.DropdownBox, { "Rye", "Sourdough", "Bread" });
    function u2.BreadDropdown.Switched() --[[ Line: 27 ]]
        -- upvalues: u2 (ref)
        warn("The users favorite bread is:", u2.BreadDropdown.SelectedText);
        warn("The number selected is:", u2.BreadDropdown.Selected);
    end;
end;
function u2.SliderExample(_) --[[ Line: 36 ]] end;
function u2.ButtonExample(_) --[[ Line: 40 ]]
    -- upvalues: u1 (copy)
    local l__ScreenGui__4 = u1.Interface.ScreenGui;
    u1.NewButton(l__ScreenGui__4.TestButton).Activated:Connect(function() --[[ Line: 46 ]]
        warn("Test Button was pressed! ");
    end);
    u1.NewButton(l__ScreenGui__4.HelloButton).Activated:Connect(function() --[[ Line: 51 ]]
        warn("Hello button was pressed! ");
    end);
end;
function u2.Setup(_) --[[ Line: 57 ]] end;
return u2;
