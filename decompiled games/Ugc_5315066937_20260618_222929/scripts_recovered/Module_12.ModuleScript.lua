-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = type;
local u2 = unpack;
local l__insert__1 = table.insert;
local l__remove__2 = table.remove;
local l__yield__3 = coroutine.yield;
local l__create__4 = coroutine.create;
local l__resume__5 = coroutine.resume;
local l__status__6 = coroutine.status;
local l__running__7 = coroutine.running;
local u3 = _G.obtain("LabelPrint");
local u4 = {};
local u5 = 0;
local function u8(p6) --[[ Line: 18 ]]
    -- upvalues: l__resume__5 (copy), l__status__6 (copy), u3 (copy)
    local v7 = { l__resume__5(p6) };
    if not v7[1] then
        u3("Job error:", v7[2]);
        return true;
    end;
    if l__status__6(p6) == "dead" then
        return true, v7;
    end;
end;
return {
    Init = function() --[[ Name: Init, Line 45 ]]
        -- upvalues: u4 (copy), u5 (ref), u8 (copy), l__remove__2 (copy), l__resume__5 (copy), u2 (copy), u3 (copy)
        game:GetService("RunService").Stepped:connect(function() --[[ Line: 46 ]]
            -- upvalues: u4 (ref), u5 (ref), u8 (ref), l__remove__2 (ref), l__resume__5 (ref), u2 (ref), u3 (ref)
            if #u4 ~= 0 then
                u5 = (u5 - 2) % #u4 + 1;
                local v9 = u4[u5];
                local v10, v11 = u8(v9.co);
                if v10 then
                    l__remove__2(u4, u5);
                    if v11 and v9.Thread then
                        local v12, v13 = l__resume__5(v9.Thread, u2(v11, 2));
                        if not v12 then
                            u3("Thread error:", v13);
                        end;
                    end;
                end;
            end;
        end);
    end,
    Job = function(p14, p15) --[[ Name: Job, Line 30 ]]
        -- upvalues: l__create__4 (copy), u4 (copy), l__insert__1 (copy), u1 (copy), l__running__7 (copy), l__yield__3 (copy)
        local v16 = {
            co = l__create__4(p14)
        };
        l__insert__1(u4, v16);
        if p15 then
            if u1(p15) == "function" then
                v16.Thread = l__create__4(p15);
            elseif u1(p15) == "thread" then
                v16.Thread = p15;
            end;
        else
            v16.Thread = l__running__7();
            return l__yield__3();
        end;
    end
};
