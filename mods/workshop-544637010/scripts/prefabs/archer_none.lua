local assets =
{
	Asset( "ANIM", "anim/archer.zip" ),
	Asset( "ANIM", "anim/ghost_archer_build.zip" ),
}

local skins =
{
	normal_skin = "archer",
	ghost_skin = "ghost_archer_build",
}

local base_prefab = "archer"

local tags = {"ARCHER", "CHARACTER"}

return CreatePrefabSkin("archer_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	tags = tags,
	
	skip_item_gen = true,
	skip_giftable_gen = true,
})