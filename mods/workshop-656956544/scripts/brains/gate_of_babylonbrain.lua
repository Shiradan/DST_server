require "behaviours/standstill"
require "behaviours/chattynode"
require "behaviours/chaseandattack"
require "behaviours/follow"
require "behaviours/faceentity"
require "behaviours/wander"

local RUN_AWAY_DIST = 10
local STOP_RUN_AWAY_DIST = 10
local MAX_CHASE_TIME = 20
local MIN_FOLLOW_CLOSE = 2
local TARGET_FOLLOW_CLOSE = 10
local MAX_FOLLOW_CLOSE = 8
local MIN_FOLLOW = 2
local TARGET_FOLLOW = 15
local MAX_FOLLOW = 8
local MAX_WANDER_DIST = 0


local gate_of_babylonbrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local function CheckForClosely(inst)


       local 
              v = FindEntity(inst, 30, function(guy)
        return guy:HasTag("gilgamesh") 
    end)
              if v ~= nil then
              v.components.leader:AddFollower(inst)
              else return true
              end
		

end

local function ReadyForAttack(inst)
	return inst.components.combat.target and inst.components.combat:InCooldown()
end

local function CombatTarget(inst)
	return inst.components.combat.target
end

local function GetLeader(inst)
	return inst.components.follower and inst.components.follower.leader
end

local function GetFaceTargetFn(inst)
	return inst.components.follower.leader
end

local function KeepFaceTargetFn(inst, target)
	return inst.components.follower.leader == target
end

function gate_of_babylonbrain:OnStart()
	local root = PriorityNode({
		------------------------------------------------------
	--	StandStill(self.inst, StayHere, StayHere),
	--	IfNode(function() return BeeHasBeeBox(self.inst) end, "Bee Panic",
	--		Panic(self.inst)),
	--	WhileNode(function() return IsTakingFireDamage(self.inst) end, "On Fire",
	--		ChattyNode(self.inst, STRINGS.SUMMONASSASSIN_TALK_PANICFIRE, Panic(self.inst))),
	---------------------------------------------------------------------------------------
	--战斗冷却？似乎并不需要
		WhileNode(function() return ReadyForAttack(self.inst) end, "Dodge",
			RunAway(self.inst, function() return CombatTarget(self.inst) end, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST)),
	--------------------------------------------------------------------------------------------
		ChaseAndAttack(self.inst, MAX_CHASE_TIME),
	------------------------------------------------------------------------------------------------------	
		IfNode(function() return CheckForClosely(self.inst) end, "Follow Closely",
			Follow(self.inst, GetLeader, MIN_FOLLOW_CLOSE, TARGET_FOLLOW_CLOSE, MAX_FOLLOW_CLOSE, true)),
		IfNode(function() return not CheckForClosely(self.inst) end, "Follow from Distance",
			Follow(self.inst, GetLeader, MIN_FOLLOW, TARGET_FOLLOW, MAX_FOLLOW, true)),
	-----------------------------面对实体------------------------------------------
		FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn),

	--------------------徘徊-----------------------------------------------------------	
		
		Wander(self.inst),

	}, .1)

	self.bt = BT(self.inst, root)
end

return gate_of_babylonbrain