--[[
	Ugc 5315066937 — movement speed helpers.

	Client-only velocity / mv patches desync Module_97 and trigger
	"Simulation failed! Rescuing to last spawn" + hard lagbacks.

	Ranked autohop: only input-based assists work (auto bhop).
	Practice / allow_timescale styles: timescale via SimulationControl input
	(same path as /timescale — no RootTimer.Scale, no sync blocking).
]]

local run = function(func)
	local ok, err = pcall(func)
	if not ok then
		warn('[UGC531]', err)
	end
end

local cloneref = cloneref or function(obj)
	return obj
end

local playersService = cloneref(game:GetService('Players'))
local runService = cloneref(game:GetService('RunService'))
local virtualInputManager = cloneref(game:GetService('VirtualInputManager'))

local lplr = playersService.LocalPlayer
local vape = shared.vape
if not vape then
	return
end

local extras = vape.Categories.Extras

local function obtain(name)
	return _G.obtain and _G.obtain(name) or nil
end

local function getLocalContext()
	local ctxMgr = obtain('ContextManager')
	if not ctxMgr or type(ctxMgr.GetContext) ~= 'function' then
		return nil
	end
	local ok, ctx = pcall(function()
		return ctxMgr.GetContext('Local') or ctxMgr.GetContext(lplr)
	end)
	if ok then
		return ctx
	end
	return nil
end

local function getLocalMechanics()
	local ctx = getLocalContext()
	if ctx and ctx.Context and ctx.Context.Simulation then
		return ctx.Context.Simulation.GameMechanics
	end
	return nil
end

local function canUseTimescale()
	local mechanics = getLocalMechanics()
	if not mechanics or not mechanics.StyleInfo then
		return false, false
	end
	local si = mechanics.StyleInfo
	if si.allow_timescale then
		return true, false
	end
	if mechanics.PracticeMode then
		return true, true
	end
	return false, false
end

local function sendTimescale(scale)
	local simControl = obtain('SimulationControl')
	local timerSys = obtain('RealtimeTimerSystem')
	local enums = obtain('CustomEnums')
	if not simControl or not timerSys or not enums or not timerSys.RootTimer then
		return false
	end
	local eventId = enums.EVENT_INPUT_TIMESCALE
	if type(eventId) ~= 'number' then
		return false
	end
	scale = math.clamp(scale, 0.01, 2)
	pcall(function()
		simControl.OutputMulticall:Call('Input', timerSys.RootTimer:Time(), eventId, scale)
	end)
	return true
end

local boostActive = false
local boostMode = 'Auto Bhop'
local boostMultiplier = 1.5
local lastBhopAt = 0
local lastTimescaleAt = 0
local warnedRankedTimescale = false

run(function()
	local Speed
	Speed = extras:CreateModule({
		Name = 'Speed Boost',
		Function = function(callback)
			boostActive = callback
			if callback then
				warnedRankedTimescale = false
				lastTimescaleAt = 0
				if boostMode == 'Timescale' or boostMode == 'Both' then
					local allowed, practiceOnly = canUseTimescale()
					if allowed then
						sendTimescale(boostMultiplier)
					elseif not warnedRankedTimescale then
						warnedRankedTimescale = true
						pcall(function()
							vape:CreateNotification(
								'Speed Boost',
								'Timescale only works in /practice or styles that allow it. Use Auto Bhop on ranked runs.',
								6
							)
						end)
					end
				end
				local tickEvent = runService.PreSimulation or runService.Heartbeat
				Speed:Clean(tickEvent:Connect(function()
					if not boostActive then
						return
					end
					pcall(function()
						local useTimescale = boostMode == 'Timescale' or boostMode == 'Both'
						local useBhop = boostMode == 'Auto Bhop' or boostMode == 'Both'

						if useTimescale then
							local allowed = canUseTimescale()
							if allowed and tick() - lastTimescaleAt > 0.5 then
								lastTimescaleAt = tick()
								sendTimescale(boostMultiplier)
							end
						end

						if useBhop then
							local ctx = getLocalContext()
							local enums = obtain('CustomEnums')
							local touchBit = enums and enums.TICKINFO_BIT_TOUCHING or 8
							if ctx and ctx.Context and ctx.Context.GetOutput then
								local ok, _, tickInfo = pcall(function()
									return ctx.Context:GetOutput()
								end)
								if ok and tickInfo and bit32.band(tickInfo, touchBit) ~= 0 then
									local now = tick()
									if now - lastBhopAt > 0.05 then
										lastBhopAt = now
										virtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
										task.delay(0.01, function()
											virtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
										end)
									end
								end
							end
						end
					end)
				end))
			else
				sendTimescale(1)
			end
		end,
		Tooltip = 'Auto Bhop for ranked runs. Timescale uses the game /timescale input path (practice or allowed styles only).',
	})

	Speed:CreateDropdown({
		Name = 'Mode',
		List = { 'Auto Bhop', 'Timescale', 'Both' },
		Default = 'Auto Bhop',
		Function = function(val)
			boostMode = val
			warnedRankedTimescale = false
			if boostActive and (val == 'Timescale' or val == 'Both') then
				sendTimescale(boostMultiplier)
			elseif boostActive then
				sendTimescale(1)
			end
		end,
	})

	Speed:CreateSlider({
		Name = 'Multiplier',
		Min = 1,
		Max = 2,
		Decimal = 10,
		Default = 1.5,
		Function = function(val)
			boostMultiplier = val
			if boostActive and (boostMode == 'Timescale' or boostMode == 'Both') and canUseTimescale() then
				sendTimescale(val)
			end
		end,
		Suffix = function(val)
			return val .. 'x'
		end,
	})
end)

return '5315066937'
