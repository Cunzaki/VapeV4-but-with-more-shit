-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = typeof;
local l__obtain__1 = _G.obtain;
local l__FreeMouse__2 = l__obtain__1("QBox").FreeMouse;
local u2 = l__obtain__1("View");
local l__SetMode__3 = u2.SetMode;
local l__SetPlayer__4 = u2.SetPlayer;
local l__GetContextData__5 = l__obtain__1("ContextManager").GetContextData;
local v3 = l__obtain__1("PlayerManager");
local l__Players__6 = v3.Players;
local l__LocalPlayer__7 = v3.LocalPlayer;
local v4 = l__obtain__1("BotManager");
local l__Bots__8 = v4.Bots;
local l__GetBotFromId__9 = v4.GetBotFromId;
local v5 = l__obtain__1("VisibilityManager");
local l__SetHiding__10 = v5.SetHiding;
local l__PlayersVisible__11 = v5.PlayersVisible;
local u6 = l__obtain__1("PauseMulticall");
local u7 = {
    FreeMouse = false
};
local u8 = l__obtain__1("Styles");
local l__Call__12 = l__obtain__1("Remote").Call;
local l__Call__13 = l__obtain__1("Local").Call;
local v9 = l__obtain__1("Command");
local function u21(p10, p11) --[[ Line: 39 ]]
    -- upvalues: l__Players__6 (copy), l__GetContextData__5 (copy), l__Bots__8 (copy)
    local v12 = false;
    for v13 = 1, #l__Players__6 do
        local v14 = l__Players__6[v13];
        if v14 == p11 then
            v12 = true;
        elseif v12 and (v14 ~= p10 and not l__GetContextData__5(v14, "Spectating")) then
            return v14;
        end;
    end;
    for v15 = 1, #l__Bots__8 do
        local v16 = l__Bots__8[v15];
        if v16 == p11 then
            v12 = true;
        elseif v12 and (v16 ~= p10 and not l__GetContextData__5(v16, "Spectating")) then
            return v16;
        end;
    end;
    for v17 = 1, #l__Players__6 do
        local v18 = l__Players__6[v17];
        if v18 ~= p10 and not l__GetContextData__5(v18, "Spectating") then
            return v18;
        end;
    end;
    for v19 = 1, #l__Bots__8 do
        local v20 = l__Bots__8[v19];
        if v20 ~= p10 and not l__GetContextData__5(v20, "Spectating") then
            return v20;
        end;
    end;
end;
local function u33(p22, p23) --[[ Line: 71 ]]
    -- upvalues: l__Bots__8 (copy), l__GetContextData__5 (copy), l__Players__6 (copy)
    local v24 = false;
    for v25 = #l__Bots__8, 1, -1 do
        local v26 = l__Bots__8[v25];
        if v26 == p23 then
            v24 = true;
        elseif v24 and (v26 ~= p22 and not l__GetContextData__5(v26, "Spectating")) then
            return v26;
        end;
    end;
    for v27 = #l__Players__6, 1, -1 do
        local v28 = l__Players__6[v27];
        if v28 == p23 then
            v24 = true;
        elseif v24 and (v28 ~= p22 and not l__GetContextData__5(v28, "Spectating")) then
            return v28;
        end;
    end;
    for v29 = #l__Bots__8, 1, -1 do
        local v30 = l__Bots__8[v29];
        if v30 ~= p22 and not l__GetContextData__5(v30, "Spectating") then
            return v30;
        end;
    end;
    for v31 = #l__Players__6, 1, -1 do
        local v32 = l__Players__6[v31];
        if v32 ~= p22 and not l__GetContextData__5(v32, "Spectating") then
            return v32;
        end;
    end;
