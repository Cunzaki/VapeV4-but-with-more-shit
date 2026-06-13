-- Decompiled from: ReplicatedStorage.Modules.GameNotesUtil
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local l__Notes__1 = require(script.Notes);
local u5 = {
    Size = 0.025,
    PageTotal = function() --[[ Name: PageTotal, Line 9 ]]
        -- upvalues: l__Notes__1 (copy)
        return #l__Notes__1;
    end,
    GetGameNotes = function(p1) --[[ Name: GetGameNotes, Line 13 ]]
        -- upvalues: l__Notes__1 (copy)
        return l__Notes__1[p1 or 1];
    end,
    DestroyNoteInfo = function(p2) --[[ Name: DestroyNoteInfo, Line 17 ]]
        for _, v3 in p2.Instances do
            v3:Destroy();
        end;
        for _, v4 in p2.Events do
            v4:Disconnect();
        end;
    end
};
function u5.CreateGameNotes(p6, u7) --[[ Line: 26 ]]
    -- upvalues: u5 (copy)
    local v8 = u5.GetGameNotes(p6 or 1);
    local l__Content__2 = v8.Content;
    local v9 = {
        Instances = {},
        Events = {},
        Destroy = u5.DestroyNoteInfo
    };
    for v10, v11 in ipairs(l__Content__2) do
        local v12, v13, v14 = table.unpack(v11);
        local u15 = nil;
        if v12 == "Header" then
            u15 = script.Header:Clone();
            u15.LayoutOrder = v10;
            u15.WorldBackground.Image = v13;
        elseif v12 == "Title" then
            u15 = script.Title:Clone();
            u15.LayoutOrder = v10;
            u15.Text = v13;
        elseif v12 == "SubTitle" then
            u15 = script.SubTitle:Clone();
            u15.LayoutOrder = v10;
            u15.Text = v13;
        elseif v12 == "Divider" then
            u15 = script.Divider:Clone();
            u15.LayoutOrder = v10;
        elseif v12 == "Body" then
            u15 = script.Text:Clone();
            u15.LayoutOrder = v10;
            u15.Text = v13;
            local function v16() --[[ Line: 67 ]]
                -- upvalues: u15 (copy), u7 (copy), u5 (ref)
                u15.TextScaled = false;
                u15.TextSize = math.round(u7.AbsoluteSize.X * u5.Size);
            end;
            task.defer(v16);
            v9.Events[{}] = u7:GetPropertyChangedSignal("AbsoluteSize"):Connect(v16);
            v9.Events[{}] = u15:GetPropertyChangedSignal("TextBounds"):Connect(function() --[[ Line: 73 ]]
                -- upvalues: u15 (copy)
                u15.Size = UDim2.new(1, 0, 0, u15.TextBounds.Y);
            end);
        elseif v12 == "Image" then
            u15 = script.Image:Clone();
            u15.LayoutOrder = v10;
            u15.Image = v13;
            u15.UIAspectRatioConstraint.AspectRatio = v14;
        end;
        u15.Parent = u7;
        table.insert(v9.Instances, u15);
    end;
    return v9, v8;
end;
return u5;
