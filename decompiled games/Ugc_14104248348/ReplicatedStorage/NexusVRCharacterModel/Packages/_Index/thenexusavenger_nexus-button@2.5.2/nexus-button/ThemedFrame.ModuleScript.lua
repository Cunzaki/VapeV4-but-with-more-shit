-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_nexus-button@2.5.2.nexus-button.ThemedFrame
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v1 = {
    CutCorners = {
        MainButton = {
            Image = "rbxassetid://76476290918578",
            SliceScaleMultiplier = 0.00625,
            SliceCenter = Rect.new(32, 32, 34, 34)
        },
        GamepadIconBackground = {
            Image = "rbxassetid://135976734207422",
            SliceScaleMultiplier = 0.00625,
            SliceCenter = Rect.new(32, 32, 34, 34)
        }
    },
    CutTopLeftCorner = {
        MainButton = {
            Image = "rbxassetid://127204475432575",
            SliceScaleMultiplier = 0.00625,
            SliceCenter = Rect.new(32, 32, 34, 34)
        },
        GamepadIconBackground = {
            Image = "rbxassetid://95201075795195",
            SliceScaleMultiplier = 0.00625,
            SliceCenter = Rect.new(32, 32, 34, 34)
        }
    },
    CutBottomRightCorner = {
        MainButton = {
            Image = "rbxassetid://135976734207422",
            SliceScaleMultiplier = 0.00625,
            SliceCenter = Rect.new(32, 32, 34, 34)
        },
        GamepadIconBackground = {
            Image = "rbxassetid://135976734207422",
            SliceScaleMultiplier = 0.00625,
            SliceCenter = Rect.new(32, 32, 34, 34)
        }
    },
    RoundedCorners = {
        MainButton = {
            Image = "rbxassetid://136205699446611",
            SliceScaleMultiplier = 0.00625,
            SliceCenter = Rect.new(32, 32, 34, 34)
        },
        GamepadIconBackground = {
            Image = "rbxassetid://98913835358317",
            SliceScaleMultiplier = 0.00625,
            SliceCenter = Rect.new(32, 32, 34, 34)
        }
    }
};
local l__NexusInstance__1 = require(script.Parent:WaitForChild("Packages"):WaitForChild("NexusInstance"));
local l__SimpleWrappedInstance__2 = require(script.Parent:WaitForChild("SimpleWrappedInstance"));
local u2 = {
    Themes = v1
};
u2.__index = u2;
setmetatable(u2, l__SimpleWrappedInstance__2);
function u2.__new(u3) --[[ Line: 85 ]]
    -- upvalues: l__SimpleWrappedInstance__2 (copy)
    l__SimpleWrappedInstance__2.__new(u3, Instance.new("ImageLabel"));
    u3:GetWrappedInstance().BackgroundTransparency = 1;
    u3:DisableChangeReplication("Theme");
    u3.Theme = "CutCorners";
    u3:DisableChangeReplication("SubTheme");
    u3.SubTheme = "MainButton";
    u3:DisableChangeReplication("BackgroundColor3");
    u3:OnPropertyChanged("BackgroundColor3", function(p4) --[[ Line: 97 ]]
        -- upvalues: u3 (copy)
        u3.ImageColor3 = p4;
    end);
    u3:DisableChangeReplication("BackgroundTransparency");
    u3:OnPropertyChanged("BackgroundTransparency", function(p5) --[[ Line: 101 ]]
        -- upvalues: u3 (copy)
        u3.ImageTransparency = p5;
    end);
    u3:DisableChangeReplication("SliceScaleMultiplier");
    u3:OnPropertyChanged("SliceScaleMultiplier", function() --[[ Line: 105 ]]
        -- upvalues: u3 (copy)
        u3:UpdateSliceScale();
    end);
    u3:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 108 ]]
        -- upvalues: u3 (copy)
        u3:UpdateSliceScale();
    end);
    u3:OnPropertyChanged("Theme", function() --[[ Line: 113 ]]
        -- upvalues: u3 (copy)
        u3:UpdateTheme();
    end);
    u3:OnPropertyChanged("SubTheme", function() --[[ Line: 116 ]]
        -- upvalues: u3 (copy)
        u3:UpdateTheme();
    end);
    u3.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    u3.BackgroundTransparency = 0;
    u3.ScaleType = Enum.ScaleType.Slice;
    u3.SliceScaleMultiplier = 1;
    u3.Size = UDim2.new(0, 100, 0, 100);
    u3:UpdateTheme();
end;
function u2.UpdateSliceScale(p6) --[[ Line: 132 ]]
    -- upvalues: u2 (copy)
    local v7 = u2.Themes[p6.Theme][p6.SubTheme];
    p6.SliceScale = math.min(p6.AbsoluteSize.X, p6.AbsoluteSize.Y) * v7.SliceScaleMultiplier * (p6.SliceScaleMultiplier or 1);
end;
function u2.UpdateTheme(p8) --[[ Line: 140 ]]
    -- upvalues: u2 (copy)
    local v9 = u2.Themes[p8.Theme];
    if not v9 then
        error((`Unknown theme: {p8.Theme}`));
    end;
    local v10 = v9[p8.SubTheme];
    if not v10 then
        error((`Unknown subtheme: {p8.SubTheme}`));
    end;
    p8.Image = v10.Image;
    p8.SliceCenter = v10.SliceCenter;
    p8:UpdateSliceScale();
end;
return l__NexusInstance__1.ToInstance(u2);
