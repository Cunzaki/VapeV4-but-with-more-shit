-- Decompiled from: ReplicatedStorage.Client.Source.VoiceChatHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("RunService");
game:GetService("SoundService");
local l__Players__2 = game:GetService("Players");
require(l__ReplicatedStorage__1.Modules.Signal);
local l__Audio__3 = require(l__ReplicatedStorage__1.Modules.Audio);
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = require(l__ReplicatedStorage__1.Modules.PlayerConnections).Get();
local u2 = l__Mince__4:Get("TriggerHandler");
local u3 = l__Mince__4:Get("Settings");
local u4 = l__Mince__4:Get("RegionHandler");
l__Mince__4:Get("SoundArea");
local u5 = l__Mince__4:GetEvent("SyncState");
local _ = workspace.CurrentCamera;
local u6 = {
    DefaultSoundGroup = "Voicechat",
    ROLLOFFMINDIST = 50,
    ROLLOFFMAXDIST = 75,
    PlayerGraphs = {},
    PlayerVCHandlers = {},
    UpdateTimeout = {},
    Microphones = {}
};
local u7 = {};
u7.__index = u7;
local v8 = l__Mince__4.Component({
    Tag = "Microphone"
});
function u6.GetPlayerGraphIfExists(p9) --[[ Line: 48 ]]
    -- upvalues: u6 (copy)
    local v10;
    if u6.PlayerGraphs[p9] == "Processing" then
        v10 = false;
    else
        v10 = u6.PlayerGraphs[p9];
    end;
    return v10;
end;
function u6.GetPlayerGraph(p11) --[[ Line: 52 ]]
    -- upvalues: u6 (copy), l__Audio__3 (copy), u3 (copy)
    if u6.PlayerGraphs[p11] == "Processing" then
        repeat
            wait();
        until u6.PlayerGraphs[p11] ~= "Processing";
    end;
    if not u6.PlayerGraphs[p11] then
        u6.PlayerGraphs[p11] = "Processing";
        local l__AudioDeviceInput__5 = p11:WaitForChild("AudioDeviceInput");
        local v12 = l__Audio__3.NewGraph(l__AudioDeviceInput__5);
        v12:CreateModifier("Equalizer", {
            Name = "RolloffEqualizer"
        });
        v12:CreateModifier("Fader", {
            Name = "RolloffFader"
        });
        v12:SetVolume((u3.GetValue("VCVol") or 0.5) * 2.5);
        u6.PlayerGraphs[p11] = v12;
    end;
    return u6.PlayerGraphs[p11];
end;
function u7.ApplyEffect(p13, p14) --[[ Line: 71 ]]
    -- upvalues: u6 (copy), u3 (copy)
    local v15 = u6.PlayerGraphs[p13.Player];
    local v16 = game.ReplicatedStorage.Assets.VoiceEffect:FindFirstChild(p14);
    if v16 then
        local v17 = v16:Clone();
        p13.Effects[p14] = v17;
        v17.Parent = v15.ProducerInstance.Modifiers;
        if u3.GetValue("VCEffects") then
            v15:ConnectModifier(v17);
        end;
    else
        return error((`VoiceChatHandler: No effect by the name of {p14}!`));
    end;
end;
function u7.AddEmitter(p18, p19) --[[ Line: 85 ]]
    -- upvalues: u6 (copy)
    local v20 = p19:IsA("AudioEmitter");
    local v21 = `Cannot add emitter for player {p18.Player}! {p19} is not a valid AudioEmitter!`;
    assert(v20, v21);
    u6.PlayerGraphs[p18.Player]:ConnectConsumer(p19);
end;
function u7.RemoveEffect(p22, p23) --[[ Line: 90 ]]
    local v24 = p22.Effects[p23];
    if not v24 then
        return warn((`VoiceChatHandler: No effect by the name of {p23} to remove!`));
    end;
    v24:Destroy();
    p22.Effects[p23] = nil;
