-- Decompiled from: ReplicatedStorage.Modules.Audio
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("SoundService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Signal__2 = require(l__ReplicatedStorage__1.Modules:WaitForChild("Signal"));
local u1 = {
    Graphs = {}
};
local u2 = {};
u2.__index = u2;
function u1.NewGraph(u3) --[[ Line: 16 ]]
    -- upvalues: l__Signal__2 (copy), u2 (copy), u1 (copy)
    local v4 = {
        BranchingFrom = nil,
        ProducerInstance = u3,
        Modifiers = {},
        ModifierLookup = {},
        ModifierRemoving = l__Signal__2.new(),
        ModifierAdded = l__Signal__2.new(),
        Consumers = {},
        ConsumerLookup = {},
        ConsumerRemoved = l__Signal__2.new(),
        ConsumerAdded = l__Signal__2.new(),
        Wires = {},
        SidechainWires = {},
        Branches = {}
    };
    local u5 = setmetatable(v4, u2);
    if not u3.Parent then
        u3.Parent = game:GetService("SoundService");
    end;
    (u3:FindFirstChild("Modifiers") or Instance.new("Folder", u3)).Name = "Modifiers";
    (u3:FindFirstChild("Consumers") or Instance.new("Folder", u3)).Name = "Consumers";
    local v6 = Instance.new("AudioFader");
    v6.Name = "_MainVolume";
    u5:ConnectModifier(v6);
    table.insert(u1.Graphs, u5);
    u5.ModifierRemoving:Connect(function(p7) --[[ Line: 51 ]]
        -- upvalues: u5 (copy)
        for _, v8 in pairs(u5.Branches) do
            if p7 == v8.ProducerInstance then
                v8:Cleanup(v8.DestroyAll);
                table.remove(u5.Branches, table.find(u5.Branches, v8));
            end;
        end;
    end);
    u3.Destroying:Connect(function() --[[ Line: 61 ]]
        -- upvalues: u1 (ref), u3 (copy)
        table.remove(u1.Graphs, table.find(u1.Graphs, u3));
    end);
    return u5;
end;
function u2.CreateModifier(p9, u10, u11) --[[ Line: 68 ]]
    local u12 = nil;
    local v15, v16 = pcall(function() --[[ Line: 70 ]]
        -- upvalues: u12 (ref), u10 (copy), u11 (copy)
        u12 = Instance.new((`Audio{u10}`));
        if u11 then
            for v13, v14 in pairs(u11) do
                u12[v13] = v14;
            end;
        end;
    end);
    if v15 then
        p9:ConnectModifier(u12);
        return u12;
    end;
    warn(`Could not create instance "Audio{u10}"!\n`, v16);
end;
function u2.SetVolume(p17, p18) --[[ Line: 87 ]]
    p17:GetAudioInstance("_MainVolume").Volume = p18;
    return p17;
end;
function u2.ConnectModifier(u19, u20) --[[ Line: 93 ]]
    -- upvalues: u1 (copy)
    if not u20.Parent then
        u20.Parent = u19.ProducerInstance.Modifiers;
    end;
    local v21;
    if #u19.Modifiers > 0 then
        v21 = u19.Modifiers[#u19.Modifiers];
    else
        v21 = false;
    end;
    if v21 then
        u1.Wire(v21, u20, u19);
    else
        u1.Wire(u19.ProducerInstance, u20, u19);
    end;
    u20.Destroying:Once(function() --[[ Line: 105 ]]
        -- upvalues: u19 (copy), u20 (copy)
        u19:RemoveModifier(u20, true);
    end);
    table.insert(u19.Modifiers, u20);
    u19.ModifierLookup[u20.Name] = u20;
    u1.UpdateConsumers(u19, v21);
    u19.ModifierAdded:Fire(u20);
    return u19;
end;
function u2.RemoveModifier(p22, p23, p24) --[[ Line: 118 ]]
    -- upvalues: u1 (copy)
    if not p24 or p23.Name ~= "_MainVolume" then
        assert(p23.Name ~= "_MainVolume", "You cannot delete the _MainVolume modifier!");
        local v25 = table.find(p22.Modifiers, p23);
        p22.ModifierRemoving:Fire(p23);
        if p22.Wires[p23] then
            for _, v26 in pairs(p22.Wires[p23]) do
                local l__SourceInstance__3 = v26.SourceInstance;
                local v27 = p22.Modifiers[v25 + 1];
                table.remove(p22.Wires[p23], table.find(p22.Wires[p23], v26));
                v26:Destroy();
                if v27 then
                    for _, v28 in pairs(p22.Wires[v27]) do
                        if v28.SourceInstance == p23 then
                            table.remove(p22.Wires[v27], table.find(p22.Wires[v27], v28));
                            v28:Destroy();
                            u1.Wire(l__SourceInstance__3, v27, p22);
                        end;
                    end;
                end;
            end;
        end;
        p22.ModifierLookup[p23.Name] = nil;
        table.remove(p22.Modifiers, v25);
        u1.UpdateConsumers(p22, p23);
        return p22;
    end;
end;
function u2.ConnectConsumer(u29, u30) --[[ Line: 153 ]]
    -- upvalues: u1 (copy)
    if not u30.Parent then
        u30.Parent = u29.ProducerInstance.Consumers;
    end;
    u1.Wire(u29.Modifiers[#u29.Modifiers] or u29.ProducerInstance, u30, u29);
    table.insert(u29.Consumers, u30);
    u29.ConsumerLookup[u30.Name] = u30;
    u30.Destroying:Once(function() --[[ Line: 164 ]]
        -- upvalues: u30 (copy), u29 (copy)
        print((`Consumer {u30} is destroying`));
        u29:RemoveConsumer(u30);
    end);
    u29.ConsumerAdded:Fire(u30);
    return u29;
end;
function u2.RemoveConsumer(p31, p32) --[[ Line: 174 ]]
    local v33 = p31.Wires[p32];
    if v33 then
        for _, v34 in pairs(v33) do
            v34:Destroy();
            table.remove(p31.Wires[p32], table.find(p31.Wires[p32], v34));
        end;
    end;
    table.remove(p31.Consumers, table.find(p31.Consumers, p32));
    p31.ConsumerLookup[p32.Name] = nil;
    p31.ConsumerRemoved:Fire(p32);
    return p31;
end;
function u2.GetAudioInstance(p35, p36) --[[ Line: 191 ]]
    return p35.ModifierLookup[p36] or p35.ConsumerLookup[p36];
end;
function u2.Branch(p37, p38, p39) --[[ Line: 199 ]]
    -- upvalues: u1 (copy)
    if not p37:GetAudioInstance(p38.Name) then
        error("Attempted to branch off of non existent modifier!");
    end;
    local v40 = u1.NewGraph(p38);
    v40.BranchingFrom = p37;
    v40.DestroyAll = p39;
    table.insert(p37.Branches, v40);
    return v40;
end;
function u2.Cleanup(p41, p42) --[[ Line: 211 ]]
    -- upvalues: u1 (copy)
    for _, v43 in pairs(p41.Modifiers) do
        if p42 then
            v43:Destroy();
        else
            p41:RemoveModifier(v43);
        end;
    end;
    for _, v44 in pairs(p41.Consumers) do
        if p42 then
            v44:Destroy();
        else
            p41:RemoveModifier(v44);
        end;
    end;
    if p42 then
        p41.ProducerInstance:Destroy();
    else
        table.remove(u1.Graphs, table.find(u1.Graphs, p41));
    end;
end;
function u2.Duck(u45, p46, p47) --[[ Line: 235 ]]
    local v48 = u45:GetAudioInstance("_DuckCompressor") or u45:CreateModifier("Compressor", {
        Name = "_DuckCompressor"
    });
    local v49 = Instance.new("Wire");
    v49.TargetName = "Sidechain";
    v49.SourceInstance = p46;
    v49.TargetInstance = v48;
    v49.Parent = v48;
    v49.Name = `{p46}ToSidechain{v48}`;
    table.insert(u45.SidechainWires, v49);
    u45.DuckConnection = p46.Destroying:Once(function() --[[ Line: 248 ]]
        -- upvalues: u45 (copy)
        u45:ReleaseDuck();
    end);
    if not p47 then
        return u45;
    end;
    for v50, v51 in ipairs(p47) do
        v48[v50] = v51;
    end;
    return u45;
end;
function u2.ReleaseDuck(p52) --[[ Line: 260 ]]
    local v53 = p52:GetAudioInstance("_DuckCompressor");
    if not v53 then
        warn("AudioGraph isn\'t ducked!");
        return p52;
    end;
    for v54, v55 in pairs(p52.SidechainWires) do
        if v55.TargetInstance == v53 then
            v55:Destroy();
            table.remove(p52.SidechainWires, v54);
        end;
    end;
    if p52.DuckConnection then
        p52.DuckConnection:Disconnect();
    end;
    v53:Destroy();
    return p52;
end;
function u1.Wire(p56, p57, p58) --[[ Line: 283 ]]
    local v59 = Instance.new("Wire");
    v59.Parent = p57;
    v59.SourceInstance = p56;
    v59.TargetInstance = p57;
    v59.Name = `{p56.Name}To{p57.Name}`;
    if p58.Wires[p57] then
        table.insert(p58.Wires[p57], v59);
    else
        p58.Wires[p57] = { v59 };
    end;
end;
function u1.UpdateConsumers(p60, p61) --[[ Line: 298 ]]
    -- upvalues: u1 (copy)
    for _, v62 in ipairs(p60.Consumers) do
        local v63 = p60.Modifiers[#p60.Modifiers] or p60.ProducerInstance;
        local v64 = p60.Wires[v62];
        if v64 then
            for _, v65 in ipairs(v64) do
                if v65.SourceInstance == p61 then
                    v65:Destroy();
                    table.remove(p60.Wires[v62], table.find(p60.Wires[v62], v65));
                    u1.Wire(v63, v62, p60);
                end;
            end;
        end;
    end;
end;
function u1.GetFirstGraph(p66) --[[ Line: 314 ]]
    -- upvalues: u1 (copy)
    for _, v67 in ipairs(u1.Graphs) do
        if v67.ProducerInstance == p66 then
            return v67;
        end;
    end;
    return nil;
end;
return u1;
