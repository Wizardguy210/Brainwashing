local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Karshtakavaar/Folder/main/WallysUI', true))()
-- ^ TY WALLY!!! --
local Player = game:GetService('Players').LocalPlayer
local Character = Player.Character
local HumanoidRootPart = Character.HumanoidRootPart
local win1 = library:CreateWindow('Main')
local win2 = library:CreateWindow('Teleports')
local win3 = library:CreateWindow('Purchases')
local win4 = library:CreateWindow('Misc')
local Core = game:GetService('CoreGui')
local remote = game:GetService('ReplicatedStorage').Remote.RemoteFunction
local locations = game:GetService('Workspace').Ignore.HighlightSpawns
local BuyZones = game:GetService('Workspace').Ignore.Zones
local SkyIsland = game:GetService('Workspace').Ignore.BoostedShotArea.SkyIsland
local chests = game:getService('Workspace').ChestStands

Core.ScreenGui.Name = 'MAINUI'

Player.CharacterAdded:Connect(function(NewCharacter)
    Character = NewCharacter
    HumanoidRootPart = NewCharacter:WaitForChild('HumanoidRootPart')
end)


task.spawn(function()
    while task.wait() do
        if win1.flags.AutoKick then
            remote:InvokeServer('Throw',1)
            wait()
        end
    end
end)
win1:Toggle('Kick Ball', {flag = 'AutoKick'})

task.spawn(function()
    while task.wait() do
        if win3.flags.Upgrade1 then
            remote:InvokeServer('UpgradeStats', 'Speed', 'inf')
        end
    end
end)
win3:Toggle('Upgrade Speed', {flag = 'Upgrade1'})

task.spawn(function()
    while task.wait() do
        if win3.flags.Upgrade2 then
            remote:InvokeServer('UpgradeStats', 'KickPower', 'inf')
        end
    end
end)
win3:Toggle('Upgrade Strength', {flag = 'Upgrade2'})


task.spawn(function()
    while task.wait() do
        if win3.flags.Upgrade3 then
            remote:InvokeServer('UpgradeStats', 'KickAccuracy', 'inf')
        end
    end
end)
win3:Toggle('Upgrade Accuracy', {flag = 'Upgrade3'})


win3:Button('Buy Available Zones', function()
 remote:InvokeServer('UnlockArea', BuyZones['Park'])   
 remote:InvokeServer('UnlockArea', BuyZones['Park Tree'])   
 remote:InvokeServer('UnlockArea', BuyZones['Desert'])   
 remote:InvokeServer('UnlockArea', BuyZones['Grand Pyramid'])   
 remote:InvokeServer('UnlockArea', BuyZones['City'])   
 remote:InvokeServer('UnlockArea', BuyZones['Distorted Skyscraper'])   
 remote:InvokeServer('UnlockArea', BuyZones['Beach'])   
 remote:InvokeServer('UnlockArea', BuyZones['Rocket Ship'])   
 remote:InvokeServer('UnlockArea', BuyZones['Moon'])   
 remote:InvokeServer('UnlockArea', BuyZones['Moon Base'])   
 remote:InvokeServer('UnlockArea', BuyZones['Moon Extractor'])   
 remote:InvokeServer('UnlockArea', BuyZones['World 2 Portal'])   
 remote:InvokeServer('UnlockArea', BuyZones['Mars Rocket Ship'])   
end)

win3:Button('Rebirth', function()
   remote:InvokeServer('Rebirth') 
end)


win2:Dropdown('Teleports', {
    location = _G;
    flag = 'Teleports';
    list = {
      'Spawn';  
      'Park';
      'Desert';
      'City';
      'Beach';
      'Rocket Ship';
      'Moon';
      'Moon Base';
      'Mars';
      'World 2 Portal';
      'Mars Rocket Ship';
      'Sky Island';
    }
}, function(Location)
 if Location == 'Spawn' then
     HumanoidRootPart.CFrame = locations['Default'].CFrame
 elseif Location == 'Park' then
     HumanoidRootPart.CFrame = locations['Park'].CFrame
 elseif Location == 'Desert' then
     HumanoidRootPart.CFrame = locations['Desert'].CFrame
 elseif Location == 'City' then
     HumanoidRootPart.CFrame = locations['City'].CFrame
 elseif Location == 'Beach' then
     HumanoidRootPart.CFrame = locations['Beach'].CFrame
 elseif Location == 'Rocket Ship' then
     HumanoidRootPart.CFrame = locations['Rocket Ship'].CFrame
 elseif Location == 'Moon' then
     HumanoidRootPart.CFrame = locations['Moon'].CFrame
 elseif Location == 'Moon Base' then
     HumanoidRootPart.CFrame = locations['Moon Base'].CFrame
 elseif Location == 'Mars' then
     HumanoidRootPart.CFrame = locations['Mars'].CFrame
 elseif Location == 'World 2 Portal' then
     HumanoidRootPart.CFrame = locations['World 2 Portal'].CFrame
 elseif Location == 'Mars Rocket Ship' then
     HumanoidRootPart.CFrame = locations['Mars Rocket Ship'].CFrame
 elseif Location == 'Sky Island' then
     HumanoidRootPart.CFrame = SkyIsland.CFrame
    end
end)

win4:Button('Destroy', function()
   game:GetService('CoreGui').MAINUI:Destroy() 
    
end)

