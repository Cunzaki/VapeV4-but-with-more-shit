-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.Settings
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Signal__2 = require(l__ReplicatedStorage__1.Modules.Signal);
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__3:Get("InterfaceHandler");
local u2 = l__Mince__3:Get("UserProfile");
local u3 = l__Mince__3:GetEvent("SaveSettings");
local u4 = {
    Listners = {}
};
function u4.ChangeSetting(p5, p6) --[[ Line: 16 ]]
    -- upvalues: u4 (copy), u3 (copy)
    local v7 = u4.SerializeSettings();
    v7[p5] = p6;
    u4.DeserializeSettings(v7);
    u3:Fire(v7);
end;
function u4.GetValue(p8) --[[ Line: 24 ]]
    -- upvalues: u4 (copy), l__Mince__3 (copy)
    while not u4.SettingsRetrived do
        task.wait();
    end;
    for _, v9 in ipairs(l__Mince__3.Config.Settings.Objects) do
        if v9.Identifer == p8 then
            return v9.Value;
        end;
    end;
    return l__Mince__3.Config.LocalProfile.Settings[p8];
end;
function u4.SerializeSettings() --[[ Line: 36 ]]
    -- upvalues: l__Mince__3 (copy)
    local v10 = {};
    for _, v11 in ipairs(l__Mince__3.Config.Settings.Objects) do
        if v11.Scope ~= "Session" then
            v10[v11.Identifer] = v11.Value;
        end;
    end;
    return v10;
end;
function u4.DeserializeSettings(p12) --[[ Line: 45 ]]
    -- upvalues: l__Mince__3 (copy), u4 (copy)
    for v13, v14 in p12 do
        local v15 = nil;
        for _, v16 in l__Mince__3.Config.Settings.Objects do
            if v16.Identifer == v13 then
                v15 = v16;
            end;
        end;
        if v15 and v15.Change then
            v15.Change:Fire(v14);
        end;
    end;
    u4.SettingsRetrived = true;
end;
function u4.SettingChanged(p17) --[[ Line: 63 ]]
    -- upvalues: u4 (copy), l__Signal__2 (copy)
    local v18 = u4.Listners[p17];
    if not v18 then
        v18 = l__Signal__2.new();
        u4.Listners[p17] = v18;
    end;
    return v18;
end;
function u4.ChangedSignal(p19) --[[ Line: 72 ]]
    -- upvalues: u4 (copy)
    u4.SettingChanged(p19.Identifer):Fire(p19.Value);
end;
function u4.SetupSettings() --[[ Line: 76 ]]
    -- upvalues: u4 (copy), l__Mince__3 (copy), l__ReplicatedStorage__1 (copy), l__Signal__2 (copy), u1 (copy)
    local l__Settings__4 = u4.Settings;
    for _, u20 in ipairs(l__Mince__3.Config.Settings.Objects) do
        local v21 = l__ReplicatedStorage__1.Assets.Interface.SetItem:Clone();
        v21.Parent = l__Settings__4.TweenFrame.Scroll.ScrollingFrame;
        v21.SettingName.Text = u20.Name;
        v21.Visible = not u20.Hidden;
        u20.Change = l__Signal__2.new();
        if u20.Type == "Buttons" then
            local u22 = l__ReplicatedStorage__1.Assets.Interface.SetButtons.Button:Clone();
            u22.Parent = v21;
            local u23 = 0;
            local function v25() --[[ Line: 91 ]]
                -- upvalues: u23 (ref), u20 (copy), u22 (copy), u4 (ref)
                u23 = u23 + 1;
                if u23 > #u20.Buttons then
                    u23 = 1;
                end;
                local v24 = u20.Buttons[u23];
                u22.Text = v24.Text;
                u20.Value = v24.Value;
                u4.ChangedSignal(u20);
            end;
            u1.NewButton(u22).Activated:Connect(v25);
            u23 = u23 + 1;
            u23 = #u20.Buttons < u23 and 1 or u23;
            local v26 = u20.Buttons[u23];
            u22.Text = v26.Text;
            u20.Value = v26.Value;
            u4.ChangedSignal(u20);
            u20.Change:Connect(function(p27) --[[ Line: 108 ]]
                -- upvalues: u20 (copy), u22 (copy), u23 (ref), u4 (ref)
                for v28, v29 in ipairs(u20.Buttons) do
                    if v29.Value == p27 then
                        u22.Text = v29.Text;
                        u20.Value = p27;
                        u23 = v28;
                        u4.ChangedSignal(u20);
                    end;
                end;
            end);
        end;
        if u20.Type == "Slider" then
            local v30 = l__ReplicatedStorage__1.Assets.Interface.SetButtons.Slider:Clone();
            v30.Parent = v21;
            local u31 = u1.NewSlider(v30);
            if u20.Default then
                u31.SetPosition(u20.Default);
            end;
            u31.Changed:Connect(function(p32) --[[ Line: 133 ]]
                -- upvalues: u20 (copy), u4 (ref)
                u20.Value = p32;
                u4.ChangedSignal(u20);
            end);
            u20.Change:Connect(function(p33) --[[ Line: 139 ]]
                -- upvalues: u20 (copy), u31 (copy), u4 (ref)
                u20.Value = p33;
                u31.SetPosition(p33);
                u4.ChangedSignal(u20);
            end);
        end;
    end;
end;
function u4.__SetupButtons() --[[ Line: 151 ]]
    -- upvalues: u4 (copy), u1 (copy), u3 (copy)
    local _ = u4.SettingsUI;
    u1.NewButton(u4.Settings.TweenFrame.CloseButton).Activated:Connect(function() --[[ Line: 155 ]]
        -- upvalues: u3 (ref), u4 (ref)
        u3:Fire(u4.SerializeSettings());
        u4.Settings:Close();
    end);
end;
function u4.Trigger() --[[ Line: 162 ]]
    -- upvalues: u4 (copy)
    u4.Settings.Trigger();
end;
function u4.Setup() --[[ Line: 167 ]]
    -- upvalues: u4 (copy), u1 (copy), u2 (copy)
    u4.Settings = u1.Get("Settings");
    u4.SetupSettings();
    u4.__SetupButtons();
    u2.IndexUpdated("Settings"):Connect(u4.DeserializeSettings);
end;
return u4;
