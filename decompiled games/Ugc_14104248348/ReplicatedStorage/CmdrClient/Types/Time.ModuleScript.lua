-- Decompiled from: ReplicatedStorage.CmdrClient.Types.Time
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

function StringAbbrivationToSeconds(p1)
    local v2 = false;
    local v3 = 0;
    local v4 = {
        s = 1,
        sec = 1,
        secs = 1,
        second = 1,
        seconds = 1,
        m = 60,
        min = 60,
        mins = 60,
        minute = 60,
        minutes = 60,
        h = 3600,
        hr = 3600,
        hrs = 3600,
        hour = 3600,
        hours = 3600,
        d = 86400,
        day = 86400,
        days = 86400,
        w = 604800,
        week = 604800,
        weeks = 604800,
        mon = 2629743,
        month = 2629743,
        months = 2629743,
        y = 31556926,
        yr = 31556926,
        yrs = 31556926,
        year = 31556926,
        years = 31556926
    };
    for v5 = 1, #p1 do
        if p1:sub(v5, v5):match("%a") ~= nil then
            v3 = v5;
            v2 = true;
            break;
        end;
    end;
    if v2 then
        local v6 = v4[p1.lower(p1:sub(v3, #p1))];
        local v7 = tonumber(p1:sub(1, v3 - 1));
        if v7 and v6 then
            return v7 * v6;
        end;
    end;
end;
return function(p8) --[[ Line: 38 ]]
    p8:RegisterType("time", {
        Validate = function(p9) --[[ Name: Validate, Line 40 ]]
            return StringAbbrivationToSeconds(p9) ~= nil;
        end,
        Parse = function(p10) --[[ Name: Parse, Line 44 ]]
            return StringAbbrivationToSeconds(p10);
        end
    });
end;
