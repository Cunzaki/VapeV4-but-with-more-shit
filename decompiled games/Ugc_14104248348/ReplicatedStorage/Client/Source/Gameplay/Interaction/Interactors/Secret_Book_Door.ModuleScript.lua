-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Interaction.Interactors.Secret_Book_Door
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local _ = game:GetService("Players").LocalPlayer;
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__ModelTweenOG__4 = require(game.ReplicatedStorage.Modules.ModelTweenOG);
l__Mince__3:Get("SoundHandler");
local u1 = l__Mince__3:Get("SelectInteractor");
local u5 = {
    BookTween = TweenInfo.new(0.5, Enum.EasingStyle.Sine),
    WallTween = TweenInfo.new(2, Enum.EasingStyle.Linear),
    SetupSwitch = function(u2) --[[ Name: SetupSwitch, Line 19 ]]
        -- upvalues: l__TweenService__2 (copy), u1 (copy)
        local l__Lever__5 = u2.Switch:WaitForChild("Lever");
        local l__Plate__6 = u2.Switch:WaitForChild("Plate");
        u1.NewInteractionClass({
            HoverName = "Pull Switch",
            Target = u2.Switch,
            HitCollider = l__Plate__6,
            Interact = function(_, p3) --[[ Name: Interact, Line 30 ]]
                -- upvalues: u2 (copy), l__Lever__5 (copy), l__Plate__6 (copy), l__TweenService__2 (ref)
                warn("request!");
                u2.Request("Exit");
                local v4 = l__Lever__5.CFrame:ToWorldSpace(CFrame.Angles(0, 0, -3.141592653589793) * CFrame.new(0, l__Lever__5.Size.Y, 0));
                l__Plate__6.Switch:Play();
                l__TweenService__2:Create(l__Lever__5, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out, 0, true), {
                    CFrame = v4
                }):Play();
                task.wait(0.5);
                p3();
            end
        });
    end
};
function u5.SetupBook(u6, u7) --[[ Line: 48 ]]
    -- upvalues: u1 (copy), l__ModelTweenOG__4 (copy), u5 (copy)
    local l__CFrame__7 = u7.CFrame;
    local u8 = u7.CFrame:ToWorldSpace(CFrame.new(0.5, 0, 0));
    table.insert(u6.BooksList, u7);
    local u10 = {
        HoverName = "Pull Book",
        Target = u7,
        HitCollider = u7,
        Interact = function(_, p9) --[[ Name: Interact, Line 61 ]]
            -- upvalues: u6 (copy), u7 (copy)
            u6.Request("PushBook", u7);
            task.wait(0.5);
            p9();
        end
    };
    u1.NewInteractionClass(u10);
    local function v13() --[[ Line: 70 ]]
        -- upvalues: u7 (copy), u1 (ref), u6 (copy), u10 (copy), l__ModelTweenOG__4 (ref), u5 (ref), u8 (copy), l__CFrame__7 (copy)
        local v11 = u7:GetAttribute("Pushed");
        for _, v12 in u1.GetSelections() do
            if v12 == u6 and v12.CurrentSource then
                v12.CurrentSource:Unselect();
            end;
        end;
        u10.HoverName = v11 and "Pull Book" or "Push Book";
        if v11 then
            l__ModelTweenOG__4.new(u7, u5.BookTween, u8):Play();
        else
            l__ModelTweenOG__4.new(u7, u5.BookTween, l__CFrame__7):Play();
        end;
    end;
    u7:GetAttributeChangedSignal("Pushed"):Connect(v13);
    task.defer(v13);
end;
function u5.ConfigChanged(u14, p15) --[[ Line: 91 ]]
    -- upvalues: l__ModelTweenOG__4 (copy), u5 (copy)
    if p15 == "Opened" then
        if u14.Config.Opened then
            u14.SlideSound:Play();
            local v16 = l__ModelTweenOG__4.new(u14.Wall, u5.WallTween, u14.WallEnd);
            v16.Finished:Connect(function() --[[ Line: 97 ]]
                -- upvalues: u14 (copy)
                u14.SlideSound:Stop();
                u14.SlideSound.TimePosition = 0;
            end);
            v16:Play();
        else
            u14.SlideSound:Play();
            local v17 = l__ModelTweenOG__4.new(u14.Wall, u5.WallTween, u14.WallStart);
            v17.Finished:Connect(function() --[[ Line: 105 ]]
                -- upvalues: u14 (copy)
                u14.SlideSound:Stop();
                u14.SlideSound.TimePosition = 0;
            end);
            v17:Play();
        end;
        for _, v18 in u14.BooksList do
            v18.LocalTransparencyModifier = u14.Config.Opened and 1 or 0;
        end;
    end;
end;
function u5.SetupBooks(p19) --[[ Line: 118 ]]
    for _, v20 in p19.Books:GetChildren() do
        p19:SetupBook(v20);
    end;
end;
function u5.Created(p21) --[[ Line: 124 ]]
    -- upvalues: u5 (copy)
    p21.Wall = p21.Item:WaitForChild("Wall");
    p21.Books = p21.Item:WaitForChild("Books");
    p21.Switch = p21.Item:WaitForChild("Switch");
    p21.WallStart = p21.Wall:GetPivot();
    p21.WallEnd = p21.WallStart - Vector3.new(0, 22, 0);
    p21.SlideSound = p21.Wall.Source.Slide;
    p21.BooksList = {};
    p21.SetupSwitch = u5.SetupSwitch;
    p21.SetupBook = u5.SetupBook;
    p21.SetupBooks = u5.SetupBooks;
    p21:SetupSwitch();
    p21:SetupBooks();
end;
return u5;
