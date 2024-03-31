ESX = exports["es_extended"]:getSharedObject()

local yes = true
local no = false
local load = 0.0

-- Blips --
-- Blips job
Citizen.CreateThread(function()
        for _, pos in pairs(Config.Pos.Blips) do
            local blips = AddBlipForCoord(pos)
            SetBlipSprite(blips, 67)
            SetBlipScale(blips, 0.7)
            SetBlipColour(blips, 52)
            SetBlipAsShortRange(blips, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Gruppe 6")
            EndTextCommandSetBlipName(blips)
    end
end)

-- Blips récolte
Citizen.CreateThread(function()
    while true do
        local nb_blips = 0
        Citizen.Wait(5000)
        for _, pos in pairs(Config.Farm.Recolte) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "g6" then
                nb_blips = 1
                local recolte = AddBlipForCoord(pos)
                SetBlipSprite(recolte, 256)
                SetBlipScale(recolte, 0.5)
                SetBlipColour(recolte, 52)
                SetBlipAsShortRange(recolte, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("Récolte de billets")
                EndTextCommandSetBlipName(recolte)
            end
        end
        if nb_blips == 1 then break end
    end
end)

-- blips Vente
Citizen.CreateThread(function()
    while true do
        local nb_blips = 0
        Citizen.Wait(5000)
        for _, pos in pairs(Config.Farm.Vente) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "g6" then
                local vente = AddBlipForCoord(pos)
                SetBlipSprite(vente, 256)
                SetBlipScale(vente, 0.5)
                SetBlipColour(vente, 52)
                SetBlipAsShortRange(vente, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("Vente de billets")
                EndTextCommandSetBlipName(vente)
            end
        end
        if nb_blips == 1 then break end
    end
end)
----------------------------------------------------------------

-- Marker récolte 
Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Farm.Recolte
        for _, v in pairs(position) do
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    if ESX.PlayerData.job and ESX.PlayerData.job.name == "g6" then
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z-0.9, 0.0, 0.0, Config.Marker.Rotation, 0.0, 0.0, 0.0, 5.5, 5.5, 5.5, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, no, no, no, no)
                    if distance <= 3.5 then
                        RageUI.Text({message = "Appuyez sur ~g~[E]~s~ pour récolter des sacs de billets", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            OpenRecBillet()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

-- Fonction récolte de billets
function OpenRecBillet()
    local recolte = RageUI.CreateMenu("Récolte", "Récolte de billets")
    local onrecolte = no
    recolte:SetRectangleBanner(Config.Banniere.ColorR, Config.Banniere.ColorG, Config.Banniere.ColorB)

    RageUI.Visible(recolte, not RageUI.Visible(recolte))
    while recolte do
        FreezeEntityPosition(PlayerPedId(), yes)
        Citizen.Wait(3)
        RageUI.IsVisible(recolte, yes, no, yes, function()

        if not onrecolte then
            RageUI.ButtonWithStyle("Récolter des sacs de billets", nil, {RightLabel = "~g~→"},yes, function(Hovered, Active, Selected)
                if Selected then
                onrecolte = yes
                TaskStartScenarioInPlace(GetPlayerPed(-1), "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
                end
            end)
        else
            RageUI.PercentagePanel(load, "Récolte en cours (~b~" .. math.floor(load * 100) .. "%~s~)", "", "", function(_, a_, percent)
                if load < 1.0 then
                    load = load + Config.Time.Recolte
                else
                    load = 0
                    TriggerServerEvent("galaxie:recolte")
                end
            end)

            RageUI.ButtonWithStyle("~r~Arrêter de récolter~s~", nil, {RightBadge = RageUI.BadgeStyle.Alert}, yes, function(Hovered, Active, Selected)
                if Selected then
                    RageUI.CloseAll()
                    onrecolte = no
                end
            end)

        end

        end, function()  
        end)

        if not RageUI.Visible(recolte) then
            recolte = RMenu:DeleteType("recolte", yes)
            onrecolte = no
            ClearPedTasksImmediately(GetPlayerPed(-1))
            FreezeEntityPosition(PlayerPedId(), no)
        end
    end
end

-- Marker vente
Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Farm.Vente
        for _, v in pairs(position) do
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 20.0 then
                    interval = 0
                    if ESX.PlayerData.job and ESX.PlayerData.job.name == "g6" then
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z-0.9, 0.0, 0.0, Config.Marker.Rotation, 0.0, 0.0, 0.0, 5.5, 5.5, 5.5, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, no, no, no, no)
                    if distance <= 3.5 then
                        RageUI.Text({message = "Appuyez sur ~g~[E]~s~ pour vendre les sacs de billets", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            OpenVenteBillet()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

-- Fonction vente de billets
function OpenVenteBillet()
    local vente = RageUI.CreateMenu("Vendre", "Vente de billets")
    local onrecolte = no
    vente:SetRectangleBanner(Config.Banniere.ColorR, Config.Banniere.ColorG, Config.Banniere.ColorB)

    RageUI.Visible(vente, not RageUI.Visible(vente))
    while vente do
        FreezeEntityPosition(PlayerPedId(), yes)
        Citizen.Wait(3)
        RageUI.IsVisible(vente, yes, no, yes, function()

        if not onrecolte then
            RageUI.ButtonWithStyle("Vendre les sacs de billets", nil, {RightLabel = "~g~→"},yes, function(Hovered, Active, Selected)
                if Selected then
                onrecolte = yes
                end
            end)
        else
            RageUI.PercentagePanel(load, "Vente en cours (~b~" .. math.floor(load * 100) .. "%~s~)", "", "", function(_, a_, percent)
                TaskStartScenarioInPlace(GetPlayerPed(-1), "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
                if load < 1.0 then
                    load = load + Config.Time.Vente
                else
                    load = 0
                    TriggerServerEvent("galaxie:vente")
                end
            end)

            RageUI.ButtonWithStyle("~r~Arrêter de vendre~s~", nil, {RightBadge = RageUI.BadgeStyle.Alert}, yes, function(Hovered, Active, Selected)
                if Selected then
                    RageUI.CloseAll()
                    onrecolte = no
                end
            end)

        end

        end, function()  
        end)

        if not RageUI.Visible(vente) then
            vente = RMenu:DeleteType("vente", yes)
            onrecolte = no
            ClearPedTasksImmediately(GetPlayerPed(-1))
            FreezeEntityPosition(PlayerPedId(), no)
        end
    end
end