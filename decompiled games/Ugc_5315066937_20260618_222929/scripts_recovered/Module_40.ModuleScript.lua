-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__remove__1 = table.remove;
local u1 = {};
local u2 = {};
local u3 = {};
local function u8(p4, ...) --[[ Line: 33 ]]
    -- upvalues: u2 (copy), u1 (copy), u3 (copy)
    local v5 = u2[p4];
    if v5 then
        for v6 = 1, #v5 do
            v5[v6](...);
        end;
    end;
    local v7 = u1[p4];
    if v7 then
        return v7(...);
    end;
    if not u3[p4] then
        u3[p4] = true;
        print("[Local] Attempt to call unregistered function \'" .. tostring(p4) .. "\' with arguments: ", ...);
    end;
end;
return {
    Add = function(p9, p10) --[[ Name: Add, Line 6 ]]
        -- upvalues: u1 (copy)
        if u1[p9] then
            error("[Local] A function with the id \'" .. tostring(p9) .. "\' already exists.");
        else
            u1[p9] = p10;
        end;
    end,
    Subscribe = function(p11, u12) --[[ Name: Subscribe, Line 14 ]]
        -- upvalues: u2 (copy), l__remove__1 (copy)
        local u13 = u2[p11];
        if u13 then
            u13[#u13 + 1] = u12;
        else
            u13 = { u12 };
            u2[p11] = u13;
        end;
        return function() --[[ Line: 22 ]]
            -- upvalues: u13 (ref), u12 (copy), l__remove__1 (ref)
            for v14 = #u13, 1, -1 do
                if u13[v14] == u12 then
                    l__remove__1(u13, v14);
                end;
            end;
        end;
    end,
    Call = u8,
    GetCallFunction = function(u15) --[[ Name: GetCallFunction, Line 49 ]]
        -- upvalues: u8 (copy)
        return function(...) --[[ Line: 49 ]]
            -- upvalues: u8 (ref), u15 (copy)
            u8(u15, ...);
        end;
    end
};
