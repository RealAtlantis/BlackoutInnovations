local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MovementEvents = ReplicatedStorage:WaitForChild("MovementEvents")
local MainEvent = MovementEvents:FindFirstChild("MainEvent")

MainEvent.OnServerEvent:Connect(function(player, eventType, arg1, arg2, arg3)
    if eventType == "ReplicateSound" then
        local playerCharacter = player.Character
        if not playerCharacter then return end
        
        local humanoidRootPart = playerCharacter:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end

        local playerPosition = humanoidRootPart.Position

        for _, otherPlayer in pairs(Players:GetPlayers()) do
            if otherPlayer ~= player then
                local otherPlayerDistance = otherPlayer:DistanceFromCharacter(playerPosition)
                if otherPlayerDistance and otherPlayerDistance <= 140 then
                    MainEvent:FireClient(otherPlayer, player, eventType, arg1, arg2, arg3)
                end
            end
        end
    end
end)

return nil
