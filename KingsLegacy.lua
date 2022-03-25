local Players          = game:GetService('Players')
local LocalPlayer      = Players.LocalPlayer
local Character        = LocalPlayer.Character
local HumanoidRootPart = Character:WaitForChild('HumanoidRootPart')
local Humanoid         = Character:WaitForChild('Humanoid')
local UILib            = loadstring(game:HttpGet('https://raw.githubusercontent.com/Karshtakavaar/Folder/main/WallysUI', true))()
local Window1          = UILib:CreateWindow('Teleports')
local Window2          = UILib:CreateWindow('Main Stuff?')
local Window3          = UILib:CreateWindow('Misc')
local SpawnPoints      = game:GetService('Workspace').SpawnPoints
local RedeemCodeRemote = game:GetService('ReplicatedStorage').Remotes.Functions.redeemcode
local Location         = game:GetService('Workspace').AllspawnDF

for i, v in next, game:GetService('CoreGui'):GetChildren() do
    if v.Name == 'ScreenGui' then
        v.Name = 'MainUI'
        end
end

LocalPlayer.CharacterAdded:Connect(function(NewChar)
    Character = NewChar
end)

LocalPlayer.CharacterAdded:Connect(function(NewChar)
    Humanoid = NewChar:WaitForChild('Humanoid')
end)

LocalPlayer.CharacterAdded:Connect(function(NewChar)
    HumanoidRootPart = NewChar:WaitForChild('HumanoidRootPart')
end)

Window1:Dropdown('Locations', {
    location = _G;
 flag = 'TeleportLocation';
 list = {
     'Start Island LVL 0';
     'Pirate Island LVL 50';
     'Soldier Island LVL 100';
     'Snow Island LVL 400';
     'Desert Island LVL 525';
     'Shark Island LVL 180';
     'Chef Ship LVL 250';
     'Bubble Island LVL 1K';
     'Sky Island LVL 800';
     'Lobby Island LVL 1.25K';
     'Zombie Island LVL 1.5K';
     'War Island LVL 1.75K';
     'Fishland LVL 2K'
 }
}, function(Location)
if Location == 'Start Island LVL 0' then
    HumanoidRootPart.CFrame = SpawnPoints.Spawn1.CFrame
elseif Location == 'Pirate Island LVL 50' then
    HumanoidRootPart.CFrame = SpawnPoints.Spawn2.CFrame
elseif Location == 'Soldier Island LVL 100' then 
    HumanoidRootPart.CFrame = SpawnPoints.Spawn3.CFrame
elseif Location == 'Snow Island LVL 400' then
    HumanoidRootPart.CFrame = SpawnPoints.Spawn4.CFrame
elseif Location == 'Desert Island LVL 525' then
    HumanoidRootPart.CFrame = SpawnPoints.Spawn5.CFrame
elseif Location == 'Shark Island LVL 180' then
    HumanoidRootPart.CFrame = SpawnPoints.Spawn6.CFrame
elseif Location == 'Chef Ship LVL 250' then
    HumanoidRootPart.CFrame = SpawnPoints.Spawn7.CFrame
elseif Location == 'Bubble Island LVL 1K' then
    HumanoidRootPart.CFrame = SpawnPoints.Spawn8.CFrame
elseif Location == 'Sky Island LVL 800' then
    HumanoidRootPart.CFrame = SpawnPoints.Spawn9.CFrame
elseif Location == 'Lobby Island LVL 1.25K' then
    HumanoidRootPart.CFrame = SpawnPoints.Spawn10.CFrame
elseif Location == 'Zombie Island LVL 1.5K' then
    HumanoidRootPart.CFrame = SpawnPoints.Spawn11.CFrame
elseif Location == 'War Island LVL 1.75K' then
    HumanoidRootPart.CFrame = SpawnPoints.Spawn12.CFrame
elseif Location == 'Fishland LVL 2K' then
    HumanoidRootPart.CFrame = SpawnPoints.Spawn13.CFrame

    end
end)

local RedeemCodes = Window2:Button('Redeem All Codes', function()
    RedeemCodeRemote:InvokeServer('Peodiz')
    RedeemCodeRemote:InvokeServer('DinoxLive')
    RedeemCodeRemote:InvokeServer('1MFAV')
    RedeemCodeRemote:InvokeServer('THXFOR1BVISIT')
    RedeemCodeRemote:InvokeServer('Update3_17')

end)
local Section1 = Window2:Section('')

local StatReset = Window2:Button('Stat Reset', function()
    RedeemCodeRemote:InvokeServer('550KLIKES')
end)

local section2 = Window2:Section('ONE TIME USE ^')

task.spawn(function()
    while task.wait() do
    if Window2.flags.DevilFruit then
        
        
         for i, v in next, Location:GetDescendants() do
            if v.Name == 'Handle' then
                HumanoidRootPart.CFrame = v.CFrame
            elseif Humanoid.Health < 500 then
        HumanoidRootPart.CFrame = game:GetService('Workspace').SpawnPoints.Spawn1.CFrame
                 end
            end
        end
    end
end)
Window2:Toggle('Devil Fruit AutoFarm', {flag = 'DevilFruit'})

local Section3 = Window2:Section('^ Kinda Buggy')

local EnablePVP = Window2:Button('Enable PVP', function()
    LocalPlayer.PlayerStats.PVP.Value = true
    
end)

local DisablePVP = Window2:Button('Disable PVP', function()
    LocalPlayer.PlayerStats.PVP.Value = false
    
end)

-- Skidded from IY - https://github.com/EdgeIY/infiniteyield/blob/master/source
local AntiAFK = Window3:Button('Anti Afk', function()
	local GC = getconnections or get_signal_cons
	if GC then
		for i,v in pairs(GC(Players.LocalPlayer.Idled)) do
			if v["Disable"] then
				v["Disable"](v)
			elseif v["Disconnect"] then
				v["Disconnect"](v)
			end
		end   
	end
end)


local Destroy = Window3:Button('Destroy UI', function()
    game:GetService('CoreGui').MainUI:Destroy()
end)
