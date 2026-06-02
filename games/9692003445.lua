local function disableModule(mod)
	if mod and mod.Enabled then
		mod:Toggle(true)
	end
end

local function optValue(opt, default)
	if opt and opt.Value ~= nil then
		return opt.Value
	end
	return default
end

local function cloneList(list)
	local copy = {}
	for i, v in ipairs(list) do
		copy[i] = v
	end
	return copy
end

local run = function(func)
	local ok, err = pcall(func)
	if not ok then
		warn('[9692003445] module init failed:', err)
	end
end
local cloneref = cloneref or function(obj)
	return obj
end

local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local textChatService = cloneref(game:GetService('TextChatService'))

local vape = shared.vape

if not vape.Categories.Minigames then
	vape.Categories.Minigames = vape:CreateCategory({
		Name = 'Minigames',
		Icon = 'vape/assets/new/minigames.png'
	})
end

local minigames = vape.Categories.Minigames

local function notif(...)
	return vape:CreateNotification(...)
end

local function waitRemote(parent, name, timeout)
	timeout = timeout or 8
	local ok, inst = pcall(function()
		return parent:WaitForChild(name, timeout)
	end)
	return ok and inst or nil
end

local function isInCharacter()
	return replicatedStorage:GetAttribute('IsInCharacter') == true
end

-- client_message_receiver: message_sent -> FireServer(text) when IsInCharacter
-- server_message_sent.OnClientEvent -> Chat:Chat(player.Character, text) on every client
local function fireRpBubble(text, mode)
	if mode ~= 'Direct' and not isInCharacter() then
		return false, 'not_in_character'
	end
	if mode ~= 'Direct' then
		local bindable = replicatedStorage:FindFirstChild('message_sent')
		if bindable and bindable:IsA('BindableEvent') then
			pcall(function()
				bindable:Fire(text)
			end)
			return true
		end
	end
	local remote = replicatedStorage:FindFirstChild('server_message_sent')
	if remote then
		pcall(function()
			remote:FireServer(text)
		end)
		return true
	end
	return false, 'missing_remote'
end

local function getLegacyChatRemote()
	local folder = replicatedStorage:FindFirstChild('DefaultChatSystemChatEvents')
	return folder and folder:FindFirstChild('SayMessageRequest')
end

local function getTextChannelName()
	local general = textChatService:FindFirstChild('TextChannels')
	general = general and general:FindFirstChild('RBXGeneral')
	if general then
		return 'RBXGeneral'
	end
	return 'All'
end

