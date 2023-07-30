local assets =
{
	Asset( "ANIM", "anim/lancer.zip" ),
	Asset( "ANIM", "anim/ghost_lancer_build.zip" ),
}

local skins =
{
	normal_skin = "lancer",
	ghost_skin = "ghost_lancer_build",
}

local base_prefab = "lancer"

local tags = {"LANCER", "CHARACTER"}

return CreatePrefabSkin("lancer_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	tags = tags,
	
	skip_item_gen = true,
	skip_giftable_gen = true,
})