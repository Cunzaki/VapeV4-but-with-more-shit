-- Decompiled from: ReplicatedStorage.Config.Shared.ChatFormatting
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    PlayerRankTags = {
        Whimsical = {},
        FouledAnchors = {},
        Developer = {}
    },
    TagIndexes = {
        Dev = "<font color=\'#F5CD30\'>[⚒️]</font>"
    },
    TextFormats = {
        Emoji = "<font color=\'#FFFFFF\'>[%s]</font>"
    },
    LocalChannelPrefixSpeaker = {
        TTS = `<font color="#{Color3.new(0.807843, 0.937255, 1):ToHex()}">[TTS] %s |</font>`
    },
    ChannelFormats = {
        GameSystem = `<i><font color="#{Color3.new(0, 0.615686, 1):ToHex()}">System |</font> <font color="#{Color3.new(0.380392, 0.835294, 1):ToHex()}">%s</font></i>`,
        GameLocal = `<font color="#{Color3.new(1, 0, 1):ToHex()}">Game |</font> <font color="#{Color3.new(1, 0.380392, 1):ToHex()}">%s</font>`,
        GameGlobal = `<font color="#{Color3.new(1, 0.513725, 0.0235294):ToHex()}">Global |</font> <font color="#{Color3.new(1, 0.690196, 0.380392):ToHex()}">%s</font>`,
        GameSystem2 = `<stroke thickness="1"><font color="{Color3.new(0, 0.615686, 1):ToHex()}">System:</font></stroke>%s`
    }
};
