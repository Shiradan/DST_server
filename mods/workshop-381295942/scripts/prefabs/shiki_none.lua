local assets =
{
	Asset( "ANIM", "anim/shiki.zip" ),
	Asset( "ANIM", "anim/ghost_shiki_build.zip" ),
}

local skins =
{
	normal_skin = "shiki",
	ghost_skin = "ghost_shiki_build",
}

local base_prefab = "shiki"

local tags = {"SHIKI", "CHARACTER"}

return CreatePrefabSkin("shiki_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	tags = tags,
	
	skip_item_gen = true,
	skip_giftable_gen = true,
})