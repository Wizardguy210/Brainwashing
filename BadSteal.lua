--// ROFL \\--

local SwagDealer = game:GetService('Players').LocalPlayer
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Karshtakavaar/WallySV2XD/main/Waluh.lua", true))()
local win1 = library:CreateWindow('Poopinator')
local Core = game:GetService('CoreGui')
Core.ScreenGui.Name = 'Wally'


--// Ok \\ --
win1:Button('Steal', function()
for i,v in pairs(game:GetService('Workspace'):GetDescendants()) do
    if v.Name == 'BoomBox' and v:IsA'Tool' then
v.Handle.CFrame = SwagDealer.Character.HumanoidRootPart.CFrame
end  
end    
end)

win1:Button('Drop Tools', function()
  for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
    v.Parent = game.Players.LocalPlayer.Character
    v.Parent = workspace
end              
end)

win1:Button('Destroy', function()
 Core.Wally:Destroy()       
        
end)
