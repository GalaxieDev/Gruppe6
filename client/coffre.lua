ESX = exports["es_extended"]:getSharedObject()

local yes = true
local no = false
local itemstock = {}
local PlayersItem = {}

function CoffreG6()
    local CoffreG6 = RageUI.CreateMenu("Coffre", "Coffre de la société")
    CoffreG6:SetRectangleBanner(Config.Banniere.ColorR, Config.Banniere.ColorG, Config.Banniere.ColorB)
        RageUI.Visible(CoffreG6, not RageUI.Visible(CoffreG6))
            while CoffreG6 do
                FreezeEntityPosition(PlayerPedId(), yes)
            Citizen.Wait(3)
            RageUI.IsVisible(CoffreG6, yes, yes, yes, function()

                    RageUI.ButtonWithStyle("→ Retirer un objet(s)",nil, {RightLabel = ""}, yes, function(Hovered, Active, Selected)
                        if (Selected) then
                            G6Retirer()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("→ Déposer un objet(s)",nil, {RightLabel = ""}, yes, function(Hovered, Active, Selected)
                        if (Selected) then
                            G6Deposer()
                        end
                    end)

                    RageUI.Line()

                    RageUI.ButtonWithStyle("→ Fermer le ~r~coffre",nil, {RightLabel = ""}, yes, function(Hovered, Active, Selected)
                        if (Selected) then
                        FreezeEntityPosition(PlayerPedId(), no)
                        RageUI.CloseAll()
                        end
                    end)
                    
                end, function()
                end)


            if not RageUI.Visible(CoffreG6) then
                CoffreG6 = RMenu:DeleteType("CoffreG6", yes)
            FreezeEntityPosition(PlayerPedId(), no)
        end
    end
end

function G6Retirer()
    local G6Retirer = RageUI.CreateMenu("Coffre", "Retirer...")
    G6Retirer:SetRectangleBanner(Config.Banniere.ColorR, Config.Banniere.ColorG, Config.Banniere.ColorB)
    ESX.TriggerServerCallback('galaxie:getStockItems', function(items) 
    itemstock = items
    RageUI.Visible(G6Retirer, not RageUI.Visible(G6Retirer))
        while G6Retirer do
            Citizen.Wait(3)
                RageUI.IsVisible(G6Retirer, yes, yes, yes, function()
                    FreezeEntityPosition(PlayerPedId(), yes)
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, yes, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    playAnim('random@domestic', 'pickup_low', 1500)
                                    Citizen.Wait(1500)
                                    TriggerServerEvent('galaxie:getStockItem', v.name, tonumber(count))
                                    G6Retirer()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(G6Retirer) then
                FreezeEntityPosition(PlayerPedId(), no)
                G6Retirer = RMenu:DeleteType("G6Retirer", yes)
        end
    end
end)
end

function G6Deposer()
    local G6Deposer = RageUI.CreateMenu("Coffre", "Déposer...")
    G6Deposer:SetRectangleBanner(Config.Banniere.ColorR, Config.Banniere.ColorG, Config.Banniere.ColorB)
    ESX.TriggerServerCallback('galaxie:getPlayerInventory', function(inventory)
        RageUI.Visible(G6Deposer, not RageUI.Visible(G6Deposer))
    while G6Deposer do
        Citizen.Wait(3)
            RageUI.IsVisible(G6Deposer, yes, yes, yes, function()
                FreezeEntityPosition(PlayerPedId(), yes)
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                            local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, yes, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            playAnim('random@domestic', 'pickup_low', 1500)
                                            Citizen.Wait(1500)
                                            TriggerServerEvent('g6:putStockItems', item.name, tonumber(count))
                                            G6Deposer()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours...')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(G6Deposer) then
                    FreezeEntityPosition(PlayerPedId(), no)
                    G6Deposer = RMenu:DeleteType("Coffre", yes)
            end
        end
    end)
end

-- marker 
Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Pos.Coffre
        for _, v in pairs(position) do
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 100.0 then
                    interval = 0
                    if ESX.PlayerData.job and ESX.PlayerData.job.name == "g6" then
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z-0.9, 0.0, 0.0, Config.Marker.Rotation, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, no, no, no, no)
                    if distance <= 0.5 then
                        RageUI.Text({message = "Appuyez sur ~g~[E]~s~ pour ouvrir le coffre", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            CoffreG6()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

-- Fonction Imput
function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

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

-- Fonction pour l'animation de la vente
function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end