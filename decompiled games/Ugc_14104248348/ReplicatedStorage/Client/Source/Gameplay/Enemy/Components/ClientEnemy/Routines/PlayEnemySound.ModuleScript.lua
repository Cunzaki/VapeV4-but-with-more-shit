-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Enemy.Components.ClientEnemy.Routines.PlayEnemySound
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
return {
    Called = function(p1, p2) --[[ Name: Called, Line 6 ]]
        local v3 = p1.Sounds[p2];
        if v3 then
            if v3:IsA("Sound") then
                v3:Play();
                return;
            end;
            if v3:IsA("Attachment") then
                local v4 = v3:GetChildren();
                v4[math.random(1, #v4)]:Play();
            end;
        end;
    end
};
