
--[[
Note: The Itemtable and all that will have to be customized to your setup over time, It's set too my setup with rebirth items that you would be able too place, configure it in your own way.

--]]
local Rebirth, Layout, Withdraw = game:getService('ReplicatedStorage')['Rebirth'], game:GetService('ReplicatedStorage')['Layouts'], game:GetService('ReplicatedStorage')['DestroyAll']
local UI = loadstring(game:HttpGet('https://raw.githubusercontent.com/Karshtakavaar/Folder/main/WallysUI', true))()
local Window1 = UI:CreateWindow('Layouts')
local Window2 = UI:CreateWindow('Others')
local ItemTable = {
    [1] = {
        ['CostPerUnit'] = 50000000,
        ['Name'] = 'Blue Teleporter Receiver',
        ['Amount'] = 1
    },
    [2] = {
        ['CostPerUnit'] = 10000000000000,
        ['Name'] = 'Orbital Raised Obliterator',
        ['Amount'] = 1
    },
    [3] = {
        ['CostPerUnit'] = 100000,
        ['Name'] = 'Raised Conveyor',
        ['Amount'] = 4
    },
    [4] = {
        ['CostPerUnit'] = 5000000000,
        ['Name'] = 'Miniature Refiner',
        ['Amount'] = 4
    },
    [5] = {
        ['CostPerUnit'] = 75000000,
        ['Name'] = 'Emerald Enhancer',
        ['Amount'] = 1
    },
    [6] = {
        ['CostPerUnit'] = 650000000000,
        ['Name'] = 'Impulsion Refinery',
        ['Amount'] = 1
    },
    [7] = {
        ['CostPerUnit'] = 1000000,
        ['Name'] = 'Green Teleporter Receiver',
        ['Amount'] = 1
    },
    [8] = {
        ['CostPerUnit'] = 1000000,
        ['Name'] = 'Green Teleporter Sender',
        ['Amount'] = 1
    },
    [9] = {
        ['CostPerUnit'] = 425000000000000,
        ['Name'] = 'Scrapyard Enchancer',
        ['Amount'] = 1
    },
    [10] = {
        ['CostPerUnit'] = 100,
        ['Name'] = 'Centering Conveyor',
        ['Amount'] = 2
    },
    [11] = {
        ['CostPerUnit'] = 500000000000,
        ['Name'] = 'Toxin Pillars',
        ['Amount'] = 1
    },
    [12] = {
        ['CostPerUnit'] = 50000000,
        ['Name'] = 'Blue Teleporter Sender',
        ['Amount'] = 1
    },
    [13] = {
        ['CostPerUnit'] = 1250000000,
        ['Name'] = 'Corroding Device',
        ['Amount'] = 1
    },
    [14] = {
        ['CostPerUnit'] = 100000000,
        ['Name'] = 'Ore Buffer',
        ['Amount'] = 1
    },
    [15] = {
        ['CostPerUnit'] = 75000000000,
        ['Name'] = 'Containment Breach',
        ['Amount'] = 2
    },
    [16] = {
        ['CostPerUnit'] = 500000000000000,
        ['Name'] = 'Hyper Tunnel',
        ['Amount'] = 4
    },
    [17] = {
        ['CostPerUnit'] = 25000000000,
        ['Name'] = 'Mint Sprayer',
        ['Amount'] = 1
    },
    [18] = {
        ['CostPerUnit'] = 2500,
        ['Name'] = 'Charging Device',
        ['Amount'] = 1
    },
    [19] = {
        ['CostPerUnit'] = 1000000000000000,
        ['Name'] = 'Springy Refiner',
        ['Amount'] = 2
    },
    [20] = {
        ['CostPerUnit'] = 250000000,
        ['Name'] = 'Electric Rose Enchancer',
        ['Amount'] = 1
    },
    [21] = {
        ['CostPerUnit'] = 500000000,
        ['Name'] = 'Ore Moltizer',
        ['Amount'] = 1
    },
    [22] = {
        ['CostPerUnit'] = 1000000000000,
        ['Name'] = 'Raised Crimson Refiner',
        ['Amount'] = 1
    },
    [23] = {
        ['CostPerUnit'] = 5000000,
        ['Name'] = 'Raised Side Cleanser',
        ['Amount'] = 8
    },
    [24] = {
        ['CostPerUnit'] = 50000,
        ['Name'] = 'Signal Amplifier',
        ['Amount'] = 2
    },
    [25] = {
        ['CostPerUnit'] = 2500000000,
        ['Name'] = 'Overhang Refiner',
        ['Amount'] = 1
    },
    [26] = {
        ['CostPerUnit'] = 75000,
        ['Name'] = 'Basic Ramp',
        ['Amount'] = 1
    },
    [27] = {
        ['CostPerUnit'] = 1000,
        ['Name'] = 'Hyper Supplier',
        ['Amount'] = 2
    },
    [28] = {
        ['CostPerUnit'] = 125000000000000,
        ['Name'] = 'Slimey Refinery',
        ['Amount'] = 1
    },
    [29] = {
        ['CostPerUnit'] = 50000000000000000,
        ['Name'] = 'Ore Charger',
        ['Amount'] = 1
        
    },
    [30] = {
        ['CostPerUnit'] = 1000000000000000000,
        ['Name'] = 'Cyber Temple',
        ['Amount'] = 1
    }
}


Window1:Button('Load Layout 1', function()
    Layout:InvokeServer('Load', 'Layout1')
end)

Window1:Button('Load Layout 2', function()
        Layout:InvokeServer('Check')
    Layout:InvokeServer('Load', 'Layout2', ItemTable)
        Layout:InvokeServer('Check')
end)

Window1:Button('Load Layout 3', function()
    Layout:InvokeServer('Load', 'Layout3')
end)

task.spawn(function()
   while task.wait() do
       if Window2.flags.Rebirth then
    wait(3)
    Rebirth:InvokeServer()
       end
       end
end)
Window2:Toggle('Auto Rebirth', {flag = 'Rebirth'})

task.spawn(function()
   while task.wait() do
       if Window2.flags.AutoFarm then
           Layout:InvokeServer('Load', 'Layout1')
            wait(22)
        Withdraw:InvokeServer()
        wait(.5)
        Layout:InvokeServer('Load', 'Layout2', ItemTable)
            wait(45)
        Rebirth:InvokeServer()
        wait(1)
       end
    end
end)
Window2:Toggle('AutoFarm', {flag = 'AutoFarm'})


Window2:Button('Withdraw All', function()
    Withdraw:InvokeServer()
end)

Window2:Button('Destroy', function()
    game:GetService('CoreGui')['ScreenGui']:Destroy() 
end)
