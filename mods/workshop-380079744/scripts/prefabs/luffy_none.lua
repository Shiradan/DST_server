local assets =
{
	Asset( "ANIM", "anim/luffy.zip" ),
	Asset( "ANIM", "anim/ghost_luffy_build.zip" ),
}

local skins =
{
	normal_skin = "luffy",
	ghost_skin = "ghost_luffy_build",
}

local base_prefab = "luffy"

local tags = {"LUFFY", "CHARACTER"}

return CreatePrefabSkin("luffy_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	tags = tags,
	
	skip_item_gen = true,
	skip_giftable_gen = true,
})