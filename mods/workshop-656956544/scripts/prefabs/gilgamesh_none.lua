local assets =
{
	Asset( "ANIM", "anim/gilgamesh.zip" ),
	Asset( "ANIM", "anim/ghost_archer_build.zip" ),
}

local skins =
{
	normal_skin = "gilgamesh",
	ghost_skin = "ghost_archer_build",
}

local base_prefab = "gilgamesh"

local tags = {"GILGAMESH", "CHARACTER"}

return CreatePrefabSkin("gilgamesh_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	tags = tags,
	
	skip_item_gen = true,
	skip_giftable_gen = true,
})