-- server_message_sent -> OnClientEvent(player, message) -> Chat:Chat on all clients
run(function()
	local RPBubbleSpam
	local Delay
	local CustomText
	local SendMode
	local warnedCharacter = false
	local warnedRemote = false

	local presetLines = {
		'...',
		'hello?',
		'can you hear me',
		'lag?',
		'brb',
		'what',
		'stop',
		'help',
		'???',
		'ok',
		'AAAAAAAA',
		'why is everyone staring',
		'*splash*',
		'help im drowning',
		'water water water'
	}
	local presetIndex = 1

	RPBubbleSpam = minigames:CreateModule({
		Name = 'RP Bubble Spam',
		Function = function(enabled)
			if enabled then
				local remote = replicatedStorage:FindFirstChild('server_message_sent')
				if not remote then
					remote = waitRemote(replicatedStorage, 'server_message_sent', 4)
				end
				if not remote then
					notif('RP Bubble Spam', 'server_message_sent missing', 5, 'warning')
					disableModule(RPBubbleSpam)
					return
				end
				if optValue(SendMode, 'Game path') == 'Game path' and not isInCharacter() then
					notif('RP Bubble Spam', 'Game path needs IsInCharacter', 6, 'warning')
				end
				task.spawn(function()
					while RPBubbleSpam.Enabled do
						local text = CustomText and CustomText.Value or ''
						if text == '' then
							text = presetLines[presetIndex]
							presetIndex = presetIndex % #presetLines + 1
						end
						local mode = optValue(SendMode, 'Game path')
						local ok, reason = fireRpBubble(text, mode)
						if not ok then
							if reason == 'not_in_character' and not warnedCharacter then
								warnedCharacter = true
								notif('RP Bubble Spam', 'Use Direct mode or spawn in role', 5, 'warning')
							elseif reason == 'missing_remote' and not warnedRemote then
								warnedRemote = true
								notif('RP Bubble Spam', 'server_message_sent missing', 5, 'warning')
								disableModule(RPBubbleSpam)
								break
							end
						else
							warnedCharacter = false
						end
						task.wait(math.max(optValue(Delay, 0.25), 0.05))
					end
				end)
			else
				warnedCharacter = false
				warnedRemote = false
			end
		end,
		Tooltip = 'Server → all clients: FireServer(string) relays to OnClientEvent(player, text) then Chat:Chat on every client (client_message_receiver). Game path uses message_sent bindable like RP typing.'
	})
	Delay = RPBubbleSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.05,
		Max = 3,
		Default = 0.25,
		Suffix = 's'
	})
	SendMode = RPBubbleSpam:CreateDropdown({
		Name = 'Send Path',
		List = { 'Game path', 'Direct' }
	})
	CustomText = RPBubbleSpam:CreateTextBox({
		Name = 'Custom Bubble',
		Placeholder = 'leave empty for presets'
	})
end)

-- ChatMain.MessageSender: SayMessageRequest:FireServer(msg, channel) -> OnNewMessage on all clients
run(function()
	local LegacyChatSpam
	local Delay
	local CustomText
	local ChannelPick
	local warnedRemote = false

	local channelNames = { 'All', 'RBXGeneral', 'System' }
	local presetLines = {
		'hello from vape',
		'test message',
		'lag?',
		'brb',
		'???'
	}
	local presetIndex = 1

	local function getChannelList()
		return cloneList(channelNames)
	end

	LegacyChatSpam = minigames:CreateModule({
		Name = 'Legacy Chat Spam',
		Function = function(enabled)
			if enabled then
				local remote = getLegacyChatRemote()
				if not remote then
					local folder = waitRemote(replicatedStorage, 'DefaultChatSystemChatEvents', 4)
					remote = folder and folder:FindFirstChild('SayMessageRequest')
				end
				if not remote then
					notif('Legacy Chat Spam', 'SayMessageRequest missing', 5, 'warning')
					disableModule(LegacyChatSpam)
					return
				end
				task.spawn(function()
					while LegacyChatSpam.Enabled do
						local text = CustomText and CustomText.Value or ''
						if text == '' then
							text = presetLines[presetIndex]
							presetIndex = presetIndex % #presetLines + 1
						end
						local channel = optValue(ChannelPick, getTextChannelName())
						local ok = pcall(function()
							remote:FireServer(text, channel)
						end)
						if not ok and not warnedRemote then
							warnedRemote = true
							notif('Legacy Chat Spam', 'SayMessageRequest failed', 5, 'warning')
							disableModule(LegacyChatSpam)
							break
						end
						task.wait(math.max(optValue(Delay, 0.5), 0.1))
					end
				end)
			else
				warnedRemote = false
			end
		end,
		Tooltip = 'Server → all clients: SayMessageRequest:FireServer(message, channel) filtered by server then OnNewMessage on every client (ChatMain).'
	})
	Delay = LegacyChatSpam:CreateSlider({
		Name = 'Delay',
		Min = 0.1,
		Max = 5,
		Default = 0.5,
		Suffix = 's'
	})
	ChannelPick = LegacyChatSpam:CreateDropdown({
		Name = 'Channel',
		List = getChannelList()
	})
	CustomText = LegacyChatSpam:CreateTextBox({
		Name = 'Custom Message',
		Placeholder = 'leave empty for presets'
	})
end)
