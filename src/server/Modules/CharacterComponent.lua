local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Types = require(ServerScriptService.Server.Types)
local Maid = require(ReplicatedStorage.Shared.Modules.MadworkMaid)

local BodyParts = {
    "Humanoid",
    "Head",
    "LeftFoot", "LeftHand", "LeftLowerArm", "LeftLowerLeg", "LeftUpperArm", "LeftUpperLeg",
    "RightFoot", "RightHand", "RightLowerArm", "RightLowerLeg", "RightUpperArm", "RightUpperLeg",
    "HumanoidRootPart",
    "UpperTorso"
}

local function CheckBodyPartsInCharacter(character: Model): boolean
    for i, partName in pairs(BodyParts) do
        if not character:FindFirstChild(partName) then return false end
    end
    return true
end

local CharacterComponents = {}

local CharacterComponent: Types.ICharacterComponent = {}
CharacterComponent.__index = CharacterComponent

function CharacterComponent:Init()
    self.Player = Players:GetPlayerFromCharacter(self.Instance)
    self.Maid = Maid.NewMaid()

    local humanoid = self.Instance:FindFirstChildOfClass("Humanoid")
    self.Maid:AddCleanupTask(task.spawn(
        humanoid.Died:Connect(function()
            self:Destroy()
        end)
    ))
    

    self.Maid:AddCleanupTask(task.spawn(
        self.Instance.Destroying:Connect(function()
            self:Destroy()
        end)
    ))
    

    --print("Inited character component for "..self.Player.Name)
end

function CharacterComponent:Destroy()
    CharacterComponents[self.Instance] = nil
    self.Maid:Cleanup()
end

local CharacterComponentConstructor = {}

function CharacterComponentConstructor.new(character: Model): Types.ICharacterComponent | nil
    if not CheckBodyPartsInCharacter(character) then return end

    local component = {
        Instance = character,
    }

    setmetatable(component, CharacterComponent)
    CharacterComponents[character] = component

    return component
end

function CharacterComponentConstructor.get(character: Model) : Types.ICharacterComponent | nil
    return CharacterComponents[character]
end

return CharacterComponentConstructor