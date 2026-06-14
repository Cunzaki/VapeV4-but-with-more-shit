-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.UserGenerated.Store.UGCStandManager
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__MarketplaceService__1 = game:GetService("MarketplaceService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__CollectionService__3 = game:GetService("CollectionService");
local l__Signal__4 = require(l__ReplicatedStorage__2.Modules.Signal);
require(l__ReplicatedStorage__2.Modules.Mince);
local u1 = require(l__ReplicatedStorage__2.Modules.Queue).new(0.5);
u1:RunPushedFunctions();
local u2 = {
    Tags = {
        UGCStand = "UGCStand",
        UGCInteract = "UGCInteract"
    },
    UGCStands = {},
    InteractBegin = l__Signal__4.new(),
    TotalAccessoryChoices = {},
    CachedProductInfo = {},
    StringToAcessoryType = {
        Hat = Enum.AccessoryType.Hat,
        Face = Enum.AccessoryType.Face,
        Back = Enum.AccessoryType.Back,
        Front = Enum.AccessoryType.Front,
        Neck = Enum.AccessoryType.Neck,
        Waist = Enum.AccessoryType.Waist,
        Shirt = Enum.AccessoryType.Shirt,
        Jacket = Enum.AccessoryType.Jacket,
        TShirt = Enum.AccessoryType.TShirt,
        Shoulder = Enum.AccessoryType.Shoulder,
        Pants = Enum.AccessoryType.Pants,
        Hair = Enum.AccessoryType.Hair,
        Shorts = Enum.AccessoryType.Shorts,
        Sweater = Enum.AccessoryType.Sweater,
        Eyebrow = Enum.AccessoryType.Eyebrow,
        Eyelash = Enum.AccessoryType.Eyelash,
        DressSkirt = Enum.AccessoryType.DressSkirt
    }
};
function u2.GetProductInfo(u3, u4) --[[ Line: 47 ]]
    -- upvalues: u2 (copy), l__MarketplaceService__1 (copy), u1 (copy)
    if u2.CachedProductInfo[u3] then
        return u2.CachedProductInfo[u3];
    end;
    local u5 = nil;
    local u6 = coroutine.running();
    local function u9() --[[ Line: 51 ]]
        -- upvalues: l__MarketplaceService__1 (ref), u3 (copy), u4 (copy), u1 (ref), u9 (ref), u5 (ref), u2 (ref), u6 (copy)
        local v7, v8 = pcall(function() --[[ Line: 52 ]]
            -- upvalues: l__MarketplaceService__1 (ref), u3 (ref), u4 (ref)
            return l__MarketplaceService__1:GetProductInfo(u3, u4);
        end);
        if v7 then
            u5 = v8;
            u2.CachedProductInfo[u3] = v8;
            task.spawn(u6);
        else
            warn("Request failure! ->", v8);
            u1:Push(u9);
        end;
    end;
    u1:Push(u9);
    coroutine.yield();
    return u5;
end;
function u2.ClearStand() --[[ Line: 75 ]]
    -- upvalues: u2 (copy)
    u2.SelectedStand = nil;
    for _, v10 in u2.UGCStands do
        v10.ProximityPrompt.Enabled = true;
    end;
end;
function u2.SelectStand(p11) --[[ Line: 83 ]]
    -- upvalues: u2 (copy)
    u2.SelectedStand = p11;
    for _, v12 in u2.UGCStands do
        v12.ProximityPrompt.Enabled = false;
    end;
    u2.InteractBegin:Fire(p11);
end;
function u2.CreateInteractor(p13) --[[ Line: 93 ]]
    -- upvalues: u2 (copy)
    local l__AttachedItems__5 = p13:WaitForChild("AttachedItems", 5);
    assert(l__AttachedItems__5 ~= nil, "In order for the UGCStand to be valid it requires at config called attachedItems.");
    local v14 = Instance.new("Configuration");
    v14.Name = "UGCInteract";
    v14.Parent = u2.UGCStandFolder;
    p13.Name = "Proximity";
    p13.Parent = v14;
    p13.Anchored = true;
    p13.Transparency = 1;
    local u15 = {
        AcessoryChoices = {}
    };
    function u15.LoadNewAcessoryChoice(p16) --[[ Line: 111 ]]
        -- upvalues: u2 (ref), u15 (copy)
        local v17 = p16:IsA("Configuration");
        assert(v17, "Invalid. AcessoryChoice must be an configuration.");
        local u18 = p16:GetAttributes();
        local l__AccessoryType__6 = u18.AccessoryType;
        u18.AccessoryType = u2.StringToAcessoryType[u18.AccessoryType];
        local v19 = typeof(u18.AcessoryType) ~= "EnumItem";
        local v20 = `Invalid acessory type '{l__AccessoryType__6}' check StringConversion.`;
        assert(v19, v20);
        u18.AssetID = tonumber(u18.AssetID);
        assert(u18.AssetID ~= nil, "AcessoryType.AssetID is required.");
        u18.HumanoidAcessoryTable = {
            AssetId = u18.AssetID,
            AccessoryType = u18.AccessoryType
        };
        local function v27() --[[ Line: 129 ]]
            -- upvalues: u2 (ref), u18 (copy)
            local v21 = u2.GetProductInfo(u18.AssetID, Enum.InfoType.Asset);
            local v22 = string.split(v21.Name, " ");
            for v23, v24 in v22 do
                v22[v23] = string.lower(v24);
            end;
            u18.Keywords = v22;
            u18.KeywordCount = #v22;
            local v25 = {};
            for _, v26 in u18.Keywords do
                v25[v26] = true;
            end;
            u18.KeywordsLookup = v25;
            u18.ProductInfo = v21;
        end;
        table.insert(u2.TotalAccessoryChoices, u18);
        task.spawn(v27);
        table.insert(u15.AcessoryChoices, u18);
    end;
    for _, v28 in l__AttachedItems__5:GetChildren() do
        u15.LoadNewAcessoryChoice(v28);
    end;
    l__AttachedItems__5.ChildAdded:Connect(function(p29) --[[ Line: 159 ]]
        -- upvalues: u15 (copy)
        u15.LoadNewAcessoryChoice(p29);
    end);
    local v30 = Instance.new("ProximityPrompt");
    v30:SetAttribute("Type", "Radial");
    v30.ObjectText = "View Items";
    v30.MaxActivationDistance = 10;
    v30.Style = Enum.ProximityPromptStyle.Custom;
    v30.Parent = p13;
    v30.RequiresLineOfSight = false;
    v30.TriggerEnded:Connect(function() --[[ Line: 172 ]]
        -- upvalues: u2 (ref), u15 (copy)
        u2.SelectStand(u15);
    end);
    u15.ProximityPrompt = v30;
    table.insert(u2.UGCStands, u15);
end;
function u2.CreateStand(p31) --[[ Line: 181 ]]
    -- upvalues: u2 (copy), l__ReplicatedStorage__2 (copy)
    local l__AttachedItems__7 = p31:WaitForChild("AttachedItems", 5);
    assert(l__AttachedItems__7 ~= nil, "In order for the UGCStand to be valid it requires at config called attachedItems.");
    local v32 = Instance.new("Configuration");
    v32.Name = "UGCStand";
    v32.Parent = u2.UGCStandFolder;
    local u33 = l__ReplicatedStorage__2.Assets.BaseDummy:Clone();
    local l__HumanoidRootPart__8 = u33:WaitForChild("HumanoidRootPart");
    local l__Humanoid__9 = u33:WaitForChild("Humanoid");
    local v34 = u33:GetExtentsSize();
    local v35 = CFrame.new(p31.Position - p31.Size.Y * Vector3.new(0, 1, 0) * 0.5 + v34 * Vector3.new(0, 1, 0) * 0.5) * p31.CFrame.Rotation;
    l__AttachedItems__7.Parent = v32;
    p31:Destroy();
    u33.Parent = v32;
    l__HumanoidRootPart__8.Anchored = true;
    u33:PivotTo(v35);
    local u36 = {
        AcessoryChoices = {}
    };
    function u36.UpdateAcessoriesOnDummy() --[[ Line: 211 ]]
        -- upvalues: l__Humanoid__9 (copy), u36 (copy), u33 (copy), l__ReplicatedStorage__2 (ref)
        local v37 = l__Humanoid__9:GetAppliedDescription();
        local v38 = {};
        for _, v39 in u36.AcessoryChoices do
            if v39.ShowOnCharacter then
                table.insert(v38, v39.HumanoidAcessoryTable);
            end;
        end;
        v37:SetAccessories(v38, true);
        l__Humanoid__9:ApplyDescription(v37);
        local v40 = u33:FindFirstChildOfClass("BodyColors");
        if v40 then
            v40:Destroy();
        end;
        l__ReplicatedStorage__2.Assets.StandColors:Clone().Parent = u33;
    end;
    function u36.LoadNewAcessoryChoice(p41) --[[ Line: 233 ]]
        -- upvalues: u2 (ref), u36 (copy)
        local v42 = p41:IsA("Configuration");
        assert(v42, "Invalid. AcessoryChoice must be an configuration.");
        local v43 = p41:GetAttributes();
        local l__AccessoryType__10 = v43.AccessoryType;
        v43.AccessoryType = u2.StringToAcessoryType[v43.AccessoryType];
        local v44 = typeof(v43.AcessoryType) ~= "EnumItem";
        local v45 = `Invalid acessory type '{l__AccessoryType__10}' check StringConversion.`;
        assert(v44, v45);
        v43.AssetID = tonumber(v43.AssetID);
        assert(v43.AssetID ~= nil, "AcessoryType.AssetID is required.");
        v43.HumanoidAcessoryTable = {
            AssetId = v43.AssetID,
            AccessoryType = v43.AccessoryType
        };
        table.insert(u36.AcessoryChoices, v43);
    end;
    for _, v46 in l__AttachedItems__7:GetChildren() do
        u36.LoadNewAcessoryChoice(v46);
    end;
    task.defer(u36.UpdateAcessoriesOnDummy);
    l__AttachedItems__7.ChildAdded:Connect(function(p47) --[[ Line: 258 ]]
        -- upvalues: u36 (copy)
        u36.LoadNewAcessoryChoice(p47);
        u36.UpdateAcessoriesOnDummy();
    end);
    local v48 = Instance.new("ProximityPrompt");
    v48:SetAttribute("Type", "Radial");
    v48.ObjectText = "View Items";
    v48.MaxActivationDistance = 20;
    v48.Style = Enum.ProximityPromptStyle.Custom;
    v48.Parent = l__HumanoidRootPart__8;
    v48.RequiresLineOfSight = false;
    u36.ProximityPrompt = v48;
    v48.TriggerEnded:Connect(function() --[[ Line: 273 ]]
        -- upvalues: u2 (ref), u36 (copy)
        u2.SelectStand(u36);
    end);
    table.insert(u2.UGCStands, u36);
    return u36;
end;
function u2.Setup() --[[ Line: 281 ]]
    -- upvalues: u2 (copy), l__CollectionService__3 (copy)
    local v49 = Instance.new("Folder");
    v49.Name = "UGCStands";
    v49.Parent = game.Workspace;
    u2.UGCStandFolder = v49;
    for _, v50 in l__CollectionService__3:GetTagged(u2.Tags.UGCInteract) do
        u2.CreateInteractor(v50);
    end;
    l__CollectionService__3:GetInstanceAddedSignal(u2.Tags.UGCInteract):Connect(function(p51) --[[ Line: 292 ]]
        -- upvalues: u2 (ref)
        u2.CreateInteractor(p51);
    end);
    for _, v52 in l__CollectionService__3:GetTagged(u2.Tags.UGCStand) do
        u2.CreateStand(v52);
    end;
    l__CollectionService__3:GetInstanceAddedSignal(u2.Tags.UGCStand):Connect(function(p53) --[[ Line: 298 ]]
        -- upvalues: u2 (ref)
        u2.CreateStand(p53);
    end);
end;
return u2;