end;
local l__Player__14 = u2.Player;
u2.ModeChanged:Add(function(p34) --[[ Line: 104 ]]
    -- upvalues: l__FreeMouse__2 (copy), l__Player__14 (ref), l__SetHiding__10 (copy)
    if p34 == 1 then
        l__FreeMouse__2("Spectate", l__Player__14 ~= "Local");
        l__SetHiding__10(l__Player__14, "Spectate", true, true);
    else
        if p34 == 2 then
            l__FreeMouse__2("Spectate", false);
            l__SetHiding__10(l__Player__14, "User", false);
            l__SetHiding__10(l__Player__14, "Spectate", false, true);
        end;
    end;
end);
u2.PlayerChanged:Add(function(p35) --[[ Line: 114 ]]
    -- upvalues: l__SetHiding__10 (copy), l__Player__14 (ref), l__PlayersVisible__11 (copy)
    l__SetHiding__10(l__Player__14, "User", not l__PlayersVisible__11());
    l__SetHiding__10(l__Player__14, "Spectate", false);
    l__Player__14 = p35;
end);
local function u39(p36) --[[ Line: 120 ]]
    -- upvalues: l__Player__14 (ref), u6 (copy), u7 (copy), l__SetPlayer__4 (copy), l__SetMode__3 (copy), u2 (copy), u1 (copy), l__Call__12 (copy)
    local v37 = p36 or "Local";
    if v37 ~= l__Player__14 then
        local v38 = v37 == "Local";
        u6:CallWithIncludes(u7, "Spectating", not v38);
        l__SetPlayer__4(v37);
        l__SetMode__3(v38 and 1 or u2.Mode);
        if u1(v37) == "table" then
            v37 = v37.Id;
        end;
        assert(v37 ~= nil, "SpectatePlayer==nil");
        l__Call__12("SetSpectating", v37);
    end;
end;
local function v41(p40) --[[ Line: 146 ]]
    -- upvalues: u2 (copy), u39 (copy), u21 (copy), l__LocalPlayer__7 (copy)
    if u2.Player == p40 then
        u39(u21(l__LocalPlayer__7, u2.Player));
    end;
end;
v3.PlayerRemoving:Add(v41);
v4.BotRemoving:Add(v41);
local function u45(p42, p43) --[[ Line: 154 ]]
    -- upvalues: l__GetContextData__5 (copy), u39 (copy), u33 (copy), l__GetBotFromId__9 (copy)
    if p43 == nil then
        if l__GetContextData__5(p42, "Spectating") then
            u39("Local");
        else
            p43 = u33(p42);
            if not p43 then
                return "There is no one to spectate.";
            end;
        end;
    end;
    if p42 == p43 then
        return "Lol, nice try";
    elseif p43 then
        local v44 = l__GetContextData__5(p43, "Spectating");
        if v44 then
            if type(v44) == "number" then
                v44 = l__GetBotFromId__9(v44);
            end;
            return p43.Name .. " is currently spectating " .. v44.Name .. ".", true;
        else
            u39(p43);
            return "You are now in spectate mode.  Say !spec or press x to stop spectating.";
        end;
    end;
end;
v9.Add("spec bonus", { "Commander" }, function(p46) --[[ Line: 183 ]]
    -- upvalues: u8 (copy), u39 (copy), l__Call__13 (copy)
    local v47 = GetActiveBot(1, u8.DefaultStyle);
    if v47 then
        u39(v47);
        l__Call__13("Chat", {
            "List",
            {
                "FGColor",
                {
                    r = 255,
                    g = 0,
                    b = 255,
                    a = 128
                }
            },
            { "Text", "o yea" }
        }, nil, p46);
    else
        l__Call__13("Chat", {
            "List",
            {
                "FGColor",
                {
                    r = 255,
                    g = 0,
                    b = 0,
                    a = 128
                }
            },
            { "Text", "o no" }
        }, nil, p46);
    end;
end);
v9.Add({ "spectate", "spec" }, { "Commander", "Player" }, u45);
v9.Add({ "spectate", "spec" }, { "Commander", "BotId" }, function(p48, p49) --[[ Line: 194 ]]
    -- upvalues: l__GetBotFromId__9 (copy), u45 (copy)
    local v50 = l__GetBotFromId__9(p49);
    if v50 then
        return u45(p48, v50);
    end;
end);
v9.Add({ "spectate", "spec" }, { "Commander" }, function(...) --[[ Line: 200 ]]
    -- upvalues: u45 (copy)
    return u45(...);
end);
return {
    Next = function() --[[ Name: Next, Line 136 ]]
        -- upvalues: u39 (copy), u21 (copy), l__LocalPlayer__7 (copy), u2 (copy)
        u39(u21(l__LocalPlayer__7, u2.Player));
    end,
    Prev = function() --[[ Name: Prev, Line 139 ]]
        -- upvalues: u39 (copy), u33 (copy), l__LocalPlayer__7 (copy), u2 (copy)
        u39(u33(l__LocalPlayer__7, u2.Player));
    end,
    SetPlayer = u39,
    ChangeView = function(p51) --[[ Name: ChangeView, Line 142 ]]
        -- upvalues: l__SetMode__3 (copy), u2 (copy)
        l__SetMode__3(p51 or u2.Mode % u2.ModeCount + 1);
    end
};
