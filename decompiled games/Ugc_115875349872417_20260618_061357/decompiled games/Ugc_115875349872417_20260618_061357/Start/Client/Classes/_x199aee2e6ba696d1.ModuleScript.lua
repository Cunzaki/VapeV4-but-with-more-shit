-- Decompiled from: Start.Client.Classes._x199aee2e6ba696d1
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__Players__2 = game:GetService("Players");
local l__UserInputService__3 = game:GetService("UserInputService");
local l__RunService__4 = game:GetService("RunService");
local l__ModuleScripts__5 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__6 = require(l__ModuleScripts__5.Packets);
local l__Trove__7 = require(l__ModuleScripts__5.Trove);
local l__Spring__8 = require(l__ModuleScripts__5.Spring);
local l__UIAssets__9 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local u1 = {};
u1.__index = u1;
local l__ClientRoot__10 = require(script.Parent.Parent.ClientRoot);
local l__Classes__11 = l__ClientRoot__10.Classes;
local l__Context__12 = l__ClientRoot__10.Context;
local l__LocalPlayer__13 = l__Players__2.LocalPlayer;
local function u3(p2) --[[ Line: 63 ]]
    return p2:IsA("ParticleEmitter") or (p2:IsA("Beam") or p2:IsA("Trail") or (p2:IsA("BillboardGui") or p2:IsA("SurfaceGui")) or (p2:IsA("PointLight") or p2:IsA("SpotLight") or (p2:IsA("SurfaceLight") or p2:IsA("Highlight"))));
end;
local function u10(p4) --[[ Line: 79 ]]
    local l__CFrame__14 = p4.CFrame;
    local v5 = p4.Size * 0.5;
    local l__RightVector__15 = l__CFrame__14.RightVector;
    local l__UpVector__16 = l__CFrame__14.UpVector;
    local l__LookVector__17 = l__CFrame__14.LookVector;
    local v6 = math.abs(l__RightVector__15.X) * v5.X + math.abs(l__UpVector__16.X) * v5.Y + math.abs(l__LookVector__17.X) * v5.Z;
    local v7 = math.abs(l__RightVector__15.Y) * v5.X + math.abs(l__UpVector__16.Y) * v5.Y + math.abs(l__LookVector__17.Y) * v5.Z;
    local v8 = math.abs(l__RightVector__15.Z) * v5.X + math.abs(l__UpVector__16.Z) * v5.Y + math.abs(l__LookVector__17.Z) * v5.Z;
    local v9 = Vector3.new(v6, v7, v8);
    local l__Position__18 = l__CFrame__14.Position;
    return l__Position__18 - v9, l__Position__18 + v9;
end;
local function u25(p11) --[[ Line: 94 ]]
    -- upvalues: u10 (copy)
    local v12 = p11:FindFirstChild("CameraAngles");
    local v13 = nil;
    local v14 = nil;
    for _, v15 in p11:GetDescendants() do
        if not (v12 and v15:IsDescendantOf(v12)) and v15:IsA("BasePart") then
            local v16, v17 = u10(v15);
            if v13 and v14 then
                local v18 = math.min(v13.X, v16.X);
                local v19 = math.min(v13.Y, v16.Y);
                local v20 = math.min(v13.Z, v16.Z);
                v13 = Vector3.new(v18, v19, v20);
                local v21 = math.max(v14.X, v17.X);
                local v22 = math.max(v14.Y, v17.Y);
                local v23 = math.max(v14.Z, v17.Z);
                v14 = Vector3.new(v21, v22, v23);
            else
                v14 = v17;
                v13 = v16;
            end;
        end;
    end;
    if not (v13 and v14) then
        return nil, nil;
    end;
    local v24 = v14 - v13;
    return v13 + v24 * 0.5, v24;
end;
function u1._x90d4581ac99dd483() --[[ Line: 136 ]]
    -- upvalues: u1 (copy), l__Trove__7 (copy), l__Spring__8 (copy)
    local v26 = setmetatable({}, u1);
    v26._x8634da6a26920aa5 = l__Trove__7.new();
    v26._x4181b4eb5653faa2 = "idle";
    v26._xbf73a0b250690860 = nil;
    v26._x6d08cf9411da6945 = nil;
    v26._x167ca2cf5f109288 = false;
    v26._x3144c8923b9b14af = v26._x8634da6a26920aa5:Extend();
    v26._x60a0e5a17e513660 = 0;
    v26._xe21a7aa6c7f19bd4 = {
        x = l__Spring__8.fromFrequency(5, 4, 1),
        y = l__Spring__8.fromFrequency(5, 4, 1),
        z = l__Spring__8.fromFrequency(5, 4, 1)
    };
    v26._xfd122f733d81ae4e = {
        wideshot_bored = 3
    };
    for _, v27 in pairs(v26._xe21a7aa6c7f19bd4) do
        v27:SnapToCriticalDamping();
    end;
    v26._x5f5f7d7f1245d748 = game:GetService("UserInputService"):GetMouseLocation();
    v26._x1ddb62815790cbdc = 0;
    v26._xe5f04c0e4d21bc33 = 0;
    v26._x3698dde2584de52e = 0;
    v26._x0329f68317eeff48 = 0;
    v26._x27f097e45e8e8402 = 0;
    v26._x06b036b3f2953813 = Vector3.new(0, 8, 0);
    v26._xb2cde732fa1b3748 = Vector3.new(80, 45, 80);
    v26._xce39060adb4e67dd = l__Trove__7.new();
    v26._xdcf9c75682230594 = nil;
    v26._x627624bb5018b87b = nil;
    v26._x1c52e8d714df94ce = nil;
    v26._xc39b083bfb3b911a = nil;
    v26._x44a57685a0706c13 = 0;
    v26._x3d54620a830709c6 = Vector3.new(0, 0, -1);
    v26._xef9b557423ef0642 = nil;
    v26._x60cd91c1ed5f178c = 0;
    v26._xe67ab1fa9edaa3e0 = false;
    v26._x4438e5cca0851840 = 0;
    v26._xf3d59dfa04d860b7 = false;
    v26._x90f08d75066b2a8b = l__Trove__7.new();
    v26._x2b005597329f4f81 = {};
    return v26;
