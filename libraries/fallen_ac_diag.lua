--[[ Fallen Survival — quick anticheat GC diagnostic (runs after bypass pass) ]]

local Diag = {}

local function tblLen(tbl)
	if rawlen then return rawlen(tbl) end
	local n = 0
	for k in tbl do if type(k) == 'number' and k > n then n = k end end
	return n
end

local function ptr(v)
	if type(v) == 'table' then return string.format('table@%s', tostring(v):match('%x+$') or tostring(v)) end
	if typeof(v) == 'Instance' then
		local name = '?'
		pcall(function() name = v:GetFullName() end)
		return 'Instance:' .. name
	end
	return tostring(v)
end

local function snap(tbl, max)
	local parts = {}
	for i = 1, max or 12 do
		local v = rawget(tbl, i)
		if v ~= nil then
			parts[#parts + 1] = string.format('[%d]=%s', i, ptr(v))
		end
	end
	return table.concat(parts, ' ')
end

function Diag.scan(character, humanoid, bypassStatus)
	local remotes = game:GetService('ReplicatedStorage'):FindFirstChild('Remotes')
	local report = {
		time = os.date('!%Y-%m-%dT%H:%M:%SZ'),
		placeId = game.PlaceId,
		bypass = bypassStatus or {},
		remotesTables = {},
		characterTables = {},
		recursiveCandidates = 0,
		recursiveHooked = bypassStatus and bypassStatus.HookCount or 0,
		assetContainerClosures = 0,
	}

	for _, tbl in getgc(true) do
		if type(tbl) == 'table' then
		local first = rawget(tbl, 1)
		if typeof(first) == 'Instance' and first.Name == 'Remotes' then
			local bans = {}
			for i = 1, 24 do
				if i ~= 1 then
					local v = rawget(tbl, i)
					if type(v) == 'table' and v ~= tbl then
						bans[#bans + 1] = i
					end
				end
			end
			report.remotesTables[#report.remotesTables + 1] = {
				len = tblLen(tbl),
				banOffsets = bans,
				snap = snap(tbl, 10),
			}
		end
		if character and humanoid and rawget(tbl, 1) == character and rawget(tbl, 2) == humanoid then
			local bans = {}
			for i = 3, 16 do
				if type(rawget(tbl, i)) == 'table' then bans[#bans + 1] = i end
			end
			report.characterTables[#report.characterTables + 1] = {
				len = tblLen(tbl),
				banOffsets = bans,
				snap = snap(tbl, 10),
			}
		end
		if not (getrawmetatable and getrawmetatable(tbl)) then
			local foundIndex, foundRecursive = false, false
			for _, value in tbl do
				if type(value) == 'number' and rawequal(value, 1) then foundIndex = value end
				if rawequal(value, tbl) then foundRecursive = value end
			end
			if foundIndex and foundRecursive and rawequal(rawget(tbl, foundIndex), nil) then
				report.recursiveCandidates = report.recursiveCandidates + 1
			end
		end
		end
	end

	if getgc then
		for _, fn in getgc(false) do
			if type(fn) == 'function' then
				local ok, info = pcall(debug.getinfo, fn)
				if ok and info and type(info.source) == 'string' and info.source:find('AssetContainer') then
					report.assetContainerClosures = report.assetContainerClosures + 1
				end
			end
		end
	end

	return report
end

function Diag.format(report)
	local b = report.bypass
	local lines = {
		'=== Fallen AC Diagnostic ===',
		string.format('time=%s place=%s', report.time, tostring(report.placeId)),
		string.format('bypass: active=%s strict=%s B1=%s B2=%s B3=%s hooks=%s runs=%s err=%s',
			tostring(b.Active), tostring(b.Strict), tostring(b.Bypass1), tostring(b.Bypass2),
			tostring(b.Bypass3), tostring(b.HookCount), tostring(b.RunCount), tostring(b.LastError or 'none')),
		string.format('remotes_gc_tables=%d character_gc_tables=%d recursive_candidates=%d assetcontainer_closures=%d',
			#report.remotesTables, #report.characterTables, report.recursiveCandidates, report.assetContainerClosures),
		'',
		'-- Remotes tables --',
	}
	for i, t in ipairs(report.remotesTables) do
		lines[#lines + 1] = string.format('#%d len=%s bans={%s} %s', i, t.len, table.concat(t.banOffsets, ','), t.snap)
	end
	lines[#lines + 1] = ''
	lines[#lines + 1] = '-- Character tables --'
	for i, t in ipairs(report.characterTables) do
		lines[#lines + 1] = string.format('#%d len=%s bans={%s} %s', i, t.len, table.concat(t.banOffsets, ','), t.snap)
	end
	return table.concat(lines, '\n')
end

function Diag.write(report)
	if not writefile then return nil end
	local text = Diag.format(report)
	local folder = 'fallen_ac_dumps'
	pcall(function()
		if isfolder and not isfolder(folder) then makefolder(folder) end
	end)
	local stamp = string.format('%s_%d', tostring(game.PlaceId), math.floor(tick()))
	pcall(writefile, folder .. '/latest.txt', text)
	pcall(writefile, folder .. '/' .. stamp .. '.txt', text)
	pcall(function()
		local hs = game:GetService('HttpService')
		writefile(folder .. '/' .. stamp .. '.json', hs:JSONEncode(report))
	end)
	print('[FallenACDiag]\n' .. text)
	return folder .. '/latest.txt'
end

function Diag.run(character, bypassStatus)
	local hum = character and character:FindFirstChildOfClass('Humanoid')
	local report = Diag.scan(character, hum, bypassStatus)
	local path = Diag.write(report)
	local vape = shared.vape
	if vape and vape.CreateNotification then
		local b = bypassStatus or {}
		vape:CreateNotification('Fallen AC',
			string.format('B1=%s B2=%s B3=%s → %s', tostring(b.Bypass1), tostring(b.Bypass2), tostring(b.Bypass3), path or 'console'),
			12, b.Active and 'info' or 'alert')
	end
	return report, path
end

return Diag
