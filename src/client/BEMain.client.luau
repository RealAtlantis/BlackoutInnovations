-- Wait until the game is fully loaded
repeat 
    game["Run Service"].Heartbeat:Wait() 
until game:IsLoaded()

-- Initialize Client and Modules tables
local Client = {}
local Modules = {}

-- Function to recursively gather all ModuleScripts
local function GatherModules(container)
    for _, child in ipairs(container:GetChildren()) do
        if child:IsA("ModuleScript") then
            Modules[child.Name] = child
        end
        GatherModules(child)
    end
end

-- Function to require a module by name
function Client.Require(moduleName)
    if Modules[moduleName] then
        return require(Modules[moduleName])
    else
        return nil
    end
end

-- Share the Client table globally
shared.Client = Client

-- Gather all ModuleScripts starting from the script's parent
GatherModules(script)

-- Require the "Run" module
Client.Require("Run")
