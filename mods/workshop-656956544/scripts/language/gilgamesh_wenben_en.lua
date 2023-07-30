local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

STRINGS.RECIPE_DESC.GILGAMESH_NOTICE_CH = "Instructions of the character."
GLOBAL.STRINGS.NAMES.GILGAMESH_NOTICE_CH = "King's Diary"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.GILGAMESH_NOTICE_CH= "Instructions\n*The key of babylon almost deal no damage but have a long range*\n*If you have a target,you can push C summon gates to shoot them*\n*Gilgamesh can make some Exclusive items*\n*Uruk's meals*\nIced red wine:2 berries + 1ice;\ngilgamesh great meal: 1 Iced red wine +1.5meat +1 fish*"

STRINGS.RECIPE_DESC.KEY_OF_BABYLON = "Set target and click C to open the door!"
GLOBAL.STRINGS.NAMES.KEY_OF_BABYLON = "Bablli"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.KEY_OF_BABYLON= "The key open gates of babylon"   

STRINGS.RECIPE_DESC.KEYOFBABYLON = "Remedy: spare key\nbundled 3 gates of babylon"
GLOBAL.STRINGS.NAMES.KEYOFBABYLON = "King's Key"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.KEYOFBABYLON= "The key necessary to open the treasure. Right click to place the recovered gates." 

STRINGS.RECIPE_DESC.GATE_OF_BABYLON = "Right click to place it in the key."
GLOBAL.STRINGS.NAMES.GATE_OF_BABYLON = "Gate of Babylon"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.GATE_OF_BABYLON= "Gate of Babylon" 

STRINGS.RECIPE_DESC.GILGAMESH_AXE = "King of the axe!"
GLOBAL.STRINGS.NAMES.GILGAMESH_AXE = "Uruk Battle Axe"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.GILGAMESH_AXE= "It can cut the tree down." 

STRINGS.RECIPE_DESC.EA = "Before Enuma Elish"
GLOBAL.STRINGS.NAMES.EA = "Rebellious Sword"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.EA= "This sword has not liberated its real name." 

STRINGS.RECIPE_DESC.ARCHER_GALIENTSWORD = "Enuma Elish"
GLOBAL.STRINGS.NAMES.ARCHER_GALIENTSWORD = "Enuma Elish"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_GALIENTSWORD= "Stay away from your kingdom" 

STRINGS.RECIPE_DESC.ENKIDU_DX = "Remember the king's best friend"
GLOBAL.STRINGS.NAMES.ENKIDU_DX = "The statue of Enkidu"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ENKIDU_DX= "The statue of Enkidu" 

------------食谱的文本-------------------
GLOBAL.STRINGS.NAMES.GILGAMESH_COLD_REDWINE = "Cold RedWine"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.GILGAMESH_COLD_REDWINE = "Wowcooool!!!"

GLOBAL.STRINGS.NAMES.GILGAMESH_GREAT_MEAL = "Gilgamesh Great Meal"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.GILGAMESH_GREAT_MEAL = "The oldest great meal in human history!"

----------------------------------------------------

-- The character select screen lines
STRINGS.CHARACTER_TITLES.gilgamesh = "Hero King"
STRINGS.CHARACTER_NAMES.gilgamesh = "Gilgamesh"
STRINGS.CHARACTER_DESCRIPTIONS.gilgamesh = "*Not afraid of hunger, but afraid of close combat\n*Summon Gates of Babylon and shoot your enemies\n*Golden rule"
STRINGS.CHARACTER_QUOTES.gilgamesh = "\"Before the Enuma Elish，All the treasures belong to me. \""

STRINGS.CHARACTERS.GENERIC.DESCRIBE.GILGAMESH = 
{
	GENERIC = "My king.",
	ATTACKER = "Fucking Gilgamesh",
	MURDERER = "Parden?",
	REVIVER = "Archer,what r u doing?",
	GHOST = "My king will never died.",
}

-- Custom speech strings
STRINGS.CHARACTERS.GILGAMESH = require "speech_gilgamesh"