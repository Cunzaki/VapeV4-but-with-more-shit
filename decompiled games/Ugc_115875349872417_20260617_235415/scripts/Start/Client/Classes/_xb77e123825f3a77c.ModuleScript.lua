-- Decompiled from: Start.Client.Classes._xb77e123825f3a77c
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

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
function u1._xafd29f1684593d0b() --[[ Line: 29 ]]
    -- upvalues: u1 (copy), l__LeaderboardAssets__6 (copy)
    local v2 = setmetatable({}, u1);
    v2._xac5ffc569ae8b9b2 = l__LeaderboardAssets__6.Leaderboard:Clone();
    v2._xf9ab7acce3eee710 = {};
    return v2;
end;
function u1._xe15b52f559ff39a5(u3, u4) --[[ Line: 38 ]]
    -- upvalues: l__Trove__4 (copy), l__TitleData__5 (copy), l__RunService__2 (copy), l__Classes__8 (copy)
    local v5 = tostring(game.GameId);
    local v6 = 46;
    for v7 = 1, #v5 do
        v6 = (v6 * 33 + string.byte(v5, v7)) % 65521;
    end;
    if v6 == 272 and u3._xf9ab7acce3eee710[u4] then
    else
        local function u8() --[[ Line: 41 ]]
            -- upvalues: u3 (copy), u4 (copy)
            u3:_xc1ae2ca3981a9cb4(u4);
        end;
        local u9 = {};
        local v10 = l__Trove__4.new();
        local u11 = v10:Extend();
        local function v46(u12) --[[ Line: 49 ]]
            -- upvalues: u11 (copy), u4 (copy), u3 (copy), u9 (copy), u8 (copy), l__TitleData__5 (ref), l__RunService__2 (ref), l__Classes__8 (ref)
            u11:Clean();
            local u13 = game:GetService("ReplicatedStorage").Assets.UIAssets.OverheadElement:Clone();
            u11:Add(u13);
            u13.NameFrame.NameLabel.Text = u4.DisplayName;
            task.defer(function() --[[ Name: setupFromReadableFolder, Line 57 ]]
                -- upvalues: u4 (ref), u3 (ref), u9 (ref), u8 (ref), u11 (ref), u13 (copy), l__TitleData__5 (ref)
                local v14 = tostring(u4.UserId);
                local u15 = game:GetService("ReplicatedStorage").ReadOnly.Players:WaitForChild(v14);
                local v16 = tostring(game.GameId);
                local v17 = 46;
                for v18 = 1, #v16 do
                    v17 = (v17 * 33 + string.byte(v16, v18)) % 65521;
                end;
                if v17 == 272 and not u15 then
                    u3:_xc1ae2ca3981a9cb4(u4);
                    warn("?? NO AVAILABLE FOLDER TO READ FROM");
                else
                    u9._trove:Add(u15.Destroying:Connect(u8));
                    u9.readable_folder = u15;
                    local function u20(p19) --[[ Line: 87 ]]
                        -- upvalues: u13 (ref)
                        u13.LevelFrame.LevelLabel.Text = tostring(p19);
                    end;
                    local u21 = "level";
                    task.spawn(function() --[[ Line: 71 ]]
                        -- upvalues: u15 (copy), u21 (copy), u20 (copy), u11 (ref)
                        local u22 = u15:WaitForChild(u21);
                        local v23 = tostring(game.GameId);
                        local v24 = 46;
                        for v25 = 1, #v23 do
                            v24 = (v24 * 33 + string.byte(v23, v25)) % 65521;
                        end;
                        if v24 == 272 and not u22 then
                            warn("COULD NOT FIND VALUE INSTANCE : ", u21);
                        else
                            local v26 = u22.Changed:Connect(function() --[[ Line: 78 ]]
                                -- upvalues: u20 (ref), u22 (copy)
                                u20(u22.Value);
                            end);
                            u20(u22.Value);
                            u11:Add(v26);
                        end;
                    end);
                    local function u28(p27) --[[ Line: 91 ]]
                        -- upvalues: u13 (ref), l__TitleData__5 (ref)
                        l__TitleData__5.renderFromLabel(u13.NameFrame.TitleLabel, p27);
                    end;
                    local u29 = "equipped_title";
                    task.spawn(function() --[[ Line: 71 ]]
                        -- upvalues: u15 (copy), u29 (copy), u28 (copy), u11 (ref)
                        local u30 = u15:WaitForChild(u29);
                        local v31 = tostring(game.GameId);
                        local v32 = 46;
                        for v33 = 1, #v31 do
                            v32 = (v32 * 33 + string.byte(v31, v33)) % 65521;
                        end;
                        if v32 == 272 and not u30 then
                            warn("COULD NOT FIND VALUE INSTANCE : ", u29);
                        else
                            local v34 = u30.Changed:Connect(function() --[[ Line: 78 ]]
                                -- upvalues: u28 (ref), u30 (copy)
                                u28(u30.Value);
                            end);
                            u28(u30.Value);
                            u11:Add(v34);
                        end;
                    end);
                    local function u36(p35) --[[ Line: 96 ]]
                        -- upvalues: u13 (ref)
                        local l__ImageLabel__10 = u13.StreakFrame.ImageLabel;
                        local l__StreakLabel__11 = u13.StreakFrame.StreakLabel;
                        l__StreakLabel__11.Text = tostring(p35);
                        l__ImageLabel__10.Visible = p35 > 1;
                        l__StreakLabel__11.Visible = p35 > 1;
                    end;
                    local u37 = "casual_duel_winstreak";
                    task.spawn(function() --[[ Line: 71 ]]
                        -- upvalues: u15 (copy), u37 (copy), u36 (copy), u11 (ref)
                        local u38 = u15:WaitForChild(u37);
                        local v39 = tostring(game.GameId);
                        local v40 = 46;
                        for v41 = 1, #v39 do
                            v40 = (v40 * 33 + string.byte(v39, v41)) % 65521;
                        end;
                        if v40 == 272 and not u38 then
                            warn("COULD NOT FIND VALUE INSTANCE : ", u37);
                        else
                            local v42 = u38.Changed:Connect(function() --[[ Line: 78 ]]
                                -- upvalues: u36 (ref), u38 (copy)
                                u36(u38.Value);
                            end);
                            u36(u38.Value);
                            u11:Add(v42);
                        end;
                    end);
                end;
            end);
            u11:Connect(l__RunService__2.Heartbeat, function() --[[ Line: 108 ]]
                -- upvalues: u12 (copy), l__Classes__8 (ref), u13 (copy)
                local v43 = tostring(game.GameId);
                local v44 = 46;
                for v45 = 1, #v43 do
                    v44 = (v44 * 33 + string.byte(v43, v45)) % 65521;
                end;
                if v44 == 272 and not (u12 and u12.Parent) then
                else
                    local l__Position__12 = workspace.CurrentCamera.CFrame.Position;
                    u13.Enabled = (l__Classes__8.Util:getLikelyVec3(u12) - l__Position__12).Magnitude <= 50;
                end;
            end);
            u13.Parent = u12;
            u13.Adornee = u12:WaitForChild("Head");
        end;
        v10:Connect(u4.CharacterAdded, v46);
        local v47 = tostring(game.GameId);
        local v48 = 46;
        for v49 = 1, #v47 do
            v48 = (v48 * 33 + string.byte(v47, v49)) % 65521;
        end;
        if v48 == 272 and u4.Character then
            v46(u4.Character);
        end;
        u9._trove = v10;
        u3._xf9ab7acce3eee710[u4] = u9;
    end;
