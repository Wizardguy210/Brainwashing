local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Karshtakavaar/Folder/main/WallysUI', true))()
-- ^ TY WALLY!!! --
local Player = game:GetService('Players').LocalPlayer
local win1 = library:CreateWindow('Main')
local win2 = library:CreateWindow('Teleports')
local win3 = library:CreateWindow('Unboxing')
local win4 = library:CreateWindow('Misc')
local Core = game:GetService('CoreGui')
local remote = game:GetService('ReplicatedStorage').Remote.RemoteFunction
local locations = game:GetService('Workspace').Ignore.HighlightSpawns
local SkyIsland = game:GetService('Workspace').Ignore.BoostedShotArea.SkyIsland
local chests = game:getService('Workspace').ChestStands
Core.ScreenGui.Name = 'MAINUI'
local Character = Player.Character
local HumanoidRootPart = Character.HumanoidRootPart

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
        if win1.flags.Upgrade1 then
            remote:InvokeServer('UpgradeStats', 'Speed', 'inf')
        end
    end
end)
win1:Toggle('Upgrade Speed', {flag = 'Upgrade1'})

task.spawn(function()
    while task.wait() do
        if win1.flags.Upgrade2 then
            remote:InvokeServer('UpgradeStats', 'KickPower', 'inf')
        end
    end
end)
win1:Toggle('Upgrade Strength', {flag = 'Upgrade2'})


task.spawn(function()
    while task.wait() do
        if win1.flags.Upgrade3 then
            remote:InvokeServer('UpgradeStats', 'KickAccuracy', 'inf')
        end
    end
end)
win1:Toggle('Upgrade Accuracy', {flag = 'Upgrade3'})

win1:Button('Rebirth', function()
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

win3:Dropdown('Chests', {
    Unbox = _G;
    flag = 'Unbox';
    list = {
    'Sports Chest';
    'Park Chest';
    'Desert Chest';
    'City Chest';
    'Beach Chest';
    'Space Chest';
    'Moon Chest';
    'Moon Base Chest';
    'World 2 Portal Chest';
    'Floppa Chest';
    }
}, function(Open)
    if Open == 'Sports Chest' then
        remote:InvokeServer('PromptPurchaseChest', chests['Sports Chest'])
    elseif Open == 'Park Chest' then
        remote:InvokeServer('PromptPurchaseChest', chests['Park Chest'])
    elseif Open == 'Desert Chest' then
        remote:InvokeServer('PromptPurchaseChest', chests['Desert Chest'])
    elseif Open == 'City Chest' then
        remote:InvokeServer('PromptPurchaseChest', chests['City Chest'])
    elseif Open == 'Beach Chest' then
        remote:InvokeServer('PromptPurchaseChest', chests['Beach Chest'])
    elseif Open == 'Space Chest' then
        remote:InvokeServer('PromptPurchaseChest', chests['Space Chest'])
    elseif Open == 'Moon Chest' then
        remote:InvokeServer('PromptPurchaseChest', chests['Moon Chest'])
    elseif Open == 'Moon Base Chest' then
        remote:InvokeServer('PromptPurchaseChest', chests['Moon Base Chest'])
    elseif Open == 'World 2 Portal Chest' then
        remote:InvokeServer('PromptPurchaseChest', chests['World 2 Portal Chest'])
    elseif Open == 'Floppa Chest' then
        remote:InvokeServer('PromptPurchaseChest', chests['Floppa Chest'])
    end
end)

win4:Button('Destroy', function()
   game:GetService('CoreGui').MAINUI:Destroy() 
    
end)

win4:Button('Beast Mode', function()
Player:Kick('Nigger')
end)
