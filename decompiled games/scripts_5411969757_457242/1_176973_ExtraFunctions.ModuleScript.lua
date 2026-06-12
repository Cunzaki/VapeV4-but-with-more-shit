-- Decompiled with Potassium's decompiler.

local u2 = setmetatable({}, {
    __index = function(_, p1) --[[ Name: __index, Line 1 ]]
        return game:GetService(p1);
    end
});
return {
    Sound = function(_, p3, p4) --[[ Name: Sound, Line 4 ]]
        -- upvalues: u2 (copy)
        local v5 = u2.ReplicatedStorage:FindFirstChild("FUTURETOPS_LOCAL_STORAGE");
        if v5 == nil then
            return nil;
        end;
        local v6 = v5:FindFirstChild("Bindables");
        if v6 == nil then
            return nil;
        end;
        local v7 = v6:FindFirstChild("SoundPlayer");
        if v7 == nil then
            return nil;
        end;
        v7:Fire(p3, p4);
    end,
    OrdenarAlfabeticamente = function(_, p8) --[[ Name: OrdenarAlfabeticamente, Line 17 ]]
        if typeof(p8) ~= "table" then
            return {};
        end;
        if p8 == nil then
            return {};
        end;
        table.sort(p8, function(p9, p10) --[[ Line: 22 ]]
            return tostring(p9):lower() < tostring(p10):lower();
        end);
        return p8;
    end
};