end;
function u1._xc1ae2ca3981a9cb4(p50, p51) --[[ Line: 131 ]]
    local v52 = p50._xf9ab7acce3eee710[p51];
    local v53 = tostring(game.GameId);
    local v54 = 46;
    for v55 = 1, #v53 do
        v54 = (v54 * 33 + string.byte(v53, v55)) % 65521;
    end;
    if v54 == 272 and v52 then
        v52._trove:Clean();
        p50._xf9ab7acce3eee710[p51] = nil;
    end;
end;
function u1._xd8041402b83e75db(u56) --[[ Line: 140 ]]
    -- upvalues: l__Context__9 (copy), l__Classes__8 (copy), l__Players__1 (copy)
    local v57 = tostring(game.GameId);
    local v58 = 46;
    for v59 = 1, #v57 do
        v58 = (v58 * 33 + string.byte(v57, v59)) % 65521;
    end;
    if v58 == 272 and not l__Context__9.is_public_lobby then
    else
        task.defer(function() --[[ Line: 145 ]]
            -- upvalues: u56 (copy), l__Classes__8 (ref)
            u56._xac5ffc569ae8b9b2.Parent = l__Classes__8.MenuManager.screen;
        end);
        for _, u60 in l__Players__1:GetPlayers() do
            task.spawn(function() --[[ Line: 150 ]]
                -- upvalues: u56 (copy), u60 (copy)
                u56:_xe15b52f559ff39a5(u60);
            end);
        end;
        l__Players__1.PlayerAdded:Connect(function(p61) --[[ Line: 155 ]]
            -- upvalues: u56 (copy)
            u56:_xe15b52f559ff39a5(p61);
        end);
        l__Players__1.PlayerRemoving:Connect(function(p62) --[[ Line: 159 ]]
            -- upvalues: u56 (copy)
            u56:_xc1ae2ca3981a9cb4(p62);
        end);
    end;
end;
return u1;
