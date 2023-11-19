ESX = exports["es_extended"]:getSharedObject()

--[[CreateThread(function()
    local testi = print('test cron')
    lib.cron.new('2 * * * *', testi, true)
end)]]

RegisterNetEvent('morpawn:add')
AddEventHandler('morpawn:add', function(data)
    local buys = data
    print(json.encode(buys))
    local amount = buys[5]
    local count = math.floor(amount[1] * 1)
    local profit = math.floor(amount[1] * buys[3])
    exports.ox_inventory:AddItem(source, buys[1], count)
    exports.ox_inventory:RemoveItem('pawnsellstash', buys[1], count)
    exports.ox_inventory:RemoveItem(source, 'money', profit)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_gwa', function(account)
        if account then
            account.addMoney(profit)
        end
    end)
end)

RegisterNetEvent('morpawn:remove')
AddEventHandler('morpawn:remove', function(data)
    local sells = data
    local amount = sells[5]
    local count = math.floor(amount[1] * 1)
    local profit = math.floor(amount[1] * sells[3])
    exports.ox_inventory:RemoveItem(source, sells[1], count)
    exports.ox_inventory:AddItem('pawnstash', sells[1], count)
    exports.ox_inventory:AddItem(source, 'money', profit)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_gwa', function(account)
        if account then
            account.removeMoney(profit)
        end
    end)
end)

RegisterNetEvent('morpawn:getinventory')
AddEventHandler('morpawn:getinventory', function(bitems)
    local items = bitems
    local stashinv = exports.ox_inventory:Search('pawnsellstash', 'count', {items[1].name, items[2].name, items[3].name, items[4].name})
    local count1,count2,count3,count4 = 0,0,0,0
    local base = {}
    if stashinv then
		for name, count in pairs(stashinv) do
			if name == items[1].name then
				count1 = count
			end
			if name == items[2].name then
				count2 = count
			end
			if name == items[3].name then
				count3 = count
			end
			if name == items[4].name then
				count4 = count
			end
		end
	end
    base =  {{items[1].name, items[1].label, items[1].sprice, count1},{items[2].name, items[2].label, items[2].sprice, count2},
                    {items[3].name, items[3].label, items[3].sprice, count3},{items[4].name, items[4].label, items[4].sprice, count4}}
    TriggerClientEvent('morpawn:verkaufmenu', source, base)
end)

