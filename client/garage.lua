ESX = exports["es_extended"]:getSharedObject()

local yes = true
local no = false

function GarageG6()
    local GarageG6 = RageUI.CreateMenu("Garage", "Liste des véhicules")
    GarageG6:SetRectangleBanner(Config.Banniere.ColorR, Config.Banniere.ColorG, Config.Banniere.ColorB)

    RageUI.Visible(GarageG6, not RageUI.Visible(GarageG6))
    while GarageG6 do
        Citizen.Wait(3)
            RageUI.IsVisible(GarageG6, yes, yes, yes, function()

                for k,v in pairs(Config.Garage.g6.vehicules) do
				if v.category ~= nil then 
					RageUI.Separator(v.category)
				else 
					RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "→"}, yes, function(Hovered, Active, Selected)
						if (Selected) then
							Citizen.CreateThread(function()
								local model = GetHashKey(v.model)
								RequestModel(model)
								while not HasModelLoaded(model) do Citizen.Wait(3) end
								local vehicle = CreateVehicle(model, Config.Spawn.spawnvoiture.position.x, Config.Spawn.spawnvoiture.position.y, Config.Spawn.spawnvoiture.position.z, Config.Spawn.spawnvoiture.position.h, true, false)
								SetModelAsNoLongerNeeded(model)
								SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
								TriggerServerEvent('esx_vehiclelock:givekey', 'yes', GetVehicleNumberPlateText(vehicle))
								SetVehicleWindowTint(vehicle, 1)
								SetVehRadioStation(vehicle, "OFF")
								SetVehicleNumberPlateText(vehicle, "GRUPPE6") 
								RageUI.CloseAll()
								FreezeEntityPosition(PlayerPedId(), no)
							end)
						end
					end)
				end
			end

				end, function()    
				end)

		if not RageUI.Visible(GarageG6) then
			FreezeEntityPosition(PlayerPedId(), no)
			GarageG6 = RMenu:DeleteType("GarageG6", yes)
		end
	end
end

Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Pos.Rangement
        for _, v in pairs(position) do
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
					if IsPedInAnyVehicle(PlayerPedId(), false) then
                    if ESX.PlayerData.job and ESX.PlayerData.job.name == "g6" then
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z-0.9, 0.0, 0.0, Config.Marker.Rotation, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, no, no, no, no)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~g~[E]~s~ pour ranger le véhicule", time_display = 1})
                        if IsControlJustPressed(0, 51) then
							ESX.Game.DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1), false))
							TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'yes')
							RageUI.CloseAll()
						end
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Pos.Garage
        for _, v in pairs(position) do
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    if ESX.PlayerData.job and ESX.PlayerData.job.name == "g6" then
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z-0.9, 0.0, 0.0, Config.Marker.Rotation, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, no, no, no, no)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~g~[E]~s~ pour ouvrir le garage", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            FreezeEntityPosition(PlayerPedId(), yes)
                            GarageG6()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)