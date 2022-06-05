-- Loader
if game.GameId == 3475191052 then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Karshtakavaar/Brainwashing/main/GoalGame.lua', true))()-- Goal
    elseif game.GameId == 2998444255 then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Karshtakavaar/Brainwashing/main/SlashingSimulator.lua', true))()-- Goal
    elseif game.GameId ~= 3475191052 or 2998444255 then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Karshtakavaar/Brainwashing/main/Multi.lua', true))()-- Goal
end
