-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.VCList
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local l__Players__2 = game:GetService("Players");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__3:Get("InterfaceHandler");
local u2 = l__Mince__3:Get("VoiceChatHandler");
local u3 = l__Mince__3:Get("Settings");
local u4 = {
    PlayerVolumes = {},
    Interfaces = {}
};
function u4.CreatePlayerHandler(u5) --[[ Line: 18 ]]
    -- upvalues: u2 (copy), u4 (copy), l__ReplicatedStorage__1 (copy), u1 (copy)
    local v6 = u2.GetPlayerGraph(u5);
    local _ = u4.PlayerVolumes[u5.UserId];
    local u7 = v6:GetAudioInstance("PlayerVolume") or v6:CreateModifier("Fader", {
        Name = "PlayerVolume"
    });
    local v8 = l__ReplicatedStorage__1.Assets.Interface.VCPlayerItem:Clone();
    v8.Parent = u4.Interface.TweenFrame.Scroll;
    v8.Username.Text = `@{u5.Name}`;
    v8.DisplayName.Text = u5.DisplayName;
    v8.Thumbnail.Image = `https://www.roblox.com/headshot-thumbnail/image?userId={u5.UserId}&width=420&height=420&format=png`;
    u1.NewSlider(v8.Slider).Changed:Connect(function(p9) --[[ Line: 32 ]]
        -- upvalues: u4 (ref), u5 (copy), u7 (copy)
        u4.PlayerVolumes[u5.UserId] = p9 / 0.5;
        u7.Volume = p9 / 0.5;
    end);
    u4.Interfaces[u5] = v8;
end;
function u4.NewPlayer(p10) --[[ Line: 40 ]]
    -- upvalues: u4 (copy)
    if u4.PlayerVolumes[p10.UserId] then
    else
        u4.PlayerVolumes[p10.UserId] = 1;
    end;
end;
function u4.SetupUI() --[[ Line: 45 ]]
    -- upvalues: u1 (copy), u4 (copy)
    u1.NewButton(u4.Interface.TweenFrame.CloseButton).Activated:Connect(function() --[[ Line: 47 ]]
        -- upvalues: u4 (ref)
        u4.Interface.Close();
    end);
end;
function u4.Trigger() --[[ Line: 52 ]]
    -- upvalues: l__Players__2 (copy), u4 (copy)
    for _, v11 in l__Players__2:GetPlayers() do
        u4.CreatePlayerHandler(v11);
    end;
    local u13 = l__Players__2.PlayerRemoving:Connect(function(p12) --[[ Line: 57 ]]
        -- upvalues: u4 (ref)
        u4.Interfaces[p12]:Destroy();
    end);
    local u15 = l__Players__2.PlayerAdded:Connect(function(p14) --[[ Line: 60 ]]
        -- upvalues: u4 (ref)
        u4.CreatePlayerHandler(p14);
    end);
    u4.Interface.Trigger();
    local u16 = nil;
    u16 = u4.Interface.Closed:Connect(function() --[[ Line: 67 ]]
        -- upvalues: u4 (ref), u13 (copy), u15 (copy), u16 (ref)
        for _, v17 in u4.Interfaces do
            v17:Destroy();
        end;
        u13:Disconnect();
        u15:Disconnect();
        u16:Disconnect();
    end);
end;
function u4.Setup() --[[ Line: 78 ]]
    -- upvalues: u4 (copy), u1 (copy), l__Players__2 (copy), u3 (copy)
    u4.Interface = u1.Get("VCList");
    u4.SetupUI();
    l__Players__2.PlayerAdded:Connect(u4.NewPlayer);
    u3.SettingChanged("PlayerVolume"):Connect(function(p18) --[[ Line: 84 ]]
        -- upvalues: u4 (ref), u3 (ref)
        if p18 then
            u4.Trigger();
            u3.ChangeSetting("PlayerVolume", false);
        end;
    end);
end;
return u4;