end;
function u7.RemoveEmitter(p25, p26) --[[ Line: 98 ]]
    -- upvalues: u6 (copy)
    local v27 = p26:IsA("AudioEmitter");
    local v28 = `Cannot remove emitter for player {p25.Player}! {p26} is not a valid AudioEmitter!`;
    assert(v27, v28);
    u6.PlayerGraphs[p25.Player]:RemoveConsumer(p26);
end;
function u7.GetAnalyzer(p29) --[[ Line: 103 ]]
    -- upvalues: u6 (copy)
    local v30 = u6.PlayerGraphs[p29.Player];
    if not v30:GetAudioInstance("VCAnalyzer") then
        local v31 = Instance.new("AudioAnalyzer");
        v31.Name = "VCAnalyzer";
        v30:ConnectConsumer(v31);
    end;
    return v30:GetAudioInstance("VCAnalyzer");
end;
function u7.GetEffect(p32, p33, p34) --[[ Line: 115 ]]
    -- upvalues: u6 (copy)
    if not p32.Effects[p33] and (p34 and not u6.PlayerGraphs[p32.Player]:GetAudioInstance(p33)) then
        p32:ApplyEffect(p33);
    end;
    return p32.Effects[p33] or u6.PlayerGraphs[p32.Player]:GetAudioInstance(p33);
end;
function u7.ClearAll(p35) --[[ Line: 123 ]]
    -- upvalues: u6 (copy)
    for v36, _ in pairs(p35.Effects) do
        p35:RemoveEffect(v36);
    end;
    for _, v37 in pairs(u6.PlayerGraphs[p35.Player].Consumers) do
        if v37:IsA("AudioEmitter") and not v37:HasTag("RbxDefaultVoiceEmitter") then
            p35:RemoveEmitter(v37);
        end;
    end;
end;
function u7.Remove(p38) --[[ Line: 135 ]]
    -- upvalues: u6 (copy)
    u6.PlayerGraphs[p38.Player] = nil;
end;
function u6.CalculateRolloff(p39, p40, p41) --[[ Line: 139 ]]
    -- upvalues: u6 (copy), u3 (copy), u4 (copy)
    if not p40 then
        return;
    end;
    if not p41 then
        return;
    end;
    local v42 = u6.GetPlayerGraphIfExists(p39);
    if not v42 then
        return;
    end;
    local v43 = v42:GetAudioInstance("RolloffEqualizer");
    local v44 = v42:GetAudioInstance("RolloffFader");
    if not (v43 and v44) then
        return;
    end;
    local l__Magnitude__6 = (p41.Position - p40.CFrame.Position).Magnitude;
    local v45 = (u6.ROLLOFFMAXDIST <= u6.ROLLOFFMINDIST or l__Magnitude__6 < u6.ROLLOFFMINDIST) and 1 or (u6.ROLLOFFMAXDIST < l__Magnitude__6 and 0 or (1 - (l__Magnitude__6 - u6.ROLLOFFMINDIST) / (u6.ROLLOFFMAXDIST - u6.ROLLOFFMINDIST)) ^ 2);
    local v46 = 4 / math.min(1, l__Magnitude__6);
    local v47 = math.clamp(v46, 0, 1);
    local v48, v49;
    if u3.GetValue("MufflePlayers") then
        v48 = 0.15;
        v49 = { -30, 10, -20 };
        if next(u6.LocalRegions) then
            for _, v50 in u6.LocalRegions do
                if v50:Has(p39) then
                    v49 = { 0, 0, 0 };
                    v48 = 1;
                    break;
                end;
            end;
        elseif not u4.IsPlayerInRegion(p39) then
            v49 = { 0, 0, 0 };
            v48 = 1;
        end;
    else
        v49 = { 0, 0, 0 };
        v48 = 1.5;
    end;
    v43.HighGain = v49[1];
    v43.LowGain = v49[2];
    v43.MidGain = v49[3];
    v44.Volume = v45 / v47 * v48;
