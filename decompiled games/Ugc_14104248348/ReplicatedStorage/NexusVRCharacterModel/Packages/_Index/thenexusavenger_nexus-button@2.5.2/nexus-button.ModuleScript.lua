-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_nexus-button@2.5.2.nexus-button
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ButtonFactory__1 = require(script:WaitForChild("Factory"):WaitForChild("ButtonFactory"));
local l__TextButtonFactory__2 = require(script:WaitForChild("Factory"):WaitForChild("TextButtonFactory"));
require(script:WaitForChild("Packages"):WaitForChild("NexusInstance"));
local l__Button__3 = require(script:WaitForChild("Button"));
local v1 = {
    ButtonFactory = l__ButtonFactory__1,
    TextButtonFactory = l__TextButtonFactory__2,
    ControllerIcon = require(script:WaitForChild("ControllerIcon")),
    ThemedFrame = require(script:WaitForChild("ThemedFrame"))
};
return setmetatable(v1, l__Button__3);
