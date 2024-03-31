ESX = exports["es_extended"]:getSharedObject()

print("[^6JOB GRUPPE6^7] Job by Galaxie Geek#1486 s'est lancé correctement !")
print("^2Discord^7 : https://discord.gg/qBPjHQfzm8")

TriggerEvent('esx_phone:registerNumber', 'g6', 'Alerte Gruppe6', true, true) --- Si vous avez un GCPHONE
TriggerEvent('esx_society:registerSociety', 'g6', 'g6', 'society_g6', 'society_g6', 'society_g6', {type = 'public'})

local notif = 'esx:showNotification'
local numbers = 8
local char = 'CHAR_BANK_FLEECA'
local notif2 = "esx:showAdvancedNotification"

RegisterNetEvent("galaxie:recolte")
AddEventHandler("galaxie:recolte", function() 

    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local item = "sac_billets"
    local max = xPlayer.getInventoryItem(item).count

    if max < 120 then
        xPlayer.addInventoryItem(item, 1)
    else
        TriggerClientEvent(notif, _src, "~r~Vous n'avez plus assez de place pour ceci")
    end
end)

RegisterNetEvent("galaxie:vente")
AddEventHandler("galaxie:vente", function() 

    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local item = "sac_billets"
    local max = xPlayer.getInventoryItem(item).count
    local price = Config.Economie.Price
    local entreprise = Config.Economie.Entreprise

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_g6', function(account)
        societyAccount = account
    end)

    if max <= 0 then
        TriggerClientEvent(notif, _src, "Vous n'avez plus de sacs de billets pour vendre")
    else
        if societyAccount ~= nil then
            societyAccount.addMoney(entreprise)
        end
        xPlayer.removeInventoryItem(item, 1)
        xPlayer.addMoney(price)
    end
end)

ESX.RegisterUsableItem('sac_billets', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local money = Config.Economie.Sale

    PerformHttpRequest(Config.Webhook.Ouverture, function(err, text, headers) end, 'POST', json.encode({username = "Gruppe 6 Logs - Ouverture de sac", content = "`" .. xPlayer.getName() .. "` a ouvert un sac de billet et a gagné: `" .. money .. "$`"}), { ['Content-Type'] = 'application/json' })
    xPlayer.removeInventoryItem("sac_billets", 1)
    xPlayer.addAccountMoney('black_money', money)
end)

-- Menu Patron
ESX.RegisterServerCallback('galaxie:refresh', function(source, cb, accountEv)
    local source = source
        MySQL.Async.fetchAll('SELECT * FROM addon_account_data WHERE account_name = @a', {['a'] = "society_g6"}, function(data)
            local accountEv = data[1].money
            cb(accountEv)
        end)
end)

RegisterNetEvent('galaxie:deposer')
AddEventHandler('galaxie:deposer', function(number)
    local _src= source
	local xPlayer = ESX.GetPlayerFromId(_src)
    TriggerEvent('esx_addonaccount:getSharedAccount', "society_g6", function (account)
        account.addMoney(number)
    end)
    PerformHttpRequest(Config.Webhook.Logs, function(err, text, headers) end, 'POST', json.encode({username = "Gruppe 6 Logs - Patron", content = "`" .. xPlayer.getName() .. "` a déposé `".. number .. "$` dans l'entreprise du Gruppe6"}), { ['Content-Type'] = 'application/json' })
	xPlayer.removeMoney(number)
	TriggerClientEvent(notif, _src, "Vous avez déposer ~g~" .. number .. "$~s~")
end)

RegisterNetEvent('galaxie:retirer')
AddEventHandler('galaxie:retirer', function(number2)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    TriggerEvent('esx_addonaccount:getSharedAccount', "society_g6", function (account)
        account.removeMoney(number2)
    end)
    PerformHttpRequest(Config.Webhook.Logs, function(err, text, headers) end, 'POST', json.encode({username = "Gruppe 6 Logs - Patron", content = "`" .. xPlayer.getName() .. "` a retiré `".. number2 .. "$` de l'entreprise du Gruppe6"}), { ['Content-Type'] = 'application/json' })
    xPlayer.addMoney(number2)
	TriggerClientEvent(notif, _src, "Vous avez retirer ~g~" .. number2 .. "$~s~")
end)

RegisterServerEvent('galaxie:recruter')
AddEventHandler('galaxie:recruter', function(target)
	local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xPlayer.job.grade_name == 'patron' then
        xTarget.setJob("g6", 0)
        PerformHttpRequest(Config.Webhook.Logs, function(err, text, headers) end, 'POST', json.encode({username = "Gruppe 6 Logs", content = "`" .. xPlayer.getName() .. "` a recruté `" .. target.getName() "` dans l'entreprise du Gruppe 6"}), { ['Content-Type'] = 'application/json' })
        TriggerClientEvent(notif, xPlayer.source, "~b~La personne a été recruté")
        TriggerClientEvent(notif, target, "~b~Bienvenue dans l'entreprise !")
    else
        TriggerClientEvent(notif, xPlayer.source, "~r~Vous n'êtes pas patron...")
	end
end)

