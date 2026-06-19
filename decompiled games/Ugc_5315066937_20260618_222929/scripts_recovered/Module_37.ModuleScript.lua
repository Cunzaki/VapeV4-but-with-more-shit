-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__CurrentCamera__1 = workspace.CurrentCamera;
if l__CurrentCamera__1 == nil then
    l__CurrentCamera__1 = Instance.new("Camera", workspace);
    workspace.CurrentCamera = l__CurrentCamera__1;
end;
return l__CurrentCamera__1;
