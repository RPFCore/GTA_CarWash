--DO-NOT-EDIT-BELLOW-THIS-LINE--

Key = 38 -- ENTER

vehicleWashStation = {
	{ 1580.927, 967.4775, 22.4221 },
	{ -431.4571, 1334.368, 5.5766 }
}


Citizen.CreateThread(function ()
	Citizen.Wait(0)
	for i = 1, #vehicleWashStation do
		garageCoords = vehicleWashStation[i]
		stationBlip = AddBlipForCoord(garageCoords[1], garageCoords[2], garageCoords[3])
		SetBlipSprite(stationBlip, 100) -- 100 = carwash
         SetBlipScale(stationBlip, 0.6)
		SetBlipAsShortRange(stationBlip, true)
	end
    return
end)

function es_carwash_DrawSubtitleTimed(m_text, showtime)
	SetTextEntry_2('STRING')
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function es_carwash_DrawNotification(m_text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(m_text)
	DrawNotification(true, false)
end

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
			for i = 1, #vehicleWashStation do
				garageCoords2 = vehicleWashStation[i]
                DrawMarker(20, garageCoords2[1], garageCoords2[2], garageCoords2[3]+1.0, 0.0, 0.0, 0.0, 180.0, 0.0, 180.0, 1.5, 1.5, 1.0, 240, 200, 80, 180, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), garageCoords2[1], garageCoords2[2], garageCoords2[3], true ) < 5 then
					TriggerEvent("GTA-Notification:InfoInteraction", "Touche ~INPUT_PICKUP~ pour lavé votre vehicule.")

					--es_carwash_DrawSubtitleTimed("Touche [~g~ENTER~s~] pour lavé le vehicule !")
					if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then
						--print("test")
						TriggerServerEvent("rpf:carwash")
					end
				end
			end
		end
	end
end)

RegisterNetEvent('es_carwash:success')
AddEventHandler('es_carwash:success', function (prixTotal)
	WashDecalsFromVehicle(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1.0)
	SetVehicleDirtLevel(GetVehiclePedIsUsing(GetPlayerPed(-1)))
--	TriggerEvent('nMenuNotif:showNotification', "Votre véhicule est ~y~propre~s~ vous avez payez ~g~-$" .. prixTotal .. "~s~ !")
--	es_carwash_DrawNotification("Votre véhicule est ~y~propre~s~! ~g~-$" .. prixTotal .. "~s~!")
end)

RegisterNetEvent('es_carwash:notenoughmoney')
AddEventHandler('es_carwash:notenoughmoney', function (moneyleft)
--	TriggerEvent("GTA-Notification:InfoInteraction", "Votre véhicule est ~y~propre~s~ !")
--	es_carwash_DrawNotification("~h~~r~You don't have enough money! $" .. moneyleft .. " left!")
end)

RegisterNetEvent('es_carwash:free')
AddEventHandler('es_carwash:free', function ()
	WashDecalsFromVehicle(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1.0)
	SetVehicleDirtLevel(GetVehiclePedIsUsing(GetPlayerPed(-1)))
--	TriggerEvent("GTA-Notification:InfoInteraction", "Votre véhicule est ~y~propre~s~ gratuitement !")
	--es_carwash_DrawNotification("Votre véhicule est ~y~propre~s~ gratuitement !")
end)

