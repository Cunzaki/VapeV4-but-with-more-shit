-- Decompiled with Potassium's decompiler.

local v2 = setmetatable({}, {
    __index = function(_, p1) --[[ Name: __index, Line 1 ]]
        return game:GetService(p1);
    end
});
local v3 = v2.Players.LocalPlayer:GetMouse();
local l__UI__1 = v2.ReplicatedStorage:WaitForChild("FUTURETOPS_LOCAL_STORAGE"):WaitForChild("UI");
local l__Menu__2 = script.Parent:WaitForChild("Menu");
local l__Buttons__3 = l__Menu__2:WaitForChild("Buttons");
local l__Frames__4 = script.Parent:WaitForChild("Frames");
local l__Container__5 = l__Frames__4:WaitForChild("Container");
local _ = v2.TextService;
local u4 = pairs;
local l__new__6 = UDim2.new;
local u5 = false;
local l__MouseoverEffect__7 = v2.ReplicatedStorage:WaitForChild("MouseoverEffect", 300);
local l__FrameContainer__8 = l__Container__5:WaitForChild("AdminPanel"):WaitForChild("FrameContainer");
local l__UIPageLayout__9 = l__Container__5:WaitForChild("AdminPanel"):WaitForChild("Botones"):WaitForChild("Frame"):WaitForChild("UIPageLayout");
l__Container__5:WaitForChild("Settings"):WaitForChild("Botones"):WaitForChild("Frame"):WaitForChild("UIPageLayout");
l__MouseoverEffect__7:Fire("connect", l__Menu__2, 1, "Open/Close Menu [M]");
l__MouseoverEffect__7:Fire("connect", l__Buttons__3:WaitForChild("Admin"), 1, "Manage Server");
l__MouseoverEffect__7:Fire("connect", l__Buttons__3:WaitForChild("Settings"), 1, "Player/Server Settings");
l__MouseoverEffect__7:Fire("connect", l__Buttons__3:WaitForChild("Donors"), 1, "Donate us");
l__MouseoverEffect__7:Fire("connect", l__Buttons__3:WaitForChild("Game"), 1, "Game Settings");
l__MouseoverEffect__7:Fire("connect", l__Buttons__3:WaitForChild("GM"), 1, "Gamemode Settings");
local u6 = l__Buttons__3:GetChildren();
local u7 = {};
local u8 = "AdminPanel";
local u9 = "";
local function u22(p10, p11) --[[ Line: 43 ]]
    -- upvalues: u8 (ref), u4 (copy), l__Container__5 (copy), u7 (copy), l__UI__1 (copy), l__new__6 (copy), u9 (ref)
    if p10 ~= nil and p10:len() >= 2 then
        u8 = p10;
    end;
    for _, u12 in u4(l__Container__5:GetChildren()) do
        u12:WaitForChild("FrameContainer"):ClearAllChildren();
        if u12.Name == p10 then
            if u12.Name == "Settings" then
                local v13 = l__UI__1:FindFirstChild(u7[u12.Name] or "ServerSettings");
                if v13 ~= nil then
                    local v14 = v13:clone();
                    v14.Parent = u12:WaitForChild("FrameContainer");
                    local v15 = v14:FindFirstChildOfClass("LocalScript");
                    if v15 ~= nil then
                        v15.Disabled = false;
                    end;
                end;
            elseif u12.Name == "AdminPanel" then
                local v16 = l__UI__1:FindFirstChild(u7[u12.Name] or "Maps");
                if v16 ~= nil then
                    local v17 = v16:clone();
                    v17.Parent = u12:WaitForChild("FrameContainer");
                    local v18 = v17:FindFirstChildOfClass("LocalScript");
                    if v18 ~= nil then
                        v18.Disabled = false;
                    end;
                end;
            end;
            local v19 = p11 == true and 0 or 0.5;
            u12.Visible = true;
            u12:TweenPosition(l__new__6(0, 0, 0, 0), "Out", "Quad", v19, true);
            u9 = u12.Name;
        else
            local v20 = p10 == "" and 0 or 0.5;
            u12:TweenPosition(l__new__6(0, 0, 1, 0), "Out", "Quad", v20, true, function(p21) --[[ Line: 87 ]]
                -- upvalues: u12 (copy)
                if Enum.TweenStatus.Completed == p21 then
                    u12.Visible = false;
                    u12:WaitForChild("FrameContainer"):ClearAllChildren();
                end;
            end);
        end;
    end;
