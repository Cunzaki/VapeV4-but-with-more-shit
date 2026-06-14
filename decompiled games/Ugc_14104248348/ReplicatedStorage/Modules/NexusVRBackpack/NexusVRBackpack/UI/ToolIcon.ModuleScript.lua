-- Decompiled from: ReplicatedStorage.Modules.NexusVRBackpack.NexusVRBackpack.UI.ToolIcon
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
function u1.new(p2, p3, p4) --[[ Line: 24 ]]
    -- upvalues: u1 (copy)
    local v5 = {
        Focused = false,
        Players = game:GetService("Players"),
        TweenService = game:GetService("TweenService"),
        RelativePositionX = p3 * 0.8660254037844386 + 0.5,
        RelativePositionY = p4 * 0.75 + 0.5
    };
    setmetatable(v5, u1);
    local u6 = Instance.new("ImageLabel");
    u6.BackgroundTransparency = 1;
    u6.AnchorPoint = Vector2.new(0.5, 0.5);
    u6.Size = UDim2.new(0.9, 0, 0.9, 0);
    u6.Position = UDim2.new(v5.RelativePositionX, 0, v5.RelativePositionY, 0);
    u6.Image = "http://www.roblox.com/asset/?id=10708006436";
    u6.ImageColor3 = Color3.new(0.1, 0.1, 0.1);
    u6.ImageTransparency = 0.8;
    u6.Parent = p2;
    v5.Background = u6;
    local u7 = Instance.new("TextLabel");
    u7.BackgroundTransparency = 1;
    u7.AnchorPoint = Vector2.new(0.5, 0.5);
    u7.Position = UDim2.new(0.5, 0, 0.5, 0);
    u7.Size = UDim2.new(0.625, 0, 0.625, 0);
    u7.Font = Enum.Font.SourceSans;
    u7.TextColor3 = Color3.new(1, 1, 1);
    u7.Text = "";
    u7.TextSize = u6.AbsoluteSize.Y * 0.625 / 4;
    u7.TextWrapped = true;
    u7.Visible = false;
    u7.Parent = u6;
    v5.ToolText = u7;
    u6:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 60 ]]
        -- upvalues: u7 (copy), u6 (copy)
        u7.TextSize = u6.AbsoluteSize.Y * 0.625 / 4;
    end);
    local v8 = Instance.new("ImageLabel");
    v8.BackgroundTransparency = 1;
    v8.AnchorPoint = Vector2.new(0.5, 0.5);
    v8.Position = UDim2.new(0.5, 0, 0.5, 0);
    v8.Size = UDim2.new(0.625, 0, 0.625, 0);
    v8.Visible = false;
    v8.Parent = u6;
    v5.ToolImage = v8;
    return v5;
end;
function u1.UpdateColor(p9) --[[ Line: 80 ]]
    if p9.Tool then
        if p9.Tool.TextureId == "" then
            p9.ToolText.Visible = true;
            p9.ToolImage.Visible = false;
            p9.ToolText.Text = p9.Tool.Name;
        else
            p9.ToolText.Visible = false;
            p9.ToolImage.Visible = true;
            p9.ToolImage.Image = p9.Tool.TextureId;
        end;
    else
        p9.ToolText.Visible = false;
        p9.ToolImage.Visible = false;
    end;
    local v10 = Color3.new(0.1, 0.1, 0.1);
    local v11 = p9.Tool and 0.5 or 0.8;
    local v12 = p9.Tool and p9.Focused and UDim2.new(1.05, 0, 1.05, 0) or UDim2.new(0.9, 0, 0.9, 0);
    if p9.Tool then
        if p9.Players.LocalPlayer.Character and p9.Players.LocalPlayer.Character == p9.Tool.Parent then
            if p9.Focused then
                v10 = Color3.new(0.2, 1, 0.2);
            else
                v10 = Color3.new(0, 0.7, 0);
            end;
        elseif p9.Focused then
            v10 = Color3.new(0.2, 0.2, 0.2);
        end;
    end;
    p9.TweenService:Create(p9.Background, TweenInfo.new(0.1), {
        Size = v12,
        ImageColor3 = v10,
        ImageTransparency = v11
    }):Play();
end;
function u1.SetTool(u13, p14) --[[ Line: 126 ]]
    if p14 == u13.Tool then
    else
        u13.Tool = p14;
        if u13.ToolEvents then
            for _, v15 in u13.ToolEvents do
                v15:Disconnect();
            end;
            u13.ToolEvents = nil;
        end;
        u13:UpdateColor();
        if p14 then
            u13.ToolEvents = {};
            table.insert(u13.ToolEvents, p14.Changed:Connect(function(p16) --[[ Line: 142 ]]
                -- upvalues: u13 (copy)
                if p16 == "Name" or (p16 == "TextureId" or p16 == "Parent") then
                    u13:UpdateColor();
                end;
            end));
        end;
    end;
end;
function u1.SetFocused(p17, p18) --[[ Line: 151 ]]
    p17.Focused = p18;
    p17:UpdateColor();
end;
function u1.Destroy(p19) --[[ Line: 159 ]]
    p19.Background:Destroy();
    if p19.ToolEvents then
        for _, v20 in p19.ToolEvents do
            v20:Disconnect();
        end;
        p19.ToolEvents = nil;
    end;
end;
return u1;
