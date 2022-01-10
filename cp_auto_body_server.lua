-- Based on es_carwash by 'EssentialMode 5 CarWash by TheSpartaPT.' --
--Settings--

enableprice = false -- true = repair is paid, false = repair is free

price = 1000 -- you may edit this to your liking. if "enableprice = false" ignore this one

--DO-NOT-EDIT-BELLOW-THIS-LINE--

RegisterServerEvent('cp_auto_body:checkmoney')
AddEventHandler('cp_auto_body:checkmoney', function ()
	if enableprice == true then
		TriggerEvent('es:getPlayerFromId', source, function (user)
			userMoney = user.getMoney()
			if userMoney >= price then
				user.removeMoney(price)
				TriggerClientEvent('cp_auto_body:success', source, price)
			else
				moneyleft = price - userMoney
				TriggerClientEvent('cp_auto_body:notenoughmoney', source, moneyleft)
			end
		end)
	else
		TriggerClientEvent('cp_auto_body:free', source)
	end
end)
