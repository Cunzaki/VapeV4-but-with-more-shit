-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__find__1 = table.find;
local l__insert__2 = table.insert;
local l__remove__3 = table.remove;
local l__new__4 = Instance.new;
local l__obtain__5 = _G.obtain;
local u1 = l__obtain__5("LabelPrint");
local u2 = l__obtain__5("Bots");
local v3 = l__obtain__5("FakeRoot");
local l__Add__6 = v3.Add;
local l__Remove__7 = v3.Remove;
local v4 = l__obtain__5("Signal");
local v5 = l__obtain__5("Remote");
local u6 = CFrame.new(0, 1.25, 0);
local u7 = CFrame.new(0, -0.25, 0);
local u8 = {};
local u9 = {};
local u10 = v4();
local u11 = v4();
local u12 = v4();
local function u15(p13) --[[ Line: 67 ]]
    -- upvalues: l__find__1 (copy), u8 (copy), l__remove__3 (copy), u1 (copy), u9 (copy), u11 (copy), l__Remove__7 (copy)
    local v14 = l__find__1(u8, p13);
    if v14 then
        l__remove__3(u8, v14);
        u9[p13.Id] = nil;
        local l__DeadId__8 = p13.DeadId;
        if l__DeadId__8 then
            u9[l__DeadId__8] = nil;
        end;
        p13.Character:Destroy();
        u11:Call(p13);
        l__Remove__7(p13);
    else
        u1("Impossible case");
    end;
end;
u2.Kick = u15;
v5.Add("KickBot", function(p16) --[[ Line: 87 ]]
    -- upvalues: u9 (copy), u15 (copy), u1 (copy)
    local v17 = u9[p16];
    if v17 then
        u15(v17);
    else
        u1("KickBot called for non exist BotId=", p16);
    end;
end);
v5.Add("EditBotID", function(p18, p19) --[[ Line: 106 ]]
    -- upvalues: u9 (copy), u1 (copy), u12 (copy)
    local v20 = u9[p18];
    if v20 then
        if v20.DeadId then
            u1("Attempt to call EditBotID on Bot that already has DeadId: BotID=", v20.Id, "DeadId=", v20.DeadId, "Provided BotID=", p19);
        else
            v20.DeadId = v20.Id;
            v20.Id = p19;
            u9[p19] = v20;
            u12:Call(v20, p19);
        end;
    else
        u1("EditBotID called for non exist BotId=", p18);
    end;
end);
return {
    Bots = u8,
    GetBotFromId = function(p21) --[[ Name: GetBotFromId, Line 117 ]]
        -- upvalues: u9 (copy)
        return u9[p21];
    end,
    CreateBot = function(p22, p23, p24) --[[ Name: CreateBot, Line 33 ]]
        -- upvalues: u2 (copy), u8 (copy), l__insert__2 (copy), u9 (copy), l__new__4 (copy), u6 (copy), u7 (copy), l__Add__6 (copy), u10 (copy)
        local v25 = u2(p22, p23, p24);
        l__insert__2(u8, v25);
        u9[p22] = v25;
        local v26 = l__new__4("Model", workspace);
        v26.Name = p23;
        v25.Character = v26;
        local v27 = l__new__4("Part", v26);
        v27.Name = "Torso";
        v27.FormFactor = 3;
        v27.Size = Vector3.new(2, 2, 1);
        v27.TopSurface = 0;
        v27.BottomSurface = 0;
        v27.Anchored = true;
        local v28 = l__new__4("Part", v26);
        v28.Name = "Head";
        v28.FormFactor = 3;
        v28.Size = Vector3.new(2, 1, 1);
        v28.TopSurface = 0;
        v28.BottomSurface = 0;
        l__new__4("SpecialMesh", v28).MeshType = 0;
        local v29 = l__new__4("Motor6D", v27);
        v29.Name = "Neck";
        v29.Part0 = v27;
        v29.Part1 = v28;
        v29.C0 = u6;
        v29.C1 = u7;
        l__new__4("Humanoid", v26);
        l__Add__6(v25);
        u10:Call(v25);
        return v25;
    end,
    RemoveBot = u15,
    BotAdded = u10,
    BotRemoving = u11,
    BotIdChanged = u12
};
