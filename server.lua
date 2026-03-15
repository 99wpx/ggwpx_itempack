
local function Notify(source, msg, type)
    if GetResourceState('ggwpx_ui') == 'started' then
        TriggerClientEvent('ggwpx_ui:client:Notify', source, 'ITEM PACK', msg, type or 'info', 5000)
    else
        exports.qbx_core:Notify(source, msg, type)
    end
end

CreateThread(function()
    for itemName, _ in pairs(Config.Packages) do
        exports.qbx_core:CreateUseableItem(itemName, function(source, item)
            TriggerClientEvent('ggwpx_itempack:client:openPackage', source, itemName)
        end)
    end
end)

RegisterNetEvent('ggwpx_itempack:server:rewardItems', function(itemName)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    if not player then return end

    local packageData = Config.Packages[itemName]
    if not packageData then return end

    local hasItem = exports.ox_inventory:Search(src, 'count', itemName)
    if hasItem and hasItem > 0 then
        exports.ox_inventory:RemoveItem(src, itemName, 1)

        local receivedItems = {}
        
        for _, item in ipairs(packageData.items) do
            if exports.ox_inventory:CanCarryItem(src, item.name, item.amount) then
                exports.ox_inventory:AddItem(src, item.name, item.amount)
                
                local itemInfo = exports.ox_inventory:Items(item.name)
                local itemLabel = itemInfo and itemInfo.label or item.name
                
                table.insert(receivedItems, item.amount .. 'x ' .. itemLabel)
            else
                Notify(src, 'Not enough space to carry ' .. item.name, 'error')
            end
        end

        local itemsMsg = table.concat(receivedItems, ", ")

        Notify(src, 'Successfully received: ' .. itemsMsg, 'success')
    else
        Notify(src, 'You do not have a ' .. packageData.label .. '.', 'error')
    end
end)
