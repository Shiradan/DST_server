-- Import the engine
modimport("engine.lua")

-- Import to keep the keyhandler from working while typing in chat.
Load "chatinputscreen"
Load "consolescreen"
Load "textedit"

--暂时
PrefabFiles = {
	"illya_mahoo",
--	"illya_mahoo_none",
	"illya_rubystar",
	"illya_rubystar1",
	"illya_rubystar2",
	"illya_rubystar3",
	"illya_rubystar4",
	"illya_light",
	"illya_battle_ring",
	"bishop_chargel",
	"bishop_chargex",

}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/illya_mahoo.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/illya_mahoo.xml" ),

	Asset( "IMAGE", "images/map_icons/illya_mahoo.tex" ),
	Asset( "ATLAS", "images/map_icons/illya_mahoo.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_illya_mahoo.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_illya_mahoo.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_illya_mahoo.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_illya_mahoo.xml" ),
	
	Asset( "IMAGE", "images/illya_rubystar.tex" ),
    Asset( "ATLAS", "images/illya_rubystar.xml" ),
	
	Asset( "IMAGE", "images/illya_rubystar1.tex" ),
    Asset( "ATLAS", "images/illya_rubystar1.xml" ),
	
		Asset( "IMAGE", "images/illya_rubystar2.tex" ),
    Asset( "ATLAS", "images/illya_rubystar2.xml" ),
	
	Asset( "IMAGE", "images/illya_rubystar3.tex" ),
    Asset( "ATLAS", "images/illya_rubystar3.xml" ),
	
	Asset( "IMAGE", "images/illya_rubystar4.tex" ),
    Asset( "ATLAS", "images/illya_rubystar4.xml" ),
	
	Asset( "IMAGE", "images/illya_battle_ring.tex" ),
    Asset( "ATLAS", "images/illya_battle_ring.xml" ),
	
	Asset( "IMAGE", "bigportraits/illya_mahoo.tex" ),
    Asset( "ATLAS", "bigportraits/illya_mahoo.xml" ),
	
	Asset( "ANIM", "anim/illya_mahoo_tran.zip" ),
	
	Asset("SOUNDPACKAGE", "sound/illya_mahoo.fev"),
	Asset("SOUND", "sound/illya_mahoo.fsb"),
	
	--在此处添加文件
}

--此处添加音频替换
RemapSoundEvent( "dontstarve/characters/illya_mahoo/death_voice", "illya_mahoo/sound/death_voice" )
RemapSoundEvent( "dontstarve/characters/illya_mahoo/talk_LP", "illya_mahoo/sound/talk_LP" )
--此处添加科技树
modimport "custom_tech_tree.lua"

--全局变量声明（main）
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local TUNING = GLOBAL.TUNING
local Player = GLOBAL.ThePlayer
local TheNet = GLOBAL.TheNet
local IsServer = GLOBAL.TheNet:GetIsServer()
local TheInput = GLOBAL.TheInput
local TimeEvent = GLOBAL.TimeEvent
local FRAMES = GLOBAL.FRAMES
local EQUIPSLOTS = GLOBAL.EQUIPSLOTS
local EventHandler = GLOBAL.EventHandler
local SpawnPrefab = GLOBAL.SpawnPrefab
local State = GLOBAL.State
local DEGREES = GLOBAL.DEGREES
local Vector3 = GLOBAL.Vector3
local ACTIONS = GLOBAL.ACTIONS
local FOODTYPE = GLOBAL.FOODTYPE
local PLAYERSTUNLOCK = GLOBAL.PLAYERSTUNLOCK
local GetTime = GLOBAL.GetTime
local HUMAN_MEAT_ENABLED = GLOBAL.HUMAN_MEAT_ENABLED
local TheSim = GLOBAL.TheSim
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local STRINGS = GLOBAL.STRINGS
local TheNet = GLOBAL.TheNet
local GetWorld = GLOBAL.GetWorld
local _G = GLOBAL
--不同的mod 此处作为分界线
--local _G = GLOBAL

