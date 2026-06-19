-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__clear__1 = table.clear;
local l__obtain__2 = _G.obtain;
local u1 = l__obtain__2("L1Copy");
local u2 = l__obtain__2("LabelPrint");
local u3 = l__obtain__2("View");
local l__OutputSignal__3 = u3.OutputSignal;
local l__CreateStyleInfo__4 = l__obtain__2("Styles").CreateStyleInfo;
local v4 = l__obtain__2("CustomEnums");
local l__MODE_MAIN__5 = v4.MODE_MAIN;
local l__EVENT_WORLD_RESET__6 = v4.EVENT_WORLD_RESET;
local l__EVENT_WORLD_BUTTON__7 = v4.EVENT_WORLD_BUTTON;
local l__EVENT_WORLD_SETTIME__8 = v4.EVENT_WORLD_SETTIME;
local l__EVENT_WORLD_SETPAUSED__9 = v4.EVENT_WORLD_SETPAUSED;
local u5 = {
    [v4.SOUND_JUMP_GROUND] = true,
    [v4.SOUND_JUMP_LADDER] = true,
    [v4.SOUND_TRACK_GROUND] = true,
    [v4.SOUND_TRACK_LADDER] = true
};
local u6 = l__obtain__2("Timers");
local u7 = l__obtain__2("CustomCamera");
local l__MainSound__10 = l__obtain__2("Sound").MainSound;
local u8 = l__obtain__2("World");
local v9 = l__obtain__2("RunManager");
local u10 = l__obtain__2("FixLocalPlayer");
local l__CharacterInfos__11 = l__obtain__2("CharacterManager").CharacterInfos;
local u11 = l__obtain__2("MapManager");
local l__Simulation__12 = l__obtain__2("SmoothingSimulation").Simulation;
local u12 = l__obtain__2("MonitoredData");
local v13 = l__obtain__2("Class")();
local u36 = {
    Input = false,
    Gravity = false,
    Output = function(p14, ...) --[[ Name: OutputHandler, Line 61 ]]
        -- upvalues: u3 (copy), l__OutputSignal__3 (copy)
        if p14.Player == u3.Player then
            l__OutputSignal__3:Call(...);
        end;
    end,
    Sound = function(p15, _, p16, p17) --[[ Name: SoundHandler, Line 67 ]]
        -- upvalues: u5 (copy), u3 (copy), l__CharacterInfos__11 (copy), u10 (copy), l__MainSound__10 (copy)
        if u5[p16] and u3.JumpSounds == false then
        else
            local l__Player__13 = p15.Player;
            local l__Timer__14 = p15.Timer;
            local v18 = l__Player__13 == u3.Player and 0.3 or 0.1;
            local v19 = not l__Timer__14 and 1 or l__Timer__14:GetGlobalScale();
            local v20 = l__CharacterInfos__11[u10(l__Player__13)];
            if v20 and v18 ~= 0 then
                local v21 = l__MainSound__10;
                local v22 = {
                    Sound = p16
                };
                if v20 then
                    v20 = v20.HRP or v20.Torso;
                end;
                v22.Part = v20;
                v22.Volume = v18;
                v22.Scale = v19;
                v22.Material = p17;
                v21:Play(v22);
            end;
        end;
    end,
    World = function(p23, p24, p25, p26, p27) --[[ Name: WorldHandler, Line 105 ]]
        -- upvalues: l__EVENT_WORLD_SETTIME__8 (copy), l__EVENT_WORLD_SETPAUSED__9 (copy), l__EVENT_WORLD_RESET__6 (copy), l__Simulation__12 (copy), u11 (copy), l__MODE_MAIN__5 (copy), u2 (copy), l__EVENT_WORLD_BUTTON__7 (copy)
        local l__World__15 = p23.World;
        if p25 == l__EVENT_WORLD_SETTIME__8 then
            l__World__15.Timer:SetTime(p24, p26);
        elseif p25 == l__EVENT_WORLD_SETPAUSED__9 then
            if p26 then
                l__World__15.Timer:Pause(p24);
            else
                l__World__15.Timer:Play(p24);
            end;
        else
            if p25 == l__EVENT_WORLD_RESET__6 then
                local l__World__16 = l__Simulation__12.World;
                if l__World__16.ID == l__World__15.ID then
                    if l__World__15.ReferenceWorld then
                        l__World__15:Reset(l__World__15.Timer:Time(p24));
                        return;
                    else
                        u2("Attempted to reset uninitialized World");
                        return;
                    end;
                end;
                if l__World__16.ID ~= p27 and p27 ~= nil then
                    u2("Attempted to perform world resync on old ID Player=", p23.Player);
                    return;
                end;
                l__World__15:InitReuse(l__World__16, p23.Timer, p24);
                if p26 then
                    p23.MapOffset = u11.MapInfo.Zone.Start[l__MODE_MAIN__5].Position - p26;
                end;
            elseif p25 == l__EVENT_WORLD_BUTTON__7 then
                if p26 then
                    l__World__15:ActivateButton(p26, l__World__15.Timer:Time(p24));
                    return;
                end;
                u2("Attempt to ActivateButton with nil Value");
            end;
        end;
    end,
    Camera = function(p28, p29, p30, p31) --[[ Name: CameraHandler, Line 93 ]]
        local l__Camera__17 = p28.Camera;
        local v32 = p28.Context:GetAngles();
        l__Camera__17:SetTime(p29);
        l__Camera__17:Event(p30, p31);
        if v32 then
            l__Camera__17:SetAngles(v32);
        end;
    end,
    Setting = function(p33, _, p34, p35) --[[ Name: SettingHandler, Line 102 ]]
        p33.Camera:Setting(p34, p35);
    end,
    Run = v9.EventHandler
};
v13.InputHandlers = u36;
function v13.HandleInput(p37, p38, ...) --[[ Line: 156 ]]
    -- upvalues: u36 (copy)
    local v39 = u36[p38];
    if v39 then
        v39(p37, ...);
    end;
