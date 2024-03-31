Config = {}

Config.Farm = {
    Recolte = {
        vector3(308.15093994141, -280.46520996094, 54.16455078125),
        vector3(-356.51330566406, -50.102649688721, 49.03636932373),
        vector3(-1216.5416259766, -334.08450317383, 37.780872344971),
        vector3(144.53785705566, -1040.7042236328, 29.367876052856),
        vector3(-2961.1518554688, 477.87490844727, 15.696907043457),
        vector3(1179.9754638672, 2708.2180175781, 38.087852478027),
        vector3(-105.51268768311, 6476.3139648438, 31.626695632935)
}, -- position des recoltes de sac
    Vente = {vector3(295.8674621582, 220.93737792969, 97.68815612793)}, -- position de la vente de sac
}

Config.Pos = {
    Blips = {vector3(-229.70288085938, -848.08349609375, 30.680969238281)},
    Patron = {vector3(-238.07081604004, -833.13323974609, 30.683904647827)}, -- position du menu patron
    Vestiaire = {vector3(-219.09368896484, -822.92620849609, 30.683362960815)}, -- position du menu vestiaire
    Garage = {vector3(-233.2354888916, -860.31494140625, 30.429727554321)}, -- position du menu du garage
    Rangement = {vector3(-234.9772644043, -863.46936035156, 30.391296386719)}, -- position du menu du rangement de véhicule
    Coffre = {vector3(11.720339775085, -662.33447265625, 16.130630493164)} -- position du coffre 
}

Config.Teleportation = {
    Menu = {vector3(10.223519325256, -668.05151367188, 33.449104309082),
            vector3(5.8564910888672, -708.78729248047, 16.131008148193)},
    Niv0 = {x = 10.166884422302, y = -667.91882324219, z = 33.449184417725},
    Niv1 = {x = 5.8115854263306, y = -708.85577392578, z = 16.131010055542},
}

Config.Marker = {
    Type = 6, -- Type de marker
    Rotation = 360.0, -- Régler sur 0.0 pour remettre à la normal 
    ColorR = 20, ColorG = 95, ColorB = 7, -- couleur RGB des marker
    Opacite = 180, -- Opacité du marker
    Saute = false, -- Si le marker saute (true = saute)
    Tourne = false -- Si le marker tourne (true = tourne)
}

Config.Time = {
    Recolte = 0.0025, -- Temps pour atteindre les 100% de la bart de chargement (recolte)
    Vente = 0.0025 -- Temps pour atteindre les 100% de la bart de chargement (vente)
}

Config.Banniere = {
    ColorR = 20, ColorG = 95, ColorB = 7 -- couleur des menu du job (en RGB)
}

Config.Economie = {
    Price = 180, -- Argent liquide reçus pour la vente de 1 sac d'argent
    Entreprise = 180, -- Argent que l'entreprise reçoit pour la vente de 1 sac d'argent
    Sale = 250 -- Argent sale qu'un joueur reçoit lors de l'ouverture de 1 sac d'argent 
}

Config.Vestiaire = { -- possibilité de crée autant de tenu que l'on souhaite
    Tenues = {
    {
        name = "Tenu recrue", -- nom de la tenu
        tshirt = 15, tshirt2 = 0, -- tshirt
        torse = 318, torse2 = 1, -- torse
        bras = 19, -- bras
        pantalon = 47, pantalon2 = 1, -- pantalon
        chaussures = 54, chaussures2 = 0, -- chaussures
        badge = 76, badge2 = 0, -- badge
        gilet = 0, gilet2 = 0, -- gilet
    },
    {
        name = "Tenu employé", -- nom de la tenu
        tshirt = 15, tshirt2 = 0, -- tshirt
        torse = 316, torse2 = 1, -- torse
        bras = 20, -- bras
        pantalon = 47, pantalon2 = 1, -- pantalon
        chaussures = 54, chaussures2 = 0, -- chaussures
        badge = 71, badge2 = 0 -- badge
    },
    {
        name = "Tenu chef d'équipe", -- nom de la tenu
        tshirt = 15, tshirt2 = 0, -- tshirt
        torse = 316, torse2 = 8, -- torse
        bras = 20, -- bras
        pantalon = 47, pantalon2 = 1, -- pantalon
        chaussures = 54, chaussures2 = 0, -- chaussures
        badge = 71, badge2 = 0, -- badge
        gilet = 0, gilet2 = 0, -- gilet
    },
    {
        name = "Tenu patron", -- nom de la tenu
        tshirt = 15, tshirt2 = 0, -- tshirt
        torse = 316, torse2 = 5, -- torse
        bras = 20, -- bras
        pantalon = 47, pantalon2 = 1, -- pantalon
        chaussures = 54, chaussures2 = 0, -- chaussures
        badge = 71, badge2 = 0, -- badge
        gilet = 0, gilet2 = 0, -- gilet
    },
    {
        name = "Costard patron", -- nom de la tenu
        tshirt = 15, tshirt2 = 0, -- tshirt
        torse = 322, torse2 = 0, -- torse
        bras = 1, -- bras
        pantalon = 28, pantalon2 = 8, -- pantalon
        chaussures = 10, chaussures2 = 0, -- chaussures
        badge = 71, badge2 = 0, -- badge
        gilet = 0, gilet2 = 0, -- gilet
    }
}}

Config.Garage = {
    g6 = {      -- Les véhicules dispo, possible de crée plusieurs ligne                                                     
        vehicules = {                                                           
            {category = "↓ ~b~Véhicules ~s~↓"},                           
			{model = "gruppe1", label = "Coupé"},
            {model = "gruppe2", label = "Dodge"},
            {model = "gruppe3", label = "SUV"},
            {model = "stockade", label = "Stockade"},
        },
    }
}

Config.Spawn = {
	spawnvoiture = {position = {x = -232.43911743164, y = -865.1201171875, z = 30.334634780884, h = 64.5064926147461}} -- Position point de spawn voiture
}

Config.Webhook = {
    Ouverture = "https://discord.com/api/webhooks/1106857862728273920/NuFalNUe2vwbOgd42LV9odJisddsX3JtF3Wc6v4ufbo0gpmDtrTvUu1IuiWfypdnRPvs", -- Logs d'ouverture de sacs
    Logs = "https://discord.com/api/webhooks/1106857862728273920/NuFalNUe2vwbOgd42LV9odJisddsX3JtF3Wc6v4ufbo0gpmDtrTvUu1IuiWfypdnRPvs" -- Logs général du job
}