--UI/技能按钮
local Zzh_SkillButton2 = require("widgets/zzh_skillbutton2")
local function AddSkillButton_mahoo(self) 
	if self.owner and self.owner:HasTag("illya_magi") then
	
		--self.skillbutton_z = self:AddChild( Zg_SkillButton2( self.owner, "images/yohimetab2.xml", "yohimetab2.tex", "yohimetab2.tex",35,37.5,0) )	
		self.skillbutton_z = self:AddChild( Zzh_SkillButton2( self.owner, "images/z_illya.xml", "z_illya.tex", "z_illya.tex",30,25,0) )
		self.skillbutton_x = self:AddChild( Zzh_SkillButton2( self.owner, "images/x_illya.xml", "x_illya.tex", "x_illya.tex",80,25,0) )	
		
		local OnUpdate_base = self.OnUpdate
		self.OnUpdate = function(self, dt)
			OnUpdate_base(self, dt)
			
			local thetab = {"z","x"}--去掉z
			for k, v in pairs(thetab) do
				if self.owner[v.."_skill"] ~= true then
					self["skillbutton_"..v]:Zzh_SetTint(0.2,0.2,0.2,1)
					self["skillbutton_"..v]:Zzh_SetColour(1,0,0,0.5)
					local cd = self.owner.components.timer:GetTimeLeft(v.."_skill") or self.owner[v.."_skill_cd"]
					cd = math.ceil(cd)
					self["skillbutton_"..v]:Zzh_SetString(cd)
				else
					self["skillbutton_"..v]:Zzh_SetTint(1,1,1,1)
					self["skillbutton_"..v]:Zzh_SetColour(0,1,0,0.6)
					self["skillbutton_"..v]:Zzh_SetString(string.upper(v))
				end
			end
			
		end
		
	end
end
--加入按钮类型
AddClassPostConstruct("widgets/controls", AddSkillButton_mahoo)--]]
--变身系统Transformation 需要添加武器判断
local function mahoo_Fn(inst)
--local equip_ff = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) 
if 	inst.illya_weapon_ok == 1 then
if inst:HasTag("playerghost") then return end
if inst.transformed then
		local sanity_percent_b = inst.components.sanity:GetPercent()
		inst.components.sanity:SetMax(150 + (math.min(inst.level, 18) * 10))
		inst.components.sanity:SetPercent(sanity_percent_b)
    inst.AnimState:SetBuild("illya_mahoo")
	inst.SoundEmitter:PlaySound("dontstarve/sanity/creature2/taunt")
		inst.lightfx2 = SpawnPrefab("illya_light")
		if inst.lightfx2 then
			inst.lightfx2.persists = false
			inst.lightfx2.entity:SetParent(inst.entity)
		end
		inst:DoTaskInTime(3, function()
			inst.lightfx2:Remove()
		end)
		local x, y, z = inst.Transform:GetWorldPosition()
		local fx = SpawnPrefab("lightning")
		fx.Transform:SetPosition(x, y, z)
		SpawnPrefab("statue_transition").Transform:SetPosition(inst:GetPosition():Get()) --此处有问题
	inst.components.locomotor.walkspeed = 5                --normal行走速度
	inst.components.locomotor.runspeed = 7
	inst.components.health.absorb = 0
--	inst.components.combat.damagemultiplier = 0.5
	inst.Transform:SetScale(1, 1, 1)
	inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE)
	inst.soundsname = "illya_normal"
	TUNING.illya_status = "normal"
		if GetModConfigData("lang") == 0 then
			inst.components.talker:Say("德玛西亚!", 2.5,true) 
		else
			inst.components.talker:Say("naive!", 2.5,true)
		end
else
	if inst.components.sanity and inst.components.sanity.current >= 40 then
		local sanity_percent_a = inst.components.sanity:GetPercent()
	--inst.components.sanity:DoDelta(-40)
		inst.components.sanity:SetMax(600 + (57*math.min(inst.level, 18)))
		inst.components.sanity:SetPercent(sanity_percent_a)
	inst.AnimState:SetBuild("illya_mahoo_tran")
	inst.SoundEmitter:PlaySound("dontstarve/sanity/creature2/taunt")
		inst.lightfx2 = SpawnPrefab("illya_light")               --照明效果
		if inst.lightfx2 then
			inst.lightfx2.persists = false
			inst.lightfx2.entity:SetParent(inst.entity)
		end
		inst:DoTaskInTime(3, function()
			inst.lightfx2:Remove()
		end)
		local x, y, z = inst.Transform:GetWorldPosition()
		local fx = SpawnPrefab("lightning")
		fx.Transform:SetPosition(x, y, z)
		SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
	inst.components.locomotor.walkspeed = 6               --魔法少女行走速度
	inst.components.locomotor.runspeed = 9.5
	inst.components.health.absorb = 0
