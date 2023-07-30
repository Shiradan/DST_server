-- Import the engine.
modimport("engine.lua")

-- Imports to keep the keyhandler from working while typing in chat.
Load "chatinputscreen"
Load "consolescreen"
Load "textedit"

PrefabFiles = {
	"lancer",
	"lancer_none",
	"lancerpower_none",
	"lancerlootbag",
	"gaebolg",
	"gaebolg_projectile",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/lancer.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/lancer.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/lancer.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/lancer.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/lancer_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/lancer_silho.xml" ),

    Asset( "IMAGE", "bigportraits/lancer.tex" ),
    Asset( "ATLAS", "bigportraits/lancer.xml" ),
	
	Asset( "IMAGE", "images/map_icons/lancer.tex" ),
	Asset( "ATLAS", "images/map_icons/lancer.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_lancer.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_lancer.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_lancer.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_lancer.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_lancer.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_lancer.xml" ),
	
	Asset( "IMAGE", "images/names_lancer.tex" ),
    Asset( "ATLAS", "images/names_lancer.xml" ),
	
    Asset( "IMAGE", "bigportraits/lancer_none.tex" ),
    Asset( "ATLAS", "bigportraits/lancer_none.xml" ),
	
	Asset("ANIM", "anim/gaebolg_projectile.zip"),
	
    Asset("SOUNDPACKAGE", "sound/lancer.fev"),
	Asset("SOUND", "sound/lancer.fsb"),
}

RemapSoundEvent( "dontstarve/characters/lancer/death_voice", "lancer/sound/death_voice" )
RemapSoundEvent( "dontstarve/characters/lancer/hurt", "lancer/sound/hurt" )
RemapSoundEvent( "dontstarve/characters/lancer/talk_LP", "lancer/sound/talk_LP" )
RemapSoundEvent( "dontstarve/characters/lancer/yawn", "lancer/sound/yawn" )
RemapSoundEvent( "dontstarve/characters/lancer/emote", "lancer/sound/emote" )


local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

local TUNING = GLOBAL.TUNING

TUNING.HEALTHVALUE = GetModConfigData("healthvalue")
TUNING.HUNGERVALUE = GetModConfigData("hungervalue")

---Key Handler
-- GLOBAL.TUNING.LANCER = {}
-- GLOBAL.TUNING.LANCER.KEY = GetModConfigData("key") or 122

-- local function PowerFn(inst)
-- if inst:HasTag("playerghost") then return end
-- if inst.transformed then
-- inst.AnimState:SetBuild("lancer")
-- SpawnPrefab("wathgrithr_spirit").entity:AddFollower():FollowSymbol(inst.GUID, "swap_body", 0, 0, 0)

-- inst.components.talker:Say("I have to replenish my energy.", 2.5,true) 

 
-- else
-- inst.AnimState:SetBuild("lancerpower")local x, y, z = inst.Transform:GetWorldPosition()
-- SpawnPrefab("lavaarena_portal_player_fx").entity:AddFollower():FollowSymbol(inst.GUID, "swap_body", 0, 0, 0)

-- inst.components.talker:Say("I will strike you down.", 2.5,true) 


-- end
 
-- inst.transformed = not inst.transformed
 
-- return true
 
-- end
 
-- AddModRPCHandler("lancer", "POWER", PowerFn)
---Key handler End

--Spear Throwable(Thanks to Rezecib)--
local SMALL_MISS_CHANCE = GetModConfigData("SMALL_MISS_CHANCE")
local SMALL_USES = GetModConfigData("SMALL_USES")
local LARGE_USES = GetModConfigData("LARGE_USES")
local RANGE_CHECK = GetModConfigData("RANGE_CHECK")

local smallhits =
{
	frog = true,
	penguin = true,
	eyeplant = true,
}

