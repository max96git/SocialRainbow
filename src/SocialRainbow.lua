--[[
	<SocialRainbow by VSCPlays (originally from @kernelvox (max96git))
	This rainbow module is based on @WinnersTakeAll (RyanLua)'s Shime
	I made this for @kernelvox as @bluebxrrybot and @commitblue said it's not enough for a community resource,
	I want to help @kernelvox succed
	please credit me @VSCPlays for the module and @kernelvox for the idea
	
	The Shime Owner suggested some stuff, so I added some adjustments
]]

--// Types \\--
type ItemType = "Border" | "Text" | "Background"

--// Services \\--
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Sanity Checks \\--
assert(script:IsDescendantOf(ReplicatedStorage), "Place this module in ReplicatedStorage, where both the client and the server can access it.")

--// Bindables \\--
local playedEvent = Instance.new("BindableEvent")
local pausedEvent = Instance.new("BindableEvent")
local finishedEvent = Instance.new("BindableEvent")

--// rainbow \\--
local rainbow = {}
rainbow.__index = rainbow

function rainbow.new(item: GuiObject, itemType: ItemType, rainbowSpeed: number?)
	local self = setmetatable({}, rainbow)

	self.itemType = itemType
	self.item = item
	self.playbackState = Enum.PlaybackState.Completed
	self.rainbowSpeed = rainbowSpeed or 3 --how many seconds until the rainbow loops

	self._connection = nil
	self._currentProgress = 0

	self.Played = PLAYED_EVENT.Event
	self.Paused = PAUSED_EVENT.Event
	self.Finished = FINISHED_EVENT.Event

	return self
end

function rainbow:Play()
	if self._connection then 
		return 
	end

	playedEvent:Fire(self.item, self.playbackState)
	self.playbackState = Enum.PlaybackState.Begin

	local function nextFrame(deltaTime: number)
		self.playbackState = Enum.PlaybackState.Playing
		self._currentProgress = (self._currentProgress + (deltaTime / self.rainbowSpeed)) % 1

		local color = Color3.fromHSV(self._currentProgress, 1, 1)

		self.item[self.itemType .. "Color3"] = color
	end

	if RunService:IsServer() then
		self._connection = RunService.Stepped:Connect(nextFrame)
	else
		self._connection = RunService.RenderStepped:Connect(nextFrame)
	end
end

function rainbow:Pause(seconds: number?)
	if self.playbackState ~= Enum.PlaybackState.Playing then
		return
	end

	seconds = seconds or 1.5 --default value if no value is provided

	if seconds == self.cooldown then
		seconds += self.cooldown
	end

	seconds = math.clamp(seconds, .1, 10e4)

	pausedEvent:Fire(self.item, self.playbackState, seconds)
	self.playbackState = Enum.PlaybackState.Paused
	
	self._connection:Disconnect()
	self._connection = nil

	task.wait(seconds)
	self:Play()
end

function rainbow:Stop()
	if self.playbackState ~= Enum.PlaybackState.Playing then
		return
	end

	finishedEvent:Fire(self.item, self.playbackState)
	self.playbackState = Enum.PlaybackState.Paused
	
	self._connection:Disconnect()
	self._connection = nil
end

return rainbow
