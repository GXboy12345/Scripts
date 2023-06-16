local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Gboy's +1 JP/sec script", "Midnight")

-- GUI CONFIGS

local Main = Window:NewTab("Main")
local Credits = Window:NewTab("Credits")
local Hatch = Main:NewSection("Auto Hatch Egg")
local Pet = Main:NewSection("Pet Management")
local creditsection = Credits:NewSection("Script Credits")
creditsection:NewLabel("Script by Gboy#0933")
creditsection:NewLabel("UI library by xHeptc (KavoUILib)")
local hatchEnabled = false  -- Variable to store the state of autohatch toggle
local manageEnabled = false -- Variable to store the state of pet management toggle
local eggPaths = { 
    dirt_egg = "workspace.Worlds.Earth_Realm.Dirt_Egg.Purchase.ProximityPrompt", 
    rock_egg = "workspace.Worlds.Earth_Realm.Rock_Egg.Purchase.ProximityPrompt", 
    sandy_egg = "workspace.Worlds.Desert_Realm.Eggs.Sandy_Egg.Purchase.ProximityPrompt", 
    snowy_egg = "workspace.Worlds.Show_Realm.Eggs.Snowy_Egg.Purchase.ProximityPrompt",
    marble_egg = "workspace.Worlds.Mountain_Realm.Eggs.Marble_Egg.Purchase.ProximityPrompt",
    ice_egg = "workspace.Worlds.Ice_Realm.Eggs.Ice_egg.Purchase.ProximityPrompt",
    cracked_lava_egg = "workspace.Worlds.Volcano_Realm.Eggs.Cracked_lava_egg.Purchase.ProximityPrompt",
    quartz_egg = "workspace.Worlds.Crystal_Realm.Eggs.Quartz_egg.Purchase.ProximityPrompt",
    poison_brain_egg = "workspace.Worlds.Poison_Realm.Eggs.Poison_Brain_Egg.Purchase.ProximityPrompt",
    radioactive_egg = "workspace.Worlds.Nuclear_Realm.Eggs.Radioactive_Egg.Purchase.ProximityPrompt",
    lava_egg = "workspace.Worlds.Lava_Realm.Eggs.Lava_Egg.Purchase.ProximityPrompt",
    moon_rock_egg = "workspace.Worlds.Moon_Realm.Eggs.Moon_Rock_Egg.Purchase.ProximityPrompt",
    mars_rock_egg = "workspace.Worlds.Mars_Realm.Eggs.Mars_Rock_Egg.Purchase.ProximityPrompt",
    sun_egg = "workspace.Worlds.Sun_Realm.Eggs.Sun_Egg.Purchase.ProximityPrompt",
    cracked_void_egg = "workspace.Worlds.Void_Realm.Eggs.Cracked_Void_Egg.Purchase.ProximityPrompt",
    devil_egg = "workspace.Worlds.Underworld_Realm.Eggs.Devil_Egg.Purchase.ProximityPrompt",
    heaven_egg = "workspace.Worlds.Heaven_Realm.Eggs.Heaven_Egg.Purchase.ProximityPrompt",
}
local eggNames = {}
for key, _ in pairs(eggPaths) do
  table.insert(eggNames, key)
end
Hatch:NewDropdown("Select an egg to autohatch!", "choose which egg you'd like to autohatch", eggNames, function(currentOption)
    eggSelection = eggPaths[currentOption]
end)
Hatch:NewLabel("Note: Go to the egg's prompt to autohatch")
Hatch:NewToggle("Autohatch", "Enable Script", function(state)
    hatchEnabled = state
end)

