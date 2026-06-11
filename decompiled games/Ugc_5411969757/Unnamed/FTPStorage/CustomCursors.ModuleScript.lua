-- Decompiled from: .FTPStorage.CustomCursors
-- Class: ModuleScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local u2 = setmetatable({}, {
    __index = function(_, p1) --[[ Name: __index, Line 1 ]]
        return game:GetService(p1);
    end
});
local l__StarterGui__1 = u2.StarterGui;
local l__LocalPlayer__2 = u2.Players.LocalPlayer;
local l__PlayerSettings__3 = u2.ReplicatedStorage:WaitForChild("FTPStorage"):WaitForChild("Remotes"):WaitForChild("PlayerSettings");
local u3 = {};
local u4 = true;
local u5 = false;
local u6 = false;
local u7 = 0;
local l__CurrentSlot__4 = l__LocalPlayer__2:WaitForChild("CurrentSlot");
local l__CustomCursorsEnabled__5 = l__LocalPlayer__2:WaitForChild("CustomCursorsEnabled");
local l__CursorSlots__6 = l__LocalPlayer__2:WaitForChild("CursorSlots");
local l__CursorToggle__7 = l__LocalPlayer__2:WaitForChild("CursorToggle");
local l__CursorToggleKey__8 = l__LocalPlayer__2:WaitForChild("CursorToggleKey");
local l__ServerCC__9 = u2.Lighting:WaitForChild("ServerCC");
local u8 = {};
l__CurrentSlot__4:GetPropertyChangedSignal("Value"):connect(function() --[[ Line: 27 ]]
    -- upvalues: u7 (ref), l__CurrentSlot__4 (copy)
    u7 = l__CurrentSlot__4.Value;
end);
l__CustomCursorsEnabled__5:GetPropertyChangedSignal("Value"):connect(function() --[[ Line: 28 ]]
    -- upvalues: u5 (ref), l__CustomCursorsEnabled__5 (copy)
    u5 = l__CustomCursorsEnabled__5.Value;
end);
l__CursorSlots__6:GetPropertyChangedSignal("Value"):connect(function() --[[ Line: 29 ]]
    -- upvalues: l__CursorSlots__6 (copy), u8 (ref), u2 (copy)
    if l__CursorSlots__6.Value:len() > 2 then
        u8 = u2.HttpService:JSONDecode(l__CursorSlots__6.Value);
    else
        u8 = {};
    end;
end);
l__CursorToggle__7:GetPropertyChangedSignal("Value"):connect(function() --[[ Line: 30 ]]
    -- upvalues: u6 (ref), l__CursorToggle__7 (copy)
    u6 = l__CursorToggle__7.Value;
end);
l__ServerCC__9:GetPropertyChangedSignal("Value"):connect(function() --[[ Line: 31 ]]
    -- upvalues: u4 (ref), l__ServerCC__9 (copy)
    u4 = l__ServerCC__9.Value;
end);
u7 = l__CurrentSlot__4.Value;
u5 = l__CustomCursorsEnabled__5.Value;
if l__CursorSlots__6.Value:len() > 2 then
    u8 = u2.HttpService:JSONDecode(l__CursorSlots__6.Value);
else
    u8 = {};
end;
u6 = l__CursorToggle__7.Value;
u4 = l__ServerCC__9.Value;
function u3.GetCursorName(_, p9) --[[ Line: 44 ]]
    -- upvalues: u8 (ref)
    local v10 = u8[tostring(p9)];
    return v10 == nil and "Unnamed" or (v10.name == nil and "Unnamed" or v10.name);
end;
function u3.GetToggleKey(_) --[[ Line: 52 ]]
    -- upvalues: l__CursorToggleKey__8 (copy)
    local l__Value__10 = l__CursorToggleKey__8.Value;
    return (l__Value__10 == "nil" or l__Value__10 == "") and "X" or l__Value__10;
end;
function u3.ToggleCursor(_) --[[ Line: 58 ]]
    -- upvalues: u6 (ref), u7 (ref), l__PlayerSettings__3 (copy), l__StarterGui__1 (copy), u3 (copy)
    if u6 == true then
        u7 = u7 + 1;
        if u7 > 5 then
            u7 = 1;
        end;
        l__PlayerSettings__3:FireServer("toggle", u7);
        l__StarterGui__1:SetCore("SendNotification", {
            Title = "Cursor Slot Changed to:",
            Text = "[" .. tostring(u7) .. "] " .. u3:GetCursorName(u7)
        });
    end;
end;
function u3.GetSlot(_, p11) --[[ Line: 74 ]]
    -- upvalues: u7 (ref), u8 (ref)
    local v12 = p11 or u7;
    local v13 = u8[tostring(v12)];
    if v13 == nil then
    else
        if v13.id ~= nil then
            return u8[tostring(v12)];
        end;
    end;
end;
function u3.CheckHitPart(_, p14) --[[ Line: 82 ]]
    -- upvalues: u2 (copy)
    if p14 == nil then
    else
        local v15 = p14.Parent:FindFirstChild("Humanoid");
        if v15 ~= nil then
            return u2.Players:GetPlayerFromCharacter(v15.Parent);
        end;
        if p14.Parent:IsA("Tool") or p14.Parent:IsA("Accessory") then
            return u2.Players:GetPlayerFromCharacter(p14.Parent.Parent);
        end;
    end;
end;
function u3.IsEnabled(_) --[[ Line: 94 ]]
    -- upvalues: u4 (ref), u5 (ref), u7 (ref)
    local v16;
    if u4 == true and u5 == true then
        v16 = u7 > 0;
    else
        v16 = false;
    end;
    return v16;
end;
function u3.GetCursor(_, p17) --[[ Line: 98 ]]
    -- upvalues: u3 (copy), l__LocalPlayer__2 (copy)
    local v18 = u3:CheckHitPart(p17);
    return v18 == nil and 0 or (l__LocalPlayer__2.TeamColor == v18.TeamColor and 1 or 2);
end;
return u3;