local function gaebolgthrow_onattack(inst, attacker, target, skipsanity)
    local smalltarget = target:HasTag("smallcreature")
                and not target:HasTag("spider")
                and not smallhits[target.prefab]
    local missed = false
    local gaebolg = GLOBAL.SpawnSaveRecord(inst._gaebolg)
    gaebolg.Transform:SetPosition(inst:GetPosition():Get())
    if math.random() < SMALL_MISS_CHANCE and smalltarget then
        missed = true
        if attacker.components and attacker.components.talker then
            local miss_message = "...E-Rank Luck."
            if attacker.prefab == 'wx78' then miss_message = "INSUFFICIENT ACCURACY" end
            attacker.components.talker:Say(miss_message)
            target:PushEvent("attacked", {attacker = attacker, damage = 0, weapon = gaebolg})
        end
    else
        if target.components.combat then
            gaebolg.projectile = true
            target.components.combat:GetAttacked(attacker, attacker.components.combat:CalcDamage(target, gaebolg), gaebolg)
        end			
    end
    if gaebolg.components.finiteuses then
        gaebolg.components.finiteuses:Use((smalltarget and not missed)
            and GLOBAL.TUNING.GAEBOLG_USES/SMALL_USES
            or GLOBAL.TUNING.GAEBOLG_USES/LARGE_USES)
    end
    gaebolg:AddTag("scarytoprey")
    gaebolg:DoTaskInTime(1, function(inst) inst:RemoveTag("scarytoprey") end)
    inst:Remove()

    attacker.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon", nil, nil, true)
end

AddPrefabPostInit("gaebolg", function(inst)
	if not GLOBAL.TheWorld.ismastersim then return end
	inst:AddComponent('gaebolgthrowable')
	inst.components.gaebolgthrowable:SetRange(8, 10)
	inst.components.gaebolgthrowable:SetOnAttack(gaebolgthrow_onattack)
	inst.components.gaebolgthrowable:SetProjectile("gaebolg_projectile")
end)

local GAEBOLGTHROW = AddAction("GAEBOLGTHROW", "Throw Gaebolg", function(act)
	if act.invobject then
		local pvp = GLOBAL.TheNet:GetPVPEnabled()
		local target = act.target
		if target == nil then
			for k,v in pairs(GLOBAL.TheSim:FindEntities(act.pos.x, act.pos.y, act.pos.z, 20)) do
				if v.replica and v.replica.combat and v.replica.combat:CanBeAttacked(act.doer) and
				act.doer.replica and act.doer.replica.combat and act.doer.replica.combat:CanTarget(v)
				and (not v:HasTag("wall")) and (pvp or ((not pvp)
						and (not (act.doer:HasTag("player") and v:HasTag("player"))))) then
					target = v
					break
				end
			end
		end
		if target then
				local prefab = act.invobject.prefab
				act.invobject.components.gaebolgthrowable:LaunchProjectile(act.doer, target)
				local newgaebolg = act.doer.components.inventory:FindItem(
					function(item) return item.prefab == prefab end)
				if newgaebolg then
					act.doer.components.inventory:Equip(newgaebolg)
				end
		elseif act.doer.components and act.doer.components.talker then
			local fail_message = "E rank luck strikes again..."
			if act.doer.prefab == 'wx78' then fail_message = "NO TARGET" end
			act.doer.components.talker:Say(fail_message)
		end
		return true
	end
end)
GAEBOLGTHROW.priority = 4
GAEBOLGTHROW.rmb = true
GAEBOLGTHROW.distance = 10
GAEBOLGTHROW.mount_valid = true

local State = GLOBAL.State
local TimeEvent = GLOBAL.TimeEvent
local EventHandler = GLOBAL.EventHandler
local FRAMES = GLOBAL.FRAMES

