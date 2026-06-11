-- Decompiled from: .ChillArrow26.PlayerGui.FTHUD.HUD.newMenuController
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local v2 = setmetatable({}, {
    __index = function(_, p1) --[[ Name: __index, Line 1 ]]
        return game:GetService(p1);
    end
});
local l__UserInputService__1 = v2.UserInputService;
local l__Players__2 = v2.Players;
local _ = v2.TweenService;
local l__TextService__3 = v2.TextService;
local l__LocalPlayer__4 = l__Players__2.LocalPlayer;
local u3 = pairs;
local l__new__5 = UDim2.new;
local l__insert__6 = table.insert;
local l__Parent__7 = script.Parent;
local l__Button__8 = l__Parent__7:WaitForChild("MenuButton"):WaitForChild("Button");
local l__MenuButtons__9 = l__Parent__7:WaitForChild("MenuButtons");
local l__Frames__10 = script.Parent:WaitForChild("Frames");
local l__Container__11 = l__Frames__10:WaitForChild("Container");
local u4 = false;
l__MenuButtons__9:FindFirstChild("AdminPanel");
local l__FTPStorage__12 = v2.ReplicatedStorage:WaitForChild("FTPStorage");
local l__UI__13 = l__FTPStorage__12:WaitForChild("UI");
local l__Cache__14 = l__FTPStorage__12:WaitForChild("Cache");
v2.ReplicatedStorage:WaitForChild("MouseoverEffect", 300);
l__MenuButtons__9:GetChildren();
local u5 = {};
local u6 = "AdminPanel";
local u7 = "";
local u8 = {};
local v9 = Instance.new("BlurEffect", workspace.CurrentCamera);
v9.Size = 0;
local v10 = TweenInfo.new(1);
local l__new__15 = Vector2.new;
local u11 = game:GetService("TweenService"):Create(v9, v10, {
    Size = 0
});
local u12 = game:GetService("TweenService"):Create(v9, v10, {
    Size = 15
});
local l__MenuToggleKey__16 = l__LocalPlayer__4:WaitForChild("MenuToggleKey");
local function u15(p13) --[[ Line: 51 ]]
    for _, v14 in pairs(p13) do
        v14:disconnect();
    end;
    return {};
end;
local function u20() --[[ Line: 68 ]]
    -- upvalues: l__MenuButtons__9 (copy), l__new__15 (copy), l__TextService__3 (copy), l__new__5 (copy)
    for _, v16 in pairs(l__MenuButtons__9:GetChildren()) do
        if v16:IsA("ImageButton") and v16:FindFirstChildOfClass("TextLabel") then
            local l__Text__17 = v16:FindFirstChildOfClass("TextLabel").Text;
            local v17;
            if v16 == nil then
                v17 = nil;
            else
                local v18 = v16.AbsoluteSize.Y * 0.7;
                local v19 = l__new__15(l__MenuButtons__9.AbsoluteSize.X - 14, v18);
                v17 = l__TextService__3:GetTextSize(l__Text__17, v18, Enum.Font.SourceSans, v19);
            end;
            v16.Size = l__new__5(0, v17.X, 1, 0);
        end;
    end;
