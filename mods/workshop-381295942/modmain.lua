PrefabFiles = {
	"shiki", "knife", "knifethrow", "shiki_none",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/shiki.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/shiki.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/shiki.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/shiki.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/shiki_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/shiki_silho.xml" ),

    Asset( "IMAGE", "bigportraits/shiki.tex" ),
    Asset( "ATLAS", "bigportraits/shiki.xml" ),
	
	Asset( "IMAGE", "images/map_icons/shiki.tex" ),
	Asset( "ATLAS", "images/map_icons/shiki.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_shiki.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_shiki.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_shiki.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_shiki.xml" ),
	
	Asset( "IMAGE", "bigportraits/shiki_none.tex" ),
    Asset( "ATLAS", "bigportraits/shiki_none.xml" ),
	
	Asset( "IMAGE", "images/names_shiki.tex" ),
    Asset( "ATLAS", "images/names_shiki.xml" ),

}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
GLOBAL.STRINGS.NAMES.KNIFE = "Knife"
GLOBAL.STRINGS.NAMES.KNIFETHROW = "Throwing Knife"
local IsServer = GLOBAL.TheNet:GetIsServer()

function setAutoCatch(inst)
    if IsServer then
		local oldhit = inst.components.projectile.Hit
		function inst.components.projectile:Hit(target)
			if target == self.owner and target.components.catcher then
				target:PushEvent("catch", {projectile = self.inst})
				self.inst:PushEvent("caught", {catcher = target})
				self:Catch(target)
				target.components.catcher:StopWatching(self.inst)
			else
				oldhit(self, target)
			end
		end
	end
end

AddPrefabPostInit("knifethrow", setAutoCatch)

-- The character select screen lines
STRINGS.CHARACTER_TITLES.shiki = "Ryougi Shiki"
STRINGS.CHARACTER_NAMES.shiki = "Shiki"
STRINGS.CHARACTER_DESCRIPTIONS.shiki = "*High Damage\n*Semi-winter resistant\n*Fast Sanity Loss"
STRINGS.CHARACTER_QUOTES.shiki = "\"I can kill anything that exists - even if it's a god.\""

-- Custom speech strings
STRINGS.CHARACTERS.SHIKI = require "speech_shiki"

-- The character's name as appears in-game 
STRINGS.NAMES.SHIKI = "Shiki"

-- The default responses of examining the character
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SHIKI = 
{
	GENERIC = "Shiki doesn't look so happy. At all.",
	ATTACKER = "That Shiki looks shifty...",
	MURDERER = "Murderer!",
	REVIVER = "Shiki, friend of ghosts.",
	GHOST = "Shiki could use a heart.",
}

-- Let the game know character is male, female, or robot
table.insert(GLOBAL.CHARACTER_GENDERS.FEMALE, "shiki")


AddMinimapAtlas("images/map_icons/shiki.xml")
AddModCharacter("shiki")

