local ServerScriptService = game:GetService("ServerScriptService")
local Types = require(ServerScriptService.Server.Types)

local PlayerProfiles = {}

PlayerProfile = {}
PlayerProfile.__index = PlayerProfile

function PlayerProfile.GiveCash(self: Types.IPlayerProfile, cash_amount: number)
	if self:IsActive() == false then return end
	self.Replica:SetValue({"Cash"}, self.Replica.Data.Cash + cash_amount)
end

function PlayerProfile.IsActive(self: Types.IPlayerProfile): boolean
	return PlayerProfiles[self.Instance] ~= nil
end

function PlayerProfile.Get(self: Types.IPlayerProfile, player: Player): Types.IPlayerProfile
    return PlayerProfiles[player]
end

function PlayerProfile.Remove(self: Types.IPlayerProfile, player: Player)
    PlayerProfiles[player] = nil
end

return PlayerProfile