end;
function u1.cleanUp(p28) --[[ Line: 194 ]]
    -- upvalues: l__Classes__11 (copy)
    p28._x3144c8923b9b14af:Clean();
    p28:_x0bb90927e7edfcec();
    p28._x8634da6a26920aa5:Clean();
    p28._x3144c8923b9b14af = p28._x8634da6a26920aa5:Extend();
    p28._x4181b4eb5653faa2 = "idle";
    p28._xbf73a0b250690860 = nil;
    l__Classes__11.Util:unbindFromRenderStep("SpectatorCam");
    p28._x06ea370a96d72e56 = nil;
    p28._x167ca2cf5f109288 = false;
    l__Classes__11._x32ae459de0772e82._x5b34a8c32cf04968 = false;
end;
function u1._x81b88048da82fb60(p29) --[[ Line: 207 ]]
    -- upvalues: l__Classes__11 (copy)
    if not p29._x167ca2cf5f109288 then
        return false;
    end;
    l__Classes__11.Util:unbindFromRenderStep("SpectatorCam");
    p29._x06ea370a96d72e56 = nil;
    p29._x167ca2cf5f109288 = false;
    return true;
end;
function u1._x9b4936706cf319b5(p30, p31) --[[ Line: 219 ]]
    if p30._x167ca2cf5f109288 then
    else
        p30:_x8fcdafeb8ad3312d(false, p31 or p30._xbf73a0b250690860);
    end;
end;
function u1._x3e96b288f12cd070(p32, p33) --[[ Line: 227 ]]
    if p32._x4181b4eb5653faa2 == "first_person" then
        p32:_x0bb90927e7edfcec();
    end;
    p32._x3144c8923b9b14af:Clean();
    p32._x60a0e5a17e513660 = 0;
    p32._x4181b4eb5653faa2 = p33;
end;
function u1._xb2f397f91e7cf846(p34) --[[ Line: 237 ]]
    p34._xce39060adb4e67dd:Clean();
    p34._xdcf9c75682230594 = nil;
    p34._x627624bb5018b87b = nil;
    p34._x1c52e8d714df94ce = nil;
end;
function u1._x014cc70b583e1d74(p35, p36, u37) --[[ Line: 244 ]]
    -- upvalues: u3 (copy)
    if p36 and p36.Parent then
        if p35._xdcf9c75682230594 == p36 and p35._x627624bb5018b87b == u37 then
        else
            p35:_xb2f397f91e7cf846();
            p35._xdcf9c75682230594 = p36;
            p35._x627624bb5018b87b = u37;
            local u38 = {};
            p35._x1c52e8d714df94ce = u38;
            local function u40(p39) --[[ Line: 290 ]]
                -- upvalues: u38 (copy), u3 (ref)
                if u38[p39] then
                elseif p39:IsA("BasePart") then
                    u38[p39] = {
                        local_transparency_modifier = p39.LocalTransparencyModifier
                    };
                    p39.LocalTransparencyModifier = 1;
                elseif p39:IsA("Decal") then
                    u38[p39] = {
                        transparency = p39.Transparency
                    };
                    p39.Transparency = 1;
                else
                    if u3(p39) then
                        u38[p39] = {
                            enabled = p39.Enabled
                        };
                        p39.Enabled = false;
                    end;
                end;
            end;
            local function u43(p41) --[[ Line: 268 ]]
                -- upvalues: u38 (copy), u37 (copy)
                if not u38[p41] then
                    local v42;
                    if u37 then
                        v42 = p41 == u37 and true or p41:IsDescendantOf(u37);
                    else
                        v42 = false;
                    end;
                    if not v42 then
                        if p41:IsA("BasePart") then
                            u38[p41] = {
                                local_transparency_modifier = p41.LocalTransparencyModifier
                            };
                            if p41.Parent and p41.Parent:IsA("Accessory") then
                                p41.LocalTransparencyModifier = math.max(p41.LocalTransparencyModifier, 1);
                            else
                                p41.LocalTransparencyModifier = math.max(p41.LocalTransparencyModifier, 0.97);
                            end;
                        else
                            if p41:IsA("Decal") then
                                u38[p41] = {
                                    transparency = p41.Transparency
                                };
                                p41.Transparency = math.max(p41.Transparency, 0.97);
                            end;
                        end;
                    end;
                end;
            end;
            for _, v44 in p36:GetDescendants() do
                u43(v44);
            end;
            if u37 then
                u40(u37);
                for _, v45 in u37:GetDescendants() do
                    u40(v45);
                end;
            end;
            p35._xce39060adb4e67dd:Connect(p36.DescendantAdded, function(p46) --[[ Line: 323 ]]
                -- upvalues: u37 (copy), u40 (copy), u43 (copy)
                local v47;
                if u37 then
                    v47 = p46 == u37 and true or p46:IsDescendantOf(u37);
                else
                    v47 = false;
                end;
                if v47 then
                    u40(p46);
                else
                    u43(p46);
                end;
            end);
            p35._xce39060adb4e67dd:Add(function() --[[ Line: 331 ]]
                -- upvalues: u38 (copy), u3 (ref)
                for v48, v49 in u38 do
                    if v48 and v48.Parent then
                        if v49.local_transparency_modifier == nil or not v48:IsA("BasePart") then
                            if v49.transparency == nil or not v48:IsA("Decal") then
                                if v49.enabled ~= nil and u3(v48) then
                                    v48.Enabled = v49.enabled;
                                end;
                            else
                                v48.Transparency = v49.transparency;
                            end;
                        else
                            v48.LocalTransparencyModifier = v49.local_transparency_modifier;
                        end;
                    end;
                end;
            end);
        end;
    end;
