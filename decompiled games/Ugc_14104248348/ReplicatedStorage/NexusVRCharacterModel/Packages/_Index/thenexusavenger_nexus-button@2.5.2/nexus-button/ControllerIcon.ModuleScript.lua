-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_nexus-button@2.5.2.nexus-button.ControllerIcon
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    Xbox = {
        ButtonA = {
            Image = "rbxassetid://408444495",
            Size = Vector2.new(95, 95),
            Offset = Vector2.new(318, 416)
        },
        ButtonB = {
            Image = "rbxassetid://408444495",
            Size = Vector2.new(95, 95),
            Offset = Vector2.new(520, 522)
        },
        ButtonX = {
            Image = "rbxassetid://408444495",
            Size = Vector2.new(95, 95),
            Offset = Vector2.new(510, 416)
        },
        ButtonY = {
            Image = "rbxassetid://408444495",
            Size = Vector2.new(95, 95),
            Offset = Vector2.new(616, 318)
        },
        DPadUp = {
            Image = "rbxassetid://408444495",
            Size = Vector2.new(105, 105),
            Offset = Vector2.new(616, 530)
        },
        DPadDown = {
            Image = "rbxassetid://408444495",
            Size = Vector2.new(105, 105),
            Offset = Vector2.new(212, 522)
        },
        DPadLeft = {
            Image = "rbxassetid://408444495",
            Size = Vector2.new(105, 105),
            Offset = Vector2.new(318, 522)
        },
        DPadRight = {
            Image = "rbxassetid://408444495",
            Size = Vector2.new(105, 105),
            Offset = Vector2.new(212, 416)
        },
        ButtonSelect = {
            Image = "rbxassetid://408444495",
            Size = Vector2.new(95, 95),
            Offset = Vector2.new(424, 522)
        },
        ButtonLB = {
            Image = "rbxassetid://408444495",
            Size = Vector2.new(115, 64),
            Offset = Vector2.new(116, 628)
        },
        ButtonRB = {
            Image = "rbxassetid://408444495",
            Size = Vector2.new(115, 64),
            Offset = Vector2.new(0, 628)
        },
        ButtonLT = {
            Image = "rbxassetid://408444495",
            Size = Vector2.new(105, 115),
            Offset = Vector2.new(616, 0)
        },
        ButtonRT = {
            Image = "rbxassetid://408444495",
            Size = Vector2.new(105, 115),
            Offset = Vector2.new(616, 414)
        },
        ButtonLS = {
            Image = "rbxassetid://408444495",
            Size = Vector2.new(105, 105),
            Offset = Vector2.new(0, 522)
        },
        ButtonRS = {
            Image = "rbxassetid://408444495",
            Size = Vector2.new(105, 105),
            Offset = Vector2.new(0, 416)
        },
        Thumbstick1 = {
            Image = "rbxassetid://408444495",
            Size = Vector2.new(105, 105),
            Offset = Vector2.new(616, 116)
        },
        Thumbstick2 = {
            Image = "rbxassetid://408444495",
            Size = Vector2.new(105, 105),
            Offset = Vector2.new(106, 522)
        }
    },
    PlayStation = {
        ButtonCross = {
            Image = "rbxassetid://15530886548",
            Size = Vector2.new(58, 58),
            Offset = Vector2.new(0, 0)
        },
        ButtonCircle = {
            Image = "rbxassetid://15530886548",
            Size = Vector2.new(58, 58),
            Offset = Vector2.new(58, 0)
        },
        ButtonSquare = {
            Image = "rbxassetid://15530886548",
            Size = Vector2.new(58, 58),
            Offset = Vector2.new(116, 0)
        },
        ButtonTriangle = {
            Image = "rbxassetid://15530886548",
            Size = Vector2.new(58, 58),
            Offset = Vector2.new(0, 58)
        },
        ButtonL1 = {
            Image = "rbxassetid://15530886548",
            Size = Vector2.new(58, 58),
            Offset = Vector2.new(58, 58)
        },
        ButtonR1 = {
            Image = "rbxassetid://15530886548",
            Size = Vector2.new(58, 58),
            Offset = Vector2.new(116, 58)
        },
        ButtonL2 = {
            Image = "rbxassetid://15530886548",
            Size = Vector2.new(58, 58),
            Offset = Vector2.new(0, 116)
        },
        ButtonR2 = {
            Image = "rbxassetid://15530886548",
            Size = Vector2.new(58, 58),
            Offset = Vector2.new(58, 116)
        },
        ButtonTouchpad = {
            Image = "rbxassetid://15530886548",
            Size = Vector2.new(58, 58),
            Offset = Vector2.new(116, 116)
        }
    }
};
u1.Default = u1.Xbox;
u1.Default.ButtonL1 = u1.Xbox.ButtonLB;
u1.Default.ButtonR1 = u1.Xbox.ButtonRB;
u1.Default.ButtonL2 = u1.Xbox.ButtonLT;
u1.Default.ButtonR2 = u1.Xbox.ButtonRT;
u1.Default.ButtonL3 = u1.Xbox.ButtonLS;
u1.Default.ButtonR3 = u1.Xbox.ButtonRS;
local l__UserInputService__1 = game:GetService("UserInputService");
local l__NexusInstance__2 = require(script.Parent:WaitForChild("Packages"):WaitForChild("NexusInstance"));
local l__ThemedFrame__3 = require(script.Parent:WaitForChild("ThemedFrame"));
local l__SimpleWrappedInstance__4 = require(script.Parent:WaitForChild("SimpleWrappedInstance"));
local v2 = {};
v2.__index = v2;
setmetatable(v2, l__ThemedFrame__3);
local u3 = {};
function v2.ResolveImage(p4) --[[ Line: 188 ]]
    -- upvalues: l__UserInputService__1 (copy), u1 (copy), u3 (copy)
    local v5 = l__UserInputService__1:GetStringForKeyCode(p4);
    local v6 = l__UserInputService__1:GetImageForKeyCode(p4);
    for v7, v8 in u1 do
        if string.find(string.lower(v6), string.lower(v7)) and v8[v5] then
            return v8[v5];
        end;
    end;
    if u1.Default[v5] then
        return u1.Default[v5];
    end;
    if not u3[v5] then
        warn((`No override exists for {v5} (from {p4.Name}) with {v6}. Returning default image.`));
        u3[v5] = true;
    end;
    return {
        Image = v6,
        Size = Vector2.zero,
        Offset = Vector2.zero,
        Color = Color3.fromRGB(60, 60, 60)
    };
