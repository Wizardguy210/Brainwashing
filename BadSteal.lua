--// ROFL \\--

local me = game:GetService('Players').LocalPlayer
local back = me.Backpack
local char = me.Character
local Humanoid = char.Humanoid
local RootPart = char.HumanoidRootPart
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Karshtakavaar/WallySV2XD/main/Waluh.lua', true))()
local win1 = library:CreateWindow('Poopinator')
local Core = game:GetService('CoreGui')
Core.ScreenGui.Name = 'Wally'


--// Ok \\ --
task.spawn(function()
    while task.wait(.4) do 
        if win1.flags.Steal then
   for i,v in pairs(game:GetService('Workspace'):GetDescendants()) do
    if v:IsA'Tool' and v.Name == 'Boombox' or v.Name == 'BoomBox' or v.Name == 'SuperFlyGoldenBoombox' then
                     Humanoid:EquipTool(v)        
                    end
                end
            end
        end
    end)
win1:Toggle('Steal Tools', {flag = 'Steal'})

win1:Button('Drop Tools', function()
  for i,v in pairs(back:GetChildren()) do
    v.Parent = char
    v.Parent = workspace
end              
end)

win1:Button('Destroy', function()
 Core.Wally:Destroy()       
end)
