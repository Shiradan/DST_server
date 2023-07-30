local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local TECH = GLOBAL.TECH

--自定义建造栏位
gilgameshstab = AddRecipeTab("王之财宝" , 998, "images/hud/gilgameshtab.xml", "gilgameshtab.tex", "gilgameshbuilder")

-------中文说明书
local gilgamesh_notice_ch_recipe = AddRecipe("gilgamesh_notice_ch",{GLOBAL.Ingredient("goldnugget", 1)},gilgameshstab,TECH.NONE,
	nil, nil, nil, nil, nil,
	"images/inventoryimages/gilgamesh_notice.xml","gilgamesh_notice.tex"
	)
gilgamesh_notice_ch_recipe.tagneeded = false
gilgamesh_notice_ch_recipe.builder_tag = "gilgameshbuilder"

--[[------王之财宝
local gate_of_babylon_recipe = AddRecipe("gate_of_babylon",
{GLOBAL.Ingredient("goldnugget", 15)},
gilgameshstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/caibao.xml", "caibao.tex")
gate_of_babylon_recipe.tagneeded = false
gate_of_babylon_recipe.builder_tag = "gilgameshbuilder"
]]
--------乌鲁克战斧
local gilgamesh_axe_recipe = AddRecipe("gilgamesh_axe",
{GLOBAL.Ingredient("goldnugget", 20),GLOBAL.Ingredient("bluegem", 1)},
gilgameshstab, TECH.SCIENCE_ONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/swap_gilgamesh_axe.xml", "swap_gilgamesh_axe.tex")
gilgamesh_axe_recipe.tagneeded = false
gilgamesh_axe_recipe.builder_tag = "gilgameshbuilder"

---------乖离剑
local ea_recipe = AddRecipe("ea",
{GLOBAL.Ingredient("key_of_babylon",1,"images/inventoryimages/key_of_babylon.xml"),GLOBAL.Ingredient("nightmarefuel", 1),GLOBAL.Ingredient("redgem", 1)},
gilgameshstab, TECH.SCIENCE_ONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/ea.xml", "ea.tex")
ea_recipe.tagneeded = false
ea_recipe.builder_tag = "gilgameshbuilder"

---------王律键
local key_of_babylon_recipe = AddRecipe("key_of_babylon",
{GLOBAL.Ingredient("goldnugget", 10)},
gilgameshstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/key_of_babylon.xml", "key_of_babylon.tex")
key_of_babylon_recipe.tagneeded = false
key_of_babylon_recipe.builder_tag = "gilgameshbuilder"

--[[
------王律钥匙
local keyofbabylon_recipe = AddRecipe("keyofbabylon",
{GLOBAL.Ingredient("goldnugget", 35)},
gilgameshstab, TECH.SCIENCE_ONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/keyofbabylon.xml", "keyofbabylon.tex")
keyofbabylon_recipe.tagneeded = false
keyofbabylon_recipe.builder_tag = "gilgameshbuilder"

]]

--------EA
local archer_galientsword_recipe = AddRecipe("archer_galientsword",
{GLOBAL.Ingredient("ea",1,"images/inventoryimages/ea.xml"),GLOBAL.Ingredient("goldnugget", 30),GLOBAL.Ingredient("gears", 3)},
gilgameshstab, TECH.SCIENCE_TWO,
nil, nil, nil, nil, nil,
"images/inventoryimages/galientsword.xml", "galientsword.tex")
archer_galientsword_recipe.tagneeded = false
archer_galientsword_recipe.builder_tag = "gilgameshbuilder"

-------恩齐都雕像
local enkidu_dx_recipe = AddRecipe("enkidu_dx",{GLOBAL.Ingredient("goldnugget", 40)},
gilgameshstab,TECH.SCIENCE_ONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/enkidu_dx2.xml","enkidu_dx2.tex")
enkidu_dx_recipe.tagneeded = false
enkidu_dx_recipe.builder_tag = "gilgameshbuilder"