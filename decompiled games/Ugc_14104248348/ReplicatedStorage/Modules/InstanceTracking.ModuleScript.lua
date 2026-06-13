-- Decompiled from: ReplicatedStorage.Modules.InstanceTracking
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__CollectionService__2 = game:GetService("CollectionService");
return {
    TrackingActive = false,
    TrackedInstances = {},
    FormatSummary = function(p1) --[[ Name: FormatSummary, Line 21 ]]
        local v2 = {};
        for v3, v4 in p1.TrackedInstances do
            local v5 = 0;
            local v6 = 0;
            local v7 = 0;
            for v8, _ in v4 do
                v5 = v5 + 1;
                if not v8:IsDescendantOf(game) then
                    v6 = v6 + 1;
                    if not v8.Parent then
                        v7 = v7 + 1;
                    end;
                end;
            end;
            local v9 = `{v3}: {v5}`;
            if v6 ~= 0 then
                if v6 == v7 then
                    v9 = v9 .. ` ({v7} unparented)`;
                elseif v7 == 0 then
                    v9 = v9 .. ` ({v6} not under game)`;
                else
                    v9 = v9 .. ` ({v6} not under game, {v7} unparented)`;
                end;
            end;
            table.insert(v2, v9);
        end;
        table.sort(v2);
        return table.concat(v2, ", ");
    end,
    TrackInstanceWithTag = function(p10, p11, p12) --[[ Name: TrackInstanceWithTag, Line 61 ]]
        if not p10.TrackedInstances[p11] then
            p10.TrackedInstances[p11] = setmetatable({}, {
                __mode = "k"
            });
        end;
        p10.TrackedInstances[p11][p12] = true;
    end,
    TrackInstance = function(p13, p14) --[[ Name: TrackInstance, Line 77 ]]
        -- upvalues: l__Players__1 (copy), l__CollectionService__2 (copy)
        if p14:IsA("Player") then
            p13:TrackInstanceWithTag("Players", p14);
        elseif p14:IsA("Tool") then
            p13:TrackInstanceWithTag("Tool", p14);
        elseif p14:IsA("Model") and l__Players__1:GetPlayerFromCharacter(p14) then
            p13:TrackInstanceWithTag("Characters", p14);
        else
            if l__CollectionService__2:HasTag(p14, "AnimatedCar") then
                p13:TrackInstanceWithTag("Cars", p14);
            end;
        end;
    end,
    StartTracking = function(u15) --[[ Name: StartTracking, Line 93 ]]
        if u15.TrackingActive then
        else
            u15.TrackingActive = true;
            for _, v16 in game:GetDescendants() do
                u15:TrackInstance(v16);
            end;
            game.DescendantAdded:Connect(function(p17) --[[ Line: 101 ]]
                -- upvalues: u15 (copy)
                u15:TrackInstance(p17);
            end);
        end;
    end
};
