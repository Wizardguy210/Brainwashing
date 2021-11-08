--// ROFL \\--

local SwagDealer = game:GetService('Players').LocalPlayer
local Humanoid = SwagDealer.Character.Humanoid
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Karshtakavaar/WallySV2XD/main/Waluh.lua", true))()
local win1 = library:CreateWindow('Poopinator')
local Core = game:GetService('CoreGui')
Core.ScreenGui.Name = 'Wally'


--// Ok \\ --
task.spawn(function()
    while task.wait() do 
        if win1.flags.Steal then
    for i,v in pairs(game:GetService('Workspace'):GetChildren()) do
        if v:IsA'Tool' then
                        v.Handle.CFrame = SwagDealer.Character.HumanoidRootPart.CFrame
                    end  
                end  
            end
        end
    end)
win1:Toggle('Steal Tools', {flag = 'Steal'})

win1:Button('Drop Tools', function()
  for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
    v.Parent = SwagDealer.Character
    v.Parent = workspace
end              
end)

win1:Button('Destroy', function()
 Core.Wally:Destroy()       
        
end)
