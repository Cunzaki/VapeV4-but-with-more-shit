repeat task.wait() until game:IsLoaded()
if shared.vape then shared.vape:Uninject() end

if identifyexecutor and ({identifyexecutor()})[1] == 'Argon' then
	getgenv().setthreadidentity = nil
end

local vape
local loadstring = function(...)
	local res, err = loadstring(...)
	if err then
		if vape then
			vape:CreateNotification('Katware', 'Failed to load : '..err, 30, 'alert')
		else
			warn('[Vape] Failed to load:', err)
		end
	end
	return res, err
end
local queue_on_teleport = queue_on_teleport or function() end
local isfile = isfile or function(file)
	local suc, res = pcall(function()
		return readfile(file)
	end)
	return suc and res ~= nil and res ~= ''
end
local cloneref = cloneref or function(obj)
	return obj
end
local playersService = cloneref(game:GetService('Players'))

local function downloadFile(path, func)
	if not isfile(path) then
		local suc, res = pcall(function()
			return game:HttpGet('https://raw.githubusercontent.com/Cunzaki/VapeV4-but-with-more-shit/'..readfile('newvape/profiles/commit.txt')..'/'..select(1, path:gsub('newvape/', '')), true)
		end)
		if not suc or res == '404: Not Found' then
			error(res)
		end
		if path:find('.lua') then
			res = '--This watermark is used to delete the file if its cached, remove it to make the file persist after vape updates.\n'..res
		end
		writefile(path, res)
	end
	return (func or readfile)(path)
end

local function runGameScript(source, name)
	local chunk, err = loadstring(source, name)
	if not chunk then
		warn('[Vape] Failed to compile '..name..': '..tostring(err))
		return false
	end
	local ok, runErr = pcall(chunk)
	if not ok then
		warn('[Vape] Failed to run '..name..': '..tostring(runErr))
		if vape and vape.CreateNotification then
			vape:CreateNotification('Vape', 'Failed to run '..name..': '..tostring(runErr), 15, 'alert')
		end
		return false
	end
	return true
end

local function finishLoading()
	vape.Init = nil
	local loadOk, loadErr = pcall(function()
		vape:Load()
	end)
	if not loadOk then
		warn('[Vape] Load failed:', loadErr)
		if vape.CreateNotification then
			vape:CreateNotification('Vape', 'Load failed: '..tostring(loadErr), 15, 'alert')
		end
	else
		vape._profileReady = vape._profileReady or false
	end
	task.spawn(function()
		repeat
			task.wait(0.1)
		until vape._profileReady or not vape.Loaded
		repeat
			vape:Save()
			task.wait(10)
		until not vape.Loaded
	end)

	local teleportedServers
	vape:Clean(playersService.LocalPlayer.OnTeleport:Connect(function()
		if (not teleportedServers) and (not shared.VapeIndependent) then
			teleportedServers = true
			local teleportScript = [[
				shared.vapereload = true
				if shared.VapeDeveloper then
					loadstring(readfile('newvape/loader.lua'), 'loader')()
				else
					loadstring(game:HttpGet('https://raw.githubusercontent.com/Cunzaki/VapeV4-but-with-more-shit/'..readfile('newvape/profiles/commit.txt')..'/loader.lua', true), 'loader')()
				end
			]]
			if shared.VapeDeveloper then
				teleportScript = 'shared.VapeDeveloper = true\n'..teleportScript
			end
			if shared.VapeCustomProfile then
				teleportScript = 'shared.VapeCustomProfile = "'..shared.VapeCustomProfile..'"\n'..teleportScript
			end
			vape:Save()
			queue_on_teleport(teleportScript)
		end
	end))

	if not shared.vapereload then
		if not vape.Categories then return end
		if vape.Categories.Main.Options['GUI bind indicator'].Enabled then
			vape:CreateNotification('Finished Loading', vape.VapeButton and 'Press the button in the top right to open GUI' or 'Press '..table.concat(vape.Keybind, ' + '):upper()..' to open GUI', 5)
		end
	end
end

if not isfile('newvape/profiles/gui.txt') then
	writefile('newvape/profiles/gui.txt', 'new')
end
local gui = readfile('newvape/profiles/gui.txt')

if not isfolder('newvape/assets/'..gui) then
	makefolder('newvape/assets/'..gui)
end
local guiChunk, guiErr = loadstring(downloadFile('newvape/guis/'..gui..'.lua'), 'gui')
if not guiChunk then
	error('Failed to load GUI: '..tostring(guiErr))
end
vape = guiChunk()
shared.vape = vape

if not shared.VapeIndependent then
	runGameScript(downloadFile('newvape/games/universal.lua'), 'universal')
	local placeScript = 'newvape/games/'..game.PlaceId..'.lua'
	if isfile(placeScript) then
		runGameScript(readfile(placeScript), tostring(game.PlaceId))
	else
		if not shared.VapeDeveloper then
			local suc, res = pcall(function()
				return game:HttpGet('https://raw.githubusercontent.com/Cunzaki/VapeV4-but-with-more-shit/'..readfile('newvape/profiles/commit.txt')..'/games/'..game.PlaceId..'.lua', true)
			end)
			if suc and res ~= '404: Not Found' then
				runGameScript(downloadFile(placeScript), tostring(game.PlaceId))
			end
		end
	end
	finishLoading()
else
	vape.Init = finishLoading
	return vape
end
