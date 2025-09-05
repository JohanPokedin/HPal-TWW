--#############################################
--#####       Holy Paladin by Johan       #####
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
    HammerofJusticeGreen            = Action.Create({ Type = "SpellSingleColor", ID = 853, Color = "GREEN", Desc = "[1] CC", Hidden = true, QueueForbidden = true }),    
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
    HolyShockDMG                    = Action.Create({ Type = "Spell", ID = 93402        }), 
    
    -- Holy Specific
    Absolution                        = Action.Create({ Type = "Spell", ID = 212056    }),
    AuraMastery                        = Action.Create({ Type = "Spell", ID = 31821    }),
    BeaconofLight                    = Action.Create({ Type = "Spell", ID = 53563    }),
    Cleanse                            = Action.Create({ Type = "Spell", ID = 4987        }),
    DivineProtection                = Action.Create({ Type = "Spell", ID = 498        }),
    HolyLight                        = Action.Create({ Type = "Spell", ID = 82326, predictName = "HolyLight"            }),
    HolyShock                        = Action.Create({ Type = "Spell", ID = 20473, predictName = "HolyShock"            }),
    LightofDawn                        = Action.Create({ Type = "Spell", ID = 85222, predictName = "LightofDawn"        }),
    LightofMartyr                    = Action.Create({ Type = "Spell", ID = 447985, Hidden = true   }),
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
    SanctifiedWrath                    = Action.Create({ Type = "Spell", ID = 53376    }),    
    AvengingCrusader                = Action.Create({ Type = "Spell", ID = 216331    }),
    Awakening                        = Action.Create({ Type = "Spell", ID = 414195, Hidden = true    }),
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
    EmpyrealWard                = Action.Create({ Type = "Spell", ID = 387791, Hidden = true    }),
    EmpyrealLOH                    = Action.Create({ Type = "Spell", ID = 471195    }),
    RiteOfSanctification        = Action.Create({ Type = "Spell", ID = 433568    }),
    RiteOfSanctificationBuff     = Action.Create({ Type = "Spell", ID = 433550, Hidden = true    }),
    HolyBulwark                    = Action.Create({ Type = "Spell", ID = 432459    }),
    HolyBulwarkBuff             = Action.Create({ Type = "Spell", ID = 432607, Hidden = true    }),
    SacredWeapon                = Action.Create({ Type = "Spell", ID = 432472    }),
    SacredWeaponBuff            = Action.Create({ Type = "Spell", ID = 432502, Hidden = true    }),
    BarrierOfFaith                = Action.Create({ Type = "Spell", ID = 148039    }),
    TyrDeliverance                = Action.Create({ Type = "Spell", ID = 200652    }),
    Veneration                    = Action.Create({ Type = "Spell", ID = 392938, Hidden = true    }),
    
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
    SoullettingRuby = Create({ Type = "Trinket", ID = 178809}),  
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
-- (18) clamp thresholds helper
local function clamp1to100(x)
    if not x then return 0 end
    if x < 1 then return 1 end
    if x > 100 then return 100 end
    return x
end

local function RotationsVariables()
    combatTime = Unit(player):CombatTime()
    inCombat = Unit(player):CombatTime() > 0
    UseDBM = GetToggle(1 ,"DBM") -- Don't call it DBM else it broke all the global DBM var used by another addons
    Potion = GetToggle(1, "Potion")
    Racial = GetToggle(1, "Racial")
    -- ProfileUI vars
    BeaconWorkMode = GetToggle(2, "BeaconWorkMode")    
    TrinketMana = GetToggle(2, "TrinketMana")
    LightofDawnHP = clamp1to100(GetToggle(2, "LightofDawnHP"))
    LightofDawnUnits = GetToggle(2, "LightofDawnUnits")
    ForceWoGHP = clamp1to100(GetToggle(2, "ForceWoGHP"))
    HolyLightHP = clamp1to100(GetToggle(2, "HolyLightHP"))
    WordofGloryHP = clamp1to100(GetToggle(2, "WordofGloryHP"))
    HolyShockHP = clamp1to100(GetToggle(2, "HolyShockHP"))
    FlashofLightHP = clamp1to100(GetToggle(2, "FlashofLightHP"))
    HolyPrismHP = clamp1to100(GetToggle(2, "HolyPrismHP"))
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

local GetTotemInfo, IsMouseButtonDown, UnitIsUnit = GetTotemInfo, IsMouseButtonDown, UnitIsUnit

--========================================================
-- Small helpers you already asked to keep at file scope
--========================================================
local function IsCastingSpell(unit, id)
    return select(5, Unit(unit):IsCasting()) == id
end

local function GetNpcId(unit)
    local guid = UnitGUID(unit)
    if not guid then return nil end
    local _, _, _, _, _, npcId = strsplit("-", guid)
    return tonumber(npcId)
end

