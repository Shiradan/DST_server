local _G = GLOBAL
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local SpawnPrefab = GLOBAL.SpawnPrefab


TUNING.wklimit = false
TUNING.crossedge = false

TUNING.DodgeKey = 114
TUNING.ChargeKey = 122
TUNING.IcicleKey = 99
TUNING.CheckKey = 106

modimport("scripts/okita_util/okita_util.lua")

PrefabFiles = {
	"okita",
	"okita_none",
	"okitasword",
	"okitasymbol",
	"lighterfire_shadow",
	"lighterfire_red",
	"lighterfire_blue",
	"lighterfire_green",
	"pred",
	"pgreen",
	"pblue",
	"pstar",
	"pphit",
	"dogfood",
	"santu",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/okita.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/okita.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/okita.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/okita.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/okita_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/okita_silho.xml" ),

    Asset( "IMAGE", "bigportraits/okita.tex" ),
    Asset( "ATLAS", "bigportraits/okita.xml" ),
	
	Asset( "IMAGE", "images/map_icons/okita.tex" ),
	Asset( "ATLAS", "images/map_icons/okita.xml" ),
	
	Asset( "IMAGE", "images/hud/okitatab.tex" ),
	Asset( "ATLAS", "images/hud/okitatab.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_okita.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_okita.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_okita.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_okita.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_okita.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_okita.xml" ),
	
	Asset( "IMAGE", "images/names_okita.tex" ),
    Asset( "ATLAS", "images/names_okita.xml" ),
	
    Asset( "IMAGE", "bigportraits/okita_none.tex" ),
    Asset( "ATLAS", "bigportraits/okita_none.xml" ),
	--
	Asset("SOUNDPACKAGE","sound/music_okita.fev"),
	Asset("SOUND","sound/music_okita.fsb"),
}

--Add dogfood
GLOBAL.FOODTYPE.DOGFOOD = "DOGFOOD"

local function AddBossLoot(prefab)
    if prefab.components.lootdropper then
        prefab.components.lootdropper:AddChanceLoot('dogfood',1)
    end
end

AddPrefabPostInit("leif", AddBossLoot)
AddPrefabPostInit("spiderqueen", AddBossLoot)
AddPrefabPostInit("dragonfly", AddBossLoot)
AddPrefabPostInit("deerclops", AddBossLoot)

AddPrefabPostInit("minotaur", AddBossLoot)
AddPrefabPostInit("bearger", AddBossLoot)
AddPrefabPostInit("moose", AddBossLoot)
AddPrefabPostInit("klaus", AddBossLoot)
AddPrefabPostInit("beequeen", AddBossLoot)
AddPrefabPostInit("antlion", AddBossLoot)



