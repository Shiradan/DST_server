local assets =
{
	Asset( "ANIM", "anim/okita.zip" ),
	Asset( "ANIM", "anim/ghost_okita_build.zip" ),
}

local skins =
{
	normal_skin = "okita",
	ghost_skin = "ghost_okita_build",
}

local base_prefab = "okita"

local tags = {"OKITA", "CHARACTER"}

return CreatePrefabSkin("okita_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	tags = tags,
	
	skip_item_gen = true,
	skip_giftable_gen = true,
})