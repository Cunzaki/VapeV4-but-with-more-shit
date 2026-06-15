-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__LocalPlayer__2 = game:GetService("Players").LocalPlayer;
local u1 = {
    camera_right = Vector3.new(-0, -0, -1),
    camera_up = Vector3.new(-0, -1, -0),
    camera_forward = Vector3.new(-1, -0, -0)
};
local function u13(p2, p3, p4) --[[ Line: 65 ]]
    if not p4 then
        local v5 = p3:Dot(p2.RightVector);
        local v6 = p3:Dot(p2.UpVector);
        return Vector3.new(v5, v6, p3:Dot(p2.LookVector));
    end;
    local l__LookVector__3 = p2.LookVector;
    local v7 = l__LookVector__3 - Vector3.new(0, 1, 0) * l__LookVector__3:Dot(Vector3.new(0, 1, 0));
    local l__Magnitude__4 = v7.Magnitude;
    local v8 = l__Magnitude__4 < 0.00001 and Vector3.new(0, 0, 0) or v7 / l__Magnitude__4;
    local v9 = v8 == Vector3.new(0, 0, 0) and Vector3.new(0, 0, -1) or v8;
    local v10 = (Vector3.new(0, 1, 0)):Cross(v9);
    local l__Magnitude__5 = v10.Magnitude;
    local v11 = p3:Dot(l__Magnitude__5 < 0.00001 and Vector3.new(0, 0, 0) or v10 / l__Magnitude__5);
    local v12 = p3:Dot(Vector3.new(0, 1, 0));
    return Vector3.new(v11, v12, p3:Dot(v9));
end;
local function u26(u14) --[[ Line: 121 ]]
    -- upvalues: l__RunService__1 (copy), l__LocalPlayer__2 (copy), u13 (copy), u1 (copy)
    assert(u14, "params is required");
    local l__particle_emitter__6 = u14.particle_emitter;
    local l__max_intensity__7 = u14.max_intensity;
    local l__max_velocity__8 = u14.max_velocity;
    local u15 = u14.flatten_camera_forward ~= false;
    local v16;
    if typeof(l__particle_emitter__6) == "Instance" then
        v16 = l__particle_emitter__6:IsA("ParticleEmitter");
    else
        v16 = false;
    end;
    assert(v16, "params.particle_emitter must be a ParticleEmitter");
    local v17 = type(l__max_intensity__7) == "number";
    assert(v17, "params.max_intensity must be a number");
    local v18;
    if type(l__max_velocity__8) == "number" then
        v18 = l__max_velocity__8 > 0;
    else
        v18 = false;
    end;
    assert(v18, "params.max_velocity must be a positive number");
    return l__RunService__1.RenderStepped:Connect(function() --[[ Line: 144 ]]
        -- upvalues: u14 (copy), l__LocalPlayer__2 (ref), l__particle_emitter__6 (copy), u13 (ref), u15 (copy), l__max_velocity__8 (copy), l__max_intensity__7 (copy), u1 (ref)
        local l__CurrentCamera__9 = workspace.CurrentCamera;
        local v19 = u14;
        local v20;
        if v19.hrp then
            v20 = v19.hrp;
        else
            local l__Character__10 = l__LocalPlayer__2.Character;
            if l__Character__10 then
                v20 = l__Character__10:FindFirstChild("HumanoidRootPart");
            else
                v20 = nil;
            end;
        end;
        if l__CurrentCamera__9 and (v20 and l__particle_emitter__6.Parent) then
            local v21 = u13(l__CurrentCamera__9.CFrame, v20.AssemblyLinearVelocity, u15);
            local l__Magnitude__11 = v21.Magnitude;
            if l__Magnitude__11 < 0.00001 then
                l__particle_emitter__6.Acceleration = Vector3.new(0, 0, 0);
            else
                local v22 = math.clamp(l__Magnitude__11 / l__max_velocity__8, 0, 1) * l__max_intensity__7;
                local v23 = -v21.Unit * v22;
                local v24 = l__particle_emitter__6;
                local v25 = u14.axis_map or u1;
                v24.Acceleration = (v25.camera_right or u1.camera_right) * v23.X + (v25.camera_up or u1.camera_up) * v23.Y + (v25.camera_forward or u1.camera_forward) * v23.Z;
            end;
        else
            l__particle_emitter__6.Acceleration = Vector3.new(0, 0, 0);
        end;
    end);
