--[[
	Quick wrapper — 5 second poll.
	For full dump use tools/fallen_anticheat_offset_dumper.lua directly (30s default).
]]
getgenv().FallenDumperPollSeconds = getgenv().FallenDumperPollSeconds or 5
return loadstring(readfile("tools/fallen_anticheat_offset_dumper.lua"), "fallen_ac_dumper")()