--	inst.components.combat.damagemultiplier = 1
	inst.Transform:SetScale(1, 1, 1)
	inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE*4)
	--inst.soundsname = "illya_mahoo_tran"
	TUNING.illya_status = "mahoo"
		if GetModConfigData("lang") == 0 then
			inst.components.talker:Say("肚子饿了~", 2.5,true)
		else
			inst.components.talker:Say("exciting!", 2.5,true)
		end
	else
		if inst.components.talker then
			inst.components.talker:Say("没有足够的理智")
		end
    
		

end
end
else
if inst.components.talker then
		inst.components.talker:Say("需要红宝石之星")
	end
	return
end


inst.transformed = not inst.transformed

return true
 
end
--此处修改RPC句柄
AddModRPCHandler("illya_mahoo", "z_skill", mahoo_Fn)
--Max Health Penalty



modimport "custom_tech_tree.lua"                     --科技树系统注入
modimport("scripts/stategraphs/illya_mi.lua")        --元素炮击状态机注入
--supergun 元素炮击 需要添加武器判断
local function supergun_Fn(inst)
--local equip_ff = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) 
if inst.illya_weapon_ok == 1 then
if TUNING.illya_status == "mahoo" then
if inst.components.sanity and inst.components.sanity.current >= 250 then
	inst.components.talker:Say("就算是这样也不能原谅")
	inst.SoundEmitter:PlaySound("illya_mahoo/sound/dazhao_1")
	inst.components.sanity:DoDelta(-250)		
	--local x0,y0,z0 = inst.Transform:GetWorldPosition()
	--local ents = GLOBAL.TheSim:FindEntities(x0,y0,z0, 15)--半径50
	local x_f, y_f, z_f = inst:GetPosition():Get()
	local xyz_input = TheInput:GetWorldPosition()
	--local cannon = GLOBAL.SpawnPrefab("bishop_chargel")
	--cannon.Transform:SetPosition(inst:GetPosition():Get())
	--cannon.Transform:SetRotation(inst.Transform:GetRotation())
	inst.pos = xyz_input
	inst.components.locomotor:Stop()
	inst.components.playercontroller:EnableMapControls(false)
    inst.components.playercontroller:Enable(false)
	inst.sg:GoToState("illya_skill")
	--inst.yohime_reflect_fxsp.Transform:SetPosition(x_f, 3.5, z_f)
	--inst.yohime_reflect_fxsp.launch()
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))
	local i = 0
	local angle = inst.Transform:GetRotation() * _G.DEGREES 
	local fin_x, fin_y, fin_z = 3 * math.cos(angle), 0, -3 * math.sin(angle) 
    --第二阶段
	inst.skill_task = inst:DoPeriodicTask(0.15, function() 
	inst.illya_reflect_fxsp = GLOBAL.SpawnPrefab("bishop_chargex")
	--local x3 = GetRandomWithVariance(0, 1)
    --local z3 = GetRandomWithVariance(0, 1)
	inst.illya_reflect_fxsp.pos = xyz_input
	inst.illya_reflect_fxsp.pos.x = inst.illya_reflect_fxsp.pos.x + 2*math.random() -1
	inst.illya_reflect_fxsp.pos.z = inst.illya_reflect_fxsp.pos.z + 2*math.random() -1
	inst.illya_reflect_fxsp.pos.y = 0
	inst.illya_reflect_fxsp.damage = inst.Mag_Power + inst.Mag_Power2
	--inst.illya_reflect_fxsp.Transform:SetPosition(x_f + 2*math.random() - 1, 3.5, z_f + 2*math.random() - 1)
	inst.illya_reflect_fxsp.Transform:SetPosition(x_f + fin_x, 1, z_f + fin_z)
	--inst.illya_reflect_fxsp.damage = inst.Mag_Power
	inst.illya_reflect_fxsp.launch()
	i = i + 1
	if i == 6 then 
	inst.components.playercontroller:EnableMapControls(true)
    inst.components.playercontroller:Enable(true)
	inst.skill_task:Cancel()
	end
	end)
	--第三阶段
	inst:DoTaskInTime(1.05, function()  
	inst.illya_reflect_fxb = GLOBAL.SpawnPrefab("bishop_chargex")
	inst.illya_reflect_fxb.pos = xyz_input
	inst.illya_reflect_fxb.pos.y = 0
	inst.illya_reflect_fxb.damage = inst.Mag_Power + inst.Mag_Power2
	inst.illya_reflect_fxb.Transform:SetPosition(x_f + fin_x, 1, z_f + fin_z)
	inst.illya_reflect_fxb.launch()
	end)
	--清扫
	inst:DoTaskInTime(1.5, function()  
	inst.components.playercontroller:EnableMapControls(true)
    inst.components.playercontroller:Enable(true)
	inst.skill_task:Cancel()
	--cannon:Remove()
	end)
