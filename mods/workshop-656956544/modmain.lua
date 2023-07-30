--全局变量赋予本地变量
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local resolvefilepath = GLOBAL.resolvefilepath

local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local TECH = GLOBAL.TECH

GLOBAL.package.loaded["gilgamesh"] = env

PrefabFiles = {
"gilgamesh",  ----角色
"gilgamesh_none",  
-----------宝具-------------
"ea",      --乖离剑
"archer_galientsword",  --EA
"gilgamesh_axe",     ---乌鲁克战斧
"key_of_babylon", --王律键：原本是用来标记目标的，后来觉得有点拉胯
------------特效--------------
"gate_of_babylon_attack_fx", --召唤王财特效
"gate_of_babylon_fx", --测试王财特效
"caster_ring_fx", --caster的圆环特效
-------------物品建筑----------------
"enkidu_dx",  --恩齐都雕像
"gilgamesh_notice_ch", ---中英文说明书
--------------新食物------------------
"gilgamesh_cold_redwine",  --冰红酒
"gilgamesh_great_meal", --吉尔伽美什大餐
----------------陈旧资源---------------------
"keyofbabylon",   ---王律钥匙
"caibao",		---召唤物：王之财宝
"gate_of_babylon",---拾取物：王之财宝
--"jssspear",--王财废弃物特效，已失效2020/12/20
--"jsssword",--弹道特效，已失效2020/12/20
--"gilgamesh_notice_en",--原本的英文说明书，已失效
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/gilgamesh.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/gilgamesh.xml" ),

    Asset("IMAGE", "images/avatars/self_inspect_gilgamesh.tex"), 
	Asset("ATLAS", "images/avatars/self_inspect_gilgamesh.xml"), 

	-- Asset("IMAGE","images/avatars/gilgamesh.tex"), 
	-- Asset("ATLAS", "images/avatars/gilgamesh.xml"),

    Asset( "IMAGE", "bigportraits/gilgamesh.tex" ),
    Asset( "ATLAS", "bigportraits/gilgamesh.xml" ),
	
	Asset( "IMAGE", "images/map_icons/gilgamesh.tex" ),
	Asset( "ATLAS", "images/map_icons/gilgamesh.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_gilgamesh.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_gilgamesh.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_gilgamesh.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_gilgamesh.xml" ),
	
	Asset( "IMAGE", "images/hud/gilgameshtab.tex" ),
	Asset( "ATLAS", "images/hud/gilgameshtab.xml" ),
	
	Asset( "IMAGE", "bigportraits/gilgamesh_none.tex" ),
    Asset( "ATLAS", "bigportraits/gilgamesh_none.xml" ),
	
	Asset( "IMAGE", "images/names_gilgamesh.tex" ),
    Asset( "ATLAS", "images/names_gilgamesh.xml" ),


}
--想办法为吉尔伽美什添加初始信息
local character_mode = GetModConfigData("PingA_Range",true);
if character_mode == "normal" then
	TUNING.GILGAMESH_HEALTH=90
	TUNING.GILGAMESH_HUNGER=80
	TUNING.GILGAMESH_SANITY=260
elseif character_mode == "far" then
	TUNING.GILGAMESH_HEALTH=50
	TUNING.GILGAMESH_HUNGER=80
	TUNING.GILGAMESH_SANITY=220
end

TUNING.GAMEMODE_STARTING_ITEMS = {
		DEFAULT = {
			GILGAMESH={
				"key_of_babylon",
				"gilgamesh_notice_ch"
			},
		}
	}

TUNING.STARTING_ITEM_IMAGE_OVERRIDE["key_of_babylon"] = {
	atlas = "images/inventoryimages/key_of_babylon.xml",
	image = "key_of_babylon.tex",
}

TUNING.STARTING_ITEM_IMAGE_OVERRIDE["gilgamesh_notice_ch"] = {
	atlas = "images/inventoryimages/gilgamesh_notice.xml",
	image = "gilgamesh_notice.tex",
}


--加载新食谱以及给新食物添加食物属性
modimport("scripts/gilgamesh_meals.lua")
AddIngredientValues({"gilgamesh_cold_redwine"}, {frozen=1},true)--红酒具有一点冰属性

--加载吉尔伽美什的配方文件，包括一个自定义的配方栏位
modimport("scripts/gilgamesh_recipes.lua")
--添加台词的基本介绍，分为中英文
local Language = GetModConfigData("Language", true)  
if Language == "cn" then
	modimport("scripts/language/gilgamesh_wenben_cn.lua")--加载中文台词
elseif Language == "el" then
	modimport("scripts/language/gilgamesh_wenben_en.lua")--加载英文台词
end

-- 角色出现在游戏中的名字
STRINGS.NAMES.GILGAMESH = "gilgamesh"

AddMinimapAtlas("images/map_icons/gilgamesh.xml")

-- 将mod角色添加到mod角色列表中，同时定义其性别。可供选择的性别有MALE, FEMALE, ROBOT, NEUTRAL,以及PLURAL
AddModCharacter("gilgamesh", "MALE")

------------------------------------------------------------------------------