AddStategraphPostInit("wilson", function(self)
    for key,value in pairs(self.states) do
        if value.name == 'run_stop' then
            local original_run_stop_onenter = self.states[key].onenter
            self.states[key].onenter = function(inst)
            	if inst.cmiss and inst.cmiss:value() == 1 then
            		inst.components.locomotor:Stop()
                else
                    original_run_stop_onenter(inst)
                end
            end
        end
        if value.name == 'run_start' then
            local original_run_start_onenter = self.states[key].onenter
            self.states[key].onenter = function(inst)
            	if inst.cmiss and inst.cmiss:value() == 1 then
            		inst.components.locomotor:RunForward()
            		inst.sg.mem.footsteps = 0
                else
                    original_run_start_onenter(inst)
                end
            end
        end
        if value.name == 'run' then
            local original_run_onenter = self.states[key].onenter
            self.states[key].onenter = function(inst)
            	if inst.cmiss and inst.cmiss:value() == 1 then
            		inst.components.locomotor:RunForward()
            		inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength())
                else
                    original_run_onenter(inst)
                end
            end
        end
        if value.name == 'funnyidle' then
            local original_funnyidle_onenter = self.states[key].onenter
            self.states[key].onenter = function(inst)
            	if inst.cmiss and inst.cmiss:value() == 1 then
                else
                    original_funnyidle_onenter(inst)
                end
            end
        end
        if value.name == 'attack' then
            local original_attack_onenter = self.states[key].onenter
            self.states[key].onenter = function(inst)
	            local function DoMountSound(inst, mount, sound, ispredicted)
				    if mount ~= nil and mount.sounds ~= nil then
				        inst.SoundEmitter:PlaySound(mount.sounds[sound], nil, nil, ispredicted)
				    end
				end
            	local FRAMES = GLOBAL.FRAMES
            	local buffaction = inst:GetBufferedAction()
	            local target = buffaction ~= nil and buffaction.target or nil
	            local equip = inst.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
	            inst.components.combat:SetTarget(target)
	            inst.components.combat:StartAttack()
	            inst.components.locomotor:Stop()
	            local cooldown = inst.components.combat.min_attack_period + .5 * FRAMES
	            if inst.components.rider:IsRiding() then
	                if equip ~= nil and (equip.components.projectile ~= nil or equip:HasTag("rangedweapon")) then
	                    inst.AnimState:PlayAnimation("player_atk_pre")
	                    inst.AnimState:PushAnimation("player_atk", false)
	                    inst.SoundEmitter:PlaySound(
	                        (equip:HasTag("icestaff") and "dontstarve/wilson/attack_icestaff") or
	                        (equip:HasTag("firestaff") and "dontstarve/wilson/attack_firestaff") or
	                        "dontstarve/wilson/attack_weapon",
	                        nil, nil, true
	                    )
	                    cooldown = math.max(cooldown, 13 * FRAMES)
	                else
	                    inst.AnimState:PlayAnimation("atk_pre")
	                    inst.AnimState:PushAnimation("atk", false)
	                    DoMountSound(inst, inst.components.rider:GetMount(), "angry", true)
	                    cooldown = math.max(cooldown, 16 * FRAMES)
	                end
	            elseif equip ~= nil and equip:HasTag("windyknife") then
	                inst.AnimState:PlayAnimation("atk_pre")
	                inst.AnimState:PushAnimation("atk", false)
	                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon", nil, nil, true)
	                cooldown = 11 * FRAMES
	            elseif equip ~= nil and equip:HasTag("whip") then
	                inst.AnimState:PlayAnimation("whip_pre")
	                inst.AnimState:PushAnimation("whip", false)
	                inst.sg.statemem.iswhip = true
	                inst.SoundEmitter:PlaySound("dontstarve/common/whip_pre", nil, nil, true)
	                cooldown = math.max(cooldown, 17 * FRAMES)
	            elseif equip ~= nil and equip.components.weapon ~= nil and not equip:HasTag("punch") then
	                inst.AnimState:PlayAnimation("atk_pre")
	                inst.AnimState:PushAnimation("atk", false)
	                inst.SoundEmitter:PlaySound(
	                    (equip:HasTag("icestaff") and "dontstarve/wilson/attack_icestaff") or
	                    (equip:HasTag("shadow") and "dontstarve/wilson/attack_nightsword") or
	                    (equip:HasTag("firestaff") and "dontstarve/wilson/attack_firestaff") or
	                    "dontstarve/wilson/attack_weapon",
	                    nil, nil, true
	                )
	                cooldown = math.max(cooldown, 13 * FRAMES)
	            elseif equip ~= nil and (equip:HasTag("light") or equip:HasTag("nopunch")) then
	                inst.AnimState:PlayAnimation("atk_pre")
	                inst.AnimState:PushAnimation("atk", false)
	                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon", nil, nil, true)
	                cooldown = math.max(cooldown, 13 * FRAMES)
	            elseif inst:HasTag("beaver") then
	                inst.sg.statemem.isbeaver = true
	                inst.AnimState:PlayAnimation("atk_pre")
	                inst.AnimState:PushAnimation("atk", false)
	                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh", nil, nil, true)
	                cooldown = math.max(cooldown, 13 * FRAMES)
	            else
	                inst.AnimState:PlayAnimation("punch")
	                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh", nil, nil, true)
	                cooldown = math.max(cooldown, 24 * FRAMES)
	            end

	            inst.sg:SetTimeout(cooldown)

	            if target ~= nil then
	                inst.components.combat:BattleCry()
	                if target:IsValid() then
	                    inst:FacePoint(target:GetPosition())
	                    inst.sg.statemem.attacktarget = target
	                end
	            end
            end
        end
    end
end)

