--[[ Fallen Survival — anticheat GC diagnostic (post-bypass + manual Diagnose()) ]]

local Diag = {}
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local function tblLen(tbl)
	if rawlen then return rawlen(tbl) end
	local n = 0
	for k in tbl do if type(k) == 'number' and k > n then n = k end end
	return n
end

local function listOffsets(tbl, pred, max)
	local hits = {}
	for i = 1, max or 32 do
		local v = rawget(tbl, i)
		if pred(v, i) then hits[#hits + 1] = i end
	end
	return hits
end

local function ptr(v)
	if type(v) == 'table' then return string.format('table@%s', tostring(v):match('%x+$') or tostring(v)) end
	if typeof(v) == 'Instance' then
		local name = '?'
		pcall(function() name = v:GetFullName() end)
		return 'Instance:' .. name
	end
	return typeof(v) .. ':' .. tostring(v)
end

local function snap(tbl, max)
	local parts = {}
	for i = 1, max or 16 do
		local v = rawget(tbl, i)
		if v ~= nil then parts[#parts + 1] = string.format('[%d]=%s', i, ptr(v)) end
	end
	return table.concat(parts, ' ')
end

local function readiness(character)
	local modules = ReplicatedStorage:FindFirstChild('Modules')
	return {
		assetContainerModule = modules and modules:FindFirstChild('AssetContainer') ~= nil,
		remotesFolder = ReplicatedStorage:FindFirstChild('Remotes') ~= nil,
		inventoryController = character and character:FindFirstChild('InventoryController') ~= nil,
		stateController = character and character:FindFirstChild('StateController') ~= nil,
		viewmodelReady = character and character:FindFirstChild('ViewmodelController') ~= nil,
	}
end

function Diag.scan(character, humanoid, bypassStatus)
	local remotesInst = ReplicatedStorage:FindFirstChild('Remotes')
	local report = {
		time = os.date('!%Y-%m-%dT%H:%M:%SZ'),
		placeId = game.PlaceId,
		bypass = bypassStatus or {},
		readiness = readiness(character),
		remotesExact = {},
		remotesByName = {},
		characterExact = {},
		characterFuzzy = {},
		recursiveOpen = {},
		recursiveHooked = {},
		assetContainerClosures = 0,
		assetContainerSamples = {},
		notes = {},
	}

	local seenR, seenRN, seenC, seenF, seenRec = {}, {}, {}, {}, {}

	for _, tbl in getgc(true) do
		if type(tbl) == 'table' then

		local remotesIndex
		if remotesInst then
			for i = 1, 32 do
				if rawget(tbl, i) == remotesInst then
					remotesIndex = i
					break
				end
			end
		end
		local first = rawget(tbl, 1)
		if not remotesIndex and typeof(first) == 'Instance' and first.Name == 'Remotes' then
			remotesIndex = 1
		end

		if remotesIndex and not seenR[tbl] then
			seenR[tbl] = true
			local bans = listOffsets(tbl, function(v, i)
				return i ~= remotesIndex and type(v) == 'table' and v ~= tbl
			end, 32)
			report.remotesExact[#report.remotesExact + 1] = {
				remotesIndex = remotesIndex,
				len = tblLen(tbl),
				banOffsets = bans,
				snap = snap(tbl, 12),
			}
		end

		if typeof(first) == 'Instance' and first.Name == 'Remotes' and not seenRN[tbl] then
			seenRN[tbl] = true
			report.remotesByName[#report.remotesByName + 1] = {
				len = tblLen(tbl),
				banOffsets = listOffsets(tbl, function(v, i)
					return i ~= 1 and type(v) == 'table' and v ~= tbl
				end, 32),
				snap = snap(tbl, 12),
			}
		end

		if character and humanoid and rawget(tbl, 1) == character and rawget(tbl, 2) == humanoid and not seenC[tbl] then
			seenC[tbl] = true
			report.characterExact[#report.characterExact + 1] = {
				len = tblLen(tbl),
				banOffsets = listOffsets(tbl, function(v, i) return i > 2 and type(v) == 'table' end, 32),
				legacy5 = rawget(tbl, 5) ~= nil,
				legacy8 = rawget(tbl, 8) ~= nil,
				snap = snap(tbl, 12),
			}
		end

		if character and humanoid then
			local ci = listOffsets(tbl, function(v) return v == character end, 32)
			local hi = listOffsets(tbl, function(v) return v == humanoid end, 32)
			if (#ci > 0 or #hi > 0) and not (rawget(tbl, 1) == character and rawget(tbl, 2) == humanoid) then
				local key = table.concat(ci, ',') .. '|' .. table.concat(hi, ',')
				if not seenF[key] then
					seenF[key] = true
					report.characterFuzzy[#report.characterFuzzy + 1] = {
						charIdx = ci,
						humIdx = hi,
						len = tblLen(tbl),
						banOffsets = listOffsets(tbl, function(v, i)
							return type(v) == 'table' and v ~= tbl and v ~= character and v ~= humanoid
						end, 32),
						snap = snap(tbl, 10),
					}
				end
			end
		end

		if not seenRec[tbl] then
			local foundIndex, foundRecursive
			for _, value in tbl do
				if type(value) == 'number' and rawequal(value, 1) then foundIndex = value end
				if rawequal(value, tbl) then foundRecursive = value end
			end
			if foundIndex and foundRecursive and rawequal(rawget(tbl, foundIndex), nil) then
				seenRec[tbl] = true
				local innerMeta = getrawmetatable and getrawmetatable(foundRecursive)
				local entry = { banIndex = foundIndex, len = tblLen(tbl), snap = snap(tbl, 8) }
				if innerMeta and innerMeta.__newindex then
					report.recursiveHooked[#report.recursiveHooked + 1] = entry
				else
					report.recursiveOpen[#report.recursiveOpen + 1] = entry
				end
			end
		end
		end
	end

	for _, fn in getgc(false) do
		if type(fn) == 'function' then
			local ok, info = pcall(debug.getinfo, fn)
			if ok and info and type(info.source) == 'string' and info.source:find('AssetContainer') then
				report.assetContainerClosures = report.assetContainerClosures + 1
				if #report.assetContainerSamples < 3 then
					report.assetContainerSamples[#report.assetContainerSamples + 1] = {
						name = info.name or '?',
						line = info.currentline,
					}
				end
			end
		end
	end

	-- Actionable notes
	if #report.remotesExact == 0 and #report.remotesByName == 0 then
		report.notes[#report.notes + 1] = 'B1: no Remotes GC table yet — AC may init later; background poll will retry'
	end
	local hasCharBans = false
	for _, t in ipairs(report.characterExact) do
		if #t.banOffsets > 0 or t.len >= 9 then hasCharBans = true end
	end
	if not hasCharBans then
		for _, t in ipairs(report.characterExact) do
			if t.len <= 2 then
				report.notes[#report.notes + 1] = 'B2: character GC table len=' .. t.len .. ' only — ban subtables not allocated yet (inject after HUD/inventory load)'
			end
		end
	end
	if #report.recursiveOpen == 0 and #(report.recursiveHooked) > 0 then
		report.notes[#report.notes + 1] = 'B3: recursive tables hooked (' .. #report.recursiveHooked .. ')'
	end

	return report
end

local function section(lines, title, items, fmt)
	lines[#lines + 1] = '-- ' .. title .. ' (' .. #items .. ') --'
	if #items == 0 then
		lines[#lines + 1] = '(none)'
	else
		for i, t in ipairs(items) do
			lines[#lines + 1] = fmt(i, t)
		end
	end
	lines[#lines + 1] = ''
end

function Diag.format(report)
	local b = report.bypass
	local r = report.readiness or {}
	local lines = {
		'=== Fallen AC Diagnostic ===',
		string.format('time=%s place=%s', report.time, tostring(report.placeId)),
		string.format('bypass: active=%s strict=%s B1=%s B2=%s B3=%s hooks=%s runs=%s',
			tostring(b.Active), tostring(b.Strict), tostring(b.Bypass1), tostring(b.Bypass2),
			tostring(b.Bypass3), tostring(b.HookCount), tostring(b.RunCount)),
		string.format('ready: remotes=%s assetContainer=%s inv=%s state=%s vm=%s ac_closures=%d',
			tostring(r.remotesFolder), tostring(r.assetContainerModule), tostring(r.inventoryController),
			tostring(r.stateController), tostring(r.viewmodelReady), report.assetContainerClosures),
		'',
	}

	section(lines, 'Remotes exact (ReplicatedStorage.Remotes ref)', report.remotesExact, function(i, t)
		return string.format('#%d idx=%s len=%s bans={%s} %s', i, t.remotesIndex, t.len, table.concat(t.banOffsets, ','), t.snap)
	end)
	section(lines, 'Remotes by Name==Remotes', report.remotesByName, function(i, t)
		return string.format('#%d len=%s bans={%s} %s', i, t.len, table.concat(t.banOffsets, ','), t.snap)
	end)
	section(lines, 'Character exact [1]=char [2]=hum', report.characterExact, function(i, t)
		return string.format('#%d len=%s bans={%s} leg5=%s leg8=%s %s', i, t.len, table.concat(t.banOffsets, ','),
			tostring(t.legacy5), tostring(t.legacy8), t.snap)
	end)
	section(lines, 'Character fuzzy', report.characterFuzzy, function(i, t)
		return string.format('#%d char={%s} hum={%s} len=%s bans={%s}', i, table.concat(t.charIdx, ','), table.concat(t.humIdx, ','), t.len, table.concat(t.banOffsets, ','))
	end)
	section(lines, 'Recursive OPEN (need fishy hook)', report.recursiveOpen, function(i, t)
		return string.format('#%d banIndex=%s len=%s %s', i, t.banIndex, t.len, t.snap)
	end)
	section(lines, 'Recursive HOOKED', report.recursiveHooked, function(i, t)
		return string.format('#%d banIndex=%s len=%s %s', i, t.banIndex, t.len, t.snap)
	end)

	if #report.notes > 0 then
		lines[#lines + 1] = '-- Notes --'
		for _, n in ipairs(report.notes) do lines[#lines + 1] = '• ' .. n end
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
		writefile(folder .. '/' .. stamp .. '.json', game:GetService('HttpService'):JSONEncode(report))
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

-- Lightweight check (no assetcontainer scan)
function Diag.hasBanTargets(character, humanoid)
	local remotesInst = ReplicatedStorage:FindFirstChild('Remotes')
	for _, tbl in getgc(true) do
		if type(tbl) ~= 'table' then
			-- skip
		else
			if remotesInst then
				for i = 1, 32 do
					if rawget(tbl, i) == remotesInst then
						for j = 1, 32 do
							if j ~= i and type(rawget(tbl, j)) == 'table' then return true end
						end
					end
				end
			end
			if character and humanoid and rawget(tbl, 1) == character and rawget(tbl, 2) == humanoid then
				for i = 3, 16 do
					if type(rawget(tbl, i)) == 'table' then return true end
				end
			end
		end
	end
	return false
end

return Diag
