-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Debris__3 = game:GetService("Debris");
local l__TextService__4 = game:GetService("TextService");
l__Players__1.LocalPlayer:GetMouse();
local l__Server__5 = l__ReplicatedStorage__2:WaitForChild("FTPStorage"):WaitForChild("Remotes"):WaitForChild("Server");
local l__Big_framebase__6 = script:WaitForChild("Big_framebase");
local l__Mid_framebase__7 = script:WaitForChild("Mid_framebase");
script:WaitForChild("Separador");
local l__MainFrame__8 = script.Parent:WaitForChild("MainFrame");
local l__TextBase__9 = script:WaitForChild("TextBase");
local l__SoundEffect__10 = l__ReplicatedStorage__2:WaitForChild("SoundEffect");
local u1 = 0;
local function u6(p2, p3) --[[ Line: 52 ]]
    -- upvalues: l__MainFrame__8 (copy), l__TextService__4 (copy)
    local l__AbsoluteSize__11 = l__MainFrame__8.AbsoluteSize;
    local v4 = l__AbsoluteSize__11.Y * p3;
    local v5 = l__TextService__4:GetTextSize(p2.Text, v4 * 0.8, p2.Font, Vector2.new(l__AbsoluteSize__11.X, v4));
    p2.Size = UDim2.new(0, v5.X, p2.Size.Y.Scale, 0);
end;
local function u15(p7) --[[ Line: 63 ]]
    -- upvalues: l__SoundEffect__10 (copy), l__Big_framebase__6 (copy), l__Mid_framebase__7 (copy), u1 (ref), l__TextBase__9 (copy), u6 (copy), l__MainFrame__8 (copy), l__Debris__3 (copy)
    if typeof(p7) ~= "table" then
        return nil;
    end;
    l__SoundEffect__10:Fire("ServerNotify");
    for _, v8 in pairs(p7) do
        local v9 = v8[1] == 1 and l__Big_framebase__6:clone() or l__Mid_framebase__7:clone();
        v9:WaitForChild("Fondo");
        local l__Contain__12 = v9:WaitForChild("Contain");
        l__Contain__12:WaitForChild("UIListLayout");
        u1 = u1 + 1;
        v9.LayoutOrder = u1;
        for v10 = 1, #v8 - 1 do
            local v11 = v8[v10 + 1];
            local v12 = v11[1];
            local v13 = v11[2];
            local v14 = l__TextBase__9:clone();
            v14.Text = v12;
            v14.Font = v13 == 2 and Enum.Font.SourceSansBold or (v13 == 1 and Enum.Font.SourceSans or Enum.Font.SourceSansItalic);
            v14.LayoutOrder = v10;
            v14.Parent = l__Contain__12;
            u6(v14, v9.Size.Y.Scale);
        end;
        v9.Parent = l__MainFrame__8;
        l__Debris__3:AddItem(v9, 5);
    end;
end;
l__Server__5.OnClientEvent:connect(function(p16, ...) --[[ Line: 132 ]]
    -- upvalues: u15 (copy)
    local v17 = { ... };
    if tostring(p16) == "server_notify" then
        u15(v17[1]);
    end;
end);