local throw_gaebolg = State({
        name = "throw_gaebolg",
        tags = { "attack", "notalking", "abouttoattack", "autopredict" },

        onenter = function(inst)
            local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
			inst.components.combat:SetTarget(target)
			inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()

            inst.AnimState:PlayAnimation("throw")

            inst.sg:SetTimeout(2)

            if target ~= nil and target:IsValid() then
                inst:FacePoint(target.Transform:GetWorldPosition())
                inst.sg.statemem.attacktarget = target
			elseif buffaction ~= nil and buffaction.pos ~= nil then
                inst:FacePoint(buffaction.pos)
            end
        end,

        timeline =
        {
            TimeEvent(7 * FRAMES, function(inst)
                inst:PerformBufferedAction()
                inst.sg:RemoveStateTag("abouttoattack")
            end),
        },

        ontimeout = function(inst)
            inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle")
        end,

        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            inst.components.combat:SetTarget(nil)
            if inst.sg:HasStateTag("abouttoattack") then
                inst.components.combat:CancelAttack()
            end
        end,})
AddStategraphState("wilson", throw_gaebolg)

local throw_gaebolg_client = State({
        name = "throw_gaebolg",
        tags = { "attack", "notalking", "abouttoattack" },

        onenter = function(inst)
            local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
			inst.replica.combat:StartAttack()
            inst.components.locomotor:Stop()

            inst.AnimState:PlayAnimation("throw")

            inst.sg:SetTimeout(2)

            if target ~= nil and target:IsValid() then
                inst:FacePoint(target.Transform:GetWorldPosition())
                inst.sg.statemem.attacktarget = target
			elseif buffaction ~= nil and buffaction.pos ~= nil then
                inst:FacePoint(buffaction.pos)
            end
			if buffaction ~= nil then
				inst:PerformPreviewBufferedAction()
			end
        end,

        timeline =
        {
            TimeEvent(7 * FRAMES, function(inst)
                inst:ClearBufferedAction()
                inst.sg:RemoveStateTag("abouttoattack")
            end),
        },

        ontimeout = function(inst)
            inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle")
        end,

        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            if inst.sg:HasStateTag("abouttoattack") then
                inst.replica.combat:CancelAttack()
            end
        end,})
AddStategraphState("wilson_client", throw_gaebolg_client)

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GAEBOLGTHROW, function(inst, action)
	if not inst.sg:HasStateTag("attack") then
		return "throw_gaebolg"
	end
end))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GAEBOLGTHROW, function(inst, action)
	if not inst.sg:HasStateTag("attack") then
		return "throw_gaebolg"
	end
end))

local function gaebolgthrow_point(inst, doer, pos, actions, right)
	if right then
		local target = nil
		local pvp = GLOBAL.TheNet:GetPVPEnabled()
		if RANGE_CHECK then
			for k,v in pairs(GLOBAL.TheSim:FindEntities(pos.x, pos.y, pos.z, 2)) do
				if v.replica and v.replica.combat and v.replica.combat:CanBeAttacked(doer) and
				doer.replica and doer.replica.combat and doer.replica.combat:CanTarget(v)
				and (not v:HasTag("wall")) and (pvp or ((not pvp)
						and (not (doer:HasTag("player") and v:HasTag("player")))))
                and (doer.components.playercontroller:IsControlPressed(GLOBAL.CONTROL_FORCE_ATTACK)
                        or not doer.replica.combat:IsAlly(v)) then
					target = v
					break
				end
			end
		end
		if target then
			table.insert(actions, GLOBAL.ACTIONS.GAEBOLGTHROW)
		end
	end
end
AddComponentAction("POINT", "gaebolgthrowable", gaebolgthrow_point)

local function gaebolgthrow_target(inst, doer, target, actions, right)
	local pvp = GLOBAL.TheNet:GetPVPEnabled()
	if right and (not target:HasTag("wall"))
		and doer.replica.combat ~= nil
		and doer.replica.combat:CanTarget(target)
		and target.replica.combat:CanBeAttacked(doer)
		and (pvp or ((not pvp)
					and (not (doer:HasTag("player") and target:HasTag("player")))))
        and (doer.components.playercontroller:IsControlPressed(GLOBAL.CONTROL_FORCE_ATTACK)
                or not doer.replica.combat:IsAlly(target)) then
		table.insert(actions, GLOBAL.ACTIONS.GAEBOLGTHROW)
	end
