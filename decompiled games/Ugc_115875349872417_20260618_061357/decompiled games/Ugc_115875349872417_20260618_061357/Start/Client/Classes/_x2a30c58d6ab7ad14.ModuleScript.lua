-- Decompiled from: Start.Client.Classes._x2a30c58d6ab7ad14
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__ModuleScripts__3 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Trove__4 = require(l__ModuleScripts__3.Trove);
local l__TitleData__5 = require(l__ModuleScripts__3.TitleData);
local l__LeaderboardAssets__6 = game:GetService("ReplicatedStorage").Assets.UIAssets.LeaderboardAssets;
local u1 = {};
u1.__index = u1;
local l__ClientRoot__7 = require(script.Parent.Parent.ClientRoot);
local l__Classes__8 = l__ClientRoot__7.Classes;
local l__Context__9 = l__ClientRoot__7.Context;
function u1._x90d4581ac99dd483() --[[ Line: 20 ]]
    -- upvalues: u1 (copy), l__LeaderboardAssets__6 (copy)
    local v2 = setmetatable({}, u1);
    v2._x8de4a61aa2a30958 = l__LeaderboardAssets__6.Leaderboard:Clone();
    v2._x980553af4b193fc2 = {};
    return v2;
end;
function u1._xf27f2310f2da5afe(u3, u4) --[[ Line: 29 ]]
    -- upvalues: l__Trove__4 (copy), l__TitleData__5 (copy), l__RunService__2 (copy), l__Classes__8 (copy)
    if u3._x980553af4b193fc2[u4] then
    else
        local function u5() --[[ Line: 32 ]]
            -- upvalues: u3 (copy), u4 (copy)
            u3:_x40245d3996e01f9e(u4);
        end;
        local u6 = {};
        local v7 = l__Trove__4.new();
        local u8 = v7:Extend();
        local function v28(u9) --[[ Line: 40 ]]
            -- upvalues: u8 (copy), u4 (copy), u3 (copy), u6 (copy), u5 (copy), l__TitleData__5 (ref), l__RunService__2 (ref), l__Classes__8 (ref)
            u8:Clean();
            local u10 = game:GetService("ReplicatedStorage").Assets.UIAssets.OverheadElement:Clone();
            u8:Add(u10);
            u10.NameFrame.NameLabel.Text = u4.DisplayName;
            task.defer(function() --[[ Name: setupFromReadableFolder, Line 48 ]]
                -- upvalues: u4 (ref), u3 (ref), u6 (ref), u5 (ref), u8 (ref), u10 (copy), l__TitleData__5 (ref)
                local v11 = tostring(u4.UserId);
                local u12 = game:GetService("ReplicatedStorage").ReadOnly.Players:WaitForChild(v11);
                if u12 then
                    u6._trove:Add(u12.Destroying:Connect(u5));
                    u6.readable_folder = u12;
                    local function u14(p13) --[[ Line: 78 ]]
                        -- upvalues: u10 (ref)
                        u10.LevelFrame.LevelLabel.Text = tostring(p13);
                    end;
                    local u15 = "level";
                    task.spawn(function() --[[ Line: 62 ]]
                        -- upvalues: u12 (copy), u15 (copy), u14 (copy), u8 (ref)
                        local u16 = u12:WaitForChild(u15);
                        if u16 then
                            local v17 = u16.Changed:Connect(function() --[[ Line: 69 ]]
                                -- upvalues: u14 (ref), u16 (copy)
                                u14(u16.Value);
                            end);
                            u14(u16.Value);
                            u8:Add(v17);
                        else
                            warn("COULD NOT FIND VALUE INSTANCE : ", u15);
                        end;
                    end);
                    local function u19(p18) --[[ Line: 82 ]]
                        -- upvalues: u10 (ref), l__TitleData__5 (ref)
                        l__TitleData__5.renderFromLabel(u10.NameFrame.TitleLabel, p18);
                    end;
                    local u20 = "equipped_title";
                    task.spawn(function() --[[ Line: 62 ]]
                        -- upvalues: u12 (copy), u20 (copy), u19 (copy), u8 (ref)
                        local u21 = u12:WaitForChild(u20);
                        if u21 then
                            local v22 = u21.Changed:Connect(function() --[[ Line: 69 ]]
                                -- upvalues: u19 (ref), u21 (copy)
                                u19(u21.Value);
                            end);
                            u19(u21.Value);
                            u8:Add(v22);
                        else
                            warn("COULD NOT FIND VALUE INSTANCE : ", u20);
                        end;
                    end);
                    local function u24(p23) --[[ Line: 87 ]]
                        -- upvalues: u10 (ref)
                        local l__ImageLabel__10 = u10.StreakFrame.ImageLabel;
                        local l__StreakLabel__11 = u10.StreakFrame.StreakLabel;
                        l__StreakLabel__11.Text = tostring(p23);
                        l__ImageLabel__10.Visible = p23 > 1;
                        l__StreakLabel__11.Visible = p23 > 1;
                    end;
                    local u25 = "casual_duel_winstreak";
                    task.spawn(function() --[[ Line: 62 ]]
                        -- upvalues: u12 (copy), u25 (copy), u24 (copy), u8 (ref)
                        local u26 = u12:WaitForChild(u25);
                        if u26 then
                            local v27 = u26.Changed:Connect(function() --[[ Line: 69 ]]
                                -- upvalues: u24 (ref), u26 (copy)
                                u24(u26.Value);
                            end);
                            u24(u26.Value);
                            u8:Add(v27);
                        else
                            warn("COULD NOT FIND VALUE INSTANCE : ", u25);
                        end;
                    end);
                else
                    u3:_x40245d3996e01f9e(u4);
                    warn("?? NO AVAILABLE FOLDER TO READ FROM");
                end;
            end);
            u8:Connect(l__RunService__2.Heartbeat, function() --[[ Line: 99 ]]
                -- upvalues: u9 (copy), l__Classes__8 (ref), u10 (copy)
                if u9 and u9.Parent then
                    local l__Position__12 = workspace.CurrentCamera.CFrame.Position;
                    u10.Enabled = (l__Classes__8.Util:getLikelyVec3(u9) - l__Position__12).Magnitude <= 50;
                end;
            end);
            u10.Parent = u9;
            u10.Adornee = u9:WaitForChild("Head");
        end;
        v7:Connect(u4.CharacterAdded, v28);
        if u4.Character then
            v28(u4.Character);
        end;
        u6._trove = v7;
        u3._x980553af4b193fc2[u4] = u6;
    end;
