local RSGCore = exports['rsg-core']:GetCoreObject()

-----------------------
-- eat
-----------------------
for k, _ in pairs(Config.Consumables.Eat) do
    RSGCore.Functions.CreateUseableItem(k, function(source, item)
        TriggerClientEvent('rsg-consume:client:eat', source, item.name)
    end)
end

-----------------------
-- drink
-----------------------
for k, _ in pairs(Config.Consumables.Drink) do
    RSGCore.Functions.CreateUseableItem(k, function(source, item)
        TriggerClientEvent('rsg-consume:client:drink', source, item.name)
    end)
end

-----------------------
-- hot drinks
-----------------------
for k, _ in pairs(Config.Consumables.Hotdrinks) do
    RSGCore.Functions.CreateUseableItem(k, function(source, item)
        TriggerClientEvent('rsg-consume:client:drinkcoffee', source, item.name)
    end)
end

-----------------------
-- stew
-----------------------
for k, _ in pairs(Config.Consumables.Stew) do
    RSGCore.Functions.CreateUseableItem(k, function(source, item)
        TriggerClientEvent('rsg-consume:client:stew', source, item.name)
    end)
end

-----------------------
-- update hunger
-----------------------
RegisterNetEvent('rsg-consume:server:addHunger', function(amount)
    local Player = RSGCore.Functions.GetPlayer(source)
    if not Player then return end
    if amount > 100 then
        amount = 100
    end
    Player.Functions.SetMetaData('hunger', amount)
    TriggerClientEvent('hud:client:UpdateHunger', source, amount)
end)

-----------------------
-- update thirst
-----------------------
RegisterNetEvent('rsg-consume:server:addThirst', function(amount)
    local Player = RSGCore.Functions.GetPlayer(source)
    if not Player then return end
    if amount > 100 then
        amount = 100
    end
    Player.Functions.SetMetaData('thirst', amount)
    TriggerClientEvent('hud:client:UpdateThirst', source, amount)
end)

---------------------------------------------
-- remove item
---------------------------------------------
RegisterServerEvent('rsg-consume:server:removeitem', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.RemoveItem(item, amount)
    TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[item], 'remove', amount)
end)
