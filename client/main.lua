ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


RegisterNetEvent('ym-carutilities:umytauto')
AddEventHandler('ym-carutilities:umytauto', function()
	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(playerPed)

	if IsPedSittingInAnyVehicle(playerPed) then
		exports['mythic_notify']:DoHudText('error', 'Exit the vehicle before cleaning it!')
		return
	end

	if DoesEntityExist(vehicle) then
		isBusy = true
		TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
		exports['pogressBar']:drawBar(10000, "Cleaning the car")
		Citizen.CreateThread(function()
			Citizen.Wait(10000)

			SetVehicleDirtLevel(vehicle, 0)
			ClearPedTasksImmediately(playerPed)

			exports['mythic_notify']:DoHudText('success', 'Vehicle cleaned!')
			isBusy = false
		end)
	else
		exports['mythic_notify']:DoHudText('error', 'No vehicle nearby!')
	end
end)

RegisterNetEvent('ym-carutilities:opravitauto')
AddEventHandler('ym-carutilities:opravitauto', function()
	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(playerPed)

	if IsPedSittingInAnyVehicle(playerPed) then
		exports['mythic_notify']:DoHudText('error', 'Exit the vehicle before repairing it!')
		return
	end

	if DoesEntityExist(vehicle) then
		isBusy = true
		TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
		local finished = exports["reload-skillbar"]:taskBar(6000,math.random(5,15))
		if finished ~= 100 then
		ClearPedTasksImmediately(playerPed)
		exports['mythic_notify']:DoHudText('error', 'You failed!')
		isBusy = false
		else
		exports['pogressBar']:drawBar(20000, "Repairing the car")
		exports['mythic_notify']:DoHudText('success', 'Success!')
		Citizen.CreateThread(function()
			Citizen.Wait(20000)

			SetVehicleFixed(vehicle)
			SetVehicleDeformationFixed(vehicle)
			SetVehicleUndriveable(vehicle, false)
			SetVehicleEngineOn(vehicle, true, true)
			ClearPedTasksImmediately(playerPed)

			exports['mythic_notify']:DoHudText('success', 'You repaired the car!')
			isBusy = false
		end)
		end
	else
		exports['mythic_notify']:DoHudText('error', 'No vehicle nearby!')
	end
end)




RegisterNetEvent('ym-carutilities:noshampoo')
AddEventHandler('ym-carutilities:noshampoo', function()
	exports['mythic_notify']:DoHudText('error', 'You dont have car shampoo!')
end)

RegisterNetEvent('ym-carutilities:norepairkit')
AddEventHandler('ym-carutilities:norepairkit', function()
	exports['mythic_notify']:DoHudText('error', 'You dont have a repair kit!')
end)