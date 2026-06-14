-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.chrono.Shared.Config
-- Class: ModuleScript
-- Place: Ugc (126691165749976)

-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);
local u1 = game:GetService("RunService"):IsServer();
local u2 = false;
local u3 = {
    __VERSION = "v2.0.7",
    CHECK_NEW_VERSION = true,
    MAX_TOTAL_BYTES_PER_FRAME_PER_PLAYER = 3000,
    MIN_BUFFER = 0.09,
    MAX_BUFFER = 0.5,
    GRID_UPDATE_INTERVAL = 0.1,
    GRID_MAX_UPDATE_TIME = 0.0005,
    WARNING_SEVERITY = "MEDIUM",
    DEFAULT_NORMAL_TICK_DISTANCE = 50,
    DEFAULT_HALF_TICK_DISTANCE = 100,
    REPLICATE_DEATHS = "PLAYER_CHARACTERS",
    REPLICATE_CFRAME_SETTERS = "PLAYER_ENTITIES",
    PLAYER_REPLICATION = "AUTOMATIC",
    DEFAULT_MODEL_REPLICATION_MODE = "NATIVE_WITH_LOCK",
    SEND_FULL_ROTATION = false,
    MAX_SNAPSHOT_COUNT = 30
};
local u4 = {
    DEFAULT = {
        NAME = "DEFAULT",
        TICK_RATE = 0.03333333333333333,
        BUFFER = 0.1
    },
    WITH_ROT = {
        NAME = "WITH_ROT",
        TICK_RATE = 0.05,
        BUFFER = 0.1,
        FULL_ROTATION = true
    },
    PLAYER = {
        NAME = "PLAYER",
        MODEL_REPLICATION_MODE = "NATIVE",
        BUFFER = 0,
        TICK_RATE = 0.05
    }
};
local u5 = {};
local u6 = {};
local u7 = {};
return {
    SetConfig = function(p8, p9) --[[ Line: 147 ]]
        -- upvalues: u2 (ref), u3 (copy)
        assert(not u2, "Config is locked and cannot be modified after startup.");
        u3[p8] = p9;
    end,
    RegisterEntityType = function(p10, p11) --[[ Name: RegisterEntityType, Line 126 ]]
        -- upvalues: u2 (ref), u4 (copy)
        assert(not u2, "Config is locked and cannot be modified after startup.");
        u4[p10] = p11;
    end,
    RegisterEntityModel = function(p12, p13, p14) --[[ Name: RegisterEntityModel, Line 139 ]]
        -- upvalues: u5 (copy), u6 (copy)
        if p13 ~= false and (p13:IsA("Model") and not p13.PrimaryPart) then
            error(p12 .. " must have a PrimaryPart to be registered as an entity model.");
        end;
        u5[p12] = p13;
        u6[p12] = p14;
    end,
    FLAGS = {
        SNAPSHOT_INTERPOLATION_FIX = true,
        SET_CFRAME_FIX = true
    },
    _EntityConfigs = u4,
    _GetEntityType = function(p15) --[[ Name: GetEntityType, Line 152 ]]
        -- upvalues: u4 (copy)
        return p15 and u4[p15] or u4.DEFAULT;
    end,
    _GetEntityModel = function(p16) --[[ Name: GetEntityModel, Line 156 ]]
        -- upvalues: u5 (copy)
        if u5[p16] ~= nil then
            return u5[p16];
        end;
        warn((`Entity model {p16} not found in Config.`));
        return nil;
    end,
    _GetConfig = function(p17) --[[ Name: GetConfig, Line 168 ]]
        -- upvalues: u3 (copy)
        return u3[p17];
    end,
    _Lock = function() --[[ Name: Lock, Line 188 ]]
        -- upvalues: u2 (ref), u3 (copy), u4 (copy), u1 (copy), u7 (copy)
        require(script.Parent.Warn).low("Config is now locked");
        u2 = true;
        local l__DEFAULT_NORMAL_TICK_DISTANCE__1 = u3.DEFAULT_NORMAL_TICK_DISTANCE;
        local l__DEFAULT_HALF_TICK_DISTANCE__2 = u3.DEFAULT_HALF_TICK_DISTANCE;
        for v18, v19 in u4 do
            local v20 = table.clone(v19);
            v20.NAME = v18;
            v20.AUTO_UPDATE_POSITION = v20.AUTO_UPDATE_POSITION ~= false;
            v20.FULL_ROTATION = v20.FULL_ROTATION or false;
            v20.NORMAL_TICK_DISTANCE = v20.NORMAL_TICK_DISTANCE or l__DEFAULT_NORMAL_TICK_DISTANCE__1;
            v20.HALF_TICK_DISTANCE = v20.HALF_TICK_DISTANCE or l__DEFAULT_HALF_TICK_DISTANCE__2;
            v20.MODEL_REPLICATION_MODE = v20.MODEL_REPLICATION_MODE or u3.DEFAULT_MODEL_REPLICATION_MODE;
            if u1 then
                v20.TICKER = require(script.Parent.Ticker).new(v20);
            else
                v20.CLIENT_CLOCK = {};
            end;
            u4[v18] = table.freeze(v20);
        end;
        for _, v21 in u7 do
            v21();
        end;
    end,
    _WaitForLock = function(p22) --[[ Name: WaitForLock, Line 173 ]]
        -- upvalues: u2 (ref), u7 (copy)
        if u2 then
            p22();
        else
            table.insert(u7, p22);
        end;
    end,
    _GetBroadPhase = function(p23) --[[ Name: GetBroadPhase, Line 164 ]]
        -- upvalues: u6 (copy)
        return u6[p23];
    end,
    _Base_Config = u3,
    SetModelPrimaryForChrono = function(p24, p25) --[[ Name: SetModelPrimaryForChrono, Line 233 ]]
        p24:SetAttribute("__CHRONO_PRIMARY", p25);
    end,
    SetWarningSeverity = function(p26) --[[ Name: SetWarningSeverity, Line 181 ]]
        -- upvalues: u3 (copy)
        if p26 ~= "NONE" and (p26 ~= "LOW" and (p26 ~= "MEDIUM" and p26 ~= "HIGH")) then
            error("Invalid warning level: " .. tostring(p26));
        end;
        u3.WARNING_SEVERITY = p26;
    end
};