end
AddComponentAction("EQUIPPED", "gaebolgthrowable", gaebolgthrow_target)
--End of Spear Throwable--

--Spear Lunge Animation--
local FRAMES = GLOBAL.FRAMES
local ACTIONS = GLOBAL.ACTIONS
local State = GLOBAL.State
local EventHandler = GLOBAL.EventHandler
local ActionHandler = GLOBAL.ActionHandler
local TimeEvent = GLOBAL.TimeEvent
local EQUIPSLOTS = GLOBAL.EQUIPSLOTS
local require = GLOBAL.require

TUNING.ENABLEGAEBOLGJAB = GetModConfigData("enablejab")

if TUNING.ENABLEGAEBOLGJAB == true then
local function DoMountSound(inst, mount, sound, ispredicted)
    if mount ~= nil and mount.sounds ~= nil then
        inst.SoundEmitter:PlaySound(mount.sounds[sound], nil, nil, ispredicted)
    end
end

local function DoMountSoundClient(inst, mount, sound)
    if mount ~= nil and mount.sounds ~= nil then
        inst.SoundEmitter:PlaySound(mount.sounds[sound], nil, nil, true)
    end
end
	local gaebolgjab = State({
        name = "gaebolgjab",
        tags = { "attack", "notalking", "abouttoattack", "autopredict" },

        onenter = function(inst)
            local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            local equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            inst.components.combat:SetTarget(target)
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()
            local cooldown = inst.components.combat.min_attack_period + .5 * FRAMES
            if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
                inst.AnimState:PlayAnimation("atk_pre")
                inst.AnimState:PushAnimation("atk", false)
                DoMountSound(inst, inst.components.rider:GetMount(), "angry", true)
                cooldown = math.max(cooldown, 16 * FRAMES)
            elseif equip ~= nil and equip:HasTag("gaebolg") then
                inst.AnimState:PlayAnimation("spearjab")
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
                cooldown = math.max(cooldown, 13 * FRAMES)
            end

            inst.sg:SetTimeout(cooldown)

            if target ~= nil then
                inst.components.combat:BattleCry()
                if target:IsValid() then
                    inst:FacePoint(target:GetPosition())
                    inst.sg.statemem.attacktarget = target
                end
            end
        end,

        timeline =
        {
            TimeEvent(8 * FRAMES, function(inst)
                    inst:PerformBufferedAction()
                    inst.sg:RemoveStateTag("abouttoattack")
            end)
        },

        ontimeout = function(inst)
            inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle")
        end,

        events =
        {
            EventHandler("equip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            inst.components.combat:SetTarget(nil)
            if inst.sg:HasStateTag("abouttoattack") then
                inst.components.combat:CancelAttack()
            end
        end,
    }
)

AddStategraphState("wilson", gaebolgjab)

local gaebolgjab_client = State({
	name = "gaebolgjab",
        tags = { "attack", "notalking", "abouttoattack" },

        onenter = function(inst)
            local cooldown = 0
            if inst.replica.combat ~= nil then
                inst.replica.combat:StartAttack()
                cooldown = inst.replica.combat:MinAttackPeriod() + .5 * FRAMES
            end
            inst.components.locomotor:Stop()
            local equip = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            local rider = inst.replica.rider
            if rider ~= nil and rider:IsRiding() then
                inst.AnimState:PlayAnimation("atk_pre")
                inst.AnimState:PushAnimation("atk", false)
                DoMountSoundClient(inst, rider:GetMount(), "angry")
                if cooldown > 0 then
                    cooldown = math.max(cooldown, 16 * FRAMES)
                end
            elseif equip ~= nil and equip:HasTag("gaebolg") then
                inst.AnimState:PlayAnimation("spearjab")
                if cooldown > 0 then
                    cooldown = math.max(cooldown, 13 * FRAMES)
                end
            end

            local buffaction = inst:GetBufferedAction()
            if buffaction ~= nil then
                inst:PerformPreviewBufferedAction()

                if buffaction.target ~= nil and buffaction.target:IsValid() then
                    inst:FacePoint(buffaction.target:GetPosition())
                    inst.sg.statemem.attacktarget = buffaction.target
                end
            end

            if cooldown > 0 then
                inst.sg:SetTimeout(cooldown)
            end
        end,

        timeline =
		{
            TimeEvent(8 * FRAMES, function(inst)
                    inst:ClearBufferedAction()
                    inst.sg:RemoveStateTag("abouttoattack")
			end)
        },

        ontimeout = function(inst)
            inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle")
        end,

        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            if inst.sg:HasStateTag("abouttoattack") and inst.replica.combat ~= nil then
                inst.replica.combat:CancelAttack()
            end
        end,
	}
)

AddStategraphState("wilson_client", gaebolgjab_client)

--------------------------------------------WILSON SG ACTIONHANDLER FOR ATTACK OVERRIDE---------------------------------------------------------------------------


local SGWils = require "stategraphs/SGwilson"
local OriginalDestStateATTACK

for k1, v1 in pairs(SGWils.actionhandlers) do
	if SGWils.actionhandlers[k1]["action"]["id"] == "ATTACK" then	
		OriginalDestStateATTACK = SGWils.actionhandlers[k1]["deststate"]
	end
end

local function NewDestStateATTACK(inst, action)
	inst.sg.mem.localchainattack = not action.forced or nil
	local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) or nil
	
	if weapon and weapon:HasTag("gaebolg") and not inst.components.health:IsDead() and not inst.sg:HasStateTag("attack") and inst.components.combat ~= nil then
			return (weapon:HasTag("gaebolg") and "gaebolgjab") 
	else
		return OriginalDestStateATTACK(inst, action)
	end
end

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.ATTACK, NewDestStateATTACK))
GLOBAL.package.loaded["stategraphs/SGwilson"] = nil 

