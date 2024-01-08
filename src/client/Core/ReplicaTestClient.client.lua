----- Loaded Modules -----

local ReplicaController = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Modules"):WaitForChild("ReplicaController"))

----- Private Variables -----

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

----- Initialize -----

ReplicaController.RequestData()

----- Connections -----

ReplicaController.ReplicaOfClassCreated("PlayerProfile", function(replica)
	local is_local = replica.Tags.Player == LocalPlayer
	local player_name = is_local and "your" or replica.Tags.Player.Name .. "'s"
	local replica_data = replica.Data

	print("Received " .. player_name .. " player profile; Cash:", replica_data.Cash)
	replica:ListenToChange({"Cash"}, function(new_value)
		print(player_name .. " cash changed:", replica_data.Cash)
	end)
end)