local Player = game:GetService('Players')['LocalPlayer']
local Character = Player['Character']
local RootPart = Character['HumanoidRootPart']
Player.CharacterAdded:Connect(function(c)
   Character = c
   RootPart = c:WaitForChild('HumanoidRootPart')
end)


local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Karshtakavaar/Folder/main/WallysUI', true))()
local Auto = library:CreateWindow('Auto Miner')
local CoreGui = game:GetService('CoreGui'); 
CoreGui.ScreenGui.Name = 'MainUI'

local AdvancedMine = game:GetService('Workspace')['Global']['OreMines2']
local Mine = game:GetService('Workspace')['Global']['OreMines']



task.spawn(function()
    while task.wait() do
        if Auto.flags.Mine2 then
            for _, v in next, Mine:GetDescendants() do
                if string.find(tostring(v), 'Head') then
                    if v.Parent.Name == 'Ruby ore' then
                                v:Destroy()
                            else
                                RootPart.CFrame = v.CFrame + Vector3.new(0, 0, 3)
                            end
                        end 
                    end
                end
            end
        end)
    Auto:Toggle('Mine Normal', {flag = 'Mine2'})

task.spawn(function()
    while task.wait() do
        if Auto.flags.Mine1 then
            for _, v in next, AdvancedMine:GetDescendants() do
                if string.find(tostring(v), 'Head') then
                        if v.Parent.Name == 'Ruby ore' then
                                v:Destroy()
                                else
                                    RootPart.CFrame = v.CFrame + Vector3.new(0, 0, 3)
                                end
                            end 
                        end
                    end
                end
            end)
    Auto:Toggle('Mine Advanced', {flag = 'Mine1'})


Auto:Button('Destroy', function()
   CoreGui['MainUI']:Destroy()
end)

