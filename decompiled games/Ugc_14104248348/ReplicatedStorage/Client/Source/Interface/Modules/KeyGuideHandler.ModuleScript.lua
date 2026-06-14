-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.KeyGuideHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("UserInputService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
game:GetService("RunService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.Signal);
require(l__ReplicatedStorage__1.Modules.Utility);
local u1 = l__Mince__3:Get("InterfaceHandler");
local u2 = l__Mince__3:Get("BindManager");
local u3 = {
    GuideObjects = {}
};
function u3.Clear() --[[ Line: 19 ]]
    -- upvalues: u3 (copy)
    for _, v4 in u3.GuideObjects do
        for _, v5 in v4.Events do
            v5:Disconnect();
        end;
        v4.Gui:Destroy();
    end;
    u3.GuideObjects = {};
end;
function u3.CreateGuides(p6) --[[ Line: 31 ]]
    -- upvalues: u3 (copy), l__ReplicatedStorage__1 (copy), l__TweenService__2 (copy), u2 (copy)
    u3.Clear();
    local v7 = typeof(p6) == "table";
    assert(v7, "!Error!");
    for _, v8 in p6 do
        local v9 = typeof(v8) == "table";
        assert(v9, "Invalid GuideObject ");
        assert(v8.Bind, "No bind attached to GuildeObject");
        local v10 = {};
        local u11 = l__ReplicatedStorage__1.Assets.Interface.KeyItem:Clone();
        u11.Parent = u3.MainPriority.Right.KeyGuide;
        local v12 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local u13 = {
            Press = l__TweenService__2:Create(u11.KeyImage, v12, {
                Size = u11.KeyImage.Size - UDim2.new(0.03, 0, 0.03, 0)
            }),
            Default = l__TweenService__2:Create(u11.KeyImage, v12, {
                Size = u11.KeyImage.Size
            })
        };
        local u14 = u2.Get(v8.Bind);
        local v15 = u14:GetPrimaryVisualObject();
        v10.ModeChange = u2.ModeChanged:Connect(function() --[[ Line: 62 ]]
            -- upvalues: u14 (copy), u11 (copy)
            local v16 = u14:GetPrimaryVisualObject();
            if v16.Type == "Image" then
                u11.KeyImage.Image = v16.Value;
            end;
        end);
        v10.BindEvent = u14.OnAction:Connect(function(p17) --[[ Line: 65 ]]
            -- upvalues: u13 (copy)
            if p17 == Enum.UserInputState.Begin then
                u13.Press:Play();
            else
                if p17 == Enum.UserInputState.End then
                    u13.Default:Play();
                end;
            end;
        end);
        if v15.Type == "Image" then
            u11.KeyImage.Image = v15.Value;
        end;
        u11.BindName.Text = v8.Name or u14:GetName();
        if v8.Meta then
            u11.KeyImage.MetaText.Text = v8.Meta;
        else
            u11.KeyImage.MetaText.Text = "";
        end;
        table.insert(u3.GuideObjects, {
            Events = v10,
            Gui = u11
        });
    end;
end;
function u3.Setup() --[[ Line: 92 ]]
    -- upvalues: u3 (copy), u1 (copy)
    u3.MainPriority = u1.GetScreenGui("MainPriority");
end;
return u3;