end;
function u1._x0bb90927e7edfcec(p50) --[[ Line: 348 ]]
    -- upvalues: l__Classes__11 (copy)
    p50:_xb2f397f91e7cf846();
    p50:_x4d06e2a836896b74(false);
    if l__Classes__11._xafc4950d7b094088 then
        l__Classes__11._xafc4950d7b094088:_xdc3b5df4fbf49698();
    end;
    p50._xc39b083bfb3b911a = nil;
    p50._x44a57685a0706c13 = 0;
    p50._x3d54620a830709c6 = Vector3.new(0, 0, -1);
    p50._xef9b557423ef0642 = nil;
    p50._x60cd91c1ed5f178c = 0;
    p50._xe67ab1fa9edaa3e0 = false;
    p50._x4438e5cca0851840 = 0;
end;
function u1._x7ce13abdd8d1f497(p51, p52) --[[ Line: 365 ]]
    if p52 and p52.Parent then
        local v53 = p52:FindFirstChild("Head");
        if not (v53 and v53:IsA("BasePart")) then
            v53 = nil;
        end;
        p51:_x014cc70b583e1d74(p52, v53);
    else
        p51:_xb2f397f91e7cf846();
    end;
end;
local function u60() --[[ Line: 376 ]]
    -- upvalues: l__Players__2 (copy)
    local v54 = {};
    for _, v55 in game:GetService("ReplicatedStorage").ReadOnly.Players:GetChildren() do
        local v56 = v55:FindFirstChild("in_combat");
        local v57 = v55:FindFirstChild("status");
        if v56 and v57 and (v56.Value and v57.Value == "alive") then
            local v58 = tonumber(v55.Name);
            local v59;
            if v58 then
                v59 = l__Players__2:GetPlayerByUserId(v58);
            else
                v59 = nil;
            end;
            if v59 then
                table.insert(v54, v59);
            end;
        end;
    end;
    return v54;
