
local function Notify(msg, type)
    if GetResourceState('ggwpx_ui') == 'started' then
        exports['ggwpx_ui']:Notify('ITEM PACK', msg, type or 'info', 5000)
    else
        exports.qbx_core:Notify(msg, type)
    end
end

RegisterNetEvent('ggwpx_itempack:client:openPackage', function(itemName)
    local packageData = Config.Packages[itemName]
    if not packageData then return end

    Notify('Opening ' .. packageData.label .. '...', 'info')

    if lib.progressBar({
        duration = packageData.progressTime,
        label = 'Opening ' .. packageData.label,
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            move = false,
            combat = true,
            mouse = false
        },
        anim = {
            dict = packageData.animDict,
            clip = packageData.anim,
            flag = packageData.flags
        },
    }) then
        TriggerServerEvent('ggwpx_itempack:server:rewardItems', itemName)
    else
        Notify('Cancelled opening package.', 'error')
    end
end)
