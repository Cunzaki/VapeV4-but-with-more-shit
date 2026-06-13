-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.Debug.ConfigHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Signal__2 = require(l__ReplicatedStorage__1.Modules.Signal);
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__3:Get("InterfaceHandler");
local u2 = l__Mince__3:GetFunction("GetConfig");
local u3 = l__Mince__3:GetEvent("UpdateConfig");
local u4 = {
    IsLoaded = false,
    ConfigUIs = {},
    Loaded = l__Signal__2.new()
};
function u4.WaitUntilConfigValue(p5) --[[ Line: 19 ]]
    -- upvalues: u4 (copy)
    if not u4.IsLoaded then
        u4.Loaded:Wait();
    end;
    return u4.LocalConfigs[p5];
end;
function u4.UpdateForChanges() --[[ Line: 27 ]]
    -- upvalues: u4 (copy)
    for v6, v7 in u4.LocalConfigs do
        local v8 = u4.ConfigUIs[v6];
        if not v8 then
            v8 = script.StatText:Clone();
            v8.Parent = u4.MainFrame;
        end;
        v8.Text = `Config[{v6}]={v7}`;
    end;
end;
function u4.Setup() --[[ Line: 39 ]]
    -- upvalues: u1 (copy), u4 (copy), u2 (copy), u3 (copy)
    u4.MainFrame = u1.GetScreenGui("MainPriority").ABTest;
    u4.LocalConfigs = u2:Invoke();
    u3.Event:Connect(function(p9) --[[ Line: 44 ]]
        -- upvalues: u4 (ref)
        u4.LocalConfigs = p9;
        u4.UpdateForChanges();
    end);
    u4.UpdateForChanges();
    local v10 = script.StatText:Clone();
    v10.Text = "== Local Config Values (Use For A/B) ==";
    v10.Parent = u4.MainFrame;
    v10.LayoutOrder = -1;
    u4.IsLoaded = true;
    u4.Loaded:Fire();
end;
return u4;
