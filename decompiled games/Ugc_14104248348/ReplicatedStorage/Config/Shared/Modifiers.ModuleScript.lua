-- Decompiled from: ReplicatedStorage.Config.Shared.Modifiers
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Utility__2 = require(l__ReplicatedStorage__1.Modules.Utility);
local u1 = {};
function u1.Merge(p2, p3) --[[ Line: 5 ]]
    -- upvalues: u1 (copy)
    for v4, v5 in pairs(p3) do
        if type(v5) == "table" then
            if type(p2[v4] or false) == "table" then
                u1.Merge(p2[v4] or {}, p3[v4] or {});
            else
                p2[v4] = v5;
            end;
        else
            p2[v4] = v5;
        end;
    end;
    return p2;
end;
function u1.Construct() --[[ Line: 20 ]]
    -- upvalues: l__Utility__2 (copy)
    local v6 = {};
    for _, v7 in script:GetChildren() do
        if v7:IsA("ModuleScript") then
            for v8, v9 in require(v7) do
                if v6[v8] then
                    for v10, v11 in v9 do
                        v6[v8][v10] = v11;
                    end;
                else
                    v6[v8] = v9;
                end;
            end;
        end;
    end;
    for v12, v13 in v6 do
        v13.Name = v12;
        v13.ActionTime = v13.ActionTime or 0.5;
        if v13.Garnish then
            v13.Garnish = l__Utility__2.CreateFuzzyFinder(v13.Garnish);
        end;
    end;
    return v6;
end;
return u1.Construct();
