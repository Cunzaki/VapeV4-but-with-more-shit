-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.Init.UpdateLog
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__GameNotesUtil__3 = require(l__ReplicatedStorage__1.Modules.GameNotesUtil);
local u1 = l__Mince__2:Get("InterfaceHandler");
local u2 = {
    CurrentPage = 1,
    PageCount = l__GameNotesUtil__3.PageTotal()
};
function u2.ShowNotes() --[[ Line: 14 ]]
    -- upvalues: u2 (copy), l__GameNotesUtil__3 (copy)
    if u2.AsyncLock then
    else
        u2.AsyncLock = true;
        if u2.GameGuiNotes then
            u2.GameGuiNotes:Destroy();
        end;
        u2.MainFrame.PageBar.PageText.Text = "Loading...";
        task.spawn(function() --[[ Line: 20 ]]
            -- upvalues: l__GameNotesUtil__3 (ref), u2 (ref)
            local v3, _ = l__GameNotesUtil__3.GetGameNotes(u2.CurrentPage);
            u2.GameGuiNotes = l__GameNotesUtil__3.CreateGameNotes(u2.CurrentPage, u2.Scroll);
            u2.MainFrame.PageBar.PageText.Text = v3.Name;
            task.wait();
            u2.UpdateScrollingFrame();
            u2.AsyncLock = false;
        end);
        u2.Interface.Open();
        u2.Interface.Closed:Wait();
    end;
end;
function u2.SetupButtons() --[[ Line: 34 ]]
    -- upvalues: u1 (copy), u2 (copy)
    local v4 = u1.NewButton(u2.MainFrame.PageBar.LeftArrowButton);
    local v5 = u1.NewButton(u2.MainFrame.PageBar.RightArrowButton);
    u1.NewButton(u2.MainFrame.CloseButton).Activated:Connect(function() --[[ Line: 39 ]]
        -- upvalues: u2 (ref)
        u2.Interface.Close();
    end);
    v4.Activated:Connect(function() --[[ Line: 43 ]]
        -- upvalues: u2 (ref)
        local v6 = u2;
        v6.CurrentPage = v6.CurrentPage - 1;
        if u2.CurrentPage < 1 then
            u2.CurrentPage = 1;
        else
            u2.ShowNotes();
        end;
    end);
    v5.Activated:Connect(function() --[[ Line: 49 ]]
        -- upvalues: u2 (ref)
        local v7 = u2;
        v7.CurrentPage = v7.CurrentPage + 1;
        if u2.CurrentPage > u2.PageCount then
            u2.CurrentPage = u2.PageCount;
        else
            u2.ShowNotes();
        end;
    end);
end;
function u2.ScaleUIListLayout(u8, p9) --[[ Line: 56 ]]
    local u10 = p9 or "X";
    local l__Scale__4 = u8.Padding.Scale;
    local l__Parent__5 = u8.Parent;
    l__Parent__5:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 60 ]]
        -- upvalues: u8 (copy), l__Scale__4 (copy), l__Parent__5 (copy), u10 (copy)
        u8.Padding = UDim.new(0, l__Scale__4 * l__Parent__5.AbsoluteSize[u10]);
    end);
end;
function u2.Setup() --[[ Line: 65 ]]
    -- upvalues: u2 (copy), u1 (copy)
    u2.Interface = u1.Get("UpdateLog");
    u2.MainFrame = u2.Interface.TweenFrame;
    u2.Scroll = u2.Interface.TweenFrame.Scroll.ScrollingFrame;
    u2.ScaleUIListLayout(u2.Scroll.UIListLayout);
    u2.UpdateScrollingFrame = u1.AutoSizeScrollingFrame(u2.Scroll, nil, nil, 0.5);
    u2.SetupButtons();
end;
return u2;
