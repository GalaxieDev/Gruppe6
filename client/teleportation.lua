local yes = true
local no = false

Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Teleportation.Menu
        for _, v in pairs(position) do
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    if ESX.PlayerData.job and ESX.PlayerData.job.name == "g6" then
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z-0.9, 0.0, 0.0, Config.Marker.Rotation, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, no, no, no, no)
                    if distance <= 0.5 then
                        RageUI.Text({message = "Appuyez sur ~g~[E]~s~ pour ouvrir l'ascenceur", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            FreezeEntityPosition(PlayerPedId(), yes)
                            Teleport()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

function Teleport()

    local Teleport = RageUI.CreateMenu("Ascenceur", "Ascenceur ...")
    Teleport:SetRectangleBanner(Config.Banniere.ColorR, Config.Banniere.ColorG, Config.Banniere.ColorB)

    RageUI.Visible(Teleport, not RageUI.Visible(Teleport))
    while Teleport do
    Citizen.Wait(3)
        RageUI.IsVisible(Teleport, yes, yes, yes, function()

            RageUI.ButtonWithStyle("~g~Niveau 0", nil, {RightLabel = "→"}, yes, function(Hovered, Active, Selected)
                if (Selected) then
                    SetEntityCoords(GetPlayerPed(-1), Config.Teleportation.Niv0.x, Config.Teleportation.Niv0.y, Config.Teleportation.Niv0.z, yes, no, no)
                    RageUI.CloseAll()
                end
            end)

            RageUI.ButtonWithStyle("~g~Niveau -1", nil, {RightLabel = "→"}, yes, function(Hovered, Active, Selected)
                if (Selected) then
                    SetEntityCoords(GetPlayerPed(-1), Config.Teleportation.Niv1.x, Config.Teleportation.Niv1.y, Config.Teleportation.Niv1.z, yes, no, no)
                    RageUI.CloseAll()
                end
            end)

    end, function()
    end)


        if not RageUI.Visible(Teleport) then
            FreezeEntityPosition(PlayerPedId(), no)
            Teleport = RMenu:DeleteType("Teleport", yes)
        end
    end
end