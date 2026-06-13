-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Core.Note
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
l__Mince__2:Get("BindManager");
local u1 = l__Mince__2:Get("SoundHandler");
local u2 = l__Mince__2:Get("InterfaceHandler");
local u3 = l__Mince__2:Get("SelectInteractor");
local u4 = l__Mince__2.Component({
    Tag = "Note"
});
function u4.OpenNote(p5) --[[ Line: 16 ]]
    -- upvalues: u4 (copy), u1 (copy)
    if u4.IsNoteActive then
    else
        u4.IsNoteActive = true;
        u4.CurrentNode = p5;
        u4.Blur = Instance.new("BlurEffect", game.Lighting);
        u4.CenterNote.Visible = true;
        u4.CenterNote.Note.Image = p5.Image;
        u4.CenterNote.Note.UIAspectRatioConstraint.AspectRatio = p5.AspectRatio;
        u1.PlaySound("PageTurn");
    end;
end;
function u4.CloseCurrentNote() --[[ Line: 30 ]]
    -- upvalues: u4 (copy), u3 (copy)
    u4.CenterNote.Visible = false;
    if u4.Blur then
        u4.Blur:Destroy();
    end;
    u4.Blur = nil;
    if u4.IsNoteActive then
        u4.IsNoteActive = false;
        u3.EndInteractions();
    end;
end;
function u4.Construct(p6) --[[ Line: 43 ]]
    -- upvalues: u4 (copy), u3 (copy)
    assert(p6.Image, "Image is missing");
    assert(p6.AspectRatio, "Requires a aspect ratio");
    p6.HoverName = "Menu";
    p6.HitCollider = p6.Instance;
    function p6.Interact(p7, _) --[[ Line: 49 ]]
        -- upvalues: u4 (ref)
        u4.OpenNote(p7);
    end;
    u3.NewInteractionClass(p6);
end;
function u4.Removing(p8) --[[ Line: 56 ]]
    -- upvalues: u3 (copy)
    u3.CollapseClass(p8);
end;
function u4.SetupUI() --[[ Line: 60 ]]
    -- upvalues: u2 (copy), u4 (copy)
    u2.NewButton(u4.CenterNote.Note.Bottom.Back).Activated:Connect(u4.CloseCurrentNote);
end;
function u4.Setup() --[[ Line: 66 ]]
    -- upvalues: u4 (copy), u2 (copy)
    u4.MainPriority = u2.GetScreenGui("MainPriority");
    u4.CenterNote = u4.MainPriority.NoteContainer.Center;
    u4.SetupUI();
end;
return u4;
