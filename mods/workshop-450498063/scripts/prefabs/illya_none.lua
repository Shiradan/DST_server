local assets =
{
	Asset( "ANIM", "anim/illya.zip" ),
	Asset( "ANIM", "anim/ghost_illya_build.zip" ),
}

local skins =
{
	normal_skin = "illya",
	ghost_skin = "ghost_illya_build",
}

local base_prefab = "illya"

local tags = {"ILLYA", "CHARACTER"}

return CreatePrefabSkin("illya_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	tags = tags,
	
	skip_item_gen = true,
	skip_giftable_gen = true,
})