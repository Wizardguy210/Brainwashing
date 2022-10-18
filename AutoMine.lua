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
local Auto = library:CreateWindow('Auto Miner')
local CoreGui = game:GetService('CoreGui'); 
CoreGui.ScreenGui.Name = 'MainUI'

local AdvancedMine = game:GetService('Workspace')['Global']['OreMines2']
local Mine = game:GetService('Workspace')['Global']['OreMines']
local Teleport = game:GetService('ReplicatedStorage').Remotes.Teleport



local Equip = function()
    for _, v in next, Player['Backpack']:GetChildren() do
        if string.find(tostring(v), 'Pickaxe') then
            Humanoid:EquipTool(v)
        end
    end
end




task.spawn(function()
    while task.wait() do
        if Auto.flags.Mine1 then
            Equip()
            Teleport:InvokeServer(Character, Vector3.new(0, -1013, 0))
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
    Auto:Toggle('Mine Normal', {flag = 'Mine1'})

task.spawn(function()
    while task.wait() do
        if Auto.flags.Mine2 then
            
      Equip()
            Teleport:InvokeServer(Character, Vector3.new(0, -1085, 0))
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
    Auto:Toggle('Mine Advanced', {flag = 'Mine2'})


Auto:Button('Destroy', function()
   CoreGui['MainUI']:Destroy()
end)