--------------------------------------------WILSON_CLIENT SG ACTIONHANDLER FOR ATTACK OVERRIDE---------------------------------------------------------------------------

local SGWilsClient = require "stategraphs/SGwilson_client"
local OriginalClientDestStateATTACK

for k1, v1 in pairs(SGWilsClient.actionhandlers) do
	if SGWilsClient.actionhandlers[k1]["action"]["id"] == "ATTACK" then
		
		OriginalClientDestStateATTACK = SGWilsClient.actionhandlers[k1]["deststate"]
	end
end

local function NewClientDestStateATTACK(inst, action)
	local weapon = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) or nil
	if weapon and weapon:HasTag("gaebolg") and not inst.sg:HasStateTag("attack") and inst.replica.combat then
		if inst.replica.combat then
			return (weapon:HasTag("gaebolg") and "gaebolgjab") 
		end
	else
		return OriginalClientDestStateATTACK(inst, action)
	end
end

AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.ATTACK, NewClientDestStateATTACK))

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GLOBAL.package.loaded["stategraphs/SGwilson_client"] = nil 
	
local function MakeGaebolgTag(inst)
    inst:AddTag("gaebolg")
end
	
AddPrefabPostInit("gaebolg", MakeGaebolgTag)

else

end
--End of Spear Lunge animation--

--Fishing Pro--
AddComponentPostInit("fishingrod", function(FishingRod, inst)

   local function DoNibble(inst)
		local fishingrod = inst.components.fishingrod
		if fishingrod and fishingrod.fisherman then
			inst:PushEvent("fishingnibble")
			fishingrod.fisherman:PushEvent("fishingnibble")
			fishingrod.fishtask = nil
		end
	end
	
	function FishingRod:WaitForFish()
		if self.target and self.target.components.fishable then
			local fishleft = self.target.components.fishable:GetFishPercent()
			local nibbletime = nil
			if fishleft > 0 then
				nibbletime = self.minwaittime + (1.0 - fishleft)*(self.maxwaittime - self.minwaittime)
			end
			if fishleft > 0 and self.fisherman:HasTag("fishingpro") then
				nibbletime = self.minwaittime/2 + (1.0 - fishleft)*(self.maxwaittime/3 - self.minwaittime)
			end
			self:CancelFishTask()
			if nibbletime then
				self.fishtask = self.inst:DoTaskInTime(nibbletime, DoNibble)
			end
		end
	end
	
end)
--Ending Fishing Pro--

