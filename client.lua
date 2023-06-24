ESX = exports['es_extended']:getSharedObject()
--print(json.encode(input))
--local PlayerData = ESX.GetPlayerData()
--local job = PlayerData.job.name

CreateThread(function()
	for _, points in pairs(Config.NPCS) do

		RequestModel(GetHashKey(points.ped))
		while not HasModelLoaded(GetHashKey(points.ped)) do
			Wait(1)
		end

		if points.pedenabled then
			local npc = CreatePed(4, points.pedhash, points.pedcoords.x, points.pedcoords.y, points.pedcoords.z-1, points.pedheading, false, true)
			FreezeEntityPosition(npc, true)	
			SetEntityHeading(npc, points.pedheading)
			SetEntityInvincible(npc, true)
			SetBlockingOfNonTemporaryEvents(npc, true)
			TaskStartScenarioInPlace(npc, points.scenario, -1, true)
		end
	end
	SetForcePedFootstepsTracks(false)
end)

CreateThread(function()
	exports.ox_target:addBoxZone({
		coords = Config.Targets[1].coords,
		size = Config.Targets[1].size,
		rotation = Config.Targets[1].heading,
		options = {
			{
				name = 'Ankauf',
				event = 'morpawn:ankauf',
				icon = 'fas fa-dollar',
				iconColor = '#008000',
				label = 'Ankauf'
			},
			{
				name = 'Verkauf',
				event = 'morpawn:getinv',
				icon = 'fas fa-dollar',
				iconColor = '#FF0000',
				label = 'Verkauf'
			}
		}
	})
end)

RegisterNetEvent('morpawn:ankauf')
AddEventHandler('morpawn:ankauf', function()
	local pitems = exports.ox_inventory:GetPlayerItems(source)
	local psitems = exports.ox_inventory:Search('count', {Config.Items[1].name,Config.Items[2].name,Config.Items[3].name,Config.Items[4].name})
	local count1,count2,count3,count4 = 0,0,0,0

	if psitems then
		for name, count in pairs(psitems) do
			if name == Config.Items[1].name then
				count1 = count
			end
			if name == Config.Items[2].name then
				count2 = count
			end
			if name == Config.Items[3].name then
				count3 = count
			end
			if name == Config.Items[4].name then
				count4 = count
			end
		end
	end

	lib.registerContext({
		id = 'morpawn:ankaufmenu',
		title = 'Ankauf',
		options = {
			{
				title = ''..Config.Items[1].label..'	Ankaufspreis: $'..Config.Items[1].bprice, description = 'Dein Bestand: '..count1,
				args = {Config.Items[1].name, Config.Items[1].label, Config.Items[1].bprice, count1}, arrow = true,
				event = 'morpawn:ankaufinput'
			},
			{
				title = ''..Config.Items[2].label..'	Ankaufspreis: $'..Config.Items[2].bprice, description = 'Dein Bestand: '..count2,
				args = {Config.Items[2].name, Config.Items[2].label,Config.Items[2].bprice, count2}, arrow = true,
				event = 'morpawn:ankaufinput'
			},
			{
				title = ''..Config.Items[3].label..'	Ankaufspreis: $'..Config.Items[3].bprice, description = 'Dein Bestand: '..count3,
				args = {Config.Items[3].name, Config.Items[3].label,Config.Items[3].bprice, count3}, arrow = true,
				event = 'morpawn:ankaufinput'
			},
			{
				title = ''..Config.Items[4].label..'	Ankaufspreis: $'..Config.Items[4].bprice, description = 'Dein Bestand: '..count4,
				args = {Config.Items[4].name, Config.Items[4].label,Config.Items[4].bprice, count4}, arrow = true,
				event = 'morpawn:ankaufinput'
			},
		}
	})
	lib.showContext('morpawn:ankaufmenu')
end)

RegisterNetEvent('morpawn:getinv')
AddEventHandler('morpawn:getinv', function()
	local bitems = Config.Items
	TriggerServerEvent('morpawn:getinventory', bitems)
end)

RegisterNetEvent('morpawn:ankaufinput')
AddEventHandler('morpawn:ankaufinput', function(args)
	local sells = args
	local sellinput = lib.inputDialog('Ankauf', {
		{type = 'slider', label = sells[2]..'	Preis: $'..sells[3], description = 'Dein Bestand:'..sells[4],
		icon = 'hashtag',min = 0, max = sells[4], default = sells[4]},
		})
		if sellinput ~= nil or sellinput ~= 0 then
			table.insert(sells, 5, sellinput)
			TriggerServerEvent('morpawn:remove', sells)
		end
end)

RegisterNetEvent('morpawn:verkaufmenu')
AddEventHandler('morpawn:verkaufmenu', function(citems)
	local buys = citems
	local buys1 = buys[1]
	local buys2 = buys[2]
	local buys3 = buys[3]
	local buys4 = buys[4],
	print(json.encode(buys))

	-- Menü Kaufoptionen >> InputDialog >> Server:Add
	lib.registerContext({
		id = 'morpawn:verkaufsmenu',
		title = 'Verkauf',
		options = {
			{
				title = ''..buys1[2]..'	Verkaufspreis: $'..buys1[3], description = 'Bestand: '..buys1[4],
				args = {buys1}, arrow = true, event = 'morpawn:verkaufinput'
			},
			{
				title = ''..buys2[2]..'	Verkaufspreis: $'..buys2[3], description = 'Bestand: '..buys2[4],
				args = {buys2}, arrow = true, event = 'morpawn:verkaufinput'
			},
			{
				title = ''..buys3[2]..'	Verkaufspreis: $'..buys3[3], description = 'Bestand: '..buys3[4],
				args = {buys3}, arrow = true, event = 'morpawn:verkaufinput'
			},
			{
				title = ''..buys4[2]..'	Verkaufspreis: $'..buys4[3], description = 'Bestand: '..buys4[4],
				args = {buys4}, arrow = true, event = 'morpawn:verkaufinput'
			},
		}
	})
	lib.showContext('morpawn:verkaufsmenu')
end)

RegisterNetEvent('morpawn:verkaufinput')
AddEventHandler('morpawn:verkaufinput', function(args)
	local items = args[1]
	print(json.encode(items))
	print(items[4])
	if items[4] == 0 or items[4] == nil then
		lib.notify({title = 'Pfandhaus', position = 'top-right',description = 'Kein Bestand am Lager.', style = {backgroundColor = '#000000',color = '#ffffff'},icon = 'warehouse',iconColor = '#800080'})
	else local buyinput = lib.inputDialog('Verkauf', {
			{type = 'slider', label = items[2]..'	Preis: $'..items[3], description = 'Bestand:'..items[4],
			icon = 'hashtag',min = 0, max = items[4], default = items[4]},
			})
			if buyinput ~= nil or buyinput ~= 0 then
				table.insert(items, 5, buyinput)
				print(json.encode(items))
				TriggerServerEvent('morpawn:add', items)
			end
	end
end)