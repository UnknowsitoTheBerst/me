   ---Progess

   for _, v in pairs(getgc(true)) do
        if pcall(function() return rawget(v, "indexInstance") end) and type(rawget(v, "indexInstance")) == "table" and (rawget(v, "indexInstance"))[1] == "kick" then
            v.tvk = { "kick", function() return game.Workspace:WaitForChild("") end }
        end
    end
    
    for _, v in next, getgc() do
        if typeof(v) == "function" and islclosure(v) and not isexecutorclosure(v) then
            local Constants = debug.getconstants(v)
            if table.find(Constants, "Detected") and table.find(Constants, "crash") then
                setthreadidentity(2)
                hookfunction(v, function()
                    return task.wait(9e9)
                end)
                setthreadidentity(7)
            end
        end
    end


    local NPCList = {}
    local QuestNPCList = {}
    local Moves = {}
    local lp = game:GetService("Players").LocalPlayer
    local BlacklistedNPC = { "Quest", "Filler", "Aretim", "PurgNPC", "ExampleNPC", "Pup 1", "Pup 2", "Pup 3" }
    local aux = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/UnknowBest/Floppa/main/floppa.lua"))()
    function checkforfight()
        if game:GetService("Workspace").Living[lp.Name]:FindFirstChild("FightInProgress") then
            return true
        else
            return false
        end
    end
    
    function getproximity()
        for _, Cauldrons in next, game:GetService("Workspace").Cauldrons:GetDescendants() do
            if Cauldrons:IsA("ProximityPrompt") then
                fireproximityprompt(Cauldrons)
            end
        end
    end
    
    function getclicker()
        for _, CauldronsClick in next, game:GetService("Workspace").Cauldrons:GetDescendants() do
            if CauldronsClick:IsA("ClickDetector") then
                fireclickdetector(CauldronsClick)
            end
        end
    end
    
    for _, Movess in next, lp.PlayerGui.StatMenu.SkillMenu.Actives:GetChildren() do
        if Movess:IsA("TextButton") then
            table.insert(Moves, Movess.Name)
        end
    end
    
    for _, NPC in next, game:GetService("Workspace").NPCs:GetChildren() do
        if NPC:IsA("Model") and not table.find(BlacklistedNPC, NPC.Name) then
            table.insert(NPCList, NPC.Name)
        end
    end
    
    for _, QuestNPC in next, game:GetService("Workspace").NPCs.Quest:GetChildren() do
        if QuestNPC:IsA("Model") then
            table.insert(QuestNPCList, QuestNPC.Name)
        end
    end

    
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/UnknowBest/Floppa/main/floppa.lua')))()
local Window = OrionLib:MakeWindow({
    Name = "Floppa Hub | Arcane Lineage",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "FoolArcLin"
})


local PlayerSec = Window:MakeTab({
    Name = "Dupe",
    PremiumOnly = false
})

local PlayerSec = PlayerSec:AddSection({
    Name = "Enable then drop the item(s) to another account then rejoin/leave"
})

PlayerSec:AddButton({
    Name = "Enable Rollback",
    Callback = function()
        while task.wait() do
            local ohTable1 = {
                ["1"] = "\255"
            }
            game:GetService("ReplicatedStorage").Remotes.Data.UpdateHotbar:FireServer(ohTable1)
            print("Rollback Setup")
        end
    end
})

PlayerSec:AddButton({
    Name = "Rejoin",
    Callback = function()
        local ts = game:GetService("TeleportService")
        local p = lp
        ts:TeleportToPlaceInstance(game.PlaceId, game.JobId, p)
    end
})


-- Combat

local Combat = Window:MakeTab({
    Name = "Combat",
    PremiumOnly = false
})

Combat:AddToggle({
    Name = "Auto-Dodge",
    Default = false,
    Save = true,
    Flag = "AutoDodge",
    Callback = function(Value)
        getgenv().AutoDodge = (Value)

        while AutoDodge do
            task.wait()
            local ohTable1 = {
                [1] = true,
                [2] = true
            }
            local ohString2 = "DodgeMinigame"

            game:GetService("ReplicatedStorage").Remotes.Information.RemoteFunction:FireServer(ohTable1, ohString2)
            task.wait()
        end
    end
})


Combat:AddToggle({
    Name = "Auto-Attack",
    Default = true,
    Callback = function(Value)
        getgenv().AutoAttack = (Value)

        local function performAttack(target)
            local ohString1 = "Attack"
            local ohString2 = tostring(MoveToUse)
            local ohTable3 = {
                ["Attacking"] = target
            }

            lp.PlayerGui.Combat.CombatHandle.RemoteFunction:InvokeServer(
                ohString1, ohString2, ohTable3)
        end

        while AutoAttack do
            task.wait()
            if checkforfight() then
                local enemiesToAttack = {}
                for _, Enemies in next, game:GetService("Workspace").Living:GetDescendants() do
                    if Enemies:IsA("IntValue") and Enemies.Value == game:GetService("Workspace").Living[lp.Name].FightInProgress.Value and Enemies.Parent.Name ~= lp.Name then
                        table.insert(enemiesToAttack, Enemies.Parent.Name)

                        for _, enemyName in ipairs(enemiesToAttack) do
                            local enemy = game:GetService("Workspace").Living[enemyName]
                            if enemy then
                                performAttack(enemy)
                            end
                            task.wait(1)
                        end
                    else
                    end
                end
            end
        end
    end
})

Combat:AddDropdown({
    Name = "Auto-Attack Move",
    Default = "",
    Options = Moves,
    Callback = function(Value)
        MoveToUse = Value
    end
})
local Misc = Window:MakeTab({
    Name = "Misc",
    PremiumOnly = false
})

local AntiAFK = Misc:AddSection({
    Name = "Anti-AFK Active"
})


OrionLib:Init()