AddStategraphPostInit("wilson_client", function(self)
    for key,value in pairs(self.states) do
        if value.name == 'run_stop' then
            local original_run_stop_onenter = self.states[key].onenter
            self.states[key].onenter = function(inst)
            	if GLOBAL.ThePlayer.cmiss and GLOBAL.ThePlayer.cmiss:value() == 1 then
            		GLOBAL.ThePlayer.components.locomotor:Stop()
                else
                    original_run_stop_onenter(inst)
                end
            end
        end
        if value.name == 'run_start' then
            local original_run_start_onenter = self.states[key].onenter
            self.states[key].onenter = function(inst)
            	if GLOBAL.ThePlayer.cmiss and GLOBAL.ThePlayer.cmiss:value() == 1 then
            		GLOBAL.ThePlayer.components.locomotor:RunForward()
            		GLOBAL.ThePlayer.sg.mem.footsteps = 0
                else
                    original_run_start_onenter(inst)
                end
            end
        end
        if value.name == 'run' then
            local original_run_onenter = self.states[key].onenter
            self.states[key].onenter = function(inst)
            	if GLOBAL.ThePlayer.cmiss and GLOBAL.ThePlayer.cmiss:value() == 1 then
            		GLOBAL.ThePlayer.components.locomotor:RunForward()
            		GLOBAL.ThePlayer.sg:SetTimeout(GLOBAL.ThePlayer.AnimState:GetCurrentAnimationLength())
                else
                    original_run_onenter(inst)
                end
            end
        end
        if value.name == 'attack' then
            local original_run_onenter = self.states[key].onenter
            self.states[key].onenter = function(inst)
	            local function DoMountSound(inst, mount, sound)
				    if mount ~= nil and mount.sounds ~= nil then
				        inst.SoundEmitter:PlaySound(mount.sounds[sound], nil, nil, true)
				    end
				end
            	local cooldown = 0
            	local FRAMES = GLOBAL.FRAMES
	            if inst.replica.combat ~= nil then
	                inst.replica.combat:StartAttack()
	                cooldown = inst.replica.combat:MinAttackPeriod() + .5 * FRAMES
	            end
	            inst.components.locomotor:Stop()
	            local equip = inst.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
	            local rider = inst.replica.rider
	            if rider ~= nil and rider:IsRiding() then
	                if equip ~= nil and (equip:HasTag("rangedweapon") or equip:HasTag("projectile")) then
	                    inst.AnimState:PlayAnimation("player_atk_pre")
	                    inst.AnimState:PushAnimation("player_atk", false)
	                    inst.SoundEmitter:PlaySound(
	                        (equip:HasTag("icestaff") and "dontstarve/wilson/attack_icestaff") or
	                        (equip:HasTag("firestaff") and "dontstarve/wilson/attack_firestaff") or
	                        "dontstarve/wilson/attack_weapon",
	                        nil, nil, true
	                    )
	                    if cooldown > 0 then
	                        cooldown = math.max(cooldown, 13 * FRAMES)
	                    end
	                else
	                    inst.AnimState:PlayAnimation("atk_pre")
	                    inst.AnimState:PushAnimation("atk", false)
	                    DoMountSound(inst, rider:GetMount(), "angry")
	                    if cooldown > 0 then
	                        cooldown = math.max(cooldown, 16 * FRAMES)
	                    end
	                end
                elseif equip ~= nil and equip:HasTag("windyknife") then
	                inst.AnimState:PlayAnimation("atk_pre")
	                inst.AnimState:PushAnimation("atk", false)
	                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon", nil, nil, true)
	                cooldown = 11 * FRAMES
	            elseif equip ~= nil and equip:HasTag("whip") then
	                inst.AnimState:PlayAnimation("whip_pre")
	                inst.AnimState:PushAnimation("whip", false)
	                inst.sg.statemem.iswhip = true
	                inst.SoundEmitter:PlaySound("dontstarve/common/whip_pre", nil, nil, true)
	                if cooldown > 0 then
	                    cooldown = math.max(cooldown, 17 * FRAMES)
	                end
	            elseif equip ~= nil and
	                equip.replica.inventoryitem ~= nil and
	                equip.replica.inventoryitem:IsWeapon() and
	                not equip:HasTag("punch") then
	                inst.AnimState:PlayAnimation("atk_pre")
	                inst.AnimState:PushAnimation("atk", false)
	                inst.SoundEmitter:PlaySound(
	                    (equip:HasTag("icestaff") and "dontstarve/wilson/attack_icestaff") or
	                    (equip:HasTag("shadow") and "dontstarve/wilson/attack_nightsword") or
	                    (equip:HasTag("firestaff") and "dontstarve/wilson/attack_firestaff") or
	                    "dontstarve/wilson/attack_weapon",
	                    nil, nil, true
	                )
	                if cooldown > 0 then
	                    cooldown = math.max(cooldown, 13 * FRAMES)
	                end
	            elseif equip ~= nil and
	                (equip:HasTag("light") or
	                equip:HasTag("nopunch")) then
	                inst.AnimState:PlayAnimation("atk_pre")
	                inst.AnimState:PushAnimation("atk", false)
	                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon", nil, nil, true)
	                if cooldown > 0 then
	                    cooldown = math.max(cooldown, 13 * FRAMES)
	                end
	            elseif inst:HasTag("beaver") then
	                inst.sg.statemem.isbeaver = true
	                inst.AnimState:PlayAnimation("atk_pre")
	                inst.AnimState:PushAnimation("atk", false)
	                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh", nil, nil, true)
	                if cooldown > 0 then
	                    cooldown = math.max(cooldown, 8 * FRAMES)
	                end
	            else
	                inst.AnimState:PlayAnimation("punch")
	                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh", nil, nil, true)
	                if cooldown > 0 then
	                    cooldown = math.max(cooldown, 24 * FRAMES)
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
            end
        end
    end
end)


