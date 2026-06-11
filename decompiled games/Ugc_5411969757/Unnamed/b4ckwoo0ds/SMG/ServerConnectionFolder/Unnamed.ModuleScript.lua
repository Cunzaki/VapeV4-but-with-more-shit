-- Decompiled from: .b4ckwoo0ds.SMG.ServerConnectionFolder.
-- Class: ModuleScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__LocalPlayer__2 = l__Players__1.LocalPlayer;
local l__RaycastEvent__3 = l__LocalPlayer__2:WaitForChild("RaycastEvent");
local l__insert__4 = table.insert;
local u1 = unpack;
local v2 = {};
repeat
    wait();
until script.Parent:FindFirstChildOfClass("RemoteEvent");
local u3 = script.Parent:FindFirstChildOfClass("RemoteEvent");
local l__SpectateFolder__5 = workspace:WaitForChild("SpectateFolder");
local u4 = workspace:FindFirstChild("__Ignorable");
function v2.FireServer(_, p5, ...) --[[ Line: 17 ]]
    -- upvalues: u3 (copy), l__LocalPlayer__2 (copy)
    u3:FireServer({ script, l__LocalPlayer__2.Character, p5 }, ...);
end;
function v2.GetIgnore(_, ...) --[[ Line: 21 ]]
    -- upvalues: l__LocalPlayer__2 (copy), l__SpectateFolder__5 (copy), u4 (copy)
    return {
        l__LocalPlayer__2.Character,
        l__SpectateFolder__5,
        u4,
        workspace:FindFirstChild("FE_Ignorable", true),
        ...
    };
end;
function v2.GetTargetFilter(_) --[[ Line: 25 ]]
    -- upvalues: l__SpectateFolder__5 (copy)
    return l__SpectateFolder__5;
end;
function v2.HitCheck(p6) --[[ Line: 29 ]]
    -- upvalues: l__Players__1 (copy)
    if p6 == nil then
    else
        local v7 = tick();
        local v8 = nil;
        while tick() - v7 <= 0.25 and (p6 ~= nil and v8 == nil) do
            v8 = p6:FindFirstChildOfClass("Humanoid");
            p6 = p6.Parent;
        end;
        if tick() - v7 >= 0.25 then
        else
            if v8 ~= nil then
                return { l__Players__1:GetPlayerFromCharacter(v8.Parent), v8 };
            end;
        end;
    end;
end;
function v2.QueueAnimations(_, ...) --[[ Line: 48 ]]
    -- upvalues: l__LocalPlayer__2 (copy), l__insert__4 (copy), u1 (copy)
    local _ = l__LocalPlayer__2.Character;
    local v9 = tick();
    local v10 = nil;
    local v11 = { ... };
    local v12 = {};
    while true do
        local l__Character__6 = l__LocalPlayer__2.Character;
        if l__Character__6 ~= nil then
            v10 = l__Character__6:FindFirstChild("Humanoid");
        end;
        wait();
        if l__Character__6 ~= nil and (v10 ~= nil and v10:IsDescendantOf(workspace)) or tick() - v9 >= 5 then
            v10:FindFirstChild("Animator");
            local v13;
            repeat
                wait();
                v13 = v10:FindFirstChild("Animator");
            until v13 ~= nil;
            if tick() - v9 < 5 then
                for v14 = 1, #v11 do
                    local v15 = v11[v14];
                    if typeof(v15) == "number" then
                        local v16 = Instance.new("Animation", script);
                        v16.AnimationId = "rbxassetid://" .. tostring(v15);
                        l__insert__4(v12, (v13:LoadAnimation(v16)));
                    end;
                end;
                return v10, u1(v12);
            end;
            return;
        end;
    end;
end;
function v2.Raycast(_, ...) --[[ Line: 82 ]]
    -- upvalues: l__RaycastEvent__3 (copy)
    l__RaycastEvent__3:Fire("ray", ...);
end;
return v2;
