-- Decompiled from: ReplicatedStorage.Modules.RarityUtil
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Rarities__1 = game:GetService("ReplicatedStorage").Config.Shared.Rarities;
local u1 = {
    RarityCount = 0,
    Rarities = {}
};
function deepcopy(p2)
    if type(p2) ~= "table" then
        return p2;
    end;
    local v3 = {};
    for v4, v5 in next, p2 do
        v3[deepcopy(v4)] = deepcopy(v5);
    end;
    local v6 = deepcopy;
    local v7 = getmetatable(p2);
    setmetatable(v3, v6(v7));
    return v3;
end;
function u1.GetRarity(p8) --[[ Line: 30 ]]
    -- upvalues: u1 (copy)
    return u1.Rarities[p8];
end;
function u1.Init() --[[ Line: 34 ]]
    -- upvalues: l__Rarities__1 (copy), u1 (copy)
    local v9;
    if l__Rarities__1 then
        v9 = require(l__Rarities__1);
    else
        v9 = nil;
    end;
    for v10, u11 in v9 do
        local u12 = {
            Data = u11,
            Order = u11.Order or 1,
            Name = u11.Text
        };
        function u12.GetColors() --[[ Line: 48 ]]
            -- upvalues: u12 (copy), u11 (copy)
            if not u12.Colors then
                u12.Colors = {
                    Graident = ColorSequence.new({ ColorSequenceKeypoint.new(0, u11.AltColor1 or u11.PrimaryColor), ColorSequenceKeypoint.new(1, u11.AltColor2 or u11.PrimaryColor) })
                };
            end;
            return u12.Colors;
        end;
        function u12.RarityColorArray() --[[ Line: 62 ]]
            -- upvalues: u11 (copy)
            return { u11.PrimaryColor, u11.AltColor1, u11.AltColor2 };
        end;
        u1.Rarities[v10] = u12;
    end;
end;
u1.Init();
return u1;
