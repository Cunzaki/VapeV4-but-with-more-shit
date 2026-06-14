-- Decompiled from: ReplicatedStorage.Assets.Polaroid.Interface
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__StarterGui__2 = game:GetService("StarterGui");
local l__UserInputService__3 = game:GetService("UserInputService");
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Signal__5 = require(l__ReplicatedStorage__1.Modules.Signal);
local u1 = l__Mince__4:Get("InterfaceHandler");
local u2 = {
    ButtonInactive = Color3.fromRGB(97, 92, 92),
    ButtonActive = Color3.fromRGB(0, 187, 255)
};
local u3 = {};
u3.__index = u3;
function u3.Close(p4) --[[ Line: 22 ]]
    p4.MenuFrame.Visible = false;
end;
function u3.Open(p5) --[[ Line: 26 ]]
    p5.MenuFrame.Visible = true;
end;
function u2.MakeMenu(_, p6, p7, p8, p9, p10) --[[ Line: 30 ]]
    -- upvalues: u3 (copy), l__Signal__5 (copy), u1 (copy), l__ReplicatedStorage__1 (copy)
    local u11 = setmetatable({}, u3);
    u11.Type = p6;
    u11.ValueChanged = l__Signal__5.new();
    u11.Connections = {};
    u11.MenuFrame = p8;
    p8.Content.Options.Visible = p6 == "Options";
    p8.Content.Slider.Visible = p6 == "Slider";
    p8.Title.Text = p7;
    p8.Visible = false;
    if p6 ~= "Slider" then
        for _, u12 in ipairs(p9) do
            local v13 = p10 and l__ReplicatedStorage__1.Assets.Interface.PolaroidMenuItems.LongMenuButton:Clone() or l__ReplicatedStorage__1.Assets.Interface.PolaroidMenuItems.ShortMenuButton:Clone();
            local v14 = u1.NewButton(v13);
            v13.ImageLabel.Image = u12.Image;
            v13.ImageLabel.TextLabel.Text = u12.Text;
            v13.Parent = p8.Content.Options;
            local v15 = v14.Activated:Connect(function() --[[ Line: 61 ]]
                -- upvalues: u11 (copy), u12 (copy)
                u11.ValueChanged:Fire(u12.Value);
            end);
            table.insert(u11.Connections, v15);
        end;
        return u11;
    end;
    local v17 = u1.NewSlider(p8.Content.Slider).Changed:Connect(function(p16) --[[ Line: 46 ]]
        -- upvalues: u11 (copy)
        u11.ValueChanged:Fire(p16);
    end);
    table.insert(u11.Connections, v17);
    return u11;
end;
function u2.MakeToggleButton(_, p18) --[[ Line: 72 ]]
    -- upvalues: u1 (copy), l__Signal__5 (copy), u2 (copy)
    local u19 = u1.NewButton(p18);
    local u20 = {
        Activated = l__Signal__5.new()
    };
    u20.Activated:Fire(u19.BackgroundColor3 == u2.ButtonActive);
    u19.Activated:Connect(function() --[[ Line: 80 ]]
        -- upvalues: u19 (copy), u2 (ref), u20 (copy)
        local v21 = u19.BackgroundColor3 == u2.ButtonInactive;
        u19.BackgroundColor3 = v21 and u2.ButtonActive or u2.ButtonInactive;
        u20.Activated:Fire(v21);
    end);
    return u20;
end;
function u2.MakeMenuButton(u22, p23, p24, p25, p26) --[[ Line: 90 ]]
    local v27 = u22.ControlsFrame.Menu:Clone();
    local u28 = u22:MakeMenu(p24, p25, v27, p26);
    v27.Parent = u22.ControlsFrame;
    u22:MakeToggleButton(p23).Activated:Connect(function(p29) --[[ Line: 96 ]]
        -- upvalues: u22 (copy), u28 (copy)
        if u22.CurrentMenu then
            u22.CurrentMenu:Close();
            u22.CurrentMenu = nil;
        end;
        if p29 then
            u28:Open();
            u22.CurrentMenu = u28;
        end;
    end);
    return u28;
end;
function u2.SetAllGuiEnabled(p30, p31) --[[ Line: 111 ]]
    -- upvalues: l__StarterGui__2 (copy), l__UserInputService__3 (copy)
    if p30.UIHidden and not p31 then
    else
        l__StarterGui__2:SetCoreGuiEnabled(Enum.CoreGuiType.All, p31);
        l__UserInputService__3.MouseIconEnabled = p31;
        if p31 then
            if p30.UIHidden then
                p30.UIHidden = false;
                for _, v32 in p30.VisibleElements do
                    v32.Enabled = true;
                end;
            end;
        else
            p30.VisibleElements = {};
            for _, v33 in game.Players.LocalPlayer.PlayerGui:GetChildren() do
                if v33:IsA("ScreenGui") and v33.Enabled then
                    table.insert(p30.VisibleElements, v33);
                    v33.Enabled = false;
                end;
            end;
            p30.UIHidden = true;
        end;
    end;
end;
function u2.Init(p34) --[[ Line: 137 ]]
    -- upvalues: u1 (copy)
    p34.ScreenGui = u1.GetScreenGui("Polaroid");
    p34.PolaroidModal = u1.Get("Polaroid", "PostEdit");
    p34.PostEditFrame = p34.ScreenGui.PostEdit;
    p34.ControlsFrame = p34.ScreenGui.CameraControls;
    p34.ImagePreview = p34.ScreenGui.Corkboard;
end;
return u2;
