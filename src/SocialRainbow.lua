--[[
	<SocialRainbow by VSCPlays (originally from @kernelvox (max96git))
	This rainbow module is based on @WinnersTakeAll (RyanLua)'s Shime
	I made this for @kernelvox as @bluebxrrybot and @commitblue said it's not enough for a community resource,
	I want to help @kernelvox succed
	please credit me @VSCPlays for the module and @kernelvox for the idea
	
	The Shime Owner suggested some stuff, so I added some adjustments
]]

--// Services \\--
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Sanity Checks \\--

if not script:IsDescendantOf(ReplicatedStorage) then
	error(`Please put this in {ReplicatedStorage:GetFullName()}, where both the client and the server can access it`)
end

--// Bindables \\--
local event1 = Instance.new("BindableEvent")
local event2 = Instance.new("BindableEvent")
local event3 = Instance.new("BindableEvent")

--// rainbow \\--
local rainbow = {}
rainbow.__index = rainbow

function rainbow.new(item:GuiObject, it:"Border" | "Text" | "Background", cooldown:number?)
	local self = setmetatable({}, rainbow)

	self.itemType = it
	self.item = item
	self.playbackState = Enum.PlaybackState.Completed
	self.cooldown = cooldown or 0
	self.func = function()
		self.playbackState = Enum.PlaybackState.Playing
		local color = Color3.fromHSV((tick() * 4) % 1, 1, 1)
		if self.itemType == "Border" then
			self.item.BorderColor3 = color
		elseif self.itemType == "Text" then
			if self.item.ClassName == "TextBox" or "TextButton" or "TextLabel" then
				self.item.TextColor3 = color
			end
		elseif self.itemType == "Background" then
			self.item.BackgroundColor3 = color
		end
		task.wait(self.cooldown)
	end
	self.Played = event1.Event
	self.Paused = event2.Event
	self.Finished = event3.Event

	return self
end

function rainbow:Play()
	event1:Fire(self.item, self.playbackState)
	self.playbackState = Enum.PlaybackState.Begin
	
	self.func = function()
		self.playbackState = Enum.PlaybackState.Playing
		local color = Color3.fromHSV((tick() * 4) % 1, 1, 1)
		if self.itemType == "Border" then
			self.item.BorderColor3 = color
		elseif self.itemType == "Text" then
			if self.item.ClassName == "TextBox" or "TextButton" or "TextLabel" then
				self.item.TextColor3 = color
			end
		elseif self.itemType == "Background" then
			self.item.BackgroundColor3 = color
		end
		task.wait(self.cooldown)
	end
	
	while true do
		if self.func == nil then
			break
		end
		
		self.func()
	end
end

function rainbow:Pause(seconds:number)
	if self.playbackState ~= Enum.PlaybackState.Playing then
		return
	end

	if seconds == self.cooldown then
		seconds += self.cooldown
	end

	event2:Fire(self.item, self.playbackState, seconds)

	seconds = math.clamp(seconds, 0.1, 10e4)

	self.playbackState = Enum.PlaybackState.Paused
	self.func = nil
	task.wait(seconds)
	self:Play()
end

function rainbow:Stop()
	if self.playbackState ~= Enum.PlaybackState.Playing then
		return
	end

	event3:Fire(self.item, self.playbackState)
	self.playbackState = Enum.PlaybackState.Paused
	self.func = nil
end

return rainbow
