-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__Destroy__1 = game.Destroy;
local l__obtain__2 = _G.obtain;
local u1 = l__obtain__2("Signal")();
local l__Call__3 = l__obtain__2("Local").Call;
local v2 = l__obtain__2("Remote");
local v3 = l__obtain__2("Character");
local l__CreateCharacterInfo__4 = v3.CreateCharacterInfo;
local l__CreateCharacterClone__5 = v3.CreateCharacterClone;
local l__WriteInfoState__6 = v3.WriteInfoState;
local u4 = l__obtain__2("PlayerManager");
local u5 = l__obtain__2("BotManager");
local u6 = Instance.new("Model", workspace);
u6.Name = "Characters";
local u7 = Instance.new("Model", workspace);
u7.Name = "Equipment";
local u8 = {};
local function u12(p9) --[[ Line: 33 ]]
    -- upvalues: u8 (copy), l__CreateCharacterClone__5 (copy), u6 (copy), l__CreateCharacterInfo__4 (copy), u7 (copy), l__WriteInfoState__6 (copy), l__Call__3 (copy), u1 (copy)
    if u8[p9] then
    else
        local v10 = l__CreateCharacterClone__5(p9);
        if v10 then
            v10.Parent = u6;
            local v11 = l__CreateCharacterInfo__4(v10);
            v11.ItemContainerParent = u7;
            l__WriteInfoState__6(v11);
            l__Call__3("EquipDefaultCharacter", p9, v11);
            p9.Character = v10;
            u8[p9] = v11;
            u1:Call(p9, v11);
        end;
    end;
end;
local function u15(p13) --[[ Line: 48 ]]
    -- upvalues: u8 (copy), l__Destroy__1 (copy)
    local v14 = u8[p13];
    u8[p13] = nil;
    if v14 then
        l__Destroy__1(v14.Character);
    end;
end;
v2.Add("CharacterReady", u12);
local function u18(p16) --[[ Line: 58 ]]
    -- upvalues: l__CreateCharacterInfo__4 (copy), l__WriteInfoState__6 (copy), u8 (copy), u1 (copy)
    local v17 = l__CreateCharacterInfo__4(p16.Character);
    l__WriteInfoState__6(v17);
    u8[p16] = v17;
    u1:Call(p16, v17);
end;
return {
    Init = function() --[[ Name: Init, Line 64 ]]
        -- upvalues: u4 (copy), u12 (copy), u15 (copy), u5 (copy), u18 (copy)
        u4.PlayerAdded:Add(u12);
        u4.PlayerRemoving:Add(u15);
        u5.BotAdded:Add(u18);
        u5.BotRemoving:Add(u15);
    end,
    CharacterAdded = u1,
    CharacterInfos = u8
};
