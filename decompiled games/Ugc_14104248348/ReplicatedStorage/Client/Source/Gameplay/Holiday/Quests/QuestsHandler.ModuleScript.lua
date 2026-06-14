-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.Quests.QuestsHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("Players");
local l__Maid__2 = require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Signal__4 = require(l__ReplicatedStorage__1.Modules.Signal);
local u1 = l__Mince__3:Get("UserProfile");
l__Mince__3:Get("InterfaceHandler");
local u2 = l__Mince__3:GetEvent("CompleteQuest");
local u5 = {
    QuestCompleted = l__Signal__4.new(),
    QuestEnded = l__Signal__4.new(),
    QuestMaid = l__Maid__2.new(),
    CurrentLoaded = {},
    Controllers = {},
    SubQuest = {},
    GetCurrentStorylineQuest = function(p3) --[[ Name: GetCurrentStorylineQuest, Line 23 ]]
        -- upvalues: u1 (copy), l__Mince__3 (copy)
        u1:WaitUntilLoaded();
        local v4 = l__Mince__3.Config.Quests[p3];
        if v4 then
            if v4.Enabled then
                if l__Mince__3.Config.LocalProfile.Quests.StorylineProgress[p3] then
                    return v4[l__Mince__3.Config.LocalProfile.Quests.StorylineProgress[p3]];
                end;
                error((`No storyline progress for '{p3}'`));
            else
                error((`Could not load Storyline beacuse quest '{p3}' is not enabled!`));
            end;
        else
            error((`Could not load Storyline because quest '{p3}' does not exist!`));
        end;
    end
};
function u5.GetSubQuestEvent(u6, p7) --[[ Line: 45 ]]
    -- upvalues: u5 (copy), l__Signal__4 (copy)
    if not u5.Controllers[u6] then
        u5.SubQuest[u6] = {};
        u5.Controllers[u6] = function(p8) --[[ Line: 49 ]]
            -- upvalues: u5 (ref), u6 (copy), l__Signal__4 (ref)
            warn(p8);
            u5.SubQuest[u6][p8.Quest.SubQuest] = u5.SubQuest[u6][p8.Quest.SubQuest] or l__Signal__4.new();
            u5.SubQuest[u6][p8.Quest.SubQuest]:Fire(p8);
        end;
    end;
    if u5.SubQuest[u6] then
        u5.SubQuest[u6][p7] = u5.SubQuest[u6][p7] or l__Signal__4.new();
        return u5.SubQuest[u6][p7];
    end;
    error("Failed because the Storyline is already controlled!");
end;
function u5.StartStoryline(u9, p10) --[[ Line: 66 ]]
    -- upvalues: u5 (copy), u1 (copy), l__Signal__4 (copy), u2 (copy)
    local u11 = u5.GetCurrentStorylineQuest(u9);
    if not u11 then
        warn((`Couldn't find active quest by the name of!  '{u9}'`));
    end;
    u1:WaitUntilLoaded();
    u5.QuestMaid:Clean();
    local v12 = {
        Maid = u5.QuestMaid,
        Quest = u11,
        Interact = l__Signal__4.new(),
        InteractNPC = p10,
        Finish = function() --[[ Name: Finish, Line 81 ]]
            -- upvalues: u2 (ref), u9 (copy), u5 (ref), u11 (copy)
            u2:Fire(u9);
            u5.QuestCompleted:Fire(u11);
            task.wait();
            u5.StopStoryline();
        end
    };
    u5.QuestActive = v12;
    u5.Controllers[u9](v12);
end;
function u5.StopStoryline() --[[ Line: 97 ]]
    -- upvalues: u5 (copy)
    if u5.QuestActive then
        u5.QuestActive = false;
        u5.QuestMaid:Clean();
        u5.QuestEnded:Fire();
    end;
end;
function u5.Interact() --[[ Line: 108 ]]
    -- upvalues: u5 (copy)
    if u5.QuestActive then
        u5.QuestActive.Interact:Fire();
    end;
end;
return u5;
