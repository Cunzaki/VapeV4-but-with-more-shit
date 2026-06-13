-- Decompiled from: ReplicatedStorage.Modules.ParticleSource
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Create = function(p1, p2, p3, p4) --[[ Name: Create, Line 3 ]]
        local v5 = p1.Lifetime.Max + 0.5;
        local v6 = p1:Clone();
        local v7 = Instance.new("Part");
        v7.Name = "ParticleSource";
        v7.Transparency = 1;
        v7.Position = p2;
        v7.Anchored = true;
        v7.CanCollide = false;
        v7.Size = p3;
        v7.Position = p2;
        v6.Enabled = false;
        v6.Parent = v7;
        v7.Parent = workspace;
        v6:Emit(p4);
        game:GetService("Debris"):AddItem(v7, v5);
    end,
    Emit = function(p8, p9, p10) --[[ Name: Emit, Line 25 ]]
        for _, u11 in p8:GetDescendants() do
            if p10 and u11:IsA("Sound") then
                u11:Play();
            end;
            if u11:IsA("ParticleEmitter") then
                if u11:GetAttribute("Time") then
                    u11.Enabled = true;
                    task.delay(u11:GetAttribute("Time"), function() --[[ Line: 33 ]]
                        -- upvalues: u11 (copy)
                        u11.Enabled = false;
                    end);
                else
                    u11:Emit(u11:GetAttribute("EmitCount") or (p9 or (u11.Rate or 1)));
                end;
            end;
        end;
    end,
    CreateGroup = function(p12, p13, p14) --[[ Name: CreateGroup, Line 43 ]]
        local v15 = p12:Clone();
        local v16 = 0;
        for _, v17 in v15:GetDescendants() do
            if v17:IsA("ParticleEmitter") then
                v17.Enabled = false;
                v16 = math.max(v16, v17.Lifetime.Max + 0.5);
            end;
        end;
        local v18;
        if typeof(p13) == "Vector3" then
            v18 = Instance.new("Part");
            v18.Name = "ParticleSource";
            v18.Transparency = 1;
            v18.Anchored = true;
            v18.CanCollide = false;
            v18.Size = Vector3.new(0.2, 0.2, 0.2);
            v18.Position = p13;
            v18.Parent = game.Workspace;
            game:GetService("Debris"):AddItem(v18, v16);
        else
            v18 = p13;
        end;
        v15.Parent = v18;
        for _, u19 in v15:GetDescendants() do
            if u19:IsA("ParticleEmitter") then
                local v20 = u19:GetAttribute("Time");
                if v20 then
                    u19.Enabled = true;
                    task.delay(v20, function() --[[ Line: 77 ]]
                        -- upvalues: u19 (copy)
                        u19.Enabled = false;
                    end);
                else
                    u19:Emit(p14 or u19.Rate);
                end;
            end;
            if u19:IsA("Sound") then
                u19:Play();
            end;
        end;
        game:GetService("Debris"):AddItem(v15, v16);
        return v15;
    end
};