else
	if inst.components.talker then
		inst.components.talker:Say("没有足够的魔法值")
		return
	end
end
else
if inst.components.talker then
		inst.components.talker:Say("需要变身呢")
		return
	end
end
else
if inst.components.talker then
		inst.components.talker:Say("需要红宝石之星")
		return
	end
end
end
AddModRPCHandler("illya_mahoo", "x_skill", supergun_Fn)
--local function HealthPostInit(self)
--如需要可在pururut找到


-- The character select screen lines
-- lang系统————前段需要：、data替换 暂未添加
TUNING.magic_regene = GetModConfigData("magic_regene")
TUNING.Lang1 = GetModConfigData("lang1")
--GetModConfigData("lang")
if TUNING.Lang1 == 0 then
	STRINGS.CHARACTER_TITLES.illya_mahoo = "伊莉雅(illya)"
	STRINGS.CHARACTER_NAMES.illya_mahoo = "ILLYA"
	STRINGS.CHARACTER_DESCRIPTIONS.illya_mahoo = "*pain but have magic \n*have more Mana point\n*can transform"
	STRINGS.CHARACTER_QUOTES.illya_mahoo = "\"When you feel hungry, you'd better eat sth rather than drink water:)\""
	-- Custom speech strings
	STRINGS.CHARACTERS.illya_mahoo = require "speech_illya"
	-- The character's name as appears in-game 
	STRINGS.NAMES.illya_mahoo = "illya"
	-- The default responses of examining the character
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.illya_mahoo = 
	{
		GENERIC = "mahou shoujo illya ☆ desu",
		ATTACKER = "biubiubiu",
		MURDERER = "gomen, I was unmeant to do so",
		REVIVER = "arigatou",
		GHOST = "oh, my head hurts !!",
	}

	--加入小地图图标
	AddMinimapAtlas("images/map_icons/illya_mahoo.xml")

	-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
	--通过下面的代码表示物品
	STRINGS.NAMES.ILLYA_RUBYSTAR = "rubystar Lv1"
	STRINGS.RECIPE_DESC.ILLYA_RUBYSTAR = "a illya has a rubystar. can't be created."
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.ILLYA_RUBYSTAR = "Love & Justice(WTF??)"

	STRINGS.NAMES.ILLYA_RUBYSTAR1 = "rubystar Lv2"
	STRINGS.RECIPE_DESC.ILLYA_RUBYSTAR1 = "increase the power, unconspicuous."
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.ILLYA_RUBYSTAR1 = "a illya has a rubystar. can't be created"
	
	STRINGS.NAMES.ILLYA_RUBYSTAR2 = "rubystar Lv3"
	STRINGS.RECIPE_DESC.ILLYA_RUBYSTAR2 = "increase some power."
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.ILLYA_RUBYSTAR2 = "a illya has a rubystar. can't be created"
	
	STRINGS.NAMES.ILLYA_RUBYSTAR3 = "rubystar Lv4"
	STRINGS.RECIPE_DESC.ILLYA_RUBYSTAR3 = "increase much more power."
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.ILLYA_RUBYSTAR3 = "a illya has a rubystar. can't be created"
	
	STRINGS.NAMES.ILLYA_RUBYSTAR4 = "rubystar Lv5"
	STRINGS.RECIPE_DESC.ILLYA_RUBYSTAR4 = "OMG, how do you get it?!"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.ILLYA_RUBYSTAR4 = "Ultima magic staff"

	STRINGS.NAMES.ILLYA_BATTLE_RING = "illya battle ring"
	STRINGS.RECIPE_DESC.ILLYA_BATTLE_RING = "the damage absorb according to sanity"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.ILLYA_BATTLE_RING = "you will never died"
	
	STRINGS.NAMES.ILLYA_MAHOOTAB = "illya tab"

