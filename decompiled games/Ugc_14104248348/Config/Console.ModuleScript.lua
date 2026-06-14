-- Decompiled from: Config.Console
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

client = nil;
Pcall = nil;
Routine = nil;
service = nil;
gTable = nil;
return function(_, p1) --[[ Line: 10 ]]
    if p1 then
        setfenv(1, p1);
    end;
    local l__LocalPlayer__1 = service.Players.LocalPlayer;
    local l__PlayerGui__2 = l__LocalPlayer__1.PlayerGui;
    local l__UI__3 = client.UI;
    local l__Remote__4 = client.Remote;
    local l__Variables__5 = client.Variables;
    local l__Parent__6 = script.Parent.Parent;
    gTable.Name = "Console";
    gTable.CanKeepAlive = true;
    local l__Frame__7 = l__Parent__6.Frame;
    local l__TextBox__8 = l__Frame__7.TextBox;
    local l__ScrollingFrame__9 = l__Frame__7.ScrollingFrame;
    local l__PlayerList__10 = l__Frame__7.PlayerList;
    local l__Entry__11 = l__Parent__6.Entry;
    local v2 = l__Remote__4.Get("Setting", {
        "SplitKey",
        "ConsoleKeyCode",
        "BatchKey",
        "Prefix"
    });
    local l__SplitKey__12 = v2.SplitKey;
    local l__ConsoleKeyCode__13 = v2.ConsoleKeyCode;
    local l__BatchKey__14 = v2.BatchKey;
    local _ = v2.Prefix;
    local u3 = l__Remote__4.Get("FormattedCommands") or {};
    local u4 = false;
    local u5 = false;
    local u6 = false;
    local v7 = TweenInfo.new(0.15);
    local u8 = service.TweenService:Create(l__Frame__7, v7, {
        Size = UDim2.new(1, 0, 0, 140)
    });
    local u9 = service.TweenService:Create(l__Frame__7, v7, {
        Size = UDim2.new(1, 0, 0, 40)
    });
    local u10 = service.TweenService:Create(l__Frame__7, v7, {
        Position = UDim2.new(0, 0, 0, 0)
    });
    local u11 = service.TweenService:Create(l__Frame__7, v7, {
        Position = UDim2.new(0, 0, 0, -200)
    });
    l__Frame__7.TopBar.Size = UDim2.new(1, 0, 0, service.GuiService:GetGuiInset().Y);
    local function u15() --[[ Line: 58 ]]
        -- upvalues: l__UI__3 (copy)
        if l__UI__3.Get("Notif") then
            l__UI__3.Get("Notif", nil, true).Object.LABEL.Visible = true;
        end;
        local v12 = l__UI__3.Get("Chat", nil, true);
        if v12 then
            v12.Object.Drag.Visible = true;
        end;
        local v13 = l__UI__3.Get("PlayerList", nil, true);
        if v13 then
            v13.Object.Drag.Visible = true;
        end;
        local v14 = l__UI__3.Get("HintHolder", nil, true);
        if v14 then
            v14.Object.Frame.Visible = true;
        end;
    end;
    local function u19() --[[ Line: 76 ]]
        -- upvalues: l__UI__3 (copy)
        if l__UI__3.Get("Notif") then
            l__UI__3.Get("Notif", nil, true).Object.LABEL.Visible = false;
        end;
        local v16 = l__UI__3.Get("Chat", nil, true);
        if v16 then
            v16.Object.Drag.Visible = false;
        end;
        local v17 = l__UI__3.Get("PlayerList", nil, true);
        if v17 then
            v17.Object.Drag.Visible = false;
        end;
        local v18 = l__UI__3.Get("HintHolder", nil, true);
        if v18 then
            v18.Object.Frame.Visible = false;
        end;
    end;
    l__Frame__7.Position = UDim2.fromOffset(0, -200);
    l__Frame__7.Visible = false;
    l__Frame__7.Size = UDim2.new(1, 0, 0, 40);
    l__ScrollingFrame__9.Visible = false;
    if l__Variables__5.ConsoleOpen then
        if l__Variables__5.ChatEnabled then
            service.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true);
        end;
        if l__Variables__5.PlayerListEnabled then
            service.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true);
        end;
        u15();
    end;
    l__Variables__5.ChatEnabled = service.StarterGui:GetCoreGuiEnabled("Chat");
    l__Variables__5.PlayerListEnabled = service.StarterGui:GetCoreGuiEnabled("PlayerList");
    local function u20() --[[ Line: 114 ]]
        -- upvalues: l__Parent__6 (copy), u6 (ref), l__ScrollingFrame__9 (copy), l__Frame__7 (copy), l__PlayerList__10 (copy), u5 (ref), l__Variables__5 (copy), u15 (copy), u11 (copy), u4 (ref)
        if l__Parent__6:IsDescendantOf(game) and not u6 then
            u6 = true;
            l__ScrollingFrame__9:ClearAllChildren();
            l__ScrollingFrame__9.CanvasSize = UDim2.new(0, 0, 0, 0);
            l__ScrollingFrame__9.ScrollingEnabled = false;
            l__Frame__7.Size = UDim2.new(1, 0, 0, 40);
            l__ScrollingFrame__9.Visible = false;
            l__PlayerList__10.Visible = false;
            u5 = false;
            if l__Variables__5.ChatEnabled then
                service.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true);
            end;
            if l__Variables__5.PlayerListEnabled then
                service.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true);
            end;
            u15();
            u11:Play();
            u6 = false;
            u4 = false;
        end;
    end;
    local function u21() --[[ Line: 143 ]]
        -- upvalues: l__Parent__6 (copy), u6 (ref), l__Variables__5 (copy), l__ScrollingFrame__9 (copy), l__PlayerList__10 (copy), u19 (copy), u10 (copy), l__Frame__7 (copy), u5 (ref), l__TextBox__8 (copy), u4 (ref)
        if l__Parent__6:IsDescendantOf(game) and not u6 then
            u6 = true;
            l__Variables__5.ChatEnabled = service.StarterGui:GetCoreGuiEnabled("Chat");
            l__Variables__5.PlayerListEnabled = service.StarterGui:GetCoreGuiEnabled("PlayerList");
            service.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false);
            service.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
            l__ScrollingFrame__9.ScrollingEnabled = true;
            l__PlayerList__10.ScrollingEnabled = true;
            u19();
            u10:Play();
            l__Frame__7.Size = UDim2.new(1, 0, 0, 40);
            l__ScrollingFrame__9.Visible = false;
            l__PlayerList__10.Visible = false;
            u5 = false;
            l__TextBox__8.Text = "";
            l__Frame__7.Visible = true;
            l__Frame__7.Position = UDim2.new();
            l__TextBox__8:CaptureFocus();
            l__TextBox__8.Text = "";
            wait();
            l__TextBox__8.Text = "";
            u6 = false;
            u4 = true;
        end;
    end;
    local function u24(p22) --[[ Line: 176 ]]
        -- upvalues: l__PlayerGui__2 (copy), l__Parent__6 (copy)
        for _, v23 in ipairs(l__PlayerGui__2:GetGuiObjectsAtPosition(p22.X, p22.Y)) do
            if v23 == l__Parent__6 or v23 == l__Parent__6.Frame then
                return true;
            end;
        end;
        return false;
    end;
    l__TextBox__8.FocusLost:Connect(function(p25) --[[ Line: 183 ]]
        -- upvalues: l__TextBox__8 (copy), l__Remote__4 (copy), u20 (copy), u24 (copy), l__LocalPlayer__1 (copy)
        if p25 then
            if l__TextBox__8.Text ~= "" and string.len(l__TextBox__8.Text) > 1 then
                l__Remote__4.Send("ProcessCommand", l__TextBox__8.Text);
            end;
            u20();
        else
            if not u24(l__LocalPlayer__1:GetMouse()) then
                u20();
            end;
        end;
    end);
    l__TextBox__8:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 194 ]]
        -- upvalues: l__TextBox__8 (copy), u4 (ref), l__PlayerList__10 (copy), l__SplitKey__12 (copy), l__ScrollingFrame__9 (copy), l__BatchKey__14 (copy), u3 (copy), u5 (ref), u8 (copy), l__Entry__11 (copy), l__UI__3 (copy), l__Frame__7 (copy), u9 (copy)
        if l__TextBox__8.Text == "" or not u4 then
            if l__TextBox__8.Text == "" and u4 then
                u9:Play();
                l__ScrollingFrame__9.Visible = false;
                l__PlayerList__10.Visible = false;
                u5 = false;
                l__ScrollingFrame__9:ClearAllChildren();
                l__ScrollingFrame__9.CanvasSize = UDim2.new();
            end;
        else
            local l__Text__15 = l__TextBox__8.Text;
            local v26 = string.len(l__TextBox__8.Text);
            if string.sub(l__Text__15, v26) == "\t" then
                if l__PlayerList__10:FindFirstChild("Entry 0") then
                    local v27 = string.split(l__TextBox__8.Text, l__SplitKey__12);
                    v27[#v27] = nil;
                    local v28 = table.concat(v27, l__SplitKey__12);
                    if v28 ~= "" then
                        v28 = v28 .. l__SplitKey__12;
                    end;
                    l__TextBox__8.Text = v28 .. l__PlayerList__10["Entry 0"].Text .. " ";
                elseif l__ScrollingFrame__9:FindFirstChild("Entry 0") then
                    l__TextBox__8.Text = string.split(l__ScrollingFrame__9["Entry 0"].Text, "<")[1];
                end;
                l__TextBox__8.CursorPosition = string.len(l__TextBox__8.Text) + 1;
                l__TextBox__8.Text = string.gsub(l__TextBox__8.Text, "\t", "");
            end;
            l__ScrollingFrame__9:ClearAllChildren();
            l__PlayerList__10:ClearAllChildren();
            local l__Text__16 = l__TextBox__8.Text;
            local v29 = string.match(l__Text__16, (`.*{l__BatchKey__14}([^']+)`));
            if v29 then
                l__Text__16 = string.match(v29, "^%s*(.-)%s*$");
            end;
            local v30 = 0;
            local v31 = "";
            for _, v32 in u3 do
                local v33 = string.match(string.lower(l__Text__16), (`^(.-){l__SplitKey__12}`)) or string.lower(l__Text__16);
                local v34 = string.lower(v32);
                if string.sub(v34, 1, #l__Text__16) == string.lower(l__Text__16) or string.find(string.lower(v32), v33, 1, true) then
                    if not u5 then
                        u8:Play();
                        l__ScrollingFrame__9.Visible = true;
                        l__PlayerList__10.Visible = true;
                        u5 = true;
                    end;
                    local u35 = l__Entry__11:Clone();
                    u35.Visible = true;
                    u35.Parent = l__ScrollingFrame__9;
                    u35.Text = v32;
                    u35.Name = `Entry {v30}`;
                    u35.Position = UDim2.fromOffset(0, v30 * 20);
                    u35.MouseButton1Down:Connect(function() --[[ Line: 243 ]]
                        -- upvalues: l__TextBox__8 (ref), u35 (copy)
                        l__TextBox__8.Text = u35.Text;
                        l__TextBox__8:CaptureFocus();
                    end);
                    v30 = v30 + 1;
                    v31 = v32;
                end;
            end;
            local v36 = 0;
            local v37 = string.split(l__Text__16, l__SplitKey__12);
            if v30 > 0 and #v37 > 1 then
                local v38 = string.match(l__Text__16, (`.+{l__SplitKey__12}(.*)$`));
                local v39 = string.split(v31, l__SplitKey__12)[#v37];
                for _, u40 in l__UI__3.Autocomplete(v38, v39) do
                    local v41 = l__Entry__11:Clone();
                    v41.Text = u40;
                    v41.Name = `Entry {v36}`;
                    v41.TextXAlignment = "Right";
                    v41.Visible = true;
                    v41.Parent = l__PlayerList__10;
                    v41.Position = UDim2.new(0, 0, 0, v36 * 20);
                    v41.MouseButton1Down:Connect(function() --[[ Line: 266 ]]
                        -- upvalues: l__TextBox__8 (ref), l__SplitKey__12 (ref), u40 (copy)
                        local v42 = string.split(l__TextBox__8.Text, l__SplitKey__12);
                        v42[#v42] = nil;
                        local v43 = table.concat(v42, l__SplitKey__12);
                        if v43 ~= "" then
                            v43 = v43 .. l__SplitKey__12;
                        end;
                        l__TextBox__8.Text = v43 .. tostring(u40) .. " ";
                        l__TextBox__8.CursorPosition = #l__TextBox__8.Text + 1;
                        l__TextBox__8:CaptureFocus();
                    end);
                    v36 = v36 + 1;
                end;
            end;
            local v44 = l__Frame__7;
            local l__new__17 = UDim2.new;
            local v45 = math.max(v30, v36) * 20 + 40;
            v44.Size = l__new__17(1, 0, 0, (math.clamp(v45, 40, 140)));
            l__ScrollingFrame__9.CanvasSize = UDim2.fromOffset(0, v30 * 20);
        end;
    end);
    gTable.BindEvent(service.Events.ToggleConsole, function() --[[ Line: 297 ]]
        -- upvalues: u4 (ref), u20 (copy), u21 (copy), l__Variables__5 (copy)
        if u4 then
            u20();
        else
            u21();
        end;
        l__Variables__5.ConsoleOpen = u4;
    end);
    gTable.BindEvent(service.UserInputService.InputBegan, function(p46, p47) --[[ Line: 306 ]]
        -- upvalues: l__Variables__5 (copy), l__ConsoleKeyCode__13 (copy)
        if not service.UserInputService:GetFocusedTextBox() and (not p47 and rawequal(p46.UserInputType, Enum.UserInputType.Keyboard)) and p46.KeyCode.Name == (l__Variables__5.CustomConsoleKey or l__ConsoleKeyCode__13) then
            service.Events.ToggleConsole:Fire();
        end;
    end);
    gTable:Ready();
end;
