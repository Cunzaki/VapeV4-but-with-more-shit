-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__ContextActionService__2 = game:GetService("ContextActionService");
local l__Backpack__3 = l__LocalPlayer__1:WaitForChild("Backpack", 300);
local l__UserInputService__4 = game:GetService("UserInputService");
local l__MainFrame__5 = script.Parent:WaitForChild("MainFrame");
local l__WeaponFrames__6 = l__MainFrame__5:WaitForChild("WeaponFrames");
local l__BackpackFrame__7 = l__MainFrame__5:WaitForChild("BackpackFrame");
local l__TweenService__8 = game:GetService("TweenService");
local l__PlayerVals__9 = script.Parent:WaitForChild("PlayerVals");
local l__animModule__10 = require(script.Parent:WaitForChild("animModule"));
local l__insert__11 = table.insert;
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
local u1 = {};
local u2 = nil;
local u3 = {};
repeat
    wait();
until l__LocalPlayer__1.Character ~= nil and l__LocalPlayer__1.Character:FindFirstChild("Humanoid");
local u4 = l__LocalPlayer__1.Character:FindFirstChild("Humanoid");
local u5 = {
    l__PlayerVals__9.Saluting,
    l__PlayerVals__9.Sprinting,
    l__PlayerVals__9.Crouching,
    l__PlayerVals__9.Prone,
    l__PlayerVals__9.CanSprint,
    l__PlayerVals__9.AtEase
};
local u6 = { 16, 12, 22 };
function FindTool()
    -- upvalues: l__LocalPlayer__1 (copy)
    local v7, v8, v9 = pairs((l__LocalPlayer__1.Character:GetChildren()));
    while true do
        local v10;
        v9, v10 = v7(v8, v9);
        if not v9 then
            break;
        end;
        if v10:IsA("Tool") then
            return true, v10.Name, v10;
        end;
    end;
    return false, nil;
end;
function GlobalCrouch()
    -- upvalues: u5 (copy), u4 (copy), u6 (copy), l__animModule__10 (copy)
    if u5[4].Value == true then
    elseif u5[6].Value == true then
    elseif u5[3].Value == false then
        if u5[2].Value == true then
            _G.GlobalSprint();
        end;
        u4.WalkSpeed = u6[2];
        l__animModule__10.AnimTable["Global-Animations"].Global_Crouch:Play();
        u5[3].Value = true;
    else
        if u5[3].Value == true then
            u4.WalkSpeed = u6[1];
            l__animModule__10.AnimTable["Global-Animations"].Global_Crouch:Stop();
            u5[3].Value = false;
        end;
    end;
end;
function _G.GlobalSprint() --[[ Line: 71 ]]
    -- upvalues: u5 (copy), u4 (copy), u6 (copy)
    if u5[4].Value == true or u5[5].Value == false then
    elseif u5[2].Value == false then
        if u5[3].Value == true then
            GlobalCrouch();
        end;
        u4.WalkSpeed = u6[3];
        u5[2].Value = true;
    else
        if u5[2].Value == true then
            u4.WalkSpeed = u6[1];
            u5[2].Value = false;
        end;
    end;
end;
local function u15() --[[ Line: 87 ]]
    -- upvalues: l__BackpackFrame__7 (copy), u1 (ref), u2 (ref)
    for _, v11 in pairs(l__BackpackFrame__7:GetChildren()) do
        if v11:IsA("Frame") then
            v11:Destroy();
        end;
    end;
    for v12 = 1, #u1 do
        local v13 = u1[v12];
        local v14 = script:WaitForChild("Template"):clone();
        v14.Parent = l__BackpackFrame__7;
        v14:WaitForChild("Binding").Text = tostring(v12);
        v14:WaitForChild("WeaponName").Text = v13.Name;
        if u2 == v13 then
            v14:WaitForChild("Bordeok").Visible = true;
        end;
    end;
