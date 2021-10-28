local Humanoid = game:GetService('Players').LocalPlayer.Character.HumanoidRootPart
_G.A = true
while _G.A do
    wait()
 Humanoid.Anchored = true
 wait(.5)
 
 Humanoid.Anchored = false
end
