-- Decompiled from: ReplicatedFirst.Runtime.Source.LoadingManager.LoadingTasks
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__LightRunner__1 = _G.LightRunner;
local l__Task__2 = require(script.Parent.Task);
local l__ContentProvider__3 = game:GetService("ContentProvider");
local function u7(p1, p2, p3, p4) --[[ Line: 14 ]]
    local l__CurrentTask__4 = p1.CurrentTask;
    if l__CurrentTask__4 then
        l__CurrentTask__4 = p1.CurrentTask.Descriptor;
    end;
    local v5 = 0;
    while true do
        if not l__CurrentTask__4 then
            l__CurrentTask__4 = p1.CurrentTask;
            if l__CurrentTask__4 then
                l__CurrentTask__4 = p1.CurrentTask.Descriptor;
            end;
        end;
        v5 = v5 + task.wait();
        if v5 > 2 then
            local v6 = math.floor(5 - (v5 - 2)) - 2;
            p1.CurrentTask.Descriptor = `{l__CurrentTask__4 or "CurrentTask.NotRetrieved"} ({v6 + 1})`;
            p2(1 - v6 / 3);
            if v5 > 5 then
                return p3();
            end;
        end;
        if p4() then
            return;
        end;
    end;
end;
return {
    l__Task__2.New({
        Descriptor = "Waiting For Server",
        Worker = function(_, p8) --[[ Name: Worker, Line 42 ]]
            -- upvalues: l__LightRunner__1 (copy)
            l__LightRunner__1:Get("Runner"):Get("Mince"):WaitUntilSetup("Server");
            p8();
        end
    }),
    l__Task__2.New({
        Descriptor = "Client Scripts Intializing",
        Worker = function(_, p9) --[[ Name: Worker, Line 50 ]]
            -- upvalues: l__LightRunner__1 (copy)
            l__LightRunner__1:Get("Runner"):Get("Mince"):WhenStart(p9);
        end
    }),
    l__Task__2.New({
        Descriptor = "Syncing With Server",
        Worker = function(_, p10) --[[ Name: Worker, Line 61 ]]
            -- upvalues: l__LightRunner__1 (copy)
            l__LightRunner__1:Get("Runner"):Get("Mince"):WaitUntilHandshake(game:GetService("Players").LocalPlayer);
            p10();
        end
    }),
    l__Task__2.New({
        Descriptor = "Loading Player Data",
        Worker = function(p11, u12) --[[ Name: Worker, Line 70 ]]
            -- upvalues: l__LightRunner__1 (copy)
            local u13 = l__LightRunner__1:Get("Runner"):Get("Mince");
            p11(0.5);
            u13:WhenStart(function() --[[ Line: 73 ]]
                -- upvalues: u13 (copy), u12 (copy)
                u13:Get("UserProfile"):WaitUntilLoaded();
                u12();
            end);
        end
    }),
    l__Task__2.New({
        Descriptor = "Loading Game World",
        Worker = function(_, p14) --[[ Name: Worker, Line 84 ]]
            if not game:IsLoaded() then
                game.Loaded:Wait();
            end;
            p14();
        end
    }),
    l__Task__2.New({
        Descriptor = "Loading Priority Assets",
        StartEarly = true,
        SkipInStudio = true,
        Worker = function(u15, p16, p17) --[[ Name: Worker, Line 95 ]]
            -- upvalues: l__ContentProvider__3 (copy), u7 (copy)
            local u18 = {
                "rbxassetid://17532006272",
                "rbxassetid://12110299262",
                "rbxassetid://17802501925",
                "rbxassetid://17802381681",
                "rbxassetid://136148598245888",
                "rbxassetid://123118520414966",
                "rbxassetid://103036021096481",
                "rbxassetid://124936280652938",
                "rbxassetid://99109952235770",
                "rbxassetid://135989379582225",
                "rbxassetid://134453274456603",
                "rbxassetid://89066951224166",
                "rbxassetid://130755511868988",
                "rbxassetid://116682529504154",
                "rbxassetid://136424526390589",
                "rbxassetid://85147320039801",
                "rbxassetid://131893769422713",
                "rbxassetid://16427517262",
                "rbxassetid://16427564546"
            };
            local u19 = false;
            local u20 = 0;
            task.spawn(function() --[[ Line: 131 ]]
                -- upvalues: l__ContentProvider__3 (ref), u18 (copy), u20 (ref), u15 (copy), u19 (ref)
                l__ContentProvider__3:PreloadAsync(u18, function(_, _) --[[ Line: 132 ]]
                    -- upvalues: u20 (ref), u15 (ref), u18 (ref)
                    u20 = u20 + 1;
                    u15(u20 / #u18);
                end);
                u19 = true;
            end);
            u7(p17, u15, p16, function() --[[ Line: 138 ]]
                -- upvalues: u19 (ref)
                return u19;
            end);
            p16();
        end
    }),
    l__Task__2.New({
        StartEarly = true,
        Descriptor = "Loading Sound Effects",
        Worker = function(u21, p22, p23, p24) --[[ Name: Worker, Line 148 ]]
            -- upvalues: l__LightRunner__1 (copy), l__ContentProvider__3 (copy), u7 (copy)
            if not game:IsLoaded() then
                game.Loaded:Wait();
            end;
            local v25 = l__LightRunner__1:Get("Runner"):Get("Mince");
            v25:WaitUntilSetup("Client");
            v25:Get("SoundHandler");
            local u26 = {};
            local u27 = 0;
            l__ContentProvider__3:PreloadAsync(u26, function(_) --[[ Line: 168 ]]
                -- upvalues: u27 (ref), u21 (copy), u26 (copy)
                u27 = u27 + 1;
                u21(u27 / #u26);
            end);
            local u28 = u27;
            repeat
                task.wait();
            until p24 == p23.CurrentTask;
            u7(p23, u21, p22, function() --[[ Line: 175 ]]
                -- upvalues: u28 (ref), u26 (copy)
                return u28 == #u26;
            end);
            p22();
        end
    })
};
