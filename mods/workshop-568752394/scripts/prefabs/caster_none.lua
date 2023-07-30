local assets =
{
	Asset( "ANIM", "anim/caster.zip" ),
	Asset( "ANIM", "anim/ghost_caster_build.zip" ),
}

local skins =
{
	normal_skin = "caster",
	ghost_skin = "ghost_caster_build",
}

local base_prefab = "caster"

local tags = {"CASTER", "CHARACTER"}

return CreatePrefabSkin("caster_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	tags = tags,
	
	skip_item_gen = true,
	skip_giftable_gen = true,
})