end;
local function u43(u27, u28) --[[ Line: 190 ]]
    -- upvalues: l__RunService__1 (copy)
    local u29 = {
        {
            timestamp = os.clock(),
            position = u27.WorldPosition
        }
    };
    u28.WorldPosition = u27.WorldCFrame:PointToWorldSpace(Vector3.new(0.2, -0.4, 0));
    return l__RunService__1.RenderStepped:Connect(function(p30) --[[ Line: 205 ]]
        -- upvalues: u29 (copy), u27 (copy), u28 (copy)
        local v31 = os.clock();
        local v32 = v31 - 0.016;
        table.insert(u29, {
            timestamp = v31,
            position = u27.WorldPosition
        });
        while #u29 > 2 and u29[2].timestamp <= v32 do
            table.remove(u29, 1);
        end;
        local v33 = u29[1];
        local v34 = u29[2];
        local l__position__12 = v33.position;
        if v34 then
            local v35 = v34.timestamp - v33.timestamp;
            if v35 > 0 then
                local v36 = math.clamp((v32 - v33.timestamp) / v35, 0, 1);
                l__position__12 = v33.position:Lerp(v34.position, v36);
            end;
        end;
        local l__WorldPosition__13 = u27.WorldPosition;
        local v37 = u27.WorldCFrame:PointToWorldSpace(Vector3.new(0.2, -0.4, 0));
        local v38 = l__position__12 - l__WorldPosition__13;
        if v38.Magnitude > 0.4 then
            v38 = v38.Unit * 0.4;
        end;
        local v39 = (l__WorldPosition__13 + v38):Lerp(v37, 1 - math.clamp(v38.Magnitude / 0.4, 0, 1));
        local v40 = v39 - u28.WorldPosition;
        local l__Magnitude__14 = v40.Magnitude;
        if l__Magnitude__14 <= 0.00001 then
            u28.WorldPosition = v39;
        else
            local v41 = math.min(2 * p30, l__Magnitude__14);
            local v42 = u28;
            v42.WorldPosition = v42.WorldPosition + v40.Unit * v41;
        end;
    end);
