--[[
    10/31/2022
Released

    DONE:
    Teleports
    Boosts
    Auto Souls
    Auto Rebirths
    Auto Upgrades
    Auto Upgrade Ascenders
--]]


-- // LOCALS \\ --
local Players = game:GetService('Players')
local Player = Players['LocalPlayer']

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local stats = ReplicatedStorage['Data'][tostring(Player)]['Stats']
local RemoteFunction = ReplicatedStorage['Framework']['RemoteFunction']
local TeleportRemote = ReplicatedStorage['Events']['ToMap']

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Karshtakavaar/Folder/main/WallysUI', true))()
local CoreGui = game:GetService('CoreGui')

local GetBase = function()
   local Base;
        for _, v in next, game:GetService('Workspace'):GetChildren() do      
            if string.find(tostring(v), tostring(Player).. "'s Base") then
            Base = v 
            return Base
        end
    end
end
local Base = GetBase()
local Ascenders = Base['Ascender']
local Appraiser = Base['ItemMachine']['Appraiser']




-- // UI \\ --

local Upgrades = library:CreateWindow('Main Features')
local Boosts = library:CreateWindow('Boosts')
local Teleports = library:CreateWindow('Teleports')
local Misc = library:CreateWindow('Misc')
CoreGui['ScreenGui']['Name'] = '1Z2Y3X'



-- // MAIN SHIT \\ --

-- MAIN FEATURES --

task.spawn(function()
    while task.wait() do
        if Upgrades.flags.Upgrades then
            RemoteFunction:InvokeServer(0, 'UpgradeServer', 'Upgrade', {[1] = 'Molder',     [2] = 50})
            RemoteFunction:InvokeServer(0, 'UpgradeServer', 'Upgrade', {[1] = 'Polisher',   [2] = 50})
            RemoteFunction:InvokeServer(0, 'UpgradeServer', 'Upgrade', {[1] = 'Classifier', [2] = 50})
            RemoteFunction:InvokeServer(0, 'UpgradeServer', 'Upgrade', {[1] = 'Upgrader',   [2] = 50})
            RemoteFunction:InvokeServer(0, 'UpgradeServer', 'Upgrade', {[1] = 'Enchanter',  [2] = 50})
            RemoteFunction:InvokeServer(0, 'UpgradeServer', 'Upgrade', {[1] = 'Appraiser',  [2] = 50})
        end
    end
end)
Upgrades:Toggle('Auto Upgrades', {flag = 'Upgrades'})


task.spawn(function()
    while task.wait() do
        if Upgrades.flags.Rebirth then
            RemoteFunction:InvokeServer(0, 'UpgradeServer', 'Upgrade', {[1] = 'Molder',     [2] = 1, [3] = true})
            RemoteFunction:InvokeServer(0, 'UpgradeServer', 'Upgrade', {[1] = 'Polisher',   [2] = 1, [3] = true})
            RemoteFunction:InvokeServer(0, 'UpgradeServer', 'Upgrade', {[1] = 'Classifier', [2] = 1, [3] = true})
            RemoteFunction:InvokeServer(0, 'UpgradeServer', 'Upgrade', {[1] = 'Upgrader',   [2] = 1, [3] = true})
            RemoteFunction:InvokeServer(0, 'UpgradeServer', 'Upgrade', {[1] = 'Enchanter',  [2] = 1, [3] = true})
            RemoteFunction:InvokeServer(0, 'UpgradeServer', 'Upgrade', {[1] = 'Appraiser',  [2] = 1, [3] = true})
        end
    end
end)
Upgrades:Toggle('Auto Rebirth', {flag = 'Rebirth'})


task.spawn(function()
    while task.wait() do
        if Upgrades.flags.Ascender1 then
            RemoteFunction:InvokeServer(0, 'ButtonServer', 'Activate', {[1] = Ascenders['Ascender1Luck']})
            RemoteFunction:InvokeServer(0, 'ButtonServer', 'Activate', {[1] = Ascenders['Ascender2Luck']})
            RemoteFunction:InvokeServer(0, 'ButtonServer', 'Activate', {[1] = Ascenders['Ascender3Luck']})


        end
    end
end)
Upgrades:Toggle('Auto Upgrade Ascenders', {flag = 'Ascender1'})


task.spawn(function()
    while task.wait() do
        if Upgrades.flags.Levels then
             RemoteFunction:InvokeServer(0, 'ButtonServer', 'Activate', {[1] = Appraiser['MolderLuck']})
             RemoteFunction:InvokeServer(0, 'ButtonServer', 'Activate', {[1] = Appraiser['PolisherLuck']})
             RemoteFunction:InvokeServer(0, 'ButtonServer', 'Activate', {[1] = Appraiser['ClassifierLuck']})
             RemoteFunction:InvokeServer(0, 'ButtonServer', 'Activate', {[1] = Appraiser['UpgraderLuck']})
             RemoteFunction:InvokeServer(0, 'ButtonServer', 'Activate', {[1] = Appraiser['Enchanter2Luck']})
             RemoteFunction:InvokeServer(0, 'ButtonServer', 'Activate', {[1] = Appraiser['AppraiserLuck']})


        end
    end
end)
Upgrades:Toggle('Auto Level Luck', {flag = 'Levels'})


