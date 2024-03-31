ESX = exports["es_extended"]:getSharedObject()

local yes = true
local no = false
local gestion = false

function PatronG6()
    local PatronG6 = RageUI.CreateMenu("Société", "Entreprise Gruppe6")
    PatronG6:SetRectangleBanner(Config.Banniere.ColorR, Config.Banniere.ColorG, Config.Banniere.ColorB)

    RageUI.Visible(PatronG6, not RageUI.Visible(PatronG6))

    while PatronG6 do
        Citizen.Wait(3)
    RageUI.IsVisible(PatronG6, yes, yes, yes, function()

        if not gestion then
        RageUI.Separator("↓ ~r~  Argent total de la société ~s~↓")

            if GMoney ~= nil then
                RageUI.Separator("Argent de l'entreprise : ~b~".. GMoney .. "$")
            end

            RageUI.Separator("↓     ~g~Gestion de l'entreprise    ~s~↓")
        
            RageUI.ButtonWithStyle("Déposer de l'argent", nil, {RightLabel = "→"}, yes, function(Hovered, Active, Selected)
                if (Selected) then
                    local number = KeyboardInput("Nombre ?", "", 50)
                    TriggerServerEvent('galaxie:deposer', number)
                    GRefresh()   
                end
            end)

            RageUI.ButtonWithStyle("Retirer de l'argent", nil, {RightLabel = "→"}, yes, function(Hovered, Active, Selected)
                if (Selected) then
                    local number2 = KeyboardInput("Nombre ?", "", 50)
                    TriggerServerEvent('galaxie:retirer', number2)
                    GRefresh() 
                end
            end)

            RageUI.ButtonWithStyle("Gestion employé", nil, {RightLabel = "→"}, yes, function(Hovered, Active, Selected)
                if (Selected) then
                    gestion = yes
                end
            end)
        end

        if gestion then

            RageUI.ButtonWithStyle("~g~Recruter~s~ la personne", nil, {RightLabel = "→"}, yes, function(Hovered, Active, Selected)
                if Selected then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        TriggerServerEvent('galaxie:recruter', GetPlayerServerId(closestPlayer))
                    else
                        RageUI.Popup({message = "~r~Aucune personne~s~ à proximité"})
                    end 
                end
            end)

            RageUI.ButtonWithStyle("~r~Virer~s~ la personne", nil, {RightLabel = "→"}, yes, function(Hovered, Active, Selected)
                if Selected then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        TriggerServerEvent('galaxie:virer', GetPlayerServerId(closestPlayer))
                    else
                        RageUI.Popup({message = "~r~Aucune personne~s~ à proximité"})
                    end 
                end
            end)

            RageUI.ButtonWithStyle("~g~Gradé~s~ la personne", nil, {RightLabel = "→"}, yes, function(Hovered, Active, Selected)
                if Selected then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        TriggerServerEvent('galaxie:rank', GetPlayerServerId(closestPlayer))
                    else
                        RageUI.Popup({message = "~r~Aucune personne~s~ à proximité"})
                    end 
                end
            end)

            RageUI.ButtonWithStyle("~r~Dégradé~s~ la personne", nil, {RightLabel = "→"}, yes, function(Hovered, Active, Selected)
                if Selected then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        TriggerServerEvent('galaxie:derank', GetPlayerServerId(closestPlayer))
                    else
                        RageUI.Popup({message = "~r~Aucune personne~s~ à proximité"})
                    end 
                end
            end)

            RageUI.ButtonWithStyle("~r~Fermer le menu", nil, {RightLabel = "→"}, yes, function(Hovered, Active, Selected)
                if (Selected) then
                    gestion = no
                    RageUI.CloseAll()
                end
            end)
        end

        end, function()
        end)

        if not RageUI.Visible(PatronG6) then
            PatronG6=RMenu:DeleteType("PatronG6", yes)
            FreezeEntityPosition(GetPlayerPed(-1), no)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Pos.Patron
        for _, v in pairs(position) do
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    if ESX.PlayerData.job and ESX.PlayerData.job.name == "g6" and ESX.PlayerData.job.grade_name == "patron" then
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z-0.9, 0.0, 0.0, Config.Marker.Rotation, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, no, no, no, no)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~g~[E]~s~ pour accéder au compte de la société", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            FreezeEntityPosition(PlayerPedId(), yes)
                            GRefresh()   
                            PatronG6()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

-- function Refresh
    function GRefresh()
        if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'patron' then
            ESX.TriggerServerCallback('galaxie:refresh', function(accountEv)
                GMoney = accountEv
            end)
        end
    end

--- Fonction KeyboardInput
KeyboardInput = function(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(3)
    end
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end