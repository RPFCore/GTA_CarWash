--Settings--

enableprice = true -- true = carwash is paid, false = carwash is free

price = 100 -- you may edit this to your liking. if "enableprice = false" ignore this one

--DO-NOT-EDIT-BELLOW-THIS-LINE--

RegisterServerEvent('rpf:carwash')
AddEventHandler('rpf:carwash', function ()
	--print("test")
    local source = source
	local prixTotal = 5

	TriggerEvent('GTA_Inventaire:GetItemQty', source, "cash", function(qtyItem, itemid)
		local cash = qtyItem
		--local prixTotal = 10
		--print("test")
		if (tonumber(cash) >= prixTotal) then
		--	print("test")
		--	TriggerClientEvent("GTASuperette:Achat", source, quantityItems, nameItem)
			TriggerClientEvent("GTA_Inventaire:RetirerItem", source, "cash", prixTotal)
			--TriggerClientEvent('nMenuNotif:showNotification', source, " + "..quantityItems)
			TriggerClientEvent('es_carwash:success', source, prixTotal)
			TriggerClientEvent("GTAO:NotificationIcon", source, "CHAR_MP_MEX_LT", "Car Wash", "Véhicule propre !", "Voila chef votre véhicule est comme neuve...\nvous avez payez ~g~-$" .. prixTotal .. "~s~ !")
		else
			TriggerClientEvent('GTASuperette:AchatFail', source)
			TriggerClientEvent('nMenuNotif:showNotification', source, "~r~Tu n'as pas suffisamment d'argent !")
		end
	end)
end)
