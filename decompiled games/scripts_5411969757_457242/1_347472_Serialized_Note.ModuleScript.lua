-- Decompiled with Potassium's decompiler.

local v1 = Instance.new("TextLabel");
v1.Name = "Note";
v1.AutoLocalize = false;
v1.Localize = false;
v1.ZIndex = 10;
v1.Visible = false;
v1.Size = UDim2.new(0, 0, 0, 20);
v1.BorderColor3 = Color3.fromRGB(0, 0, 0);
v1.BackgroundTransparency = 1;
v1.BorderSizePixel = 0;
v1.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
v1.FontSize = 5;
v1.TextStrokeTransparency = 0.7;
v1.TextSize = 14;
v1.TextColor3 = Color3.fromRGB(255, 255, 255);
v1.Text = "";
v1.Font = 3;
local v2 = Instance.new("Frame");
v2.Name = "Back";
v2.ZIndex = 9;
v2.Size = UDim2.new(1, 0, 1, 0);
v2.BorderColor3 = Color3.fromRGB(0, 0, 0);
v2.BackgroundTransparency = 0.5;
v2.BorderSizePixel = 0;
v2.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
v2.Parent = v1;
return v1;