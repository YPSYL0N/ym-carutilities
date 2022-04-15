ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('cloth', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local shampoo = xPlayer.getInventoryItem('carshampoo').count

	if shampoo >= 1 then
		xPlayer.removeInventoryItem('cloth', 1)
		xPlayer.removeInventoryItem('carshampoo', 1)
		TriggerClientEvent('ym-carutilities:umytauto', _source)
	else
		TriggerClientEvent('ym-carutilities:noshampoo', _source)
	end
end)

ESX.RegisterUsableItem('repairkit', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local repairkit = xPlayer.getInventoryItem('repairkit').count

	if repairkit >= 1 then
		xPlayer.removeInventoryItem('repairkit', 1)
		TriggerClientEvent('ym-carutilities:opravitauto', _source)
	else
		TriggerClientEvent('ym-carutilities:norepairkit', _source)
	end
end)