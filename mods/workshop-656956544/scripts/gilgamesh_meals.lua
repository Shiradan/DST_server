local meals =
	{
		----------------冰镇红酒-------------------------
		gilgamesh_cold_redwine =
			{
				test = function(cooker, names, tags) return names.berries and names.berries==2 and tags.frozen and not tags.meat and not tags.fish end,
				priority = 10,
				foodtype = "DRINK",
				health =5,
				hunger =15,
				sanity =37.5,
				perishtime = 9999,
				temperature =-10,
				temperatureduration = 10,
				cooktime = 0.5,

			},
----------------吉尔家美食-------------------------
		gilgamesh_great_meal =
			{
				test = function(cooker, names, tags) return names.gilgamesh_cold_redwine and names.gilgamesh_cold_redwine==1 and tags.meat >=1.5 and tags.fish>=0.5  end,
				priority = 20,
				foodtype = "MEAT",
				health =80,
				hunger =80,
				sanity =80,
				perishtime = 999,
				temperature =30,
				temperatureduration = 10,
				cooktime = 2.1,

			},	
-----------------------------------------

	}

	for k,v in pairs(meals) do
	v.name = k
	v.weight = v.weight or 1
	v.priority = v.priority or 0
end
for k,recipe in pairs(meals) do
	AddCookerRecipe("cookpot", recipe)
end