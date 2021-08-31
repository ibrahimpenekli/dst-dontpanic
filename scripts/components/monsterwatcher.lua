local function SecondsToDay(timeInSec)
    return timeInSec / TUNING.TOTAL_DAY_TIME
end

local function AnnounceForHounds()
	TheNet:Announce("Hounds will attack in a day!")
end

local function AnnounceForBoss(bossName)
	TheNet:Announce(bossName.." will attack in a day!")
end

local MonsterWatcher = Class(function(self, inst)
	self.warningTimeForDeerclops = -1
    self.warningTimeForBearger = -1
    self.warningTimeForHounds = -1
	self.isWarnedForBoss = false
	self.isWarnedForHounds = false
	self.tick = 0

	self.DEERCLOPS_TIMERNAME = "deerclops_timetoattack"
	self.BEARGER_TIMERNAME = "bearger_timetospawn"
	self.MAX_HOUNDS_ATTACK_DELAY = TUNING.TOTAL_DAY_TIME * 3

	inst:StartUpdatingComponent(self)
end)

function MonsterWatcher:GetDeerclopsWarningTime()
	return self.warningTimeForDeerclops
end

function MonsterWatcher:SetDeerclopsWarningTime(timeInSec)
	self.warningTimeForDeerclops = timeInSec
end

function MonsterWatcher:GetBeargerWarningTime()
	return self.warningTimeForBearger
end

function MonsterWatcher:SetBeargerWarningTime(timeInSec)
	self.warningTimeForBearger = timeInSec
end

function MonsterWatcher:GetHoundsWarningTime()
	return self.warningTimeForHounds
end

function MonsterWatcher:SetHoundsWarningTime(timeInSec)
	self.warningTimeForHounds = timeInSec
end

function MonsterWatcher:CheckForHounds()
	if self.warningTimeForHounds <= 0 then
		return
	end

	local hounded = TheWorld.components.hounded
	if not hounded then
		return
	end

	local timeToAttack = hounded:GetTimeToAttack()
	if timeToAttack and timeToAttack > 0 and timeToAttack < self.MAX_HOUNDS_ATTACK_DELAY then
		self:Debug("Hounds", timeToAttack)

		if not self.isWarnedForHounds then
			if timeToAttack <= self.warningTimeForHounds then
				self.isWarnedForHounds = true
				AnnounceForHounds()
			end
		end

		-- Reset last warning state.
		if timeToAttack > self.warningTimeForHounds then
			self.isWarnedForHounds = false
		end
	end
end

function MonsterWatcher:CheckForBoss(bossName, warningTime, timerName)
	if warningTime <= 0 then
		return
	end

	local worldTimer = TheWorld.components.worldsettingstimer
	if not worldTimer then
		return
	end

	local timeToAttack = worldTimer:GetTimeLeft(timerName)
	if timeToAttack and timeToAttack > 0 and timeToAttack <= warningTime then
		self:Debug(bossName, timeToAttack)

		if not self.isWarnedForBoss then
			if timeToAttack <= warningTime then
				self.isWarnedForBoss = true
				AnnounceForBoss(bossName)
			end
		end

		-- Reset last warning state.
		if timeToAttack > warningTime then
			self.isWarnedForBoss = false
		end
	end
end

local GetDebugString = function (monsterName, timeToAttack)
	return string.format("%s will attack after %d secs (%.1f days)", monsterName, timeToAttack, SecondsToDay(timeToAttack))
end

function MonsterWatcher:Debug(monsterName, timeToAttack)
	if self.tick % 250 == 0 then
		print(GetDebugString(monsterName, timeToAttack))
	end
end

function MonsterWatcher:OnUpdate(deltaTime)
	self:CheckForBoss("Deerclops", self.warningTimeForDeerclops, self.DEERCLOPS_TIMERNAME)
	self:CheckForBoss("Bearger", self.warningTimeForBearger, self.BEARGER_TIMERNAME)
	self:CheckForHounds()

	self.tick = self.tick + 1
end

return MonsterWatcher