-- Decompiled from: ReplicatedStorage.Client.Class.EnterBox
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local l__Players__2 = game:GetService("Players");
local l__Signal__3 = require(l__ReplicatedStorage__1.Modules.Signal);
local u1 = {
    Lookup = {}
};
function u1.new(u2) --[[ Line: 14 ]]
    -- upvalues: u1 (copy), l__Signal__3 (copy)
    u2 = u2;
    local v3;
    if u2 then
        v3 = u2:IsA("BasePart");
    else
        v3 = u2;
    end;
    assert(v3, "Need basepart blalhahahahaq");
    if u1.Lookup[u2] then
        return u1.Lookup[u2];
    end;
    local u4 = {
        CurrentCharactersInBox = {},
        Added = l__Signal__3.new(),
        Removed = l__Signal__3.new()
    };
    u1.Lookup[u2] = u4;
    local u5 = 0;
    function u4.ForceUpdate() --[[ Line: 30 ]]
        -- upvalues: u5 (ref), u4 (copy)
        u5 = 0.5;
        u4.Update(0.5);
    end;
    function u4.Update(p6) --[[ Line: 35 ]]
        -- upvalues: u5 (ref), u1 (ref), u2 (copy), u4 (copy)
        u5 = u5 + p6;
        if u5 > 0.5 then
            u5 = u5 - 0.5;
            local v7 = u1.GetCharactersInPart(u2);
            local v8 = {};
            local v9 = {};
            for _, v10 in u4.CurrentCharactersInBox do
                if not v7[v10] then
                    v8[v10] = v10;
                end;
            end;
            for _, v11 in v7 do
                if not u4.CurrentCharactersInBox[v11] then
                    v9[v11] = v11;
                end;
            end;
            u4.CurrentCharactersInBox = v7;
            if next(v9) then
                for _, v12 in v9 do
                    u4.Added:Fire(v12);
                end;
            end;
            if next(v8) then
                for _, v13 in v8 do
                    u4.Removed:Fire(v13);
                end;
            end;
        end;
    end;
    return u4;
end;
function u1.GetCharactersInPart(p14) --[[ Line: 79 ]]
    -- upvalues: l__Players__2 (copy)
    local v15 = p14.CFrame:Inverse();
    local v16 = p14.Size / 2;
    local v17 = {};
    for _, v18 in l__Players__2:GetPlayers() do
        local l__Character__4 = v18.Character;
        if l__Character__4 then
            local v19 = l__Character__4:FindFirstChild("HumanoidRootPart");
            if v19 then
                local v20 = v15 * v19.CFrame;
                if math.abs(v20.X) <= v16.X and (math.abs(v20.Y) <= v16.Y and math.abs(v20.Z) <= v16.Z) then
                    v17[l__Character__4] = l__Character__4;
                end;
            end;
        end;
    end;
    return v17;
end;
return u1;
