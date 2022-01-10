-- Based on es_carwash by 'EssentialMode 5 CarWash by TheSpartaPT.' --
-- Modified a bit by Calm Producions
-- RECOMMEND-THAT-YOU-DO-NOT-EDIT-BELLOW-THIS-LINE--

Key = 201 -- ENTER

vehicleAutoBodyStation = {
	{-327.0, -144.6, 38.3}, -- LSC Burton body spray tent
	{735.7, -1073.9, 21.5}, -- LSC La Mesa body spray tent
	{481.7, -1317.4, 28.5}, -- Hayes Bodywork Shop, Little Bighorn Ave.
	{288.2, -1729.5, 28.5}, -- Hayes Bodywork Shop, Rancho
	{-24.6, -1678.2, 29.0}, -- Mosley Bodywork Service, Strawberry
	{-199.0, -1382.0, 30.5}, -- Glass Heroes, Strawberry
	{-1166.7, -2013.0, 12.5},	-- LSC by airport body spray tent
	{-440.0, -2177.5, 10.0}, -- Otto's Auto Body, LSI Elysin Island
	{-1409.0, -459.1, 33.8}, -- Hayes Auto Body Shop, Del Perro
	{103.6, 6622.5, 31.1}, -- LSC Paleto Bay body spray tent
	{1914.0, 3729.0, 32.0}, -- Otto's Auto Body, Sandy Shores
	{1182.7, 2638.4, 37.0} -- 68 Harmony Body spray tent
}

Citizen.CreateThread(function ()
	Citizen.Wait(0)
	for i = 1, #vehicleAutoBodyStation do
		garageCoords = vehicleAutoBodyStation[i]
		stationBlip = AddBlipForCoord(garageCoords[1], garageCoords[2], garageCoords[3])
		SetBlipSprite(stationBlip, 72) -- 72 radar_car_mod_shop
		SetBlipColour(stationBlip, 3) -- 0 White, 1 Red, 2 Green, 3 Blue etc.
		SetBlipAsShortRange(stationBlip, true)
		SetBlipDisplay(stationBlip, 2) -- 0 Doesn't showup ever. 
										--1 Doesn't showup ever anywhere. 
										--2 Shows on both main map and minimap 
										--3&4 Main map only 
										--5 shows on minimap only 
										--6 shows on both 
										--7 Doesn't showup 
										--8 both not selectable
										--9 minimap only 
										--10 both not selectable
										--Rockstar seem to only use 0, 2, 3, 4, 5 and 8 in the decompiled scripts.
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Body Shop")
		EndTextCommandSetBlipName(stationBlip)
	end
    return
end)

function cp_auto_body_DrawSubtitleTimed(m_text, showtime)
	SetTextEntry_2('STRING')
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function cp_auto_body_DrawNotification(m_text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(m_text)
	DrawNotification(true, false)
end

Citizen.CreateThread(function ()

	while true do
		Citizen.Wait(0)
		if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
			for i = 1, #vehicleAutoBodyStation do
				garageCoords2 = vehicleAutoBodyStation[i]
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), garageCoords2[1], garageCoords2[2], garageCoords2[3], true ) < 20 then
					DrawMarker(1, garageCoords2[1], garageCoords2[2], garageCoords2[3], 0, 0, 0, 0, 0, 0, 5.0, 5.0, 2.0, 0, 0, 156, 155, 0, 0, 2, 0, 0, 0, 0)
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), garageCoords2[1], garageCoords2[2], garageCoords2[3], true ) < 5 then
						cp_auto_body_DrawSubtitleTimed("Press [~g~ENTER~s~] to repair your vehicle!")
						if IsControlJustPressed(1, Key) then
							TriggerServerEvent('cp_auto_body:checkmoney')
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent('cp_auto_body:success')
AddEventHandler('cp_auto_body:success', function (price)
	player = GetPlayerPed(-1)
	playerVehicle = GetVehiclePedIsUsing(player)
	local GVEH = GetVehicleEngineHealth(playerVehicle)
	SetVehicleBodyHealth(playerVehicle, 1000.0)
	SetVehiclePetrolTankHealth(playerVehicle, 1000.0)
--	SetVehicleWheelHealth(playerVehicle, 1000.0)
--	SetVehicleUndriveable(playerVehicle, false)
--	SetVehicleEngineHealth(playerVehicle, 1000.0)
	RemoveDecalsFromVehicle(playerVehicle)
	SetVehicleDeformationFixed(playerVehicle)
	SetVehicleFixed(playerVehicle)
	SetVehicleEngineHealth(playerVehicle, GVEH)
	Citizen.Wait(1000)
	cp_auto_body_DrawNotification("Your vehicle's body was ~y~repaired~s~! ~g~-$" .. price .. "~s~!")
end)

RegisterNetEvent('cp_auto_body:notenoughmoney')
AddEventHandler('cp_auto_body:notenoughmoney', function (moneyleft)
	cp_auto_body_DrawNotification("~h~~r~You don't have enough money! $" .. moneyleft .. " left!")
end)

RegisterNetEvent('cp_auto_body:free')
AddEventHandler('cp_auto_body:free', function ()
	player = GetPlayerPed(-1)
	playerVehicle = GetVehiclePedIsUsing(player)
	local GVEH = GetVehicleEngineHealth(playerVehicle)
	SetVehicleBodyHealth(playerVehicle, 1000.0)
	SetVehiclePetrolTankHealth(playerVehicle, 1000.0)
--	SetVehicleWheelHealth(playerVehicle, 1000.0)
--	SetVehicleUndriveable(playerVehicle, false)
--	SetVehicleEngineHealth(playerVehicle, 1000.0)
	RemoveDecalsFromVehicle(playerVehicle)
	SetVehicleDeformationFixed(playerVehicle)
	SetVehicleFixed(playerVehicle)
	SetVehicleEngineHealth(playerVehicle, GVEH)
	Citizen.Wait(1000)
	cp_auto_body_DrawNotification("Your vehicle's body was ~y~repaired~s~ for free!")
end)
