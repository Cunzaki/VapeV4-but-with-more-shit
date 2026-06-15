-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.Attack
-- Class: ModuleScript
-- Place: Ugc (94987506187454)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local l__Hitbox__1 = require(script.Hitbox);
function u1.new(p2, p3) --[[ Line: 14 ]]
    -- upvalues: u1 (copy)
    local v4 = setmetatable({}, u1);
    v4.sender = p2;
    v4.attack_id = p3;
    v4.hitboxes = {};
    v4.exclude_list = {};
    v4.hit_hurtboxes = {};
    return v4;
end;
function u1.addHitbox(p5, p6) --[[ Line: 28 ]]
    -- upvalues: l__Hitbox__1 (copy)
    local v7 = l__Hitbox__1.new(p6);
    if v7 then
        table.insert(p5.hitboxes, v7);
    end;
    return v7;
end;
function u1.addToExclusion(p8, p9) --[[ Line: 36 ]]
    table.insert(p8.exclude_list, p9);
end;
function u1.castOnce(p10, p11) --[[ Line: 40 ]]
    table.clear(p10.hit_hurtboxes);
    for _, v12 in p10.hitboxes do
        for _, v13 in v12:cast() do
            if p11 or v13:FindFirstAncestorWhichIsA("Model") ~= p10.sender then
                if not table.find(p10.hit_hurtboxes, v13) then
                    table.insert(p10.hit_hurtboxes, v13);
                end;
            end;
        end;
    end;
    return p10.hit_hurtboxes;
end;
function u1.castContinuous(p14) --[[ Line: 59 ]]
    table.clear(p14.hit_hurtboxes);
    local v15 = {};
    for _, v16 in p14.hitboxes do
        for _, v17 in v16:cast() do
            local v18 = v17:FindFirstAncestorWhichIsA("Model");
            if not (table.find(p14.hit_hurtboxes, v17) or table.find(p14.exclude_list, v17)) then
                if not table.find(p14.exclude_list, v18) then
                    table.insert(p14.hit_hurtboxes, v17);
                    table.insert(v15, v18);
                end;
            end;
        end;
    end;
    for _, v19 in v15 do
        p14:addToExclusion(v19);
    end;
    return p14.hit_hurtboxes;
end;
function u1.castMore(p20) --[[ Line: 87 ]]
    for _, v21 in p20.hitboxes do
        for _, v22 in v21:cast() do
            v22:FindFirstAncestorWhichIsA("Model");
            if not table.find(p20.hit_hurtboxes, v22) then
                table.insert(p20.hit_hurtboxes, v22);
            end;
        end;
    end;
    return p20.hit_hurtboxes;
end;
return u1;
