local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FolderEvents = ReplicatedStorage:WaitForChild("MovementEvents")
local MainEvent = FolderEvents:FindFirstChild("MainEvent")

MainEvent.OnServerEvent:Connect(function(player, type, arg1, arg2, arg3)
    if type == "ReplicateSound" then
        local playerCharacter = player.Character
        if not playerCharacter then return end
        
        local playerHRP = playerCharacter:FindFirstChild("HumanoidRootPart")
        if not playerHRP then return end

        local playerPosition = playerHRP.Position

        for _, otherPlayer in ipairs(Players:GetPlayers()) do
            if otherPlayer ~= player and (otherPlayer:DistanceFromCharacter(playerPosition) <= 140) then
                MainEvent:FireClient(otherPlayer, player, type, arg1, arg2, arg3)
            end
        end
    end
end)

return nil
