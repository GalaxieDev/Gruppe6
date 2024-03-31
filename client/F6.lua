ESX = exports["es_extended"]:getSharedObject()

local yes = true
local no = false
local service = false

function F6G6()

    local main = RageUI.CreateMenu("Gruppe6", "Intéraction Gruppe6")
    local citoyen = RageUI.CreateSubMenu(main, "Intéraction Citoyen", "Gruppe6...")
    local annonce = RageUI.CreateSubMenu(main, "Annonce", "Gruppe6...")
    local fouille = RageUI.CreateSubMenu(citoyen, "Fouille", "Vous fouillez une personne")
    main:SetRectangleBanner(Config.Banniere.ColorR, Config.Banniere.ColorG, Config.Banniere.ColorB)
    citoyen:SetRectangleBanner(Config.Banniere.ColorR, Config.Banniere.ColorG, Config.Banniere.ColorB)
    annonce:SetRectangleBanner(Config.Banniere.ColorR, Config.Banniere.ColorG, Config.Banniere.ColorB)
    fouille:SetRectangleBanner(Config.Banniere.ColorR, Config.Banniere.ColorG, Config.Banniere.ColorB)

    RageUI.Visible(main, not RageUI.Visible(main))
    while main do
        Citizen.Wait(3)
        RageUI.IsVisible(main, true, true, true, function()

            RageUI.Checkbox("→ Prendre son service", nil, check, {}, function(Hovered, Active, Selected, Checked)
            if (Selected) then
                check = Checked

                if Checked then
                    service = true
                    ESX.ShowNotification("Vous avez pris votre ~g~service~s~ !")
                else
                    service = false
                    ESX.ShowNotification("Vous n'êtes plus en ~r~service~s~ !")
                    -- TriggerClientEvent('esx:showNotification', source, "Vous n'êtes plus en ~r~service~s~ !")
                end
            end
        end)

        if service then
            RageUI.Separator("↓ ~p~Intéraction ~s~↓")

            RageUI.ButtonWithStyle("Faire une facture", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                local player, distance = ESX.Game.GetClosestPlayer()
                local playerPed        = GetPlayerPed(-1)
                if (Selected) then
                    local raison = ""
                    local montant = 0
                    AddTextEntry("FMMC_MPM_NA", "Objet de la facture")
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le motif de la facture :", "", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0)
                        Wait(3)
                    end
                    if (GetOnscreenKeyboardResult()) then
                        local result = GetOnscreenKeyboardResult()
                        if result then
                            raison = result
                            result = nil
                            AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                            DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Indiquez le montant de la facture :", "", "", "", "", 30)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0)
                                Wait(3)
                            end
                            if (GetOnscreenKeyboardResult()) then
                                result = GetOnscreenKeyboardResult()
                                if result then
                                    montant = result
                                    result = nil
                                    if player ~= -1 and distance <= 3.0 then
                                        TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, yes)
                                        TaskStartScenarioInPlace(GetPlayerPed(-1), "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, true)
                                        Citizen.Wait(5000)
                                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_g6', ('g6'), montant)
                                        ClearPedTasksImmediately(GetPlayerPed(-1))
                                        TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank', 'Facture envoyée : ', 'Vous avez envoyé une facture d\'un montant de : ~g~'..montant.. '$ ~s~pour cette raison : ~b~' ..raison.. '', 'CHAR_BANK_FLEECA', 9)
                                    else
                                        ESX.ShowNotification("~r~Probleme~s~: Aucuns joueurs proche")
                                    end
                                end
                            end
                        end
                    end
                end
            end)

        RageUI.ButtonWithStyle("Intéraction citoyen", nil, {RightLabel = "→"}, yes, function(Hovered, Active, Selected)
            if (Selected) then
            end
        end, citoyen)

        RageUI.ButtonWithStyle("Faire une annonce", nil, {RightLabel = "→"}, yes, function(Hovered, Active, Selected)
            if (Selected) then
            end
        end, annonce)
    end

    end, function()
    end)

    RageUI.IsVisible(citoyen, yes, yes, yes, function()

        RageUI.Separator("↓ ~g~     Intéractions    ~s~↓")

        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        local target, distance = ESX.Game.GetClosestPlayer()
        playerheading = GetEntityHeading(GetPlayerPed(-1))
        playerlocation = GetEntityForwardVector(PlayerPedId())
        playerCoords = GetEntityCoords(GetPlayerPed(-1))
        local target_id = GetPlayerServerId(target)
        local searchPlayerPed = GetPlayerPed(target)
                                
    RageUI.ButtonWithStyle('Fouiller la personne', nil, {RightLabel = "→"}, closestPlayer ~= -1 and closestDistance <= 3.0, function(_, a, s)
    if a then
        MarquerJoueur()
    if s then
        ClearPedTasksImmediately(GetPlayerPed(-1))
        getPlayerInv(closestPlayer)
    end
end
end, fouille)
                            
            
                        local searchPlayerPed = GetPlayerPed(target)
                    RageUI.ButtonWithStyle("Menotter/démenotter", nil, {RightLabel = "→"}, yes, function(Hovered, Active, Selected)
                        if (Selected) then
                            ClearPedTasksImmediately(GetPlayerPed(-1))
                            local target, distance = ESX.Game.GetClosestPlayer()
                            playerheading = GetEntityHeading(GetPlayerPed(-1))
                            playerlocation = GetEntityForwardVector(PlayerPedId())
                            playerCoords = GetEntityCoords(GetPlayerPed(-1))
                            local target_id = GetPlayerServerId(target)
                            if closestPlayer ~= -1 and closestDistance <= 3.0 then   
                            TriggerServerEvent('galaxie:handcuff', GetPlayerServerId(closestPlayer))
                        else
                            ESX.ShowNotification('~r~Aucun joueurs à proximité~s~')
                        end
                        end
                    end)
            
                        local searchPlayerPed = GetPlayerPed(target)
                        RageUI.ButtonWithStyle("Escorter", nil, {RightLabel = "→"}, yes, function(Hovered, Active, Selected)
                            if (Selected) then
                                ClearPedTasksImmediately(GetPlayerPed(-1))
                                local target, distance = ESX.Game.GetClosestPlayer()
                                playerheading = GetEntityHeading(GetPlayerPed(-1))
                                playerlocation = GetEntityForwardVector(PlayerPedId())
                                playerCoords = GetEntityCoords(GetPlayerPed(-1))
                                local target_id = GetPlayerServerId(target)
                                if closestPlayer ~= -1 and closestDistance <= 3.0 then  
                            TriggerServerEvent('galaxie:drag', GetPlayerServerId(closestPlayer))
                        else
                            ESX.ShowNotification('~r~Aucun joueurs à proximité~s~')
                        end
                        end
                    end)
                    
                        local searchPlayerPed = GetPlayerPed(target)
                        RageUI.ButtonWithStyle("Mettre dans un véhicule", nil, {RightLabel = "→"}, yes, function(Hovered, Active, Selected)
                            if (Selected) then
                                ClearPedTasksImmediately(GetPlayerPed(-1))
                                local target, distance = ESX.Game.GetClosestPlayer()
                                playerheading = GetEntityHeading(GetPlayerPed(-1))
                                playerlocation = GetEntityForwardVector(PlayerPedId())
                                playerCoords = GetEntityCoords(GetPlayerPed(-1))
                                local target_id = GetPlayerServerId(target)
                                if closestPlayer ~= -1 and closestDistance <= 3.0 then  
                            TriggerServerEvent('galaxie:putInVehicle', GetPlayerServerId(closestPlayer))
                        else
                            ESX.ShowNotification('~r~Aucun joueurs à proximité~s~')
                        end
                            end
                        end)
                    
                        local searchPlayerPed = GetPlayerPed(target)
                        RageUI.ButtonWithStyle("Sortir du véhicule", nil, {RightLabel = "→"}, yes, function(Hovered, Active, Selected)
                            if (Selected) then
                                ClearPedTasksImmediately(GetPlayerPed(-1))
                                local target, distance = ESX.Game.GetClosestPlayer()
                                playerheading = GetEntityHeading(GetPlayerPed(-1))
                                playerlocation = GetEntityForwardVector(PlayerPedId())
                                playerCoords = GetEntityCoords(GetPlayerPed(-1))
                                local target_id = GetPlayerServerId(target)
                                if closestPlayer ~= -1 and closestDistance <= 3.0 then  
                            TriggerServerEvent('galaxie:OutVehicle', GetPlayerServerId(closestPlayer))
                        else
                            ESX.ShowNotification('~r~Aucun joueurs à proximité~s~')
                        end
                        end
                    end)

                                            
                end, function() 
                end)

                RageUI.IsVisible(fouille, yes, yes, yes, function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    ExecuteCommand("me fouille")
                    
                    RageUI.Separator("↓ ~r~Argent non déclaré ~s~↓")
                    for k, v  in pairs(ArgentSale) do
                        RageUI.ButtonWithStyle("Argent non déclaré :", nil, {RightLabel = "~g~"..v.label.."$"}, yes, function(_, _, s)
                            if s then
                                local combien = KeyboardInput("Combien ?", '' , '', 8)
                                if tonumber(combien) > v.amount then
                                    RageUI.Popup({message = "~r~Quantité invalide"})
                                else
                                    TriggerServerEvent('galaxie:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                                end
                                RageUI.GoBack()
                            end
                        end)
                    end
            
                    RageUI.Separator("↓ ~r~Objets~s~↓")
                    for k,v  in pairs(Items) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "~g~x"..v.right}, yes, function(_, _, s)
                            if s then
                                local combien = KeyboardInput("Combien ?", '' , '', 8)
                                if tonumber(combien) > v.amount then
                                    RageUI.Popup({message = "~r~Quantité invalide"})
                                else
                                    TriggerServerEvent('galaxie:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                                end
                                RageUI.GoBack()
                            end
                        end)
                    end
        
                    RageUI.Separator("↓ ~r~Armes~s~↓")
                    for k,v  in pairs(Armes) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "avec ~g~"..v.right.. " ~s~balle(s)"}, yes, function(_, _, s)
                            if s then
                                local combien = KeyboardInput("Combien ?", '' , '', 9999999)
                            if tonumber(combien) > v.amount then
                                RageUI.Popup({message = "~r~Quantité invalide"})
                            else
                                TriggerServerEvent('galaxie:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                        end
                            RageUI.GoBack()
                        end
                    end)
                end
            
            end, function() 
            end)

            RageUI.IsVisible(annonce, yes, yes, yes, function()

                RageUI.Separator("↓ ~b~     Listes des annonces    ~s~↓")
                RageUI.ButtonWithStyle("Annonce ouverture",nil, {RightLabel = "→"}, yes, function(Hovered, Active, Selected)
                    if Selected then 
                        TriggerServerEvent('galaxie:ouvert')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonce fermeture",nil, {RightLabel = "→"}, yes, function(Hovered, Active, Selected)
                    if Selected then       
                        TriggerServerEvent('galaxie:fermer')
                    end
                end)

                RageUI.ButtonWithStyle("Annonce recrutement",nil, {RightLabel = "→"}, yes, function(Hovered, Active, Selected)
                    if Selected then    
                        TriggerServerEvent('galaxie:recrutement')
                    end
                end)

                local afficher = false
                if ESX.PlayerData.job and ESX.PlayerData.job.name == "g6" and ESX.PlayerData.job.grade_name == "patron" then
                    afficher = true
                end

                RageUI.ButtonWithStyle("Annonce personnalisé",nil, {RightLabel = "→"}, afficher, function(Hovered, Active, Selected)
                    if (Selected) then 
                        message = KeyboardInput("Quel message voulez-vous envoyez ?", "", 100, no)
                        if message ~= nil and message ~= "" then
                            TriggerServerEvent('galaxie:perso', message)
                        else
                            RageUI.Popup({message = "~r~Quantité invalide !"})
                        end   
                    end
                end)
            
            end, function() 
            end)

            if not RageUI.Visible(main) and not RageUI.Visible(citoyen) and not (annonce) and not (fouille) then
                main = RMenu:DeleteType("main", yes)
            end

    end
end

Keys.Register('F6', 'g6', 'F6 Gruppe6', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'g6' then
        F6G6()
	end
end)

local function MarquerJoueur()
    local ped = GetPlayerPed(ESX.Game.GetClosestPlayer())
    local pos = GetEntityCoords(ped)
    local target, distance = ESX.Game.GetClosestPlayer()
end