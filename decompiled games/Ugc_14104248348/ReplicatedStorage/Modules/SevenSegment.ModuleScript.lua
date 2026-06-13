-- Decompiled from: ReplicatedStorage.Modules.SevenSegment
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__CharacterSheet__1 = require(script:WaitForChild("CharacterSheet"));
local l__SegmentDisplayTemplate__2 = script:WaitForChild("SegmentDisplayTemplate");
local l__SegmentDisplayItalicsTemplate__3 = script:WaitForChild("SegmentDisplayItalicsTemplate");
function v1.new(p2, p3, p4) --[[ Line: 78 ]]
    -- upvalues: l__SegmentDisplayItalicsTemplate__3 (copy), l__SegmentDisplayTemplate__2 (copy), l__CharacterSheet__1 (copy)
    p2 = p2;
    local v5;
    if p2 then
        v5 = p2:IsA("GuiObject");
    else
        v5 = p2;
    end;
    assert(v5, "Module Error - Argument 1. Please provide a valid GuiObject");
    local u6 = Instance.new("Frame");
    u6.AutomaticSize = Enum.AutomaticSize.X;
    u6.BackgroundTransparency = 1;
    u6.Size = UDim2.fromScale(1, 1);
    u6.Name = "SegmentDisplayRow";
    u6.Parent = p2;
    u6.Visible = true;
    local u7 = math.ceil(u6.AbsoluteSize.Y / 12);
    local v8 = false;
    local u9 = 1.5;
    local v10 = Color3.new(1, 1, 1);
    local v11 = nil;
    local l__Left__4 = Enum.HorizontalAlignment.Left;
    local v12 = UDim.new(0, 15);
    local v13 = not (p4 and p4.Thickness);
    if p4 then
        v10 = p4.OnColour or v10;
        v11 = p4.OffColour or v11;
        u7 = p4.Thickness or u7;
        u9 = p4.SeamSize or u9;
        v8 = p4.Italics or v8;
        l__Left__4 = p4.HorizontalAlignment or l__Left__4;
        v12 = p4.LayoutSpacing or v12;
    end;
    local u14 = {
        Frame = p2,
        DigitCount = p3 or 1,
        OnColour = v10,
        OffColour = v11,
        CurrentDisplays = {}
    };
    local v15 = Instance.new("UIListLayout");
    v15.FillDirection = Enum.FillDirection.Horizontal;
    v15.HorizontalAlignment = l__Left__4 or Enum.HorizontalAlignment.Left;
    v15.Padding = v12;
    v15.SortOrder = Enum.SortOrder.LayoutOrder;
    v15.Parent = u6;
    local v16;
    if v8 then
        v16 = l__SegmentDisplayItalicsTemplate__3;
    else
        v16 = l__SegmentDisplayTemplate__2;
    end;
    local function u22(p17) --[[ Line: 143 ]]
        -- upvalues: u7 (ref), u9 (ref)
        local v18 = u7;
        local v19 = v18 / 2 * u9;
        for v20, v21 in ipairs(p17) do
            if v20 == 1 or (v20 == 4 or v20 == 7) then
                v21.Size = UDim2.new(1, -v18, 0, v18);
            else
                v21.Size = UDim2.new(1, -v19, 0, v18);
            end;
        end;
        p17[2].Position = UDim2.new(1, -v18 / 2, 0.25, v18 / 4);
        p17[6].Position = UDim2.new(0, v18 / 2, 0.25, v18 / 4);
        p17[3].Position = UDim2.new(1, -v18 / 2, 0.75, -v18 / 4);
        p17[5].Position = UDim2.new(0, v18 / 2, 0.75, -v18 / 4);
    end;
    if v13 then
        local v23 = math.ceil(u6.AbsoluteSize.Y / 12);
        u7 = v23;
    end;
    for v24 = 1, u14.DigitCount do
        local v25 = v16:Clone();
        v25.Name = "SegmentDisplay" .. v24;
        v25.Parent = u6;
        v25.LayoutOrder = v24;
        v25.Visible = true;
        local v26 = {
            v25.TopSegment,
            v25.TopRightSegment,
            v25.BottomRightSegment,
            v25.BottomSegment,
            v25.BottomLeftSegment,
            v25.TopLeftSegment,
            v25.MiddleSegment
        };
        local v27 = {
            IsVisible = true,
            EnabledSegments = {
                false,
                false,
                false,
                false,
                false,
                false,
                false
            },
            OnColour = v10,
            OffColour = v11,
            SegmentFrames = v26
        };
        for _, v28 in ipairs(v26) do
            if v11 then
                v28.ImageColor3 = v11;
            else
                v28.Visible = false;
            end;
        end;
        u22(v26);
        table.insert(u14.CurrentDisplays, v27);
    end;
    local u29;
    if v13 then
        u29 = u6:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 210 ]]
            -- upvalues: u7 (ref), u6 (copy), u14 (copy), u22 (copy)
            u7 = math.ceil(u6.AbsoluteSize.Y / 12);
            for v30 = 1, u14.DigitCount do
                u22(u14.CurrentDisplays[v30].SegmentFrames);
            end;
        end);
    else
        u29 = nil;
    end;
    function u14.Set(p31, p32, p33) --[[ Line: 220 ]]
        -- upvalues: l__CharacterSheet__1 (ref)
        local v34 = p33 or 1;
        if #p31.CurrentDisplays < v34 then
        else
            local v35;
            if p32 then
                v35 = tostring(p32);
            else
                v35 = p32;
            end;
            assert(v35, "Module Error - Arugment 1. Invalid number/string");
            local v36 = v34 and tonumber(v34);
            if v36 then
                v36 = math.floor(v34) == v34;
            end;
            assert(v36, "Module Error - Argument 2. Invalid value. DigitIndex must be an interger");
            local v37 = p31.CurrentDisplays[v34];
            if v37.IsVisible then
                local v38 = l__CharacterSheet__1[tostring(p32)] or l__CharacterSheet__1[tostring(p32):lower()];
                if v38 then
                    for v39, v40 in ipairs(v37.SegmentFrames) do
                        local v41 = v38[v39];
                        if v41 then
                            v41 = v38[v39] == 1;
                        end;
                        v37.EnabledSegments[v39] = v41;
                        if v41 then
                            v40.Visible = true;
                            v40.ImageColor3 = p31.OnColour;
                        elseif p31.OffColour then
                            v40.ImageColor3 = p31.OffColour;
                        else
                            v40.Visible = false;
                        end;
                    end;
                else
                    for _, v42 in ipairs(v37.SegmentFrames) do
                        if p31.OffColour then
                            v42.ImageColor3 = p31.OffColour;
                        else
                            v42.Visible = false;
                        end;
                    end;
                end;
            end;
        end;
    end;
    function u14.SetText(p43, p44) --[[ Line: 270 ]]
        local v45;
        if p44 then
            v45 = tostring(p44);
        else
            v45 = p44;
        end;
        assert(v45, "Module Error - Argument 1. Please provide a valid string or number");
        local v46;
        if typeof(p44) == "number" then
            local v47 = math.floor(p44);
            v46 = tostring(v47);
        else
            v46 = tostring(p44);
        end;
        local v48 = string.split(v46, "");
        for v49 = 1, #p43.CurrentDisplays do
            if v48[v49] then
                p43:Set(v48[v49], v49);
            else
                p43:Set("", v49);
            end;
        end;
    end;
    function u14.SetColours(u50, u51, u52, p53) --[[ Line: 292 ]]
        local v54;
        if u51 then
            v54 = typeof(u51) == "Color3";
        else
            v54 = u51;
        end;
        assert(v54, "Module Error - Argument 1. Please provide a valid Color3 value");
        local v55 = not u51 or typeof(u51) == "Color3";
        assert(v55, "Module Error - Argument 2. Please provide a valid Color3 value");
        local function v59(p56) --[[ Line: 296 ]]
            -- upvalues: u50 (copy), u51 (copy), u52 (copy)
            u50.OnColour = u51;
            if u52 then
                u50.OffColour = u52;
            end;
            if p56.IsVisible then
                for v57, v58 in ipairs(p56.SegmentFrames) do
                    if p56.EnabledSegments[v57] then
                        v58.ImageColor3 = u51;
                    elseif u52 then
                        v58.ImageColor3 = u52;
                        v58.Visible = true;
                    end;
                end;
            end;
        end;
        if p53 then
            v59(u50.CurrentDisplays[p53]);
        else
            for v60, _ in ipairs(u50.CurrentDisplays) do
                v59(u50.CurrentDisplays[v60]);
            end;
        end;
    end;
    function u14.SetVisibility(u61, u62, p63) --[[ Line: 324 ]]
        local function v67(p64) --[[ Line: 325 ]]
            -- upvalues: u62 (copy), u61 (copy)
            for v65, v66 in ipairs(p64.SegmentFrames) do
                if p64.EnabledSegments[v65] and u62 then
                    v66.ImageColor3 = u61.OnColour;
                    v66.Visible = true;
                elseif u61.OffColour and u62 then
                    v66.ImageColor3 = u61.OffColour;
                    v66.Visible = true;
                else
                    v66.Visible = false;
                    v66.ImageColor3 = u61.OnColour;
                end;
            end;
            p64.IsVisible = u62;
        end;
        if p63 then
            v67(u61.CurrentDisplays[p63]);
        else
            for v68, _ in ipairs(u61.CurrentDisplays) do
                v67(u61.CurrentDisplays[v68]);
            end;
        end;
    end;
    function u14.Destroy(_) --[[ Line: 353 ]]
        -- upvalues: u29 (ref), u6 (copy), u14 (copy)
        if u29 then
            u29:Disconnect();
        end;
        u6:Destroy();
        table.clear(u14.CurrentDisplays);
        table.clear(u14);
    end;
    return u14;
end;
return v1;
