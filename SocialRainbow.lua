--[[
	SocialRainbow by VSCPlays (originally from @kernelvox (max96git))
	This rainbow module is based on @WinnersTakeAll (RyanLua)'s Shime
	I made this for @kernelvox as @bluebxrrybot and @commitblue said it's not enough for a community resource,
	I want to help @kernelvox succed

	please credit me @VSCPlays for the module and @kernelvox for the idea
]]

--// Services \\--
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Sanity Checks \\--
if not RunService:IsClient() then
	error(`Please use require({script:GetFullName()}) in the client`)
end

if not script:IsDescendantOf(ReplicatedStorage) then
	error(`Please put this in {ReplicatedStorage:GetFullName()}, where both the client and the server can access it`)
end

--// rainbow \\--
local rainbow = {}
rainbow.__index = rainbow

function rainbow.new(item:GuiObject, it:"Border" | "Text" | "Background", cooldown:number?)
	local self = setmetatable({}, rainbow)

	self.itemType = it
	self.item = item
	self.isPlaying = false
	self.isPaused = false
	self.finished = false
	self.cooldown = cooldown or 0

	return self
end

function rainbow:Play()
	self.isPlaying = true
	self.isPaused = false
	self.finished = false
	RunService:BindToRenderStep("RainbowEffect" ..self.item.Name, 1, function()
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
	end)
end

function rainbow:Pause()
	if self.finished then
		return
	end
	
	self.isPlaying = false
	self.isPaused = true
	self.finished = false
	RunService:UnbindFromRenderStep("RainbowEffect" ..self.item.Name)
end

function rainbow:Stop()
	self.isPlaying = false
	self.isPaused = false
	self.finished = true
	RunService:UnbindFromRenderStep("RainbowEffect" ..self.item.Name)
end

return rainbow