end;
function u6.LoadAreaEffects() --[[ Line: 198 ]]
    -- upvalues: u6 (copy), l__Mince__4 (copy)
    u6.AreaEffects = {};
    for v51, v52 in l__Mince__4.Config.Sounds.Effects do
        local v53 = {};
        for v54, v55 in v52 do
            local v56;
            if type(v55) == "table" then
                local v57 = "Audio" .. string.gsub(v55.Class, "SoundEffect", "");
                v56 = Instance.new(v57);
                for v58, v59 in v55.Properties do
                    if v58 ~= "Priority" then
                        v56[v58] = v59;
                    end;
                end;
            else
                v56 = Instance.new("AudioReverb");
                v56.DecayTime = 12;
            end;
            v56.Name = `{v51}{v54}`;
            v56.Parent = game.ReplicatedStorage.Assets.VoiceEffect;
            table.insert(v53, v56.Name);
        end;
        u6.AreaEffects[v51] = v53;
    end;
end;
function u6.UpdateAreaEffects(p60) --[[ Line: 229 ]]
    -- upvalues: u6 (copy), l__Players__2 (copy)
    if p60 and p60 ~= u6.AreaEffect then
        local v61 = u6.AreaEffects[p60];
        if u6.AreaEffect then
            for _, v62 in l__Players__2:GetPlayers() do
                local v63 = u6.GetHandlerIfExists(v62);
                if v63 then
                    for _, v64 in u6.AreaEffect do
                        v63:RemoveEffect(v64);
                    end;
                end;
            end;
        end;
        if p60 == "None" then
            u6.AreaEffect = nil;
        else
            for _, v65 in game.Players:GetPlayers() do
                local v66 = u6.GetHandlerIfExists(v65);
                if v66 then
                    for _, v67 in v61 do
                        v66:ApplyEffect(v67);
                    end;
                end;
            end;
        end;
    end;
end;
function u6.GetHandlerIfExists(p68) --[[ Line: 261 ]]
    -- upvalues: u6 (copy)
    return u6.PlayerVCHandlers[p68];
end;
function u6.GetHandler(p69) --[[ Line: 265 ]]
    -- upvalues: u6 (copy), u7 (copy), u1 (copy), u3 (copy)
    if u6.PlayerVCHandlers[p69] then
        return u6.PlayerVCHandlers[p69];
    end;
    local u70 = setmetatable({
        Player = p69,
        Effects = {}
    }, u7);
    u1:AddPlayerConnection(p69, u3.SettingChanged("VCEffects"):Connect(function(p71) --[[ Line: 272 ]]
        -- upvalues: u6 (ref), u70 (copy)
        local v72 = u6.PlayerGraphs[u70.Player];
        for v73, v74 in pairs(u70.Effects) do
            if v72:GetAudioInstance(v73) or not p71 then
                if not p71 and v72:GetAudioInstance(v73) then
                    v72:RemoveModifier(v74);
                end;
            else
                v72:ConnectModifier(v74);
            end;
        end;
    end));
    u6.GetPlayerGraph(p69);
    u6.PlayerVCHandlers[p69] = u70;
    return u6.PlayerVCHandlers[p69];
end;
function u6.SetupCharacter(p75, p76) --[[ Line: 290 ]]
    -- upvalues: u6 (copy)
    local v77 = u6.GetPlayerGraphIfExists(p76);
    if v77 then
        local l__AudioEmitter__7 = p75:WaitForChild("AudioEmitter", 5);
        if l__AudioEmitter__7 then
            l__AudioEmitter__7:Destroy();
        end;
        local v78 = Instance.new("AudioEmitter", p75.PrimaryPart);
        v78.Archivable = false;
        v77:ConnectConsumer(v78);
    end;
