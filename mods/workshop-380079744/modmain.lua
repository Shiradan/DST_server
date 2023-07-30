-- Import the engine.
modimport("engine.lua")

-- Imports to keep the keyhandler from working while typing in chat.
Load "chatinputscreen"
Load "consolescreen"
Load "textedit"

PrefabFiles = {
	"luffy", "luffyhat", "luffy_none",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/luffy.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/luffy.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/luffy.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/luffy.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/luffy_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/luffy_silho.xml" ),

    Asset( "IMAGE", "bigportraits/luffy.tex" ),
    Asset( "ATLAS", "bigportraits/luffy.xml" ),
	
	Asset( "IMAGE", "images/map_icons/luffy.tex" ),
	Asset( "ATLAS", "images/map_icons/luffy.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_luffy.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_luffy.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_luffy.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_luffy.xml" ),
	
	Asset( "IMAGE", "bigportraits/luffy_none.tex" ),
    Asset( "ATLAS", "bigportraits/luffy_none.xml" ),
	
	Asset( "IMAGE", "images/names_luffy.tex" ),
    Asset( "ATLAS", "images/names_luffy.xml" ),

}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
GLOBAL.STRINGS.NAMES.LUFFYHAT = "Luffy's Hat"

GLOBAL.TUNING.LUFFY = {}
GLOBAL.TUNING.LUFFY.KEYTWO = GetModConfigData("key2") or 122

local function SecondFn(inst)
if inst:HasTag("playerghost") then return end
if inst.transformed then
inst.AnimState:SetBuild("luffy")
	local x, y, z = inst.Transform:GetWorldPosition()
	local fx = SpawnPrefab("groundpound_fx")
	inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/groundpound")
	fx.Transform:SetPosition(x, y, z)
	SpawnPrefab("collapse_big").Transform:SetPosition(inst:GetPosition():Get())
inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED)
inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED)
inst.components.health.absorb = 0.10
inst.components.temperature.inherentinsulation = 35
inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.5)
inst.components.combat.damagemultiplier = 1

	fx.Transform:SetPosition(x, y, z)
	SpawnPrefab("collapse_big").Transform:SetPosition(inst:GetPosition():Get())

 
else
inst.AnimState:SetBuild("luffysecondgear")
	local x, y, z = inst.Transform:GetWorldPosition()
	local fx = SpawnPrefab("groundpound_fx")
	inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/groundpound")
	fx.Transform:SetPosition(x, y, z)
	SpawnPrefab("collapse_big").Transform:SetPosition(inst:GetPosition():Get())
	SpawnPrefab("mole_move_fx").Transform:SetPosition(inst.Transform:GetWorldPosition())
	for i, v in ipairs(AllPlayers) do
		v:ShakeCamera(CAMERASHAKE.FULL, .7, .02, .3, inst, 40)
	end
inst.components.locomotor.walkspeed = (6)
inst.components.locomotor.runspeed = (8.5)
inst.components.health.absorb = 0.50
inst.components.temperature.inherentinsulation = 35
inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 3)
inst.components.combat.damagemultiplier = 2
 
end
 
inst.transformed = not inst.transformed
 
-- inst.components.health:SetCurrentHealth(1)
-- inst.components.health:DoDelta(0)
return true
 
end
 
AddModRPCHandler("luffy", "SECOND", SecondFn)

-- The character select screen lines
STRINGS.CHARACTER_TITLES.luffy = "Monkey D. Luffy"
STRINGS.CHARACTER_NAMES.luffy = "Luffy"
STRINGS.CHARACTER_DESCRIPTIONS.luffy = "*Eats All Meats\n*Damage Increase\n*Easily Hungry"
STRINGS.CHARACTER_QUOTES.luffy = "\"kaizoku oni ore wa naru!\""

-- Custom speech strings
STRINGS.CHARACTERS.LUFFY = require "speech_luffy"

-- The character's name as appears in-game 
STRINGS.NAMES.LUFFY = "Luffy"

-- The default responses of examining the character
STRINGS.CHARACTERS.GENERIC.DESCRIBE.LUFFY = 
{
	GENERIC = "It's the upcoming pirate king Luffy!",
	ATTACKER = "That Luffy looks shifty...",
	MURDERER = "Murderer!",
	REVIVER = "Luffy, friend of ghosts.",
	GHOST = "Luffy could use a heart.",
}

-- Let the game know character is male, female, or robot
table.insert(GLOBAL.CHARACTER_GENDERS.MALE, "luffy")


AddMinimapAtlas("images/map_icons/luffy.xml")
AddModCharacter("luffy")