--Crit Chance
AddComponentPostInit("combat", function(Combat)-- place in modmain
	local OldCalcDamage = Combat.CalcDamage
	Combat.CalcDamage = function(self, target, weapon, ...)
		local old_damage = nil
		local crit = 0.10 --crit chance (e.g. this is 10%)
		local critdmg = 2 --crit damage (x2)
		if math.random() <= crit and target and self.inst.prefab == "lancer" then --change to your prefab
			if weapon then -- if its a weapon
				old_damage = weapon.components.weapon.damage
				weapon.components.weapon.damage = old_damage * critdmg
			else -- if we attack with something not using the weapon component
				old_damage = self.defaultdamage
				self.defaultdamage = old_damage * critdmg
			end
			-- visual effects and other stuff you can add
			-- local fx = SpawnPrefab("explode_small")
			-- local x, y, z = target.Transform:GetWorldPosition()
			-- fx.Transform:SetPosition(x, y, z)
		end
		local ret = OldCalcDamage(self, target, weapon, ...)-- returning crit damage
		if old_damage then-- reseting back to non crit damage
			if weapon then
				weapon.components.weapon.damage = old_damage
			else
				self.defaultdamage = old_damage
			end
		end
		return ret
	end
end)
--End Crit Chance

--Untouchable creatures
local untouchables = {
	chester = true,
	glommer = true,
	hutch = true,
}

AddComponentPostInit("playeractionpicker", function(self)
    local old = self.SortActionList
    function self:SortActionList(actions, target, useitem)
        if #actions == 0 then
            return actions
        end
        local c = 0
        for k, v in pairs(actions) do
            if v == GLOBAL.ACTIONS.ATTACK and
            self.inst.prefab == "lancer" and
            untouchables[target.prefab] then
                c = 1
                break
            end
        end
        if c == 1 then
            return {}
        else
            return old(self, actions, target, useitem)
        end
    end
end)
--Untouchable End

--Killing the weak is uncool
local innocents = {
    pigman = true,
	merm = true,
	rocky = true,
	bunnyman= true,
	little_walrus = true,
}

local rand_sayings =
{
  "That was pointless. Where was the fun in that?",
  "Not a satisfactory victory.",
  "What a dissapointment.",
  "A meaningless battle that was.",
  "My blade just dulled a little.",
}
 
AddPrefabPostInit("lancer", function(inst)
    if inst.components.combat == nil then
        return
    end
    inst.components.combat.onhitotherfn = function(attacker, target, damage)
        if innocents[target.prefab] and attacker.components.sanity then
            if target.components.health and target.components.health:IsDead() then
                attacker.components.sanity:DoDelta(-8)
				inst.components.talker:Say(rand_sayings[math.random(#rand_sayings)], 2.5,true) 
            end
        end
    end
end)
--Killing the weak is uncool end

-- The character select screen lines
STRINGS.CHARACTER_TITLES.lancer = "The Hound of Culann"
STRINGS.CHARACTER_NAMES.lancer = "Lancer"
STRINGS.CHARACTER_DESCRIPTIONS.lancer = "*Way of the spear\n*Restricted\n*Battle Continuation"
STRINGS.CHARACTER_QUOTES.lancer = "\"Don't worry about it. I'm used to this kind of thing.\""

-- Custom speech strings
STRINGS.CHARACTERS.LANCER = require "speech_lancer"

-- The character's name as appears in-game 
STRINGS.NAMES.LANCER = "Lancer"

AddMinimapAtlas("images/map_icons/lancer.xml")

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("lancer", "MALE")

