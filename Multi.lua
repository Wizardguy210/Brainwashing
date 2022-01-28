--// ROFL \\--
-- Z
local me = game:GetService('Players').LocalPlayer
local back = me.Backpack
local char = me.Character
local Humanoid = char.Humanoid
local RootPart = char.HumanoidRootPart
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Karshtakavaar/Folder/main/WallysUI', true))()
local win1 = library:CreateWindow('Karma')
local Core = game:GetService('CoreGui')
Core.ScreenGui.Name = 'Wally'


--// Ok \\ --
task.spawn(function()
    while task.wait() do 
        if win1.flags.Steal then
   for i,v in pairs(game:GetService('Workspace'):GetDescendants()) do
    if v:IsA'Tool' and v.Name == 'Boombox' or v.Name == 'BoomBox' or v.Name == 'SuperFlyGoldenBoombox' then
       for i,v in pairs(v:GetDescendants()) do 
          if v:IsA'TouchTransmitter' then 
               firetouchinterest(RootPart, v.Parent, 0)
              wait()
for i,v in pairs(char:GetChildren()) do
    if v:IsA'Tool' then
        v.Parent = back
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
win1:Toggle('Steal Tools', {flag = 'Steal'})

task.spawn(function()
    while task.wait(.8) do
        if win1.flags.TPOAbuse then
  
for i,v in pairs(game:GetService('Workspace'):GetDescendants()) do
  if v:IsA'Sound' then
     v.TimePosition = math.random(1,100)
     
    end
end
for i,v in pairs(game:GetService('Players'):GetDescendants()) do
    if v:IsA'Sound' then
    v.TimePosition = math.random(1,100)
    end
end
        end
    end
end)
win1:Toggle('TPOAbuse', {flag = 'TPOAbuse'})



task.spawn(function()
    while task.wait() do
        if win1.flags.Anti then
            for i,v in pairs(char:GetDescendants()) do
        if v:IsA'Tool' and v.Name == 'Boombox' or v.Name == 'BoomBox' or v.Name == 'SuperFlyGoldenBoombox' then
            Humanoid:UnequipTools(v)
                end
            end           
        end
    end
end)
win1:Toggle('Anti Kill', {flag = 'Anti'})

win1:Button('Right Arm Anti Kill', function()
    char['Right Arm']:Destroy()
    
end)

win1:Button('Drop Tools', function()
  for i,v in pairs(back:GetChildren()) do
    v.Parent = char
    v.Parent = game:GetService('Workspace')
end              
end)

win1:Button('Destroy', function()
 Core.Wally:Destroy()       
end)
