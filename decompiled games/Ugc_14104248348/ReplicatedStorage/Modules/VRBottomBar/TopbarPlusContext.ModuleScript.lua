-- Decompiled from: ReplicatedStorage.Modules.VRBottomBar.TopbarPlusContext
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
require(script.Parent:WaitForChild("Types"));
local u1 = {};
u1.__index = u1;
function u1.new(p2, p3) --[[ Line: 20 ]]
    -- upvalues: u1 (copy)
    local v4 = {};
    setmetatable(v4, u1);
    v4.VRBottomBar = p2;
    v4.TopbarPlus = p3;
    return v4;
end;
function u1.Add(p5, p6, p7) --[[ Line: 32 ]]
    local v8 = Instance.new("Frame");
    v8.BackgroundTransparency = 1;
    v8.Size = UDim2.new(1, 0, 1, 0);
    v8.SizeConstraint = Enum.SizeConstraint.RelativeYY;
    local l__IconButton__2 = p6.cachedNamesToInstances.IconButton;
    l__IconButton__2.Parent = v8;
    local l__IconSpot__3 = p6.cachedNamesToInstances.IconSpot;
    l__IconSpot__3:GetPropertyChangedSignal("Size"):Connect(function() --[[ Line: 42 ]]
        -- upvalues: l__IconSpot__3 (copy)
        l__IconSpot__3.Size = UDim2.fromScale(1, 1);
    end);
    l__IconSpot__3.Size = UDim2.fromScale(1, 1);
    p6.cachedNamesToInstances.IconOverlay.Parent = l__IconButton__2;
    p5.VRBottomBar:Add(v8, p7);
end;
function u1.AddNexusVRCharacterModelMenuButton(p9, p10) --[[ Line: 55 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy)
    local u11 = p9.TopbarPlus.new():setName("NexusVRCharacterModelMenu"):setImage("rbxassetid://14034301935");
    p9:Add(u11, p10);
    task.spawn(function() --[[ Line: 64 ]]
        -- upvalues: l__ReplicatedStorage__1 (ref), u11 (copy)
        local u12 = require(l__ReplicatedStorage__1:WaitForChild("NexusVRCharacterModel")).Api:WaitFor("Menu");
        u11:bindEvent("selected", function(_) --[[ Line: 67 ]]
            -- upvalues: u12 (copy)
            u12:Open();
        end);
        u11:bindEvent("deselected", function(_) --[[ Line: 70 ]]
            -- upvalues: u12 (copy)
            u12:Close();
        end);
    end);
end;
return u1;