else
	STRINGS.CHARACTER_TITLES.illya_mahoo = "伊莉雅(illya)"
	STRINGS.CHARACTER_NAMES.illya_mahoo = "伊莉雅"
	STRINGS.CHARACTER_DESCRIPTIONS.illya_mahoo = "*柔弱身板但拥有强大魔法\n*超级高的魔法值（伪）\n*可以变身"
	STRINGS.CHARACTER_QUOTES.illya_mahoo = "\"真正的空腹是不能靠喝水解决的。要吃水果\""
	-- Custom speech strings
	STRINGS.CHARACTERS.illya_mahoo = require "speech_illya"
	-- The character's name as appears in-game 
	STRINGS.NAMES.illya_mahoo = "伊莉雅"
	-- The default responses of examining the character
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.illya_mahoo = 
	{
		GENERIC = "魔法少女伊利亚☆desu",
		ATTACKER = "biubiubiu",
		MURDERER = "啊狗咩，不过你就先反省反省吧",
		REVIVER = "arigatou",
		GHOST = "啊~撞到头了，头好疼。",
	}

	--加入小地图图标
	AddMinimapAtlas("images/map_icons/illya_mahoo.xml")

	-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
	--通过下面的代码表示物品
	STRINGS.NAMES.ILLYA_RUBYSTAR = "红宝石之星f1"
	STRINGS.RECIPE_DESC.ILLYA_RUBYSTAR = "红宝石之星只有一个，请不要随意丢弃，丢了概不补换"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.ILLYA_RUBYSTAR = "自称爱和正义的魔法杖（爱和正义？？？）"

	STRINGS.NAMES.ILLYA_RUBYSTAR1 = "红宝石之星f2"
	STRINGS.RECIPE_DESC.ILLYA_RUBYSTAR1 = "略微增加法术强度的魔法杖，但是并不明显"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.ILLYA_RUBYSTAR1 = "红宝石之星只有一个，请不要随意丢弃，丢了概不补换"
	
	STRINGS.NAMES.ILLYA_RUBYSTAR2 = "红宝石之星f3"
	STRINGS.RECIPE_DESC.ILLYA_RUBYSTAR2 = "增加了一定的法术强度"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.ILLYA_RUBYSTAR2 = "红宝石之星只有一个，请不要随意丢弃，丢了概不补换"
	
	STRINGS.NAMES.ILLYA_RUBYSTAR3 = "红宝石之星f4"
	STRINGS.RECIPE_DESC.ILLYA_RUBYSTAR3 = "完全体的法杖，加的法强几乎加了伊利亚1倍的伤害"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.ILLYA_RUBYSTAR3 = "红宝石之星只有一个，请不要随意丢弃，丢了概不补换"
	
	STRINGS.NAMES.ILLYA_RUBYSTAR4 = "红宝石之星f5"
	STRINGS.RECIPE_DESC.ILLYA_RUBYSTAR4 = "天哪，你连这个法杖都做出来了?!"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.ILLYA_RUBYSTAR4 = "终极的法杖，加超多的法强，还有武器技能"

	STRINGS.NAMES.ILLYA_BATTLE_RING = "战法师指环"
	STRINGS.RECIPE_DESC.ILLYA_BATTLE_RING = "你不会死了"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.ILLYA_BATTLE_RING = "根据当前san值的比例抵消伤害，满san就是100%减伤的效果，同时还有超速回蓝"
	
	STRINGS.NAMES.ILLYA_MAHOOTAB = "illya tab"

