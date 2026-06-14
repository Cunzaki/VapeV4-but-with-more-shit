-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.ObjectiveHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Maid__4 = require(l__ReplicatedStorage__1.Modules.Maid);
local l__Signal__5 = require(l__ReplicatedStorage__1.Modules.Signal);
local u1 = l__Mince__3:Get("InterfaceHandler");
local u2 = {
    SlideTween = TweenInfo.new(0.5),
    ValidObjectiveTypes = {
        Count = true
    }
};
function u2.ExitObjective(p3, p4) --[[ Line: 19 ]]
    -- upvalues: u2 (copy)
    if p3 then
        if p3.Exiting then
        else
            p3.Exiting = true;
            u2.TitleTweenOut:Play();
            for _, v5 in p3.Tasks do
                v5.TweenOut:Play();
                task.wait(0.2);
            end;
            task.wait(0.2);
            u2.Frame.Visible = false;
            if p4 then
                p3.Failed:Fire();
            else
                p3.Completed:Fire();
            end;
            p3.Finished:Fire();
            u2.Instance = nil;
        end;
    end;
end;
function u2.FormatTask(p6) --[[ Line: 45 ]]
    assert(p6.GUI, "No gui exists for this task!!");
    if p6.Type == "Count" then
        p6.GUI.Container.TaskText.Text = p6.Format:format(p6.Value, p6.Goal);
    end;
end;
function u2.CheckCompletion(p7, p8) --[[ Line: 52 ]]
    -- upvalues: u2 (copy)
    if not p8 then
        for _, v9 in p7.Tasks do
            if not v9.Finished then
                return;
            end;
        end;
    end;
    u2.ExitObjective(p7, false);
end;
function u2.StartObjectives(p10) --[[ Line: 63 ]]
    -- upvalues: u2 (copy), l__Signal__5 (copy), l__Maid__4 (copy), l__ReplicatedStorage__1 (copy), l__TweenService__2 (copy)
    if u2.Instance then
        if u2.Instance.Exiting then
            return;
        end;
        u2.ExitObjective(u2.Instance);
    end;
    warn("starting...");
    u2.Frame.Size = UDim2.new(1, 0, 0.13, 0);
    u2.Frame.Visible = true;
    u2.Body.Slide.Position = UDim2.fromScale(1.5, 0);
    u2.TitleTween:Play();
    local u11 = {
        Finished = l__Signal__5.new(),
        Completed = l__Signal__5.new(),
        Failed = l__Signal__5.new(),
        Maid = l__Maid__4.new(),
        Tasks = {}
    };
    function u11.Stop(_) --[[ Line: 84 ]]
        -- upvalues: u2 (ref), u11 (copy)
        u2.ExitObjective(u11, true);
    end;
    for _, u12 in p10 do
        assert(u12.Format, "A format is required for the task!");
        u12.Value = u12.Value or 0;
        u12.Goal = u12.Goal or 1;
        u12.Completed = l__Signal__5.new();
        u12.UI = l__ReplicatedStorage__1.Assets.Interface.Objective:Clone();
        u12.UI.Slide.Check.Visible = false;
        u12.UI.Slide.TaskText.Text = u12.Format:format(u12.Value, u12.Goal);
        u12.UI.Slide.Complete.Visible = false;
        u12.UI.Position = UDim2.fromScale(1.5, 0);
        u12.UI.Parent = u2.Frame;
        l__TweenService__2:Create(u2.Body.Slide, u2.SlideTween, {
            Position = UDim2.fromScale(0, 0)
        }):Play();
        u12.TweenOut = l__TweenService__2:Create(u12.UI.Slide, u2.SlideTween, {
            Position = UDim2.fromScale(1.5, 0)
        });
        function u12.Complete(_) --[[ Line: 110 ]]
            -- upvalues: u12 (copy), u2 (ref), u11 (copy)
            if u12.Finished then
            else
                u12.Finished = true;
                u12.Completed:Fire();
                task.spawn(function() --[[ Line: 115 ]]
                    -- upvalues: u12 (ref), u2 (ref), u11 (ref)
                    u12.UI.Slide.Check.Visible = true;
                    task.wait(0.5);
                    u12.UI.Slide.Complete.Visible = true;
                    task.wait(2);
                    u2.CheckCompletion(u11);
                end);
            end;
        end;
        function u12.Next(_) --[[ Line: 125 ]]
            -- upvalues: u12 (copy)
            if u12.Finished then
            else
                if u12.Type == "Count" then
                    local v13 = u12;
                    v13.Value = v13.Value + 1;
                end;
                u12.UI.Slide.TaskText.Text = u12.Format:format(u12.Value, u12.Goal);
                if u12.Type == "Count" and u12.Value >= u12.Goal then
                    u12:Complete();
                end;
            end;
        end;
        table.insert(u11.Tasks, u12);
    end;
    u2.Instance = u11;
    return u11;
end;
function u2.InitUI() --[[ Line: 148 ]]
    -- upvalues: u2 (copy), l__TweenService__2 (copy), u1 (copy)
    u2.Body.Slide.Position = UDim2.fromScale(1.5, 0);
    u2.TitleTween = l__TweenService__2:Create(u2.Body.Slide, u2.SlideTween, {
        Position = UDim2.fromScale(0, 0)
    });
    u2.TitleTweenOut = l__TweenService__2:Create(u2.Body.Slide, u2.SlideTween, {
        Position = UDim2.fromScale(1.5, 0)
    });
    u1.NewButton(u2.Body.Slide.CloseButton).Activated:Connect(function() --[[ Line: 157 ]]
        -- upvalues: u2 (ref)
        u2.ExitObjective(u2.Instance, true);
    end);
end;
function u2.Setup() --[[ Line: 163 ]]
    -- upvalues: u2 (copy), u1 (copy)
    u2.MainPriority = u1.GetScreenGui("MainPriority");
    u2.Frame = u2.MainPriority.Right.Objective;
    u2.Body = u2.Frame.Body;
    u2.InitUI();
end;
return u2;
