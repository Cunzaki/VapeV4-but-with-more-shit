-- Decompiled from: ReplicatedStorage.Client.Source.ProximityManager
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ProximityPromptService__1 = game:GetService("ProximityPromptService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local l__PlayerGui__3 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
local l__Maid__4 = require(l__ReplicatedStorage__2.Modules.Maid);
local l__Mince__5 = require(l__ReplicatedStorage__2.Modules.Mince);
local l__Signal__6 = require(l__ReplicatedStorage__2.Modules.Signal);
local l__Utility__7 = require(l__ReplicatedStorage__2.Modules.Utility);
local u1 = l__Mince__5:Get("BindManager");
local u2 = {
    ScreenGuiName = "__ProximityHandler",
    Enabled = true,
    CustomPrompts = {},
    WaitingThreads = {},
    Controllers = {},
    TranslateMethods = {
        TriggerEnded = "TriggerEnded",
        Triggered = "Triggered",
        HoldEnded = "PromptButtonHoldEnded",
        HoldBegan = "PromptButtonHoldBegan"
    }
};
local u3 = {};
u3.__index = u3;
function u3.new(p4) --[[ Line: 36 ]]
    -- upvalues: u2 (copy), u1 (copy), u3 (copy)
    local v5 = {
        ProximityPrompt = p4,
        ProxTable = {
            ProximityPrompt = p4,
            ScreenGui = u2:GetScreenGui(),
            InputObjects = {
                Computer = u1.GetObject(p4.KeyboardKeyCode),
                Mobile = u1.GetObject(Enum.UserInputType.Touch),
                Console = u1.GetObject(p4.GamepadKeyCode)
            }
        }
    };
    local v6 = setmetatable(v5, u3);
    v6:Init();
    u2.CustomPrompts[p4] = v6;
    return v6;
end;
function u3.GetProxTable(p7) --[[ Line: 58 ]]
    return table.clone(p7.ProxTable);
end;
function u3.Init(u8) --[[ Line: 62 ]]
    -- upvalues: l__Maid__4 (copy), l__Signal__6 (copy), u1 (copy)
    u8.InstancingMaid = l__Maid__4.new();
    u8.Maid = l__Maid__4.new();
    u8.InputsChanged = l__Signal__6.new();
    u8.TimesShown = 0;
    u8.Maid:Add(u8.ProximityPrompt.Destroying:Connect(function() --[[ Line: 70 ]]
        -- upvalues: u8 (copy)
        u8:Destroy();
    end));
    u8.Maid:Add(u8.ProximityPrompt:GetPropertyChangedSignal("KeyboardKeyCode"):Connect(function() --[[ Line: 74 ]]
        -- upvalues: u8 (copy), u1 (ref)
        u8.ProxTable.InputObjects.Computer = u1.GetObject(u8.ProximityPrompt.KeyboardKeyCode);
        u8:DetermineInputObject();
        u8.InputsChanged:Fire();
    end));
    u8.Maid:Add(u8.ProximityPrompt:GetPropertyChangedSignal("GamepadKeyCode"):Connect(function() --[[ Line: 80 ]]
        -- upvalues: u8 (copy), u1 (ref)
        u8.ProxTable.InputObjects.Console = u1.GetObject(u8.ProximityPrompt.GamepadKeyCode);
        u8:DetermineInputObject();
        u8.InputsChanged:Fire();
    end));
    u8.Maid:Add(u1.ModeChanged:Connect(function() --[[ Line: 86 ]]
        -- upvalues: u8 (copy)
        u8:DetermineInputObject();
        u8.InputsChanged:Fire();
    end));
    u8.ProxTable.InstancingMaid = u8.InstancingMaid;
    u8:DetermineInputObject();
end;
function u3.DetermineInputObject(p9) --[[ Line: 95 ]]
    -- upvalues: u1 (copy)
    p9.ProxTable.InputObject = p9.ProxTable.InputObjects[u1:GetMode()] or p9.ProxTable.InputObjects.Computer;
end;
function u3.Destroy(p10) --[[ Line: 99 ]]
    p10.Maid:Clean();
    p10.InstancingMaid:Clean();
end;
function u2.SetAllEnabled(_, p11) --[[ Line: 104 ]]
    -- upvalues: u2 (copy)
    if p11 == u2.Enabled then
    else
        u2.Enabled = p11;
        if not u2.Enabled then
            for _, v12 in u2.WaitingThreads do
                if coroutine.status(v12) == "suspended" then
                    task.spawn(v12);
                end;
            end;
        end;
    end;
end;
function u2.GetScreenGui(_) --[[ Line: 119 ]]
    -- upvalues: l__PlayerGui__3 (copy), u2 (copy)
    local v13 = l__PlayerGui__3:FindFirstChild(u2.ScreenGuiName);
    if not v13 then
        v13 = Instance.new("ScreenGui", l__PlayerGui__3);
        v13.Name = u2.ScreenGuiName;
        v13.ResetOnSpawn = false;
    end;
    return v13;
end;
function u2.PromptShown(p14) --[[ Line: 129 ]]
    -- upvalues: u2 (copy), l__Utility__7 (copy), u3 (copy)
    if u2.Enabled then
        if p14.Style == Enum.ProximityPromptStyle.Custom then
            local v15 = p14:GetAttribute("Type");
            if v15 then
                assert(l__Utility__7.AssertTypes(v15, "string"));
                local u16 = u2.Controllers[v15];
                if u16 then
                    local v17 = u2.CustomPrompts[p14] or u3.new(p14);
                    local v18 = v17:GetProxTable();
                    local u19 = setmetatable(v18, {
                        __index = u16
                    });
                    v17.TimesShown = v17.TimesShown + 1;
                    v17.InstancingMaid:Add(v17.InputsChanged:Connect(function() --[[ Line: 144 ]]
                        -- upvalues: u16 (copy), u19 (copy)
                        if u16.InputsChanged then
                            u16.InputsChanged(u19);
                        end;
                    end));
                    function u19.Simulate(p20, p21) --[[ Line: 151 ]]
                        -- upvalues: u16 (copy)
                        if u16[p21] then
                            u16[p21](p20);
                        end;
                    end;
                    for u22, v23 in u2.TranslateMethods do
                        if u16[u22] then
                            v17.InstancingMaid:Add(p14[v23]:Connect(function(...) --[[ Line: 159 ]]
                                -- upvalues: u16 (copy), u22 (copy), u19 (copy)
                                u16[u22](u19, ...);
                            end));
                        end;
                    end;
                    u16.Appear(u19);
                    local u24 = coroutine.running();
                    local v25 = p14.PromptHidden:Once(function() --[[ Line: 168 ]]
                        -- upvalues: u24 (copy)
                        task.spawn(u24);
                    end);
                    u2.WaitingThreads[u24] = u24;
                    coroutine.yield();
                    u2.WaitingThreads[u24] = nil;
                    v25:Disconnect();
                    v17.InstancingMaid:Clean();
                    u16.Hidden(u19);
                end;
            end;
        end;
    end;
end;
function u2.ValidateController(p26) --[[ Line: 182 ]]
    assert(p26.Appear, "ProximityController.Appear is a required value.");
    assert(p26.Hidden, "ProximityController.Hidden is a required value.");
    return true;
end;
function u2.SetupScripts(_) --[[ Line: 188 ]]
    -- upvalues: u2 (copy)
    for _, v27 in script:GetChildren() do
        if v27:IsA("ModuleScript") then
            local v28 = require(v27);
            if u2.ValidateController(v28) then
                u2.Controllers[v28.Name or v27.Name] = v28;
            end;
        end;
    end;
end;
function u2.Setup(_) --[[ Line: 205 ]]
    -- upvalues: l__ProximityPromptService__1 (copy), u2 (copy)
    l__ProximityPromptService__1.PromptShown:Connect(u2.PromptShown);
    u2:SetupScripts();
end;
return u2;
