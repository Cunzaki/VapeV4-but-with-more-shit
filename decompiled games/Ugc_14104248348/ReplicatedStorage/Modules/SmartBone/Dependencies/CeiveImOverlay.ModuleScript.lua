-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.CeiveImOverlay
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__GuiService__1 = game:GetService("GuiService");
local u1 = Font.new("rbxasset://fonts/families/PressStart2P.json");
local u2 = {};
u2.__index = u2;
function u2.new(p3, p4, p5) --[[ Line: 22 ]]
    -- upvalues: l__GuiService__1 (copy), u2 (copy)
    local v6 = p5 == nil and true or p5;
    local v7 = UDim2.fromOffset(25, 5 + l__GuiService__1:GetGuiInset().Y);
    local v8 = UDim2.new(1, -25, 1, -5);
    local v9 = UDim2.fromOffset(0, 0);
    local v10 = UDim2.fromScale(1, 1);
    local v11 = setmetatable({}, u2);
    v11.DefaultY = p3 or 5;
    v11.TextSize = p4 or 11;
    v11.BackFrame = Instance.new("Frame");
    local l__BackFrame__2 = v11.BackFrame;
    if v6 then
        v9 = v7 or v9;
    end;
    l__BackFrame__2.Position = v9;
    local l__BackFrame__3 = v11.BackFrame;
    if v6 then
        v10 = v8 or v10;
    end;
    l__BackFrame__3.Size = v10;
    v11.BackFrame.Name = "BackFrame";
    v11.BackFrame.Transparency = 1;
    v11.ListLayout = Instance.new("UIListLayout");
    v11.ListLayout.Padding = UDim.new(0, 2);
    v11.ListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    v11.ListLayout.Parent = v11.BackFrame;
    v11.m_Indent = 0;
    v11.DidUpdate = false;
    v11.m_State = "";
    v11.m_PreviousState = "";
    v11.m_RenderGroup = {};
    v11.m_ItemPool = {};
    return v11;
end;
function u2.Begin(p12, p13, p14, p15) --[[ Line: 64 ]]
    if p13 and type(p13) == "string" then
        if p14 and typeof(p14) ~= "Color3" then
            warn("BackgroundColor should be a Color3", debug.traceback());
        elseif p15 and typeof(p15) ~= "Color3" then
            warn("TextColor should be a Color3", debug.traceback());
        else
            p12:Text(p13, p14, p15);
            p12.m_Indent = p12.m_Indent + 1;
        end;
    else
        warn("Expected text to ImOverlay::Begin", debug.traceback());
    end;
end;
function u2.End(p16) --[[ Line: 84 ]]
    if p16.m_Indent - 1 < 0 then
        error("Too many callbacks to ImOverlay::End");
    else
        p16.m_Indent = p16.m_Indent - 1;
    end;
end;
function u2.Text(p17, p18, p19, p20) --[[ Line: 93 ]]
    if p18 and type(p18) == "string" then
        if p19 and typeof(p19) ~= "Color3" then
            warn("BackgroundColor should be a Color3", debug.traceback());
        elseif p20 and typeof(p20) ~= "Color3" then
            warn("TextColor should be a Color3", debug.traceback());
        else
            local v21 = p19 or Color3.new();
            local v22 = p20 or Color3.new(1, 1, 1);
            table.insert(p17.m_RenderGroup, {
                Text = p18,
                TextColor = v22,
                BackgroundColor = v21,
                Indent = p17.m_Indent
            });
            p17.m_State = p17.m_State .. `{p18}|{v22}|{v21}|{p17.m_Indent}`;
        end;
    else
        warn("Expected text to ImOverlay::Text", debug.traceback());
    end;
end;
function u2.m_Pool(p23) --[[ Line: 122 ]]
    for _, v24 in p23.BackFrame:GetChildren() do
        if not v24:IsA("UIListLayout") and v24.Visible then
            v24.Visible = false;
            table.insert(p23.m_ItemPool, v24);
        end;
    end;
end;
function u2.m_Cleanup(p25) --[[ Line: 137 ]]
    p25.m_State = "";
    p25.m_Indent = 0;
    p25.m_RenderGroup = {};
end;
function u2.m_CreateLabel(p26, p27, p28, p29, p30) --[[ Line: 145 ]]
    -- upvalues: u1 (copy)
    local v31 = Instance.new("Frame");
    v31.Name = "Background";
    v31.AutomaticSize = Enum.AutomaticSize.XY;
    v31.BackgroundColor3 = p29;
    v31.BackgroundTransparency = 0.4;
    v31.BorderSizePixel = 0;
    local v32 = Instance.new("TextLabel");
    v32.Name = "TaskText";
    v32.FontFace = u1;
    v32.Text = p27;
    v32.TextColor3 = p28;
    v32.TextSize = p26.TextSize;
    v32.TextXAlignment = Enum.TextXAlignment.Left;
    v32.AutomaticSize = Enum.AutomaticSize.XY;
    v32.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    v32.BackgroundTransparency = 1;
    v32.Position = UDim2.fromOffset(p30 * 50, 0);
    v32.Size = UDim2.fromOffset(0, p26.DefaultY);
    v32.Parent = v31;
    local v33 = Instance.new("UIPadding");
    v33.Name = "UIPadding";
    v33.PaddingBottom = UDim.new(0, 2);
    v33.Parent = v32;
    local v34 = Instance.new("UIPadding");
    v34.Name = "UIPadding";
    v34.PaddingRight = UDim.new(0, 5);
    v34.PaddingLeft = UDim.new(0, 5);
    v34.Parent = v31;
    return v31;
end;
function u2.Render(p35) --[[ Line: 182 ]]
    if p35.m_State == "" then
        p35:m_Pool();
        p35:m_Cleanup();
        p35.DidUpdate = false;
    else
        p35.m_State = p35.m_State .. `{p35.DefaultY}|{p35.TextSize}`;
        if p35.m_State == p35.m_PreviousState then
            p35:m_Cleanup();
            p35.DidUpdate = false;
        else
            p35:m_Pool();
            p35.m_PreviousState = p35.m_State;
            p35.DidUpdate = true;
            for v36, v37 in p35.m_RenderGroup do
                if #p35.m_ItemPool == 0 then
                    local v38 = p35:m_CreateLabel(v37.Text, v37.TextColor, v37.BackgroundColor, v37.Indent);
                    v38.LayoutOrder = v36;
                    v38.Parent = p35.BackFrame;
                else
                    local v39 = table.remove(p35.m_ItemPool, #p35.m_ItemPool);
                    local l__TaskText__4 = v39.TaskText;
                    v39.LayoutOrder = v36;
                    v39.BackgroundColor3 = v37.BackgroundColor;
                    l__TaskText__4.Text = v37.Text;
                    l__TaskText__4.TextColor3 = v37.TextColor;
                    l__TaskText__4.Position = UDim2.fromOffset(50 * v37.Indent, 0);
                    v39.Visible = true;
                    v39.Parent = p35.BackFrame;
                end;
            end;
            p35:m_Cleanup();
        end;
    end;
end;
function u2.Destroy(p40) --[[ Line: 239 ]]
    p40.BackFrame:Destroy();
    setmetatable(p40, nil);
end;
return u2;
