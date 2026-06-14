-- Decompiled from: StarterGui.PV2Piano.PianoController.PianoModules
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
local u18 = {
    GetPianoModule = function(p1, p2) --[[ Name: GetPianoModule, Line 6 ]]
        return p1[p2] or p1:LoadPianoModule(p2);
    end,
    GetPianos = function(p3) --[[ Name: GetPianos, Line 10 ]]
        local v4 = {};
        for v5, v6 in pairs(p3) do
            if typeof(v5) == "Instance" and type(v6) == "table" then
                table.insert(v4, v5);
            end;
        end;
        return v4;
    end,
    GetPianoModules = function(p7) --[[ Name: GetPianoModules, Line 20 ]]
        local v8 = {};
        for v9, v10 in pairs(p7) do
            if typeof(v9) == "Instance" and type(v10) == "table" then
                table.insert(v8, v10);
            end;
        end;
        return v8;
    end,
    LoadPianoModule = function(u11, u12) --[[ Name: LoadPianoModule, Line 30 ]]
        if not u11[u12] then
            local u13 = u12:FindFirstChild("PianoModule");
            if u13 then
                local v14, v15 = pcall(function() --[[ Line: 34 ]]
                    -- upvalues: u11 (copy), u12 (copy), u13 (copy)
                    u11[u12] = require(u13);
                end);
                if not v14 then
                    warn(v15);
                    u11[u12] = {};
                end;
                return u11[u12];
            end;
            u11[u12] = {};
        end;
    end,
    UnloadPianoModule = function(p16, p17) --[[ Name: UnloadPianoModule, Line 49 ]]
        p16[p17] = nil;
    end
};
for _, v19 in ipairs(l__CollectionService__1:GetTagged("Piano")) do
    u18:LoadPianoModule(v19);
end;
l__CollectionService__1:GetInstanceAddedSignal("Piano"):Connect(function(p20) --[[ Line: 58 ]]
    -- upvalues: u18 (copy)
    u18:LoadPianoModule(p20);
end);
l__CollectionService__1:GetInstanceRemovedSignal("Piano"):Connect(function(p21) --[[ Line: 61 ]]
    -- upvalues: u18 (copy)
    u18:UnloadPianoModule(p21);
end);
return u18;
