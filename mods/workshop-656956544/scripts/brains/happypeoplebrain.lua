require "behaviours/wander"
require "behaviours/follow"
require "behaviours/faceentity"
require "behaviours/chaseandattack"
require "behaviours/runaway"
require "behaviours/doaction"
--require "behaviours/choptree"
require "behaviours/findlight"
require "behaviours/panic"
require "behaviours/chattynode"
require "behaviours/leash"


local SEE_PLAYER_DIST = 20
local SEE_FOOD_DIST = 5
--local MAX_WANDER_DIST = 20
local RUN_AWAY_DIST = 3
local STOP_RUN_AWAY_DIST = 5

local MIN_FOLLOW_DIST = 20
local TARGET_FOLLOW_DIST = 30
local MAX_FOLLOW_DIST = 50
local MAX_WANDER_DIST = 20

local LEASH_RETURN_DIST = 10
local LEASH_MAX_DIST = 30

local START_RUN_DIST = 10
local STOP_RUN_DIST = 15
local MAX_CHASE_TIME = 10
local MAX_CHASE_DIST = 30
local SEE_LIGHT_DIST = 20
local TRADE_DIST = 20
local SEE_TREE_DIST = 15
local SEE_TARGET_DIST = 30
local SEE_BURNING_HOME_DIST_SQ = 20*20

local COMFORT_LIGHT_LEVEL = 0.3

local KEEP_CHOPPING_DIST = 10

local STRINGS=
{
 DESCRIBE_NULL = "MISSING DESCRIPTION STRING",
    PRHP_TALK_FOLLOWWILSON = {"陛下。", "听从吩咐", "你是我的Master", "系从尊便!"},
    PRHP_TALK_FIND_LIGHT = {"啧。", "哦。", "我想嗮太阳啊", "王赋予了光明", "不错。", "我听说冰神在饥荒中很厉害。", "哦，是吗？"},
   PRHP_TALK_LOOKATWILSON = {"您是?", "您是外地来的？", "入乡随俗", "要来一场交易吗?"},
   PRHP_TALK_RUNAWAY_WILSON = {"该死!", "滚开!", "王八蛋!", "干他娘的."},
    PRHP_TALK_FIGHT = {"这很棘手!", "制服他!", "哼!", "王创造了我，让我干掉你。"},
   PRHP_TALK_RUN_FROM_SPIDER = {"可怕的东西!", "八脚的怪物!", "丑陋的灵魂!"},
   -- PRHP_TALK_HELP_CHOP_WOOD = {"KILL TREE!", "SMASH MEAN TREE!", "I PUNCH TREE!"},
  PRHP_TALK_ATTEMPT_TRADE = {"要来一场交易?", "你的货看起来不赖."},
   PRHP_TALK_PANIC = {"有趣啊!", "团结就是力量!", "聚在一起!!"},
   PRHP_TALK_PANICFIRE = {"好烫!", "啊!", "烧着了!"},
    PRHP_TALK_PANICHOUSEFIRE = {"我的家!", "嘤嘤嘤!", "啊啊啊! 火!", "救命!"},
 PRHP_TALK_PANICHAUNT = {"可怕的东西!", "啊啊啊啊!!", "有鬼啊！！"},
    PRHP_TALK_FIND_MEAT = {"我的货存不够了!", "有点意思!", "毕竟我们身兼数职!", "有货吗？"},
    PRHP_TALK_EAT_MEAT = {"这货成色不错", "有点意思!"},
    PRHP_TALK_GO_HOME = {"日出而作，日落而息。", "下班了。", "我想打麻将。", "我记得有家温泉很不错。"},
    PRHP_TALK_RESCUE = {"祝你一臂之力!", "呵呵!", "来吧!"},
}

local function ShouldRunAway(inst, target)
    return not inst.components.trader:IsTryingToTradeWithMe(target)
end