end;
local function u19() --[[ Line: 105 ]]
    -- upvalues: u1 (ref), l__insert__11 (copy), u15 (copy)
    local v16 = {};
    for v17 = 1, #u1 do
        local v18 = u1[v17];
        if v18 ~= nil and v18:GetFullName():len() > v18.Name:len() then
            l__insert__11(v16, #v16 + 1, v18);
        end;
    end;
    u1 = v16;
    u15();
end;
local function u23(p20) --[[ Line: 117 ]]
    -- upvalues: u3 (copy), u19 (copy), u1 (ref), l__insert__11 (copy)
    if p20 == nil then
    elseif u3[p20] == nil then
        if p20:IsA("Tool") == false then
        else
            local u21 = nil;
            u3[p20] = p20;
            u21 = p20.AncestryChanged:connect(function(_, p22) --[[ Line: 125 ]]
                -- upvalues: u21 (ref), u19 (ref)
                if p22 == nil then
                    u21:disconnect();
                    u19();
                end;
            end);
            l__insert__11(u1, #u1 + 1, p20);
        end;
    end;
end;
local u24 = {
    Equip = {
        Weapon = { l__TweenService__8:Create(l__WeaponFrames__6.MainWeapon, TweenInfo.new(0.1), {}), l__TweenService__8:Create(l__WeaponFrames__6.MainWeapon.AmmoInfo.CurrentClip, TweenInfo.new(0.1), {
                TextTransparency = 0
            }), l__TweenService__8:Create(l__WeaponFrames__6.MainWeapon.AmmoInfo.TotalClip, TweenInfo.new(0.1), {
                TextTransparency = 0
            }) },
        Medic = { l__TweenService__8:Create(l__WeaponFrames__6.MediWeapon, TweenInfo.new(0.1), {}), l__TweenService__8:Create(l__WeaponFrames__6.MediWeapon.AmmoInfo.CurrentClip, TweenInfo.new(0.1), {
                TextTransparency = 0
            }) }
    },
    Unequip = {
        Weapon = { l__TweenService__8:Create(l__WeaponFrames__6.MainWeapon, TweenInfo.new(0.1), {}), l__TweenService__8:Create(l__WeaponFrames__6.MainWeapon.AmmoInfo.CurrentClip, TweenInfo.new(0.1), {
                TextTransparency = 1
            }), l__TweenService__8:Create(l__WeaponFrames__6.MainWeapon.AmmoInfo.TotalClip, TweenInfo.new(0.1), {
                TextTransparency = 1
            }) },
        Medic = { l__TweenService__8:Create(l__WeaponFrames__6.MediWeapon, TweenInfo.new(0.1), {}), l__TweenService__8:Create(l__WeaponFrames__6.MediWeapon.AmmoInfo.CurrentClip, TweenInfo.new(0.1), {
                TextTransparency = 1
            }) }
    }
};
l__ContextActionService__2.LocalToolEquipped:connect(function(p25) --[[ Line: 158 ]]
    -- upvalues: u2 (ref), u15 (copy), u24 (copy), l__WeaponFrames__6 (copy), u5 (copy), l__animModule__10 (copy)
    u2 = p25;
    u15();
    if p25:FindFirstChild("isMediGun") then
        for _, v26 in pairs(u24.Equip.Medic) do
            v26:Play();
        end;
    else
        l__WeaponFrames__6.MainWeapon.WeaponName.Text = p25.Name;
        for _, v27 in pairs(u24.Equip.Weapon) do
            v27:Play();
        end;
    end;
    if u5[1].Value == true then
        l__animModule__10.AnimTable["Global-Animations"].Global_Salute:Stop();
        u5[1].Value = false;
    end;
end);
l__ContextActionService__2.LocalToolUnequipped:connect(function(p28) --[[ Line: 182 ]]
    -- upvalues: u2 (ref), u15 (copy), u24 (copy), l__WeaponFrames__6 (copy), l__TweenService__8 (copy)
    u2 = nil;
    u15();
    if p28:FindFirstChild("isMediGun") then
        for _, v29 in pairs(u24.Unequip.Medic) do
            v29:Play();
        end;
        for _, v30 in pairs(l__WeaponFrames__6.MediWeapon.Border:GetChildren()) do
            l__TweenService__8:Create(v30, TweenInfo.new(0.1), {
                BackgroundTransparency = 1
            }):Play();
        end;
    else
        l__WeaponFrames__6.MainWeapon.WeaponName.Text = p28.Name;
        for _, v31 in pairs(u24.Unequip.Weapon) do
            v31:Play();
        end;
        for _, v32 in pairs(l__WeaponFrames__6.MainWeapon.Border:GetChildren()) do
            l__TweenService__8:Create(v32, TweenInfo.new(0.1), {
                BackgroundTransparency = 1
            }):Play();
        end;
    end;
end);
l__Backpack__3.ChildAdded:connect(function(p33) --[[ Line: 200 ]]
    -- upvalues: u23 (copy), u19 (copy)
    u23(p33);
    u19();
end);
l__UserInputService__4.InputBegan:connect(function(p34, _) --[[ Line: 205 ]]
    -- upvalues: l__UserInputService__4 (copy), u1 (ref), u2 (ref), u4 (copy), l__WeaponFrames__6 (copy)
    if p34.UserInputType == Enum.UserInputType.Keyboard and l__UserInputService__4:GetFocusedTextBox() == nil then
        local l__Value__12 = p34.KeyCode.Value;
        if l__Value__12 >= 48 and l__Value__12 <= 57 then
            local v35 = u1[l__Value__12 - 48];
            if v35 ~= nil then
                if v35 == u2 then
                    u4:UnequipTools();
                    l__WeaponFrames__6:TweenPosition(UDim2.new(1.5, -30, 1, -30), "Out", "Quad", 0.25, true);
                else
                    u4:EquipTool(v35);
                    l__WeaponFrames__6:TweenPosition(UDim2.new(1, -30, 1, -30), "Out", "Quad", 0.25, true);
                end;
            end;
        else
            if p34.KeyCode == Enum.KeyCode.C then
                GlobalCrouch();
                return;
            end;
            if p34.KeyCode == Enum.KeyCode.F then
                _G.GlobalSprint();
            end;
        end;
    end;
end);
for _, v36 in pairs(l__Backpack__3:GetChildren()) do
    u23(v36);
end;
u19();
wait(0.5);
for _, v37 in pairs(l__Backpack__3:GetChildren()) do
    u23(v37);
end;
u19();