RegisterServerEvent('galaxie:virer')
AddEventHandler('galaxie:virer', function(target)
	local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xPlayer.job.grade_name == 'patron' then
        xTarget.setJob("unemployed", 0)
        PerformHttpRequest(Config.Webhook.Logs, function(err, text, headers) end, 'POST', json.encode({username = "Gruppe 6 Logs", content = "`" .. xPlayer.getName() .. "` a viré `" .. target.getName() "` de l'entreprise du Gruppe 6"}), { ['Content-Type'] = 'application/json' })
        TriggerClientEvent(notif, xPlayer.source, "~r~La personne a été viré")
        TriggerClientEvent(notif, target, "~r~Vous avez été viré !")
    else
        TriggerClientEvent(notif, xPlayer.source, "~r~Vous n'êtes pas patron...")
	end
end)

RegisterServerEvent('galaxie:rank')
AddEventHandler('galaxie:rank', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xPlayer.job.grade_name == 'patron' and xPlayer.job.name == xTarget.job.name then
        xTarget.setJob("g6", tonumber(xTarget.job.grade) + 1)
        TriggerClientEvent(notif, xPlayer.source, "~g~La personne a été promu")
        TriggerClientEvent(notif, target, "~g~Vous avez été promu !")
    else
        TriggerClientEvent(notif, xPlayer.source, "~r~Vous n'êtes pas patron ou la personne ne peut pas être promu.")
    end
end)

RegisterServerEvent('galaxie:derank')
AddEventHandler('galaxie:derank', function(target)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(target)

    if xPlayer.job.grade_name == 'patron' and xPlayer.job.name == xTarget.job.name then
        xTarget.setJob(name, tonumber(xTarget.job.grade) - 1)
        TriggerClientEvent(notif, xPlayer.source, "~r~La personne a été rétrograder")
        TriggerClientEvent(notif, target, "~r~Vous avez été rétrograder !")
    else
        TriggerClientEvent(notif, xPlayer.source, "~r~Vous n'êtes pas patron ou la personne ne peut pas être rétrograder.")

    end
end)

-- Coffre -- 
ESX.RegisterServerCallback('galaxie:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_g6', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('galaxie:getStockItem')
AddEventHandler('galaxie:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_g6', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent(notif, _source, '~g~Objet retiré')
		else
			TriggerClientEvent(notif, _source, "~r~Quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('galaxie:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('g6:putStockItems')
AddEventHandler('g6:putStockItems', function(itemName, count)
    local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
    local item = xPlayer.getInventoryItem(itemName).count

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_g6', function(inventory)

        if item > count then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
            TriggerClientEvent(notif, _src, "~g~Objet déposé")
        else
            TriggerClientEvent(notif, _src, "~r~Quantité invalide")
        end
    end)
end)

-- F6 --
RegisterServerEvent('galaxie:ouvert')
    AddEventHandler('galaxie:ouvert', function()
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent(notif2, xPlayers[i], '~g~Gruppe6', '~b~Annonce', 'Le Gruppe6 est ~g~ouvert~s~ !', char, numbers)
        end
    end)
    
    RegisterServerEvent('galaxie:fermer')
    AddEventHandler('galaxie:fermer', function()
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent(notif2, xPlayers[i], '~g~Gruppe6', '~b~Annonce', 'Le Gruppe6 est ~r~fermer~s~ !', 'CHAR_BLOCKED', numbers)
        end
    end)
    
    RegisterServerEvent('galaxie:recrutement')
    AddEventHandler('galaxie:recrutement', function (target)
    
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent(notif2, xPlayers[i], '~g~Gruppe6', '~b~Annonce', '~b~Recrutement~s~ en cours au Gruppe6', char, numbers)
    
        end
    end)

    RegisterServerEvent('galaxie:perso')
    AddEventHandler('galaxie:perso', function(message)

        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent(notif2, xPlayers[i], '~g~Gruppe6', '~b~Annonce', ''.. message, char, numbers)
        end

    end)

    -- Menotte --
RegisterServerEvent('galaxie:handcuff')
AddEventHandler('galaxie:handcuff', function(target)
    TriggerClientEvent('galaxie:handcuff', target)
end)
-- 
RegisterServerEvent('galaxie:drag')
AddEventHandler('galaxie:drag', function(target)
    local _source = source
    TriggerClientEvent('galaxie:drag', target, _source)
end)
-- 
RegisterServerEvent('galaxie:putInVehicle')
AddEventHandler('galaxie:putInVehicle', function(target)
    TriggerClientEvent('galaxie:putInVehicle', target)
end)
--
RegisterServerEvent('galaxie:OutVehicle')
AddEventHandler('galaxie:OutVehicle', function(target)
    TriggerClientEvent('galaxie:OutVehicle', target)
end)
--