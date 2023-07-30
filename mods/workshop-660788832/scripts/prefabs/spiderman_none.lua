local assets =
{
	Asset( "ANIM", "anim/spiderman.zip" ),
	Asset( "ANIM", "anim/ghost_spiderman_build.zip" ),
}

local skins =
{
	normal_skin = "spiderman",
	ghost_skin = "ghost_spiderman_build",
}

local base_prefab = "spiderman"

local tags = {"Spiderman", "CHARACTER"}

return CreatePrefabSkin("spiderman_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	tags = tags,
	
	skip_item_gen = true,
	skip_giftable_gen = true,
})