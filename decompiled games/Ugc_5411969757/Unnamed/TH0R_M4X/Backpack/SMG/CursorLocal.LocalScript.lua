-- Decompiled from: .TH0R_M4X.Backpack.SMG.CursorLocal
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local v2 = setmetatable({}, {
    __index = function(_, p1) --[[ Name: __index, Line 1 ]]
        return game:GetService(p1);
    end
});
local _ = v2.Players.LocalPlayer;
local l__UserInputService__1 = v2.UserInputService;
local l__CustomCursors__2 = v2.ReplicatedStorage:WaitForChild("FTPStorage"):WaitForChild("CustomCursors");
local u3 = require(l__CustomCursors__2);
local u4 = nil;
local function u9(p5) --[[ Line: 17 ]]
    -- upvalues: u3 (copy)
    local v6 = u3:IsEnabled();
    local v7 = u3:GetSlot();
    if v6 == true and v7 ~= nil then
        p5.Icon = "rbxassetid://" .. v7.id;
    else
        local v8 = u3:GetCursor(p5.Target) or 0;
        if v8 == 1 then
            p5.Icon = "rbxassetid://131718487";
        elseif v8 == 2 then
            p5.Icon = "rbxassetid://131718495";
        else
            p5.Icon = "rbxassetid://131581677";
        end;
    end;
end;
script.Parent.Equipped:connect(function(u10) --[[ Line: 36 ]]
    -- upvalues: u9 (copy), u4 (ref), l__UserInputService__1 (copy), u3 (copy)
    u9(u10);
    u10.Move:connect(function() --[[ Line: 38 ]]
        -- upvalues: u9 (ref), u10 (copy)
        u9(u10);
    end);
    u4 = l__UserInputService__1.InputBegan:connect(function(p11, _) --[[ Line: 50 ]]
        -- upvalues: u3 (ref), l__UserInputService__1 (ref)
        if u3:IsEnabled() and p11.UserInputType == Enum.UserInputType.Keyboard then
            local l__KeyCode__3 = p11.KeyCode;
            if l__KeyCode__3 ~= nil and (l__KeyCode__3.Name ~= nil and (u3:GetToggleKey() == l__KeyCode__3.Name and l__UserInputService__1:GetFocusedTextBox() == nil)) then
                u3:ToggleCursor();
            end;
        end;
    end);
end);
script.Parent.Unequipped:connect(function() --[[ Line: 62 ]]
    -- upvalues: u4 (ref)
    if u4 ~= nil then
        u4:disconnect();
        u4 = nil;
    end;
end);
