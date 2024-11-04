--#############################################
--##### Edited Trip Holy Paladin by Johan #####
--#############################################


local _G, setmetatable                            = _G, setmetatable
local TMW                                       = TMW
local CTT                                         = _G.CTT
local CNDT                                      = TMW.CNDT
local Env                                       = CNDT.Env
local A                                         = _G.Action
local Listener                                  = Action.Listener
local Create                                    = Action.Create
local GetToggle                                 = Action.GetToggle
local SetToggle                                 = Action.SetToggle
local GetGCD                                    = Action.GetGCD
local GetCurrentGCD                             = Action.GetCurrentGCD
local GetPing                                   = Action.GetPing
local ShouldStop                                = Action.ShouldStop
local BurstIsON                                 = Action.BurstIsON
local AuraIsValid                               = Action.AuraIsValid
local InterruptIsValid                          = Action.InterruptIsValid
local FrameHasSpell                             = Action.FrameHasSpell
local Utils                                     = Action.Utils
local TeamCache                                 = Action.TeamCache
local EnemyTeam                                 = Action.EnemyTeam
local FriendlyTeam                              = Action.FriendlyTeam
local LoC                                       = Action.LossOfControl
local Player                                    = Action.Player 
local MultiUnits                                = Action.MultiUnits
local UnitCooldown                              = Action.UnitCooldown
local Unit                                      = Action.Unit 
local IsUnitEnemy                               = Action.IsUnitEnemy
local IsUnitFriendly                            = Action.IsUnitFriendly
local HealingEngine                             = Action.HealingEngine
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()
local TeamCacheFriendly                         = TeamCache.Friendly
local TeamCacheFriendlyIndexToPLAYERs           = TeamCacheFriendly.IndexToPLAYERs
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local Pet                                       = LibStub("PetLibrary")
local next, pairs, type, print                  = next, pairs, type, print 
local math_floor                                = math.floor
local math_ceil                                 = math.ceil
local tinsert                                   = table.insert 
local select, unpack, table                     = select, unpack, table 
local CombatLogGetCurrentEventInfo              = _G.CombatLogGetCurrentEventInfo
local UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower = UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower
local select, math                              = select, math 
local huge                                      = math.huge  
local UIParent                                  = _G.UIParent 
local CreateFrame                               = _G.CreateFrame
local wipe                                      = _G.wipe
local IsUsableSpell                             = IsUsableSpell
local UnitPowerType                             = UnitPowerType 

--For Toaster
local Toaster                                    = _G.Toaster
local GetSpellTexture                             = _G.TMW.GetSpellTexture

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_PALADIN_HOLY] = {
    -- Racial
    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                      = Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    WillToSurvive                           = Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    Regeneratin                                = Create ({ Type = "Spell", ID = 291944    }),
    
    -- Spells
    Sanguine = Create({ Type = "Spell", ID = 226510, Hidden = true}),    
    Combustion = Create({ Type = "Spell", ID = 99240, Hidden = true}),    
    
    -- Paladin General
    AvengingWrath                    = Action.Create({ Type = "Spell", ID = 31884    }),    
    BlessingofFreedom                = Action.Create({ Type = "Spell", ID = 1044        }),
    BlessingofProtection            = Action.Create({ Type = "Spell", ID = 1022        }),
    BlessingofSacrifice                = Action.Create({ Type = "Spell", ID = 6940        }),
    ConcentrationAura                = Action.Create({ Type = "Spell", ID = 317920    }),
    Consecration                    = Action.Create({ Type = "Spell", ID = 26573    }),
    CrusaderAura                    = Action.Create({ Type = "Spell", ID = 32223    }),
    CrusaderStrike                    = Action.Create({ Type = "Spell", ID = 35395    }),
    DevotionAura                    = Action.Create({ Type = "Spell", ID = 465        }),    
    DivineShield                    = Action.Create({ Type = "Spell", ID = 642        }),
    DivineSteed                        = Action.Create({ Type = "Spell", ID = 190784    }),
    FlashofLight                    = Action.Create({ Type = "Spell", ID = 19750, predictName = "FlashofLight"        }),
    HammerofJustice                    = Action.Create({ Type = "Spell", ID = 853        }),
    HammerofJusticeGreen            = Action.Create({ Type = "SpellSingleColor", ID = 853, Color = "GREEN", Desc = "[1] CC", Hidden = true, Hidden = true, QueueForbidden = true }),    
    HammerofWrath                    = Action.Create({ Type = "Spell", ID = 24275    }),
    HandofReckoning                    = Action.Create({ Type = "Spell", ID = 62124    }),    
    Judgment                        = Action.Create({ Type = "Spell", ID = 275773    }),
    LayOnHands                        = Action.Create({ Type = "Spell", ID = 633, predictName = "LayOnHands"            }),    
    Redemption                        = Action.Create({ Type = "Spell", ID = 7328        }),
    RetributionAura                    = Action.Create({ Type = "Spell", ID = 183435    }),
    ShieldoftheRighteous            = Action.Create({ Type = "Spell", ID = 53600    }),
    TurnEvil                        = Action.Create({ Type = "Spell", ID = 10326    }),
    WordofGlory                        = Action.Create({ Type = "Spell", ID = 85673, predictName = "WordofGlory"        }),    
    Forbearance                        = Action.Create({ Type = "Spell", ID = 25771    }),
    ShieldoftheRighteousBuff         = Action.Create({ Type = "Spell", ID = 132403, Hidden = true        }),    
    
    
    -- Holy Specific
    Absolution                        = Action.Create({ Type = "Spell", ID = 212056    }),
    AuraMastery                        = Action.Create({ Type = "Spell", ID = 31821    }),
    BeaconofLight                    = Action.Create({ Type = "Spell", ID = 53563    }),
    Cleanse                            = Action.Create({ Type = "Spell", ID = 4987        }),
    DivineProtection                = Action.Create({ Type = "Spell", ID = 498        }),
    HolyLight                        = Action.Create({ Type = "Spell", ID = 82326, predictName = "HolyLight"            }),
    HolyShock                        = Action.Create({ Type = "Spell", ID = 20473, predictName = "HolyShock"            }),
    LightofDawn                        = Action.Create({ Type = "Spell", ID = 85222, predictName = "LightofDawn"        }),
    LightofMartyr                    = Action.Create({ Type = "Spell", ID = 183998, predictName = "LightofMartyr"    }),
    InfusionofLight                    = Action.Create({ Type = "Spell", ID = 53576, Hidden = true        }),    
    InfusionofLightBuff                = Action.Create({ Type = "Spell", ID = 54149, Hidden = true        }),    
    EmpyreanLegacy                        = Action.Create({ Type = "Spell", ID = 387170, Hidden = true        }),   
    EmpyreanLegacyDebuff                = Action.Create({ Type = "Spell", ID = 387441, Hidden = true        }),    
    Maraad                            = Action.Create({ Type = "Spell", ID = 388018, Hidden = true        }),   
    MaraadBuff                        = Action.Create({ Type = "Spell", ID = 388019, Hidden = true        }),   
    Intercession                     = Action.Create({ Type = "Spell", ID = 391054        }),
    
    -- Normal Talents
    CrusadersMight                    = Action.Create({ Type = "Spell", ID = 196926, Hidden = true    }),
    BestowFaith                        = Action.Create({ Type = "Spell", ID = 223306, predictName = "BestowFaith"        }),
    LightsHammer                    = Action.Create({ Type = "Spell", ID = 114158    }),    
    SavedbytheLight                    = Action.Create({ Type = "Spell", ID = 157047, Hidden = true    }),
    JudgmentofLight                    = Action.Create({ Type = "Spell", ID = 183778, Hidden = true    }),        
    HolyPrism                        = Action.Create({ Type = "Spell", ID = 114165, predictName = "HolyPrism"        }),
    FistofJustice                    = Action.Create({ Type = "Spell", ID = 234299, Hidden = true    }),
    Repentance                        = Action.Create({ Type = "Spell", ID = 20066    }),
    BlindingLight                    = Action.Create({ Type = "Spell", ID = 115750    }),        
    UnbreakableSpirit                = Action.Create({ Type = "Spell", ID = 114154, Hidden = true    }),        
    Cavalier                        = Action.Create({ Type = "Spell", ID = 230332, Hidden = true    }),
    RuleofLaw                        = Action.Create({ Type = "Spell", ID = 214202    }),
    DivinePurpose                    = Action.Create({ Type = "Spell", ID = 223817, Hidden = true    }),    
    DivinePurposeBuff               = Action.Create({ Type = "Spell", ID = 223819, Hidden = true     }),
    HolyAvenger                        = Action.Create({ Type = "Spell", ID = 105809    }),
    Seraphim                        = Action.Create({ Type = "Spell", ID = 152262    }),
    SanctifiedWrath                    = Action.Create({ Type = "Spell", ID = 53376    }),    
    AvengingCrusader                = Action.Create({ Type = "Spell", ID = 216331    }),
    Awakening                        = Action.Create({ Type = "Spell", ID = 414195, Hidden = true    }),
    GlimmerofLight                    = Action.Create({ Type = "Spell", ID = 325966, Hidden = true    }),
    GlimmerofLightBuff                = Action.Create({ Type = "Spell", ID = 287280, Hidden = true    }),
    BeaconofFaith                    = Action.Create({ Type = "Spell", ID = 156910    }),
    BeaconofVirtue                    = Action.Create({ Type = "Spell", ID = 200025    }),        
    BreakingDawn                    = Action.Create({ Type = "Spell", ID = 387879, Hidden = true }),
    Rebuke                            = Action.Create({ Type = "Spell", ID = 96231 }),
    RebukeGreen                     = Create({ Type = "SpellSingleColor",ID = 96231,Hidden = true,Color = "GREEN",QueueForbidden = true}),
    BlessingOfDusk                = Action.Create({ Type = "Spell", ID = 385126, Hidden = true    }),
    BlessingOfDawn                = Action.Create({ Type = "Spell", ID = 385127, Hidden = true    }),
    SealOfOrder                        = Action.Create({ Type = "Spell", ID = 385129, Hidden = true    }),
    AwakeningBuff                    = Action.Create({ Type = "Spell", ID = 414193, Hidden = true    }),
    EternalFlame                    = Action.Create({ Type = "Spell", ID = 156322    }),
	EmpyrealWard				= Action.Create({ Type = "Spell", ID = 387791, Hidden = true    }),
	EmpyrealLOH					= Action.Create({ Type = "Spell", ID = 471195    }),
	RiteOfSanctification		= Action.Create({ Type = "Spell", ID = 433568    }),
	RiteOfSanctificationBuff 	= Action.Create({ Type = "Spell", ID = 433550, Hidden = true    }),
	HolyBulwark					= Action.Create({ Type = "Spell", ID = 432459    }),
	HolyBulwarkBuff 			= Action.Create({ Type = "Spell", ID = 432496, Hidden = true    }),
	SacredWeapon				= Action.Create({ Type = "Spell", ID = 432472    }),
	SacredWeaponBuff			= Action.Create({ Type = "Spell", ID = 432502, Hidden = true    }),
    
    -- PvP
    DivineFavor                               = Action.Create({ Type = "Spell", ID = 210294 }),
    HordeFlag                                = Action.Create({ Type = "Spell", ID = 156618 }),
    AllianceFlag                           = Action.Create({ Type = "Spell", ID = 156621 }),
    OrbofPowerPurple                               = Action.Create({ Type = "Spell", ID = 121175 }), 
    OrbofPowerGreen                               = Action.Create({ Type = "Spell", ID = 121176 }), 
    OrbofPowerBlue                               = Action.Create({ Type = "Spell", ID = 121164 }), 
    OrbofPowerOrange                        = Action.Create({ Type = "Spell", ID = 121177 }), 
    FocusedAssault                           = Action.Create({ Type = "Spell", ID = 46392 }),
    NetherstormFlag                           = Action.Create({ Type = "Spell", ID = 34976 }),
    CleanseTheWeak                            = Action.Create({ Type = "Spell", ID = 199330 }),
    RecentlySavedByTheLight                    = Action.Create({ Type = "Spell", ID = 157131 }),
    HallowedGround                            = Action.Create({ Type = "Spell", ID = 216868 }),
    Mindgames                                 = Action.Create({ Type = "Spell", ID = 323673 }),
    
    --    Later
    
    DivineToll                        = Action.Create({ Type = "Spell", ID = 375576    }),    
    BlessingoftheSeasons            = Action.Create({ Type = "Spell", ID = 328278    }),
    BlessingofSummer                = Action.Create({ Type = "Spell", ID = 388007, Texture = 328620     }),    
    BlessingofAutumn                = Action.Create({ Type = "Spell", ID = 388010, Texture = 328620     }),    
    BlessingofSpring                = Action.Create({ Type = "Spell", ID = 388013, Texture = 328620      }),    
    BlessingofWinter                = Action.Create({ Type = "Spell", ID = 388011, Texture = 328620      }),      
    
    -- Conduits
    
    
    
    --Anima Powers - to add later...
    
    
    -- Trinkets
    MoteSanctification = Create({ Type = "Trinket", ID = 133646}),  
    Chillglobe = Create({ Type = "Trinket", ID = 194300}),  
    
    
    -- Potions
    PotionofUnbridledFury            = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }),     
    SuperiorPotionofUnbridledFury    = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }),
    PotionofSpectralIntellect        = Action.Create({ Type = "Potion", ID = 171273, QueueForbidden = true }),
    PotionofSpectralStamina            = Action.Create({ Type = "Potion", ID = 171274, QueueForbidden = true }),
    PotionofEmpoweredExorcisms        = Action.Create({ Type = "Potion", ID = 171352, QueueForbidden = true }),
    PotionofHardenedShadows            = Action.Create({ Type = "Potion", ID = 171271, QueueForbidden = true }),
    PotionofPhantomFire                = Action.Create({ Type = "Potion", ID = 171349, QueueForbidden = true }),
    PotionofDeathlyFixation            = Action.Create({ Type = "Potion", ID = 171351, QueueForbidden = true }),
    SpiritualHealingPotion            = Action.Create({ Type = "Item", ID = 171267, QueueForbidden = true }),
    PotionofChilledClarity            = Action.Create({ Type = "Potion", ID = 191368, QueueForbidden = true }),
    
    
    -- Misc
    Channeling                      = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),    -- Show an icon during channeling
    TargetEnemy                     = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),    -- Change Target (Tab button)
    StopCast                        = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),        -- spell_magic_polymorphrabbit
    PoolResource                    = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
    Quake                           = Action.Create({ Type = "Spell", ID = 240447, Hidden = true     }), -- Quake (Mythic Plus Affix)
    Cyclone                         = Action.Create({ Type = "Spell", ID = 33786, Hidden = true     }), -- Cyclone     
    
}

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_PALADIN_HOLY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_PALADIN_HOLY], { __index = Action })


