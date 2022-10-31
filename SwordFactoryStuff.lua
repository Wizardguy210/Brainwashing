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
    Added Auto buy Lock
    Added Rejoin
    Condensed Everything
--]]


-- // LOCALS \\ --
local Players = game:GetService('Players')
local Player = Players['LocalPlayer']

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local stats = ReplicatedStorage['Data'][tostring(Player)]['Stats']
local RemoteFunction = ReplicatedStorage['Framework']['RemoteFunction']
local TeleportRemote = ReplicatedStorage['Events']['ToMap']
local RemoteEvent = ReplicatedStorage['Framework']['RemoteEvent']
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

-- // UI \\ --

local Upgrades = library:CreateWindow('Main Features')
CoreGui['ScreenGui']['Name'] = '1Z2Y3X'

-- // MAIN SHIT \\ --

-- MAIN FEATURES --

Upgrades:Section('Upgrades')

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
        if Upgrades.flags.Souls then
            RemoteFunction:InvokeServer(0, 'SoulTankService', 'AddSouls', {})
        end
    end
end)
Upgrades:Toggle('Auto Souls', {flag = 'Souls'})



-- BOOSTS -- 
Upgrades:Section('Boosts')
task.spawn(function()
    while task.wait() do
        if Upgrades.flags.Boost1 then
            RemoteFunction:InvokeServer(0, 'BoostService', 'BuyWithGems', {[1] = 'Dungeon',   [2] = '30Min'})
            RemoteFunction:InvokeServer(0, 'BoostService', 'BuyWithGems', {[1] = 'Cash',      [2] = '30Min'})
            RemoteFunction:InvokeServer(0, 'BoostService', 'BuyWithGems', {[1] = 'Artifact',  [2] = '30Min'})
            RemoteFunction:InvokeServer(0, 'BoostService', 'BuyWithGems', {[1] = 'Damage',    [2] = '30Min'})
            RemoteFunction:InvokeServer(0, 'BoostService', 'BuyWithGems', {[1] = 'Luck',      [2] = '30Min'})
            RemoteFunction:InvokeServer(0, 'BoostService', 'BuyWithGems', {[1] = 'UltraLuck', [2] = '30Min'})

        end
    end
end)
Upgrades:Toggle('Autobuy ALL Boosts', {flag = 'Boost1'})

task.spawn(function()
    while task.wait() do
        if Upgrades.flags.Boost2 then
            RemoteFunction:InvokeServer(0, 'BoostService', 'Use', {[1] = 'Dungeon',   [2] = '30Min'})
            RemoteFunction:InvokeServer(0, 'BoostService', 'Use', {[1] = 'Cash',      [2] = '30Min'})
            RemoteFunction:InvokeServer(0, 'BoostService', 'Use', {[1] = 'Artifact',  [2] = '30Min'})
            RemoteFunction:InvokeServer(0, 'BoostService', 'Use', {[1] = 'Damage',    [2] = '30Min'})
            RemoteFunction:InvokeServer(0, 'BoostService', 'Use', {[1] = 'Luck',      [2] = '30Min'})
            RemoteFunction:InvokeServer(0, 'BoostService', 'Use', {[1] = 'UltraLuck', [2] = '30Min'})

        end
    end
end)
Upgrades:Toggle('Autouse ALL Boosts', {flag = 'Boost2'})



-- ENCHANTS -- 
Upgrades:Section('Enchants')



Upgrades:Button('50 Locks', function()
    for i = 1,50 do task.wait()
        RemoteFunction:InvokeServer(0, 'EnchanterServer', 'BuyLock', {})

    end 
end)


-- TELEPORTS --
Upgrades:Section('Teleports')

Upgrades:Dropdown('Teleports', {
TempTeleport = _G;
flag = 'TP';
list = {
    'Home',
    'Noob Island',
    'Sand Canyons',
    'Icy Planes',
    'Magma Hills',
    'Poisoned Cove',
    'Plasma Ruins',
    'Graveyard'
    }
}, function(loc)
    if loc == 'Home' then 
        RemoteEvent:FireServer(0, 'UIServer', 'Teleport', {})
        RemoteEvent:FireServer(0, 'UIServer', 'Teleport', {})
    elseif loc == 'Noob Island' then
        TeleportRemote:FireServer(stats, Base, tostring(Player), 'Noob Island')
        TeleportRemote:FireServer(stats, Base, tostring(Player), 'Noob Island')
    elseif loc == 'Sand Canyons' then
        TeleportRemote:FireServer(stats, Base, tostring(Player), 'Sand Canyons')
        TeleportRemote:FireServer(stats, Base, tostring(Player), 'Sand Canyons')
    elseif loc == 'Icy Planes' then
        TeleportRemote:FireServer(stats, Base, tostring(Player), 'Icy Planes')
        TeleportRemote:FireServer(stats, Base, tostring(Player), 'Icy Planes')
    elseif loc == 'Magma Hills' then
        TeleportRemote:FireServer(stats, Base, tostring(Player), 'Magma Hills')
        TeleportRemote:FireServer(stats, Base, tostring(Player), 'Magma Hills')
    elseif loc == 'Poisoned Cove' then
        TeleportRemote:FireServer(stats, Base, tostring(Player), 'Poisoned Cove')
        TeleportRemote:FireServer(stats, Base, tostring(Player), 'Poisoned Cove')
    elseif loc == 'Plasma Ruins' then
        TeleportRemote:FireServer(stats, Base, tostring(Player), 'Plasma Ruins')
        TeleportRemote:FireServer(stats, Base, tostring(Player), 'Plasma Ruins')
    elseif loc == 'Graveyard' then
        TeleportRemote:FireServer(stats, Base, tostring(Player), 'Graveyard')
        TeleportRemote:FireServer(stats, Base, tostring(Player), 'Graveyard')
    end
end)

-- MISC STUFF --
Upgrades:Section('Misc')

Upgrades:Button('Rejoin PUBLIC SERVER', function()
    game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId, game.JobId)
end)

Upgrades:Button('Destroy', function()
   CoreGui['1Z2Y3X']:Destroy() 
end)
