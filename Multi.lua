-- // Added \\ --
--[[

made stuff not break as much (you can die now but wait like a second before reactivating anything)

Stupid way of fixing it too

--]]

--// To Do \\--
--[[

MAKE VARIABLES WORK AGAIN WITH THIS SHIT!!!!!!!!!!!
^ Whenever you reset, you get a new set of like parts humanoidrootpart for example, need to find a way to reassign variables without it being a clusterfuck

add sex

Make a better antikill

--]]

--// Bugs \\--
--[[

Freeze humanoid breaks a lot (lol)
^ used it a bit doesnt break as often as i thought, still needs a fix though which is making variables work
--]]
--// ROFL \\--
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
               firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
              wait()
for i,v in pairs(game:GetService('Players').LocalPlayer.Character:GetChildren()) do
    if v:IsA'Tool' then
        v.Parent = game:GetService('Players').LocalPlayer.Backpack
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
        if win1.flags.FREEZE then
            game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Anchored = true
            else
            game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Anchored = false
            
         end
     end
end)
win1:Toggle('Freeze Humanoid', {flag = 'FREEZE'})

task.spawn(function()
    while task.wait() do
        if win1.flags.Anti then
            for i,v in pairs(game:GetService('Players').LocalPlayer.Character:GetDescendants()) do
        if v:IsA'Tool' then
            game:GetService('Players').LocalPlayer.Character.Humanoid:UnequipTools(v)
                end
            end           
        end
    end
end)
win1:Toggle('Anti Kill', {flag = 'Anti'})

win1:Button('Right Arm Anti Kill', function()
    game:GetService('Players').LocalPlayer.Character['Right Arm']:Destroy()
    
end)

win1:Button('Drop Tools', function()
  for i,v in pairs(game:GetService('Players').LocalPlayer.Backpack:GetChildren()) do
    v.Parent = game:GetService('Players').LocalPlayer.Character
    v.Parent = game:GetService('Workspace')
end              
end)

win1:Button('Destroy', function()
 Core.Wally:Destroy()       
end)
