Assets = {}

function AddIcons(prefab)
        table.insert(Assets, Asset("IMAGE", "images/" .. prefab .. ".tex"))
        table.insert(Assets, Asset("ATLAS", "images/" .. prefab .. ".xml"))
        AddMinimapAtlas("images/" .. prefab .. ".xml")
        AddPrefabPostInit(prefab, function(inst)
        inst.entity:AddMiniMapEntity()
        inst.MiniMapEntity:SetIcon(prefab .. ".tex")
        end)
end

List =
{
        "beefalo",                                      
        "babybeefalo",                          
        "carrot_planted",                       
        "flint",                                       
        "rabbithole",                          
        "rocky",                                                         
        "lightninggoat",                        
        "molehill",                                     
        "koalefant_winter",                     
        "koalefant_summer",                     
        "blue_mushroom",                        
        "red_mushroom",                         
        "green_mushroom",                       
        "mandrake",                                     
        "hound",                                        
        "firehound",                            
        "icehound",                                     
        "skeleton",                                     
        "rock2",                                        
        "fireflies",                            
        "dirtpile",                                     
        "animal_track",                         
        "tentacle",                                     
        "chester_eyebone",                             
        "pighead",                                      
        "krampus",                                      
        "minotaur",                                     
        "bat",                                          
        "spider_hider",                         
        "bishop",                                       
        "bishop_nightmare",                     
        "knight",                                       
        "knight_nightmare",                     
        "rook",                                         
        "rook_nightmare",                       
        "spider_dropper",                       
        "worm",                                         
        "walrus",                                       
        "tentacle_pillar",                      
        "bunnyman",                                     
        "leif",                                         
        "leif_sparse",                          
        "spiderqueen",                          
        "moose",                                        
        "mooseegg",                                     
        "dragonfly",                            
        "deerclops",                            
        "bearger",                                      
        "warg",                                         
        "sandbagsmall",
        "wall_hay",
        "wall_wood",
        "wall_stone",
        "wall_limestone",
        "wall_ruins",
}

        for k,v in pairs(List) do
        AddIcons(v)
end