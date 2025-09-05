--############################################
--#####        PALADINUI by Johan        #####
--############################################

-- Full credit to Taste

local TMW                                            = TMW 
local CNDT                                            = TMW.CNDT
local Env                                            = CNDT.Env

local A                                                = Action
local GetToggle                                        = A.GetToggle
local InterruptIsValid                                = A.InterruptIsValid

local UnitCooldown                                    = A.UnitCooldown
local Unit                                            = A.Unit 
local Player                                        = A.Player 
local Pet                                            = A.Pet
local LoC                                            = A.LossOfControl
local MultiUnits                                    = A.MultiUnits
local EnemyTeam                                        = A.EnemyTeam
local FriendlyTeam                                    = A.FriendlyTeam
local TeamCache                                        = A.TeamCache
local InstanceInfo                                    = A.InstanceInfo
local TR                                            = Action.TasteRotation
local select, setmetatable                            = select, setmetatable

A.Data.ProfileEnabled[Action.CurrentProfile] = true
A.Data.ProfileUI = {      
    DateTime = "v1 (25 Aug 2025)",
    -- Class settings
    [2] = {
        [ACTION_CONST_PALADIN_RETRIBUTION] = {          
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- General -- ",
                    },
                },
            },            
            { -- [1] 1st Row        
                {
                    E = "Checkbox", 
                    DB = "mouseover",
                    DBV = true,
                    L = { 
                        enUS = "Use @mouseover", 
                        ruRU = "Использовать @mouseover", 
                        frFR = "Utiliser les fonctions @mouseover",
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing", 
                        ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Воскрешение, Хилинг", 
                        frFR = "Activera les actions via @mouseover\n Exemple: Ressusciter, Soigner",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use AoE", 
                        ruRU = "Использовать AoE", 
                        frFR = "Utiliser l'AoE",
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                        frFR = "Activer les actions multi-unités",
                    }, 
                    M = {
                        Custom = "/run Action.AoEToggleMode()",
                        -- It does call func CraftMacro(L[CL], macro above, 1) -- 1 means perCharacter tab in MacroUI, if nil then will be used allCharacters tab in MacroUI
                        Value = value or nil, 
                        -- Very Very Optional, no idea why it will be need however.. 
                        TabN = '@number' or nil,                                
                        Print = '@string' or nil,
                    },
                }, 
                {
                    E = "Slider",                                                     
                    MIN = 2, 
                    MAX = 5,                            
                    DB = "AOEUnits",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = " Minimum Units for AOE Toll/Ashes",
                    }, 
                    M = {},
                },
                
            },     
            { -- [7] Spell Status Frame
                {
                    E = "Header",
                    L = {
                        ANY = " -- Spell Status Frame -- ",
                    },
                },
            },    
            {
                {
                    E         = "Button",
                    H         = 35,
                    OnClick = function(self, button, down)     
                        if button == "LeftButton" then 
                            TR.ToggleStatusFrame() 
                        else                
                            Action.CraftMacro("Status Frame", [[/run Action.TasteRotation.ToggleStatusFrame()]], 1, true, true)   
                        end 
                    end, 
                    L = { 
                        ANY = "Status Frame\nMacro Creator",
                    }, 
                    TT = { 
                        enUS = "Click this button to create the special status frame macro.\nStatus Frame is a new windows that allow user to track blocked spells during fight. So you don't have to check your chat anymore.", 
                        ruRU = "Нажмите эту кнопку, чтобы создать специальный макрос статуса.\nStatus Frame - это новые окна, которые позволяют пользователю отслеживать заблокированные заклинания во время боя. Так что вам больше не нужно проверять свой чат.",  
                        frFR = "Cliquez sur ce bouton pour créer la macro de cadre d'état spécial.\nLe cadre d'état est une nouvelle fenêtre qui permet à l'utilisateur de suivre les sorts bloqués pendant le combat. Vous n'avez donc plus besoin de vérifier votre chat.", 
                    },                           
                },
            },    
            { -- [4] 4th Row
                
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Defensives -- ",
                    },
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "FoLHP",
                    DBV = 50, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(19750) .. " (%)",
                    }, 
                    M = {},
                },    
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "WoGHP",
                    DBV = 50, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(85673) .. " (%)",
                    }, 
                    M = {},
                },        
            },
            { -- [4] 4th Row
                
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Trinkets -- ",
                    },
                },
            },
            {
                {
                    E = "Checkbox", 
                    DB = "TrinketsAoE",
                    DBV = true,
                    L = { 
                        enUS = "Trinkets\nAoE only", 
                        ruRU = "Trinkets\nAoE only",  
                        frFR = "Trinkets\nAoE only",  
                    }, 
                    TT = { 
                        enUS = "Enable this to option to trinkets for AoE usage ONLY.", 
                        ruRU = "Enable this to option to trinkets for AoE usage ONLY.", 
                        frFR = "Enable this to option to trinkets for AoE usage ONLY.", 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 30,                            
                    DB = "TrinketsMinTTD",
                    DBV = 10, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Min TTD",
                    },
                    TT = { 
                        enUS = "Minimum Time To Die for units in range before using Trinkets.\nNOTE: This will calculate Time To Die of your current target OR the Area Time To Die if multiples units are detected.", 
                        ruRU = "Minimum Time To Die for units in range before using Trinkets.\nNOTE: This will calculate Time To Die of your current target OR the Area Time To Die if multiples units are detected.", 
                        frFR = "Minimum Time To Die for units in range before using Trinkets.\nNOTE: This will calculate Time To Die of your current target OR the Area Time To Die if multiples units are detected.", 
                    },                    
                    M = {},
                },
            },
            {
                {
                    E = "Slider",                                                     
                    MIN = 2, 
                    MAX = 10,                            
                    DB = "TrinketsMinUnits",
                    DBV = 20, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Min Units",
                    },
                    TT = { 
                        enUS = "Minimum number of units in range to activate Trinkets.", 
                        ruRU = "Minimum number of units in range to activate Trinkets.", 
                        frFR = "Minimum number of units in range to activate Trinkets.",  
                    },                    
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 40,                            
                    DB = "TrinketsUnitsRange",
                    DBV = 20, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Max AoE range",
                    },
                    TT = { 
                        enUS = "Maximum range for units detection to automatically activate trinkets.", 
                        ruRU = "Maximum range for units detection to automatically activate trinkets.", 
                        frFR = "Maximum range for units detection to automatically activate trinkets.",  
                    },                    
                    M = {},
                },
            },
            
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- PvP -- ",
                    },
                },
            },
            { -- [5] 5th Row     
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "ON MELEE BURST", value = "ON MELEE BURST" },
                        { text = "ON COOLDOWN", value = "ON COOLDOWN" },                    
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "HammerofJusticePvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(853),
                    }, 
                    TT = { 
                        enUS = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Only if melee player has damage buffs\nON COOLDOWN - means will use always on melee players\nOFF - Cut out from rotation but still allow work through Queue and MSG systems\nIf you want fully turn it OFF then you should make SetBlocker in 'Actions' tab", 
                        ruRU = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Только если игрок ближнего боя имеет бафы на урон\nON COOLDOWN - значит будет использовано по игрокам ближнего боя по восстановлению способности\nOFF - Выключает из ротации, но при этом позволяет Очередь и MSG системам работать\nЕсли нужно полностью выключить, тогда установите блокировку во вкладке 'Действия'", 
                    }, 
                    M = {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "@arena1", value = 1 },
                        { text = "@arena2", value = 2 },
                        { text = "@arena3", value = 3 },
                        { text = "primary", value = 4 },
                    },
                    MULT = true,
                    DB = "HammerofJusticePvPUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(853) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },
            },
        },    
        [ACTION_CONST_PALADIN_HOLY] = {          
            LayoutOptions = { gutter = 5, padding = { left = 10, right = 10 } },    
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- General -- ",
                    },
                },
            },        
            {            
                {
                    E = "Checkbox", 
                    DB = "DispelSniper",
                    DBV = true,
                    L = { 
                        enUS = "Use\nDispel Sniper",
                        ruRU = "Активировать\nОчищение снайпер",
                    },
                    TT = { 
                        enUS = "Automatically targets and cleanses allies\nRight click: Create macro",
                        ruRU = "Автоматически нацеливается и использует Очищение на союзниках\nПравая кнопка мышки: Создать макрос",
                    },
                    M = {},
                },                                  
                {
                    E = "Checkbox", 
                    DB = "OffensiveDT",
                    DBV = true,
                    L = { 
                        ANY = "Use\nDivine Toll AOE DPS"
                    },
                    TT = {
                        enUS = "Will use Divine Toll offensively when 5 enemy units are within range\nRight click: Create macro",
                        ruRU = "Будет использовать Божественный благовест в атаке, когда 5 вражеских юнитов находятся в пределах досягаемости.\nПравая кнопка мышки: Создать макрос.",
                    },
                    M = {},
                },               
            },     
            {
                {
                    E = "Checkbox", 
                    DB = "HolyShockDPS",
                    DBV = true,
                    L = { 
                        ANY = "Use\nHoly Shock DPS"
                    },
                    M = {},
                },     
                {
                    E = "Checkbox", 
                    DB = "UseDivineShield",
                    DBV = true,
                    L = { 
                        ANY = "Use\nDivine Shield"
                    },
                    M = {},
                },     
            },
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        " -- Holy Light and Flash of Light HP Thresholds (or Off) -- ",
                    },
                },
            },            
            { -- [3]     
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "WordofGloryHP",
                    DBV = 80,
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(85673) .. " (%HP)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "HolyShockHP",
                    DBV = 90,
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(20473) .. " (%HP)",
                    }, 
                    M = {},
                },
            },
            {
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "HolyLightHP",
                    DBV = 80,
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(82326) .. " (%HP)",
                    }, 
                    M = {},
                },
            },
            {
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "HolyPrismHP",
                    DBV = 80,
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(114165) .. " (%HP)",
                    }, 
                    M = {},
                },
            },
            {
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "FlashofLightHP",
                    DBV = 90,
                    ONOFF = false,
                    L = { 
                        ANY = "Flash of Light (%HP)",
                    },
                    TT = {
                        ANY = "Will use Flash of Light if HP% less than XX\n\nRight click: Create macro",
                    },
                    M = {},
                },                  
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 60,                            
                    DB = "ForceWoGHP",
                    DBV = 30,
                    ONOFF = false,
                    L = { 
                        ANY = "Force WoG over LoD (%HP)",
                    },
                    TT = {
                        ANY = "Prevents Light of Dawn usage if any party member has <= XX% HP\n\nRight click: Create macro",
                    },
                    M = {},
                },  
            },
            {
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "LightofDawnUnits",
                    DBV = 10,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(85222) .. " (# Players < HP %)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "LightofDawnHP",
                    DBV = 95,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(85222) .. " (%HP)",
                    }, 
                    M = {},
                },                
            }, 
            {
                {
                    E = "Slider",                                                     
                    MIN = 3, 
                    MAX = 5,                            
                    DB = "DivineTollUnitsParty",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(304971) .. " Party (# Players < HP %)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 20, 
                    MAX = 90,                            
                    DB = "DivineTollHPParty",
                    DBV = 85,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(304971) .. " Party (%HP)",
                    }, 
                    M = {},
                },        
            },
            {
                {
                    E = "Slider",                                                     
                    MIN = 3, 
                    MAX = 5,                            
                    DB = "DivineTollUnitsRaid",
                    DBV = 5,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(304971) .. " Raid (# Players < HP %)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 20, 
                    MAX = 90,                            
                    DB = "DivineTollHPRaid",
                    DBV = 85,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(304971) .. " Raid (%HP)",
                    }, 
                    M = {},
                },    
            },
            {
                {
                    E = "Slider",                                                     
                    MIN = 2, 
                    MAX = 5,                            
                    DB = "BoVUnitsParty",
                    DBV = 2,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(200025) .. " Party (# Players < HP %)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 20, 
                    MAX = 100,                            
                    DB = "BoVHPParty",
                    DBV = 85,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(200025) .. " Party (%HP)",
                    }, 
                    M = {},
                },        
            },
            {
                {
                    E = "Slider",                                                     
                    MIN = 2, 
                    MAX = 5,                            
                    DB = "BoVUnitsRaid",
                    DBV = 5,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(200025) .. " Raid (# Players < HP %)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 20, 
                    MAX = 100,                            
                    DB = "BoVHPRaid",
                    DBV = 90,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(200025) .. " Raid (%HP)",
                    }, 
                    M = {},
                },    
            },
            {          
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 50,                            
                    DB = "Necrotic",
                    DBV = 35,
                    ONOFF = false,
                    L = { 
                        ANY = "Ignore Necrotic @ X Stacks",
                    }, 
                    TT = {
                        ANY = "Stops Healing Engine from targeting an ally with >= XX Necrotic Stacks\nRight click: Create macro",
                    },
                    M = {},
                },        
            },
            {
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 40,                            
                    DB = "ManaConservation",
                    DBV = 20,
                    ONOFF = false,
                    L = { 
                        ANY = "Mana Conservation %",
                    }, 
                    TT = {
                        ANY = "Begins conserving the use of mana @ XX Mana % by stopping Holy Shock DPS and using Crusader Strike more economically\nAt 0.5 * (XX Mana %) will stop use of Crusader Strike completely",
                    },
                    M = {},
                },       
            },
            {
                {
                    E = "Dropdown",                                                         
                    OT = {   
                        { text = "Dumps @ >= 3 Holy Power", value = 3 },                    
                        { text = "Dumps @ 5 Holy Power", value = 5 },
                    },
                    DB = "DumpHP",
                    DBV = 5,
                    L = { 
                        ANY = "Holy Power Dump",
                    }, 
                    TT = { 
                        ANY = "Will use Shield of the Righteous or Light of Dawn when Holy Power is equal to option value"
                    },                    
                    M = {},
                },  
                {
                    E = "Dropdown",                                                         
                    OT = {   
                        { text = "CS >= 1 second on HS CD", value = 1 },                    
                        { text = "CS >= 1.5 second on HS CD", value = 1.5 },
                        { text = "CS >= 2 second on HS CD", value = 2 },
                    },
                    DB = "CSTime",
                    DBV = 2,
                    L = { 
                        ANY = "Crusader Strike >= HS CD",
                    }, 
                    TT = { 
                        ANY = "Will use Crusader Strike when Holy Shock Cooldown is greater than or equal to set value. Only affects CS usage if you have 2 talent points in CS."
                    },                    
                    M = {},
                },  
            },
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Healing Engine -- ",
                    },
                },
            },    
            -- Beacon of Virtue(talent)
            -- + Classic Beacon 
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Beacons -- ",
                    },
                },
            },              
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Racials -- ",
                    },
                },
            },    
            {
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "RacialBurstHealing",                    
                    DBV = 100,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetLocalization()["TAB"][1]["RACIAL"] .. "\n(Healing HP %)",                        
                    },                     
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "RacialBurstDamaging",                    
                    DBV = 100,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetLocalization()["TAB"][1]["RACIAL"] .. "\n(Damaging HP %)",                        
                    },                     
                    M = {},
                },
            },
            { -- Trinkets
                {
                    E = "Header",
                    L = {
                        ANY = " -- Trinkets -- ",
                    },
                },
            },    
            {                 
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Always", value = "Always" },
                        { text = "Burst Synchronized", value = "BurstSync" },                    
                    },
                    DB = "TrinketBurstSyncUP",
                    DBV = "Always",
                    L = { 
                        enUS = "Damager: How to use trinkets"
                    },
                    TT = { 
                        enUS = "Always: On cooldown\nBurst Synchronized: By Burst Mode in 'General' tab"
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 100,                            
                    DB = "TrinketMana",
                    DBV = 85,
                    ONLYOFF = false,
                    L = { 
                        enUS = "Trinket: Mana(%)"
                    },
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 100,                            
                    DB = "TrinketBurstHealing",
                    DBV = 75,
                    ONLYOFF = false,
                    L = { 
                        enUS = "Healer: Target Health (%)"
                    },
                    M = {},
                },        
            },         
        },
    },
}

