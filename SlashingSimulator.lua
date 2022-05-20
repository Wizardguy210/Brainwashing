local GPF = game:GetService('ReplicatedStorage').GameEvents:GetChildren()
local Remote = game:GetService("Players").LocalPlayer.PlayerScripts.EssentialForGameplay.SliceEvent
local UILib            = loadstring(game:HttpGet('https://raw.githubusercontent.com/Karshtakavaar/Folder/main/WallysUI', true))()
local Window1 = UILib:CreateWindow('Main Area')
local OpenEgg = game:GetService('ReplicatedStorage').Remotes.Pets.Eggs.HatchEgg
local RebirthRemote = game:GetService("ReplicatedStorage").Remotes.Other.Rebirth
for i, v in next, game:GetService('CoreGui'):GetChildren() do
    if v.Name == 'ScreenGui' then
        v.Name = 'MainUI'
        end
end

Window1:Button('Gamepasses', function()
 for i, v in next, GPF do
    v.Value = true
    end 
end)

task.spawn(function()
    while task.wait() do
        if Window1.flags.AutoSwing then
            Remote:Fire()
        end
    end
end)
Window1:Toggle('Auto Swing', {flag = 'AutoSwing'})

task.spawn(function()
    while task.wait() do
        if Window1.flags.AutoOpen then
            OpenEgg:FireServer('TitanEgg', 'Diamonds')
        end
    end
end)
Window1:Toggle('Auto Open', {flag = 'AutoOpen'})

task.spawn(function()
    while task.wait(5) do
        if Window1.flags.Rebirth then
            RebirthRemote:FireServer(30000, 12)
        end
    end
end)
Window1:Toggle('Auto Rebirth', {flag = 'Rebirth'})

Window1:Button('Destroy', function()
  game:GetService('CoreGui').MainUI:Destroy()
end)