end;
function u1._x34c643ef711abe7f(u61) --[[ Line: 400 ]]
    -- upvalues: u60 (copy), l__Classes__11 (copy)
    local u62 = workspace:FindFirstChild("Map");
    local u63;
    if u62 then
        u63 = u62:FindFirstChild("CameraAngles");
    else
        u63 = u62;
    end;
    local v64 = u60();
    local function u82(p65) --[[ Line: 406 ]]
        -- upvalues: u61 (copy), l__Classes__11 (ref), u82 (copy)
        u61:_x3e96b288f12cd070("orbit");
        u61._xbf73a0b250690860 = p65;
        local l___xc2aea7afbdbc2790__19 = l__Classes__11._xc2aea7afbdbc2790;
        local v66 = l___xc2aea7afbdbc2790__19:_xa062e75791e7ac86(u61._xbf73a0b250690860, "wasHit");
        local v67 = l___xc2aea7afbdbc2790__19:_xa062e75791e7ac86(u61._xbf73a0b250690860, "clashed");
        local v68 = l___xc2aea7afbdbc2790__19:_xa062e75791e7ac86(u61._xbf73a0b250690860, "wasParried");
        local v69 = l___xc2aea7afbdbc2790__19:_xa062e75791e7ac86(u61._xbf73a0b250690860, "wasKilled");
        if v66 and (v67 and (v68 and v69)) then
            local v72 = v66:Connect(function(p70) --[[ Line: 430 ]]
                -- upvalues: u82 (ref)
                local v71 = game:GetService("Players"):GetPlayerFromCharacter(p70);
                if v71 then
                    u82(v71);
                end;
            end);
            local v75 = v67:Connect(function(p73) --[[ Line: 434 ]]
                -- upvalues: u82 (ref)
                local v74 = game:GetService("Players"):GetPlayerFromCharacter(p73);
                if v74 then
                    u82(v74);
                end;
            end);
            local v78 = v68:Connect(function(p76) --[[ Line: 438 ]]
                -- upvalues: u82 (ref)
                local v77 = game:GetService("Players"):GetPlayerFromCharacter(p76);
                if v77 then
                    u82(v77);
                end;
            end);
            local v81 = v69:Connect(function(p79) --[[ Line: 442 ]]
                -- upvalues: u82 (ref)
                local v80 = game:GetService("Players"):GetPlayerFromCharacter(p79);
                if v80 then
                    u82(v80);
                end;
            end);
            u61._x3144c8923b9b14af:Add(v72);
            u61._x3144c8923b9b14af:Add(v75);
            u61._x3144c8923b9b14af:Add(v78);
            u61._x3144c8923b9b14af:Add(v81);
        else
            u61._xbf73a0b250690860 = nil;
            u61:_x3e96b288f12cd070("idle");
        end;
    end;
    local function v84() --[[ Line: 452 ]]
        -- upvalues: u61 (copy), u62 (copy), u63 (copy)
        u61:_x3e96b288f12cd070("wideshot");
        u61._xbf73a0b250690860 = nil;
        u61._x6d08cf9411da6945 = nil;
        u61:_xc54534e81e961972(u62);
        if u63 then
            local v83 = u63:GetChildren();
            if #v83 > 0 then
                u61._x6d08cf9411da6945 = v83[math.random(1, #v83)];
            end;
        end;
    end;
    local function v86(p85) --[[ Line: 466 ]]
        -- upvalues: u82 (copy), u61 (copy)
        u82(p85);
        local l___xbf73a0b250690860__20 = u61._xbf73a0b250690860;
        if l___xbf73a0b250690860__20 then
            l___xbf73a0b250690860__20 = u61._xbf73a0b250690860.Character;
        end;
        if l___xbf73a0b250690860__20 then
            l___xbf73a0b250690860__20 = l___xbf73a0b250690860__20.PrimaryPart;
        end;
        if l___xbf73a0b250690860__20 then
            local l__Position__21 = l___xbf73a0b250690860__20.Position;
            u61._xe21a7aa6c7f19bd4.x:SetOffset(l__Position__21.X, true);
            u61._xe21a7aa6c7f19bd4.y:SetOffset(l__Position__21.Y, true);
            u61._xe21a7aa6c7f19bd4.z:SetOffset(l__Position__21.Z, true);
        end;
    end;
    if u61._xbf73a0b250690860 then
        v86(u61._xbf73a0b250690860);
    elseif #v64 > 0 then
        v86(v64[math.random(1, #v64)]);
    else
        v84();
    end;
end;
function u1._x3011e0039164c9eb(p87, _) --[[ Line: 490 ]]
    local v88 = game:GetService("UserInputService"):GetMouseLocation();
    local v89 = v88 - p87._x5f5f7d7f1245d748;
    p87._x5f5f7d7f1245d748 = v88;
    p87._x3698dde2584de52e = p87._x3698dde2584de52e + v89.X * 0.0002;
    p87._x0329f68317eeff48 = p87._x0329f68317eeff48 + v89.Y * 0.0002;
    p87._x3698dde2584de52e = math.clamp(p87._x3698dde2584de52e, -0.5, 0.5);
    p87._x0329f68317eeff48 = math.clamp(p87._x0329f68317eeff48, -0.3, 0.3);
end;
function u1._xc54534e81e961972(p90, p91) --[[ Line: 505 ]]
    -- upvalues: u25 (copy)
    local v92 = Vector3.new(0, 8, 0);
    local v93 = Vector3.new(80, 45, 80);
    local v94, v95;
    if p91 then
        v94, v95 = u25(p91);
        if v94 then
            if not v95 then
                v95 = v93;
                v94 = v92;
            end;
        else
            v95 = v93;
            v94 = v92;
        end;
    else
        v95 = v93;
        v94 = v92;
    end;
    p90._x06b036b3f2953813 = v94;
    p90._xb2cde732fa1b3748 = v95;
end;
function u1._xe43210952631556d(p96, p97) --[[ Line: 525 ]]
    local l___x06b036b3f2953813__22 = p96._x06b036b3f2953813;
    local l___xb2cde732fa1b3748__23 = p96._xb2cde732fa1b3748;
    local v98 = math.max(l___xb2cde732fa1b3748__23.X, l___xb2cde732fa1b3748__23.Z);
    local v99 = math.clamp(v98 * 0.9, 80, 320);
    local v100 = math.max(l___xb2cde732fa1b3748__23.Y * 1.1, v98 * 0.35);
    local v101 = math.clamp(v100, 45, 180);
    p96._x27f097e45e8e8402 = p96._x27f097e45e8e8402 + p97 * 0.08;
    local v102 = p96._x27f097e45e8e8402 + p96._x1ddb62815790cbdc;
    local v103 = v101 + p96._xe5f04c0e4d21bc33 * v99;
    local v104 = l___x06b036b3f2953813__22 + CFrame.Angles(0, v102, 0):VectorToWorldSpace((Vector3.new(0, v103, v99)));
    workspace.CurrentCamera.CFrame = CFrame.lookAt(v104, l___x06b036b3f2953813__22);
end;
function u1._x40dd509549592f33(p105, p106, p107, p108) --[[ Line: 548 ]]
    if p105._x4181b4eb5653faa2 == "first_person" then
        if p106 == p105._xc39b083bfb3b911a then
            if p108 <= p105._x44a57685a0706c13 then
            else
                local v109;
                if p107 then
                    local l__Magnitude__24 = p107.Magnitude;
                    if l__Magnitude__24 == l__Magnitude__24 and l__Magnitude__24 > 0 then
                        v109 = p107 / l__Magnitude__24;
                    else
                        v109 = nil;
                    end;
                else
                    v109 = nil;
                end;
                if v109 then
                    p105._x44a57685a0706c13 = p108;
                    p105._x3d54620a830709c6 = v109;
                    p105._x60cd91c1ed5f178c = os.clock();
                    if not (p105._xe67ab1fa9edaa3e0 and p105._xef9b557423ef0642) then
                        p105._xef9b557423ef0642 = v109;
                    end;
                    p105._xe67ab1fa9edaa3e0 = true;
                end;
            end;
        end;
    end;
end;
function u1._xdc1e08824b3a0057(p110, p111, p112, p113) --[[ Line: 577 ]]
    -- upvalues: l__Classes__11 (copy)
    if p110._x4181b4eb5653faa2 == "first_person" then
        if p111 == p110._xc39b083bfb3b911a then
            if p113 <= p110._x4438e5cca0851840 then
            elseif typeof(p112) == "table" then
                p110._x4438e5cca0851840 = p113;
                if l__Classes__11._xafc4950d7b094088 then
                    l__Classes__11._xafc4950d7b094088:_x91910985bdfe9fdd(p112);
                end;
            end;
        end;
    end;
end;
function u1._x9d9cfb555186c838(p114) --[[ Line: 601 ]]
    for _, v115 in p114._x2b005597329f4f81 do
        if v115 then
            v115:Destroy();
        end;
    end;
    table.clear(p114._x2b005597329f4f81);
end;
function u1._x15181087f706cf86(p116, p117) --[[ Line: 610 ]]
    local v118 = p116._x2b005597329f4f81[p117];
    if v118 then
        v118:Destroy();
        p116._x2b005597329f4f81[p117] = nil;
    end;
end;
function u1._xc98dea4be8736da1(p119, p120) --[[ Line: 618 ]]
    local v121 = p119._x2b005597329f4f81[p120];
    if v121 and v121.Parent then
        return v121;
    end;
    local v122 = Instance.new("Highlight");
    v122.Name = "SpectateWallhackHighlight";
    v122.FillColor = Color3.fromRGB(255, 255, 255);
    v122.OutlineColor = Color3.fromRGB(255, 255, 255);
    v122.FillTransparency = 0.5;
    v122.OutlineTransparency = 0.5;
    v122.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    v122.Adornee = p120;
    v122.Parent = p120;
    p119._x2b005597329f4f81[p120] = v122;
    return v122;
end;
function u1._x1bced6ea1f2641f7(p123) --[[ Line: 638 ]]
    -- upvalues: l__Classes__11 (copy)
    if p123._xf3d59dfa04d860b7 then
        local v124 = workspace:FindFirstChild("Entities");
        if v124 then
            local l__Position__25 = workspace.CurrentCamera.CFrame.Position;
            local v125 = {};
            for _, v126 in v124:GetChildren() do
                local v127 = l__Classes__11.Util:getLikelyVec3(v126);
                if v127 then
                    if l__Classes__11.Util:hasLineOfSight(l__Position__25, v127) then
                        p123:_x15181087f706cf86(v126);
                    else
                        v125[v126] = true;
                        p123:_xc98dea4be8736da1(v126);
                    end;
                else
                    p123:_x15181087f706cf86(v126);
                end;
            end;
            local v128 = {};
            for v129, _ in p123._x2b005597329f4f81 do
                if not (v125[v129] and v129.Parent) then
                    table.insert(v128, v129);
                end;
            end;
            for _, v130 in v128 do
                p123:_x15181087f706cf86(v130);
            end;
        else
            p123:_x9d9cfb555186c838();
        end;
    end;
end;
function u1._x4d06e2a836896b74(u131, p132) --[[ Line: 680 ]]
    -- upvalues: l__RunService__4 (copy)
    if u131._xf3d59dfa04d860b7 == p132 and p132 then
    else
        u131._xf3d59dfa04d860b7 = p132;
        u131._x90f08d75066b2a8b:Clean();
        u131:_x9d9cfb555186c838();
        if p132 then
            local u133 = 0.12;
            u131._x90f08d75066b2a8b:Connect(l__RunService__4.Heartbeat, function(p134) --[[ Line: 694 ]]
                -- upvalues: u131 (copy), u133 (ref)
                if u131._x4181b4eb5653faa2 == "first_person" then
                    u133 = u133 + p134;
                    if u133 < 0.12 then
                    else
                        u133 = 0;
                        u131:_x1bced6ea1f2641f7();
                    end;
                else
                    u131:_x4d06e2a836896b74(false);
                end;
            end);
            u131:_x1bced6ea1f2641f7();
        end;
    end;
end;
function u1._xfc941df3be73b6db(u135, p136) --[[ Line: 712 ]]
    -- upvalues: l__Players__2 (copy), l__Classes__11 (copy)
    u135:_xb2f397f91e7cf846();
    if p136 then
        p136 = p136.user_id;
    end;
    if typeof(p136) == "number" then
        local u137 = l__Players__2:GetPlayerByUserId(p136);
        if u137 then
            u135:_x8fcdafeb8ad3312d(false, u137);
            u135:_x3e96b288f12cd070("first_person");
            u135._xbf73a0b250690860 = u137;
            u135._xc39b083bfb3b911a = tostring(u137.UserId);
            u135._x44a57685a0706c13 = 0;
            u135._x60cd91c1ed5f178c = os.clock();
            u135._xe67ab1fa9edaa3e0 = false;
            u135._x4438e5cca0851840 = 0;
            local l__Character__26 = u137.Character;
            local v138;
            if l__Character__26 then
                local l__PrimaryPart__27 = l__Character__26.PrimaryPart;
                if l__PrimaryPart__27 then
                    local l__LookVector__28 = l__PrimaryPart__27.CFrame.LookVector;
                    if l__LookVector__28 then
                        local l__Magnitude__29 = l__LookVector__28.Magnitude;
                        if l__Magnitude__29 == l__Magnitude__29 and l__Magnitude__29 > 0 then
                            v138 = l__LookVector__28 / l__Magnitude__29;
                        else
                            v138 = nil;
                        end;
                    else
                        v138 = nil;
                    end;
                else
                    v138 = nil;
                end;
            else
                v138 = nil;
            end;
            local v139 = v138 or Vector3.new(0, 0, -1);
            u135._x3d54620a830709c6 = v139;
            u135._xef9b557423ef0642 = v139;
            u135._x3144c8923b9b14af:Add(u137.CharacterAdded:Connect(function() --[[ Line: 739 ]]
                -- upvalues: u135 (copy), u137 (copy)
                if u135._x4181b4eb5653faa2 == "first_person" and u135._xbf73a0b250690860 == u137 then
                    u135:_xb2f397f91e7cf846();
                    task.defer(function() --[[ Line: 742 ]]
                        -- upvalues: u135 (ref), u137 (ref)
                        if u135._x4181b4eb5653faa2 == "first_person" and u135._xbf73a0b250690860 == u137 then
                            u135:_x7ce13abdd8d1f497(u137.Character);
                        end;
                    end);
                end;
            end));
            if l__Classes__11._xafc4950d7b094088 then
                l__Classes__11._xafc4950d7b094088:_x4c8394e631a87ac3(u137);
            end;
        end;
    end;
end;
function u1._x9e96ca58e4cf91b8(p140) --[[ Line: 755 ]]
    -- upvalues: l__Classes__11 (copy), l__LocalPlayer__13 (copy)
    if p140._x4181b4eb5653faa2 == "first_person" then
        if l__Classes__11._x7430d6d194f43373 and l__Classes__11._x7430d6d194f43373._x3668b6edfe3dbbd4 == "alive" then
            p140:cleanUp();
            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
            local l__Character__30 = l__LocalPlayer__13.Character;
            if l__Character__30 then
                l__Character__30 = l__Character__30:FindFirstChildWhichIsA("Humanoid");
            end;
            if l__Character__30 then
                workspace.CurrentCamera.CameraSubject = l__Character__30;
            end;
        else
            p140:_x3e96b288f12cd070("idle");
        end;
    end;
end;
function u1._xec4ea1d3f300e407(p141) --[[ Line: 774 ]]
    if p141._x4181b4eb5653faa2 == "first_person" then
        local l___xbf73a0b250690860__31 = p141._xbf73a0b250690860;
        if l___xbf73a0b250690860__31 then
            l___xbf73a0b250690860__31 = l___xbf73a0b250690860__31.Character;
        end;
        if l___xbf73a0b250690860__31 and l___xbf73a0b250690860__31.Parent then
            return l___xbf73a0b250690860__31;
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function u1._xd2aea7407c9484cf(p142, p143) --[[ Line: 788 ]]
    -- upvalues: l__Players__2 (copy), l__Classes__11 (copy)
    local l___xbf73a0b250690860__32 = p142._xbf73a0b250690860;
    if l___xbf73a0b250690860__32 and l___xbf73a0b250690860__32.Parent == l__Players__2 then
        if l__Classes__11._x910f31e87b3c7281 then
            l__Classes__11._x910f31e87b3c7281._x0dabd010e1f00f2e = false;
        end;
        local l__Character__33 = l___xbf73a0b250690860__32.Character;
        if l__Character__33 and l__Character__33.Parent then
            local v144 = l__Character__33:FindFirstChild("Head");
            if not (v144 and v144:IsA("BasePart")) then
                v144 = nil;
            end;
            local v145 = v144 or l__Character__33.PrimaryPart;
            p142:_x7ce13abdd8d1f497(l__Character__33);
            if v145 then
                local v146 = p142._x3d54620a830709c6 or Vector3.new(0, 0, -1);
                local v147;
                if os.clock() - p142._x60cd91c1ed5f178c > 0.35 then
                    v147 = p142._xef9b557423ef0642;
                    if not v147 then
                        local l__Character__34 = l___xbf73a0b250690860__32.Character;
                        local v148;
                        if l__Character__34 then
                            local l__PrimaryPart__35 = l__Character__34.PrimaryPart;
                            if l__PrimaryPart__35 then
                                local l__LookVector__36 = l__PrimaryPart__35.CFrame.LookVector;
                                if l__LookVector__36 then
                                    local l__Magnitude__37 = l__LookVector__36.Magnitude;
                                    if l__Magnitude__37 == l__Magnitude__37 and l__Magnitude__37 > 0 then
                                        v148 = l__LookVector__36 / l__Magnitude__37;
                                    else
                                        v148 = nil;
                                    end;
                                else
                                    v148 = nil;
                                end;
                            else
                                v148 = nil;
                            end;
                        else
                            v148 = nil;
                        end;
                        v147 = v148 or v146;
                    end;
                else
                    v147 = v146;
                end;
                local l___xef9b557423ef0642__38 = p142._xef9b557423ef0642;
                if l___xef9b557423ef0642__38 then
                    local v149 = l___xef9b557423ef0642__38:Dot(v147);
                    if math.clamp(v149, -1, 1) >= -0.25 then
                        local v150 = l___xef9b557423ef0642__38:Lerp(v147, 1 - math.exp(-30 * p143));
                        local v151;
                        if v150 then
                            local l__Magnitude__39 = v150.Magnitude;
                            if l__Magnitude__39 == l__Magnitude__39 and l__Magnitude__39 > 0 then
                                v151 = v150 / l__Magnitude__39;
                            else
                                v151 = nil;
                            end;
                        else
                            v151 = nil;
                        end;
                        v147 = v151 or v147;
                    end;
                end;
                p142._xef9b557423ef0642 = v147;
                workspace.CurrentCamera.CFrame = CFrame.lookAt(v145.Position, v145.Position + v147, Vector3.new(0, 1, 0));
            end;
        else
            p142:_xb2f397f91e7cf846();
        end;
    else
        p142:_x9e96ca58e4cf91b8();
    end;
end;
function u1._x4703c5bb9f821811(p152, p153) --[[ Line: 840 ]]
    -- upvalues: l__Classes__11 (copy)
    local v154 = math.min(p153, 1);
    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    if p152._x4181b4eb5653faa2 == "idle" then
        p152:_x34c643ef711abe7f();
    end;
    if p152._x4181b4eb5653faa2 == "first_person" then
        p152:_xd2aea7407c9484cf(v154);
    elseif p152._x4181b4eb5653faa2 == "orbit" then
        local l___xbf73a0b250690860__40 = p152._xbf73a0b250690860;
        if l___xbf73a0b250690860__40 and (l___xbf73a0b250690860__40.Character and l___xbf73a0b250690860__40.Character.PrimaryPart) then
            if l___xbf73a0b250690860__40.Character.Parent == workspace.Entities then
                p152._x60a0e5a17e513660 = p152._x60a0e5a17e513660 + v154;
                local l___xe21a7aa6c7f19bd4__41 = p152._xe21a7aa6c7f19bd4;
                local l__Position__42 = l___xbf73a0b250690860__40.Character.PrimaryPart.Position;
                local v155 = l__Position__42 + Vector3.new(0, 5, 0) + -l___xbf73a0b250690860__40.Character.PrimaryPart.CFrame.LookVector * 20;
                l___xe21a7aa6c7f19bd4__41.x:SetGoal(v155.X);
                l___xe21a7aa6c7f19bd4__41.y:SetGoal(v155.Y);
                l___xe21a7aa6c7f19bd4__41.z:SetGoal(v155.Z);
                local v156 = Vector3.new(l___xe21a7aa6c7f19bd4__41.x.Offset, l___xe21a7aa6c7f19bd4__41.y.Offset, l___xe21a7aa6c7f19bd4__41.z.Offset);
                local v157 = v156 - l__Position__42;
                local v158 = workspace:FindFirstChild("Map");
                local v159;
                if v158 then
                    local v160 = RaycastParams.new();
                    v160.FilterType = Enum.RaycastFilterType.Include;
                    v160.FilterDescendantsInstances = { v158 };
                    v159 = workspace:Raycast(l__Position__42, v157, v160);
                else
                    v159 = nil;
                end;
                if v159 then
                    v156 = v159.Position;
                    l___xe21a7aa6c7f19bd4__41.x:SetOffset(v156.X);
                    l___xe21a7aa6c7f19bd4__41.y:SetOffset(v156.Y);
                    l___xe21a7aa6c7f19bd4__41.z:SetOffset(v156.Z);
                end;
                workspace.CurrentCamera.CFrame = CFrame.lookAt(v156, l__Position__42);
            else
                p152._xbf73a0b250690860 = nil;
                p152:_x3e96b288f12cd070("idle");
            end;
        else
            p152._xbf73a0b250690860 = nil;
            p152:_x3e96b288f12cd070("idle");
        end;
    else
        if p152._x4181b4eb5653faa2 == "wideshot" then
            p152._x60a0e5a17e513660 = p152._x60a0e5a17e513660 + v154;
            if p152._x60a0e5a17e513660 > p152._xfd122f733d81ae4e.wideshot_bored then
                p152:_x3e96b288f12cd070("idle");
                return;
            end;
            p152:_x3011e0039164c9eb(v154);
            p152._x1ddb62815790cbdc = l__Classes__11.Util:numLerp(p152._x1ddb62815790cbdc, -p152._x3698dde2584de52e, 5 * v154);
            p152._xe5f04c0e4d21bc33 = l__Classes__11.Util:numLerp(p152._xe5f04c0e4d21bc33, -p152._x0329f68317eeff48, 5 * v154);
            local l___x6d08cf9411da6945__43 = p152._x6d08cf9411da6945;
            local v161;
            if l___x6d08cf9411da6945__43 then
                v161 = l___x6d08cf9411da6945__43:FindFirstChild("LookAt");
            else
                v161 = l___x6d08cf9411da6945__43;
            end;
            if l___x6d08cf9411da6945__43 then
                l___x6d08cf9411da6945__43 = l___x6d08cf9411da6945__43:FindFirstChild("Position");
            end;
            if not (v161 and v161:IsA("BasePart")) then
                v161 = nil;
            end;
            if not (l___x6d08cf9411da6945__43 and l___x6d08cf9411da6945__43:IsA("BasePart")) then
                l___x6d08cf9411da6945__43 = nil;
            end;
            if not (v161 and l___x6d08cf9411da6945__43) then
                p152:_xe43210952631556d(v154);
                return;
            end;
            local v162 = CFrame.lookAt(l___x6d08cf9411da6945__43.Position, v161.Position);
            local v163 = CFrame.Angles(p152._xe5f04c0e4d21bc33, p152._x1ddb62815790cbdc, 0);
            local v164 = CFrame.lookAt(l___x6d08cf9411da6945__43.Position, l___x6d08cf9411da6945__43.Position + ((v162 - v162.Position) * v163).LookVector);
            workspace.CurrentCamera.CFrame = v164;
        end;
    end;
end;
function u1._x9b33ad4e08746b7e(p165, p166) --[[ Line: 947 ]]
    -- upvalues: l__Classes__11 (copy), l__Context__12 (copy), l__UIAssets__9 (copy), l__Packets__6 (copy)
    l__Classes__11._x7430d6d194f43373._xfc59a57f1de8b1fb:Clean();
    l__Classes__11._xafc4950d7b094088._x964f370fda99e2af.Main.Visible = false;
    if l__Context__12.is_match_mode then
        local v167 = l__UIAssets__9.Matches.SpectatorScreen:Clone();
        local l__Button__44 = v167.MidContainer.QuickButton.Button;
        l__Button__44.Activated:Connect(function() --[[ Line: 955 ]]
            -- upvalues: l__Classes__11 (ref), l__Packets__6 (ref), l__Button__44 (copy)
            l__Classes__11._xd00ac57201023755:_x4782af5368e4c758("Modal", {
                title_text = "Leave Match?",
                body_text = "Your team is still playing. Leaving now will count as a loss.",
                actions = {
                    {
                        action_id = "LEAVE MATCH",
                        action_text = "LEAVE MATCH",
                        action_bg_color = Color3.fromRGB(255, 70, 70),
                        action_text_color = Color3.fromRGB(255, 255, 255),
                        action_callback = function() --[[ Name: action_callback, Line 965 ]]
                            -- upvalues: l__Packets__6 (ref), l__Button__44 (ref)
                            l__Packets__6._xb683881048afb304:Fire("leave");
                            l__Button__44.Visible = false;
                        end
                    },
                    {
                        action_id = "CANCEL",
                        action_text = "CANCEL",
                        action_bg_color = Color3.fromRGB(60, 60, 60),
                        action_text_color = Color3.fromRGB(255, 255, 255),
                        action_callback = function() --[[ Name: action_callback, Line 975 ]] end
                    }
                }
            });
        end);
        v167.Parent = game.Players.LocalPlayer.PlayerGui;
    end;
    local v168;
    if p166 and p166.user_id then
        v168 = game:GetService("Players"):GetPlayerByUserId(p166.user_id);
    else
        v168 = nil;
    end;
    p165:_x8fcdafeb8ad3312d(false, v168);
end;
function u1._x8fcdafeb8ad3312d(u169, p170, p171) --[[ Line: 993 ]]
    -- upvalues: l__Classes__11 (copy), l__TweenService__1 (copy)
    u169._x3144c8923b9b14af:Clean();
    u169:_x0bb90927e7edfcec();
    u169._x8634da6a26920aa5:Clean();
    u169._x3144c8923b9b14af = u169._x8634da6a26920aa5:Extend();
    u169._xbf73a0b250690860 = p171;
    l__Classes__11.Util:unbindFromRenderStep("SpectatorCam");
    u169._x06ea370a96d72e56 = nil;
    u169._x167ca2cf5f109288 = true;
    l__Classes__11._x32ae459de0772e82._x5b34a8c32cf04968 = true;
    if p170 then
        workspace.CurrentCamera.FieldOfView = 10;
        local u172 = l__TweenService__1:Create(workspace.CurrentCamera, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            FieldOfView = 113
        });
        u172:Play();
        task.spawn(function() --[[ Line: 1008 ]]
            -- upvalues: u172 (copy), l__TweenService__1 (ref)
            u172.Completed:Wait();
            l__TweenService__1:Create(workspace.CurrentCamera, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                FieldOfView = 110
            }):Play();
        end);
    else
        workspace.CurrentCamera.FieldOfView = 110;
    end;
    u169._x06ea370a96d72e56 = l__Classes__11.Util:bindToRenderStep("SpectatorCam", Enum.RenderPriority.Camera.Value + 3, function(p173) --[[ Line: 1015 ]]
        -- upvalues: u169 (copy)
        u169:_x4703c5bb9f821811(p173);
    end);
end;
function u1._xe53615d96cf36a6b(u174) --[[ Line: 1020 ]]
    -- upvalues: l__Packets__6 (copy), l__UserInputService__3 (copy)
    l__Packets__6._x1ed148e14a64125c.OnClientEvent:Connect(function(p175) --[[ Line: 1021 ]]
        -- upvalues: u174 (copy)
        if p175.op == "start" then
            u174:_x9b33ad4e08746b7e(p175.params);
        elseif p175.op == "start_first_person" then
            u174:_xfc941df3be73b6db(p175.params);
        else
            if p175.op == "stop_first_person" then
                u174:_x9e96ca58e4cf91b8();
            end;
        end;
    end);
    l__Packets__6.unreliablePackets._x59619b2167cd6dd9.OnClientEvent:Connect(function(p176, p177, p178) --[[ Line: 1031 ]]
        -- upvalues: u174 (copy)
        u174:_x40dd509549592f33(p176, p177, p178);
    end);
    l__Packets__6.unreliablePackets._x87742c78e4506257.OnClientEvent:Connect(function(p179, p180, p181) --[[ Line: 1035 ]]
        -- upvalues: u174 (copy)
        u174:_xdc1e08824b3a0057(p179, p180, p181);
    end);
    l__UserInputService__3.InputBegan:Connect(function(p182, p183) --[[ Line: 1039 ]]
        -- upvalues: u174 (copy), l__Packets__6 (ref)
        if p183 or u174._x4181b4eb5653faa2 ~= "first_person" then
        elseif p182.KeyCode == Enum.KeyCode.R then
            l__Packets__6._x1554ede5375131b3:Fire();
            u174:_x9e96ca58e4cf91b8();
        else
            if p182.KeyCode == Enum.KeyCode.T then
                u174:_x4d06e2a836896b74(not u174._xf3d59dfa04d860b7);
            end;
        end;
    end);
end;
return u1;