end;
local u21 = "";
local u22 = nil;
local function u47(p23, p24) --[[ Line: 81 ]]
    -- upvalues: u21 (ref), u22 (ref), u6 (ref), u3 (copy), l__Container__11 (copy), l__Cache__14 (copy), u5 (copy), l__UI__13 (copy), u8 (ref), u15 (copy), l__insert__6 (copy), l__new__5 (copy), u7 (ref)
    u21 = p23;
    u22 = nil;
    if p23 ~= nil and p23:len() >= 2 then
        u6 = p23;
    end;
    for _, u25 in u3(l__Container__11:GetChildren()) do
        for _, v26 in pairs(u25:WaitForChild("FrameContainer"):GetChildren()) do
            v26.Parent = l__Cache__14;
        end;
        if u25.Name == p23 then
            if u25.Name == "Settings" then
                local function u30() --[[ Line: 98 ]]
                    -- upvalues: u5 (ref), u25 (copy), l__Cache__14 (ref), l__UI__13 (ref)
                    local v27 = u5[u25.Name] or "ServerSettings";
                    local v28 = l__Cache__14:FindFirstChild(v27) or l__UI__13:FindFirstChild(v27);
                    if v28 ~= nil then
                        for _, v29 in pairs(u25:WaitForChild("FrameContainer"):GetChildren()) do
                            v29.Parent = l__Cache__14;
                        end;
                        v28.Parent = u25:WaitForChild("FrameContainer");
                    end;
                end;
                u8 = u15(u8);
                local l__Frame__18 = u25:WaitForChild("Botones"):WaitForChild("Frame");
                local u31 = l__Frame__18:FindFirstChildOfClass("UIPageLayout");
                u22 = u31;
                for _, u32 in pairs(l__Frame__18:GetChildren()) do
                    if u32:IsA("TextButton") then
                        l__insert__6(u8, (u32.MouseButton1Down:connect(function() --[[ Line: 127 ]]
                            -- upvalues: u31 (copy), u32 (copy)
                            u31:JumpTo(u32);
                        end)));
                    end;
                end;
                l__insert__6(u8, (u31:GetPropertyChangedSignal("CurrentPage"):connect(function() --[[ Line: 136 ]]
                    -- upvalues: u5 (ref), u25 (copy), u31 (copy), u30 (copy)
                    u5[u25.Name] = u31.CurrentPage.Name;
                    u30();
                end)));
                u30();
            elseif u25.Name == "AdminPanel" then
                local l__FrameContainer__19 = u25:WaitForChild("FrameContainer");
                local function u36() --[[ Line: 147 ]]
                    -- upvalues: u5 (ref), u25 (copy), l__Cache__14 (ref), l__UI__13 (ref), l__FrameContainer__19 (copy)
                    local v33 = u5[u25.Name] or "Maps";
                    local v34 = l__Cache__14:FindFirstChild(v33) or l__UI__13:FindFirstChild(v33);
                    if v34 ~= nil then
                        for _, v35 in pairs(u25:WaitForChild("FrameContainer"):GetChildren()) do
                            v35.Parent = l__Cache__14;
                        end;
                        v34.Parent = l__FrameContainer__19;
                    end;
                end;
                u8 = u15(u8);
                local l__Frame__20 = u25:WaitForChild("Botones"):WaitForChild("Frame"):WaitForChild("Frame");
                local u37 = l__Frame__20:FindFirstChildOfClass("UIPageLayout");
                u22 = u37;
                for _, u38 in pairs(l__Frame__20:GetChildren()) do
                    if u38:IsA("TextButton") then
                        l__insert__6(u8, (u38.MouseButton1Down:connect(function() --[[ Line: 176 ]]
                            -- upvalues: u37 (copy), u38 (copy)
                            u37:JumpTo(u38);
                        end)));
                    end;
                end;
                l__insert__6(u8, (u37:GetPropertyChangedSignal("CurrentPage"):connect(function() --[[ Line: 185 ]]
                    -- upvalues: u5 (ref), u25 (copy), u37 (copy), u36 (copy)
                    u5[u25.Name] = u37.CurrentPage.Name;
                    u36();
                end)));
                u36();
            elseif u25.Name == "DonateUs" then
                local l__FrameContainer__21 = u25:WaitForChild("FrameContainer");
                local function v42() --[[ Line: 195 ]]
                    -- upvalues: u5 (ref), u25 (copy), l__Cache__14 (ref), l__UI__13 (ref), l__FrameContainer__21 (copy)
                    local v39 = u5[u25.Name] or "Donor";
                    local v40 = l__Cache__14:FindFirstChild(v39) or l__UI__13:FindFirstChild(v39);
                    if v40 ~= nil then
                        for _, v41 in pairs(u25:WaitForChild("FrameContainer"):GetChildren()) do
                            v41.Parent = l__Cache__14;
                        end;
                        v40.Parent = l__FrameContainer__21;
                    end;
                end;
                u8 = u15(u8);
                v42();
            end;
            local v43 = p24 == true and 0 or 0.25;
            u25.Visible = true;
            u25:TweenPosition(l__new__5(0, 0, 0, 0), "Out", "Quad", v43, true);
            u7 = u25.Name;
        else
            local v44 = p23 == "" and 0 or 0.25;
            u25:TweenPosition(l__new__5(0, 0, 1, 0), "Out", "Quad", v44, true, function(p45) --[[ Line: 232 ]]
                -- upvalues: u25 (copy), l__Cache__14 (ref)
                if Enum.TweenStatus.Completed == p45 then
                    u25.Visible = false;
                    for _, v46 in pairs(u25:WaitForChild("FrameContainer"):GetChildren()) do
                        v46.Parent = l__Cache__14;
                    end;
                end;
            end);
        end;
    end;
