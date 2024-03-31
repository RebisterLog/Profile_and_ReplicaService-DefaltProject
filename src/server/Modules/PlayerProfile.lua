local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CharacterComponent = require(ServerScriptService.Server.Modules.CharacterComponent)
local Maid = require(ReplicatedStorage.Shared.Modules.MadworkMaid)
local Types = require(ServerScriptService.Server.Types)

local PlayerProfiles = {}

local PlayerProfile = {}
PlayerProfile.__index = PlayerProfile


function PlayerProfile:Init()
	self.Maid = Maid.new()

	self.Maid:GiveTask(self.Instance.CharacterAdded:Connect(function(character)
		local component = CharacterComponent.new(character, self)
		if not component then return end

		self.CharacterComponent = component
		PlayerProfiles[self.Instance] = self
		component:Init()
	end))

	if self.Instance.Character and self.CharacterComponent == nil then
		local component = CharacterComponent.new(self.Instance.Character, self)
		if not component then return end

		self.CharacterComponent = component
		PlayerProfiles[self.Instance] = self
		component:Init()
	end

	print(self.CharacterComponent)
end

function PlayerProfile:GiveCash(cash_amount: number)
	if self:IsActive() == false then return end
	self.Replica:SetValue({"Cash"}, self.Replica.Data.Cash + cash_amount)
end

function PlayerProfile:IsActive(): boolean
	return PlayerProfiles[self.Instance] ~= nil
end

function PlayerProfile:Get(player: Player): Types.IPlayerProfile
    return PlayerProfiles[player]
end

function PlayerProfile:Remove(player: Player)
    PlayerProfiles[player] = nil
end

return PlayerProfile