end;
local l__ReplicatedStorage__15 = game:GetService("ReplicatedStorage");
local l__CEnum__16 = require(script.Parent.CEnum);
local u47 = {
    DEFAULT_SKIN_ID = l__CEnum__16.Skins.Default,
    RARITIES = {
        Base = {
            priority = 1,
            name = "Base",
            color = Color3.fromRGB(255, 255, 255)
        },
        Uncommon = {
            priority = 6,
            name = "Uncommon",
            color = Color3.fromRGB(120, 255, 120)
        },
        Rare = {
            priority = 7,
            name = "Rare",
            color = Color3.fromRGB(44, 44, 255)
        },
        Elite = {
            priority = 8,
            name = "Elite",
            color = Color3.fromRGB(300, 70, 255)
        },
        Exotic = {
            priority = 9,
            name = "Exotic",
            color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 214, 44)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
        },
        Classified = {
            priority = 10,
            name = "Classified",
            color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) })
        },
        ["Direct-Elite"] = {
            priority = 15,
            name = "Direct-Elite",
            color = Color3.fromRGB(300, 70, 255)
        },
        ["Direct-Exotic"] = {
            priority = 16,
            name = "Direct-Exotic",
            color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 214, 44)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
        },
        ["Direct-Classified"] = {
            priority = 17,
            name = "Direct-Classified",
            color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) })
        },
        Exclusive = {
            priority = 20,
            name = "Exclusive",
            color = Color3.fromRGB(50, 0, 180)
        }
    },
    DEFAULT_FIELDS = {
        rarity = "Common",
        creator = "Jstin",
        price = 0,
        tradable = false,
        marketable = false,
        limited = false,
        hidden = false,
        metadata = {},
        effects = {},
        sounds = {},
        params = {},
        offsets = {},
        auxiliary = {},
        render = {}
    },
    defs = {
        Redliner = {
            [l__CEnum__16.Skins.Default] = {
                name = "Default",
                item_id = "Redliner",
                skin_id = l__CEnum__16.Skins.Default,
                sounds = {
                    clash = "ALT_CLASH",
                    melee_hit = "HIT2"
                }
            },
            [l__CEnum__16.Skins.Jetstream] = {
                rarity = "Rare",
                name = "Jetstream",
                item_id = "Redliner",
                creator = "Anti-",
                model = "Jetstream1P",
                rig_3p = "Jetstream3P",
                skin_id = l__CEnum__16.Skins.Jetstream
            },
            [l__CEnum__16.Skins.Glass] = {
                rarity = "Elite",
                name = "Glass",
                item_id = "Redliner",
                creator = "Reverity",
                model = "Glass1P",
                rig_3p = "Glass3P",
                skin_id = l__CEnum__16.Skins.Glass
            },
            [l__CEnum__16.Skins.Darkness] = {
                rarity = "Direct-Classified",
                name = "Nihility",
                item_id = "Redliner",
                creator = "Reverity",
                model = "Darkness1P",
                rig_3p = "Darkness3P",
                skin_id = l__CEnum__16.Skins.Darkness,
                sounds = {
                    SWING = "DARK_SLASH",
                    SWING_HEAVY = "DARK_SLASH",
                    PARRY3 = "DARK_PARRY"
                }
            },
            [l__CEnum__16.Skins.Tester] = {
                hidden = true,
                rarity = "Exclusive",
                name = "Tester",
                item_id = "Redliner",
                creator = "Reverity",
                model = "Tester1P",
                rig_3p = "Tester3P",
                skin_id = l__CEnum__16.Skins.Tester
            },
            [l__CEnum__16.Skins.TypeCC] = {
                hidden = true,
                rarity = "Exclusive",
                name = "Type: CC",
                item_id = "Redliner",
                creator = "Anti-",
                model = "TypeCC1P",
                rig_3p = "TypeCC3P",
                skin_id = l__CEnum__16.Skins.TypeCC
            },
            [l__CEnum__16.Skins.Inheritor] = {
                hidden = false,
                rarity = "Classified",
                name = "Inheritor",
                item_id = "Redliner",
                creator = "Reverity",
                model = "Inheritor1P",
                rig_3p = "Inheritor3P",
                skin_id = l__CEnum__16.Skins.Inheritor,
                skinInitializer = function(p44) --[[ Name: skinInitializer, Line 461 ]]
                    -- upvalues: u43 (copy), u26 (copy)
                    local l__beams__17 = p44.asset.Weapon.Parts.Plane.beams;
                    p44.equipped_trove:Add(u43(l__beams__17.at3, l__beams__17.at4));
                    for _, v45 in p44.asset:GetDescendants() do
                        if v45:IsA("ParticleEmitter") then
                            local v46 = u26({
                                max_intensity = 20,
                                max_velocity = 100,
                                particle_emitter = v45
                            });
                            p44.equipped_trove:Add(v46);
                        end;
                    end;
                end,
                sounds = {
                    melee_hit = "INHERIT_HIT",
                    clash = "INHERIT_CLASH",
                    PARRY3 = "INHERIT_PARRY"
                }
            },
            [l__CEnum__16.Skins.TestUncommon] = {
                rarity = "Uncommon",
                name = "TestCommon",
                item_id = "Redliner",
                creator = "Anti-",
                hidden = true,
                model = "Jetstream1P",
                rig_3p = "Jetstream3P",
                skin_id = l__CEnum__16.Skins.TestUncommon
            },
            [l__CEnum__16.Skins.TestRare] = {
                rarity = "Rare",
                name = "TestRare",
                item_id = "Redliner",
                creator = "Anti-",
                hidden = true,
                model = "Jetstream1P",
                rig_3p = "Jetstream3P",
                skin_id = l__CEnum__16.Skins.TestRare
            },
            [l__CEnum__16.Skins.TestExotic] = {
                rarity = "Exotic",
                name = "TestExotic",
                item_id = "Redliner",
                creator = "Anti-",
                hidden = true,
                model = "Jetstream1P",
                rig_3p = "Jetstream3P",
                skin_id = l__CEnum__16.Skins.TestExotic
            },
            [l__CEnum__16.Skins.TestClassified] = {
                rarity = "Classified",
                name = "TestClassified",
                item_id = "Redliner",
                creator = "Anti-",
                hidden = true,
                model = "Jetstream1P",
                rig_3p = "Jetstream3P",
                skin_id = l__CEnum__16.Skins.TestClassified
            }
        },
        Grappler = {
            [l__CEnum__16.Skins.Default] = {
                name = "Default",
                item_id = "Grappler",
                creator = "rinrinmatsu",
                skin_id = l__CEnum__16.Skins.Default
            }
        },
        Castigate = {
            [l__CEnum__16.Skins.Default] = {
                name = "Default",
                item_id = "Castigate",
                skin_id = l__CEnum__16.Skins.Default
            },
            [l__CEnum__16.Skins.UniverseDestroyer] = {
                rarity = "Exotic",
                name = "Unleashed",
                item_id = "Castigate",
                creator = "Reverity",
                model = "Destroyer1P",
                rig_3p = "Destroyer3P",
                skin_id = l__CEnum__16.Skins.UniverseDestroyer,
                sounds = {
                    shot = "DESTROY_SHOT"
                }
            },
            [l__CEnum__16.Skins.CAS_Goldrose] = {
                rarity = "Uncommon",
                name = "Goldrose",
                item_id = "Castigate",
                creator = "Reverity",
                model = "GoldroseCAS1P",
                rig_3p = "GoldroseCAS3P",
                skin_id = l__CEnum__16.Skins.CAS_Goldrose
            }
        },
        Phoenix = {
            [l__CEnum__16.Skins.Default] = {
                name = "Default",
                item_id = "Phoenix",
                skin_id = l__CEnum__16.Skins.Default
            },
            [l__CEnum__16.Skins.PHX_HeavyDuty] = {
                rarity = "Uncommon",
                name = "Heavy-Duty",
                item_id = "Phoenix",
                creator = "Reverity",
                model = "HeavyPHX1P",
                rig_3p = "HeavyPHX3P",
                skin_id = l__CEnum__16.Skins.PHX_HeavyDuty
            },
            [l__CEnum__16.Skins.PHX_Zealot] = {
                rarity = "Rare",
                name = "Zealot",
                item_id = "Phoenix",
                creator = "Reverity",
                model = "ZealotPHX1P",
                rig_3p = "ZealotPHX3P",
                skin_id = l__CEnum__16.Skins.PHX_Zealot
            }
        },
        Siege = {
            [l__CEnum__16.Skins.Default] = {
                name = "Default",
                item_id = "Siege",
                skin_id = l__CEnum__16.Skins.Default
            },
            [l__CEnum__16.Skins.SIE_Afterburn] = {
                rarity = "Rare",
                name = "Afterburn",
                item_id = "Siege",
                creator = "Reverity",
                model = "AfterburnSIE1P",
                rig_3p = "AfterburnSIE3P",
                skin_id = l__CEnum__16.Skins.SIE_Afterburn
            }
        },
        Monarch = {
            [l__CEnum__16.Skins.Default] = {
                name = "Default",
                item_id = "Monarch",
                skin_id = l__CEnum__16.Skins.Default
            },
            [l__CEnum__16.Skins.AwpVanilla] = {
                hidden = false,
                rarity = "Elite",
                name = "AWP",
                item_id = "Monarch",
                creator = "Anti-",
                model = "AWP1P",
                rig_3p = "AWP3P",
                skin_id = l__CEnum__16.Skins.AwpVanilla,
                sounds = {
                    shot = "AWP_SHOT"
                }
            },
            [l__CEnum__16.Skins.MON_WinterTroop] = {
                hidden = false,
                rarity = "Uncommon",
                name = "Winter Troop",
                item_id = "Monarch",
                creator = "Reverity",
                model = "WinterMON1P",
                rig_3p = "WinterMON3P",
                skin_id = l__CEnum__16.Skins.MON_WinterTroop
            }
        }
    }
};
local function u52(p48) --[[ Line: 655 ]]
    -- upvalues: u52 (copy)
    if typeof(p48) ~= "table" then
        return p48;
    end;
    local v49 = {};
    for v50, v51 in pairs(p48) do
        v49[v50] = u52(v51);
    end;
    return v49;
