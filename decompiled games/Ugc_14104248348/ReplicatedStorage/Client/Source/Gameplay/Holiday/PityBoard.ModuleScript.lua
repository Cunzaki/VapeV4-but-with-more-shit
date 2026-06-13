-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.PityBoard
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.RarityUtil);
local l__LootboxUtil__3 = require(l__ReplicatedStorage__1.Modules.LootboxUtil);
local u1 = l__Mince__2:Get("InterfaceHandler");
l__Mince__2:Get("Notices");
local u2 = l__Mince__2:Get("OpeningHandler");
local u3 = l__Mince__2:Get("UserProfile");
local u4 = l__Mince__2:Get("ProximityManager");
local u5 = l__Mince__2:GetFunction("ClaimPityReward");
local u6 = l__Mince__2.Component({
    Tag = "PityBoard"
});
function u6.Construct(u7) --[[ Line: 22 ]]
    -- upvalues: l__LootboxUtil__3 (copy), l__ReplicatedStorage__1 (copy), u1 (copy), u5 (copy), u4 (copy), u2 (copy), l__Mince__2 (copy)
    local v8 = typeof(u7.Name) == "string";
    assert(v8, "Self name must exist and be an a string! ");
    u7.Config = l__LootboxUtil__3.GetLootbox(u7.Name);
    local l__Config__4 = u7.Config;
    local v9 = `Failed to load the lootbox by the name of '{u7.Name}'!`;
    assert(l__Config__4, v9);
    local l__GatchaReward__5 = l__ReplicatedStorage__1.Assets.Interface:WaitForChild("GatchaReward");
    local l__Instance__6 = u7.Instance;
    for u10, v11 in u7.Config.PityCosts do
        local v12 = l__GatchaReward__5:Clone();
        local v13 = `Next Free {u10} (Open`;
        for v14, v15 in v11 do
            v13 = v13 .. ` {v15} {v14}`;
        end;
        v12.LevelTitle.Text = v13 .. ")";
        v12.Parent = l__Instance__6.Container.Container;
        v12.Name = u10;
        u1.NewButton(v12.Claim).Button.Activated:Connect(function() --[[ Line: 43 ]]
            -- upvalues: u5 (ref), u7 (copy), u10 (copy), u4 (ref), u2 (ref), l__Mince__2 (ref)
            local v16, v17 = pcall(function() --[[ Line: 44 ]]
                -- upvalues: u5 (ref), u7 (ref), u10 (ref)
                return u5:Invoke(u7.Config.ID, u10);
            end);
            if v16 and v17 then
                u4:SetAllEnabled(false);
                u2.NextClose:ConnectOnce(function() --[[ Line: 51 ]]
                    -- upvalues: u4 (ref)
                    u4:SetAllEnabled(true);
                end);
                u2[l__Mince__2.Config.HolidayConfigure.EVENT_OPENING_METHOD]({
                    IVID = v17
                });
            end;
        end);
    end;
    if u7.Data then
        u7:Update();
    end;
end;
function u6.Update(p18) --[[ Line: 67 ]]
    local l__Instance__7 = p18.Instance;
    task.wait(5);
    local v19 = {};
    for v20, v21 in p18.Data do
        local v22 = string.split(v20, ".");
        if v22[1] == p18.Config.ID then
            v19[v22[2]] = v21;
        end;
    end;
    for v23, v24 in p18.Config.PityCosts do
        for v25, v26 in v24 do
            if v19[v25] then
                local v27 = v19[v25] / v26;
                local v28 = `{math.floor(v27 * 100)}%`;
                local v29 = l__Instance__7.Container.Container[v23];
                v29.ProgressBar.Fill.Size = UDim2.fromScale(v27, 1);
                v29.ProgressBar.CompleteLabel.Text = v28;
                if v27 == 1 then
                    v29.Claim.Visible = true;
                    v29.NoClaim.Visible = false;
                else
                    v29.Claim.Visible = false;
                    v29.NoClaim.Visible = true;
                end;
            end;
        end;
    end;
end;
function u6.Setup() --[[ Line: 105 ]]
    -- upvalues: u3 (copy), u6 (copy)
    u3.Upon("LootboxesOpenedRarityTrack", function(p30) --[[ Line: 106 ]]
        -- upvalues: u6 (ref)
        for _, v31 in u6:GetAll() do
            v31.Data = p30;
            v31:Update();
        end;
    end);
end;
return u6;
