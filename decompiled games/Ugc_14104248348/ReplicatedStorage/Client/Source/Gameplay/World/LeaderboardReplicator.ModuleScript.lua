-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.LeaderboardReplicator
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local l__Players__2 = game:GetService("Players");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__3:Get("InterfaceHandler");
local u2 = l__Mince__3:Get("SelectInteractor");
local u3 = l__Mince__3:GetEvent("LeaderboardReplicate");
local u4 = {
    Tag = "Leaderboard",
    Cache = {},
    Leaderboards = {},
    UIS = {}
};
function u4.GetThumbnail(p5) --[[ Line: 22 ]]
    -- upvalues: u4 (copy), l__Players__2 (copy)
    if u4.Cache[p5] then
        return u4.Cache[p5];
    end;
    local v6 = l__Players__2:GetUserThumbnailAsync(p5, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48);
    u4.Cache[p5] = v6;
    return v6;
end;
function u4.UpdateLeaderboard(p7) --[[ Line: 31 ]]
    -- upvalues: l__Players__2 (copy)
    local v8 = p7.Rankings[1];
    if v8 then
        local v9 = l__Players__2:GetUserThumbnailAsync(v8[3], Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48);
        p7.Value.Text = v8[1];
        p7.LeaderImage.Image = v9;
    end;
end;
function u4.SetupLeaderboards() --[[ Line: 40 ]]
    -- upvalues: l__Mince__3 (copy), u4 (copy), u2 (copy), u3 (copy)
    l__Mince__3.SetupComponent(u4.Tag, function(p10) --[[ Line: 41 ]]
        -- upvalues: u4 (ref), u2 (ref)
        local l__Instance__4 = p10.Instance;
        local l__BoardGui__5 = l__Instance__4:WaitForChild("BoardGui");
        local v11 = l__Instance__4:GetAttribute("Name");
        local u12 = {
            Name = v11,
            HoverName = l__Instance__4:GetAttribute("ActualName") or v11,
            LeaderboardItems = {},
            Model = l__Instance__4,
            HitCollider = l__Instance__4.Board,
            Target = l__Instance__4,
            Value = l__BoardGui__5.Value,
            LeaderImage = l__BoardGui__5.Leader
        };
        l__BoardGui__5.Title.Text = u12.HoverName;
        u4.Leaderboards[v11] = u12;
        function u12.Interact(_, p13) --[[ Line: 64 ]]
            -- upvalues: u4 (ref), u12 (copy)
            p13();
            u4.PreviewLeaderboard(u12);
        end;
        u2.NewInteractionClass(u12);
    end);
    u3.Event:Connect(function(p14) --[[ Line: 73 ]]
        -- upvalues: u4 (ref)
        for _, v15 in p14 do
            local v16 = u4.Leaderboards[v15.Name];
            if v16 then
                v16.Rankings = v15.Rankings;
                u4.UpdateLeaderboard(v16);
            end;
        end;
    end);
end;
function u4.PreviewLeaderboard(p17) --[[ Line: 86 ]]
    -- upvalues: u2 (copy), u4 (copy), l__ReplicatedStorage__1 (copy)
    if p17.Rankings then
        if u4.InProgress then
            return u2.EndInteractions();
        end;
        u4.InProgress = true;
        for _, v18 in u4.UIS do
            v18:Destroy();
        end;
        p17.LeaderboardItems = {};
        u4.Leaderboard:Switch();
        local l__TweenFrame__6 = u4.Leaderboard.TweenFrame;
        for v19, u20 in p17.Rankings do
            local u21 = l__ReplicatedStorage__1.Assets.Interface.LeaderboardItem:Clone();
            u21.LayoutOrder = v19;
            u21.PlayerName.Text = `@{u20[2]}`;
            u21.PlayerPosition.Text = `#{v19}`;
            u21.LeaderValue.Text = u20[1];
            u21.Parent = l__TweenFrame__6.Scroll;
            task.spawn(function() --[[ Line: 110 ]]
                -- upvalues: u21 (copy), u4 (ref), u20 (copy)
                u21.Thumbnail.Image = u4.GetThumbnail(u20[3]);
            end);
            table.insert(u4.UIS, u21);
        end;
        l__TweenFrame__6.Scroll.CanvasPosition = Vector2.zero;
        u4.InProgress = false;
    else
        u2.EndInteractions();
    end;
end;
function u4.SetupUI() --[[ Line: 123 ]]
    -- upvalues: u4 (copy), u1 (copy)
    u1.NewButton(u4.Leaderboard.TweenFrame.CloseButton).Activated:Connect(function() --[[ Line: 127 ]]
        -- upvalues: u4 (ref)
        u4.Leaderboard.Close();
    end);
end;
function u4.Setup() --[[ Line: 132 ]]
    -- upvalues: u4 (copy), u1 (copy)
    u4.Leaderboard = u1.Get("Leaderboard");
    u4.SetupLeaderboards();
    u4.SetupUI();
end;
return u4;
