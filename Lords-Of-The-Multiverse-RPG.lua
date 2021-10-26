--// Locals !! \\--

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Karshtakavaar/WallySV2XD/main/Waluh.lua', true))()
local Window1 = library:CreateWindow('Farm Stuff')
local Core = game:GetService('CoreGui')
local Level = game:GetService('Players').LocalPlayer.leaderstats.Lvl
local Gold = game:GetService('Players').LocalPlayer.leaderstats.Gd
local Me = game:GetService('Players').LocalPlayer
local Sword = nil
local Char = Me.Character
local window2 = library:CreateWindow('Armors')
local window3 = library:CreateWindow('Private Universes')
Core.ScreenGui.Name = 'Wally'

-- // Script Thangs \\--
Window1:Button('Show Level and Gold', function()
    rconsoleprint('@@LIGHT_MAGENTA@@')
    rconsolename('Level and Gold')
        while wait(6) do
            rconsoleprint('Level: ')
            rconsoleprint(Level.Value)
                rconsoleprint('\n')
            rconsoleprint('Gold: ')
            rconsoleprint(Gold.Value)
                rconsoleprint('\n')
            end
    end)

-- This part was basically made by Jack (Dot_Mp4) as I didn't know how to make the auto toggle so the taskwait, flags, etc was done by him :D
task.spawn(function()
    while task.wait(.06) do 
        if Window1.flags.Autoswing then
            for i,v in pairs(Char:GetChildren()) do
                    pcall(function()
                        if v:IsA'Tool' then
                            Sword = v
                        end
                    end)
                end
                    Sword:Activate()
                end
            end
        end)

Window1:Toggle('Auto Swing', {flag = 'Autoswing'})

window2:Button('Godly Armor UNI 1', function()
    Char.HumanoidRootPart.CFrame = CFrame.new(741.391, 13.758, 464.647)
    
end)

window2:Button('Godly Armor UNI 2', function()
    Char.HumanoidRootPart.CFrame = CFrame.new(-604.495, 23.587, 794.749)  
end)

window2:Button('Goldy Armor UNI 3', function()
    Char.HumanoidRootPart.CFrame = CFrame.new(-605.5, 19.859, 802.5)
end)

window3:Button('Instructions', function()
messagebox('You have to be in universe 1 to use these', '', 0)    
end)

window3:Button('Universe 2', function()
    Char.HumanoidRootPart.CFrame = CFrame.new(-140.499, 15.665, -931.973)  
    
end)

window3:Button('Universe 3', function()
    Char.HumanoidRootPart.CFrame = CFrame.new(-110.5, 11.94, -1105.5)  
    
end)

Window1:Button('Destroy', function()
    Core.Wally:Destroy()
    
end)