end;
local function u58(p53, p54, p55) --[[ Line: 668 ]]
    -- upvalues: u47 (copy), u52 (copy), l__CEnum__16 (copy)
    for v56, v57 in pairs(u47.DEFAULT_FIELDS) do
        if p53[v56] == nil then
            p53[v56] = u52(v57);
        end;
    end;
    p53.name = p53.name or (l__CEnum__16.reverse(l__CEnum__16.Skins, p55) or tostring(p55));
    p53.item_id = p53.item_id or p54;
    p53.skin_id = p53.skin_id or p55;
    return p53;
end;
function u47.normalizeDefinition(p59, p60, p61) --[[ Line: 682 ]]
    -- upvalues: u58 (copy)
    if typeof(p61) == "table" then
        return u58(p61, p59, p60);
    else
        return nil;
    end;
end;
function u47.normalizeDefs() --[[ Line: 690 ]]
    -- upvalues: u47 (copy)
    for v62, v63 in pairs(u47.defs) do
        for v64, v65 in pairs(v63) do
            u47.normalizeDefinition(v62, v64, v65);
        end;
    end;
end;
u47.normalizeDefs();
function u47.getDefs() --[[ Line: 700 ]]
    -- upvalues: u47 (copy)
    return u47.defs;
end;
function u47.findByPath(p66, p67) --[[ Line: 704 ]]
    if not p66 then
        return nil;
    end;
    if typeof(p67) == "string" then
        if not string.find(p67, "/") then
            return p66:FindFirstChild(p67, true);
        end;
        p67 = string.split(p67, "/");
    end;
    if typeof(p67) ~= "table" then
        return nil;
    end;
    for _, v68 in ipairs(p67) do
        if typeof(v68) ~= "string" then
            return nil;
        end;
        p66 = p66:FindFirstChild(v68);
        if not p66 then
            return nil;
        end;
    end;
    return p66;
