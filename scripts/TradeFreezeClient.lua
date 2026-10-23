-- TradeFreezeClient.lua

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Remote Events
local RemoteEvents = {
    FreezeTrade = ReplicatedStorage:WaitForChild("FreezeTrade"),
    UnfreezeTrade = ReplicatedStorage:WaitForChild("UnfreezeTrade"),
    CollectItem = ReplicatedStorage:WaitForChild("CollectItem")
}

-- UI Elements
local TradeFreezeUI = Instance.new("ScreenGui")
TradeFreezeUI.Name = "TradeFreezeUI"
TradeFreezeUI.Parent = PlayerGui

local FreezeButton = Instance.new("TextButton")
FreezeButton.Name = "FreezeButton"
FreezeButton.Size = UDim2.new(0, 100, 0, 50)
FreezeButton.Position = UDim2.new(0.5, -50, 0.5, -25)
FreezeButton.Text = "Freeze Trade"
FreezeButton.Parent = TradeFreezeUI

local UnfreezeButton = Instance.new("TextButton")
UnfreezeButton.Name = "UnfreezeButton"
UnfreezeButton.Size = UDim2.new(0, 100, 0, 50)
UnfreezeButton.Position = UDim2.new(0.5, -50, 0.5, 35)
UnfreezeButton.Text = "Unfreeze Trade"
UnfreezeButton.Parent = TradeFreezeUI

-- Functions
local function onFreezeButtonClicked()
    RemoteEvents.FreezeTrade:FireServer()
end

local function onUnfreezeButtonClicked()
    RemoteEvents.UnfreezeTrade:FireServer()
end

-- Event Connections
FreezeButton.MouseButton1Click:Connect(onFreezeButtonClicked)
UnfreezeButton.MouseButton1Click:Connect(onUnfreezeButtonClicked)

-- Collect Item Function
local function collectItem(itemName)
    RemoteEvents.CollectItem:FireServer(itemName)
end

-- Example: Collect a Diamond
collectItem("Diamond")