task.spawn(function()
    while task.wait() do
        if Upgrades.flags.Souls then
            RemoteFunction:InvokeServer(0, 'SoulTankService', 'AddSouls', {})
        end
    end
end)
Upgrades:Toggle('Auto Souls', {flag = 'Souls'})

-- BOOSTS -- 

task.spawn(function()
    while task.wait() do
        if Boosts.flags.Boost1 then
            RemoteFunction:InvokeServer(0, 'BoostService', 'BuyWithGems', {[1] = 'Dungeon',   [2] = '30Min'})
            RemoteFunction:InvokeServer(0, 'BoostService', 'BuyWithGems', {[1] = 'Cash',      [2] = '30Min'})
            RemoteFunction:InvokeServer(0, 'BoostService', 'BuyWithGems', {[1] = 'Artifact',  [2] = '30Min'})
            RemoteFunction:InvokeServer(0, 'BoostService', 'BuyWithGems', {[1] = 'Damage',    [2] = '30Min'})
            RemoteFunction:InvokeServer(0, 'BoostService', 'BuyWithGems', {[1] = 'Luck',      [2] = '30Min'})
            RemoteFunction:InvokeServer(0, 'BoostService', 'BuyWithGems', {[1] = 'UltraLuck', [2] = '30Min'})

        end
    end
end)
Boosts:Toggle('Autobuy ALL Boosts', {flag = 'Boost1'})

task.spawn(function()
    while task.wait() do
        if Boosts.flags.Boost2 then
            RemoteFunction:InvokeServer(0, 'BoostService', 'Use', {[1] = 'Dungeon',   [2] = '30Min'})
            RemoteFunction:InvokeServer(0, 'BoostService', 'Use', {[1] = 'Cash',      [2] = '30Min'})
            RemoteFunction:InvokeServer(0, 'BoostService', 'Use', {[1] = 'Artifact',  [2] = '30Min'})
            RemoteFunction:InvokeServer(0, 'BoostService', 'Use', {[1] = 'Damage',    [2] = '30Min'})
            RemoteFunction:InvokeServer(0, 'BoostService', 'Use', {[1] = 'Luck',      [2] = '30Min'})
            RemoteFunction:InvokeServer(0, 'BoostService', 'Use', {[1] = 'UltraLuck', [2] = '30Min'})

        end
    end
end)
Boosts:Toggle('Autouse ALL Boosts', {flag = 'Boost2'})



-- TELEPORTS --

Teleports:Button('Noob Island', function()
    TeleportRemote:FireServer(stats, Base, tostring(Player), 'Noob Island')
    TeleportRemote:FireServer(stats, Base, tostring(Player), 'Noob Island')
end)

Teleports:Button('Sand Canyons', function()
    TeleportRemote:FireServer(stats, Base, tostring(Player), 'Sand Canyons')
    TeleportRemote:FireServer(stats, Base, tostring(Player), 'Sand Canyons')
end)

Teleports:Button('Icy Planes', function()
    TeleportRemote:FireServer(stats, Base, tostring(Player), 'Icy Planes')
    TeleportRemote:FireServer(stats, Base, tostring(Player), 'Icy Planes')
end)

Teleports:Button('Magma Hills', function()
    TeleportRemote:FireServer(stats, Base, tostring(Player), 'Magma Hills')
    TeleportRemote:FireServer(stats, Base, tostring(Player), 'Magma Hills')
end)

Teleports:Button('Poisoned Cove', function()
    TeleportRemote:FireServer(stats, Base, tostring(Player), 'Poisoned Cove')
    TeleportRemote:FireServer(stats, Base, tostring(Player), 'Poisoned Cove')
end)

Teleports:Button('Plasma Ruins', function()
    TeleportRemote:FireServer(stats, Base, tostring(Player), 'Plasma Ruins')
    TeleportRemote:FireServer(stats, Base, tostring(Player), 'Plasma Ruins')
end)

Teleports:Button('Graveyard', function()
    TeleportRemote:FireServer(stats, Base, tostring(Player), 'Graveyard')
    TeleportRemote:FireServer(stats, Base, tostring(Player), 'Graveyard')
end)




-- MISC STUFF --
Misc:Button('Destroy', function()
   CoreGui['1Z2Y3X']:Destroy() 
end)
