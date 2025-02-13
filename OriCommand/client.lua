RegisterNetEvent('QBCore:Notify')
AddEventHandler('QBCore:Notify', function(message, type)
    local oxType = (type == "success" and "success") or (type == "error" and "error") or "info"
    
    TriggerEvent('ox_lib:notify', {
        description = message,
        type = oxType
    })
end)
