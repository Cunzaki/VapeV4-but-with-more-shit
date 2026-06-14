-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Enemy.NewEnemies
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__LocalPlayer__2 = game:GetService("Players").LocalPlayer;
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__ClientEnemy__4 = require(script.ClientEnemy);
local v1 = l__Mince__3:GetEvent("BossEvents");
local u2 = v1:Extend("SyncHumanoidHealth");
local u3 = v1:Extend("ClientDestroyAllEnemies");
local u4 = {
    ConfigurationToEnemy = {}
};
function u4.NewCharacter(p5) --[[ Line: 20 ]]
    -- upvalues: u4 (copy)
    local l__Humanoid__5 = p5:WaitForChild("Humanoid");
    u4.Humanoid = l__Humanoid__5;
    l__Humanoid__5.Died:Connect(function() --[[ Line: 25 ]]
        -- upvalues: u4 (ref)
        u4.Humanoid = nil;
    end);
end;
function u4.Setup() --[[ Line: 30 ]]
    -- upvalues: l__ClientEnemy__4 (copy), u4 (copy), u2 (copy), l__LocalPlayer__2 (copy), u3 (copy)
    l__ClientEnemy__4:Setup();
    local l__Enemies__6 = game.Workspace:WaitForChild("Enemies");
    local function u9(u6) --[[ Line: 34 ]]
        -- upvalues: l__ClientEnemy__4 (ref), u4 (ref), u2 (ref)
        if u6:IsA("Configuration") then
            local v7 = l__ClientEnemy__4.new(u6);
            v7.Destroying:Connect(function() --[[ Line: 38 ]]
                -- upvalues: u4 (ref), u6 (copy)
                u4.ConfigurationToEnemy[u6] = nil;
            end);
            v7.ClientEnemyReportedDamage:Connect(function(p8) --[[ Line: 42 ]]
                -- upvalues: u4 (ref), u2 (ref)
                u4.Humanoid:TakeDamage(p8);
                u2:Fire(u4.Humanoid.Health);
            end);
            u4.ConfigurationToEnemy[u6] = v7;
        end;
    end;
    for _, v10 in l__Enemies__6:GetChildren() do
        u9(v10);
    end;
    l__Enemies__6.ChildAdded:Connect(function(p11) --[[ Line: 53 ]]
        -- upvalues: u9 (copy)
        u9(p11);
    end);
    if l__LocalPlayer__2.Character then
        u4.NewCharacter(l__LocalPlayer__2.Character);
    end;
    l__LocalPlayer__2.CharacterAdded:Connect(u4.NewCharacter);
    u3.Event:Connect(function() --[[ Line: 62 ]]
        -- upvalues: l__Enemies__6 (copy), u4 (ref)
        for _, v12 in l__Enemies__6:GetChildren() do
            local v13 = u4.ConfigurationToEnemy[v12];
            if v13 then
                v13:UponDeath();
            end;
        end;
    end);
end;
return u4;
