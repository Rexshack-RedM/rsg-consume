-- =========================================================================================
-- Server-side usable item registration & consumption
-- =========================================================================================
local config = require 'shared.config'
local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

-- Must be at least as long as the longest client consume animation (5000 ms + margin)
local USE_COOLDOWN = 6000

---@type table<number, number> src -> GetGameTimer() at which the player may consume again
local busyUntil = {}

---Registers every item in a category as usable. The item is removed server-side
---BEFORE the client plays the animation, so the client never decides whether it is consumed.
---@param category string Consumable category key in config.Consumables
local function registerConsumables(category)
    local items = config.Consumables[category]
    if not items then return end

    for itemName in pairs(items) do
        if not RSGCore.Shared.Items[itemName] then
            print(('^3[rsg-consume] Item "%s" (%s) is not in rsg-core shared items, skipping^7'):format(itemName, category))
        else
            RSGCore.Functions.CreateUseableItem(itemName, function(source, item)
                local src = source
                local Player = RSGCore.Functions.GetPlayer(src)
                if not Player then return end

                local now = GetGameTimer()
                if (busyUntil[src] or 0) > now then
                    TriggerClientEvent('ox_lib:notify', src, {
                        title = locale('title_consume'),
                        description = locale('busy'),
                        type = 'error',
                        duration = 3000,
                    })
                    return
                end

                if not Player.Functions.RemoveItem(itemName, 1, item and item.slot, 'rsg-consume') then return end

                busyUntil[src] = now + USE_COOLDOWN
                TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[itemName], 'remove', 1)
                TriggerClientEvent('rsg-consume:client:consume', src, itemName, category)
            end)
        end
    end
end

for category in pairs(config.Consumables) do
    registerConsumables(category)
end

-- Event triggered from the client after the consumption animation successfully completes
RegisterNetEvent('rsg-consume:server:giveReturnItem', function(category, itemName)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end

    local itemConfig = config.Consumables[category] and config.Consumables[category][itemName]
    if itemConfig and itemConfig.giveItem then
        if RSGCore.Shared.Items[itemConfig.giveItem] then
            Player.Functions.AddItem(itemConfig.giveItem, 1, false, { ['item_info'] = 'returned-from-consumption' })
            TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[itemConfig.giveItem], 'add', 1)
        end
    end
end)

AddEventHandler('playerDropped', function()
    busyUntil[source] = nil
end)