end;
function u47.getSkinFolder(p69, p70, p71) --[[ Line: 736 ]]
    -- upvalues: l__ReplicatedStorage__15 (copy), u47 (copy), l__CEnum__16 (copy)
    if typeof(p71) == "table" then
        local l__asset_folder__18 = p71.asset_folder;
        if typeof(l__asset_folder__18) == "Instance" then
            return l__asset_folder__18;
        end;
    end;
    local v72 = l__ReplicatedStorage__15:FindFirstChild("Assets");
    if v72 then
        v72 = v72:FindFirstChild("Skins");
    end;
    if v72 then
        v72 = v72:FindFirstChild(p69);
    end;
    if v72 then
        local v73;
        if typeof(p71) == "table" then
            v73 = p71.asset_folder or nil;
        else
            v73 = nil;
        end;
        if typeof(v73) ~= "string" then
            local v74 = u47.getEquippedOrDefault(p69, p70);
            v73 = l__CEnum__16.reverse(l__CEnum__16.Skins, v74);
        end;
        if typeof(v73) == "string" then
            return v72:FindFirstChild(v73);
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function u47.resolveReference(p75, p76) --[[ Line: 764 ]]
    -- upvalues: u47 (copy)
    if typeof(p75) == "Instance" then
        return p75;
    elseif typeof(p75) == "string" and p76 then
        return u47.findByPath(p76, p75);
    else
        return nil;
    end;
