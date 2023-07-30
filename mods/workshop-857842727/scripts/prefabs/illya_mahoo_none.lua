local assets =
{
	Asset( "ANIM", "anim/illya_mahoo.zip" ),
	Asset( "ANIM", "anim/ghost_illya_mahoo_build.zip" ),
}

local skins =
{
	normal_skin = "illya_mahoo",
	ghost_skin = "ghost_illya_mahoo_build",
}

local base_prefab = "illya_mahoo"

local tags = {"ILLYA_MAHOO", "CHARACTER"}

return CreatePrefabSkin("illya_mahoo_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	tags = tags,
	
	skip_item_gen = true,
	skip_giftable_gen = true,
})