end;
local function u48() --[[ Line: 245 ]]
    -- upvalues: u4 (ref), u11 (copy), u47 (copy), l__Frames__10 (copy), l__new__5 (copy), u12 (copy), u6 (ref)
    if u4 == true then
        u11:Play();
        u47("");
        u4 = not u4;
        l__Frames__10:TweenPosition(l__new__5(0, 0, 1, 0), "Out", "Quad", 0.25, true);
    else
        if u4 == false then
            u12:Play();
            u47(u6, true);
            u4 = not u4;
            l__Frames__10:TweenPosition(l__new__5(0, 0, 0, 0), "Out", "Quad", 0.25, true);
        end;
    end;
end;
local function u49() --[[ Line: 261 ]]
    -- upvalues: u4 (ref), l__MenuButtons__9 (copy), l__new__5 (copy)
    if u4 == true then
        l__MenuButtons__9:TweenPosition(l__new__5(0, 5, 1, -50), "Out", "Quad", 0.25, true);
    else
        l__MenuButtons__9:TweenPosition(l__new__5(-0.2, -5, 1, -50), "Out", "Quad", 0.25, true);
    end;
end;
l__MenuButtons__9:WaitForChild("AdminPanel").MouseButton1Down:connect(function() --[[ Line: 269 ]]
    -- upvalues: u47 (copy)
    u47("AdminPanel", false);
end);
l__MenuButtons__9:WaitForChild("Settings").MouseButton1Down:connect(function() --[[ Line: 273 ]]
    -- upvalues: u47 (copy)
    u47("Settings", false);
end);
l__MenuButtons__9:WaitForChild("Settings").MouseButton1Down:connect(function() --[[ Line: 277 ]]
    -- upvalues: u47 (copy)
    u47("Settings", false);
end);
l__MenuButtons__9:WaitForChild("Donor").MouseButton1Down:connect(function() --[[ Line: 281 ]]
    -- upvalues: u47 (copy)
    u47("DonateUs", false);
end);
l__UserInputService__1.InputBegan:connect(function(p50, p51) --[[ Line: 285 ]]
    -- upvalues: l__UserInputService__1 (copy), l__MenuToggleKey__16 (copy), u48 (copy), u49 (copy), u22 (ref)
    if p50.UserInputType == Enum.UserInputType.Keyboard and p51 == false then
        local l__KeyCode__22 = p50.KeyCode;
        if l__KeyCode__22 ~= nil and (l__KeyCode__22.Name ~= nil and l__UserInputService__1:GetFocusedTextBox() == nil) then
            if l__KeyCode__22.Name == l__MenuToggleKey__16.Value then
                u48();
                u49();
                return;
            end;
            if l__KeyCode__22.Name == "Q" and u22 ~= nil then
                u22:Previous();
                return;
            end;
            if l__KeyCode__22.Name == "E" and u22 ~= nil then
                u22:Next();
            end;
        end;
    end;
end);
local v52 = Instance.new("BindableEvent", l__LocalPlayer__4);
v52.Name = "ToggleMenuEvent";
v52.Event:Connect(function() --[[ Line: 304 ]]
    -- upvalues: u48 (copy), u49 (copy)
    u48();
    u49();
end);
l__Button__8.MouseButton1Click:connect(function() --[[ Line: 309 ]]
    -- upvalues: u48 (copy), u49 (copy)
    u48();
    u49();
end);
l__Parent__7:GetPropertyChangedSignal("AbsoluteSize"):connect(function() --[[ Line: 316 ]]
    -- upvalues: u20 (copy)
    u20();
end);
u4 = true;
u48();
u20();
u49();
