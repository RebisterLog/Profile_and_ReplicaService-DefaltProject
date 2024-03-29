local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CharacterComponent = require(ServerScriptService.Server.Modules.CharacterComponent)
local Maid = require(ReplicatedStorage.Shared.Modules.MadworkMaid)
local Types = require(ServerScriptService.Server.Types)

local PlayerProfiles = {}

local PlayerProfile: Types.IPlayerProfile = {}
PlayerProfile.__index = PlayerProfile


function PlayerProfile:Init()
	self.Maid = Maid.NewMaid()
	self.CharacterComponent = nil

	self.Maid:AddCleanupTask(self.Instance.CharacterAdded:Connect(function(character)
		self.CharacterComponent = CharacterComponent.new(character)
		self.CharacterComponent:Init(character)
	end))

	if self.Instance.Character and self.CharacterComponent == nil then
		self.CharacterComponent = CharacterComponent.new(self.Instance.Character)
		self.CharacterComponent:Init(self.Instance.Character)
	end
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