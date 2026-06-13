-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.Priority.Notices
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__RunService__3 = game:GetService("RunService");
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__4:Get("InterfaceHandler");
local u2 = l__Mince__4:Get("SoundHandler");
local u3 = l__Mince__4:GetEvent("NoticeEvent");
local u4 = {
    QueueBreak = 0.2,
    IsEnabled = true,
    ClearTextUponDissapearing = false,
    MaximumItems = 5,
    SizeIncrease = 1.05,
    QueueList = {},
    Items = {},
    BounceTween = TweenInfo.new(0.1, Enum.EasingStyle.Bounce, Enum.EasingDirection.InOut, 0, true),
    IncreaseTween = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, true),
    DisappearTween = TweenInfo.new(0.05, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
    DropInTween = TweenInfo.new(0.6, Enum.EasingStyle.Back),
    UndoTween = TweenInfo.new(0.8, Enum.EasingStyle.Quad)
};
function ModifyColor(p5, p6)
    local v7, v8, v9 = p5:ToHSV();
    return Color3.fromHSV(v7 * (p6.H or 1), v8 * (p6.S or 1), v9 * (p6.V or 1));
end;
function u4.Update(p10) --[[ Line: 39 ]]
    -- upvalues: u4 (copy)
    if u4.MaximumItems > 0 and #u4.Items > u4.MaximumItems then
        local v11 = u4.Items[#u4.Items];
        v11.Age = v11.Life + 1;
    end;
    for v12, u13 in u4.Items do
        u13.Age = u13.Age + p10;
        u13.UIItem.LayoutOrder = -v12;
        if u13.Age > u13.Life then
            table.remove(u4.Items, v12);
            task.spawn(function() --[[ Line: 56 ]]
                -- upvalues: u4 (ref), u13 (copy)
                if u4.ClearTextUponDissapearing then
                    u13.UIItem.Label.Text = "";
                end;
                u13.DissapearTween:Play();
                u13.DissapearTween.Completed:Wait();
                u13.UIItem:Destroy();
            end);
            return;
        end;
    end;
end;
function u4.Error(p14, p15) --[[ Line: 69 ]]
    -- upvalues: u4 (copy)
    u4.CreateNotice(p14, Color3.new(1, 0.2, 0.2), p15, "error");
end;
function u4.CreateNotice(p16, p17, p18, p19) --[[ Line: 73 ]]
    -- upvalues: u2 (copy), l__ReplicatedStorage__1 (copy), u1 (copy), u4 (copy), l__TweenService__2 (copy)
    local v20 = p16 or "Notice.Text";
    local v21 = p17 or Color3.new(1, 1, 1);
    u2.PlaySound(p19 or "notifsound");
    local v22 = {
        Age = 0,
        Life = p18 or 3,
        Text = v20,
        UIItem = l__ReplicatedStorage__1.Assets.Interface.NotifItem:Clone()
    };
    u1.ScaleDescedantsStrokes(v22.UIItem, u4.ScreenGui);
    v22.UIItem.Label.Text = v20;
    v22.UIItem.Label.TextColor3 = v21;
    v22.UIItem.Label.UIStroke.Color = ModifyColor(v21, {
        V = 0.2
    });
    v22.UIItem.Parent = u4.NoticeFrame;
    local l__Size__5 = v22.UIItem.Size;
    local v23 = UDim2.fromScale(l__Size__5.X.Scale * u4.SizeIncrease, l__Size__5.Y.Scale * u4.SizeIncrease);
    v22.DissapearTween = l__TweenService__2:Create(v22.UIItem, u4.DisappearTween, {
        Size = UDim2.fromScale(0, 0)
    });
    l__TweenService__2:Create(v22.UIItem, u4.IncreaseTween, {
        Size = v23
    }):Play();
    table.insert(u4.Items, 1, v22);
    return v22;
end;
function u4.Setup() --[[ Line: 111 ]]
    -- upvalues: u4 (copy), u1 (copy), u3 (copy), l__RunService__3 (copy)
    u4.ScreenGui = u1.GetScreenGui("MainPriority");
    u4.NoticeFrame = u4.ScreenGui.Notices;
    u4.ActiveThread = task.spawn(function() --[[ Line: 116 ]]
        -- upvalues: u4 (ref)
        while true do
            while #u4.QueueList > 0 do
                local _ = u4.QueueList[1];
                u4.CreateNotice(table.unpack(u4.QueueList[1]));
                task.wait(u4.QueueBreak);
                table.remove(u4.QueueList, 1);
            end;
            task.wait();
        end;
    end);
    u3.Event:Connect(function(...) --[[ Line: 129 ]]
        -- upvalues: u4 (ref)
        table.insert(u4.QueueList, { ... });
    end);
    l__RunService__3.Heartbeat:Connect(u4.Update);
end;
return u4;
