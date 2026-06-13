-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.PlayerRewards
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__MarketplaceService__1 = game:GetService("MarketplaceService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local l__RunService__3 = game:GetService("RunService");
local l__LocalPlayer__4 = game:GetService("Players").LocalPlayer;
local l__Unify__5 = require(l__ReplicatedStorage__2.Modules.Unify);
local l__Mince__6 = require(l__ReplicatedStorage__2.Modules.Mince);
local u1 = l__Mince__6:Get("Level");
local u2 = l__Mince__6:Get("UserProfile");
local u3 = l__Mince__6:Get("InterfaceHandler");
local u4 = l__Mince__6:Get("SelectInteractor");
local u5 = l__Mince__6:GetEvent("SubmitPlayerReward");
local u6 = l__Mince__6.Component({
    Tag = "PlayerRewards",
    TimeElapsed = 0,
    UpdateRate = 0.5,
    Updators = {},
    CachedProductInfo = {}
});
function u6.Updators.StatCheck(p7) --[[ Line: 32 ]]
    -- upvalues: u2 (copy), l__Mince__6 (copy)
    u2:WaitUntilLoaded();
    return (l__Mince__6.Config.LocalProfile.Statistics[p7.StatRequirement[1]] or 0) / p7.StatRequirement[2];
end;
function u6.Updators.TimePlayed(p8) --[[ Line: 39 ]]
    -- upvalues: u2 (copy), l__LocalPlayer__4 (copy), l__Mince__6 (copy), l__Unify__5 (copy)
    u2:WaitUntilLoaded();
    if not l__LocalPlayer__4:GetAttribute("JoinedOn") then
        return false;
    end;
    local l__LocalProfile__7 = l__Mince__6.Config.LocalProfile;
    local v9 = l__Unify__5.GetStandardTimeFrom(l__LocalPlayer__4:GetAttribute("JoinedOn") or 0);
    return math.floor(l__LocalProfile__7.TotalPlayTime + v9) / p8.TimeRequired or 0;
end;
function u6.Updators.LevelCheck(p10) --[[ Line: 53 ]]
    -- upvalues: u2 (copy), u1 (copy)
    u2:WaitUntilLoaded();
    local v11 = u1.GetLevel(p10.LevelRequirement[1]);
    if v11 and v11.CurrentLevel then
        return v11.CurrentLevel / p10.LevelRequirement[2] or 0;
    end;
end;
function u6.ProductInfo(u12, u13, p14) --[[ Line: 65 ]]
    -- upvalues: u6 (copy), l__MarketplaceService__1 (copy)
    local v15 = p14 or 0;
    if v15 > 3 then
    elseif u6.CachedProductInfo[u12] then
        return u6.CachedProductInfo[u12];
    else
        local v16, v17 = pcall(function() --[[ Line: 75 ]]
            -- upvalues: l__MarketplaceService__1 (ref), u12 (copy), u13 (copy)
            return l__MarketplaceService__1:GetProductInfo(u12, u13);
        end);
        if v16 then
            u6.CachedProductInfo[u12] = v17;
            return v17;
        else
            task.wait(1);
            return u6.ProductInfo(u12, u13, v15 + 1);
        end;
    end;
end;
function u6.Construct(p18) --[[ Line: 88 ]]
    -- upvalues: u6 (copy), u4 (copy)
    p18.Target = p18.Instance;
    p18.HoverName = "Player Rewards";
    p18.HitCollider = p18.Instance.Board;
    function p18.Interact(_, p19) --[[ Line: 93 ]]
        -- upvalues: u6 (ref)
        p19();
        u6.Interface:Open();
    end;
    u4.NewInteractionClass(p18);
end;
function u6.InitPlayerReward(u20) --[[ Line: 100 ]]
    -- upvalues: u6 (copy), l__ReplicatedStorage__2 (copy), u3 (copy), u5 (copy)
    local u21 = u6.Updators[u20.Method or (u20.ID or "Default")];
    local v22 = `Update method missing for '{u20.Name}'`;
    assert(u21, v22);
    u20.IsCompleted = false;
    local u23 = l__ReplicatedStorage__2.Assets.Interface.PlayerReward:Clone();
    u20.Gui = u23;
    u23.LevelTitle.Text = u20.Name;
    u23.Descriptor.Text = u20.Description;
    u23.ProgressBar.Fill.Size = UDim2.fromScale(1, 1);
    u23.ProgressBar.CompleteLabel.Text = "Loading...";
    u23.Claim.Visible = false;
    u23.NoClaim.Visible = true;
    u23.Parent = u6.Interface.TweenFrame.Scroll.ScrollingFrame;
    u3.NewButton(u23.Claim).Activated:Connect(function() --[[ Line: 117 ]]
        -- upvalues: u5 (ref), u20 (copy)
        u5:Fire(u20.ID);
    end);
    if u20.ProductID then
        if u6.ProductInfo(u20.ProductID, Enum.InfoType.Asset).Remaining == 0 then
            u23.Visible = false;
        end;
        u23.Icon.Image = `http://www.roblox.com/asset-thumbnail/image?assetId={u20.ProductID}&width=420&height=420&format=png`;
    else
        local _ = u20.GivesItem;
    end;
    function u20.Update() --[[ Line: 132 ]]
        -- upvalues: u21 (copy), u20 (copy), u23 (copy)
        local v24 = u21(u20);
        if v24 and tonumber(v24) then
            local v25 = math.clamp(v24, 0, 1);
            u23.ProgressBar.Fill.Size = UDim2.fromScale(math.max(0.05, v25), 1);
            u23.ProgressBar.CompleteLabel.Text = `{math.floor(v25 * 10000) / 100}%`;
            if not u20.IsCompleted and v25 >= 1 then
                u20.IsCompleted = true;
                u23.NoClaim.Visible = false;
                u23.Claim.Visible = true;
                u23.ProgressBar.Fill.Size = UDim2.fromScale(1, 1);
                u23.ProgressBar.CompleteLabel.Text = "COMPLETE!";
            end;
        end;
    end;
    u20.Update();
    u20.CachedProductInfo = ProductInfo;
    u20.Ready = true;
end;
function u6.Update(p26) --[[ Line: 158 ]]
    -- upvalues: u6 (copy), l__Mince__6 (copy)
    if u6.Interface.IsActive then
        local v27 = u6;
        v27.TimeElapsed = v27.TimeElapsed + p26;
        if u6.TimeElapsed > u6.UpdateRate then
            u6.TimeElapsed = 0;
            for _, v28 in l__Mince__6.Config.PlayerRewards do
                if v28.Ready then
                    v28:Update(p26);
                end;
            end;
        end;
    end;
end;
function u6.SetupUI() --[[ Line: 174 ]]
    -- upvalues: u3 (copy), u6 (copy), l__Mince__6 (copy)
    u3.NewButton(u6.Interface.TweenFrame.CloseButton).Activated:Connect(u6.Interface.Close);
    for _, v29 in l__Mince__6.Config.PlayerRewards do
        task.defer(u6.InitPlayerReward, v29);
    end;
end;
function u6.Setup() --[[ Line: 184 ]]
    -- upvalues: u6 (copy), u3 (copy), l__RunService__3 (copy)
    u6.Interface = u3.Get("PlayerRewards");
    u6.SetupUI();
    l__RunService__3.Heartbeat:Connect(u6.Update);
end;
return u6;
