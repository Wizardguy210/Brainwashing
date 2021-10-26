--// Locals \\--
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Karshtakavaar/WallySV2XD/main/Waluh.lua', true))()
local Window1 = library:CreateWindow('Poop')
local Core = game:GetService('CoreGui')
local Level = game:GetService('Players').LocalPlayer.leaderstats.Lvl
local Me = game:GetService('Players').LocalPlayer
local Sword = nil
local Char = Me.Character

--// HOW???? \\--
Core.ScreenGui.Name = 'Wally'

--// Scripta Sstuff $$$ \\--
Window1:Button('Show Level', function()
    rconsoleprint('@@LIGHT_MAGENTA@@')
        while wait(3) do
            rconsoleprint(Level.Value)
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

Window1:Button('Teleport To op armor', function()
    Char.HumanoidRootPart.CFrame = CFrame.new(741.391, 13.758, 464.647)
    
end)


Window1:Button('Destroy', function()
    Core.Wally:Destroy()
    
end)
