-- REDLINER FFA place loader (GameId 7265339759)
local paths = {
	'newvape/games/redliner_shared.lua',
	'games/redliner_shared.lua',
}
for _, path in paths do
	if isfile and isfile(path) then
		loadstring(readfile(path), 'redliner')()
		return
	end
end
