-- Decompiled from: .ChillArrow26.PlayerScripts..MapPads
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local _ = script.Parent;
local l__Pads__2 = game:GetService("ReplicatedStorage"):WaitForChild("FTPStorage"):WaitForChild("Remotes"):WaitForChild("Pads");
local u1 = nil;
local u2 = 0;
local u3 = {};
local l__insert__3 = table.insert;
l__Pads__2.OnClientEvent:connect(function(p4) --[[ Line: 15 ]]
    -- upvalues: u1 (ref)
    u1 = p4;
end);
local function u6() --[[ Line: 19 ]]
    -- upvalues: u3 (ref)
    for _, v5 in pairs(u3) do
        v5:disconnect();
    end;
    u3 = {};
end;
local function u18() --[[ Line: 26 ]]
    -- upvalues: u6 (copy), l__LocalPlayer__1 (copy), u1 (ref), u2 (ref), u3 (ref), l__insert__3 (copy)
    u6();
    repeat
        wait();
    until l__LocalPlayer__1.Character ~= nil;
    local l__Character__4 = l__LocalPlayer__1.Character;
    local v7, v8, u9, u10;
    while true do
        v7 = l__Character__4:FindFirstChild("Left Leg");
        v8 = l__Character__4:FindFirstChild("Right Leg");
        u9 = l__Character__4:FindFirstChild("HumanoidRootPart");
        u10 = l__Character__4:FindFirstChild("Humanoid");
        if l__Character__4 == nil then
            break;
        end;
        wait();
        if v7 ~= nil and (v8 ~= nil and (u9 ~= nil and u10 ~= nil)) then
            break;
        end;
    end;
    if l__Character__4 == nil then
    else
        local function u13(p11) --[[ Line: 55 ]]
            -- upvalues: u2 (ref), u10 (ref), u9 (ref)
            local v12 = p11 == nil and 150 or p11;
            if tick() - u2 >= 0.5 then
                u2 = tick();
                u10:ChangeState(Enum.HumanoidStateType.Jumping);
                u9.Velocity = Vector3.new(u9.Velocity.X, v12, u9.Velocity.Z);
            end;
        end;
        l__insert__3(u3, v7.Touched:connect(function(p14) --[[ Line: 64 ]]
            -- upvalues: u1 (ref), u13 (copy)
            local v15;
            if u1 == nil or p14 == nil then
                v15 = nil;
            else
                v15 = u1:IsAncestorOf(p14);
            end;
            if v15 == true then
                u13((tonumber(p14.Name)));
            end;
        end));
        l__insert__3(u3, v8.Touched:connect(function(p16) --[[ Line: 72 ]]
            -- upvalues: u1 (ref), u13 (copy)
            local v17;
            if u1 == nil or p16 == nil then
                v17 = nil;
            else
                v17 = u1:IsAncestorOf(p16);
            end;
            if v17 == true then
                u13((tonumber(p16.Name)));
            end;
        end));
    end;
end;
l__LocalPlayer__1.CharacterAdded:connect(function() --[[ Line: 85 ]]
    -- upvalues: l__Pads__2 (copy), u18 (copy)
    l__Pads__2:FireServer();
    u18();
end);
l__Pads__2:FireServer();
u18();
