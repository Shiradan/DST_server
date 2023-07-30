local assets =
{
	Asset( "ANIM", "anim/lancerpower.zip" ),
	Asset( "ANIM", "anim/ghost_lancer_build.zip" ),
}

local skins =
{
	normal_skin = "lancerpower",
	ghost_skin = "ghost_lancer_build",
}

local base_prefab = "lancer"

local tags = {"LANCERPOWER", "CHARACTER"}

return CreatePrefabSkin("lancerpower_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	tags = tags,
	
	skip_item_gen = true,
	skip_giftable_gen = true,
})