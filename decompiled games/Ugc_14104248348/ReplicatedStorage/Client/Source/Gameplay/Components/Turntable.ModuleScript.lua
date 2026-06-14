-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Turntable
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("ContextActionService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local l__TweenService__2 = game:GetService("TweenService");
game:GetService("Players");
local l__MarketplaceService__3 = game:GetService("MarketplaceService");
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Audio__5 = require(l__ReplicatedStorage__1.Modules.Audio);
local u1 = l__Mince__4:Get("SelectInteractor");
local u2 = l__Mince__4:Get("InterfaceHandler");
local u3 = l__Mince__4:Get("RegionHandler");
local u4 = l__Mince__4:Get("Settings");
local u5 = l__Mince__4:Get("ConfirmPrompt");
local u6 = l__Mince__4:GetEvent("RequestSongTurntable");
local u7 = l__Mince__4:GetEvent("AllSongs");
local u8 = l__Mince__4:GetEvent("ReportSong");
local u9 = l__Mince__4.Component({
    Tag = "Turntable",
    Songs = {}
});
function u9.Construct(u10) --[[ Line: 41 ]]
    -- upvalues: u9 (copy), u3 (copy), l__TweenService__2 (copy), u4 (copy), u1 (copy)
    local v11 = {};
    local l__Turntable__6 = u10.Instance:WaitForChild("Turntable");
    local l__Body__7 = l__Turntable__6.Body;
    local l__RecordPlayerID__8 = u10.RecordPlayerID;
    v11.HoverName = "See queue";
    v11.Name = "See queue";
    v11.Model = u10.Instance;
    v11.HitCollider = l__Body__7;
    function v11.Interact(_, p12) --[[ Line: 52 ]]
        -- upvalues: u9 (ref), l__RecordPlayerID__8 (copy), l__Turntable__6 (copy)
        u9.CurrentID = l__RecordPlayerID__8;
        u9.CurrentTable = l__Turntable__6.Parent.AudioPlayer;
        u9.Interface.Trigger();
        u9.UpdateUI();
        p12();
    end;
    u3.GetPlayerRegionsChangedSignal(game.Players.LocalPlayer):Connect(function(p13) --[[ Line: 60 ]]
        -- upvalues: u9 (ref), l__TweenService__2 (ref), u10 (copy), u4 (ref)
        u9.InRegion = false;
        for _, v14 in p13 do
            if v14.Name == "Music Room" then
                u9.InRegion = true;
            end;
        end;
        if u9.InRegion then
            l__TweenService__2:Create(u10.Instance.AudioPlayer.Modifiers._MainVolume, TweenInfo.new(0.5), {
                Volume = (u4.GetValue("MusicVol") or 1) / 2
            }):Play();
        else
            l__TweenService__2:Create(u10.Instance.AudioPlayer.Modifiers._MainVolume, TweenInfo.new(0.5), {
                Volume = 0
            }):Play();
        end;
    end);
    u4.SettingChanged("MusicVol"):Connect(function(p15) --[[ Line: 75 ]]
        -- upvalues: u9 (ref), l__TweenService__2 (ref), u10 (copy)
        if u9.InRegion then
            l__TweenService__2:Create(u10.Instance.AudioPlayer.Modifiers._MainVolume, TweenInfo.new(0.5), {
                Volume = p15 / 2
            }):Play();
        end;
    end);
    u1.NewInteractionClass(v11);
end;
function u9.UpdateUI() --[[ Line: 84 ]]
    -- upvalues: u9 (copy), l__MarketplaceService__3 (copy)
    if u9.CurrentTable then
        local l__TweenFrame__9 = u9.Interface.TweenFrame;
        local v16 = string.split(u9.CurrentTable.AssetId, "rbxassetid://")[2];
        local u17 = tonumber(v16);
        local v18;
        if u17 then
            local v19;
            v19, v18 = pcall(function() --[[ Line: 30 ]]
                -- upvalues: l__MarketplaceService__3 (ref), u17 (copy)
                return l__MarketplaceService__3:GetProductInfoAsync(u17);
            end);
            if not v19 or (not v18 or v18.AssetTypeId ~= 3) then
                v18 = false;
            end;
        else
            v18 = false;
        end;
        if v18 then
            l__TweenFrame__9.TextLabel.Text = `Current Song: {v18.Name}`;
            for _, v20 in pairs(l__TweenFrame__9.Scroll:GetChildren()) do
                if v20:IsA("Frame") then
                    v20:Destroy();
                end;
            end;
            for v21, v22 in ipairs(u9.Songs) do
                local v23 = game.ReplicatedStorage.Assets.Interface.LeaderboardItem:Clone();
                v23.LeaderValue.Text = v22.SongData.Name;
                v23.PlayerName.Text = `{v22.Player.DisplayName}(@{v22.Player.Name})`;
                v23.PlayerPosition.Text = `#{v21}`;
                v23.Thumbnail.Image = `https://www.roblox.com/headshot-thumbnail/image?userId={v22.Player.UserId}&width=420&height=420&format=png`;
                v23.Parent = l__TweenFrame__9.Scroll;
                if v22.Playing then
                    l__TweenFrame__9.TextLabel.Text = `Current Song: {v22.SongData.Name} (Requested by @{v22.Player.Name})`;
                end;
            end;
        end;
    end;
end;
function u9.SetupListener() --[[ Line: 112 ]]
    -- upvalues: l__Audio__5 (copy)
    local v24 = l__Audio__5.NewGraph(Instance.new("AudioListener", game.Workspace.CurrentCamera));
    v24:ConnectConsumer(Instance.new("AudioDeviceOutput"));
    v24.ProducerInstance.AudioInteractionGroup = "VinylRoom";
end;
function u9.Setup() --[[ Line: 120 ]]
    -- upvalues: u9 (copy), u2 (copy), u7 (copy), u6 (copy), u5 (copy), u8 (copy)
    u9.Interface = u2.Get("RecordRoom");
    u7.Event:Connect(function(p25) --[[ Line: 123 ]]
        -- upvalues: u9 (ref)
        u9.Songs = p25;
        u9.UpdateUI();
    end);
    local l__TweenFrame__10 = u9.Interface.TweenFrame;
    local v26 = u2.NewButton(l__TweenFrame__10.TextBox.OkayButton);
    local v27 = u2.NewButton(l__TweenFrame__10.CloseButton);
    local v28 = u2.NewButton(l__TweenFrame__10.OkayButton);
    u9.SetupListener();
    v26.Activated:Connect(function() --[[ Line: 135 ]]
        -- upvalues: u6 (ref), u9 (ref), l__TweenFrame__10 (copy)
        u6:Fire(u9.CurrentID, l__TweenFrame__10.TextBox.TextBox.Text);
        l__TweenFrame__10.TextBox.TextBox.Text = "";
    end);
    v27.Activated:Connect(function() --[[ Line: 140 ]]
        -- upvalues: u9 (ref)
        u9.Interface:Close();
    end);
    v28.Activated:Connect(function() --[[ Line: 144 ]]
        -- upvalues: u5 (ref), u8 (ref), u9 (ref)
        u5.Display("Are you sure you want to report this song? False reports are bannable!", function() --[[ Line: 145 ]]
            -- upvalues: u8 (ref), u9 (ref)
            u8:Fire(u9.CurrentTable.AssetId);
        end);
    end);
end;
return u9;
