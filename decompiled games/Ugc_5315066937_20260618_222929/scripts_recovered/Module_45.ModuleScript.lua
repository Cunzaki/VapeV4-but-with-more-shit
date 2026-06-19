-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = {
    [0] = {
        ID = 0,
        Title = "Character",
        Category = 0,
        SlotCombos = {},
        SlotTypes = {
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            12,
            13,
            14,
            15,
            16,
            17,
            20,
            21,
            22,
            23,
            24,
            25,
            35,
            35,
            35
        }
    },
    [3] = {
        ID = 3,
        Title = "Mesh",
        Category = 3,
        SlotCombos = {
            { 21 }
        },
        SlotTypes = {}
    },
    [5] = {
        ID = 5,
        Title = "Trail",
        Category = 5,
        SlotCombos = {
            { 16 }
        },
        SlotTypes = {}
    },
    [7] = {
        ID = 7,
        Title = "Surf Board",
        Category = 7,
        SlotCombos = {
            { 17 }
        },
        SlotTypes = {}
    },
    [13] = {
        ID = 13,
        Title = "Sound",
        Category = 4,
        SlotCombos = {
            { 34 },
            { 35 }
        },
        SlotTypes = {}
    },
    [14] = {
        ID = 14,
        Title = "SoundPack",
        Category = 4,
        SlotCombos = {
            { 34 },
            { 35 }
        },
        SlotTypes = {}
    },
    [15] = {
        ID = 15,
        Title = "SoundMaterialMap",
        Category = 4,
        SlotCombos = {
            { 35 }
        },
        SlotTypes = {
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34,
            34
        }
    }
};
local u2 = {
    [0] = {
        ID = 0,
        Type = 0,
        Title = "Robloxian R6",
        Description = "This is your character.  How are you reading this text...",
        Data = {
            MeshAttachment = {
                CFrame = {
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    1
                }
            },
            TrailAttachment = {
                CFrame = {
                    0,
                    -1,
                    0.5,
                    0,
                    0,
                    1,
                    0
                }
            },
            UnderFeetAttachment = {
                CFrame = {
                    0,
                    -3,
                    0,
                    0,
                    0,
                    0,
                    1
                }
            }
        }
    },
    [30] = {
        ID = 30,
        Title = "Bloxy Cola",
        Description = "Become the best drink known to Roblox.",
        Type = 3,
        Creator = 52250025,
        PriceP = 5000,
        PriceE = 50000,
        Data = {
            AssetID = 10472779,
            Mesh = {
                MeshId = 10470609,
                TextureId = 10470600,
                Scale = { 6, 6, 6 }
            }
        }
    },
    [31] = {
        ID = 31,
        Title = "Starblox Latte",
        Description = "Pumpkin spice and everything nice.",
        Type = 3,
        Creator = 52250025,
        PriceP = 4000,
        PriceE = 40000,
        Data = {
            AssetID = 15932306,
            Mesh = {
                MeshId = 15929962,
                TextureId = 15929949,
                Scale = { 8, 8, 8 }
            }
        }
    },
    [32] = {
        ID = 32,
        Title = "Doge",
        Description = "Wow.",
        Type = 3,
        Creator = 52250025,
        PriceP = 7200,
        PriceE = 72000,
        Data = {
            AssetID = 257810065,
            Mesh = {
                MeshId = 255485578,
                TextureId = 255486143,
                Scale = { 1, 1, 1 },
                Offset = { 0, -1.05, 0 }
            }
        }
    },
    [33] = {
        ID = 33,
        Title = "Soldier",
        Description = "T-pose your way to victory.",
        Type = 3,
        Creator = 52250025,
        PriceP = 4500,
        PriceE = 45000,
        Data = {
            AssetID = 430075400,
            Mesh = {
                MeshId = 430075366,
                TextureId = 430075396,
                Scale = { 0.03333333333333333, 0.03333333333333333, 0.03333333333333333 }
            },
            CFrame = {
                0,
                1,
                0,
                0
            }
        }
    },
    [34] = {
        ID = 34,
        Title = "Zatsune Miku",
        Description = "Obligatory anime girl.",
        Type = 3,
        Creator = 52250025,
        PriceP = 8000,
        PriceE = 80000,
        Data = {
            AssetID = 752599562,
            Mesh = {
                MeshId = 752599066,
                TextureId = 752599541,
                Scale = { 0.5, 0.5, 0.5 }
            }
        }
    },
    [35] = {
        ID = 35,
        Title = "Sonic",
        Description = "Gotta go fast.",
        Type = 3,
        Creator = 52250025,
        PriceP = 5000,
        PriceE = 50000,
        Data = {
            AssetID = 430069472,
            Mesh = {
                MeshId = 430069460,
                TextureId = 430069464,
                Scale = { 0.03, 0.03, 0.03 },
                Offset = { 0, -0.5, 0 }
            },
            CFrame = {
                0,
                1,
                0,
                0
            }
        }
    },
    [36] = {
        ID = 36,
        Title = "Bugs",
        Description = "What\'s up doc?",
        Type = 3,
        Creator = 52250025,
        PriceP = 4500,
        PriceE = 45000,
        Data = {
            AssetID = 1827699131,
            Mesh = {
                MeshId = 1827699045,
                TextureId = 1827699090,
                Scale = { 0.6, 0.6, 0.6 },
                Offset = { 0, 0.8, 0 }
            }
        }
    },
    [37] = {
        ID = 37,
        Title = "Kermit Boi",
        Description = "Here come dat frog.",
        Type = 3,
        Creator = 52250025,
        PriceP = 5500,
        PriceE = 55000,
        Data = {
            AssetID = 516819741,
            Mesh = {
                MeshId = 516819717,
                TextureId = 516819728,
                Scale = { 0.09, 0.09, 0.09 },
                Offset = { 0, -0.25, 0 }
            }
        }
    },
    [38] = {
        ID = 38,
        Title = "Carl Wheezer",
        Description = "Are you going to finish that croissant?",
        Type = 3,
        Creator = 52250025,
        PriceP = 5000,
        PriceE = 50000,
        Data = {
            AssetID = 682545496,
            Mesh = {
                MeshId = 682545462,
                TextureId = 682545475,
                Scale = { 0.08, 0.08, 0.08 },
                Offset = { 0, -0.4, 0 }
            },
            CFrame = {
                0,
                1,
                0,
                0
            }
        }
    },
    [39] = {
        ID = 39,
        Title = "Steve",
        Description = "It\'s Steve Minecraft.",
        Type = 3,
        Creator = 52250025,
        PriceP = 4000,
        PriceE = 40000,
        Data = {
            AssetID = 3885660639,
            Mesh = {
                MeshId = 3885660456,
                TextureId = 3885660543,
                Scale = { 0.74, 0.74, 0.74 }
            },
            CFrame = {
                0,
                -0.7071067811865476,
                0,
                0.7071067811865476
            }
        }
    },
    [300] = {
        ID = 300,
        Title = "iPhone",
        Description = "Thanks Tim Apple.",
        Type = 3,
        Creator = 52250025,
        PriceP = 5000,
        PriceE = 50000,
        Data = {
            AssetID = 430345288,
            Mesh = {
                MeshId = 430345282,
                TextureId = 430345284,
                Scale = { 0.75, 0.75, 0.75 }
            },
            CFrame = {
                0,
                1,
                0,
                0
            }
        }
    },
    [301] = {
        ID = 301,
        Title = "Teapot",
        Description = "The famous Utah Teapot.",
        Type = 3,
        Creator = 52250025,
        PriceP = 3000,
        PriceE = 30000,
        Data = {
            AssetID = 553688044,
            Mesh = {
                MeshId = 553688034,
                Scale = { 3, 3, 3 },
                Offset = { 0, -1.45, 0 }
            },
            CFrame = {
                0,
                0.7071067811865476,
                0,
                0.7071067811865476
            }
        }
    },
    [302] = {
        ID = 302,
        Title = "Vending Machine",
        Description = "Jump around as a vending machine.",
        Type = 3,
        Creator = 52250025,
        PriceP = 5000,
        PriceE = 50000,
        Data = {
            AssetID = 443415009,
            Mesh = {
                MeshId = 443414829,
                TextureId = 443414983,
                Scale = { 0.0106, 0.0106, 0.0106 },
                Offset = { 0, -0.05, 0 }
            },
            CFrame = {
                0,
                1,
                0,
                0
            }
        }
    },
    [303] = {
        ID = 303,
        Title = "Helicopter",
        Description = "Get in the chopper.",
        Type = 3,
        Creator = 52250025,
        PriceP = 7000,
        PriceE = 70000,
        Data = {
            AssetID = 3399215657,
            Mesh = {
                MeshId = 3399215450,
                TextureId = 3399215572,
                Scale = { 4.5, 4.5, 4.5 },
                Offset = { 0, 0.8, 0 }
            },
            CFrame = {
                0,
                -0.3826834323650897,
                0,
                0.9238795325112867
            }
        }
    },
    [304] = {
        ID = 304,
        Title = "Lawnmower",
        Description = "There is no need to be upset.",
        Type = 3,
        Creator = 52250025,
        PriceP = 5500,
        PriceE = 55000,
        Data = {
            AssetID = 550140420,
            Mesh = {
                MeshId = 550140319,
                TextureId = 550140404,
                Scale = { 0.07, 0.07, 0.07 },
                Offset = { 0, -1.1, 0 }
            }
        }
    },
    [305] = {
        ID = 305,
        Title = "Crash Bandicoot",
        Description = "Woah.",
        Type = 3,
        Creator = 52250025,
        PriceP = 5000,
        PriceE = 50000,
        Data = {
            AssetID = 430155878,
            Mesh = {
                MeshId = 430155854,
                TextureId = 430155861,
                Scale = { 0.3, 0.3, 0.3 },
                Offset = { 0, -0.4, 0 }
            },
            CFrame = {
                0,
                1,
                0,
                0
            }
        }
    },
    [306] = {
        ID = 306,
        Title = "Green Shell",
        Description = "Koopa carapace.",
        Type = 3,
        Creator = 52250025,
        PriceP = 3500,
        PriceE = 35000,
        Data = {
            AssetID = 430090818,
            Mesh = {
                MeshId = 430090810,
                TextureId = 430090814,
                Scale = { 0.005, 0.005, 0.005 },
                Offset = { 0, -1.4, 0 }
            }
        }
    },
    [307] = {
        ID = 307,
        Title = "TARDIS",
        Description = "Time and Relative Dimension in Space.",
        Type = 3,
        Creator = 52250025,
        PriceP = 5000,
        PriceE = 50000,
        Data = {
            AssetID = 430080541,
            Mesh = {
                MeshId = 430080461,
                TextureId = 430080522,
                Scale = { 0.59, 0.59, 0.59 }
            },
            CFrame = {
                0,
                -0.7071067811865476,
                0,
                0.7071067811865476
            }
        }
    },
    [50] = {
        ID = 50,
        Title = "Red",
        Description = "Better red than dead.",
        Type = 5,
        Creator = 52250025,
        PriceP = 2000,
        PriceE = 20000,
        Data = {
            Trail = {
                Lifetime = 1,
                Color = {
                    { 255, 0, 0 }
                }
            },
            Attachment0 = {
                CFrame = { 0, 0.5, 0 }
            },
            Attachment1 = {
                CFrame = { 0, -0.5, 0 }
            }
        }
    },
    [51] = {
        ID = 51,
        Title = "Orange",
        Description = "Orange you glad it isn\'t red?",
        Type = 5,
        Creator = 52250025,
        PriceP = 2000,
        PriceE = 20000,
        Data = {
            Trail = {
                Lifetime = 1,
                Color = {
                    { 255, 128, 0 }
                }
            },
            Attachment0 = {
                CFrame = { 0, 0.5, 0 }
            },
            Attachment1 = {
                CFrame = { 0, -0.5, 0 }
            }
        }
    },
    [52] = {
        ID = 52,
        Title = "Yellow",
        Description = "Praise the sun.",
        Type = 5,
        Creator = 52250025,
        PriceP = 2000,
        PriceE = 20000,
        Data = {
            Trail = {
                Lifetime = 1,
                Color = {
                    { 255, 255, 0 }
                }
            },
            Attachment0 = {
                CFrame = { 0, 0.5, 0 }
            },
            Attachment1 = {
                CFrame = { 0, -0.5, 0 }
            }
        }
    },
    [53] = {
        ID = 53,
        Title = "Green",
        Description = "The human eye can see the most shades of green.",
        Type = 5,
        Creator = 52250025,
        PriceP = 2000,
        PriceE = 20000,
        Data = {
            Trail = {
                Lifetime = 1,
                Color = {
                    { 0, 255, 0 }
                }
            },
            Attachment0 = {
                CFrame = { 0, 0.5, 0 }
            },
            Attachment1 = {
                CFrame = { 0, -0.5, 0 }
            }
        }
    },
    [54] = {
        ID = 54,
        Title = "Teal",
        Description = "Teal Protoss.",
        Type = 5,
        Creator = 52250025,
        PriceP = 2000,
        PriceE = 20000,
        Data = {
            Trail = {
                Lifetime = 1,
                Color = {
                    { 0, 128, 128 }
                }
            },
            Attachment0 = {
                CFrame = { 0, 0.5, 0 }
            },
            Attachment1 = {
                CFrame = { 0, -0.5, 0 }
            }
        }
    },
    [55] = {
        ID = 55,
        Title = "Blue",
        Description = "Unnaturally blue.",
        Type = 5,
        Creator = 52250025,
        PriceP = 2000,
        PriceE = 20000,
        Data = {
            Trail = {
                Lifetime = 1,
                Color = {
                    { 0, 0, 255 }
                }
            },
            Attachment0 = {
                CFrame = { 0, 0.5, 0 }
            },
            Attachment1 = {
                CFrame = { 0, -0.5, 0 }
            }
        }
    },
    [56] = {
        ID = 56,
        Title = "Purple",
        Description = "Quaternions\' favourite colour!",
        Type = 5,
        Creator = 52250025,
        PriceP = 2000,
        PriceE = 20000,
        Data = {
            Trail = {
                Lifetime = 1,
                Color = {
                    { 128, 0, 255 }
                }
            },
            Attachment0 = {
                CFrame = { 0, 0.5, 0 }
            },
            Attachment1 = {
                CFrame = { 0, -0.5, 0 }
            }
        }
    },
    [57] = {
        ID = 57,
        Title = "White",
        Description = "Reflects all the colours.",
        Type = 5,
        Creator = 52250025,
        PriceP = 2000,
        PriceE = 20000,
        Data = {
            Trail = {
                Lifetime = 1,
                Color = {
                    { 255, 255, 255 }
                }
            },
            Attachment0 = {
                CFrame = { 0, 0.5, 0 }
            },
            Attachment1 = {
                CFrame = { 0, -0.5, 0 }
            }
        }
    },
    [58] = {
        ID = 58,
        Title = "Black",
        Description = "Dark.",
        Type = 5,
        Creator = 52250025,
        PriceP = 2000,
        PriceE = 20000,
        Data = {
            Trail = {
                Lifetime = 1,
                Color = {
                    { 0, 0, 0 }
                }
            },
            Attachment0 = {
                CFrame = { 0, 0.5, 0 }
            },
            Attachment1 = {
                CFrame = { 0, -0.5, 0 }
            }
        }
    },
    [59] = {
        ID = 59,
        Title = "Pink",
        Description = "Rose gold? Oh you mean pink.",
        Type = 5,
        Creator = 52250025,
        PriceP = 2000,
        PriceE = 20000,
        Data = {
            Trail = {
                Lifetime = 1,
                Color = {
                    { 255, 0, 160 }
                }
            },
            Attachment0 = {
                CFrame = { 0, 0.5, 0 }
            },
            Attachment1 = {
                CFrame = { 0, -0.5, 0 }
            }
        }
    },
    [75] = {
        ID = 75,
        Title = "Ranbo",
        Description = "This trail pretty ranbo behind your.",
        Type = 5,
        Creator = 52250025,
        PriceP = 4800,
        PriceE = 48000,
        Data = {
            Trail = {
                Texture = 4489632265,
                Lifetime = 2,
                TextureLength = 100,
                TextureMode = 1
            },
            Attachment0 = {
                CFrame = { 0, 1, 0 }
            },
            Attachment1 = {
                CFrame = { 0, -1, 0 }
            }
        }
    },
    [76] = {
        ID = 76,
        Title = "Aneurism",
        Description = "This is the first item ever added to the shop.",
        Type = 5,
        Creator = 52250025,
        PriceP = 3200,
        PriceE = 32000,
        Data = {
            Trail = {
                Texture = 4900018730,
                Lifetime = 1,
                TextureLength = 3.5555555555555554,
                TextureMode = 2
            },
            Attachment0 = {
                CFrame = { 0, 1, 0 }
            },
            Attachment1 = {
                CFrame = { 0, -1, 0 }
            }
        }
    },
    [70] = {
        ID = 70,
        Title = "Triangle Surfer",
        Description = "This is a surf board for someone who surfs triangles.",
        Type = 7,
        Creator = 52250025,
        PriceP = 800,
        PriceE = 8000,
        SlotTypes = { 33 },
        Data = {
            Mode = 1,
            Image = 4900137861,
            Handle = {
                TopSurface = 0,
                BottomSurface = 0,
                Size = { 1, 6, 4 }
            },
            Weld = {
                C1 = {
                    0.49,
                    -0.23076923076923078,
                    1.1794871794871795,
                    0,
                    1,
                    0,
                    0.5547001962252291,
                    0,
                    -0.8320502943378437,
                    -0.8320502943378437,
                    0,
                    -0.5547001962252291
                }
            }
        }
    },
    [71] = {
        ID = 71,
        Title = "Merely Surfboard",
        Description = "Straight from the roblox catalogue and onto your feet.",
        Type = 7,
        Creator = 52250025,
        PriceP = 1200,
        PriceE = 12000,
        Data = {
            Mode = 0,
            AssetID = 233660801,
            Mesh = {
                MeshId = 230850078,
                TextureId = 230850143,
                Scale = { 0.013, 0.013, 0.013 }
            },
            Weld = {
                C1 = { 0, 0.05, 0 }
            }
        }
    },
    [72] = {
        ID = 72,
        Title = "Board with Nail",
        Description = "Watch out for that pointy bit.",
        Type = 7,
        Creator = 52250025,
        PriceP = 2000,
        PriceE = 20000,
        Data = {
            Mode = 0,
            AssetID = 10510024,
            Mesh = {
                MeshId = 10547612,
                TextureId = 10547605,
                Scale = { 2, 2, 2 }
            },
            Weld = {
                C1 = {
                    0.15,
                    0,
                    0,
                    0,
                    0,
                    -0.7071067811865476,
                    0.7071067811865476
                }
            }
        }
    },
    [73] = {
        ID = 73,
        Title = "Money",
        Description = "Stepping on that cash.",
        Type = 7,
        Creator = 52250025,
        PriceP = 10000,
        PriceE = 100000,
        Data = {
            Mode = 0,
            AssetID = 511726147,
            Mesh = {
                MeshId = 511726060,
                TextureId = 511726139,
                Scale = { 0.03, 0.03, 0.03 },
                Offset = { 0, -0.25, 0 }
            },
            Weld = {
                C1 = {
                    0,
                    -0.7071067811865476,
                    0,
                    0.7071067811865476
                }
            }
        }
    },
    [74] = {
        ID = 74,
        Title = "Wheelchair",
        Description = "Some maps may need an accessibility audit.",
        Type = 7,
        Creator = 52250025,
        PriceP = 4000,
        PriceE = 40000,
        Data = {
            Mode = 0,
            AssetID = 6637278870,
            Mesh = {
                MeshId = 6637278141,
                TextureId = 6637278446,
                Scale = { 0.1, 0.1, 0.1 },
                Offset = { 0, 2, 0 }
            },
            Weld = {
                C1 = {
                    0,
                    1,
                    0,
                    0
                }
            }
        }
    }
};
local u3 = {};
local u4 = {};
local u5 = next;
local u6 = type;
local function u14(p7, p8) --[[ Line: 868 ]]
    -- upvalues: u6 (copy), u5 (copy), u14 (copy)
    if u6(p7) ~= "table" then
        return p7;
    end;
    local v9 = p8 or {};
    local v10 = v9[p7];
    if v10 then
        return v10;
    end;
    local v11 = {};
    v9[p7] = v11;
    for v12, v13 in u5, p7 do
        v11[u14(v12, v9)] = u14(v13, v9);
    end;
    return v11;