end;
function v8.Construct(u79) --[[ Line: 304 ]]
    -- upvalues: u2 (copy), l__Mince__4 (copy), u5 (copy), u6 (copy)
    task.wait(1);
    if not u79.Instance:IsA("BasePart") then
        return warn((`Microphone {u79.Instance} is not a valid Mic!`));
    end;
    local v80 = {
        MicPart = u79.Instance,
        Emitters = {}
    };
    local v81 = u2.PsudeoTrigger(u79.Instance:GetPivot(), Vector3.new(6, 8, 6), {
        Name = u79.MicID
    });
    for _, v82 in pairs(u79.Instance:GetDescendants()) do
        if v82.Name ~= "Speaker" or not v82:IsA("BasePart") then
            return;
        end;
        table.insert(v80.Emitters, Instance.new("AudioEmitter", v82));
    end;
    v81.Entered:Connect(function() --[[ Line: 322 ]]
        -- upvalues: l__Mince__4 (ref), u5 (ref), u79 (copy)
        if not l__Mince__4.Config.Humanoid.Parent:GetAttribute("Microphone") then
            u5:Fire("Microphone", u79.Instance:GetAttribute("MicID"));
        end;
    end);
    v81.Exited:Connect(function() --[[ Line: 328 ]]
        -- upvalues: u5 (ref)
        u5:Fire("Microphone", nil);
    end);
    if #v80.Emitters < 1 then
        warn((`Microphone {u79.Instance} has no speakers!`));
    end;
    u6.Microphones[u79.MicID] = v80;
end;
function u6.GetMic(p83) --[[ Line: 336 ]]
    -- upvalues: u6 (copy)
    return u6.Microphones[p83];
end;
function u6.GetMics() --[[ Line: 340 ]]
    -- upvalues: u6 (copy)
    return u6.Microphones;
end;
function u6.PlayerAdded(u84) --[[ Line: 344 ]]
    -- upvalues: u6 (copy), l__Players__2 (copy), u3 (copy), u1 (copy)
    u6.GetHandler(u84);
    local v85 = u6.GetPlayerGraph(u84);
    if u84 == l__Players__2.LocalPlayer and not u3.GetValue("HearSelf") then
        v85:SetVolume(0);
    end;
    if u84.Character then
        u6.SetupCharacter(u84.Character, u84);
    end;
    u1:AddPlayerConnection(u84, u84.CharacterAdded:Connect(function(p86) --[[ Line: 357 ]]
        -- upvalues: u6 (ref), u84 (copy)
        u6.SetupCharacter(p86, u84);
    end));
end;
function u6.Setup() --[[ Line: 362 ]]
    -- upvalues: u6 (copy), l__Players__2 (copy), u4 (copy), u3 (copy)
    u6.CURVE = {
        [0] = 1,
        [u6.ROLLOFFMINDIST] = 1,
        [u6.ROLLOFFMAXDIST] = 0
    };
    for _, v87 in l__Players__2:GetPlayers() do
        task.defer(u6.PlayerAdded, v87);
    end;
    u6.LocalRegions = {};
    u4.GetPlayerRegionsChangedSignal(l__Players__2.LocalPlayer):Connect(function() --[[ Line: 375 ]]
        -- upvalues: u4 (ref), l__Players__2 (ref), u6 (ref)
        local v88 = u4.GetPlayerRegions(l__Players__2.LocalPlayer);
        for v89 = #v88, 1, -1 do
            if v88[v89].IgnoreVC then
                table.remove(v88, v89);
            end;
        end;
        u6.LocalRegions = v88;
    end);
    l__Players__2.PlayerAdded:Connect(u6.PlayerAdded);
    u6.LoadAreaEffects();
    u3.SettingChanged("HearSelf"):Connect(function(p90) --[[ Line: 391 ]]
        -- upvalues: u6 (ref), l__Players__2 (ref), u3 (ref)
        u6.GetPlayerGraph(l__Players__2.LocalPlayer):SetVolume(p90 and (u3.GetValue("VCVol") or 0.5) * 2.5 or 0);
    end);
    u3.SettingChanged("VCVol"):Connect(function(p91) --[[ Line: 395 ]]
        -- upvalues: u6 (ref), l__Players__2 (ref), u3 (ref)
        for v92, v93 in pairs(u6.PlayerGraphs) do
            if v92 ~= l__Players__2.LocalPlayer or u3.GetValue("HearSelf") then
                v93:SetVolume(p91 * 2.5);
            end;
        end;
    end);
    l__Players__2.PlayerRemoving:Connect(function(p94) --[[ Line: 404 ]]
        -- upvalues: u6 (ref)
        local v95 = u6.GetHandlerIfExists(p94);
        if v95 then
            v95:ClearAll();
            v95:Remove();
        end;
        u6.PlayerVCHandlers[p94] = nil;
    end);
end;
return u6;
