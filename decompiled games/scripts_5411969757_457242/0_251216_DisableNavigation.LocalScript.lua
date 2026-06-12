-- Decompiled with Potassium's decompiler.

game:GetService("GuiService");
game:GetService("ContextActionService"):BindAction("EnableKeyboardUINavigation", function(_, _, _) --[[ Name: EnableKeyboardNavigation, Line 4 ]]
    return Enum.ContextActionResult.Sink;
end, false, Enum.KeyCode.BackSlash);