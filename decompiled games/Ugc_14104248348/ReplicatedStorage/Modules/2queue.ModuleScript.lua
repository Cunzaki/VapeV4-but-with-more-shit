-- Decompiled from: ReplicatedStorage.Modules.2queue
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local l__HttpService__1 = game:GetService("HttpService");
game:GetService("RunService");
function u1.sort(p2) --[[ Line: 7 ]]
    table.sort(p2.list, function(p3, p4) --[[ Line: 8 ]]
        return p3.priority > p4.priority;
    end);
end;
function u1.getQueueFromList(p5, p6) --[[ Line: 13 ]]
    for v7 = 1, #p5.list do
        local v8 = p5.list[v7];
        if v8._id == p6 then
            return v7, v8;
        end;
    end;
end;
function u1.remove(p9, p10) --[[ Line: 24 ]]
    local v11, _ = p9:getQueueFromList(p10);
    table.remove(p9.list, v11);
    p9:sort();
end;
function u1.add(u12, u13, u14, p15) --[[ Line: 30 ]]
    -- upvalues: l__HttpService__1 (copy)
    local u16 = l__HttpService__1:GenerateGUID();
    table.insert(u12.list, {
        _id = u16,
        priority = p15 or 10,
        args = u14,
        run = function() --[[ Name: run, Line 36 ]]
            -- upvalues: u13 (copy), u14 (copy), u12 (copy), u16 (copy)
            local v17, v18 = pcall(function() --[[ Line: 37 ]]
                -- upvalues: u13 (ref), u14 (ref)
                return u13(u14 and unpack(u14, 1, #u14) or nil);
            end);
            u12:remove(u16);
            if not v17 then
                print(("%s failed to run: %s"):format(u16, v18));
            end;
        end
    });
    u12:sort();
    return u16;
end;
function u1.new(u19) --[[ Line: 55 ]]
    -- upvalues: u1 (copy)
    local u20 = setmetatable({
        list = {}
    }, u1);
    task.spawn(function() --[[ Line: 60 ]]
        -- upvalues: u20 (copy), u19 (copy)
        while true do
            if u20.list[1] then
                u20.list[1]:run();
            end;
            task.wait(u19);
        end;
    end);
    return u20;
end;
return u1;
