local TheNet = GLOBAL.TheNet

local function DayToSeconds(dayCount)
    return dayCount * GLOBAL.TUNING.TOTAL_DAY_TIME
end

local function GetWarningTimeInSec(timeConfig)
    if timeConfig > 0 then
        return DayToSeconds(timeConfig)
    else
        return timeConfig
    end
end

local function AnnounceForBoss(bossName, player)
	TheNet:Announce(bossName.." is coming for "..player:GetDisplayName().."!")
end

local function AnnounceForHounds()
    local name = "Hounds"
    if GLOBAL.TheWorld:HasTag("cave") then
        name = "Worms"
    end

	TheNet:Announce(name.." are coming!")
end

local function ShouldWarn(warningTimeConfig)
    local warningTime = GetWarningTimeInSec(GetModConfigData(warningTimeConfig))
    return warningTime >= 0
end

local isWarnedForHounds = false
local function AnnounceOnHoundsSpawn(self, warningTimeConfig)
    if ShouldWarn(warningTimeConfig) then
        local base_DoWarningSound = self.DoWarningSound
        self.DoWarningSound = function (self)

            if not isWarnedForHounds then
                isWarnedForHounds = true
                AnnounceForHounds()
            end
            base_DoWarningSound(self)
        end

        -- Reset warning state
        local base_OnUpdate = self.OnUpdate
        self.OnUpdate = function (self, dt)
            base_OnUpdate(self, dt)
            
            if not self.GetWarning() then
                isWarnedForHounds = false
            end
        end
    end
end

local function AnnounceOnBossSpawn(self, bossName, warningTimeConfig)
    if ShouldWarn(warningTimeConfig) then
        local base_DoWarningSound = self.DoWarningSound

        self.DoWarningSound = function (self, player)
            AnnounceForBoss(bossName, player)
            base_DoWarningSound(self, player)
        end
    end
end

local function ModInit(inst)
    inst:AddComponent("monsterwatcher")
    inst.components.monsterwatcher:SetDeerclopsWarningTime(GetWarningTimeInSec(GetModConfigData("OPTION_DEERCLOPS_WARNING")))
    inst.components.monsterwatcher:SetBeargerWarningTime(GetWarningTimeInSec(GetModConfigData("OPTION_BEARGER_WARNING")))
    inst.components.monsterwatcher:SetHoundsWarningTime(GetWarningTimeInSec(GetModConfigData("OPTION_HOUNDS_WARNING")))
end

-- Notify players for boss and hounds at default warning time.
AddComponentPostInit("deerclopsspawner", function (self, inst) AnnounceOnBossSpawn(self, "Deerclops", "OPTION_DEERCLOPS_WARNING") end)
AddComponentPostInit("beargerspawner", function (self, inst) AnnounceOnBossSpawn(self, "Bearger", "OPTION_BEARGER_WARNING") end)
AddComponentPostInit("hounded", function (self, inst) AnnounceOnHoundsSpawn(self, "OPTION_HOUNDS_WARNING") end)

-- For early announcements.
AddPrefabPostInit("cave", ModInit)
AddPrefabPostInit("world", ModInit)