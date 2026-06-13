-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.Quests.LNY.FindBoxesQuest
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("Players");
require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.Signal);
local u1 = l__Mince__2:Get("CollectPickup");
local u2 = l__Mince__2:Get("ConfirmPrompt");
local u3 = l__Mince__2:Get("QuestsHandler");
local u4 = l__Mince__2:Get("ObjectiveHandler");
local u12 = {
    Start = function(p5) --[[ Name: Start, Line 16 ]]
        -- upvalues: u4 (copy), u2 (copy), u3 (copy), u1 (copy)
        local v6 = script.Pickup:Clone();
        local u7 = u4.StartObjectives({
            {
                Type = "Count",
                Format = "Get red box from storage room!",
                Goal = 1
            },
            {
                Type = "Count",
                Format = "Return to the NPC",
                Goal = 1
            }
        });
        local u8 = u7.Tasks[1];
        local u9 = u7.Tasks[2];
        local v10 = Instance.new("Highlight", game.Workspace);
        v10.Enabled = false;
        v6.Parent = game.Workspace;
        v10.Enabled = true;
        v10.Adornee = v6;
        p5.Maid:Add(v10);
        p5.Maid:Add(function() --[[ Line: 44 ]]
            -- upvalues: u7 (copy)
            u7:Stop();
        end);
        p5.Maid:Add(v6);
        p5.Maid:Add(p5.Interact:Connect(function() --[[ Line: 48 ]]
            -- upvalues: u8 (copy), u9 (copy), u2 (ref), u3 (ref)
            if u8.Finished then
                u9:Next();
            else
                u2.Display("Would you like to stop this quest?", function() --[[ Line: 54 ]]
                    -- upvalues: u3 (ref)
                    u3.StopStoryline();
                end);
            end;
        end));
        repeat
            task.wait();
        until u1:Get(v6);
        local v11 = u1:Get(v6);
        v11.PickedUp:Connect(function() --[[ Line: 62 ]]
            -- upvalues: u8 (copy)
            u8:Next();
        end);
        u8.Completed:Wait();
        v10.Adornee = p5.InteractNPC.Character;
        u9.Completed:Wait();
        v11.Tool:Destroy();
        p5.Finish();
    end
};
function u12.Setup() --[[ Line: 76 ]]
    -- upvalues: u3 (copy), u12 (copy)
    u3.GetSubQuestEvent("LNY25EventSetup", "FindBoxes"):Connect(u12.Start);
end;
return u12;
