-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local l__SetRaceBot__2 = l__obtain__1("Race").SetRaceBot;
local l__SetPlayer__3 = l__obtain__1("Spectate").SetPlayer;
local l__Call__4 = l__obtain__1("Remote").Call;
local l__GetBotFromId__5 = l__obtain__1("BotManager").GetBotFromId;
local v1 = l__obtain__1("ContextManager");
local u2 = nil;
local u3 = nil;
local function v7(p4, p5) --[[ Line: 20 ]]
    -- upvalues: l__GetBotFromId__5 (copy), l__SetRaceBot__2 (copy), u2 (ref), l__Call__4 (copy)
    local v6 = l__GetBotFromId__5(p5);
    if v6 then
        l__SetRaceBot__2(v6);
    else
        if p4 and p5 then
            u2 = p5;
            l__Call__4("LoadPrivateBot", p4, p5);
        end;
    end;
end;
local function v11(p8, p9) --[[ Line: 29 ]]
    -- upvalues: l__GetBotFromId__5 (copy), l__SetPlayer__3 (copy), u3 (ref), l__Call__4 (copy)
    local v10 = l__GetBotFromId__5(p9);
    if v10 then
        l__SetPlayer__3(v10);
    else
        if p8 and p9 then
            u3 = p9;
            l__Call__4("LoadPrivateBot", p8, p9);
        end;
    end;
end;
v1.ContextChanged:Add(function(p12) --[[ Line: 39 ]]
    -- upvalues: u2 (ref), l__SetRaceBot__2 (copy), u3 (ref), l__SetPlayer__3 (copy)
    local l__Player__6 = p12.Player;
    if type(l__Player__6) == "table" then
        local l__Id__7 = l__Player__6.Id;
        if l__Id__7 == u2 then
            u2 = nil;
            l__SetRaceBot__2(l__Player__6);
        end;
        if l__Id__7 == u3 then
            u3 = nil;
            l__SetPlayer__3(l__Player__6);
        end;
    end;
end);
return {
    WFBRace = v7,
    WFBSpectate = v11
};
