-- On Tap challenge place loader (GameId 14104248348)
local paths = {
	'newvape/games/14104248348.lua',
	'games/14104248348.lua',
}
for _, path in paths do
	if isfile and isfile(path) then
		loadstring(readfile(path), '14104248348')()
		return
	end
end