-----------------------------------------
--                   PvP  
-----------------------------------------

function A.Main_CastBars(unit, list)
    if not A.IsInitialized or A.IamHealer or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    
    if A[A.PlayerSpec] and A[A.PlayerSpec].SpearHandStrike and A[A.PlayerSpec].SpearHandStrike:IsReadyP(unit, nil, true) and A[A.PlayerSpec].SpearHandStrike:AbsentImun(unit, {"KickImun", "TotalImun", "DamagePhysImun"}, true) and A.InterruptIsValid(unit, list) then 
        return true         
    end 
end 

function A.Second_CastBars(unit)
    if not A.IsInitialized or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    
    local Toggle = A.GetToggle(2, "ParalysisPvP")    
    if Toggle and Toggle ~= "OFF" and A[A.PlayerSpec] and A[A.PlayerSpec].Paralysis and A[A.PlayerSpec].Paralysis:IsReadyP(unit, nil, true) and A[A.PlayerSpec].Paralysis:AbsentImun(unit, {"CCTotalImun", "TotalImun", "DamagePhysImun"}, true) and Unit(unit):IsControlAble("incapacitate", 0) then 
        if Toggle == "BOTH" then 
            return select(2, A.InterruptIsValid(unit, "Heal", true)) or select(2, A.InterruptIsValid(unit, "PvP", true)) 
        else
            return select(2, A.InterruptIsValid(unit, Toggle, true))         
        end 
    end 
end 

