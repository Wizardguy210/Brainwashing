local Player = game:GetService('Players')['LocalPlayer']
local Character = Player['Character']
local RootPart = Character['HumanoidRootPart']
local Humanoid = Character['Humanoid']
Player.CharacterAdded:Connect(function(c)
   Character = c
   RootPart = c:WaitForChild('HumanoidRootPart')
   Humanoid = c:WaitForChild('Humanoid')
end)


local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Karshtakavaar/Folder/main/WallysUI', true))()
local Gayass = library:CreateWindow('Auto Dungeons')
local CoreGui = game:GetService('CoreGui'); 
CoreGui.ScreenGui.Name = 'MainUI'
local Global = game:GetService('Workspace')['Global']
local Event = Global['Map']['ActiveEvents']
local AirButton = Global['Warps']['Air Temple']['Button']


-- Fire Temple; Earth Temple; Sea Temple; Air Temple

task.spawn(function()
    while task.wait() do
        if Gayass.flags.AirTemple then
            if game:GetService('Workspace'):FindFirstChild('Jeff') then 
            if Event:FindFirstChild('Air Temple') then
                
            for _, v in next, Player['Backpack']:GetChildren() do
               if string.find(tostring(v), 'Death Horn') then
                   Humanoid:EquipTool(v)
                end
            end
                
                
                
                wait(.1)
                RootPart.CFrame = CFrame.new(-2068.98, -560.5, -2185.03) * CFrame.Angles(0, math.rad(180), 0)
                Character['Death Horn']['Use']:InvokeServer('use', {['char'] = Character})
                wait(.1)
                RootPart.CFrame = CFrame.new(-2028.93, -560.5, -2184.85) * CFrame.Angles(0, math.rad(180), 0)
                Character['Death Horn']['Use']:InvokeServer('use', {['char'] = Character})
        else
            RootPart.CFrame = AirButton.CFrame
        end
        else
             local Part = Instance.new('Part', game:GetService('Workspace'))    
             Part.Name = 'Jeff'
             Part.CFrame = CFrame.new(-2047, -569, -2184)
             Part.Size = Vector3.new(160, 11, 9)
             Part.Anchored = true
end




        end
    end
end)
Gayass:Toggle('Air Temple', {flag = 'AirTemple'})


Auto:Button('Destroy', function()
   CoreGui['MainUI']:Destroy()
end)



