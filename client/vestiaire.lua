ESX = exports["es_extended"]:getSharedObject()

local yes = true
local no = false

function VestiaireG6()
    local VestiaireG6 = RageUI.CreateMenu("Vestiaire", "Vestiaire du Gruppe6")
    VestiaireG6:SetRectangleBanner(Config.Banniere.ColorR, Config.Banniere.ColorG, Config.Banniere.ColorB)
        RageUI.Visible(VestiaireG6, not RageUI.Visible(VestiaireG6))
            while VestiaireG6 do
            Citizen.Wait(3)
            RageUI.IsVisible(VestiaireG6, yes, yes, yes, function()

                RageUI.ButtonWithStyle("→ Reprendre ses vêtements",nil, {nil}, yes, function(Hovered, Active, Selected)
                    if (Selected) then
                        ExecuteCommand'e adjust'
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                        end)
                    end
                end)

                RageUI.Line()
    
            for i, v in pairs(Config.Vestiaire.Tenues) do
                RageUI.ButtonWithStyle("→ " .. v.name, nil, {nil}, yes, function(Hovered, Active, Selected)
                    if (Selected) then
                        ExecuteCommand'e adjust'

                        SetPedComponentVariation(GetPlayerPed(-1) , 8, v.tshirt, v.tshirt2) 
                        SetPedComponentVariation(GetPlayerPed(-1) , 11, v.torse, v.torse2)  
                        SetPedComponentVariation(GetPlayerPed(-1) , 3, v.bras, 0)  
                        SetPedComponentVariation(GetPlayerPed(-1) , 4, v.pantalon, v.pantalon2)  
                        SetPedComponentVariation(GetPlayerPed(-1) , 6, v.chaussures, v.chaussures2)   
                        SetPedComponentVariation(GetPlayerPed(-1) , 10, v.badge, v.badge2)   
                        SetPedComponentVariation(GetPlayerPed(-1) , 9, v.gilet, v.gilet2)   
                    end
                end)
            end

                RageUI.ButtonWithStyle("→ Fermer ton ~r~casier",nil, {RightLabel = ""}, yes, function(Hovered, Active, Selected)
                    if (Selected) then
                    FreezeEntityPosition(PlayerPedId(), no)
                    
                    RageUI.CloseAll()
                    end
                end)

    
            end, function()
            end, 1)

            if not RageUI.Visible(VestiaireG6) then
                VestiaireG6 = RMenu:DeleteType("VestiaireG6", yes)
                FreezeEntityPosition(PlayerPedId(), no)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Pos.Vestiaire
        for _, v in pairs(position) do
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    if ESX.PlayerData.job and ESX.PlayerData.job.name == "g6" then
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z-0.9, 0.0, 0.0, Config.Marker.Rotation, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, no, no, no, no)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~g~[E]~s~ pour ouvrir le vestiaire", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            FreezeEntityPosition(PlayerPedId(), yes)
                            VestiaireG6()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)