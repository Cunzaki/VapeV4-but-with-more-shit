-- Decompiled from: ReplicatedStorage.Client.Class.BindManager
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local l__ContextActionService__3 = game:GetService("ContextActionService");
local l__UserInputService__4 = game:GetService("UserInputService");
local l__PlayerGui__5 = l__Players__1.LocalPlayer:WaitForChild("PlayerGui");
local l__Mince__6 = require(l__ReplicatedStorage__2.Modules.Mince);
local l__Signal__7 = require(l__ReplicatedStorage__2.Modules.Signal);
local l__EnumTo__8 = require(script.EnumTo);
local u1 = {
    CurrentMode = "Computer",
    ForceMobileJumpButton = true,
    Binds = {},
    Button = {
        Static = "rbxassetid://12091205581",
        Pressed = "rbxassetid://12095141051",
        BaseIconSize = 0.6,
        StaticColor = Color3.new(1, 1, 1),
        PressedColor = Color3.new(0, 0, 0),
        InteractingButton = {},
        ButtonAligments = {
            BottomRight = {
                Multiplier = -1,
                Position = Vector2.new(1, 1),
                Anchor = Vector2.new(1, 0.5)
            },
            TopRight = {
                Multiplier = Vector2.new(-1, 1),
                Position = Vector2.new(1, 0),
                Anchor = Vector2.new(1, 0)
            }
        },
        Stack = {}
    },
    ModeChanged = l__Signal__7.new(),
    Warn = warn,
    Throw = error
};
local u2 = {};
u2.__index = u2;
function u2.new(p3) --[[ Line: 64 ]]
    -- upvalues: u2 (copy)
    local v4 = setmetatable(p3, u2);
    v4:init();
    return v4;
end;
function u2.init(p5) --[[ Line: 70 ]]
    -- upvalues: l__Mince__6 (copy), l__ContextActionService__3 (copy), u1 (copy)
    p5.OnAction = l__Mince__6.Signal.new();
    l__ContextActionService__3:BindAction(p5.Name, u1.HandleAction, false, table.unpack(p5.Binds));
end;
function u2.GetPrimaryVisualObject(p6) --[[ Line: 75 ]]
    -- upvalues: u1 (copy)
    return p6.VisualObjects[u1.CurrentMode] or next(p6.VisualObjects);
end;
function u2.GetPrimaryString(p7) --[[ Line: 79 ]]
    -- upvalues: l__EnumTo__8 (copy), l__UserInputService__4 (copy)
    local v8 = p7:GetPrimaryKeyCode();
    return l__EnumTo__8.KeyCodeToTextMapping[v8] or l__UserInputService__4:GetStringForKeyCode(v8);
end;
function u2.GetPrimaryKeyCode(p9) --[[ Line: 84 ]]
    -- upvalues: u1 (copy)
    return p9.BindsIndex[u1.CurrentMode] or p9.Binds[1];
end;
function u2.GetName(p10) --[[ Line: 88 ]]
    return p10.Config.BindFormattedText or p10.Name;
end;
function u1.SetMobileBindButtonsEnabled(p11, p12) --[[ Line: 92 ]]
    -- upvalues: u1 (copy)
    local v13 = u1.Get(p11);
    if v13 then
        for _, v14 in v13.Buttons do
            v14.Visible = p12;
            v14:SetAttribute("Visible", p12);
        end;
    end;
end;
function u1.Get(p15) --[[ Line: 102 ]]
    -- upvalues: u1 (copy)
    local v16 = u1.Binds[p15];
    if v16 then
        return v16;
    end;
    u1.Throw("There is no bind by the name of  " .. p15 .. ".");
end;
function u1.HandleAction(p17, p18, p19) --[[ Line: 112 ]]
    -- upvalues: u1 (copy)
    local v20 = u1.Binds[p17];
    if v20 then
        v20.OnAction:FireImmediate(p18, p19);
        return Enum.ContextActionResult.Pass;
    else
        u1.Warn("Attemped to handle action for " .. p17 .. " but no bindstable was found.");
        return Enum.ContextActionResult.Pass;
    end;