local player = "player"
local targettarget = "targettarget"
local target = "target"
local mouseover = "mouseover"
local focustarget = "focustarget"
local focus = "focus"

-- Call to avoid lua limit of 60upvalues 
-- Call RotationsVariables in each function that need these vars
local function RotationsVariables()
    combatTime = Unit(player):CombatTime()
    inCombat = Unit(player):CombatTime() > 0
    UseDBM = GetToggle(1 ,"DBM") -- Don't call it DBM else it broke all the global DBM var used by another addons
    Potion = GetToggle(1, "Potion")
    Racial = GetToggle(1, "Racial")
    HealMouseover = GetToggle(2, "HealMouseover")
    DPSMouseover = GetToggle(2, "DPSMouseover")
    -- ProfileUI vars
    BeaconWorkMode = GetToggle(2, "BeaconWorkMode")    
    TrinketMana = GetToggle(2, "TrinketMana")
    LightofDawnHP = GetToggle(2, "LightofDawnHP")
    LightofDawnUnits = GetToggle(2, "LightofDawnUnits")
    UseLightofDawn = GetToggle(2, "UseLightofDawn")
    ForceWoGHP = GetToggle(2, "ForceWoGHP")
    HolyLightHP = GetToggle(2, "HolyLightHP")
    WordofGloryHP = GetToggle(2, "WordofGloryHP")
    HolyShockHP = GetToggle(2, "HolyShockHP")
    BestowFaithHP = GetToggle(2, "BestowFaithHP")
    FlashofLightHP = GetToggle(2, "FlashofLightHP")
    HolyPrismHP = GetToggle(2, "HolyPrismHP")
    LightofMartyr = GetToggle(2, "LightofDawnHP")
    DFHolyLightHP = GetToggle(2, "DFHolyLightHP")
    
    
end


local Temp                               = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
    TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
}

--CTT logic for using the CantTouchThis Addon
local isNotCCAble = {}
if CTT then 
    local cttKnown = CTT.immuneKnown
    local cttFound = CTT.immuneFound
    for k,v in pairs(cttFound) do cttKnown[k] = v end
    isNotCCAble = cttKnown
end 

