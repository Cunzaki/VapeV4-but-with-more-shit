-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_nexus-button@2.5.2.nexus-button.Factory.TextButtonFactory
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = Color3.fromRGB(-30, -30, -30);
require(script.Parent.Parent:WaitForChild("Button"));
local l__ButtonFactory__1 = require(script.Parent:WaitForChild("ButtonFactory"));
local u2 = {};
u2.__index = u2;
setmetatable(u2, l__ButtonFactory__1);
function u2.CreateDefault(p3) --[[ Line: 23 ]]
    -- upvalues: u2 (copy), l__ButtonFactory__1 (copy), u1 (copy)
    local v4 = u2.new();
    v4:SetDefault("BackgroundColor3", p3);
    v4:SetDefault("BorderColor3", l__ButtonFactory__1.AddColor3(p3, u1));
    v4:SetDefault("BorderTransparency", 0.25);
    v4:SetTextDefault("Font", Enum.Font.SourceSans);
    v4:SetTextDefault("TextColor3", Color3.fromRGB(255, 255, 255));
    v4:SetTextDefault("TextStrokeColor3", Color3.fromRGB(0, 0, 0));
    v4:SetTextDefault("TextStrokeTransparency", 0);
    v4:SetTextDefault("TextScaled", true);
    return v4;
end;
function u2.new() --[[ Line: 44 ]]
    -- upvalues: l__ButtonFactory__1 (copy), u2 (copy)
    local v5 = l__ButtonFactory__1.new();
    local v6 = setmetatable(v5, u2);
    v6.TextDefaults = {};
    return v6;
end;
function u2.Create(p7) --[[ Line: 53 ]]
    -- upvalues: l__ButtonFactory__1 (copy)
    local v8 = l__ButtonFactory__1.Create(p7);
    local v9 = Instance.new("TextLabel");
    v9.Size = UDim2.new(1, 0, 1, 0);
    v9.AnchorPoint = Vector2.new(0.5, 0.5);
    v9.Position = UDim2.new(0.5, 0, 0.5, 0);
    v9.BackgroundTransparency = 1;
    v9.ZIndex = 5;
    v9.Parent = v8:GetAdornFrame();
    for v10, v11 in p7.TextDefaults do
        v9[v10] = v11;
    end;
    return v8, v9;
end;
function u2.SetTextDefault(p12, p13, p14) --[[ Line: 78 ]]
    p12.TextDefaults[p13] = p14;
end;
function u2.UnsetTextDefault(p15, p16) --[[ Line: 85 ]]
    p15.TextDefaults[p16] = nil;
end;
return u2;