end;
function u1.ForceMobileJumpButton(p21) --[[ Line: 124 ]]
    -- upvalues: l__UserInputService__4 (copy), u1 (copy)
    if l__UserInputService__4.TouchEnabled then
        if u1.MobileJumpButton then
            u1.MobileJumpButton.Visible = p21;
        end;
    end;
end;
function u1.CreateButtons(p22, u23, p24) --[[ Line: 137 ]]
    -- upvalues: u1 (copy)
    for _, v25 in p22.Buttons do
        local u26 = script.Button:Clone();
        u26.Name = ("%s.ScreenButton"):format(u23);
        local v27 = v25.Position or Vector2.new(0.5, 0.5);
        local v28 = u1.Button.ButtonAligments[v25.Align or "BottomRight"] or {};
        local v29 = v25.Name or "Button.Name";
        local v30 = v28.Position or Vector2.new(0, 0);
        local v31 = v28.Anchor or Vector2.new(0, 0);
        local v32 = v28.Multiplier or 1;
        local v33 = v25.Icon ~= nil;
        local v34 = v27 * v32;
        local v35 = u1.Button.BaseIconSize * (v25.IconSize or 1);
        if v33 then
            u26.Icon.Image = v25.Icon;
        end;
        u26.Icon.Size = UDim2.fromScale(v35, v35);
        u26.AnchorPoint = v31;
        u26.ButtonText.Text = v29;
        u26.Icon.Visible = v33;
        u26.ButtonText.Visible = not v33;
        u26.Position = UDim2.new(v30.X, v34.X, v30.Y, v34.Y);
        u26.Active = true;
        u26:SetAttribute("SyncWithJumpButton", v25.SyncWithJumpButton);
        u26.Visible = not p22.HideButtons;
        u26:SetAttribute("Visible", u26.Visible);
        local function u39(p36, p37) --[[ Line: 172 ]]
            -- upvalues: u1 (ref), u23 (copy), u26 (copy)
            local v38 = {
                Position = Vector2.new(p36, p37),
                UserInputState = Enum.UserInputState.End,
                UserInputType = Enum.UserInputType.Touch
            };
            u1.HandleAction(u23, v38.UserInputState, v38);
            u26.Image = u1.Button.Static;
            u26.ImageTransparency = 0.55;
            u26.Icon.ImageColor3 = u1.Button.StaticColor;
            u26.ButtonText.TextColor = BrickColor.new(u1.Button.StaticColor);
            u1.Button.InteractingButton = {};
        end;
        u26.MouseButton1Down:Connect(function(p40, p41) --[[ Line: 189 ]]
            -- upvalues: u1 (ref), u23 (copy), u39 (copy), u26 (copy)
            local v42 = {
                Position = Vector2.new(p40, p41),
                UserInputState = Enum.UserInputState.Begin,
                UserInputType = Enum.UserInputType.Touch
            };
            u1.HandleAction(u23, v42.UserInputState, v42);
            u1.Button.InteractingButton = {
                UserInputType = v42.UserInputType,
                Ending = u39
            };
            u26.Image = u1.Button.Pressed;
            u26.ImageTransparency = 0.77;
            u26.Icon.ImageColor3 = u1.Button.PressedColor;
            u26.ButtonText.TextColor = BrickColor.new(u1.Button.PressedColor);
        end);
        u26.MouseButton1Up:Connect(u39);
        table.insert(u1.Button.Stack, u26);
        table.insert(p24, u26);
    end;
    return p24;
