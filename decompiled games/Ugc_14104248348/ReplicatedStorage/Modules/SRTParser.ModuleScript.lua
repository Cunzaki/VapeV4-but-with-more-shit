-- Decompiled from: ReplicatedStorage.Modules.SRTParser
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__Signal__2 = require(script.Signal);
local u11 = {
    MaxForwardSectionSearch = 4,
    NextIndicator = "-->",
    TokenBreaks = {
        [" "] = true,
        ["\n"] = true
    },
    LineBreaks = {
        ["\n"] = true
    },
    CreateSection = function(_, p1) --[[ Name: CreateSection, Line 16 ]]
        return {
            SectionNumber = p1,
            Subtitles = {}
        };
    end,
    Timestamp = function(_, p2) --[[ Name: Timestamp, Line 23 ]]
        local v3, v4, v5, v6 = string.match(p2, "(%d+):(%d+):(%d+),(%d+)");
        local v7 = tonumber(v3);
        local v8 = tonumber(v4);
        local v9 = tonumber(v5);
        local v10 = tonumber(v6);
        if not (v7 and (v8 and (v9 and v10))) then
            error("Lexical Parsing Error (Timestamp) : Number value could not be parsed by tonumber");
        end;
        if v9 < 0 or (v8 < 0 or (v7 < 0 or (v10 < 0 or v10 >= 1000))) then
            error("Lexical Parsing Error (Timestamp) : Invalid number range within timestamp");
        end;
        return v7 * 3600 + v8 * 60 + v9 + v10 / 1000;
    end
};
function u11.Parse(_, p12) --[[ Line: 37 ]]
    -- upvalues: u11 (copy)
    local v13 = "";
    local v14 = #p12;
    local v15 = v13;
    local v16 = 0;
    local v17 = "FindSection";
    local v18 = nil;
    local v19 = {
        __type = "SRTSectionData"
    };
    while v16 < v14 do
        v16 = v16 + 1;
        local v20 = p12:sub(v16, v16);
        v13 = v15 .. v20;
        if v17 == "FindSection" then
            if u11.TokenBreaks[v20] then
                local v21 = v13:sub(1, #v13 - 1);
                v13 = "";
                local v22 = tonumber(v21);
                if v22 then
                    v18 = u11:CreateSection(v22);
                    v15 = v13;
                    v17 = "FindBeginningTimeStamp";
                else
                    v15 = v13;
                end;
            else
                v15 = v13;
            end;
        elseif v17 == "FindBeginningTimeStamp" then
            if u11.TokenBreaks[v20] then
                local v23 = v13:sub(1, #v13 - 1);
                v13 = "";
                v18.BeginTime = u11:Timestamp(v23);
                v15 = v13;
                v17 = "FindNextIndicator";
            else
                v15 = v13;
            end;
        elseif v17 == "FindEndTimeStamp" then
            if u11.TokenBreaks[v20] then
                local v24 = v13:sub(1, #v13 - 1);
                v13 = "";
                v18.EndTime = u11:Timestamp(v24);
                v15 = v13;
                v17 = "ReadSubtitleInformation";
            else
                v15 = v13;
            end;
        elseif v17 == "FindNextIndicator" then
            if u11.TokenBreaks[v20] then
                local v25 = v13:sub(1, #v13 - 1);
                v13 = "";
                if v25 == u11.NextIndicator then
                    v15 = v13;
                    v17 = "FindEndTimeStamp";
                else
                    v15 = v13;
                end;
            else
                v15 = v13;
            end;
        elseif v17 == "ReadSubtitleInformation" and u11.LineBreaks[v20] then
            local v26 = v13:sub(1, #v13 - 1);
            v13 = "";
            if v26 == "" then
                table.insert(v19, v18);
                v15 = v13;
                v17 = "FindSection";
            else
                table.insert(v18.Subtitles, v26);
                v15 = v13;
            end;
        else
            v15 = v13;
        end;
    end;
    return v19;
end;
function u11.SearchUpFromHighestSection(_, p27, p28, p29) --[[ Line: 111 ]]
    -- upvalues: u11 (copy)
    local v30 = #p27;
    for v31 = 0, u11.MaxForwardSectionSearch do
        local v32 = (v31 + p29) % (v30 + 1);
        local v33 = p27[v32];
        if v32 ~= 0 and (v33.BeginTime < p28 and p28 < v33.EndTime) then
            return v33, v32;
        end;
    end;
end;
function u11.SyncSubtitleSoundInstanceEvents(_, p34, u35) --[[ Line: 125 ]]
    -- upvalues: l__Signal__2 (copy), u11 (copy), l__RunService__1 (copy)
    local v36;
    if typeof(p34) == "table" then
        v36 = p34.__type == "SRTSectionData";
    else
        v36 = false;
    end;
    assert(v36, "Need valid SectionsData from SRTParser:Parse");
    local v37;
    if typeof(u35) == "Instance" then
        v37 = u35:IsA("Sound");
    else
        v37 = false;
    end;
    assert(v37, "Expected Sound Instance!");
    local u38 = {
        CachedOffset = 1,
        Sections = p34,
        Started = l__Signal__2.new(),
        Stopped = l__Signal__2.new(),
        ActiveSections = {}
    };
    function u38.Update() --[[ Line: 137 ]]
        -- upvalues: u38 (copy), u35 (copy), u11 (ref)
        if u38.LastTimePosition == u35.TimePosition then
            return;
        end;
        u38.LastTimePosition = u35.TimePosition;
        local v39 = false;
        for _, v40 in u38.ActiveSections do
            if u35.TimePosition > v40.BeginTime and u35.TimePosition < v40.EndTime then
                v39 = true;
                break;
            end;
        end;
        if not v39 then
            local v41, v42 = u11:SearchUpFromHighestSection(u38.Sections, u35.TimePosition, (math.max(0, u38.CachedOffset - 1)));
            if v41 and v42 then
                local v43 = false;
                for _, v44 in u38.ActiveSections do
                    if v44 == v41 then
                        v43 = true;
                        break;
                    end;
                end;
                if not v43 then
                    table.insert(u38.ActiveSections, v41);
                    u38.Started:Fire(v41);
                end;
                u38.CachedOffset = v42 + 1;
            end;
        end;
        for v45 = #u38.ActiveSections, 1, -1 do
            local v46 = u38.ActiveSections[v45];
            if u35.TimePosition > v46.EndTime then
                table.remove(u38.ActiveSections, v45);
                u38.Stopped:Fire(v46);
            end;
        end;
    end;
    (function(p47) --[[ Line: 184 ]]
        -- upvalues: u38 (copy), l__RunService__1 (ref)
        if u38.UpdateConnection then
            u38.UpdateConnection:Disconnect();
            u38.UpdateConnection = nil;
        end;
        if p47 then
            u38.ActiveSections = {};
            u38.CachedOffset = 1;
            u38.UpdateConnection = l__RunService__1.Heartbeat:Connect(u38.Update);
        end;
    end)(u35.IsPlaying);
    u35.Played:Connect(function() --[[ Line: 198 ]]
        -- upvalues: u38 (copy), l__RunService__1 (ref)
        if u38.UpdateConnection then
            u38.UpdateConnection:Disconnect();
            u38.UpdateConnection = nil;
        end;
        u38.ActiveSections = {};
        u38.CachedOffset = 1;
        u38.UpdateConnection = l__RunService__1.Heartbeat:Connect(u38.Update);
    end);
    u35.Stopped:Connect(function() --[[ Line: 201 ]]
        -- upvalues: u38 (copy)
        if u38.UpdateConnection then
            u38.UpdateConnection:Disconnect();
            u38.UpdateConnection = nil;
        end;
    end);
    return u38;
end;
return u11;