--========================================================
-- FAST NAMEPLATE REGISTRY + CAST CACHE (shared utility)
-- (13) store cast end times in SECONDS (not ms)
--========================================================
local ActiveUnits, ActiveIndex = {}, {}
do
    local f = CreateFrame("Frame")
    f:RegisterEvent("NAME_PLATE_UNIT_ADDED")
    f:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
    f:SetScript("OnEvent", function(_, ev, unit)
            if ev == "NAME_PLATE_UNIT_ADDED" then
                if UnitCanAttack("player", unit) and not ActiveIndex[unit] then
                    ActiveUnits[#ActiveUnits+1] = unit
                    ActiveIndex[unit] = #ActiveUnits
                end
            else
                local i = ActiveIndex[unit]
                if i then
                    local last = ActiveUnits[#ActiveUnits]
                    ActiveUnits[i] = last
                    ActiveIndex[last] = i
                    ActiveUnits[#ActiveUnits] = nil
                    ActiveIndex[unit] = nil
                end
            end
    end)
end

-- CastCache[u] = { spellID, endTimeSec, isChannel, lastUpdatedSec }
local CastCache = {}
local UnitCastingInfo, UnitChannelInfo = UnitCastingInfo, UnitChannelInfo
local GetTime = GetTime

local function UpdateCastCacheNow()
    local now = GetTime()
    for i = 1, #ActiveUnits do
        local u = ActiveUnits[i]
        local _, _, _, _, endMS, _, _, _, spellID = UnitCastingInfo(u)
        local isCh
        if not spellID then
            _, _, _, _, endMS, _, _, spellID = UnitChannelInfo(u)
            isCh = true
        end
        if spellID and endMS then
            CastCache[u] = { spellID, (endMS / 1000), isCh, now }
        else
            CastCache[u] = nil
        end
    end
end

local nextNPScan, SCAN_DELTA = 0, 0.10
local function NPScanTick()
    local t = GetTime()
    if t >= nextNPScan then
        nextNPScan = t + SCAN_DELTA
        UpdateCastCacheNow()
    end
end

--========================================================
-- (12) DANGEROUS CAST SET + WRAPPER
--========================================================
local DANGEROUS_VERSION = "TWW_S3"
local DANGEROUS = {
    [258622]=true,[260202]=true,[262347]=true,[267354]=true,[269429]=true,
    [297128]=true,[323825]=true,[324449]=true,[326409]=true,[328791]=true,
    [330716]=true,[333241]=true,[333827]=true,[339573]=true,[342135]=true,
    [346742]=true,[350875]=true,[355429]=true,[357243]=true,[357508]=true,
    [423015]=true,[423665]=true,[424431]=true,[424958]=true,[425394]=true,
    [426787]=true,[427404]=true,[427609]=true,[428066]=true,[428169]=true,
    [428266]=true,[430171]=true,[438476]=true,[439365]=true,[439524]=true,
    [441171]=true,[444250]=true,[448492]=true,[448619]=true,[448791]=true,
    [448888]=true,[453212]=true,[460156]=true,[463206]=true,[465827]=true,
    [465463]=true,[469721]=true,[473070]=true,[1214628]=true,[1215102]=true,
    [1215412]=true,[1215409]=true,[1218117]=true,[1215741]=true,[1217232]=true,
    [1219700]=true,[1221532]=true,[1241693]=true,
}
local function IsDangerous(spellID)
    return spellID and DANGEROUS[spellID] == true
end

local function CheckEnemyCasting_cached()
    for i = 1, #ActiveUnits do
        local cc = CastCache[ActiveUnits[i]]
        if cc and IsDangerous(cc[1]) then
            return true
        end
    end
    return false
end

--========================================================
-- COSMIC SINGULARITY (432117) — event-driven timer + check
--========================================================
local LAST_COSMIC_T = 0
do
    local f = CreateFrame("Frame")
    f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    f:SetScript("OnEvent", function()
            local _, ev, _, _, _, _, _, _, _, _, _, spellID = CombatLogGetCurrentEventInfo()
            if ev == "SPELL_CAST_SUCCESS" and spellID == 432117 then
                LAST_COSMIC_T = GetTime()
            end
    end)
end

local function Cast432117Within5s()
    if LAST_COSMIC_T == 0 then
        return true
    end
    local dt = GetTime() - LAST_COSMIC_T
    return dt > 0 and dt < 5
end

-- Current-cast check for Cosmic using seconds-base cache
local function AnyUnitCastingCosmicNow()
    for i = 1, #ActiveUnits do
        local cc = CastCache[ActiveUnits[i]]
        if cc and cc[1] == 432117 then
            return true
        end
    end
    return false
end

--========================================================
-- Light throttles for heavy gates
--========================================================
local nextSeasons, nextMassUtils, nextStopcast = 0, 0, 0

-- (6) Aura swap throttle
local nextAuraSwap = 0

-- (1)(2) Beacon tracking via CLEU (applied/refresh) at file scope
local MyBeacons = { Light = nil, Faith = nil }
local BEACON_TRACK_READY = false
local function EnsureBeaconTracker()
    if BEACON_TRACK_READY then return end
    Listener:Add("MY_BEACON_TRACKER_CLEU", "COMBAT_LOG_EVENT_UNFILTERED", function()
            local _, subEvent, _, _, _, _, _, destGUID, _, _, _, spellID = CombatLogGetCurrentEventInfo()
            if subEvent == "SPELL_AURA_APPLIED" or subEvent == "SPELL_AURA_REFRESH" then
                if spellID == A.BeaconofLight.ID then
                    MyBeacons.Light = destGUID
                elseif spellID == A.BeaconofFaith.ID then
                    MyBeacons.Faith = destGUID
                end
            elseif subEvent == "SPELL_AURA_REMOVED" then
                if spellID == A.BeaconofLight.ID and MyBeacons.Light == destGUID then
                    MyBeacons.Light = nil
                elseif spellID == A.BeaconofFaith.ID and MyBeacons.Faith == destGUID then
                    MyBeacons.Faith = nil
                end
            end
    end)
    BEACON_TRACK_READY = true
end
EnsureBeaconTracker()

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    IsUnitEnemy(unit) and Unit(unit):GetDR("stun") > 0 and
    A.HammerofJustice:IsInRange(unit) and Unit(unit):HasDeBuffs({"Silenced", "Stuned", "Sleep", "Fear", "Disoriented", "Incapacitated"}) == 0 and
    A.HammerofJusticeGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)
end 
A[1] = function(icon)    
    local useKick, useCC, useRacial = A.InterruptIsValid(targettarget, "TargetMouseover")    
    
    -- Manual Key
    if     A.HammerofJusticeGreen:IsReady(nil, nil, nil, true) and
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
    local unitID
    if IsUnitEnemy("mouseover") then
        unitID = "mouseover"
    elseif IsUnitEnemy("target") then
        unitID = "target"
    end
    if not unitID then return end
    
    -- Primary: wrapper that already covers casts *and* channels (6th = isChannel)
    local left, _, spellID, _, notKickAble, isChannel = Unit(unitID):IsCastingRemains()
    
    -- Fallback: call CastTime() directly if wrapper returns nothing
    if not left or left <= 0 then
        local l, _, sid, _, nki, chan = select(2, Unit(unitID):CastTime())
        if l and l > 0 then
            left, spellID, notKickAble, isChannel = l, sid, nki, chan
        end
    end
    
    if left and left > A.GetPing() then
        if not notKickAble
        and A.Rebuke:IsReadyP(unitID, nil, true, true)
        and A.Rebuke:AbsentImun(unitID, Temp.TotalAndPhysKick, true)
        then
            return A.RebukeGreen:Show(icon)
        end
    end
end

TMW:RegisterCallback("TMW_ACTION_HEALINGENGINE_UNIT_UPDATE", function(callbackEvent, thisUnit, db, QueueOrder) 
        local _,_,_,_,_,NPCID = Unit("target"):InfoGUID()
        
        if (A.InstanceInfo and A.InstanceInfo.KeyStone or 0) >= 7 and thisUnit.Unit and (Unit(thisUnit.Unit):HasDeBuffsStacks(209858) >= GetToggle(2, "Necrotic") or Unit(thisUnit.Unit):HasDeBuffsStacks(388801) >= 2) and (not AuraIsValid(thisUnit.Unit, "UseDispel", "Dispel") or AuraIsValid(thisUnit.Unit, "UseDispel", "Dispel") and not A.Cleanse:IsReady()) and (not AuraIsValid(thisUnit.Unit, true, "BlessingofFreedom") or AuraIsValid(thisUnit.Unit, true, "BlessingofFreedom") and not A.BlessingofFreedom:IsReady()) then
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

-- (19) Central "can heal" helper
local function CanHeal(unit)
    return IsUnitFriendly(unit)
    and Unit(unit):IsExists()
    and not Unit(unit):IsDead()
    and Unit(unit):HasDeBuffs(A.Cyclone.ID, nil, true) == 0
end

-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    
    -- (4) Keep cast cache fresh once per tick
    NPScanTick()
    
    local CurrentTanks = HealingEngine.GetMembersByMode("TANK")
    local membersAll = HealingEngine.GetMembersAll()
    
    local inCombat = Unit(player):CombatTime() > 0
    local isMoving = Player:IsMoving()
    local isMovingFor = A.Player:IsMovingTime()
    local combatTime = Unit(player):CombatTime()    
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods:GetPullTimer()
    local AoEON = GetToggle(2, "AoE") 
    
    -- Healing Engine vars (5) cached once
    local AVG_DMG = HealingEngine.GetIncomingDMGAVG()
    local AVG_HPS = HealingEngine.GetIncomingHPSAVG()
    local TeamCacheEnemySize = TeamCache.Enemy.Size
    local TeamCacheFriendlySize = TeamCache.Friendly.Size
    local TeamCacheFriendlyType = TeamCache.Friendly.Type or "none"  
    local DungeonGroup = TeamCacheFriendlySize >= 2 and TeamCacheFriendlySize <= 5
    local RaidGroup = TeamCacheFriendlySize >= 5
    
    local function CTT_ShouldAvoidStun(unit)
        if not CTT then return false end
        local guid = UnitGUID(unit)
        if not guid or not CTT.IsNPC(guid) then return false end
        local npcId = CTT.GetNPCId(guid)
        if not npcId then return false end
        if CTT.stunned and CTT.stunned[npcId] then return false end
        local found = CTT.immuneFound and CTT.immuneFound[npcId]
        local known = CTT.immuneKnown and CTT.immuneKnown[npcId]
        if found == true then return true end
        if known and found ~= false then return true end
        return false
    end    
    
    -- Cheaper “hold Freedom” using the cast cache (Cosmic only)
    local function HoldFreedom()
        return AnyUnitCastingCosmicNow()
    end
    
    -- ==========================================
    -- NEW HELPERS: Arak presence + BoF gate
    -- ==========================================
    -- Is Arak (215407) on target or any hostile nameplate?
    local function IsArakPresent()
        if GetNpcId("target") == 215407 then
            return true
        end
        for i = 1, #ActiveUnits do
            if GetNpcId(ActiveUnits[i]) == 215407 then
                return true
            end
        end
        return false
    end
    
    -- BoF permission considering Arak/Cosmic timing.
    -- If Arak present: ONLY allow in the 5s AFTER Cosmic (432117) completed.
    -- If Arak not present: allow whenever Cosmic isn’t being cast right now.
    local function CanUseFreedomNow()
        if IsArakPresent() then
            local recentCosmicEnd = (LAST_COSMIC_T > 0) and Cast432117Within5s()
            return recentCosmicEnd and not HoldFreedom()
        else
            return not HoldFreedom()
        end
    end
    
    -- Use cached cast info to decide whether enemy will finish before our cast (13 seconds-base)
    local function DoNotCastFOL()
        local watch = {
            [1235326] = true, -- Disrupting Screech
            [427609]  = true, -- Disrupting Shout
        }
        local folExec = Player:Execute_Time(A.FlashofLight.ID) or 0
        for i = 1, #ActiveUnits do
            local cc = CastCache[ActiveUnits[i]]
            if cc and watch[cc[1]] then
                local enemyRem = math.max(0, cc[2] - GetTime())
                if folExec > enemyRem then return true end
            end
        end
        return false
    end
    
    local function DoNotCastHL()
        local watch = {
            [1235326] = true, -- Disrupting Screech
            [427609]  = true, -- Disrupting Shout
        }
        local hlExec = Player:Execute_Time(A.HolyLight.ID) or 0
        for i = 1, #ActiveUnits do
            local cc = CastCache[ActiveUnits[i]]
            if cc and watch[cc[1]] then
                local enemyRem = math.max(0, cc[2] - GetTime())
                if hlExec > enemyRem then return true end
            end
        end
        return false
    end
    
    RotationsVariables()    
    
    ---------------------
    --- HEAL ROTATION ---
    ---------------------
    local function HealingRotation(unitID) 
        
        local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(unitID)
        local unitGUID = UnitGUID(unitID)    
        
        -- Defensive CDs based on cached dangerous casts
        if A.DivineProtection:IsReady(player) and (CheckEnemyCasting_cached() or (Unit(player):HealthPercent() <= 80 and combatTime > 5)) then
            return A.DivineProtection:Show(icon)
        end
        
        -- Smart Blinding Light (only if +10y, cc'able, casting past GCD)
        local function ShouldBlindingLight()
            local gcd = A.GetGCD() or 1.5
            for i = 1, #ActiveUnits do
                local u = ActiveUnits[i]
                if not Unit(u):IsBoss() and Unit(u):IsControlAble("incapacitate", 25) and not CTT_ShouldAvoidStun(u) then
                    local maxRange = Unit(u):GetRange()
                    if maxRange and maxRange <= 10 then
                        local cc = CastCache[u]
                        if cc and ((cc[2] - GetTime()) > gcd) then
                            return true
                        end
                    end
                end
            end
            return false
        end
        
        if useCC and A.BlindingLight:IsReady("player") and not HoldFreedom() and ShouldBlindingLight() then
            return A.BlindingLight:Show(icon)
        end
        
        if A.Rebuke:IsReadyP("target") and Unit("target"):CanInterrupt(true, nil, 20, 70) and A.Rebuke:AbsentImun("target", Temp.TotalAndPhysKick, true) then
            return A.Rebuke:Show(icon)
        end    
        
        if A.AuraMastery:IsReady(player) and (CheckEnemyCasting_cached() or Unit(player):HasDeBuffs(451764) > 0) then
            return A.AuraMastery:Show(icon)
        end
        
        -- Redundant Kick/CCs for Grasping Blood during Last Boss Arak
        if A.Rebuke:IsReadyP("mouseover")
        and combatTime > 0
        and IsCastingSpell("mouseover", 432031)
        and not HoldFreedom()
        and not (GetNpcId("target") == 215407 and IsCastingSpell("target", 432117))
        then
            return A.Rebuke:Show(icon)
        end
        
        if A.HammerofJustice:IsReady("mouseover")
        and combatTime > 0
        and IsCastingSpell("mouseover", 432031)
        and not HoldFreedom()
        and not (GetNpcId("target") == 215407 and IsCastingSpell("target", 432117))
        then
            return A.HammerofJustice:Show(icon)
        end
        
        if A.BlindingLight:IsReady("player")
        and combatTime > 0
        and IsCastingSpell("mouseover", 432031)
        and not HoldFreedom()
        and not (GetNpcId("target") == 215407 and IsCastingSpell("target", 432117))
        then
            return A.BlindingLight:Show(icon)
        end
        
        local function BlessingofSeasons(unitID, allMembers)
            local getmembersAll = allMembers or HealingEngine.GetMembersAll()
            for i = 1, #getmembersAll do 
                if A.HolyShock:IsInRange(getmembersAll[i].Unit) then
                    --BlessingofAutumn
                    if A.BlessingofAutumn:IsReady(getmembersAll[i].Unit) then 
                        if Unit(getmembersAll[i].Unit):IsDamager() and (Unit(getmembersAll[i].Unit):Class() == "MAGE" and Unit(getmembersAll[i].Unit):HasBuffs(190319)) then
                            HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)    
                            return A.BlessingofAutumn
                        else 
                            HealingEngine.SetTarget(player, 0.5)
                            return A.BlessingofAutumn
                        end  
                    elseif A.BlessingofWinter:IsReady(player)  then 
                        HealingEngine.SetTarget(player, 0.5)    
                        return A.BlessingofWinter
                    elseif A.BlessingofSummer:IsReady(player) 
                    and not (A.BlessingofAutumn:IsReady(getmembersAll[i].Unit) or A.BlessingofWinter:IsReady(getmembersAll[i].Unit) or A.BlessingofSpring:IsReady(getmembersAll[i].Unit)) then
                        if (Unit(player):HasBuffs(A.AvengingWrath.ID) >= 10 or Unit(player):HasBuffs(A.AvengingCrusader.ID) >= 10) then
                            HealingEngine.SetTarget(player, 0.5)
                            return A.BlessingofSummer
                        end
                    end
                end                  
            end    
            if A.BlessingofSpring:IsReady(player) then
                HealingEngine.SetTarget(player, 0.5)
                return A.BlessingofSpring  
            end
        end
        
        -- Helper: do we already have ANY self-cast paladin aura?
        local function HasAnySelfPalAura()
            local a = A
            if Unit("player"):HasBuffs(a.DevotionAura.ID,   false, true) > 0 then return true end
            if Unit("player"):HasBuffs(a.ConcentrationAura.ID,false, true) > 0 then return true end
            if Unit("player"):HasBuffs(a.RetributionAura.ID, false, true) > 0 then return true end
            if Unit("player"):HasBuffs(a.CrusaderAura.ID,    false, true) > 0 then return true end
            return false
        end
        
        local function InRatedOrPvP()
            return (A.Zone == "pvp") or (A.Zone == "arena") or (A.InstanceInfo and A.InstanceInfo.isRated)
        end
        
        -- Only choose an aura if we don't already have a self-cast one.
        -- Prefer Concentration in PvP/rated, otherwise Devotion.
        -- Never auto-apply Crusader Aura (especially not when mounted).
        local function DesiredAura()
            if HasAnySelfPalAura() then
                return nil
            end
            if InRatedOrPvP() and A.ConcentrationAura:IsReady() then
                return A.ConcentrationAura
            elseif A.DevotionAura:IsReady() then
                return A.DevotionAura
            end
        end
        
        do
            local aura = DesiredAura()
            if aura and aura:IsReady() and GetTime() >= nextAuraSwap and Unit("player"):HasBuffs(aura.ID, false, true) == 0 then
                nextAuraSwap = GetTime() + 2.0
                return aura:Show(icon)
            end
        end
        
        --Lay on hands
        if Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 
        and ((TeamCacheFriendlyType ~= "raid" and combatTime > 0) or (TeamCacheFriendlyType == "raid" and combatTime > 30) or (Action.Zone == "arena" or (Action.InstanceInfo and Action.InstanceInfo.isRated))) then
            for i = 1, #membersAll do 
                if A.LayOnHands:IsInRange(membersAll[i].Unit) then 
                    if not Unit(membersAll[i].Unit):IsPet() 
                    and Unit(membersAll[i].Unit):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 
                    and not Unit(membersAll[i].Unit):IsDead() 
                    and (((not A.EmpyrealWard:IsTalentLearned() and A.LayOnHands:IsReadyByPassCastGCD(membersAll[i].Unit))
                            or (A.EmpyrealWard:IsTalentLearned() and A.EmpyrealLOH:IsReadyByPassCastGCD(membersAll[i].Unit))))
                    and (((Unit(membersAll[i].Unit):HealthDeficit() >= Unit(player):HealthMax()) and Unit(membersAll[i].Unit):TimeToDie() <= 3)
                        or (Unit(membersAll[i].Unit):HealthPercent() <= 30 and Unit(membersAll[i].Unit):TimeToDie() <= 3))
                    and Unit(membersAll[i].Unit):HasDeBuffs(A.Forbearance.ID) == 0 then
                        HealingEngine.SetTarget(membersAll[i].Unit, 0.5)
                        return A.LayOnHands:Show(icon)
                    end                    
                end                
            end    
        end 
        
        if GetToggle(1, "StopCast") and GetTime() >= nextStopcast then
            nextStopcast = GetTime() + 0.08
            
            local castRemHL  = Unit(player):IsCastingRemains(A.HolyLight.ID)
            local castRemFoL = Unit(player):IsCastingRemains(A.FlashofLight.ID)
            
            if (castRemHL > 0 and DoNotCastHL()) or (castRemFoL > 0 and DoNotCastFOL()) then
                return A:Show(icon, ACTION_CONST_STOPCAST)
            end
            
            if inCombat then
                local execHL  = Player:Execute_Time(A.HolyLight.ID)
                local execFoL = Player:Execute_Time(A.FlashofLight.ID)
                local focusHealthy = Unit(focus):IsExists() and Unit(focus):HealthPercent() or 100
                if ((castRemHL  > execHL/2  or castRemFoL > execFoL/2) and A.HolyShock:IsReady(unitID) and Unit(unitID):HealthPercent() < HolyShockHP)
                or ((castRemHL  > 0.5      or castRemFoL > 0.5)      and A.WordofGlory:IsReady(unitID) and Unit(unitID):HealthPercent() < WordofGloryHP)
                or (castRemHL  > 0 and focusHealthy >= HolyLightHP)
                or (castRemFoL > 0 and focusHealthy >= FlashofLightHP)
                then
                    return A:Show(icon, ACTION_CONST_STOPCAST)
                end
            end
        end
        
        --Blessing of Sacrifice
        if A.BlessingofSacrifice:IsReadyByPassCastGCD(unitID) 
        and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 
        and combatTime > 0 
        and not UnitIsUnit(unitID, player) 
        and not Unit(unitID):IsPet() 
        and not Unit(unitID):IsDead() 
        and Unit(unitID):HealthPercent() <= 40 
        and Unit(unitID):TimeToDie() <= 4 
        and (Unit(unitID):HasBuffs("TotalImun") == 0 
            or (Unit(unitID):HasBuffs("DamagePhysImun") > 0 and Unit(unitID):TimeToDieMagic() <= 4) 
            or (Unit(unitID):HasBuffs("DamageMagicImun") > 0 and Unit(unitID):TimeToDie() - Unit(unitID):TimeToDieMagic() < -1)) then
            return A.BlessingofSacrifice:Show(icon)
        end    
        
        --Blessing of Protection (Keystone Combustion Aggro)
        do
            for i = 1, #membersAll do 
                if combatTime > 0 and useShields and A.BlessingofProtection:IsInRange(membersAll[i].Unit) and (A.InstanceInfo and A.InstanceInfo.KeyStone or 0) >= 15 then 
                    if not Unit(membersAll[i].Unit):IsPet() and not Unit(membersAll[i].Unit):IsDead() and A.BlessingofProtection:IsReady(membersAll[i].Unit) 
                    and Unit(membersAll[i].Unit):HasDeBuffs(A.Forbearance.ID) == 0 and Unit(membersAll[i].Unit):HasBuffs(A.Combustion.ID) > 0
                    and Unit(membersAll[i].Unit):IsTanking() and not Unit(membersAll[i].Unit):Role("TANK") and not UnitIsUnit(membersAll[i].Unit, player) 
                    and (Unit(membersAll[i].Unit):HasBuffs("TotalImun") == 0 or Unit(membersAll[i].Unit):HasBuffs("DamagePhysImun") == 0) then
                        HealingEngine.SetTarget(membersAll[i].Unit, 0.5)       
                        return A.BlessingofProtection:Show(icon)                        
                    end                    
                end                
            end    
        end
        
        --Blessing of Protection (general)
        if A.BlessingofProtection:IsReady(unitID) 
        and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 
        and useShields and combatTime > 0 
        and not Unit(unitID):IsPet() 
        and not Unit(unitID):Role("TANK") 
        and not UnitIsUnit(unitID, player) 
        and not Unit(unitID):IsDead() 
        and Unit(unitID):HealthPercent() <= 30 
        and Unit(unitID):TimeToDie() <= 3 
        and Unit(unitID):HasDeBuffs(A.OrbofPowerBlue.ID) == 0 
        and Unit(unitID):HasDeBuffs(A.OrbofPowerGreen.ID) == 0 
        and Unit(unitID):HasDeBuffs(A.OrbofPowerPurple.ID) == 0 
        and Unit(unitID):HasDeBuffs(A.OrbofPowerOrange.ID) == 0 
        and Unit(unitID):HasDeBuffs(A.Forbearance.ID, true) == 0
        and not Unit(unitID):HasFlags() 
        and (Unit(unitID):HasBuffs("TotalImun") == 0 
            or (Unit(unitID):HasBuffs("DamagePhysImun") == 0 and Unit(unitID):TimeToDie() - Unit(unitID):TimeToDieMagic() < -1)) then
            return A.BlessingofProtection:Show(icon)
        end    
        
        if A.WillToSurvive:IsReady() and Unit(player):HasDeBuffs("Stuned") > 2 then
            return A.WillToSurvive:Show(icon)
        end
        
        -- ##################################
        -- ##### Beacon of Light / Faith #####
        -- ##################################
        
        -- Helper: do I already have *my* Beacon on this unit?
        local function HasMyBeacon(unit, spell)
            local guid = UnitGUID(unit)
            if not guid then return false end
            if spell.ID == A.BeaconofLight.ID then
                return MyBeacons.Light == guid
            elseif spell.ID == A.BeaconofFaith.ID then
                return MyBeacons.Faith == guid
            end
            return false
        end
        
        -- Helper: try to assign a Beacon
        local function TryBeacon(unit, spell)
            return spell:IsReady(unit)
            and Unit(unit):Role("TANK")
            and not HasMyBeacon(unit, spell)
        end
        
        -- =====================
        -- SOLO: BoL on yourself
        -- =====================
        if not A.BeaconofVirtue:IsTalentLearned()
        and TeamCacheFriendlyType == "none"
        and A.BeaconofLight:IsReady("player")
        and not HasMyBeacon("player", A.BeaconofLight) then
            return A.BeaconofLight:Show(icon)
        end
        
        -- ========================
        -- RAID: BoL + BoF on tanks
        -- ========================
        if not A.BeaconofVirtue:IsTalentLearned()
        and A.BeaconofFaith:IsTalentLearned()
        and TeamCacheFriendlyType == "raid" then
            for _, unit in pairs({"target", "mouseover"}) do
                if TryBeacon(unit, A.BeaconofLight) then
                    return A.BeaconofLight:Show(icon)
                end
                if TryBeacon(unit, A.BeaconofFaith) then
                    return A.BeaconofFaith:Show(icon)
                end
            end
        end
        
        -- ============================
        -- PARTY: BoF on self + BoL tank
        -- ============================
        if not A.BeaconofVirtue:IsTalentLearned()
        and A.BeaconofFaith:IsTalentLearned()
        and TeamCacheFriendlyType == "party" then
            if A.BeaconofFaith:IsReady("player")
            and not HasMyBeacon("player", A.BeaconofFaith) then
                return A.BeaconofFaith:Show(icon)
            end
            if TryBeacon(unitID, A.BeaconofLight) then
                return A.BeaconofLight:Show(icon)
            end
        end
        
        if A.SavedbytheLight:IsTalentLearned() and A.BeaconofFaith:IsTalentLearned() and (A.Zone == "arena" or A.Zone == "pvp" or (A.InstanceInfo and A.InstanceInfo.isRated)) then
            if UnitIsUnit(unitID, player)
            and not Unit(unitID):IsDead()
            and Unit(player):HasBuffs(A.BeaconofLight.ID, true) == 0
            and Unit(player):HasDeBuffs(A.RecentlySavedByTheLight.ID, true) == 0
            or (not UnitIsUnit(unitID, player)
                and HealingEngine.GetBuffsCount(A.BeaconofFaith.ID) > 0
                and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0
                and not Unit(unitID):IsDead()
                and IsUnitFriendly(unitID)
                and Unit(unitID):IsPlayer()
                and Unit(player):HasDeBuffs(A.RecentlySavedByTheLight.ID, true) > 0
                and Unit(unitID):HasDeBuffs(A.RecentlySavedByTheLight.ID, true) == 0
                and Unit(unitID):HasBuffs(A.BeaconofLight.ID, true) == 0
                and Unit(unitID):HasBuffs(A.BeaconofFaith.ID, true) == 0
                and Unit(unitID):HealthPercent() <= 45
            and combatTime > 0) then
                return A.BeaconofLight:Show(icon)
            end
            if IsUnitFriendly(unitID)
            and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0
            and not UnitIsUnit(unitID, player)
            and not Unit(unitID):IsDead()
            and Unit(unitID):IsPlayer()
            and Unit(unitID):HasDeBuffs(A.RecentlySavedByTheLight.ID, true) == 0
            and (Unit(player):HasBuffs(A.BeaconofLight.ID, true) == 0 or Unit(player):HasDeBuffs(A.RecentlySavedByTheLight.ID, true) == 0)
            and Unit(unitID):HasBuffs(A.BeaconofLight.ID, true) == 0
            and Unit(unitID):HasBuffs(A.BeaconofFaith.ID, true) == 0
            and Unit(unitID):HealthPercent() <= 45
            and combatTime > 0 then
                return A.BeaconofFaith:Show(icon)
            end
        end
        
        --Beacon of Virtue
        if A.BeaconofVirtue:IsReady(unitID) 
        and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 
        and A.BeaconofVirtue:IsTalentLearned() 
        and TeamCacheFriendlyType ~= "none"
        and (not IsUnitEnemy(unitID))
        and A.BeaconofVirtue:IsInRange(unitID)
        and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0
        and (((DungeonGroup) and (HealingEngine.GetBelowHealthPercentUnits(GetToggle(2, "BoVHPParty"), 40) >= GetToggle(2, "BoVUnitsParty")))
            or ((RaidGroup) and (HealingEngine.GetBelowHealthPercentUnits(GetToggle(2, "BoVHPRaid"), 40) >= GetToggle(2, "BoVUnitsRaid")))) then
            return A.BeaconofVirtue:Show(icon)
        end
        
        -- Soulletting Ruby / Tyr / Rite / AC (unchanged logic)
        if A.SoullettingRuby:IsReady() and Unit(player):HealthDeficit() >= 520000 and combatTime > 0 then
            return A.SoullettingRuby:Show(icon)
        end
        if A.TyrDeliverance:IsReady() and Unit(player):GetCurrentSpeed() == 0 and (A.Zone == "pvp" or A.Zone == "arena" or (A.InstanceInfo and A.InstanceInfo.isRated)) and HealingEngine.GetBelowHealthPercentUnits(85, 40) >= 4 then
            return A.TyrDeliverance:Show(icon)
        end
        if not inCombat and A.RiteOfSanctification:IsTalentLearned() and Unit(player):HasBuffs(A.RiteOfSanctificationBuff.ID) <= 600 then
            return A.RiteOfSanctification:Show(icon)
        end    
        if inCombat and A.AvengingCrusader:IsReady() and A.AvengingCrusader:IsTalentLearned()
        and HealingEngine.GetBelowHealthPercentUnits(80, 40) >= 5
        and HealingEngine.GetIncomingDMGAVG() > 20 then
            return A.AvengingCrusader:Show(icon)
        end
        
        -- Holy Bulwark / Sacred Weapon
        if inCombat and A.HolyBulwark:IsTalentLearned() and A.HolyBulwark:IsReady(unitID)
        and Unit(unitID):HasBuffs(A.HolyBulwarkBuff.ID, true) == 0 and Unit(player):HasBuffs(A.HolyBulwarkBuff.ID) == 0
        and ((TeamCacheFriendlyType == "raid" and combatTime < 15 and Unit(unitID):Role("TANK")) or Unit(unitID):HealthPercent() <= 60) then
            return A.HolyBulwark:Show(icon)
        end
        
        if inCombat and A.HolyBulwark:IsTalentLearned() and A.SacredWeapon:IsReady(unitID)
        and (((HealingEngine.GetBelowHealthPercentUnits(80, 40) >= 5) and Unit(unitID):Role("HEALER") and not Unit(unitID):HasSpec(256))
            or ((HealingEngine.GetBelowHealthPercentUnits(80, 40) < 5) and Unit(unitID):Role("DAMAGER")))
        and Unit(unitID):HasBuffs(A.SacredWeaponBuff.ID, true) == 0
        and Unit(player):HasBuffs(A.SacredWeaponBuff.ID) == 0 then
            return A.SacredWeapon:Show(icon)
        end
        
        -- Mouseover Bress
        if Unit(mouseover):IsDead() and Unit(mouseover):IsPlayer() then
            if inCombat and A.Intercession:IsReady(mouseover) then
                return A.Intercession:Show(icon)
            elseif not inCombat and A.Absolution:IsReady(mouseover) then
                return A.Absolution:Show(icon)
            end
        end
        
        if A.Veneration:IsTalentLearned() and combatTime > 0 and A.HammerofWrath:IsReady(target)
        and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and IsUnitEnemy(target)
        and Unit(target):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 and not Unit(target):IsDead() then
            return A.HammerofWrath:Show(icon)
        end
        
        if A.Judgment:IsReady(target) and Unit(target):CombatTime() > 0 and combatTime > 0
        and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and IsUnitEnemy(target)
        and Unit(target):HasDeBuffs(A.Cyclone.ID, nil, true) == 0
        and (Unit(player):HasBuffs(A.AwakeningBuff.ID) <= 5
            or (Unit(player):HasBuffs(A.AwakeningBuff.ID) > 5 and HealingEngine.GetBelowHealthPercentUnits(80, 40) >= 4)) then
            return A.Judgment:Show(icon)
        end
        
        -- Divine Toll
        if A.DivineToll:IsReady(unitID) and combatTime > 0 and Unit(unitID):IsPlayer()
        and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 and not Unit(unitID):IsDead()
        and not IsUnitEnemy(unitID) and A.DivineToll:IsInRange(unitID)
        and Unit(unitID):HealthPercent() < HolyShockHP
        and ((Player:HolyPower() <= 2 and
                (((Action.Zone == "arena") and (TeamCache.Friendly.Size >= 2 and HealingEngine.GetBelowHealthPercentUnits(80, 40) >= 2))
                    or (TeamCacheFriendlyType == "none" and MultiUnits:GetByRange(10) > 2 and Unit(player):HealthPercent() <= 80)
                    or (TeamCacheFriendlyType == "party" and HealingEngine.GetBelowHealthPercentUnits(GetToggle(2, "DivineTollHPParty"), 40) >= GetToggle(2, "DivineTollUnitsParty"))
                    or (TeamCacheFriendlyType == "raid" and HealingEngine.GetBelowHealthPercentUnits(GetToggle(2, "DivineTollHPRaid"), 40) >= GetToggle(2, "DivineTollUnitsRaid"))))
            or (TeamCacheFriendlyType ~= "raid" and HealingEngine.GetBelowHealthPercentUnits(50, 40) >= 4 and Player:HolyPower() <= 3)
            or (TeamCacheFriendlyType == "raid" and HealingEngine.GetBelowHealthPercentUnits(80, 40) >= 5)) then
            return A.DivineToll:Show(icon)
        end
        
        -- PvP utilities & dispels & blessings (throttled a bit)
        if (not (Action.InstanceInfo and Action.InstanceInfo.isRated) or ((Action.InstanceInfo and Action.InstanceInfo.isRated) and (Unit(unitID):HealthPercent() >= 30 or (Unit(unitID):HealthPercent() < 30 and not A.HolyShock:IsReady() and not A.WordofGlory:IsReady())))) then
            if GetTime() >= nextMassUtils then
                nextMassUtils = GetTime() + 0.12
                
                -- Arena Freedom (targeting logic only)
                if (A.Zone == "arena" or (A.InstanceInfo and A.InstanceInfo.isRated)) and A.BlessingofFreedom:IsReady() and A.GetToggle(2, "DispelSniper") then
                    for i = 1, #membersAll do
                        if A.BlessingofFreedom:IsInRange(membersAll[i].Unit) and not Unit(membersAll[i].Unit):IsDead()
                        and Unit(membersAll[i].Unit):HasBuffs(A.BlessingofFreedom.ID) == 0
                        and AuraIsValid(membersAll[i].Unit, true, "BlessingofFreedom")
                        and Unit(membersAll[i].Unit):HasSpec(PVPMELEE)
                        and Unit(membersAll[i].Unit):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 then
                            HealingEngine.SetTarget(membersAll[i].Unit, 0.5)
                        end
                    end
                end
                
                -- Cleanse (member sweep)
                if A.Cleanse:IsReady() and A.GetToggle(2, "DispelSniper") then
                    for i = 1, #membersAll do
                        local U = Unit(membersAll[i].Unit)
                        if A.Cleanse:IsInRange(membersAll[i].Unit)
                        and ((U:HasDeBuffs(1240097) == 0 or U:HasDeBuffs(1240097) < 20)
                            and (U:HasDeBuffs(461487) == 0 or U:HasDeBuffs(461487) < 6)
                            and (U:HasDeBuffs(473713) == 0 or U:HasDeBuffs(473713) < 9))
                        and not U:IsDead()
                        and AuraIsValid(membersAll[i].Unit, "UseDispel", "Dispel")
                        and U:HasDeBuffs(342938) == 0
                        and U:HasDeBuffs(A.Cyclone.ID, nil, true) == 0 then
                            HealingEngine.SetTarget(membersAll[i].Unit, 0.5)
                        end
                    end
                end
                
                -- Blessing of Freedom (PvE general) honoring Cosmic window + Arak gate
                if A.BlessingofFreedom:IsReady() and A.GetToggle(2, "DispelSniper") then
                    for i = 1, #membersAll do
                        if A.BlessingofFreedom:IsInRange(membersAll[i].Unit)
                        and not Unit(membersAll[i].Unit):IsDead()
                        and CanUseFreedomNow()
                        and Unit(membersAll[i].Unit):HasBuffs(A.BlessingofFreedom.ID) == 0
                        and AuraIsValid(membersAll[i].Unit, true, "BlessingofFreedom")
                        and Unit(membersAll[i].Unit):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 then
                            HealingEngine.SetTarget(membersAll[i].Unit, 0.5)
                        end
                    end
                end
                
                -- BoP (member sweep)
                if A.BlessingofProtection:IsReady() and A.GetToggle(2, "DispelSniper") then
                    for i = 1, #membersAll do
                        local U = Unit(membersAll[i].Unit)
                        if A.BlessingofProtection:IsInRange(membersAll[i].Unit)
                        and not U:IsDead()
                        and U:HasBuffs(A.BlessingofProtection.ID) == 0
                        and U:HasDeBuffs(A.Forbearance.ID) == 0
                        and AuraIsValid(membersAll[i].Unit, true, "BlessingofProtection")
                        and not U:Role("TANK")
                        and U:HasDeBuffs(A.Cyclone.ID, nil, true) == 0 then
                            HealingEngine.SetTarget(membersAll[i].Unit, 0.5)
                        end
                    end
                end
                
                -- BoSac (member sweep)
                if A.BlessingofSacrifice:IsReadyByPassCastGCD() and A.GetToggle(2, "DispelSniper") then
                    for i = 1, #membersAll do
                        local U = Unit(membersAll[i].Unit)
                        if A.BlessingofSacrifice:IsInRange(membersAll[i].Unit)
                        and not U:IsDead()
                        and U:HasBuffs(A.BlessingofSacrifice.ID) == 0
                        and U:HasBuffs("TotalImun") == 0
                        and AuraIsValid(membersAll[i].Unit, true, "BlessingofSacrifice")
                        and not UnitIsUnit(membersAll[i].Unit, player)
                        and U:HasDeBuffs(A.Cyclone.ID, nil, true) == 0 then
                            HealingEngine.SetTarget(membersAll[i].Unit, 0.5)
                        end
                    end
                end
            end
            
            -- TWW S3 Mouseover Dispel
            if A.Cleanse:IsReady(mouseover) and A.MouseHasFrame()
            and (Unit(mouseover):HasDeBuffs(473713) > 0 or Unit(mouseover):HasDeBuffs(461487) > 0 or Unit(mouseover):HasDeBuffs(1240097) > 0)
            and combatTime > 0 then
                return A.Cleanse:Show(icon)
            end
            
            if A.BlessingofFreedom:IsReady(mouseover) and A.MouseHasFrame()
            and CanUseFreedomNow()
            and not IsCastingSpell("target", 432117)
            and Unit(mouseover):HasDeBuffs(432031) > 0
            and combatTime > 0 then
                return A.BlessingofFreedom:Show(icon)
            end
            
            -- #1 HPvE Dispel
            if A.Cleanse:IsReady(unitID) 
            and ((Unit(unitID):HasDeBuffs(1240097) == 0 or Unit(unitID):HasDeBuffs(1240097) < 20)
                and (Unit(unitID):HasDeBuffs(461487) == 0 or Unit(unitID):HasDeBuffs(461487) < 6)
                and (Unit(unitID):HasDeBuffs(473713) == 0 or Unit(unitID):HasDeBuffs(473713) < 9))
            and (((A.Zone ~= "arena" or not (A.InstanceInfo and A.InstanceInfo.isRated))) or ((A.Zone == "arena" or (A.InstanceInfo and A.InstanceInfo.isRated))))
            and useDispel and Unit(unitID):HasDeBuffs(342938) == 0
            and ((Unit("mouseover"):IsExists() and A.MouseHasFrame() and not IsUnitEnemy("mouseover") and AuraIsValid(mouseover, "UseDispel", "Dispel"))
                or ((not A.GetToggle(2, "mouseover") or not Unit("mouseover"):IsExists() or IsUnitEnemy("mouseover"))
                    and not IsUnitEnemy(unitID) and A.GetToggle(2, "DispelSniper") and AuraIsValid(unitID, "UseDispel", "Dispel"))) then
                return A.Cleanse:Show(icon)
            end        
            
            -- #2 HPvE BoF (with Arak/Cosmic gate)
            if A.BlessingofFreedom:IsReady(unitID)
            and CanUseFreedomNow()
            and not IsCastingSpell("target", 432117)
            and Unit(unitID):HasBuffs(A.BlessingofFreedom.ID) == 0
            and useUtils
            and ((Unit("mouseover"):IsExists() and A.MouseHasFrame() and not IsUnitEnemy("mouseover") and AuraIsValid(mouseover, true, "BlessingofFreedom"))
                or ((not A.GetToggle(2, "mouseover") or not Unit("mouseover"):IsExists() or IsUnitEnemy("mouseover"))
                    and not IsUnitEnemy(unitID) and A.GetToggle(2, "DispelSniper") and AuraIsValid(unitID, true, "BlessingofFreedom"))) then
                return A.BlessingofFreedom:Show(icon)
            end        
            
            -- #3 HPvE BoP
            if A.BlessingofProtection:IsReady(unitID)
            and Unit(unitID):HasBuffs(A.BlessingofProtection.ID) == 0
            and Unit(unitID):HasDeBuffs(A.Forbearance.ID) == 0
            and not Unit(unitID):IsPet() and not Unit(unitID):Role("TANK")
            and useShields and not Unit(unitID):IsDead()
            and ((Unit("mouseover"):IsExists() and A.MouseHasFrame() and not IsUnitEnemy("mouseover") and AuraIsValid(mouseover, true, "BlessingofProtection"))
                or ((not A.GetToggle(2, "mouseover") or not Unit("mouseover"):IsExists() or IsUnitEnemy("mouseover"))
                    and not IsUnitEnemy(unitID) and A.GetToggle(2, "DispelSniper") and AuraIsValid(unitID, true, "BlessingofProtection"))) then
                return A.BlessingofProtection:Show(icon)
            end     
            
            -- #4 HPvE BoS
            if A.BlessingofSacrifice:IsReadyByPassCastGCD(unitID)
            and Unit(unitID):HasBuffs(A.BlessingofSacrifice.ID) == 0
            and not UnitIsUnit(unitID, player)
            and Unit(unitID):HasBuffs("TotalImun") == 0
            and not Unit(unitID):IsPet() and not Unit(unitID):Role("TANK")
            and not Unit(unitID):IsDead()
            and ((Unit("mouseover"):IsExists() and A.MouseHasFrame() and not IsUnitEnemy("mouseover") and AuraIsValid(mouseover, true, "BlessingofSacrifice"))
                or ((not A.GetToggle(2, "mouseover") or not Unit("mouseover"):IsExists() or IsUnitEnemy("mouseover"))
                    and not IsUnitEnemy(unitID) and A.GetToggle(2, "DispelSniper") and AuraIsValid(unitID, true, "BlessingofSacrifice"))) then
                return A.BlessingofSacrifice:Show(icon)
            end     
        end
        
        -- Spend HP
        if Player:HolyPower() == 5 and A.LightofDawn:IsReady()
        and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0
        and not Unit(unitID):IsDead()
        and TeamCacheFriendlyType == "raid"
        and HealingEngine.GetBelowHealthPercentUnits(LightofDawnHP, 40) >= LightofDawnUnits
        and HealingEngine.GetBelowHealthPercentUnits(ForceWoGHP, 40) == 0 then
            return A.LightofDawn:Show(icon)
        end
        
        if not A.EternalFlame:IsTalentLearned()
        and Player:HolyPower() == 5 and A.WordofGlory:IsReady(unitID)
        and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0
        and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0
        and not Unit(unitID):IsDead()
        and (Unit(unitID):HealthPercent() < WordofGloryHP or Unit(unitID):GetTotalHealAbsorbsPercent() > 100 - WordofGloryHP) then
            return A.WordofGlory:Show(icon)
        end
        
        if A.EternalFlame:IsTalentLearned()
        and Player:HolyPower() == 5 and A.WordofGlory:IsReady(unitID)
        and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0
        and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0
        and not Unit(unitID):IsDead()
        and (Unit(unitID):HealthPercent() < WordofGloryHP or Unit(unitID):GetTotalHealAbsorbsPercent() > 100 - WordofGloryHP) then
            return A.EternalFlame:Show(icon)
        end
        
        --Infusion Flash of Light with BoV
        if A.FlashofLight:IsReady(unitID)
        and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0
        and Unit(player):HasBuffs(A.InfusionofLightBuff.ID) > 0
        and Unit(player):HasBuffs(A.BeaconofVirtue.ID) > 0
        and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0
        and not Unit(unitID):IsDead()
        and (Unit(unitID):HealthPercent() < HolyPrismHP or Unit(unitID):GetTotalHealAbsorbsPercent() > 100 - HolyPrismHP) then
            return A.FlashofLight:Show(icon)
        end       
        
        -- Avenging Crusader DPS Spells
        if inCombat and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and A.AvengingCrusader:IsTalentLearned()
        and Unit(player):HasBuffs(A.AvengingCrusader.ID) > 0
        and A.CrusaderStrike:IsReady(target)
        and A.CrusaderStrike:IsInRange(target) and IsUnitEnemy(target)
        and Unit(target):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 
        and not Unit(target):IsDead() then
            return A.CrusaderStrike:Show(icon)        
        end
        
        if inCombat and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and A.AvengingCrusader:IsTalentLearned()
        and Unit(player):HasBuffs(A.AvengingCrusader.ID) > 0
        and Unit(target):CombatTime() > 0
        and A.Judgment:IsReady(target)
        and IsUnitEnemy(target)
        and Unit(target):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 
        and not Unit(target):IsDead() then
            return A.Judgment:Show(icon)        
        end
        
        if A.HolyPrism:IsReady(unitID)
        and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0
        and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0
        and not Unit(unitID):IsDead()
        and (Unit(unitID):HealthPercent() < HolyPrismHP or Unit(unitID):GetTotalHealAbsorbsPercent() > 100 - HolyPrismHP) then
            return A.HolyPrism:Show(icon)
        end       
        
        --Holy Shock
        if A.HolyShock:IsReady(unitID)
        and CanHeal(unitID)
        and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0
        and (Unit(unitID):HealthPercent() < HolyShockHP or Unit(unitID):GetTotalHealAbsorbsPercent() > 100 - HolyShockHP) then
            return A.HolyShock:Show(icon)
        end
        
        --Raid Infusion Judgment
        if TeamCacheFriendlyType == "raid" and A.Judgment:IsReady(target)
        and Unit(target):CombatTime() > 0 and combatTime > 0
        and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0
        and IsUnitEnemy(target)
        and Unit(target):HasDeBuffs(A.Cyclone.ID, nil, true) == 0
        and ((Unit(player):HasBuffs(A.AwakeningBuff.ID) == 0 and Unit(player):HasBuffs(A.InfusionofLightBuff.ID) > 0)
            or (Unit(player):HasBuffs(A.AwakeningBuff.ID) <= 5
                or (Unit(player):HasBuffs(A.AwakeningBuff.ID) > 5 and HealingEngine.GetBelowHealthPercentUnits(80, 40) >= 4))) then
            return A.Judgment:Show(icon)
        end
        
        --Infusion Flash of Light without BoV
        if A.FlashofLight:IsReady(unitID)
        and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0
        and Unit(player):HasBuffs(A.InfusionofLightBuff.ID) > 0
        and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0
        and not Unit(unitID):IsDead()
        and (Unit(unitID):HealthPercent() < HolyPrismHP or Unit(unitID):GetTotalHealAbsorbsPercent() > 100 - HolyPrismHP) then
            return A.FlashofLight:Show(icon)
        end      
        
        --Barrier of Faith
        if A.BarrierOfFaith:IsReady(unitID)
        and CanHeal(unitID)
        and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0
        and (Unit(unitID):HealthPercent() < WordofGloryHP or Unit(unitID):GetTotalHealAbsorbsPercent() > 100 - WordofGloryHP) then
            return A.BarrierOfFaith:Show(icon)
        end
        
        --Light of Dawn >= 3 HP
        if A.LightofDawn:IsReady()
        and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0
        and not Unit(unitID):IsDead()
        and TeamCacheFriendlyType == "raid"
        and HealingEngine.GetBelowHealthPercentUnits(LightofDawnHP, 40) >= LightofDawnUnits
        and HealingEngine.GetBelowHealthPercentUnits(ForceWoGHP, 40) == 0 then
            return A.LightofDawn:Show(icon)
        end
        
        --Word of Glory >= 3 HP
        if not A.EternalFlame:IsTalentLearned()
        and A.WordofGlory:IsReady(unitID)
        and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0
        and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0
        and not Unit(unitID):IsDead()
        and (Unit(unitID):HealthPercent() < WordofGloryHP or Unit(unitID):GetTotalHealAbsorbsPercent() > 100 - WordofGloryHP) then
            return A.WordofGlory:Show(icon)
        end
        
        if A.EternalFlame:IsTalentLearned()
        and A.WordofGlory:IsReady(unitID)
        and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0
        and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0
        and not Unit(unitID):IsDead()
        and (Unit(unitID):HealthPercent() < WordofGloryHP or Unit(unitID):GetTotalHealAbsorbsPercent() > 100 - WordofGloryHP) then
            return A.EternalFlame:Show(icon)
        end
        
        -- Seasons (throttled)
        if inCombat and GetTime() >= nextSeasons then
            nextSeasons = GetTime() + 0.15
            local s = BlessingofSeasons(unitID, membersAll)
            if s then return s:Show(icon) end
        end
        
        -- DPS fillers
        if Unit(target):HasDeBuffs("BreakAble") == 0 and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 then
            if (Player:ManaPercentage() > GetToggle(2, "ManaConservation") or Unit(player):HasBuffs(A.AvengingCrusader.ID) > 0)
            and A.CrusaderStrike:IsReady(target)
            and A.CrusaderStrike:IsInRange(target)
            and IsUnitEnemy(target)
            and Unit(target):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 
            and not Unit(target):IsDead()
            and (Unit(player):HasBuffs(A.AvengingCrusader.ID) > 0
                or ((A.CrusadersMight:IsTalentLearned()
                        and ((Player:HolyPower() < 5 and A.HolyShock:GetCooldown() >= 2 and A.HolyShock:GetSpellChargesFrac() <= 1.6)
                            or (Player:ManaPercentage() > 80 and Player:HolyPower() < 5 and HealingEngine.GetBelowHealthPercentUnits(90, 40) == 0)))
                    or (not A.CrusadersMight:IsTalentLearned() and Player:HolyPower() < 5 and Player:ManaPercentage() > GetToggle(2, "ManaConservation")))) then
                return A.CrusaderStrike:Show(icon)
            end
            
            if A.Judgment:IsReady(target)
            and IsUnitEnemy(target)
            and Unit(target):HasDeBuffs(A.Cyclone.ID, nil, true) == 0
            and (Unit(target):CombatTime() > 0 or A.Zone == "arena" or (A.InstanceInfo and A.InstanceInfo.isRated) or A.Zone == "pvp")
            and ((not IsInGroup() or not IsInRaid()) or ((IsInGroup() or IsInRaid())
                    and (Unit(player):HasBuffs(A.AwakeningBuff.ID) == 0
                        or (Unit(player):HasBuffs(A.AwakeningBuff.ID) <= 5
                            or (Unit(player):HasBuffs(A.AwakeningBuff.ID) > 5 and HealingEngine.GetBelowHealthPercentUnits(80, 40) >= 4)
                            and Unit(player):HasBuffs(A.AvengingWrath.ID) == 0))))
            and (Unit(player):HasBuffs(A.AvengingCrusader.ID) > 0
                or (not A.JudgmentofLight:IsTalentLearned()
                    or (A.JudgmentofLight:IsTalentLearned() and Unit(target):HasDeBuffs(196941, true) == 0)))
            and not Unit(target):IsDead() then
                return A.Judgment:Show(icon)
            end
        end
        
        if A.ArcaneTorrent:IsReady(player) and not Unit(player):IsDead() and Player:HolyPower() == 2 and combatTime > 0 then
            return A.ArcaneTorrent:Show(icon)
        end
        
        if TeamCacheFriendlyType ~= "raid" and A.HolyShock:IsReady(unitID)
        and not Unit(unitID):IsDead()
        and Unit(unitID):HealthPercent() <= 90
        and (HealingEngine.GetBelowHealthPercentUnits(90, 40) == 1 and Player:ManaPercentage() >= 50 and Player:HolyPower() < 5)
        and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 then
            return A.HolyShock:Show(icon)
        end
        
        if not A.EternalFlame:IsTalentLearned() and A.WordofGlory:IsReady(unitID)
        and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() <= 90 and combatTime == 0 then
            return A.WordofGlory:Show(icon)
        end
        
        if A.EternalFlame:IsTalentLearned() and A.WordofGlory:IsReady(unitID)
        and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() <= 90 and combatTime == 0 then
            return A.EternalFlame:Show(icon)
        end
        
        if A.Zone == "arena" or (A.InstanceInfo and A.InstanceInfo.isRated) or A.Zone == "pvp" or inCombat then
            
            if (Unit(target):HasDeBuffs(376449) > 0
                or (MultiUnits:GetByRangeInCombat(5) >= 1 and ((A.HolyShock:GetCooldown() >= 2.5 and A.CrusaderStrike:GetCooldown() > 1.5) or Player:HolyPower() == 5))
                or ((MultiUnits:GetByRangeInCombat(5) >= 4 or (MultiUnits:GetByRangeInCombat(5) >= 1  and Unit(player):HasBuffs(A.SacredWeaponBuff.ID) > 0)) and Player:HolyPower() >= 3)
            or TeamCacheFriendlyType == "none") 
            and A.ShieldoftheRighteous:IsReady(player)
            and A.CrusaderStrike:IsInRange(target) and IsUnitEnemy(target)
            and Unit(target):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 
            and (HealingEngine.GetBelowHealthPercentUnits(85, 40) < 1 or (HealingEngine.GetBelowHealthPercentUnits(50, 40) < 1 and TeamCache.Friendly.Size <= 2)) then
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
        
        if not inCombat or inCombat and not A.HolyShock:IsReady() and not A.WordofGlory:IsReady() then 
            -- Flash of Light (Infusion)
            if A.FlashofLight:IsReady(unitID) 
            and Unit(player):HasDeBuffs(A.Mindgames.ID) < Player:Execute_Time(A.FlashofLight.ID) 
            and not A.WordofGlory:IsReady(unitID) 
            and Player:Execute_Time(A.FlashofLight.ID) - A.HolyShock:GetCooldown() <= Player:Execute_Time(A.FlashofLight.ID)/2 
            and Unit(unitID):HealthPercent() <= A.GetToggle(2, "FlashofLightHP") 
            and Unit(player):HasBuffs(A.DivineFavor.ID, true) == 0 
            and not Unit(unitID):IsDead() 
            and Unit(player):HasBuffs(A.InfusionofLightBuff.ID, true) > Player:Execute_Time(A.FlashofLight.ID) 
            and Unit(unitID):HealthPercent() < WordofGloryHP
            and Unit(unitID):TimeToDie() > Player:Execute_Time(A.FlashofLight.ID) 
            and Unit(unitID):TimeToDie() < 8 
            and Unit(player):GetCurrentSpeed() == 0 then
                return A.FlashofLight:Show(icon)
            end
            
            -- Holy Light (Infusion)
            if not DoNotCastHL() 
            and A.HolyLight:IsReady(unitID) 
            and Unit(player):HasDeBuffs(A.Mindgames.ID) < Player:Execute_Time(A.HolyLight.ID) 
            and not A.WordofGlory:IsReady(unitID) 
            and Player:Execute_Time(A.HolyLight.ID) - A.HolyShock:GetCooldown() <= Player:Execute_Time(A.HolyLight.ID)/2 
            and Unit(player):HasBuffs(A.DivineFavor.ID, true) == 0 
            and not Unit(unitID):IsDead() 
            and Unit(player):HasBuffs(A.InfusionofLightBuff.ID, true) > Player:Execute_Time(A.HolyLight.ID) 
            and Unit(unitID):HealthPercent() < HolyLightHP 
            and Unit(player):GetCurrentSpeed() == 0 then
                return A.HolyLight:Show(icon)
            end    
            
            -- Flash of Light (no Infusion)
            if not DoNotCastFOL() 
            and Player:ManaPercentage() > GetToggle(2, "ManaConservation") 
            and A.FlashofLight:IsReady(unitID) 
            and Unit(player):HasDeBuffs(A.Mindgames.ID) < Player:Execute_Time(A.FlashofLight.ID) 
            and not A.WordofGlory:IsReady(unitID) 
            and Player:Execute_Time(A.FlashofLight.ID) - A.HolyShock:GetCooldown() <= Player:Execute_Time(A.FlashofLight.ID)/2 
            and Unit(unitID):HealthPercent() <= A.GetToggle(2, "FlashofLightHP") 
            and Unit(player):HasBuffs(A.DivineFavor.ID, true) == 0 
            and not Unit(unitID):IsDead() 
            and Unit(unitID):TimeToDie() > Player:Execute_Time(A.FlashofLight.ID) 
            and Unit(unitID):TimeToDie() < 8 
            and Unit(player):GetCurrentSpeed() == 0 then
                return A.FlashofLight:Show(icon)
            end
            
            -- Holy Light (no Infusion)
            if not DoNotCastHL() 
            and Player:ManaPercentage() > GetToggle(2, "ManaConservation") 
            and A.HolyLight:IsReady(unitID) 
            and Unit(player):HasDeBuffs(A.Mindgames.ID) < Player:Execute_Time(A.HolyLight.ID) 
            and not A.WordofGlory:IsReady(unitID) 
            and Player:Execute_Time(A.HolyLight.ID) - A.HolyShock:GetCooldown() <= Player:Execute_Time(A.HolyLight.ID)/2 
            and Unit(player):HasBuffs(A.DivineFavor.ID, true) == 0 
            and not Unit(unitID):IsDead() 
            and Unit(unitID):HealthPercent() < HolyLightHP 
            and Unit(player):GetCurrentSpeed() == 0 then
                return A.HolyLight:Show(icon)
            end    
        end
    end
    FillerRotation = Action.MakeFunctionCachedDynamic(FillerRotation)
    
    
    --------------------
    --- DPS ROTATION ---
    --------------------
    local function DamageRotation(unitID)
        if A.Zone == "arena" or (A.InstanceInfo and A.InstanceInfo.isRated) or A.Zone == "pvp" or inCombat then
            local _,_,_,_,_,NPCID1 = Unit(unitID):InfoGUID()
            local useCC, useKick = Action.InterruptIsValid(unitID)
            
            if GetToggle(1, "AutoTarget") and Unit(player):CombatTime() > 0 and MultiUnits:GetByRangeInCombat(15) >= 1 and not Unit(target):IsExplosives() and not Unit(target):IsCondemnedDemon() and (not Unit(target):IsExists() or IsUnitFriendly(target) or Unit(target):IsEnemy()) then 
                if A.IsExplosivesExists() or A.IsCondemnedDemonsExists() then
                    return A:Show(icon, ACTION_CONST_AUTOTARGET)                               
                end 
                
                if  (not Unit(target):IsExists() or IsUnitFriendly(target) or (A.Zone ~= "none" and not A.IsInPvP and not Unit(target):IsCracklingShard() and Unit(target):CombatTime() == 0 and Unit(target):IsEnemy() and Unit(target):HealthPercent() >= 100))              
                and ((not A.IsInPvP and MultiUnits:GetByRangeInCombat(15) >= 1) or A.Zone == "pvp")                                                                                                                                 then 
                    return A:Show(icon, ACTION_CONST_AUTOTARGET)
                end 
            end    
            
            if useCC and not HoldFreedom() and not CTT_ShouldAvoidStun(unitID) and Unit(unitID):HasDeBuffs({"Silenced", "Stuned", "Sleep", "Fear", "Disoriented", "Incapacitated"}) == 0 and Unit(unitID):IsControlAble("stun") and Unit(unitID):HasBuffs(A.Sanguine.ID) == 0 and A.HammerofJustice:IsReady(unitID) and Unit(unitID):GetDR("stun") > 0 and A.HammerofJustice:IsInRange(unitID) and A.HammerofJustice:AbsentImun(unitID, Temp.TotalAndPhysAndCC) and not Unit(unitID):IsBoss() and not Unit(unitID):IsDead() and Unit(unitID):IsCasting()
            then 
                return A.HammerofJustice:Show(icon)       
            end           
            
            if (Unit(unitID):HasDeBuffs("BreakAble") == 0 and (A.Zone == "arena" or (A.InstanceInfo and A.InstanceInfo.isRated))) or (not (A.Zone == "arena" or (A.InstanceInfo and A.InstanceInfo.isRated)) and ((inCombat and Unit(target):CombatTime() > 0) or TeamCacheFriendlySize == 1)) then
                if MultiUnits:GetByRangeInCombat(30) >= 4 and Player:HolyPower() <= 1 and A.GetToggle(2, "OffensiveDT") and A.DivineToll:IsReady(unitID) and HealingEngine.GetBelowHealthPercentUnits(80, 40) <= 1 then
                    return A.HandofReckoning:Show(icon)
                end
                
                if A.HammerofWrath:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0
                and IsUnitEnemy(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 and not Unit(unitID):IsDead() then
                    return A.HammerofWrath:Show(icon)
                end     
                
                if A.Consecration:IsReady(player) and MultiUnits:GetByRange(5) >= 2 and Unit(unitID):HasDeBuffs(204242, true) <= 1 and A.CrusaderStrike:IsInRange(unitID) then
                    return A.Consecration:Show(icon)
                end
                
                if A.ShieldoftheRighteous:IsReady(player) and (MultiUnits:GetByRange(5) >= 4 or A.CrusaderStrike:GetCooldown() > 1.5) and Player:HolyPower() >= A.GetToggle(2, "DumpHP") and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and A.CrusaderStrike:IsInRange(unitID) and IsUnitEnemy(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 
                and (HealingEngine.GetBelowHealthPercentUnits(80, 40) < 1 or (HealingEngine.GetBelowHealthPercentUnits(50, 40) < 1 and TeamCache.Friendly.Size <= 2)) then
                    return A.ShieldoftheRighteous:Show(icon)
                end
                
                if A.HammerofWrath:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and A.HammerofWrath:IsInRange(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 then
                    return A.HammerofWrath:Show(icon)
                end
                
                if A.Judgment:IsReady(unitID) and Unit(player):HasBuffs(A.AwakeningBuff.ID) == 0 and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and A.Judgment:IsInRange(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 then
                    return A.Judgment:Show(icon)
                end
                
                if ((A.Zone == "pvp" or A.Zone == "arena" or (A.InstanceInfo and A.InstanceInfo.isRated)) or Player:ManaPercentage() > 30 or Unit(target):HasDeBuffs(376449) > 0) and A.HolyShock:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and GetToggle(2, "HolyShockDPS") and A.HolyShock:IsInRange(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 then
                    return A.HolyShockDMG:Show(icon)
                end
                
                if A.CrusaderStrike:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and A.CrusaderStrike:IsInRange(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID, nil, true) == 0 and
                ((A.CrusadersMight:IsTalentLearned() and Player:HolyPower() < 5 and A.HolyShock:GetCooldown() >= 2 and A.HolyShock:GetSpellChargesFrac() <= 1.6 and Player:ManaPercentage() > GetToggle(2, "ManaConservation")) 
                    or (not A.CrusadersMight:IsTalentLearned() and Player:HolyPower() < 5 and ((A.Zone == "pvp" or A.Zone == "arena" or (A.InstanceInfo and A.InstanceInfo.isRated)) or (Player:ManaPercentage() > GetToggle(2, "ManaConservation")))))
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
    
    if IsUnitFriendly(focus) then    
        unitID = focus
        if HealingRotation(unitID) then
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
    if IsUnitEnemy("mouseover") and (Unit("mouseover"):IsExplosives() or Unit("mouseover"):IsTotem()) then 
        return A:Show(icon, ACTION_CONST_LEFT)
    end
end 
A[7] = nil 
A[8] = nil