end;
function u47.resolveReferenceWithFallback(p77, p78, p79) --[[ Line: 776 ]]
    -- upvalues: u47 (copy)
    local v80 = u47.resolveReference(p77, p78);
    if v80 then
        return v80;
    elseif typeof(p77) == "string" and p79 then
        return u47.findByPath(p79, p77);
    else
        return nil;
    end;
end;
function u47.resolveRig3P(p81, p82) --[[ Line: 789 ]]
    -- upvalues: u47 (copy), l__ReplicatedStorage__15 (copy)
    local v83 = u47.getEquippedOrDefault(p81, p82);
    local v84 = u47.getSkin(p81, v83);
    if typeof(v84) ~= "table" or v84.rig_3p == nil then
        return nil;
    end;
    local v85 = l__ReplicatedStorage__15:FindFirstChild("Assets");
    if v85 then
        v85 = v85:FindFirstChild("Rigs3P");
    end;
    local v86 = u47.getSkinFolder(p81, v83, v84);
    return u47.resolveReferenceWithFallback(v84.rig_3p, v86, v85);
end;
function u47.resolveAnimations3P(p87, p88) --[[ Line: 803 ]]
    -- upvalues: u47 (copy), l__ReplicatedStorage__15 (copy)
    local v89 = u47.getEquippedOrDefault(p87, p88);
    local v90 = u47.getSkin(p87, v89);
    if typeof(v90) ~= "table" or v90.animations_3p == nil then
        return nil;
    end;
    local v91 = l__ReplicatedStorage__15:FindFirstChild("Assets");
    if v91 then
        v91 = v91:FindFirstChild("Animations");
    end;
    local v92 = u47.getSkinFolder(p87, v89, v90);
    return u47.resolveReferenceWithFallback(v90.animations_3p, v92, v91);
end;
function u47.getSkin(p93, p94) --[[ Line: 817 ]]
    -- upvalues: u47 (copy)
    local v95 = u47.defs[p93];
    if not v95 then
        return nil;
    end;
    local v96 = p94 or u47.DEFAULT_SKIN_ID;
    return u47.normalizeDefinition(p93, v96, v95[v96]);
end;
function u47.getDefinitionsBySkinId(p97) --[[ Line: 827 ]]
    -- upvalues: u47 (copy)
    local v98 = {};
    for v99, v100 in pairs(u47.defs) do
        if v100[p97] ~= nil then
            local v101 = u47.getSkin(v99, p97);
            if v101 then
                table.insert(v98, {
                    item_id = v99,
                    skin_id = p97,
                    def = v101
                });
            end;
        end;
    end;
    table.sort(v98, function(p102, p103) --[[ Line: 843 ]]
        return p102.item_id < p103.item_id;
    end);
    return v98;
end;
function u47.isValidForItem(p104, p105) --[[ Line: 850 ]]
    -- upvalues: u47 (copy)
    return u47.getSkin(p104, p105) ~= nil;
end;
function u47.getEquippedOrDefault(p106, p107) --[[ Line: 854 ]]
    -- upvalues: u47 (copy)
    if typeof(p107) == "number" and u47.isValidForItem(p106, p107) then
        return p107;
    else
        return u47.DEFAULT_SKIN_ID;
    end;
end;
return u47;