end;
local function u27() --[[ Line: 97 ]]
    -- upvalues: u5 (ref), u22 (copy), l__Frames__4 (copy), l__new__6 (copy), u6 (copy), u8 (ref)
    if u5 == true then
        u22("");
        u5 = not u5;
        l__Frames__4:TweenPosition(l__new__6(0, 0, 1, 0), "Out", "Quad", 0.5, true);
        for v23 = 1, #u6 do
            if u5 ~= false then
                return;
            end;
            local _ = v23 - 1;
            local v24 = u6[#u6 - v23 + 1];
            local l__X__10 = v24.Position.X;
            v24:TweenPosition(l__new__6(l__X__10.Scale, l__X__10.Offset, 1, 3), "Out", "Quad", 0.1, true);
            wait(0.05);
        end;
    else
        if u5 == false then
            u22(u8, true);
            u5 = not u5;
            l__Frames__4:TweenPosition(l__new__6(0, 0, 0, 0), "Out", "Quad", 0.5, true);
            for v25 = 1, #u6 do
                if u5 ~= true then
                    break;
                end;
                local _ = v25 - 1;
                local v26 = u6[v25];
                local l__X__11 = v26.Position.X;
                v26:TweenPosition(l__new__6(l__X__11.Scale, l__X__11.Offset, 0, 0), "Out", "Quad", 0.1, true);
                wait(0.05);
            end;
        end;
    end;
end;
l__Menu__2.MouseButton1Down:connect(function() --[[ Line: 133 ]]
    -- upvalues: u27 (copy)
    u27();
end);
v3.KeyDown:connect(function(p28) --[[ Line: 137 ]]
    -- upvalues: u27 (copy), u5 (ref), u9 (ref), l__UIPageLayout__9 (copy)
    if p28:lower() == "m" then
        u27();
    end;
    if u5 == true then
        if p28:lower() == "q" then
            if u9 == "AdminPanel" then
                l__UIPageLayout__9:Previous();
            end;
        elseif p28:lower() == "e" and u9 == "AdminPanel" then
            l__UIPageLayout__9:Next();
        end;
    end;
end);
l__Buttons__3:WaitForChild("Admin").MouseButton1Down:connect(function() --[[ Line: 157 ]]
    -- upvalues: u5 (ref), u8 (ref), u22 (copy)
    if u5 == true and u8 ~= "AdminPanel" then
        u22("AdminPanel");
    end;
end);
l__Buttons__3:WaitForChild("Settings").MouseButton1Down:connect(function() --[[ Line: 163 ]]
    -- upvalues: u5 (ref), u8 (ref), u22 (copy)
    if u5 == true and u8 ~= "Settings" then
        u22("Settings");
    end;
end);
local function u33() --[[ Line: 170 ]]
    -- upvalues: u7 (copy), l__FrameContainer__8 (copy), u5 (ref), l__UI__1 (copy)
    local v29 = u7.AdminPanel or "Maps";
    l__FrameContainer__8:ClearAllChildren();
    if u5 == true then
        local v30 = l__UI__1:FindFirstChild(v29);
        if v30 ~= nil then
            local v31 = v30:clone();
            v31.Parent = l__FrameContainer__8;
            local v32 = v31:FindFirstChildOfClass("LocalScript");
            if v32 ~= nil then
                v32.Disabled = false;
            end;
        end;
    end;
end;
for _, u34 in pairs(l__UIPageLayout__9.Parent:GetChildren()) do
    if u34:IsA("TextButton") then
        u34.MouseButton1Down:connect(function() --[[ Line: 191 ]]
            -- upvalues: l__UIPageLayout__9 (copy), u34 (copy)
            l__UIPageLayout__9:JumpTo(u34);
        end);
    end;
end;
l__UIPageLayout__9.Stopped:connect(function(p35) --[[ Line: 198 ]]
    -- upvalues: u7 (copy), u33 (copy)
    if p35 ~= nil then
        u7.AdminPanel = p35.Name;
        u33();
    end;
end);