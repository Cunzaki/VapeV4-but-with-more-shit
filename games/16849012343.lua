local vape = shared.vape
local isfile = isfile or function(file)
	local suc, res = pcall(function()
		return readfile(file)
	end)
	return suc and res ~= nil and res ~= ''
end
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

local source = downloadFile('newvape/games/fallen_survival.lua')
local chunk, err = loadstring(source, 'fallen_survival')
if not chunk then
	if vape and vape.CreateNotification then
		vape:CreateNotification('Vape', 'Failed to compile fallen_survival: ' .. tostring(err), 30, 'alert')
	end
	error(err)
end
local ok, runErr = pcall(chunk)
if not ok then
	if vape and vape.CreateNotification then
		vape:CreateNotification('Vape', 'Failed to run fallen_survival: ' .. tostring(runErr), 30, 'alert')
	end
	error(runErr)
end
