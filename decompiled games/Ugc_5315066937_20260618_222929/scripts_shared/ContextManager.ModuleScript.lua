-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("Signal");
local v2 = l__obtain__1("BotManager");
local v3 = l__obtain__1("PlayerManager");
local u4 = v1();
local u5 = v1();
local u6 = {};
local function v9(p7) --[[ Line: 44 ]]
    -- upvalues: u6 (copy), u5 (copy)
    local v8 = u6[p7];
    if v8 then
        u5:Call(v8);
        u6[p7] = nil;
    end;
end;
v3.PlayerRemoving:Add(v9);
v2.BotRemoving:Add(v9);
return {
    Contexts = u6,
    GetContext = function(p10) --[[ Name: GetContext, Line 20 ]]
        -- upvalues: u6 (copy)
        return u6[p10];
    end,
    RegisterContext = function(p11) --[[ Name: RegisterContext, Line 14 ]]
        -- upvalues: u6 (copy), u4 (copy)
        u6[p11.Player] = p11;
        u4:Call(p11);
    end,
    ContextChanged = u4,
    ContextRemoving = u5,
    GetContextData = function(p12, p13) --[[ Name: GetContextData, Line 23 ]]
        -- upvalues: u6 (copy)
        local v14 = u6[p12];
        if v14 then
            return v14.Cache:GetKey(p13);
        end;
    end,
    UpdateContextData = function(p15, p16, p17) --[[ Name: UpdateContextData, Line 30 ]]
        -- upvalues: u6 (copy)
        local v18 = u6[p15];
        if v18 then
            v18:SetData(p16, p17);
        end;
    end,
    SetContextData = function(p19, p20, p21) --[[ Name: SetContextData, Line 37 ]]
        -- upvalues: u6 (copy)
        local v22 = u6[p19];
        if v22 then
            v22.Cache:SetKey(p20, p21);
        end;
    end,
    DeleteContext = v9
};
