-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.HideDuringCutscene
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local v1 = {};
local u2 = require(l__ReplicatedStorage__1.Modules.Mince).Component({
    Tag = "HideDuringCutscene"
});
function u2.Construct(p3) --[[ Line: 10 ]]
    p3.DesiredParent = p3.Instance.Parent;
end;
function u2.Hide(p4) --[[ Line: 14 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy)
    p4.Instance.Parent = l__ReplicatedStorage__1;
end;
function u2.Show(p5) --[[ Line: 18 ]]
    p5.Instance.Parent = p5.DesiredParent;
end;
function v1.HideAll() --[[ Line: 22 ]]
    -- upvalues: u2 (copy)
    for _, v6 in u2:GetAll() do
        v6:Hide();
    end;
end;
function v1.ShowAll() --[[ Line: 28 ]]
    -- upvalues: u2 (copy)
    for _, v7 in u2:GetAll() do
        v7:Show();
    end;
end;
return v1;
