-- Decompiled from: ReplicatedStorage.Modules.timeago
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__en__1 = require(script.en);
function v1.format(p2) --[[ Line: 12 ]]
    -- upvalues: l__en__1 (copy)
    if p2 < 30 then
        return l__en__1.justnow;
    else
        local v3 = p2 / 60;
        if v3 < 1.5 then
            return l__en__1.minute.singular;
        elseif v3 < 59.5 then
            return math.floor(v3 + 0.5) .. " " .. l__en__1.minute.plural;
        else
            local v4 = v3 / 60;
            if v4 < 1.5 then
                return l__en__1.hour.singular;
            elseif v4 < 23.5 then
                return math.floor(v4 + 0.5) .. " " .. l__en__1.hour.plural;
            else
                local v5 = v4 / 24;
                if v5 < 1.5 then
                    return l__en__1.day.singular;
                elseif v5 < 7.5 then
                    return math.floor(v5 + 0.5) .. " " .. l__en__1.day.plural;
                else
                    local v6 = v5 / 7;
                    if v6 < 1.5 then
                        return l__en__1.week.singular;
                    elseif v6 < 4.5 then
                        return math.floor(v6 + 0.5) .. " " .. l__en__1.week.plural;
                    else
                        local v7 = v5 / 30;
                        if v7 < 1.5 then
                            return l__en__1.month.singular;
                        elseif v7 < 11.5 then
                            return math.floor(v7 + 0.5) .. " " .. l__en__1.month.plural;
                        else
                            local v8 = v5 / 365.25;
                            if v8 < 1.5 then
                                return l__en__1.year.singular;
                            else
                                return math.floor(v8 + 0.5) .. " " .. l__en__1.year.plural;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
return v1;