local GetTotemInfo, IsMouseButtonDown, UnitIsUnit = GetTotemInfo, IsMouseButtonDown, UnitIsUnit

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    IsUnitEnemy(unit) and Unit(unit):GetDR("stun") > 0 and
    Unit(unit):GetRange() <= 10 and Unit(unit):HasBuffs(A.Sanguine.ID) == 0 and Unit(unit):HasDeBuffs({"Silenced", "Stuned", "Sleep", "Fear", "Disoriented", "Incapacitated"}) == 0 and
    A.HammerofJusticeGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    local useKick, useCC, useRacial = A.InterruptIsValid(targettarget, "TargetMouseover")    
    
    
    
    -- Manual Key
    if     A.HammerofJusticeGreen:IsReady(nil, nil, nil, true) and not isNotCCAble[npc_id] and
    (
        AntiFakeStun(mouseover) or 
        AntiFakeStun(target) or 
        (
            not IsUnitEnemy(mouseover) and 
            not IsUnitEnemy(target) and                     
            (
                (A.IsInPvP and EnemyTeam():PlayersInRange(1, 10)) or 
                (not A.IsInPvP and MultiUnits:GetByRange(10) >= 1)
            )
        )
    )
    then 
        return A.HammerofJusticeGreen:Show(icon)         
    end
    
    
end

A[2] = function(icon)
    local unitID = "none"
    if IsUnitEnemy(mouseover) then
        unitID = mouseover
    elseif IsUnitEnemy(target) then
        unitID = target
    end
    if unitID then
        local castLeft, _, _, _, notKickAble = Unit(unitID):IsCastingRemains()
        if castLeft > A.GetPing() then
            if not notKickAble and A.Rebuke:IsReadyP(unitID, nil, true, true) and A.Rebuke:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then
                return A.RebukeGreen:Show(icon)
            end
        end
    end
end

TMW:RegisterCallback("TMW_ACTION_HEALINGENGINE_UNIT_UPDATE", function(callbackEvent, thisUnit, db, QueueOrder) 
        
        local _,_,_,_,_,NPCID = Unit("target"):InfoGUID()
        
        if A.InstanceInfo.KeyStone >= 7 and thisUnit.Unit and (Unit(thisUnit.Unit):HasDeBuffsStacks(209858) >= GetToggle(2, "Necrotic") or Unit(thisUnit.Unit):HasDeBuffsStacks(388801) >= 2) and (not AuraIsValid(thisUnit.Unit, "UseDispel", "Dispel") or AuraIsValid(thisUnit.Unit, "UseDispel", "Dispel") and not A.Cleanse:IsReady()) and (not AuraIsValid(thisUnit.Unit, true, "BlessingofFreedom") or AuraIsValid(thisUnit.Unit, true, "BlessingofFreedom") and not A.BlessingofFreedom:IsReady()) then
            thisUnit.isSelectAble = false
        end
        
        if thisUnit.Unit and (Unit(thisUnit.Unit):HasBuffs(344916) > 0 or Unit(thisUnit.Unit):HasBuffs(108978) > 0) and (not AuraIsValid(thisUnit.Unit, "UseDispel", "Dispel") or AuraIsValid(thisUnit.Unit, "UseDispel", "Dispel") and not A.Cleanse:IsReady()) and (not AuraIsValid(thisUnit.Unit, true, "BlessingofFreedom") or AuraIsValid(thisUnit.Unit, true, "BlessingofFreedom") and not A.BlessingofFreedom:IsReady()) then
            thisUnit.isSelectAble = false
        end
        
end)

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end  
    
    -- DivineShield
    if A.DivineShield:IsReady(player) and GetToggle(2, "UseDivineShield") and combatTime > 0 and Unit(player):HasDeBuffs(A.Forbearance.ID, true) == 0 and Unit(player):HealthPercent() < 30 and Unit(player):TimeToDie() < 3
    then 
        return A.DivineShield
    end
    
    -- BlessingofProtection
    if A.BlessingofProtection:IsReady(player) and combatTime > 0 and not A.DivineShield:IsReady(player) and Unit(player):HealthPercent() < 30 and (Unit(player):HasBuffs("TotalImun") == 0 or Unit(player):HasBuffs("DamagePhysImun") == 0 and Unit(player):TimeToDie() - Unit(player):TimeToDieMagic() < -1)
    and Unit(player):HasDeBuffs(A.Forbearance.ID, true) == 0 and UnitIsUnit("focus", player)
    then 
        return A.BlessingofProtection
    end
    
    -- DivineProtection
    if A.DivineProtection:IsReady(player) and Unit(player):HealthPercent() < 80 and Unit(player):TimeToDie() < 5 then
        return A.DivineProtection
    end
    
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
    
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-----------------------------------------
--        ROTATION FUNCTIONS           --
-----------------------------------------

local ipairs, pairs = ipairs, pairs
local FriendlyGUIDs = TeamCache.Friendly.GUIDs

