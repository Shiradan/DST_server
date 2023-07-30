local assets =
{
	Asset( "ANIM", "anim/deadpool.zip" ),
	Asset( "ANIM", "anim/ghost_deadpool_build.zip" ),
}

local skins =
{
	normal_skin = "deadpool",
	ghost_skin = "ghost_deadpool_build",
}

local base_prefab = "deadpool"

local tags = {"DEADPOOL", "CHARACTER"}

return CreatePrefabSkin("deadpool_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	tags = tags,
	
	skip_item_gen = true,
	skip_giftable_gen = true,
})