end;
function v2.__new(u9) --[[ Line: 221 ]]
    -- upvalues: l__ThemedFrame__3 (copy), l__UserInputService__1 (copy)
    l__ThemedFrame__3.__new(u9);
    u9.SubTheme = "GamepadIconBackground";
    u9:DisableChangeReplication("IconScale");
    u9.IconScale = 0.9;
    u9:DisableChangeReplication("Icon");
    u9:DisableChangeReplication("IconUIScale");
    u9:DisableChangeReplication("KeyCode");
    u9:DisableChangeReplication("EventConnections");
    u9.EventConnections = {};
    table.insert(u9.EventConnections, l__UserInputService__1.GamepadConnected:Connect(function() --[[ Line: 235 ]]
        -- upvalues: u9 (copy)
        u9:UpdateVisibility();
    end));
    table.insert(u9.EventConnections, l__UserInputService__1.GamepadDisconnected:Connect(function() --[[ Line: 238 ]]
        -- upvalues: u9 (copy)
        u9:UpdateVisibility();
    end));
    u9:DisableChangeReplication("IconVisible");
    u9.IconVisible = false;
    u9:UpdateVisibility();
end;
function v2.UpdateVisibility(p10) --[[ Line: 251 ]]
    -- upvalues: l__UserInputService__1 (copy)
    if p10.Icon then
        local v11 = #l__UserInputService__1:GetConnectedGamepads() ~= 0;
        p10.Visible = v11;
        p10.IconVisible = v11;
    else
        p10.Visible = false;
        p10.IconVisible = false;
    end;
end;
function v2.SetIcon(p12, p13) --[[ Line: 270 ]]
    if p13 == nil then
        p12.KeyCode = nil;
        if p12.Icon then
            p12.Icon:Destroy();
            p12.Icon = nil;
        end;
        p12:UpdateVisibility();
    else
        if type(p13) == "string" then
            p13 = Enum.KeyCode[p13];
        end;
        if p12.Icon then
            p12.Icon:Destroy();
        end;
        local v14 = p12.ResolveImage(p13);
        local v15 = Instance.new("ImageLabel");
        v15.BackgroundTransparency = 1;
        v15.AnchorPoint = Vector2.new(0.5, 0.5);
        v15.Position = UDim2.new(0.5, 0, 0.5, 0);
        if v14.Size.X > v14.Size.Y then
            v15.Size = UDim2.new(1, 0, v14.Size.Y / v14.Size.X, 0);
        elseif v14.Size.X < v14.Size.Y then
            v15.Size = UDim2.new(v14.Size.X / v14.Size.Y, 0, 1, 0);
        else
            v15.Size = UDim2.new(1, 0, 1, 0);
        end;
        v15.ZIndex = p12.ZIndex;
        v15.Image = v14.Image;
        v15.ImageRectSize = v14.Size;
        v15.ImageRectOffset = v14.Offset;
        v15.ImageColor3 = v14.Color or Color3.fromRGB(255, 255, 255);
        v15.Parent = p12:GetWrappedInstance();
        local v16 = Instance.new("UIScale");
        v16.Scale = p12.IconScale or 1;
        v16.Parent = v15;
        p12.IconUIScale = v16;
        p12.Icon = v15;
        p12.KeyCode = p13;
        p12:UpdateVisibility();
    end;
end;
function v2.SetScale(p17, p18) --[[ Line: 325 ]]
    p17.IconScale = p18;
    if p17.IconUIScale then
        p17.IconUIScale.Scale = p18;
    end;
end;
function v2.Destroy(p19) --[[ Line: 335 ]]
    -- upvalues: l__SimpleWrappedInstance__4 (copy)
    l__SimpleWrappedInstance__4.Destroy(p19);
    for _, v20 in p19.EventConnections do
        v20:Disconnect();
    end;
    p19.EventConnections = {};
end;
return l__NexusInstance__2.ToInstance(v2);
