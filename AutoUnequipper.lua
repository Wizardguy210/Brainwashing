--// LOCALS!!! \\--

local LP = game:GetService('Players').LocalPlayer


--// SCRIPTA!!! \\--
_G.A = true
    while _G.A do
        wait()
pcall(function()
    for i,v in pairs(LP.Character:GetDescendants()) do
    if v:IsA'Tool' then
        v.Parent = LP.Backpack
end
end
end)
end
