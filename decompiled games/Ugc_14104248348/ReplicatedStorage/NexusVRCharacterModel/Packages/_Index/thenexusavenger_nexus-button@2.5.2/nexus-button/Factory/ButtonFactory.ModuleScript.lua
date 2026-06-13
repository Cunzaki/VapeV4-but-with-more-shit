-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_nexus-button@2.5.2.nexus-button.Factory.ButtonFactory
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = Color3.fromRGB(-30, -30, -30);
local l__Button__1 = require(script.Parent.Parent:WaitForChild("Button"));
local u2 = {};
u2.__index = u2;
function u2.AddColor3(p3, p4) --[[ Line: 20 ]]
    return Color3.new(math.clamp(p3.R + p4.R, 0, 1), math.clamp(p3.G + p4.G, 0, 1), (math.clamp(p3.B + p4.B, 0, 1)));
end;
function u2.CreateDefault(p5) --[[ Line: 28 ]]
    -- upvalues: u2 (copy), u1 (copy)
    local v6 = u2.new();
    v6:SetDefault("BackgroundColor3", p5);
    v6:SetDefault("BorderColor3", u2.AddColor3(p5, u1));
    v6:SetDefault("BorderTransparency", 0.25);
    return v6;
end;
function u2.new() --[[ Line: 44 ]]
    -- upvalues: u2 (copy)
    return setmetatable({
        Defaults = {}
    }, u2);
end;
function u2.Create(p7) --[[ Line: 53 ]]
    -- upvalues: l__Button__1 (copy)
    local v8 = l__Button__1.new();
    for v9, v10 in p7.Defaults do
        v8[v9] = v10;
    end;
    return v8;
end;
function u2.SetDefault(p11, p12, p13) --[[ Line: 69 ]]
    p11.Defaults[p12] = p13;
end;
function u2.UnsetDefault(p14, p15) --[[ Line: 76 ]]
    p14.Defaults[p15] = nil;
end;
return u2;
