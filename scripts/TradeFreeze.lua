-- TradeFreeze.lua

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TradeFreeze = {}

-- Configuration
local VALUABLE_ITEMS = {
    "Diamond",
    "Gold",
    "Emerald",
    "Ruby"
}

-- Remote Events
local RemoteEvents = {
    FreezeTrade = Instance.new("RemoteEvent"),
    UnfreezeTrade = Instance.new("RemoteEvent"),
    CollectItem = Instance.new("RemoteEvent")
}

-- Initialize Remote Events
for name, event in pairs(RemoteEvents) do
    event.Name = name
    event.Parent = ReplicatedStorage
end

-- Player Data
local PlayerData = {}

-- Functions
function TradeFreeze:Initialize()
    -- Initialize player data
    Players.PlayerAdded:Connect(function(player)
        PlayerData[player] = {
            TradeFrozen = false,
            ValuableItems = {}
        }
    
        Players.PlayerRemoving:Connect(function(player)
            PlayerData[player] = nil
        end)
    end)

    -- Set up remote event handlers
    RemoteEvents.FreezeTrade.OnServerEvent:Connect(function(player)
        if player:IsInGroup(ADMIN_GROUP_ID) then
            for _, p in ipairs(Players:GetPlayers()) do
                PlayerData[p].TradeFrozen = true
            end
        end
    end)

    RemoteEvents.UnfreezeTrade.OnServerEvent:Connect(function(player)
        if player:IsInGroup(ADMIN_GROUP_ID) then
            for _, p in ipairs(Players:GetPlayers()) do
                PlayerData[p].TradeFrozen = false
            end
        end
    end)

    RemoteEvents.CollectItem.OnServerEvent:Connect(function(player, itemName)
        if table.find(VALUABLE_ITEMS, itemName) then
            table.insert(PlayerData[player].ValuableItems, itemName)
        end
    end)
end

return TradeFreeze