end;
local u48 = {
    Timer = function(p40, p41, p42, p43) --[[ Name: Timer, Line 164 ]]
        if p42 == "SetPaused" then
            if p43 then
                p40.Timer:Pause(p41);
            else
                p40.Timer:Play(p41);
            end;
        elseif p42 == "SetTime" then
            p40.Timer:SetTime(p41, p43);
        else
            if p42 == "SetTimescale" then
                p40.Timer:SetScale(p41, p43);
            end;
        end;
    end,
    Aux = function(p44, p45, p46, p47) --[[ Name: Aux, Line 177 ]]
        if p44.Context and (p44.Context.Type == "Realtime" and p46 == "SetStyle") then
            p44:HandleData("Data", p45, "Style", p47);
        end;
    end
};
v13.ControlHandlers = u48;
function v13.HandleControl(p49, p50, ...) --[[ Line: 185 ]]
    -- upvalues: u48 (copy)
    local v51 = u48[p50];
    if v51 then
        v51(p49, ...);
    end;
end;
local u52 = {
    Style = true,
    Mode = true,
    Spectating = true,
    Moderator = true,
    ChatModerator = true
};
local u53 = {
    Times = true,
    Ranks = true,
    Skills = true
};
local u59 = {
    Data = function(p54, _, p55, p56) --[[ Name: Data, Line 206 ]]
        -- upvalues: u52 (copy), l__CreateStyleInfo__4 (copy), u2 (copy), u53 (copy), l__clear__1 (copy), u1 (copy)
        if u52[p55] then
            p54.Cache:SetKey(p55, p56);
            if p55 == "Style" then
                local v57 = l__CreateStyleInfo__4(p56);
                if v57 then
                    p54.StyleInfo = v57;
                    p54.Camera:SetOffset(v57.camera_offset);
                    return;
                end;
                if not p54.ComplainStyleMissing then
                    u2("Missing StyleInfo StyleId=", p56);
                end;
            end;
        elseif u53[p55] then
            local v58 = p54.Cache:GetKey(p55);
            if p56 == nil then
                if v58 then
                    l__clear__1(v58);
                end;
                return;
            end;
            p54.Cache:SoftSetKey(p55, u1(p56, v58));
        end;
    end
};
v13.DataHandlers = u59;
function v13.HandleData(p60, p61, ...) --[[ Line: 233 ]]
    -- upvalues: u59 (copy)
    local v62 = u59[p61];
    if v62 then
        v62(p60, ...);
    end;
end;
local u63 = tostring;
function v13.GetIndex(p64, p65, p66, p67) --[[ Line: 245 ]]
    -- upvalues: u63 (copy)
    local v68 = p64.Cache:GetKey(p65);
    if v68 then
        return v68[u63(p66) .. "-" .. u63(p67)];
    end;
end;
function v13.SetData(p69, p70, p71) --[[ Line: 252 ]]
    p69:HandleData("Data", nil, p70, p71);
end;
function v13.FixWorld(p72) --[[ Line: 257 ]]
    local l__Context__18 = p72.Context;
    if l__Context__18 then
        if l__Context__18.Type == "Realtime" then
            p72.World:CopyState(l__Context__18.SmoothingSimulation.Phys.World);
            return;
        end;
        local v73 = l__Context__18.Type == "Offline" and l__Context__18.EventQueues.Input.Queued:After();
        if v73 then
            local v74 = p72.World.Timer:Time(v73[1]);
            if p72.World.Cache1.Time ~= v74 then
                p72.World:PrepareInterpolationTarget(v74);
            end;
        end;
    end;
end;
local u75 = true;
local u76 = {};
local u77 = {};
function v13.Run(p78) --[[ Line: 280 ]]
    -- upvalues: u11 (copy), u75 (ref), u2 (copy), u77 (copy), u76 (copy)
    if u11.MapInfo then
        local l__Player__19 = p78.Player;
        if p78.DataIndexer then
            p78.DataIndexer:Run();
        elseif not u77[l__Player__19] then
            u77[l__Player__19] = true;
            u2("DataIndexer is missing for Player=", l__Player__19);
        end;
        local l__Context__20 = p78.Context;
        if l__Context__20 and l__Context__20.Type == "Offline" then
            if l__Context__20.ControlIndexer then
                l__Context__20.ControlIndexer:Run();
            elseif not u76[l__Player__19] then
                u76[l__Player__19] = true;
                u2("Context.ControlIndexer is missing for Player=", l__Player__19);
            end;
            if p78.InsideIndexer then
                p78.InsideIndexer:Run();
            end;
            if p78.OutsideIndexer then
                p78.OutsideIndexer:Run();
            end;
            l__Context__20.Indexer:Run();
        end;
    else
        if u75 then
            u75 = false;
            u2("Will not run without map");
        end;
    end;
end;
function v13.Constructor(p79, p80, p81, p82) --[[ Line: 315 ]]
    -- upvalues: u12 (copy), u6 (copy), u7 (copy), u8 (copy)
    p79.Player = p80;
    p79.Runs = {};
    p79.Context = p82;
    p79.Cache = u12();
    p79.Timer = u6(p81);
    p79.Camera = u7();
    p79.MapOffset = Vector3.new(0, 0, 0);
    p79.World = u8();
end;
return v13;