Pet:NewToggle("Pet Management", "Every 60 seconds crafts all, and equips best pets", function(state)
    manageEnabled = state
end)
local teleports = Main:NewSection("Teleports")
local waypoints = { 
    Earth_Spawn = "-94, 15, 27",
    Desert_Spawn = "-94, 15, -209",
    Snow_Spawn = "-94, 15, -447",
    Mountain_Spawn = "-94, 15, -683",
    Ice_Spawn = "-94, 15, -1395",
    Volcano_Spawn = "-94, 15, -1158",
    Crystal_Spawn = "-95, 15, -1395",
    Poison_Spawn = "-95, 15, -1632",
    Nuclear_Spawn = "-95, 15, -1869",
    Lava_Spawn = "-95, 15, -2106",
    Moon_Spawn = "-94, 15, -2343",
    Mars_Spawn = "-95, 15, -2580",
    Sun_Spawn = "-94, 15, -2817",
    Void_Spawn = "-93, 15, -3054",
    Underworld_Spawn = "-94, 15, -3291",
    Heaven_Spawn = "-93, 15, -3528",
    Earth_Tower = "111, 2224, 27", --1
    Desert_Tower = "111, 4434, -210", --2
    Snow_Tower = "110, 5760, -446", --3
    Mountain_Tower = "111, 7528, -684", --4
    Ice_Tower = "111, 9075, -922", --5
    Volcano_Tower = "111, 13716, -1158", --6
    Crystal_Tower = "113, 18357, -1395", --7
    Poison_Tower = "122, 23003, -1632", --8
    Nuclear_Tower = "120, 30955, -1866", --9
    Lava_Tower = "119, 38691, -2109", --10
    Moon_Tower = "120,48635,-2341", --11
    Mars_Tower = "120, 60790, -2579", --12
    Sun_Tower = "123, 88415, -2817", --13
    Void_Tower = "119, 176817, -3051", --14
    Underworld_Tower = "117,196017,-3289", --15
    Heaven_Jump_Pad = "51, 16, -3528" --16
}
local coordinates = {}
local waypointNames = {}
for k, v in pairs(waypoints) do
    local x, y, z = string.match(v, "([^,]+),([^,]+),([^,]+)")
    if x and y and z then
        x = tonumber(x)
        y = tonumber(y)
        z = tonumber(z)
        coordinates[k] = { x = x, y = y, z = z }
        table.insert(waypointNames, k)
    end
end
teleports:NewDropdown("Choose a waypoint to teleport to", "This determines where you teleport", waypointNames, function(currentOption)
    coordSelection = coordinates[currentOption]
end)
local UIBind = Main:NewSection("Toggle UI keybind")
UIBind:NewKeybind("click to set toggle UI keybind", "Toggles UI", Enum.KeyCode.F, function()
	Library:ToggleUI()
end)
local function teleport(pos)
    if type(pos) == "table" then
        pos = string.format("%d, %d, %d", pos.x, pos.y, pos.z)
    end
    
    local x, y, z = string.match(pos, "(-?%d+%.?%d*),%s*(-?%d+%.?%d*),%s*(-?%d+%.?%d*)")
    if x and y and z then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
    else
        print("Invalid coordinates format")
    end
end
teleports:NewButton("Teleport", "teleports to selected waypoint", function()
    teleport(coordSelection)
end)
-- Functions

local function fireproximityprompt(path, Amount, Skip)
    local Obj = game.Workspace:FindFirstChild(path)
    if Obj and Obj:IsA("ProximityPrompt") then 
        Amount = Amount or 1
        local PromptTime = Obj.HoldDuration
        if Skip then 
            Obj.HoldDuration = 0
        end
        for i = 1, Amount do 
            Obj:InputHoldBegin()
            if not Skip then 
                wait(Obj.HoldDuration)
            end
            Obj:InputHoldEnd()
        end
        Obj.HoldDuration = PromptTime
    else 
        error("ProximityPrompt not found at path: " .. path)
    end
end

local function craft()
    for i = 1,3 do
        local args = {
         [1] = game:GetService("Players").LocalPlayer.Custom_Data.Pets_Equipped.Slot_2:FindFirstChild("Gold: 50")
        }
        game:GetService("ReplicatedStorage").Remote_Functions.Craft_All:InvokeServer(unpack(args))
    end
end

local function unequip()
    local args = {
      [1] = game:GetService("Players").LocalPlayer.Custom_Data.Pets_Equipped.Slot_1:FindFirstChild("Gold: 50")
    }
    game:GetService("ReplicatedStorage").Remote_Functions.Unequip_All:InvokeServer(unpack(args))
end

local function eqBest()
    local args = {
      [1] = game:GetService("Players").LocalPlayer.Custom_Data.Pets_Stored:FindFirstChild("Gold: 50")
    }
    game:GetService("ReplicatedStorage").Remote_Functions.Equip_Best:InvokeServer(unpack(args))
end

local function autoHatch()
    while true do
        if hatchEnabled then
            fireproximityprompt(loadstring(eggSelection), 1, true)
            wait(4.25)
        end
        wait()
    end
end

local function manageRoutine()
    local i = 0
    while true do
        if manageEnabled then
            i = i + 1
            print('routine ' .. i .. ' starting now...')
            craft()
            wait()
            unequip()
            wait()
            eqBest()
            print('routine ' .. i .. ' complete, waiting time...')
            for j = 1, 60 do
                wait(1)
                print(j .. '/60 seconds waited...')
                if not manageEnabled then
                    print("Instance aborted due to toggle update")
                    break
                end
            end
        end
        wait()
    end
end

-- Run the functions continuously

while true do
    autoHatch()
    manageRoutine()
    wait()
end