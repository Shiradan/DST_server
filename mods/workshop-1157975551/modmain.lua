PrefabFiles = {
    "mapiconhelper",
}

local general = {
	"flotsam",
	"spiderden",
	"spiderden_2",
	"spiderden_3",
	"spiderhole",
	"slurtlehole",
	"catcoonden",
	"wallyintro_debris_1",
	"wallyintro_debris_2",
	"wallyintro_debris_3",
	"wallyintro_shipmast",
	"crate"
	--"tallbirdnest"
	--"tallbirdegg"
}

local tracks = {
	"animal_track",
	"dirtpile",
	"whale_bubbles"
}

local bones = {
	"houndbone", 
	"skeleton"
}

local holes = {
	"molehill",
	"rabbithole",
	"crabhole"
}

local things = {
	"teleportato_box",
	"teleportato_crank",
	"teleportato_potato",
	"teleportato_ring"
}

local walls = {
	"sandbagsmall",
	"wall_hay",
	"wall_limestone",
	"wall_ruins",
	"wall_stone",
	"wall_wood"
}

local vegetation = {
	"green_mushroom",
	"blue_mushroom",
	"red_mushroom",
	"carrot_planted",
	"seeds",
	"marsh_bush"
}

local pigs_rituals = {
	"pigtorch",
	"pighead",
	"mermhead",
	"wildborehead"
}

local chester_packim_bones = {
	"chester_eyebone",
	"packim_fishbone"
}

local tools = {
	"axe",
	"goldenaxe",
	"axe_obsidian",
	"pickaxe",
	"goldenpickaxe",
	"shovel",
	"goldenshovel",
	"machete",
	"goldenmachete",
	"machete_obsidian",
	"hammer",
	"pitchfork",
	"razor"
}

local minerals = {
	"flint",
	"rock2",
	"rocks",
	"goldnugget",
	"obsidian",
	"sandhill"
}

local flowers = {
	"flower"
}

local seashells = {
	"seashell_beached"
}

local basic_mobs = {
	"babybeefalo",
	"beefalo",
	"bishop",
	"catcoon",
	"chester",
	"deer",
	"deer_blue",
	"deer_red",
	"doydoy",
	"doydoybaby",
	"firehound",
	"glommer",
	"grassgekko",
	"hound",
	"hutch",
	"icehound",
	"jellyfish_planted",
	"knight",
	"knightboat",
	"koalefant_summer",
	"koalefant_winter",
	"krampus",
	"lightninggoat",
	"mandrake",
	"mandrake_active",
	"mandrake_planted",
	"minotaur",
	"musselfarm",
	"musselfarm_seed",
	"packim",
	"pigman",
	"rainbowjellyfish_planted",
	"rocky",
	"rook",
	"sharkitten",
	"sharx",
	"slurper",
	"slurtle",
	"snurtle",
	"solofish",
	"spat",
	"stungray",
	"swordfish",
	"tallbird",
	"tentacle",
	"tigershark",
	"walrus",
	"warg",
	"whale_blue",
	"whale_carcass_blue",
	"whale_carcass_white",
	"whale_white",
	"wildbore",
	"worm"
}

local giants = {
	"antlion",
	"bearger",
	"deerclops",
	"dragonfly",
	"kraken",
	"leif",
	"leif_sparse",
	"moose",
	"treeguard",
	"twister",
	"twister_seal"
}

local more_mobs = {
	"abigail",
	"ballphin",
	"bat",
	"bee",
	"birchnutdrake",
	"bunnyman",
	"butterfly",
	"canary",
	"canary_poisoned",
	"cormorant",
	"crab",
	"crawlinghorror",
	"crawlingnightmare",
	"crow",
	"dragoon",
	"eyeplant",
	"fireflies",
	"flup",
	"frog",
	"ghost",
	"killerbee",
	"kraken_tentacle",
	"lavae",
	"lavae_pet",
	"little_walrus",
	"merm",
	"mermfisher",
	"mole",
	"monkey",
	"mosquito",
	"mosquito_poison",
	"mossling",
	"nightmarebeak",
	"parrot",
	"perd",
	"pirateghost",
	"primeape",
	"rabbit",
	"robin",
	"robin_winter",
	"seagull",
	"snake",
	"snake_poison",
	"spider",
	"spiderqueen",
	"spider_dropper",
	"spider_hider",
	"spider_spitter",
	"spider_warrior",
	"stalker",
	"stalker_atrium",
	"stalker_forest",
	"stalker_minion1",
	"stalker_minion2",
	"swimminghorror",
	"tentacle_pillar",
	"terrorbeak",
	"toucan"
}

Assets = {
	Asset("ATLAS", "images/icons.xml"),
	Asset("IMAGE", "images/icons.tex"),
	Asset("ATLAS", "images/icons_red.xml"),
	Asset("IMAGE", "images/icons_red.tex"),
	Asset("ATLAS", "images/icons_yellow.xml"),
	Asset("IMAGE", "images/icons_yellow.tex"),
	Asset("ATLAS", "images/icons_red_yellow.xml"),
	Asset("IMAGE", "images/icons_red_yellow.tex")
}

local border = GetModConfigData("Icons_Border")

if (border ~= false) then
	if (border == "red") then
		AddMinimapAtlas("images/icons_red.xml")
	elseif (border == "yellow") then
		AddMinimapAtlas("images/icons_yellow.xml")
	elseif (border == "red_yellow") then
		AddMinimapAtlas("images/icons_red_yellow.xml")
	end
else
	AddMinimapAtlas("images/icons.xml")
end

local function AddMapIcon(inst)
	inst:AddComponent("mapiconhandler")
	inst.components.mapiconhandler.helper.entity:AddMiniMapEntity():SetIcon(inst.prefab .. ".tex")
end

function AddIconsMap(group)
	for entities_count = 1, #group do
		local entity = group[entities_count]
		AddPrefabPostInit(entity, AddMapIcon)
	end
end

AddIconsMap(general, "general")

if GetModConfigData("Basic_Mobs") then
	AddIconsMap(basic_mobs)
end

if GetModConfigData("More_Mobs") then
	AddIconsMap(more_mobs)
end

if GetModConfigData("Giants") then
	AddIconsMap(giants)
end

if GetModConfigData("Tools") then
	AddIconsMap(tools)
end

if GetModConfigData("Minerals") then
	AddIconsMap(minerals)
end

if GetModConfigData("Bones") then
	AddIconsMap(bones)
end

if GetModConfigData("Chester_Packim_Bones") then
	AddIconsMap(chester_packim_bones)
end

if GetModConfigData("Holes") then
	AddIconsMap(holes)
end

if GetModConfigData("Vegetation") then
	AddIconsMap(vegetation)
end

if GetModConfigData("Flowers") then
	AddIconsMap(flowers)
end

if GetModConfigData("Pigs_Rituals") then
	AddIconsMap(pigs_rituals)
end

if GetModConfigData("Things") then
	AddIconsMap(things)
end

if GetModConfigData("Walls") then
	AddIconsMap(walls)
end

if GetModConfigData("Tracks") then
	AddIconsMap(tracks)
end