-- Decompiled from: .FTPStorage.UI.ServerSettings.Colores.Ctrl
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local _ = game.Players.LocalPlayer;
local u1 = script.Parent:FindFirstChild("Bindable") or Instance.new("BindableEvent", script.Parent);
u1.Name = "Bindable";
local l__OK__1 = script.Parent:WaitForChild("OK");
local l__Contenedor__2 = script.Parent:WaitForChild("Contenedor");
local u2 = false;
local u3 = nil;
local u4 = nil;
for _, u5 in pairs(l__Contenedor__2:GetChildren()) do
    if u5:IsA("TextButton") then
        u5.MouseButton1Down:connect(function() --[[ Line: 22 ]]
            -- upvalues: u2 (ref), u3 (ref), u5 (copy), l__OK__1 (copy)
            if u2 == true then
                u3 = u5.Name;
                if tostring(u3):lower() == "nil" then
                    l__OK__1:WaitForChild("Nombre").Text = "CANCEL";
                    l__OK__1:WaitForChild("Selected").Text = "";
                    return;
                end;
                l__OK__1:WaitForChild("Nombre").Text = "USE THIS COLOR";
                l__OK__1:WaitForChild("Selected").Text = tostring(u3);
            end;
        end);
    end;
end;
l__OK__1.MouseButton1Down:connect(function() --[[ Line: 37 ]]
    -- upvalues: u2 (ref), u1 (copy), u4 (ref), u3 (ref), l__OK__1 (copy)
    if u2 == true then
        u1:Fire(u4, u3);
        u2 = false;
        u4 = nil;
        u3 = nil;
        l__OK__1:WaitForChild("Selected").Text = "CANCEL";
        l__OK__1:WaitForChild("Selected").Text = "";
        script.Parent:TweenPosition(UDim2.new(2.5, 0, 0.4, 0), "Out", "Quad", 0.5, true);
    end;
end);
u1.Event:connect(function(p6) --[[ Line: 49 ]]
    -- upvalues: u2 (ref), u4 (ref)
    if (tostring(p6):lower() == "capture_red" or (tostring(p6):lower() == "capture_blue" or tostring(p6):lower() == "capture_lobby")) and u2 == false then
        u2 = true;
        u4 = tostring(p6);
        script.Parent:TweenPosition(UDim2.new(0.5, 0, 0.4, 0), "Out", "Quad", 0.5, true);
    end;
end);