end;
local u15 = {};
local function u29(p16, p17) --[[ Line: 910 ]]
    local v18 = #p16;
    local v19 = {};
    for v20 = 1, p17 do
        v19[v20] = v20;
    end;
    local v21 = {};
    if v18 == 0 then
        return v21;
    end;
    local v22 = 0;
    while true do
        local v23 = {};
        for v24 = 1, p17 do
            v23[v24] = p16[v19[v24]];
        end;
        v22 = v22 + 1;
        v21[v22] = v23;
        for v25 = 0, p17 do
            local v26 = v19[p17 - v25];
            if v26 ~= v18 - v25 then
                if v25 == p17 then
                    return v21;
                end;
                local v27 = v26 - (p17 - v25) + 1;
                for v28 = p17 - v25, p17 do
                    v19[v28] = v27 + v28;
                end;
            end;
        end;
    end;
end;
return {
    ItemTypes = u1,
    ItemClasses = u2,
    ItemInstances = u3,
    IDList = function(p30) --[[ Name: IDList, Line 858 ]]
        local v31 = {};
        for v32 = 1, #p30 do
            v31[v32] = p30[v32].ID;
        end;
        return v31;
    end,
    CreateInstanceOfClass = function(p33, p34, p35) --[[ Name: CreateInstanceOfClass, Line 891 ]]
        -- upvalues: u15 (copy), u14 (copy), u2 (copy)
        local v36;
        if u15[p33] then
            v36 = u14(u2[p33].Data);
        else
            v36 = nil;
        end;
        return {
            EquippedTo = 0,
            EquippedToSlots = 0,
            Class = p33,
            Owner = p34,
            Date = p35,
            Updated = p35,
            Data = v36
        };
    end,
    SlotDescriptions = {
        [1] = "Right Hand",
        [2] = "Left Hand",
        [3] = "Head",
        [4] = "Face",
        [5] = "Neck",
        [6] = "Right Shoulder",
        [7] = "Left Shoulder",
        [8] = "Back",
        [9] = "Shirt",
        [10] = "Tail",
        [11] = "Belt",
        [12] = "Right Leg",
        [13] = "Left Leg",
        [14] = "Right Foot",
        [15] = "Left Foot",
        [16] = "Trail",
        [17] = "Under Feet",
        [20] = "Head Mesh",
        [21] = "Torso Mesh",
        [22] = "Right Arm Mesh",
        [23] = "Left Arm Mesh",
        [24] = "Right Leg Mesh",
        [25] = "Left Leg Mesh",
        [32] = "Texture",
        [33] = "Color",
        [34] = "Sound",
        [35] = "SoundMaterialMap"
    },
    GetEquipOptions = function(p37, p38) --[[ Name: GetEquipOptions, Line 960 ]]
        -- upvalues: u3 (copy), u2 (copy), u1 (copy), u5 (copy), u29 (copy)
        local v39 = u2[u3[p38].Class];
        local v40 = v39.SlotCombos or u1[v39.Type].SlotCombos;
        local v41 = {};
        for v42 = 1, #v40 do
            local v43 = v40[v42];
            local v44 = {};
            for v45 = 1, #v43 do
                local v46 = v43[v45];
                v44[v46] = (v44[v46] or 0) + 1;
            end;
            v41[v42] = v44;
        end;
        local v47 = 0;
        local v48 = {};
        local v49 = u3[p37];
        if v49 then
            local v50 = u2[v49.Class];
            local v51 = v50.SlotTypes or u1[v50.Type].SlotTypes;
            local v52 = {};
            for v53 = 1, #v51 do
                local v54 = v51[v53];
                local v55 = v52[v54] or {};
                v55[#v55 + 1] = v53;
                v52[v54] = v55;
            end;
            for v56 = 1, #v40 do
                local _ = v40[v56];
                local v57 = 0;
                local v58 = {};
                local v59 = {};
                local v60 = true;
                for v61, v62 in u5, v41[v56] do
                    local v63 = v52[v61];
                    if not v63 then
                        v60 = false;
                        break;
                    end;
                    v57 = v57 + 1;
                    v58[v57] = v61;
                    v59[v57] = u29(v63, v62);
                end;
                if v60 then
                    local v64 = #v59;
                    local v65 = {};
                    local v66 = {};
                    for v67 = 1, v64 do
                        v65[v67] = #v59[v67];
                        v66[v67] = 1;
                    end;
                    local v68;
                    if v64 > 0 then
                        v68 = true;
                    else
                        v68 = false;
                    end;
                    while v68 do
                        local v69 = {};
                        local v70 = {
                            EquipTo = v49.ID,
                            Title = v50.Title,
                            Slots = v69
                        };
                        for v71 = 1, v64 do
                            local v72 = v59[v71][v66[v71]];
                            local v73 = #v69;
                            for v74 = 1, #v72 do
                                v69[v73 + v74] = v72[v74];
                            end;
                        end;
                        v47 = v47 + 1;
                        v48[v47] = v70;
                        for v75 = 0, v64 do
                            local v76 = v66[v64 - v75];
                            if v76 ~= v65[v64 - v75] then
                                v66[v64 - v75] = v76 + 1;
                                for v77 = v64 - v75 + 1, v64 do
                                    v66[v77] = 1;
                                end;
                                break;
                            end;
                            if v75 == v64 then
                                v68 = false;
                                break;
                            end;
                        end;
                    end;
                end;
            end;
        end;
        return v48;
    end,
    Subsets = u29,
    EquipTreeCache = u4,
    GenerateEquipTreeFromInstanceList = function(p78) --[[ Name: GenerateEquipTreeFromInstanceList, Line 1187 ]]
        -- upvalues: u3 (copy), u5 (copy), u4 (copy)
        local v79 = {};
        for v80 = 1, #p78 do
            local v81 = p78[v80];
            local v82 = u3[v81.EquippedTo];
            if v82 then
                local v83 = v79[v82.ID];
                if v83 then
                    v83[#v83 + 1] = v81.ID;
                else
                    v79[v82.ID] = { v81.ID };
                end;
            end;
        end;
        for v84, v85 in u5, v79 do
            u4[v84] = v85;
        end;
        return v79;
    end,
    GenerateEquipListFromEquipTree = function(p86, p87) --[[ Name: GenerateEquipListFromEquipTree, Line 1216 ]]
        local v88 = { p87 };
        local v89 = 1;
        local v90 = {};
        while true do
            local v91 = v88[v89];
            local v92 = p86[v91];
            if not v90[v91] then
                v90[v91] = true;
                if v92 then
                    for v93 = 1, #v92 do
                        local v94 = v92[v93];
                        if v90[v94] == nil then
                            v90[v94] = false;
                            v88[#v88 + 1] = v94;
                        end;
                    end;
                end;
            end;
            v89 = v89 + 1;
            if #v88 < v89 then
                return v88;
            end;
        end;
    end
};