AddPlayerPostInit(function(inst)
   if inst.components.combat == nil then
        return
    end
	
	if  not inst:HasTag("okita") then 
		return 
	end
	
	if GLOBAL.TheWorld.ismastersim then
		local old_start = inst.components.combat.StartAttack
		inst.components.combat.StartAttack = function(self)
			old_start(self)
			if self.target then
				local weapon = self:GetWeapon()
				if weapon and weapon.components.weapon  and inst.components.okitastatus.teji==1 and  inst:HasTag("okita") then
					local distance = math.sqrt(self.inst:GetDistanceSqToInst(self.target))
					local hitrange = weapon.components.weapon.hitrange
						inst.SoundEmitter:PlaySound("music_okita/music_okita/symbol")
						inst.components.okitastatus.teji=0
						--gai
						inst.components.okitastatus.miss = 1
						inst.symbolfx = SpawnPrefab("santu")
						inst.symbolfx.Transform:SetPosition(inst.Transform:GetWorldPosition())
						inst:DoTaskInTime(7,function()
							inst.symbolfx:Remove()
						end)
						
						
						local smoke1 = SpawnPrefab("red_leaves")
						local smoke2 = SpawnPrefab("red_leaves")
						local sx, sy, sz = self.inst.Transform:GetWorldPosition()
						smoke1.Transform:SetPosition(sx, sy, sz)
						local fx, fy, fz = self.target.Transform:GetWorldPosition()
						local q = (distance - hitrange + 0.2) / distance
						local dx = sx - q * (sx - fx)
						local dy = sy - q * (sy - fy)
						local dz = sz - q * (sz - fz)
						inst.Transform:SetPosition(fx, fy, fz+7)
						smoke2.Transform:SetPosition(fx, fy, fz+7)
						inst.AnimState:PlayAnimation("atk")
						
						inst:DoTaskInTime(0.5, function()
						inst.Transform:SetPosition(fx, fy, fz+4)
						inst.AnimState:PlayAnimation("jumpout")
						local smoke2 = SpawnPrefab("red_leaves")
						
						smoke2.Transform:SetPosition(fx, fy, fz+4)
						end)
												
					
						inst:DoTaskInTime(1, function()
						inst.Transform:SetPosition(dx, dy, dz)
						local smoke2 = SpawnPrefab("red_leaves")
						smoke2.Transform:SetPosition(dx, dy, dz)
						inst.components.okitastatus.baojuatk = 1
						
						--gai
						inst.components.okitastatus.miss = 0
						--inst.SoundEmitter:PlaySound("music_okita/music_okita/win")
						
						end)
						
										
						
					

				end
			end
		end
	end
end)


--local okitatab = AddRecipeTab("Ushiwakamaru", 999, "images/hud/okitatab.xml", "okitatab.tex", nil)
--local okitatab = AddRecipeTab("Ushiwakamaru", 999, "images/shop/shop.xml", "shop.tex", nil)
local shop = AddRecipeTab("Okita", 999, "images/hud/okitatab.xml", "okitatab.tex", "okita")

AddRecipe("okitasword", {GLOBAL.Ingredient("nightmarefuel", 2), GLOBAL.Ingredient("goldnugget", 5), GLOBAL.Ingredient("spear", 1)}, 
shop, TECH.NONE, nil, nil, nil, nil, "okita", 
"images/inventoryimages/okitasword.xml", "okitasword.tex" )



-- The character select screen lines
STRINGS.CHARACTER_TITLES.okita = "Okita"
STRINGS.CHARACTER_NAMES.okita = "Okita son"
STRINGS.CHARACTER_DESCRIPTIONS.okita = "*She is weak....\n*Like eating dogfood\n*Max level 90 with out holybottle"
STRINGS.CHARACTER_QUOTES.okita = "\"Souji\""

-- gouliang
GLOBAL.STRINGS.NAMES.DOGFOOD = "四星狗粮"
GLOBAL.STRINGS.RECIPE_DESC.DOGFOOD = "总司的爱食"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.DOGFOOD = "英灵吃了狗粮就可以升级啦 啦啦啦"

-- okitasword
GLOBAL.STRINGS.NAMES.OKITASWORD = "菊一文字则宗"
GLOBAL.STRINGS.RECIPE_DESC.OKITASWORD = "总司的爱剑"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.OKITASWORD = "武装是“乞食清光”，穿上羽织效果，剑会升格为菊一文字则宗"

-- Custom speech strings
STRINGS.CHARACTERS.okita = require "speech_wilson"

-- The character's name as appears in-game 
STRINGS.NAMES.okita = "okita"

AddMinimapAtlas("images/map_icons/okita.xml")

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("okita", "FEMALE")