end 
AddModCharacter("illya_mahoo", "FEMALE")
--AddNewTechTree("illya_black_tech",1)
--科技树没想好暂时搁置
local illya_mahootab = AddRecipeTab("illya_mahootab", 0, "images/illya_mahootab.xml", "illya_mahootab.tex", "illya_mahoo")

AddRecipe("illya_battle_ring", 
	{ Ingredient("orangegem", 10), Ingredient("thulecite", 50), Ingredient("goldnugget", 20) }, 
	illya_mahootab, GLOBAL.TECH.NONE, nil, nil, nil, nil, "illya_mahoo","images/illya_battle_ring.xml")
AddRecipe("illya_rubystar", 
	{ Ingredient("illya_rubystar", 1)}, 
	illya_mahootab, GLOBAL.TECH.NONE, nil, nil, nil, nil, "illya_mahoo","images/illya_rubystar.xml")
AddRecipe("illya_rubystar1", 
	{ Ingredient("illya_rubystar", 1), Ingredient("redgem", 3), Ingredient("goldnugget", 8) }, 
	illya_mahootab, GLOBAL.TECH.NONE, nil, nil, nil, nil, "illya_mahoo","images/illya_rubystar1.xml")
AddRecipe("illya_rubystar2", 
	{ Ingredient("illya_rubystar1", 1), Ingredient("bluegem", 6), Ingredient("goldnugget", 20) }, 
	illya_mahootab, GLOBAL.TECH.NONE, nil, nil, nil, nil, "illya_mahoo","images/illya_rubystar2.xml")
AddRecipe("illya_rubystar3", 
	{ Ingredient("illya_rubystar2", 1), Ingredient("purplegem", 6), Ingredient("goldnugget", 20), Ingredient("gears", 20),Ingredient("thulecite", 1)}, 
	illya_mahootab, GLOBAL.TECH.NONE, nil, nil, nil, nil, "illya_mahoo","images/illya_rubystar3.xml")
AddRecipe("illya_rubystar4", 
	{ Ingredient("illya_rubystar3", 1), Ingredient("orangegem", 5), Ingredient("goldnugget", 99), Ingredient("gears", 40),Ingredient("thulecite", 30)}, 
	illya_mahootab, GLOBAL.TECH.NONE, nil, nil, nil, nil, "illya_mahoo","images/illya_rubystar4.xml")










--*****************解決中文換行問題longfei***********************
local function StrInsert(str,index,insertStr) 
    local len = string.len(str) 
	local leftstr = string.sub(str,1,index-1)
	local rightstr = string.sub(str,index,len)
	local newstr = leftstr..insertStr..rightstr
    return newstr; 
end
local function StrLength(str, limit)
	if not str then return str end
	local str_to = string.gsub( str , '%s' , '')
	local Size = 0
	local lenInByte = string.len(str_to)
	local ennum = 0
	local chnum = 0
	local i = 1
    local byteCount=0;
	while true do
		if i <= lenInByte then
			local curByte = string.byte(str_to, i)

			if curByte>0 and curByte<=127 then
				byteCount = 1
			elseif curByte>=192 and curByte<223 then
				byteCount = 2
			elseif curByte>=224 and curByte<239 then
				byteCount = 3
			elseif curByte>=240 and curByte<=247 then
				byteCount = 4
			end
			local char = string.sub(str_to, i, i+byteCount-1)
			i = i + byteCount

			if byteCount == 1 then
				ennum = ennum + 1
			else
				chnum = chnum + 1
			end

			Size = chnum*2 + ennum
			if chnum > 0 and Size >= limit*2 and char and not string.find("()", char, 1, true) then
				str_to = StrInsert( str_to, i, " \n")
				ennum = 0
				chnum = 0
				i = i + 2
				lenInByte=lenInByte+2
			end

		else
			break
		end
	end
	return str_to
end
local function RenameAllRecipeDesc(length)
	if STRINGS and STRINGS.RECIPE_DESC then
		for k,v in pairs(STRINGS.RECIPE_DESC) do
			if STRINGS.RECIPE_DESC[k] then
				STRINGS.RECIPE_DESC[k]=StrLength(STRINGS.RECIPE_DESC[k], length)
			end
		end
	end
end


RenameAllRecipeDesc(9)		