local function GetTraderFn(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local players = FindPlayersInRange(x, y, z, TRADE_DIST, true)
    for i, v in ipairs(players) do
        if inst.components.trader:IsTryingToTradeWithMe(v) then
            return v
        end
    end
end

local function KeepTraderFn(inst, target)
    return inst.components.trader:IsTryingToTradeWithMe(target)
end

--local function StartChoppingCondition(inst)
   -- local start_chop = inst.components.follower.leader and inst.components.follower.leader.sg and inst.components.follower.leader.sg:HasStateTag("chopping")
   -- local target = FindEntity(inst, SEE_TREE_DIST/3, function(item) 
   --     return item.prefab == "deciduoustree" and item.monster and item.components.workable and item.components.workable.action == ACTIONS.CHOP 
  --  end)
  --  if inst.tree_target ~= nil then target = inst.tree_target end
    
 --   return (start_chop or target ~= nil)
--end


--local function FindTreeToChopAction(inst)
  --  local target = FindEntity(inst, SEE_TREE_DIST, function(item) return item.components.workable and item.components.workable.action == ACTIONS.CHOP end)
  --  if target then
   --     local decid_monst_target = FindEntity(inst, SEE_TREE_DIST/3, function(item)
    --        return item.prefab == "deciduoustree" and item.monster and item.components.workable and item.components.workable.action == ACTIONS.CHOP 
    --    end)
    --    if decid_monst_target ~= nil then 
     --       target = decid_monst_target 
      --  end
      --  if inst.tree_target then 
      --      target = inst.tree_target
       --     inst.tree_target = nil 
       -- end
       -- return BufferedAction(inst, target, ACTIONS.CHOP)
   -- end
--end



local function FindFoodAction(inst)
    local target = nil

    if inst.sg:HasStateTag("busy") then
        return
    end
    
    if inst.components.inventory and inst.components.eater then
        target = inst.components.inventory:FindItem(function(item) return inst.components.eater:CanEat(item) end)
    end
    
    local time_since_eat = inst.components.eater:TimeSinceLastEating()
    local noveggie = time_since_eat and time_since_eat < TUNING.PIG_MIN_POOP_PERIOD*4
    
    if not target and (not time_since_eat or time_since_eat > TUNING.PIG_MIN_POOP_PERIOD*2) then
        target = FindEntity(inst, SEE_FOOD_DIST, function(item) 
                if item:GetTimeAlive() < 8 then return false end
                if item.prefab == "mandrake" then return false end
                if noveggie and item.components.edible and item.components.edible.foodtype ~= FOODTYPE.MEAT then
                    return false
                end
                if not item:IsOnValidGround() then
                    return false
                end
                return inst.components.eater:CanEat(item) 
            end)
    end
    if target then
        return BufferedAction(inst, target, ACTIONS.EAT)
    end

    if not target and (not time_since_eat or time_since_eat > TUNING.PIG_MIN_POOP_PERIOD*2) then
        target = FindEntity(inst, SEE_FOOD_DIST, function(item) 
                if not item.components.shelf then return false end
                if not item.components.shelf.itemonshelf or not item.components.shelf.cantakeitem then return false end
                if noveggie and item.components.shelf.itemonshelf.components.edible and item.components.shelf.itemonshelf.components.edible.foodtype ~= FOODTYPE.MEAT then
                    return false
                end
                if not item:IsOnValidGround() then
                    return false
                end
                return inst.components.eater:CanEat(item.components.shelf.itemonshelf) 
            end)
    end

    if target then
        return BufferedAction(inst, target, ACTIONS.TAKEITEM)
    end

end


local function HasValidHome(inst)
    local home = inst.components.homeseeker ~= nil and inst.components.homeseeker.home or nil
    return home ~= nil
        and home:IsValid()
        and not (home.components.burnable ~= nil and home.components.burnable:IsBurning())
        and not home:HasTag("burnt")
end

local function GoHomeAction(inst)
    if not inst.components.follower.leader and
        HasValidHome(inst) and
        not inst.components.combat.target then
            return BufferedAction(inst, inst.components.homeseeker.home, ACTIONS.GOHOME)
    end
end

local function GetLeader(inst)
    return inst.components.follower.leader 
end

local function GetHomePos(inst)
    return HasValidHome(inst) and inst.components.homeseeker:GetHomePos()
end

local function GetNoLeaderHomePos(inst)
    if GetLeader(inst) then
        return nil
    end
    return GetHomePos(inst)
end

local function GetFaceTargetFn(inst)
    return inst.components.follower.leader
end

local function KeepFaceTargetFn(inst, target)
    return inst.components.follower.leader == target
end

local function GetNearestLightPos(inst)
    local light = GetClosestInstWithTag("lightsource", inst, SEE_LIGHT_DIST)
    if light then
        return Vector3(light.Transform:GetWorldPosition())
    end
    return nil
end

local function GetNearestLightRadius(inst)
    local light = GetClosestInstWithTag("lightsource", inst, SEE_LIGHT_DIST)
    if light then
        return light.Light:GetCalculatedRadius()
    end
    return 1
end

local function RescueLeaderAction(inst)
    return BufferedAction(inst, GetLeader(inst), ACTIONS.UNPIN)
end

local function SafeLightDist(inst, target)
    return (target:HasTag("player") or target:HasTag("playerlight")
            or (target.inventoryitem and target.inventoryitem:GetGrandOwner() and target.inventoryitem:GetGrandOwner():HasTag("player")))
        and 4
        or target.Light:GetCalculatedRadius() / 3
end

local function IsHomeOnFire(inst)
    return inst.components.homeseeker
        and inst.components.homeseeker.home
        and inst.components.homeseeker.home.components.burnable
        and inst.components.homeseeker.home.components.burnable:IsBurning()
        and inst:GetDistanceSqToInst(inst.components.homeseeker.home) < SEE_BURNING_HOME_DIST_SQ
end





local happypeoplebrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

---------------------------------------------------------------------------

----	吃食物时
local function EatFoodAction(inst)
    --if (inst.components.combat.target) then return end
    local target = nil
    if inst.components.inventory and inst.components.eater then
        target = inst.components.inventory:FindItem(function(item) return inst.components.eater:CanEat(item) end)
    end
    if not target then
        target = FindEntity(inst, 30, function(item) return inst.components.eater:CanEat(item) end)
    end
    if target then
        local act = BufferedAction(inst, target, ACTIONS.EAT)
        act.validfn = function() return not (target.components.inventoryitem and target.components.inventoryitem.owner and target.components.inventoryitem.owner ~= inst) end
        return act
    end
end
---------------------------------------------------------------------------
--function Zg_ch_wilsonbrain:CanSpawnChild(inst)   
--    local num = inst.NumPerdsToSpawn(inst)
   -- return num > 0 and self.inst.components.combat.target
--end

function happypeoplebrain:OnStart()
    local root = PriorityNode(
    {	
		----	主动召唤
--		MinPeriod(self.inst, 30, true,
	--		IfNode(function() return self:CanSpawnChild(self.inst) end, "needs follower", 
			--	ActionNode(function() self.inst.sg:GoToState("summon_perd") return SUCCESS end, "Summon Perd" ))),
	
		----	进攻
		ChaseAndAttack(self.inst, 40, 40) ,      
		
		----	吃食物
        DoAction(self.inst, EatFoodAction, "Eat Food"),
		
		----	徘徊
        Wander(self.inst),
		
    }, .1)




     local day = WhileNode( function() return TheWorld.state.isday end, "IsDay",
        PriorityNode{
            ChattyNode(self.inst, STRINGS.PRHP_TALK_FIND_MEAT,
                DoAction(self.inst, FindFoodAction )),
        --    IfNode(function() return StartChoppingCondition(self.inst) end, "chop", 
             --   WhileNode(function() return KeepChoppingAction(self.inst) end, "keep chopping",
                   -- LoopNode{ 
                    --    ChattyNode(self.inst, STRINGS.PIG_TALK_HELP_CHOP_WOOD,
                    --        DoAction(self.inst, FindTreeToChopAction ))})),
            ChattyNode(self.inst, STRINGS.PRHP_TALK_FOLLOWWILSON, 
                Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST)),
            IfNode(function() return GetLeader(self.inst) end, "has leader",
                ChattyNode(self.inst, STRINGS.PRHP_TALK_FOLLOWWILSON,
                    FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn ))),

            Leash(self.inst, GetNoLeaderHomePos, LEASH_MAX_DIST, LEASH_RETURN_DIST),

            ChattyNode(self.inst, STRINGS.PRHP_TALK_RUNAWAY_WILSON,
                RunAway(self.inst, "monster", START_RUN_DIST, STOP_RUN_DIST)),
            ChattyNode(self.inst, STRINGS.PRHP_TALK_LOOKATWILSON,
                FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn)),
            Wander(self.inst, GetNoLeaderHomePos, MAX_WANDER_DIST)
        },.5)
        
    
    local night = WhileNode( function() return not TheWorld.state.isday end, "IsNight",
        PriorityNode{
            ChattyNode(self.inst, STRINGS.PRHP_TALK_RUN_FROM_SPIDER,
                RunAway(self.inst, "spider", 4, 8)),
            ChattyNode(self.inst, STRINGS.PRHP_TALK_FIND_MEAT,
                DoAction(self.inst, FindFoodAction )),
            RunAway(self.inst, "monster", START_RUN_DIST, STOP_RUN_DIST, function(target) return ShouldRunAway(self.inst, target) end ),
            ChattyNode(self.inst, STRINGS.PRHP_TALK_GO_HOME,
                WhileNode( function() return not TheWorld.state.iscaveday or not self.inst.LightWatcher:IsInLight() end, "Cave nightness",
                    DoAction(self.inst, GoHomeAction, "go home", true ))),
            WhileNode(function() return TheWorld.state.isnight and self.inst.LightWatcher:GetLightValue() > COMFORT_LIGHT_LEVEL end, "IsInLight", -- wants slightly brighter light for this
                Wander(self.inst, GetNearestLightPos, GetNearestLightRadius, {
                    minwalktime = 0.6,
                    randwalktime = 0.2,
                    minwaittime = 5,
                    randwaittime = 5
                })
            ),
            ChattyNode(self.inst, STRINGS.PRHP_TALK_FIND_LIGHT,
                FindLight(self.inst, SEE_LIGHT_DIST, SafeLightDist)),
            ChattyNode(self.inst, STRINGS.PRHP_TALK_PANIC,
                Panic(self.inst)),
        },1)
    
    
    local root = 
        PriorityNode(
        {
            WhileNode( function() return self.inst.components.hauntable and self.inst.components.hauntable.panic end, "PanicHaunted", 
                ChattyNode(self.inst, STRINGS.PRHP_TALK_PANICHAUNT,
                    Panic(self.inst))),
            WhileNode(function() return self.inst.components.health.takingfiredamage end, "OnFire",
                ChattyNode(self.inst, STRINGS.PRHP_TALK_PANICFIRE,
                    Panic(self.inst))),
            ChattyNode(self.inst, STRINGS.PRHP_TALK_FIGHT,
                WhileNode( function() return self.inst.components.combat.target == nil or not self.inst.components.combat:InCooldown() end, "AttackMomentarily",
                    ChaseAndAttack(self.inst, MAX_CHASE_TIME, MAX_CHASE_DIST) )),
            ChattyNode(self.inst, STRINGS.PRHP_TALK_RESCUE,
                WhileNode( function() return GetLeader(self.inst) and GetLeader(self.inst).components.pinnable and GetLeader(self.inst).components.pinnable:IsStuck() end, "Leader Phlegmed",
                    DoAction(self.inst, RescueLeaderAction, "Rescue Leader", true) )),
            ChattyNode(self.inst, STRINGS.PRHP_TALK_FIGHT,
                WhileNode( function() return self.inst.components.combat.target and self.inst.components.combat:InCooldown() end, "Dodge",
                    RunAway(self.inst, function() return self.inst.components.combat.target end, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST) )),
            WhileNode(function() return IsHomeOnFire(self.inst) end, "OnFire",
                ChattyNode(self.inst, STRINGS.PRHP_TALK_PANICHOUSEFIRE,
                    Panic(self.inst))),
            RunAway(self.inst, function(guy) return guy:HasTag("kings") and guy.components.combat and guy.components.combat.target == self.inst end, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST ),
            ChattyNode(self.inst, STRINGS.PRHP_TALK_ATTEMPT_TRADE,
                FaceEntity(self.inst, GetTraderFn, KeepTraderFn)),            
            day,
            night
        }, .5)
    
    self.bt = BT(self.inst, root)

end

return happypeoplebrain