-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
	
    local CurrentTanks = HealingEngine.GetMembersByMode("TANK")
    local getmembersAll = HealingEngine.GetMembersAll()
    local inCombat = Unit(player):CombatTime() > 0
    local isMoving = Player:IsMoving()
    local isMovingFor = A.Player:IsMovingTime()
    local combatTime = Unit(player):CombatTime()    
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods:GetPullTimer()
    local AoEON = GetToggle(2, "AoE") 
    
    -- Healing Engine vars
    local AVG_DMG = HealingEngine.GetIncomingDMGAVG()
    local AVG_HPS = HealingEngine.GetIncomingHPSAVG()
    local TeamCacheEnemySize = TeamCache.Enemy.Size
    local DungeonGroup = TeamCache.Friendly.Size >= 2 and TeamCache.Friendly.Size <= 5
    local RaidGroup = TeamCache.Friendly.Size >= 5
    local TeamCacheFriendlySize = TeamCache.Friendly.Size
    local TeamCacheFriendlyType = TeamCache.Friendly.Type or "none"  
    local PVEDebuffs = {
    352224, 441397, 442589, 323137, 431494, 435148, 324859, 428650, 439325, 426735, 429545, 287295, 272571, 424420, 323347, 464876, 437956, 442250, 428019, 320788, 425974, 427897, 451606, 441382, 440238, 350000, 428161, 275014, 440313    
    }
    
    
    RotationsVariables()    
    
    
    ---------------------
    --- HEAL ROTATION ---
    ---------------------
    local function HealingRotation(unitID) 
        
        local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(unitID)
        local unitGUID = UnitGUID(unitID)    
		
        
        local function BlessingofSeasons(unitID)
            local getmembersAll = HealingEngine.GetMembersAll()
            for i = 1, #getmembersAll do 
                if Unit(getmembersAll[i].Unit):GetRange() <= 40 then
                    --BlessingofAutumn
                    if A.BlessingofAutumn:IsReady(getmembersAll[i].Unit) then 
                        if Unit(getmembersAll[i].Unit):IsDamager() and (Unit(getmembersAll[i].Unit):Class() == "MAGE" and Unit(getmembersAll[i].Unit):HasBuffs(190319)) then
                            HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)    -- Add 1sec delay in case of emergency switch     
                            return A.BlessingofAutumn                --Keep same icon for all four spells.  
                        else HealingEngine.SetTarget(player, 0.5)
                            return A.BlessingofAutumn              --If no mage has Combustion, just dump Autumn on self    
                        end  
                        --Blessing of Winter                  
                    elseif A.BlessingofWinter:IsReady(player)  then 
                        HealingEngine.SetTarget(player, 0.5)    -- Add 1sec delay in case of emergency switch     
                        return A.BlessingofWinter                --Keep same icon for all four spells.  
                    elseif A.BlessingofSummer:IsReady(player) and not (A.BlessingofAutumn:IsReady(getmembersAll[i].Unit) or A.BlessingofWinter:IsReady(getmembersAll[i].Unit) or A.BlessingofSpring:IsReady(getmembersAll[i].Unit)) then
                        if Unit(player):HasBuffs(A.AvengingWrath.ID) >= 10 then --no pet/clone specs 
                            HealingEngine.SetTarget(player, 0.5)    -- Add 0.5 sec delay in case of emergency switch     
                            return A.BlessingofSummer                --Keep same icon for all four spells.       
                        end
                    end
                end                  
                
            end    
            
            if A.BlessingofSpring:IsReady(player) then
                HealingEngine.SetTarget(player, 0.5)    -- Add 1sec delay in case of emergency switch     
                return A.BlessingofSpring  
            end
            
        end
        
        --Auras
        if (A.Zone == "pvp" or A.Zone == "arena" or A.InstanceInfo.isRated) and A.ConcentrationAura:IsReady() and Unit(player):HasBuffs(A.ConcentrationAura.ID) == 0 and Unit(player):HasBuffs(A.CrusaderAura.ID) == 0 and Unit(player):HasBuffs(A.RetributionAura.ID) == 0 
        and Unit(player):HasBuffs(A.DevotionAura.ID) == 0 then
            return A.ConcentrationAura:Show(icon)
        end
        
        if (A.Zone ~= "pvp" or A.Zone ~= "arena" or not A.InstanceInfo.isRated) and A.DevotionAura:IsReady() and Unit(player):HasBuffs(A.DevotionAura.ID) == 0 and Unit(player):HasBuffs(A.CrusaderAura.ID) == 0 and Unit(player):HasBuffs(A.RetributionAura.ID) == 0 
        and Unit(player):HasBuffs(A.ConcentrationAura.ID) == 0 then
            return A.DevotionAura:Show(icon)
        end
        
        --Lay on hands
        if Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and ((TeamCacheFriendlyType ~= "raid" and combatTime > 0) or (TeamCacheFriendlyType == "raid" and combatTime > 30)) and Action.Zone ~= "arena" and not Action.InstanceInfo.isRated   -- Forbearance
        then
            for i = 1, #getmembersAll do 
                if Unit(getmembersAll[i].Unit):GetRange() <= 40 then 
                    if not Unit(getmembersAll[i].Unit):IsPet() and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 and not Unit(getmembersAll[i].Unit):IsDead() and ((not A.EmpyrealWard:IsTalentLearned() and A.LayOnHands:IsReadyByPassCastGCD(getmembersAll[i].Unit)) or (A.EmpyrealWard:IsTalentLearned() and A.EmpyrealLOH:IsReadyByPassCastGCD(getmembersAll[i].Unit))) and ((Unit(getmembersAll[i].Unit):HealthDeficit() >= Unit(player):HealthMax() and Unit(getmembersAll[i].Unit):TimeToDie() <= 3) or (Unit(getmembersAll[i].Unit):HealthPercent() <= 30 
                            and Unit(getmembersAll[i].Unit):TimeToDie() <= 3)) and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Forbearance.ID) == 0 then
                        HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)    -- Add 1sec delay in case of emergency switch     
                        return A.LayOnHands:Show(icon)                        
                    end                    
                end                
            end    
        end 
        
        if GetToggle(1, "StopCast") then
            
            if Unit(player):HasDeBuffs(A.Quake.ID) > 0 and (Unit(player):IsCastingRemains(A.HolyLight.ID) > Unit(player):HasDeBuffs(A.Quake.ID) or Unit(player):IsCastingRemains(A.FlashofLight.ID) > Unit(player):HasDeBuffs(A.Quake.ID)) then
                return A:Show(icon, ACTION_CONST_STOPCAST)
            end
            
            if inCombat and Unit(player):HasBuffs(A.DivineFavor.ID, true) == 0 and (((Unit(player):IsCastingRemains(A.HolyLight.ID) > Player:Execute_Time(A.HolyLight.ID)/2 or Unit(player):IsCastingRemains(A.FlashofLight.ID) > Player:Execute_Time(A.FlashofLight.ID)/2) and A.HolyShock:IsReady(unitID) and Unit(unitID):HealthPercent() < HolyShockHP)
                or ((Unit(player):IsCastingRemains(A.HolyLight.ID) > 0.5 or Unit(player):IsCastingRemains(A.FlashofLight.ID) > 0.5) and A.WordofGlory:IsReady(unitID) and Unit(unitID):HealthPercent() < WordofGloryHP) or (Unit(player):IsCastingRemains(A.HolyLight.ID) > 0 and Unit(unitID):HealthPercent() >= HolyLightHP) 
                or (Unit(player):IsCastingRemains(A.FlashofLight.ID) > 0 and Unit(unitID):HealthPercent() >= FlashofLightHP)) then
                return A:Show(icon, ACTION_CONST_STOPCAST)
            end
            
        end
        
        --Blessing of Sacrifice
        if A.BlessingofSacrifice:IsReadyByPassCastGCD(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 and combatTime > 0 and not UnitIsUnit(unitID, player) and not Unit(unitID):IsPet() and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() <= 40 
        and Unit(unitID):TimeToDie() <= 4 and (Unit(unitID):HasBuffs("TotalImun") == 0 or (Unit(unitID):HasBuffs("DamagePhysImun") > 0 and Unit(unitID):TimeToDieMagic() <= 4) or (Unit(unitID):HasBuffs("DamageMagicImun") > 0 and Unit(unitID):TimeToDie() - Unit(unitID):TimeToDieMagic() < -1)) then
            return A.BlessingofSacrifice:Show(icon)
        end    
        
        --Blessing of Protection (Keystone Combustion Aggro)
        for i = 1, #getmembersAll do 
            if combatTime > 0 and useShields and Unit(getmembersAll[i].Unit):GetRange() <= 40 and A.InstanceInfo.KeyStone >= 15 then 
                if not Unit(getmembersAll[i].Unit):IsPet() and not Unit(getmembersAll[i].Unit):IsDead() and A.BlessingofProtection:IsReady(getmembersAll[i].Unit) 
                and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Forbearance.ID) == 0 and Unit(getmembersAll[i].Unit):HasBuffs(A.Combustion.ID) > 0
                and Unit(getmembersAll[i].Unit):IsTanking() and not Unit(getmembersAll[i].Unit):Role("TANK") and not UnitIsUnit(getmembersAll[i].Unit, player) and (Unit(getmembersAll[i].Unit):HasBuffs("TotalImun") == 0 or Unit(getmembersAll[i].Unit):HasBuffs("DamagePhysImun") == 0) then
                    HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)       
                    return A.BlessingofProtection:Show(icon)                        
                end                    
            end                
        end    
        
        local _,_,_,_,_,NPCID1 = Unit(unitID):InfoGUID()
        
        --Blessing of Protection
        
        if A.BlessingofProtection:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 and useShields and combatTime > 0 and not Unit(unitID):IsPet() and not Unit(unitID):IsTank() and not UnitIsUnit(unitID, player) and not Unit(unitID):IsDead() 
        and Unit(unitID):HealthPercent() <= 30 and Unit(unitID):TimeToDie() <= 3 and Unit(unitID):HasDeBuffs(A.OrbofPowerBlue.ID) == 0 and Unit(unitID):HasDeBuffs(A.OrbofPowerGreen.ID) == 0 
        and Unit(unitID):HasDeBuffs(A.OrbofPowerPurple.ID) == 0 and Unit(unitID):HasDeBuffs(A.OrbofPowerOrange.ID) == 0 and Unit(unitID):HasDeBuffs(A.Forbearance.ID, true) == 0
        and not Unit(unitID):HasFlags() and (Unit(unitID):HasBuffs("TotalImun") == 0 or Unit(unitID):HasBuffs("DamagePhysImun") == 0 and Unit(unitID):TimeToDie() - Unit(unitID):TimeToDieMagic() < -1) then
            return A.BlessingofProtection:Show(icon)
        end    
        
        if A.WillToSurvive:IsReady() and Unit(player):HasDeBuffs("Stuned") > 2 then
            return A.WillToSurvive:Show(icon)
        end
        
        --Holy Light Divine Favor w/ Infusion
        if A.HolyLight:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) < 0.8 and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 and Unit(player):HasBuffs(A.DivineFavor.ID, true) > 0 and Unit(player):HasBuffs(A.InfusionofLightBuff.ID, true) > 1 and (Unit(unitID):HealthPercent() <= DFHolyLightHP or Unit(unitID):GetTotalHealAbsorbsPercent() > 100 - DFHolyLightHP) and not Unit(unitID):IsDead() and Unit(player):GetCurrentSpeed() == 0 then
            return A.HolyLight:Show(icon)
        end    
        
        -- Beacon of Light - Self
        if not A.BeaconofVirtue:IsTalentLearned() and A.BeaconofLight:IsReady() and BeaconWorkMode == "Self" then
            if UnitIsUnit(unitID, player) and Unit(player):HasBuffs(A.BeaconofLight.ID, true) == 0  then    
                return A.BeaconofLight:Show(icon)                        
            end                    
        end
        
        -- Beacon of Light - Tank
        if not A.BeaconofVirtue:IsTalentLearned() and A.BeaconofLight:IsReady(unitID) and BeaconWorkMode == "Tanking Units" then
            if Unit(unitID):Role("TANK") and Unit(unitID):HasBuffs(A.BeaconofLight.ID, true) == 0 and HealingEngine.GetBuffsCount(A.BeaconofLight.ID, 0, true) == 0 then
                return A.BeaconofLight:Show(icon)
            end
        end
        
        -- Beacon of Faith PVE - 2x Tank
        if not A.BeaconofVirtue:IsTalentLearned() and BeaconWorkMode == "Beacon of Faith 2" then
            if A.BeaconofLight:IsReady(unitID) and Unit(unitID):Role("TANK") and Unit(unitID):HasBuffs(A.BeaconofLight.ID, true) == 0 and Unit(unitID):HasBuffs(A.BeaconofFaith.ID, true) == 0 and HealingEngine.GetBuffsCount(A.BeaconofLight.ID, 0, true) == 0 then
                return A.BeaconofLight:Show(icon)
            end
            if A.BeaconofFaith:IsReady(unitID) and Unit(unitID):Role("TANK") and Unit(unitID):HasBuffs(A.BeaconofLight.ID, true) == 0 and Unit(unitID):HasBuffs(A.BeaconofFaith.ID, true) == 0 and HealingEngine.GetBuffsCount(A.BeaconofFaith.ID, 0, true) == 0 then
                return A.BeaconofFaith:Show(icon)
            end
        end
        
        -- Beacon of Faith PVE
        if not A.BeaconofVirtue:IsTalentLearned() and A.BeaconofFaith:IsTalentLearned() and BeaconWorkMode == "Beacon of Faith" then
            if UnitIsUnit(unitID, player) and A.BeaconofFaith:IsReady(unitID) and Unit(player):HasBuffs(A.BeaconofFaith.ID, true) == 0 then
                return A.BeaconofFaith:Show(icon)
            end
            if Unit(unitID):Role("TANK") and Unit(unitID):HasBuffs(A.BeaconofLight.ID, true) == 0 and HealingEngine.GetBuffsCount(A.BeaconofLight.ID, 0, true) == 0 then
                return A.BeaconofLight:Show(icon)
            end
        end
        
        -- Beacon of Light - Beacon of Faith + Saved By the Light
        if A.SavedbytheLight:IsTalentLearned() and A.BeaconofFaith:IsTalentLearned() and BeaconWorkMode == "Beacon of Faith + Saved By the Light" then
            if UnitIsUnit(unitID, player) and not Unit(unitID):IsDead() and Unit(player):HasBuffs(A.BeaconofLight.ID, true) == 0 and Unit(player):HasDeBuffs(A.RecentlySavedByTheLight.ID, true) == 0 
            or not UnitIsUnit(unitID, player) and HealingEngine.GetBuffsCount(A.BeaconofFaith.ID) > 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 and not Unit(unitID):IsDead() and IsUnitFriendly(unitID) and Unit(unitID):IsPlayer() and Unit(player):HasDeBuffs(A.RecentlySavedByTheLight.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.RecentlySavedByTheLight.ID, true) == 0 and Unit(unitID):HasBuffs(A.BeaconofLight.ID, true) == 0 and Unit(unitID):HasBuffs(A.BeaconofFaith.ID, true) == 0 and Unit(unitID):HealthPercent() <= 45 and combatTime > 0 then
                return A.BeaconofLight:Show(icon)                        
            end           
            if IsUnitFriendly(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 and not UnitIsUnit(unitID, player) and not Unit(unitID):IsDead() and Unit(unitID):IsPlayer() and Unit(unitID):HasBuffs(A.RecentlySavedByTheLight.ID, true) == 0 and (Unit(player):HasBuffs(A.BeaconofLight.ID, true) == 0 or Unit(player):HasDeBuffs(A.RecentlySavedByTheLight.ID, true) == 0) and Unit(unitID):HasBuffs(A.BeaconofLight.ID, true) == 0 and Unit(unitID):HasBuffs(A.BeaconofFaith.ID, true) == 0 and Unit(unitID):HealthPercent() <= 45 and combatTime > 0 then
                return A.BeaconofFaith:Show(icon)
            end
        end
        
        --Beacon of Virtue
        if A.BeaconofVirtue:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and A.BeaconofVirtue:IsTalentLearned() and TeamCacheFriendlyType ~= "none" and
        (
            (       
                not IsUnitEnemy(unitID) and
                A.BeaconofVirtue:IsInRange(unitID) and
                Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0
            )
        ) and
        (
            (
                DungeonGroup and
                HealingEngine.GetBelowHealthPercentUnits(GetToggle(2, "BoVHPParty"), 40) >= GetToggle(2, "BoVUnitsParty") 
            ) or
            (
                RaidGroup and
                HealingEngine.GetBelowHealthPercentUnits(GetToggle(2, "BoVHPRaid"), 40) >= GetToggle(2, "BoVUnitsRaid")
            )
        )
        then
            return A.BeaconofVirtue:Show(icon)
        end
        
		-- Rite of Sanctification
		
		if not inCombat and A.RiteOfSanctification:IsTalentLearned() and Unit(player):HasBuffs(A.RiteOfSanctificationBuff.ID) == 0 then
			return A.RiteOfSanctification:Show(icon)
		end	
		
        if inCombat and A.HolyBulwark:IsTalentLearned() and A.HolyBulwark:IsReady(unitID) and Unit(player):HasBuffs(A.HolyBulwarkBuff.ID) == 0 and Unit(unitID):HealthPercent() <= 60 then
			return A.HolyBulwark:Show(icon)
		end
		
		if inCombat and A.HolyBulwark:IsTalentLearned() and A.SacredWeapon:IsReady(unitID) and ((HealingEngine.GetBelowHealthPercentUnits(80, 40) >= 5 and Unit(unitID):Role("HEALER") and not Unit(unitID):HasSpec(256)) or (HealingEngine.GetBelowHealthPercentUnits(80, 40) < 5 and Unit(unitID):Role("DAMAGER"))) and Unit(player):HasBuffs(A.SacredWeaponBuff.ID) == 0 then
			return A.SacredWeapon:Show(icon)
		end
		
        --Mouseover Bress
        if A.Intercession:IsReady(mouseover) and combatTime > 0 and Unit(mouseover):IsDead() and Unit(mouseover):IsPlayer() then
            return A.Intercession:Show(icon)
        end
        
        -- Toll + Wrath Amplifier
        if combatTime > 0 and A.DivineToll:IsReady(unitID) and HealingEngine.GetBelowHealthPercentUnits(70, 40) >= 5 and Unit(player):HasBuffs(A.AvengingWrath.ID) == 0 and A.AvengingWrath:IsReady() and TeamCacheFriendlyType == "raid" then
            return A.AvengingWrath:Show(icon)
        end
        
        -- #17 HPvE DivineToll
        if A.DivineToll:IsReady(unitID) and combatTime > 0 and Unit(unitID):IsPlayer() and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 and not Unit(unitID):IsDead() 
        and not IsUnitEnemy(unitID) and Unit(unitID):GetRange() <= 40 and Unit(unitID):HealthPercent() < HolyShockHP and
        ((Player:HolyPower() <= 1 and
                (    (Action.Zone == "arena" and (TeamCache.Friendly.Size >= 2 and HealingEngine.GetBelowHealthPercentUnits(80, 40) >= 2))
                    or
                    (TeamCacheFriendlyType == "none" and MultiUnits:GetByRange(10) > 2 and Unit(player):HealthPercent() <= 80) 
                    or
                    (TeamCacheFriendlyType == "party" and HealingEngine.GetBelowHealthPercentUnits(GetToggle(2, "DivineTollHPParty"), 40) >= GetToggle(2, "DivineTollUnitsParty")) 
                    or
                    (TeamCacheFriendlyType == "raid" and HealingEngine.GetBelowHealthPercentUnits(GetToggle(2, "DivineTollHPRaid"), 40) >= GetToggle(2, "DivineTollUnitsRaid"))
                )
            ) 
            or
            TeamCacheFriendly ~= "raid" and HealingEngine.GetBelowHealthPercentUnits(50, 40) >= 4 and Player:HolyPower() <= 3 or (TeamCacheFriendlyType == "raid" and HealingEngine.GetBelowHealthPercentUnits(80, 40) >= 5))
        then
            return A.DivineToll:Show(icon)
        end
        
        
        if not Action.InstanceInfo.isRated or Action.InstanceInfo.isRated and (Unit(unitID):HealthPercent() >= 30 or Unit(unitID):HealthPercent() < 30 and not A.HolyShock:IsReady() and not A.WordofGlory:IsReady()) then
            
            if (A.Zone == "arena" or A.InstanceInfo.isRated) and A.BlessingofFreedom:IsReady() and A.GetToggle(2, "DispelSniper") then
                for i = 1, #getmembersAll do 
                    if Unit(getmembersAll[i].Unit):GetRange() <= 40 and not Unit(getmembersAll[i].Unit):IsDead() and Unit(getmembersAll[i].Unit):HasBuffs(A.BlessingofFreedom.ID) == 0 
                    and AuraIsValid(getmembersAll[i].Unit, true, "BlessingofFreedom") and Unit(getmembersAll[i].Unit):HasSpec(PVPMELEE) and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 then  
                        HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)                                      
                    end                
                end
            end
            
			if A.Cleanse:IsReady() and A.GetToggle(2, "DispelSniper") then
				-- Check if 275014 is present on ANY party member
				local debuff275014Present = false
				for i = 1, 4 do -- Assuming a standard 5-man party
					if UnitExists("party"..i) and Unit("party"..i):HasDeBuffs(275014) > 2 then
						debuff275014Present = true
						break
					end
				end

				for i = 1, #getmembersAll do  
					if Unit(getmembersAll[i].Unit):GetRange() <= 40 and 
					   not Unit(getmembersAll[i].Unit):IsDead() and 
					   AuraIsValid(getmembersAll[i].Unit, "UseDispel", "Dispel") and 
					   Unit(getmembersAll[i].Unit):HasDeBuffs(342938) == 0 and 
					   Unit(getmembersAll[i].Unit):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 
					   then

						if debuff275014Present then
							-- If 275014 is present, only target players with that debuff
							if Unit(getmembersAll[i].Unit):HasDeBuffs(275014) > 2 then
								HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)
							end
						else
							-- Otherwise, target normally
							HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)
						end

					end    
				end
			end
		
            if A.BlessingofFreedom:IsReady() and A.GetToggle(2, "DispelSniper") then
                for i = 1, #getmembersAll do 
                    if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):GetCurrentSpeed() <= 70 and not Unit(getmembersAll[i].Unit):IsDead() and Unit(getmembersAll[i].Unit):HasBuffs(A.BlessingofFreedom.ID) == 0 
                    and AuraIsValid(getmembersAll[i].Unit, true, "BlessingofFreedom") and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 then  
                        HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)                                      
                    end                
                end
            end
            
            if A.BlessingofProtection:IsReady() and A.GetToggle(2, "DispelSniper") then
                for i = 1, #getmembersAll do 
                    if Unit(getmembersAll[i].Unit):GetRange() <= 40 and not Unit(getmembersAll[i].Unit):IsDead() and Unit(getmembersAll[i].Unit):HasBuffs(A.BlessingofProtection.ID) == 0 and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Forbearance.ID) == 0
                    and AuraIsValid(getmembersAll[i].Unit, true, "BlessingofProtection") and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 then  
                        HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)                                      
                    end                
                end
            end 
            
            -- #1 HPvE Dispel
            if A.Cleanse:IsReady(unitID) and (((A.Zone ~= "arena" or not A.InstanceInfo.isRated)) or ((A.Zone == "arena" or A.InstanceInfo.isRated))) and
            useDispel and Unit(unitID):HasDeBuffs(342938) == 0 and
            (
                -- MouseOver
                (
                    Unit("mouseover"):IsExists() and 
                    MouseHasFrame() and                      
                    not IsUnitEnemy("mouseover") and        
                    AuraIsValid(mouseover, "UseDispel", "Dispel")
                ) or 
                (
                    (
                        not A.GetToggle(2, "mouseover") or 
                        not Unit("mouseover"):IsExists() or 
                        IsUnitEnemy("mouseover")
                    ) and        
                    not IsUnitEnemy(unitID) and A.GetToggle(2, "DispelSniper") and
                    AuraIsValid(unitID, "UseDispel", "Dispel")
                )
            )
            then
                return A.Cleanse:Show(icon)
            end        
            
            -- #2 HPvE BoF
            if A.BlessingofFreedom:IsReady(unitID) and (((A.Zone == "arena" or A.InstanceInfo.isRated)) or ((A.Zone ~= "arena" or not A.InstanceInfo.isRated) and Unit(unitID):GetCurrentSpeed() <= 70)) and Unit(unitID):HasBuffs(A.BlessingofFreedom.ID) == 0 and
            useUtils and
            (
                -- MouseOver
                (
                    Unit("mouseover"):IsExists() and 
                    MouseHasFrame() and                      
                    not IsUnitEnemy("mouseover") and        
                    AuraIsValid(mouseover, true, "BlessingofFreedom")
                ) or 
                (
                    (
                        not A.GetToggle(2, "mouseover") or 
                        not Unit("mouseover"):IsExists() or 
                        IsUnitEnemy("mouseover")
                    ) and        
                    not IsUnitEnemy(unitID) and A.GetToggle(2, "DispelSniper") and
                    AuraIsValid(unitID, true, "BlessingofFreedom")
                )
            )
            then
                return A.BlessingofFreedom:Show(icon)
            end        
            
            -- #3 HPvE BoP
            if A.BlessingofProtection:IsReady(unitID) and Unit(unitID):HasBuffs(A.BlessingofProtection.ID) == 0 and Unit(unitID):HasDeBuffs(A.Forbearance.ID) == 0 and not Unit(unitID):IsPet() and not Unit(unitID):IsTank() and
            useShields and not Unit(unitID):IsDead() and
            (
                -- MouseOver
                (
                    Unit("mouseover"):IsExists() and 
                    MouseHasFrame() and                      
                    not IsUnitEnemy("mouseover") and        
                    AuraIsValid(mouseover, true, "BlessingofProtection")
                ) or 
                (
                    (
                        not A.GetToggle(2, "mouseover") or 
                        not Unit("mouseover"):IsExists() or 
                        IsUnitEnemy("mouseover")
                    ) and        
                    not IsUnitEnemy(unitID) and A.GetToggle(2, "DispelSniper") and
                    AuraIsValid(unitID, true, "BlessingofProtection")
                )
            )
            then
                return A.BlessingofProtection:Show(icon)
            end     
            
        end
		
				-- Self Dispel
		if A.Cleanse:IsReady(unitID) and UnitIsUnit("focus", player) then

			-- Check if 275014 is present on ANY party member
			local debuffPresentOnParty = false
			for i = 1, 4 do -- Assuming a standard 5-man party
				if UnitExists("party"..i) and Unit("party"..i):HasDeBuffs(275014) > 0 then
					debuffPresentOnParty = true
					break
				end
			end

			-- Check if 275014 is present on the focus target
			if debuffPresentOnParty and Unit(player):HasDeBuffs(275014) > 2 then 
				return A.Cleanse:Show(icon) 
			end

			-- If 275014 is not present on any party member, proceed with the normal dispel logic
			if not debuffPresentOnParty then
				-- Iterate through the PVEDebuffs table
				for i, debuffID in ipairs(PVEDebuffs) do
					if Unit(player):HasDeBuffs(debuffID) > 2 then
						return A.Cleanse:Show(icon) 
					end
				end
			end
		end
		
        --Light of Dawn at 5 HP
        if Player:HolyPower() == 5 and A.LightofDawn:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and not Unit(unitID):IsDead() and UseLightofDawn and HealingEngine.GetBelowHealthPercentUnits(LightofDawnHP, 40) >= LightofDawnUnits and HealingEngine.GetBelowHealthPercentUnits(ForceWoGHP, 40) == 0 then
            return A.LightofDawn:Show(icon)
        end
        
        --Word of Glory at 5 HP
        if not A.EternalFlame:IsTalentLearned() and Player:HolyPower() == 5 and A.WordofGlory:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 and not Unit(unitID):IsDead() and (Unit(unitID):HealthPercent() < WordofGloryHP or Unit(unitID):GetTotalHealAbsorbsPercent() > 100 - WordofGloryHP) and Player:HolyPower() >= 5 then
            return A.WordofGlory:Show(icon)
        end
        
        if A.EternalFlame:IsTalentLearned() and Player:HolyPower() == 5 and A.WordofGlory:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 and not Unit(unitID):IsDead() and (Unit(unitID):HealthPercent() < WordofGloryHP or Unit(unitID):GetTotalHealAbsorbsPercent() > 100 - WordofGloryHP) and Player:HolyPower() >= 5 then
            return A.EternalFlame:Show(icon)
        end
        
        if A.HolyPrism:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 and not Unit(unitID):IsDead() and (Unit(unitID):HealthPercent() < HolyPrismHP or Unit(unitID):GetTotalHealAbsorbsPercent() > 100 - HolyPrismHP) then
            return A.HolyPrism:Show(icon)
        end       
        
        --Holy Shock target
        if A.HolyShock:IsReady(unitID) and IsUnitFriendly(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 and not Unit(unitID):IsDead() and (Unit(unitID):HealthPercent() < HolyShockHP or Unit(unitID):GetTotalHealAbsorbsPercent() > 100 - HolyShockHP) then
            return A.HolyShock:Show(icon)
        end
        
        --Light of Dawn >= 3 HP
        if A.LightofDawn:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and not Unit(unitID):IsDead() and UseLightofDawn and HealingEngine.GetBelowHealthPercentUnits(LightofDawnHP, 40) >= LightofDawnUnits and HealingEngine.GetBelowHealthPercentUnits(ForceWoGHP, 40) == 0 then
            return A.LightofDawn:Show(icon)
        end
        
        --Word of Glory >= 3 HP
        if not A.EternalFlame:IsTalentLearned() and A.WordofGlory:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 and not Unit(unitID):IsDead() and (Unit(unitID):HealthPercent() < WordofGloryHP or Unit(unitID):GetTotalHealAbsorbsPercent() > 100 - WordofGloryHP) then
            return A.WordofGlory:Show(icon)
        end
        
        --Word of Glory >= 3 HP
        if A.EternalFlame:IsTalentLearned() and A.WordofGlory:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 and not Unit(unitID):IsDead() and (Unit(unitID):HealthPercent() < WordofGloryHP or Unit(unitID):GetTotalHealAbsorbsPercent() > 100 - WordofGloryHP) then
            return A.EternalFlame:Show(icon)
        end
        
        if inCombat then
            local SeasonBlessings = BlessingofSeasons()
            if SeasonBlessings then
                return SeasonBlessings:Show(icon)
            end
        end
        
        if Unit(target):HasDeBuffs("BreakAble") == 0 and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 then
            
            if Player:ManaPercentage() > GetToggle(2, "ManaConservation") and A.CrusaderStrike:IsReady(target) and A.CrusaderStrike:IsInRange(target) and IsUnitEnemy(target) and Unit(target):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 
            and not Unit(target):IsDead() and ((A.CrusadersMight:IsTalentLearned() and ((Player:HolyPower() < 5 and A.HolyShock:GetCooldown() >= 1.5 and A.HolyShock:GetSpellChargesFrac() <= 1.6) or (Player:ManaPercentage() > 80 and Player:HolyPower() < 5 and HealingEngine.GetBelowHealthPercentUnits (90, 40) == 0))) or (not A.CrusadersMight:IsTalentLearned() and Player:HolyPower() < 5 and Player:ManaPercentage() > GetToggle(2, "ManaConservation"))) then
                return A.CrusaderStrike:Show(icon)        
            end
            
            if A.Judgment:IsReady(target) and (Unit(target):CombatTime() > 0 or A.Zone == "arena" or A.InstanceInfo.isRated or A.Zone == "pvp") and IsUnitEnemy(target) and Unit(target):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 
            and (not A.JudgmentofLight:IsTalentLearned() or (A.JudgmentofLight:IsTalentLearned() and Unit(target):HasDeBuffs(196941, true) == 0))
            and not Unit(target):IsDead() then
                return A.Judgment:Show(icon)
            end
            
        end
        
        if A.ArcaneTorrent:IsReady(player) and not Unit(player):IsDead() and Player:HolyPower() == 2 and combatTime > 0 then
            return A.ArcaneTorrent:Show(icon)
        end
        
        if TeamCacheFriendlyType ~= "raid" and A.HolyShock:IsReady(unitID) and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() <= 90 and (HealingEngine.GetBelowHealthPercentUnits(90, 40) == 1 and Player:ManaPercentage() >= 50 and Player:HolyPower() < 5) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 then
            return A.HolyShock:Show(icon)
        end
        
        if not A.EternalFlame:IsTalentLearned() and A.WordofGlory:IsReady(unitID) and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() <= 90 and combatTime == 0 then
            return A.WordofGlory:Show(icon)
        end
        
        if A.EternalFlame:IsTalentLearned() and A.WordofGlory:IsReady(unitID) and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() <= 90 and combatTime == 0 then
            return A.EternalFlame:Show(icon)
        end
        
        if A.Zone == "arena" or A.InstanceInfo.isRated or A.Zone == "pvp" or inCombat then
            
            if A.LightofDawn:IsReady(unitID) and A.GetToggle(2, "LightofDawnDump") and Player:HolyPower() >= A.GetToggle(2, "DumpHP") then
                return A.LightofDawn:Show(icon)
            end
            
            if (Unit(target):HasDeBuffs(376449) > 0 or (MultiUnits:GetByRangeInCombat(5) >= 1 and A.CrusaderStrike:GetCooldown() > 1.5 and Player:HolyPower() == 5) or ((MultiUnits:GetByRangeInCombat(5) >= 4 or (MultiUnits:GetByRangeInCombat(5) >= 1  and Unit(player):HasBuffs(A.SacredWeaponBuff.ID) > 0)) and Player:HolyPower() >= 3) or TeamCacheFriendlyType == "none") 
			and A.ShieldoftheRighteous:IsReady(player) and A.CrusaderStrike:IsInRange(target) and IsUnitEnemy(target) and Unit(target):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 
            and (HealingEngine.GetBelowHealthPercentUnits(80, 40) < 1 or (HealingEngine.GetBelowHealthPercentUnits(50, 40) < 1 and TeamCache.Friendly.Size <= 2)) then
                return A.ShieldoftheRighteous:Show(icon)
            end
            
        end
    end    
    HealingRotation = Action.MakeFunctionCachedDynamic(HealingRotation)
    
    ---------------------
    --- FILLER ROTATION ---
    ---------------------
    local function FillerRotation(unitID) 
        
        local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(unitID)
        local unitGUID = UnitGUID(unitID)    
        
        if Unit(player):HasDeBuffs(A.Quake.ID) == 0 then
            
            if not inCombat or inCombat and not A.HolyShock:IsReady() and not A.WordofGlory:IsReady() then 
                
                --Flash of Light Infusion proc
                if A.FlashofLight:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) < Player:Execute_Time(A.FlashofLight.ID) and not A.WordofGlory:IsReady(unitID) 
                and Player:Execute_Time(A.FlashofLight.ID) - A.HolyShock:GetCooldown() <= Player:Execute_Time(A.FlashofLight.ID)/2 and Unit(unitID):HealthPercent() <= A.GetToggle(2, "FlashofLightHP") 
                and Unit(player):HasBuffs(A.DivineFavor.ID, true) == 0 and not Unit(unitID):IsDead() and Unit(player):HasBuffs(A.InfusionofLightBuff.ID, true) > Player:Execute_Time(A.FlashofLight.ID) 
                and Unit(unitID):HealthPercent() < FlashofLightHP 
                and Unit(unitID):TimeToDie() > Player:Execute_Time(A.FlashofLight.ID) and Unit(unitID):TimeToDie() < 8 and Unit(player):GetCurrentSpeed() == 0 then
                    return A.FlashofLight:Show(icon)
                end
                
                --Holy Light Infusion proc
                if A.HolyLight:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) < Player:Execute_Time(A.HolyLight.ID) and not A.WordofGlory:IsReady(unitID) 
                and Player:Execute_Time(A.HolyLight.ID) - A.HolyShock:GetCooldown() <= Player:Execute_Time(A.HolyLight.ID)/2 and Unit(player):HasBuffs(A.DivineFavor.ID, true) == 0 and not Unit(unitID):IsDead() 
                and Unit(player):HasBuffs(A.InfusionofLightBuff.ID, true) > Player:Execute_Time(A.HolyLight.ID) and Unit(unitID):HealthPercent() < HolyLightHP 
                and Unit(player):GetCurrentSpeed() == 0 then
                    return A.HolyLight:Show(icon)
                end    
                
                --Flash of Light no infusion
                if Player:ManaPercentage() > GetToggle(2, "ManaConservation") and A.FlashofLight:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) < Player:Execute_Time(A.FlashofLight.ID) 
                and not A.WordofGlory:IsReady(unitID) and Player:Execute_Time(A.FlashofLight.ID) - A.HolyShock:GetCooldown() <= Player:Execute_Time(A.FlashofLight.ID)/2 
                and Unit(unitID):HealthPercent() <= A.GetToggle(2, "FlashofLightHP") and Unit(player):HasBuffs(A.DivineFavor.ID, true) == 0 and not Unit(unitID):IsDead() 
                and Unit(unitID):TimeToDie() > Player:Execute_Time(A.FlashofLight.ID) and Unit(unitID):TimeToDie() < 8 and Unit(player):GetCurrentSpeed() == 0 then
                    return A.FlashofLight:Show(icon)
                end
                
                --Holy Light no infusion
                if Player:ManaPercentage() > GetToggle(2, "ManaConservation") and A.HolyLight:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) < Player:Execute_Time(A.HolyLight.ID) and not A.WordofGlory:IsReady(unitID) 
                and Player:Execute_Time(A.HolyLight.ID) - A.HolyShock:GetCooldown() <= Player:Execute_Time(A.HolyLight.ID)/2 and Unit(player):HasBuffs(A.DivineFavor.ID, true) == 0 and not Unit(unitID):IsDead() 
                and Unit(unitID):HealthPercent() < HolyLightHP and Unit(player):GetCurrentSpeed() == 0 then
                    return A.HolyLight:Show(icon)
                end    
                
            end
            
        end
        
    end
    FillerRotation = Action.MakeFunctionCachedDynamic(FillerRotation)
    
    
    --------------------
    --- DPS ROTATION ---
    --------------------
    local function DamageRotation(unitID)
        
        if A.Zone == "arena" or A.InstanceInfo.isRated or A.Zone == "pvp" or inCombat then
            
            local _,_,_,_,_,NPCID1 = Unit(unitID):InfoGUID()
            local useCC, useKick = Action.InterruptIsValid(unitID)
            
            
            if GetToggle(2, "AutoTarget") and Unit(player):CombatTime() > 0 and MultiUnits:GetByRangeInCombat(15) >= 1 and not Unit(target):IsExplosives() and not Unit(target):IsCondemnedDemon() and (not Unit(target):IsExists() or IsUnitFriendly(target) or Unit(target):IsEnemy()) then 
                if A.IsExplosivesExists() or A.IsCondemnedDemonsExists() then
                    return A:Show(icon, ACTION_CONST_AUTOTARGET)                               
                end 
                
                if  (not Unit(target):IsExists() or IsUnitFriendly(target) or (A.Zone ~= "none" and not A.IsInPvP and not Unit(target):IsCracklingShard() and Unit(target):CombatTime() == 0 and Unit(target):IsEnemy() and Unit(target):HealthPercent() >= 100))     -- No existed or switch target in PvE if we accidentally selected out of combat unit              
                and ((not A.IsInPvP and MultiUnits:GetByRangeInCombat(15) >= 1) or A.Zone == "pvp")                                                                                                                                 -- If rotation mode is PvE and in 40 yards any in combat enemy (exception target) or we're on (R)BG 
                then 
                    return A:Show(icon, ACTION_CONST_AUTOTARGET)
                end 
            end    
            
            if useCC and not isNotCCAble[npc_id] and Unit(unitID):HasDeBuffs({"Silenced", "Stuned", "Sleep", "Fear", "Disoriented", "Incapacitated"}) == 0 and Unit(unitID):IsControlAble("stun") and Unit(unitID):HasBuffs(A.Sanguine.ID) == 0 and A.HammerofJustice:IsReady(unitID) and Unit(unitID):GetDR("stun") > 0 and Unit(unitID):GetRange() <= 10 and A.HammerofJustice:AbsentImun(unitID, Temp.TotalAndPhysAndCC) and not Unit(unitID):IsBoss() and not Unit(unitID):IsDead() and Unit(unitID):CanInterrupt(true, nil, 20, 70)
            then 
                return A.HammerofJustice:Show(icon)       
            end          
            
            if A.Rebuke:IsReady("target") and Unit(unitID):CanInterrupt(true, nil, 20, 70) and A.Rebuke:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then
                return A.Rebuke:Show(icon)
            end     
           
            
            if Unit(mouseover):Name() == "Spiteful Shade" and Unit(mouseover):HasBuffs(A.Sanguine.ID) == 0 and A.HammerofJustice:IsReady(mouseover) and Unit(mouseover):HasDeBuffs({"Stuned", "Disoriented", "PhysStuned"}) == 0 and Unit("targettarget"):Name() == Unit(player):Name() and A.HammerofJustice:AbsentImun(mouseover, Temp.TotalAndPhysAndCC) and Unit(mouseover):GetDR("stun") >= 50 then
                return A.HammerofJustice:Show(icon) 
            end
            
            if Unit(unitID):IsExplosives() then
                if A.HammerofWrath:IsReady(unitID) then
                    return A.HammerofWrath:Show(icon)
                elseif A.Judgment:IsReady(unitID) then
                    return A.Judgment:Show(icon)
                elseif A.CrusaderStrike:IsReady(unitID) then
                    return A.CrusaderStrike:Show(icon)
                elseif A.HolyShock:IsReady(unitID) and HealingEngine.GetBelowHealthPercentUnits(80, 40) == 0 then
                    return A.Fireblood:Show(icon)
                end
            end
            
            if Unit(unitID):HasDeBuffs("BreakAble") == 0 and A.Zone == "arena" or A.InstanceInfo.isRated or (Unit(unitID):GetRange() <= 15 or TeamCache.Friendly.Size == 1) then
                
                if MultiUnits:GetByRangeInCombat(30) >= 4 and A.GetToggle(2, "OffensiveDT") and A.DivineToll:IsReady(unitID) and HealingEngine.GetBelowHealthPercentUnits(80, 40) <= 1 then
                    return A.HandofReckoning:Show(icon)
                end
                
                if A.HammerofWrath:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0
                and IsUnitEnemy(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 and not Unit(unitID):IsDead() then
                    return A.HammerofWrath:Show(icon)
                end     
                
                if A.Consecration:IsReady(player) and MultiUnits:GetByRange(5) >= 2 and Unit(unitID):HasDeBuffs(204242, true) <= 1 and A.CrusaderStrike:IsInRange(unitID) then
                    return A.Consecration:Show(icon)
                end
                
                if A.Awakening:IsTalentLearned() and A.LightofDawn:IsReady(unitID) and A.GetToggle(2, "LightofDawnDump") and Player:HolyPower() == A.GetToggle(2, "DumpHP") and Unit(player):HasBuffs(A.AwakeningBuff.ID) == 0 then
                    return A.LightofDawn:Show(icon)
                end
                
                if A.ShieldoftheRighteous:IsReady(player) and (MultiUnits:GetByRange(5) >= 4 or A.CrusaderStrike:GetCooldown() > 1.5) and Player:HolyPower() >= A.GetToggle(2, "DumpHP") and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and A.CrusaderStrike:IsInRange(unitID) and IsUnitEnemy(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 
                and (HealingEngine.GetBelowHealthPercentUnits(80, 40) < 1 or (HealingEngine.GetBelowHealthPercentUnits(50, 40) < 1 and TeamCache.Friendly.Size <= 2)) then
                    return A.ShieldoftheRighteous:Show(icon)
                end
                
                if A.HammerofWrath:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):GetRange() <= 30 and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 then
                    return A.HammerofWrath:Show(icon)
                end
                
                if A.Judgment:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):GetRange() <= 30 and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 then
                    return A.Judgment:Show(icon)
                end
                
                if ((A.Zone == "pvp" or A.Zone == "arena" or A.InstanceInfo.isRated) or Player:ManaPercentage() > 80 or Unit(target):HasDeBuffs(376449) > 0) and A.HolyShock:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and GetToggle(2, "HolyShockDPS") and Unit(unitID):GetRange() <= 40 and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 then
                    return A.Fireblood:Show(icon)
                end
                
                if A.CrusaderStrike:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and A.CrusaderStrike:IsInRange(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 and
                ((A.CrusadersMight:IsTalentLearned() and Player:HolyPower() < 5 and A.HolyShock:GetCooldown() >= 1.5 and A.HolyShock:GetSpellChargesFrac() <= 1.6 and Player:ManaPercentage() > GetToggle(2, "ManaConservation")) 
                    or (not A.CrusadersMight:IsTalentLearned() and Player:HolyPower() < 5 and ((A.Zone == "pvp" or A.Zone == "arena" or A.InstanceInfo.isRated) or (Player:ManaPercentage() > GetToggle(2, "ManaConservation")))))
                or TeamCache.Friendly.Size == 1
                then
                    return A.CrusaderStrike:Show(icon)
                end
                
                if A.Consecration:IsReady(player) and Unit(unitID):HasDeBuffs(204242, true) <= 1 and A.CrusaderStrike:IsInRange(unitID) then
                    return A.Consecration:Show(icon)
                end
            end    
        end
        
    end
    DamageRotation = Action.MakeFunctionCachedDynamic(DamageRotation)
    
    
    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
    
    -- Intercession Mouseover 
    if A.Intercession:IsReady(mouseover) then 
        unitID = mouseover 
        
        if HealingRotation(unitID) then 
            return true 
        end 
    end 
    
    -- Cleanse Mouseover 
    if A.Cleanse:IsReady(mouseover) then 
        unitID = mouseover 
        
        if HealingRotation(unitID) then 
            return true 
        end 
    end  
    
    -- Heal Mouseover 
    if IsUnitFriendly(mouseover) and A.GetToggle(2, "HealMouseover") then 
        unitID = mouseover 
        
        if HealingRotation(unitID) then 
            return true 
        end 
    end      
    
    if IsUnitFriendly(focus) then    
        unitID = focus
        
        if HealingRotation(unitID) then
            return true
        end
    end  
    
    -- DPS Mouseover 
    if IsUnitEnemy(mouseover) then 
        unitID = mouseover    
        
        if DamageRotation(unitID) and A.GetToggle(2, "DPSMouseover") then 
            return true 
        end 
    end  
    
    -- Filler Mouseover 
    if IsUnitFriendly(mouseover) and A.GetToggle(2, "HealMouseover") then 
        unitID = mouseover 
        
        if FillerRotation(unitID) then 
            return true 
        end 
    end      
    
    if IsUnitFriendly(focus) then
        unitID = focus
        
        if FillerRotation(unitID) then
            return true
        end
    end  
    
    -- DPS Target     
    if IsUnitEnemy(target) then 
        unitID = target
        
        if DamageRotation(unitID) then 
            return true 
        end 
    end         
end 

A[4] = nil
A[5] = nil 
A[6] = function(icon)    
    
    if IsUnitEnemy("mouseover") and Unit("mouseover"):IsExplosives() or IsUnitEnemy("mouseover") and Unit("mouseover"):IsTotem() then 
        return A:Show(icon, ACTION_CONST_LEFT)
    end
end 
A[7] = nil 
A[8] = nil 