end;
function u1.GenerateBinds() --[[ Line: 216 ]]
    -- upvalues: l__Mince__6 (copy), l__EnumTo__8 (copy), u1 (copy), u2 (copy), l__UserInputService__4 (copy), l__PlayerGui__5 (copy)
    for v43, v44 in pairs(l__Mince__6.Config.Binds) do
        local v45 = {};
        local v46 = {};
        for v47, v48 in pairs(v44.Binds) do
            table.insert(v45, v48);
            v46[v47] = l__EnumTo__8.GetObject(v48);
        end;
        local v49 = {};
        if v44.Buttons then
            u1.CreateButtons(v44, v43, v49);
        end;
        u1.Binds[v43] = u2.new({
            Name = v43,
            Binds = v45,
            Buttons = v49,
            BindsIndex = v44.Binds,
            Config = v44,
            VisualObjects = v46
        });
    end;
    if l__UserInputService__4.TouchEnabled then
        task.spawn(function() --[[ Line: 243 ]]
            -- upvalues: l__PlayerGui__5 (ref), u1 (ref)
            local l__TouchControlFrame__9 = l__PlayerGui__5:WaitForChild("TouchGui"):WaitForChild("TouchControlFrame");
            local l__JumpButton__10 = l__TouchControlFrame__9:WaitForChild("JumpButton");
            for _, u50 in u1.Button.Stack do
                u50.Parent = l__TouchControlFrame__9;
                u50:GetAttributeChangedSignal("Visible"):Connect(function() --[[ Line: 251 ]]
                    -- upvalues: l__JumpButton__10 (copy), u50 (copy)
                    if l__JumpButton__10.Visible or not u50:GetAttribute("SyncWithJumpButton") then
                        u50.Visible = u50:GetAttribute("Visible");
                    else
                        u50.Visible = false;
                    end;
                end);
            end;
            l__JumpButton__10:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 260 ]]
                -- upvalues: u1 (ref), l__JumpButton__10 (copy)
                if u1.ForceJumpButtonEnabled and l__JumpButton__10.Visible ~= true then
                    l__JumpButton__10.Visible = true;
                end;
                for _, v51 in u1.Button.Stack do
                    if v51:GetAttribute("SyncWithJumpButton") then
                        if v51:GetAttribute("Visible") then
                            v51.Visible = l__JumpButton__10.Visible;
                        else
                            v51.Visible = false;
                        end;
                    end;
                end;
            end);
            u1.MobileJumpButton = l__JumpButton__10;
        end);
    end;
end;
function u1.InputTypeChanged(p52) --[[ Line: 281 ]]
    -- upvalues: l__Mince__6 (copy), u1 (copy)
    local v53 = l__Mince__6.Config.InputMatch[p52] or "Ignore";
    if v53 ~= "Ignore" and u1.CurrentMode ~= v53 then
        warn(("[BindManager]: Detected mode switched to %s."):format(v53));
        u1.CurrentMode = v53;
        u1.ModeChanged:Fire(u1.CurrentMode);
    end;
end;
function u1.InputEnded(p54) --[[ Line: 293 ]]
    -- upvalues: u1 (copy)
    if p54.UserInputType == u1.Button.InteractingButton.UserInputType then
        task.wait();
        u1.Button.InteractingButton.Ending(p54.Position.X, p54.Position.Y);
    end;
end;
function u1.WhenModeChanges(p55) --[[ Line: 300 ]]
    -- upvalues: u1 (copy)
    p55(u1.CurrentMode);
    u1.ModeChanged:Connect(p55);
end;
function u1.GetObject(p56) --[[ Line: 306 ]]
    -- upvalues: l__EnumTo__8 (copy)
    return l__EnumTo__8.GetObject(p56);
end;
function u1.GetMode() --[[ Line: 310 ]]
    -- upvalues: u1 (copy)
    return u1.CurrentMode;
end;
function u1.Init() --[[ Line: 315 ]]
    -- upvalues: u1 (copy), l__UserInputService__4 (copy)
    u1.GenerateBinds();
    if l__UserInputService__4.TouchEnabled then
        u1.CurrentMode = "Mobile";
    elseif l__UserInputService__4.VREnabled then
        u1.CurrentMode = "VR";
    elseif l__UserInputService__4.GamepadEnabled then
        u1.CurrentMode = "Console";
    end;
    l__UserInputService__4.LastInputTypeChanged:Connect(u1.InputTypeChanged);
    l__UserInputService__4.InputEnded:Connect(u1.InputEnded);
end;
u1.Init();
return u1;