end;
function u1._x40245d3996e01f9e(p29, p30) --[[ Line: 122 ]]
    local v31 = p29._x980553af4b193fc2[p30];
    if v31 then
        v31._trove:Clean();
        p29._x980553af4b193fc2[p30] = nil;
    end;
end;
function u1._xe53615d96cf36a6b(u32) --[[ Line: 131 ]]
    -- upvalues: l__Context__9 (copy), l__Classes__8 (copy), l__Players__1 (copy)
    if l__Context__9.is_public_lobby then
        task.defer(function() --[[ Line: 136 ]]
            -- upvalues: u32 (copy), l__Classes__8 (ref)
            u32._x8de4a61aa2a30958.Parent = l__Classes__8.MenuManager.screen;
        end);
        for _, u33 in l__Players__1:GetPlayers() do
            task.spawn(function() --[[ Line: 141 ]]
                -- upvalues: u32 (copy), u33 (copy)
                u32:_xf27f2310f2da5afe(u33);
            end);
        end;
        l__Players__1.PlayerAdded:Connect(function(p34) --[[ Line: 146 ]]
            -- upvalues: u32 (copy)
            u32:_xf27f2310f2da5afe(p34);
        end);
        l__Players__1.PlayerRemoving:Connect(function(p35) --[[ Line: 150 ]]
            -- upvalues: u32 (copy)
            u32:_x40245d3996e01f9e(p35);
        end);
    end;
end;
return u1;
