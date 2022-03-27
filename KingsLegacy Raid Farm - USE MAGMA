getgenv().Farm = false
if game.PlaceId == 4520749081 then
wait(25)
end
print('executed')

    if game.PlaceId == 5931540094 then
        wait(5)
            game:GetService('ReplicatedStorage').ChooseMapRemote:FireServer('Normal')
                wait(17)
            game:GetService('ReplicatedStorage').GoldenArenaEvents.StartEvent:FireServer()
    end

local Players          = game:GetService('Players')
local LocalPlayer      = Players.LocalPlayer
local Character        = LocalPlayer.Character
local HumanoidRootPart = Character:WaitForChild('HumanoidRootPart')
local Humanoid         = Character:WaitForChild('Humanoid')
local TP               = game:GetService('TeleportService')
local TweenService     = game:GetService('TweenService')
local Info             = TweenInfo.new(6, Enum.EasingStyle.Sine)
LocalPlayer.CharacterAdded:Connect(function(NewChar)
    Character = NewChar
end)

LocalPlayer.CharacterAdded:Connect(function(NewChar)
    HumanoidRootPart = NewChar:WaitForChild('HumanoidRootPart')
end)

LocalPlayer.CharacterAdded:Connect(function(NewChar)
    Humanoid = NewChar:WaitForChild('Humanoid')
end)   
local newTween = TweenService:Create(HumanoidRootPart, Info, {CFrame = CFrame.new(-9, 185, 44) * CFrame.Angles(math.rad(-90),0,0)})

    if game.PlaceId == 4520749081 then
        wait(7)
            HumanoidRootPart.CFrame = game:GetService('Workspace').CircleBeam.CFrame
                wait(35) 
    end


    Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)    

if game.PlaceId == 5931540094 then
    newTween:Play()     
    wait(6.05)
    HumanoidRootPart.Anchored = true
end

while getgenv().Farm do
wait()
    if game.PlaceId == 5931540094 then
    for i, v in next, game.Players.LocalPlayer.Backpack:GetChildren() do
    if v.Name == 'MagmaMagma' then
        v.Parent = game.Players.LocalPlayer.Character
    end
end
Character.MagmaMagma.V:InvokeServer()
wait(1)
Character.MagmaMagma.Z:InvokeServer(CFrame.new(-6, 21, 77), 'Hold')        
wait(.5)
Character.MagmaMagma.Z:InvokeServer(CFrame.new(-6, 21, 77), 'Fire')
wait(1)
Character.MagmaMagma.X:InvokeServer(CFrame.new(-6, 21, 77), 'Hold')
wait(.5)
Character.MagmaMagma.X:InvokeServer(CFrame.new(-6, 21, 77), 'Fire')
        if game:GetService('Workspace').Surface.SurfaceGui.TextLabel.Text == 'Wave : 11' then
TP:Teleport(4520749081)
        end
    end
end
